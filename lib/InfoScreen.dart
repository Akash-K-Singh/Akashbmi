import 'package:flutter/material.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Information"),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: SingleChildScrollView(
          child: Column(children: [
            Row(children: [
              Container(
                  height: 100,
                  width: 100,
                  child: Image.asset("assets/images/wtmachine.png")),
              SizedBox(
                width: 10,
              ),
              Text(
                "bmiRange",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              )
            ]),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.circle,
                        color: Colors.deepPurple,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text("Severely underweight"),
                    ],
                  ),
                  Text("< 16")
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.circle,
                        color: Colors.purple,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text("Very underweight"),
                    ],
                  ),
                  Text("16.0 - 16.9")
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.circle,
                        color: Colors.blue,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text("Underweight"),
                    ],
                  ),
                  Text("17.0 - 18.4")
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.circle,
                        color: Colors.green,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text("Normal"),
                    ],
                  ),
                  Text("18.5 - 24.9")
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.circle,
                        color: Colors.grey,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text("Overweight"),
                    ],
                  ),
                  Text("25.5 - 29.9")
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.circle,
                        color: Colors.brown,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text("Obese Class 1"),
                    ],
                  ),
                  Text("30.0 - 34.9")
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.circle,
                        color: Colors.deepOrange,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text("Obese Class 2"),
                    ],
                  ),
                  Text("35.0 - 39.9")
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.circle,
                        color: Colors.orange,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text("Obese Class 3"),
                    ],
                  ),
                  Text("> 40")
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Text(
                  "What is BMI?",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Wrap(
              children: [
                Text(
                    "BMI stands for Body Mass Index. It is a numerical value of a person's weight in relation to their height. BMI is commonly used as a simple and quick screening tool to identify possible weight problems in adults. It is calculated by dividing a person's weight in kilograms by the square of their height in meters. The formula is BMI = weight (kg) / (height (m))^2."),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Wrap(
              children: [
                Text(
                    "BMI is often used to categorize individuals into different weight status categories, such as underweight, normal weight, overweight, and obesity. While it can provide a general indication of whether a person has a healthy body weight, it does not directly measure body fat and may not account for muscle mass, bone density, and distribution of fat. Therefore, it is recommended to consider other health assessments alongside BMI for a more comprehensive evaluation of an individual's health."),
              ],
            ),
            SizedBox(
              height: 30,
            ),
          ]),
        ),
      ),
    );
  }
}
