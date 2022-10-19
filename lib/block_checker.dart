import 'package:sudoku/box_checker.dart';

class BlockChecker {
  late int index;
  List<BoxChecker> blokChars = List<BoxChecker>.from([]);

  BlockChecker(this.index, this.blokChars);

  // declare method used
  setFocus(int index, Direction direction) {
    List<BoxChecker> temp;

    if (direction == Direction.Horizontal) {
      temp = blokChars
          .where((element) => element.index! ~/ 3 == index ~/ 3)
          .toList();
    } else {
      temp = blokChars
          .where((element) => element.index! % 3 == index % 3)
          .toList();
    }

    temp.forEach((element) {
      element.isFocus = true;
    });
  }

  setExistValue(
      int index, int indexBox, String textInput, Direction direction) {
    List<BoxChecker> temp;

    if (direction == Direction.Horizontal) {
      temp = blokChars
          .where((element) => element.index! ~/ 3 == index ~/ 3)
          .toList();
    } else {
      temp = blokChars
          .where((element) => element.index! % 3 == index % 3)
          .toList();
    }

    if (this.index == indexBox) {
      List<BoxChecker> blokCharsBox =
          blokChars.where((element) => element.text == textInput).toList();

      if (blokCharsBox.length == 1 && temp.isEmpty) blokCharsBox.clear();

      temp.addAll(blokCharsBox);
    }

    temp.where((element) => element.text == textInput).forEach((element) {
      element.isExist = true;
    });
  }

  clearFocus() {
    blokChars.forEach((element) {
      element.isFocus = false;
    });
  }

  clearExist() {
    blokChars.forEach((element) {
      element.isExist = false;
    });
  }
}

enum Direction { Horizontal, Vertical }
