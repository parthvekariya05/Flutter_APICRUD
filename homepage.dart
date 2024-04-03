import 'package:api_crud/Database.dart';
import 'package:api_crud/adduser.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class homepage extends StatefulWidget {
  const homepage({super.key});

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  static const String TravellerName = "TravellerName";
  static const String ExpenseAmount = "ExpenseAmount";
  static const String id = "id";
  List<dynamic> userList = [];
  List<dynamic> tempList = [];

  ApiExecutor api = new ApiExecutor();

  @override
  void initState() {
    super.initState();
    tempList.addAll(userList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("API"), actions: [
        IconButton(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(
                builder: (context) => AddUser(),
              ))
                  .then((value) {
                if (value != null) {
                  setState(() {
                    userList.clear();
                    tempList.clear();
                  });
                }
              });
            },
            icon: Icon(Icons.add))
      ]),
      body: Column(children: [
        Expanded(
            child: FutureBuilder(
          future: api.getAllUsingApi(),
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data != null) {
              userList.clear();
              tempList.clear();
              userList.addAll(snapshot.data!);
              tempList.addAll(userList);
              if (tempList.isNotEmpty) {
                return ListView.builder(
                  itemCount: userList.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) =>
                                AddUser(),
                          ),
                        )
                            .then((value) {
                          if (value == true) {
                            setState(() {});
                          }
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 5),
                        decoration: BoxDecoration(
                            color: Colors.grey),
                        child: ListTile(
                          title: Text(tempList[index][TravellerName]),
                          subtitle: Text(tempList[index][ExpenseAmount]),
                          trailing: IconButton(
                              icon: Icon(
                                Icons.delete,
                                size: 30,
                              ),
                              onPressed: () {
                                return showDeleteDialog(index);
                              }),
                        ),
                      ),
                    );
                  },
                );
              } else {
                return Center(child: Text("No Data Found"));
              }
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ))
      ]),
    );
  }

  void showDeleteDialog(index) {
    showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text('Alert!!'),
          content: Text("તમને ખાતરી છે કે તમે ડિલીટ કરવા માંગો છો"),
          actions: [
            TextButton(
                onPressed: () {
                  api.deleteData(userList[index][id]);
                  setState(() {});
                  Navigator.of(context).pop();
                },
                child: Text("YES")),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("NO")),
          ],
        );
      },
    );
  }
}
