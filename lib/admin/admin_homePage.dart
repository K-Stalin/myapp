import 'package:flutter/material.dart';
import 'package:myapp/admin/add_bankPage.dart';
import 'package:myapp/admin/add_employeePage.dart';
import 'package:myapp/admin/add_stocksPage.dart';
import 'package:myapp/admin/pending_approvalPage.dart';
import 'package:myapp/data_provider.dart';
import 'package:provider/provider.dart';

class AdminHomepage extends StatefulWidget {
  const AdminHomepage({super.key});

  @override
  State<AdminHomepage> createState() => _AdminHomepageState();
}

class _AdminHomepageState extends State<AdminHomepage> {


  @override
  Widget build(BuildContext context) {
    
  var adminProfile = context.watch<DataProvider>().adminSideLoginProfile();
print(adminProfile);

    return Scaffold(
      appBar: AppBar(title: Text("Welcome to Admin Page")),

      drawer: Drawer(
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      
      // Drawer Header (optional)
      DrawerHeader(
          
        decoration: BoxDecoration(
          color: Colors.blue,
        ),
        child: Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.admin_panel_settings,
                color: Colors.white,
                size: 40,
              ),
              SizedBox(height: 10),
              Text(
                'Admin Panel',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),

      // Pending Approvals Button
      _buildDrawerItem(
        context,
        label: "Pending Approvals",
        icon: Icons.pending,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PendingApprovalpage(),
            ),
          );
        },
      ),

      // Add Stocks Button
      _buildDrawerItem(
        context,
        label: "Add Stocks",
        icon: Icons.add_circle_outline,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddStockspage(),
            ),
          );
        },
      ),

      // Add Bank Button
      _buildDrawerItem(
        context,
        label: "Add Bank",
        icon: Icons.account_balance,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddBankpage(),
            ),
          );
        },
      ),

      // Add Employee Button
      _buildDrawerItem(
        context,
        label: "Add Employee",
        icon: Icons.person_add,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddEmployeepage(),
            ),
          );
        },
      ),

   _buildDrawerItem(
        context,
        label: "Logout",
        icon: Icons.logout,
        onTap: () {
          Navigator.pop(context);
          Navigator.pop(context);
        },
      ),


    ],
  ),
),

     body: Container(
  color: Colors.grey[100],
  padding: EdgeInsets.all(16),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [

      // Top Bar
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Admin Dashboard",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          CircleAvatar(
            backgroundColor: Colors.blue,
            child: Icon(Icons.admin_panel_settings, color: Colors.white),
          ),
        ],
      ),
      SizedBox(height: 20),

      // Statistic Cards
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildStatCard("Users", "1,245", Icons.people, Colors.blue),
          _buildStatCard("Orders", "856", Icons.shopping_cart, Colors.green),
          _buildStatCard("Revenue", "\$12.4K", Icons.attach_money, Colors.orange),
        ],
      ),
      SizedBox(height: 20),

      // Table Title
      Text(
        "Recent Orders",
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      SizedBox(height: 10),

      // Simple Table
      Expanded(
        child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: ListView(
            children: [
              _buildTableRow("Order ID", "Customer", "Status", isHeader: true),
              Divider(),
              _buildTableRow("#1234", "John Doe", "Completed"),
              Divider(),
              _buildTableRow("#1235", "Jane Smith", "Pending"),
              Divider(),
              _buildTableRow("#1236", "Alice", "Cancelled"),
            ],
          ),
        ),
      ),
    ],
  ),
)
,




    );
  }
  Widget _buildStatCard(String title, String count, IconData icon, Color color) {
  return Expanded(
    child: Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 30, color: color),
          SizedBox(height: 10),
          Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          SizedBox(height: 5),
          Text(count, style: TextStyle(fontSize: 20, color: color)),
        ],
      ),
    ),
  );
}

Widget _buildTableRow(String id, String customer, String status, {bool isHeader = false}) {
  TextStyle textStyle = TextStyle(
    fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
    fontSize: isHeader ? 16 : 14,
  );

  return Padding(
    padding: EdgeInsets.symmetric(vertical: 8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(id, style: textStyle),
        Text(customer, style: textStyle),
        Text(status, style: textStyle.copyWith(
          color: status == "Completed"
              ? Colors.green
              : status == "Pending"
                  ? Colors.orange
                  : Colors.red,
        )),
      ],
    ),
  );
}

Widget _buildDrawerItem(BuildContext context, {
  required String label,
  required IconData icon,
  required Function onTap,
}) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 5),
    child: ListTile(
      onTap: () => onTap(),
      leading: Icon(icon, color: Colors.blue),
      title: Text(
        label,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
      ),
    ),
  );
}
}
