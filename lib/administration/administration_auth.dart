import 'package:flutter/material.dart';
import 'package:shopping_list_2/administration/admnistration_main.dart';
import 'package:shopping_list_2/auth_page.dart';

class AdminAuth extends StatefulWidget {
  const AdminAuth({Key? key}) : super(key: key);

  @override
  State<AdminAuth> createState() => _AdminAuthState();
}

class _AdminAuthState extends State<AdminAuth> {
  String pin = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Administrator Passwort'),
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
      body: Center(
        child: Container(
          padding: EdgeInsets.all(10.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Um auf die Administrator Funktionen zurückgreifen zu können, müssen sie einen 6-stelligen PIN eingeben.'),
              TextField(
                obscureText: true,
                keyboardType: TextInputType.number,
                maxLength: 6,
                onChanged: (value) {
                  pin = value;

                },
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.indigo,
                  ),
                  onPressed: () {
                    if(pin == '654321') {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => AdminMainPage()));
                    } else {
                      MessageError.showSnackBar('Der eingegebene PIN ist falsch!');
                    }
                  },
                  child: Text('Fertig'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
