import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Listpath extends StatefulWidget {
  @override
  _ListpathState createState() => _ListpathState();
}

class _ListpathState extends State<Listpath> {
  CollectionReference list = FirebaseFirestore.instance.collection('_Listen');





  @override
  Widget build(BuildContext context) {
    return Container();


  }
}


//TODO get a list of documents from collection#
