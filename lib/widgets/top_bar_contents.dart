import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:explore/screens/about_us_page.dart';
import 'package:explore/screens/contact_us_page.dart';
import 'package:explore/screens/events_page.dart';
import 'package:explore/screens/home_page.dart';
import 'package:explore/utils/authentication.dart';
import 'package:explore/widgets/auth_dialog.dart';
import 'package:flutter/material.dart';

import '../screens/donation_page.dart';
import '../screens/event_manager.dart';
import '../screens/login_page.dart';

class TopBarContents extends StatefulWidget {
  final double opacity;

  TopBarContents(this.opacity);

  @override
  _TopBarContentsState createState() => _TopBarContentsState();
}

class _TopBarContentsState extends State<TopBarContents> {
  final List _isHovering = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];

  bool _isProcessing = false;

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return PreferredSize(
      preferredSize: Size(screenSize.width, 1000),
      child: Container(
        color: Theme.of(context).bottomAppBarColor.withOpacity(widget.opacity),
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
             /* Text(
                'EXPLORE',
                style: TextStyle(
                  color: Colors.blueGrey[100],
                  fontSize: 20,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w400,
                  letterSpacing: 3,
                ),
              ),*/
              InkWell(
                onHover: (value) {
                  setState(() {
                    value ? _isHovering[4] = true : _isHovering[4] = false;
                  });
                },
                onTap: userEmail == null
                    ? () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      fullscreenDialog: true,
                      builder: (context) => LoginPage(),
                    ),
                  );
                  /*showDialog(
                          context: context,
                          builder: (context) => AuthDialog(),
                        );*/
                }
                    : null,
                child: userEmail == null
                    ? Text(
                  'Sign in',
                  style: TextStyle(
                    color: _isHovering[4] ? Colors.white : Colors.white70,
                  ),
                )
                    : Row(
                  children: [
                    CircleAvatar(
                      radius: 15,
                      backgroundImage: imageUrl != null
                          ? NetworkImage(imageUrl!)
                          : null,
                      child: imageUrl == null
                          ? Icon(
                        Icons.account_circle,
                        size: 30,
                      )
                          : Container(),
                    ),
                    SizedBox(width: 5),
                    Text(
                      name ?? userEmail!,
                      style: TextStyle(
                        color: _isHovering[4]
                            ? Colors.white
                            : Colors.white70,
                      ),
                    ),
                    SizedBox(width: 10),
                    TextButton(
                      style: TextButton.styleFrom(
                        primary: Colors.blueGrey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      onPressed: _isProcessing
                          ? null
                          : () async {
                        setState(() {
                          _isProcessing = true;
                        });
                        await signOut().then((result) {
                          print(result);
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              fullscreenDialog: true,
                              builder: (context) => HomePage(),
                            ),
                          );
                        }).catchError((error) {
                          print('Sign Out Error: $error');
                        });
                        setState(() {
                          _isProcessing = false;
                        });
                      },
                      child: Padding(
                        padding: EdgeInsets.only(
                          top: 8.0,
                          bottom: 8.0,
                        ),
                        child: _isProcessing
                            ? CircularProgressIndicator()
                            : Text(
                          'Sign out',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),

              const Spacer(
                flex: 8,
              ),
              ...[
                TextButton(onPressed: () {}, child:  Text(
                  'Discover',
                  style: TextStyle(
                    color: _isHovering[0]
                        ? Colors.blue[200]
                        : Colors.white,
                  ),
                ),),
                TextButton(onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      fullscreenDialog: true,
                      builder: (context) => ContactUsPage(),
                    ),);
                }, child: Text(
                  'Contact Us',
                  style: TextStyle(
                    color: _isHovering[1]
                        ? Colors.blue[200]
                        : Colors.white,
                  ),
                ),),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          fullscreenDialog: true,
                          builder: (context) => AboutUsPage(),
                        ),);
                    }, child: Text(
                  'About Us',
                  style: TextStyle(
                    color: _isHovering[2]
                        ? Colors.blue[200]
                        : Colors.white,
                  ),
                ),),
                TextButton(onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      fullscreenDialog: true,
                      builder: (context) => DonationPage(),
                    ),);
                }, child: Text(
                  'Donation',
                  style: TextStyle(
                    color: _isHovering[3]
                        ? Colors.blue[200]
                        : Colors.white,
                  ),
                ),),
                TextButton(onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      fullscreenDialog: true,
                      builder: (context) => EventsPage(),
                    ),);
                }, child: Text(
                  'Events',
                  style: TextStyle(
                    color: _isHovering[3]
                        ? Colors.blue[200]
                        : Colors.white,
                  ),
                ),),
                TextButton(onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      fullscreenDialog: true,
                      builder: (context) => EventManager(),
                    ),);
                }, child: Text(
                  'Events Managment',
                  style: TextStyle(
                    color: _isHovering[3]
                        ? Colors.blue[200]
                        : Colors.white,
                  ),
                ),),
              ],
              SizedBox(
                width: screenSize.width / 50,
              ),
              //DonationPage
              Image.asset('assets/images/logo-side-crop.png',
                  width: screenSize.width / 8,
                  height: screenSize.width / 16
              ),
            ],
          ),
        ),
      ),
    );
  }
}
