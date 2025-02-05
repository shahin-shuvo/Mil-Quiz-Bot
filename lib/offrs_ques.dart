import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OffrsQues extends StatefulWidget {
  const OffrsQues({super.key});

  @override
  State<OffrsQues> createState() => _OffrsQuesState();
}

class _OffrsQuesState extends State<OffrsQues> {

  List<List<dynamic>> _data = [];
  List<List<dynamic>> foundAbbr = [];
  List splitted = [];

 void _loadCSV()  async {
    final _rawData =  await rootBundle.loadString("assets/data/offrs_ques.csv");
    List<List<dynamic>> _listData =
    const CsvToListConverter().convert(_rawData);
    setState(() {
      _data = _listData;
      foundAbbr = _listData;

    });
  }

  List<Map<String, dynamic>> foundWords = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadCSV();
  }
  void _filterWords(String key){

    List<List<dynamic>> resultAbbr = [];

    if(key.isEmpty) {
      resultAbbr = _data;
    }
    else{
      resultAbbr = _data.where(
              (element) =>
              (
                  element[1].toLowerCase().startsWith(key.trim().toLowerCase())
              )
      ).toList();

      if (resultAbbr.isEmpty){
        resultAbbr = _data.where(
                (element) =>
                    ( element[2].toLowerCase().startsWith(key.trim().toLowerCase())
                    )
        ).toList();
      }
      if (resultAbbr.isEmpty){
        resultAbbr = _data.where(
                (element) =>
            (
                element[1].toLowerCase().contains(key.trim().toLowerCase())
            )
        ).toList();
      }
    }

    setState(() {
      foundAbbr = resultAbbr;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body:
        Container(
        child:
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              // Container(
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.all(Radius.circular(10)),
              //     color: Colors.blue.shade900,
              //   ),
              //   child:
              //   Text('  ALL QUES FOR OFFRS(AS PER 2024)  ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),),
              // ),
              TextField(
                onChanged: (value) => _filterWords(value),
                cursorColor: Colors.black,
                style: const TextStyle(color: Colors.black),
                decoration: const InputDecoration(
                  labelText: "Search Here",
                  labelStyle: TextStyle(
                    color: Colors.black26,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 3,
                    fontSize: 15,
                  ),
                    suffixIcon: Icon(Icons.search, color: Colors.black),
                    prefixIcon: Icon(Icons.list, color: Colors.black,)
                )
              ),

              Expanded(child: foundAbbr.isNotEmpty ?
              ListView.builder(
                  itemCount: foundAbbr.length,
                  itemBuilder: (context, index){
                    return Card(
                      key: ValueKey(foundAbbr[index]),
                      elevation: 5,
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: ListTile(
                        leading: Text(foundAbbr[index][0].toString()),
                        title: Text(foundAbbr[index][1].replaceAll(RegExp('  '), '_')),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                for ( var i in optionList(foundAbbr[index][2]) )
                                  Text(i.toString().split(new RegExp(r'(?:\r?\n|\r)'))
                                      .where((s) => s.trim().length != 0)
                                      .join('\n'), style: const TextStyle( color: Colors.green, fontWeight: FontWeight.bold)),
                              ],
                            ),
                            // Text(foundAbbr[index][2],
                            //   style: const TextStyle( color: Colors.green, fontWeight: FontWeight.bold)),
                            Text("Ans: "+ foundAbbr[index][3], style: const TextStyle( color: Colors.red, fontWeight: FontWeight.bold))
                          ],
                        ),
                        // trailing: Text(foundWords[index]['id'].toString()),
                      ),
                    );
                  }):  const Center(child: Text("Nothing Found"))
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


