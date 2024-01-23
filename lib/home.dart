import 'package:flutter/material.dart';
import 'package:random/login.dart';
import 'package:random/register.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'padding.dart';
class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation
      animation; //flutter_sequence_animation package https://pub.dev/packages/flutter_sequence_animation , rubber, sprung , animation_text_kit
  late Animation a;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
      //upperBound: 100.0,
    );
    //animation = CurvedAnimation(parent: controller, curve: Curves.decelerate);
    a = CurvedAnimation(parent: controller, curve: Curves.decelerate);
    animation =
        ColorTween(begin: Colors.teal, end: Colors.blue).animate(controller);
    controller.forward();
    animation.addStatusListener((status) {
      //print(status);
      if (status == AnimationStatus.completed) {
        controller.reverse(from: 1.0);
      } /*else if (status == AnimationStatus.dismissed) {
        controller.forward();
      }*/
    });
    controller.addListener(() {
      setState(() {});
      print(animation.value);
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.deepOrange.withOpacity(controller.value/100.0),
      backgroundColor: animation.value,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Hero(
                  tag: 'logo',
                  child: Image(
                    image: const AssetImage("images/flsh.png"),
                    height: a.value * 100, //animation.value * 100,
                  ),
                ),
                AnimatedTextKit(animatedTexts:[ TypewriterAnimatedText(
                  'Flash chat_',
                  // "${controller.value.toInt()}",
                  textStyle: const TextStyle(fontSize: 50),
                )],
                totalRepeatCount: 1,
                )
              ],
            ),
            const SizedBox(
              height: 100,
            ),
            Hero(
              tag: 'login',
              child: padd("login",() {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const login(),
                  ),
                );
              }),
            ),const SizedBox(
              height: 20,
            ),
            /*FilledButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => register(),
                  ),
                );
              },
              child: Text("Register"),
            )*/
padd("register",  () {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const register(),
    ),
  );
}  )
          ],
        ),
      ),
    );
  }
}

