import 'package:flutter/material.dart';
import 'package:todoapp/models/item.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'TodoApp'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _textEditingController = TextEditingController();


  List<Item> items = [
    Item('Make coffee'),
    Item('Go shopping'),
    Item('Feed the cat'),
  ];
  _onAddItemPressed() {
    _scaffoldKey.currentState.showBottomSheet<Null>((BuildContext context) {
      return Container(
        decoration: BoxDecoration(color: Colors.blueGrey),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(32.0, 50.0, 32.0, 32.0),
          child: TextField(
            controller: _textEditingController,
            decoration: InputDecoration(
              hintText: 'Add a Task',
            ),
            onSubmitted: _onSubmit,
          ),
        ),
      );
    });
  }

  _onDeleteItem(item) {
    items.removeAt(item);
    setState(() {});
  }

  _onSubmit(String s) {
    if (s.isNotEmpty) {
      items.add(Item(s));
      _textEditingController.clear();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Todo'),
      ),
      body: Container(
          child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    '${items[index].title}',
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => _onDeleteItem(index),
                  ),
                );
              })),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _onAddItemPressed(),
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
