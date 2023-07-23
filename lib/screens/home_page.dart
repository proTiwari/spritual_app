import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:explore/widgets/web_scrollbar.dart';
import 'package:explore/widgets/bottom_bar.dart';
import 'package:explore/widgets/carousel.dart';
import 'package:explore/widgets/destination_heading.dart';
import 'package:explore/widgets/explore_drawer.dart';
import 'package:explore/widgets/featured_heading.dart';
import 'package:explore/widgets/featured_tiles.dart';
import 'package:explore/widgets/floating_quick_access_bar.dart';
import 'package:explore/widgets/responsive.dart';
import 'package:explore/widgets/top_bar_contents.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  static const String route = '/';
  static bool isContactUs = false;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ScrollController _scrollController;
  double _scrollPosition = 0;
  double _opacity = 0;


  _scrollListener() {
    setState(() {
      _scrollPosition = _scrollController.position.pixels;
    });
  }

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    _opacity = _scrollPosition < screenSize.height * 0.40
        ? _scrollPosition / (screenSize.height * 0.40)
        : 1;

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      extendBodyBehindAppBar: true,
      appBar: ResponsiveWidget.isSmallScreen(context)
          ? AppBar(
              backgroundColor:
                  Theme.of(context).bottomAppBarColor.withOpacity(_opacity),
              elevation: 0,
              centerTitle: true,
              actions: [
                Visibility(
                  visible: false,
                  child: IconButton(
                    icon: Icon(Icons.brightness_6),
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onPressed: () {
                      EasyDynamicTheme.of(context).changeTheme();
                    },
                  ),
                ),
              ],
              title:  Image.asset('assets/images/logo-side-crop.png',
                  width: screenSize.width / 6,
                  height: screenSize.width / 12
              ),
            )
          : PreferredSize(
              preferredSize: Size(screenSize.width, 1000),
              child: TopBarContents(_opacity),
            ),
      drawer: ExploreDrawer(),
      body: WebScrollbar(
        color: Colors.blueGrey,
        backgroundColor: Colors.blueGrey.withOpacity(0.3),
        width: 10,
        heightFraction: 0.3,
        controller: _scrollController,
        child: SingleChildScrollView(
          controller: _scrollController,
          physics: ClampingScrollPhysics(),
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                      height: screenSize.height * 0.1,
                      width: screenSize.width,
                    //color: Color(0xfffcb900),
                    color: Colors.deepOrangeAccent,
                  ),
                  /*Column(
                    children: [
                      FloatingQuickAccessBar(screenSize: screenSize),
                      Container(
                        child: Column(
                          children: [
                            FeaturedHeading(
                              screenSize: screenSize,
                            ),
                            FeaturedTiles(screenSize: screenSize)
                          ],
                        ),
                      ),
                    ],
                  )*/
                ],
              ),
              DestinationHeading(screenSize: screenSize),
              DestinationCarousel(),
              SizedBox(height: screenSize.height / 10),
              ResponsiveWidget.isSmallScreen(context) ?  Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'SCHEDULE FOR SHWETAMBER MAHOTSAV',
                          style: TextStyle(
                            fontFamily: 'Electrolize',
                            fontSize: screenSize.width / 40,
                            color: Colors.black54,
                          ),
                        ),
                        Image.asset('assets/images/banner-4.png',
                          height:ResponsiveWidget.isSmallScreen(context) ? screenSize.height / 2:  screenSize.height / 1.5,
                          width: ResponsiveWidget.isSmallScreen(context) ? screenSize.height / 2: screenSize.height / 1.5,
                        )
                      ],
                    ),
                  ),
                ],
              ) :
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'SCHEDULE FOR SHWETAMBER MAHOTSAV',
                      style: TextStyle(
                        fontFamily: 'Electrolize',
                        fontSize: screenSize.width / 40,
                        color: Colors.black54,
                      ),
                    ),
                    Image.asset('assets/images/banner-4.png',
                        height:ResponsiveWidget.isSmallScreen(context) ? screenSize.height / 2:  screenSize.height / 1.5,
                        width: ResponsiveWidget.isSmallScreen(context) ? screenSize.height / 2: screenSize.height / 1.5,
                    )
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(
                  left: 20.0,
                  right: 20,
                  bottom: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //
                    Text(
                      'Welcome to the Jain Center',
                      style: TextStyle(
                        fontFamily: 'Electrolize',
                        fontSize: screenSize.width / 40,
                        color: Colors.black54,
                      ),
                    ),
                    SizedBox(height: screenSize.height / 20),
                    Text(
                      'A non-profit religious organization to pursue a goal of practicing, promoting and preserving the Jain religion.',
                      style: TextStyle(
                        fontFamily: 'Electrolize',
                        fontSize: screenSize.width / 60,
                        color: Colors.black54,
                      ),
                    ),
                    SizedBox(height: screenSize.height / 20),
                    Text(
                      'The Jain Society of Waterloo (JSOW) located in Waterloo, is a non-profit religious organization to pursue a goal of practicing, promoting and preserving the Jain religion. It is governed by a constitution and managed by Board of Directors and an Executive Committee consisting of President, Vice President, Secretary, Treasurer and 8 Members, who are elected by the members for a term of two years..',
                      style: TextStyle(
                        fontFamily: 'Electrolize',
                        fontSize: screenSize.width / 60,
                        color: Colors.black54,
                      ),
                    ),
                    SizedBox(height: screenSize.height / 20),
                    Text(
                      'Various Events and On-going Activities are planned and organized by a number of sub-groups including Jain Seniors Group, Jain Professional and Cultural Association of Young Adults (JPCA). During the year Dignitaries from India and other parts of the world visit our center and hold lectures and discourses in Jainism.\nWe look forward to seeing you at the Jain Center!',
                      style: TextStyle(
                        fontFamily: 'Electrolize',
                        fontSize: screenSize.width / 60,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
              BottomBar(),
            ],
          ),
        ),
      ),
    );
  }
}
