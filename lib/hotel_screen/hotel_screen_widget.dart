import '../Models/hotel_model.dart';
import '../components/hotel_widget_widget.dart';
import '../components/restaurent_widget_widget.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../provider/LoadProvider.dart';
import 'hotel_screen_model.dart';
export 'hotel_screen_model.dart';

class HotelScreenWidget extends StatefulWidget {
  const HotelScreenWidget({Key? key}) : super(key: key);

  @override
  _HotelScreenWidgetState createState() => _HotelScreenWidgetState();
}

class _HotelScreenWidgetState extends State<HotelScreenWidget> {
  late HotelScreenModel _model;
  late List<Hotel> _HotelsList = [];
  List<Hotel> _filteredHotelsList = [];
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

  void _getData() async {
    final provider = Provider.of<LoadProvider>(context, listen: false);
    _HotelsList = provider.HotelsList;
    _filteredHotelsList = _HotelsList;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HotelScreenModel());
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
      _filteredHotelsList = _HotelsList;
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
                          _filteredHotelsList = _HotelsList
                              .where((hotel) => hotel.name
                              .toLowerCase()
                              .contains(value.toLowerCase()))
                              .toList();
                        });
                      },
                      onFieldSubmitted: (_) => _unfocusNode.requestFocus(),
                      obscureText: false,
                      textInputAction: TextInputAction.search,
                      decoration: InputDecoration(
                        labelText: 'Search Hotels',
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
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(12, 12, 12, 0),
                child: GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: _filteredHotelsList.length,
                  itemBuilder: (context, index) =>HotelWidgetWidget(
                    Hot: _filteredHotelsList[index],
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
