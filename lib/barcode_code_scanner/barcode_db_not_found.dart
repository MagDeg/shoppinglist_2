import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shopping_list_2/auth_page.dart';
import 'package:shopping_list_2/variables.dart';

import '../add_list_tile.dart';

class BarcodeDbNotFound extends StatefulWidget {
  const BarcodeDbNotFound({Key? key}) : super(key: key);

  @override
  State<BarcodeDbNotFound> createState() => _BarcodeDbNotFoundState();
}

class _BarcodeDbNotFoundState extends State<BarcodeDbNotFound> {
  final nameController = TextEditingController();
  final prodController = TextEditingController();
  final descController = TextEditingController();


  @override
  Widget build(BuildContext context) {


    return AlertDialog(
      content: Form(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Dieses Objekt konnte in der Datenbank nicht gefunden werden. Bitte fügen sie es erst hinzu.'),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(4.0),
              color: Colors.transparent,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.0),
                  color: Colors.lightBlueAccent,
                ),
                child: TextField(
                  enabled: true,
                  minLines: null,
                  maxLines: null,
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    labelStyle: TextStyle(color: Colors.white),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                  ),
                ),
              ),
            ),
            Container(
                padding: EdgeInsets.all(4.0),
                color: Colors.transparent,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.0),
                    color: Colors.lightBlueAccent,
                  ),
                  child: TextField(
                    enabled: true,
                    minLines: null,
                    maxLines: null,
                    controller: prodController,
                    decoration: InputDecoration(
                      labelText: 'Hersteller',
                      labelStyle: TextStyle(color: Colors.white),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                      ),
                    ),
                  ),
                )
            ),
            Container(
                padding: EdgeInsets.all(4.0),
                color: Colors.transparent,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.0),
                    color: Colors.lightBlueAccent,
                  ),
                  child: TextField(
                    enabled: true,
                    minLines: null,
                    maxLines: null,
                    decoration: InputDecoration(
                      labelText: 'Beschreibung',
                      labelStyle: TextStyle(color: Colors.white),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent)
                      ),
                    ),
                    controller: descController,
                  ),
                )
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 110.0,
                  child: ElevatedButton(
                    onPressed: () {
                      FirebaseFirestore.instance.collection('_barcodeDatabase').doc(scanResultGlobal).set({
                        'name' : nameController.text.trim(),
                        'hersteller' : prodController.text.trim(),
                        'beschreibung' : descController.text.trim()});
                      Navigator.pop(context);
                      bcOn = true;
                      bcDesc = descController.text.trim();
                      bcProd = prodController.text.trim();
                      bcName = nameController.text.trim();
                      showDialog<AlertDialog>(
                        context: context,
                        builder: (BuildContext context) {
                          return AddTile();
                        },
                      );


                    },
                    child: Container(child: Text('Hinzufügen & Speichern')),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.lightBlue
                    ),
                  ),
                ),
                SizedBox(width: 30.0),
                Container(
                  width: 110.0,
                  child: ElevatedButton(
                    onPressed: () {
                      FirebaseFirestore.instance.collection('_barcodeDatabase').doc(scanResultGlobal).set({
                        'name' : nameController.text.trim(),
                        'hersteller' : prodController.text.trim(),
                        'beschreibung' : descController.text.trim()});
                        Navigator.pop(context);

                      },
                    child: Container(child: Text('Speichern')),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.lightBlue
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
  @override
  void dispose() {
    nameController.clear();
    prodController.clear();
    descController.clear();
    super.dispose();
  }

}
