import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

class MyListView extends StatefulWidget{

  @override
  createState() => new MyListViewState();
}

class MyListViewState extends State<MyListView> {
    
    @override
    Widget build(BuildContext content) {
     
      return Scaffold(
        appBar: new AppBar(
          title: new Text('列表'),
          backgroundColor: Colors.orangeAccent,
        ),
        body: createListView(),

      );
    }
    //创建listview 

    Widget createListView() {
      return new ListView.builder(
          // itemExtent: 100.0,设置高度的属性
          itemCount: 10,
          itemBuilder: (BuildContext context, int index){
              return oneListTile();
          },
      );

    }

    Widget oneListTile(){
      return Card(
        // color: Colors.lightBlueAccent,
        margin: const EdgeInsets.all(1.0),
        child: ListTile(
          leading: Icon(Icons.beach_access),
          title: Text('我是测试标题'),
          trailing:Icon(Icons.keyboard_arrow_right)
        ),
        
      );
    }

    //   return ListTile(
    //     leading: Icon(Icons.beach_access),
    //     title: Text('我是测试标题'),
    //     trailing:Icon(Icons.keyboard_arrow_right)
    //   );
    // }

    // custorm listView
    // Widget createCustomListView(){
    //   return new ListView.custom(

    //     childrenDelegate: SliverChildDelegate(

    //     );

    //   );
    // }

}