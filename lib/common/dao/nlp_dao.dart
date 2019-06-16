import 'dart:io';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:nlp_starter/common/ab/provider/nlp/nlp_db_provider.dart';
import 'package:nlp_starter/common/dao/dao_result.dart';
import 'package:nlp_starter/common/model/Nlp.dart';
import 'package:nlp_starter/common/net/api.dart';

class NlpDao {
  static getNlp({after = '', order = 'POPULAR', bool needDb = false}) async {

    NlpDbProvider provider = new NlpDbProvider();

    next() async {
      String url = 'https://web-api.juejin.im/query';
      Map<String, dynamic> header = {
      'Origin': 'https://juejin.im',
      'Referer': 'https://juejin.im/welcome/ai/NLP',
      'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.169 Safari/537.36',
      'X-Agent': 'Juejin/Web',
      'X-Legacy-Device-Id': '',
      'X-Legacy-Token': '',
      'X-Legacy-Uid': '',
      'Content-Type': 'application/json'
      };
      Map<String, dynamic> params = {"operationName":"","query":"","variables":{"tags":["58c66466a22b9d0058b39b06"],"category":"57be7c18128fe1005fa902de","first":20,"after":after,"order":order},"extensions":{"query":{"id":"653b587c5c7c8a00ddf67fc66f989d42"}}};

      var res = await httpManager.netFetch(url, params, header, new Options(method: 'POST'));
      if (res.data != null) {
        if (needDb) {
          await provider.insert(json.encode(res.data));
        }
        return new DataResult(Nlp.fromJson(res.data), true);
      } else {
        return new DataResult(null, false);
      }
    }

    if (needDb) {
      Nlp db = await provider.getNlp();
      if (db == null) {
        return await next();
      }
      DataResult dataResult = new DataResult(db, true, next: next());
      return dataResult;
    }
    return await next();
  }

  static getNlpTry(String method, Map<String, dynamic> params, {bool needDb = false}) async {

    NlpDbProvider provider = new NlpDbProvider();

    next() async {
      String url = 'http://api.acgnfuns.com/hanlp/v1/hanlp/' + method;

      var res = await httpManager.netFetch(url, params, null, new Options(method: 'POST', contentType: ContentType.parse("application/x-www-form-urlencoded")));
      if (res.data != null) {
        if (needDb) {
          await provider.insert(json.encode(res.data));
        }
        return new DataResult(res.data, false);
      } else {
        return new DataResult(null, false);
      }
    }

    if (needDb) {
      Nlp db = await provider.getNlp();
      if (db == null) {
        return await next();
      }
      DataResult dataResult = new DataResult(db, true, next: next());
      return dataResult;
    }
    return await next();
  }

}
