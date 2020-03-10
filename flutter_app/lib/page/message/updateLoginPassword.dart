import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UpdateLoginPassword extends StatefulWidget {
  @override
  _UpdateLoginPasswordState createState() => _UpdateLoginPasswordState();
}

class _UpdateLoginPasswordState extends State<UpdateLoginPassword> {
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

      ),
    );
  }
}
