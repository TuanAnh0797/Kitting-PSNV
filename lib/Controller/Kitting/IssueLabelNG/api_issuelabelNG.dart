import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../Model/Kitting/IssueLabelNG/Class_IssuelabelNG.dart';

class Class_IssuelabelNG
{
  Future<List<procGetInfoMaterial_SLOC>?> Get_Info_Material(String Material,String Sloc,String Plant) async {
    final String apiUrl = 'http://10.92.184.24:8011/procGetInfoMaterial_SLOC';
    Map<String, String> requestData = {
      'Material': Material,
      'Sloc': Sloc,
      'Plant': Plant,
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
            .map((json) => procGetInfoMaterial_SLOC.fromJson(json))
            .toList();
      } else {
        throw Exception(
            'Fail API:procGetInfoMaterial_SLOC  ${response.statusCode}');
      }
    }
    catch(e)
    {
      print('Error thong tin kho: $e');
    }
  }

  Future<bool> procGRTransNG_add(String Partcard,String Material,String Plant,String Sloc,String TypeLabel,String ID,String Quantity,String User) async{
    final String apiUrl = 'http://10.92.184.24:8011/procGRTransNG_add';
    Map<String, String> requestData = {
      'Partcard': Partcard,
      'Material': Material,
      'Plant': Plant,
      'Sloc': Sloc,
      'TypeLabel': TypeLabel,
      'ID': ID,
      'Quantity': Quantity,
      'User': User,
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
      throw Exception(
          'Fail API:procGRTransNG_add  ${response.statusCode}');
      //return false;
    }
  }



}