import 'package:c_s_p_app/index.dart';
import 'package:label_marker/label_marker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import '../Models/hotel_model.dart';
import '../Models/markers_model.dart';
import 'package:flutter/material.dart';

import '../Models/region_places_models.dart';
import '../Models/restaurant_model.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../provider/LoadProvider.dart';

Future<Set<Marker>?> getMarksfromFile(List<Mark> _markers,BuildContext context) async {
  final provider = Provider.of<LoadProvider>(context, listen: false);
  Set<Marker> markers = {};
  for (int i=0;i<_markers.length;i++){
    markers.addLabelMarker(
        LabelMarker(
            onTap: (){
              showModalBottomSheet(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(40.0),
                  ),
                ),
                context: context,
                builder: (BuildContext context) {
                  if (_markers[i].type=='restaurant'||_markers[i].type=='coffeeshop'|| _markers[i].type=='bar'||_markers[i].type=='sweet'||_markers[i].type=='pat'||_markers[i].type=='snack'){
                    for(int j=0;j<provider.RestaurantsList.length;j++){
                      if(provider.RestaurantsList[j].name==_markers[i].name){
                        return ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40.0),
                              topRight: Radius.circular(40.0),
                            ),
                            child: RestaurantsDetailScreenWidget(Restau: provider.RestaurantsList[j], type: 1,));
                      }
                    }
                  }
                  else if(_markers[i].type=='hotel'){
                    for(int j=0;j<provider.HotelsList.length;j++){
                      if(provider.HotelsList[j].name==_markers[i].name){
                        return ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40.0),
                              topRight: Radius.circular(40.0),
                            ),
                            child: HotelsDetailScreenWidget(hot: provider.HotelsList[j], type: 1,)
                        );
                      }
                    }
                  }
                  else {
                    for(int j=0;j<provider.PlacesList.length;j++){
                      if(provider.PlacesList[j].name==_markers[i].name){
                        return ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40.0),
                              topRight: Radius.circular(40.0),
                            ),
                            child: PlaceDetailScreenWidget(place: provider.PlacesList[j],)
                        );
                      }
                    }
                  }
                  return Center(child: Text('Error'));
                },
              );
            },
            label: _markers[i].name,
            markerId: MarkerId(_markers[i].name),
            position: LatLng(_markers[i].latitude,_markers[i].longitude,),
            textStyle: _markers[i].type=='restaurant'? TextStyle(color:Color(0xFFD30000),fontSize: 35):
            _markers[i].type=='hotel'?TextStyle(color:Colors.yellow[700],fontSize: 35):
            _markers[i].type=='coffeeshop'? TextStyle(color:Colors.orange[500],fontSize: 35):
            _markers[i].type=='bar'?TextStyle(color:Colors.cyan[700],fontSize: 35):
            _markers[i].type=='sweet'?TextStyle(color:Colors.brown,fontSize: 35):
            _markers[i].type=='pat'?TextStyle(color:Colors.black,fontSize: 35):
            _markers[i].type=='snack'?TextStyle(color:Color(0xFFC21E56),fontSize: 35):
            TextStyle(color:Colors.brown,fontSize: 35),
            backgroundColor: Colors.white,
            alpha: 0.8
        )
    );
    markers.add(Marker(
        anchor:  Offset(0.5, 0.5),
        markerId:MarkerId(_markers[i].name),
        icon: _markers[i].type=='restaurant'?await BitmapDescriptor.fromAssetImage(
          ImageConfiguration(),
          'assets/map/restaurant_marker.png',

        ):_markers[i].type=='hotel'?await BitmapDescriptor.fromAssetImage(
          ImageConfiguration(),
          'assets/map/hotel_marker.png',
        ):_markers[i].type=='coffeeshop'?await BitmapDescriptor.fromAssetImage(
          ImageConfiguration(),
          'assets/map/coffeshop_marker.png',
        ):_markers[i].type=='bar'?await BitmapDescriptor.fromAssetImage(
          ImageConfiguration(),
          'assets/map/bar_marker.png',
        ):_markers[i].type=='sweet'?await BitmapDescriptor.fromAssetImage(
          ImageConfiguration(),
          'assets/map/sweets_marker.png',
        ):_markers[i].type=='pat'?await BitmapDescriptor.fromAssetImage(
          ImageConfiguration(),
          'assets/map/bakery_marker.png',
        ):_markers[i].type=='snack'?await BitmapDescriptor.fromAssetImage(
          ImageConfiguration(),
          'assets/map/snack_marker.png',
        ):await BitmapDescriptor.fromAssetImage(
            ImageConfiguration(),
            'assets/map/location.png',),
        position: LatLng(_markers[i].latitude,_markers[i].longitude)
    ));
  }
  return markers;
}
