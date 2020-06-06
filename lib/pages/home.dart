import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sosmed/pages/activity_feed.dart';
import 'package:sosmed/pages/search.dart';
import 'package:sosmed/pages/dashboard.dart';
import 'package:sosmed/pages/upload.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:sosmed/utils.dart' as utils;
import 'package:shared_preferences/shared_preferences.dart';


final GoogleSignIn googleSignIn = GoogleSignIn();

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isAuth = false;
  PageController pageController;
  int pageIndex = 0;
  String myurl = utils.login_url;
  TextEditingController _txtUser = TextEditingController();
  TextEditingController _txtPassword = TextEditingController();

  @override
  void initState() {
    super.initState();
    pageController = PageController();
    // Detects when user signed in
    googleSignIn.onCurrentUserChanged.listen((account) {
      handleSignIn(account);
    }, onError: (err) {
      print('Error signing in: $err');
    });
    // Reauthenticate user when app is opened

    //perlu pendalaman lanjut untuk bisa provide di desktop app
    //v13nr android 5 gak jalan
    googleSignIn.signInSilently(suppressErrors: false).then((account) {
      handleSignIn(account);
    }).catchError((err) {
      print('Error signing in: $err');
    });
  }

  doLogin(String username, String passs) async {
    http.post(myurl, headers: {
      'Accept': 'application/json',
      'x-api-key': 'DF1E02B621FBFD5849C54451D13BE778'
    }, body: {
      "username": _txtUser.value.text,
      "password": _txtPassword.value.text,
    }).then((response) {
      //print(response.statusCode);
      //print(response.body);
    });
  }

  Future<bool> showAlert(BuildContext context, String text, String title) {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(text),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.pop(context, true);
              },
            ),
            FlatButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.pop(context, false);
              },
            ),
          ],
        );
      },
    );
  }

  handleSignIn(GoogleSignInAccount account) {
    if (account != null) {
      print('User signed in!: $account');
      setState(() {
        isAuth = true;
      });
    } else {
      setState(() {
        isAuth = false;
      });
    }
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  login() {
    googleSignIn.signIn();
  }

  logout() {
    googleSignIn.signOut();
  }

  onPageChanged(int pageIndex) {
    setState(() {
      this.pageIndex = pageIndex;
    });
  }


_simpanSP(namasp, valuesp) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString(namasp, valuesp);
}

_panggilSP(namasp) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var _ambiltext = prefs.getString(namasp);
  print(_ambiltext);
}


  onTap(int pageIndex) {
    pageController.animateToPage(
      pageIndex,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  yukLogout() {
    setState(() {
      isAuth = false;
    });
  }

  setLogin() {
    setState(() {
      isAuth = true;
    });
  }

  Scaffold buildAuthScreen() {
    return Scaffold(
      body: PageView(
        children: <Widget>[
          Dashboard(),
          ActivityFeed(),
          Upload(),
          Search(),
          RaisedButton(
              child: Text('Logout'),
              onPressed: yukLogout //buildUnAuthScreen//logout,

              ),
        ],
        controller: pageController,
        onPageChanged: onPageChanged,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: CupertinoTabBar(
          currentIndex: pageIndex,
          onTap: onTap,
          activeColor: Theme.of(context).primaryColor,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text("Home"),
            ),
            BottomNavigationBarItem(icon: Icon(Icons.notifications_active)),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.whatshot,
                size: 35.0,
              ),
              title: Text("Absen"),
            ),
            BottomNavigationBarItem(icon: Icon(Icons.search)),
            BottomNavigationBarItem(icon: 
              Icon(Icons.account_circle),
              title: Text("Profile"),
              ),
          ]),
    );
    // return RaisedButton(
    //   child: Text('Logout'),
    //   onPressed: logout,
    // );
  }





  final forgotLabel = FlatButton(
    child: Text(
      'Forgot Password',
      style: TextStyle(color: Colors.black54),
    ),
    onPressed: () {},
  );

  Scaffold buildUnAuthScreen() {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Theme.of(context).accentColor,
              Theme.of(context).primaryColor,
            ],
          ),
        ),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'WiPaL',
              style: TextStyle(
                fontFamily: "Signatra",
                fontSize: 90.0,
                color: Colors.white,
              ),
            ),
            ListView(
              shrinkWrap: true,
              padding: EdgeInsets.only(left: 24.0, right: 24.0),
              children: <Widget>[
                SizedBox(height: 48.0),
                TextField(
                  controller: _txtUser,
                  obscureText: false,
                  style: TextStyle(fontSize: 20.0),
                  decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      hintText: "Username",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32.0))),
                ),
                SizedBox(height: 8.0),
                TextField(
                  controller: _txtPassword,
                  obscureText: true,
                  style: TextStyle(fontSize: 20.0),
                  decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      hintText: "Password",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32.0))),
                ),
                SizedBox(height: 24.0),
                RaisedButton(
                    color: Colors.blue[600],
                    child: Text(
                      "Login",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    onPressed: () {
                      setState(() {
                        //_isLoading = true;
                      });
                      //. request login
                      http.post(myurl, headers: {
                        'Accept': 'application/json',
                        'x-api-key': utils.x_api_key,
                      }, body: {
                        "username": _txtUser.value.text.trim(),
                        "password": _txtPassword.value.text.trim(),
                      }).then((response) {
                        print(response.statusCode);
                        print(response.body);

                        var mData = json.decode(response.body.toString());

                        if (mData != null) {
                          bool vStatus = mData["status"];
                          String vPesan = mData["message"];
                          String vNama = mData["data"]["full_name"];

                          if (vStatus == true) {
                            showAlert(context, vPesan, "Login Sukses");
                            setLogin();
                            _simpanSP('emailSP', _txtUser.value.text.trim());
                            _simpanSP('namaSP', vNama);
                            print("Email =  ");
                            _panggilSP('emailSP');
                            print("Nama =  ");
                            _panggilSP('namaSP');
                          } else {
                            showAlert(context, vPesan, "Login Gagal");
                          }
                        } else {
                          showAlert(context, "Parsing respond error", "Error");
                        }
                      });

                      setState(() {
                        //_checkSession = false;
                      });
                      //Navigator.pushNamed(context, "/crud");
                    }),
                forgotLabel
              ],
            ),
            GestureDetector(
              onTap: login,
              child: Container(
                width: 260.0,
                height: 60.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      'assets/images/google_signin_button.png',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return isAuth ? buildAuthScreen() : buildUnAuthScreen();
  }
}
