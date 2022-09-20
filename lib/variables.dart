import 'package:flutter/material.dart';

import 'add_list_tile.dart';

//project version
String version = '0.2.2';

late String path = 'none';
late String state;

late String saveName;
late String displayPath;


late String name;
late String pin;

late String pathPin = '0';
late String pathName = 'none';


bool amountControl = true;

String amountRefactor = '';
String newAmount1 = '';

String amountType = list.first;

var categoriesType = Colors.lightBlue;
var categoriesTypeAdd = Colors.lightBlue;
var categoriesTypeFirebase = Colors.lightBlue;
String categories = '';

String rawName = '';
String item = '';

//Barcode Scanner
String scanResultGlobal = '0';

//Barcode Database
String bcName = '';
String bcProd = '';
String bcDesc = '';
bool bcOn = false;