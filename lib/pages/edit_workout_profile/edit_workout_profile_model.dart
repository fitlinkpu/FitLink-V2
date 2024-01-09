import '/backend/backend.dart';
import '../../flutter_flow/icon_button.dart';
import '../../flutter_flow/fitlink_theme.dart';
import '../../flutter_flow/f_util.dart';
import '../../flutter_flow/f_widgets.dart';
import 'edit_workout_profile_widget.dart' show EditWorkoutProfileWidget;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class EditWorkoutProfileModel extends FitLinkModel<EditWorkoutProfileWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for dogName widget.
  FocusNode? dogNameFocusNode;
  TextEditingController? dogNameController;
  String? Function(BuildContext, String?)? dogNameControllerValidator;
  // State field(s) for dogBreed widget.
  FocusNode? dogBreedFocusNode;
  TextEditingController? dogBreedController;
  String? Function(BuildContext, String?)? dogBreedControllerValidator;
  // State field(s) for dogAge widget.
  FocusNode? dogAgeFocusNode;
  TextEditingController? dogAgeController;
  String? Function(BuildContext, String?)? dogAgeControllerValidator;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

  void dispose() {
    dogNameFocusNode?.dispose();
    dogNameController?.dispose();

    dogBreedFocusNode?.dispose();
    dogBreedController?.dispose();

    dogAgeFocusNode?.dispose();
    dogAgeController?.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
