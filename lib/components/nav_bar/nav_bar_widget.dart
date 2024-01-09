import '../../flutter_flow/fitlink_animations.dart';
import '../../flutter_flow/icon_button.dart';
import '../../flutter_flow/fitlink_theme.dart';
import '../../flutter_flow/f_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';
import 'nav_bar_model.dart';
export 'nav_bar_model.dart';

class NavBarWidget extends StatefulWidget {
  const NavBarWidget({
    Key? key,
    int? selectedPageIndex,
    bool? hidden,
  })  : this.selectedPageIndex = selectedPageIndex ?? 1,
        this.hidden = hidden ?? false,
        super(key: key);

  final int selectedPageIndex;
  final bool hidden;

  @override
  _NavBarWidgetState createState() => _NavBarWidgetState();
}

class _NavBarWidgetState extends State<NavBarWidget>
    with TickerProviderStateMixin {
  late NavBarModel _model;

  final animationsMap = {
    'dividerOnPageLoadAnimation1': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        ScaleEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 150.ms,
          begin: Offset(0.6, 1.0),
          end: Offset(1.0, 1.0),
        ),
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 150.ms,
          begin: 0.0,
          end: 1.0,
        ),
      ],
    ),
    'dividerOnPageLoadAnimation2': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        ScaleEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 150.ms,
          begin: Offset(0.6, 1.0),
          end: Offset(1.0, 1.0),
        ),
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 150.ms,
          begin: 0.0,
          end: 1.0,
        ),
      ],
    ),
    'dividerOnPageLoadAnimation3': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        ScaleEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 150.ms,
          begin: Offset(0.6, 1.0),
          end: Offset(1.0, 1.0),
        ),
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 150.ms,
          begin: 0.0,
          end: 1.0,
        ),
      ],
    ),
    'dividerOnPageLoadAnimation4': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        ScaleEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 150.ms,
          begin: Offset(0.6, 1.0),
          end: Offset(1.0, 1.0),
        ),
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 150.ms,
          begin: 0.0,
          end: 1.0,
        ),
      ],
    ),
    'dividerOnPageLoadAnimation5': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        ScaleEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 150.ms,
          begin: Offset(0.6, 1.0),
          end: Offset(1.0, 1.0),
        ),
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 150.ms,
          begin: 0.0,
          end: 1.0,
        ),
      ],
    ),
  };

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => NavBarModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 420.0,
      height: 70.0,
      decoration: BoxDecoration(
        color: FitLinkTheme.of(context).secondaryBackground,
        boxShadow: [
          BoxShadow(
            blurRadius: 4.0,
            color: Color(0x33000000),
            offset: Offset(0.0, 2.0),
          )
        ],
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(0.0),
          bottomRight: Radius.circular(0.0),
          topLeft: Radius.circular(0.0),
          topRight: Radius.circular(0.0),
        ),
        shape: BoxShape.rectangle,
        border: Border.all(
          color: Color(0x0039D2C0),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Opacity(
                opacity: widget.selectedPageIndex == 1 ? 1.0 : 0.5,
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
                  child: FlutterFlowIconButton(
                    borderRadius: 20.0,
                    borderWidth: 1.0,
                    buttonSize: 40.0,
                    fillColor: Color(0x00EEEEEE),
                    icon: Icon(
                      Icons.home_rounded,
                      color: FitLinkTheme.of(context).primary,
                      size: 24.0,
                    ),
                    onPressed: () async {
                      context.goNamed(
                        'homePage',
                        extra: <String, dynamic>{
                          kTransitionInfoKey: TransitionInfo(
                            hasTransition: true,
                            transitionType: PageTransitionType.fade,
                            duration: Duration(milliseconds: 0),
                          ),
                        },
                      );

                      _model.soundPlayer1 ??= AudioPlayer();
                      if (_model.soundPlayer1!.playing) {
                        await _model.soundPlayer1!.stop();
                      }
                      _model.soundPlayer1!.setVolume(0.6);
                      await _model.soundPlayer1!
                          .setAsset('assets/audios/water.opus')
                          .then((_) => _model.soundPlayer1!.play());
                    },
                  ),
                ),
              ),
              if (widget.selectedPageIndex == 1)
                SizedBox(
                  width: 30.0,
                  child: Divider(
                    height: 2.0,
                    thickness: 2.0,
                    color: FitLinkTheme.of(context).primary,
                  ),
                ).animateOnPageLoad(
                    animationsMap['dividerOnPageLoadAnimation1']!),
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Opacity(
                opacity: widget.selectedPageIndex == 2 ? 1.0 : 0.5,
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
                  child: FlutterFlowIconButton(
                    borderColor: Colors.transparent,
                    borderRadius: 20.0,
                    borderWidth: 1.0,
                    buttonSize: 40.0,
                    fillColor: Color(0x00EEEEEE),
                    icon: Icon(
                      Icons.directions_run,
                      color: FitLinkTheme.of(context).primary,
                      size: 24.0,
                    ),
                    onPressed: () async {
                      context.goNamed(
                        'workOut',
                        extra: <String, dynamic>{
                          kTransitionInfoKey: TransitionInfo(
                            hasTransition: true,
                            transitionType: PageTransitionType.fade,
                            duration: Duration(milliseconds: 0),
                          ),
                        },
                      );

                      _model.soundPlayer2 ??= AudioPlayer();
                      if (_model.soundPlayer2!.playing) {
                        await _model.soundPlayer2!.stop();
                      }
                      _model.soundPlayer2!.setVolume(0.6);
                      _model.soundPlayer2!
                          .setAsset('assets/audios/water.opus')
                          .then((_) => _model.soundPlayer2!.play());
                    },
                  ),
                ),
              ),
              if (widget.selectedPageIndex == 2)
                SizedBox(
                  width: 30.0,
                  child: Divider(
                    height: 2.0,
                    thickness: 2.0,
                    color: FitLinkTheme.of(context).primary,
                  ),
                ).animateOnPageLoad(
                    animationsMap['dividerOnPageLoadAnimation2']!),
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Opacity(
                opacity: widget.selectedPageIndex == 3 ? 1.0 : 0.5,
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
                  child: FlutterFlowIconButton(
                    borderColor: Colors.transparent,
                    borderRadius: 20.0,
                    borderWidth: 1.0,
                    buttonSize: 40.0,
                    fillColor: Color(0x00EEEEEE),
                    icon: Icon(
                      Icons.library_add,
                      color: FitLinkTheme.of(context).primary,
                      size: 24.0,
                    ),
                    onPressed: () async {
                      context.goNamed(
                        'createPage',
                        extra: <String, dynamic>{
                          kTransitionInfoKey: TransitionInfo(
                            hasTransition: true,
                            transitionType: PageTransitionType.fade,
                            duration: Duration(milliseconds: 0),
                          ),
                        },
                      );

                      _model.soundPlayer3 ??= AudioPlayer();
                      if (_model.soundPlayer3!.playing) {
                        await _model.soundPlayer3!.stop();
                      }
                      _model.soundPlayer3!.setVolume(1.0);
                      _model.soundPlayer3!
                          .setAsset('assets/audios/water.opus')
                          .then((_) => _model.soundPlayer3!.play());
                    },
                  ),
                ),
              ),
              if (widget.selectedPageIndex == 3)
                SizedBox(
                  width: 30.0,
                  child: Divider(
                    height: 2.0,
                    thickness: 2.0,
                    color: FitLinkTheme.of(context).primary,
                  ),
                ).animateOnPageLoad(
                    animationsMap['dividerOnPageLoadAnimation3']!),
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Opacity(
                opacity: widget.selectedPageIndex == 4 ? 1.0 : 0.5,
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
                  child: FlutterFlowIconButton(
                    borderColor: Colors.transparent,
                    borderRadius: 20.0,
                    borderWidth: 1.0,
                    buttonSize: 40.0,
                    fillColor: Color(0x00EEEEEE),
                    icon: Icon(
                      Icons.chat_bubble_rounded,
                      color: FitLinkTheme.of(context).primary,
                      size: 24.0,
                    ),
                    onPressed: () async {
                      context.goNamed(
                        'allChatsPage',
                        extra: <String, dynamic>{
                          kTransitionInfoKey: TransitionInfo(
                            hasTransition: true,
                            transitionType: PageTransitionType.fade,
                            duration: Duration(milliseconds: 0),
                          ),
                        },
                      );

                      _model.soundPlayer4 ??= AudioPlayer();
                      if (_model.soundPlayer4!.playing) {
                        await _model.soundPlayer4!.stop();
                      }
                      _model.soundPlayer4!.setVolume(1.0);
                      _model.soundPlayer4!
                          .setAsset('assets/audios/water.opus')
                          .then((_) => _model.soundPlayer4!.play());
                    },
                  ),
                ),
              ),
              if (widget.selectedPageIndex == 4)
                SizedBox(
                  width: 30.0,
                  child: Divider(
                    height: 2.0,
                    thickness: 2.0,
                    color: FitLinkTheme.of(context).primary,
                  ),
                ).animateOnPageLoad(
                    animationsMap['dividerOnPageLoadAnimation4']!),
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Opacity(
                opacity: widget.selectedPageIndex == 5 ? 1.0 : 0.5,
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
                  child: FlutterFlowIconButton(
                    borderColor: Colors.transparent,
                    borderRadius: 20.0,
                    borderWidth: 1.0,
                    buttonSize: 40.0,
                    fillColor: Color(0x00EEEEEE),
                    icon: Icon(
                      Icons.person,
                      color: FitLinkTheme.of(context).primary,
                      size: 24.0,
                    ),
                    onPressed: () async {
                      context.goNamed(
                        'profilePage',
                        extra: <String, dynamic>{
                          kTransitionInfoKey: TransitionInfo(
                            hasTransition: true,
                            transitionType: PageTransitionType.fade,
                            duration: Duration(milliseconds: 0),
                          ),
                        },
                      );

                      _model.soundPlayer5 ??= AudioPlayer();
                      if (_model.soundPlayer5!.playing) {
                        await _model.soundPlayer5!.stop();
                      }
                      _model.soundPlayer5!.setVolume(1.0);
                      _model.soundPlayer5!
                          .setAsset('assets/audios/water.opus')
                          .then((_) => _model.soundPlayer5!.play());
                    },
                  ),
                ),
              ),
              if (widget.selectedPageIndex == 5)
                SizedBox(
                  width: 30.0,
                  child: Divider(
                    height: 2.0,
                    thickness: 2.0,
                    color: FitLinkTheme.of(context).primary,
                  ),
                ).animateOnPageLoad(
                    animationsMap['dividerOnPageLoadAnimation5']!),
            ],
          ),
        ],
      ),
    );
  }
}
