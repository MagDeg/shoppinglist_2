import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:shopping_list_2/auth_page.dart';
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
    });
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

              bottomNavigationBar: NavigationBar(
                backgroundColor: Colors.lightBlue,
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
              floatingActionButton:
                SpeedDial(
                  icon: Icons.add,
                  // animatedIcon: AnimatedIcons.menu_close,
                  backgroundColor: Colors.lightBlue,
                  children: [
                    SpeedDialChild(
                      child: Icon(Icons.edit, color: Colors.white),
                      label: 'Manuel',
                      onTap: () => newProductEntry(),
                      backgroundColor: Colors.lightBlueAccent
                    ),
                    SpeedDialChild(
                      child: Icon(Icons.qr_code_scanner, color: Colors.white),
                      label: 'Scannen',
                      backgroundColor: Colors.lightBlueAccent,
                      onTap: () {
                        scanBarcode();
                      }

                    )
                  ],
                )
              // FloatingActionButton(
              //   child: Icon(
              //     Icons.edit,
              //     color: Colors.white,
              //   ),
              //   onPressed: () => newProductEntry(),
              //   backgroundColor: Colors.lightBlueAccent,
              // ),

            );
          } else {
            return AuthPage();
          }
        },
      ),
    );
  }
}

