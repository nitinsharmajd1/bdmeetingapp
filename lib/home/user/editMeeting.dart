// import 'dart:html';
import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/constant/app_color.dart';
import '../../utils/constant/widgets.dart';
import 'meetingModel.dart';
import 'mettingService.dart';

class EditMeeting extends StatefulWidget {
  const EditMeeting({Key? key,
  this.id,
  this.surgeonName,
  this.surgeonCategory,
  this.phoneNo,
  this.remark,
  this.date,
  this.time,
  this.address,
  this.status,
  this.isFrom
}) : super(key: key);
final id;
final surgeonName;
final surgeonCategory;
final phoneNo;
final remark;
final date;
final time;
final address;
final status;
final isFrom;
  @override
  State<EditMeeting> createState() => _EditMeetingState();
}

class _EditMeetingState extends State<EditMeeting> {
  TextEditingController surgeonName = TextEditingController();
  TextEditingController mobile = TextEditingController();
  TextEditingController meetingTime = TextEditingController();
  TextEditingController surgeryDateController = TextEditingController();
  TextEditingController sugeryCategory = TextEditingController();
  TextEditingController addressContrlller = TextEditingController();
  TextEditingController remarkController = TextEditingController();
  TextEditingController intrestedController = TextEditingController();
  TextEditingController mouController = TextEditingController();
  TimeOfDay selectedTimeAT = TimeOfDay(hour: 0, minute: 0);
  bool isLoading = false;
  bool clinicImage = false;
  PickedFile? pickedImage;
  late File? imageFile = null;
  String imagePath = "";
  bool locationLoading = false;
  late SharedPreferences? sf;
  String username = '';
  bool mouFlag = true;


  void initState(){
    surgeonName = new TextEditingController(text: widget.surgeonName);
    mobile = new TextEditingController(text: widget.phoneNo);
    List? atTime = ((widget.time) ?? '0:0').split(':') as List;
    String athr = atTime[0];
    String atmnt = atTime[1];
    selectedTimeAT = TimeOfDay(hour: int.parse(athr), minute: int.parse(atmnt));
    surgeryDateController = new TextEditingController(text: widget.date);
    addressContrlller = new TextEditingController(text: widget.address);
    sugeryCategory = new TextEditingController(text: widget.surgeonCategory);
    remarkController = new TextEditingController(text: widget.remark);
    initial();
    super.initState();
  }

  initial() async {
    sf = await SharedPreferences.getInstance();
    setState(() {
      username = sf!.getString('username')??"";
    });
    Position position = await _getGeoLocationPosition();
    location ='Lat: ${position.latitude} , Long: ${position.longitude}';
    GetAddressFromLatLong(position);
  }

  String location ='Null, Press Button';
  String Address = '';
  Future<Position> _getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }
  Future<void> GetAddressFromLatLong(Position position)async {
    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
    print(placemarks);
    Placemark place = placemarks[0];
    Address = '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
    setState(()  {
      locationLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Widgets.appBarWidget(widget.status+" Meetings"),
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
              TextField(
                controller: mouController,
                keyboardType: TextInputType.number,
                maxLength: 2,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  hintText: 'MOU(%)',
                  labelText: 'MOU(%)',
                  //errorText: _validate ? 'Name Field Shouldn\'t Be Empty' : null,
                ),
                onChanged: (value){
                  setState(() {
                    if(mouController.text.isEmpty) {
                      mouFlag = true;
                    } else {
                      mouFlag = false;
                    }
                  });
                },
              ),
              mouFlag ? Row(
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
                    height: Platform.isIOS?55: 45,
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
                              var da = date?.day??"";
                              var m = date?.month??"";
                              var y = date?.year??"";
                              surgeryDateController.text = (y.toString()+'-'+m.toString()+'-'+da.toString());
                        },
                      ))
                ],
              )
                  : SizedBox(),
              SizedBox(height: 10),
              TextField(
                controller: sugeryCategory,
                keyboardType: TextInputType.phone ,
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
              ),
              SizedBox(height: 10),
              TextField(
                controller: addressContrlller,
                maxLines: 2,
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Address',
                  labelText: 'Address',
                  //errorText: _validate ? 'Name Field Shouldn\'t Be Empty' : null,
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: remarkController,
                maxLines: 2,
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Remark',
                  labelText: 'Remark',
                  //errorText: _validate ? 'Name Field Shouldn\'t Be Empty' : null,
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: intrestedController,
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Intrested/Not intrested/May be',
                  labelText: 'Intrested/Not intrested/May be',
                  //errorText: _validate ? 'Name Field Shouldn\'t Be Empty' : null,
                ),
              ),
              SizedBox(height: 10),
              !clinicImage ? InkWell(
                child: Container(
                  height: 30,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: imageFile == null
                      ? Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.add_a_photo_outlined,
                          color: AppColor.btnColor,
                        ),
                        SizedBox(width: 10),
                        Text("Add Clinic Image",
                            style: TextStyle(color: AppColor.btnColor)),
                      ],
                    ),
                  )
                      : Container(
                      child: Row(
                        //mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.add_link, color: Colors.green),
                          SizedBox(width: 10),
                          Text(
                            "Clinic image added",
                            style: TextStyle(color: Colors.green),
                          ),
                        ],
                      )),
                ),
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: ((builder) => bottomSheet(context)),
                  );
                },
              ) : SizedBox(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(child: Text(Address)),
              ),
              /*locationLoading ?
                  CircularProgressIndicator()
              :
              //Center(child: Text(Address)),
              ElevatedButton(onPressed: () async{
                setState(()  {
                  locationLoading = true;
                });
                Position position = await _getGeoLocationPosition();
                location ='Lat: ${position.latitude} , Long: ${position.longitude}';
                GetAddressFromLatLong(position);
              },
                  child: Text('Get Location')
                  // child: Text(Address)
              ),*/

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
                    onPressed: () async {
                      DateTime dateToday =new DateTime.now();
                      String cdate = dateToday.toString().substring(0,10);
                      String ctime = dateToday.toString().substring(11,19);
                      //print(cdate +" "+ ctime);
                      if (surgeonName.text.isEmpty) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(
                            content: Text(
                              "Please enter Surgeon name",
                            )));
                        setState(() {
                          isLoading = false;
                        });
                      } else if(mobile.text.isEmpty){
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(
                            content: Text(
                              "Please enter mobile no.",
                            )));
                        setState(() {
                          isLoading = false;
                        });
                      } else if(remarkController.text.isEmpty) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(
                            content: Text(
                              "Please enter Remark",
                            )));
                        setState(() {
                          isLoading = false;
                        });
                      }else {

                        String base64string = "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";
                        if (imageFile != null) {
                          imagePath = imageFile!.path;
                          File imagefile = File(imagePath);
                          Uint8List imagebytes = await imagefile
                              .readAsBytes();
                          setState(() {
                            base64string = base64.encode(imagebytes);
                          });
                        }

                        setState(() {
                          isLoading = true;
                        });
                        String time = selectedTimeAT.hour.toString() +
                            ':' +
                            selectedTimeAT.minute.toString();

                        updateMeeting(
                            id : widget.id,
                            addedkey: username,
                            name : surgeonName.text,
                            mobile : mobile.text,
                            time : mouFlag ? time : ctime,
                            date : mouFlag ? surgeryDateController.text : cdate,
                            caregory : sugeryCategory.text,
                            address : addressContrlller.text,
                            remark : remarkController.text,
                            intrested : intrestedController.text,
                            mou : mouController.text,
                            imageString : base64string,
                            liveLocation : Address
                        ).then((value) {
                          AddMeetingModel meetingResponce = value;
                          if (meetingResponce.status == 1) {
                            setState(() {
                              isLoading = false;
                            });
                            Future.delayed(Duration(seconds: 10));
                            Navigator.pushNamed(context, '/home');

                            ScaffoldMessenger.of(context)
                                .showSnackBar(SnackBar(
                                content: Text(
                                  meetingResponce.message ?? "",
                                )));
                          } else {
                            setState(() {
                              isLoading = false;
                            });
                            print(meetingResponce.message);
                            ScaffoldMessenger.of(context)
                                .showSnackBar(SnackBar(
                                content: Text(
                                  meetingResponce.message ?? "",
                                )));
                          }

                        });
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
  Widget bottomSheet(BuildContext context) {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          Text(
            "Choos camera to take clinic image",
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.camera),
              onPressed: () {
                takePhotoFromCamera();
                Navigator.pop(context);
              },
              label: Text("Camera"),
            ),
          ])
        ],
      ),
    );
  }

  void takePhotoFromCamera() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 750,
      maxHeight: 750,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }
}

