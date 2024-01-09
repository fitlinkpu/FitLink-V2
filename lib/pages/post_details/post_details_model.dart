import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/delete_post/delete_post_widget.dart';
import '/components/post_comment_widget.dart';
import '../../flutter_flow/icon_button.dart';
import '../../flutter_flow/fitlink_theme.dart';
import '../../flutter_flow/toggle_icon.dart';
import '../../flutter_flow/f_util.dart';
import '../../flutter_flow/f_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'post_details_widget.dart' show PostDetailsWidget;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class PostDetailsModel extends FitLinkModel<PostDetailsWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for postComment component.
  late PostCommentModel postCommentModel;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {
    postCommentModel = createModel(context, () => PostCommentModel());
  }

  void dispose() {
    postCommentModel.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
