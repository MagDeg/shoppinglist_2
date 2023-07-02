import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/scheduler.dart';
import 'variables.dart';
import 'language.dart';

const List<String> list = <String>['x', 'g', 'ml'];

bool isDarkMode = true;





class AddTile extends StatefulWidget {
  @override
  _AddTileState createState() => _AddTileState();
}

class _AddTileState extends State<AddTile> {
  final textController = TextEditingController();
  final textAmount = TextEditingController();

  @override


  Widget build(BuildContext context) {
    CollectionReference shoppinglist = FirebaseFirestore.instance.collection(path);

    setState(() {
      var brightness = SchedulerBinding.instance.window.platformBrightness;
      isDarkMode = brightness == Brightness.dark;
    });

    if(bcOn == true) {
      textController.text = bcName + ' ' + bcProd + ' ' + bcDesc;
    }
    return AlertDialog(
      backgroundColor: isDarkMode ? Colors.black38 : Colors.white38,
      content: Form(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              child: Text(
                addHeading,
                style: TextStyle(color: Colors.white),
              ),
            ),
            Container(
              padding: EdgeInsets.all(4.0),
              color: Colors.transparent,
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: categoriesTypeAdd),
                child: TextField(
                  style: TextStyle(color: Colors.white),
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(20.0)),
                      labelText: addProduct,
                      labelStyle: TextStyle(color: Colors.white)),
                  controller: textController,
                ),
              ),
            ),


            Row(
              children: [
                Container(
                  width: 200,
                  padding: EdgeInsets.all(4.0),
                  color: Colors.transparent,
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: categoriesTypeAdd),
                    child: TextField(
                      style: TextStyle(color: Colors.white),
                      cursorColor: Colors.white,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(20.0)),
                          labelText: addAmount,
                          labelStyle: TextStyle(
                              color: Colors.white)),
                      controller: textAmount,
                    ),
                  ),
                ),
                DropdownButtonTypes(),
              ],
            ),
            Container(
              child: Text(
                'Kategorie (optional)',
                style: TextStyle(color: Colors.white),
              ),
            ),
            Center(
              child: Row(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.lightBlue, maximumSize: Size(30.0,30.0), minimumSize: Size(30.0, 30.0)),
                    onPressed: () { setState(() {
                      categories = 'lightBlue';
                      categoriesTypeAdd = Colors.lightBlue;

                    });
                    },
                    child: Container(),
                  ),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.red, maximumSize: Size(30.0,30.0), minimumSize: Size(30.0, 30.0)),
                    onPressed: () { setState(() {
                      categories = 'red';
                      categoriesTypeAdd = Colors.red;
                    });
                    },
                    child: Container(),
                  ),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.green, maximumSize: Size(30.0,30.0), minimumSize: Size(30.0, 30.0)),
                    onPressed: () { setState(() {
                      categories = 'green';
                      categoriesTypeAdd = Colors.green;
                    });
                    },
                    child: Container(),
                  ),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.yellow, maximumSize: Size(30.0,30.0), minimumSize: Size(30.0, 30.0)),
                    onPressed: () { setState(() {
                      categories = 'yellow';
                      categoriesTypeAdd = Colors.yellow;
                    });
                    },
                    child: Container(),
                  ),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.grey, maximumSize: Size(30.0,30.0), minimumSize: Size(30.0, 30.0)),
                    onPressed: () { setState(() {
                      categories = 'grey';
                      categoriesTypeAdd = Colors.grey;
                    });
                    },
                    child: Container(),
                  ),


                ],
              ),
            ),
            Center(
              child: Row(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.purple, maximumSize: Size(30.0,30.0), minimumSize: Size(30.0, 30.0)),
                    onPressed: () { setState(() {
                      categories = 'purple';
                      categoriesTypeAdd = Colors.purple;
                    });
                    },
                    child: Container(),
                  ),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.pink, maximumSize: Size(30.0,30.0), minimumSize: Size(30.0, 30.0)),
                    onPressed: () { setState(() {
                      categories = 'pink';
                      categoriesTypeAdd = Colors.pink;
                    });
                    },
                    child: Container(),
                  ),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.brown, maximumSize: Size(30.0,30.0), minimumSize: Size(30.0, 30.0)),
                    onPressed: () { setState(() {
                      categories = 'brown';
                      categoriesTypeAdd = Colors.brown;

                    });
                    },
                    child: Container(),
                  ),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.deepOrange, maximumSize: Size(30.0,30.0), minimumSize: Size(30.0, 30.0)),
                    onPressed: () { setState(() {
                      categories = 'deepOrange';
                      categoriesTypeAdd = Colors.deepOrange;

                    });
                    },
                    child: Container(),
                  ),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.indigo, maximumSize: Size(30.0,30.0), minimumSize: Size(30.0, 30.0)),
                    onPressed: () { setState(() {
                      categories = 'indigo';
                      categoriesTypeAdd = Colors.indigo;
                    });
                    },
                    child: Container(),
                  ),


                ],
              ),
            ),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                  side: BorderSide(width: 2, color: Colors.blueAccent)),
              onPressed: () {


                if (textAmount.text.isEmpty) {
                  amountControl = false;
                  print(amountControl);
                } else {
                  amountControl = true;
                }

                shoppinglist.add({
                    'name': amountControl ? textAmount.text + amountType + ' ' + textController.text : textController.text,
                    'done': false,
                    'amount': textAmount.text,
                    'rawName': textController.text,
                    'amountType': amountType,
                    'categoriesType': categories,
                  });
                categoriesType = Colors.lightBlue;
                categories = 'lightBlue';
                categoriesTypeAdd = Colors.lightBlue;
                categoriesTypeFirebase = Colors.lightBlue;
                amountType = list.first;
                textController.clear();
                textAmount.clear();
                bcOn = false;
                //amountControl = false;


                Navigator.pop(context);
              },
              child: Text(
                addSave,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class DropdownButtonTypes extends StatefulWidget {
  const DropdownButtonTypes({Key? key}) : super(key: key);

  @override
  State<DropdownButtonTypes> createState() => _DropdownButtonTypesState();
}

class _DropdownButtonTypesState extends State<DropdownButtonTypes> {
  String dropdownvalue = list.first;


  @override
  Widget build(BuildContext context) {



    return DropdownButton(
        value: dropdownvalue,
        onChanged: (String? value) {
          setState(() {
            dropdownvalue = value!;
            amountType = dropdownvalue;
            print(dropdownvalue);
          });
        },
        items: list.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
              value: value,
              child: Text(value, style: TextStyle(color: isDarkMode ?  Colors.white : Colors.black)));
        }).toList()
    );
  }
}
