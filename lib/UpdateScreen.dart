import 'package:flutter/material.dart';
import 'package:mybmi/BmiDataModel.dart';
import 'package:mybmi/DBHandler.dart';

class UpdateScreen extends StatefulWidget {
  const UpdateScreen(
      {super.key,
      required this.updateId,
      required this.weight,
      required this.feet,
      required this.inch,
      required this.date,
      required this.bmiValue});

  final int updateId;
  final int weight;
  final int feet;
  final int inch;
  final String date;
  final String bmiValue;

  @override
  State<StatefulWidget> createState() {
    return UpdateScreenState();
  }
}

class UpdateScreenState extends State<UpdateScreen> {
  var wtController = TextEditingController();
  var ftController = TextEditingController();
  var inController = TextEditingController();
  var selectedDate = "";

  var bmiValue = "";

  DBHelper? dbHelper;
  late Future<List<BmiDataModel>> bmiDataList;

  @override
  void initState() {
    super.initState();
    dbHelper = DBHelper();
    loadData();
  }

  loadData() async {
    bmiDataList = dbHelper!.getBmiDataList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Update"),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Padding(
          padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 21,
                ),
                Text(
                  "${widget.date}",
                  style: TextStyle(fontSize: 30),
                ),
                SizedBox(
                  height: 21,
                ),
                TextField(
                  controller: wtController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      label: Text("${widget.weight} KGs"),
                      border: new OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.teal)),
                      prefixIcon: Icon(Icons.line_weight)),
                ),
                SizedBox(
                  height: 21,
                ),
                TextField(
                  controller: ftController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      label: Text("${widget.feet} Ft."),
                      border: new OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.teal)),
                      prefixIcon: Icon(Icons.line_weight)),
                ),
                SizedBox(
                  height: 21,
                ),
                TextField(
                  controller: inController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      label: Text("${widget.inch} In."),
                      border: new OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.teal)),
                      prefixIcon: Icon(Icons.line_weight)),
                ),
                SizedBox(
                  height: 21,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    OutlinedButton(
                        onPressed: () async {
                          DateTime? datePicked = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2021),
                              lastDate: DateTime(2025));
                          if (datePicked != null) {
                            String month = datePicked.month.toString();
                            String day = datePicked.day.toString();
                            String year = datePicked.year.toString();

                            setState(() {
                              selectedDate = year +
                                  " / " +
                                  "${int.parse(month) < 10 ? '0' + month : month}" +
                                  " / " +
                                  "${int.parse(day) < 10 ? '0' + day : day}";
                            });
                          }
                        },
                        child: Text(
                            "${selectedDate == "" ? widget.date : selectedDate}")),
                    ElevatedButton(
                        onPressed: () {
                          FocusScope.of(context).unfocus();

                          var weight = wtController.text.toString();
                          var feet = ftController.text.toString();
                          var inch = inController.text.toString();

                          if (weight == "") {
                            weight = widget.weight.toString();
                          }
                          if (feet == "") {
                            feet = widget.feet.toString();
                          }
                          if (inch == "") {
                            inch = widget.inch.toString();
                          }
                          if (selectedDate == "") {
                            selectedDate = widget.date.toString();
                          }
                          //BMI calc
                          var iWeight = int.parse(weight);
                          var iFeet = int.parse(feet);
                          var iInch = int.parse(inch);

                          var tInch = (iFeet * 12) + iInch;
                          var tCm = tInch * 2.54;
                          var tM = tCm / 100;

                          var bmi = iWeight / (tM * tM);

                          setState(() {
                            bmiValue = bmi.toStringAsFixed(2);
                          });

                          dbHelper!
                              .update(BmiDataModel(
                                  id: widget.updateId,
                                  date: selectedDate,
                                  weight: iWeight,
                                  feets: iFeet,
                                  inches: iInch,
                                  bmiValue: bmiValue))
                              .then((value) => print("updated"));
                          setState(() {
                            bmiDataList = dbHelper!.getBmiDataList();
                          });
                          Navigator.pop(context);
                        },
                        child: Text("Update")),
                  ],
                ),
                SizedBox(
                  height: 21,
                ),
                Text(
                  "${bmiValue == "" ? widget.bmiValue : bmiValue}",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                SizedBox(
                  height: 11,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
