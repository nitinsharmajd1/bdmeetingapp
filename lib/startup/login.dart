import 'package:bdmeeting/startup/loginmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../home/user/userhome.dart';
import '../utils/constant/app_color.dart';
import '../utils/constant/app_string.dart';
import '../utils/constant/appfont.dart';
import '../utils/constant/widgets.dart';
import 'loginservice.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late SharedPreferences? sf;
  bool isLoading = false;
  final TextEditingController _uncontroller = TextEditingController();
  final TextEditingController _pwdcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            color: Colors.white,
            child: Stack(
              alignment: AlignmentDirectional.topCenter,
              children: [
                Positioned(
                  //top:  0,
                  child: ClipPath(
                    child: Container(
                      height: MediaQuery.of(context).size.height / 2,
                      color: AppColor.appbgColor,
                    ),
                    clipper: CustomClipPath(),
                  ),
                ),
                Positioned(top: 100, child: Widgets.applogo()),
                Positioned(
                  top: MediaQuery.of(context).size.height / 2 - 100,
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16.0),
                        child: Container(
                          margin: const EdgeInsets.all(3.0),
                          width: MediaQuery.of(context).size.width - 50,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 1,
                                    color: Colors.grey,
                                    offset: Offset(1, 3))
                              ]),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Get Started",
                                  style: Font.bold20(),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("Enter username and password",
                                  style: Font.normal14(),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    children: [
                                      TextFormField(
                                          controller: _uncontroller,
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.blue,
                                            fontWeight: FontWeight.w400,
                                          ),
                                          decoration: InputDecoration(
                                            focusColor: Colors.white,
                                            //add prefix icon
                                            prefixIcon: Icon(
                                              Icons.person_outline_rounded,
                                              color: Colors.grey,
                                            ),
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(10.0),
                                            ),
                                              fillColor: Colors.grey,
                                              hintText: "Username",
                                            hintStyle: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 16,
                                              fontFamily: "verdana_regular",
                                              fontWeight: FontWeight.w400,
                                            ),
                                            //create lable
                                            labelText: 'Username',
                                            //lable style
                                            labelStyle: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 14,
                                              fontFamily: "verdana_regular",
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                      ),
                                      SizedBox(height: 10,),
                                      TextFormField(
                                        controller: _pwdcontroller,
                                        obscureText: true,
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.blue,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        decoration: InputDecoration(
                                          focusColor: Colors.white,
                                          //add prefix icon
                                          prefixIcon: Icon(
                                            Icons.password,
                                            color: Colors.grey,
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10.0),
                                          ),
                                          fillColor: Colors.grey,
                                          hintText: "Password",
                                          hintStyle: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 16,
                                            fontFamily: "verdana_regular",
                                            fontWeight: FontWeight.w400,
                                          ),
                                          //create lable
                                          labelText: 'Password',
                                          //lable style
                                          labelStyle: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 16,
                                            fontFamily: "verdana_regular",
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )),
                              Center(
                                child: ButtonTheme(
                                  minWidth:
                                      MediaQuery.of(context).size.width - 100,
                                  height: 45,
                                  child: isLoading
                                      ? CircularProgressIndicator()
                                      : RaisedButton(
                                          color: AppColor.btnColor,
                                          child: const Text('Next'),
                                          splashColor: Colors.pink,
                                          elevation: 6,
                                          textColor: Colors.white,
                                          onPressed: () {
                                            if (_uncontroller.text.isEmpty) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                      content: Text(
                                                "Please enter your username",
                                              )));
                                              setState(() {
                                                isLoading = false;
                                              });
                                            } else if(_pwdcontroller.text.isEmpty){
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                  content: Text(
                                                    "Please enter password",
                                                  )));
                                              setState(() {
                                                isLoading = false;
                                              });
                                          } else {
                                              setState(() {
                                                isLoading = true;
                                              });
                                              login(
                                                  name: _uncontroller.text,
                                                  password : _pwdcontroller.text
                                              ).then((value) async {
                                            LoginModel logindata = value;
                                            var data = logindata.datalist
                                                ?.map((e) => e.toJson())
                                                .toList()[0];
                                            if(data!["status"] != "0"){
                                            if (logindata.status == 1) {
                                              sf = await SharedPreferences.getInstance();
                                              setState(() {
                                                sf!.setString('username', _uncontroller.text.toString());
                                                isLoading = false;
                                              });
                                              if(_uncontroller.text == "Admin"){
                                                Navigator.pushNamed(context, '/adminhome');
                                              } else {
                                              Navigator.pushNamed(context, '/home');
                                              }
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                  content: Text(
                                                    logindata.message ?? "",
                                                  )));
                                            } else {
                                              setState(() {
                                                isLoading = false;
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                    content: Text(
                                                      logindata.message ?? "",
                                                    )));
                                              });
                                            }
                                            } else {
                                              setState(() {
                                                isLoading = false;
                                              });
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                  content: Text(
                                                    "Please contact to admin or signup again",
                                                   )));
                                            }
                                          });
                                            }
                                          }),
                                ),
                              ),
                              InkWell(
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Center(child: Text("Sign up",
                                  style: Font.font600B17blue(),)),
                                ),
                                onTap:(){
                                  Navigator.pushNamed(context, '/register');
                                }
                              ),
                              SizedBox(height: 10),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
