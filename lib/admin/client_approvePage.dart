import 'package:flutter/material.dart';

class ClientApprovepage extends StatefulWidget {
  const ClientApprovepage({super.key});

  @override
  State<ClientApprovepage> createState() => _ClientApprovepageState();
}

class _ClientApprovepageState extends State<ClientApprovepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("Client Approve"),
        ),
    );
  }
}