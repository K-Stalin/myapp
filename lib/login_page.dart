import 'package:flutter/material.dart';
import 'package:myapp/admin/admin_homePage.dart';
import 'package:myapp/client/home_page.dart';
import 'package:myapp/data_provider.dart';
import 'package:myapp/user/user_homePage.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

    // var checkIn = context.watch<DataProvider>().getClientProfile();

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

                child:
                 TextButton(
                  onPressed: () {
                    setState(() async {
                      if(_formKey.currentState!.validate()) 
                      {
                        String check = "${loginId.text[0]}${loginId.text[1]}";


                     if(check == "FT")
                     {
                        bool  isLogIN=await context.read<DataProvider>().clientLoginAPI({"client_id":loginId.text, "password":loginPassword.text});
   

                          if(isLogIN)
                          { 
                  Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ClientHomePage()
                          ));
                          }
                          else
                          {
                             wPassOrID= true;
                              
                          }
                      

                     }
                     else if(check=="BO")
                     {

    //  SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.setString('user', '');

var role = "BackOfficer";
              bool isLogIN =await context.read<DataProvider>().adminLoginAPI({
               "user_name":loginId.text,
               "password": loginPassword.text,
               "user":role
});

                          if(isLogIN)
                          { 

                            
                await context.read<DataProvider>().getTradeApproval(role);

    
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:(context) => UserHomepage()
                          ));
                          }
                          else
                          {
                             wPassOrID= true;
                              
                          }
                     }
                     
                     else if(check == "BI")
                     {
                      var isLogIN =await context.read<DataProvider>().adminLoginAPI({"user_name":loginId.text, "password":loginPassword.text,"user":"Biller"});

 
  
                          if(isLogIN)
                          { 
                             print("Hello");
                          }
                          else
                          {
                             wPassOrID= true;
                              
                          }
  Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AdminHomepage()
                          ));
                     }
                     else if(check == "AD")
                     {
                     bool isLogIN =await context.read<DataProvider>().adminLoginAPI({"user_name":loginId.text, "password":loginPassword.text,"user":"Admin"});

                         print(isLogIN);
                          if(isLogIN)
                          { 
                               Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AdminHomepage()
                          ));
                          }
                          else
                          {
                             wPassOrID= true;
                              
                          }

                     }
                     else if(check == "AP")
                     {

                      var isLogIN =await context.read<DataProvider>().adminLoginAPI({"user_name":loginId.text, "password":loginPassword.text,"user":"Approver"});

                          if(isLogIN)
                          { 
                             print("Hello") ;
                          }
                          else
                          {
                             wPassOrID= true;
                              
                          }

                     }
                     else
                     {
                         wPassOrID= true;
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
