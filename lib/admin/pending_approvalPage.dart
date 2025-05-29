import 'package:flutter/material.dart';
import 'package:myapp/data_provider.dart';
import 'package:provider/provider.dart';

class PendingApprovalpage extends StatefulWidget {
  const PendingApprovalpage({super.key});

  @override
  State<PendingApprovalpage> createState() => _PendingApprovalpageState();
}

class _PendingApprovalpageState extends State<PendingApprovalpage> {
  List data = [];

  @override
  void initState() 
  {
    super.initState();
    loadClientData();
  }

  loadClientData() async {
    try {
      final dataSet = await context.read<DataProvider>().getClientDataAPI();

      if (dataSet is List) {
        final filteredData =
            dataSet.where((item) {
              return item is Map && item["kyc_completed"] == false;
            }).toList();

        setState(() {
          data = filteredData;
        });
      } else {
        throw Exception("Invalid data format: Expected List");
      }
    } catch (e) {
      print("Error:::::::::::::::::::::::::::::::::::$e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Pending Verification")),

      body: Container(
        margin: EdgeInsets.all(8),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    "Client ID",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    "User Name",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    "Pancard",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    "Status",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),

            SizedBox(height: 8),

            Expanded(
              child: ListView.builder(
                itemCount: data.length,
                itemBuilder: (BuildContext item, int index) {

           if(data[index]["first_name"].toString().isNotEmpty && data[index]["last_name"].toString().isNotEmpty && data[index]["pancard"].toString().isNotEmpty) 
           {   
                  return Container(
                    margin: EdgeInsets.fromLTRB(0, 8, 0, 14),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("📌"),
                              Text("${data[index]["client_id"]}"),
                              Text(data[index]["created_date"].toString().substring(
                                    0,
                                    10,
                                  )),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            "${data[index]["first_name"]} ${data[index]["last_name"]}",
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Row(
                            children: [
                              Text(
                                "Validated",
                                style: TextStyle(color: Colors.blue),
                              ),
                              Icon(
                                Icons.verified,
                                color: Colors.green,
                                size: 16,
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 1,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.orange.shade100,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.orange.shade300),
                            ),
                            child: TextButton(
                              onPressed: () {
                                setState(() async {
                                  var isres = await context
                                      .read<DataProvider>()
                                      .updateKyc({
                                        "client_id": data[index]["client_id"],
                                        "kyc_completed": true,
                                      });

                                  if (isres) {
                                    loadClientData();
                                  }
                                  print("ADMIN:::::::::::::::::::::::::::: $isres");
                                });
                              },
                              child: Text("Pending"),
                            ),
                          ),
                        ),
                        SizedBox(height:20,)
                      ],
                    ),
                  );
                }
                return Container();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
