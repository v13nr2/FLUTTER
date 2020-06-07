import 'package:flutter/material.dart';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sosmed/utils.dart' as utils;
import 'package:http_parser/http_parser.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  String vPesan;
  File _image;
  final imagePicker = ImagePicker();

  TextEditingController _txtUser = TextEditingController();
  TextEditingController _txtEmail = TextEditingController();

  Dio dio = Dio();

  Future<File> getImageCam() async {
    var image =
        await imagePicker.getImage(source: ImageSource.camera, maxHeight: 180);

    return File(image.path);
  }




@override
void initState() {
      super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _txtUser.text = await _panggilSP('namaSP');
      _txtEmail.text = await _panggilSP('emailSP');
    });
}

  

_panggilSP(namasp) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var _ambiltext = prefs.getString(namasp);
  return _ambiltext;
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
        'name': _txtUser.value.text,
        'bertugas': _txtUser.value.text,
        'deskripsi': _txtEmail.value.text,
        //'photo': fileName+'.jpg',
      });

      var response = await dio.post(url,
          data: formData,
          options: Options(headers: {'x-api-key': utils.x_api_key}));
      //print response dari server
      print(response.data);
      print(response.statusCode);
      //print(response.request);
      if (response.statusCode == 200) {
        // var mData = json.decode(response.data.toString());

        // //if (mData != null) {
        //   vPesan = mData["message"];
        //   print("pesan = ");
        //   print(vPesan);
        // //}
        Fluttertoast.showToast(
            msg: "Foto Berhasil di Upload",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
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
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: TextFormField(
        decoration: InputDecoration(labelText: 'Email'),
        controller: _txtEmail,
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
      ),
    );
  }

  Widget _buildPasswordField() {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: TextFormField(
        decoration: InputDecoration(labelText: 'Nama'),
        controller: _txtUser,
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
      ),
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
