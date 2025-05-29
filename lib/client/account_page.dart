import 'package:flutter/material.dart';

class AccountPage extends StatefulWidget {
  final Map<String, dynamic> account;

  AccountPage({super.key, required this.account});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    final account = widget.account;

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Account Detail',
            style: TextStyle(
              color: Color(0XFF613DE4),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                ClipOval(
                  child: Image.asset(
                    "assets/avatar.png",
                    height: 70,
                    width: 70,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      account['first_name'] ?? 'Name Not Provided',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    Text(
                      account['email'] ?? 'Email Not Provided',
                      style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 24),

            _buildInfoCard(
              'Bank Account',
              account['bank_account'] ?? 'Not Available',
            ),
            SizedBox(height: 16),

            _buildInfoCard(
              'Balance',
              '₹${account['balance'] ?? '0.00'}',
              isBalance: true,
            ),
            SizedBox(height: 16),

            _buildInfoCard('PAN Card', account['pancard'] ?? 'Not Available'),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(String title, String value, {bool isBalance = false}) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
            Text(
              value,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: isBalance ? Colors.green[800] : Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
