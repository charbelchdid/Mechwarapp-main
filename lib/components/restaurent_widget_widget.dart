import 'package:cached_network_image/cached_network_image.dart';

import '../Models/restaurant_model.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import '../restaurants_detail_screen/restaurants_detail_screen_widget.dart';
import 'restaurent_widget_model.dart';
export 'restaurent_widget_model.dart';

class RestaurentWidgetWidget extends StatefulWidget {
  RestaurentWidgetWidget({Key? key,required this.Restau}) : super(key: key);
  Restaurant Restau;
  @override
  _RestaurentWidgetWidgetState createState() => _RestaurentWidgetWidgetState();
}

class _RestaurentWidgetWidgetState extends State<RestaurentWidgetWidget>
    with TickerProviderStateMixin {
  late RestaurentWidgetModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => RestaurentWidgetModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
     // width: MediaQuery.of(context).size.width * 0.45,
      //height: 150,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
        boxShadow: [
          BoxShadow(
            blurRadius: 4,
            color: Color(0x230E151B),
            offset: Offset(0, 2),
          )
        ],
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(16),
          bottomRight: Radius.circular(16),
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
        //borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(4, 4, 4, 4),
        child: GestureDetector(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>RestaurantsDetailScreenWidget(Restau: widget.Restau, type: 0,)));
          },
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 4,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                    imageUrl:widget.Restau.picture,
                    width: double.infinity,
                    //height: 135,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(8, 12, 0, 0),
                      child: Text(
                        '${widget.Restau.name}',
                        style: FlutterFlowTheme.of(context).title3,
                      ),
                    ),
                    // Padding(
                    //   padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 4),
                    //   child: RatingBarIndicator(
                    //     itemBuilder: (context, index) => Icon(
                    //       Icons.star_rounded,
                    //       color: Color(0xFFFFA130),
                    //     ),
                    //     direction: Axis.horizontal,
                    //     rating: double.parse(widget.Restau.rating),
                    //     unratedColor: Color(0xFF95A1AC),
                    //     itemCount: 5,
                    //     itemSize: 24,
                    //   ),
                    // ),
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
