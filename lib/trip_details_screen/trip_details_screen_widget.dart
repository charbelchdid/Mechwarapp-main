
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import '../Models/activities_model.dart';
import '../components/map_direction_widget.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import '../provider/LoadProvider.dart';
export 'trip_details_screen_model.dart';

class TripDetailsScreenWidget extends StatefulWidget {
  TripDetailsScreenWidget({Key? key, required this.tripdetail}) : super(key: key);
  Activity tripdetail;
  @override
  _TripDetailsScreenWidgetState createState() =>
      _TripDetailsScreenWidgetState();
}

class _TripDetailsScreenWidgetState extends State<TripDetailsScreenWidget>
    with TickerProviderStateMixin {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool isLoading = false;

  Future<void> updateReservationStatus(BuildContext con) async {
    setState(() {
      isLoading = true;
    });
    final provider = Provider.of<LoadProvider>(context, listen: false);
    String url =
        'https://come-to-lebanon.onrender.com/api/activities/reservation';
    String userRowguid = provider.userRowguid;
    String activityRowguid = widget.tripdetail.rowguid;
    bool isReserved=!widget.tripdetail.isReserved;
    String updatedUrl =
        '$url?user_rowguid=$userRowguid&is_reserved=$isReserved&activity_rowguid=$activityRowguid';

    try {
      http.Response response = await http.post(
        Uri.parse(updatedUrl),
      );

      if (response.statusCode == 201) {
        print('Reservation status updated successfully.');
        provider.getActivity(widget.tripdetail.region,provider.userRowguid);
        Future.delayed(Duration(seconds: 2), () {ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: widget.tripdetail.isReserved==true?Text('Reservation Confirmed',style: TextStyle(fontSize: 20,color: Colors.white),):Text('Reservation Canceled',style: TextStyle(fontSize: 20,color: Colors.white),),
            backgroundColor: widget.tripdetail.isReserved==true?FlutterFlowTheme.of(context).primaryColor:Colors.red[800],
          ),
        );}
        );
        setState(() {
          widget.tripdetail.isReserved=!widget.tripdetail.isReserved;
        });
      } else {
        print('Failed to update reservation status. Error code: ${response.statusCode}');
        Future.delayed(Duration(seconds: 2), () {ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: widget.tripdetail.isReserved==true?Text('Reservation Failed. Please check your internet connection.',style: TextStyle(fontSize: 20,color: Colors.white),):Text('Cancelation Failed. Please check your internet connection.',style: TextStyle(fontSize: 20,color: Colors.white),),
          ),
        );}
        );
      }
    } catch (e) {
      print('Error occurred while updating reservation status: $e');
      Future.delayed(Duration(seconds: 2), () {ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: widget.tripdetail.isReserved==true?Text('Reservation Failed. Please check your internet connection.',style: TextStyle(fontSize: 20,color: Colors.white),):Text('Cancelation Failed. Please check your internet connection.',style: TextStyle(fontSize: 20,color: Colors.white),),
        ),
      );}
      );
    }

    setState(() {
      isLoading = false;
      Navigator.pop(con);
    });
  }





  @override
  void dispose() {

    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Stack(
                      children: [
                        CachedNetworkImage(
                          imageUrl:
                              widget.tripdetail.picture,
                          width: double.infinity,
                          height: 300,
                          fit: BoxFit.cover,
                        ),
                        Align(
                          alignment: AlignmentDirectional(0, 0),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 90,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Color(0xB3090F13), Color(0x00090F13)],
                                stops: [0, 1],
                                begin: AlignmentDirectional(0, -1),
                                end: AlignmentDirectional(0, 1),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(20, 60, 16, 16),
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
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(12, 16, 12, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 4),
                            child: Text(
                              '${widget.tripdetail.category}',
                              style: FlutterFlowTheme.of(context)
                                  .bodyText2
                                  .override(
                                    fontFamily: 'Poppins',
                                    color: FlutterFlowTheme.of(context)
                                        .primaryColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.87,
                      height: 1,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).background,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(12, 0, 12, 4),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                            child: Text(
                              '${widget.tripdetail.title}',
                              style: FlutterFlowTheme.of(context).title2,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(12, 4, 12, 4),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Text(
                              '${widget.tripdetail.description}',
                              style: FlutterFlowTheme.of(context).bodyText2,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(12, 4, 12, 8),
                      child: Column(
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 4),
                                child: Icon(
                                  Icons.schedule,
                                  color: FlutterFlowTheme.of(context).primaryColor,
                                  size: 20,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(4, 0, 0, 0),
                                child: Text(
                                  '${widget.tripdetail.startingTime} - ${widget.tripdetail.endingTime}',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyText1
                                      .override(
                                        fontFamily: 'Lato',
                                        color: FlutterFlowTheme.of(context)
                                            .primaryColor,
                                        fontWeight: FontWeight.w500,
                                      ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Padding(
                                padding:
                                EdgeInsetsDirectional.fromSTEB(0, 0, 0, 4),
                                child: Icon(
                                  Icons.location_on_sharp,
                                  color: FlutterFlowTheme.of(context).primaryColor,
                                  size: 20,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(4, 0, 0, 0),
                                child: Text(
                                  '${widget.tripdetail.location}',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyText1
                                      .override(
                                    fontFamily: 'Lato',
                                    color: FlutterFlowTheme.of(context)
                                        .primaryColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Padding(
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
                                      child: RouteMapWidget(destinationLatitude: widget.tripdetail.latitude, destinationLongitude:widget.tripdetail.longitude, name: widget.tripdetail.location, type: 'place',))]
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
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(12, 4, 12, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 4),
                            child: Text(
                              'Event Details',
                              style: FlutterFlowTheme.of(context).bodyText2,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(12, 0, 12, 4),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 4, 0, 4),
                              child: Text(
                                '${widget.tripdetail.details}',
                                textAlign: TextAlign.start,
                                style: FlutterFlowTheme.of(context).bodyText1,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    widget.tripdetail.type!='event'?SizedBox(height: 0,): Align(
                      alignment: AlignmentDirectional(-1, 0),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                        child: Text(
                          'Guide',
                          textAlign: TextAlign.start,
                          style: FlutterFlowTheme.of(context).bodyText2,
                        ),
                      ),
                    ),
                    widget.tripdetail.type!='event'?SizedBox(height: 0,):Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(16, 8, 16, 0),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 0,
                              color: FlutterFlowTheme.of(context)
                                  .primaryBackground,
                              offset: Offset(0, 1),
                            )
                          ],
                          borderRadius: BorderRadius.circular(0),
                        ),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(8, 8, 12, 8),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: CachedNetworkImage(
                                  imageUrl:'${widget.tripdetail.guideProfile}',
                                  width: 70,
                                  height: 70,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          16, 0, 0, 0),
                                      child: Text(
                                        '${widget.tripdetail.guideName}',
                                        style: FlutterFlowTheme.of(context)
                                            .subtitle1,
                                      ),
                                    ),
                                    RatingBar.builder(
                                      itemBuilder: (context, index) => Icon(
                                        Icons.star_rounded,
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryColor,
                                      ),
                                      direction: Axis.horizontal,
                                      ignoreGestures: true,
                                      initialRating:
                                          widget.tripdetail.guideRating,
                                      unratedColor: Color(0xFF9E9E9E),
                                      itemCount: 5,
                                      itemSize: 40,
                                      glowColor: FlutterFlowTheme.of(context)
                                          .secondaryColor, onRatingUpdate: (double value) {  },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    widget.tripdetail.type!='event'?SizedBox(height: 0,):Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 20),
                      child: FFButtonWidget(
                        onPressed: () {
                          launchUrl(Uri.parse('${widget.tripdetail.guideInstaProfile}'));
                        },
                        text: 'Guide Insta Profile',
                        options: FFButtonOptions(
                          width: 270,
                          height: 50,
                          color: FlutterFlowTheme.of(context).primaryColor,
                          textStyle:
                          FlutterFlowTheme.of(context).subtitle2.override(
                            fontFamily: 'Lato',
                            color: Colors.white,
                          ),
                          elevation: 2,
                          borderSide: BorderSide(
                            color: Colors.transparent,
                            width: 1,
                          ),
                        ),
                      ),
                    ),
                    widget.tripdetail.type!='event'?SizedBox(height: 0,):Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 40),
                      child: FFButtonWidget(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return  AlertDialog(
                                elevation: 8.0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16.0),
                                ),
                                title: Text(
                                  widget.tripdetail.isReserved==false?'Are you sure you want to reserve?':'Are you sure you want to cancel reservation?',
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                actions: isLoading?[Center(child: Container(child: CircularProgressIndicator()))]: [
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop(false);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.grey[200],
                                      onPrimary: Colors.black,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8.0),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                        vertical: 12.0,
                                        horizontal: 24.0,
                                      ),
                                    ),
                                    child: widget.tripdetail.isReserved==false?Text('Cancel'):Text('No'),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      updateReservationStatus(context);
                                      //Navigator.of(context).pop(true);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      primary: FlutterFlowTheme.of(context).primaryColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8.0),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                        vertical: 12.0,
                                        horizontal: 24.0,
                                      ),
                                    ),
                                    child: widget.tripdetail.isReserved==false? Text('Reserve'):Text('Yes'),
                                  ),],
                              );
                              //Confirmation(rowg: widget.tripdetail.rowGuid, res: widget.tripdetail.isReserved, region: widget.tripdetail.region,);
                            },
                          ).then((confirmed) {
                            if (confirmed != null && confirmed) {

                             } else {
                              // User canceled the log out
                              // ...
                            }
                          });
                        },
                        text:widget.tripdetail.isReserved==false?'RSVP to Event':'Cancel Reservation',
                        options: FFButtonOptions(
                          width: 270,
                          height: 50,
                          color: FlutterFlowTheme.of(context).primaryColor,
                          textStyle:
                              FlutterFlowTheme.of(context).subtitle2.override(
                                    fontFamily: 'Lato',
                                    color: Colors.white,
                                  ),
                          elevation: 2,
                          borderSide: BorderSide(
                            color: Colors.transparent,
                            width: 1,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
