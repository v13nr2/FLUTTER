import 'package:flutter/material.dart';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sosmed/utils.dart' as utils;
import 'package:http_parser/http_parser.dart';

main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Form Demo',
      home: FormDemo(),
    );
  }
}

class FormDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FormDemoState();
  }
}

class _FormDemoState extends State<FormDemo> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _formData = {'email': null, 'password': null};
  final focusPassword = FocusNode();

  File _image;
  final imagePicker = ImagePicker();
  Dio dio = Dio();

  Future<File> getImageCam() async {
    var image = await imagePicker.getImage(source: ImageSource.camera, maxHeight: 380);

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
      print(response.statusCode);
      //print(response.request);
      if(response.statusCode==200){
        //showAlert(context, "Uploaded", "Status Upload ?");
      }
      
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
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
               //uploadForm().then((value) => print('uploaded'));
              });
            },
            child: Padding(
                padding: EdgeInsets.only(right: 10),
                child: Icon(
                  Icons.camera,
                  color: Colors.black54,
                )),
          ),
          GestureDetector(
            onTap: () {
              
               uploadForm().then((value) => print('uploaded'));
            
            },
            child: Padding(
                padding: EdgeInsets.only(right: 10),
                child: Icon(
                  Icons.plus_one,
                  color: Colors.black54,
                )),
          )
        ],
      ),
      body: _buildForm(),
    );
  }

  Widget _buildForm() {
    return Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _image != null ? Image.file(_image) : Text('Input Action!'),
            _buildEmailField(),
            _buildPasswordField(),
            _buildSubmitButton(),
          ],
        ));
  }

  Widget _buildEmailField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Email'),
      validator: (String value) {
        if (!RegExp(
                r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
            .hasMatch(value)) {
          return 'This is not a valid email';
        }
      },
      onSaved: (String value) {
        _formData['email'] = value;
      },
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (v) {
        FocusScope.of(context).requestFocus(focusPassword);
      },
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Password'),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Preencha a senha';
        }
      },
      onSaved: (String value) {
        _formData['password'] = value;
      },
      focusNode: focusPassword,
      onFieldSubmitted: (v) {
        _submitForm();
      },
    );
  }

  Widget _buildSubmitButton() {
    return RaisedButton(
      onPressed: () {
        //_submitForm();
        uploadForm().then((value) => print('uploaded'));
      },
      child: Text('SEND'),
    );
  }

  void _submitForm() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      print(_formData);
    }
  }
}
