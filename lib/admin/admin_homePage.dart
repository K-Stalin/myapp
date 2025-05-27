import 'package:flutter/material.dart';
import 'package:myapp/admin/add_bankPage.dart';
import 'package:myapp/admin/add_employeePage.dart';
import 'package:myapp/admin/add_stocksPage.dart';
import 'package:myapp/admin/client_approvePage.dart';

class AdminHomepage extends StatefulWidget {
  const AdminHomepage({super.key});

  @override
  State<AdminHomepage> createState() => _AdminHomepageState();
}

class _AdminHomepageState extends State<AdminHomepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Welcome to Admin Page")),

      drawer: Drawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(10),
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ClientApprovepage(),
                    ),
                  );
                },
                child: Text("Client Approve"),
              ),
            ),

            Container(
              padding: EdgeInsets.all(10),
              child: TextButton(onPressed: () {
                 Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddStockspage(),
                    ),
                  );
              }, child: Text("Add Stocks")),
            ),

            Container(
              padding: EdgeInsets.all(10),
              child: TextButton(onPressed: () {
                 Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddBankpage(),
                    ),
                  );
              }, child: Text("Add Bank")),
            ),

            Container(
              padding: EdgeInsets.all(10),
              child: TextButton(onPressed: () {
                 Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddEmployeepage(),
                    ),
                  );
              }, child: Text("Add Employee")),
            ),
          ],
        ),
      ),
    );
  }
}
