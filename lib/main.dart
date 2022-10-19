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
        home: MyHomePage(title: 'Sudoko'));
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
  final snack = SnackBar(content: Text("Just to test inkwell"));
  @override
  Widget build(BuildContext context) {
    final thecontroller = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SafeArea(
          child: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(20),
              // height: 400,
              color: Colors.grey,
              padding: EdgeInsets.all(5),
              width: double.maxFinite,
              alignment: Alignment.center,
              child: GridView.builder(
                itemCount: 9,
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                      color: Colors.white,
                      alignment: Alignment.center,
                      child: GridView.builder(
                        itemCount: 9,
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 1,
                          crossAxisSpacing: 2,
                          mainAxisSpacing: 2,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                              margin: EdgeInsets.all(3),
                              color: Colors.grey.shade300,
                              alignment: Alignment.center,
                              child: InkWell(
                                onTap: () {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snack);
                                },
                                child: Container(
                                  child: TextField(
                                    textAlign: TextAlign.center,
                                    controller: thecontroller,
                                    //enabled: false,
                                    decoration: InputDecoration(
                                      labelText: thecontroller.text,
                                    ),
                                  ),
                                ),
                              ));
                        },
                      ));
                },
              ),
            ),
            // Expanded(
            //   child: Container(
            //     decoration: BoxDecoration(color: Colors.grey),
            //     child: GridView.builder(
            //       itemCount: 9,
            //       shrinkWrap: true,
            //       scrollDirection: Axis.vertical,
            //       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //         crossAxisCount: 3,
            //         childAspectRatio: 1,
            //         crossAxisSpacing: 5,
            //         mainAxisSpacing: 5,
            //       ),
            //       physics: ScrollPhysics(),
            //       itemBuilder: (buildContext, index) {
            //         return ElevatedButton(
            //           onPressed: () {},
            //           child: Text(
            //             "${index + 1}",
            //             style: TextStyle(color: Colors.black),
            //           ),
            //           style: ButtonStyle(
            //             backgroundColor:
            //                 MaterialStateProperty.all<Color>(Colors.white),
            //           ),
            //         );
            //       },
            //     ),
            //   ),
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(onPressed: () {}, child: Text('Enter')),
                ElevatedButton(
                  onPressed: null,
                  child: Text('Check Answer'),
                )
              ],
            ),
          ],
        ),
      )),

      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
