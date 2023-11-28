import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../Model/Kitting/KittingOutside/Class_KittingQCRosh.dart';

class APIKittingQCRosh
{
  Future<String> procKitting_check_kitting_outside(String _pullistid2) async{
    final String apiUrl = 'http://10.92.184.24:8011/procKitting_check_kitting_outside';
    Map<String, String> requestData = {
      '_pullistid2': _pullistid2,
    };
    try
    {
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
        throw Exception('Failed API: procKitting_check_kitting_outside');
      }
    }
    catch(e)
    {
      print('Error time out: $e');
      return 'err_time_out';
    }
  }

  Future<String> Check_combine_hangthieu(String _pullistid2) async{
    final String apiUrl = 'http://10.92.184.24:8011/Check_combine_hangthieu';
    Map<String, String> requestData = {
      '_pullistid2': _pullistid2,
    };
    try
    {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestData),
      );
      String kq='';
      if (response.statusCode == 200) {
        kq =  response.body.replaceAll('"', '');
        //print(kq);
        return kq;
      }
      else
      {
        //return 'err_time_out';
        //return kq;
        throw Exception('Failed API: Check_combine_hangthieu');
      }
    }
    catch(e)
    {
      print('Error time out: $e');
      return 'err_time_out';
    }
  }

  Future<String> ROSH_CHECKSTORAGE(String barcode) async{
    final String apiUrl = 'http://10.92.184.24:8011/ROSH_CHECKSTORAGE';
    Map<String, String> requestData = {
      'barcode': barcode,
    };
    try
    {
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
        throw Exception('Failed API:ROSH_CHECKSTORAGE ');
      }
    }
    catch(e)
    {
      print('Error time out: $e');
      return 'err_time_out';
    }
  }

  Future<String> procKitting_check_kitting_outside_update_rosh(String _pullistid2, String soluong, String _userid) async{
    final String apiUrl = 'http://10.92.184.24:8011/procKitting_check_kitting_outside_update_rosh';
    Map<String, String> requestData = {
      '_pullistid2': _pullistid2,
      'soluong': soluong,
      '_userid': _userid,
    };
    try
    {
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
        throw Exception('Failed API:procKitting_check_kitting_outside_update_rosh ');
      }
    }
    catch(e)
    {
      print('Error time out: $e');
      return 'err_time_out';
    }
  }

  Future<String> procKitting_check_kitting_outside_update_rosh_thieu(String _pullistid2, String soluong, String _userid) async{
    final String apiUrl = 'http://10.92.184.24:8011/procKitting_check_kitting_outside_update_rosh_thieu';
    Map<String, String> requestData = {
      '_pullistid2': _pullistid2,
      'soluong': soluong,
      '_userid': _userid,
    };
    try
    {
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
        throw Exception('Failed API:procKitting_check_kitting_outside_update_rosh_thieu ');
        //return 'err_time_out';
      }
    }
    catch(e)
    {
      print('Error time out: $e');
      return 'err_time_out';
    }
  }

  Future<String> RoshQCHistory_INSERT(String barcode, String quantity, String status, String userid) async{
    final String apiUrl = 'http://10.92.184.24:8011/RoshQCHistory_INSERT';
    Map<String, String> requestData = {
      'barcode': barcode,
      'quantity': quantity,
      'status': status,
      'userid': userid,
    };
    try
    {
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
        throw Exception('Failed API:RoshQCHistory_INSERT');
        //return 'err_time_out';
      }
    }
    catch(e)
    {
      print('Error time out: $e');
      return 'err_time_out';
    }
  }

  Future<String> procKitting_check_kitting_outside_update_thieu_combine(String _pullistid2,String soluong_old,String soluong, String _userid,String flagcombine) async{
    final String apiUrl = 'http://10.92.184.24:8011/procKitting_check_kitting_outside_update_thieu_combine';
    Map<String, String> requestData = {
      '_pullistid2': _pullistid2,
      'soluong_old': soluong_old,
      'soluong': soluong,
      '_userid': _userid,
      'flagcombine': flagcombine,
    };
    try
    {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestData),
      );
      String kq='';
      if (response.statusCode == 200) {
        //select 1
        kq =  response.body.replaceAll('"', '');
        //print(kq);
        return kq;
      }
      else
      {
        //return 'err_time_out';
        //return kq;
        throw Exception('Fail API: procKitting_check_kitting_outside_update_thieu_combine');
      }
    }
    catch(e)
    {
      print('Error time out: $e');
      return 'err_time_out';
    }
  }

  Future<String> procKitting_check_kitting_outside_update_combine(String _pullistid2,String soluong_old,String soluong, String _userid,String flagcombine) async{
    final String apiUrl = 'http://10.92.184.24:8011/procKitting_check_kitting_outside_update_combine';
    Map<String, String> requestData = {
      '_pullistid2': _pullistid2,
      'soluong_old': soluong_old,
      'soluong': soluong,
      '_userid': _userid,
      'flagcombine': flagcombine,
    };
    try
    {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestData),
      );
      String kq='';
      if (response.statusCode == 200) {
        //select 1
        kq =  response.body.replaceAll('"', '');
        //print(kq);
        return kq;
      }
      else
      {
        //return 'err_time_out';
        //return kq;
        throw Exception('Failed API: procKitting_check_kitting_outside_update_combine');
      }
    }
    catch(e)
    {
      print('Error time out: $e');
      return 'err_time_out';
    }
  }

  Future<bool> TBL_Posdiffrence_Add(String GRTranID, String QtyOld, String QtyNew, String Create_User, String Typediff, String Reason) async{
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

    print(response.body);

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
      throw Exception('Failed API: TBL_Posdiffrence_Add');
    }
  }

  Future<List<Get_TBLGRTrans>?> Get_TBLGRTrans_outside(String Barcode) async {
    final String apiUrl = 'http://10.92.184.24:8011/Get_TBLGRTrans';
    Map<String, String> requestData = {
      'Barcode': Barcode,
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
            .map((json) => Get_TBLGRTrans.fromJson(json))
            .toList();
      } else {
        throw Exception(
            'Fail API: Get_TBLGRTrans ${response.statusCode}');
      }
    }
    catch(e)
    {
      print('Error tblGRtran DIP: $e');
    }
  }


}