import 'package:flutter/material.dart';
import 'package:myapp/client/account_page.dart';
import 'package:myapp/client/buy_page.dart';
import 'package:myapp/client/order_page.dart';
import 'package:myapp/client/refer_page.dart';
import 'package:myapp/client/sell_page.dart';
import 'package:myapp/data_provider.dart';
import 'package:provider/provider.dart';

class ClientHomePage extends StatefulWidget {
  const ClientHomePage({super.key});

  @override
  State<ClientHomePage> createState() => _ClientHomePageState();
}

class _ClientHomePageState extends State<ClientHomePage> {
  List LogedUserProfile = [];
  List stockDataSet = [];
  bool isKycVerified = false;
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    loadClientData();
  }

  loadClientData() async {
    try {
      final dataSet = await context.read<DataProvider>().getClientProfile();
      final stockData = await context.read<DataProvider>().getStocks();

      setState(() {
        LogedUserProfile = [dataSet];
        stockDataSet = stockData[0]["resp"];
        isKycVerified = LogedUserProfile[0]["kyc_completed"];
        isLoading = false;
      });
    } catch (e) {
      print("Error:::::::::::::::::::::$e");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            '📉Groww📈',
            style: TextStyle(
              color: Color(0XFF613DE4),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.blue.shade600,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(60),
                  bottomRight: Radius.circular(60),
                ),
              ),
              padding: EdgeInsets.all(20),
              child: Row(
                children: [
                  ClipOval(
                    child: Image.asset(
                      "assets/avatar.png",
                      height: 70,
                      width: 70,
                      fit: BoxFit.cover,
                    ),
                  ),

                  SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "ClientID:",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "${LogedUserProfile[0]["client_id"]}",
                            style: TextStyle(color: Colors.black, fontSize: 20),
                          ),
                        ],
                      ),
                      Text(
                        "${LogedUserProfile[0]["first_name"]} ${LogedUserProfile[0]["last_name"]}",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            "KYC Status: ${isKycVerified ? "✅" : "❌"}",
                            style: TextStyle(
                              color: isKycVerified ? Colors.green : Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Text(
                        "${LogedUserProfile[0]["email"]}",
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "₹ ${LogedUserProfile[0]["balance"]}",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "+ Add money",
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ],
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  _DrawerMenuItem("Orders", Icons.shopping_cart, () async {
                    var userID = await LogedUserProfile[0]["client_id"];
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OrderPage(clientID: userID),
                      ),
                    );
                  }),
                  _DrawerMenuItem("Account details", Icons.account_circle, () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) =>
                                AccountPage(account: LogedUserProfile[0]),
                      ),
                    );
                  }),
                  _DrawerMenuItem("Refer", Icons.share, () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ReferPage()),
                    );
                  }),
                  _DrawerMenuItem("Logout", Icons.logout, () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
      body:
          stockDataSet.isEmpty
              ? Center(child: Text("No stocks available"))
              : Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView.builder(
                  itemCount: stockDataSet.length,
                  itemBuilder: (item, index) {
                    if (stockDataSet[index]["isin"].toString().isNotEmpty &&
                        stockDataSet[index]["stock_name"]
                            .toString()
                            .isNotEmpty &&
                        stockDataSet[index]["stock_price"]
                            .toString()
                            .isNotEmpty) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      stockDataSet[index]["stock_name"],
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Chip(
                                      label: Text(
                                        "NSE",
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Text(
                                  "Stock ID: ${stockDataSet[index]["stock_id"]}",
                                  style: TextStyle(color: Colors.grey),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  "ISIN: ${stockDataSet[index]["isin"]}",
                                  style: TextStyle(color: Colors.grey),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  "Price: ₹${stockDataSet[index]["stock_price"]}",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green,
                                  ),
                                ),
                                SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          if (isKycVerified) {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder:
                                                    (context) => BuyPage(
                                                      stock:
                                                          stockDataSet[index],
                                                      client: LogedUserProfile,
                                                    ),
                                              ),
                                            );
                                          } else {
                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  "KYC failed. Please Verify That.",
                                                ),
                                              ),
                                            );
                                          }
                                        });
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.green,
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 30,
                                          vertical: 12,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                        ),
                                      ),
                                      child: Text(
                                        "Buy",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder:
                                                  (context) => SellPage(
                                                    stock: stockDataSet[index],
                                                    client: LogedUserProfile,
                                                  ),
                                            ),
                                          );
                                        });
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.red,
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 30,
                                          vertical: 12,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                        ),
                                      ),
                                      child: Text(
                                        "Sell",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                    return Container();
                  },
                ),
              ),
    );
  }

  Widget _DrawerMenuItem(String title, IconData icon, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue.shade600),
      title: Text(title, style: TextStyle(fontSize: 16)),
      onTap: onTap,
    );
  }
}
