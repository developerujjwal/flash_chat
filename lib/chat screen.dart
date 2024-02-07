import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class chat extends StatefulWidget {
  const chat({super.key});

  @override
  State<chat> createState() => _chatState();
}

class _chatState extends State<chat> {
late  String msg;
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  late User loginuser;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getuser();
  }

  void getuser() async {
    try {
      final user = await _auth.currentUser;
      if(user!=null){
        loginuser=user;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [IconButton(icon: Icon(Icons.close),onPressed: () {
          _auth.signOut();
          Navigator.pop(context);
        },)],
        title: const Text('chat'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 300,
              child: TextField(
                onChanged: (value) {
                  msg=value;
                },
                textAlign: TextAlign.center,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    hintText: 'type your massage here ....'),
              ),
            ),
            TextButton(
              onPressed: () {
                _firestore.collection('message').add({
                  'text':msg,
                  'sender':loginuser.email,
                });
              },
              child: const Text('Send'),
            ),
          ],
        ),
      ),
    );
  }
}
