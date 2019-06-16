import 'package:nlp_starter/bloc/base/nlp_base_bloc.dart';
import 'package:nlp_starter/common/dao/nlp_dao.dart';
import 'package:nlp_starter/common/model/Nlp.dart';

/**
 * Created by sppsun
 * on 2019/3/23.
 */
class NlpBloc extends BlocListBase {
  requestRefresh({order = 'POPULAR', bool needDb = false}) async {
    pageReset();
    var res = await NlpDao.getNlp(after: after, order: order, needDb: needDb);
    Nlp nlp = res?.data;
    nextCursor = nlp?.data?.articleFeed?.items?.pageInfo?.endCursor;
    changeLoadMoreStatus(nlp?.data?.articleFeed?.items?.pageInfo?.hasNextPage);
    refreshData(res);
    await doNext(res);
    return res;
  }

  requestLoadMore(String endCursor, {order = 'POPULAR', bool needDb = false}) async {
    pageUp(endCursor);
    var res = await NlpDao.getNlp(after: after, order: order, needDb: needDb);
    Nlp nlp = res?.data;
    nextCursor = nlp?.data?.articleFeed?.items?.pageInfo?.endCursor;
    changeLoadMoreStatus(nlp?.data?.articleFeed?.items?.pageInfo?.hasNextPage);
    loadMoreData(res);
    return res;
  }

//  requestTry(String method, Map<String, dynamic> params, {bool needDb = false}) async {
//    var res = await NlpDao.getNlpTry(method, params, needDb: needDb);
//    return res;
//  }

}
