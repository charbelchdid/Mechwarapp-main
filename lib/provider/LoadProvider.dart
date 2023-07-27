
import 'package:c_s_p_app/Models/activities_model.dart';
import 'package:c_s_p_app/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import '../Models/hotel_model.dart';
import '../Models/markers_model.dart';
import '../Models/region_places_models.dart';
import '../Models/regions_model.dart';
import '../Models/restaurant_model.dart';
import '../Models/user_info_model.dart';
import '../Services/GetActivities.dart';
import '../Services/GetHotels.dart';
import '../Services/GetMarkers.dart';
import '../Services/GetMarks.dart';
import '../Services/GetUserRowguid.dart';
import '../Services/RegionPlaces.dart';
import '../Services/Regions.dart';
import '../Services/Restaurants.dart';
import '../Services/UserInfo.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class LoadProvider extends ChangeNotifier {
  late Payload user=Payload(rowguid: '', name: '', email: '', profile: '');
  late UserInfo userInfo;
  late Regions Region ;
  late List<Place> PlacesList = [];
  late List<Restaurant> RestaurantsList = [];
  late List<Hotel> HotelsList = [];
  bool loading = false;
  late int state=1;
  late String userRowguid='';
  late ActivitiesParent Ap;
  late List<Activity> ActivityList=[];
  late List <Mark> markers=[];
  late Set<Marker> markers2 = {};


  getRegionList() async {
    loading = true;
    Region=  (await RegionsAPI().getRegions())!;
    Future.delayed(const Duration(seconds: 1));
    loading = false;
    notifyListeners();
  }

  getPlacesList(String r) async{
    loading = true;
    PlacesList = (await RegionPlacesAPI().getRegionPlaces(r))!  ;
    Future.delayed(const Duration(seconds: 1));
    loading = false;
    notifyListeners();
  }

  getRestaurants(String r) async{
    loading = true;
    RestaurantsList = (await RestaurantsAPI().getRestaurants(r))!  ;
    Future.delayed(const Duration(seconds: 1));
    loading = false;
    notifyListeners();
  }
  getHotel(String r) async{
    loading = true;
    HotelsList = (await getHotels(r))!  ;
    Future.delayed(const Duration(seconds: 1));
    loading = false;
    notifyListeners();
  }

  getUserInfo(int s, BuildContext context) async{
    loading = true;
    await  getUserRow(context);
    userInfo = (await UserInfoAPI().getUserInfo('$userRowguid'))!  ;
    user=userInfo.payload;
    print(user.name);
    Future.delayed(const Duration(seconds: 1));
    loading = false;
    notifyListeners();
    if(s==1){
      Navigator.pop(context);
    }
  }
  changeState(int s){
    state=s;
    notifyListeners();
  }
  getActivity(String r,String user) async{
    loading = true;
    Ap = (await getActivities(r,user))!  ;
    ActivityList=Ap.data;
    Future.delayed(const Duration(seconds: 1));
    loading = false;
    notifyListeners();
  }
  getMarker(BuildContext context)async{
    loading = true;
    markers = (await getMarkers())!  ;
    Future.delayed(const Duration(seconds: 1));
    markers2=(await getMarksfromFile(markers,context))!;
    Future.delayed(const Duration(seconds: 1));
    loading = false;
    notifyListeners();
  }

  Future<bool> checkLocationPermission(BuildContext context) async {
    // Check if the location permission is granted
    PermissionStatus _permissionStatus;
    _permissionStatus = await Permission.locationWhenInUse.status;
    if (!_permissionStatus.isGranted) {
      if (_permissionStatus.isDenied) {
        await Permission.locationWhenInUse.request();
      }
      return true;
      // You can also handle other cases like PermanentlyDenied, Restricted, etc.
    }
    else{
      return true;
    }
  }
}