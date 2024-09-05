import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:optiparser/components/bottom_bar.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfilePage extends StatelessWidget {
  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(1),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 100,
                      backgroundImage: AssetImage(
                          'assets/nawabs.jpg'), // Replace with your image URL
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Nawabs',
                      style: GoogleFonts.protestGuerrilla(
                        fontSize: 30,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: TextButton.icon(
                onPressed: () {
                  _launchURL("https://djthegr8.github.io/optiparse_doc/");
                },
                icon: Icon(Icons.link, color: Colors.blue),
                label: Text(
                  'Documentation',
                  style: GoogleFonts.protestGuerrilla(
                    fontSize: 30,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                style: TextButton.styleFrom(
                  iconColor: Colors.blue,
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(currentIndex: 3),
    );
  }
}
