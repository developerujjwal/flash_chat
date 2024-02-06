import 'package:flutter/material.dart';
import 'package:random/chat%20screen.dart';
import 'padding.dart';
import 'package:firebase_auth/firebase_auth.dart';

class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  final _auth = FirebaseAuth.instance;
  late String email;
  late String password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Center(
              child: Hero(
                tag: 'logo',
                child: Image(
                  image: AssetImage("images/flsh.png"),
                ),
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
                      borderRadius: BorderRadius.circular(50)),
                  hintText: "enter your email"),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              obscureText: true,
              textAlign: TextAlign.center,
              onChanged: (value) {
                password = value;
              },
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  hintText: "enter your password"),
            ),
            const SizedBox(
              height: 20,
            ),
            Hero(
                tag: 'login',
                child: /* FilledButton(
                onPressed: () {},
                child: Text("Login"),
              ),*/
                    padd("login", () async {
                  try {
                    final user=await _auth.signInWithEmailAndPassword(email: email, password: password);
                    if(user!=null){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const chat(),
                          ));
                    }
                  } catch (e) {
                    print(e);
                  }
                })),
            /*FilledButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("home"))*/
            padd(
              "home",
              () {
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }
}
//hjvhjhv