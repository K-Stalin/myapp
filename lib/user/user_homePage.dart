import 'package:flutter/material.dart';
import 'package:myapp/data_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserHomepage extends StatefulWidget {
  const UserHomepage({super.key});

  @override
  State<UserHomepage> createState() => _UserHomepageState();
}

class _UserHomepageState extends State<UserHomepage> {
  List data = [];
  String? userRole;

  @override
  void initState() {
    super.initState();
    loadClientData();
    loadRole();
  }

  loadClientData() async {
    try {
      final dataSet = await context.read<DataProvider>().sendDataUser();
      setState(() {
        data = dataSet;
      });
    } catch (e) {
      print("Error: $e");
    }
  }

  void loadRole() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userRole = prefs.getString('user') ?? 'Unknown';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Welcome to User Page",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFE64A19),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.clear();
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: Text(
                "Logout",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),

      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Row
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    "Client ID",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    "Role: ${userRole ?? ''}",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),

            // Data List
            Expanded(
              child: ListView.builder(
                itemCount: data.length,
                itemBuilder: (BuildContext context, int index) {

      if(
        data[index]["client_id"].toString().isNotEmpty 
        &&
        data[index]["tradeClient"]["first_name"].toString().isNotEmpty
         &&
        data[index]["tradeStocks"]["stock_name"].toString().isNotEmpty
      ){            
                  return Card(
                    elevation: 5,
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                    child: Padding(
                      padding: EdgeInsets.all(12),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "ClientID: ",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      "${data[index]["client_id"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "UserName: ",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      "${data[index]["tradeClient"]["first_name"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "${data[index]["tradeStocks"]["stock_name"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "${data[index]["trade_type"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color:
                                            data[index]["trade_type"] == "Buy"
                                                ? Colors.green
                                                : Colors.red,
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Icon(
                                      Icons.circle,
                                      size: 5,
                                      color:
                                          data[index]["trade_type"] == "Buy"
                                              ? Colors.green
                                              : Colors.red,
                                    ),
                                    SizedBox(width: 3),
                                    Text(
                                      "${data[index]["quantity"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color:
                                            data[index]["trade_type"] == "Buy"
                                                ? Colors.green
                                                : Colors.red,
                                      ),
                                    ),
                                    
                                  ],
                                ),
                                Text(
                            data[index]["trade_date"].toString().substring(
                                    0,
                                    10,
                                  ),
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color:Colors.black
                                      ),
                                    )
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFF00796B),
                                foregroundColor: Colors.white,
                                padding: EdgeInsets.symmetric(vertical: 8),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              onPressed: () {
                                setState(() async {
                                  var isRes = await context
                                      .read<DataProvider>()
                                      .userApproval({
                                        "user": userRole,
                                        "trade_id": data[index]["trade_id"],
                                        "approval": "Approved",
                                      });

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        isRes
                                            ? "Approval successful!"
                                            : "Approval failed. Please try again.",
                                      ),
                                      backgroundColor:
                                          isRes ? Colors.green : Colors.red,
                                    ),
                                  );

                                  if (isRes) {
                                    SharedPreferences prefs =
                                        await SharedPreferences.getInstance();
                                    var role = await prefs.getString('user');
                                    await context
                                        .read<DataProvider>()
                                        .getTradeApproval(role);
                                    loadClientData();
                                  }
                                });
                              },
                              child: Text(
                                "Approve",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );

                }
                return Container();

                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}