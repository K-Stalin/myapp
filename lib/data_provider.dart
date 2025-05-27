import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DataProvider extends ChangeNotifier {
  


  //------------------CLIENTSIDE API START-----------------------------------
  String? _clientID;
  var _dataSet;
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

      if (status == "S") 
      {
        _clientID = clientId;
        notifyListeners();
        return true;
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch data: $e');
    }
  }

  

  clientLoginAPI(data) async {
    try {
      final response = await http.post(
        Uri.parse("http://192.168.2.34:29091/clientLogin"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
         body:json.encode(data),
      );

      var dataSet = json.decode(response.body);

      
      if (dataSet["status"] == "S") 
      {
        _dataSet=dataSet[0];
        notifyListeners();
        return true;
      } 
      else 
      {

        return false;
        
        
      }
    } catch (e) 
    {
       throw Exception('Failed to fetch data: $e');
    }
  }


   getClientID() 
  {
    return _clientID;
  }

  

  getClientProfile() 
  {
    return _dataSet;
  }

//------------------CLIENTSIDE API END----------------------------------------





//------------------ADMIN API START-----------------------------------

var  _adminProfile;

// Admin API Start
adminLoginAPI(data) async
  {
      try {
      final response = await http.post(
        Uri.parse("http://192.168.2.34:29091/adminLogin"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(data),
      );

      var dataSet = json.decode(response.body);

      
    
      if (dataSet["status"] == "S") 
      {
        _adminProfile=dataSet["resp"];
        return true;
      }
       else 
      {

        return false;
      }
    } catch (e) {
      throw Exception('Failed to fetch data: $e');
    }
  }


// Add Bank 
  addBank(data) async {
    try {
      final response = await http.post(
        Uri.parse("http://192.168.2.34:29091/insertBank"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(data),
      );

      var dataset = json.decode(response.body);
      if (dataset["status"] == "S") 
      {
        return true;
      } else
      {
        return false;
        }

    } catch (e) {
      print("ErrorName:::::::::::::: $e");
    }
  }


// Add Stock
   addStock(data)  async{
       try {
      final response = await http.post(
        Uri.parse("http://192.168.2.34:29091/insertStock"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(data),
      );

      var dataset = json.decode(response.body);
       print(dataset);
      if (dataset["status"] == "S") 
      {
        return true;
      } else
      {
        return false;
        }

    } catch (e) {
      print("ErrorName:::::::::::::: $e");
    }
   }


// Add User
  addUser(data)  async{
       try {
      final response = await http.post(
        Uri.parse("http://192.168.2.34:29091/insertUser"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(data),
      );

      var dataset = json.decode(response.body);
       print(dataset);
      if (dataset["status"] == "S") 
      {
        return true;
      } else
      {
        return false;
        }

    } catch (e) {
      print("ErrorName:::::::::::::: $e");
    }
   }


// Client Approve
 
  clientApprove(data) async
  {
      try {
      final response = await http.post(
        Uri.parse("http://192.168.2.34:29091/kycApprovals"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(data),
      );

      var dataset = json.decode(response.body);
       print(dataset);
      if (dataset["status"] == "S") 
      {
        return true;
      } else
      {
        return false;
        }

    } catch (e) {
      print("ErrorName:::::::::::::: $e");
    }
  }




// GetClientData

   getClientDataAPI() async
   {  
     try {
      final response = await http.get(
        Uri.parse("http://192.168.2.34:29091/getClientData"),
      );

      var dataset = json.decode(response.body);
     
      if (dataset["status"] == "S") 
      {
        
        return dataset["resp"];
      } else
      {
        return false;
        }

    } catch (e) {
      print("ErrorName:::::::::::::: $e");
    }

   }

   

   // updateKYC 
  updateKyc(data) async
  {
   try {
      final response = await http.put(
        Uri.parse("http://192.168.2.34:29091/kycApprovals"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(data),
      );

      var dataset = json.decode(response.body);
        
      if (dataset["status"] == "S") 
      {
        return true;
      } else
      {
        return false;
        }

    } catch (e) {
      print("ErrorName:::::::::::::: $e");
    }
  }



  adminSideLoginProfile()
  {
     return _adminProfile;
  }


List? dataUser;



// Get TradeApproval
  getTradeApproval(role)async
  {
try {
      
      final response = await http.get(
        Uri.parse("http://192.168.2.34:29091/getTradeApproval",
        ),
        headers:<String,String>
        {
           "ROLE":role
        }
      );

      var dataset = json.decode(response.body);
     
      if (dataset["status"] == "S") 
      {
        
        dataUser = dataset["resp"];
        return true;
      }else
      {
        return false;
      }

    } catch (e) {
      print("ErrorName:::::::::::::: $e");
    }
  }
  


sendDataUser()
{
  
  return dataUser;
}
  





//------------------ADMIN API END-----------------------------------




}
