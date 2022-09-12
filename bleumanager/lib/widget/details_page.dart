import 'package:flutter/material.dart';

import '../object/bleu.dart';

class DetailPage extends StatelessWidget {
  final Bleu bleu;

  const DetailPage(this.bleu, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Center(
          child: Text(
            "${bleu.lastname} ${bleu.firstname}",
            style: const TextStyle(
              color: Colors.blueAccent,
              fontSize: 24,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Widget details() => Column(
        children: const [],
      );

  Widget fName() => Row(
        children: const [
          Text.rich(
            TextSpan(
              style: TextStyle(
                fontSize: 17,
              ),
              children: [
                TextSpan(
                  text: 'Tap',
                ),
                WidgetSpan(
                  child: Icon(Icons.add),
                ),
                TextSpan(
                  text: 'on the right hand corner to start a new chat.',
                )
              ],
            ),
          )
        ],
      );
}
