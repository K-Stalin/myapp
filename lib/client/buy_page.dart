import 'package:flutter/material.dart';
import 'package:myapp/data_provider.dart';
import 'package:provider/provider.dart';

class BuyPage extends StatefulWidget {
  final Map<String, dynamic> stock;
  final client;
  const BuyPage({super.key, required this.stock, required this.client});

  @override
  State<BuyPage> createState() => _BuyPageState();
}

class _BuyPageState extends State<BuyPage> {
  final TextEditingController _quantityController = TextEditingController();
  int _quantity = 0;
  List getTrade = [];
  
  double get _stockPrice => double.tryParse(widget.stock["stock_price"].toString()) ?? 0.0;
  double get _total => _stockPrice * _quantity;

  @override
  void initState() {
    super.initState();
   
  }

  callData() async 
  {
      try
      {
         var dataSet = await context.read<DataProvider>().getTradeAPI(widget.client[0]["client_id"]);
          getTrade= dataSet;
          
      print(widget.stock);
      }
      catch(e)
      {
          print("Error:::::::::::::::::::::::$e");
      }
  }



    _placeOrder() async {
    var res = await context.read<DataProvider>().buyStockAPI({
      "client_id":widget.client[0]["client_id"],
      "trade_type": "Buy",
      "quantity":_quantity,
      "trade_price": double.parse(_total.toStringAsFixed(2)),
      "stock_id": widget.stock["stock_id"],
      "backOfficer_approve": "pending",
      "biller_approve": "pending",
      "approver": "pending",
      "kyc_completed":widget.client[0]["kyc_completed"]
    });

    print(res);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Order Placed!'),
        backgroundColor: Colors.green,
      ),
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buy Stock'),
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
                          builder: (_) => AlertDialog(
                            title: const Text('Confirm Order'),
                            content: Text(
                                'Buy $_quantity shares of ${widget.stock["stock_name"]} for ₹${_total.toStringAsFixed(2)}?'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () async {
                                  Navigator.of(context).pop();
                                  // Call the async function to place the order
                                  await _placeOrder();
                                },
                                child: const Text('Confirm'),
                              ),
                            ],
                          ),
                        );
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  'Buy Now',
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
