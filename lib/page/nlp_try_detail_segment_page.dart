import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nlp_starter/common/dao/nlp_dao.dart';

/**
 * Readme
 * Created by sppsun
 * Date: 2019-06-06
 */

class NlpTryDetailSegmentPage extends StatefulWidget {

  final String method;
  final Map<String, dynamic> params;

  NlpTryDetailSegmentPage(this.method, this.params, {Key key}) : super(key: key);

  @override
  NlpTryDetailSegmentPageState createState() => NlpTryDetailSegmentPageState();
}


class NlpTryDetailSegmentPageState extends State<NlpTryDetailSegmentPage> with AutomaticKeepAliveClientMixin {

  NlpTryDetailSegmentPageState();

  TextEditingController _controllerRequest;
  TextEditingController _controllerResult;

  getNlpTry(String method, Map<String, dynamic> params) {
    NlpDao.getNlpTry(method, params).then((res) {
      if (res != null && res.data['code'] == 'YA-200') {
        setState(() {
          _controllerResult = new TextEditingController(text: res.data['data'].toString());
        });
      }
      else
        {
          setState(() {
            _controllerResult = new TextEditingController(text: res.data['message'].toString());
          }
            );
        }
    });
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _controllerRequest = new TextEditingController(text: jsonEncode(widget.params));
    _controllerResult = new TextEditingController(text: 'no result');
    getNlpTry(widget.method, widget.params);
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _textFieldChanged(String str) {
    print(str);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return new Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: true,
//            title: Text('AppBar Back Button'),
            leading: IconButton(icon:Icon(Icons.arrow_back),
              onPressed:() => Navigator.pop(context, false),
            )
        ),
//      backgroundColor: Color(GSYColors.mainBackgroundColor),
      body: ListView(
          children: <Widget>[
      new Container(
      padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 8),
      child: new Row(
        children: <Widget>[
          Flexible(
              child: TextField(
                keyboardType: TextInputType.text,
                minLines: 2,
                maxLines: 80,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10.0),
                  icon: Icon(Icons.text_fields),
                  labelText: 'You can edit this json string',
                ),
                onChanged: _textFieldChanged,
                controller: _controllerRequest,
                autofocus: false,
              ))
        ],
      ),
    ),
            FlatButton(
                child: Icon(Icons.refresh),
                onPressed: () {
                  getNlpTry(widget.method, json.decode(_controllerRequest.text));
                }
            ),
        new Container(
          padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 8),
          child: new Row(
            children: <Widget>[
              Flexible(
                  child: TextField(
                    enabled: false,
                    keyboardType: TextInputType.text,
                    minLines: 2,
                    maxLines: 80,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(10.0),
                      icon: Icon(Icons.check_circle),
                      labelText: 'This field shows result',
                    ),
                    onChanged: _textFieldChanged,
                    controller: _controllerResult,
                    autofocus: false,
                  ))
            ],
          ),
        )
      ]
    )
    );
  }
}
