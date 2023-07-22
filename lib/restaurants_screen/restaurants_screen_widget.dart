import '../Models/restaurant_model.dart';
import '../Services/Restaurants.dart';
import '../components/restaurent_widget_widget.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../provider/LoadProvider.dart';
import 'restaurants_screen_model.dart';
export 'restaurants_screen_model.dart';
class Category {
  final String name;
  final IconData icon;

  Category({required this.name, required this.icon});
}

class RestaurantsScreenWidget extends StatefulWidget {
  const RestaurantsScreenWidget({Key? key, required this.RegionRowguid})
      : super(key: key);
  final String RegionRowguid;

  @override
  _RestaurantsScreenWidgetState createState() =>
      _RestaurantsScreenWidgetState();
}

class _RestaurantsScreenWidgetState extends State<RestaurantsScreenWidget> {
  late RestaurantsScreenModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();
  late List<Restaurant> _RestaurantsList = [];
  late List<Restaurant> _SweetsList = [];
  late List<Restaurant> _CoffeeshopsList = [];
  late List<Restaurant> _BarsList = [];
  late List<Restaurant> _SnacksList = [];
  late List<Restaurant> _PatisseriesList = [];
  List<Restaurant> _filteredRestaurantsList = [];
  int _selectedIndex=0;
  List<Category> _categories = [
    Category(name: 'Restaurants', icon: Icons.restaurant),
    Category(name: 'Sweets', icon: Icons.cake),
    Category(name: 'Coffeeshops', icon: Icons.local_cafe),
    Category(name: 'Bars', icon: Icons.local_bar),
    Category(name: 'Snacks', icon: Icons.fastfood),
    Category(name: 'Bakeries', icon: Icons.local_dining),
  ];
  void _getData() async {
    final provider = Provider.of<LoadProvider>(context, listen: false);
    _RestaurantsList = provider.RestaurantsList.where((element) => element.type=='restaurant').toList();
    _SweetsList = provider.RestaurantsList.where((element) => element.type=='sweet').toList();
    _CoffeeshopsList=provider.RestaurantsList.where((element) => element.type=='coffeeshop').toList();
    _BarsList=provider.RestaurantsList.where((element) => element.type=='bar').toList();
    _SnacksList=provider.RestaurantsList.where((element) => element.type=='snack').toList();
    _PatisseriesList=provider.RestaurantsList.where((element) => element.type=='pat').toList();
    if(_selectedIndex==0){
      _filteredRestaurantsList=_RestaurantsList;
    }
    else if(_selectedIndex==1){
      _filteredRestaurantsList=_SweetsList;
    }
    else if(_selectedIndex==2){
      _filteredRestaurantsList=_CoffeeshopsList;
    }
    else if(_selectedIndex==3){
      _filteredRestaurantsList=_BarsList;
    }
    else if(_selectedIndex==4){
      _filteredRestaurantsList=_SnacksList;
    }
    else if(_selectedIndex==5){
      _filteredRestaurantsList=_PatisseriesList;
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => RestaurantsScreenModel());
    _getData();
    _model.textController = TextEditingController();
  }

  @override
  void dispose() {
    _model.dispose();

    _unfocusNode.dispose();
    super.dispose();
  }

  void _clearSearch() {
    _model.textController?.clear();
    setState(() {
      _filteredRestaurantsList = _RestaurantsList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
                child: Stack(
                  alignment: Alignment.centerRight,
                  children: [
                    TextFormField(
                      controller: _model.textController,
                      onChanged: (value) {
                        setState(() {
                          if(_selectedIndex==0){
                            _filteredRestaurantsList=_RestaurantsList.where((restaurant) => restaurant.name
                                .toLowerCase()
                                .contains(value.toLowerCase()))
                                .toList();
                          }
                          else if(_selectedIndex==1){
                            _filteredRestaurantsList=_SweetsList.where((restaurant) => restaurant.name
                                .toLowerCase()
                                .contains(value.toLowerCase()))
                                .toList();
                          }
                          else if(_selectedIndex==2){
                            _filteredRestaurantsList=_CoffeeshopsList.where((restaurant) => restaurant.name
                                .toLowerCase()
                                .contains(value.toLowerCase()))
                                .toList();
                          }
                          else if(_selectedIndex==3){
                            _filteredRestaurantsList=_BarsList.where((restaurant) => restaurant.name
                                .toLowerCase()
                                .contains(value.toLowerCase()))
                                .toList();
                          }
                          else if(_selectedIndex==4){
                            _filteredRestaurantsList=_SnacksList.where((restaurant) => restaurant.name
                                .toLowerCase()
                                .contains(value.toLowerCase()))
                                .toList();
                          }
                          else if(_selectedIndex==5){
                            _filteredRestaurantsList=_PatisseriesList.where((restaurant) => restaurant.name
                                .toLowerCase()
                                .contains(value.toLowerCase()))
                                .toList();
                          }

                        });
                      },
                      onFieldSubmitted: (_) => _unfocusNode.requestFocus(),
                      obscureText: false,
                      textInputAction: TextInputAction.search,
                      decoration: InputDecoration(
                        labelText: 'Search Restaurants',
                        labelStyle: FlutterFlowTheme.of(context).bodyText2,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0x00000000),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0x00000000),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0x00000000),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0x00000000),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        filled: true,
                        fillColor:
                        FlutterFlowTheme.of(context).secondaryBackground,
                        prefixIcon: Icon(
                          Icons.search_rounded,
                          color: FlutterFlowTheme.of(context).secondaryText,
                        ),
                      ),
                      style: FlutterFlowTheme.of(context).bodyText1,
                      maxLines: null,
                      validator:
                      _model.textControllerValidator.asValidator(context),
                    ),
                    if (_model.textController.text.isNotEmpty)
                      IconButton(
                        onPressed: _clearSearch,
                        icon: Icon(
                          Icons.clear_rounded,
                          color: FlutterFlowTheme.of(context).secondaryText,
                        ),
                      ),
                  ],
                ),
              ),
              SizedBox(height: 10,),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(12, 0, 12, 0),
                child: BottomNavigationBar(
                  items: _categories.map((category) {
                    return BottomNavigationBarItem(
                      backgroundColor:  FlutterFlowTheme.of(context).secondaryBackground,
                      icon: Icon(category.icon),
                      label: category.name,
                    );
                  }).toList(),
                  currentIndex: _selectedIndex,
                  selectedItemColor:  FlutterFlowTheme.of(context).primaryColor,
                  unselectedItemColor: Colors.grey,
                  onTap: (index) {
                    setState(() {
                      _selectedIndex = index;
                      _getData();
                    });
                  },
                )
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(12, 12, 12, 0),
                child: GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: _filteredRestaurantsList.length,
                  itemBuilder: (context, index) => RestaurentWidgetWidget(
                    Restau: _filteredRestaurantsList[index],
                  ),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    childAspectRatio: 1.3,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
