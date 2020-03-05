import 'package:flutter/material.dart';
import '../service/service_method.dart';
class CurrentIndexProvide with ChangeNotifier{
  int currentIndex=0;
  bool isLogin=false;
  int specIndex=0;
  var userinfo;
  changeIndex(int newIndex){
    currentIndex=newIndex;
    notifyListeners();
  }
  changelogin(item){
    isLogin=item;
  }
  changeSpecIndex(int newIndex){
    specIndex=newIndex;
    notifyListeners();
  }
  getUserInfo() async{
    await request('User-Profile-index').then((val) {
      if (val['status'] == 0) {
        userinfo = val['data']["user"];
        isLogin=true;
      }
    });
  }
  // changeUserinfo(var Userinfo){
  //   userinfo=Userinfo;
  //   isLogin=true;
  //   notifyListeners();
  // }
}