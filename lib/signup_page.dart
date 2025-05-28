import 'package:flutter/material.dart';
import 'package:myapp/client/shown_page.dart';
import 'package:myapp/data_provider.dart';
import 'package:provider/provider.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  
  final _formKey = GlobalKey<FormState>();

  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController panCard = TextEditingController();
  TextEditingController nomineeName = TextEditingController();
  TextEditingController bankAccount = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController balance = TextEditingController();

  var bankData;
  String? selectedBankId;
  String? selectedIFSCcode;
  bool isToggelIFSC = false;

  @override
  void initState() {
    super.initState();
    dataCall();
  }

  dataCall() async {
    try {
      final value = await context.read<DataProvider>().bankNameProviderAPI();
      setState(() {
        bankData = value[0]["resp"];
      });
    } catch (e) {
      print('Error in SignUp Page: $e');
    }
  }

  String? validateRequired(String? value, String fieldName) 
  {
    if (value == null || value.isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'Email is required';
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone is required';
    }
    if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
      return 'Enter a valid 10-digit phone number';
    }
    return null;
  }

  String? validatePanCard(String? value) {
    if (value == null || value.isEmpty) {
      return 'PAN Card is required';
    }
    if (!RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]{1}$').hasMatch(value)) {
      return 'Enter a valid PAN Card (e.g., ABCDE1234F)';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Password is required';
    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      
      body: Form(
        key: _formKey,
        child: Container(
          margin: EdgeInsets.all(10),
          child: ListView(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // First Name
                  Text("First Name *"),
                  TextFormField(
                    controller: firstName,
                    validator: (value) => validateRequired(value, 'First Name'),
                    decoration: InputDecoration(
                      hintText: "Enter your first name",
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),

                  // Last Name
                  Text("Last Name *"),
                  TextFormField(
                    controller: lastName,
                    validator: (value) => validateRequired(value, 'Last Name'),
                    decoration: InputDecoration(
                      hintText: "Enter your last name",
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),

                  // Email
                  Text("Email *"),
                  TextFormField(
                    controller: email,
                    validator: validateEmail,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: "Enter your email",
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),

                  // Phone
                  Text("Phone *"),
                  TextFormField(
                    controller: phone,
                    validator: validatePhone,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      hintText: "Enter your phone number",
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),

                  // PAN Card
                  Text("PAN Card *"),
                  TextFormField(
                    controller: panCard,
                    validator: validatePanCard,
                    decoration: InputDecoration(
                      hintText: "Enter your PAN Card",
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),

                  // Nominee Name
                  Text("Nominee Name"),
                  TextFormField(
                    controller: nomineeName,
                    decoration: InputDecoration(
                      hintText: "Enter nominee name",
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),

                  // Bank Name
                  Text("Bank Name *"),
                  Container(
                    width: double.infinity,
                    child: DropdownButtonFormField<String>(
                      value: selectedBankId,
                      hint: Text("Select Bank"),
                      icon: Icon(Icons.arrow_drop_down_circle_sharp),
                      items:
                          bankData?.map<DropdownMenuItem<String>>((bank) {
                            return DropdownMenuItem<String>(
                              value: bank['bank_id'].toString(),
                              child: Text(bank['bank_name']),
                            );
                          }).toList(),
                      validator:
                          (value) => value == null ? 'Bank is required' : null,
                      onChanged: (String? newValue) {
                        setState(() 
                        {
                          selectedBankId = newValue;
                          for (int i = 0; i < bankData.length; i++) 
                          {
                            if (bankData[i]["bank_id"].toString() ==
                                selectedBankId.toString()) 
                            {
                              selectedIFSCcode = bankData[i]["ifsc_code"];
                              print(selectedIFSCcode);
                            }
                          }

                          isToggelIFSC = true;
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 10),

                  // Bank Account
                  Text("Bank Account *"),
                  TextFormField(
                    controller: bankAccount,
                    validator:
                        (value) => validateRequired(value, 'Bank Account'),
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: "Enter your bank account number",
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),

                  // IFSC Code
                  if (isToggelIFSC)
                  Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Text("Bank IFSC Code"),
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween, 
      children: [
        Expanded(
          child: TextFormField(
            readOnly: true,
            initialValue: selectedIFSCcode,
          ),
        ),
        SizedBox(width: 8), 
        CircleAvatar(
          radius: 16, 
          backgroundColor: Colors.green,
          child: Icon(
            Icons.check,
            color: Colors.white,
            size: 16, // Adjust size of the check icon
          ),
        ),
      ],
    ),
    SizedBox(height: 10),
  ],
),


                  // Password
                  Text("Password *"),
                  TextFormField(
                    controller: password,
                    validator: validatePassword,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: "Enter your password",
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),

                  // Balance
                  Text("Balance *"),
                  TextFormField(
                    controller: balance,
                    validator: (value) => validateRequired(value, 'Balance'),
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: "Enter initial balance",
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),

                  // Sign Up Button
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
                            context.read<DataProvider>().clientRegisterAPI({
                              "first_name": firstName.text,
                              "last_name": lastName.text,
                              "email": email.text,
                              "phone_number": phone.text,
                              "pancard": panCard.text,
                              "nominee_name": nomineeName.text,
                              "bank_id": int.parse(selectedBankId.toString()),
                              "bank_account": bankAccount.text,
                              "password": password.text,
                              'balance': balance.text,
                            });
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ShownPage(),
                              ),
                            );
                          }
                        });
                      },
                      child: Center(
                        child: Text(
                          "Sign Up",
                          style: TextStyle(color: Colors.white),
                        ),
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
}
