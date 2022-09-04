import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(home: FirestoreApp()));
}

class FirestoreApp extends StatefulWidget {
  @override
  _FirestoreAppState createState() => _FirestoreAppState();
}

class _FirestoreAppState extends State<FirestoreApp> {
  final textController = TextEditingController();




  @override
  Widget build(BuildContext context) {
    CollectionReference shoppinglist = FirebaseFirestore.instance.collection('shoppinglist');

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: TextField(
            controller: textController,
          ),
        ),
        body: Center(
          child: StreamBuilder(
              stream: shoppinglist.orderBy('name').snapshots(),//FirebaseFirestore.instance.collection('shoppinglist').snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: Text('Loading'),);
                }
                return ListView(
                    children: snapshot.data!.docs.map((shoppinglist) {
                      return Center(
                        child: ListTile(
                          title: Text(shoppinglist['name']),
                          onLongPress: () {
                            shoppinglist.reference.delete();
                          },
                        ),
                      );
                    }).toList()
                );
              }
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.save),
          onPressed: () {
            shoppinglist.add({'name': textController.text,});
            textController.clear();
          },
        ),
      ),
    );
  }
}
