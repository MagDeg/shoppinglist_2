import 'package:flutter/material.dart';
import 'package:shopping_list_2/administration/admnistration_main.dart';
import 'package:shopping_list_2/change_list/screen_list_selection.dart';
import 'package:shopping_list_2/give_feedback/screen_give_feedback.dart';
import 'package:shopping_list_2/show_changes.dart';
import 'package:shopping_list_2/variables.dart';
import 'account_page.dart';
import 'administration/administration_auth.dart';

class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text('Einstellungen'),
        actions: [
          IconButton(
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AccountPage())),
              icon: Icon(Icons.account_circle_rounded, size: 35))
        ],
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
      body: ListView(
        children: [
          Column(
            children: [
              ScreenListSelection(),
              FeedbackSettingScreen(),
              ShowChanges(),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: GestureDetector(
              onDoubleTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AdminAuth())),
              child: Container(
                  child: Text(
                'created by Magnus Degwerth, $version',
                style: TextStyle(color: Colors.black45),
              ),

              ),
            ),
          )
        ],
      ),
    );
  }
}
