import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GiveFeedbackPage extends StatefulWidget {
  @override
  _GiveFeedbackPageState createState() => _GiveFeedbackPageState();
}

class _GiveFeedbackPageState extends State<GiveFeedbackPage> {
  final feedback = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Feedback geben'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[Colors.blueAccent, Colors.lightBlue],
            ),
          ),
        ),
      ),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(child: Text('Bitte schreiben sie hier nun ihr Feedback hin.')),
                SizedBox(
                  height: 500.0,
                  child: Container(
                    decoration: BoxDecoration(border: Border.all(color: Colors.grey, width: 2.0)),
                    child: TextFormField(
                      controller: feedback,
                      textInputAction: TextInputAction.done,
                      maxLines: null,
                      minLines: null,
                      expands: true,
                      decoration: InputDecoration(labelText: 'Ihr Feedback'),
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size.fromHeight(40),
                    primary: Colors.lightBlue,
                  ),
                  child: Text('Feedback abschicken'),
                  onPressed: () {
                    
                    FirebaseFirestore.instance.collection('_feedback').add({'feedback': feedback.text});
                    showDialog(context: context, builder: (context) => AlertDialog(
                      backgroundColor: Colors.black38,
                      content: Form(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(child: Text('Ihr Feedback wurde erfolgreich verschickt!', style: TextStyle(color: Colors.white))),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  minimumSize: Size.fromHeight(40),
                                  primary: Colors.lightBlue,
                                ),
                                child: Text('Zurück'),
                                onPressed: () {
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                },
                        )],
                    ))));
                    feedback.clear();
                  },
                )
            ],
          ),
        ),
      ]),
    );
  }
}
