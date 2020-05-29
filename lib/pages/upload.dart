import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:sosmed/pages/camera.dart';

class Upload extends StatefulWidget {
  @override
  _UploadState createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  _gotoAbsensi() {
    Alert(
      context: context,
      type: AlertType.error,
      title: "Siap Absen!",
      desc: "Silahkan melakukan Absensi.",
      buttons: [
        DialogButton(
          child: Text(
            "Take Camera",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TakePictureScreen()),
          ), //Navigator.pop(context),
          width: 120,
        )
      ],
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(left: 0, right: 0),
              child: Image.network(
                'https://doktorsiaga.co.id/koperasi/images/background.jpg',
                height: 250,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.fill,
              ),
            ),
            Container(
                alignment: Alignment.topCenter,
                padding: EdgeInsets.only(top: 150, left: 0),
                child: Text(
                  'Nanang Rustianto',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0),
                )),
            Container(
              alignment: Alignment.topCenter,
              padding: EdgeInsets.only(top: 30),
              child: Image.network(
                'https://doktorsiaga.co.id/koperasi/images/logo.png',
                height: 120,
                width: 120,
                fit: BoxFit.fill,
              ),
            ),
            Container(
              alignment: Alignment.topCenter,
              padding: EdgeInsets.only(top: 190),
              child: Image.network(
                'https://doktorsiaga.co.id/koperasi/images/foreground.png',
                height: 240,
                width: 320,
                fit: BoxFit.fill,
              ),
            ),
            Container(
              alignment: Alignment.topCenter,
              padding: EdgeInsets.only(top: 175),
              child: const RaisedButton(
                color: Colors.blue,
                disabledColor: Colors.blue, //add this to your code
                onPressed: null,
                child: Text('Data Absensi Bulan ini',
                    style: TextStyle(color: Colors.white, fontSize: 16)),
              ),
            ),
            Container(
              alignment: Alignment.topCenter,
              padding: EdgeInsets.only(top: 220),
              child: Text('Jadwal : Reguler (07:35:00 - 16:30:00)',
                  style: TextStyle(color: Colors.blue, fontSize: 14)),
            ),
            Container(
              alignment: Alignment.topCenter,
              padding: EdgeInsets.only(top: 235),
              child: Text('Selasa, 21 April 2020 09:19:32',
                  style: TextStyle(color: Colors.black, fontSize: 14)),
            ),
            Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.only(top: 255, left: 1),
                margin: const EdgeInsets.only(left: 30),
                child: FlatButton(
                  color: Colors.blue,
                  textColor: Colors.white,
                  disabledColor: Colors.grey,
                  disabledTextColor: Colors.black,
                  padding: EdgeInsets.all(8.0),
                  splashColor: Colors.blueAccent,
                  onPressed: () {},
                  child: Text(
                    "Hadir",
                    style: TextStyle(fontSize: 12.0),
                  ),
                )),
            Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.only(top: 255, left: 70),
                margin: const EdgeInsets.only(left: 60),
                child: FlatButton(
                  color: Colors.orange,
                  textColor: Colors.white,
                  disabledColor: Colors.grey,
                  disabledTextColor: Colors.black,
                  padding: EdgeInsets.all(8.0),
                  splashColor: Colors.blueAccent,
                  onPressed: () {},
                  child: Text(
                    "Izin",
                    style: TextStyle(fontSize: 12.0),
                  ),
                )),
            Container(
                alignment: Alignment.topCenter,
                padding: EdgeInsets.only(top: 255, left: 70),
                margin: const EdgeInsets.fromLTRB(160, 0, 40, 40),
                child: FlatButton(
                  color: Colors.green,
                  textColor: Colors.white,
                  disabledColor: Colors.grey,
                  disabledTextColor: Colors.black,
                  padding: EdgeInsets.all(8.0),
                  splashColor: Colors.blueAccent,
                  onPressed: () {},
                  child: Text(
                    "Sisa Cuti",
                    style: TextStyle(fontSize: 12.0),
                  ),
                )),
            Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.only(top: 305, left: 1),
                margin: const EdgeInsets.only(left: 30),
                child: FlatButton(
                  color: Colors.white,
                  textColor: Colors.blue,
                  disabledColor: Colors.grey,
                  disabledTextColor: Colors.black,
                  padding: EdgeInsets.all(8.0),
                  splashColor: Colors.blueAccent,
                  onPressed: () {},
                  child: Text(
                    "30",
                    style: TextStyle(fontSize: 32.0),
                  ),
                )),
            Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.only(top: 305, left: 70),
                margin: const EdgeInsets.only(left: 60),
                child: FlatButton(
                  color: Colors.white,
                  textColor: Colors.orange,
                  disabledColor: Colors.grey,
                  disabledTextColor: Colors.black,
                  padding: EdgeInsets.all(8.0),
                  splashColor: Colors.blueAccent,
                  onPressed: () {},
                  child: Text(
                    "0",
                    style: TextStyle(fontSize: 32.0),
                  ),
                )),
            Container(
                alignment: Alignment.topCenter,
                padding: EdgeInsets.only(top: 305, left: 70),
                margin: const EdgeInsets.fromLTRB(160, 0, 40, 40),
                child: FlatButton(
                  color: Colors.white,
                  textColor: Colors.grey,
                  disabledColor: Colors.grey,
                  disabledTextColor: Colors.black,
                  padding: EdgeInsets.all(8.0),
                  splashColor: Colors.blueAccent,
                  onPressed: () {},
                  child: Text(
                    "12",
                    style: TextStyle(fontSize: 32.0),
                  ),
                )),
            Container(
                alignment: Alignment.topLeft,
                width: 220.0,
                height: 30.0,
                margin: const EdgeInsets.only(top: 365, left: 30),
                child: FlatButton(
                  onPressed: null,
                  child:
                      Text('Rekap Saya', style: TextStyle(color: Colors.blue)),
                  textColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      side: BorderSide(
                          color: Colors.blue,
                          width: 1,
                          style: BorderStyle.solid),
                      borderRadius: BorderRadius.circular(50)),
                )),
            Container(
                alignment: Alignment.topLeft,
                width: 220.0,
                height: 30.0,
                margin: const EdgeInsets.only(top: 365, left: 200),
                child: FlatButton(
                  onPressed: null,
                  child:
                      Text('Rekap Staff', style: TextStyle(color: Colors.blue)),
                  textColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      side: BorderSide(
                          color: Colors.blue,
                          width: 1,
                          style: BorderStyle.solid),
                      borderRadius: BorderRadius.circular(50)),
                )),
            Container(
              alignment: Alignment.topCenter,
              margin: const EdgeInsets.only(top: 405, left: 15),
              child: Image.network(
                'https://doktorsiaga.co.id/koperasi/images/menuutama.png',
                height: 56,
                width: 560,
                fit: BoxFit.fill,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(
                color: Colors.white,
                width: 1,
              )),
              alignment: Alignment.topLeft,
              margin: const EdgeInsets.only(top: 455, left: 15),
              child: GestureDetector(
                onTap: _gotoAbsensi,
                child: Image.network(
                  'https://doktorsiaga.co.id/koperasi/images/absensi.png',
                  height: 128,
                  width: 104,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(
                color: Colors.white,
                width: 1,
              )),
              alignment: Alignment.topLeft,
              margin: const EdgeInsets.only(top: 455, left: 125),
              child: Image.network(
                'https://doktorsiaga.co.id/koperasi/images/izin.png',
                height: 123,
                width: 104,
                fit: BoxFit.fill,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(
                color: Colors.white,
                width: 1,
              )),
              alignment: Alignment.topLeft,
              margin: const EdgeInsets.only(top: 455, left: 235, right: 15),
              child: Image.network(
                'https://doktorsiaga.co.id/koperasi/images/infogaji.png',
                height: 128,
                width: 104,
                fit: BoxFit.fill,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
