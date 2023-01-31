// import 'dart:html';
import 'dart:io';
import 'package:bdmeeting/utils/constant/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../startup/login.dart';
import '../../utils/constant/app_color.dart';
import '../../utils/constant/appfont.dart';
import 'meetingModel.dart';
import 'mettingService.dart';

class AddNewMeeting extends StatefulWidget {
  const AddNewMeeting({Key? key}) : super(key: key);
  @override
  State<AddNewMeeting> createState() => _AddNewMeetingState();
}

class _AddNewMeetingState extends State<AddNewMeeting> {
  late SharedPreferences? sf;
  bool catFlag = false;
  String username = '';
  void initState() {
    initial();
    super.initState();
  }
  initial() async {
    sf = await SharedPreferences.getInstance();
    setState(() {
      username = sf!.getString('username')??"";
    });
  }

  TextEditingController surgeonName = TextEditingController();
  TextEditingController mobile = TextEditingController();
  TextEditingController meetingTime = TextEditingController();
  TextEditingController surgeryDateController = TextEditingController();
  TextEditingController addressContrlller = TextEditingController();
  TextEditingController categoryContrler = TextEditingController();
  TimeOfDay selectedTimeAT = TimeOfDay(hour: 0, minute: 0);
  bool isLoading = false;

  var items = [
    'General Surgery',
    'Gynaeclogy',
    'Orthopeadics',
    'Urology',
    'Ent',
    'Vascular',
    'Bariatric',
    'General Physician',
    'Neurology',
    'Plastic Surgery',
    'Diagnostic',
    'Hospital',
    'Others'
  ];
  String paymentType = 'Others';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Widgets.appBarWidget("New Meetings"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                controller: surgeonName,
                decoration: InputDecoration(
                  focusColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  fillColor: Colors.grey,
                  hintText: "Surgeon Name",
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                  //create lable
                  labelText: 'Surgeon Name',
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: mobile,
                maxLength: 10,
                keyboardType: TextInputType.phone ,
                decoration: InputDecoration(
                  focusColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  fillColor: Colors.grey,
                  hintText: "Surgeon Mobile",
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                  //create lable
                  labelText: 'Surgeon Mobile',
                ),
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        border: Border.all(color: Colors.grey)),
                    child: InkWell(
                      onTap: () {
                        _selectTimeAT(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              child: Text(
                                'Meeting Time',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Text(
                              "${selectedTimeAT.hour}:${selectedTimeAT.minute}",
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  Container(
                      height: defaultTargetPlatform == TargetPlatform.iOS? 55:45,//Platform.isIOS?55: 45,
                      width: 120,
                      decoration: BoxDecoration(
                        //borderRadius: BorderRadius.circular(15.0),
                        // border: Border.all(color: Colors.white)
                      ),
                      child: TextField(
                        controller: surgeryDateController,
                        readOnly: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          labelText: "Sugery Date",
                          hintText: "Sugery Date",
                        ),
                        onTap: () async {
                          var date = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2021),//DateTime.now(), //DateTime(1900),
                              lastDate: DateTime(2100));
                          // var da = date?.day;
                          // var m = date?.month;
                          // var y = date?.year;

                          surgeryDateController.text = //(da! + m! + y!) as String;
                          date.toString().substring(0, 10);
                        },
                      ))
                ],
              ),
              SizedBox(height: 10),
              TextField(
                controller: addressContrlller,
                maxLines: 3,
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Address',
                  labelText: 'Address',
                  //errorText: _validate ? 'Name Field Shouldn\'t Be Empty' : null,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Category",
                      style : Font.font600B17blue()),
                  DropdownButton(
                    value: paymentType,
                    dropdownColor: AppColor.appbgColor,
                    focusColor: Colors.grey,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: items.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        paymentType = newValue!;
                        if(paymentType == "Others"){
                          catFlag = true;
                        } else {
                          catFlag = false;
                        }
                      });
                    },
                  ),
                ],
              ),
              catFlag ?TextField(
                controller: categoryContrler,
                keyboardType: TextInputType.text ,
                decoration: InputDecoration(
                  focusColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  fillColor: Colors.grey,
                  hintText: "Category",
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                  //create lable
                  labelText: 'Category',
                ),
              )
              :
              Container(),
              SizedBox(height: 10),
              ButtonTheme(
                minWidth:
                MediaQuery.of(context).size.width - 100,
                height: 45,
                child: isLoading
                    ? CircularProgressIndicator()
                    : RaisedButton(
                    color: AppColor.btnColor,
                    child: const Text('Submit'),
                    splashColor: Colors.pink,
                    elevation: 6,
                    textColor: Colors.white,
                    onPressed: () {

                        if (surgeonName.text.isEmpty) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar(
                              content: Text(
                                "Please enter Surgeon name",
                              )));
                          setState(() {
                            isLoading = false;
                          });
                        } else if (mobile.text.isEmpty) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar(
                              content: Text(
                                "Please enter mobile no.",
                              )));
                          setState(() {
                            isLoading = false;
                          });
                        } else {
                          if(username == ""){
                            Widgets.showAlertDialog(context, "Please signup to use this app");
                            Future.delayed(Duration(seconds: 3),(){
                              Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (BuildContext context) => LoginPage()),
                                    (Route route) => false,
                              );
                            });

                          } else {
                          setState(() {
                            isLoading = true;
                          });
                          String time = selectedTimeAT.hour.toString() +
                              ':' +
                              selectedTimeAT.minute.toString();
                          addMeeting(
                              addedby: username,
                              name: surgeonName.text,
                              mobile: mobile.text,
                              time: time,
                              date: surgeryDateController.text,
                              address: addressContrlller.text,
                              type: catFlag
                                  ? categoryContrler.text
                                  : paymentType
                          ).then((value) {
                            AddMeetingModel meetingResponce = value;
                            if (meetingResponce.status == 1) {
                              setState(() {
                                isLoading = false;
                              });
                              Navigator.pushNamed(context, '/home');

                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                  content: Text(
                                    meetingResponce.msg ?? "",
                                  )));
                            } else {
                              setState(() {
                                isLoading = false;
                              });
                              print(meetingResponce.msg);
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                  content: Text(
                                    meetingResponce.msg ?? "",
                                  )));
                            }
                          });
                        }
                        }
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
  _selectTimeAT(BuildContext context) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: selectedTimeAT,
      initialEntryMode: TimePickerEntryMode.input,
    );
    if (timeOfDay != null && timeOfDay != selectedTimeAT) {
      setState(() {
        selectedTimeAT = timeOfDay;
      });
    }
  }
}
