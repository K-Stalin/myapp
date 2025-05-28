import 'package:flutter/material.dart';
import 'package:myapp/data_provider.dart';
import 'package:provider/provider.dart';

class SellPage extends StatefulWidget {
  final Map<String, dynamic> stock;
  final client;

  const SellPage({super.key, required this.stock, required this.client});

  @override
  State<SellPage> createState() => _SellPageState();
}

class _SellPageState extends State<SellPage> {
  final TextEditingController _quantityController = TextEditingController();
  int _quantity = 0;
  List getTrade = [];

  double get _stockPrice => double.tryParse(widget.stock["stock_price"].toString()) ?? 0.0;
  double get _total => _stockPrice * _quantity;

  @override
  void initState() {
    super.initState();
    callData();
  }

  // Fetch data related to the client's trades
  callData() async {
    try {
      var dataSet = await context.read<DataProvider>().getTradeAPI(widget.client[0]["client_id"]);
      setState(() {
        getTrade = dataSet;
      });
    } catch (e) {
      print("Error:::::::::::::::::::::::$e");
    }
  }

  // Function to sell stock
  _sellStock() async {
    
    for (int i = 0; i < getTrade.length; i++) 
    {
      if (getTrade[i]["stock_id"] == widget.stock["stock_id"] && getTrade[i]["trade_type"] == "Buy") 
      {
        if (getTrade[i]["quantity"] < _quantity) 
        {
          print("QTY UP");
          return ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Enter Valid Qty!"),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }

    // Call the API to sell stock
    var res = await context.read<DataProvider>().buyStockAPI({
      "client_id": widget.client[0]["client_id"],
      "trade_type": "Sell",
      "quantity": _quantity,
      "trade_price": double.parse(_total.toStringAsFixed(2)),
      "stock_id": widget.stock["stock_id"],
      "backOfficer_approve": "pending",
      "biller_approve": "pending",
      "approver": "pending",
      "kyc_completed": widget.client[0]["kyc_completed"]
    });

    
    if (res == true) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Stock sold successfully!"),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.of(context).pop();
    } else 
    {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("To buy only, before selling?"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sell Stock'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Stock: ${widget.stock["stock_name"]}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text(
              'Price per share: ₹${widget.stock["stock_price"]}',
              style: const TextStyle(fontSize: 18, color: Colors.grey),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _quantityController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Quantity',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _quantity = int.tryParse(value) ?? 0;
                });
              },
            ),
            const SizedBox(height: 20),
            Text(
              'Total: ₹${_total.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 18),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _quantity > 0
                    ? () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Confirm Sell'),
                            content: Text(
                                'Are you sure you want to sell $_quantity shares of ${widget.stock["stock_name"]} for ₹${_total.toStringAsFixed(2)}?'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  _sellStock();
                                },
                                child: const Text('Confirm'),
                              ),
                            ],
                          ),
                        );
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  'Sell Now',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
