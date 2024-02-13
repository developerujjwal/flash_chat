import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
final _firestore = FirebaseFirestore.instance;
class chat extends StatefulWidget {
  const chat({super.key});

  @override
  State<chat> createState() => _chatState();
}

class _chatState extends State<chat> {
  late String msg;
  final _auth = FirebaseAuth.instance;

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
             streammsg(),
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
class streammsg extends StatelessWidget {
  const streammsg({super.key});

  @override
  Widget build(BuildContext context) {
    return  StreamBuilder(
        stream: _firestore.collection('message').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final messages = snapshot.data?.docs;
            List<bubble> mw = [];
            for (var message in messages!) {
              final mt = message.data()['text'];
              final ms = message.data()['sender'];
              final storemessage = bubble(ms, mt);
              mw.add(storemessage);
            }

            return SingleChildScrollView(
              child: Expanded(
                child: Column(
                  children: mw,
                ),
              ),
            );
          } else {
            throw Exception('failed to retrieve messages');
          }
        });
  }
}

class bubble extends StatelessWidget {
  bubble(this.sender, this.text);
  late final String sender;
  late final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            sender,
            style: TextStyle(fontSize: 20, color: Colors.amber),
          ),
          Material(
            color: Colors.black,
            elevation: 5.0,
            borderRadius: BorderRadius.circular(30),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Text(
                '$text',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
