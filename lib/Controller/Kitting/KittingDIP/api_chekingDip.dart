import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../Model/Kitting/KittingDIP/Class_checkingDip.dart';


class GetChekingDIP {

  Future<List<Get_KittingTran_Partcard_DIP>?> get_dt_kittingTran(String TypeKitting, String DeliveriDate, String Model, String Plant, String Category, String Name_common, String Time, String UploadNo) async {
    final String apiUrl = 'http://10.92.184.24:8011/Get_KittingTran_Partcard_DIP';
    Map<String, String> requestData = {
      'TypeKitting': TypeKitting,
      'DeliveriDate': DeliveriDate,
      'Model': Model,
      'Plant': Plant,
      'Category': Category,
      'Name_common': Name_common,
      'Time': Time,
      'UploadNo': UploadNo,
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
            .map((json) => Get_KittingTran_Partcard_DIP.fromJson(json))
            .toList();
      } else {
        throw Exception(
            'Fail API: Get_KittingTran_Partcard_DIP  ${response.statusCode}');
      }
    }
    catch(e)
    {
      print('Error dt_kittingTran DIP: $e');
    }
  }

  Future<bool> Update_sttchecking(String barcode_tray) async{
    final String apiUrl = 'http://10.92.184.24:8011/Update_sttchecking';
    Map<String, String> requestData = {
      'barcode_tray': barcode_tray,
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

  Future<List<Report_Partcard_DIP_new>?> get_dt_dt_temp(String ProductDate,String Plant,String Category,String Time,String UploadNo,String Model) async {
    final String apiUrl = 'http://10.92.184.24:8011/Report_Partcard_DIP_new';
    Map<String, String> requestData = {
      'ProductDate': ProductDate,
      'Plant': Plant,
      'Category': Category,
      'Time': Time,
      'UploadNo': UploadNo,
      'Model':Model,
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
            .map((json) => Report_Partcard_DIP_new.fromJson(json))
            .toList();
      } else {
        throw Exception(
            'Fail API: Report_Partcard_DIP_new ${response.statusCode}');
      }
    }
    catch(e)
    {
      print('Error dt_kittingTran DIP: $e');
    }
  }

  Future<List<Get_List_KittingDIP_NotYet>?> get_dt_notYetKitting(String ProductDate,String Plant,String Category,String Time,String UploadNo,String Model) async {
    final String apiUrl = 'http://10.92.184.24:8011/Get_List_KittingDIP_NotYet';
    Map<String, String> requestData = {
      'ProductDate': ProductDate,
      'Plant': Plant,
      'Category': Category,
      'Time': Time,
      'UploadNo': UploadNo,
      'Model':Model,
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
            .map((json) => Get_List_KittingDIP_NotYet.fromJson(json))
            .toList();
      } else {
        throw Exception(
            'Fail API: Get_List_KittingDIP_NotYet ${response.statusCode}');
      }
    }
    catch(e)
    {
      print('Error dt_kitting_notyes DIP: $e');
    }
  }

  Future<bool> tblKitting_Trans_PartCard_Temp_Update(String Reservation_Code, String BarcodePartcard, String Update_user) async{
    final http.Response response = await http.get(
      Uri.parse('http://10.92.184.24:8011/updatecheckingDIP?Reservation_Code=$Reservation_Code&BarcodePartcard=$BarcodePartcard&Update_user=$Update_user'),
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
        print('update checking dip thanh cong');
        return true;
      }else
      {
        print('fail checking');
        return false;
      }
    } else {
      //return false;
      throw Exception('Failed API: Reservation_Code');
    }
  }

  Future<bool> tblKitting_Trans_PartCard_Temp_Update_post(String Reservation_Code, String BarcodePartcard, String Update_user) async{
    /* final http.Response response = await http.get(
      Uri.parse('http://10.92.184.24:8011/updatecheckingDIP?Reservation_Code=$Reservation_Code&BarcodePartcard=$BarcodePartcard&Update_user=$Update_user'),
      headers:{
        'Accept': 'application/json; charset=UTF-8',
      },
    );*/
    final String apiUrl = 'http://10.92.184.24:8011/updatecheckingDIP_post';
    Map<String, String> requestData = {
      'Reservation_Code': Reservation_Code,
      'BarcodePartcard': BarcodePartcard,
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
        //print('checking dip thanh cong');
        return true;
      }else
      {
        return false;
      }
    } else {
      //return false;
      throw Exception('Failed API: updatecheckingDIP_post');
    }

  }

  //update khi exit tran temp
  Future<bool> tblKitting_Trans_PartCard_Temp_Update_SttCheck(String Reservation_Code, String BarcodePartcard, String Update_user, String SttCheck) async{
    final http.Response response = await http.get(
      Uri.parse('http://10.92.184.24:8011/exittrantempdip?Reservation_Code=$Reservation_Code&BarcodePartcard=$BarcodePartcard&Update_user=$Update_user&SttCheck=$SttCheck'),
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
      }
      else
      {
        print('fail update');
        return false;
      }
    } else {
      //return false;
      throw Exception('Failed API: exittrantempdip');
    }
  }

}