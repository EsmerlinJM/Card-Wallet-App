import 'dart:async';
import 'package:flutter/material.dart';
import './app.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SplashScreenState();
  }
  
class _SplashScreenState extends State<SplashScreen>{
  @override
  void initState(){
    super.initState();
    loadData();
  }

  Future<Timer> loadData() async{
    return Timer(Duration(seconds: 5), onDoneLoading);
  }

  onDoneLoading() async {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => App() 
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Colors.white
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 120.0,
                        child: Image(
                          image: AssetImage('assets/006-wallet-3.png'),
                          width: 148.0,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 30.0),
                      ),
                      CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.blueAccent),
                    )
                      // Text(
                      //   'Card Wallet App',
                      //   style: TextStyle(
                      //     color: Colors.black,
                      //     fontWeight: FontWeight.bold,
                      //     fontSize: 32.0,
                      //   ),
                      // )
                    ],
                  ),
                ),
              ),
              // Expanded(
              //   flex: 1,
              //   child: Column(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: <Widget>[
              //       CircularProgressIndicator(
              //         valueColor: AlwaysStoppedAnimation<Color>(Colors.greenAccent),
              //       ),
              //       Padding(padding: EdgeInsets.only(top: 25.0)),
              //       Text(
              //         'Your credits cards \n in yours hands.',
              //         textAlign: TextAlign.center,
              //         style: TextStyle(
              //           color: Colors.black,
              //           fontSize: 18.0,
              //           fontWeight: FontWeight.bold
              //         ),
              //       )
              //     ],
              //   ),
              // )
            ],
          )
        ],
      ),
    );
  }
}