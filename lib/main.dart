import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sudoku/block_checker.dart';
import 'package:sudoku/box_checker.dart';
import 'highlight.dart';
import 'package:quiver/iterables.dart';
import 'package:sudoku_solver_generator/sudoku_solver_generator.dart';

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

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  List<BlockChecker> alist = [];
  HighLights highLight = HighLights();
  bool isfinish = false;
  bool isnottfinished = false;
  String? tapbox;

  @override
  void initState() {
    generateSudoku();
    super.initState();
  }

  void generateSudoku() {
    isfinish = false;
    highLight = HighLights();
    tapbox = null;
    generatepuzzle();
    checkfinish();
    setState(() {});
    print(alist);
  }

  final snackred = SnackBar(
      content: Text("Something is wrong. Try again"),
      backgroundColor: Colors.red);

  final snack = SnackBar(content: Text("Just to test inkwell"));
  @override
  Widget build(BuildContext context) {
    final thecontroller = TextEditingController();
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        actions: [
          ElevatedButton(
              onPressed: () => generateSudoku(), child: Icon(Icons.refresh)),
        ],
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
              color: Colors.black38,
              padding: EdgeInsets.all(5),
              width: double.maxFinite,
              alignment: Alignment.center,
              child: GridView.builder(
                itemCount: alist.length,
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                ),
                itemBuilder: (BuildContext context, index) {
                  BlockChecker block = alist[index];
                  return Container(
                      color: Colors.white,
                      alignment: Alignment.center,
                      child: GridView.builder(
                        itemCount: block.blokChars.length,
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 1,
                          crossAxisSpacing: 2,
                          mainAxisSpacing: 2,
                        ),
                        itemBuilder: (BuildContext context, indexChar) {
                          BoxChecker box = block.blokChars[indexChar];
                          Color color = Colors.white;
                          Color colorText = Colors.grey.shade700;
                          if (isfinish)
                            color = Colors.green;
                          else if (box.isFocus && box.text != "")
                            color = Colors.brown.shade100;
                          else if (box.isDefault)
                            color = Colors.grey.shade400;
                          if (tapbox == "${index}-${indexChar}" && !isfinish)
                            color = Colors.blue.shade100;



                          if (this.isfinish) {
                            colorText = Colors.white;
                          }




                          else if(box.isExist) {

                            colorText = Colors.red;
                           }
                          // if(isnottfinished){
                          //   WidgetsBinding.instance.addPostFrameCallback((_) =>
                          //       ScaffoldMessenger.of(context)
                          //           .showSnackBar(snackred));
                          // }

                            ;

                          //
                          //
                          // }



                          return Container(
                              margin: EdgeInsets.all(3),
                              color: color,
                              alignment: Alignment.center,
                              child: TextButton(
                                onPressed: box.isDefault
                                    ? null
                                    : () {
                                        setFocus(index, indexChar);
                                      },
                                child: Text(
                                  '${box.text}',
                                  style: TextStyle(color: colorText),
                                ),

                                // child: Container(
                                //   child: TextField(
                                //     textAlign: TextAlign.center,
                                //     controller: thecontroller,
                                //     //enabled: false,
                                //     decoration: InputDecoration(
                                //       labelText: thecontroller.text,
                                //     ),
                                //   ),
                                // ),
                              ));
                        },
                      ));
                },
              ),
            ),

            Expanded(
              child: Container(
                padding: EdgeInsets.all(20),
                alignment: Alignment.center,
                child: Row(
                  // crossAxisAlignment: CrossAxisAlignment.stretch,
                  // mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      child: GridView.builder(
                        itemCount: 9,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                          childAspectRatio: 3,
                          crossAxisSpacing: 2,
                          mainAxisSpacing: 7,
                        ),
                        physics: ScrollPhysics(),
                        itemBuilder: (buildContext, index) {
                          return SizedBox(
                            width: 50,
                            height: 10,
                            child: ElevatedButton(
                              onPressed: () => setInput(index + 1),
                              child: Text(
                                "${index + 1}",
                                style: TextStyle(color: Colors.white),
                              ),
                              // style: ButtonStyle(
                              //   backgroundColor:
                              //   MaterialStateProperty.all<Color>(
                              //       Colors.white),
                              // ),
                            ),
                          );

                          //   ElevatedButton(
                          // onPressed: () => setInput(index + 1),
                          // child: Text(
                          // "${index + 1}",
                          // style: TextStyle(color: Colors.black),
                          // ),
                          // style: ButtonStyle(
                          // backgroundColor:
                          // MaterialStateProperty.all<Color>(
                          // Colors.white),
                          // ),
                          // );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                    onPressed: () => generateSudoku(), child: Text('Reset')),
                ElevatedButton(
                  onPressed:
                   isnottfinished ? (){
                     ScaffoldMessenger.of(context).showSnackBar(snackred);
                   }: null,
                    // isnottfinished
                    //
                    // ? ()=> ScaffoldMessenger.of(context)
                    //     .showSnackBar(snackred)
                    // :null ;

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

  generatepuzzle() {
    alist.clear();
    var sudokugenerator = SudokuGenerator(emptySquares: 4);
    List<List<List<int>>> completes = partition(sudokugenerator.newSudokuSolved,
            sqrt(sudokugenerator.newSudoku.length).toInt())
        .toList();
    partition(sudokugenerator.newSudoku,
            sqrt(sudokugenerator.newSudoku.length).toInt())
        .toList()
        .asMap()
        .entries
        .forEach((entry) {
      List<int> templistcomplete =
          completes[entry.key].expand((element) => element).toList();
      List<int> templist = entry.value.expand((element) => element).toList();
      templist.asMap().entries.forEach((entryin) {
        int index = entry.key * sqrt(sudokugenerator.newSudoku.length).toInt() +
            (entryin.key % 9).toInt() ~/ 3;
        if (alist.where((element) => element.index == index).length == 0) {
          alist.add(BlockChecker(index, []));
        }

        BlockChecker block =
            alist.where((element) => element.index == index).first;
        block.blokChars.add(BoxChecker(
          entryin.value == 0 ? "" : entryin.value.toString(),
          index: block.blokChars.length,
          isDefault: entryin.value != 0,
          isCorrect: entryin.value != 0,
          correctText: templistcomplete[entryin.key].toString(),
        ));
      });
    });
    print(alist);
  }

  setFocus(int index, int indexChar) {
    tapbox = "$index-$indexChar";
    highLight.setData(index, indexChar);
    showFocusCenterLine();
    setState(() {});
  }

  void showFocusCenterLine() {
    // set focus color for line vertical & horizontal
    int rowNoBox = highLight.indexBox! ~/ 3;
    int colNoBox = highLight.indexBox! % 3;

    this.alist.forEach((element) => element.clearFocus());

    alist
        .where((element) => element.index ~/ 3 == rowNoBox)
        .forEach((e) => e.setFocus(highLight.indexChar!, Direction.Horizontal));

    alist
        .where((element) => element.index % 3 == colNoBox)
        .forEach((e) => e.setFocus(highLight.indexChar!, Direction.Vertical));
  }

  setInput(int? number) {
    // set input data based grid
    // or clear out data
    if (highLight.indexBox == null) return;
    if (alist[highLight.indexBox!].blokChars[highLight.indexChar!].text ==
            number.toString() ||
        number == null) {
      alist.forEach((element) {
        element.clearFocus();
        element.clearExist();
      });
      alist[highLight.indexBox!].blokChars[highLight.indexChar!].setEmpty();
      tapbox = null;
      isfinish = false;
      showSameInputOnSameLine();
    } else {
      alist[highLight.indexBox!]
          .blokChars[highLight.indexChar!]
          .setText("$number");

      showSameInputOnSameLine();

      checkfinish();
    }

    setState(() {});
  }

  void showSameInputOnSameLine() {
    // show duplicate number on same line vertical & horizontal so player know he or she put a wrong value on somewhere

    int rowNoBox = highLight.indexBox! ~/ 3;
    int colNoBox = highLight.indexBox! % 3;

    String textInput =
        alist[highLight.indexBox!].blokChars[highLight.indexChar!].text!;

    alist.forEach((element) => element.clearExist());

    alist.where((element) => element.index ~/ 3 == rowNoBox).forEach((e) =>
        e.setExistValue(highLight.indexChar!, highLight.indexBox!, textInput,
            Direction.Horizontal));

    alist.where((element) => element.index % 3 == colNoBox).forEach((e) =>
        e.setExistValue(highLight.indexChar!, highLight.indexBox!, textInput,
            Direction.Vertical));

    List<BoxChecker> exists = alist
        .map((element) => element.blokChars)
        .expand((element) => element)
        .where((element) => element.isExist)
        .toList();

    if (exists.length == 1) exists[0].isExist = false;
  }

  void checkfinish() {
    int totalUnfinish = alist
        .map((e) => e.blokChars)
        .expand((element) => element)
        .where((element) => !element.isCorrect)
        .length;

    int totalUnfinish2 =
        alist.map((e) => e.blokChars).expand((element) => element).where((element) => element.text=="").length;
    print(totalUnfinish2);

    int totalUnfinish3 = alist
        .map((e) => e.blokChars)
        .expand((element) => element)
        .where((element) => element.isCorrect)
        .length;
    print(totalUnfinish3);

    isfinish = totalUnfinish == 0;
    isnottfinished =
    ((totalUnfinish> 0 && totalUnfinish<= 4) && (totalUnfinish2==0)  && totalUnfinish3 != 81);
    print("unfinished ${totalUnfinish}");
    // if (isfinish) {
    //   ScaffoldMessenger.of(context).showSnackBar(snack);
    //   print("List length is ${alist.length}");
    // } else {
    //   ScaffoldMessenger.of(context).showSnackBar(snackred);
    // }
  }
}
