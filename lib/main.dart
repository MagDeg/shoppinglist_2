
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:shopping_list_2/auth_page.dart';
import 'package:shopping_list_2/barcode_code_scanner/barcode_db_found.dart';
import 'package:shopping_list_2/barcode_code_scanner/barcode_db_not_found.dart';
import 'package:shopping_list_2/setting_screen.dart';
import 'package:shopping_list_2/todo_builder.dart';
import 'package:shopping_list_2/variables.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'add_list_tile.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

final navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
      home: ShoppinglistApp(),
      themeMode: ThemeMode.system,
      theme: ThemeData(
        brightness: Brightness.light,
        textTheme: TextTheme(
          headline1: TextStyle(color: Colors.white),
          headline2: TextStyle(color: Colors.white),
          bodyText2: TextStyle(color: Colors.white),
          // subtitle1: TextStyle(color: Colors.white),
          overline: TextStyle(color: Colors.white),
        ),
      ),
      darkTheme: ThemeData(brightness: Brightness.dark, inputDecorationTheme: InputDecorationTheme(labelStyle: TextStyle(color: Colors.white))),

      navigatorKey: navigatorKey,
      scaffoldMessengerKey: MessageError.messengerKey));
}


class ShoppinglistApp extends StatefulWidget {

  Future<void> setPrefNew() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('pathPinString', pin);
    prefs.setString('pathNameString', name);
  }

  @override
  _ShoppinglistAppState createState() => _ShoppinglistAppState();
}

class _ShoppinglistAppState extends State<ShoppinglistApp> {

  int currentIndexOfShownPages = 0;

  void loadingPageLoad() {
    currentIndexOfShownPages = 1;
  }

  void loadingPageClose() {
    currentIndexOfShownPages = 0;
  }

  final shownPages = [
    ToDoBuilder(),
    SettingScreen(),
  ];

  Future<void> incrementStartup() async {
    String pinNow = await _getPinStringFromSharedPref();
    String nameNow = await _getNameStringFromSharedPref();
    setState(() {
      pathPin = pinNow;
      pathName = nameNow;
      path = pathName + pathPin;
      loadingPageClose();
    });
  }

  Future<String> _getPinStringFromSharedPref() async {

    final prefs = await SharedPreferences.getInstance();
    final startupString = prefs.getString('pathPinString');
    final startupNull = '0';

    if (startupString == null) {
      return startupNull;
    }
    return startupString;
  }

  Future<String> _getNameStringFromSharedPref() async {

    final prefs1 = await SharedPreferences.getInstance();
    final startupString = prefs1.getString('pathNameString');
    final startupNull = 'none';

    if (startupString == null) {
      return startupNull;
    }

    return startupString;
  }

  void newProductEntry() {
    showDialog<AlertDialog>(
      context: context,
      builder: (BuildContext context) {
        return AddTile();
      },
    );
  }

  Future<void> scanBarcode() async {
    String scanResult;
    try {
      scanResult = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Abbrechen', true, ScanMode.BARCODE);
    } on PlatformException {
      scanResult = 'Failed to get Platformversion.';
    }
    if (!mounted) return;

    setState(() {
      scanResultGlobal = scanResult;
      checkIfListExists();
    });
  }

  void checkIfListExists() async {

    final docRep = await FirebaseFirestore.instance.collection('_barcodeDatabase').doc(scanResultGlobal);
    final doc = await docRep.get();

    if(doc.exists) {
      showDialog<AlertDialog>(
          context: context,
          builder: (BuildContext context) {
            return BarcodeDbFound();
          });
    } else if (scanResultGlobal != '-1') {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return BarcodeDbNotFound();
          });
    }
  }

  @override
  void initState() {
    incrementStartup();
    loadingPageLoad();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
    if (user != null) {
      print("ID: " + user.uid);
    }} );
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              body: Stack(
                children: [
                  Center(child: shownPages[currentIndexOfShownPages]),
                ],
              ),

              bottomNavigationBar: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[Colors.indigo, Colors.indigoAccent],
                  )
                ),
                  child: NavigationBar(
                    backgroundColor: Colors.transparent,

                    selectedIndex: currentIndexOfShownPages,
                    onDestinationSelected: (int newIndex) {
                      setState(() {
                        currentIndexOfShownPages = newIndex;
                      });
                    },
                    destinations: [
                      NavigationDestination(
                          selectedIcon: Icon(
                            Icons.shopping_cart,
                            color: Colors.white,
                          ),
                          icon: Icon(
                            Icons.shopping_cart_outlined,
                            color: Colors.white,
                          ),
                          label:'Einkaufsliste',


                      ),
                      NavigationDestination(
                          selectedIcon: Icon(
                            Icons.settings,
                            color: Colors.white,
                          ),
                          icon: Icon(
                            Icons.settings_outlined,
                            color: Colors.white,
                          ),
                          label:'Einstellungen'),
                  ],
                ),
              ),
              floatingActionButton: SpeedDial(
                  icon: Icons.add,
                  iconTheme: IconThemeData(color: Theme.of(context).brightness! == Brightness.dark ? Colors.white : Colors.black),
                  backgroundColor: Colors.indigoAccent,
                  children: [
                    SpeedDialChild(
                      child: Icon(Icons.edit, color: Colors.white),
                      label: 'Manuel',
                      labelStyle: TextStyle(color: Theme.of(context).brightness! == Brightness.dark ? Colors.white : Colors.black),
                      onTap: () => newProductEntry(),
                      backgroundColor: Colors.indigo
                    ),
                    SpeedDialChild(
                      child: Icon(Icons.qr_code_scanner, color: Colors.white),
                      label: 'Scannen',
                      labelStyle: TextStyle(color: Theme.of(context).brightness! == Brightness.dark ? Colors.white : Colors.black),
                      backgroundColor: Colors.indigo,
                      onTap: () {
                        scanBarcode();
                      }

                    )
                  ],
                )
            );
          } else {
            return AuthPage();
          }
        },
      ),
    );
  }
}

