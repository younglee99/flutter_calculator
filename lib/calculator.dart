import 'package:flutter/material.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  int state = 0;
  int cal = 0;
  int dot = 0;
  int dotLocation = 0;
  num hap = 0;
  int len = 0;
  String userInput = "";
  String result = "0";
  List<num> number = [0, 0];
  String stringNumber = "";
  List<String> buttonList = [
    '%',
    'AC',
    'CE',
    '<-',
    '7',
    '8',
    '9',
    'X',
    '4',
    '5',
    '6',
    '-',
    '1',
    '2',
    '3',
    '+',
    '00',
    '0',
    '.',
    '='
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Flexible(child: resultWidget(), flex: 4),
            Flexible(child: buttonWidget(), flex: 9),
          ],
        ),
      ),
    );
  }

  Widget resultWidget() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          alignment: Alignment.centerRight,
          child: Text(
            userInput,
            style: const TextStyle(fontSize: 32),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(20),
          alignment: Alignment.centerRight,
          child: Text(
            result,
            style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  Widget buttonWidget() {
    return GridView.builder(
      padding: const EdgeInsets.all(15),
      itemCount: buttonList.length,
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
      itemBuilder: (BuildContext context, int index) {
        return button(buttonList[index]);
      },
    );
  }

  Widget button(String text) {
    return Container(
      margin: const EdgeInsets.all(8),
      child: MaterialButton(
        onPressed: () {
          setState(() {
            buttonPress(text);
          });
        },
        color: Color.fromARGB(169, 255, 255, 255),
        textColor: Colors.black,
        shape: const BeveledRectangleBorder(),
        child: Text(text, style: const TextStyle(fontSize: 25)),
      ),
    );
  }

  buttonPress(String text) {
    if (state == 2) {
      // = ????????? ??????
      if (text == '=') {
        // = ???????????? ????????? ???
        userInput = result + userInput.substring(len - 1, userInput.length - 1);
        len = result.length + 1;
      } else if (text == '+' || text == '-' || text == 'X' || text == '%') {
        // = ????????? ??????????????? ????????? ???
        userInput = hap.toString();
        if (userInput.endsWith(".0")) {
          userInput = userInput.replaceAll(".0", "");
        }
        len = result.length + 1;
        state = 0;
      } else if (text == ".") {
        // = ????????? . ????????? ???
        result = "";
        userInput = "";
        state = 0;
        dot = 0;
        return;
      } else {
        result = "0"; // = ????????? ????????? ????????? ???
        userInput = "";
        state = 0;
      }
    }
    if (state == 0) {
      // ?????? ??????????????? ????????? ???
      if (userInput.length == 0) {
        // ?????????????????? ???????????? ??????
        if (text == '+' ||
            text == '-' ||
            text == 'X' ||
            text == '%' ||
            text == "=" ||
            text == "00") {
          text = "";
        }
      } else if (userInput == '0') {
        // 0 ?????? 00??? ????????? ???
        if (text == '00') {
          text = "";
        }
      } else {
        // ????????? ????????? ??????????????? ????????? ???
        if (text == '+') {
          // + ????????? ???
          if (userInput.length == dotLocation) {
            // ????????? ????????? ?????? ??????????????? ????????? ???
            userInput = userInput.substring(0, userInput.length - 1);
          }
          len = 0;
          stringNumber = userInput.substring(len, userInput.length);
          number[0] = num.parse(stringNumber); // ?????? ??? ??????
          len = userInput.length + 1;
          state = 1;
          cal = 1;
          dot = 0;
        }
        if (text == '-') {
          // -????????? ???
          if (userInput.length == dotLocation) {
            userInput = userInput.substring(0, userInput.length - 1);
          }
          len = 0;
          stringNumber = userInput.substring(len, userInput.length);
          number[0] = num.parse(stringNumber);
          len = userInput.length + 1;
          state = 1;
          cal = 2;
          dot = 0;
        }
        if (text == 'X') {
          // X ????????? ???
          if (userInput.length == dotLocation) {
            userInput = userInput.substring(0, userInput.length - 1);
          }
          len = 0;
          stringNumber = userInput.substring(len, userInput.length);
          number[0] = num.parse(stringNumber);
          len = userInput.length + 1;
          state = 1;
          cal = 3;
          dot = 0;
        }
        if (text == '%') {
          // % ????????? ???
          if (userInput.length == dotLocation) {
            userInput = userInput.substring(0, userInput.length - 1);
          }
          len = 0;
          stringNumber = userInput.substring(len, userInput.length);
          number[0] = num.parse(stringNumber);
          len = userInput.length + 1;
          state = 1;
          cal = 4;
          dot = 0;
        }
      }
    } else if (state == 1) {
      // 2??? ?????? ??????????????? ????????? ???
      if (text == '+') {
        // +
        if (userInput.length == dotLocation) {
          userInput = userInput.substring(0, userInput.length - 1);
        }
        if (len == userInput.length) {
          // ??????????????? ???????????? ?????? ????????? ???
          text = "";
        } else {
          four_Cal(cal); // ?????? 2?????? ??? ??????
          cal = 1;
          dot = 0;
        }
      }
      if (text == '-') {
        // -
        if (userInput.length == dotLocation) {
          userInput = userInput.substring(0, userInput.length - 1);
        }
        if (len == userInput.length) {
          text = "";
        } else {
          four_Cal(cal);
          cal = 2;
          dot = 0;
        }
      }
      if (text == 'X') {
        // X
        if (userInput.length == dotLocation) {
          userInput = userInput.substring(0, userInput.length - 1);
        }
        if (len == userInput.length) {
          text = "";
        } else {
          four_Cal(cal);
          cal = 3;
          dot = 0;
        }
      }
      if (text == '%') {
        // %
        if (userInput.length == dotLocation) {
          userInput = userInput.substring(0, userInput.length - 1);
        }
        if (len == userInput.length) {
          text = "";
        } else {
          four_Cal(cal);
          cal = 4;
          dot = 0;
        }
      }
    }

    if (text == ".") {
      // ???????????? ????????? ???
      if (userInput.length == 0) {
        text = "";
      } else if (dot == 1) {
        text = "";
      }
      dotLocation = userInput.length + 1;
      dot = 1;
    }

    if (text == 'AC') {
      // ??? ?????????
      len = 0;
      state = 0;
      cal = 0;
      dot = 0;
      userInput = "";
      result = "0";
      return;
    }

    if (text == "CE") {
      // ???????????? ?????????
      if (state == 1) {
        userInput = userInput.substring(0, len);
      } else {
        userInput = "";
      }
      dot = 0;
      return;
    }

    if (text == '<-') {
      // ????????? ?????????
      if (userInput.length == 0) {
      } else {
        userInput = userInput.substring(0, userInput.length - 1);
        if (userInput.length < dotLocation) {
          dot = 0;
        }
        if (userInput.length < len) {
          state = 0;
        }
      }
      return;
    }

    if (text == '=') {
      // = ????????? ???
      dot = 0;
      if (userInput.length == dotLocation) {
        // ????????? ????????? ?????? ??????????????? ????????? ???
        userInput = userInput.substring(0, userInput.length - 1);
      }
      if (state == 0) {
        // ?????? ?????? ?????? = ????????? ???
        result = userInput;
        text = "";
      } else if (len == userInput.length) {
        // ???????????? ?????? ?????? = ????????? ???
        userInput = userInput + number[0].toString();
        state = 2;
        four_Cal(cal);
      } else {
        state = 2;
        four_Cal(cal);
      }
    }

    if (text == "0" ||
        text == "1" ||
        text == "2" ||
        text == "3" ||
        text == "4" ||
        text == "5" ||
        text == "6" ||
        text == "7" ||
        text == "8" ||
        text == "9") {
      // ??? ????????? 0??? ???
      if (userInput == "0") {
        userInput = "";
      }
    }
    userInput = userInput + text;
  }

  four_Cal(int cal) {
    // 4??? ??????
    if (cal == 1) {
      // +
      stringNumber = userInput.substring(len, userInput.length);
      number[1] = num.parse(stringNumber); // ?????? ??? ??????
      hap = number[0] + number[1]; // 2??? ??? ??????
      number[0] = hap;
      result = hap.toString();
      if (result.endsWith(".0")) {
        result = result.replaceAll(".0", "");
      }
      if (state == 2) {
      } else {
        userInput = hap.toString();
        len = result.length + 1;
      }
    }
    if (cal == 2) {
      // -
      stringNumber = userInput.substring(len, userInput.length);
      number[1] = num.parse(stringNumber);
      hap = number[0] - number[1];
      number[0] = hap;
      result = hap.toString();
      if (result.endsWith(".0")) {
        result = result.replaceAll(".0", "");
      }
      if (state == 2) {
      } else {
        userInput = hap.toString();
        len = result.length + 1;
      }
    }
    if (cal == 3) {
      // X
      stringNumber = userInput.substring(len, userInput.length);
      number[1] = num.parse(stringNumber);
      hap = number[0] * number[1];
      number[0] = hap;
      result = hap.toString();
      if (result.endsWith(".0")) {
        result = result.replaceAll(".0", "");
      }
      if (state == 2) {
      } else {
        userInput = hap.toString();
        len = result.length + 1;
      }
    }
    if (cal == 4) {
      // %
      stringNumber = userInput.substring(len, userInput.length);
      number[1] = num.parse(stringNumber);
      hap = number[0] / number[1];
      number[0] = hap;
      result = hap.toString();
      if (result.endsWith(".0")) {
        result = result.replaceAll(".0", "");
      }
      if (state == 2) {
      } else {
        userInput = hap.toString();
        len = result.length + 1;
      }
    }
  }
}
