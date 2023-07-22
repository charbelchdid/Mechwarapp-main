
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/LoadProvider.dart';
import 'package:geolocator/geolocator.dart';

class MapScreenWidget extends StatefulWidget {
  MapScreenWidget({Key? key,required this.rowg}) : super(key: key);
  String rowg;
  @override
  _MapScreenWidgetState createState() => _MapScreenWidgetState();
}

class _MapScreenWidgetState extends State<MapScreenWidget> {
  late GoogleMapController _mapController;
  Position? _currentPosition;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  Set<Marker> markers = {};
  @override
  void initState() {
    super.initState();
    final provider = Provider.of<LoadProvider>(context, listen: false);
    markers=provider.markers2;
    _getCurrentLocation();
    provider.checkLocationPermission();
  }


  void _getCurrentLocation() async {
    final position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    setState(() {
      _currentPosition = position;
    });
  }
  @override
  void dispose() {

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LoadProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('Map'),
        centerTitle: true,
        toolbarHeight: 60,
        backgroundColor: FlutterFlowTheme.of(context).primaryColor,
      ),
      key: scaffoldKey,
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFFEFEFEF),
      //sk.eyJ1IjoiY2hhcmJlbGNoZGlkIiwiYSI6ImNsamxiOW1xczByaG8za251dWJza2JpZGgifQ.-CDy5CKJ9z6R-R1b5EgoiA
      body: (_currentPosition != null)
          ?
      Stack(
                  children: [
                    Align(
                        alignment: AlignmentDirectional(0, 0),
                        child: Container(
                          height: MediaQuery.of(context).size.height * 1,
                          decoration: BoxDecoration(),

                          child:  GoogleMap(
                            compassEnabled: true,
                            mapType: MapType.normal,
                            myLocationButtonEnabled: true,
                            myLocationEnabled: true,
                            initialCameraPosition: CameraPosition(
                              target: LatLng(
                                _currentPosition!.latitude,
                                _currentPosition!.longitude,
                              ),
                              zoom: 15.0,
                            ),
                            onMapCreated: (GoogleMapController controller) {
                              _mapController = controller;
                            },
                            markers: markers, // Empty set of markers
                            polylines: Set<Polyline>(), // Empty set of polylines
                          ),
                        )
                    )
                  ]
              ):Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
