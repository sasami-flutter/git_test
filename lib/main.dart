import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  TextEditingController formController = TextEditingController();
  // 未了の入れ物
  
  final startBox = [];
  String startText = "";
  // 完了の入れ物
  final endBox = [];
  String endText = "";

  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 50),
            Container(
              height: 80,
              child: Form(
                key: _formkey,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 250,
                      // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~入力欄
                      child: TextFormField(
                        controller: formController,
                        
                        // onChanged: (String value) {
                        // },
                        // 入力されたテキストの値を受け取る（valueが入力されたテキスト）
                      //   onChanged: (text) {
                      // startText = text;},
                        decoration: InputDecoration(
                          labelText: "リスト名追加",
                          border: OutlineInputBorder(),
                          hintText: ('リスト名を入力してください'),
                          hintStyle: TextStyle(
                            fontSize: 14,
                            fontWeight:FontWeight.bold,
                            color: Colors.grey
                          ),
                        ),
                        validator: (value){
                          // 空欄の際に注意喚起をする
                          if (value == null || value.isEmpty) {
                            return '必須項目が入力されていません';
                          }
                            return null;
                        },
                      ),
                    ),
                    SizedBox(width: 30),
                    SizedBox(
                      height: 65,
                      width: 65,
                      // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~追加ボタン
                      child: ElevatedButton(
                        onPressed: () {
                          if(_formkey.currentState!.validate()){
                            // .textをつけないと赤字のエラーになる。
                            startBox.add(formController.text);
                            final input = formController.text;
                            // 記入したテキストを下に表示する（確認用に一応つける）
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('$inputを保存しました')),
                            );
                          }
                          setState(() {});
                          // 入力後TextField内をクリア
                          formController.clear();
                        },
                        child: Text('追加',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight:FontWeight.bold
                          ),
                        ),
                      ),
                    ),
                  ]
                ),
              ),
            ),
            SizedBox(height: 5),
            Text('未了の予定',
              style: TextStyle(
                fontSize: 20,
                fontWeight:FontWeight.bold,
              ),
            ),
            
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue),
                borderRadius: BorderRadius.circular(10),
              ),
              width: 350,
              height: 280,
              child: Padding(
                padding: const EdgeInsets.only(top: 3,bottom: 3),
                child: ListView.builder(
                  itemCount: startBox.length,
                  itemBuilder: (context, index) {
                    final box = startBox[index];
                    // 入れたテキストを反転
                    // final item = startBox.reversed.toList()[index];
                    return Card(
                      child: ListTile(
                        title: Text(box),
                        trailing: Wrap(
                          children: [
                            // ゴミ箱ボタンの設置、わかりやすいように青に変更
                            IconButton(
                                icon: Icon(Icons.delete_outline_outlined,color: Colors.blue),
                                onPressed: () {
                                  // 削除
                                  startBox.removeAt(index);
                                  setState(() {});
                                }
                            ), 
                            //完了移動ボタン
                            IconButton(
                                icon: Icon(Icons.check_circle_outline,color: Colors.red),
                                onPressed: () {
                                  //endBoxにstartBoxに入っていたデータを渡す。その後startBoxの中身を削除する。
                                  endBox.add(startBox[index]);
                                  startBox.removeAt(index);
                                  setState(() {});
                                }
                            ),       
                          ],
                        ),
                      ),
                    );
                  }
                ),
              ),
            ),
            SizedBox(height: 20),
            Text('完了した予定',
              style: TextStyle(
                fontSize: 20,
                fontWeight:FontWeight.bold,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue),
                borderRadius: BorderRadius.circular(10),
              ),
              width: 350,
              height: 280,
              child: Padding(
                padding: const EdgeInsets.only(top: 3,bottom: 3),
                child: ListView.builder(
                  itemCount: endBox.length,
                  itemBuilder: (context, index) {
                    final box = endBox[index];
                    return Card(
                      child: ListTile(
                        title: Text(box),
                        trailing: Wrap(
                          children: [
                            // 上記のゴミ箱ボタンと同じデザイン
                            IconButton(
                              icon: Icon(Icons.delete_outline_outlined,color: Colors.blue),
                              onPressed: () {
                                endBox.removeAt(index);
                                setState(() {});
                              }
                            ),       
                          ],
                        ),
                      ),
                    );
                  }
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// コミットすんぞ〜