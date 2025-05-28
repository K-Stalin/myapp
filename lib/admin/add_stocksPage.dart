
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:myapp/data_provider.dart';


class AddStockspage extends StatefulWidget {
  const AddStockspage({super.key});

  @override
  State<AddStockspage> createState() => _AddStockspageState();
}

class _AddStockspageState extends State<AddStockspage> {
  
    final _formKey = GlobalKey<FormState>();

  TextEditingController stockName = TextEditingController();
  TextEditingController stockPrice = TextEditingController();
  TextEditingController segment = TextEditingController();
  TextEditingController isin = TextEditingController();

  validateRequired(String? value, String errMsg) {
    if (value == null || value.isEmpty) return '$errMsg is required';
    return null;
  }

  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Stock")),

      body: Form(
        key: _formKey,
        child: Container(
          margin: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Bank Name
              Text("Stock Name *"),
              TextFormField(
                controller: stockName,
                validator: (value) => validateRequired(value, 'Stock Name'),
                decoration: InputDecoration(
                  hintText: "e.g Slack",
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
              ),
              SizedBox(height: 10),

              // Bank Name
              Text("Stock Price *"),
              TextFormField(
                controller: stockPrice,
                validator: (value) => validateRequired(value, 'Stock  Price'),
                decoration: InputDecoration(
                  hintText: "e.g 1000",
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
              ),
              SizedBox(height: 10),

              // Bank Name
              Text("segment *"),
              TextFormField(
                controller: segment,
                validator: (value) => validateRequired(value, 'segment'),
                decoration: InputDecoration(
                  hintText: "e.g. NSE",
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
              ),
              SizedBox(height: 10),

              // Bank Name
              Text("isin *"),
              TextFormField(
                controller: isin,
                validator: (value) => validateRequired(value, 'isin'),
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
                        if (await context.read<DataProvider>().addStock({
                          "stock_name": stockName.text,
                          "stock_price":int.parse(stockPrice.text),
                          "segement": segment.text,
                          "isin": isin.text,
                        })) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Bank data added successfully!"),
                              backgroundColor:
                                  Colors.green, // Optional: Change color
                            ),
                          );

                          stockName.text = '';
                          stockPrice.text = '';
                          segment.text = '';
                          isin.text = '';
                        }
                      }
                    });
                  },
                  child: Center(
                    child: Text(
                      "Add Stock",
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