import 'package:flutter/material.dart';
import 'package:myapp/data_provider.dart';
import 'package:provider/provider.dart';



class AddEmployeepage extends StatefulWidget {
  const AddEmployeepage({super.key});

  @override
  State<AddEmployeepage> createState() => _AddEmployeepageState();
}

class _AddEmployeepageState extends State<AddEmployeepage> {
    final _formKey = GlobalKey<FormState>();

  TextEditingController userName = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController role = TextEditingController();
  TextEditingController status = TextEditingController();

  validateRequired(String? value, String errMsg) {
    if (value == null || value.isEmpty) return '$errMsg is required';
    return null;
  }

  
  
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add EMployee")),

      body: Form(
        key: _formKey,
        child: Container(
          margin: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Bank Name
              Text("User Name *"),
              TextFormField(
                controller: userName,
                validator: (value) => validateRequired(value, 'User Name'),
                decoration: InputDecoration(
                  hintText: "e.g. Robert",
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
              ),
              SizedBox(height: 10),

              // Bank Name
              Text("Password *"),
              TextFormField(
                controller: password,
                validator: (value) => validateRequired(value, 'Password'),
                decoration: InputDecoration(
                  hintText: "",
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
              ),
              SizedBox(height: 10),

              // Bank Name
              Text("Role *"),
              TextFormField(
                controller: role,
                validator: (value) => validateRequired(value, 'role'),
                decoration: InputDecoration(
                  hintText: "",
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
              ),
              SizedBox(height: 10),

              // Bank Name
              Text("Status *"),
              TextFormField(
                controller: status,
                validator: (value) => validateRequired(value, 'status'),
                decoration: InputDecoration(
                  hintText: "",
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
              ),
              SizedBox(height: 10),

              // Add Bank
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Color(0XFF613DE4),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextButton(
                  onPressed: () {
                    setState(() async {
                      if (_formKey.currentState!.validate()) {
                        if (await context.read<DataProvider>().addUser({
                          "stock_name": userName.text,
                          "stock_price":password.text,
                          "role": role.text,
                          "status": status.text,
                        })) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Bank data added successfully!"),
                              backgroundColor:
                                  Colors.green, // Optional: Change color
                            ),
                          );

                          userName.text = '';
                          password.text = '';
                          role.text = '';
                          status.text = '';
                        }
                      }
                    });
                  },
                  child: Center(
                    child: Text(
                      "Add Employee",
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