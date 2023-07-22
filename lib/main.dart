import 'package:c_s_p_app/provider/LoadProvider.dart';
import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'Services/Connection.dart';
import 'Services/GetUserRowg.dart';
// Import the generated file
import 'firebase_options.dart';
import 'flutter_flow/flutter_flow_theme.dart';

import 'index.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FlutterFlowTheme.initialize();
  runApp(
      MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => LoadProvider(),
        ),
        ChangeNotifierProvider<ConnectivityProvider>(
          create: (_) => ConnectivityProvider(),
        ),
      ],
      child:  Builder(
        builder: (context) {
          return MaterialApp(
            home: MyApp(),
          );
        },
      ),
      )
  );
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<MyApp> createState() => _MyAppState();

  static _MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>()!;
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;
  ThemeMode _themeMode = FlutterFlowTheme.themeMode;



  bool displaySplashImage = true;
  @override
  void initState() {
    super.initState();
    }



  void setThemeMode(ThemeMode mode) => setState(() {
        _themeMode = mode;
        FlutterFlowTheme.saveThemeMode(mode);
      });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mechwar',
      localizationsDelegates: [
      ],
      locale: _locale,
      supportedLocales: const [Locale('en', '')],
      theme: ThemeData(brightness: Brightness.light, textSelectionTheme: TextSelectionThemeData(selectionHandleColor: FlutterFlowTheme.of(context).primaryColor),),
      darkTheme: ThemeData(brightness: Brightness.dark),
      themeMode: _themeMode,
      debugShowCheckedModeBanner: false,
      home:SplashScreen(),

     );
  }
}

class SplashScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LoadProvider>(context, listen: false);
    List<Future> s = [
      provider.checkLocationPermission(),
      checkEmailFromLocalDatabase(context),
      provider.getRegionList(),
    provider.getMarker(context),
      provider.getUserInfo(0,context),
    ];
    return FutureBuilder(
      future: Future.wait(s),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if(provider.state==0){
            return SignInScreenWidget();
          }
          else{
            return SelectRegionScreenWidget();
          }
        }
        else {
          return Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/newlogo.png",),
                fit:BoxFit.cover,
              )
            ),
            child: Container(
              alignment: Alignment.bottomRight,
              child: Image.asset('assets/images/baladie.jpeg',width: 120,height: 120,),
            ),
          )
            // Container(
            //   padding: EdgeInsets.only(bottom: 16),
            //   alignment: Alignment.bottomRight,
            //   child: SizedBox(
            //     width: 130, // Adjust the width according to your needs
            //     child: Image.asset('assets/images/baladie.jpeg'), // Replace with your sponsor image path
            //   ),
            // ),
            // Column(
            //   children: [
            //     Center(
            //       child: Container(
            //         height: MediaQuery.of(context).size.height/2,
            //           width: MediaQuery.of(context).size.height/2,
            //           child: Image.asset("assets/images/logo.png")
            //       ),
            //     ),
            //     Container(
            //       height: 200,
            //         width: 200,
            //         child: Image.asset("assets/images/baladie.jpeg")
            //     ),
            //   ],
            // ),
          ;
        }
      },
    );
  }
}
class NavBarPage extends StatefulWidget {
  NavBarPage({Key? key, this.initialPage, this.page,required this.rowguid,required this.startingPage}) : super(key: key);
  final int startingPage;
  final String? initialPage;
  final Widget? page;
  final String rowguid;
  @override
  _NavBarPageState createState() => _NavBarPageState();
}

/// This is the private State class that goes with NavBarPage.
class _NavBarPageState extends State<NavBarPage> {
  String _currentPageName = 'ActivitiesScreen';
  late List<Widget> screens = []; // to store nested tabs
  final PageStorageBucket bucket = PageStorageBucket();
  late Widget currentScreen = screens[widget.startingPage]; // Our first view in viewport

  late int currentTab;
  void _onTabSelected(int index) {
    setState(() {
      currentTab  = index;
    });
  }
  @override
  void initState() {
    super.initState();
    currentTab  = widget.startingPage;
    _currentPageName = widget.initialPage ?? _currentPageName;
    screens=[
      ActivitiesScreenWidget(Regionrowguid: widget.rowguid,),
      PlaceScreenWidget(Regionrowguid: widget.rowguid,),
      RestaurantsScreenWidget(RegionRowguid: widget.rowguid,),
      HotelScreenWidget(),
    ];
  }


  @override
  Widget build(BuildContext context) {
    final String options = 'assets/icons/options.svg';
    const IconData globe = IconData(0xf68d, );
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar:AppBar(
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        automaticallyImplyLeading: false,
        title: Text(
          'Mechwar',
          style: FlutterFlowTheme.of(context).title1
        //       .override(
        //     fontFamily: 'Lexend Deca',
        //     fontSize: 25,
        // //    fontWeight: FontWeight.normal,
        //   ),
        ),
        actions: [
          IconButton(onPressed: (){ Navigator.pop(context);}, icon:Icon(Icons.place,color: Colors.grey,size: 30,),),
          IconButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>UserprofileScreenWidget()));}, icon:SvgPicture.asset(options,color: Colors.grey,height: 30,width: 30,)),//Icon(Icons.more,color:FlutterFlowTheme.of(context).primaryText),iconSize: 30,),
          SizedBox(width: 10,)
        ],
        centerTitle: false,
        elevation: 0,
      ),
      body:  PageStorage(
        child: currentScreen,
        bucket: bucket,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {

          Navigator.push(context,
              MaterialPageRoute(builder: (context) => MapScreenWidget(rowg: widget.rowguid,)));
        },
        child: Icon(Icons.map),
        backgroundColor: FlutterFlowTheme.of(context).primaryColor,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color:FlutterFlowTheme.of(context).secondaryBackground ,
        height: 70,
        shape: CircularNotchedRectangle(),
        notchMargin: 8.0,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.hiking,
                    color: currentTab == 0 ? FlutterFlowTheme.of(context).primaryColor : Colors.grey,
                    size: 30,
                  ),
                  onPressed: () {
                    _onTabSelected(0);
                    currentScreen=screens[currentTab];
                  },
                ),
                currentTab==0? Text('Activities',style: TextStyle(color: FlutterFlowTheme.of(context).primaryColor ),):SizedBox(height: 0,width:0,)
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(
                    FontAwesomeIcons.mapPin,
                    color: currentTab == 1 ? FlutterFlowTheme.of(context).primaryColor : Colors.grey,
                    size: 30,
                  ),
                  onPressed: () {
                    _onTabSelected(1);
                    currentScreen=screens[currentTab];
                  },
                ),
                currentTab==1? Text('Places',style: TextStyle(color: FlutterFlowTheme.of(context).primaryColor ),):SizedBox(height: 0,width:0,)
              ],
            ),
            SizedBox(width: 48.0), // Empty space for the FAB
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.restaurant,
                    color: currentTab== 2 ? FlutterFlowTheme.of(context).primaryColor: Colors.grey,
                    size: 30,
                  ),
                  onPressed: () {
                    _onTabSelected(2);
                    currentScreen=screens[currentTab];
                  },
                ),
                currentTab==2? Text('Restaurants',style: TextStyle(color: FlutterFlowTheme.of(context).primaryColor ),):SizedBox(height: 0,width:0,)
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.hotel,
                    color: currentTab == 3 ? FlutterFlowTheme.of(context).primaryColor : Colors.grey,
                    size: 30,
                  ),
                  onPressed: () {
                    _onTabSelected(3);
                    currentScreen=screens[currentTab];
                  },
                ),
                currentTab==3? Text('Hotels',style: TextStyle(color: FlutterFlowTheme.of(context).primaryColor ),):SizedBox(height: 0,width:0,)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
