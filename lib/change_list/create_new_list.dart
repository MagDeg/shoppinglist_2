import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shopping_list_2/auth_page.dart';
import 'package:shopping_list_2/main.dart';
import 'package:shopping_list_2/variables.dart';

class CreateNewListScreen extends StatefulWidget {
  @override
  _CreateNewListScreenState createState() => _CreateNewListScreenState();
}

class _CreateNewListScreenState extends State<CreateNewListScreen> {
  final nameController = TextEditingController();
  final pinController = TextEditingController();
  
  void checkIfListExists() async {

    final docRep = await FirebaseFirestore.instance.collection('_lists').doc(nameController.text + pinController.text);
    final doc = await docRep.get();
    
    if(!doc.exists) {
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

      nameController.clear();
      pinController.clear();
      print('Doc does not exist!');


    } else {
      MessageError.showSnackBar('Diese Liste existiert bereits mit diesem PIN. Bitte versuche es mit einem neuen Namen oder PIN.');
      print('Doc exists!');
    }
  }
  
  
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Neue Liste erstellen'),
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
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Bitte geben sie, zum erstellen einer neuen Liste, einen Namen und ein sechstelligen PIN an.'),
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
                    primary: Colors.indigo
                ),
                child: Text('Auf diese Liste zugreifen'),
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

