import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../Model/Kitting/KittingFA/Class_supplyFA.dart';


class SupplyKittingFA
{
  Future<String> Check_Issue_List_Partcard(String Reservation_Code) async{
    final http.Response response = await http.get(
      Uri.parse('http://10.92.184.24:8011/getlistsupply?Reservation_Code=$Reservation_Code'),
      headers:{
        'Accept': 'application/json; charset=UTF-8',
      },
    );
    try
    {
      String kq='';
      print(response.body);
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
        throw Exception('Failed API: getlistsupply');
      }
    }
    catch(e)
    {
      print('Error time out: $e');
      return 'err_time_out';
    }

  }

  Future<List<Get_KittingTran_Issue_line_Partcard>?> fetch_dt_kittingTran(String TypeKitting, String DeliveriDate, String Model, String Line, String Time) async {
    final String apiUrl = 'http://10.92.184.24:8011/Get_KittingTran_Issue_line_Partcard';
    Map<String, String> requestData = {
      'TypeKitting': TypeKitting,
      'DeliveriDate': DeliveriDate,
      'Model': Model,
      'Line':Line,
      'Time':Time,
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
            'Fail API: Get_KittingTran_Issue_line_Partcard ${response.statusCode}');
      }
    }
    catch (e)
    {
      // Handle any error that occurred during the API call
      print('Error dt_kittingTran: $e');
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
          'Fail API: Get_SumQuantity_Supply ${response.statusCode}');
    }
  }

  //Group API
  Future<List<Supply_NTime_Delivery>?> fetchtrantemp_NTime(String Barcode, String type_check, String name_stored) async {
    final String apiUrl = 'http://10.92.184.24:8011/Kitting_supply_dttemp';
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
            'Fail API: Kitting_supply_dttemp ${response.statusCode}');
      }

    } catch (e) {
      // Handle any error that occurred during the API call
      print('Error Ntime: $e');
    }
  }

  //show error


  Future<List<Supply_1Time_Delivery>?> fetchtrantemp_1Time(String Barcode, String type_check, String name_stored) async {
    final String apiUrl = 'http://10.92.184.24:8011/Kitting_supply_dttemp';
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

        return dataList
            .map((json) => Supply_1Time_Delivery.fromJson(json))
            .toList();
      } else {
        throw Exception(
            'Fail API: Kitting_supply_dttemp ${response.statusCode}');
      }

    }
    catch(e)
    {
      print('Error 1time: $e');
    }

  }

  //Supply_PreparetionNTime
  Future<List<Supply_PreparetionNTime>?> fetchtrantemp_PreTime(String Barcode, String type_check, String name_stored) async {
    final String apiUrl = 'http://10.92.184.24:8011/Kitting_supply_dttemp';
    Map<String, String> requestData = {
      'Barcode': Barcode,
      'type_check': type_check,
      'name_stored': name_stored,
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
            .map((json) => Supply_PreparetionNTime.fromJson(json))
            .toList();
      } else {
        throw Exception(
            'Fail API: Kitting_supply_dttemp ${response.statusCode}');
      }
    }
    catch(e)
    {
      print('Error 2-preparentime: $e');
    }
  }

  Future<List<Supply_Preparetion_Delivery>?> fetchtrantemp_Preparetion(String Barcode, String type_check, String name_stored) async {
    final String apiUrl = 'http://10.92.184.24:8011/Kitting_supply_dttemp';
    Map<String, String> requestData = {
      'Barcode': Barcode,
      'type_check': type_check,
      'name_stored': name_stored,
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
            .map((json) => Supply_Preparetion_Delivery.fromJson(json))
            .toList();
      } else {
        throw Exception(
            'Fail API: Kitting_supply_dttemp ${response.statusCode}');
      }
    }
    catch(e)
    {
      print('Error default: $e');
    }

  }

  Future<bool?> tblKitting_Trans_Partcard_Temp_Update_2(String Reservation_Code, String Update_user, String Confirm_user) async{
    try
    {
      final http.Response response = await http.get(
        Uri.parse('http://10.92.184.24:8011/UpdateSupply?Reservation_Code=$Reservation_Code&Update_user=$Update_user&Confirm_user=$Confirm_user'),
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
          print('update supply thanh cong');
          return true;
        }else
        {
          print('fail update supply');
          return false;
        }
      } else {
        //return false;
        throw Exception('Failed API: UpdateSupply');
      };
    }
    catch(e)
    {
      print('Error supply: $e');
      return false;
    }

  }

}