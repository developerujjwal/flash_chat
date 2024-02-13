import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = FirebaseFirestore.instance;
late User loginuser;
class chat extends StatefulWidget {
  const chat({super.key});

  @override
  State<chat> createState() => _chatState();
}

class _chatState extends State<chat> {
  late String msg;
  final _auth = FirebaseAuth.instance;
  final messagetextcontroller = TextEditingController();


  @override
  void initState() {
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
             // cht();
              _auth.signOut();
               Navigator.pop(context);
            },
          )
        ],
        title: const Text('chat'),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.all(10),
          child: Column(
            children: [
              streammsg(),
              Row(
                children: [
                  SizedBox(
                    width: 250,
                    child: TextField(
                      controller: messagetextcontroller,
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
                      messagetextcontroller.clear();
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
    return StreamBuilder(
        stream: _firestore.collection('message').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final messages = snapshot.data?.docs.reversed;
            List<bubble> mw = [];
            for (var message in messages!) {
              final mt = message.data()['text'];
              final ms = message.data()['sender'];
              final currentuser = loginuser?.email;
              final storemessage = bubble(ms, mt,currentuser==ms);
              mw.add(storemessage);
            }

            return SingleChildScrollView(reverse: true,
              child: Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.stretch,
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
  bubble(this.sender, this.text,this.isme);
  late final String sender;
  late final String text;
  late final bool isme;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: isme? CrossAxisAlignment.end:CrossAxisAlignment.start,
        children: [
          Text(
            sender,
            style: TextStyle(fontSize: 20, color: Colors.black),
          ),
          Material(
            color:isme? Colors.black:Colors.grey,
            elevation: 5.0,
            borderRadius:isme? BorderRadius.only(
                topLeft: Radius.circular(30),
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30)):BorderRadius.only(
                topRight: Radius.circular(30),
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30)),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Text(
                '$text',
                style: TextStyle(fontSize: 20, color: isme? Colors.white:Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
