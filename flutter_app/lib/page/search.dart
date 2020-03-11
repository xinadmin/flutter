import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  @override


  SearchPageState createState() =>
      new SearchPageState();
}

class SearchPageState extends State<SearchPage> {
  @override

  SearchPageState();

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('搜索'),
        backgroundColor: Color.fromRGBO(236, 56, 56, 1),
      ),
      body: Container(
        child: FloatingActionButton(
          child: Text("asd"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
    );
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
  void didUpdateWidget(SearchPage oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
}
