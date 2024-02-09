import 'package:flutter/material.dart';
import 'package:mybmi/BmiDataModel.dart';
import 'package:mybmi/DBHandler.dart';
import 'package:mybmi/HistoryScreen.dart';
import 'package:mybmi/InfoScreen.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var wtController = TextEditingController();
  var ftController = TextEditingController();
  var inController = TextEditingController();
  var selectedDate = "Select Date";

  var bmiValue = "";
  var resColor = Color.fromARGB(255, 0, 0, 0);
  var message = "";

  DBHelper? dbHelper;
  late Future<List<BmiDataModel>> bmiDataList;

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
        title: Text(
          widget.title,
        ),
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
                Text(
                  "Welcome",
                  style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                SizedBox(
                  height: 21,
                ),
                Text(
                  "Calculate Your BMI",
                  style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                SizedBox(
                  height: 21,
                ),
                TextField(
                  controller: wtController,
                  keyboardType: TextInputType.number,
                  cursorColor: Colors.green,
                  style: TextStyle(
                      color: Colors.green,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                      label: Text(
                        "Enter your weight in kgs",
                        style: TextStyle(
                            color: Colors.green, fontWeight: FontWeight.bold),
                      ),
                      border: new OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: new BorderSide(
                            color: Colors.teal,
                          )),
                      prefixIcon: Icon(
                        Icons.line_weight,
                        color: Colors.green,
                      )),
                ),
                SizedBox(
                  height: 21,
                ),
                TextField(
                  controller: ftController,
                  keyboardType: TextInputType.number,
                  cursorColor: Colors.green,
                  style: TextStyle(
                      color: Colors.green,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                      label: Text(
                        "Enter your height (in feets)",
                        style: TextStyle(
                            color: Colors.green, fontWeight: FontWeight.bold),
                      ),
                      border: new OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: new BorderSide(color: Colors.teal)),
                      prefixIcon: Icon(
                        Icons.line_weight,
                        color: Colors.green,
                      )),
                ),
                SizedBox(
                  height: 21,
                ),
                TextField(
                  controller: inController,
                  keyboardType: TextInputType.number,
                  cursorColor: Colors.green,
                  style: TextStyle(
                      color: Colors.green,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                      label: Text(
                        "Enter Your height (in inches)",
                        style: TextStyle(
                            color: Colors.green, fontWeight: FontWeight.bold),
                      ),
                      border: new OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: new BorderSide(color: Colors.teal)),
                      prefixIcon: Icon(
                        Icons.line_weight,
                        color: Colors.green,
                      )),
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
                        child: Text(selectedDate,
                            style: TextStyle(
                                color: Colors.green,
                                fontSize: 20,
                                fontWeight: FontWeight.bold))),
                    ElevatedButton(
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          var weight = wtController.text.toString();
                          var feet = ftController.text.toString();
                          var inch = inController.text.toString();

                          if (weight != "" &&
                              feet != "" &&
                              inch != "" &&
                              selectedDate != "Select Date") {
                            //BMI calc
                            var iWeight = int.parse(weight);
                            var iFeet = int.parse(feet);
                            var iInch = int.parse(inch);

                            var tInch = (iFeet * 12) + iInch;
                            var tCm = tInch * 2.54;
                            var tM = tCm / 100;

                            var bmi = iWeight / (tM * tM);

                            if (bmi >= 40) {
                              resColor = Colors.orange;
                              message = "You are obese class 3";
                            } else if (bmi < 40 && bmi >= 35) {
                              resColor = Colors.deepOrange;
                              message = "You are obese class 2";
                            } else if (bmi < 35 && bmi >= 30) {
                              resColor = Colors.brown;
                              message = "You are obese class 1";
                            } else if (bmi < 30 && bmi >= 25) {
                              resColor = Colors.grey;
                              message = "You are overweight";
                            } else if (bmi < 25 && bmi >= 18.5) {
                              resColor = Colors.green;
                              message = "You are normal";
                            } else if (bmi < 18.5 && bmi >= 17) {
                              resColor = Colors.blue;
                              message = "You are underweight";
                            } else if (bmi < 17 && bmi >= 16) {
                              resColor = Colors.purple;
                              message = "You are very underweight";
                            } else {
                              resColor = Colors.deepPurple;
                              message = "You are severely underweight";
                            }

                            setState(() {
                              bmiValue = bmi.toStringAsFixed(2);
                            });

                            //unique date entries implementation

                            void checkDate() async {
                              print("checking here");
                              var idAvailableDate =
                                  await dbHelper!.doesDateExists(selectedDate);
                              if (idAvailableDate != -1) {
                                print("Data for this date already available");
                                dbHelper!
                                    .update(BmiDataModel(
                                        id: idAvailableDate,
                                        date: selectedDate,
                                        weight: iWeight,
                                        feets: iFeet,
                                        inches: iInch,
                                        bmiValue: bmiValue))
                                    .then((value) => print("updated"));
                                setState(() {
                                  bmiDataList = dbHelper!.getBmiDataList();
                                });
                              } else {
                                dbHelper!
                                    .insert(BmiDataModel(
                                        date: selectedDate,
                                        weight: iWeight,
                                        feets: iFeet,
                                        inches: iInch,
                                        bmiValue: bmiValue))
                                    .then((value) => print("data inserted"))
                                    .onError((error, stackTrace) =>
                                        print(error.toString()));
                              }
                            }

                            checkDate();
                          } else {
                            setState(() {
                              bmiValue = "Please fill all the required fields";
                            });
                          }
                        },
                        child: Text(
                          "Calculate",
                          style: TextStyle(
                              color: Colors.green,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        )),
                  ],
                ),
                SizedBox(
                  height: 21,
                ),
                Text(
                  "$bmiValue",
                  style: TextStyle(
                      color: resColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                SizedBox(
                  height: 11,
                ),
                Text(
                  "$message",
                  style: TextStyle(
                      color: resColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                SizedBox(
                  height: 31,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      child: Icon(
                        Icons.history,
                        size: 50,
                        color: Colors.green,
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HistoryScreen()));
                      },
                    ),
                    InkWell(
                      child: Icon(
                        Icons.info,
                        size: 50,
                        color: Colors.green,
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => InfoScreen()));
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
