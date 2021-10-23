import 'package:flutter/material.dart';
import 'package:flutter_spinbox/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guess_teacher_age/services/api.dart';

class GuessAge extends StatefulWidget {
  const GuessAge({Key? key}) : super(key: key);

  @override
  _GuessAgeState createState() => _GuessAgeState();
}

class _GuessAgeState extends State<GuessAge> {
  int _month = 0;
  int _year = 0;
  var _isLoading = false;
  bool _guessAge = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("GUESS TEACHER'S AGE"),
      ),
      body: Container(
        child: SafeArea(
          child: Stack(
            children: [
              if(!_guessAge)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("อายุอาจารย์", style: Theme.of(context).textTheme.headline1,),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                            width: 4,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            children: [
                              SpinBox(
                                decoration: InputDecoration(labelText: 'ปี', labelStyle:Theme.of(context).textTheme.bodyText1 ),
                                value: 1,
                                onChanged: (value) {
                                  setState(() {
                                    _year = value as int;
                                  });
                                },
                              ),
                              SpinBox(
                                decoration: InputDecoration(labelText: 'เดือน', labelStyle:Theme.of(context).textTheme.bodyText1 ),
                                value: 1,
                                max: 1000,
                                onChanged: (value) {
                                  setState(() {
                                    _month = value as int;
                                  });
                                },
                              ),
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: ElevatedButton(
                                    onPressed: guessClickButton,
                                    child: Text("ทาย", style: Theme.of(context).textTheme.bodyText2,)
                                ),
                              )
                            ],
                          ),
                        ),

                      )
                    ],
                  ),
                ),
              if(_guessAge)
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: Text(
                          'อายุอาจารย์',
                          style: GoogleFonts.lato(fontSize: 30.0),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: Text(
                          '${_year} ปี ${_month} เดือน',
                          style: GoogleFonts.lato(fontSize: 24.0),
                        ),
                      ),
                      Icon(
                        Icons.done,
                        color: Colors.green,
                        size: 80.0,
                      ),
                    ],
                  ),
                ),
              if (_isLoading)
                Container(
                  color: Colors.black.withOpacity(0.5),
                  child: Center(
                    child: SizedBox(
                      width: 200.0,
                      height: 200.0,
                      child: CircularProgressIndicator(color: Colors.white),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  void guessClickButton() async {
    print("${_year} ${_month} ");
    var data = await _guess();

    if (data == null) return;

    bool value = data["value"];
    String text = data["text"];

    if (value) {
      setState(() {
        _guessAge = true;
      });
    } else {
      _showMaterialDialog('ผลการทาย', text);
    }
  }

  Future<Map<String, dynamic>?> _guess() async {
    try {
      setState(() {
        _isLoading = true;
      });
      var data = (await Api().submit('guess_teacher_age', {'year': _year, 'month': _month})) as Map<String, dynamic>;
      return data;
    } catch (e) {
      print(e);
      _showMaterialDialog('ERROR', e.toString());
      return null;
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showMaterialDialog(String title, String msg) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(msg, style: Theme.of(context).textTheme.bodyText2),
          actions: [
            // ปุ่ม OK ใน dialog
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                // ปิด dialog
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
