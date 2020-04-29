import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';

class ActivityFeed extends StatefulWidget {
  @override
  _ActivityFeedState createState() => _ActivityFeedState();
}

class _ActivityFeedState extends State<ActivityFeed> {

  // Getting value from TextField widget.
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();
    // Boolean variable for CircularProgressIndicator.
  bool visible = false ;
  


  Future webCall() async{

    // Showing CircularProgressIndicator using State.
    setState(() {
     visible = true ; 
    });

    // Getting value from Controller
    String name = nameController.text;
    String email = emailController.text;
    String phoneNumber = phoneNumberController.text;

    // API URL
    var url = 'http://10.0.2.2/sosmed/crud/submit_data.php';

    // Store all data with Param Name.
    var data = {'name': name, 'email': email, 'phone_number' : phoneNumber};

    // Starting Web Call with data.
    var response = await http.post(url, body: json.encode(data));

    // Getting Server response into variable.
    var message = jsonDecode(response.body);

    // If Web call Success than Hide the CircularProgressIndicator.
    if(response.statusCode == 200){
      setState(() {
       visible = false; 
      });
    }

    // Showing Alert Dialog with Response JSON.
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(message),
          actions: <Widget>[
            FlatButton(
              child: new Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );

  }
  
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Center(
          child: Column(
            children: <Widget>[

              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text('Fill All Information in Form', 
                       style: TextStyle(fontSize: 22))),

              Container(
              width: 280,
              padding: EdgeInsets.all(10.0),
              child: TextField(
                  controller: nameController,
                  autocorrect: true,
                  decoration: InputDecoration(hintText: 'Enter Name Here'),
                )
              ),
 
              Container(
              width: 280,
              padding: EdgeInsets.all(10.0),
              child: TextField(
                  controller: emailController,
                  autocorrect: true,
                  decoration: InputDecoration(hintText: 'Enter Email Here'),
                )
              ),
 
              Container(
              width: 280,
              padding: EdgeInsets.all(10.0),
              child: TextField(
                  controller: phoneNumberController,
                  autocorrect: true,
                  decoration: InputDecoration(hintText: 'Enter Phone Number Here'),
                )
              ),

              RaisedButton(
                onPressed: webCall,
                color: Colors.pink,
                textColor: Colors.white,
                padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
                child: Text('Click Here To Submit Data To Server'),
              ),

              Visibility(
                visible: visible, 
                child: Container(
                  margin: EdgeInsets.only(bottom: 30),
                  child: CircularProgressIndicator()
                  )
                ),

            ],
          ),
        )));
  
  }
}
