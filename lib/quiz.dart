import 'package:flutter/material.dart';
import 'package:mil_quiz_bot/ExamScript.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(

          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:[
                      Card(
                          color: Colors.green,
                          child: _DataCard(
                            title: '10 QUESTIONS',
                            type: 'ABBR',
                            subTitle: "5 MINUTES",
                            button: FilledButton(
                              style:  FilledButton.styleFrom(backgroundColor: Colors.amber),
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) =>  ExamScript(ques: 10, type: "abbr", isWrongVis: List.filled(10, false, growable: false))),);
                              },
                              child: const Text('Get Started', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                            ),
                          )
                      ),
                      Card(
                          color: Color(0xff1E145A),
                          child: _DataCard(
                            title: '20 QUESTIONS',
                            type: 'ABBR',
                            subTitle: "10 MINUTES",
                            button: FilledButton(
                                style:  FilledButton.styleFrom(backgroundColor: Colors.amber),
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => ExamScript(ques: 20, type: "abbr", isWrongVis: List.filled(20, false, growable: false))),);

                                }, child: const Text('Get Started', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),)),
                          )
                      ),
                    ]

                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                          Card(
                            color: Color(0xff281537),
                              child: _DataCard(
                                title: '10 QUESTIONS',
                                type: 'DEABBR',
                                subTitle: "5 MINUTES",
                                button: FilledButton(
                                  style:  FilledButton.styleFrom(backgroundColor: Colors.amber),
                                    onPressed: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => ExamScript(ques: 10, type: "deabbr", isWrongVis: List.filled(10, false, growable: false))),);

                                    }, child: const Text('Get Started', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),)),
                              )
                          ),
                          Card(
                              color: Color(0xffB81736),
                              child: _DataCard(
                                title: '20 QUESTIONS',
                                type: 'DEABBR',
                                subTitle: "10 MINUTES",
                                button: FilledButton(

                                    onPressed: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => ExamScript(ques: 20, type: "deabbr", isWrongVis: List.filled(20, false, growable: false))),);
                                    },
                                    child: const Text('Get Started', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                                    style:  FilledButton.styleFrom(backgroundColor: Colors.amber),),
                              )
                          ),
                  ],
                )
              ],
            ),
          ),
        )

    );
  }
}

class _DataCard extends StatelessWidget {

  const _DataCard(
      {Key? key,
        required this.title,
        required this.subTitle,
        required this.button,
        required this.type})
      : super(key: key);
  final String title;
  final String subTitle;
  final String type;
  final Widget button;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: 
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.check_circle_outline, color: Colors.white),
              SizedBox(width: 5,),
              Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Icon(Icons.question_mark_outlined, color: Colors.white),
              SizedBox(width: 5,),
              Text(type, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Icon(Icons.access_alarm_outlined, color: Colors.white),
              SizedBox(width: 5,),
              Text(subTitle,style: TextStyle(color: Colors.white),),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [button],
          )
        ],
      ),
    );
  }
}