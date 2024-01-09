import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/nav_bar/nav_bar_widget.dart';
import '../../flutter_flow/icon_button.dart';
import '../../flutter_flow/fitlink_theme.dart';
import '../../flutter_flow/f_timer.dart';
import '../../flutter_flow/f_util.dart';
import '../../flutter_flow/f_widgets.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'work_out_model.dart';
export 'work_out_model.dart';
import 'package:pedometer/pedometer.dart';

class WorkOutWidget extends StatefulWidget {
  const WorkOutWidget({Key? key}) : super(key: key);

  @override
  _WorkOutWidgetState createState() => _WorkOutWidgetState();
}

class _WorkOutWidgetState extends State<WorkOutWidget>
    with TickerProviderStateMixin {
  late WorkOutModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    initPlatformState();

    _model = createModel(context, () => WorkOutModel());

    _model.tabBarController = TabController(
      vsync: this,
      length: 2,
      initialIndex: 0,
    )..addListener(() => setState(() {}));
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  late Stream<StepCount> _stepCountStream;
  late Stream<PedestrianStatus> _pedestrianStatusStream;
  String _status = '?', _steps = '0';

  void onStepCount(StepCount event) {
    print(event);
    setState(() {
      _steps = event.steps.toString();
    });
  }

  void onPedestrianStatusChanged(PedestrianStatus event) {
    print(event);
    setState(() {
      _status = event.status;
    });
  }

  void onPedestrianStatusError(error) {
    print('onPedestrianStatusError: $error');
    setState(() {
      _status = 'Pedestrian Status not available';
    });
    print(_status);
  }

  void onStepCountError(error) {
    print('onStepCountError: $error');
    setState(() {
      _steps = 'Step Count not available';
    });
  }

  void initPlatformState() {
    _pedestrianStatusStream = Pedometer.pedestrianStatusStream;
    _pedestrianStatusStream
        .listen(onPedestrianStatusChanged)
        .onError(onPedestrianStatusError);

    _stepCountStream = Pedometer.stepCountStream;
    _stepCountStream.listen(onStepCount).onError(onStepCountError);

    if (!mounted) return;
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isiOS) {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarBrightness: Theme.of(context).brightness,
          systemStatusBarContrastEnforced: true,
        ),
      );
    }

    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FitLinkTheme.of(context).primaryBackground,
        body: SafeArea(
          top: true,
          child: Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 30.0, 0.0, 0.0),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment(0.0, 0),
                            child: TabBar(
                              labelColor: FitLinkTheme.of(context).primary,
                              unselectedLabelColor:
                                  FitLinkTheme.of(context).secondaryText,
                              labelStyle: FitLinkTheme.of(context).titleMedium,
                              unselectedLabelStyle: TextStyle(),
                              indicatorColor: FitLinkTheme.of(context).primary,
                              indicatorWeight: 3.0,
                              padding: EdgeInsets.all(4.0),
                              tabs: [
                                Tab(
                                  text: 'Exercises',
                                ),
                                Tab(
                                  text: 'Track',
                                ),
                              ],
                              controller: _model.tabBarController,
                            ),
                          ),
                          Expanded(
                            child: TabBarView(
                              controller: _model.tabBarController,
                              children: [
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Container(
                                      width: 400.0,
                                      height: 694.0,
                                      decoration: BoxDecoration(
                                        color: FitLinkTheme.of(context)
                                            .primaryBackground,
                                      ),
                                      child: StreamBuilder<List<WorkoutRecord>>(
                                        stream: queryWorkoutRecord(
                                          queryBuilder: (dogsRecord) =>
                                              dogsRecord.where(
                                            'userAssociation',
                                            isEqualTo: currentUserReference,
                                          ),
                                        ),
                                        builder: (context, snapshot) {
                                          // Customize what your widget looks like when it's loading.
                                          if (!snapshot.hasData) {
                                            return Center(
                                              child: SizedBox(
                                                width: 50.0,
                                                height: 50.0,
                                                child:
                                                    CircularProgressIndicator(
                                                  valueColor:
                                                      AlwaysStoppedAnimation<
                                                          Color>(
                                                    FitLinkTheme.of(context)
                                                        .secondary,
                                                  ),
                                                ),
                                              ),
                                            );
                                          }
                                          List<WorkoutRecord>
                                              listViewDogsRecordList =
                                              snapshot.data!;
                                          if (listViewDogsRecordList.isEmpty) {
                                            return Center(
                                              child: Image.asset(
                                                'assets/images/LogoTxt.png',
                                                width:
                                                    MediaQuery.sizeOf(context)
                                                            .width *
                                                        0.8,
                                              ),
                                            );
                                          }
                                          return ListView.builder(
                                            padding: EdgeInsets.zero,
                                            scrollDirection: Axis.vertical,
                                            itemCount:
                                                listViewDogsRecordList.length,
                                            itemBuilder:
                                                (context, listViewIndex) {
                                              final listViewDogsRecord =
                                                  listViewDogsRecordList[
                                                      listViewIndex];
                                              return Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        16.0, 12.0, 16.0, 0.0),
                                                child: Container(
                                                  width: double.infinity,
                                                  height: 100.0,
                                                  decoration: BoxDecoration(
                                                    color: FitLinkTheme.of(
                                                            context)
                                                        .secondaryBackground,
                                                    boxShadow: [
                                                      BoxShadow(
                                                        blurRadius: 3.0,
                                                        color:
                                                            Color(0x32000000),
                                                        offset:
                                                            Offset(0.0, 1.0),
                                                      )
                                                    ],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                  ),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Expanded(
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      12.0,
                                                                      0.0,
                                                                      0.0,
                                                                      0.0),
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                listViewDogsRecord
                                                                    .dogName,
                                                                style: FitLinkTheme.of(
                                                                        context)
                                                                    .headlineSmall,
                                                              ),
                                                              Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                children: [
                                                                  Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            4.0,
                                                                            0.0,
                                                                            0.0),
                                                                    child: Text(
                                                                      'Reps : ',
                                                                      style: FitLinkTheme.of(
                                                                              context)
                                                                          .bodyMedium,
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            4.0,
                                                                            0.0,
                                                                            0.0),
                                                                    child: Text(
                                                                      listViewDogsRecord
                                                                          .dogType,
                                                                      style: FitLinkTheme.of(
                                                                              context)
                                                                          .bodyMedium,
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            4.0,
                                                                            0.0,
                                                                            0.0),
                                                                    child: Text(
                                                                      '|',
                                                                      style: FitLinkTheme.of(
                                                                              context)
                                                                          .bodyMedium,
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            4.0,
                                                                            0.0,
                                                                            0.0),
                                                                    child: Text(
                                                                      'Sets : ',
                                                                      style: FitLinkTheme.of(
                                                                              context)
                                                                          .bodyMedium,
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            4.0,
                                                                            4.0,
                                                                            0.0,
                                                                            0.0),
                                                                    child: Text(
                                                                      listViewDogsRecord
                                                                          .dogAge,
                                                                      style: FitLinkTheme.of(
                                                                              context)
                                                                          .bodyMedium,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.0,
                                                                    0.0,
                                                                    12.0,
                                                                    0.0),
                                                        child:
                                                            FlutterFlowIconButton(
                                                          borderColor: FitLinkTheme
                                                                  .of(context)
                                                              .primaryBackground,
                                                          borderRadius: 30.0,
                                                          borderWidth: 2.0,
                                                          buttonSize: 44.0,
                                                          icon: Icon(
                                                            Icons.edit_outlined,
                                                            color:
                                                                FitLinkTheme.of(
                                                                        context)
                                                                    .grayIcon,
                                                            size: 24.0,
                                                          ),
                                                          onPressed: () async {
                                                            context.pushNamed(
                                                              'editDogProfile',
                                                              queryParameters: {
                                                                'dogProfile':
                                                                    serializeParam(
                                                                  listViewDogsRecord,
                                                                  ParamType
                                                                      .Document,
                                                                ),
                                                              }.withoutNulls,
                                                              extra: <String,
                                                                  dynamic>{
                                                                'dogProfile':
                                                                    listViewDogsRecord,
                                                              },
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                Align(
                                  alignment: AlignmentDirectional(0.0, 0.0),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 30.0, 0.0, 0.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  32.0, 8.0, 32.0, 0.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Stopwatch : ',
                                                style: FitLinkTheme.of(context)
                                                    .headlineSmall,
                                              ),
                                              FlutterFlowIconButton(
                                                borderColor: Colors.transparent,
                                                borderRadius: 0.0,
                                                borderWidth: 0.0,
                                                buttonSize: 44.0,
                                                fillColor: Colors.transparent,
                                                icon: Icon(
                                                  Icons.restart_alt_sharp,
                                                  color:
                                                      FitLinkTheme.of(context)
                                                          .primaryText,
                                                  size: 20.0,
                                                ),
                                                onPressed: () async {
                                                  _model.timerController
                                                      .onResetTimer();
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            FlutterFlowTimer(
                                              initialTime:
                                                  _model.timerMilliseconds,
                                              getDisplayTime: (value) =>
                                                  StopWatchTimer.getDisplayTime(
                                                      value),
                                              controller:
                                                  _model.timerController,
                                              updateStateInterval:
                                                  Duration(milliseconds: 1000),
                                              onChanged: (value, displayTime,
                                                  shouldUpdate) {
                                                _model.timerMilliseconds =
                                                    value;
                                                _model.timerValue = displayTime;
                                                if (shouldUpdate)
                                                  setState(() {});
                                              },
                                              textAlign: TextAlign.start,
                                              style: FitLinkTheme.of(context)
                                                  .displayMedium
                                                  .override(
                                                    fontFamily: 'Outfit',
                                                    fontSize: 50.0,
                                                    fontWeight: FontWeight.w100,
                                                  ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  20.0, 0.0, 20.0, 0.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Expanded(
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          10.0, 0.0, 10.0, 0.0),
                                                  child: FFButtonWidget(
                                                    onPressed: () async {
                                                      _model.timerController
                                                          .onStopTimer();
                                                    },
                                                    text: '',
                                                    icon: Icon(
                                                      Icons.pause,
                                                      size: 15.0,
                                                    ),
                                                    options: FFButtonOptions(
                                                      height: 40.0,
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  0.0,
                                                                  0.0,
                                                                  0.0),
                                                      iconPadding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  0.0,
                                                                  0.0,
                                                                  0.0),
                                                      color: FitLinkTheme.of(
                                                              context)
                                                          .secondary,
                                                      textStyle: FitLinkTheme
                                                              .of(context)
                                                          .titleSmall
                                                          .override(
                                                            fontFamily:
                                                                'Urbanist',
                                                            color: Colors.white,
                                                          ),
                                                      elevation: 0.0,
                                                      borderSide: BorderSide(
                                                        color:
                                                            Colors.transparent,
                                                        width: 0.0,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20.0),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          10.0, 0.0, 10.0, 0.0),
                                                  child: FFButtonWidget(
                                                    onPressed: () async {
                                                      _model.timerController
                                                          .onStartTimer();
                                                    },
                                                    text: '',
                                                    icon: Icon(
                                                      Icons.play_arrow,
                                                      size: 15.0,
                                                    ),
                                                    options: FFButtonOptions(
                                                      height: 40.0,
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  0.0,
                                                                  0.0,
                                                                  0.0),
                                                      iconPadding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  0.0,
                                                                  0.0,
                                                                  0.0),
                                                      color: FitLinkTheme.of(
                                                              context)
                                                          .secondary,
                                                      textStyle:
                                                          FitLinkTheme.of(
                                                                  context)
                                                              .displayMedium,
                                                      elevation: 3.0,
                                                      borderSide: BorderSide(
                                                        color:
                                                            Colors.transparent,
                                                        width: 1.0,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20.0),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 50,
                                        ),
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: 32,
                                            ),
                                            Text(
                                              'Step Counter :',
                                              style: FitLinkTheme.of(context)
                                                  .headlineSmall,
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(32.0),
                                          child: Container(
                                            height: 100,
                                            decoration: BoxDecoration(
                                              color: FitLinkTheme.of(context)
                                                  .secondaryBackground,
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: Center(
                                              child: Text(
                                                _steps,
                                                style: FitLinkTheme.of(context)
                                                    .bodyText1
                                                    .override(
                                                      fontFamily: 'Urbanist',
                                                      color: FitLinkTheme.of(
                                                              context)
                                                          .primaryText,
                                                      fontSize: 44.0,
                                                      fontWeight:
                                                          FontWeight.w300,
                                                    ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Align(
                alignment: AlignmentDirectional(0.0, 1.0),
                child: wrapWithModel(
                  model: _model.navBarModel,
                  updateCallback: () => setState(() {}),
                  child: NavBarWidget(
                    selectedPageIndex: 2,
                    hidden: false,
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0.89, 0.76),
                child: FlutterFlowIconButton(
                  borderColor: Color(0x0039D2C0),
                  borderRadius: 100.0,
                  borderWidth: 1.0,
                  buttonSize: 55.0,
                  fillColor: FitLinkTheme.of(context).primary,
                  icon: Icon(
                    Icons.directions_run_rounded,
                    color: Colors.black,
                    size: 28.0,
                  ),
                  onPressed: () async {
                    context.pushNamed(
                      'createDogProfile_New',
                      extra: <String, dynamic>{
                        kTransitionInfoKey: TransitionInfo(
                          hasTransition: true,
                          transitionType: PageTransitionType.bottomToTop,
                          duration: Duration(milliseconds: 250),
                        ),
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
