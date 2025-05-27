import 'package:flutter/material.dart';
import 'package:myapp/data_provider.dart';
import 'package:myapp/login_page.dart';
import 'package:provider/provider.dart';

class UserHomepage extends StatefulWidget {
  const UserHomepage({super.key});

  @override
  State<UserHomepage> createState() => _UserHomepageState();
}


  

class _UserHomepageState extends State<UserHomepage> {
 
 
  List data = []; // Strongly typed list


@override
void initState() {
  super.initState();
  loadClientData();
}

 loadClientData() async {

  try {

    final dataSet = await context.read<DataProvider>().sendDataUser();
      

    setState(() {
      data=dataSet;

    });
   
  } catch (e) {
   
   print("Erro::::::::::::::::::$e");
  }
}
 
 
 
  @override
  Widget build(BuildContext context) {

 
    return Scaffold(
        appBar:AppBar(
          title:Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [
               Container(
                padding: EdgeInsets.all(10),
                child: Text("Role:BackOfficer")),
              Container(
                padding: EdgeInsets.all(10),
                child: TextButton(
                onPressed:()
                {
                
                setState(() 
                {
                  
                Navigator.pop(context);
                Navigator.pop(context);
                });
                
                
                }, child: Text("Logout")),
              )
             ],
          ),
        ),
   


        body: Container(
            margin: EdgeInsets.all(8),
             child: Column(
  children: [
    // Header Row
    Row(
      children: [
        Expanded(
          flex: 2, // Adjust flex values as needed
          child: Text("Client ID",style: TextStyle(fontWeight: FontWeight.bold),),
        ),
        Expanded(
          flex: 2,
          child: Text("BackOfficer",style: TextStyle(fontWeight: FontWeight.bold),),
        ),
        // Expanded(
        //   flex: 2,
        //   child: Text("Biller",style: TextStyle(fontWeight: FontWeight.bold),),
        // ),
        // Expanded(
        //   flex: 2,
        //   child: Text("Approver",style: TextStyle(fontWeight: FontWeight.bold),),
        // ),
      ],
    ),
    
    SizedBox(height: 8), // Add some spacing
    
  

   
Expanded(
  child: ListView.builder(
    itemCount:data.length,
    itemBuilder:(BuildContext item,int index){
  
    print(data[index]["approver"]);
        return     Container(
        margin: EdgeInsets.fromLTRB(0, 8, 0, 8),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Text("${data[index]["client_id"]}"),
            ),
            Expanded(
              flex: 2,
              child: Container(
                 padding: EdgeInsets.symmetric(horizontal:1, vertical:2),
                 decoration: BoxDecoration(
                        color: Colors.orange.shade100,
                        borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.orange.shade300)
                 ),
                child: TextButton(
                  onPressed: ()
                  { 

                     setState(() async {
                     var isres =   await context.read<DataProvider>().updateKyc({
                        "client_id":data[index]["client_id"],
                        "kyc_completed":true
                         });
                         
                         if(isres)
                         {
                        loadClientData();
                         }
                         
                       
                         
                     });
                      
                  },
                  child:Text("${data[index]["approver"]}"),
                ),
              ),
            ),
            SizedBox(width: 5),
            // Expanded(
            //   flex: 2,
            //   child: Container(
            //      padding: EdgeInsets.symmetric(horizontal:1, vertical:2),
            //      decoration: BoxDecoration(
            //             color: Colors.orange.shade100,
            //             borderRadius: BorderRadius.circular(20),
            //   border: Border.all(color: Colors.orange.shade300)
            //      ),
            //     child: TextButton(
            //       onPressed: ()
            //       { 

            //          setState(() async {
            //          var isres =   await context.read<DataProvider>().updateKyc({
            //             "client_id":data[index]["client_id"],
            //             "kyc_completed":true
            //              });
                         
            //              if(isres)
            //              {
            //             loadClientData();
            //              }
                         
                       
                         
            //          });
                      
            //       },
            //       child:Text("${data[index]["approver"]}"),
            //     ),
            //   ),
            // ),
            // SizedBox(width:5),
            // Expanded(
            //   flex: 2,
            //   child: Container(
            //      padding: EdgeInsets.symmetric(horizontal:1, vertical:2),
            //      decoration: BoxDecoration(
            //             color: Colors.orange.shade100,
            //             borderRadius: BorderRadius.circular(20),
            //   border: Border.all(color: Colors.orange.shade300)
            //      ),
            //     child: TextButton(
            //       onPressed: ()
            //       { 

            //          setState(() async {sendDataUser
            //          var isres =   await context.read<DataProvider>().updateKyc({
            //             "client_id":data[index]["client_id"],
            //             "kyc_completed":true
            //              });
                         
            //              if(isres)
            //              {
            //             loadClientData();
            //              }
                         
                       
                         
            //          });
                      
            //       },
            //       child:Text("${data[index]["approver"]}"),
            //     ),
            //   ),
            // ),
            
          ],  
        ),
      );
  

      
  
  }),
)
,
   
  

  ],
),
        ),
    );
  }
}