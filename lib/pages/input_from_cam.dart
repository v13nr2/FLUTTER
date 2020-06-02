import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
//import 'package:sosmed/utils.dart' as utils;
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
    final String url = "https://doktorsiaga.co.id/api/bukti_upload/add";

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
      //import utilsnya mas, td foto emg gak masuk ya?
      var response = await dio.post(url,
          data: formData,
          //'x-api-key': utils.x_api_key,
          options: Options(headers: {'x-api-key': 'DF1E02B621FBFD5849C54451D13BE778'}));
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
          //https://doktorsiaga.co.id/api/bukti_upload/add
          //variabel = photo(text), name(text)
          //header x-api-key
          // saya lanjut?

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
