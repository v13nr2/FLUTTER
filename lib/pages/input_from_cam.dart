import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sosmed/utils.dart' as utils;
import 'package:http_parser/http_parser.dart';

class InputCamera extends StatefulWidget {
  @override
  _InputCameraState createState() => _InputCameraState();
}

class _InputCameraState extends State<InputCamera> {
  File _image;
  final imagePicker = ImagePicker();
  Dio dio = Dio();

  Future<File> getImageCam() async {
    var image = await imagePicker.getImage(source: ImageSource.camera);

    return File(image.path);
  }

  Future uploadForm() async {
    final String url = utils.upload_url;

    String fileName = _image.path.split('/').last;

    try {
      FormData formData = FormData.fromMap({
        'photo': await MultipartFile.fromFile(
          _image.path,
          filename: fileName,
          contentType: MediaType(
            'picture',
            'jpg',
           ),
         ),
        'name': fileName.substring(0,3)+'.jpg',
        //'photo': fileName+'.jpg',
      });
      
      var response = await dio.post(url,
          data: formData,
          options: Options(headers: {'x-api-key': utils.x_api_key}));
      //print response dari server
      print(response.data);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    //var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Input Camera', style: TextStyle(color: Colors.black54)),
        actions: [
          GestureDetector(
            onTap: () {
  
              getImageCam().then((value) {
                setState(() {
                  _image = value;
                });
               uploadForm().then((value) => print('uploaded'));
              });
            },
            child: Padding(
                padding: EdgeInsets.only(right: 10),
                child: Icon(
                  Icons.camera,
                  color: Colors.black54,
                )),
          )
        ],
      ),
      body: Center(
          child: _image != null ? Image.file(_image) : Text('Input Action!')),
    );
  }
}
