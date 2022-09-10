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
import 'language.dart';
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
        primaryColor: Colors.lightBlue,
      ),
      darkTheme: ThemeData(brightness: Brightness.dark),
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
  ShoppinglistAppState createState() => ShoppinglistAppState();
}

class ShoppinglistAppState extends State<ShoppinglistApp> {
  final textController = TextEditingController();
  String scanResult = '0';

  void refresh() {
      currentIndexOfShownPages = 0;
      sleep(Duration(milliseconds: 2));
      currentIndexOfShownPages = 1;
  }

  void loadingPageLoad() {
      currentIndexOfShownPages = 1;
  }

  void loadingPageClose() {
      currentIndexOfShownPages = 0;
  }

  int currentIndexOfShownPages = 0;

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

  final shownPages = [
    ToDoBuilder(),
    SettingScreen(),
  ];

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
      // this.scanResult = scanResult;
      scanResultGlobal = scanResult;
      print(scanResultGlobal);
      checkIfListExists();
    });
  }

  void checkIfListExists() async {

    final docRep = await FirebaseFirestore.instance.collection('_barcodeDatabase').doc(scanResultGlobal);
    final doc = await docRep.get();

    if(doc.exists) {
      // Navigator.push(context, MaterialPageRoute(builder: (context) => BarcodeDbFound()));
      showDialog<AlertDialog>(
          context: context,
          builder: (BuildContext context) {
            return BarcodeDbFound();
          });
      print('found');
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return BarcodeDbNotFound();
          });
      print('not found');
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
                        label: bottom1),
                    NavigationDestination(
                        selectedIcon: Icon(
                          Icons.settings,
                          color: Colors.white,
                        ),
                        icon: Icon(
                          Icons.settings_outlined,
                          color: Colors.white,
                        ),
                        label: bottom2),
                  ],
                ),
              ),
              floatingActionButton:
                SpeedDial(
                  icon: Icons.add,
                  // animatedIcon: AnimatedIcons.menu_close,
                  backgroundColor: Colors.indigo,
                  children: [
                    SpeedDialChild(
                      child: Icon(Icons.edit, color: Colors.white),
                      label: 'Manuel',
                      onTap: () => newProductEntry(),
                      backgroundColor: Colors.indigo
                    ),
                    SpeedDialChild(
                      child: Icon(Icons.qr_code_scanner, color: Colors.white),
                      label: 'Scannen',
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

