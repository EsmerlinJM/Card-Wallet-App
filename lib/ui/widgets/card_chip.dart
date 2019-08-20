import 'package:flutter/material.dart';

class CardChip extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: 30.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Image(
          image: AssetImage('assets/creditcardchipsilver.png'),
          width: 50.0,
        ),
      ],
    ),
  );
}
