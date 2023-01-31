import 'package:flutter/material.dart';

import '../../../utils/constant/app_color.dart';
import '../../../utils/constant/widgets.dart';
// import 'package:url_launcher/url_launcher.dart';

class HelpAndSupport extends StatelessWidget {
  const HelpAndSupport({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Widgets.appBarWidget(""),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          alignment: AlignmentDirectional.topCenter,
          children: [
            Positioned(child: ClipPath(
              child: Container(
                height: MediaQuery.of(context).size.height/3,
                color: AppColor.appbgColor,
              ),
              clipper: CustomClipPath(),
            )),
            Positioned(
              top : 0,
              child: Column(
                children: [
                  SizedBox(height: 40),
                  Widgets.applogo(),
                  SizedBox(height: 40),
                  Container(
                      width: MediaQuery.of(context).size.width-50,
                      margin: const EdgeInsets.all(3.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [BoxShadow(blurRadius: 1,color: Colors.grey,offset: Offset(1,3))]
                      ),
                    child: Column(
                      children: [
                        ListTile(
                          leading: Icon(Icons.mobile_friendly),
                          title: Text("+918447960512"),
                          subtitle: Text("Mobile"),
                          // trailing: Icon(Icons.whatsapp,
                          // color: AppColor.clGreen,),
                          // onTap: () async => await launch(
                          //     "https://wa.me/${918447960512}?text=Welcome to Carelan Healthcare"),
                        ),
                        ListTile(
                          leading: Icon(Icons.email_outlined),
                          title: Text("info@carelan.in"),
                          subtitle: Text("Email"),
                        ),
                        /*
                        ListTile(
                          leading: Icon(Icons.language),
                          title: Text("https://www.carelan.in/"),
                          subtitle: Text("Website"),
                        ),

                         */
                        ListTile(
                          leading: Icon(Icons.location_on_outlined),
                          title: Text("P-359, Sector-28, Gurugram, HR"),
                          subtitle: Text("Address"),
                        )
                      ],
                    ),

                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
