import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../auth_page.dart';
import '../main.dart';
import '../variables.dart';

class DeleteList extends StatefulWidget {
  @override
  _DeleteListState createState() => _DeleteListState();
}

class _DeleteListState extends State<DeleteList> {
  final nameController = TextEditingController();
  final pinController = TextEditingController();

  void checkIfListExists() async {

    final docRep = await FirebaseFirestore.instance.collection('_lists').doc(nameController.text + pinController.text);
    final doc = await docRep.get();

    if(doc.exists) {
      showDialog<AlertDialog>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Form(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Sind sie sich wirklich sicher, dass sie diese Liste löschen wollen?'),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.green,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.pop(context);
                            },
                            child: Text('Abbrechen')),
                        SizedBox(width: 50),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.red,
                            ),
                            onPressed: () {
                              FirebaseFirestore.instance.collection('_lists').doc(nameController.text + pinController.text).delete();

                              deleteAllDocs(nameController.text + pinController.text);

                              path = 'none';
                              pathName = 'none';
                              pathPin = '0';
                              pin = '0';
                              name = 'none';

                              ShoppinglistApp().setPrefNew();



                              Navigator.pop(context);
                              Navigator.pop(context);
                              Navigator.pop(context);
                              Navigator.push(context, MaterialPageRoute(builder: (context) => ShoppinglistApp()));
                              print(path);

                              nameController.clear();
                              pinController.clear();

                            },
                            child: Text('Löschen')),
                      ],
                    )
                  ],
                ),
              ),
            );
          });



    } else {
      MessageError.showSnackBar('Diese Liste konnte nicht gefunden werden. Entweder sind Name oder PIN falsch oder die Liste existiert nicht.');

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bestehende Liste löschen'),
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
            Text('Bitte geben sie, um eine bestehende Liste löschen zu können, den Namen und den sechstelligen PIN der Liste an.'),
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
                primary: Colors.red,
              ),
              child: Text('Liste löschen'),
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

void deleteAllDocs(String path) async {
  var collection = FirebaseFirestore.instance.collection(path);
  var snapshots = await collection.get();
  for (var doc in snapshots.docs) {
    await doc.reference.delete();
  }
}
