import 'package:flutter/material.dart';
import 'package:color_dart/color_dart.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_app/utils/global.dart';
import 'package:flutter_app/page/address/city_picker.dart';
import 'package:provide/provide.dart';
import 'package:flutter_app/provide/address.dart';
import 'package:flutter_app/model/addressInfo.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class AddressPage extends StatefulWidget {
  @override
  _AddressPageState createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {

  Map  defaultConsignee = {};
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(),
      floatingActionButton: new FloatingActionButton(
        onPressed: () {
          CityPicker.showCityPicker(
            context,
            selectProvince: (province) {
              print(province);
            },
            selectCity: (city) {
              print(city);
            },
            selectArea: (area) {
              print(area);
            },
          );
        },
        child: new Icon(Icons.panorama_fish_eye),
        tooltip: '三级联动',
      ),
      body: FutureBuilder(
        future: _getAddressInfo(context),
        builder: (context, snapshot) {
          List AddressList=Provide.value<AddressProvide>(context).AddressList;
          if(snapshot.hasData && AddressList!=null){
            return Stack(
              children: <Widget>[
                Provide<AddressProvide>(
                    builder: (context,child,childCategory){
                      AddressList= Provide.value<AddressProvide>(context).AddressList;
                      if(AddressList.length==0){
                        return NullAddresss();
                      }
                      return Container(
                        padding: EdgeInsets.only(bottom: ScreenUtil().setHeight(200)),
                        child: ListView.builder(
                          itemCount: AddressList.length,
                          itemBuilder:(context,index){
                            return address(AddressList[index]);
                          },
                        ),
                      );
                    }
                ),
                Positioned(
                  bottom: 20,
                  left: 0,
                  width: ScreenUtil().setWidth(750),
                  child: Container(
                    color: hex('#ffffff'),
                    child: ButtonContent(context, () {
                      Navigator.pushNamed(context,'addAddress');
                    }, '添加地址'),
                  ),
                )
              ],
            );
          } else {
            return NullAddresss();
          }
        },
      ),
    );
  }
  Widget NullAddresss(){
    return Center(
      child:IconButton(
        icon: Icon(Icons.add),
        color: Color.fromRGBO(85, 85, 85, 1),
        padding: EdgeInsets.all(0),
        iconSize: ScreenUtil().setSp(100),
        onPressed: () {
          Navigator.pop(context);
        },
      ) ,
    );
  }
  Future<String> _getAddressInfo(BuildContext context) async {
    await Provide.value<AddressProvide>(context).getAddressInfo();
    return 'end';
  }
  // 收货地址
  Widget address(AddressInfoMode item) {
    return Container(
      color: Colors.white,
      width: ScreenUtil().setWidth(730),
      margin: EdgeInsets.fromLTRB(
          ScreenUtil().setWidth(10), 0, ScreenUtil().setWidth(10), 0),
      child: ListTile(
        onTap:(){

        },
        leading: IconButton(
          icon: Icon(
            Icons.check_circle,
            size: ScreenUtil().setSp(52),
            color:item.is_default=='1'? Color.fromRGBO(236, 56, 56, 1) : hex('#f4f4f4')
          ),
          onPressed: (){
            Provide.value<AddressProvide>(context).changeCheckState(item,context);
          },
        ),
        title: Text(
          item.consignee+'  '+item.phone ,
          maxLines: 2,
          style:
          TextStyle(color: Color.fromRGBO(48, 49, 51, 1), fontSize: ScreenUtil().setSp(32)),
        ),
        subtitle: Text(
          item.country+' '+item.province+' '+item.address +' '+item.zip_code,
          maxLines: 3,
          style: TextStyle(color: hex("#888888"), fontSize: 16.0),
          textAlign: TextAlign.left,
        ),
        trailing:IconButton(
          onPressed: (){
            Navigator.pushNamed(context, '/addAddress',arguments: {
              'id':item.id
            });
          },
          icon: Icon(
            Icons.mode_edit,
            size: ScreenUtil().setSp(35 ),
            color: Color.fromRGBO(144, 147, 153, 1),
          ),
        )
      ),
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
      margin: EdgeInsets.only(left: ScreenUtil().setWidth(40), top: ScreenUtil().setHeight(28), right: ScreenUtil().setWidth(40), bottom: ScreenUtil().setHeight(28)),
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
}

