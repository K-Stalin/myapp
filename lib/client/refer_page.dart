import 'package:flutter/material.dart';

class ReferPage extends StatefulWidget 
{
  const ReferPage({super.key});

  @override
  State<ReferPage> createState() => _ReferPageState();
}

class _ReferPageState extends State<ReferPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Refer Page',style:TextStyle(color: Color(0XFF613DE4),fontWeight: FontWeight.bold))),
        elevation: 4,
      ),
      backgroundColor: Colors.purple[50],
      body: Center(

        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              
              ClipRRect(
                borderRadius: BorderRadius.circular(16.0), 
                child: Image.network(
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQVzSwft4XrVOIPoB953xclZsc0vEkrVyeXeQ&s",
                  fit: BoxFit.cover,
                  width: 300,
                  height: 200
                ),
              ),
              SizedBox(height: 20), 
              Text(
                'Welcome to the Refer Page!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurpleAccent,
                ),
              ),
              SizedBox(height: 10),

              Text(
                'Share and refer friends to earn rewards and benefits. Stay tuned for exciting offers!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700],
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
