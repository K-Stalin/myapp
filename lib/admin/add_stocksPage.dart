import 'package:flutter/material.dart';

class AddStockspage extends StatefulWidget {
  const AddStockspage({super.key});

  @override
  State<AddStockspage> createState() => _AddStockspageState();
}

class _AddStockspageState extends State<AddStockspage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("Add Stocks"),
        ),
    );
  }
}