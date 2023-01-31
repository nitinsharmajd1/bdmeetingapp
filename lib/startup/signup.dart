import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/constant/app_color.dart';
import '../utils/constant/appfont.dart';
import '../utils/constant/widgets.dart';
import 'loginmodel.dart';
import 'loginservice.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  late SharedPreferences? sf;
  bool isLoading = false;
  final TextEditingController _uncontroller = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _pwdcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Widgets.appBarWidget("Register"),
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
                Positioned(top: 35, child: Widgets.applogo()),
                Positioned(
                  top: MediaQuery.of(context).size.height / 6,
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
                                padding: const EdgeInsets.all(12.0),
                                child: Text(
                                  "Create Account",
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
                                      SizedBox(height: 10),
                                      TextFormField(
                                        controller: _mobileController,
                                        keyboardType: TextInputType.phone,
                                        maxLength: 10,
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.blue,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        decoration: InputDecoration(
                                          focusColor: Colors.white,
                                          //add prefix icon
                                          prefixIcon: Icon(
                                            Icons.phone_android,
                                            color: Colors.grey,
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10.0),
                                          ),
                                          fillColor: Colors.grey,
                                          hintText: "Phone",
                                          hintStyle: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 16,
                                            fontFamily: "verdana_regular",
                                            fontWeight: FontWeight.w400,
                                          ),
                                          //create lable
                                          labelText: 'Phone',
                                          //lable style
                                          labelStyle: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 14,
                                            fontFamily: "verdana_regular",
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 10),
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
                                      child: const Text('Register'),
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

                                          signup(
                                              name: _uncontroller.text,
                                              password : _pwdcontroller.text,
                                              mobile: _mobileController.text
                                          ).then((value) async {
                                            LoginModel logindata = value;
                                            if (logindata.status == 1) {
                                              sf = await SharedPreferences.getInstance();
                                              setState(() {
                                                sf!.setString('username', _uncontroller.text.toString());
                                                isLoading = false;
                                              });

                                              Navigator.pushNamed(context, '/home');
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                  content: Text(
                                                    logindata.message ?? "",
                                                  )));
                                            }
                                            /* else if(logindata.status == 0){
                                              if(_controller.text == "0000000000"){
                                                print("------------");
                                                Navigator.pushNamed(
                                                    context, '/OtpScreen',
                                                    arguments: _controller.text);

                                              } else {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                    content: Text(
                                                      loginByMobileModel.msg ?? "",
                                                    )));
                                              }
                                            }*/
                                          });
                                        }
                                      }),
                                ),
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
