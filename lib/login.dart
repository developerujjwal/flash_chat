import 'package:flutter/material.dart';
import 'package:random/chat%20screen.dart';
import 'padding.dart';

class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
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
                    padd("login", () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const chat(),
                      ));
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
