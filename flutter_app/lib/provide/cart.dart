import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_app/model/cartInfo.dart';
import 'dart:convert';
import 'package:flutter_app/utils/global.dart';

class CartProvide with ChangeNotifier {
  String cartString = "[]";
  List<CartInfoMode> cartList = []; //商品列表对象
  List cart = [];
  double allPrice = 0; //总价格
  int allGoodsCount = 0; //商品总数量
  bool isAllCheck = true; //是否全选
//  添加购物车后再次查询
  save() async {
    //初始化SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //获得购物车中的商品,这时候是一个字符串
    cartString = prefs.getString('cartInfo');
    //判断得到的字符串是否有值，如果不判断会报错
    var result = await G.req.cart.getCartList();
    Map val = result.data;
    if (val['status'] == "0") {
      allPrice = 0;
      allGoodsCount = 0;
      isAllCheck = true;
      List<Map> carts = [];
      cartList = [];
//          有数据进行对象遍历
      if (val['data'].length > 0) {
        //把cartList进行初始化，防止数据混乱
        G.toast('新获取购物车数据'+ val['data'].length.toString()+'条');
        for (var item in val['data']) {
          if (item['is_selected'] == null) {
            item['is_selected'] = '0';
            item['isCheck'] = false;
            isAllCheck = false;
          } else {
            if (item['is_selected'] == '1') {
              item['isCheck'] = true;
              allPrice += (double.parse(item['goods_number']) *
                  double.parse(item['goods_price']));
            } else {
              item['isCheck'] = false;
              isAllCheck = false;
            }
          }
          cartList.add(new CartInfoMode.fromJson(item));
          carts.add(item);
        }
        cartString = json.encode(carts).toString();
        prefs.setString('cartInfo', cartString);
      }
    } else {
      G.toast('系统出错');
    }
    notifyListeners();
  }
  //删除购物车中的商品
  remove() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //prefs.clear();//清空键值对
    prefs.remove('cartInfo');
    cartList = [];
    allPrice = 0;
    allGoodsCount = 0;
    G.toast('全部清空');
    notifyListeners();
  }

  //购物车中的商品
  getCartInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //获得购物车中的商品,这时候是一个字符串
    cartString = prefs.getString('cartInfo');
    //判断得到的字符串是否有值，如果不判断会报错
    cartList = [];
    if (cartString == null) {
//      请求未登录的购物车数据
      var result = await G.req.cart.getCartList();
      Map val = result.data;
      if (val['status'] == "0") {
        allPrice = 0;
        allGoodsCount = 0;
        isAllCheck = true;
        List<Map> carts = [];
//          有数据进行对象遍历
        if (val['data'].length > 0) {
          G.toast('获取购物车数据'+ val['data'].length.toString()+'条');
          //把cartList进行初始化，防止数据混乱
          for (var item in val['data']) {
            if (item['is_selected'] == null) {
              item['is_selected'] = '0';
              item['isCheck'] = false;
              isAllCheck = false;
            } else {
              if (item['is_selected'] == '1') {
                item['isCheck'] = true;
                allPrice += (double.parse(item['goods_number']) *
                    double.parse(item['goods_price']));
              } else {
                item['isCheck'] = false;
                isAllCheck = false;
              }
            }
            cartList.add(new CartInfoMode.fromJson(item));
            carts.add(item);
          }
//            存储缓存中
          cartString = json.encode(carts).toString();
          prefs.setString('cartInfo', cartString);

        }
      } else {
        G.toast('系统出错');
      }
    } else {
      //把cartList进行初始化，防止数据混乱
      cartList = [];
      List<Map> tempList = (json.decode(cartString.toString()) as List).cast();
      allPrice = 0;
      allGoodsCount = 0;
      isAllCheck = true;
      G.toast('获取购物车缓存数据'+ tempList.length.toString()+'条');
      if (tempList.length > 0) {
        for (var item in tempList) {
          if (item['is_selected'] == null) {
            item['is_selected'] = '0';
            item['isCheck'] = false;
            isAllCheck = false;
          } else {
            if (item['is_selected'] == '1') {
              item['isCheck'] = true;
              allPrice += (double.parse(item['goods_number'].toString()) *  double.parse(item['goods_price'].toString()));
//              allPrice += item['goods_number'] * double.parse(item['goods_price']);
            } else {
              item['isCheck'] = false;
              isAllCheck = false;
            }
          }
          cartList.add(new CartInfoMode.fromJson(item));
        }
      }
    }
    notifyListeners();
  }

  //删除单个购物车商品
  deleteOneGoods(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString('cartInfo');
    List<Map> tempList = (json.decode(cartString.toString()) as List).cast();
    int tempIndex = 0;
    int delIndex = 0;
    var goods = {'goods_id': id};
    var result = await G.req.cart.remove(goods);
    Map val = result.data;
    if (val['status'] == 0) {
      tempList.forEach((item) {
        if (item['id'] == id) {
          delIndex = tempIndex;
        }
        tempIndex++;
      });
      tempList.removeAt(delIndex);
    }
      cartString = json.encode(tempList).toString();
      prefs.setString('cartInfo', cartString); //
      await getCartInfo();

  }

  //修改选中状态
  changeCheckState(var  cartItem,context ) async {
    G.loading.show(context);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString('cartInfo');
    List<Map> tempList = (json.decode(cartString.toString()) as List).cast();

    var formData = {
      'goods_id': cartItem.id,
      'is_select': cartItem.isCheck ? 0 : 1
    };
    var result =await G.req.cart.ischeck(formData);
    Map val = result.data;
      if (val['status'] == "0") {
        tempList.map((item) {
          if (item['goodsId'] == cartItem.goodsId) {
            item['is_selected'] = cartItem.isCheck ? 0 : 1;
            item['isCheck'] = cartItem.isCheck ? false : true;
          }
          if (item['isCheck']) {
            allPrice += (item['goods_number'] * item['goods_price']);
            allGoodsCount += item['goods_number'];
          } else {
            isAllCheck = false;
          }
        });
        cartString = json.encode(tempList).toString();
        prefs.setString('cartInfo', cartString); //
        await getCartInfo();
        G.loading.hide(context);
      }else {
        G.loading.hide(context);
        G.toast(val['message']);
      }

    notifyListeners();
  }

  //点击全选按钮操作
  changeAllCheckBtnState(bool isCheck) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString('cartInfo');
    List<Map> tempList = (json.decode(cartString.toString()) as List).cast();
    List<Map> newList = [];
    for (var item in tempList) {
      var newItem = item;
      newItem['isCheck'] = isCheck;
      newList.add(newItem);
    }

    cartString = json.encode(newList).toString();
    prefs.setString('cartInfo', cartString); //
    await getCartInfo();
  }

  //增加减少数量的操作

  addOrReduceAction(var cartItem, String todo) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString('cartInfo');
    List<Map> tempList = (json.decode(cartString.toString()) as List).cast();
    int tempIndex = 0;
    int changeIndex = 0;
    var number = cartItem.goods_number;
    var goods = {
      'goods_id': cartItem.id,
      'goods_number': number+1
    };
    var result = await G.req.cart.changegoodsnumbe(goods);
    Map val = result.data;
    if(val['status']==0){
      tempList.forEach((item) {
        if (item['id'] == cartItem.id) {
          changeIndex = tempIndex;
        }
        tempIndex++;
      });
      if (todo == 'add') {
        cartItem.goods_number++;
      } else if (cartItem.goods_number > 1) {
        cartItem.goods_number--;
      }
      tempList[changeIndex] = cartItem.toJson();
      cartString = json.encode(tempList).toString();
      prefs.setString('cartInfo', cartString); //
      await getCartInfo();
    }
  }
}
