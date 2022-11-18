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
      // = 눌렀을 경우
      if (text == '=') {
        // = 두번이상 눌렀을 때
        userInput = result + userInput.substring(len - 1, userInput.length - 1);
        len = result.length + 1;
      } else if (text == '+' || text == '-' || text == 'X' || text == '%') {
        // = 이후에 연산기호를 눌렀을 때
        userInput = hap.toString();
        if (userInput.endsWith(".0")) {
          userInput = userInput.replaceAll(".0", "");
        }
        len = result.length + 1;
        state = 0;
      } else if (text == ".") {
        // = 이후에 . 눌렀을 때
        result = "";
        userInput = "";
        state = 0;
        dot = 0;
        return;
      } else {
        result = "0"; // = 이후에 숫자를 눌렀을 때
        userInput = "";
        state = 0;
      }
    }
    if (state == 0) {
      // 처음 연산기호를 눌렀을 때
      if (userInput.length == 0) {
        // 공백상태에서 연산기호 클릭
        if (text == '+' ||
            text == '-' ||
            text == 'X' ||
            text == '%' ||
            text == "=" ||
            text == "00") {
          text = "";
        }
      } else if (userInput == '0') {
        // 0 후에 00을 눌렀을 때
        if (text == '00') {
          text = "";
        }
      } else {
        // 숫자를 누르고 연산기호를 눌렀을 때
        if (text == '+') {
          // + 눌렀을 때
          if (userInput.length == dotLocation) {
            // 소수점 이후에 바로 연산기호를 눌렀을 때
            userInput = userInput.substring(0, userInput.length - 1);
          }
          len = 0;
          stringNumber = userInput.substring(len, userInput.length);
          number[0] = num.parse(stringNumber); // 앞에 값 저장
          len = userInput.length + 1;
          state = 1;
          cal = 1;
          dot = 0;
        }
        if (text == '-') {
          // -눌렀을 때
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
          // X 눌렀을 때
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
          // % 눌렀을 때
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
      // 2번 이상 연산기호를 눌렀을 때
      if (text == '+') {
        // +
        if (userInput.length == dotLocation) {
          userInput = userInput.substring(0, userInput.length - 1);
        }
        if (len == userInput.length) {
          // 연산기호를 연속해서 두번 눌렀을 때
          text = "";
        } else {
          four_Cal(cal); // 앞의 2개의 값 계산
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
      // 소수점을 눌렀을 때
      if (userInput.length == 0) {
        text = "";
      } else if (dot == 1) {
        text = "";
      }
      dotLocation = userInput.length + 1;
      dot = 1;
    }

    if (text == 'AC') {
      // 다 지우기
      len = 0;
      state = 0;
      cal = 0;
      dot = 0;
      userInput = "";
      result = "0";
      return;
    }

    if (text == "CE") {
      // 입력값만 지우기
      if (state == 1) {
        userInput = userInput.substring(0, len);
      } else {
        userInput = "";
      }
      dot = 0;
      return;
    }

    if (text == '<-') {
      // 하나씩 지우기
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
      // = 눌렀을 때
      dot = 0;
      if (userInput.length == dotLocation) {
        // 소수점 이후에 바로 연산기호를 눌렀을 때
        userInput = userInput.substring(0, userInput.length - 1);
      }
      if (state == 0) {
        // 숫자 다음 바로 = 눌렀을 때
        result = userInput;
        text = "";
      } else if (len == userInput.length) {
        // 연산기호 다음 바로 = 눌렀을 때
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
      // 첫 숫자가 0일 때
      if (userInput == "0") {
        userInput = "";
      }
    }
    userInput = userInput + text;
  }

  four_Cal(int cal) {
    // 4칙 연산
    if (cal == 1) {
      // +
      stringNumber = userInput.substring(len, userInput.length);
      number[1] = num.parse(stringNumber); // 뒤에 값 저장
      hap = number[0] + number[1]; // 2개 값 계산
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
