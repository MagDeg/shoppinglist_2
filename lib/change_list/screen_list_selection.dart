import 'package:flutter/material.dart';
import 'package:shopping_list_2/change_list/access_available_list.dart';
import 'package:shopping_list_2/change_list/create_new_list.dart';
import 'package:shopping_list_2/change_list/delete_available_list.dart';
import 'package:shopping_list_2/variables.dart';

import 'access_available_list.dart';


class ScreenListSelection extends StatefulWidget {
  @override
  _ScreenListSelectionState createState() => _ScreenListSelectionState();
}

class _ScreenListSelectionState extends State<ScreenListSelection> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      color: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.lightBlue),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(10.0),
                child: Text('Aktuelle Einkaufsliste', style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w600)),
              ),
              Container(
                padding: EdgeInsets.all(10.0),
                color: Colors.transparent,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: Colors.black26,
                  ),
                  height: 40.0,
                  child: Center(
                    child: Text(
                     pathName, style: TextStyle(fontSize: 20.0, color: Colors.white),
                    )),
                ),
              ),
              Container(
                color: Colors.grey,
                height: 1,
              ),
              TextButton(
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CreateNewListScreen())),
                  child: ListTile(
                    leading: Text('Neue Liste erstellen'),
                    trailing: Icon(Icons.arrow_forward_ios_sharp, size: 25.0),
                    dense: true,
                    visualDensity: VisualDensity(vertical: -4),
                  ),
                ),
              Container(
                color: Colors.grey,
                height: 1,
              ),
              TextButton(
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AccessList())),
                child: ListTile(
                  leading: Text('Auf bestehende Liste zugreifen'),
                  trailing: Icon(Icons.arrow_forward_ios_sharp, size: 25.0),
                  dense: true,
                  visualDensity: VisualDensity(vertical: -4),
                ),
              ),
              Container(
                color: Colors.grey,
                height: 1,
              ),
              TextButton(
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => DeleteList())),
                child: ListTile(
                  leading: Text('Bestehende Liste löschen'),
                  trailing: Icon(Icons.arrow_forward_ios_sharp, size: 25.0),
                  dense: true,
                  visualDensity: VisualDensity(vertical: -4),
                ),
              ),
            ],
          )

      ),
    );
  }
}
