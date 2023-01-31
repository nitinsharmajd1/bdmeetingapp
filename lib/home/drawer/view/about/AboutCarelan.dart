import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../utils/constant/widgets.dart';

class AboutCarelan extends StatelessWidget {
  const AboutCarelan({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Widgets.appBarWidget("About Carelan"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("About Us",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold
              ),),
              SizedBox(height: 5,),
              Text("Carelan Healthcare is a tech-driven startup, headquartered in Gurugram, Haryana. It was launched to deliver impeccable services to surgeons and their patients. Carelan plans to enhance the ecosystem where the surgical journey is synchronised using technology to connect with surgeons and patients. The platform works on a B2B model with paramount doctors and hospitals to provide end-to-end services to patients."
                  "Our clear focus is on offering the hassle-free and best treatment to all the patients."),
            //Vision ..............
              SizedBox(height: 10),
              Text("Vision",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                ),),
              SizedBox(height: 5),
              Text("Our vision is to improve the healthcare ecosystem by mapping and synchronising Hospital Infrastructure per Surgeon & Patient convenience. And provide quality and standardised experience of international standards to all patients."),

              //Mission ..............
              SizedBox(height: 10),
              Text("Mission",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                ),),
              SizedBox(height: 5),
              Text("Provide affordable and international standard healthcare to all patients.\n\n"
                "Access to hospitals with the latest technology at an affordable price.\n"
                "Standardised patient experience irrespective of the hospital.\n"
                "Maximise the use of hospital infrastructure. \n"),

              //Goal ..............
              SizedBox(height: 10),
              Text("Goal",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                ),),
              SizedBox(height: 5),
              Text("Is to solve operational challenges for all the surgeons practising in multiple hospitals.\n\n"
                "Pre and post-surgery assistance.\n"
                "Increase community reach.\n"
                "Quality healthcare for all.")
            ],

          ),
        ),
      ),
    );
  }
}
