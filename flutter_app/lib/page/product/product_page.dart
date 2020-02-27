import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import '../../provide/details_info.dart';
import 'product_banner.dart';
import 'product_detail.dart';
import 'product_bottom.dart';

import '../../config/common.dart';
class ProductPage extends StatefulWidget {
  @override
  Map arguments;

  ProductPage({Key key, this.arguments}) : super(key: key);

  ProductPageState createState() =>
      new ProductPageState(arguments: this.arguments);
}

class ProductPageState extends State<ProductPage> {
  Map arguments;

  ProductPageState({this.arguments});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              print('返回上一页');
              Navigator.pop(context);
            },
          ),
          title: Text('商品详细页'),
        ),
        body: FutureBuilder(
            future: _getBackInfo(context),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Stack(
                  children: <Widget>[
                    ListView(
                      children: <Widget>[
                        ProductBanner(),
                        ProductDeatail(),
//                        DetailsTopArea(),
//                        DetailsExplain(),
//                        DetailsTabBar(),
//                        DetailsWeb(),
                      ],
                    ),
                    Positioned(
                        bottom: 15,
                        left: 0,
                        child: DetailsBottom()
                    )
                  ],
                );
              } else {
                return Container(
                  child: Column(
                    children: <Widget>[
                      AspectRatio(
                        aspectRatio: 1,
                        child: Image.network(
                          'https://panda36.com/static/panda36/assets/img/m/panda.png',
                          fit: BoxFit.fill,
                        ),
                      ),
                    ],
                  ),
                );
                Text('加载中........');
              }
            }));
  }

  Future _getBackInfo(BuildContext context) async {
    await Provide.value<DetailsInfoProvide>(context)
        .getGoodsInfo(this.arguments != null ? this.arguments['goodsId'] : "");
    return '完成加载';
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

  }

  @override
  void didUpdateWidget(ProductPage oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);

  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();


  }
}
