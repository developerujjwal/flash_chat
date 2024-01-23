import 'package:flutter/material.dart';
class padd extends StatelessWidget {
  const padd (this.title,this.pressed, {super.key});
  final String title;
  final VoidCallback pressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FilledButton(
        onPressed: pressed/*() {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => login(),
            ),
          );
        }*/,
        child: Text(title),
      ),
    );
  }
} /*,*/
