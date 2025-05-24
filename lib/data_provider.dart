import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DataProvider extends ChangeNotifier {
  String? _clientID;
  List? _dataSet;
  // BankName API
  bankNameProviderAPI() async {
    try {
      final response = await http.get(
        Uri.parse("http://192.168.2.34:29091/getBankMaster"),
      );

      if (response.statusCode == 200) {
        final decodedData = jsonDecode(response.body);

        return decodedData is List ? decodedData : [decodedData];
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch data: $e');
    }
  }

  //Client Register API
  clientRegisterAPI(data) async {
    try {
      final response = await http.post(
        Uri.parse("http://192.168.2.34:29091/clientRegister"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(data),
      );

      final {"client_id": clientId, "status": status} = json.decode(
        response.body,
      );

      if (status == "S") {
        _clientID = clientId;
        notifyListeners();
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch data: $e');
    }
  }

  getClientID() {
    return _clientID;
  }

  clientLoginAPI(data) async {
    try {
      final response = await http.post(
        Uri.parse("http://192.168.2.34:29091/clientLogin"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(data),
      );

      var dataSet = json.decode(response.body);
      if (dataSet["flag"]) {
        _dataSet = [dataSet];
        notifyListeners();
        
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch data: $e');
    }
  }

  getClientProfile()
  {
    return _dataSet;
  }
}
