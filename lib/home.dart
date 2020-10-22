import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _loading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 100),
            Text('TeachableMachine.com CNN',
                style: TextStyle(color: Colors.blue, fontSize: 18)),
            SizedBox(height: 6),
            Text('Detects Dogs and Cats',
                style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.w500,
                    fontSize: 18)),
            SizedBox(height: 40),
            Center(
              child: _loading
                  ? Container(
                      width: 280,
                      child: Column(children: <Widget>[
                        Image.asset('assets/cat.png'),
                        SizedBox(height: 50),
                      ]))
                  : Container(),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Column(children: <Widget>[
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: MediaQuery.of(context).size.width - 150,
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 17),
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(6)),
                    child: Text('Take a picture',
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
                SizedBox(height: 30),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: MediaQuery.of(context).size.width - 150,
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 17),
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(6)),
                    child: Text('Camera Roll',
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
