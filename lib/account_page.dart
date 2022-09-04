import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Benutzer',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
          ),
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
        body: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            children: [
              const Text('Angemeldet als', style: TextStyle(fontSize: 16)),
              const SizedBox(height: 8),
              Text(
                user.email!,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 40,
              ),
              ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                  ),
                  icon: const Icon(Icons.arrow_back, size: 32),
                  label: const Text(
                    'Abmelden',
                    style: TextStyle(fontSize: 24),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    FirebaseAuth.instance.signOut();
                  }),
            ],
          ),
        ));
  }
}
