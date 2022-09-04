import 'package:flutter/material.dart';


class ShowChanges extends StatefulWidget {
  @override
  _ShowChangesState createState() => _ShowChangesState();
}

class _ShowChangesState extends State<ShowChanges> {

  List <String> Changes = [
    'Fehlerbehebung bei Namenänderung und Farbkategorien',
    'Überarbeitung des Layouts für den Einstellungsbildschirm',
    'Listen sind jetzt direkt erstell- und löschbar',
    'Einträge nach Farbe kategorisierbar',
    'Unterschiedliche Mengeneinheiten',
    'Mengenangabe ist optional',
    'Benutzung der App nur mit einem genehmigten Zugang möglich',
    'Löschen der Einträge durch gedrückthalten des Eintrags',
    'PIN muss sechstellig sein!',
    '"Was ist Neu?" Funktion hinzugefügt',
    'Menge und/oder Produkt in Liste änderbar',
    'Listen mit PIN wechselbar'];
  List <String> Versions = [
    '2.2.0.2',
    '2.2.0.1',
    '2.2.0',
    '2.1.3',
    '2.1.2',
    '2.1.1',
    '2.1.0',
    '2.0.4',
    '2.0.3',
    '2.0.2',
    '2.0.1',
    '2.0.0'];

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
              color: Colors.lightBlue),
          height: 200.0,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Column(
              children: [
                    Align(
                      child: Container(
                        padding: EdgeInsets.all(10.0),
                        child: Text('Was ist Neu?', style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w600),),
                      )),
                    Align(
                    child: Container(
                      height: 150,
                      child: ListView.builder(
                          itemCount: Changes.length,
                          itemBuilder: (context, i) {
                            return SingleChange(Changes[i],Versions[i]);
                          }),
                    )
                  )

              ]),
            ),
          ),
        ),
      );

  }
}

class SingleChange extends StatelessWidget {
  final String title;
  final String version;
  const SingleChange(this.title, this.version);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius:
            BorderRadius.circular(20.0),
            color: Colors.black26),
        child: ListTile(
          leading: Text(version, style: TextStyle(fontSize: 15.0),),
          title: Text(
            title,
            style: TextStyle(
                fontSize: 15.0,
                color: Colors.white),
          ),

        ),
      ),
    );

  }
}