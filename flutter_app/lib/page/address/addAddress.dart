import 'package:flutter/material.dart';
import 'package:flutter_app/model/addressInfo.dart';
import 'package:flutter_app/utils/global.dart';
import 'package:color_dart/color_dart.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import 'package:flutter_app/provide/address.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class AddAddress extends StatefulWidget {
  Map arguments;

  AddAddress({Key key, this.arguments}) : super(key: key);

  @override
  _AddAddressState createState() => _AddAddressState(arguments: this.arguments);
}

class _AddAddressState extends State<AddAddress> {
  Map arguments;
  var consignee = "";
  var xing = TextEditingController();
  var username = TextEditingController();
  var phone = TextEditingController();
  var country_index = "0";
  var country = "";
  var province_index = "0";
  var province = "";
  var city_index = "0";
  var city = "";
  var address = TextEditingController();
  var is_default = "0";
  var zip_code = TextEditingController();

  _AddAddressState({this.arguments});

  void initAddress(BuildContext context) async {
    var id = int.parse(this.arguments['id']);
    if (id > 0) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var addressString = prefs.getString('addressInfo');
      List<Map> tempList =
          (json.decode(addressString.toString()) as List).cast();
      for (var item in tempList) {
        if (item['id'] == id.toString()) {
          setState(() {
            this.consignee = item['consignee'];
            this.xing.text = item['consignee'].split("_")[0];
            this.username.text = item['consignee'].split("_")[1];
            this.phone.text = item['phone'];
            this.country_index = item['country_index'];
            this.country = item['country'];
            this.province_index = item['province_index'];
            this.province = item['province'];
            this.city_index = item['city_index'];
            this.city = item['city'];
            this.address.text = item['address'];
            this.is_default = item['is_default'];
            this.zip_code.text = item['zip_code'];
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '设置',
          style: TextStyle(
            color: Color.fromRGBO(106, 106, 106, 1),
          ),
        ),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Color.fromRGBO(85, 85, 85, 1),
          padding: EdgeInsets.all(0),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
          child: ListView(
        children: <Widget>[
          SizedBox(
            height: ScreenUtil().setHeight(20),
          ),
          Container(
            color: hex("#ffffff"),
            padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(20),
                ScreenUtil().setWidth(0), ScreenUtil().setWidth(20), 0),
            child: TextField(
              decoration: InputDecoration(hintText: '姓氏'),
              controller: this.xing,
              onChanged: (value) {
                setState(() {
                  this.xing.text = value;
                });
              },
            ),
          ),
          Container(
            color: hex("#ffffff"),
            padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(20),
                ScreenUtil().setWidth(0), ScreenUtil().setWidth(20), 0),
            child: TextField(
              controller: this.username,
              decoration: InputDecoration(hintText: '名字'),
              onChanged: (value) {
                setState(() {
                  this.username.text = value;
                });
              },
            ),
          ),
          Container(
            color: hex("#ffffff"),
            padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(20),
                ScreenUtil().setWidth(0), ScreenUtil().setWidth(20), 0),
            child: TextField(
              controller: this.phone,
              decoration: InputDecoration(hintText: '手机号码'),
              onChanged: (value) {
                setState(() {
                  this.phone.text = value;
                });
              },
            ),
          ),
          Container(
            color: hex("#ffffff"),
            padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(20),
                ScreenUtil().setWidth(0), ScreenUtil().setWidth(20), 0),
            child: TextField(
              controller: this.address,
              decoration: InputDecoration(hintText: '地址'),
              onChanged: (value) {
                setState(() {
                  this.address.text = value;
                });
              },
            ),
          ),
          Container(
            color: hex("#ffffff"),
            padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(20),
                ScreenUtil().setWidth(0), ScreenUtil().setWidth(20), 0),
            child: TextField(
              controller: this.zip_code,
              decoration: InputDecoration(hintText: '邮政编码'),
              onChanged: (value) {
                setState(() {
                  this.zip_code.text = value;
                });
              },
            ),
          ),
          ButtonContent(context, () async{
            G.loading.show(context);
            var consignee = this.xing.text + '_' + this.username.text;
            var data1 = {
              'consignee': consignee,
              'phone': this.phone.text,
              'country_index': this.country_index,
              'country': this.country,
              'province_index': this.province_index,
              'province': this.province,
              'city_index': this.city_index,
              'city': this.country_index,
              'address': this.address.text,
              'is_default': this.is_default,
              'zip_code': this.zip_code.text,
            };
            var result =await G.req.address.addConsignee(data1);
            Map val = result.data;
            if(val['status']==0){
              await Provide.value<AddressProvide>(context).save();
              G.toast(val['messages']);
              Navigator.pop(context);
            }else {
              G.toast(val['messages']);
            }
            G.loading.hide(context);

          }, '添加地址'),
        ],
      )),
    );
  }

  //  按钮生成
  Widget ButtonContent(BuildContext context, Function tap, String buttontext) {
    return Container(
      width: ScreenUtil().setWidth(750),
      height: ScreenUtil().setHeight(85),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(65.0),
      ),
      margin: EdgeInsets.only(
          left: ScreenUtil().setWidth(40),
          top: ScreenUtil().setHeight(28),
          right: ScreenUtil().setWidth(40),
          bottom: ScreenUtil().setHeight(28)),
      child: RaisedButton(
        onPressed: () {
          tap();
        },
        elevation: 12,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        color: Color.fromRGBO(236, 56, 56, 1),
        child: Text(
          buttontext,
          style: TextStyle(
            color: Colors.white,
            fontSize: ScreenUtil().setSp(36),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      initAddress(context);
    });
  }
}
