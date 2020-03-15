import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_app/model/addressInfo.dart';
import 'dart:convert';
import 'package:flutter_app/utils/global.dart';

class AddressProvide with ChangeNotifier {
  String addressString = "[]";
  List<AddressInfoMode> AddressList = []; //商品列表对象
  AddressInfoMode address;
//  添加购物车后再次查询
  save() async {
    //初始化SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //获得购物车中的商品,这时候是一个字符串
    addressString = prefs.getString('addressInfo');
    //判断得到的字符串是否有值，如果不判断会报错
    var result = await G.req.address.getconsignee();
    Map val = result.data;
    if (val['status'] == "0") {
      AddressList = [];
      if (val['data'].length > 0) {
        //把AddressList进行初始化，防止数据混乱
        AddressList  = val['data'] ;
        addressString = json.encode(AddressList).toString();
        prefs.setString('addressInfo', addressString);
      }
    } else {
      G.toast('系统出错');
    }
    notifyListeners();
  }
  //获取收货地址
  getAddressInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //获得地址,这时候是一个字符串
    addressString = prefs.getString('addressInfo');
    //判断得到的字符串是否有值，如果不判断会报错
    AddressList = [];
    List<Map> addresss = [];

    if (addressString == null) {
      var result = await G.req.address.getconsignee();
      Map val = result.data;
      print(val['data']['consignee']);
      if (val['status'] == 0) {
        AddressList = [];
        if (val['data']['consignee'].length > 0) {
          //把AddressList进行初始化，防止数据混乱
          for (var item in val['data']['consignee']) {
            AddressList.add(new AddressInfoMode.fromJson(item));
            addresss.add(item);
          }
          addressString = json.encode(addresss).toString();
          prefs.setString('addressInfo', addressString);
        }
      } else {
        G.toast('系统出错');
      }
    } else {
      //把AddressList进行初始化，防止数据混乱
      AddressList = [];
      List<Map> tempList = (json.decode(addressString.toString()) as List).cast();

      G.toast('获取购物车缓存数据'+ tempList.length.toString()+'条');
      if (tempList.length > 0) {
        for (var item in tempList) {
          AddressList.add(new AddressInfoMode.fromJson(item));
        }
      }
    }
    notifyListeners();
  }

  //删除收货地址
  deleteOneGoods(String id, context ) async {
    G.loading.show(context);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    addressString = prefs.getString('addressInfo');
    List<Map> tempList = (json.decode(addressString.toString()) as List).cast();
    int tempIndex = 0;
    int delIndex = 0;
    var goods = {'goods_id': id};
    var result = await G.req.address.delConsignee(goods);
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
      addressString = json.encode(tempList).toString();
      prefs.setString('addressInfo', addressString); //
      await getAddressInfo();
      G.loading.hide(context);
      G.toast(val['messages']);

  }

  //修改选中状态
  changeCheckState(var  addressItem,context ) async {
    G.loading.show(context);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    addressString = prefs.getString('addressInfo');
    List<Map> tempList = (json.decode(addressString.toString()) as List).cast();

    var formData = {
      'id': addressItem.id,
      'is_default':1
    };
    var result =await G.req.address.ChangeDefault(formData);
    Map val = result.data;
      if (val['status'] == 0) {
          for (var i = 0; i<tempList.length; i++) {
            if (tempList[i]['id'] == addressItem.id) {
              tempList[i]['is_default'] =  '1';
            }else {
              tempList[i]['is_default'] = '0';
            }
          }
        addressString = json.encode(tempList).toString();
        prefs.setString('addressInfo', addressString); //
        await getAddressInfo();
        G.loading.hide(context);
        G.toast(val['messages']);
      }else {
        G.loading.hide(context);
        G.toast(val['messages']);
      }
  }

}
