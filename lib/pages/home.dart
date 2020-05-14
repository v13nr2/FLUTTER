import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sosmed/pages/activity_feed.dart';
import 'package:sosmed/pages/search.dart';
import 'package:sosmed/pages/dashboard.dart';
import 'package:sosmed/pages/upload.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;


final GoogleSignIn googleSignIn = GoogleSignIn();

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isAuth = false;
  PageController pageController;
  int pageIndex = 0;


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
    googleSignIn.signInSilently(suppressErrors: false).then((account) {
      handleSignIn(account);
    }).catchError((err) {
      print('Error signing in: $err');
    });
  }


static doLogin(String username, String password) async {
  
    String myurl =
        "https://doktorsiaga.co.id/api/user/login";
    http.post(myurl, headers: {
      'Accept': 'application/json',
      'x-api-key': 'DF1E02B621FBFD5849C54451D13BE778'
    }, body: {
      "username": username,
      "password": password
    }).then((response) {
      print(response.statusCode);
      print(response.body);     

  }
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

  onTap(int pageIndex) {
    pageController.animateToPage(
      pageIndex,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
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
            onPressed: logout,
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
            BottomNavigationBarItem(icon: Icon(Icons.whatshot)),
            BottomNavigationBarItem(icon: Icon(Icons.notifications_active)),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.photo_camera,
                size: 35.0,
              ),
            ),
            BottomNavigationBarItem(icon: Icon(Icons.search)),
            BottomNavigationBarItem(icon: Icon(Icons.account_circle)),
          ]),
    );
    // return RaisedButton(
    //   child: Text('Logout'),
    //   onPressed: logout,
    // );
  }



  static final email = TextFormField(
    keyboardType: TextInputType.emailAddress,
    autofocus: false,
    initialValue: '',
    style: TextStyle(fontSize: 18.0, color: Colors.white),
    cursorColor: Colors.white,
    decoration: InputDecoration(
      hintText: 'Email',
      hintStyle: TextStyle(fontSize: 18.0, color: Colors.white),
      contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
    ),
  );

  static final password = TextFormField(
    autofocus: false,
    initialValue: '',
    obscureText: true,
    style: TextStyle(fontSize: 18.0, color: Colors.white),
    cursorColor: Colors.white,
    decoration: InputDecoration(
      hintText: 'Password',
      hintStyle: TextStyle(fontSize: 18.0, color: Colors.white),
      contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
    ),
  );

  final loginButton = Padding(
    padding: EdgeInsets.symmetric(vertical: 16.0),
    child: Material(
      borderRadius: BorderRadius.circular(30.0),
      shadowColor: Colors.lightBlueAccent.shade100,
      elevation: 5.0,
      child: MaterialButton(
        minWidth: 200.0,
        height: 42.0,
        onPressed: () {
          //Navigator.of(context).pushNamed(HomePage.tag);
          doLogin('user@user.com', 'useruser');
        },
        child: Text(
          'Log In',
          style: TextStyle(color: Colors.black),
        ),
      ),
    ),
  );

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
              'Primera',
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
                email,
                SizedBox(height: 8.0),
                password,
                SizedBox(height: 24.0),
                loginButton,
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
