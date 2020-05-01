import 'package:flutter/material.dart';

class Upload extends StatefulWidget {
  @override
  _UploadState createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(left:0, right: 0),
              child: Image.network(
                'https://doktorsiaga.co.id/koperasi/images/background.jpg',
                height: 220,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.fill,
              ),
            ),
            Container(
                alignment: Alignment.topCenter,
                padding: EdgeInsets.only(top:150, left: 0),
                child: Text(
                  'Nanang Rustianto',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0),
                )),
            Container(
              alignment: Alignment.topCenter,
              padding: EdgeInsets.only(top:30),
              child: Image.network(
                'https://doktorsiaga.co.id/koperasi/images/logo.png',
                height: 120,
                width: 120,
                fit: BoxFit.fill,
              ),
            ),
            
            Container(
              alignment: Alignment.topCenter,
              padding: EdgeInsets.only(top:190),
              child: Image.network(
                'https://doktorsiaga.co.id/koperasi/images/foreground.png',
                height: 260,
                width: 320,
                fit: BoxFit.fill,
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}
