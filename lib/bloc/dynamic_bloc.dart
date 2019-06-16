import 'package:nlp_starter/bloc/base/base_bloc.dart';
import 'package:nlp_starter/common/dao/event_dao.dart';

/**
 * Created by sppsun
 * on 2019/3/23.
 */
class DynamicBloc extends BlocListBase {
  requestRefresh(String userName) async {
    pageReset();
    var res = await EventDao.getEventReceived(userName, page: page, needDb: true);
    changeLoadMoreStatus(getLoadMoreStatus(res));
    refreshData(res);
    await doNext(res);
    return res;
  }

  requestLoadMore(String userName) async {
    pageUp();
    var res = await EventDao.getEventReceived(userName, page: page);
    changeLoadMoreStatus(getLoadMoreStatus(res));
    loadMoreData(res);
    return res;
  }

}
