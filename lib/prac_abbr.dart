import 'dart:math';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:csv/csv.dart';
import 'package:flutter/services.dart';


class PracAbbr extends StatefulWidget {
  const PracAbbr({super.key});

  @override
  State<PracAbbr> createState() => _PracAbbrState();
}

class _PracAbbrState extends State<PracAbbr> {
  int totalAbbr = 1770;
  List<List<dynamic>> data = [];
  List QuesSet = [];
  int quesNo= 0;
  bool isCorrectVis = false;
  bool isWrongVis = false;
  TextEditingController ansFd = new TextEditingController();
  String result = "";

  List colorList = [Color(0xffB81736), Color(0xff4A235A), Color(0xff145A32), Color(0xff2C3E50),
  Color(0xff641E16), Color(0xff1E145A)];
  Color quesBoxColor = Color(0xffB81736);
  void _loadCSV()  async {
    final _rawData =  await rootBundle.loadString("assets/data/abbr_sheet.csv");
    List<List<dynamic>> _listData =
    const CsvToListConverter().convert(_rawData);
    setState(() {
      data = _listData;
      for(int i=0; i<=totalAbbr; i++){
        QuesSet.add(i);
      }
      QuesSet.shuffle();
    });
  }


  int CheckAnswer(String key){
    if (key == data[QuesSet[quesNo]][1])
      return 1;
    else  return 0;
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadCSV();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Container(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  gradient: LinearGradient(colors: [
                    Color(0xffB81736),
                    Color(0xff281537),
                  ]),
                ),
                child:
                Text('  TEST YOUR ABBR COMPETENCY  ', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),),

              ),
              const SizedBox(height: 10,),

              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Color(0xff85C1E9 ),
                    Color(0xff85C1E9),
                  ]),
                ),
                child:
                Text("What is the abbr of fol word?   ",
                    style:GoogleFonts.anton(fontSize: 20),
                  textAlign: TextAlign.center,
                    ),
              ),
              if(data.isNotEmpty == true)
              Container(
                height: 200, padding: EdgeInsets.all(10.0),
                child:
                 Card(
                    elevation: 5, color: quesBoxColor ,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(data[QuesSet[quesNo]].first,
                        style: GoogleFonts.archivoBlack(fontSize: 26, color: Colors.white, fontWeight: FontWeight.w900),
                        textAlign: TextAlign.center,),
                    ))
              ),

              const SizedBox(height: 10,),

              Container(
                width: 350,
                child: TextFormField(
                  onChanged: (value) => CheckAnswer(value),
                  controller: ansFd,
                  decoration: InputDecoration(
                    labelText: 'Your Answer',
                    border: OutlineInputBorder(),
                  ),
                  style: TextStyle(color: Colors.black),
                ),
              ),

              const SizedBox(height: 10,),
              // //////////////////////////SHOW RESULT //////////////////////////////
              Container(
                 alignment: Alignment.center,
                  width: 350,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Visibility( visible: isCorrectVis,
                          child:
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Color(0xff145A32 ),
                        ),
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            children: [
                              WidgetSpan(
                                alignment: PlaceholderAlignment.middle,
                                  child: Icon(Icons.check_circle, color: Colors.white, ),
                              ),
                              TextSpan(text: ' CORRECT! ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                            ],
                          ),
                        )
                      )
                      ),

                      Visibility( visible: isWrongVis,
                          child:
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Colors.red.shade900,
                          ),
                            child: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                children: [
                                  WidgetSpan(
                                    alignment: PlaceholderAlignment.middle,
                                    child: Icon(Icons.close_outlined, color: Colors.white, ),
                                  ),
                                  TextSpan(text: result ,style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                                ],
                              ),
                            )
                      ))
                    ],
                  )
              ),
              const SizedBox(height: 10,),
              // ////////////////////////// CHECK BUTTON //////////////////////////////
              Container(
                width: 350,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                    FloatingActionButton.extended(
                      label: Text('CHECK', style: TextStyle(color: Colors.white),), // <-- Text
                      backgroundColor: Colors.blue,
                      icon: Icon( // <-- Icon
                        Icons.question_mark_outlined,
                        size: 24.0,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        String yourAns = ansFd.text.trim();
                        setState(() {
                          if(yourAns == data[QuesSet[quesNo]].last)
                            {
                              isCorrectVis = true;
                              isWrongVis = false;
                            }
                          else{
                            isCorrectVis = false;
                            isWrongVis = true;
                            result = "WRONG! Correct Ans: "+ data[QuesSet[quesNo]].last +"  ";
                          }
                        });
                      },
                  ),
                  const SizedBox(width: 20,),
                  // ////////////////////////// NEXT BUTTON //////////////////////////////

                    FloatingActionButton.extended(
                      label: Text('NEXT', style: TextStyle(color: Colors.white),), // <-- Text
                      backgroundColor: Colors.black,
                      icon: Icon( // <-- Icon
                        Icons.next_plan,
                        size: 24.0,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        setState(() {
                          quesNo ++;
                          ansFd.clear();
                          isCorrectVis = false;
                          isWrongVis = false;
                          quesBoxColor = colorList[Random().nextInt(6)];
                        });
                      },
                    ),
                ],
                )
              ),

              const SizedBox(height: 10,),
            ],
          ),
        ),
        )
      )
    );
  }
}