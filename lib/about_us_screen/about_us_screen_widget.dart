import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../flutter_flow/flutter_flow_theme.dart';

class AboutUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back,color: FlutterFlowTheme.of(context).grayIcon),
        ),
        title: Text('About Us',style: FlutterFlowTheme.of(context).title1,),
      ),
      body: Container(
        child: ListView(
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          children: [
            CachedNetworkImage(
              height:  MediaQuery.of(context).size.height/2.5,
              imageUrl:
             'https://csp-aub.s3.amazonaws.com/Images/aboutus.jpg',
              width: double.infinity,
              fit: BoxFit.fill,
            ),
            SizedBox(height: 20,),
            Center(
              child: Text(
                'Welcome',
                style:FlutterFlowTheme.of(context).title1,
              ),
            ),
            SizedBox(height: 16.0),
            Center(
              child: Text(
                'We are a dedicated team of professionals passionate about providing an exceptional user experience and bringing innovative solutions to your fingertips. Our goal is to create a seamless and enjoyable experience for you, whether you\'re looking for local guides, entertainment, trips, or touristic places.',
                style: FlutterFlowTheme.of(context).title3,
                textAlign: TextAlign.center,
              ),
            ),
            
          ],
        ),
      ),
    );
  }

  Widget _buildTeamMember(
      String imagePath, String name, String role, String bio,BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color:  FlutterFlowTheme.of(context).secondaryBackground,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 4.0,
            spreadRadius: 1.0,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 80.0,
            backgroundImage:NetworkImage(imagePath),
            backgroundColor: FlutterFlowTheme.of(context).primaryColor,
          ),
          SizedBox(height: 16.0),
          Text(
            name,
            style: FlutterFlowTheme.of(context).subtitle1,
          ),
          SizedBox(height: 4.0),
          Text(
            role,
            style: FlutterFlowTheme.of(context).subtitle2,
          ),
          SizedBox(height: 8.0),
          Text(
            bio,
            style: FlutterFlowTheme.of(context).bodyText1,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
