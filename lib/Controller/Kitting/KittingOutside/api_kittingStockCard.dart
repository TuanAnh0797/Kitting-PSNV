import 'dart:convert';
import 'package:http/http.dart' as http;

class ClassKittingStockcard
{

  Future<String> procKitting_check_stockcard_urgent(String _barcode) async{
    final String apiUrl = 'http://10.92.184.24:8011/procKitting_check_stockcard_urgent';
    Map<String, String> requestData = {
      '_barcode': _barcode,
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
        throw Exception(
            'Fail API: procKitting_check_stockcard_urgent ${response.statusCode}');
      }
    }
    catch(e)
    {
      print('Error time out: $e');
      return 'err_time_out';
    }
  }

  Future<String> procKitting_kitting_stockcard2(String vender, String DA, String DeliveryDate, String PONo, String PoNo_item, String material, String qty_act, String barcode, String reploc, String userkitting, String flagtype, String barcodeID) async{
    final String apiUrl = 'http://10.92.184.24:8011/procKitting_kitting_stockcard2';
    Map<String, String> requestData = {
      'vender': vender,
      'DA': DA,
      'DeliveryDate': DeliveryDate,
      'PONo': PONo,
      'PoNo_item': PoNo_item,
      'material': material,
      'qty_act': qty_act,
      'barcode': barcode,
      'reploc': reploc,
      'userkitting': userkitting,
      'flagtype': flagtype,
      'barcodeID': barcodeID,
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
        throw Exception(
            'Fail API: procKitting_kitting_stockcard2 ${response.statusCode}');
      }
    }
    catch(e)
    {
      print('Error time out: $e');
      return 'err_time_out';
    }
  }



}

