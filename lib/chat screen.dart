import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class chat extends StatefulWidget {
  const chat({super.key});

  @override
  State<chat> createState() => _chatState();
}

class _chatState extends State<chat> {
  late String msg;
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
      if (user != null) {
        loginuser = user;
      }
    } catch (e) {
      print(e);
    }
  }

// void cht()async{
  //  final msg = await _firestore.collection('message').get();
  //for(var abhi in msg.docs){
  //print (abhi.data());
  //}
  //}
  void cht() async {
    await for (var msg in _firestore.collection('message').snapshots()) {
      for (var abhi in msg.docs) {
        print(abhi.data());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              cht();
              //_auth.signOut();
              // Navigator.pop(context);
            },
          )
        ],
        title: const Text('chat'),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              StreamBuilder(
                stream: _firestore.collection('message').snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.blue,
                      ),
                    );
                  }

                  final messageDocs = snapshot.data?.docs;

                  if (messageDocs != null) {
                    List<Text> messageWidgets = messageDocs
                        .map((message) => Text(
                            '${message.data()['text']} from ${message.data()['sender']}'))
                        .toList();

                    return Column(children: messageWidgets);
                  } else {
                    return Center(
                        child: Text('No messages yet')); // Handle null case
                  }
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 250,
                    child: TextField(
                      onChanged: (value) {
                        msg = value;
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
                        'text': msg,
                        'sender': loginuser.email,
                      });
                    },
                    child: const Text('Send'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
