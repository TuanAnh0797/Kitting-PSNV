import 'dart:convert';
import 'package:http/http.dart' as http;

Future<bool> Login_HT(
    String userid,
    ) async {
  String apiUrl =
      "http://10.92.184.24:8011/Login_HT"; // Replace this with the actual API URL

  Map<String, String> requestData = {
    "UserID": userid
  };

  //try {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {"Content-Type": "application/json"},
      body: json.encode(requestData),
    );

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, the API call was successful
      // Parse the response body as JSON
      bool result = json.decode(response.body);
      return result;
    } else {
      // If the server did not return a 200 OK response, throw an exception.
      throw Exception('Failed to call API Login_HT');
    }
  // } catch (e) {
  //   // Handle any error that occurred during the API call
  //   print('Error Login_HT: $e');
  //   return false;
  // }
}


Future<String> Checkversion_Foss(String version) async{
  final String apiUrl = 'http://10.92.184.24:8011/Checkversion_EDI';
  Map<String, String> requestData = {
    'version': version,
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
      throw Exception('Failed API: check_version');
    }
  }
  catch(e)
  {
    print('Error time out: $e');
    return 'err_time_out';
  }
}