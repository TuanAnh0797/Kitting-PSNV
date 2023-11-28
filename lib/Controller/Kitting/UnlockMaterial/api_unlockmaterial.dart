import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../Model/Kitting/UnlockMaterial/Class_UnlokcMaterial.dart';


class Class_unlockmaterialGRtran
{
  Future<List<GetMaterialLocked>?> Get_dt_GRtran(String Material) async {
    final String apiUrl = 'http://10.92.184.24:8011/GetMaterialLocked';
    Map<String, String> requestData = {
      'Material': Material,
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
            .map((json) => GetMaterialLocked.fromJson(json))
            .toList();
      } else {
        throw Exception(
            'Fail API: GetMaterialLocked ${response.statusCode}');
      }
    }
    catch(e)
    {
      print('Error thong tin kho: $e');
    }
  }

  Future<bool> UnLockMaterial_ByListID(String ListID) async{
    final String apiUrl = 'http://10.92.184.24:8011/UnLockMaterial_ByListID';
    Map<String, String> requestData = {
      'ListID': ListID,
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
      throw Exception('Failed API: UnLockMaterial_ByListID');
    }
  }



}