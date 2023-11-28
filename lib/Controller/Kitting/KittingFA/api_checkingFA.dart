import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../Model/Kitting/KittingFA/Class_checkingFA.dart';



class GetKittingTrans {
  var data = [];

  List<Get_KittingTran_Partcard> result = [];
  Future<List<Get_KittingTran_Partcard>> fetchkittingtrans(String TypeKitting, String DeliveriDate, String Model, String Line, String Time,String Category, String Category_JT) async {
    final response =
    await http.get(Uri.parse('http://10.92.184.24:8011/listtrantemp?TypeKitting=$TypeKitting&DeliveriDate=$DeliveriDate&Model=$Model&Line=$Line&Time=$Time&Category=$Category&Category_JT=$Category_JT'));
    if (response.statusCode == 200) {
      data = jsonDecode(response.body);
      result = data.map((e) => Get_KittingTran_Partcard.fromJson(e)).toList();
      //debugPrint(response.statusCode.toString());
      //debugPrint(data.toString());
      //debugPrint(data[0]['ID'].toString());
      debugPrint(data.toString());
      print(result);
    } else {
      throw Exception('Fail API: fetchkittingtrans');
    }
    return result;

  }

  Future<List<Supply_1Time_Delivery>> fetchtrantemp1tiem2(String Barcode) async {
    final response =
    await http.get(Uri.parse('http://10.92.184.24:8011/Supply_1Time?Barcode=$Barcode'));

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      final List<dynamic> dataList = responseBody as List<dynamic>;

      //final data2 = jsonDecode(response.body);
      print ('ket qua tra ra');
      print(dataList);
      print('==end==');
      return dataList
          .map((json) => Supply_1Time_Delivery.fromJson(json))
          .toList();
    } else {
      throw Exception('Fail API: Supply_1Time');
    }
  }

  //Supply_NTime_Delivery  ==> N time   (chay cung API)
  Future<List<Supply_NTime_Delivery>?> fetchtrantemp_NTime(String Barcode, String type_check, String name_stored) async {
    final String apiUrl = 'http://10.92.184.24:8011/Kitting_1Time_Delivery';
    Map<String, String> requestData = {
      'Barcode': Barcode,
      'type_check': type_check,
      'name_stored': name_stored,
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
        print(responseBody);
        return dataList
            .map((json) => Supply_NTime_Delivery.fromJson(json))
            .toList();
      } else {
        throw Exception(
            'Fail API: Kitting_1Time_Delivery ${response.statusCode}');
      }

    } catch (e) {
      // Handle any error that occurred during the API call
      print('Error Ntime: $e');
    }



  }

  //Supply_1Time_Delivery   ==> 1 Time (chay cung API)
  //final String apiUrl = 'http://10.92.184.22:8093/Supply_1Time_Delivery';  ===> loi dia chi chay web API
  Future<List<Supply_1Time_Delivery>> fetchtrantemp_1Time(String Barcode, String type_check, String name_stored) async {
    final String apiUrl = 'http://10.92.184.24:8011/Kitting_1Time_Delivery';
    Map<String, String> requestData = {
      'Barcode': Barcode,
      'type_check': type_check,
      'name_stored': name_stored,
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
          .map((json) => Supply_1Time_Delivery.fromJson(json))
          .toList();
    } else {
      throw Exception(
          'Fail API: Kitting_1Time_Delivery ${response.statusCode}');
    }
  }

  //Supply_PreparetionNTime
  Future<List<Supply_PreparetionNTime>> fetchtrantemp_PreTime(String Barcode, String type_check, String name_stored) async {
    final String apiUrl = 'http://10.92.184.24:8011/Kitting_1Time_Delivery';
    Map<String, String> requestData = {
      'Barcode': Barcode,
      'type_check': type_check,
      'name_stored': name_stored,
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
          .map((json) => Supply_PreparetionNTime.fromJson(json))
          .toList();
    } else {
      throw Exception(
          'Fail API: Kitting_1Time_Delivery ${response.statusCode}');
    }
  }

  //Supply_GopModel_Delivery
  Future<List<Supply_XHGopModel_Delivery>> fetchtrantemp_XHGopModel(String Barcode, String type_check, String name_stored) async {
    final String apiUrl = 'http://10.92.184.24:8011/Kitting_1Time_Delivery';
    Map<String, String> requestData = {
      'Barcode': Barcode,
      'type_check': type_check,
      'name_stored': name_stored,
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
          .map((json) => Supply_XHGopModel_Delivery.fromJson(json))
          .toList();
    } else {
      throw Exception(
          'Fail API: Kitting_1Time_Delivery ${response.statusCode}');
    }
  }

  //Supply_Preparetion_Delivery
  Future<List<Supply_Preparetion_Delivery>> fetchtrantemp_Preparetion(String Barcode, String type_check, String name_stored) async {
    final String apiUrl = 'http://10.92.184.24:8011/Kitting_1Time_Delivery';
    Map<String, String> requestData = {
      'Barcode': Barcode,
      'type_check': type_check,
      'name_stored': name_stored,
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
          .map((json) => Supply_Preparetion_Delivery.fromJson(json))
          .toList();
    } else {
      throw Exception(
          'Fail API: Kitting_1Time_Delivery ${response.statusCode}');
    }
  }

  Future<bool> Update_sttchecking(String barcode_tray, String barcode_list, String Update_user) async{
    final String apiUrl = 'http://10.92.184.24:8011/Update_sttchecking';
    Map<String, String> requestData = {
      'barcode_tray': barcode_tray,
      'barcode_list': barcode_list,
      'Update_user': Update_user,
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
      throw Exception('Failed API: Update_sttchecking');
    }
  }

//Get_SumQuantity_Supply --- get so luong
  Future<List<Get_SumQuantity_Supply>> fetchsumqty(String Model,String Line, String Deliverydate, String TypeKitting, String Time, String Plant) async {
    final String apiUrl = 'http://10.92.184.24:8011/Get_SumQuantity_Supply';
    Map<String, String> requestData = {
      'Model': Model,
      'Line': Line,
      'Deliverydate': Deliverydate,
      'TypeKitting': TypeKitting,
      'Time': Time,
      'Plant': Plant,
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
          .map((json) => Get_SumQuantity_Supply.fromJson(json))
          .toList();
    } else {
      throw Exception(
          'Fail API:Get_SumQuantity_Supply  ${response.statusCode}');
    }
  }

  //Update checking kitting MCS - buoc 2
  Future<bool> UpdateChecking(String TypeKitting, String DeliveriDate, String Model, String Line, String Time, String Category, String Category_JT, String Reservation_Code, String Update_user) async{
    final http.Response response = await http.get(
      Uri.parse('http://10.92.184.24:8011/checkingupdate?TypeKitting=$TypeKitting&DeliveriDate=$DeliveriDate&Model=$Model&Line=$Line&Time=$Time&Category=$Category&Category_JT=$Category_JT&Reservation_Code=$Reservation_Code&Update_user=$Update_user'),
      headers:{
        'Accept': 'application/json; charset=UTF-8',
      },
    );
    print(response.body);
    final data = json.decode(response.body);
    print(data);
    if (response.statusCode == 200) {
      if(response.body == 'true')
      {
        print('update checking thanh cong');
        return true;
      }else
      {
        print('fail checking');
        return false;
      }
    } else {
      //return false;
      throw Exception('Failed API: checkingupdate');
    };
  }
//================== dt_not_yes_kitting ===================
  //1time
  Future<List<ProcKitting1Time_PartdCard_NOTime_category>> Select_KittingByType_1time(String Model, String Partcode,String Line, String Time, String DeliveryDate, String TypeKit, String Plant, String CATEGORY) async {
    final String apiUrl = 'http://10.92.184.24:8011/Select_KittingByType';
    Map<String, String> requestData = {
      'Model': Model,
      'Partcode': Partcode,
      'Line': Line,
      'Time': Time,
      'DeliveryDate': DeliveryDate,
      'TypeKit': TypeKit,
      'Plant': Plant,
      'CATEGORY': CATEGORY,
    };

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(requestData),
    );

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      //print(responseBody);
      final List<dynamic> dataList = responseBody as List<dynamic>;

      return dataList
          .map((json) => ProcKitting1Time_PartdCard_NOTime_category.fromJson(json))
          .toList();
    } else {
      throw Exception(
          'Fail API: Select_KittingByType ${response.statusCode}');
    }
  }

  Future<List<Get_KittingTran_Partcard_All>?> get_dt_kittingTran_all(String TypeKitting,String Deliverydate,String Model,String Line,String Time,String Category,String Category_JT) async {
    final String apiUrl = 'http://10.92.184.24:8011/Get_KittingTran_temp_all';
    Map<String, String> requestData = {
      'TypeKitting': TypeKitting,
      'Deliverydate': Deliverydate,
      'Model': Model,
      'Line': Line,
      'Time': Time,
      'Category': Category,
      'Category_JT': Category_JT,
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
            .map((json) => Get_KittingTran_Partcard_All.fromJson(json))
            .toList();
      } else {
        throw Exception(
            'Fail API:Get_KittingTran_temp_all  ${response.statusCode}');
      }
    }
    catch(e)
    {
      print('Error dt_kittingTran DIP: $e');
    }
  }

  //ntime
  Future<List<ProcKittingNTime_PartCard_Category>> Select_KittingByType_Ntime(String Model, String Partcode,String Line, String Time, String DeliveryDate, String TypeKit, String Plant, String CATEGORY) async {
    final String apiUrl = 'http://10.92.184.24:8011/Select_KittingByType';
    Map<String, String> requestData = {
      'Model': Model,
      'Partcode': Partcode,
      'Line': Line,
      'Time': Time,
      'DeliveryDate': DeliveryDate,
      'TypeKit': TypeKit,
      'Plant': Plant,
      'CATEGORY': CATEGORY,
    };

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(requestData),
    );

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      print(responseBody);
      final List<dynamic> dataList = responseBody as List<dynamic>;

      return dataList
          .map((json) => ProcKittingNTime_PartCard_Category.fromJson(json))
          .toList();
    } else {
      throw Exception(
          'Fail API:Select_KittingByType  ${response.statusCode}');
    }
  }

  //XHGopModel
  Future<List<ProcKitting_XHGopModel_PartdCard_NOTime_Category>> Select_KittingByType_XHGopModel(String Model, String Partcode,String Line, String Time, String DeliveryDate, String TypeKit, String Plant, String CATEGORY) async {
    final String apiUrl = 'http://10.92.184.24:8011/Select_KittingByType';
    Map<String, String> requestData = {
      'Model': Model,
      'Partcode': Partcode,
      'Line': Line,
      'Time': Time,
      'DeliveryDate': DeliveryDate,
      'TypeKit': TypeKit,
      'Plant': Plant,
      'CATEGORY': CATEGORY,
    };

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(requestData),
    );

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      //print(responseBody);
      final List<dynamic> dataList = responseBody as List<dynamic>;

      return dataList
          .map((json) => ProcKitting_XHGopModel_PartdCard_NOTime_Category.fromJson(json))
          .toList();
    } else {
      throw Exception(
          'Fail API:Select_KittingByType  ${response.statusCode}');
    }
  }

  //PrepareNTime
  Future<List<ProcKittingPrepareNTime_PartCard_category>> Select_KittingByType_PrepareNTime(String Model, String Partcode,String Line, String Time, String DeliveryDate, String TypeKit, String Plant, String CATEGORY) async {
    final String apiUrl = 'http://10.92.184.24:8011/Select_KittingByType';
    Map<String, String> requestData = {
      'Model': Model,
      'Partcode': Partcode,
      'Line': Line,
      'Time': Time,
      'DeliveryDate': DeliveryDate,
      'TypeKit': TypeKit,
      'Plant': Plant,
      'CATEGORY': CATEGORY,
    };

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(requestData),
    );

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      //print(responseBody);
      final List<dynamic> dataList = responseBody as List<dynamic>;

      return dataList
          .map((json) => ProcKittingPrepareNTime_PartCard_category.fromJson(json))
          .toList();
    } else {
      throw Exception(
          'Fail API:Select_KittingByType  ${response.statusCode}');
    }
  }

  //default: ProcKittingPrepare1Time_PartCard_NOTime_category
  Future<List<ProcKittingPrepare1Time_PartCard_NOTime_category>> Select_KittingByType_Prepare1time(String Model, String Partcode,String Line, String Time, String DeliveryDate, String TypeKit, String Plant, String CATEGORY) async {
    final String apiUrl = 'http://10.92.184.24:8011/Select_KittingByType';
    Map<String, String> requestData = {
      'Model': Model,
      'Partcode': Partcode,
      'Line': Line,
      'Time': Time,
      'DeliveryDate': DeliveryDate,
      'TypeKit': TypeKit,
      'Plant': Plant,
      'CATEGORY': CATEGORY,
    };

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(requestData),
    );

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      //print(responseBody);
      final List<dynamic> dataList = responseBody as List<dynamic>;

      return dataList
          .map((json) => ProcKittingPrepare1Time_PartCard_NOTime_category.fromJson(json))
          .toList();
    } else {
      throw Exception(
          'Fail API:Select_KittingByType  ${response.statusCode}');
    }
  }

  //================ end dt_not_yes_kitting ==================================

  //update khi exit tran temp
  Future<bool> UpdateTranTempExit(String Reservation_Code, String BarcodePartcard, String Update_user, String SttCheck) async{
    final http.Response response = await http.get(
      Uri.parse('http://10.92.184.24:8011/exittrantemp?Reservation_Code=$Reservation_Code&BarcodePartcard=$BarcodePartcard&Update_user=$Update_user&SttCheck=$SttCheck'),
      headers:{
        'Accept': 'application/json; charset=UTF-8',
      },
    );
    //print(response.body);
    final data = json.decode(response.body);
    //print(data);
    if (response.statusCode == 200) {
      if(response.body == 'true')
      {
        //print('update sttcheck status thanh cong');
        return true;
      }else
      {
        print('fail update');
        return false;
      }
    } else {
      //return false;
      throw Exception('Failed API: exittrantemp');
    }
  }

}
