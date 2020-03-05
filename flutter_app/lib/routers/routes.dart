import 'package:flutter/material.dart';
import '../page/index_page.dart';
import '../page/cart_page.dart';
import '../page/logins/login_page.dart';
import '../page/logins/sigin_page.dart';
import '../page/logins/forget_page.dart';
import '../page/product/product_page.dart';

import '../page/search.dart';

final routers = {
  '/login': (context, {arguments}) => LoginPage(arguments: arguments),
  '/sigin': (context, {arguments}) => SiginPage(arguments: arguments),
  '/forget': (context, {arguments}) => ForgetPage(arguments: arguments),
  '/search': (context, {arguments}) => SearchPage(arguments: arguments),
  '/product': (context, {arguments}) => ProductPage(arguments: arguments),
  '/cart': (context) => CartPage(),
  '/': (context) => IndexPage(),
};

var  onGenerateRoute = (RouteSettings settings) {
  final String name = settings.name;
  final Function pageContentBuilder = routers[name];
  if (pageContentBuilder != null) {
    if (settings.arguments != null) {
      final Route route = MaterialPageRoute(
          builder: (context) =>
              pageContentBuilder(context, arguments: settings.arguments));
      return route;
    } else {
      final Route route = MaterialPageRoute(
          builder: (context) =>
              pageContentBuilder(context));
      return route;
    }
  }
};
