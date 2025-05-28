import 'package:flutter/material.dart';
import 'package:myapp/data_provider.dart';
import 'package:provider/provider.dart';

class ShownPage extends StatefulWidget {
  const ShownPage({super.key});

  @override
  State<ShownPage> createState() => _ShownPageState();
}

class _ShownPageState extends State<ShownPage> {
  @override
  Widget build(BuildContext context) {
    final cliendID = context.watch<DataProvider>().getClientID();
    print(cliendID);

    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            Container(child: Image.asset("MegaCheck.png")),
            SizedBox(height: 100),
            Text(
              "Your account has been",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
            Text(
              "successfully created!",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
            Text("Your UserID:"),

            cliendID == null
                ? Text("Generating...")
                : Text(cliendID, style: TextStyle(fontWeight: FontWeight.bold)),

            Text("(Please copy it for login)"),
            SizedBox(height: 40),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Color(0XFF613DE4),
                borderRadius: BorderRadius.circular(8),
              ),

              child: TextButton(
                onPressed: () {
                  
                  setState(() {
                    
                     Navigator.pop(context);
                     Navigator.pop(context);
                  });
                },
                child: Center(
                  child: Text(
                    "Get Started",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
