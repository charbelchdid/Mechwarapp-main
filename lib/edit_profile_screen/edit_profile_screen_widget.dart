import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../Services/EditUserProfile.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../provider/LoadProvider.dart';

class EditProfileScreen extends StatefulWidget {
  EditProfileScreen({Key? key,required this.name,required this.email, required this.photo}) : super(key: key);
  String name;
  String email;
  String photo;
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late String _profilePicture;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: '${widget.name}');
    _emailController = TextEditingController(text: '${widget.email}');
    _profilePicture=widget.photo;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _selectProfilePicture() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _profilePicture = image.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LoadProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
      body: Stack(
        children: [
          Center(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      //onTap: _selectProfilePicture,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          CircleAvatar(
                            radius: 64,
                            backgroundImage: NetworkImage(_profilePicture),
                            backgroundColor: Colors.black ,
                          ),
                          // Positioned(
                          //   bottom: 0,
                          //   right: 0,
                          //   child: CircleAvatar(
                          //     backgroundColor: FlutterFlowTheme.of(context).primaryColor ,
                          //     radius: 16,
                          //     child: Icon(
                          //       Icons.edit,
                          //       color: Colors.white,
                          //       size: 20,
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                    SizedBox(height: 40.0),
                    TextField(
                      controller: _nameController,
                      cursorColor: FlutterFlowTheme.of(context).primaryColor ,
                      decoration: InputDecoration(
                        labelText: 'Name',
                        floatingLabelStyle: TextStyle(color:  FlutterFlowTheme.of(context).primaryColor),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: FlutterFlowTheme.of(context).primaryColor),
                        ),
                        enabledBorder: OutlineInputBorder(
                          //borderSide: BorderSide(color: FlutterFlowTheme.of(context).primaryColor),
                        ),
                      ),
                    ),
                    SizedBox(height: 30.0),
                    // TextField(
                    //   controller: _emailController,
                    //   cursorColor: FlutterFlowTheme.of(context).primaryColor ,
                    //   decoration: InputDecoration(
                    //     labelText: 'Email',
                    //       floatingLabelStyle: TextStyle(color:  FlutterFlowTheme.of(context).primaryColor),
                    //       focusedBorder: OutlineInputBorder(
                    //         borderSide: BorderSide(color: FlutterFlowTheme.of(context).primaryColor),
                    //       ),
                    //       enabledBorder: OutlineInputBorder(
                    //         //borderSide: BorderSide(color: FlutterFlowTheme.of(context).primaryColor),
                    //       ),
                    //     focusColor: Colors.red
                    //   ),
                    // ),
                    SizedBox(height: 24.0),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: FlutterFlowTheme.of(context).primaryColor ,),
                      onPressed: () {
                        if(provider.loading==false){
                          String name = _nameController.text;
                          String email = _emailController.text;
                          // Save the updated profile information
                          editUser(name,email,_profilePicture,provider.userRowguid);
                          provider.getUserInfo(1,context);
                          setState(() {

                          });
                        }
                      },
                      child: provider.loading
                          ? CircularProgressIndicator() // Show the loading indicator while the API call is in progress
                          : Text('Save'),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 60, // Adjust the position of the back icon as per your needs
            left: 20, // Adjust the position of the back icon as per your needs
            child: IconButton(
              icon: Icon(Icons.arrow_back,size: 30,),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}