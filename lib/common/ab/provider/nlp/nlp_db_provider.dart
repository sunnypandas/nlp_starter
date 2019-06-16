import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:nlp_starter/common/utils/code_utils.dart';
import 'package:nlp_starter/common/ab/sql_provider.dart';
import 'package:nlp_starter/common/model/Nlp.dart';
import 'package:sqflite/sqflite.dart';

/**
 * 用户接受事件表
 * Created by sppsun
 * Date: 2019-06-06
 */

class NlpDbProvider extends BaseDbProvider {
  final String name = 'ReceivedNlp';

  final String columnId = "_id";
  final String columnData = "data";

  int id;
  String data;

  NlpDbProvider();

  Map<String, dynamic> toMap(String nlpMapString) {
    Map<String, dynamic> map = {columnData: nlpMapString};
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }

  NlpDbProvider.fromMap(Map map) {
    id = map[columnId];
    data = map[columnData];
  }

  @override
  tableSqlString() {
    return tableBaseString(name, columnId) +
        '''
        $columnData text not null)
      ''';
  }

  @override
  tableName() {
    return name;
  }

  ///插入到数据库
  Future insert(String nlpMapString) async {
    Database db = await getDataBase();

    ///清空后再插入，因为只保存第一页面
    db.execute("delete from $name");
    return await db.insert(name, toMap(nlpMapString));
  }

  ///获取事件数据
  Future<Nlp> getNlp() async {
    Database db = await getDataBase();
    List<Map> maps = await db.query(name, columns: [columnId, columnData]);
    if (maps.length > 0) {
      NlpDbProvider provider = NlpDbProvider.fromMap(maps.first);

      ///使用 compute 的 Isolate 优化 json decode
      List<dynamic> eventMap = await compute(CodeUtils.decodeListResult, provider.data);

      Nlp.fromJson(eventMap[0]);
    }
    return null;;
  }
}