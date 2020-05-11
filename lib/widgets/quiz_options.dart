import 'package:flutter/material.dart';
import 'package:sosmed/models/category.dart';

import 'package:google_sign_in/google_sign_in.dart';

import 'package:sosmed/pages/home.dart';

final GoogleSignIn googleSignIn = GoogleSignIn();

class QuizOptionsDialog extends StatefulWidget {
  final Category category;

  const QuizOptionsDialog({Key key, this.category}) : super(key: key);

  @override
  _QuizOptionsDialogState createState() => _QuizOptionsDialogState();
}

class _QuizOptionsDialogState extends State<QuizOptionsDialog> {

  bool processing;
  bool isAuth = false;

  @override
  void initState() {
    super.initState();
 
    processing = false;
  }

  Future navigateToSubPage(context) async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
  }

  _logout() {
    googleSignIn.signOut();
    setState(() {
      isAuth = false;
    });
    
  Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Home()),
    );
    
    //return Home.buildUnAuthScreen();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16.0),
            color: Colors.grey.shade200,
            child: Text(
              widget.category.name,
              style: Theme.of(context).textTheme.title.copyWith(),
            ),
          ),
          SizedBox(height: 10.0),
          Text("Apakah Anda Yakin Akan Logout?"),
          SizedBox(height: 20.0),
          SizedBox(height: 20.0),
          processing
              ? CircularProgressIndicator()
              : RaisedButton(
                  child: Text("Ya"),
                  onPressed: _logout,
                ),
          processing
              ? CircularProgressIndicator()
              : RaisedButton(
                  child: Text("Tidak"),
                  onPressed: _startQuiz,
                ),
          SizedBox(height: 20.0),
        ],
      ),
    );
  }


  void _startQuiz() async {
    setState(() {
      processing = true;
    });

    ///kode v13nr start option
    setState(() {
      processing = false;
    });
  }
}
