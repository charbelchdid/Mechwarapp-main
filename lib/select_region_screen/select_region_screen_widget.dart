import 'package:c_s_p_app/main.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../Models/regions_model.dart';
import '../Services/Regions.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../provider/LoadProvider.dart';
import 'select_region_screen_model.dart';
export 'select_region_screen_model.dart';
import 'package:provider/provider.dart';

class SelectRegionScreenWidget extends StatefulWidget {
  const SelectRegionScreenWidget({Key? key}) : super(key: key);

  @override
  _SelectRegionScreenWidgetState createState() =>
      _SelectRegionScreenWidgetState();
}

class _SelectRegionScreenWidgetState extends State<SelectRegionScreenWidget> {
  late SelectRegionScreenModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

  late Regions _RegionsList=Regions(success: false, data: []);

  void _getData() async {
    final provider = Provider.of<LoadProvider>(context, listen: false);
    _RegionsList = provider.Region;
    for(int i=0;i<_RegionsList.data.length;i++){
      if(_RegionsList.data[i].name=='Ehden'){
        _RegionsList.data.insert(0, _RegionsList.data[i]);
        _RegionsList.data.removeAt(i+1);
      }
    }
  }
  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SelectRegionScreenModel());
    _getData();
  }

  @override
  void dispose() {
    _model.dispose();

    _unfocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        automaticallyImplyLeading: false,
        title: Text(
          'Where do you want to go?',
          style: FlutterFlowTheme.of(context).title1,
        ),
        actions: [],
        centerTitle: false,
        elevation: 0,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
        child:ListView(
          physics: BouncingScrollPhysics(),
          //mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
              child: _RegionsList.data==[]?CircularProgressIndicator():SingleChildScrollView(
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: _RegionsList.data.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index)=>
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
                          child: GestureDetector(
                            onTap: (){
                              if(_RegionsList.data[index].name=='Ehden')Navigator.push(context, MaterialPageRoute(builder: (context)=>NavBarPage(rowguid: '${_RegionsList.data[index].rowGuid}', startingPage: 1,)));},
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context).primaryBackground,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(8, 8, 12, 8),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Flexible(
                                      flex: 0,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Container(
                                          width: 70,
                                          height: 70,
                                          child: Stack(
                                            children: [
                                              CachedNetworkImage(
                                                imageUrl: '${_RegionsList.data[index].image}',
                                                fit: BoxFit.cover,
                                              ),
                                              if (_RegionsList.data[index].name!='Ehden')
                                                Positioned(
                                                  child: Icon(
                                                    Icons.lock,
                                                    size: 70,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Padding(
                                        padding: EdgeInsets.fromLTRB(16, 0, 0, 0),
                                        child: Text(
                                          _RegionsList.data[index].name=='Ehden'
                                              ? '${_RegionsList.data[index].name} - ${_RegionsList.data[index].arabicName}'
                                              : '${_RegionsList.data[index].name} - ${_RegionsList.data[index].arabicName} Coming Soon',
                                          style: _RegionsList.data[index].name=='Ehden'
                                              ? FlutterFlowTheme.of(context).subtitle1
                                              : FlutterFlowTheme.of(context).subtitle2,
                                        ),
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
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
