import 'dart:async';
import 'dart:io';

import 'package:android_intent/android_intent.dart';
import 'package:flutter/material.dart';
import 'package:nlp_starter/common/style/gsy_style.dart';
import 'package:nlp_starter/common/utils/common_utils.dart';
import 'package:nlp_starter/widget/gsy_tabbar_widget.dart';
import 'package:nlp_starter/widget/home_drawer.dart';

import 'nlp_dynamic_page.dart';
import 'nlp_trend_page.dart';
import 'nlp_try_page.dart';

/**
 * 主页
 * Created by sppsun
 * Date: 2019-06-06
 */
class HomePage extends StatelessWidget {
  static final String sName = "home";

  /// 不退出
  Future<bool> _dialogExitApp(BuildContext context) async {
    ///如果是 android 回到桌面
    if (Platform.isAndroid) {
      AndroidIntent intent = AndroidIntent(
        action: 'android.intent.action.MAIN',
        category: "android.intent.category.HOME",
      );
      await intent.launch();
    }

    return Future.value(false);
  }

  _renderTab(icon, text) {
    return new Tab(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[new Icon(icon, size: 16.0), new Text(text)],
      ),
    );
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    List<Widget> tabs = [
      _renderTab(GSYICons.MAIN_NLP_DT, CommonUtils.getLocale(context).home_nlp_dynamic),
      _renderTab(GSYICons.MAIN_NLP_QS, CommonUtils.getLocale(context).home_nlp_trend),
      _renderTab(GSYICons.MAIN_NLP_TRY, CommonUtils.getLocale(context).home_nlp_try),
    ];
    ///增加返回按键监听
    return WillPopScope(
      onWillPop: () {
        return _dialogExitApp(context);
      },
      child: new GSYTabBarWidget(
        drawer: new HomeDrawer(),
        type: GSYTabBarWidget.BOTTOM_TAB,
        tabItems: tabs,
        tabViews: [
          new NlpDynamicPage(),
          new NlpTrendPage(),
          new NlpTryPage(),
        ],
        backgroundColor: GSYColors.primarySwatch,
        indicatorColor: Color(GSYColors.white),
//        title: GSYTitleBar(
//          GSYLocalizations.of(context).currentLocalized.app_name,
//          iconData: GSYICons.MAIN_SEARCH,
//          needRightLocalIcon: true,
//          onPressed: () {
//            NavigatorUtils.goSearchPage(context);
//          },
//        ),
      ),
    );
  }
}
