import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../utils/constant/widgets.dart';

final Uri _url = Uri.parse('https://sites.google.com/view/bdmeetingapp/home');

class PrivacyAndPolicy extends StatelessWidget {
  PrivacyAndPolicy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: Widgets.appBarWidget("Privacy Policy"),
      body: const MaterialApp(
        home: Material(
          child: Center(
            child: ElevatedButton(
              onPressed: _launchUrl,
              child: Text('Show Flutter homepage'),
            ),
          ),
        ),
      ),
          /*
      Column(
        children: [
          Text("Privacy and Policy",
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold
            ),),
          SizedBox(height: 5,),
          Text("Carelan Healthcare is a tech-driven startup, headquartered in Gurugram, Haryana. It was launched to deliver impeccable services to surgeons and their patients. Carelan plans to enhance the ecosystem where the surgical journey is synchronised using technology to connect with surgeons and patients. The platform works on a B2B model with paramount doctors and hospitals to provide end-to-end services to patients."
              "Our clear focus is on offering the hassle-free and best treatment to all the patients."),

        ],
      ),

           */

    );
  }
}

Future<void> _launchUrl() async {
  // if (!await launchUrl(_url)) {
  //   throw 'Could not launch $_url';
  // }
}
