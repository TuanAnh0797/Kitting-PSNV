import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../Model/Otherfuntion/ClassCheckStatus.dart';



class APICheckStaus
{
  Future<String> Check_Stock(String Barcode) async{
    final String apiUrl = 'http://10.92.184.24:8011/Check_Stock';
    Map<String, String> requestData = {
      'Barcode': Barcode,
    };

      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestData),
      );
      String kq='';
      if (response.statusCode == 200) {
        kq =  response.body.replaceAll('"', '');
        return kq;
      }
      else
      {
        //return 'err_time_out';
        //return kq;
        throw Exception('Failed API:Check_Stock ${response.statusCode}');
      }

  }
  Future<List<Get_Reason_UpdateBox>?> getAllCategory(String cate) async {
    final String apiUrl = 'http://10.92.184.24:8011/Get_Reason_UpdateBox';
    Map<String, String> requestData = {
      "cate": "cate",
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
            .map((json) => Get_Reason_UpdateBox.fromJson(json))
            .toList();
      } else {
        throw Exception(
            'Fail API:Get_Reason_UpdateBox  ${response.statusCode}');
      }

  }


  Future<List<Get_List_CheckStock>?> Get_CheckStock(String Barcode) async {
    final String apiUrl = 'http://10.92.184.24:8011/Get_List_CheckStock';
    Map<String, String> requestData = {
      'Barcode': Barcode,
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
            .map((json) => Get_List_CheckStock.fromJson(json))
            .toList();
      } else {
        throw Exception(
            'Fail API:Get_List_CheckStock  ${response.statusCode}');
      }

  }

  //Get_CheckStock_duoiL
  Future<List<Get_List_CheckStock_duoiL>?> Get_List_CheckStock_L(String Barcode) async {
    final String apiUrl = 'http://10.92.184.24:8011/Get_List_CheckStock_duoiL';
    Map<String, String> requestData = {
      'Barcode': Barcode,
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
            .map((json) => Get_List_CheckStock_duoiL.fromJson(json))
            .toList();
      } else {
        throw Exception(
            'Fail API: Get_List_CheckStock_duoiL ${response.statusCode}');
      }

  }

  Future<List<Get_Detail_Dependent_CheckSloc>?> Get_Dependent(String Barcode) async {
    final String apiUrl = 'http://10.92.184.24:8011/Get_Detail_Dependent_CheckSloc';
    Map<String, String> requestData = {
      'Barcode': Barcode,
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
            .map((json) => Get_Detail_Dependent_CheckSloc.fromJson(json))
            .toList();
      } else {
        throw Exception(
            'Fail API: Get_Detail_Dependent_CheckSloc ${response.statusCode}');
      }

  }

  Future<List<procGetInfoMaterial>?> Get_Dependent_material(String Material) async {
    final String apiUrl = 'http://10.92.184.24:8011/procGetInfoMaterial';
    Map<String, String> requestData = {
      'Material': Material,
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
            .map((json) => procGetInfoMaterial.fromJson(json))
            .toList();
      } else {
        throw Exception(
            'Fail API procGetInfoMaterial: ${response.statusCode}');
      }

  }

  Future<List<Get_TBLGRTrans>?> Get_TBLGRTrans_possdif(String Barcode) async {
    final String apiUrl = 'http://10.92.184.24:8011/Get_TBLGRTrans';
    Map<String, String> requestData = {
      'Barcode': Barcode,
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
            .map((json) => Get_TBLGRTrans.fromJson(json))
            .toList();
      } else {
        throw Exception(
            'Fail API: ${response.statusCode}');
      }
  }

  Future<bool> TBL_Posdiffrence_Add(String GRTranID,String QtyOld,String QtyNew,String Create_User,String Typediff,String Reason) async{
    final String apiUrl = 'http://10.92.184.24:8011/TBL_Posdiffrence_Add';
    Map<String, String> requestData = {
      'GRTranID': GRTranID,
      'QtyOld': QtyOld,
      'QtyNew': QtyNew,
      'Create_User': Create_User,
      'Typediff': Typediff,
      'Reason': Reason,
    };
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(requestData),
    );

    //print(response.body);

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
      throw Exception('fail API: TBL_Posdiffrence_Add');
    }
  }

  Future<bool> UnLockMaterial_ByListID_mobile(String Barcode) async{
    final String apiUrl = 'http://10.92.184.24:8011/UnLockMaterial_ByListID_mobile';
    Map<String, String> requestData = {
      'Barcode': Barcode,
    };
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(requestData),
    );

    //print(response.body);

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
      throw Exception('Failed API: UnLockMaterial_ByListID_mobile');
    }
  }



}