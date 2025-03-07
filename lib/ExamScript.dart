import 'dart:math';

import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mil_quiz_bot/landing_page.dart';


class ExamScript extends StatefulWidget {
  final int ques;
  final String type;
  final isWrongVis;
  const ExamScript({super.key, required this.ques, required this.type, this.isWrongVis});


  @override
  State<ExamScript> createState() => _ExamScriptState();
}

class _ExamScriptState extends State<ExamScript> {
  int totalQues = 870;
  List finalQues = [];
  List quesIndex = [];
  List quesSet = [];
  String typeHd ="";
  int quesnumHd = 0;
  int score = 0;
  bool isInTime = true;
  int isSubmit = 1;
  String correctAns = "";
  int CountDownTimer = 0;

  List<List<dynamic>> data = [];
  Random random = new Random();
  List TextCtrl = [];
  TextEditingController scoreFd = new TextEditingController();
  void createQues()  async {
    final _rawData =  await rootBundle.loadString("assets/data/offrs_ques.csv");
    List<List<dynamic>> _listData =
    const CsvToListConverter().convert(_rawData);
    data = _listData;
    setState(() {

      if(widget.type == "abbr") typeHd = "ABBR";
      else typeHd = "DEABBR";
      quesnumHd = widget.ques;

      for (int i = 1; i<=widget.ques; i++){
        TextEditingController ctrl$i = new TextEditingController();
        TextCtrl.add(ctrl$i);
      }


    int i=0;
    while(quesIndex.length != widget.ques){
      int random_number = random.nextInt(totalQues);
      if (!quesIndex.contains(random_number)) {
        quesIndex.add(random_number);
        quesSet.add(data[quesIndex[i++]]);

      }
    }

    });
  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    createQues();
    CountDownTimer = widget.ques;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('QUIZ TEST', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white,),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        flexibleSpace: Image(
          image: AssetImage("assets/images/appbar_bg.jpeg"),
          fit: BoxFit.cover,
        ),
        backgroundColor: Colors.transparent,
      ),
      body:
      Container(
        child:
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.green.shade900,
                ),
                child:
                RichText(
                  text: TextSpan(
                    text: '   ANS ',
                    style:  TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.normal),
                    children: <TextSpan>[
                      TextSpan(text: ' THE FOL QUES  '),
                    ],
                  ),
                )
              ),
              Expanded(child: quesSet.isNotEmpty ?
              ListView.builder(
                  itemCount: quesSet.length,
                  itemBuilder: (context, index){
                    var cnt = index+1;
                    return Card(
                      key: ValueKey(quesSet[index]),
                      elevation: 5,
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: ListTile(
                        leading: Text('$cnt',  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold) ),
                        title: Text(quesSet[index][1].replaceAll(RegExp('  '), '_'), style: TextStyle(fontWeight: FontWeight.bold),),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                for ( var i in optionList(quesSet[index][2]) )
                                  Text(i.toString().split(new RegExp(r'(?:\r?\n|\r)'))
                                      .where((s) => s.trim().length != 0)
                                      .join('\n'), style: const TextStyle( color: Colors.green, fontWeight: FontWeight.bold)),
                              ],
                            ),
                            TextField(
                              enabled: isInTime,
                              controller: TextCtrl[index],
                              decoration: InputDecoration(
                                isDense: true,
                                labelText: 'Your Answer',
                                border: OutlineInputBorder(),

                              ),
                              style: TextStyle(color: Colors.black),
                            ),
                            Visibility( visible: widget.isWrongVis[index],
                                child:
                                Text("Correct Ans: "+ quesSet[index][3].toString(), style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.red)),
                            ),

                          ],
                        ),
                      ),
                    );
                  }):  const Center(child: Text("Loading..."))
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CircleAvatar(
                    backgroundColor: Color(0xff145A32 ),
                    child: TimerCountdown(
                      format: CountDownTimerFormat.minutesSeconds,
                      enableDescriptions: false,
                      spacerWidth: 2,
                      timeTextStyle: TextStyle(color: Colors.white),
                      colonsTextStyle: TextStyle(color: Colors.white),
                      endTime: DateTime.now().add(
                        Duration(
                          minutes: CountDownTimer~/2,
                          seconds: 00,
                        ),
                      ),
                      onEnd: () {
                        setState(() {
                          isInTime = false;
                        });
                      },
                    ),
                    maxRadius: 40,
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.pink,
                    child: TextField(
                        controller: scoreFd,
                        readOnly: true,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                            labelText: "SCORE",
                            contentPadding: EdgeInsets.all(10.0),
                            labelStyle: GoogleFonts.blackOpsOne(color: Colors.white, fontWeight: FontWeight.bold,),
                            floatingLabelAlignment: FloatingLabelAlignment.center,

                          border: InputBorder.none,
                        ),
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 42)),
                    maxRadius: 40,
                  ),
                  const SizedBox(width: 10,),

                    FloatingActionButton.extended(
                      label: Text('SUBMIT', style: TextStyle(color: Colors.white),), // <-- Text
                      backgroundColor: Colors.black,
                      icon: Icon( // <-- Icon
                        Icons.check_circle_outline,
                        size: 24.0,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        if (isSubmit==1) {
                          for (int i = 0; i < quesnumHd; i++) {
                            int gotAns= 0;
                            List ans= quesSet[i][3].split(RegExp(r'[;/,]'));

                            for(int j=0; j<ans.length;j++) {
                              if (ans[j].trim() == TextCtrl[i].text.trim() || ans[j].trim() == TextCtrl[i].text.trim()+".") {
                                score++;
                                TextCtrl[i].text = TextCtrl[i].text + "   ✅";
                                gotAns= 1;
                                break;
                              }
                            }
                            if(gotAns==0){
                                    TextCtrl[i].text = TextCtrl[i].text + "    ❌";
                                    widget.isWrongVis[i] = true;
                            }

                          }

                        }
                        setState(() {
                          scoreFd.text = score.toString();
                          isInTime = false;
                          isSubmit=0;
                          CountDownTimer = 0;
                        });

                      },
                    ),
                ],
              )


            ],
          ),
        ),

      ),
    );
  }

  List optionList(String options) {
    final splitted = options.split(',');
    List  list = [];
    int count = 0;
    if(splitted.length!=1)
      for(var i in splitted){
        list.add(String.fromCharCode(65+count)+". "+ i.trim()+"\n");
        count++;
      }

    return list;
  }
}



