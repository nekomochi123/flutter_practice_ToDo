import 'package:flutter/material.dart';

// エントリーポイントのmain関数
void main() {
  // MyAppを呼び出す
  runApp(const MyApp());
}
// MyAppのクラス、アプリ全体の共通テーマなど決まる
// アプリのエントリーポイントのmain内でMaterialAppウィジェットを生成し、アプリ構造を構築
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // タイトルとテーマを設定する。画面の本体はMyHomePageで作る。
    return MaterialApp(
      title: 'Flutter practice',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
      home: const MyHomePage(title: "flutter practice"),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Task型のオブジェクトを格納するための空のリスト
  final _taskList = <Task>[];
  final _td = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // MyHomePageの画面を構築する部分、一般的なUIコンポネートを追加できる
    return Scaffold(
      // 画面上部のタイトル部分
      appBar: AppBar(
          title: Text(widget.title, style: Theme
              .of(context)
              .textTheme
              .headlineMedium),
          backgroundColor: Theme
              .of(context)
              .primaryColorLight
      ),
      body: Center(
        //  表示する項目に仕切りをつけることができる
        child: ListView.separated(
          itemBuilder: (context, index) =>
              CheckboxListTile(
                title: Text(_taskList[index].value,
                  //　打ち消し線の装飾判定
                  style: TextStyle(
                      decoration:_taskList[index].check ? TextDecoration
                          .lineThrough : null
                  ),
                ),
                value: _taskList[index].check,
                onChanged: (bool? checkedValue) {
                  setState(() {
                  if(checkedValue != null){
                    final value = _taskList[index].value;
                    _taskList[index] = Task(value: value, check:  checkedValue);
                  }
                  });
                },
              ),
          separatorBuilder: (context, index) {
            return const Divider(height: 0.5);
          },
          itemCount: _taskList.length,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: TextField(
                  controller: _td,
                  decoration: InputDecoration(
                    hintText: 'ここにタスクを入力',
                  ),
                ),
                title: Text('Add Task'),
                actions: <Widget>[
                  TextButton(
                    child: Text('cancel'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                    child: Text('OK'),
                    onPressed: () {
                      setState(() {
                        _taskList.add(Task(value:_td.text, check: false));
                      });
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class Task {
  const Task({required this.value, required this.check});

  final String value;
  final bool check;
}