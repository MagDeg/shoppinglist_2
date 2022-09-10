import 'package:flutter/material.dart';
import 'give_feedback.dart';

class FeedbackSettingScreen extends StatelessWidget {
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
          height: 88,
          child: Align(
            alignment: Alignment.center,
            child: Column(
                children: [
                  Container(padding: EdgeInsets.all(10.0), child: Text('Schreibe Verbesserungsvorschläge', style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w600))),
                  Container(
                    color: Colors.grey,
                    height: 1,
                  ),
                  TextButton(
                    onPressed: () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) => GiveFeedbackPage())),
                    child: ListTile(
                      leading: Text('Feedback geben'),
                      trailing: Icon(Icons.arrow_forward_ios_sharp, size: 25.0),
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
