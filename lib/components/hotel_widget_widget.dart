import 'package:cached_network_image/cached_network_image.dart';

import '../Models/hotel_model.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import '../hotels_detail_screen/hotels_detail_screen_widget.dart';
import 'hotel_widget_model.dart';
export 'hotel_widget_model.dart';

class HotelWidgetWidget extends StatefulWidget {
  HotelWidgetWidget({Key? key,required this.Hot}) : super(key: key);
  Hotel Hot;
  @override
  _HotelWidgetWidgetState createState() => _HotelWidgetWidgetState();
}

class _HotelWidgetWidgetState extends State<HotelWidgetWidget>
    with TickerProviderStateMixin {
  late HotelWidgetModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HotelWidgetModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.45,
      height: 200,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
        boxShadow: [
          BoxShadow(
            blurRadius: 4,
            color: Color(0x230E151B),
            offset: Offset(0, 2),
          )
        ],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(4, 4, 4, 4),
        child: GestureDetector(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>HotelsDetailScreenWidget(hot: widget.Hot, type: 0,)));
          },
          child:Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 4,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                    imageUrl:widget.Hot.picture,
                    width: double.infinity,
                    height: 135,
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(8, 12, 0, 0),
                      child: Text(
                        '${widget.Hot.name}',
                        style: FlutterFlowTheme.of(context).subtitle1,
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
                    //     rating: double.parse(widget.Hot.rating),
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