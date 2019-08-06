import 'package:flutter/material.dart';
import 'package:first_flutter/MoiveDetailModel.dart';
import 'package:dio/dio.dart';
import 'package:first_flutter/Tools/Star.dart';
import 'package:first_flutter/MoviePalyer.dart';

class MoviewDetailPage extends StatefulWidget {
  final movieID;
  // 重构构造函数 接收电影ID
  MoviewDetailPage({Key key, @required this.movieID}) : super(key: key);

  @override
  _MoviewDetailPageState createState() => _MoviewDetailPageState();
}

class _MoviewDetailPageState extends State<MoviewDetailPage> {
  
  //简介默认不展开
  bool _isOpen = false;

  //数据模型
  MovieDetailModel model;
  // 网络请求
  _getData(String movieID) async {
    Dio dio = new Dio();
    try {
      Response response = await dio
          .get('https://douban-api.uieee.com/v2/movie/subject/' + movieID);
      MovieDetailModel movieDetailModel =
          MovieDetailModel.fromJson(response.data);
      this.model = movieDetailModel;
      setState(() {});
    } catch (e) {
      print('****请求失败***');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getData(widget.movieID);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.orangeAccent,
        appBar: AppBar(
          backgroundColor: Colors.orangeAccent,
          elevation: 0, //去掉导航条下面的阴影横线
          title: Text(model != null ? model.title : ''),
        ),
        body: Container(
          child: ListView(
            // 这里用一个list装载内部的子widget 方便可以滑动
            children: <Widget>[
              _backImage(),
              _introduction(),
              _lookButton(),
              model != null ? _introductionContent() : Container(),
              model != null ? _trailer() : Container(),
              
            ],
          ),
          color: Color.fromARGB(255, 253, 245, 230),
        ));
  }

// 大图
  Widget _backImage() {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
      color: Colors.orangeAccent,
      height: 300,
      child: model == null ? Container() : Image.network(model.images['small']),
    );
  }

// 电影名信息和评分卡片
  Widget _introduction() {
    return Padding(
      padding: EdgeInsets.fromLTRB(18, 8, 8, 8),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: _nameText(),
          ),
          Expanded(
            flex: 1,
            child: Container(),
          ),
          Expanded(
            flex: 2,
            child: _croseCard(),
          ),
        ],
      ),
    );
  }

  Widget _nameText() {
    String typeStr = '';
    if (model != null) {
      for (var i = 0; i < model.tags.length; i++) {
        String type = model.tags[i];
        typeStr = typeStr + type + '/';
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          model != null ? model.title : '',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
        Text(
          typeStr,
          style: TextStyle(fontSize: 12),
        ),
        Text(
          '电影时长:' + (model != null ? model.durations.first : ''),
          style: TextStyle(fontSize: 12),
        )
      ],
    );
  }

  //评分卡片
  Widget _croseCard() {
    return AspectRatio(
      aspectRatio: 1 / 1, // 长宽比例1：1
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              '豆瓣评分',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            Text(
              model != null ? model.rating['average'].toString() : '',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            ),
            Scorestar(
              score: double.parse(model != null ? model.rating['stars'] : '0'),
            ),
            Text(model != null ? model.collect_count.toString() + '人' : '',
                style: TextStyle(fontSize: 12, color: Colors.grey))
          ],
        ),
      ),
    );
  }

// 想看 看过

  Widget _lookButton() {
    return Padding(
        padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: OutlineButton(
                onPressed: () {},
                child: Text('想看'),
                textColor: Colors.orangeAccent,
                borderSide: BorderSide(color: Colors.orangeAccent),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(),
            ),
            Expanded(
              flex: 6,
              child: OutlineButton(
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('看过'),
                    Icon(
                      Icons.star_border,
                      color: Colors.orangeAccent,
                      size: 15,
                    ),
                    Icon(Icons.star_border,
                        color: Colors.orangeAccent, size: 15),
                    Icon(Icons.star_border,
                        color: Colors.orangeAccent, size: 15),
                    Icon(Icons.star_border,
                        color: Colors.orangeAccent, size: 15),
                    Icon(Icons.star_border,
                        color: Colors.orangeAccent, size: 15),
                  ],
                ),
                textColor: Colors.orangeAccent,
                borderSide: BorderSide(color: Colors.orangeAccent),
              ),
            ),
          ],
        ));
  }

// 预告片
  Widget _trailer() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(10, 20, 0, 0),
            child: Text('预告片',style:TextStyle(fontSize: 17,color: Colors.grey)),
          ),
          SizedBox(
            height: 120,
            child: ListView.builder(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              scrollDirection: Axis.horizontal,
              itemCount: model.trailers.length,
              itemBuilder: (BuildContext context, int index) {
                return _trailer_cards(index);
              },
            ),
          )
        ]);
  }

  Widget _trailer_cards(int index) {
    Map dataMap = model.trailers[index];
    return Row(
      children: <Widget>[
        GestureDetector(
            onTap: () {
              Navigator.push(context, PageRouteBuilder(pageBuilder:
                  (BuildContext context, Animation animation,
                      Animation secondaryAnimation) {
                return ScaleTransition(
                    scale: animation,
                    alignment: Alignment.bottomCenter,
                    child: MoviewPlayerPage(
                      movieURL: dataMap['resource_url'],
                    ));
              }));
            },
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Image.network(dataMap['medium']),
                Positioned(
                  child: Icon(
                    Icons.live_tv,
                    color: Colors.white,
                    size: 40,
                  ),
                )
              ],
            )),
        SizedBox(
          width: 10,
        )
      ],
    );
  }

// 简介

  Widget _introductionContent() {
    String _tintText;
    Widget _contentWidget;
    if(_isOpen) {
      _tintText = '收起';
      _contentWidget = Text(model != null ? model.summary : '');
    }else{
      _tintText = '展开';
      _contentWidget = Container(height: 40,child: Text(model != null ? model.summary : ''),);
    }
    return Padding(
        padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('简介',style: TextStyle(fontSize: 17,color: Colors.grey),),
            Container(height: 10,),
            _contentWidget,
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  width: 60,
                  child: 
                  FlatButton(
                  child: Text(_tintText,style: TextStyle(fontSize: 14,color: Colors.green.shade800),),
                  onPressed: (){
                    _isOpen = !_isOpen;
                    setState(() {});
                  },
                )
                ,)
                
              ],
            )
          ],
        ));
  }
} //state
