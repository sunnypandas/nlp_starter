import 'package:flutter/material.dart';
import 'package:nlp_starter/common/model/Nlp.dart';
import 'package:nlp_starter/common/style/gsy_style.dart';
import 'package:nlp_starter/widget/gsy_card_item.dart';

/**
 * 事件Item
 * Created by sppsun
 * Date: 2019-06-06
 */
class NlpItem extends StatelessWidget {
  final NlpViewModel nlpViewModel;

  final VoidCallback onPressed;

  final bool needImage;

  NlpItem(this.nlpViewModel, {this.onPressed, this.needImage = true}) : super();

  @override
  Widget build(BuildContext context) {

    return new Container(
      child: new GSYCardItem(
          child: new FlatButton(
              onPressed: onPressed,
              child: new Padding(
                padding: new EdgeInsets.only(left: 0.0, top: 10.0, right: 0.0, bottom: 10.0),
                child: new Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    new Row(
                      children: <Widget>[
                        new Expanded(child: new Text(nlpViewModel.user, style: GSYConstant.smallTextBold)),
                        new Text(nlpViewModel.createdAt, style: GSYConstant.smallSubText),
                      ],
                    ),
                    new Container(
                        child: new Text(nlpViewModel.title, style: GSYConstant.smallText),
                        margin: new EdgeInsets.only(top: 6.0, bottom: 2.0),
                        alignment: Alignment.topLeft),
                  ],
                ),
              ))),
    );
  }
}

class NlpViewModel {
  String title;
  String user;
  String createdAt;

  NlpViewModel.fromNlptMap(Node node) {
    this.title = node.title;
    this.user = node.user.username;
    this.createdAt = node.createdAt;
  }
  
}
