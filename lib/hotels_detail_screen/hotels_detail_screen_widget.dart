import 'package:c_s_p_app/review_screen/review_screen_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Models/hotel_model.dart';
import '../Models/images_model.dart';
import '../Services/GetImages.dart';
import '../components/map_direction_widget.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';


void _launchURL(String s) async {
  Uri url = Uri.parse(s); // Replace with your desired URL
  try {
    await launchUrl(url);
  } catch (e) {
    throw 'Could not launch $url';
  }
}


class HotelsDetailScreenWidget extends StatefulWidget {
  final Hotel hot;
  final int type;

  HotelsDetailScreenWidget({
    required this.hot,
    required this.type
  });

  @override
  State<HotelsDetailScreenWidget> createState() => _HotelsDetailScreenWidgetState();
}

class _HotelsDetailScreenWidgetState extends State<HotelsDetailScreenWidget> {
  List <Images>images=[];

  List<String>im=[];

  @override
  void initState() {
    super.initState();
    getImage();
  }

  getImage() async{
    images = (await getImages('hotel','${widget.hot.rowGuid}'))!  ;
    for (int i=0;i<images.length;i++){
      im.add(images[i].image);
    }
    setState(() {

    });
    Future.delayed(const Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    List<String> elements = widget.hot.services!=null?widget.hot.services.split(",").map((element) => element.trim()).toList():[];
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 300,
                      width: double.infinity,
                      child: CachedNetworkImage(
                        imageUrl: widget.hot.picture,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 20,),
                          Text(
                            '${widget.hot.name}',
                            style: FlutterFlowTheme.of(context).title1,
                          ),
                          SizedBox(height: 30,),
                          Text(
                            'Description',
                            style: FlutterFlowTheme.of(context).subtitle1,
                          ),
                          SizedBox(height: 8),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              '${widget.hot.description}',
                              style: FlutterFlowTheme.of(context).bodyText2,
                              textAlign: TextAlign.justify,
                            ),
                          ),
                          SizedBox(height: 16),
                          Text(
                            'Services',
                            style: FlutterFlowTheme.of(context).subtitle1,
                          ),
                          //SizedBox(height: 8),
                          elements.length!=0?ListView.builder(
                            padding: EdgeInsets.all(10),
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: elements.length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: EdgeInsets.only(bottom: 10),
                                child: Text('-  ${elements[index]}', style: FlutterFlowTheme.of(context).bodyText2,
                                  textAlign: TextAlign.justify,),
                              );
                            },
                          ):Text(''),
                          SizedBox(height: 16),
                          widget.hot.closingTime=='NA'?SizedBox(height:0):Text(
                            'Check IN/OUT',
                            style: FlutterFlowTheme.of(context).subtitle1,
                          ),
                          widget.hot.closingTime=='NA'?SizedBox(height:0):SizedBox(height: 8),
                          widget.hot.closingTime=='NA'?SizedBox(height:0):Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              '${widget.hot.closingTime}',
                              style: FlutterFlowTheme.of(context).bodyText2,
                            ),
                          ),
                          widget.hot.closingTime=='NA'?SizedBox(height:0):SizedBox(height: 16),
                          Text(
                            'Contact',
                            style: FlutterFlowTheme.of(context).subtitle1,
                          ),
                          SizedBox(height: 8),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              '${widget.hot.openingTime}',
                              style: FlutterFlowTheme.of(context).bodyText2,
                            ),
                          ),
                          SizedBox(height: 16),
                          Text(
                            'Photos',
                            style: FlutterFlowTheme.of(context).subtitle1,
                          ),
                          SizedBox(height: 8),
                          buildImageSlider(context),
                          SizedBox(height: 16),
                          Text(
                            'Website/Instagram',
                            style: FlutterFlowTheme.of(context).subtitle1,
                          ),
                          SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: InkWell(
                              onTap: () {
                                _launchURL(widget.hot.website);
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
                          widget.type==0?SizedBox(height: 20):SizedBox(height: 0,),
                          widget.type==0?Text(
                            'Location',
                            style: FlutterFlowTheme.of(context).subtitle1,
                          ):SizedBox(height: 0,),
                          widget.type==0?SizedBox(height: 8):SizedBox(height: 0,),
                          widget.type==0?Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: ElevatedButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                        actions: <Widget>[Container(
                                            height:MediaQuery.of(context).size.width,
                                            width:MediaQuery.of(context).size.width,
                                            child: RouteMapWidget(destinationLatitude:widget.hot.latitude, destinationLongitude:widget.hot.longitude, name: widget.hot.name, type: 'hotel',))]
                                    );
                                  },
                                );
                                },
                              style: ElevatedButton.styleFrom(backgroundColor: FlutterFlowTheme.of(context).primaryColor),
                              child: Text('Show Map',style: FlutterFlowTheme.of(context).subtitle2.override(
                                fontFamily: 'Lato',
                                color: Colors.white,
                              ),),
                            ),
                          ):SizedBox(height: 0,),
                          SizedBox(height: 16),
                          Text(
                            'Reviews',
                            style: FlutterFlowTheme.of(context).subtitle1,
                          ),
                          SizedBox(height: 8),
                        ],
                      ),
                    ),
                    ReviewWidget(rowg: widget.hot.rowGuid, type: 'hotel',)
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
                  fillColor:
                  FlutterFlowTheme.of(context).secondaryBackground,
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
          )
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
                  image: NetworkImage(im[index]),
                  fit: BoxFit.cover,
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
                fit: BoxFit.contain, imageUrl: widget.images[index],
              );
            },
          ),
          Positioned(
            top: 40, // Adjust the position of the back icon as per your needs
            left: 16, // Adjust the position of the back icon as per your needs
            child: IconButton(
              icon: Icon(Icons.arrow_back,size: 30,),
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