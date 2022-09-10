
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shopping_list_2/variables.dart';

import '../add_list_tile.dart';

class BarcodeDbFound extends StatefulWidget {
  const BarcodeDbFound({Key? key}) : super(key: key);

  @override
  State<BarcodeDbFound> createState() => _BarcodeDbFoundState();
}

class _BarcodeDbFoundState extends State<BarcodeDbFound> {
  final nameController = TextEditingController();
  final prodController = TextEditingController();
  final descController = TextEditingController();




  getData() async {
    final dbRep = await FirebaseFirestore.instance.collection('_barcodeDatabase').doc(scanResultGlobal);
    final dbDocGet = await dbRep.get();
      bcName = dbDocGet.data()?['name'];
      bcProd = dbDocGet.data()?['hersteller'];
      bcDesc = dbDocGet.data()?['beschreibung'];
      nameController.text = ' Name: $bcName';
      prodController.text = ' Hersteller: $bcProd';
      descController.text = ' Beschreibung: $bcDesc';
  }

  @override
  Widget build(BuildContext context) {

    getData();

    return AlertDialog(
      content: Form(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.all(4.0),
              color: Colors.transparent,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.0),
                  color: Colors.lightBlueAccent,
                ),
                child: TextField(
                    enabled: false,
                    minLines: null,
                    maxLines: null,
                    controller: nameController,
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
                      enabled: false,
                      minLines: null,
                      maxLines: null,
                      controller: prodController,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent)
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
                      enabled: false,
                      minLines: null,
                      maxLines: null,
                      decoration: InputDecoration(
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
                 ElevatedButton(
                     onPressed: () {
                       Navigator.pop(context);
                       bcOn = true;
                       showDialog<AlertDialog>(
                         context: context,
                         builder: (BuildContext context) {
                           return AddTile();
                         },
                       );


                     },
                     child: Text('Zu Liste hinzufügen'),
                     style: ElevatedButton.styleFrom(
                       primary: Colors.lightBlue
                     ),
                 )
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
