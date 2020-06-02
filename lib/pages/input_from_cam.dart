import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class InputCamera extends StatefulWidget {
  @override
  _InputCameraState createState() => _InputCameraState();
}

class _InputCameraState extends State<InputCamera> {
  File _image;
  final imagePicker = ImagePicker();

  Future getImageCam() async {
    var image = await imagePicker.getImage(source: ImageSource.camera);

    setState(() {
      _image = File(image.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Input Camera', style:TextStyle(color:Colors.black54)),
        actions: [
          
          ///https://doktorsiaga.co.id/api/bukti_upload/add
          ///
          ///tipenya get atau post?
          ///post
          ///ada variabel yg di post?
          ///1. header x-api-key = DF1E02B621FBFD5849C54451D13BE778
          ///2. form photo (text)
       
          //oke saya ubah apinya dulu, file juga gpp

          GestureDetector(
            onTap: () {
              getImageCam();
            },
            child: Padding(
              padding: EdgeInsets.only(right:10),
              child: Icon(Icons.camera, color: Colors.black54,)),
          )
        ],
      ),
      body: Center(
          child: _image != null ? Image.file(_image) : Text('Input Action!')),
    );
  }
}
