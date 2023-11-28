import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../Model/GR/ClassListGRPending.dart';
import '../../Model/GR/ClassOpenGR.dart';
import '../../Model/GR/DATotalRevert.dart';
import '../../Model/GR/DataTableGetNoPOPending.dart';

Future<String> GR_EDI_NoPOPending(String DANo, String DAItem, String PONo,
    String POItem, String Barcode) async {
  final String apiUrl = 'http://10.92.184.24:8011/GR_EDI_NoPOPending';

  Map<String, String> requestData = {
    'DANo': DANo,
    'DAItem': DAItem,
    'PONo': PONo,
    'POItem': POItem,
    'Barcode': Barcode,
  };

  final response = await http.post(
    Uri.parse(apiUrl),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode(requestData),
  );

  if (response.statusCode == 200) {
    return response.body;
    print(response.body);
  } else {
    print(
        'Lỗi trong quá trình gọi API GR_EDI_NoPOPending: ${response.statusCode}');
    throw Exception('Lỗi trong quá trình gọi API GR_EDI_NoPOPending');
  }
}

Future<List<DataTableGetNoPOPending>> DADetail_GetNoPOPending(
    String DATotalID, String PONo, String POItem) async {
  final String apiUrl = 'http://10.92.184.24:8011/DADetail_GetNoPOPending';

  Map<String, String> requestData = {
    'DATotalID': DATotalID,
    'PONo': PONo,
    'POItem': POItem,
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
        .map((json) => DataTableGetNoPOPending.fromJson(json))
        .toList();
  } else {
    throw Exception(
        'Error while calling API DADetail_GetNoPOPending: ${response.statusCode}');
  }
}

Future<List<Map<String, dynamic>>> checkQtyPO(String PONoID, String soluongScan,
    String POitemCode, String barcode, String status) async {
  String apiUrl =
      'http://10.92.184.24:8011/Check_qty_PO'; // Replace this with your actual API URL

  // Create the request body using a Map
  Map<String, String> requestData = {
    "PONo_ID": PONoID,
    "soluong_scan": soluongScan,
    "POitem_code": POitemCode,
    "barcode": barcode,
    "status": status,
  };

  // Encode the request data to JSON
  String requestBody = json.encode(requestData);

  // Make the API POST request
  final response = await http.post(
    Uri.parse(apiUrl),
    headers: {"Content-Type": "application/json"},
    body: requestBody,
  );

  if (response.statusCode == 200) {
    // Decode the response JSON
    List<dynamic> responseData = json.decode(response.body);

    // Convert the response data to a List<Map<String, dynamic>>
    List<Map<String, dynamic>> dataTable =
    List<Map<String, dynamic>>.from(responseData);

    return dataTable;
  } else {
    throw Exception(
        'Failed to call the  API checkQtyPO: ${response.statusCode}');
  }
}

Future<bool> DADetail_add_NoPOPending(
    String DATotalID,
    String Barcode,
    String QuantityDetail,
    String QuantityBox,
    String Status,
    String Create_User,
    String InvoiceNo,
    String PONo,
    String POItem) async {
  String apiUrl =
      "http://10.92.184.24:8011/DADetail_add_NoPOPending"; // Replace this with the actual API URL

  Map<String, String> requestData = {
    "DATotalID": DATotalID,
    "Barcode": Barcode,
    "QuantityDetail": QuantityDetail,
    "QuantityBox": QuantityBox,
    "Status": Status,
    "Create_User": Create_User,
    "InvoiceNo": InvoiceNo,
    "PONo": PONo,
    "POItem": POItem,
  };

  try {
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
      throw Exception('Failed to call API DADetail_add_NoPOPending');
    }
  } catch (e) {
    // Handle any error that occurred during the API call
    print('Error DADetail_add_NoPOPending: $e');
    return false;
  }
}

Future<bool> DADetail_update_NoPOPending(
    String DATotalID,
    String Barcode,
    String QuantityBox,
    String QuantityDiff,
    String PONo,
    String POItem,
    String Update_User) async {
  String apiUrl =
      "http://10.92.184.24:8011/DADetail_update_NoPOPending"; // Replace this with the actual API URL

  Map<String, String> requestData = {
    "DATotalID": DATotalID,
    "Barcode": Barcode,
    "QuantityBox": QuantityBox,
    "QuantityDiff": QuantityDiff,
    "PONo": PONo,
    "POItem": POItem,
    "Update_User": Update_User,
  };

  try {
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
      throw Exception('Failed to call API DADetail_update_NoPOPending');
    }
  } catch (e) {
    // Handle any error that occurred during the API call
    print('Error DADetail_update_NoPOPending: $e');
    return false;
  }
}

Future<int> procPOPending_Over(
    String poNo, String poItem, String material) async {
  final apiUrl =
      'http://10.92.184.24:8011/procPOPending_Over'; // Replace this with your actual API endpoint URL

  // Prepare the request body
  final requestBody = {
    'PONo': poNo,
    'POItem': poItem,
    'Material': material,
  };

  try {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(requestBody),
    );

    if (response.statusCode == 200) {
      // If the API call is successful, parse the response and return the integer result
      return int.parse(response.body);
    } else {
      // If the API call fails, handle the error accordingly (e.g., show an error message)
      print('API call failed with status code: ${response.statusCode}');
      return -1; // Return a specific value to indicate failure
    }
  } catch (e) {
    // Handle any exceptions that occur during the API call
    print('Error occurred during API call: $e');
    return -1; // Return a specific value to indicate failure
  }
}

Future<bool> Update_GR_EDI_Enough_NEWPO(String daTotalID, String updateUser,
    String typeRevise, String statusOver) async {
  final apiUrl =
      'http://10.92.184.24:8011/Update_GR_EDI_Enough_NEWPO'; // Replace this with your actual API endpoint URL

  // Prepare the request body
  final requestBody = {
    'DATotalID': daTotalID,
    'Update_User': updateUser,
    'TypeRevise': typeRevise,
    'statusOver': statusOver,
  };

  try {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(requestBody),
    );

    if (response.statusCode == 200) {
      // If the API call is successful, parse the response and return the boolean result
      return json.decode(response.body) as bool;
    } else {
      // If the API call fails, handle the error accordingly (e.g., show an error message)
      print(
          'API call failed with status code Update_GR_EDI_Enough_NEWPO: ${response.statusCode}');
      return false; // Return a specific value to indicate failure
    }
  } catch (e) {
    // Handle any exceptions that occur during the API call
    print('Error occurred during API call Update_GR_EDI_Enough_NEWPO: $e');
    return false; // Return a specific value to indicate failure
  }
}

Future<bool> Update_GR_EDI_Enough(
    String daTotalID, String updateUser, String typeRevise) async {
  final apiUrl =
      'http://10.92.184.24:8011/Update_GR_EDI_Enough'; // Replace this with your actual API endpoint URL

  // Prepare the request body
  final requestBody = {
    'DATotalID': daTotalID,
    'Update_User': updateUser,
    'TypeRevise': typeRevise
  };

  try {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(requestBody),
    );

    if (response.statusCode == 200) {
      // If the API call is successful, parse the response and return the boolean result
      return json.decode(response.body) as bool;
    } else {
      // If the API call fails, handle the error accordingly (e.g., show an error message)
      print(
          'API call failed with status code Update_GR_EDI_Enough: ${response.statusCode}');
      return false; // Return a specific value to indicate failure
    }
  } catch (e) {
    // Handle any exceptions that occur during the API call
    print('Error occurred during API call Update_GR_EDI_Enough: $e');
    return false; // Return a specific value to indicate failure
  }
}

Future<int> CheckUrgent(String material) async {
  final apiUrl = 'http://10.92.184.24:8011/CheckUrgent?Material=$material';

  try {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      // Successful response, parse and return the result
      final responseData = jsonDecode(response.body);
      return int.parse(response.body);
    } else {
      // Handle other status codes if needed
      throw Exception('Failed to call API CheckUrgent: ${response.statusCode}');
    }
  } catch (e) {
    // Handle any exceptions that occurred during the API call
    print('Error: $e');
    throw Exception('Failed to call API CheckUrgent: $e');
  }
}

Future<List<Map<String, dynamic>>> callProcPOPendingOverAutoAPI(
    String poNo,
    String poItem,
    String material,
    String soluongtongDA,
    String datotalID,
    ) async {
  final apiUrl = 'http://10.92.184.24:8011/procPOPending_Over_Auto';

  final requestData = {
    'PONo': poNo,
    'POItem': poItem,
    'Material': material,
    'soluongtongDA': soluongtongDA,
    'DATotalID': datotalID,
  };

  try {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(requestData),
    );

    if (response.statusCode == 200) {
      // Decode the response JSON
      List<dynamic> responseData = json.decode(response.body);

      // Convert the response data to a List<Map<String, dynamic>>
      List<Map<String, dynamic>> dataTable =
      List<Map<String, dynamic>>.from(responseData);

      return dataTable;
    } else {
      // Handle other status codes if needed
      throw Exception(
          'Failed to call API callProcPOPendingOverAutoAPI: ${response.statusCode}');
    }
  } catch (e) {
    // Handle any exceptions that occurred during the API call
    print('Error callProcPOPendingOverAutoAPI: $e');
    throw Exception('Failed to call API callProcPOPendingOverAutoAPI: $e');
  }
}

Future<bool> callDADetailAutoGRNoPOPendingAPI({
  required String datotalID,
  required String daNo,
  required String gCode,
  required String barcode,
  required String quantityDetail,
  required String quantityBox,
  required String status,
  required String createUser,
  required String invoiceNo,
  required String poNo,
  required String poItem,
  required String indexBox,
  required String totalBox,
}) async {
  final apiUrl = 'http://10.92.184.24:8011/DADetail_AutoGR_NoPOPending';

  final requestData = {
    'DATotalID': datotalID,
    'DANo': daNo,
    'GCode': gCode,
    'Barcode': barcode,
    'QuantityDetail': quantityDetail,
    'QuantityBox': quantityBox,
    'Status': status,
    'Create_User': createUser,
    'InvoiceNo': invoiceNo,
    'PONo': poNo,
    'POItem': poItem,
    'IndexBox': indexBox,
    'TotalBox': totalBox,
  };

  try {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(requestData),
    );

    if (response.statusCode == 200) {
      // Successful response, parse and return the result
      final responseData = jsonDecode(response.body);
      return responseData as bool;
    } else {
      // Handle other status codes if needed
      throw Exception(
          'Failed to call API callDADetailAutoGRNoPOPendingAPI: ${response.statusCode}');
    }
  } catch (e) {
    // Handle any exceptions that occurred during the API call
    print('Error: $e');
    throw Exception('Failed to call API callDADetailAutoGRNoPOPendingAPI: $e');
  }
}

class GetOpenGR {
  var data = [];

  List<ClassOpenGR> result = [];

  Future<List<ClassOpenGR>> fetchListGR(String DANo, String DAItem, String PONo,
      String POItem, String Material) async {
    final response = await http.get(Uri.parse(
        'http://10.92.184.24:8011/openGR?DANo=$DANo&DAItem=$DAItem&PONo=$PONo&POItem=$POItem&Material=$Material'));
    if (response.statusCode == 200) {
      data = jsonDecode(response.body);
      result = data.map((e) => ClassOpenGR.fromJson(e)).toList();
      //debugPrint(response.statusCode.toString());
      //debugPrint(data.toString());
      //debugPrint(data[0]['ID'].toString());
      debugPrint(data.toString());
      print(result);
    } else {
      throw Exception('Fail to load API');
    }
    return result;
  }
}

class ClickOpenGR {
  //var data = [];
  // ignore: library_private_types_in_public_api
  Future<bool> UpdateGR(String DAtotalID, String Create_User) async {
    final http.Response response = await http.get(
      Uri.parse(
          'http://10.92.184.24:8011/ClickOpenGR?DAtotalID=$DAtotalID&Create_User=$Create_User'),
      headers: {
        'Accept': 'application/json; charset=UTF-8',
      },
    );
    print(response.body);
    final data = json.decode(response.body);
    //print(data[0]["username"]);
    if (response.statusCode == 200) {
      if (response.body == 'true') {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
      //throw Exception('Failed to create album.');
    }
  }
}

class InsertLabelGR {
  //var data = [];
  // ignore: library_private_types_in_public_api
  Future<bool> InsertLBNG(
      String Vendercode,
      String Deliverydate,
      String InvoiceNo,
      String DANo,
      String DAItem,
      String PONo,
      String POItem,
      String Material,
      String Qty,
      String QtyperBox,
      String TotalBox,
      String UnitNo,
      String QtyTotal,
      String Create_User) async {
    final http.Response response = await http.get(
      Uri.parse(
          'http://10.92.184.24:8011/insertNG?Vendercode=$Vendercode&Deliverydate=$Deliverydate&InvoiceNo=$InvoiceNo&DANo=$DANo&DAItem=$DAItem&PONo=$PONo&POItem=$POItem&Material=$Material&Qty=$Qty&QtyperBox=$QtyperBox&TotalBox=$TotalBox&UnitNo=$UnitNo&QtyTotal=$QtyTotal&Create_User=$Create_User'),
      headers: {
        'Accept': 'application/json; charset=UTF-8',
      },
    );
    print(response.body);
    final data = json.decode(response.body);
    //print(data[0]["username"]);
    if (response.statusCode == 200) {
      if (response.body == 'true') {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
      //throw Exception('Failed to create album.');
    }
  }
}

class ListGRPending {
  var data = [];
  List<ClassListGRPending> result = [];

  Future<List<ClassListGRPending>> fetchListGR(String DANo, String GCode) async {
    final response = await http.get(Uri.parse(
        'http://10.92.184.24:8011/POPendingGR?DANo=$DANo&GCode=$GCode'));
    if (response.statusCode == 200) {
      data = jsonDecode(response.body);
      result = data.map((e) => ClassListGRPending.fromJson(e)).toList();
      //debugPrint(response.statusCode.toString());
      //debugPrint(data.toString());
      //debugPrint(data[0]['ID'].toString());
      debugPrint(data.toString());
      print(result);
    } else {
      throw Exception('Fail to load API');
    }
    return result;
  }
}

Future<List<DATotalRevert>> Check_Revert_OddBox(String Barcode) async {
  final String apiUrl = 'http://10.92.184.24:8011/Check_Revert_OddBox';
  //final String apiUrl = 'http://10.92.184.22:8093/Check_Revert_OddBox';

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
    return dataList.map((json) => DATotalRevert.fromJson(json)).toList();
  } else {
    throw Exception(
        'Error while calling API Check_Revert_OddBox: ${response.statusCode}');
  }
}

Future<List<DATotalRevert>> Check_Revert_GR_NoPOPending(String DANo,
    String DAItem, String PONo, String POItem, String Material) async {
  final String apiUrl = 'http://10.92.184.24:8011/Check_Revert_GR_NoPOPending';
  //final String apiUrl = 'http://10.92.184.22:8093/Check_Revert_GR_NoPOPending';

  Map<String, String> requestData = {
    'DANo': DANo,
    'DAItem': DAItem,
    'PONo': PONo,
    'POItem': POItem,
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
    return dataList.map((json) => DATotalRevert.fromJson(json)).toList();
  } else {
    throw Exception(
        'Error while calling API Check_Revert_OddBox: ${response.statusCode}');
  }
}

Future<bool> DA_Revert_NoPOPending(
    String DAtotalID, String Create_User, String type) async {
  final apiUrl = 'http://10.92.184.24:8011/DA_Revert_NoPOPending';

  final requestData = {
    'DAtotalID': DAtotalID,
    'Create_User': Create_User,
    'type': type,
  };

  try {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(requestData),
    );

    if (response.statusCode == 200) {
      // Successful response, parse and return the result
      final responseData = jsonDecode(response.body);
      return responseData as bool;
    } else {
      // Handle other status codes if needed
      throw Exception(
          'Failed to call API DA_Revert_NoPOPending: ${response.statusCode}');
    }
  } catch (e) {
    // Handle any exceptions that occurred during the API call
    print('Error: $e');
    throw Exception('Failed to call API DA_Revert_NoPOPending: $e');
  }
}

Future<bool> UserRight(
    String userID, String function_code) async {
  final String apiUrl = 'http://10.92.184.24:8011/UserRight';
  //final String apiUrl = 'http://10.92.184.22:8093/UserRight';

  final requestData = {
    'userID': userID,
    'FunctionName': function_code,
  };

  try {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(requestData),
    );

    if (response.statusCode == 200) {
      // Successful response, parse and return the result
      final responseData = jsonDecode(response.body);
      return responseData as bool;
    } else {
      // Handle other status codes if needed
      throw Exception(
          'Failed to call API UserRight: ${response.statusCode}');
    }
  } catch (e) {
    // Handle any exceptions that occurred during the API call
    print('Error: $e');
    throw Exception('Failed to call API UserRight: $e');
  }
}
