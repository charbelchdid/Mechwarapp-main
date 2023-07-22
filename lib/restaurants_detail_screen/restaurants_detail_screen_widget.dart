import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Models/images_model.dart';
import '../Models/restaurant_model.dart';
import '../Services/GetImages.dart';
import '../components/map_direction_widget.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../review_screen/review_screen_widget.dart';

void _launchURL(String s) async {
  Uri url = Uri.parse(s); // Replace with your desired URL
  try {
    await launch(url.toString());
  } catch (e) {
    throw 'Could not launch $url';
  }
}

class RestaurantsDetailScreenWidget extends StatefulWidget {
  final Restaurant Restau;
  final int type;

  RestaurantsDetailScreenWidget({
    required this.Restau,
    required this.type,
  });

  @override
  _RestaurantsDetailScreenWidgetState createState() =>
      _RestaurantsDetailScreenWidgetState();
}

class _RestaurantsDetailScreenWidgetState
    extends State<RestaurantsDetailScreenWidget> {
  List<Images> images = [];
  List<String> im = [];

  @override
  void initState() {
    super.initState();
    getImage();
  }

  getImage() async {
    images = (await getImages('restaurant', '${widget.Restau.rowGuid}'))!;
    for (int i = 0; i < images.length; i++) {
      im.add(images[i].image);
    }
    setState(() {}); // Update the UI once the images are fetched
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusScope.of(context).unfocus(); // Close keyboard on tap outside text field
      },
      child: Scaffold(
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: Stack(
          children: [
            SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  CachedNetworkImage(
                    imageUrl: widget.Restau.picture,
                    fit: BoxFit.cover,
                    height: 300,
                    width: double.infinity,
                  ),
                  SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 10),
                        Text(
                          "${widget.Restau.name}",
                          style: FlutterFlowTheme.of(context).title1,
                        ),
                        SizedBox(height: 30),
                        widget.Restau.openingTime=='NA'?SizedBox(height:0):Text(
                          'Opening Hours: ',
                          style: FlutterFlowTheme.of(context).subtitle1,
                        ),
                        widget.Restau.openingTime=='NA'?SizedBox(height:0):Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            '${widget.Restau.openingTime}',
                            style: FlutterFlowTheme.of(context).bodyText2,
                          ),
                        ),
                        Text(
                          'Description: ',
                          style: FlutterFlowTheme.of(context).subtitle1,
                        ),
                        SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Text(
                            '${widget.Restau.description}',
                            style: FlutterFlowTheme.of(context).bodyText2,
                            textAlign: TextAlign.justify,
                          ),
                        ),
                        SizedBox(height: 10),
                        widget.Restau.menu=='NA'?SizedBox(height:0):Text(
                          'Menu',
                          style: FlutterFlowTheme.of(context).subtitle1,
                        ),
                        widget.Restau.menu=='NA'?SizedBox(height:0):SizedBox(height: 10),
                        widget.Restau.menu=='NA'?SizedBox(height:0):Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: InkWell(
                            onTap: () {
                              _launchURL("${widget.Restau.menu}");
                            },
                            child: Text(
                              'Click here to open the URL',
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: Colors.blue,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                        widget.Restau.menu=='NA'?SizedBox(height:0):SizedBox(height: 10),
                        widget.Restau.closingTime=='NA'?SizedBox(height:0):Text(
                          'Contact',
                          style: FlutterFlowTheme.of(context).subtitle1,
                        ),
                        widget.Restau.closingTime=='NA'?SizedBox(height:0):SizedBox(height: 10),
                        widget.Restau.closingTime=='NA'?SizedBox(height:0):Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Text(
                            '${widget.Restau.closingTime}',
                            style: FlutterFlowTheme.of(context).bodyText2,
                          ),
                        ),
                        widget.Restau.closingTime=='NA'?SizedBox(height:0):SizedBox(height: 20),
                        Text(
                          'Images',
                          style: FlutterFlowTheme.of(context).subtitle1,
                        ),
                        SizedBox(height: 10),
                        buildImageSlider(context),
                        widget.type == 0 ? SizedBox(height: 20) : SizedBox(height: 0,),
                        widget.type == 0 ? Text(
                          'Location',
                          style: FlutterFlowTheme.of(context).subtitle1,
                        ) : SizedBox(height: 0,),
                        widget.type == 0 ? SizedBox(height: 10) : SizedBox(height: 0,),
                        widget.type == 0 ? Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: ElevatedButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    actions: <Widget>[
                                      Container(
                                        height:
                                        MediaQuery.of(context).size.width,
                                        width:
                                        MediaQuery.of(context).size.width,
                                        child: RouteMapWidget(
                                          destinationLatitude: widget.Restau.latitude,
                                          destinationLongitude: widget.Restau.longitude,
                                          name: widget.Restau.name,
                                          type: widget.Restau.type,
                                        ),
                                      )
                                    ],
                                  );
                                },
                              );
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: FlutterFlowTheme.of(context)
                                    .primaryColor),
                            child: Text(
                              'Show Map',
                              style: FlutterFlowTheme.of(context)
                                  .subtitle2
                                  .override(
                                fontFamily: 'Lato',
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ) : widget.type == 0 ? Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                                backgroundColor: FlutterFlowTheme.of(context)
                                    .primaryColor),
                            child: Text(
                              'Show Directions',
                              style: FlutterFlowTheme.of(context)
                                  .subtitle2
                                  .override(
                                fontFamily: 'Lato',
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ) : SizedBox(height: 0,),
                        if (widget.type == 0) SizedBox(height: 30),

                        Text(
                            'Reviews',
                            style: FlutterFlowTheme.of(context).subtitle1,
                          ),
                        SizedBox(height: 10),
                        SizedBox(height: 20),
                        ReviewWidget(
                            rowg: '${widget.Restau.rowGuid}',
                            type: 'restaurant',
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 50,
              left: 20,
              child: FlutterFlowIconButton(
                borderColor: Colors.transparent,
                borderRadius: 8,
                borderWidth: 1,
                buttonSize: 40,
                fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                icon: Icon(
                  Icons.arrow_back_rounded,
                  color: FlutterFlowTheme.of(context).secondaryText,
                  size: 20,
                ),
                onPressed: () async {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildImageSlider(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: im.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ImageScreen(
                    images: im,
                    initialIndex: index,
                  ),
                ),
              );
            },
            child: Container(
              margin: EdgeInsets.all(8),
              width: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: CachedNetworkImageProvider(im[index]),
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class ImageScreen extends StatefulWidget {
  final List<String> images;
  final int initialIndex;

  const ImageScreen({
    required this.images,
    required this.initialIndex,
  });

  @override
  _ImageScreenState createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  late PageController _pageController;
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: widget.images.length,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemBuilder: (context, index) {
              return CachedNetworkImage(
                fit: BoxFit.contain,
                imageUrl: widget.images[index],
              );
            },
          ),
          Positioned(
            top: 40,
            left: 16,
            child: IconButton(
              icon: Icon(Icons.arrow_back, size: 30,),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          Positioned(
            bottom: 16,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < widget.images.length; i++)
                  buildDotIndicator(i == _currentIndex),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDotIndicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 4),
      height: 8,
      width: isActive ? 24 : 8,
      decoration: BoxDecoration(
        color: isActive ? Colors.blue : Colors.grey,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}
