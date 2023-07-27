import '../Services/AddUser.dart';
import '../Services/GetUserRowg.dart';
import '../Services/auth.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../forgot_password_screen/forgot_password_screen_widget.dart';
import '../provider/LoadProvider.dart';
import '../select_region_screen/select_region_screen_widget.dart';
import 'sign_in_screen_model.dart';
import 'package:fluttertoast/fluttertoast.dart';
export 'sign_in_screen_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignInScreenWidget extends StatefulWidget {
  const SignInScreenWidget({Key? key}) : super(key: key);

  @override
  _SignInScreenWidgetState createState() => _SignInScreenWidgetState();
}

class _SignInScreenWidgetState extends State<SignInScreenWidget> {
  late SignInScreenModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SignInScreenModel());
    _model.emailAddressLoginController = TextEditingController();
    _model.passwordLoginController = TextEditingController();
    _model.emailAddressController = TextEditingController();
    _model.passwordController = TextEditingController();
    _model.passwordConfirmController = TextEditingController();
    _model.nameController = TextEditingController();
  }

  @override
  void dispose() {
    _model.dispose();

    _unfocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LoadProvider>(context, listen: false);
    return Scaffold(
      key: scaffoldKey,
      backgroundColor:
      FlutterFlowTheme.of(context).primaryBackground, //Color(0xFF14181B),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
        child: Container(
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 70, 0, 0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/logo.png',
                        width: 200,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: DefaultTabController(
                    length: 3,
                    initialIndex: 0,
                    child: Column(
                      children: [
                        TabBar(
                          isScrollable: true,
                          labelColor:
                          FlutterFlowTheme.of(context).primaryColor,
                          labelStyle: FlutterFlowTheme.of(context).subtitle1,
                          indicatorColor:
                          FlutterFlowTheme.of(context).primaryColor,
                          tabs: [
                            Tab(
                              text: 'Sign In',
                            ),
                            Tab(
                              text: 'Sign Up',
                            ),
                          ],
                        ),
                        Expanded(
                          child: TabBarView(
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    44, 0, 44, 0),
                                child: SingleChildScrollView(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Padding(
                                        padding:
                                        EdgeInsetsDirectional.fromSTEB(
                                            0, 20, 0, 0),
                                        child: TextFormField(
                                          controller: _model
                                              .emailAddressLoginController,
                                          obscureText: false,
                                          decoration: InputDecoration(
                                            labelText: 'Email Address',
                                            labelStyle: FlutterFlowTheme.of(
                                                context)
                                                .bodyText1
                                                .override(
                                              fontFamily: 'Lexend Deca',
                                              color: Color(0xFF95A1AC),
                                              fontSize: 14,
                                              fontWeight:
                                              FontWeight.normal,
                                            ),
                                            hintStyle:
                                            FlutterFlowTheme.of(context)
                                                .bodyText1,
                                            // .override(
                                            //   fontFamily: 'Lexend Deca',
                                            //   color: Color(0xFF95A1AC),
                                            //   fontSize: 14,
                                            //   fontWeight:
                                            //       FontWeight.normal,
                                            // ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                //color: Color(0x00000000),
                                                width: 1,
                                              ),
                                              borderRadius:
                                              BorderRadius.circular(8),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                //color: Color(0x00000000),
                                                width: 1,
                                              ),
                                              borderRadius:
                                              BorderRadius.circular(8),
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                //color: Color(0x00000000),
                                                width: 1,
                                              ),
                                              borderRadius:
                                              BorderRadius.circular(8),
                                            ),
                                            focusedErrorBorder:
                                            OutlineInputBorder(
                                              borderSide: BorderSide(
                                                //color: Color(0x00000000),
                                                width: 1,
                                              ),
                                              borderRadius:
                                              BorderRadius.circular(8),
                                            ),
                                            filled: true,
                                            fillColor: Colors.white,
                                            contentPadding:
                                            EdgeInsetsDirectional
                                                .fromSTEB(20, 24, 20, 24),
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .subtitle2,
                                          // .override(
                                          //   fontFamily: 'Lato',
                                          //   color: Color(0xFF0F1113),
                                          // ),
                                          validator: _model
                                              .emailAddressLoginControllerValidator
                                              .asValidator(context),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                        EdgeInsetsDirectional.fromSTEB(
                                            0, 12, 0, 0),
                                        child: TextFormField(
                                          controller:
                                          _model.passwordLoginController,
                                          obscureText:
                                          !_model.passwordLoginVisibility,
                                          decoration: InputDecoration(
                                            labelText: 'Password',
                                            labelStyle: FlutterFlowTheme.of(
                                                context)
                                                .bodyText1
                                                .override(
                                              fontFamily: 'Lexend Deca',
                                              color: Color(0xFF95A1AC),
                                              fontSize: 14,
                                              fontWeight:
                                              FontWeight.normal,
                                            ),
                                            hintStyle: FlutterFlowTheme.of(
                                                context)
                                                .bodyText1
                                                .override(
                                              fontFamily: 'Lexend Deca',
                                              color: Color(0xFF95A1AC),
                                              fontSize: 14,
                                              fontWeight:
                                              FontWeight.normal,
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                //color: Color(0x00000000),
                                                width: 1,
                                              ),
                                              borderRadius:
                                              BorderRadius.circular(8),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                //color: Color(0x00000000),
                                                width: 1,
                                              ),
                                              borderRadius:
                                              BorderRadius.circular(8),
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                //color: Color(0x00000000),
                                                width: 1,
                                              ),
                                              borderRadius:
                                              BorderRadius.circular(8),
                                            ),
                                            focusedErrorBorder:
                                            OutlineInputBorder(
                                              borderSide: BorderSide(
                                                //color: Color(0x00000000),
                                                width: 1,
                                              ),
                                              borderRadius:
                                              BorderRadius.circular(8),
                                            ),
                                            filled: true,
                                            fillColor: Colors.white,
                                            contentPadding:
                                            EdgeInsetsDirectional
                                                .fromSTEB(20, 24, 20, 24),
                                            suffixIcon: InkWell(
                                              onTap: () => setState(
                                                    () => _model
                                                    .passwordLoginVisibility =
                                                !_model
                                                    .passwordLoginVisibility,
                                              ),
                                              focusNode: FocusNode(
                                                  skipTraversal: true),
                                              child: Icon(
                                                _model.passwordLoginVisibility
                                                    ? Icons
                                                    .visibility_outlined
                                                    : Icons
                                                    .visibility_off_outlined,
                                                color: Color(0xFF95A1AC),
                                                size: 20,
                                              ),
                                            ),
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .subtitle2,
                                          // .override(
                                          //   fontFamily: 'Lato',
                                          //   color: Color(0xFF0F1113),
                                          // ),
                                          validator: _model
                                              .passwordLoginControllerValidator
                                              .asValidator(context),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                        EdgeInsetsDirectional.fromSTEB(
                                            0, 24, 0, 0),
                                        child: FFButtonWidget(
                                          onPressed: () {
                                            Auth()
                                                .signInWithEmailAndPassword(
                                                email: _model
                                                    .emailAddressLoginController
                                                    .text,
                                                password: _model
                                                    .passwordLoginController
                                                    .text)
                                                .then((value) {
                                              saveUserDataLocally(
                                                  _model
                                                      .emailAddressLoginController
                                                      .text,
                                                  'charbel');
                                              return {
                                              provider.getUserInfo(
                                                  0, context),provider.state=1,
                                              Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                              builder: (context) =>
                                              SelectRegionScreenWidget()))
                                              };
                                            }).onError((error, stackTrace) {
                                              String errorMessage =
                                              error.toString();
                                              int index =
                                              errorMessage.indexOf("]");
                                              String substring = errorMessage;
                                              if (index != -1 &&
                                                  index <
                                                      errorMessage.length -
                                                          1) {
                                                substring = errorMessage
                                                    .substring(index + 1);
                                              }
                                              showErrorMessage(
                                                  substring, context);
                                              throw 'Could not Login';
                                            });
                                          },
                                          text: 'Login',
                                          options: FFButtonOptions(
                                            width: 230,
                                            height: 50,
                                            color:
                                            FlutterFlowTheme.of(context)
                                                .primaryColor,
                                            textStyle: FlutterFlowTheme.of(
                                                context)
                                                .subtitle2
                                                .override(
                                              fontFamily: 'Lexend Deca',
                                              color: FlutterFlowTheme.of(
                                                  context)
                                                  .primaryBtnText,
                                              fontSize: 16,
                                              fontWeight:
                                              FontWeight.normal,
                                            ),
                                            elevation: 3,
                                            borderSide: BorderSide(
                                              color: Colors.transparent,
                                              width: 1,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                        EdgeInsetsDirectional.fromSTEB(
                                            0, 20, 0, 0),
                                        child: FFButtonWidget(
                                          onPressed: () async {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ForgotPasswordScreenWidget()));
                                          },
                                          text: 'Forgot Password?',
                                          options: FFButtonOptions(
                                            width: 170,
                                            height: 40,
                                            color: Color(0x0039D2C0),
                                            textStyle:
                                            FlutterFlowTheme.of(context)
                                                .subtitle1,
                                            // .override(
                                            //   fontFamily: 'Lato',
                                            //   color:
                                            //       FlutterFlowTheme.of(
                                            //               context)
                                            //           .primaryBtnText,
                                            // ),
                                            elevation: 0,
                                            borderSide: BorderSide(
                                              color: Colors.transparent,
                                              width: 1,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    44, 0, 44, 0),
                                child: SingleChildScrollView(
                                  primary: false,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Padding(
                                        padding:
                                        EdgeInsetsDirectional.fromSTEB(
                                            0, 20, 0, 0),
                                        child: TextFormField(
                                          controller:
                                          _model.emailAddressController,
                                          obscureText: false,
                                          decoration: InputDecoration(
                                            labelText: 'Email Address',
                                            labelStyle: FlutterFlowTheme.of(
                                                context)
                                                .bodyText1
                                                .override(
                                              fontFamily: 'Lexend Deca',
                                              color: Color(0xFF95A1AC),
                                              fontSize: 14,
                                              fontWeight:
                                              FontWeight.normal,
                                            ),
                                            hintStyle:
                                            FlutterFlowTheme.of(context)
                                                .bodyText1,
                                            // .override(
                                            //   fontFamily: 'Lexend Deca',
                                            //   color: Color(0xFF95A1AC),
                                            //   fontSize: 14,
                                            //   fontWeight:
                                            //       FontWeight.normal,
                                            // ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                //color: Color(0x00000000),
                                                width: 1,
                                              ),
                                              borderRadius:
                                              BorderRadius.circular(8),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                //color: Color(0x00000000),
                                                width: 1,
                                              ),
                                              borderRadius:
                                              BorderRadius.circular(8),
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                //color: Color(0x00000000),
                                                width: 1,
                                              ),
                                              borderRadius:
                                              BorderRadius.circular(8),
                                            ),
                                            focusedErrorBorder:
                                            OutlineInputBorder(
                                              borderSide: BorderSide(
                                                //color: Color(0x00000000),
                                                width: 1,
                                              ),
                                              borderRadius:
                                              BorderRadius.circular(8),
                                            ),
                                            filled: true,
                                            fillColor: Colors.white,
                                            contentPadding:
                                            EdgeInsetsDirectional
                                                .fromSTEB(20, 24, 20, 24),
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .subtitle2,
                                          validator: _model
                                              .emailAddressControllerValidator
                                              .asValidator(context),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                        EdgeInsetsDirectional.fromSTEB(
                                            0, 20, 0, 0),
                                        child: TextFormField(
                                          controller: _model.nameController,
                                          obscureText: false,
                                          decoration: InputDecoration(
                                            labelText: 'Username',
                                            labelStyle: FlutterFlowTheme.of(
                                                context)
                                                .bodyText1
                                                .override(
                                              fontFamily: 'Lexend Deca',
                                              color: Color(0xFF95A1AC),
                                              fontSize: 14,
                                              fontWeight:
                                              FontWeight.normal,
                                            ),
                                            hintStyle:
                                            FlutterFlowTheme.of(context)
                                                .bodyText1,
                                            // .override(
                                            //   fontFamily: 'Lexend Deca',
                                            //   color: Color(0xFF95A1AC),
                                            //   fontSize: 14,
                                            //   fontWeight:
                                            //       FontWeight.normal,
                                            // ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                //color: Color(0x00000000),
                                                width: 1,
                                              ),
                                              borderRadius:
                                              BorderRadius.circular(8),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                //color: Color(0x00000000),
                                                width: 1,
                                              ),
                                              borderRadius:
                                              BorderRadius.circular(8),
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                //color: Color(0x00000000),
                                                width: 1,
                                              ),
                                              borderRadius:
                                              BorderRadius.circular(8),
                                            ),
                                            focusedErrorBorder:
                                            OutlineInputBorder(
                                              borderSide: BorderSide(
                                                //color: Color(0x00000000),
                                                width: 1,
                                              ),
                                              borderRadius:
                                              BorderRadius.circular(8),
                                            ),
                                            filled: true,
                                            fillColor: Colors.white,
                                            contentPadding:
                                            EdgeInsetsDirectional
                                                .fromSTEB(20, 24, 20, 24),
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .subtitle2,
                                          validator: _model
                                              .nameControllerValidator
                                              .asValidator(context),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                        EdgeInsetsDirectional.fromSTEB(
                                            0, 12, 0, 0),
                                        child: TextFormField(
                                          controller:
                                          _model.passwordController,
                                          obscureText:
                                          !_model.passwordVisibility,
                                          decoration: InputDecoration(
                                            labelText: 'Password',
                                            labelStyle: FlutterFlowTheme.of(
                                                context)
                                                .bodyText1
                                                .override(
                                              fontFamily: 'Lexend Deca',
                                              color: Color(0xFF95A1AC),
                                              fontSize: 14,
                                              fontWeight:
                                              FontWeight.normal,
                                            ),
                                            hintStyle:
                                            FlutterFlowTheme.of(context)
                                                .bodyText1,
                                            // .override(
                                            //   fontFamily: 'Lexend Deca',
                                            //   color: Color(0xFF95A1AC),
                                            //   fontSize: 14,
                                            //   fontWeight:
                                            //       FontWeight.normal,
                                            // ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                //color: Color(0x00000000),
                                                width: 1,
                                              ),
                                              borderRadius:
                                              BorderRadius.circular(8),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                //color: Color(0x00000000),
                                                width: 1,
                                              ),
                                              borderRadius:
                                              BorderRadius.circular(8),
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                // color: Color(0x00000000),
                                                width: 1,
                                              ),
                                              borderRadius:
                                              BorderRadius.circular(8),
                                            ),
                                            focusedErrorBorder:
                                            OutlineInputBorder(
                                              borderSide: BorderSide(
                                                //color: Color(0x00000000),
                                                width: 1,
                                              ),
                                              borderRadius:
                                              BorderRadius.circular(8),
                                            ),
                                            filled: true,
                                            fillColor: Colors.white,
                                            contentPadding:
                                            EdgeInsetsDirectional
                                                .fromSTEB(20, 24, 20, 24),
                                            suffixIcon: InkWell(
                                              onTap: () => setState(
                                                    () => _model
                                                    .passwordVisibility =
                                                !_model
                                                    .passwordVisibility,
                                              ),
                                              focusNode: FocusNode(
                                                  skipTraversal: true),
                                              child: Icon(
                                                _model.passwordVisibility
                                                    ? Icons
                                                    .visibility_outlined
                                                    : Icons
                                                    .visibility_off_outlined,
                                                color: Color(0xFF95A1AC),
                                                size: 20,
                                              ),
                                            ),
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .subtitle2,
                                          validator: _model
                                              .passwordControllerValidator
                                              .asValidator(context),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                        EdgeInsetsDirectional.fromSTEB(
                                            0, 12, 0, 0),
                                        child: TextFormField(
                                          controller: _model
                                              .passwordConfirmController,
                                          obscureText: !_model
                                              .passwordConfirmVisibility,
                                          decoration: InputDecoration(
                                            labelText: 'Confirm Password',
                                            labelStyle: FlutterFlowTheme.of(
                                                context)
                                                .bodyText1
                                                .override(
                                              fontFamily: 'Lexend Deca',
                                              color: Color(0xFF95A1AC),
                                              fontSize: 14,
                                              fontWeight:
                                              FontWeight.normal,
                                            ),
                                            hintStyle:
                                            FlutterFlowTheme.of(context)
                                                .bodyText1,
                                            // .override(
                                            //   fontFamily: 'Lexend Deca',
                                            //   color: Color(0xFF95A1AC),
                                            //   fontSize: 14,
                                            //   fontWeight:
                                            //       FontWeight.normal,
                                            // ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                //color: Color(0x00000000),
                                                width: 1,
                                              ),
                                              borderRadius:
                                              BorderRadius.circular(8),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                //color: Color(0x00000000),
                                                width: 1,
                                              ),
                                              borderRadius:
                                              BorderRadius.circular(8),
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                //color: Color(0x00000000),
                                                width: 1,
                                              ),
                                              borderRadius:
                                              BorderRadius.circular(8),
                                            ),
                                            focusedErrorBorder:
                                            OutlineInputBorder(
                                              borderSide: BorderSide(
                                                // color: Color(0x00000000),
                                                width: 1,
                                              ),
                                              borderRadius:
                                              BorderRadius.circular(8),
                                            ),
                                            filled: true,
                                            fillColor: Colors.white,
                                            contentPadding:
                                            EdgeInsetsDirectional
                                                .fromSTEB(20, 24, 20, 24),
                                            suffixIcon: InkWell(
                                              onTap: () => setState(
                                                    () => _model
                                                    .passwordConfirmVisibility =
                                                !_model
                                                    .passwordConfirmVisibility,
                                              ),
                                              focusNode: FocusNode(
                                                  skipTraversal: true),
                                              child: Icon(
                                                _model.passwordConfirmVisibility
                                                    ? Icons
                                                    .visibility_outlined
                                                    : Icons
                                                    .visibility_off_outlined,
                                                color: Color(0xFF95A1AC),
                                                size: 20,
                                              ),
                                            ),
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .subtitle2,
                                          validator: _model
                                              .passwordConfirmControllerValidator
                                              .asValidator(context),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                        EdgeInsetsDirectional.fromSTEB(
                                            0, 24, 0, 0),
                                        child: FFButtonWidget(
                                          onPressed: () {
                                            provider.state=1;
                                            Auth()
                                                .createUserWithEmailAndPassword(
                                                email: _model
                                                    .emailAddressController
                                                    .text,
                                                password: _model
                                                    .passwordController
                                                    .text)
                                                .then((value) {
                                              addUser(
                                                  _model.nameController.text,
                                                  '${_model.emailAddressController.text}',
                                                  '',
                                                  context);
                                            }).onError((error, stackTrace) {
                                              provider.state=0;
                                              String errorMessage =
                                              error.toString();
                                              int index =
                                              errorMessage.indexOf("]");
                                              String substring = errorMessage;
                                              if (index != -1 &&
                                                  index <
                                                      errorMessage.length -
                                                          1) {
                                                substring = errorMessage
                                                    .substring(index + 1);
                                              }
                                              showErrorMessage(
                                                  substring, context);
                                            });
                                          },
                                          text: 'Create Account',
                                          options: FFButtonOptions(
                                            width: 230,
                                            height: 50,
                                            color:
                                            FlutterFlowTheme.of(context)
                                                .primaryColor,
                                            textStyle: FlutterFlowTheme.of(
                                                context)
                                                .subtitle1
                                                .override(
                                              fontFamily: 'Lexend Deca',
                                              color: FlutterFlowTheme.of(
                                                  context)
                                                  .primaryBtnText,
                                              fontSize: 16,
                                              fontWeight:
                                              FontWeight.normal,
                                            ),
                                            elevation: 3,
                                            borderSide: BorderSide(
                                              color: Colors.transparent,
                                              width: 1,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void showErrorMessage(String errorMessage, BuildContext context) {
  final snackBar = SnackBar(
    content: Text(errorMessage),
    duration: Duration(seconds: 2), // Adjust the duration as desired
  );

  // Show the SnackBar in the Scaffold's context
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}