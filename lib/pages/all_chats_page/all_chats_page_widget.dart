import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/nav_bar/nav_bar_widget.dart';
import '/flutter_flow/chat/index.dart';
import '../../flutter_flow/icon_button.dart';
import '../../flutter_flow/fitlink_theme.dart';
import '../../flutter_flow/f_util.dart';
import '../../flutter_flow/f_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'all_chats_page_model.dart';
export 'all_chats_page_model.dart';

class AllChatsPageWidget extends StatefulWidget {
  const AllChatsPageWidget({Key? key}) : super(key: key);

  @override
  _AllChatsPageWidgetState createState() => _AllChatsPageWidgetState();
}

class _AllChatsPageWidgetState extends State<AllChatsPageWidget> {
  late AllChatsPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AllChatsPageModel());
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

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FitLinkTheme.of(context).primaryBackground,
      appBar: AppBar(
        backgroundColor: FitLinkTheme.of(context).secondaryBackground,
        automaticallyImplyLeading: false,
        title: Text(
          'Messages',
          style: FitLinkTheme.of(context).headlineMedium,
        ),
        actions: [],
        centerTitle: false,
        elevation: 0.0,
      ),
      body: SafeArea(
        top: true,
        child: Stack(
          alignment: AlignmentDirectional(0.0, 1.0),
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 2.0, 0.0, 70.0),
              child: StreamBuilder<List<ChatsRecord>>(
                stream: queryChatsRecord(
                  queryBuilder: (chatsRecord) => chatsRecord
                      .where(
                        'users',
                        arrayContains: currentUserReference,
                      )
                      .orderBy('last_message_time', descending: true),
                ),
                builder: (context, snapshot) {
                  // Customize what your widget looks like when it's loading.
                  if (!snapshot.hasData) {
                    return Center(
                      child: SizedBox(
                        width: 50.0,
                        height: 50.0,
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            FitLinkTheme.of(context).secondary,
                          ),
                        ),
                      ),
                    );
                  }
                  List<ChatsRecord> listViewChatsRecordList = snapshot.data!;
                  if (listViewChatsRecordList.isEmpty) {
                    return Center(
                      child: Image.asset(
                        'assets/images/2vqf7_',
                        width: MediaQuery.sizeOf(context).width * 0.76,
                      ),
                    );
                  }
                  return ListView.builder(
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.vertical,
                    itemCount: listViewChatsRecordList.length,
                    itemBuilder: (context, listViewIndex) {
                      final listViewChatsRecord =
                          listViewChatsRecordList[listViewIndex];
                      return StreamBuilder<FFChatInfo>(
                        stream: FFChatManager.instance
                            .getChatInfo(chatRecord: listViewChatsRecord),
                        builder: (context, snapshot) {
                          final chatInfo =
                              snapshot.data ?? FFChatInfo(listViewChatsRecord);
                          return FFChatPreview(
                            onTap: () => context.pushNamed(
                              'chatPage',
                              queryParameters: {
                                'chatUser': serializeParam(
                                  chatInfo.otherUsers.length == 1
                                      ? chatInfo.otherUsersList.first
                                      : null,
                                  ParamType.Document,
                                ),
                                'chatRef': serializeParam(
                                  chatInfo.chatRecord.reference,
                                  ParamType.DocumentReference,
                                ),
                              }.withoutNulls,
                              extra: <String, dynamic>{
                                'chatUser': chatInfo.otherUsers.length == 1
                                    ? chatInfo.otherUsersList.first
                                    : null,
                              },
                            ),
                            lastChatText: chatInfo.chatPreviewMessage(),
                            lastChatTime: listViewChatsRecord.lastMessageTime,
                            seen: listViewChatsRecord.lastMessageSeenBy!
                                .contains(currentUserReference),
                            title: chatInfo.chatPreviewTitle(),
                            userProfilePic: chatInfo.chatPreviewPic(),
                            color: FitLinkTheme.of(context).secondaryBackground,
                            unreadColor: FitLinkTheme.of(context).primary,
                            titleTextStyle: GoogleFonts.getFont(
                              'Outfit',
                              color: FitLinkTheme.of(context).primaryText,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                              fontStyle: FontStyle.normal,
                            ),
                            dateTextStyle: GoogleFonts.getFont(
                              'Urbanist',
                              color: FitLinkTheme.of(context).grayIcon,
                              fontWeight: FontWeight.normal,
                              fontSize: 14.0,
                            ),
                            previewTextStyle: GoogleFonts.getFont(
                              'Urbanist',
                              color: FitLinkTheme.of(context).grayIcon,
                              fontWeight: FontWeight.normal,
                              fontSize: 14.0,
                            ),
                            contentPadding: EdgeInsetsDirectional.fromSTEB(
                                12.0, 3.0, 3.0, 3.0),
                            borderRadius: BorderRadius.circular(0.0),
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
            wrapWithModel(
              model: _model.navBarModel,
              updateCallback: () => setState(() {}),
              child: NavBarWidget(
                selectedPageIndex: 4,
                hidden: false,
              ),
            ),
            Align(
              alignment: AlignmentDirectional(0.89, 0.74),
              child: FlutterFlowIconButton(
                borderColor: FitLinkTheme.of(context).primary,
                borderRadius: 100.0,
                borderWidth: 1.0,
                buttonSize: 55.0,
                fillColor: FitLinkTheme.of(context).primary,
                icon: FaIcon(
                  FontAwesomeIcons.pen,
                  color: Colors.black,
                  size: 20.0,
                ),
                onPressed: () async {
                  context.pushNamed('createGroupChat');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
