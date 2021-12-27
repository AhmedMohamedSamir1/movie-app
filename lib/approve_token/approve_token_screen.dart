import 'package:flutter/material.dart';
import 'package:movie_app/shared/components/constants.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ApproveTokenScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: WebView(
        initialUrl: 'https://www.themoviedb.org/authenticate/$TOKEN',
      ),
    );
  }
}
