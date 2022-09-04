import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../auth_page.dart';
import '../main.dart';
import '../variables.dart';

class AccessList extends StatefulWidget {
  @override
  _AccessListState createState() => _AccessListState();
}

class _AccessListState extends State<AccessList> {
  final nameController = TextEditingController();
  final pinController = TextEditingController();

  void checkIfListExists() async {

    final docRep = await FirebaseFirestore.instance.collection('_lists').doc(nameController.text + pinController.text);
    final doc = await docRep.get();

    if(doc.exists) {
      FirebaseFirestore.instance.collection('_lists').doc(nameController.text + pinController.text).set({'name': nameController.text, 'pin': pinController.text});

      path = nameController.text + pinController.text;
      pathName = nameController.text;
      pathPin = pinController.text;
      name = nameController.text;
      pin = pinController.text;
      ShoppinglistApp().setPrefNew();



      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.push(context, MaterialPageRoute(builder: (context) => ShoppinglistApp()));
      /// Reload single Page
      /// Navigator.pushReplacement(
      ///     context,
      ///     MaterialPageRoute(
      ///         builder: (BuildContext context) => this.widget));
      nameController.clear();
      pinController.clear();


    } else {
      MessageError.showSnackBar('Diese Liste konnte nicht gefunden werden. Entweder sind Name oder PIN falsch oder die Liste existiert nicht.');

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Auf bestehende Liste zugreifen'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[Colors.blueAccent, Colors.lightBlue],
            ),
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Bitte geben sie, um auf eine bestehende Liste zugreifen zu können, den Namen und den sechstelligen PIN der Liste an.'),
            SizedBox(height: 20),
            TextFormField(
              controller: nameController,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextFormField(
              controller: pinController,
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(labelText: 'PIN'),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              maxLength: 6,
              keyboardType: TextInputType.number,
              obscureText: true,
              validator: (value) =>
              value != null && value.length < 6
                  ? 'Bitte gib 6 Zahlen ein!'
                  : null,
            ),
            SizedBox(height: 40),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size.fromHeight(40),
              ),
              child: Text('Auf Liste zugreifen'),
              onPressed: () {
                checkIfListExists();

              },
            )
          ],
        ),
      ),
    );
  }
}
