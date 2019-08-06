import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:first_flutter/Movie.dart';
import 'package:first_flutter/Tools/Star.dart';
import 'package:flutter_refresh/flutter_refresh.dart';
import 'package:first_flutter/MoviesDetail.dart';

enum MovieType { HOT, COMING }

//动态页面
class MinZhuPage extends StatefulWidget {
  @override //默认能生成属性的getter 和 setter方法
  State<StatefulWidget> createState() {
    return MinZhuPageState();
  }
}

class MinZhuPageState extends State<MinZhuPage> {
// 选择器选项
  final tabs = [
    Tab(text: '正在热映'),
    Tab(text: '即将上映'),
  ];

  // 请求地址
  String url;
  // 列表总数
  int total;
  // 数据源数组
  List _hotMovies = List();
  List _commingMovies = List();
  //选择地区
  var selectValue;
  // 即将上映选项按钮颜色
  Color _buttonTitleColor = Colors.grey;

  //默认选中第一个选项
  int select_i = 0;
  int select_j = 0;

  // 发起网络请求
  _getData(int start, int count, MovieType moviewType) async {
    Dio dio = new Dio();
    if (moviewType == MovieType.HOT) {
      url = 'https://douban-api.uieee.com/v2/movie/in_theaters';
    } else if (moviewType == MovieType.COMING) {
      url = 'https://douban-api.uieee.com/v2/movie/coming_soon';
    }
    try {
      Response response =
          await dio.get(url, queryParameters: {'start': start, 'count': count});
      //数据总量
      total = response.data['total'];
      List subjects = response.data['subjects'];
      for (var item in subjects) {
        var movie = Movie(
            item['rating'],
            item['genres'],
            item['title'],
            item['casts'],
            item['durations'],
            item['collect_count'],
            item['mainland_pubdate'],
            item['has_video'],
            item['original_title'],
            item['subtype'],
            item['directors'],
            item['pubdates'],
            item['year'],
            item['images'],
            item['alt'],
            item['id']);
        if (moviewType == MovieType.HOT) {
          _hotMovies.add(movie);
        } else {
          _commingMovies.add(movie);
        }
      }

      setState(() {});
    } catch (e) {
      print('请求失败');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getData(0, 10, MovieType.HOT);
    _getData(0, 10, MovieType.COMING);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        // 触摸收起键盘
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: DefaultTabController(
          length: tabs.length,
          child: Scaffold(
              appBar: _MyAppBar(context),
              body: TabBarView(
                children: <Widget>[_HotList(context), _ComingSoon(context)],
              ))),
    );
  }

/* *********************** AppBar *************************/

  Widget _MyAppBar(BuildContext context) {
    return AppBar(
      leading: _dropDownButton(context),
      title: Container(
        child: TextField(
            decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                icon: Icon(Icons.search),
                hintText: '电影/电视剧/影人',
                hintStyle: TextStyle(color: Colors.grey)),
            onSubmitted: (text) {
              print('$text');
            }),
      ),
      centerTitle: true,
      elevation: 0,//去掉导航条下面的阴影横线
      backgroundColor: Colors.white,
      bottom: TabBar(
        tabs: tabs,
        labelColor: Colors.black,
        unselectedLabelColor: Colors.grey,
        indicatorColor: Colors.black,
        labelStyle: TextStyle(
          fontSize: 15,
        ),
      ),
    );
  }

// 下拉选项控件

  Widget _dropDownButton(BuildContext context) {
    return DropdownButtonHideUnderline(
        child: DropdownButton(
      hint: Text('北京'),
      value: selectValue,
      items: _generateItemList(),
      onChanged: (T) {
        setState(() {
          selectValue = T;
        });
      },
    ));
  }

  List<DropdownMenuItem> _generateItemList() {
    List<DropdownMenuItem> items = new List();
    DropdownMenuItem item1 =
        new DropdownMenuItem(value: '北京', child: new Text('北京'));
    DropdownMenuItem item2 =
        new DropdownMenuItem(value: '上海', child: new Text('上海'));
    DropdownMenuItem item3 =
        new DropdownMenuItem(value: '广州', child: new Text('广州'));
    DropdownMenuItem item4 =
        new DropdownMenuItem(value: '杭州', child: new Text('杭州'));
    items.add(item1);
    items.add(item2);
    items.add(item3);
    items.add(item4);
    return items;
  }

// 下拉刷新
  Future<Null> _refresh() async {
    _hotMovies.clear();
    await _getData(0, 10, MovieType.HOT);
    return;
  }
  // 上拉加载

  Future<Null> _loadMore() async {
    // 如果数据没有全部加载
    if (_hotMovies.length < total) {
      await _getData(_hotMovies.length, 10, MovieType.HOT);
    }
    return;
  }
/* *********************** 正在热映列表 *************************/

  Widget _HotList(BuildContext context) {
    return Refresh(
        onHeaderRefresh: () {
          return _refresh();
        },
        onFooterRefresh: () {
          return _loadMore();
        },
        child: ListView.builder(
          itemCount: _hotMovies.length,
          itemBuilder: (BuildContext context, int index) {
            return HotCell(context, index, MovieType.HOT);
          },
        ));
  }

// 热映列表单元格 && 即将上映列表单元格

  Widget HotCell(BuildContext context, int index, MovieType type) {
    Movie movie;
    if (type == MovieType.HOT) {
      movie = _hotMovies[index];
    } else if (type == MovieType.COMING) {
      movie = _commingMovies[index];
    }

    // 主演
    String castsStr = '主演:';
    for (Map cast in movie.casts) {
      castsStr = castsStr + cast['name'] + '/';
    }
    // 导演
    String directorStr = '导演:';
    for (Map director in movie.directors) {
      directorStr = directorStr + director['name'] + '/';
    }

    //上映时间和当前时间比较
    bool isUpMovie;
    if (movie.mainland_pubdate.length > 0) {
      DateTime now = new DateTime.now();
      String movieTimeStr = movie.mainland_pubdate.toString();
      DateTime movieTime = DateTime.parse(movieTimeStr);
      isUpMovie = now.isAfter(movieTime);
    } else {
      isUpMovie = false;
    }

    String viewerStr;
    Color rightColor;
    String buttonText;
    if (isUpMovie) {
      rightColor = Colors.red[400];
      buttonText = '购票';
    } else {
      rightColor = Colors.orange[400];
      if (type == MovieType.HOT) {
        buttonText = '预售';
      } else {
        buttonText = '想看';
      }
    }
    int viewers = movie.collect_count;
    if (viewers > 10000) {
      if (isUpMovie) {
        //正在上映
        viewerStr = (viewers / 10000).toStringAsFixed(2) + '万人看过';
      } else {
        viewerStr = (viewers / 10000).toStringAsFixed(2) + '万人想看';
      }
    } else {
      if (isUpMovie) {
        viewerStr = viewers.toString() + '人看过';
      } else {
        viewerStr = viewers.toString() + '人想看';
      }
    }

    return GestureDetector(
      onTap: (){
        _cellClick(movie.id);
      },
      child:
      Card(
        child: Padding(
            padding: EdgeInsets.fromLTRB(10, 8, 0, 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        flex: 2,
                        child: Container(
                          child: Image.network(movie.images['small']),
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: Container(
                          padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                movie.title,
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Container(
                                height: 10,
                              ),
                              _starWidgt(context, type, index),
                              Text(
                                directorStr,
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 12.0),
                              ),
                              Text(
                                castsStr,
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 12.0),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                    flex: 1,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: Column(
                        children: <Widget>[
                          Text(
                            viewerStr,
                            style: TextStyle(color: rightColor, fontSize: 12.0),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                              width: 60,
                              height: 30,
                              child: OutlineButton(
                                onPressed: () {},
                                borderSide: BorderSide(color: rightColor),
                                child: Text(
                                  buttonText,
                                  style: TextStyle(fontSize: 12.0),
                                ),
                                textColor: rightColor,
                              ))
                        ],
                      ),
                    ))
              ],
            ))
          ));
  }

// 列表点击事件
void _cellClick (String moviewID){

    Navigator.push(context, 
      MaterialPageRoute(
        builder: (context) {
         return MoviewDetailPage(movieID: moviewID,);
        }
      )
    );
}

  // 评分星星
  Widget _starWidgt(BuildContext context, MovieType type, int index) {
    Movie movie;
    if (type == MovieType.HOT) {
      movie = _hotMovies[index];
    } else {
      movie = _commingMovies[index];
    }
    if (type == MovieType.HOT) {
      return Row(
        children: <Widget>[
          Scorestar(
            score: double.parse(movie.rating['stars']),
          ),
          Padding(padding: EdgeInsets.only(right: 10)),
          Text(movie.rating['average'].toString(),
              style: TextStyle(fontSize: 14.0, color: Colors.green[400])),
        ],
      );
    } else {
      return Container();
    }
  }

/* *********************** 即将上映列表 *************************/

  Widget _ComingSoon(BuildContext context) {
    return Container(
        child: Column(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(flex: 1, child: _SelectItemBar(context)),
        Expanded(flex: 12, child: _ComingSoonList(context)),
      ],
    ));
  }

  // 选项条
  Widget _SelectItemBar(BuildContext context) {
    return Row(children: <Widget>[
      Expanded(
          flex: 2,
          child: Container(
              color: Colors.white,
              child: Padding(
                  padding: EdgeInsets.only(right: 30),
                  child: Row(
                      children: _leftButtonList(
                          context, ['全部', '7月', '8月', '9月']))))),
      Container(
        width: 1,
        height: 20,
        color: Colors.grey,
      ),
      Expanded(
        flex: 1,
        child: Container(
            color: Colors.white,
            child: Row(children: _RightButtonList(context, ['时间', '热度']))),
      )
    ]);
  }

// 全部/ 7月 / 8月 /9月
  List _leftButtonList(BuildContext context, List<String> titles) {
    List<Widget> buttons = List();
    for (int i = 0; i < titles.length; i++) {
      buttons.add(Expanded(
          child: OutlineButton(
        textColor: i != select_i ? _buttonTitleColor : Colors.black,
        borderSide: BorderSide.none,
        color: Colors.white,
        child: Text(
          titles[i],
          style: TextStyle(fontSize: 14),
        ),
        onPressed: () {
          select_i = i;
          setState(() {});
        },
      )));
    }
    return buttons;
  }

  // 时间、热度 按钮
  List _RightButtonList(BuildContext context, List<String> titles) {
    List<Widget> buttons = List();
    for (int j = 0; j < titles.length; j++) {
      buttons.add(Expanded(
          child: OutlineButton(
        textColor: j != select_j ? _buttonTitleColor : Colors.black,
        borderSide: BorderSide.none,
        color: Colors.white,
        child: Text(
          titles[j],
          style: TextStyle(fontSize: 14),
        ),
        onPressed: () {
          select_j = j;
          setState(() {});
        },
      )));
    }
    return buttons;
  }

  Widget _ComingSoonList(BuildContext context) {
    return Refresh(
        onHeaderRefresh: () {
          return _refresh();
        },
        onFooterRefresh: () {
          return _loadMore();
        },
        child: ListView.builder(
          itemCount: _commingMovies.length,
          itemBuilder: (BuildContext context, int index) {
            return HotCell(context, index, MovieType.COMING);
          },
        ));
  }
} // state
