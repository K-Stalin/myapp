import 'package:flutter/material.dart';
import 'package:myapp/data_provider.dart';
import 'package:myapp/home_page.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(ChangeNotifierProvider(create: (_) => DataProvider(), child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Trade App',
        home:HomePage(),
    );
  }
}
