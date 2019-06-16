
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

/**
 * 语言Redux
 * Created by sppsun
 * Date: 2019-06-06
 */

final LocaleReducer = combineReducers<Locale>([
  TypedReducer<Locale, RefreshLocaleAction>(_refresh),
]);

Locale _refresh(Locale locale, RefreshLocaleAction action) {
  locale = action.locale;
  return locale;
}

class RefreshLocaleAction {
  final Locale locale;

  RefreshLocaleAction(this.locale);
}


