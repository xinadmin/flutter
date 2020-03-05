import 'package:flutter/material.dart';
import 'dart:math';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:core';
import 'package:cached_network_image/cached_network_image.dart';

//美元转化
String tranFrom(var val) {
  var exchange = 0.15;
  val = formatNum(double.parse(val) * exchange, 2);
  if (val != 0) {
    return "\$" + val.toString();
  } else {
    return "\$0.00";
  }
}

//清空本地缓冲
formClean() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.clear();
}

//保存缓存String类型
formSave(var key, var value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(key, value);
}

//获取缓存String类型
Future<String> formGet(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String item = prefs.getString(key);
  return item;
}

//保存缓存Bool类型
saveisLogin(var key, var value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool(key, value);
}

//获取缓存Bool类型
Future<bool> formBool(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool item = prefs.getBool(key);
  return item;
}

//保留小数点
String formatNum(double num, int postion) {
  if ((num.toString().length - num.toString().lastIndexOf(".") - 1) < postion) {
    //小数点后有几位小数
    return num.toStringAsFixed(postion)
        .substring(0, num.toString().lastIndexOf(".") + postion + 1)
        .toString();
  } else {
    return num.toString()
        .substring(0, num.toString().lastIndexOf(".") + postion + 1)
        .toString();
  }
}

//图片过滤
String changeImg(item) {
  if (item) {
    item = item.toString();
    var reg = '/src=[\'\"][/image](\.\*\?)[\'\"]/g';
    var reg1 = '/src=[\'\"](\?\!http)(\.\*\?)[\'\"]/g';

    var baseurl = 'https://panda36.com/';
    var newimage = "";
    item.replace(RegExp(reg), 'src="' + newimage + '"');
    item.replace(RegExp(reg1), 'src="' + baseurl + '"');
    return item;
  }
}

CachedNetworkImage getCacheImage(
    {String imageUrl, BoxFit fit, double width, double height}) {
  return CachedNetworkImage(
    imageUrl: imageUrl,
    fit: fit,
    fadeInDuration: Duration(milliseconds: 300),
    width: width,
    height: height,
  );
}
