import "package:flutter/material.dart";

class CardLogo extends StatelessWidget {
  final String type;
  const CardLogo(this.type);

  @override 
  Widget build(BuildContext context) => Align (
    alignment: Alignment.centerRight,
    child: Padding (
      padding: EdgeInsets.only(top: 15.0, right: 25.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Image(
            image: AssetImage('assets/visa_logo.png'),
            width: 65.0,
            height: 32.0,
          ),
          Text(
            type,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w400
            ),
          )
        ],
      )
    )
  );
}
