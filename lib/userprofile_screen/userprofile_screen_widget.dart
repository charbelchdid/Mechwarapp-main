import 'package:c_s_p_app/index.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../Models/user_info_model.dart';
import '../Services/GetUserRowg.dart';
import '../about_us_screen/about_us_screen_widget.dart';
import '../edit_profile_screen/edit_profile_screen_widget.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../provider/LoadProvider.dart';
import 'userprofile_screen_model.dart';
export 'userprofile_screen_model.dart';

class UserprofileScreenWidget extends StatefulWidget {
  const UserprofileScreenWidget({Key? key}) : super(key: key);

  @override
  _UserprofileScreenWidgetState createState() =>
      _UserprofileScreenWidgetState();
}

class _UserprofileScreenWidgetState extends State<UserprofileScreenWidget>
    with TickerProviderStateMixin {
  late UserprofileScreenModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();
  late Payload userInfo;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => UserprofileScreenModel());
  }

  @override
  void dispose() {
    _model.dispose();

    _unfocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      final provider = Provider.of<LoadProvider>(context, listen: true);
      userInfo=provider.user;
    });
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 12, 0),
            child: FlutterFlowIconButton(
              borderColor: Colors.transparent,
              borderRadius: 30,
              borderWidth: 1,
              buttonSize: 60,
              icon: Icon(
                Icons.close_rounded,
                color: FlutterFlowTheme.of(context).secondaryText,
                size: 30,
              ),
              onPressed: () async {
                Navigator.pop(context);
              },
            ),
          ),
        ],
        centerTitle: false,
        elevation: 0,
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: [
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(height: 100,),
                  Card(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    color: FlutterFlowTheme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(2, 2, 2, 2),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(60),
                        child: Image.network(
                          '${userInfo.profile}',
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                    child: Text(
                      '${userInfo.name}',
                      style: FlutterFlowTheme.of(context).title3,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                    child: Text(
                      '${userInfo.email}',
                      style: FlutterFlowTheme.of(context).subtitle2.override(
                        fontFamily: 'Lato',
                        color: FlutterFlowTheme.of(context).primaryColor,
                      ),
                    ),
                  ),
                  Divider(
                    height: 44,
                    thickness: 1,
                    indent: 24,
                    endIndent: 24,
                    color: FlutterFlowTheme.of(context).lineColor,
                  ),
                  // Padding(
                  //   padding: EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
                  //   child: Column(
                  //     mainAxisSize: MainAxisSize.max,
                  //     children: [
                  //       if (Theme.of(context).brightness == Brightness.light)
                  //         InkWell(
                  //           onTap: () async {
                  //             setDarkModeSetting(context, ThemeMode.dark);
                  //             setDarkModeSetting(context, ThemeMode.dark);
                  //           },
                  //           child: Container(
                  //             width: MediaQuery.of(context).size.width,
                  //             decoration: BoxDecoration(
                  //               color: FlutterFlowTheme.of(context)
                  //                   .secondaryBackground,
                  //               borderRadius: BorderRadius.circular(12),
                  //               border: Border.all(
                  //                 color: FlutterFlowTheme.of(context).primaryColor,
                  //                 width: 2,
                  //               ),
                  //             ),
                  //             child: Padding(
                  //               padding:
                  //                   EdgeInsetsDirectional.fromSTEB(12, 8, 12, 8),
                  //               child: Row(
                  //                 mainAxisSize: MainAxisSize.max,
                  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //                 children: [
                  //                   Padding(
                  //                     padding: EdgeInsetsDirectional.fromSTEB(
                  //                         4, 0, 0, 0),
                  //                     child: Icon(
                  //                       Icons.nights_stay_outlined,
                  //                       color: FlutterFlowTheme.of(context)
                  //                           .primaryText,
                  //                       size: 24,
                  //                     ),
                  //                   ),
                  //                   Expanded(
                  //                     child: Padding(
                  //                       padding: EdgeInsetsDirectional.fromSTEB(
                  //                           12, 0, 0, 0),
                  //                       child: Text(
                  //                         'Switch to Dark Mode',
                  //                         style: FlutterFlowTheme.of(context)
                  //                             .bodyText2,
                  //                       ),
                  //                     ),
                  //                   ),
                  //                   Container(
                  //                     width: 80,
                  //                     height: 40,
                  //                     decoration: BoxDecoration(
                  //                       color: FlutterFlowTheme.of(context)
                  //                           .primaryBackground,
                  //                       borderRadius: BorderRadius.circular(20),
                  //                     ),
                  //                     child: Stack(
                  //                       alignment: AlignmentDirectional(0, 0),
                  //                       children: [
                  //                         Align(
                  //                           alignment:
                  //                               AlignmentDirectional(0.95, 0),
                  //                           child: Padding(
                  //                             padding:
                  //                                 EdgeInsetsDirectional.fromSTEB(
                  //                                     0, 0, 8, 0),
                  //                             child: Icon(
                  //                               Icons.nights_stay,
                  //                               color: FlutterFlowTheme.of(context)
                  //                                   .secondaryText,
                  //                               size: 20,
                  //                             ),
                  //                           ),
                  //                         ),
                  //                         Align(
                  //                           alignment:
                  //                               AlignmentDirectional(-0.99, -1.59),
                  //                           child: Container(
                  //                             width: 36,
                  //                             height: 36,
                  //                             decoration: BoxDecoration(
                  //                               color: FlutterFlowTheme.of(context)
                  //                                   .secondaryBackground,
                  //                               boxShadow: [
                  //                                 BoxShadow(
                  //                                   blurRadius: 4,
                  //                                   color: Color(0x430B0D0F),
                  //                                   offset: Offset(0, 2),
                  //                                 )
                  //                               ],
                  //                               borderRadius:
                  //                                   BorderRadius.circular(30),
                  //                               shape: BoxShape.rectangle,
                  //                             ),
                  //                           ),
                  //                         ),
                  //                       ],
                  //                     ),
                  //                   ),
                  //                 ],
                  //               ),
                  //             ),
                  //           ),
                  //         ),
                  //       if (Theme.of(context).brightness == Brightness.dark)
                  //         InkWell(
                  //           onTap: () async {
                  //             setDarkModeSetting(context, ThemeMode.light);
                  //             setDarkModeSetting(context, ThemeMode.light);
                  //           },
                  //           child: Container(
                  //             width: MediaQuery.of(context).size.width,
                  //             decoration: BoxDecoration(
                  //               color: FlutterFlowTheme.of(context)
                  //                   .secondaryBackground,
                  //               boxShadow: [
                  //                 BoxShadow(
                  //                   blurRadius: 1,
                  //                   color: Color(0xFF1A1F24),
                  //                   offset: Offset(0, 0),
                  //                 )
                  //               ],
                  //               borderRadius: BorderRadius.circular(12),
                  //               border: Border.all(
                  //                 color: FlutterFlowTheme.of(context).primaryColor,
                  //                 width: 2,
                  //               ),
                  //             ),
                  //             child: Padding(
                  //               padding:
                  //                   EdgeInsetsDirectional.fromSTEB(12, 8, 12, 8),
                  //               child: Row(
                  //                 mainAxisSize: MainAxisSize.max,
                  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //                 children: [
                  //                   Padding(
                  //                     padding: EdgeInsetsDirectional.fromSTEB(
                  //                         4, 0, 0, 0),
                  //                     child: Icon(
                  //                       Icons.wb_sunny_outlined,
                  //                       color: FlutterFlowTheme.of(context)
                  //                           .primaryText,
                  //                       size: 24,
                  //                     ),
                  //                   ),
                  //                   Expanded(
                  //                     child: Padding(
                  //                       padding: EdgeInsetsDirectional.fromSTEB(
                  //                           12, 0, 0, 0),
                  //                       child: Text(
                  //                         'Switch to Light Mode',
                  //                         style: FlutterFlowTheme.of(context)
                  //                             .bodyText2,
                  //                       ),
                  //                     ),
                  //                   ),
                  //                   Container(
                  //                     width: 80,
                  //                     height: 40,
                  //                     decoration: BoxDecoration(
                  //                       color:
                  //                           FlutterFlowTheme.of(context).lineColor,
                  //                       borderRadius: BorderRadius.circular(20),
                  //                     ),
                  //                     child: Stack(
                  //                       alignment: AlignmentDirectional(0, 0),
                  //                       children: [
                  //                         Align(
                  //                           alignment:
                  //                               AlignmentDirectional(-0.9, 0),
                  //                           child: Padding(
                  //                             padding:
                  //                                 EdgeInsetsDirectional.fromSTEB(
                  //                                     8, 2, 0, 0),
                  //                             child: Icon(
                  //                               Icons.wb_sunny_rounded,
                  //                               color: Color(0xFF95A1AC),
                  //                               size: 24,
                  //                             ),
                  //                           ),
                  //                         ),
                  //                         Align(
                  //                           alignment: AlignmentDirectional(0.9, 0),
                  //                           child: Container(
                  //                             width: 36,
                  //                             height: 36,
                  //                             decoration: BoxDecoration(
                  //                               color: Color(0xFF14181B),
                  //                               boxShadow: [
                  //                                 BoxShadow(
                  //                                   blurRadius: 4,
                  //                                   color: Color(0x430B0D0F),
                  //                                   offset: Offset(0, 2),
                  //                                 )
                  //                               ],
                  //                               borderRadius:
                  //                                   BorderRadius.circular(30),
                  //                               shape: BoxShape.rectangle,
                  //                             ),
                  //                           ),
                  //                         ),
                  //                       ],
                  //                     ),
                  //                   ),
                  //                 ],
                  //               ),
                  //             ),
                  //           ),
                  //         ),
                  //     ],
                  //   ),
                  // ),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>EditProfileScreen(name: userInfo.name, email: userInfo.email, photo: userInfo.profile,)));
                    },
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).secondaryBackground,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: FlutterFlowTheme.of(context).primaryColor,
                            width: 2,
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(8, 12, 8, 12),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(8, 0, 0, 0),
                                child: Icon(
                                  Icons.account_circle_outlined,
                                  color: FlutterFlowTheme.of(context).primaryText,
                                  size: 24,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                                child: Text(
                                  'Edit Profile',
                                  style: FlutterFlowTheme.of(context).bodyText2,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>AboutUsPage()));
                    },
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).secondaryBackground,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: FlutterFlowTheme.of(context).primaryColor,
                            width: 2,
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(8, 12, 8, 12),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(8, 0, 0, 0),
                                child: Icon(
                                  Icons.short_text_outlined,
                                  color: FlutterFlowTheme.of(context).primaryText,
                                  size: 24,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                                child: Text(
                                  'About us',
                                  style: FlutterFlowTheme.of(context).bodyText2,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return DeleteDialog();
                        },
                      ).then((confirmed) async {
                        if (confirmed != null && confirmed) {
                          User? user = FirebaseAuth.instance.currentUser;
                        if (user != null) {
                        await user.delete();
                        await FirebaseAuth.instance.signOut();
                        print("Account deleted successfully");
                        } else {
                        print("User is not logged in.");
                        }
                        removeUserDataLocally();
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (BuildContext context)=>SignInScreenWidget()),(route) => false,);
                        } else {
                        // User canceled the log out
                        // ...
                        }
                      });
                    },
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).secondaryBackground,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.red,
                            width: 2,
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(8, 12, 8, 12),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(8, 0, 0, 0),
                                child: Icon(
                                  Icons.delete,
                                  color: FlutterFlowTheme.of(context).primaryText,
                                  size: 24,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                                child: Text(
                                  'Delete Account',
                                  style: FlutterFlowTheme.of(context).bodyText2,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Padding(
                  //   padding: EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
                  //   child: Container(
                  //     width: double.infinity,
                  //     decoration: BoxDecoration(
                  //       color: FlutterFlowTheme.of(context).secondaryBackground,
                  //       borderRadius: BorderRadius.circular(12),
                  //       border: Border.all(
                  //         color: FlutterFlowTheme.of(context).lineColor,
                  //         width: 2,
                  //       ),
                  //     ),
                  //     child: Padding(
                  //       padding: EdgeInsetsDirectional.fromSTEB(8, 12, 8, 12),
                  //       child: Row(
                  //         mainAxisSize: MainAxisSize.max,
                  //         children: [
                  //           Padding(
                  //             padding: EdgeInsetsDirectional.fromSTEB(8, 0, 0, 0),
                  //             child: Icon(
                  //               Icons.settings_outlined,
                  //               color: FlutterFlowTheme.of(context).primaryText,
                  //               size: 24,
                  //             ),
                  //           ),
                  //           Padding(
                  //             padding: EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                  //             child: Text(
                  //               'Account Settings',
                  //               style: FlutterFlowTheme.of(context).bodyText2,
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                    child: FFButtonWidget(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return LogoutDialog();
                          },
                        ).then((confirmed) async {
                          if (confirmed != null && confirmed) {
                            removeUserDataLocally();
                            await FirebaseAuth.instance.signOut();
                            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (BuildContext context)=>SignInScreenWidget()),(route) => false,);
                          } else {
                            // User canceled the log out
                            // ...
                          }
                        });
                      },
                      text: 'Log Out',
                      options: FFButtonOptions(
                        width: 150,
                        height: 44,
                        color: FlutterFlowTheme.of(context).primaryBackground,
                        textStyle: FlutterFlowTheme.of(context).bodyText2,
                        elevation: 0,
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).lineColor,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(38),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LogoutDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 8.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10.0,
              offset: Offset(0, 5),
            ),
          ],
        ),
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.logout,
              size: 48.0,
              color: FlutterFlowTheme.of(context).primaryColor,
            ),
            SizedBox(height: 16.0),
            Text(
              'Are you sure you want to log out?',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(false),
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
                  child: Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(true),
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
                  child: Text('Log Out'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
class DeleteDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 8.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10.0,
              offset: Offset(0, 5),
            ),
          ],
        ),
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.logout,
              size: 48.0,
              color: Colors.red,
            ),
            SizedBox(height: 16.0),
            Text(
              'Are you sure you want to delete your account?',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(false),
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
                  child: Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    padding: EdgeInsets.symmetric(
                      vertical: 12.0,
                      horizontal: 24.0,
                    ),
                  ),
                  child: Text('Delete'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}