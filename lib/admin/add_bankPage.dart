import 'package:flutter/material.dart';
import 'package:myapp/data_provider.dart';
import 'package:provider/provider.dart';

class AddBankpage extends StatefulWidget {
  const AddBankpage({super.key});

  @override
  State<AddBankpage> createState() => _AddBankpageState();
}  

 
 

class _AddBankpageState extends State<AddBankpage> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController bankName = TextEditingController();
  TextEditingController branchName = TextEditingController();
  TextEditingController ifscCode = TextEditingController();
  TextEditingController address = TextEditingController();

  validateRequired(String? value, String errMsg) {
    if (value == null || value.isEmpty) return '$errMsg is required';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Bank")),

      body: Form(
        key: _formKey,
        child: Container(
          margin: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Bank Name
              Text("Bank Name *"),
              TextFormField(
                controller: bankName,
                validator: (value) => validateRequired(value, 'Bank Name'),
                decoration: InputDecoration(
                  hintText: "Canara Bank",
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
              ),
              SizedBox(height: 10),

              // Bank Name
              Text("Branch Name *"),
              TextFormField(
                controller: branchName,
                validator: (value) => validateRequired(value, 'Branch Name'),
                decoration: InputDecoration(
                  hintText: "Rajamadam",
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
              ),
              SizedBox(height: 10),

              // Bank Name
              Text("IFSC Code *"),
              TextFormField(
                controller: ifscCode,
                validator: (value) => validateRequired(value, 'IFSC Code'),
                decoration: InputDecoration(
                  hintText: "e.g. CNRB0005023",
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
              ),
              SizedBox(height: 10),

              // Bank Name
              Text("Address *"),
              TextFormField(
                controller: address,
                validator: (value) => validateRequired(value, 'Address'),
                decoration: InputDecoration(
                  hintText: "Adress",
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
                        if (await context.read<DataProvider>().addBank({
                          "bank_name": bankName.text,
                          "branch_name": branchName.text,
                          "ifsc_code": ifscCode.text,
                          "address": address.text,
                        })) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Bank data added successfully!"),
                              backgroundColor:
                                  Colors.green, // Optional: Change color
                            ),
                          );

                          bankName.text = '';
                          branchName.text = '';
                          ifscCode.text = '';
                          address.text = '';
                        }
                      }
                    });
                  },
                  child: Center(
                    child: Text(
                      "Add Bank",
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
