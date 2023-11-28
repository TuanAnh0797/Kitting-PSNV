import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../Controller/GRController/GRController.dart';
import '../../Model/GR/DataTableGetNoPOPending.dart';
import '../MenuPage/MenuPageGoodsReceiveDA.dart';
import '../PageCommon/Common.dart';


class GRNoPo extends StatefulWidget {
  @override
  _GRNoPoStateState createState() => _GRNoPoStateState();
}

class _GRNoPoStateState extends State<GRNoPo> {
  int? selectedOption = 0;
  final TextEditingController _txtCodeController = TextEditingController();
  final TextEditingController _txtTotalQtyController = TextEditingController();
  final FocusNode _txtCodeFocusNode = FocusNode();
  final FocusNode _txtTotalQtyFocusNode = FocusNode();
  String? userId;
  String enteredText = '';
  String lblUrgentValue = "";
  String lblSloc = "";
  String lblcoutbox = "0";
  int? _DATotalIDfix;
  String _checkobjEDI = '';
  String lblquantityplan = "0";
  String _DeliveryDate = '';
  int? _totalBox = 0;


  List<DataTableGetNoPOPending> data = List.empty();
  int ktobo = 0;
  bool isDisabled = false;
  bool isDisabledUrgent = false;
  bool isDisabledtxtTotalQty = false;

  bool flagcolorur = false;
  String labelcheckbox = "";

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget continueButton = TextButton(
      child: Text("YES"),
      onPressed: () {
        //Navigator.of(context).pop();
        //xu ly su kien o day
        ktobo = 1;
        //resettxtTotalQty(QtyBox.toString());
        isDisabled = true;
        Navigator.of(context, rootNavigator: true)
            .pop(true); // dismisses only the dialog and returns true
      },
    );
    Widget cancelButton = TextButton(
      child: Text("NO"),
      onPressed: () {
        //xu ly du lieu o day
        //Navigator.of(context).pop();
        //QtyBox = 0;
        isDisabled = false;
        _txtTotalQtyController.value = TextEditingValue(text: "");
        resettxtCode("");
        Navigator.of(context, rootNavigator: true)
            .pop(false); // dismisses only the dialog and returns false
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Thông báo"),
      content: Text("Mã này đã tồn tại. Bạn có muốn cập nhật số lượng?"),
      actions: [
        continueButton,
        cancelButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void handleOptionChange(int? value) {
    setState(() {
      selectedOption = value;
      isDisabled = false;
    });
    resettxtCode("");
  }

  bool checkStringLength(String input) {
    return input.split(';').length == 12;
  }

  String computeSum(List<DataTableGetNoPOPending> data) {
    double sum = 0;
    for (var item in data) {
      sum += item.quantitybox ?? 0;
    }
    return sum.toString();
  }

  void GRAllAuto(String Barcode,int? _DATotalID,double? QtyBox,double? _quantityDetail,double? _quantityBox) async {
    final List<Map<String, dynamic>> result =
    await callProcPOPendingOverAutoAPI(
        Barcode.split(';')[4].toString(),
        Barcode.split(';')[5].toString(),
        Barcode.split(';')[6].toString(),
        Barcode.split(';')[7].toString(),
        _DATotalID.toString());
    if (result.isNotEmpty) {
      var firstRowValues = result[0].values.toList();
      if (firstRowValues[0].toString() == "1") {
        String sl_PO = firstRowValues[1].toString();
        String qty_act = firstRowValues[2].toString();
        showError(
            context,
            "Qty vuot qua Qty PO!\n Qty PO la: " +
                sl_PO +
                "\n Qty da nhan: " +
                qty_act,
            "Thông báo");
        setState(() {
          _txtTotalQtyController.value = TextEditingValue(text: "0");
          QtyBox = 0;
        });
        resettxtCode("");
      } else if (firstRowValues[0].toString() == "2") {
        String ckDAQty = firstRowValues[1].toString();
        showError(context, "Qty vuot qua Qty DA\n Qty DA la: " + ckDAQty,
            "Thông báo");
        setState(() {
          _txtTotalQtyController.value = TextEditingValue(text: "0");
          QtyBox = 0;
        });
        resettxtCode("");
      } else if (firstRowValues[0].toString() == "3") {
        showError(context, "Chua co Qty PO, Kiem tra lai!", "Thông báo");
      } else {
        try {
          bool result = await callDADetailAutoGRNoPOPendingAPI(
              datotalID: _DATotalID.toString(),
              daNo: Barcode.split(';')[1].toString(),
              gCode: Barcode.split(';')[0].toString(),
              barcode: Barcode.toString(),
              quantityDetail: _quantityDetail.toString(),
              quantityBox: _quantityBox.toString(),
              status: "0",
              createUser: userId!,
              invoiceNo: Barcode.split(';')[10].toString(),
              poNo: Barcode.split(';')[4].toString(),
              poItem: Barcode.split(';')[5].toString(),
              indexBox: Barcode.split(';')[11].toString(),
              totalBox: Barcode.split(';')[9].toString());
          if (result == true) {
            showError(context, "GR Auto Success", "Thông báo");
            setState(() {
              selectedOption == 0;
              Reset();
              data = [];
              buildDataTable();
              lblcoutbox = "";
            });
          } else {
            showError(context, "GR Auto Error", "Error");
          }

          // Do something with the result
        } catch (e) {
          // Handle any errors that occurred during the API call
          print('Error: $e');
          // Handle the error
        }
      }
    }
  }

  void GRAll_Finish(String Barcode,int? _DATotalID) async {

    // Show loading dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: CircularProgressIndicator(),
        );
      },
      barrierDismissible: false, // Prevent user from dismissing the dialog
    );

    print("function GR Finish");
    int sttCheckOver = await procPOPending_Over(
        Barcode.split(';')[4].toString(),
        Barcode.split(';')[5].toString(),
        Barcode.split(';')[6].toString());
    if (sttCheckOver == 1) {
      showError(context, "Hàng về vượt quá Qty PO", "Thông báo");
    }

    bool result = await Update_GR_EDI_Enough_NEWPO(
        _DATotalID.toString(), userId!, "0", sttCheckOver.toString());
    print(
        "function GR Finish \n _DATotalID ${_DATotalID.toString()} - userid ${userId!} - sstCheckover ${sttCheckOver.toString()} - kq ${result}");

    // Close loading dialog
    Navigator.of(context).pop();

    if (result == true) {
      showError(context, "GR thành công", "Thông báo");
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        data = [];
        setState(() {
          buildDataTable();
          lblcoutbox = "";
        });
        Reset();
      });
    }
    else {
      //showError(context, "Có lỗi!!", "Thông báo");
      resettxtCode("");
    }
  }

  void Reset() {
    resettxtCode("");
    setState(() {
      _txtTotalQtyController.value = TextEditingValue(text: "0");
      lblSloc = "";
      lblquantityplan = "0";
      //QtyBox = 0;
      lblcoutbox = "0";
      labelcheckbox = "";
    });
  }

  void SaveData(double qtyUpdate, int type, String Barcode ,int? _DATotalID,double? _quantityDetail,double? _Quantity_plant,double? QtyBox) async {
    bool kq;

    print("Barcode Save data ${Barcode}");
    print(QtyBox);
    if (QtyBox == 0) {
      // print("check data");
      print(_DATotalID.toString());
      print(Barcode.toString().toUpperCase());
      print(_quantityDetail.toString());
      print(qtyUpdate.toString());
      // print("0");
      // print("2014717");
      // print(Barcode.split(';')[10].toString());
      // print(Barcode.split(';')[4].toString());
      // print(Barcode.split(';')[5].toString());
      kq = await DADetail_add_NoPOPending(

          _DATotalID.toString(),
          Barcode.toString().toUpperCase(),
          _quantityDetail.toString(),
          qtyUpdate.toString(),
          "0",
          userId!,
          Barcode.split(';')[10].toString(),
          Barcode.split(';')[4].toString(),
          Barcode.split(';')[5].toString());
      print("vaoday4");
    } else {
      //print("vaoday4");
      kq = await DADetail_update_NoPOPending(
          _DATotalID.toString(),
          Barcode.toString().toUpperCase(),
          qtyUpdate.toString(),
          (QtyBox! - qtyUpdate).toString(),
          Barcode.split(';')[4].toString(),
          Barcode.split(';')[5].toString(),
          userId!);
    }
    print(kq);
    if (kq == true) {
      print("vaoday5");
      if (type == 1) {
        showError(context, "OK", "Thông báo");
      }
      // if (qtyUpdate + _ActualTotalQuantity! - QtyBox! >= _Quantity_plant!) {
      //   print("vaoday6");
      //   setState(() {
      //     lblcoutbox = Barcode.split(';')[9].toString() +
      //         "/" +
      //         Barcode.split(';')[9].toString();
      //     lblquantityplan = (qtyUpdate + _ActualTotalQuantity!).toString() +
      //         "/" +
      //         _Quantity_plant.toString();
      //   });
      //   print("Vao GRALL Finish");
      //   GRAll_Finish(Barcode);
      //   return;
      // }
      data = await DADetail_GetNoPOPending(_DATotalID.toString(),
          Barcode.split(';')[4].toString(), Barcode.split(';')[5].toString());
      setState(() {
        buildDataTable();
        //lblcoutbox = "0/" + Barcode.split(';')[9].toString();
      });
      double ActQty = 0;
      if (data.length > 0) {
        String result = computeSum(data);
        ActQty = double.parse(result);
      }
      if (ActQty >= _Quantity_plant!) {
        print("vaoday6");
        // setState(() {
        //   lblcoutbox = Barcode.split(';')[9].toString() +
        //       "/" +
        //       Barcode.split(';')[9].toString();
        //   lblquantityplan = (qtyUpdate + _ActualTotalQuantity!).toString() +
        //       "/" +
        //       _Quantity_plant.toString();
        // });
        print("Vao GRALL Finish");
        GRAll_Finish(Barcode,_DATotalID);
        return;
      }
      setState(() {
        lblcoutbox =
            data.length.toString() + "/" + Barcode.split(';')[9].toString();
        lblquantityplan = ActQty.toString() + "/" + _Quantity_plant.toString();
      });
      resettxtCode("");
      setState(() {
        _txtTotalQtyController.value = TextEditingValue(text: "0");
        QtyBox = 0;
      });
    } else {
      showError(context, "NG!!", "Error");
    }
  }

  void txtTotalQtyhandleKeyPress(String value) async {
    bool isLengthValid = checkStringLength(_txtCodeController.text);
    if (isLengthValid) {
      String barcode = _txtCodeController.text;
      String  result = await GR_EDI_NoPOPending(
          barcode.split(';')[1].toString(),
          barcode.split(';')[2].toString(),
          barcode.split(';')[4].toString(),
          barcode.split(';')[5].toString(),
          barcode.toString());

      List<String> arrListCheckGR = [];
      List<String> sCat1 = result.toUpperCase().split(';');
      arrListCheckGR.addAll(sCat1);

      double? _quantityBox = double.parse(value);
      double? _Quantity_plant = double.parse(arrListCheckGR[2].toString());
      double? _ActualTotalQuantity = double.parse(arrListCheckGR[4].toString());
      double ktsl = 0;
      String soluong_scan = _quantityBox.toString();
      String vendor_code = arrListCheckGR[10].toString();

      if (ktobo == 1) {
        double QuantityBox_old = double.parse(barcode[8].toString());
        ktsl = (_quantityBox! + _ActualTotalQuantity! - QuantityBox_old);
      } else {
        ktsl = (_quantityBox! + _ActualTotalQuantity!);
      }
      final List<Map<String, dynamic>> dtcheckQtyPO = await checkQtyPO(
          barcode.split(';')[4].toString(),
          soluong_scan,
          barcode.split(';')[5].toString(),
          barcode,
          "0");
      if (_txtTotalQtyController.text.trim() == "") {
        return;
      }
      double qtyUpdate = 0;
      qtyUpdate = double.parse(_txtTotalQtyController.text);
      if (qtyUpdate <= 0) {
        showError(context, "Số lượng không nhỏ hơn 0", "Cảnh báo");
        resettxtTotalQty(_txtTotalQtyController.text);
      }

      if (dtcheckQtyPO.isNotEmpty) {
        var firstRowValues = dtcheckQtyPO[0].values.toList();
        if (firstRowValues[0].toString() == "1") {
          if (ktsl > _Quantity_plant!) {
            showError(
                context, "So luong scan vuot qua so luong DA!", "Thông báo");
            resettxtCode("");
            setState(() {
              _txtTotalQtyController.value = TextEditingValue(text: "0");
              //QtyBox = 0;
            });
          } else {
            print("vaoday2");
            print(double.parse(_txtTotalQtyController.text));
            print(barcode);
            SaveData(double.parse(_txtTotalQtyController.text), 0, barcode,int.parse(arrListCheckGR[1]),double.parse(barcode.split(';')[7].toString()),_Quantity_plant,double.parse(arrListCheckGR[5]));
          }
        } else if (firstRowValues[0].toString() == "2") {
          showError(context, "Chua co Qty PO, Kiem tra lai!", "Thông báo");
          resettxtCode("");
        } else {
          String sl_PO = firstRowValues[2].toString();
          String qty_act = firstRowValues[1].toString();
          showError(
              context,
              "Qty vuot qua Qty PO!\n Qty PO la: " +
                  sl_PO +
                  "\n Qty da nhan: " +
                  qty_act,
              "Thông báo");
          setState(() {
            _txtTotalQtyController.value = TextEditingValue(text: "0");
            //QtyBox = 0;
          });
          resettxtCode("");
        }
      } else {
        showError(context, "Chua co POpending!", "Thông báo");
        resettxtCode("");
      }
    } else {
      showError(context, "Barcode GR không hợp lệ", "Error");
      resettxtCode("");
    }
  }

  int i = 0;
  List<String> listbarcode = List.empty();

  void txtCodehandleKeyPress(String value) async {
    print("${i++} : ${value}" );
    bool isLengthValid = checkStringLength(value);
    if (isLengthValid) {
      if(selectedOption==0){
        handletest(value);
        resettxtCode("");
        //return;
      }else{
        handletest(value);
      }
    } else {
      showError(context, "Barcode không hợp lệ", "Error");
      resettxtCode("");
    }
  }

  void handletest(String value) async{

    if (double.parse(value.split(';')[7].toString()) <
        double.parse(value.split(';')[8].toString())) {}

    String result = await GR_EDI_NoPOPending(
        value.split(';')[1].toString(),
        value.split(';')[2].toString(),
        value.split(';')[4].toString(),
        value.split(';')[5].toString(),
        value.toString());
    print(result);
    if (result == '"1"') {
      print(result);
      showError(context, "Không tồn tại DA", "Thông báo");
      resettxtCode("");
      return;
    } else if (result == '"3"') {
      print("OK");
      showError(context, "Barcode đã được GR", "Thông báo");
      resettxtCode("");
      return;
    } else {
      print("vao day1");

      List<String> arrListCheckGR = [];
      List<String> sCat1 = result.toUpperCase().split(';');
      print("result ${result}");
      arrListCheckGR.addAll(sCat1);
      List<String> arrCheckGR = arrListCheckGR.toList();

      //_totalBox = int.parse(value.split(';')[9].toString());
      //_DeliveryDate = value.split(';')[3].toString();
      double?  _quantityDetail = double.parse(value.split(';')[7].toString());
      double? _quantityBox = double.parse(value.split(';')[8].toString());
      print("vao day ${arrListCheckGR[1].toString()}");
      int? _DATotalID = int.parse(arrListCheckGR[1]);
      _DATotalIDfix = int.parse(arrListCheckGR[1]);
      double? _Quantity_plant = double.parse(arrListCheckGR[2]);
      double? _ActualTotalQuantity = double.parse(arrListCheckGR[4]);

      // lblInvQty.text = "";
      setState(() {
        // Update the value for lblUrgentWidget
        //lblUrgentValue = 'URGENT';
        lblSloc = arrListCheckGR[9];
        _txtTotalQtyController.value =
            TextEditingValue(text: _quantityBox.toString());
      });

      double ktsl = _quantityBox! + _ActualTotalQuantity!;
      String soluongScan = _quantityBox.toString();
      String venderCode = arrListCheckGR[10];
      String barcode = value.toString().trim();

      if (arrListCheckGR[7].toString() == "----" &&
          arrListCheckGR[8].toString() == "----" ||
          arrListCheckGR[7].toString() == "----" &&
              arrListCheckGR[8].toString() == "M" ||
          arrListCheckGR[7].toString() == "----" &&
              arrListCheckGR[8].toString() == "S") {
        labelcheckbox = "V";
      } else if (arrListCheckGR[7].toString() == "" &&
          arrListCheckGR[8].toString() == "") {
        labelcheckbox = "V";
      } else {
        labelcheckbox = "X";
      }

      print("vao day2");
      int numberAsString = await CheckUrgent(barcode.split(';')[6].toString());


      //print("Check UR ${numberAsString.toString()}");
      if (numberAsString == 0) {
        setState(() {
          lblUrgentValue = 'URGENT';
          isDisabledUrgent = false;
          flagcolorur = true;
        });
      } else {
        setState(() {
          lblUrgentValue = '';
          isDisabledUrgent = true;
          flagcolorur = false;
        });
      }

      print('_DATotalID: ${_DATotalID}');
      print('_PONO: ${barcode.split(';')[4]}');
      print('_POItem: ${barcode.split(';')[5]}');

      data = await DADetail_GetNoPOPending(
          _DATotalID.toString(), barcode.split(';')[4], barcode.split(';')[5]);
      double ActQty = 0;
      print(data.length);
      if (data.length > 0) {
        String result = computeSum(data);
        ActQty = double.parse(result);
      }
      final List<Map<String, dynamic>> dtcheckQtyPO = await checkQtyPO(
          barcode.split(';')[4].toString(),
          soluongScan,
          barcode.split(';')[5].toString(),
          barcode,
          "0");

      setState(() {
        buildDataTable();
        //lblcoutbox = "0/" + value.split(';')[9].toString();
        lblquantityplan = ActQty.toString() + "/" + _Quantity_plant.toString();
      });
      print("xxx");
      double? QtyBox = 0;
      print(result.substring(0, 1));
      if (result.substring(1, 2) == "2") {
        setState(() {
          selectedOption = 1;
          _txtCodeController.value =
              TextEditingValue(text: barcode.toString());
          QtyBox = double.parse(arrListCheckGR[5]);
        });
        showAlertDialog(context);
        return;
      } else {
        setState(() {
          _txtTotalQtyController.value =
              TextEditingValue(text: _quantityBox.toString());
        });
      }
      if (selectedOption == 1) {
        isDisabled = true;
        isDisabledtxtTotalQty = false;
        resettxtTotalQty("");
      } else if (selectedOption == 0) {
        if (dtcheckQtyPO.isNotEmpty) {
          var firstRowValues = dtcheckQtyPO[0].values.toList();
          if (firstRowValues[0].toString() == "1") {
            if (ktsl > _Quantity_plant!) {
              showError(
                  context, "So luong scan vuot qua so luong DA!", "Thông báo");
              resettxtCode("");
              setState(() {
                _txtTotalQtyController.value = TextEditingValue(text: "0");
                QtyBox = 0;
              });
            } else {
              print("vaoday3");
              print(double.parse(_txtTotalQtyController.text));
              print(barcode);
              SaveData(double.parse(_txtTotalQtyController.text), 0, barcode,_DATotalID,_quantityDetail,_Quantity_plant,QtyBox);
            }
          } else if (firstRowValues[0].toString() == "2") {
            showError(context, "Chua co Qty PO, Kiem tra lai!", "Thông báo");
            resettxtCode("");
          } else {
            String sl_PO = firstRowValues[2].toString();
            String qty_act = firstRowValues[1].toString();
            showError(
                context,
                "Qty vuot qua Qty PO!\n Qty PO la: " +
                    sl_PO +
                    "\n Qty da nhan: " +
                    qty_act,
                "Thông báo");
            setState(() {
              _txtTotalQtyController.value = TextEditingValue(text: "0");
              QtyBox = 0;
            });
            resettxtCode("");
          }
        } else {
          showError(context, "Chua co POpending!", "Thông báo");
          resettxtCode("");
        }
      } else if (selectedOption == 2) {
        GRAllAuto(barcode,_DATotalID,QtyBox,_quantityDetail,_quantityBox);
      }
    }
  }

  void resettxtCode(String text) {
    setState(() {
      _txtCodeController.value = TextEditingValue(text: text.toString());
      FocusScope.of(context).requestFocus(_txtCodeFocusNode);
    });
  }

  void resettxtTotalQty(String text) {
    setState(() {
      _txtTotalQtyController.value = TextEditingValue(text: text.toString());
      FocusScope.of(context).requestFocus(_txtTotalQtyFocusNode);
    });
  }

  Widget buildDataTable() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: DataTable(
          columns: [
            DataColumn(label: Text('UnitNo')),
            DataColumn(label: Text('Material')),
            DataColumn(label: Text('QuantityBox')),
            DataColumn(label: Text('Sloc')),
            DataColumn(label: Text('InvoiceNo')),
            DataColumn(label: Text('CtrlKey')),
            DataColumn(label: Text('T')),
          ],
          rows: data.map((item) {
            return DataRow(
              cells: [
                DataCell(Text(item.unitno)),
                DataCell(Text(item.material)),
                DataCell(Text(item.quantitybox.toString())),
                DataCell(Text(item.sloc)),
                DataCell(Text(item.invoiceno)),
                DataCell(Text(item.ctrkey)),
                DataCell(Text(item.t)),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _txtCodeController.dispose();
    super.dispose();
  }

  @override
  void autogetuser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getString('username')!;
    });
  }

  @override
  void initState() {
    super.initState();
    _txtCodeFocusNode.requestFocus(); // Set focus on _txtCodeController
    autogetuser();
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 10),
            () => SystemChannels.textInput.invokeMethod('TextInput.hide'));
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 25),
                height: 50,
                width: MediaQuery.of(context).size.width - 20,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                          color: Color(0xFFd8dbe0),
                          offset: Offset(1, 1),
                          blurRadius: 20.0,
                          spreadRadius: 10)
                    ]),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: [
                          Text(
                            'Welcome: $userId',
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 16),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            handleOptionChange(0);
                          },
                          child: Row(
                            children: [
                              Radio(
                                value: 0,
                                groupValue: selectedOption,
                                onChanged: handleOptionChange,
                              ),
                              Text('Normal', style: TextStyle(fontSize: 15)),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            handleOptionChange(1);
                          },
                          child: Row(
                            children: [
                              Radio(
                                value: 1,
                                groupValue: selectedOption,
                                onChanged: handleOptionChange,
                              ),
                              Text('One by One',
                                  style: TextStyle(fontSize: 15)),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            handleOptionChange(2);
                          },
                          child: Row(
                            children: [
                              Radio(
                                value: 2,
                                groupValue: selectedOption,
                                onChanged: handleOptionChange,
                              ),
                              Text('Auto', style: TextStyle(fontSize: 15)),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.0),
                    Row(
                      children: [
                        Text('Code: ', style: TextStyle(fontSize: 20)),
                        SizedBox(width: 10.0),
                        Expanded(
                          child: Row(
                            children: [
                              lblSlocWidget(
                                valuetext: lblSloc,
                              ),
                              SizedBox(width: 10.0),
                              Expanded(
                                child: TextField(
                                  enabled: !isDisabled,
                                  controller: _txtCodeController,
                                  focusNode: _txtCodeFocusNode,
                                  onSubmitted: txtCodehandleKeyPress,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.0),
                    Row(
                      children: [
                        Text('Box Qty: ', style: TextStyle(fontSize: 20)),
                        SizedBox(width: 10.0),
                        Expanded(
                          child: Row(
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                color: Colors.blue,
                                child: lblcheckbox(
                                  value: labelcheckbox,
                                ),
                              ),
                              SizedBox(width: 10.0),
                              Expanded(
                                child: lblUrgentWidget(
                                  value: lblUrgentValue,
                                  visible: true,
                                  flagcolor: flagcolorur,
                                ),
                              ),
                              SizedBox(width: 10.0),
                              Expanded(
                                  child: TextField(
                                    keyboardType: TextInputType.number,
                                    enabled: !isDisabledtxtTotalQty,
                                    controller: _txtTotalQtyController,
                                    focusNode: _txtTotalQtyFocusNode,
                                    onSubmitted: txtTotalQtyhandleKeyPress,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                    ),
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.0),
                    Row(
                      children: [
                        Text('Qty/plan: ', style: TextStyle(fontSize: 20)),
                        SizedBox(width: 10.0),
                        lblQuantityPlan(
                          value: lblquantityplan,
                        ),
                      ],
                    ),
                    SizedBox(height: 10.0),
                    Container(
                      height: MediaQuery.of(context).size.height *
                          0.3, // Set the desired height
                      child: buildDataTable(),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            // Add your button logic here
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MenuPageGoodsReceive()),
                                  (Route<dynamic> route) => false,
                            );
                          },
                          child: Text('Home'),
                        ),
                        SizedBox(width: 10),
                        // Add some spacing between the button and label
                        lblCountboxWidget(
                          valuetext: lblcoutbox,
                        ),
                        SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: () {
                            print("keypress");
                            print(data.length);
                            // Add your button logic here
                            if (data.length <= 0) {
                              print(data.length);
                              return;
                            } else {
                              showAlertDialogFinish(context);
                            }
                          },
                          child: Text('Finish'),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  showAlertDialogFinish(BuildContext context) {
    // set up the buttons
    Widget continueButton = TextButton(
      child: Text("YES"),
      onPressed: () {
        //Navigator.of(context).pop();
        //xu ly su kien o day
        //print("_DATotalID.toString() ${_DATotalID.toString()}");
        // print("userId ${userId!}");
        if (Update_GR_EDI_Enough(
            _DATotalIDfix.toString(),
            userId!,
            "0") ==
            true) {
          showError(context, "GR thành công",
              "Thông báo");
          data = [];
          setState(() {
            buildDataTable();
            lblcoutbox = "";
          });
          Reset();
        } else {
          showError(
              context, "GR thất bại", "Error");
        }

        Navigator.of(context, rootNavigator: true).pop(
            true); // dismisses only the dialog and returns true
      },
    );
    Widget cancelButton = TextButton(
      child: Text("NO"),
      onPressed: () {
        //xu ly du lieu o day
        //Navigator.of(context).pop();
        Navigator.of(context, rootNavigator: true).pop(
            false); // dismisses only the dialog and returns false
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Thông báo"),
      content: Text("Bạn có muốn kết thúc GR?"),
      actions: [
        continueButton,
        cancelButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

class lblcheckbox extends StatelessWidget {
  final String value;

  const lblcheckbox({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(
          value,
          style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
        ));
  }
}

class lblQuantityPlan extends StatelessWidget {
  final String value;

  const lblQuantityPlan({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: MediaQuery.of(context).size.width,
      // height: MediaQuery.of(context).size.height,
      padding: EdgeInsets.all(10.0),
      child: Text(
        value,
        style: TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class lblUrgentWidget extends StatelessWidget {
  final String value;
  final bool visible;
  final bool flagcolor;

  const lblUrgentWidget(
      {Key? key,
        required this.value,
        this.visible = true,
        required this.flagcolor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Container(
          // height: MediaQuery.of(context).size.height * 0.05,
          color: flagcolor ? Colors.red : Colors.white,
          padding: EdgeInsets.all(10.0),
          child: Text(
            value,
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

class lblSlocWidget extends StatelessWidget {
  final String valuetext;

  const lblSlocWidget({super.key, required this.valuetext});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.2,
      padding: EdgeInsets.all(10.0),
      child: Text(
        valuetext,
        style: TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class lblCountboxWidget extends StatelessWidget {
  final String valuetext;

  const lblCountboxWidget({super.key, required this.valuetext});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.5,
      // height: MediaQuery.of(context).size.height * 0.05,
      padding: EdgeInsets.all(10.0),
      child: Text(
        valuetext,
        style: TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
        textAlign: TextAlign.center,
      ),
    );
  }
}
