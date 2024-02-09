import 'package:flutter/material.dart';
import 'package:mybmi/BmiDataModel.dart';
import 'package:mybmi/DBHandler.dart';
import 'package:mybmi/UpdateScreen.dart';

class HistoryScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HistoryScreenState();
  }
}

class HistoryScreenState extends State<HistoryScreen> {
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
        title: Text("History"),
      ),
      body: Container(
          margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: FutureBuilder(
              future: bmiDataList,
              builder: (context, AsyncSnapshot<List<BmiDataModel>> snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    reverse: false,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UpdateScreen(
                                        updateId: snapshot.data![index].id!,
                                        weight: snapshot.data![index].weight,
                                        feet: snapshot.data![index].feets,
                                        inch: snapshot.data![index].inches,
                                        date: snapshot.data![index].date,
                                        bmiValue:
                                            snapshot.data![index].bmiValue,
                                      ))).then((_) => {
                                setState(() {
                                  // refresh the history after update
                                  bmiDataList = dbHelper!.getBmiDataList();
                                })
                              });
                        },
                        child: Dismissible(
                          key: ValueKey<int>(snapshot.data![index].id!),
                          direction: DismissDirection.endToStart,
                          background: Container(
                            color: Colors.red,
                            child: Icon(Icons.delete_forever),
                          ),
                          onDismissed: (DismissDirection direction) {
                            setState(() {
                              dbHelper!.delete(snapshot.data![index].id!);
                              bmiDataList = dbHelper!.getBmiDataList();
                              snapshot.data!.remove(snapshot.data![index]);
                            });
                          },
                          child: Container(
                              margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                              height: 80,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.green),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    snapshot.data![index].bmiValue,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "${snapshot.data![index].weight} KG",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                    ),
                                  ),
                                  Text(
                                      "${snapshot.data![index].feets}ft ${snapshot.data![index].inches}in",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                      )),
                                  Text(
                                    "${snapshot.data![index].date}",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              )),
                        ),
                      );
                    },
                    itemCount: snapshot.data?.length,
                  );
                } else {
                  return CircularProgressIndicator();
                }
              })),
    );
  }
}
