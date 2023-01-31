import 'package:flutter/material.dart';
import '../../../utils/constant/widgets.dart';
import 'about/AboutCarelan.dart';
import 'package:url_launcher/url_launcher.dart';

final Uri _urlPandP = Uri.parse('https://sites.google.com/view/carelan-healthcare/home');
final Uri _urlTandT = Uri.parse('https://sites.google.com/view/carelanhealthcaretandc/home');
final Uri _urlcmctGdline = Uri.parse('https://sites.google.com/view/community-guideline/home');

class AboutList extends StatefulWidget {
  const AboutList({Key? key}) : super(key: key);

  @override
  State<AboutList> createState() => _AboutListState();
}

class _AboutListState extends State<AboutList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Widgets.appBarWidget("About"),
      body: Column(
        children: [
          ListTile(
            title: Text('About Carelan'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => AboutCarelan()));
            },
          ),
          ListTile(
            title: Text('Privacy Policy'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: _launchUrlPandP,
          ),
          ListTile(
            title: Text('Terms & Conditions'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: _launchUrlTandC,
          ),
          ListTile(
            title: Text('Community Guidlines'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: _launchUrlCandG,
          ),
        ],
      )
    );
  }
}

Future<void> _launchUrlPandP() async {
  if (!await launchUrl(_urlPandP)) {
    throw 'Could not launch $_urlPandP';
  }
}

Future<void> _launchUrlTandC() async {
  if (!await launchUrl(_urlTandT)) {
    throw 'Could not launch $_urlTandT';
  }
}

Future<void> _launchUrlCandG() async {
  if (!await launchUrl(_urlcmctGdline)) {
    throw 'Could not launch $_urlcmctGdline';
  }
}
