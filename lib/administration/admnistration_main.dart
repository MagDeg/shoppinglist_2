import 'package:flutter/material.dart';
import 'package:shopping_list_2/administration/administration_all_lists.dart';

class AdminMainPage extends StatefulWidget {
  @override
  _AdminMainPageState createState() => _AdminMainPageState();
}

class _AdminMainPageState extends State<AdminMainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Administrator Funktionen'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[Colors.indigo, Colors.indigoAccent],
            ),
          ),
        ),
      ),
      body: Align(
        alignment: Alignment.bottomCenter,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10.0),
              color: Colors.transparent,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.white
                  ),
                child: ListTile(
                title: OutlinedButton(
                        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AdminAllListScreen())),
                        child: Text('Alle bestehenden Listen anzeigen', style: TextStyle(color: Colors.black),)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
