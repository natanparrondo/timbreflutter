import 'package:flutter/material.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'info_model.dart';
export 'info_model.dart';

class InfoWidget extends StatefulWidget {
  const InfoWidget({super.key});

  @override
  State<InfoWidget> createState() => _InfoWidgetState();
}

class _InfoWidgetState extends State<InfoWidget> {
  late InfoModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => InfoModel());
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primary,
          automaticallyImplyLeading: false,
          leading: FlutterFlowIconButton(
            borderColor: Colors.transparent,
            borderRadius: 30.0,
            borderWidth: 1.0,
            buttonSize: 60.0,
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white,
              size: 30.0,
            ),
            onPressed: () async {
              Navigator.of(context).pop();
            },
          ),
          title: Align(
            alignment: const AlignmentDirectional(0.0, 0.0),
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 56.0, 0.0),
              child: Text(
                'Información',
                style: FlutterFlowTheme.of(context).headlineMedium.override(
                      fontFamily: 'Outfit',
                      color: Colors.white,
                      fontSize: 22.0,
                      letterSpacing: 0.0,
                    ),
              ),
            ),
          ),
          actions: const [],
          centerTitle: true,
          elevation: 2.0,
        ),
        body: SafeArea(
          top: true,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Icon(
                    Icons.circle_notifications_rounded,
                    color: FlutterFlowTheme.of(context).primary,
                    size: 64.0,
                  ),
                  Text(
                    'Timbre',
                    style: FlutterFlowTheme.of(context).displaySmall.override(
                          fontFamily: 'Outfit',
                          letterSpacing: 0.0,
                        ),
                  ),
                  // Text(
                  //   'Version 0.2',
                  //   style: FlutterFlowTheme.of(context).headlineSmall.override(
                  //         fontFamily: 'Outfit',
                  //         letterSpacing: 0.0,
                  //       ),
                  // ),
                  Text(
                    'Desarrollada para ITSB\nIntegrantes: Castro, Parrondo, Pylypchuk',
                    textAlign: TextAlign.center, // Correct placement of textAlign
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: 'Readex Pro',
                      letterSpacing: 0.0,
                    ),
                  ),
                  SizedBox(height: 16.0), // Add some spacing before the ImageScroller
                  AspectRatio(
                    aspectRatio: 1.0, // To ensure the height and width are equal
                    child: ImageScroller(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ImageScroller extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double imageSize = MediaQuery.of(context).size.width - 32; // Adjust for padding

    return PageView(
      children: <Widget>[
        Container(
          width: imageSize,
          height: imageSize,
          child: Image.asset(
            'assets/images/0.png',
            fit: BoxFit.cover,
          ),
        ),
        Container(
          width: imageSize,
          height: imageSize,
          child: Image.asset(
            'assets/images/1.png',
            fit: BoxFit.cover,
          ),
        ),
        Container(
          width: imageSize,
          height: imageSize,
          child: Image.asset(
            'assets/images/2.png',
            fit: BoxFit.cover,
          ),
        ),
        Container(
          width: imageSize,
          height: imageSize,
          child: Image.asset(
            'assets/images/3.png',
            fit: BoxFit.cover,
          ),
        ),
        Container(
          width: imageSize,
          height: imageSize,
          child: Image.asset(
            'assets/images/4.png',
            fit: BoxFit.cover,
          ),
        ),
        Container(
          width: imageSize,
          height: imageSize,
          child: Image.asset(
            'assets/images/5.png',
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }
}
