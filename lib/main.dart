import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home:  MyHomePage(title: 'Sudoko')
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body: Container (
        alignment: Alignment.center,
        child: Column(
          children: [
            Expanded(
              child:
              GridView.count(
                  crossAxisCount: 9,
                  children: List.generate(81, (index) {
                    return Center(
                      child: Text('this is '),
                    );
                  })
              ),
            ),
            Row(
              children: [
                ElevatedButton(onPressed: (){}, child: Text('Enter'))
              ],
            ),

          ],

        ),
      )




           // This trailing comma makes auto-formatting nicer for build methods.
    );

  }
}
