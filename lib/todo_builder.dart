import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopping_list_2/variables.dart';
import 'account_page.dart';

class ToDoBuilder extends StatefulWidget {
  @override
  _ToDoBuilderState createState() => _ToDoBuilderState();
}

class _ToDoBuilderState extends State<ToDoBuilder> {
  CollectionReference shoppinglist =
      FirebaseFirestore.instance.collection(path);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Liste - ' + pathName),
        actions: [
          IconButton(
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AccountPage())),
              icon: Icon(Icons.account_circle_rounded, size: 35,))
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
      body: StreamBuilder(
          stream: shoppinglist.orderBy('name').snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: Column(
                  children: [
                    CircularProgressIndicator(),
                  ],
                ),
              );
            }


            return ListView(
                children: snapshot.data!.docs.map((shoppinglist) {
              bool done = shoppinglist['done'];
              bool notdone = !done;

              String amount = shoppinglist['amount'];
              categories = shoppinglist['categoriesType'];
              categoryType();
              categories = 'lightBlue';

              return Stack(
                children: [
                  Center(
                    child: Container(
                      padding: EdgeInsets.all(10.0),
                      color: Colors.transparent,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: categoriesTypeFirebase,
                        ),
                        child: ListTile(
                          leading: Checkbox(
                            value: done,
                            onChanged: (done) {
                              shoppinglist.reference.update({'done': notdone});
                            },
                            activeColor: Colors.grey,
                          ),
                          title: Text(
                            shoppinglist['name'],
                            style: TextStyle(
                                color: done ? Colors.black45 : Colors.white,
                                fontSize: 20.0,
                                decoration: done
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none),
                          ),

                          // trailing: IconButton(
                          //   icon: Icon(
                          //     Icons.delete,
                          //     size: 30.0,
                          //   ),
                          //   onPressed: () => shoppinglist.reference.delete(),
                          // ),
                          onLongPress: () => shoppinglist.reference.delete(),
                          onTap: () {
                            showDialog<AlertDialog>(
                                context: context,
                                builder: (BuildContext context) {

                                  final amountController =
                                      TextEditingController();

                                  rawName = shoppinglist['rawName'];
                                  amountRefactor = shoppinglist['amount'];
                                  amountControl = shoppinglist['amountController'];

                                  amountTypeG = shoppinglist['amountTypeG'];
                                  amountTypeMl = shoppinglist['amountTypeMl'];
                                  amountTypeSt = shoppinglist['amountTypeSt'];

                                  // String item = '';
                                  String newAmount = '';

                                  categories = shoppinglist['categoriesType'];
                                  categoryType();


                                  return AlertDialog(
                                    backgroundColor: Colors.black38,
                                    content: Form(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          ChangeTile(),
                                          OutlinedButton(
                                            style: OutlinedButton.styleFrom(
                                                side: BorderSide(
                                                    width: 2,
                                                    color: Colors.blueAccent)),
                                            onPressed: () {
                                              newAmount = newAmount1;

                                              if (item.isEmpty) {item = shoppinglist['rawName'];}
                                              if (newAmount.isEmpty) {newAmount = shoppinglist['amount'];}
                                              shoppinglist.reference.update({'name': amountControl ? newAmount + amountType + ' ' + item : item});
                                              shoppinglist.reference.update({'amount': newAmount});
                                              shoppinglist.reference.update({'rawName': item});
                                              shoppinglist.reference.update({'amountController': amountControl});
                                              shoppinglist.reference.update({'amountTypeG': amountTypeG});
                                              shoppinglist.reference.update({'amountTypeMl': amountTypeMl});
                                              shoppinglist.reference.update({'amountTypeSt': amountTypeSt});
                                              shoppinglist.reference.update({'amountType': amountType});
                                              shoppinglist.reference.update({'categoriesType': categories});

                                              ChangeTile().textController1.clear();
                                              amountController.clear();
                                              amountType = '';
                                              categories = 'lightBlue';
                                              item = '';
                                              categoriesTypeFirebase = Colors.lightBlue;
                                              categoriesTypeAdd = Colors.lightBlue;
                                              categoriesType = Colors.lightBlue;
                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                              'Fertig!',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }
                                );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }).toList());
          }),
    );
  }
}

class AmountControllerRefactor extends StatefulWidget {
  final amountController1 = TextEditingController();

  @override
  _AmountControllerRefactorState createState() =>
      _AmountControllerRefactorState();
}

class _AmountControllerRefactorState extends State<AmountControllerRefactor> {
  @override
  Widget build(BuildContext context) {
    final amountController = AmountControllerRefactor().amountController1;
    amountController.text = amountRefactor;

    return Column(
      children: [
        Row(children: [
          Checkbox(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(2.0)),
            side: MaterialStateBorderSide.resolveWith(
                    (states) => BorderSide(width: 1.0, color: Colors.grey)),
            value: amountControl,
            onChanged: (value) {
              setState(() {
                amountControl = value!;
              });
            },
          ),
          Container(
            child: Text(
              'Mengenangabe (optional)',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ]),
        Container(
          padding: EdgeInsets.all(4.0),
          color: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: amountControl ? categoriesType : Colors.black38),
            child: TextField(
              enabled: amountControl,
              style:
                  TextStyle(color: amountControl ? Colors.white : Colors.grey),
              cursorColor: Colors.white,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(20.0)),
                  labelText: 'Neue Menge',
                  labelStyle: TextStyle(
                      color: amountControl ? Colors.white : Colors.grey)),
              onChanged: (String text) {
                newAmount1 = text;
              },
              controller: amountController,
            ),
          ),
        ),
        Row(
          children: [
            Checkbox(
              value: amountTypeG,
              onChanged: (value) {
                setState(
                  () {
                    if (amountTypeMl == false && amountTypeSt == false && amountControl == true) {
                      amountTypeG = value!;
                      amountType = 'g';
                    }
                  },
                );
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(2.0)),
              side: MaterialStateBorderSide.resolveWith((states) => BorderSide(
                  width: 1.0,
                  color: amountControl ? Colors.grey : Colors.black)),
            ),
            Text(
              'g',
              style:
                  TextStyle(color: amountControl ? Colors.white : Colors.grey),
            ),
            Checkbox(
              value: amountTypeMl,
              onChanged: (value) {
                setState(() {
                  if (amountTypeG == false && amountTypeSt == false && amountControl == true) {
                    amountTypeMl = value!;
                    amountType = 'ml';
                  }
                });
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(2.0)),
              side: MaterialStateBorderSide.resolveWith((states) => BorderSide(
                  width: 1.0,
                  color: amountControl ? Colors.grey : Colors.black)),
            ),
            Text(
              'ml',
              style:
                  TextStyle(color: amountControl ? Colors.white : Colors.grey),
            ),
            Checkbox(
              value: amountTypeSt,
              onChanged: (value) {
                setState(() {
                  if (amountTypeG == false && amountTypeMl == false && amountControl == true) {
                    amountTypeSt = value!;
                    amountType = 'x';
                  }
                });
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(2.0)),
              side: MaterialStateBorderSide.resolveWith((states) => BorderSide(
                  width: 1.0,
                  color: amountControl ? Colors.grey : Colors.black)),
            ),
            Text(
              'x',
              style:
                  TextStyle(color: amountControl ? Colors.white : Colors.grey),
            )
          ],
        ),
      ],
    );
  }
}


void categoryType() {
  if(categories == 'lightBlue') {
    categoriesTypeFirebase = Colors.lightBlue;
  }
  if(categories == 'red') {
  categoriesTypeFirebase = Colors.red;
  }
  if(categories == 'green') {
    categoriesTypeFirebase = Colors.green;
  }
  if(categories == 'yellow') {
    categoriesTypeFirebase = Colors.yellow;
  }
  if(categories == 'grey') {
    categoriesTypeFirebase = Colors.grey;
  }
  if(categories == 'purple') {
    categoriesTypeFirebase = Colors.purple;
  }
  if(categories == 'pink') {
    categoriesTypeFirebase = Colors.pink;
  }
  if(categories == 'brown') {
    categoriesTypeFirebase = Colors.brown;
  }
  if(categories == 'deepOrange') {
    categoriesTypeFirebase = Colors.deepOrange;
  }
  if(categories == 'indigo') {
    categoriesTypeFirebase = Colors.indigo;
  }
}



class ChangeTile extends StatefulWidget {

  final textController1 = TextEditingController();

  @override
  _ChangeTileState createState() => _ChangeTileState();
}

class _ChangeTileState extends State<ChangeTile> {
  final textController = ChangeTile().textController1;



  @override
  Widget build(BuildContext context) {
    textController.text = rawName;

    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(4.0),
          color: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
                borderRadius:
                BorderRadius.circular(
                    20.0),
                color: categoriesTypeFirebase),
            child: TextField(
              style: TextStyle(
                  color: Colors.white),
              cursorColor: Colors.white,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                          color:
                          Colors.white),
                      borderRadius:
                      BorderRadius.circular(20.0)),
                  labelText: 'Neuer Name',
                  labelStyle: TextStyle(
                      color: Colors.white)),
              onChanged: (String text) {
                item = text;
              },
              controller: textController,
            ),
          ),
        ),
        AmountControllerRefactor(),
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
                  categoriesTypeFirebase = Colors.lightBlue;

                });
                },
                child: Container(),
              ),

              ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.red, maximumSize: Size(30.0,30.0), minimumSize: Size(30.0, 30.0)),
                onPressed: () { setState(() {
                  categories = 'red';
                  categoriesTypeFirebase = Colors.red;
                });
                },
                child: Container(),
              ),

              ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.green, maximumSize: Size(30.0,30.0), minimumSize: Size(30.0, 30.0)),
                onPressed: () { setState(() {
                  categories = 'green';
                  categoriesTypeFirebase = Colors.green;
                });
                },
                child: Container(),
              ),

              ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.yellow, maximumSize: Size(30.0,30.0), minimumSize: Size(30.0, 30.0)),
                onPressed: () { setState(() {
                  categories = 'yellow';
                  categoriesTypeFirebase = Colors.yellow;
                });
                },
                child: Container(),
              ),

              ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.grey, maximumSize: Size(30.0,30.0), minimumSize: Size(30.0, 30.0)),
                onPressed: () { setState(() {
                  categories = 'grey';
                  categoriesTypeFirebase = Colors.grey;
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
                  categoriesTypeFirebase = Colors.purple;
                });
                },
                child: Container(),
              ),

              ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.pink, maximumSize: Size(30.0,30.0), minimumSize: Size(30.0, 30.0)),
                onPressed: () { setState(() {
                  categories = 'pink';
                  categoriesTypeFirebase = Colors.pink;
                });
                },
                child: Container(),
              ),

              ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.brown, maximumSize: Size(30.0,30.0), minimumSize: Size(30.0, 30.0)),
                onPressed: () { setState(() {
                  categories = 'brown';
                  categoriesTypeFirebase = Colors.brown;

                });
                },
                child: Container(),
              ),

              ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.deepOrange, maximumSize: Size(30.0,30.0), minimumSize: Size(30.0, 30.0)),
                onPressed: () { setState(() {
                  categories = 'deepOrange';
                  categoriesTypeFirebase = Colors.deepOrange;

                });
                },
                child: Container(),
              ),

              ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.indigo, maximumSize: Size(30.0,30.0), minimumSize: Size(30.0, 30.0)),
                onPressed: () { setState(() {
                  categories = 'indigo';
                  categoriesTypeFirebase = Colors.indigo;
                });
                },
                child: Container(),
              ),


            ],
          ),
        ),
      ],
    );
  }
}
