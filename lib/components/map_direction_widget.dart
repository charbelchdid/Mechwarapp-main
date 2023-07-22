import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:label_marker/label_marker.dart';
import 'dart:convert';
import 'dart:async';

import '../flutter_flow/flutter_flow_theme.dart';
class RouteMapWidget extends StatefulWidget {
  final double destinationLatitude;
  final double destinationLongitude;
  final String name;
  final String type;

  const RouteMapWidget({
    Key? key,
    required this.destinationLatitude,
    required this.destinationLongitude,
    required this.name,
    required this.type,
  }) : super(key: key);

  @override
  _RouteMapWidgetState createState() => _RouteMapWidgetState();
}

class _RouteMapWidgetState extends State<RouteMapWidget> {
  late GoogleMapController mapController;
  Position? currentPosition;
  Set<Marker> markers = {};
  Set<Polyline> polylines = {};
  Timer? timer;
  bool isDisposed = false;
  bool isZoomedOut = false;

  @override
  void initState(){
    super.initState();
    initializeMap();
    getM();
    }
  void getM() async{
    markers.add(
        Marker(
            markerId: MarkerId('${widget.name}1'),
            anchor:  Offset(0.5, 0.5),
            icon: widget.type=='restaurant'?await BitmapDescriptor.fromAssetImage(
              ImageConfiguration(),
              'assets/map/restaurant_marker.png',
            ):widget.type=='hotel'?await BitmapDescriptor.fromAssetImage(
              ImageConfiguration(),
              'assets/map/hotel_marker.png',
            ):widget.type=='coffeeshop'?await BitmapDescriptor.fromAssetImage(
              ImageConfiguration(),
              'assets/map/coffeshop_marker.png',
            ):widget.type=='bar'?await BitmapDescriptor.fromAssetImage(
              ImageConfiguration(),
              'assets/map/bar_marker.png',
            ):widget.type=='sweet'?await BitmapDescriptor.fromAssetImage(
              ImageConfiguration(),
              'assets/map/sweets_marker.png',
            ):widget.type=='pat'?await BitmapDescriptor.fromAssetImage(
              ImageConfiguration(),
              'assets/map/bakery_marker.png',
            ):widget.type=='snack'?await BitmapDescriptor.fromAssetImage(
              ImageConfiguration(),
              'assets/map/snack_marker.png',
            ):await BitmapDescriptor.fromAssetImage(
              ImageConfiguration(),
              'assets/map/location.png',),
            position: LatLng(widget.destinationLatitude,widget.destinationLongitude)
        )
    );

    markers.addLabelMarker(
        LabelMarker(label: widget.name, markerId:MarkerId(widget.name), position: LatLng(widget.destinationLatitude,widget.destinationLongitude,),
            textStyle:
            widget.type=='restaurant'? TextStyle(color:Color(0xFFD30000),fontSize: 35):
            widget.type=='hotel'?TextStyle(color:Colors.yellow[700],fontSize: 35):
            widget.type=='coffeeshop'? TextStyle(color:Colors.orange[500],fontSize: 35):
            widget.type=='bar'?TextStyle(color:Colors.cyan[700],fontSize: 35):
            widget.type=='sweet'?TextStyle(color:Colors.brown,fontSize: 35):
            widget.type=='pat'?TextStyle(color:Colors.black,fontSize: 35):
            widget.type=='snack'?TextStyle(color:Color(0xFFC21E56),fontSize: 35):
            TextStyle(color:Colors.brown,fontSize: 35),
            backgroundColor: Colors.white,
            alpha: 0.8
        ));

  }
  @override
  void dispose() {
    isDisposed = true;
    stopTimer();
    super.dispose();
  }

  void initializeMap() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      if (isDisposed) return;
      setState(() {
        currentPosition = position;
      });
    } catch (e) {
      print('Error: $e');
    }
  }


  List<LatLng> decodePolyline(String encoded) {
    List<LatLng> polylinePoints = [];
    int index = 0;
    int len = encoded.length;
    int lat = 0;
    int lng = 0;

    while (index < len) {
      int b;
      int shift = 0;
      int result = 0;

      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);

      int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lat += dlat;

      shift = 0;
      result = 0;

      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);

      int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lng += dlng;

      double latitude = lat / 1e5;
      double longitude = lng / 1e5;

      polylinePoints.add(LatLng(latitude, longitude));
    }

    return polylinePoints;
  }

  void fetchRoute() async {
    String apiKey = '5b3ce3597851110001cf6248a5cb4546e9b141cbbdd2eb60a7fda0fa'; // Replace with your OpenRouteService API Key
    String url = 'https://api.openrouteservice.org/v2/directions/driving-car?' +
        'api_key=$apiKey' +
        '&start=${currentPosition!.longitude},${currentPosition!.latitude}' +
        '&end=${widget.destinationLongitude},${widget.destinationLatitude}';

    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      var features = data['features'];
      if (features != null && features.isNotEmpty) {
        var geometry = features[0]['geometry']['coordinates'];
        List<LatLng> routeCoordinates = [];

        for (var coordinate in geometry) {
          double latitude = coordinate[1];
          double longitude = coordinate[0];
          routeCoordinates.add(LatLng(latitude, longitude));
        }

        Polyline routePolyline = Polyline(
          polylineId: PolylineId('route'),
          color: Colors.blue,
          points: routeCoordinates,
          width: 3,
        );

        if (!isDisposed) {
          setState(() {
            polylines.clear();
            polylines.add(routePolyline);
          });
        }
      }
    }
    else{
      print('large');
    }
  }

  void startTimer() {
    fetchRoute();
    timer = Timer.periodic(Duration(seconds: 3), (timer) {
      fetchRoute();
    });
  }

  void stopTimer() {
    timer?.cancel();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          GoogleMap(
           // mapType: MapType.normal,
            gestureRecognizers: Set()..add(Factory<EagerGestureRecognizer>(() => EagerGestureRecognizer())),
            initialCameraPosition: CameraPosition(
              target: LatLng(widget.destinationLatitude, widget.destinationLongitude),
              zoom: 15.0,
            ),
            markers: markers,
            polylines: polylines,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            onMapCreated: (GoogleMapController controller) {
              mapController = controller;
            },
          ),
          Positioned(
            top: 16,
            left: 16,
            child: ElevatedButton(
              onPressed: () {
                mapController.animateCamera(
                  CameraUpdate.newLatLngBounds(
                    LatLngBounds(
                      southwest: LatLng(
                        currentPosition!.latitude < widget.destinationLatitude
                            ? currentPosition!.latitude
                            : widget.destinationLatitude,
                        currentPosition!.longitude < widget.destinationLongitude
                            ? currentPosition!.longitude
                            : widget.destinationLongitude,
                      ),
                      northeast: LatLng(
                        currentPosition!.latitude > widget.destinationLatitude
                            ? currentPosition!.latitude
                            : widget.destinationLatitude,
                        currentPosition!.longitude > widget.destinationLongitude
                            ? currentPosition!.longitude
                            : widget.destinationLongitude,
                      ),
                    ),
                    10.0,
                  ),
                );
                startTimer();
              },
              style: ElevatedButton.styleFrom(backgroundColor: FlutterFlowTheme.of(context).primaryColor),
              child: Text('Show Directions',style: FlutterFlowTheme.of(context).subtitle2.override(
                fontFamily: 'Lato',
                color: Colors.white,
              ),),
            ),
          ),
        ],
      ),
    );
  }
}
