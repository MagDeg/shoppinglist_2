import 'package:flutter/material.dart';
import 'package:shopping_list_2/variables.dart';

class InfoSettingScreen extends StatefulWidget {
  const InfoSettingScreen({Key? key}) : super(key: key);

  @override
  State<InfoSettingScreen> createState() => _InfoSettingScreenState();
}

class _InfoSettingScreenState extends State<InfoSettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        padding: EdgeInsets.all(10.0),
        color: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[Colors.indigo, Colors.indigoAccent],
              )
          ),
          height: 140,
          child: Align(
            alignment: Alignment.center,
            child: Column(
              children: [
                Container(padding: EdgeInsets.all(10.0), child: Text('Info', style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w600))),
                Container(
                  color: Colors.grey,
                  height: 1,
                ),
                TextButton(
                  onPressed: () {},
                  child: ListTile(
                    leading: Text('Kontakt: dev.md.public@gmail.com'),
                    dense: true,
                    visualDensity: VisualDensity(vertical: -4),
                  ),
                ),
                Container(
                  color: Colors.grey,
                  height: 1,
                ),
                TextButton(
                  onPressed: () {},
                  child: ListTile(
                    leading: Text('Version: $version'),
                    dense: true,
                    visualDensity: VisualDensity(vertical: -4),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
