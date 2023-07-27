import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Services/GetReviews.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import 'package:c_s_p_app/Models/comments_model.dart';

import '../provider/LoadProvider.dart';

class ReviewWidget extends StatefulWidget {
  ReviewWidget({Key? key, required this.rowg, required this.type})
      : super(key: key);

  final String rowg;
  final String type;

  @override
  _ReviewWidgetState createState() => _ReviewWidgetState();
}

class _ReviewWidgetState extends State<ReviewWidget> {
  late List<Comment>? comments = [];
  late String userPhoto = '';
  String currentUsername = "";
  int currentRating = 0;
  String userrow = '';

  List<String> commentTexts = [];
  final TextEditingController commentController = TextEditingController();
  final FocusNode commentFocus = FocusNode();
  int x=0;
  @override
  void initState() {
    super.initState();
    fetchReviews();
    final provider = Provider.of<LoadProvider>(context, listen: false);
    x=provider.state;
  }

  void fetchReviews() async {
    final provider = Provider.of<LoadProvider>(context, listen: false);
    userPhoto = provider.userInfo.payload.profile;
    currentUsername = provider.userInfo.payload.name;
    userrow = provider.userRowguid;

    List<Comment>? fetchedComments = await getReviews(widget.type, widget.rowg);
    setState(() {
      comments = fetchedComments ?? [];
    });
  }

  void addComment() {
    setState(() {
      commentTexts.add(commentController.text);
      commentController.clear();
      commentFocus.requestFocus();

      Comment newComment = Comment(
        userName: currentUsername,
        rating: currentRating,
        comment: commentTexts.last,
        rowGuid: '',
        userProfile: '$userPhoto',
        userRowguid: '$userrow',
      );
      comments!.add(newComment);
      Future.delayed(Duration(seconds: 2));
    });
  }

  void removeComment(int index) {
    setState(() {
      comments!.removeAt(index);
      Future.delayed(Duration(seconds: 2));
    });
  }

  @override
  Widget build(BuildContext context) {

    return Builder(
      builder: (context) {
        return Padding(
          padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
          child: Column(
            children: [
              x==0?Text('Please sign in to add reviews',style: FlutterFlowTheme.of(context).title2,):buildAddCommentSection(userrow),
              SizedBox(height: 16),
              Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: comments!.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          buildCommentContainer(comments![index], index, 0),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildCommentContainer(Comment comment, int index, int type) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
          boxShadow: [
            BoxShadow(
              blurRadius: 3,
              color: Color(0x2E000000),
              offset: Offset(0, 2),
            ),
          ],
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: FlutterFlowTheme.of(context).primaryBackground,
            width: 2,
          ),
        ),
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(4, 4, 4, 4),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(12, 12, 12, 8),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 8, 0),
                          child: CircleAvatar(
                            radius: 20,
                            backgroundImage: NetworkImage(
                              comment.userProfile,
                            ),
                          ),
                        ),
                        Text(
                          comment.userName,
                          style: FlutterFlowTheme.of(context).bodyText1,
                        ),
                      ],
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Overall',
                          style: FlutterFlowTheme.of(context).bodyText2,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(0, 0, 4, 0),
                              child: Text(
                                comment.rating.toString(),
                                style: FlutterFlowTheme.of(context).title2,
                              ),
                            ),
                            Icon(
                              Icons.star_rounded,
                              color: FlutterFlowTheme.of(context).primaryColor,
                              size: 20,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(12, 0, 12, 8),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Text(
                        comment.comment,
                        style: FlutterFlowTheme.of(context).bodyText1,
                      ),
                    ),
                    comment.userRowguid == userrow
                        ? Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              deleteReview(comment.rowGuid);
                              removeComment(index);
                            });
                          },
                          icon: Icon(Icons.delete),
                          color: FlutterFlowTheme.of(context).primaryColor,
                        ),
                      ],
                    )
                        : Text(''),
                  ],
                ),
              ),
              comment.userRowguid == userrow
                  ? SizedBox(height: Icon(Icons.delete).size)
                  : Text(''),
            ],
          ),
        ),
      ),
    );
  }
  String rev = '';
  Widget buildAddCommentSection(String userRow) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(12, 0, 12, 8),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              RatingWidget(
                initialRating: currentRating,
                onRatingChanged: (rating) {
                  currentRating = rating;
                },
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(12, 0, 12, 8),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: TextField(
                  controller: commentController,
                  focusNode: commentFocus,
                  onChanged: (value) {
                    rev = value;
                  },
                  decoration: InputDecoration(
                    labelText: 'Add a review',
                    floatingLabelStyle:
                    TextStyle(color: FlutterFlowTheme.of(context).primaryColor),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).primaryColor)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).primaryColor)),
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  if (rev != '') {
                    setState(() {
                      addComment();
                      postReview(
                          userRow, currentRating, rev, widget.rowg, widget.type);
                    });
                  }
                },
                icon: Icon(Icons.send),
                color: FlutterFlowTheme.of(context).primaryColor,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class RatingWidget extends StatefulWidget {
  final int initialRating;
  final ValueChanged<int> onRatingChanged;

  RatingWidget({
    required this.initialRating,
    required this.onRatingChanged,
  });

  @override
  _RatingWidgetState createState() => _RatingWidgetState();
}

class _RatingWidgetState extends State<RatingWidget> {
  late int _rating;

  @override
  void initState() {
    super.initState();
    _rating = widget.initialRating;
  }

  void _updateRating(int rating) {
    setState(() {
      _rating = rating;
      widget.onRatingChanged(rating);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        5,
            (index) => GestureDetector(
          onTap: () => _updateRating(index + 1),
          child: Icon(
            index < _rating ? Icons.star_rounded : Icons.star_outline_rounded,
            size: 24,
            color: FlutterFlowTheme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }
}