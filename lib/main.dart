import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
// Eeshan Dutta
// Task 5 Sparks Foundation
void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isLoggedIn = false;
  int f = 0;
  int g=0;
  Map _userObj = {};
  GoogleSignInAccount _userObj1;
  GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.greenAccent,
        body: Center(
          child: _isLoggedIn
              ? f==1 ?
          Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.network(
                      _userObj["picture"]["data"]["url"],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(_userObj["name"], style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),),
                    SizedBox(
                      height: 10,
                    ),
                    Text(_userObj["email"] , style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),),
                    SizedBox(
                      height: 10,
                    ),
                    ElevatedButton.icon(
                      label: Text(
                        "Logout",
                        style: TextStyle(fontSize: 15),
                      ),
                      icon: Icon(Icons.login),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.redAccent,
                        onPrimary: Colors.white,
                        shadowColor: Colors.grey,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                      ),
                      onPressed: () {
                        FacebookAuth.instance.logOut().then((value) {
                          setState(() {
                            _isLoggedIn = false;
                            _userObj = {};
                            f=0;
                          });
                        });
                      },
                    ),
                  ],
                )
          : Column(
            mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Image.network(_userObj1.photoUrl),
                ),
                Text(_userObj1.displayName , style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),),
                SizedBox(height: 10,),
                Text(_userObj1.email, style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),),
                SizedBox(height: 10,),
                ElevatedButton( //Logout Function
                    onPressed: () {
                      _googleSignIn.signOut().then((value) {
                        setState(() {
                          _isLoggedIn = false;
                        });
                      }).catchError((e) {});
                    },
                    child: Text("Logout"))
              ],)
              : Column(
            mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Image.asset("images/auth.png" , height: 200, width: 200,),
                  ),
                  ElevatedButton.icon(
                      label: Text("Login with Facebook"),
                      icon: Icon(Icons.login),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blueAccent,
                        onPrimary: Colors.white,
                        shadowColor: Colors.grey,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10))),
                      ),
                      onPressed: () async {
                        FacebookAuth.instance.login(
                            permissions: ["public_profile", "email"]).then((value) {
                          FacebookAuth.instance.getUserData().then((userData) {
                            setState(() {
                              _isLoggedIn = true;
                              _userObj = userData;
                              f=1;
                            });
                          });
                        });
                      },
                    ),
                  ElevatedButton.icon(
                    label: Text("Login with Google"),
                    icon: Icon(Icons.login),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                      onPrimary: Colors.white,
                      shadowColor: Colors.grey,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                    ),
                    onPressed: () async {
                      _googleSignIn.signIn().then((userData) {
                        setState(() {
                          _isLoggedIn = true;
                          _userObj1 = userData;
                        });
                      }).catchError((e) {
                        print(e);
                      });
                    },
                  ),
                ],
              ),
        ),
      ),
    );
  }
}
