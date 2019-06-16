import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:nlp_starter/common/redux/gsy_state.dart';
import 'package:nlp_starter/common/utils/navigator_utils.dart';
import 'package:nlp_starter/page/home_page.dart';
import 'package:nlp_starter/page/nlp_try_detail_segment_page.dart';
import 'package:nlp_starter/page/web_view_page.dart';
import 'package:nlp_starter/page/welcome_page.dart';

import 'package:nlp_starter/main.dart';

var rootHand = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      StoreProvider.of<GSYState>(context).state.platformLocale = Localizations.localeOf(context);
      return WelcomePage();
    });

var homePageHand = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return new GSYLocalizations(
          child: NavigatorUtils.pageContainer(new HomePage()));
    });

var webViewPageHand = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      String title = params['title']?.first;
      String url = params['url']?.first;
      return new WebViewPage(url, title);
    });

var nlpTryDetailSegmentPageHand = new Handler(
    handlerFunc: (BuildContext context, Map<String, dynamic> params) {
      return new NlpTryDetailSegmentPage(params['method']?.first, jsonDecode(params['params']?.first));
    });
