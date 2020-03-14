import 'package:flutter/material.dart';
import 'package:flutter_app/utils/global.dart';
import 'package:flutter_app/config/common.dart';
import 'package:color_dart/color_dart.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class payPage extends StatefulWidget {
  Map arguments;

  payPage({Key key, this.arguments}) : super(key: key);

  @override
  _payPageState createState() => _payPageState(arguments: this.arguments);
}

class _payPageState extends State<payPage> {
  Map arguments;

  var end_time = 0;

  String goods_type = '0';
  String order_money = '0.00';

  _payPageState({this.arguments});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            '支付方式',
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
          width: ScreenUtil().setWidth(750),
          padding: EdgeInsets.fromLTRB(
              ScreenUtil().setWidth(10),
              ScreenUtil().setWidth(10),
              ScreenUtil().setWidth(10),
              ScreenUtil().setWidth(10)),
          child: ListView(
            children: <Widget>[
              Text(
                tranFrom(order_money),
                style: TextStyle(
                    color: hex('#ec3838'), fontSize: ScreenUtil().setSp(32)),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    '剩余支付时间',
                    style: TextStyle(
                        color: hex('#222222'),
                        fontSize: ScreenUtil().setSp(28)),
                  ),
                  Text(
                    '08:02:00',
                    style: TextStyle(
                        color: hex('#ec3838'),
                        fontSize: ScreenUtil().setSp(28)),
                  )
                ],
              ),
              listPay(),
            ],
          ),
        ));
  }

  Row listPay() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          width: ScreenUtil().setWidth(220),
          child: Image.network(
            'https://panda36.com/static/panda36/assets/img/m/pay/paypal.jpg',
            width: ScreenUtil().setWidth(200),
          ),
        ),
        IconButton(
            icon: Icon(Icons.arrow_back),
            color: Color.fromRGBO(85, 85, 85, 1),
            padding: EdgeInsets.all(0),
            onPressed: () {

            },
        ),
      ],
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initpay(context);
  }

//  获取支付信息
  initpay(BuildContext context) async {
    var data = {'order_sn': arguments['order_sn']};
    try {
      var result = await G.req.order.step3(data);
      Map val = result.data;
      if (val['status'] == 0) {
        setState(() {
          this.end_time = val['data']['end_time'];
          this.goods_type = val['data']['goods_type'];
          this.order_money = val['data']['order_money'];
        });
      } else {
        G.toast(val['messages']);
      }
    } catch (e) {
      print(e);
      G.toast('错误');
    }
  }
}
