import 'package:flutter/material.dart';
import '../model/details.dart';
import '../service/service_method.dart';
import 'package:flutter_app/utils/global.dart';

class DetailsInfoProvide with ChangeNotifier {
//   DetailsModel goodsInfo =null;
  var goodsInfo = null;

  bool isLeft = true;
  bool isRight = false;
  int isSelectSpec = 0;

  //从后台获取商品信息
  //默认
//  设置一个变量默认为空
  // 遍历数组
  getGoodsInfo(String id) async {
    var formData = {
      'goods_id': id,
    };
    var result = await G.req.goods.goodsdetail(formData);
    Map val = result.data;
    if (val['status'] == 0) {
      goodsInfo = val['data'];
      var goods_attr_key = goodsInfo["goodsInfo"]['goods_attr_key'];
      if (goods_attr_key == "") {
        goodsInfo["goodsInfo"]['goods_attr_key'] = "";
      } else {
        List attr = goodsInfo["goodsInfo"]['attr'];
        Map series = {};
        var isMore = goods_attr_key.contains("_");
        if (!isMore) {
          series[goods_attr_key] = [];
          if (attr.length > 0) {
               for (var index = 0 ; index < attr.length; index++ ) {
                 if (index == 0) {
                    series[goods_attr_key].add({
                      'value': attr[index]['goods_attr_value'],
                      'selected': true,
                    });
                 } else {
                    series[goods_attr_key].add({
                      'value': attr[index]['goods_attr_value'],
                      'selected': false,
                    });
                  }
               }
          } else {
            return Container(
              height: 0,
            );
          }
        } else {
          var series_key = goods_attr_key.split('_');
          series_key.asMap().forEach((index1, value) {
            series[series_key[index1]] = [];
            attr.asMap().forEach((index, value) {
              for (var i = 0; i < series[series_key[index1]].length; i++) {
                if (series[series_key[index1]][i]['value'] ==
                    attr[index]['goods_attr_value'].split('_')[index1]) {
                  return;
                }
              }
              if (index == 0) {
                series[series_key[index1]].add({
                  'value': attr[index]['goods_attr_value'].split('_')[index1],
                  'selected': true,
                });
              } else {
                series[series_key[index1]].add({
                  'value': attr[index]['goods_attr_value'].split('_')[index1],
                  'selected': false,
                });
              }
            });
          });
        }
        goodsInfo['series'] = series;
      }
      goodsInfo['checkvalue'] =
          goodsInfo["goodsInfo"]['attr'][0]['goods_attr_value'];
      goodsInfo['specindex'] = 0;
      notifyListeners();
    }

  }

//  切换规格值
  changeSpecValue(var childrenindex, var parentindex) {
    for (var i = 0; i < goodsInfo['series'][parentindex].length; i++) {
      goodsInfo['series'][parentindex][i]['selected'] = false;
    }
    goodsInfo['series'][parentindex][childrenindex]['selected'] = true;
    var checkvalue = "";
    goodsInfo['series'].forEach((key, value) {
      for (var i = 0; i < goodsInfo['series'][key].length; i++) {
        if (goodsInfo['series'][key][i]['selected'] == true) {
          checkvalue += goodsInfo['series'][key][i]['value'] + "_";
        }
      }
      goodsInfo['series'][key].forEach((val) {});
    });

    checkvalue = checkvalue.substring(0, checkvalue.length - 1);
    goodsInfo['checkvalue'] = checkvalue;
    for (var i = 0; i < goodsInfo['goodsInfo']['attr'].length; i++) {
      if (goodsInfo['goodsInfo']['attr'][i]['goods_attr_value'] == checkvalue) {
        goodsInfo['specindex'] = i;
      }
    }
    notifyListeners();
  }

  //改变tabBar的状态
  changeLeftAndRight(String changeState) {
    if (changeState == 'left') {
      isLeft = true;
      isRight = false;
    } else {
      isLeft = false;
      isRight = true;
    }
    notifyListeners();
  }
}
