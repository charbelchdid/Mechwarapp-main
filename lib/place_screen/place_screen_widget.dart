import '../Models/region_places_models.dart';
import '../Models/regions_model.dart';

import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import '../place_detail_screen/place_detail_screen_widget.dart';
import '../provider/LoadProvider.dart';
import 'place_screen_model.dart';
export 'place_screen_model.dart';

class PlaceScreenWidget extends StatefulWidget {
  const PlaceScreenWidget({Key? key,required this.Regionrowguid,}) : super(key: key);
  final String Regionrowguid;
  @override
  _PlaceScreenWidgetState createState() => _PlaceScreenWidgetState();
}

class _PlaceScreenWidgetState extends State<PlaceScreenWidget>
    with TickerProviderStateMixin {
  late PlaceScreenModel _model;
  late Regions regParent;
  late Datum region;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();
  late List<Place> _PlacesList = [];
  List <Place> _filteredPlaceList=[];

  _getData() async {
    final provider = Provider.of<LoadProvider>(context, listen: false);
      _PlacesList = provider.PlacesList;
      _filteredPlaceList=_PlacesList;
      regParent=provider.Region;
    for (int i=0;i<regParent.data.length;i++){
      if (regParent.data[i].rowGuid==widget.Regionrowguid){
        region=regParent.data[i];
      }
    }
    setState(() {

    });
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PlaceScreenModel());
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
      _filteredPlaceList = _PlacesList;
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LoadProvider>(context, listen: false);
    List<Future> s =[
    provider.getActivity(widget.Regionrowguid,provider.userRowguid),
    provider.getPlacesList(widget.Regionrowguid),
    provider.getRestaurants(widget.Regionrowguid),
    provider.getHotel(widget.Regionrowguid),
    _getData()
    ];
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body:FutureBuilder(
        future: Future.wait(s),
    builder: (context, snapshot) {
          if(snapshot.connectionState==ConnectionState.done||_PlacesList.length>0){
            final provider = Provider.of<LoadProvider>(context, listen: false);
            _PlacesList = provider.PlacesList;
            _filteredPlaceList=_PlacesList;
        return GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Container(
                height: 500,
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  children: [
                    Container(
                      child: Stack(
                        children: [
                        CachedNetworkImage(
                          imageUrl:
                              region.image,
                          width: double.infinity,
                          height: 300,
                          fit: BoxFit.fill,
                        ),
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Padding(
                              //   padding:
                              //       EdgeInsetsDirectional.fromSTEB(16, 30, 16, 0),
                              //   child: Row(
                              //     mainAxisSize: MainAxisSize.max,
                              //     children: [
                              //       Expanded(
                              //         child: Stack(
                              //           alignment: Alignment.centerRight,
                              //           children: [
                              //             TextFormField(
                              //               controller: _model.textController,
                              //               onChanged: (value) {
                              //                 setState(() {
                              //                   _filteredPlaceList = _PlacesList
                              //                       .where((place) => place.name
                              //                       .toLowerCase()
                              //                       .contains(value.toLowerCase()))
                              //                       .toList();
                              //                 });
                              //               },
                              //               obscureText: false,
                              //               decoration: InputDecoration(
                              //                 labelText: 'Find destinations...',
                              //                 labelStyle: FlutterFlowTheme.of(context)
                              //                     .bodyText2,
                              //                 enabledBorder: OutlineInputBorder(
                              //                   borderSide: BorderSide(
                              //                     color: Color(0x00000000),
                              //                     width: 1,
                              //                   ),
                              //                   borderRadius:
                              //                       BorderRadius.circular(16),
                              //                 ),
                              //                 focusedBorder: OutlineInputBorder(
                              //                   borderSide: BorderSide(
                              //                     color: Color(0x00000000),
                              //                     width: 1,
                              //                   ),
                              //                   borderRadius:
                              //                       BorderRadius.circular(16),
                              //                 ),
                              //                 errorBorder: OutlineInputBorder(
                              //                   borderSide: BorderSide(
                              //                     color: Color(0x00000000),
                              //                     width: 1,
                              //                   ),
                              //                   borderRadius:
                              //                       BorderRadius.circular(16),
                              //                 ),
                              //                 focusedErrorBorder: OutlineInputBorder(
                              //                   borderSide: BorderSide(
                              //                     color: Color(0x00000000),
                              //                     width: 1,
                              //                   ),
                              //                   borderRadius:
                              //                       BorderRadius.circular(16),
                              //                 ),
                              //                 filled: true,
                              //                 fillColor: FlutterFlowTheme.of(context)
                              //                     .secondaryBackground,
                              //                 prefixIcon: Icon(
                              //                   Icons.search,
                              //                   color: FlutterFlowTheme.of(context)
                              //                       .primaryText,
                              //                   size: 16,
                              //                 ),
                              //               ),
                              //               style: FlutterFlowTheme.of(context)
                              //                   .bodyText1,
                              //               maxLines: null,
                              //               validator: _model.textControllerValidator
                              //                   .asValidator(context),
                              //             ),
                              //             if (_model.textController.text.isNotEmpty)
                              //               IconButton(
                              //                 onPressed: _clearSearch,
                              //                 icon: Icon(
                              //                   Icons.clear_rounded,
                              //                   color: FlutterFlowTheme.of(context).secondaryText,
                              //                 ),
                              //               ),
                              //           ],
                              //         ),
                              //       ),
                              //     ],
                              //   ),
                              // ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16, 100, 16, 44),
                                child: Center(
                                  child: Text(
                                    '${region.name}  -  ${region.arabicName}',
                                    textAlign: TextAlign.center,
                                    style: FlutterFlowTheme.of(context)
                                        .title1
                                        .override(
                                          fontFamily: 'Lato',
                                          color: FlutterFlowTheme.of(context)
                                              .primaryBtnText,
                                        ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 60, 0, 0),
                                child: Container(
                                  width: double.infinity,
                                  //height: 700,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .primaryBackground,
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(0),
                                      bottomRight: Radius.circular(0),
                                      topLeft: Radius.circular(16),
                                      topRight: Radius.circular(16),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 8, 0, 16),
                                    child: SingleChildScrollView(
                                      physics: NeverScrollableScrollPhysics(),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          _filteredPlaceList.length==_PlacesList.length?Divider(
                                            height: 8,
                                            thickness: 4,
                                            indent: 140,
                                            endIndent: 140,
                                            color: FlutterFlowTheme.of(context)
                                                .lineColor,
                                          ):Text(''),
                                          _filteredPlaceList.length==_PlacesList.length?Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    16, 16, 16, 0),
                                            child: Text(
                                              'Recommended Places',
                                              style: FlutterFlowTheme.of(context)
                                                  .title2,
                                            ),
                                          ):Text(''),
                                          _filteredPlaceList.length==_PlacesList.length?Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 12, 0, 0),
                                            child: Container(
                                              width: double.infinity,
                                              height: 190,
                                              decoration: BoxDecoration(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryBackground,
                                              ),
                                              child: ListView.builder(
                                                physics: BouncingScrollPhysics(),
                                                padding: EdgeInsets.zero,
                                                primary: false,
                                                shrinkWrap: true,
                                                scrollDirection: Axis.horizontal,
                                                itemCount: 3,
                                                itemBuilder: (BuildContext context, int index) {
                                                  return GestureDetector(
                                                    onTap:(){Navigator.push(context, MaterialPageRoute(builder: (context)=>PlaceDetailScreenWidget(place:_PlacesList[index])));},
                                                    child: Padding(
                                                      padding:index==2?EdgeInsetsDirectional
                                                          .fromSTEB(16, 8, 16, 8) :EdgeInsetsDirectional
                                                          .fromSTEB(16, 8, 0, 8),
                                                      child: Container(
                                                        width: 270,
                                                        height: 100,
                                                        decoration: BoxDecoration(
                                                          color: FlutterFlowTheme
                                                              .of(context)
                                                              .secondaryBackground,
                                                          boxShadow: [
                                                            BoxShadow(
                                                              blurRadius: 8,
                                                              color:
                                                              Color(0x230F1113),
                                                              offset: Offset(0, 4),
                                                            )
                                                          ],
                                                          borderRadius:
                                                          BorderRadius.circular(
                                                              12),
                                                        ),
                                                        child: Column(
                                                          mainAxisSize: MainAxisSize.max,
                                                          children: [
                                                            ClipRRect(
                                                              borderRadius:
                                                              BorderRadius.only(
                                                                bottomLeft:
                                                                Radius.circular(
                                                                    0),
                                                                bottomRight:
                                                                Radius.circular(
                                                                    0),
                                                                topLeft:
                                                                Radius.circular(
                                                                    12),
                                                                topRight:
                                                                Radius.circular(
                                                                    12),
                                                              ),
                                                              child:
                                                              CachedNetworkImage(
                                                                imageUrl:_PlacesList[index].picture,
                                                               width:
                                                                double.infinity,
                                                                height: 110,
                                                                fit: BoxFit.fitWidth,
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                  16,
                                                                  12,
                                                                  16,
                                                                  12),
                                                              child: Row(
                                                                mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                                mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                                children: [
                                                                  Column(
                                                                    children: [
                                                                      Text(
                                                                        _PlacesList[index].name,
                                                                        style: FlutterFlowTheme.of(
                                                                            context)
                                                                            .subtitle1,
                                                                      ),
                                                                      // Padding(
                                                                      //   padding: EdgeInsetsDirectional
                                                                      //       .fromSTEB(
                                                                      //       0,
                                                                      //       5,
                                                                      //       0,
                                                                      //       0),
                                                                      //   child: Row(
                                                                      //     mainAxisSize:
                                                                      //     MainAxisSize
                                                                      //         .max,
                                                                      //     children: [
                                                                      //       RatingBarIndicator(
                                                                      //         itemBuilder: (context, index) =>
                                                                      //             Icon(
                                                                      //               Icons.radio_button_checked_rounded,
                                                                      //               color:
                                                                      //               FlutterFlowTheme.of(context).primaryText,
                                                                      //             ),
                                                                      //         direction:
                                                                      //         Axis.horizontal,
                                                                      //         rating:double.parse(_PlacesList[index].rating),
                                                                      //         unratedColor:
                                                                      //         FlutterFlowTheme.of(context).secondaryText,
                                                                      //         itemCount:
                                                                      //         5,
                                                                      //         itemSize:
                                                                      //         16,
                                                                      //       ),
                                                                      //       Padding(
                                                                      //         padding: EdgeInsetsDirectional.fromSTEB(
                                                                      //             8,
                                                                      //             0,
                                                                      //             0,
                                                                      //             0),
                                                                      //         child:
                                                                      //         Text(
                                                                      //           _PlacesList[index].rating,
                                                                      //           style:
                                                                      //           FlutterFlowTheme.of(context).bodyText2,
                                                                      //         ),
                                                                      //       ),
                                                                      //     ],
                                                                      //   ),
                                                                      // ),
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ):Text(''),
                                          _filteredPlaceList.length==_PlacesList.length?Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    16, 16, 16, 0),
                                            child: Text(
                                              'Other Places',
                                              style: FlutterFlowTheme.of(context)
                                                  .title2,
                                            ),
                                          ):Text(''),
                                         Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 20, 0, 2),
                                            child: ListView.builder(
                                              itemCount: _filteredPlaceList.length==_PlacesList.length? _PlacesList.length-3:_filteredPlaceList.length,
                                              padding: EdgeInsets.zero,
                                              primary: false,
                                              shrinkWrap: true,
                                              scrollDirection: Axis.vertical,
                                              itemBuilder: (BuildContext context, int index) =>
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(16, 8, 16, 8),
                                                  child: InkWell(
                                                    onTap: () async {
                                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>PlaceDetailScreenWidget(place:_filteredPlaceList.length==_PlacesList.length?_PlacesList[index+3]:_filteredPlaceList[index])));
                                                    },
                                                    child: Container(
                                                      width: 270,
                                                      decoration: BoxDecoration(
                                                        color: FlutterFlowTheme
                                                                .of(context)
                                                            .secondaryBackground,
                                                        boxShadow: [
                                                          BoxShadow(
                                                            blurRadius: 8,
                                                            color:
                                                                Color(0x230F1113),
                                                            offset: Offset(0, 4),
                                                          )
                                                        ],
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                12),
                                                      ),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          Hero(
                                                            tag: 'italyImage',
                                                            transitionOnUserGestures:
                                                                true,
                                                            child: ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .only(
                                                                bottomLeft: Radius
                                                                    .circular(0),
                                                                bottomRight:
                                                                    Radius
                                                                        .circular(
                                                                            0),
                                                                topLeft: Radius
                                                                    .circular(12),
                                                                topRight: Radius
                                                                    .circular(12),
                                                              ),
                                                              child:
                                                                  CachedNetworkImage(
                                                                imageUrl:
                                                                _filteredPlaceList.length==_PlacesList.length?_PlacesList[index+3].picture:_filteredPlaceList[index].picture,
                                                                    width: double
                                                                    .infinity,
                                                                height: 200,
                                                                fit: BoxFit.cover,
                                                              ),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        16,
                                                                        12,
                                                                        16,
                                                                        12),
                                                            child: Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                      '${_filteredPlaceList.length==_PlacesList.length?_PlacesList[index+3].name:_filteredPlaceList[index].name}',
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .subtitle1,
                                                                    ),
                                                                    // Padding(
                                                                    //   padding: EdgeInsetsDirectional
                                                                    //       .fromSTEB(
                                                                    //       0,
                                                                    //       8,
                                                                    //       0,
                                                                    //       0),
                                                                    //   child: Row(
                                                                    //     mainAxisSize:
                                                                    //     MainAxisSize
                                                                    //         .max,
                                                                    //     children: [
                                                                    //       RatingBarIndicator(
                                                                    //         itemBuilder: (context, index) =>
                                                                    //             Icon(
                                                                    //               Icons.radio_button_checked_rounded,
                                                                    //               color:
                                                                    //               FlutterFlowTheme.of(context).primaryText,
                                                                    //             ),
                                                                    //         direction:
                                                                    //         Axis.horizontal,
                                                                    //         rating:
                                                                    //         double.parse(_PlacesList[index+3].rating),
                                                                    //         unratedColor:
                                                                    //         FlutterFlowTheme.of(context).secondaryText,
                                                                    //         itemCount:
                                                                    //         5,
                                                                    //         itemSize:
                                                                    //         16,
                                                                    //       ),
                                                                    //       Padding(
                                                                    //         padding: EdgeInsetsDirectional.fromSTEB(
                                                                    //             8,
                                                                    //             0,
                                                                    //             0,
                                                                    //             0),
                                                                    //         child:
                                                                    //         Text(
                                                                    //           '${_filteredPlaceList.length==_PlacesList.length?_PlacesList[index+3].rating:_filteredPlaceList[index].rating}',
                                                                    //           style:
                                                                    //           FlutterFlowTheme.of(context).bodyText2,
                                                                    //         ),
                                                                    //       ),
                                                                    //     ],
                                                                    //   ),
                                                                    // ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          SizedBox(height:10)
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                )
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
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
      );
          }
    else{
      return Center(child: CircularProgressIndicator());
    }

        }
        )
    );
  }
}
