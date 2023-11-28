import 'dart:convert';
//import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../Model/Kitting/KittingDIP/Class_supplyDIP.dart';

class SupplyKittingDIP
{
  Future<String> Check_Issue_List_Partcard(String Reservation_Code) async{
    final String apiUrl = 'http://10.92.184.24:8011/getlistsupplyDIP';
    Map<String, String> requestData = {
      'Reservation_Code': Reservation_Code,
    };
    try{
      final  response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestData),
      );  //.timeout(Duration(seconds: 3))
      String kq='';
      //print(response.body);
      final data = json.decode(response.body);
      //print(data);
      if (response.statusCode == 200) {
        if(response.body != '""')
        {
          //gia tri khac null
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
        throw Exception('Failed API: getlistsupplyDIP');
      }
    }
    catch(e)
    {
      print('Error time out: $e');
      return 'err_time_out';
    }
  }
  //dt_tran
  Future<List<Get_KittingTran_Issue_line_Partcard>?> fetch_dt_kittingTran_dip(String TypeKitting,String DeliveriDate,String Model,String Plant,String Category,String Name_Common,String Time,String UploadNo) async {
    final String apiUrl = 'http://10.92.184.24:8011/Get_KittingTran_Issue_line_Partcard_DIP';
    Map<String, String> requestData = {
      'TypeKitting': TypeKitting,
      'DeliveriDate': DeliveriDate,
      'Model': Model,
      'Plant':Plant,
      'Category':Category,
      'Name_Common':Name_Common,
      'Time':Time,
      'UploadNo':UploadNo,
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
            .map((json) => Get_KittingTran_Issue_line_Partcard.fromJson(json))
            .toList();
      } else {
        throw Exception(
            'Fail API: Get_KittingTran_Issue_line_Partcard_DIP ${response.statusCode}');
      }
    }
    catch (e)
    {
      // Handle any error that occurred during the API call
      print('Error dt_kittingTran: $e');
    }
  }
  //dt_temp
  Future<List<Report_Partcard_DIP_new>?> fetchtrantemp_dip(String ProductDate,String Plant,String Category,String Time,String UploadNo, String Model) async {
    final String apiUrl = 'http://10.92.184.24:8011/Kitting_supply_dttemp_dip';
    Map<String, String> requestData = {
      'ProductDate': ProductDate,
      'Plant': Plant,
      'Category': Category,
      'Time': Time,
      'UploadNo': UploadNo,
      'Model': Model,
    };
    try
    {
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
            'Fail API: Kitting_supply_dttemp_dip  ${response.statusCode}');
      }
    }
    catch(e)
    {
      print('Error default: $e');
    }
  }

  Future<bool?> tblKitting_Trans_Partcard_Temp_DIP_Update_2(String Reservation_Code, String Update_user, String Confirm_user) async{
    try
    {
      /*final http.Response response = await http.get(
        Uri.parse('http://10.92.184.24:8011/UpdateSupply?Reservation_Code=$Reservation_Code&Update_user=$Update_user&Confirm_user=$Confirm_user'),
        headers:{
          'Accept': 'application/json; charset=UTF-8',
        },
      );*/
      final String apiUrl = 'http://10.92.184.24:8011/UpdateSupplydip';
      Map<String, String> requestData = {
        'Reservation_Code': Reservation_Code,
        'Update_user': Update_user,
        'Confirm_user': Confirm_user,
      };
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestData),
      );

      print(response.body);
      final data = json.decode(response.body);
      print(data);
      if (response.statusCode == 200) {
        if(response.body == 'true')
        {
          //print('update supply thanh cong');
          return true;
        }else
        {
          //print('fail update supply');
          return false;
        }
      } else {
        //return false;
        throw Exception('Failed API: UpdateSupplydip');
      };
    }
    catch(e)
    {
      print('Error supply: $e');
      return false;
    }

  }


}