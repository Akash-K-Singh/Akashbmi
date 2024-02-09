import 'package:flutter/material.dart';
import 'package:mybmi/HomeScreen.dart';
import 'package:mybmi/SplashScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginScreenState();
  }
}

class LoginScreenState extends State<LoginScreen> {
  var nameController = TextEditingController();
  var genderController = TextEditingController();
  String userName = "";
  String userGender = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
          "Login"
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Icon(Icons.person,size:100,color:Colors.green),
            TextField(
                  controller: nameController,
                  cursorColor: Colors.green,
                  style: TextStyle(
                      color: Colors.green,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                      label: Text(
                        "Enter your name",
                        style: TextStyle(
                            color: Colors.green, fontWeight: FontWeight.bold),
                      ),
                      border: new OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: new BorderSide(
                            color: Colors.teal,
                          )),
                      prefixIcon: Icon(
                        Icons.line_weight,
                        color: Colors.green,
                      )),
                      
                ),
                SizedBox(height: 20.0),
                TextField(
                  controller: genderController,
                  cursorColor: Colors.green,
                  style: TextStyle(
                      color: Colors.green,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                      label: Text(
                        "Enter your genders",
                        style: TextStyle(
                            color: Colors.green, fontWeight: FontWeight.bold),
                      ),
                      border: new OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: new BorderSide(
                            color: Colors.teal,
                          )),
                      prefixIcon: Icon(
                        Icons.line_weight,
                        color: Colors.green,
                      )),
                ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () async{

                setState(() { 
                  userName = nameController.text;
                  userGender = genderController.text;
                });

                var sharePref = await SharedPreferences.getInstance();
                sharePref.setBool(SplashScreenState.KEYLOGIN,true);
                sharePref.setString('name',userName);
                sharePref.setString('gender',userGender);

                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyHomePage(title: 'Calculate your BMI')));
                
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
