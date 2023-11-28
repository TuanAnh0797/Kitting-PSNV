import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../Model/Kitting/KittingOutside/Class_KittingExportOutside.dart';


class KittingOutsideExport
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
        //truong hop chua duoc kitting   = 1
        //select 2, @sl_conlai as soluongconlai  =2 combine nhieu partcard
        //select 0  //da duoc kitting
        kq =  response.body.replaceAll('"', '');
        //print(kq);
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
      //print('Error time out: $e');
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


  Future<String> procKitting_check_kitting_outside_update_thieu(String _pullistid2,String soluong, String _userid) async{
    final String apiUrl = 'http://10.92.184.24:8011/procKitting_check_kitting_outside_update_thieu';
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
        //select 0  //--khong ton tai ban ghi  // or --hoac da duoc kitting het roi
        //select 1,@slconlai as slconlai  //-->update hang thieu  ==> truong hop hang thieu
        kq =  response.body.replaceAll('"', '');
        //print(kq);
        return kq;
      }
      else
      {
        //return 'err_time_out';
        //return kq;
        throw Exception('Failed API: procKitting_check_kitting_outside_update_thieu');
      }
    }
    catch(e)
    {
      print('Error time out: $e');
      return 'err_time_out';
    }
  }

  Future<String> Update_Kitting_EportNG(String _pullistid2,String soluong, String _userid) async{
    final String apiUrl = 'http://10.92.184.24:8011/Update_Kitting_EportNG';
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
        //select 0  //--khong ton tai ban ghi  // or --hoac da duoc kitting het roi
        //select 1,@slconlai as slconlai  //-->update hang thieu  ==> truong hop hang thieu
        kq =  response.body.replaceAll('"', '');
        //print(kq);
        return kq;
      }
      else
      {
        //return 'err_time_out';
        //return kq;
        throw Exception('Failed API: Update_Kitting_EportNG');
      }
    }
    catch(e)
    {
      //print('Error time out: $e');
      return 'err_time_out';
    }
  }

  Future<String> procKitting_check_kitting_outside_update_thieu2(String _pullistid2,String soluong, String _userid) async{
    final String apiUrl = 'http://10.92.184.24:8011/procKitting_check_kitting_outside_update_thieu2';
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
        //select 0  //--khong ton tai ban ghi  // or --hoac da duoc kitting het roi
        //select 1,@slconlai as slconlai  //-->update hang thieu  ==> truong hop hang thieu
        kq =  response.body.replaceAll('"', '');
        //print(kq);
        return kq;
      }
      else
      {
        //return 'err_time_out';
        //return kq;
        throw Exception('Failed API: procKitting_check_kitting_outside_update_thieu2');
      }
    }
    catch(e)
    {
      print('Error time out: $e');
      return 'err_time_out';
    }
  }

  Future<String> procKitting_check_kitting_outside_update(String _pullistid2,String soluong, String _userid) async{
    final String apiUrl = 'http://10.92.184.24:8011/procKitting_check_kitting_outside_update';
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
        //select 1
        kq =  response.body.replaceAll('"', '');
        //print(kq);
        return kq;
      }
      else
      {
        //return 'err_time_out';
        //return kq;
        throw Exception('Failed API: procKitting_check_kitting_outside_update');
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
        throw Exception('Failed API: procKitting_check_kitting_outside_update_thieu_combine');
      }
    }
    catch(e)
    {
      print('Error time out: $e');
      return 'err_time_out';
    }
  }

  Future<bool> TBL_Posdiffrence_Add2(String GRTranID, String QtyOld, String QtyNew, String Create_User, String Typediff, String Reason) async{
    final String apiUrl = 'http://10.92.184.24:8011/TBL_Posdiffrence_Add2';
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
      throw Exception('Failed API: TBL_Posdiffrence_Add2');
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

}