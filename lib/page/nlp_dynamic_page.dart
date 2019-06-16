import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:nlp_starter/bloc/base/nlp_base_bloc.dart';
import 'package:nlp_starter/bloc/nlp_bloc.dart';
import 'package:nlp_starter/common/dao/repos_dao.dart';
import 'package:nlp_starter/common/model/Nlp.dart';
import 'package:nlp_starter/common/redux/gsy_state.dart';
import 'package:nlp_starter/common/router/application.dart';
import 'package:nlp_starter/common/router/routers.dart';
import 'package:nlp_starter/widget/nlp_item.dart';
import 'package:nlp_starter/widget/state/nlp_gsy_bloc_list_state.dart';
import 'package:nlp_starter/widget/pull/gsy_pull_new_load_widget.dart';
import 'package:redux/redux.dart';

/**
 * 主页动态tab页
 * Created by sppsun
 * Date: 2019-06-06
 */
class NlpDynamicPage extends StatefulWidget {
  @override
  _NlpDynamicPageState createState() => _NlpDynamicPageState();
}

class _NlpDynamicPageState extends State<NlpDynamicPage>
    with
        AutomaticKeepAliveClientMixin<NlpDynamicPage>,
        GSYListState<NlpDynamicPage>,
        WidgetsBindingObserver {
  final NlpBloc nlpDynamicBloc = new NlpBloc();

  ///控制列表滚动和监听
  final ScrollController scrollController = new ScrollController();

  /// 模拟IOS下拉显示刷新
  @override
  showRefreshLoading() {
    ///直接触发下拉
    new Future.delayed(const Duration(milliseconds: 500), () {
      scrollController.animateTo(-141,
          duration: Duration(milliseconds: 600), curve: Curves.linear);
      return true;
    });
  }

  @override
  bool get wantKeepAlive => true;

  @override
  requestRefresh() async {
    await Future.delayed(Duration(seconds: 1));
    return await nlpDynamicBloc.requestRefresh(order: 'POPULAR');
  }

  @override
  requestLoadMore() async {
    return await nlpDynamicBloc.requestLoadMore(nlpDynamicBloc.nextCursor, order: 'POPULAR');
  }

  @override
  bool get isRefreshFirst => false;

  @override
  BlocListBase get bloc => nlpDynamicBloc;

  @override
  void initState() {
    super.initState();
    ///监听生命周期，主要判断页面 resumed 的时候触发刷新
    WidgetsBinding.instance.addObserver(this);
    ///获取网络端新版信息
    ReposDao.getNewsVersion(context, false);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    if (bloc.getDataLength() == 0) {
      showRefreshLoading();
    }
    super.didChangeDependencies();
  }

  ///监听生命周期，主要判断页面 resumed 的时候触发刷新
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      if (bloc.getDataLength() != 0) {
        showRefreshLoading();
      }
    }
  }

  _renderNlpItem(Node node) {
    NlpViewModel eventViewModel = NlpViewModel.fromNlptMap(node);
    return new NlpItem(
      eventViewModel,
      onPressed: () {
        Application.router.navigateTo(context, '${Routes.webViewPage}?title=${Uri.encodeComponent(node.title)}&url=${Uri.encodeComponent(node.originalUrl)}');
//        EventUtils.ActionUtils(context, node, "");
      },
    );
  }

  Store<GSYState> _getStore() {
    return StoreProvider.of(context);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // See AutomaticKeepAliveClientMixin.
    return new StoreBuilder<GSYState>(
      builder: (context, store) {
        ///BlocProvider 用于管理 bloc 共享，如果不需要共享可以不用
        ///直接 StreamBuilder 配合即可
        return BlocProvider<NlpBloc>(
          bloc: nlpDynamicBloc,
          child: GSYPullLoadWidget(
            bloc.pullLoadWidgetControl,
            (BuildContext context, int index) =>
                _renderNlpItem(bloc.dataList[index]),
            requestRefresh,
            requestLoadMore,
            refreshKey: refreshIndicatorKey,
            scrollController: scrollController,
            ///使用ios模式的下拉刷新
            userIos: true,
          ),
        );
      },
    );
  }
}
