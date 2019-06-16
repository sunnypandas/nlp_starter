import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nlp_starter/common/router/application.dart';
import 'package:nlp_starter/common/router/routers.dart';
import 'package:nlp_starter/common/style/gsy_style.dart';

/**
 * 通知消息
 * Created by sppsun
 * Date: 2019-06-06
 */

class NlpTryPage extends StatefulWidget {
  NlpTryPage();

  @override
  _NlpTryPageState createState() => _NlpTryPageState();
}

class _NlpTryPageState extends State<NlpTryPage>
    with AutomaticKeepAliveClientMixin<NlpTryPage> {

  _NlpTryPageState();

  var items = [
    {
      'name': '基础分词',
      'desc': '基础分词只进行基本NGram分词，不识别命名实体，不使用用户词典',
      'method': 'basicTokenizer',
      'params': {
        'text' :"举办纪念活动铭记二战历史，不忘战争带给人类的深重灾难，是为了防止悲剧重演，确保和平永驻；" +
            "铭记二战历史，更是为了提醒国际社会，需要共同捍卫二战胜利成果和国际公平正义，" +
            "必须警惕和抵制在历史认知和维护战后国际秩序问题上的倒行逆施。"
      }
    },
    {
      'name': 'CRF词法分析器',
      'desc': 'CRF模型为对数线性，模型通过复用结构化感知机的维特比解码算法，效率提高10倍',
      'method': 'crfLexicalAnalyzer',
      'params': {
        'sentence': "商品和服务"
      }
    },
    {
      'name': '中国人名识别',
      'desc': '中国人名识别',
      'method': 'chineseNameRecognition',
      'params': {
        'sentence': "签约仪式前，秦光荣、李纪恒、仇和等一同会见了参加签约的企业家。"
      }
    },
    {
      'name': '依存句法分析',
      'desc': '依存句法分析',
      'method': 'dependencyParser',
      'params': {
        'sentence': "徐先生还具体帮助他确定了把画雄鹰、松鼠和麻雀作为主攻目标。"
      }
    },
    {
      'name': '极速分词',
      'desc': '基于DoubleArrayTrie实现的词典正向最长分词，适用于“高吞吐量”“精度一般”的场合',
      'method': 'highSpeedSegment',
      'params': {
        'text': "江西鄱阳湖干枯，中国最大淡水湖变成大草原"
      }
    },
    {
      'name': '索引分词',
      'desc': '索引分词',
      'method': 'indexSegment',
      'params': {
        'text': "主副食品"
      }
    },
    {
      'name': '日本人名识别',
      'desc': '日本人名识别',
      'method': 'japaneseNameRecognition',
      'params': {
        'sentence': "北川景子参演了林诣彬导演的《速度与激情3》"
      }
    },
    {
      'name': '关键词提取',
      'desc': '关键词提取',
      'method': 'keyword',
      'params': {
        'content': "程序员(英文Programmer)是从事程序开发、维护的专业人员。" +
            "一般将程序员分为程序设计人员和程序编码人员，" +
            "但两者的界限并不非常清楚，特别是在中国。" +
            "软件从业人员分为初级程序员、高级程序员、系统" +
            "分析员和项目经理四大类。",
        'size': 5
      }
    },
    {
      'name': '多线程并行分词',
      'desc': '多线程并行分词',
      'method': 'multithreadingSegment',
      'params': {
        'text': "举办纪念活动铭记二战历史，不忘战争带给人类的深重灾难，是为了防止悲剧重演，确保和平永驻；" +
            "铭记二战历史，更是为了提醒国际社会，需要共同捍卫二战胜利成果和国际公平正义，" +
            "必须警惕和抵制在历史认知和维护战后国际秩序问题上的倒行逆施。"
      }
    },
    {
      'name': 'NLP分词',
      'desc': '更精准的中文分词、词性标注与命名实体识别',
      'method': 'nlpSegment',
      'params': {
        'text': "我新造一个词叫幻想乡你能识别并正确标注词性吗？"
      }
    },
    {
      'name': 'N最短路径分词',
      'desc': '该分词器比最短路分词器慢，但是效果稍微好一些，对命名实体识别能力更强',
      'method': 'nShortSegment',
      'params': {
        'sentence': "今天，刘志军案的关键人物,山西女商人丁书苗在市二中院出庭受审。"
      }
    },
    {
      'name': '最短路径分词',
      'desc': '最短路径分词',
      'method': 'shortestSegment',
      'params': {
        'sentence': "今天，刘志军案的关键人物,山西女商人丁书苗在市二中院出庭受审。"
      }
    },
    {
      'name': '词语提取、新词发现',
      'desc': '词语提取、新词发现',
      'method': 'newWordDiscover',
      'params': {
        'content': "今天，刘志军案的关键人物,山西女商人丁书苗在市二中院出庭受审。",
        'size': 5
      }
    },
    {
      'name': '自动去除停用词、自动断句',
      'desc': '自动去除停用词、自动断句的分词器',
      'method': 'normalization',
      'params': {
        'text': "小区居民有的反对喂养流浪猫，而有的居民却赞成喂养这些小宝贝"
      }
    },
    {
      'name': '数词和数量词识别',
      'desc': '数词和数量词识别',
      'method': 'numberAndQuantifierRecognition',
      'params': {
        'sentence': "九千九百九十九朵玫瑰"
      }
    },
    {
      'name': '演示词共现统计',
      'desc': '演示词共现统计',
      'method': 'occurrence',
      'params': {
        'text': "在计算机音视频和图形图像技术等二维信息算法处理方面目前比较先进的视频处理算法"
      }
    },
    {
      'name': '机构名识别',
      'desc': '机构名识别',
      'method': 'organizationRecognition',
      'params': {
        'sentence': "偶尔去开元地中海影城看电影。"
      }
    },
    {
      'name': '短语提取',
      'desc': '短语提取',
      'method': 'phraseExtractor',
      'params': {
        'text': "算法工程师\n" +
            "算法（Algorithm）是一系列解决问题的清晰指令，也就是说，能够对一定规范的输入，在有限时间内获得所要求的输出。" +
            "如果一个算法有缺陷，或不适合于某个问题，执行这个算法将不会解决这个问题。不同的算法可能用不同的时间、" +
            "空间或效率来完成同样的任务。一个算法的优劣可以用空间复杂度与时间复杂度来衡量。算法工程师就是利用算法处理事物的人。\n" +
            "\n" +
            "1职位简介\n" +
            "算法工程师是一个非常高端的职位；\n" +
            "专业要求：计算机、电子、通信、数学等相关专业；\n" +
            "学历要求：本科及其以上的学历，大多数是硕士学历及其以上；\n" +
            "语言要求：英语要求是熟练，基本上能阅读国外专业书刊；\n" +
            "必须掌握计算机相关知识，熟练使用仿真工具MATLAB等，必须会一门编程语言。\n" +
            "\n" +
            "2研究方向\n" +
            "视频算法工程师、图像处理算法工程师、音频算法工程师 通信基带算法工程师\n" +
            "\n" +
            "3目前国内外状况\n" +
            "目前国内从事算法研究的工程师不少，但是高级算法工程师却很少，是一个非常紧缺的专业工程师。" +
            "算法工程师根据研究领域来分主要有音频/视频算法处理、图像技术方面的二维信息算法处理和通信物理层、" +
            "雷达信号处理、生物医学信号处理等领域的一维信息算法处理。\n" +
            "在计算机音视频和图形图像技术等二维信息算法处理方面目前比较先进的视频处理算法：机器视觉成为此类算法研究的核心；" +
            "另外还有2D转3D算法(2D-to-3D conversion)，去隔行算法(de-interlacing)，运动估计运动补偿算法" +
            "(Motion estimation/Motion Compensation)，去噪算法(Noise Reduction)，缩放算法(scaling)，" +
            "锐化处理算法(Sharpness)，超分辨率算法(Super Resolution),手势识别(gesture recognition),人脸识别(face recognition)。\n" +
            "在通信物理层等一维信息领域目前常用的算法：无线领域的RRM、RTT，传送领域的调制解调、信道均衡、信号检测、网络优化、信号分解等。\n" +
            "另外数据挖掘、互联网搜索算法也成为当今的热门方向。\n" +
            "算法工程师逐渐往人工智能方向发展。",
        'size': 5
      }
    },
    {
      'name': '汉字转拼音',
      'desc': '汉字转拼音',
      'method': 'pinyin',
      'params': {
        'text': "重载不是重任！"
      }
    },
    {
      'name': '地名识别',
      'desc': '地名识别',
      'method': 'placeRecognition',
      'params': {
        'sentence': "蓝翔给宁夏固原市彭阳县红河镇黑牛沟村捐赠了挖掘机"
      }
    },
    {
      'name': '词性标注',
      'desc': '词性标注',
      'method': 'posTagging',
      'params': {
        'text': "教授正在教授自然语言处理课程"
      }
    },
    {
      'name': '文本重写',
      'desc': '文本重写',
      'method': 'rewriteText',
      'params': {
        'text': "这个方法可以利用同义词词典将一段文本改写成意思相似的另一段文本，而且差不多符合语法"
      }
    },
    {
      'name': '标准分词',
      'desc': '标准分词',
      'method': 'segment',
      'params': {
        'sentence': "商品和服务"
      }
    },
    {
      'name': '去除停用词',
      'desc': '如何去除停用词',
      'method': 'stopWord',
      'params': {
        'text': "小区居民有的反对喂养流浪猫，而有的居民却赞成喂养这些小宝贝",
        'stopWords': ["居民"]
      }
    },
    {
      'name': '文本推荐',
      'desc': '句子级别，从一系列句子中挑出与输入句子最相似的那一个',
      'method': 'suggester',
      'params': {
        'titles': [
          "威廉王子发表演说 呼吁保护野生动物",
          "魅惑天后许佳慧不爱“预谋” 独唱《许某某》",
          "《时代》年度人物最终入围名单出炉 普京马云入选",
          "“黑格比”横扫菲：菲吸取“海燕”经验及早疏散",
          "日本保密法将正式生效 日媒指其损害国民知情权",
          "英报告说空气污染带来“公共健康危机”"
        ],
        'key': "陈述",
        'size': 2
      }
    },
    {
      'name': '自动摘要',
      'desc': '自动摘要',
      'method': 'summary',
      'params': {
        'document': "水利部水资源司司长陈明忠9月29日在国务院新闻办举行的新闻发布会上透露，" +
            "根据刚刚完成了水资源管理制度的考核，有部分省接近了红线的指标，" +
            "有部分省超过红线的指标。对一些超过红线的地方，陈明忠表示，对一些取用水项目进行区域的限批，" +
            "严格地进行水资源论证和取水许可的批准。",
        'size': 3
      }
    },
    {
      'name': '动态设置预置分词器',
      'desc': '动态设置预置分词器，这里的设置是全局的',
      'method': 'tokenizerConfig',
      'params': {
        'text': "泽田依子是上外日本文化经济学院的外教"
      }
    },
    {
      'name': '将简繁转换做到极致',
      'desc': '将简繁转换做到极致',
      'method': 'convertToTraditionalChinese',
      'params': {
        'simplifiedChineseString': "“以后等你当上皇后，就能买草莓庆祝了”。发现一根白头发"
      }
    },
    {
      'name': '将繁简转换做到极致',
      'desc': '将繁简转换做到极致',
      'method': 'convertToSimplifiedChinese',
      'params': {
        'traditionalChineseString': "憑藉筆記簿型電腦寫程式HanLP"
      }
    },
    {
      'name': '繁体中文分词',
      'desc': '繁体中文分词',
      'method': 'traditionalChineseSegment',
      'params': {
        'text': "大衛貝克漢不僅僅是名著名球員，球場以外，其妻為前" +
            "辣妹合唱團成員維多利亞·碧咸，亦由於他擁有" +
            "突出外表、百變髮型及正面的形象，以至自己" +
            "品牌的男士香水等商品，及長期擔任運動品牌" +
            "Adidas的代言人，因此對大眾傳播媒介和時尚界" +
            "等方面都具很大的影響力，在足球圈外所獲得的" +
            "認受程度可謂前所未見。"
      }
    },
    {
      'name': '音译人名识别',
      'desc': '音译人名识别',
      'method': 'translatedNameRecognition',
      'params': {
        'sentence': "一桶冰水当头倒下，微软的比尔盖茨、Facebook的扎克伯格跟桑德博格、亚马逊的贝索斯、苹果的库克全都不惜湿身入镜，这些硅谷的科技人，飞蛾扑火似地牺牲演出，其实全为了慈善。"
      }
    },
    {
      'name': 'url识别',
      'desc': 'url识别',
      'method': 'urlRecognition',
      'params': {
        'text': "HanLP的项目地址是https://github.com/hankcs/HanLP，" +
            "发布地址是https://github.com/hankcs/HanLP/releases，" +
            "我有时候会在www.hankcs.com上面发布一些消息，" +
            "我的微博是http://weibo.com/hankcs/，会同步推送hankcs.com的新闻。" +
            "听说.中国域名开放申请了,但我并没有申请hankcs.中国,因为穷……"
      }
    },
    {
      'name': '语义距离',
      'desc': '语义距离',
      'method': 'wordDistance',
      'params': {
        'wordA': "香蕉",
        'wordB': "苹果"
      }
    },
    {
      'name': '语义相似度',
      'desc': '语义相似度',
      'method': 'wordSimilarity',
      'params': {
        'wordA': "香蕉",
        'wordB': "苹果"
      }
    }
  ];

  @override
  Widget build(BuildContext context) {
    super.build(context); // See AutomaticKeepAliveClientMixin.
    return new Scaffold(
//      backgroundColor: Color(GSYColors.mainBackgroundColor),
      body: SizedBox(
      child:  ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: items.length, // item 的个数
//        separatorBuilder: (BuildContext context, int index) => Divider(height:1.0,color: Colors.blue),  // 添加分割线
        itemBuilder: (BuildContext context, int index) {
          return Card(
            clipBehavior:Clip.antiAlias,// 根据设置裁剪内容
            color:Colors.blue, //  卡片背景颜色
            elevation:12.0, // 卡片的z坐标,控制卡片下面的阴影大小
            margin:EdgeInsets.all(8.0),
            //  margin: EdgeInsetsDirectional.only(bottom: 30.0, top: 30.0, start: 30.0),// 边距
            semanticContainer:true, // 表示单个语义容器，还是false表示单个语义节点的集合，接受单个child，但该child可以是Row，Column或其他包含子级列表的widget
//      shape: Border.all(
//          color: Colors.indigo, width: 1.0, style: BorderStyle.solid), // 卡片材质的形状，以及边框
            shape:RoundedRectangleBorder(borderRadius:  BorderRadius.circular(16.0)), // 圆角
            //borderRadius: BorderRadius.all(Radius.circular(8.0)),
            child: Column( //card里面的子控件
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  leading: Text('${index + 1}'),
                  title: Text(items[index]['name'], style: TextStyle(color: Colors.white, fontSize: 20.0)),
                  subtitle: Text(items[index]['desc'], style: TextStyle(color: Colors.yellow, fontSize: 16.0)),
                  contentPadding: EdgeInsets.all(8.0),// item 内容内边距
                ),
                ButtonTheme.bar( // make buttons use the appropriate styles for cards
                  child: ButtonBar(
                    children: <Widget>[
                      FlatButton(
                        child: Icon(Icons.more_vert),
                        onPressed: () {
                          String method = items[index]['method'];
                          Map<String, dynamic> params = items[index]['params'];
                          Application.router.navigateTo(context, '${Routes.nlpTryDetailSegmentPage}?method=${Uri.encodeComponent(method)}&params=${Uri.encodeComponent(jsonEncode(params))}');
                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

}
