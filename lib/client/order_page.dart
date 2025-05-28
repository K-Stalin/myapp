import 'package:flutter/material.dart';
import 'package:myapp/data_provider.dart';
import 'package:provider/provider.dart';




class OrderPage extends StatefulWidget {
  
  var clientID;
  
   OrderPage({super.key,required  this.clientID});
  
  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> 
{
  
  List dataSet= [];
  var getStocks;
  void initState()
  {
      super.initState();
      getData();
  }


  getData() async
  {
      try
      { 
          getStocks = await  context.read<DataProvider>().getStocks();
         var res =  await context.read<DataProvider>().getTradeAPI(widget.clientID);
            
    setState(() {
      dataSet = res;
    });
           
      }
      catch(e)
      {
         print("Error::::::::::::::::::::::::$e");
      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
         
     appBar: AppBar(
        title: Text("Order"),
     ),

     body:Container(
       child: Column(
          
        children: [
            

           Expanded(
  child: ListView.builder(
    itemCount: dataSet.length,
    itemBuilder: (context, index) {
      String tradeType = dataSet[index]["trade_type"] ?? ""; 
      Color tradeColor = tradeType.toUpperCase() == "SELL" ? Colors.red : Colors.green;


      return Container(
        margin: EdgeInsets.all(15),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                
                Text(dataSet[index]["trade_date"].toString().substring(0,10) ?? ""),
                Text(
                  tradeType.toUpperCase(),
                  style: TextStyle(color: tradeColor, fontWeight: FontWeight.bold),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
             Text(
              getStocks[0]["resp"].firstWhere((element)=>element["stock_id"]==dataSet[index]["stock_id"] ,orElse:()=>{"stock_name":"unknown"},)["stock_name"]
),
                Row(
                   children: [
                                  Icon(
  Icons.circle,
  size: 5, 
  color:tradeColor,
)
,
SizedBox(width: 5,),
                Text(dataSet[index]["quantity"].toString()),
                   ],
                )

              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(dataSet[index]["order_type"] ?? "Delivery"),
                Text(dataSet[index]["order_price"] ?? "At Market"),
              ],
            ),
            SizedBox(height: 5),
            Container(
              height: 1,
              color: Colors.grey,
            ),
          ],
        ),
      );
    },
  ),
)
 


        


        ],
          
       ),
     ),


    );
  }
}

