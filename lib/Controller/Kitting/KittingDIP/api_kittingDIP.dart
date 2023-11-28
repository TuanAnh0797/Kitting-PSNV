import 'dart:convert';
import 'package:http/http.dart' as http;

class Class_KittingDIP {
  Future<String> Check_Partcard_kittingTrans(String BarcodePartcard) async{
    final http.Response response = await http.get(
      Uri.parse('http://10.92.184.24:8011/checkkittingdip?BarcodePartcard=$BarcodePartcard'),
      headers:{
        'Accept': 'application/json; charset=UTF-8',
      },
    );
    String kq='';
    print(response.body);
    final data = json.decode(response.body);
    //print(data[0]["username"]);
    if (response.statusCode == 200) {
      if(response.body != '""')
      {
        kq =  response.body.replaceAll('"', '');
        print(kq);
        return kq;
      }
      else
      {
        return kq;
      }

    }
    else
    {
      //return kq;
      throw Exception('Failed API: checkkittingdip');
    }
  }

  Future<String> Check_Partcard_kittingTrans_post(String BarcodePartcard) async{
    /*final http.Response response = await http.get(
      Uri.parse('http://10.92.184.24:8011/checkkittingdip?BarcodePartcard=$BarcodePartcard'),
      headers:{
        'Accept': 'application/json; charset=UTF-8',
      },
    );*/
    final String apiUrl = 'http://10.92.184.24:8011/checkkittingdip_post';
    Map<String, String> requestData = {
      'BarcodePartcard': BarcodePartcard,
    };
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(requestData),
    );
    String kq='';
    print(response.body);
    final data = json.decode(response.body);
    //print(data[0]["username"]);
    if (response.statusCode == 200) {
      if(response.body != '""')
      {
        kq =  response.body.replaceAll('"', '');
        print(kq);
        return kq;
      }
      else
      {
        return kq;
      }

    }
    else
    {
      //return kq;
      throw Exception('Failed API: checkkittingdip_post');
    }
  }

  Future<String> procDataKittingDIP_getByPartCard_new(String ProductDate,String Plant,String Material,String Model,String Line,String Time,String Sloc,String UploadNo) async{
    final http.Response response = await http.get(
      Uri.parse('http://10.92.184.24:8011/checkkittingdipstep2?ProductDate=$ProductDate&Plant=$Plant&Material=$Material&Model=$Model&Line=$Line&Time=$Time&Sloc=$Sloc&UploadNo=$UploadNo'),
      headers:{
        'Accept': 'application/json; charset=UTF-8',
      },
    );
    String kq='';
    print(response.body);
    final data = json.decode(response.body);
    //print(data[0]["username"]);
    if (response.statusCode == 200) {
      if(response.body != '""')
      {
        kq =  response.body.replaceAll('"', '');
        print(kq);
        return kq;
      }
      else
      {
        return kq;
      }

    }
    else
    {
      //return kq;
      throw Exception('Failed API: checkkittingdipstep2');
    }
  }

  Future<String> procDataKittingDIP_getByPartCard_new_post(String ProductDate,String Plant,String Material,String Model,String Line,String Time,String Sloc,String UploadNo) async{
    /*final http.Response response = await http.get(
      Uri.parse('http://10.92.184.24:8011/checkkittingdipstep2?ProductDate=$ProductDate&Plant=$Plant&Material=$Material&Model=$Model&Line=$Line&Time=$Time&Sloc=$Sloc&UploadNo=$UploadNo'),
      headers:{
        'Accept': 'application/json; charset=UTF-8',
      },
    );*/
    final String apiUrl = 'http://10.92.184.24:8011/checkkittingdipstep2_post';
    Map<String, String> requestData = {
      'ProductDate': ProductDate,
      'Plant': Plant,
      'Material': Material,
      'Model': Model,
      'Line': Line,
      'Time': Time,
      'Sloc': Sloc,
      'UploadNo': UploadNo,
    };
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(requestData),
    );
    String kq='';
    print(response.body);
    final data = json.decode(response.body);
    //print(data[0]["username"]);
    if (response.statusCode == 200) {
      if(response.body != '""')
      {
        kq =  response.body.replaceAll('"', '');
        print(kq);
        return kq;
      }
      else
      {
        return kq;
      }

    }
    else
    {
      //return kq;
      throw Exception('Failed API: checkkittingdipstep2_post');
    }
  }

  Future<String> GrTran_ConfirmBarcode(String Barcode, String Material, String SLOC) async{
    final http.Response response = await http.get(
      Uri.parse('http://10.92.184.24:8011/ckitting?Barcode=$Barcode&Material=$Material&SLOC=$SLOC'),
      headers: {
        "accept": "application/json; charset=UTF-8",
      },
    );
    String kq='';
    //print('vao toi day chua:'+response.body);
    final data = json.decode(response.body);
    //print(data[0]["username"]);
    if (response.statusCode == 200) {
      if(response.body != '"0"')
      {
        //result == "-1" ==>  result = Qty  (truong hop nay QTY > 0)
        //result.Equals("-2")   MessageBox.Show("Thung hang nay chua duoc luu \n Hoac thung hang nay da het.");
        //result.Equals("0")    MessageBox.Show("KHONG PHAI LOT MIN");
        //result.Equals("-3")   MessageBox.Show("Khong phai thung le.");
        //result.Equals("-4")   MessageBox.Show("Ma nay dang duoc Kitting. Ban co muon MO KHOA khong?
        kq =  response.body.replaceAll('"', '');
        //print(kq);
        return kq;
      }
      else
      {
        return kq;
      }

    }
    else
    {
      //return kq;
      throw Exception('Failed API: ckitting');
    }
  }

  Future<String> GrTran_ConfirmBarcode_post(String Barcode, String Material, String SLOC) async{
    /*final http.Response response = await http.get(
      Uri.parse('http://10.92.184.24:8011/ckitting?Barcode=$Barcode&Material=$Material&SLOC=$SLOC'),
      headers: {
        "accept": "application/json; charset=UTF-8",
      },
    );*/
    final String apiUrl = 'http://10.92.184.24:8011/ckitting_post';
    Map<String, String> requestData = {
      'Barcode': Barcode,
      'Material': Material,
      'SLOC': SLOC,
    };
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(requestData),
    );
    String kq='';
    //print('vao toi day chua:'+response.body);
    final data = json.decode(response.body);
    //print(data[0]["username"]);
    if (response.statusCode == 200) {
      if(response.body != '"0"')
      {
        //result == "-1" ==>  result = Qty  (truong hop nay QTY > 0)
        //result.Equals("-2")   MessageBox.Show("Thung hang nay chua duoc luu \n Hoac thung hang nay da het.");
        //result.Equals("0")    MessageBox.Show("KHONG PHAI LOT MIN");
        //result.Equals("-3")   MessageBox.Show("Khong phai thung le.");
        //result.Equals("-4")   MessageBox.Show("Ma nay dang duoc Kitting. Ban co muon MO KHOA khong?
        kq =  response.body.replaceAll('"', '');
        //print(kq);
        return kq;
      }
      else
      {
        return kq;
      }

    }
    else
    {
      //return kq;
      throw Exception('Failed API: ckitting_post');
    }
  }

  Future<bool> ulbarcodekitting(String Barcode) async{
    final http.Response response = await http.get(
      Uri.parse('http://10.92.184.24:8011/unlockkiting?Barcode=$Barcode'),
      headers:{
        'Accept': 'application/json; charset=UTF-8',
      },
    );
    print(response.body);
    final data = json.decode(response.body);
    //print(data[0]["username"]);
    if (response.statusCode == 200) {
      if(response.body == 'true')
      {
        print('unlock thanh cong');
        return true;
      }else
      {
        return false;
      }
    } else {
      //return false;
      throw Exception('Failed API: unlockkiting');
    }
  }

  Future<bool> ulbarcodekitting_post(String Barcode) async{
    /*final http.Response response = await http.get(
      Uri.parse('http://10.92.184.24:8011/unlockkiting?Barcode=$Barcode'),
      headers:{
        'Accept': 'application/json; charset=UTF-8',
      },
    );*/
    final String apiUrl = 'http://10.92.184.24:8011/unlockkiting_post';
    Map<String, String> requestData = {
      'Barcode': Barcode,
    };
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(requestData),
    );
    print(response.body);
    final data = json.decode(response.body);
    //print(data[0]["username"]);
    if (response.statusCode == 200) {
      if(response.body == 'true')
      {
        print('unlock thanh cong');
        return true;
      }else
      {
        return false;
      }
    } else {
      //return false;
      throw Exception('Failed API: unlockkiting_post');
    }
  }

  Future<bool> procGRTran_update(String Barcode, String GetQuantity) async{
    final http.Response response = await http.get(
      Uri.parse('http://10.92.184.24:8011/trantemp?Barcode=$Barcode&GetQuantity=$GetQuantity'),
      headers:{
        'Accept': 'application/json; charset=UTF-8',
      },
    );
    print(response.body);
    final data = json.decode(response.body);
    //print(data[0]["username"]);
    if (response.statusCode == 200) {
      if(response.body == 'true')
      {
        //print('kitting tran temp thanh cong');
        return true;
      }else
      {
        return false;
      }
    } else {
      //return false;
      throw Exception('Failed API: trantemp');
    }
  }

  Future<bool> procGRTran_update_post(String Barcode, String GetQuantity) async{
    /*final http.Response response = await http.get(
      Uri.parse('http://10.92.184.24:8011/trantemp?Barcode=$Barcode&GetQuantity=$GetQuantity'),
      headers:{
        'Accept': 'application/json; charset=UTF-8',
      },
    );*/
    final String apiUrl = 'http://10.92.184.24:8011/trantemp_post';
    Map<String, String> requestData = {
      'Barcode': Barcode,
      'GetQuantity': GetQuantity,
    };
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(requestData),
    );
    print(response.body);
    final data = json.decode(response.body);
    //print(data[0]["username"]);
    if (response.statusCode == 200) {
      if(response.body == 'true')
      {
        //print('kitting tran temp thanh cong');
        return true;
      }else
      {
        return false;
      }
    } else {
      //return false;
      throw Exception('Failed API: trantemp_post');
    }
  }

  Future<bool> procKitting_trans_temp_DIP(String Partcode, String Quantity,
      String Issue_sloc, String RepLoc, String DeliveryDate, String BarcodeCarton,
      String BarcodePartcard, String TypeKitting, String Status, String UserID, String Plant,
      String BarcodeArr, String QuantityArr, String Model, String Line, String Time, String UploadNo) async{
    final http.Response response = await http.get(
      Uri.parse('http://10.92.184.24:8011/updatekittingdip?Partcode=$Partcode&Quantity=$Quantity&Issue_sloc=$Issue_sloc&RepLoc=$RepLoc&DeliveryDate=$DeliveryDate&BarcodeCarton=$BarcodeCarton&BarcodePartcard=$BarcodePartcard&TypeKitting=$TypeKitting&Status=$Status&UserID=$UserID&Plant=$Plant&BarcodeArr=$BarcodeArr&QuantityArr=$QuantityArr&Model=$Model&Line=$Line&Time=$Time&UploadNo=$UploadNo'),
      headers:{
        'Accept': 'application/json; charset=UTF-8',
      },
    );
    print(response.body);
    final data = json.decode(response.body);
    //print(data[0]["username"]);
    if (response.statusCode == 200) {
      if(response.body == 'true')
      {
        //print('kitting tran temp thanh cong');
        return true;
      }else
      {
        return false;
      }
    } else {
      //return false;
      throw Exception('Failed API: updatekittingdip');
    }
  }

  Future<bool> procKitting_trans_temp_DIP_post(String Partcode, String Quantity,
      String Issue_sloc, String RepLoc, String DeliveryDate, String BarcodeCarton,
      String BarcodePartcard, String TypeKitting, String Status, String UserID, String Plant,
      String BarcodeArr, String QuantityArr, String Model, String Line, String Time, String UploadNo) async{
    /*final http.Response response = await http.get(
      Uri.parse('http://10.92.184.24:8011/updatekittingdip?Partcode=$Partcode&Quantity=$Quantity&Issue_sloc=$Issue_sloc&RepLoc=$RepLoc&DeliveryDate=$DeliveryDate&BarcodeCarton=$BarcodeCarton&BarcodePartcard=$BarcodePartcard&TypeKitting=$TypeKitting&Status=$Status&UserID=$UserID&Plant=$Plant&BarcodeArr=$BarcodeArr&QuantityArr=$QuantityArr&Model=$Model&Line=$Line&Time=$Time&UploadNo=$UploadNo'),
      headers:{
        'Accept': 'application/json; charset=UTF-8',
      },
    );*/
    final String apiUrl = 'http://10.92.184.24:8011/updatekittingdip_post';
    Map<String, String> requestData = {
      'Partcode': Partcode,
      'Quantity': Quantity,
      'Issue_sloc': Issue_sloc,
      'RepLoc': RepLoc,
      'DeliveryDate': DeliveryDate,
      'BarcodeCarton': BarcodeCarton,
      'BarcodePartcard': BarcodePartcard,
      'TypeKitting': TypeKitting,
      'Status': Status,
      'UserID': UserID,
      'Plant': Plant,
      'BarcodeArr': BarcodeArr,
      'QuantityArr': QuantityArr,
      'Model': Model,
      'Line': Line,
      'Time': Time,
      'UploadNo': UploadNo,
    };
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(requestData),
    );

    print(response.body);
    final data = json.decode(response.body);
    //print(data[0]["username"]);
    if (response.statusCode == 200) {
      if(response.body == 'true')
      {
        //print('kitting tran temp thanh cong');
        return true;
      }else
      {
        return false;
      }
    } else {
      //return false;
      throw Exception('Failed API: updatekittingdip_post');
    }
  }

  Future<bool> tblGrTrans_Delete_Temp(String BarcodeArr) async{
    final http.Response response = await http.get(
      Uri.parse('http://10.92.184.24:8011/deletetemp?BarcodeArr=$BarcodeArr'),
      headers:{
        'Accept': 'application/json; charset=UTF-8',
      },
    );
    //print(response.body);
    //final data = json.decode(response.body);
    //print(data[0]["username"]);
    if (response.statusCode == 200) {
      if(response.body == 'true')
      {
        //print('xoa bang tran thanh cong');
        return true;
      }else
      {
        return false;
      }
    } else {
      //return false;
      throw Exception('Failed API: deletetemp');
    }
  }

  Future<bool> tblGrTrans_Delete_Temp_post(String BarcodeArr) async{
    /*final http.Response response = await http.get(
      Uri.parse('http://10.92.184.24:8011/deletetemp?BarcodeArr=$BarcodeArr'),
      headers:{
        'Accept': 'application/json; charset=UTF-8',
      },
    );*/
    final String apiUrl = 'http://10.92.184.24:8011/deletetemp_post';
    Map<String, String> requestData = {
      'BarcodeArr': BarcodeArr,
    };
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(requestData),
    );
    //print(response.body);
    //final data = json.decode(response.body);
    //print(data[0]["username"]);
    if (response.statusCode == 200) {
      if(response.body == 'true')
      {
        //print('xoa bang tran thanh cong');
        return true;
      }else
      {
        return false;
      }
    } else {
      //return false;
      throw Exception('Failed API: deletetemp_post');
    }
  }




}