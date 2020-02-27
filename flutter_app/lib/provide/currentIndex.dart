import 'package:flutter/material.dart';

class CurrentIndexProvide with ChangeNotifier{
  int currentIndex=0;
  bool isLogin=false;
  int specIndex=0;
  var userinfo;
  changeIndex(int newIndex){
    currentIndex=newIndex;
    notifyListeners();
  }
  changelogin(){
    isLogin=true;
  }
  changeSpecIndex(int newIndex){
    specIndex=newIndex;
    notifyListeners();
  }
  changeUserinfo(var Userinfo){
    print(Userinfo);
    userinfo=Userinfo;
    isLogin=true;
    notifyListeners();
  }
}