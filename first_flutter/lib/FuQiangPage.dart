import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FuQiangPage extends StatefulWidget {

    @override
      State<StatefulWidget> createState() {

        return FuQiangState();
      }
}

class FuQiangState extends State<FuQiangPage> {

//创建MethodChannel
  // flutter_and_native_101 为通信标识
  // StandardMessageCodec() 为参数传递的 编码方式
  static const methodChannel = const MethodChannel('flutter_and_native_ios');
  //封装 Flutter 向 原生中 发送消息 的方法 
  //method 为方法标识
  //arguments 为参数
  static Future<dynamic> invokNative(String method, {Map arguments}) async {
    if (arguments == null) {
      //无参数发送消息
      return await methodChannel.invokeMethod(method);
    } else {
      //有参数发送消息
      return await methodChannel.invokeMethod(method, arguments);
    }
  }

String content = '富强';


final myTabs = [Tab(text: "体育",), Tab(text: "财经",)];
  @override
  Widget build(BuildContext context) {
      
      return Scaffold(
        appBar:AppBar( title:Text('富强'),centerTitle: true,backgroundColor: Colors.redAccent,
                actions: getNavigationBarItem(context),
        ),
        body: Center(
          child: Text(
                    content,
                    style:TextStyle(
                    color: Colors.deepOrangeAccent,
                    fontSize: 33.0,
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.italic,
                      letterSpacing: 5.0,
                     wordSpacing: 11.0,
//                  height: 6.0,
//                    decoration: TextDecoration.overline,
//                    decorationColor: Color.fromARGB(255, 22, 33, 88),
                    ) ,
                maxLines: 3,
                textAlign: TextAlign.center,
              )
        ),
        
      );
    }

// 导航条按钮
List<Widget> getNavigationBarItem (BuildContext context) {
  List<Widget> items = new List();
  Widget firstItem = new IconButton(icon: new Icon(Icons.ac_unit),
              onPressed: (){
                 invokNative("test")
                    ..then((result) {
        //第一种 原生回调 Flutter 的方法
        //此方法只能使用一次
                int code = result["code"];
                String message = result["message"];
              setState(() {
                 content = "你今天走了$message ";
        });
   });


              },
              color: Colors.blue,
            );
  Widget secondItem = new IconButton( icon: new Icon(Icons.access_alarm),
              onPressed: (){
                
              },
              color: Colors.orangeAccent,
            );
  items.add(firstItem);
  items.add(secondItem);
  return items;
}


}

