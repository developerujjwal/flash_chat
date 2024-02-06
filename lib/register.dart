import 'package:flutter/material.dart';
import 'padding.dart';
import 'chat screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class register extends StatefulWidget {
  const register({super.key});

  @override
  State<register> createState() => _registerState();
}

class _registerState extends State<register> {
  final _auth = FirebaseAuth.instance;
  late String email;
  late String password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Hero(
                tag: 'logo',
                child: Image(
                  image: AssetImage("images/flsh.png"),
                ),
              ),
              TextField(
                textAlign: TextAlign.center,
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  email = value;
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    hintText: "enter your email"),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                obscureText: true,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  password = value;
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    hintText: "enter your password"),
              ),
              const SizedBox(
                height: 20,
              ),
              /* FilledButton(
                onPressed: () {},
                child: Text("register"),
                style: ButtonStyle(
                    backgroundColor:
                    MaterialStatePropertyAll(Colors.deepPurpleAccent)),
              ),*/
              padd("register", () async {
                try {
                  final newuser = await _auth.createUserWithEmailAndPassword(
                      email: email, password: password);
                  if (newuser != null) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const chat(),
                        ));
                  }
                } catch (e) {
                  print(e);
                }

                print(email);
                print(password);
              }),
              /*FilledButton(onPressed: (){
                Navigator.pop(context);
              }, child: Text("home"))*/
              padd("home", () {
                Navigator.pop(context);
              })
            ],
          ),
        ),
      ),
    );
  }
}
