import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AdminAllListScreen extends StatefulWidget {
  const AdminAllListScreen({Key? key}) : super(key: key);

  @override
  State<AdminAllListScreen> createState() => _AdminAllListScreenState();
}

class _AdminAllListScreenState extends State<AdminAllListScreen> {
  CollectionReference list = FirebaseFirestore.instance.collection('_lists');
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Alle Listen'),
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
      body: StreamBuilder(
          stream: list.snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Column(
                children: [
                  CircularProgressIndicator(),
                  Text('Lädt')
                ],
              );
            }
            return ListView(
              children: snapshot.data!.docs.map((list){
                String listName = list['name'];
                String listPin = list['pin'];

                return Stack(
                  children: [
                    Center(
                      child: Container(
                        padding: EdgeInsets.all(10.0),
                        color: Colors.transparent,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.indigo,
                          ),
                          child: ListTile(
                            title: Row(
                                children: [
                                  Text('Name: $listName'),
                                  SizedBox(width: 40),
                                  Text('Pin: $listPin'),
                                ],
                              ),

                    ),
                        ),
                      ),
                  ),
                ]);

              }).toList(),
            );
          }),
    );
  }
}
