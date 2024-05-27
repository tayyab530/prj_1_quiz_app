import 'package:flutter/material.dart';
import '../models/question_model.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<QuestionModel> listOfQuestion = [
    QuestionModel(
      "Select OOP language?",
      {
        "C++": 10, //Key:Value(Answer:Score)
        "Java": 10,
        "Dart": 10,
        "Cobol": 0,
      },
    ),
    QuestionModel(
      "Is Flutter open-source?",
      {
        "Yes": 10, //Key:Value(Answer:Score)
        "No": 0,
      },
    ),
    QuestionModel(
      "Which of the following is NOT a type in Dart?",
      {
        "Double": 10, //Key:Value(Answer:Score)
        "Num": 10,
        "int": 10,
        "decimal": 0,
      },
    ),
  ];

  late QuestionModel currentQuestion;
  int qIndex = 0;
  int score = 0;
  String imageUrl = '';

  @override
  void initState() {
    currentQuestion = listOfQuestion.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Quiz App"),
      ),
      body: Center(
        child: qIndex == listOfQuestion.length
            ? buildScoreWidget()
            : buildQuestionCard(currentQuestion, qIndex + 1),
      ),
    );
  }

  Widget buildScoreWidget(){
    return Column(
      children: [
        SizedBox(
          height: 30,
        ),
        Text(
          "Score: $score",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Image.network(imageUrl),
      ],
    );
  }

  Widget buildQuestionCard(QuestionModel question, int qNumber) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 20,
        ),
        Text(
          "Q$qNumber: ${question.text}",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        ...question.mapOfAnswers.keys.toList().map(
              (answerText) => buildButton(
                answerText,
                question.mapOfAnswers[answerText]!,
              ),
            ),
      ],
    );
  }

  Widget buildButton(
    String text,
    int score,
  ) {
    return Padding(
      padding: EdgeInsets.only(bottom: 5),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        width: double.maxFinite,
        child: ElevatedButton(
          onPressed: () {
            gotoNextQuestionOrResult();
            calculateScore(score);
          },
          child: Text(
            text,
            style: TextStyle(color: Colors.white),
          ),
          style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
        ),
      ),
    );
  }

  void gotoNextQuestionOrResult() {
    setState(() {
      qIndex++;
      if (qIndex >= listOfQuestion.length) {
      } else {
        currentQuestion = listOfQuestion[qIndex];
      }
    });
  }

  void calculateScore(int scr) {
    setState(() {
      score += scr;
      imageUrl = isQuizPassed()
          ? "https://www.shutterstock.com/image-vector/passed-vector-stamp-260nw-216562036.jpg"
          : "https://www.shutterstock.com/image-vector/grunge-rubber-stamp-word-failure-260nw-147523214.jpg";
    });
  }

  bool isQuizPassed() {
    int totalPoints = listOfQuestion.length * 10;
    double passingRatio = (score / totalPoints) * 100;
    if (passingRatio >= 50) {
      return true;
    } else {
      return false;
    }
  }
}
