import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'variables.dart';

class HomePageString extends StatefulWidget {
  @override
  _HomePageStringState createState() => _HomePageStringState();
}

class _HomePageStringState extends State<HomePageString> {
  late String displayText;

  Future<void> _incrementStartup() async{
    print('increment');
    String? textNow = await _getStringFromSharedPref();
    print(textNow);
    final beforedisplaytext = textNow!;
    displayText =  await beforedisplaytext;
    print('setted');
  }

  Future<String?> _getStringFromSharedPref() async {
    final prefs = await SharedPreferences.getInstance();
    final startupString = prefs.getString('startupString');
    final startupNull = 'DEV1';

    if (startupString == null) {

      return startupNull;
    }

    return startupString;
  }

  Future<void> setPrefNew() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('startupString', 'Morgen');
  }


  @override
  void initState() {
    // final prefs = await SharedPreferences.getInstance();
    _incrementStartup();
    super.initState();
    displayText = 'none';
    print('init Done!');
  }



  @override
  Widget build(BuildContext context) {
    return Container();
      // Scaffold(
      //   body: Center(child: Text(displayText, style: TextStyle(fontSize: 32.0),)),
      //   floatingActionButton: FloatingActionButton(
      //     onPressed: () => setPrefNew(),
      //   ),
      // );
  }
}