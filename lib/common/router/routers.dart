import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:nlp_starter/common/router/router_handler.dart';

class Routes {
  static String root = '/';
  static String homePage = 'home';
  static String webViewPage = '/web-view-page';
  static String nlpTryDetailSegmentPage = '/nlp-try-detail-segment-page';

  static void configureRoutes(Router router) {
    router.notFoundHandler = new Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
        });

    router.define(root,handler:rootHand);
    router.define(homePage,handler:homePageHand);
    router.define(webViewPage,handler:webViewPageHand);
    router.define(nlpTryDetailSegmentPage,handler:nlpTryDetailSegmentPageHand);
  }
}
