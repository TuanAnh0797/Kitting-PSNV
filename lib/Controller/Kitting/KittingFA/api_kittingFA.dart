import 'dart:convert';
//import 'dart:html';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../Model/Kitting/KittingFA/Class_kittingFA.dart';


//==================// Kitting MCS //=========================
class KittingTemp {
  //var data = [];
  // ignore: library_private_types_in_public_api
  Future<bool> CheckKittingTemp(String BarcodePartcard) async{
    final http.Response response = await http.get(
      Uri.parse('http://10.92.184.24:8011/kittingtemp?BarcodePartcard=$BarcodePartcard'),
      headers:{
        'Accept': 'application/json; charset=UTF-8',
      },
    );
    print(response.body);
    final data = json.decode(response.body);
    //print(data[0]["username"]);
    if (response.statusCode == 200) {
      if(response.body == '"0"')
      {
        //partcard chua duoc kitting
        return true;
      }else
      {
        return false;
      }
    } else {
      //return false;
      throw Exception('Failed API: kittingtemp');
    }
  }

  Future<bool> CheckKittingTemp_post(String BarcodePartcard) async{
    /*final http.Response response = await http.get(
      Uri.parse('http://10.92.184.24:8011/kittingtemp?BarcodePartcard=$BarcodePartcard'),
      headers:{
        'Accept': 'application/json; charset=UTF-8',
      },
    );*/
    final String apiUrl = 'http://10.92.184.24:8011/kittingtemp_post';
    Map<String, String> requestData = {
      'BarcodePartcard': BarcodePartcard,
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
      if(response.body == '"0"')
      {
        //partcard chua duoc kitting
        return true;
      }else
      {
        return false;
      }
    } else {
      //return false;
      throw Exception('Failed API: kittingtemp_post');
    }
  }
}

class Getqtykitting {
  //var data = [];
  // ignore: library_private_types_in_public_api
  Future<String> fetchqtykitting(String Model, String Partcode, String Line, String Time, String DeliveryDate,String TypeKit) async{
    final http.Response response = await http.get(
      Uri.parse('http://10.92.184.24:8011/getqtykt?Model=$Model&Partcode=$Partcode&Line=$Line&Time=$Time&DeliveryDate=$DeliveryDate&TypeKit=$TypeKit'),
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
        //gia tri khac null
        //truong hop lay ket qua so luong hang thieu hang thieu
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
      throw Exception('Failed API: fetchqtykitting');
    }
  }

  Future<String> fetchqtykitting_post(String Model, String Partcode, String Line, String Time, String DeliveryDate,String TypeKit) async{
    /*final http.Response response = await http.get(
      Uri.parse('http://10.92.184.24:8011/getqtykt?Model=$Model&Partcode=$Partcode&Line=$Line&Time=$Time&DeliveryDate=$DeliveryDate&TypeKit=$TypeKit'),
      headers:{
        'Accept': 'application/json; charset=UTF-8',
      },
    );*/
    final String apiUrl = 'http://10.92.184.24:8011/getqtykt_post';
    Map<String, String> requestData = {
      'Model': Model,
      'Partcode': Partcode,
      'Line': Line,
      'Time': Time,
      'DeliveryDate': DeliveryDate,
      'TypeKit': TypeKit,
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
        //gia tri khac null
        //truong hop lay ket qua so luong hang thieu hang thieu
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
      throw Exception('Failed API: fetchqtykitting_post');
    }
  }
}
//=========================  // dt_PartCard //=============================
//1Time
//ProcKitting1Time_PartdCard_NOTime_category
class SelectTypeKitting {
  var data = [];
  List<ClasLisTypeKitting> result = [];
  Future<List<ClasLisTypeKitting>> fetchListKitting(String Model, String Partcode,
      String Line, String Time, String DeliveryDate, String TypeKit, String Plant, String CATEGORY) async {
    final response =
    await http.get(Uri.parse('http://10.92.184.24:8011/listKitting?Model=$Model&Partcode=$Partcode&Line=$Line&Time=$Time&DeliveryDate=$DeliveryDate&TypeKit=$TypeKit&Plant=$Plant&CATEGORY=$CATEGORY'));
    if (response.statusCode == 200) {
      data = jsonDecode(response.body);
      result = data.map((e) => ClasLisTypeKitting.fromJson(e)).toList();
      //debugPrint(response.statusCode.toString());
      //debugPrint(data.toString());
      //debugPrint(data[0]['ID'].toString());
      debugPrint(data.toString());
      print(result);
    } else {
      throw Exception('FailAPI: fetchListKitting');
    }
    return result;

  }

  Future<List<ClasLisTypeKitting>?> fetchListKitting_post(String Model, String Partcode,
      String Line, String Time, String DeliveryDate, String TypeKit, String Plant, String CATEGORY) async {
    /* final response =
    await http.get(Uri.parse('http://10.92.184.24:8011/listKitting?Model=$Model&Partcode=$Partcode&Line=$Line&Time=$Time&DeliveryDate=$DeliveryDate&TypeKit=$TypeKit&Plant=$Plant&CATEGORY=$CATEGORY'));
*/
    final String apiUrl = 'http://10.92.184.24:8011/listKitting_post';
    Map<String, String> requestData = {
      'Model': Model,
      'Partcode': Partcode,
      'Line': Line,
      'Time': Time,
      'DeliveryDate': DeliveryDate,
      'TypeKit':TypeKit,
      'Plant':Plant,
      'CATEGORY':CATEGORY,
    };

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestData),
      );

      if (response.statusCode == 200) {
        data = jsonDecode(response.body);
        result = data.map((e) => ClasLisTypeKitting.fromJson(e)).toList();
        //debugPrint(response.statusCode.toString());
        //debugPrint(data.toString());
        //debugPrint(data[0]['ID'].toString());
        debugPrint(data.toString());
        print(result);
      } else {
        throw Exception('Fail API: listKitting_post');
      }
      return result;

    }
    catch(e)
    {
      print('Error listKitting 1 time: $e');
    }

  }

  //ntime
  Future<List<ProcKittingNTime_PartCard_category>> fetchkitting_NTime(String Model, String Partcode, String Line, String Time, String DeliveryDate, String Plant, String CATEGORY,String TypeKit) async {
    final String apiUrl = 'http://10.92.184.24:8011/Select_KittingByType_category';
    Map<String, String> requestData = {
      'Model': Model,
      'Partcode': Partcode,
      'Line': Line,
      'Time':Time,
      'DeliveryDate':DeliveryDate,
      'Plant':Plant,
      'CATEGORY':CATEGORY,
      'TypeKit':TypeKit,
    };

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(requestData),
    );

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      final List<dynamic> dataList = responseBody as List<dynamic>;

      return dataList
          .map((json) => ProcKittingNTime_PartCard_category.fromJson(json))
          .toList();
    } else {
      throw Exception(
          'Fail API: Select_KittingByType_category ${response.statusCode}');
    }
  }

  //Gop Model
  Future<List<ProcKittingNTime_PartCard_category>> fetchkitting_XHGopModel(String Model, String Partcode, String Line, String Time, String DeliveryDate, String Plant, String CATEGORY,String TypeKit) async {
    final String apiUrl = 'http://10.92.184.24:8011/Select_KittingByType_category';
    Map<String, String> requestData = {
      'Model': Model,
      'Partcode': Partcode,
      'Line': Line,
      'Time':Time,
      'DeliveryDate':DeliveryDate,
      'Plant':Plant,
      'CATEGORY':CATEGORY,
      'TypeKit':TypeKit,
    };

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(requestData),
    );

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      final List<dynamic> dataList = responseBody as List<dynamic>;

      return dataList
          .map((json) => ProcKittingNTime_PartCard_category.fromJson(json))
          .toList();
    } else {
      throw Exception(
          'Fail API: Select_KittingByType_category ${response.statusCode}');
    }
  }

  //PrepareNTime
  Future<List<ProcKittingPrepareNTime_PartCard_category>> fetchkitting_PrepareNTime(String Model, String Partcode, String Line, String Time, String DeliveryDate, String Plant, String CATEGORY,String TypeKit) async {
    final String apiUrl = 'http://10.92.184.24:8011/Select_KittingByType_category';
    Map<String, String> requestData = {
      'Model': Model,
      'Partcode': Partcode,
      'Line': Line,
      'Time':Time,
      'DeliveryDate':DeliveryDate,
      'Plant':Plant,
      'CATEGORY':CATEGORY,
      'TypeKit':TypeKit,
    };

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(requestData),
    );

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      final List<dynamic> dataList = responseBody as List<dynamic>;

      return dataList
          .map((json) => ProcKittingPrepareNTime_PartCard_category.fromJson(json))
          .toList();
    } else {
      throw Exception(
          'Fail API: Select_KittingByType_category ${response.statusCode}');
    }
  }

  //Prepare1Time
  Future<List<ProcKittingPrepare1Time_PartCard_NOTime_category>> fetchkitting_Prepare1Time(String Model, String Partcode, String Line, String Time, String DeliveryDate, String Plant, String CATEGORY,String TypeKit) async {
    final String apiUrl = 'http://10.92.184.24:8011/Select_KittingByType_category';
    Map<String, String> requestData = {
      'Model': Model,
      'Partcode': Partcode,
      'Line': Line,
      'Time':Time,
      'DeliveryDate':DeliveryDate,
      'Plant':Plant,
      'CATEGORY':CATEGORY,
      'TypeKit':TypeKit,
    };

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(requestData),
    );

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      final List<dynamic> dataList = responseBody as List<dynamic>;

      return dataList
          .map((json) => ProcKittingPrepare1Time_PartCard_NOTime_category.fromJson(json))
          .toList();
    } else {
      throw Exception(
          'Fail API:Select_KittingByType_category  ${response.statusCode}');
    }
  }


}



class SelectViewKitting {
  var data = [];
  List<ClassViewKitting> result = [];
  Future<List<ClassViewKitting>> fetchViewKitting(String PIC, String Issue_Sloc, String Partcode,
      String Model, String Line, String Time, String DeliveryDate, String TypeKit, String Plant, String Category) async {
    final response = await http.get(Uri.parse('http://10.92.184.24:8011/viewKitting?PIC=$PIC&Issue_Sloc=$Issue_Sloc&Partcode=$Partcode&Model=$Model&Line=$Line&Time=$Time&DeliveryDate=$DeliveryDate&TypeKit=$TypeKit&Plant=$Plant&Category=$Category'));
    if (response.statusCode == 200) {
      data = jsonDecode(response.body);
      result = data.map((e) => ClassViewKitting.fromJson(e)).toList();
      //debugPrint(response.statusCode.toString());
      //debugPrint(data.toString());
      //debugPrint(data[0]['ID'].toString());
      //debugPrint(data.toString());
      print(data);
    } else {
      throw Exception('Fail API: fetchViewKitting ');
    }
    return result;

  }

  Future<List<ClassViewKitting>?> fetchViewKitting_post(String PIC, String Issue_Sloc, String Partcode,
      String Model, String Line, String Time, String DeliveryDate, String TypeKit, String Plant, String Category) async {
    /*final response = await http.get(Uri.parse('http://10.92.184.24:8011/viewKitting?PIC=$PIC&Issue_Sloc=$Issue_Sloc&Partcode='
        '$Partcode&Model=$Model&Line=$Line&Time=$Time&DeliveryDate=$DeliveryDate&TypeKit=$TypeKit&Plant=$Plant&Category=$Category'));*/

    final String apiUrl = 'http://10.92.184.24:8011/viewKitting_post';
    Map<String, String> requestData = {
      'PIC': PIC,
      'Issue_Sloc': Issue_Sloc,
      'Partcode': Partcode,
      'Model': Model,
      'Line': Line,
      'Time':Time,
      'DeliveryDate':DeliveryDate,
      'TypeKit':TypeKit,
      'Plant':Plant,
      'Category':Category,
    };

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestData),
      );

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        final List<dynamic> dataList = responseBody as List<dynamic>;

        return dataList
            .map((json) => ClassViewKitting.fromJson(json))
            .toList();
      } else {
        throw Exception(
            'Fail API: viewKitting_post  ${response.statusCode}');
      }
    }
    catch(e)
    {
      print('Error ViewKitting DIP: $e');
    }

  }


}

class CheckCodeKitting {
  Future<String> fetchcheckkitting(String Barcode, String Material, String SLOC) async{
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
      throw Exception('Failed API: fetchcheckkitting');
    }
  }

  Future<String> fetchcheckkitting_post(String Barcode, String Material, String SLOC) async{
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
}

class UnlockBarcodekiting {
  //var data = [];
  // ignore: library_private_types_in_public_api
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
      throw Exception('Failed API: ulbarcodekitting');
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

}



class KitingTranTemp {
  Future<bool> Updatetrantemp(String Barcode, String GetQuantity) async{
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
      throw Exception('Failed API: Updatetrantemp');
    }
  }

  Future<bool> Updatetrantemp_post(String Barcode, String GetQuantity) async{
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

}

class UpkittingPlan {
  Future<bool> kittingplan(String Partcode, String Quantity, String QtyPlan, String Model, String Line, String Time,
      String Issue_sloc, String DeliveryDate, String BarcodeCarton, String BarcodePartcard, String TypeKitting,
      String Status, String UserID, String Plant, String ValueArr, String ModelQty, String ListBarcode) async{
    final http.Response response = await http.get(
      Uri.parse(
          'http://10.92.184.24:8011/kittingplan?Partcode=$Partcode&Quantity=$Quantity&QtyPlan=$QtyPlan&Model=$Model&Line=$Line&Time=$Time'
              '&Issue_sloc=$Issue_sloc&DeliveryDate=$DeliveryDate&BarcodeCarton=$BarcodeCarton&BarcodePartcard=$BarcodePartcard'
              '&TypeKitting=$TypeKitting&Status=$Status&UserID=$UserID&Plant=$Plant&ValueArr=$ValueArr&ModelQty=$ModelQty&ListBarcode=$ListBarcode'),
      headers: {
        'Accept': 'application/json; charset=UTF-8',
      },
    );
    print(response.body);
    final data = json.decode(response.body);
    //print(data[0]["username"]);
    if (response.statusCode == 200) {
      if(response.body == 'true')
      {
        print('kitting tran temp thanh cong');
        return true;
      }else
      {
        print('kitting fail');
        return false;
      }
    } else {
      //return false;
      throw Exception('Failed API: UpkittingPlan');
    }
  }

  Future<bool> kittingplan_post(String Partcode, String Quantity, String QtyPlan, String Model, String Line, String Time,
      String Issue_sloc, String DeliveryDate, String BarcodeCarton, String BarcodePartcard, String TypeKitting,
      String Status, String UserID, String Plant, String ValueArr, String ModelQty, String ListBarcode) async{

    final String apiUrl = 'http://10.92.184.24:8011/kittingplan_post';
    Map<String, String> requestData = {
      'Partcode': Partcode,
      'Quantity': Quantity,
      'QtyPlan': QtyPlan,
      'Model': Model,
      'Line': Line,
      'Time': Time,
      'Issue_sloc': Issue_sloc,
      'DeliveryDate': DeliveryDate,
      'BarcodeCarton': BarcodeCarton,
      'BarcodePartcard': BarcodePartcard,
      'TypeKitting': TypeKitting,
      'Status': Status,
      'UserID': UserID,
      'Plant': Plant,
      'ValueArr': ValueArr,
      'ModelQty': ModelQty,
      'ListBarcode': ListBarcode,
    };
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(requestData),
    );

    print(response.body);
    //final data = json.decode(response.body);
    //print(data[0]["username"]);
    if (response.statusCode == 200) {
      if(response.body == 'true')
      {
        print('kitting tran temp thanh cong');
        return true;
      }else
      {
        print('kitting fail');
        return false;
      }
    } else {
      //return false;
      throw Exception('Failed API: kittingplan_post');
    }
  }


}

class Api_tblGrTrans_Delete_Temp {
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
}

//==================// end Kitting MCS //===================

class GetUser {
  var data = [];
  List<User> result = [];
  Future<List<User>> fetchuser() async {
    final response =
    await http.get(Uri.parse('http://10.92.184.24:8011/login'));
    if (response.statusCode == 200) {
      data = jsonDecode(response.body);
      result = data.map((e) => User.fromJson(e)).toList();
      //debugPrint(response.statusCode.toString());
      //debugPrint(data.toString());
    } else {
      throw Exception('Fail to load API');
    }
    //return result;
    return result;
  }
}
class GetUserFoss {
  var data = [];
  List<UserFoss> result = [];
  Future<List<UserFoss>> fetchuserfoss() async {
    final response =
    await http.get(Uri.parse('http://10.92.184.24:8011/loginfoss'));
    if (response.statusCode == 200) {
      data = jsonDecode(response.body);
      result = data.map((e) => UserFoss.fromJson(e)).toList();
      //debugPrint(response.statusCode.toString());
      //debugPrint(data.toString());
    } else {
      throw Exception('Fail to load API');
    }
    //return result;
    return result;
  }
}
class InsertUserFoss {
  //var data = [];
  // ignore: library_private_types_in_public_api
  Future<bool> getInsert(String userid, String fullname, String password) async{
    final http.Response response = await http.get(
      Uri.parse('http://10.92.184.24:8011/userfoss?_userid=$userid&_name=$fullname&_pass=$password'),
      headers:{
        'Accept': 'application/json; charset=UTF-8',
      },
    );
    print(response.body);
    final data = json.decode(response.body);
    //print(data[0]["username"]);
    if (response.statusCode == 200) {
      if(response.body == '"1"')
      {
        return true;
      }else
      {
        return false;
      }
    } else {
      //return false;
      throw Exception('Failed to create album.');
    }
  }
}

class InsertUserFoss2 {
  //var data = [];
  // ignore: library_private_types_in_public_api
  Future<bool> getInsert(String userid, String fullname, String password) async{
    final http.Response response = await http.get(
      Uri.parse('http://10.92.184.24:8011/userfoss2?_userid=$userid&_name=$fullname&_pass=$password'),
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
        return true;
      }else
      {
        return false;
      }
    } else {
      //return false;
      throw Exception('Failed to create album.');
    }
  }
}

class UpdateUserMater
{
  Future<bool> updateID(String userid, String fullname, String password) async {
    //final response = await http.post(Uri.parse('http://10.92.184.24:8011/login2?_user=${username}&_pass=${password}'));
    final response = await http.get(Uri.parse('http://10.92.184.24:8011/updateMaterUser?_userid=$userid&_name=$fullname&_pass=$password'),
      //final response = await http.put(Uri.parse('http://10.92.184.24:8011/update2?_user=$username&_pass=$password'),
      headers:{
        'Accept': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      //var _data = jsonDecode(response.body);
      //print('check json');
      //print(response.body);
      //List = [{"ketqua":"OK"}];
      //return Insertdata2.fromJson(json.decode(response.body));
      //return abc;
      if(response.body == '"1"')
      {
        return true;
      }else
      {
        return false;
      }
    } else {
      //return false;
      throw Exception('Failed to create album.');
    }
  }
}

class UpdateData
{
  Future<bool> updateID(String username, String password) async {
    //final response = await http.post(Uri.parse('http://10.92.184.24:8011/login2?_user=${username}&_pass=${password}'));
    final response = await http.get(Uri.parse('http://10.92.184.24:8011/update?_user=$username&_pass=$password'),
      //final response = await http.put(Uri.parse('http://10.92.184.24:8011/update2?_user=$username&_pass=$password'),
      headers:{
        'Accept': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      //var _data = jsonDecode(response.body);
      //print('check json');
      //print(response.body);
      //List = [{"ketqua":"OK"}];
      //return Insertdata2.fromJson(json.decode(response.body));
      //return abc;
      if(response.body == '"1"')
      {
        return true;
      }else
      {
        return false;
      }
    } else {
      //return false;
      throw Exception('Failed to create album.');
    }
  }
}

class Checklogin{
  Future<bool> fetchlogin(String username, String password) async{
    final http.Response response = await http.get(
      Uri.parse('http://10.92.184.24:8011/checklogin?_user=$username&_pass=$password'),
      headers:{
        'Accept': 'application/json; charset=UTF-8',
      },
    );
    //print(response.body);
    final data = json.decode(response.body);
    //print(data[0]["username"]);
    if (response.statusCode == 200) {
      if (data[0]["username"] == '1'){
        return true;
      }
      else
      {
        return false;
      }
    } else {
      //return false;
      throw Exception('Failed to create album.');
    }
  }
}

class GetDatotaldetail {
  var data = [];
  List<Dadetail> result = [];

  Future<List<Dadetail>> fetchDAdetail(String barcode) async{
    final http.Response response = await http.get(
      Uri.parse('http://10.92.184.24:8011/checkpo?barcode=$barcode'),
      headers:{
        'Accept': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      data = jsonDecode(response.body);
      result = data.map((e) => Dadetail.fromJson(e)).toList();
      //debugPrint(response.statusCode.toString());
      debugPrint(result.toString());
      debugPrint(data.toString());
      return result;
    } else {
      throw Exception('Fail API checkpo');
    }

    /*//print(response.body);
    final data = json.decode(response.body);
    //print(data[0]["username"]);
    if (response.statusCode == 200) {
      if (data[0]["DATotalID"] != '0'){
        return true;
      }
      else
      {
        return false;
      }
    } else {
      return false;
      //throw Exception('Failed to create album.');
    }*/
  }
}



