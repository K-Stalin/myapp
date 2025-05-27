import 'package:flutter/material.dart';
import 'package:myapp/data_provider.dart';
import 'package:provider/provider.dart';

class ClientHomePage extends StatefulWidget {
  const ClientHomePage({super.key});

  @override
  State<ClientHomePage> createState() => _ClientHomePageState();
}

class _ClientHomePageState extends State<ClientHomePage> {
  @override
  Widget build(BuildContext context) {
    var dataSet = context.watch<DataProvider>().getClientProfile();

    print(dataSet);
    return Scaffold(
         
         appBar: AppBar(
            title:Text("Wel"),
         ),
        
        drawer: Drawer(
            child: Column(
                
                 children: [

                      Container(
                            child: Image.asset("avatar.png"),   
                      )
                      ,
                      Row(
                         children: [
                           
                       Text("₹0.00"),
                       TextButton(onPressed:(){}, child:Text("+ Add money")),

                         ],
                      ),
                      Text("Orders"),

                      Text("Account details"),

                      Text("Refer")
                     
                 ],
                
            ),
        ),

        

      body: Text("HomePage")
      
      
      
      
      );
  }
}
