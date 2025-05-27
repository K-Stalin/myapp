import 'package:flutter/material.dart';

class AddEmployeepage extends StatefulWidget {
  const AddEmployeepage({super.key});

  @override
  State<AddEmployeepage> createState() => _AddEmployeepageState();
}

class _AddEmployeepageState extends State<AddEmployeepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("Add Employee"),
        ),
    );
  }
}