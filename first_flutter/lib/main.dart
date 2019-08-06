import 'package:flutter/material.dart';
import 'package:first_flutter/listviewPage.dart';
import 'package:first_flutter/minZhuPage.dart';
import 'package:first_flutter/wenMingPage.dart';
import 'package:first_flutter/heXiePage.dart';
import 'package:first_flutter/FuQiangPage.dart';


void main()=>runApp(MyApp());

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // 此刻的上下文环境中，是不存在 Navigator部件的，在这个context上下文环境中Navigator.pushNamed返回null
    return MaterialApp(
      routes: {'/listviewPage':(BuildContext context)=> new MyListView()},
      title: "欢迎练习",
      home: MainWidgt(),
    );

  }

}

class MainWidgt extends StatefulWidget{
  
   @override
   createState() => new MainWidgtgtState();
}

class MainWidgtgtState extends State<MainWidgt> {
  //当前选中页
  var _currentIndex = 0;
  // 页面存储
  final _pages = [new FuQiangPage(), new MinZhuPage(),new WenMingPage(),new HeXiePage()];

  var bottomItemTitles = ['热点资讯','正在售票','热门影评','票房榜'];

  Text getTabTitle(int index) {
    if(index == _currentIndex){
      return new Text(bottomItemTitles[index],style: TextStyle(color: Colors.redAccent));
    }else{
      return new Text(bottomItemTitles[index],style: TextStyle(color: Colors.grey));

    }

  }
  // bottm item 图片
  var bottomItemImages;
  Image getTabImage(path){
    return new Image.asset(path,width: 24.0,height: 24.0,);
  }
  void initData(){
    bottomItemImages = [[getTabImage('images/jinli.png'),getTabImage('images/jinli_select.png')],
                        [getTabImage('images/chunlian.png'),getTabImage('images/chunlian_select.png')],
                        [getTabImage('images/denglong.png'),getTabImage('images/denglong_select.png')],
                        [getTabImage('images/bianpao.png'),getTabImage('images/bianpao_select.png')],
                       ];
  }

  Image getTabIcon(int index) {

    if(index == _currentIndex) {
      return bottomItemImages[index][1];
    }else {
      return bottomItemImages[index][0];
    }
  }

  @override
  

  Widget build(BuildContext context) {
    // 初始化数据
    initData();
    return Scaffold(
      
        body: _pages[_currentIndex],
        bottomNavigationBar: new BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: <BottomNavigationBarItem>[
            new BottomNavigationBarItem(
                icon:getTabIcon(0),
                title:getTabTitle(0),
                backgroundColor: Colors.greenAccent
            ),
            new BottomNavigationBarItem(
                icon:getTabIcon(1),
                title:getTabTitle(1),
                backgroundColor: Colors.greenAccent
            ),
            new BottomNavigationBarItem(
                icon:getTabIcon(2),
                title: getTabTitle(2),
                backgroundColor: Colors.greenAccent
            ),
            new BottomNavigationBarItem(
                icon:getTabIcon(3),
                title: getTabTitle(3),
                backgroundColor: Colors.greenAccent
            )

          ],

        currentIndex: _currentIndex,

        onTap: (index){
          setState((){
            _currentIndex = index;
          });
        },

        ),

      );
  }

}
