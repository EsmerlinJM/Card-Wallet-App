import 'package:flutter/material.dart';

class CardChip extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Image(
            image: AssetImage('assets/creditcardchipsilver.png'),
            width: 50.0,
          ),
          SizedBox(width: 50.0),
          SizedBox(width: 50.0),
          SizedBox(width: 50.0),
        ],
      ),
    );
  }
}