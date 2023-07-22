import 'package:c_s_p_app/review_screen/review_screen_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../Models/images_model.dart';
import '../Models/region_places_models.dart';
import '../Services/GetImages.dart';
import '../components/map_direction_widget.dart';
import '../flutter_flow/flutter_flow_theme.dart';

class PlaceDetailScreenWidget extends StatefulWidget {
  late Place? place;

  PlaceDetailScreenWidget({this.place});

  @override
  State<PlaceDetailScreenWidget> createState() => _PlaceDetailScreenWidgetState();
}

class _PlaceDetailScreenWidgetState extends State<PlaceDetailScreenWidget> {
  List <Images>images=[];

  List<String>im=[];
  @override
  void initState() {
    super.initState();
    getImage();
  }
  getImage() async{
    images = (await getImages('place','${widget.place!.rowGuid}'))!  ;
    for (int i=0;i<images.length;i++){
      im.add(images[i].image);
    }
    setState(() {

    });
    Future.delayed(const Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      behavior: HitTestBehavior.translucent,
      onPointerDown: (_) {
        // Unfocus when touched outside the input field
        FocusScope.of(context).unfocus();
      },

      child: Scaffold(
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back,color: FlutterFlowTheme.of(context).grayIcon),
          ),
          title: Text("Details",style: FlutterFlowTheme.of(context).title1,),
        ),
        body:ListView(
          physics: BouncingScrollPhysics(),
              children: [
                CachedNetworkImage(
                  fit: BoxFit.cover,
                  height: 300,
                  width: double.infinity, imageUrl: widget.place!.picture,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.place!.name,
                        style: FlutterFlowTheme.of(context).title1,
                      ),
                      SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          widget.place!.category,
                          style: FlutterFlowTheme.of(context).bodyText2,
                        ),
                      ),
                      SizedBox(height: 8),
                      SizedBox(height: 20,),
                      Text(
                        'Opening Hours: ',
                        style: FlutterFlowTheme.of(context).subtitle1,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child:widget.place!.openingTime=='24 hours'?Text(
                          '${widget.place!.openingTime}',
                          style: FlutterFlowTheme.of(context).bodyText2,
                        ) :Text(
                          '${widget.place!.openingTime} - ${widget.place!.closingTime}',
                          style: FlutterFlowTheme.of(context).bodyText2,
                        ),
                      ),
                      SizedBox(height: 16),
                      buildImageSlider(context),
                      SizedBox(height: 16),
                      Text(
                        'Description:',
                        style: FlutterFlowTheme.of(context).subtitle1,
                      ),
                      SizedBox(height: 8),
                      Text(
                          widget.place!.description,
                          style: FlutterFlowTheme.of(context).bodyText2
                      ),
                      SizedBox(height: 16),
                      Text(
                          'Location:',
                          style: FlutterFlowTheme.of(context).subtitle1
                      ),
                      SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ElevatedButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                    actions: <Widget>[
                                      Container(
                                        height:MediaQuery.of(context).size.width,
                                        width:MediaQuery.of(context).size.width,
                                        child: RouteMapWidget(destinationLatitude: widget.place!.latitude, destinationLongitude:widget.place!.longitude, name:widget.place!.name, type: 'place',))]
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
                      ),
                      SizedBox(height: 16),
                      Text(
                          'Reviews:',
                          style: FlutterFlowTheme.of(context).subtitle1
                      ),
                      SizedBox(height: 8),
                      ReviewWidget(rowg: widget.place!.rowGuid, type: 'place',)
                    ],
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
