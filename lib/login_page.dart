import 'package:flutter/material.dart';
import 'package:myapp/client/home_page.dart';
import 'package:myapp/data_provider.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController loginId = TextEditingController();
  TextEditingController loginPassword = TextEditingController();
  bool wPassOrID = false;

  validateRequired(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return "$fieldName is required";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    var checkIn = context.watch<DataProvider>().getClientProfile();

    return Scaffold(
      appBar: AppBar(),

      body: Form(
        key: _formKey,
        child: Container(
          margin: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("userID"),
              TextFormField(
                controller: loginId,
                validator: (value) => validateRequired(value, "userID"),
                decoration: InputDecoration(
                  hintText: "FTOOO123",
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Text("Password"),
              TextFormField(
                controller: loginPassword,
                validator: (value) => validateRequired(value, "Password"),
                decoration: InputDecoration(
                  hintText: "Enter your password",
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
              ),
              SizedBox(height: 20),

              wPassOrID
                  ? Text(
                    "Invalid UserID or Password",
                    style: TextStyle(color: Colors.red),
                  )
                  : SizedBox.shrink(),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Color(0XFF613DE4),
                  borderRadius: BorderRadius.circular(8),
                ),

                child: TextButton(
                  onPressed: () {
                    setState(() {
                      if (_formKey.currentState!.validate()) {
                         context.read<DataProvider>().clientLoginAPI({
                          "client_id": loginId.text,
                          "password": loginPassword.text,
                        });

                        if (checkIn == null) 
                        {
                          wPassOrID = true;
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => HomePage()),
                          );
                        }
                      }
                    });
                  },
                  child: Center(
                    child: Text(
                      "Sign In",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
