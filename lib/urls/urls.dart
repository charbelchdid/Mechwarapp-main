import '../Services/GetUserRowg.dart';

class GetUrls {
  final String _baseUrl =
      "https://come-to-lebanon.onrender.com/api";

  String getRegionsAPI() {
    return "$_baseUrl/regions";
  }
  String getPlacesAPI(String rowguid){
    return "$_baseUrl/places?region=$rowguid";
  }
  String getActivitiesAPI(String region,String rowguid){
    return "https://come-to-lebanon.onrender.com/api/activities?region=$region&user_rowguid=$rowguid";
  }
  String getRestaurantsAPI(String rowguid){
    return "$_baseUrl/restaurants?region=$rowguid";
  }
  String getImages(String item, String rowg){
    return "$_baseUrl/images?item=$item&itemRowGuid=$rowg";
  }
  String getUserInfoAPI(String rowguid){
    print(rowguid);
    return "$_baseUrl/users/profile?rowguid=$rowguid";
  }
  Future<String> getUserRowguidAPI() async{
    String email=await getEmailFromLocalDatabase();
    return "$_baseUrl/users?email=$email";
  }
  String getReviewsAPI(String type, String rowguid){
    return "$_baseUrl/reviews?item=${type}&item_rowguid=${rowguid}";
  }
  String getHotelsAPI(String rowguid){
    return "$_baseUrl/hotels?region=$rowguid";
  }
  String getMarkersAPI(){
    return "$_baseUrl/locations";
  }
}


