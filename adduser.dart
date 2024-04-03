import 'package:api_crud/Database.dart';
import 'package:flutter/material.dart';

class AddUser extends StatelessWidget {
  Map<String, dynamic>? userData;

  AddUser({this.userData}) {
    nameController.text =
        userData != null ? userData![ApiExecutor.TravellerName] : "";
    expenseController.text =
        userData != null ? userData![ApiExecutor.ExpenseAmount] : "";
  }

  ApiExecutor api = ApiExecutor();
  GlobalKey<FormState> _formkey = GlobalKey();
  TextEditingController nameController = TextEditingController();
  TextEditingController expenseController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("${userData != null ? "Edit" : "Add"} User")),
      body: Form(
          key: _formkey,
          child: Column(
            children: [
              TextFormField(
                controller: nameController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please Enter Name ";
                  }
                },
                decoration: InputDecoration(
                    hintText: "Enter Name", labelText: "Enter Name "),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: expenseController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please Enter Expance ";
                  }
                },
                decoration: InputDecoration(
                    hintText: "Enter Expance", labelText: "Enter Expance "),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () async {
                    if (_formkey.currentState!.validate()) {
                      if (userData == null) {
                        Map<String, dynamic> map = {};
                        map[ApiExecutor.TravellerName] =
                            nameController.text;
                        map[ApiExecutor.ExpenseAmount] =
                            expenseController.text;

                        Map<dynamic, dynamic> userMap =
                            await api.insertData(map);

                        if (userMap != null) {
                          Navigator.of(context).pop(true);
                        }
                      } else{
                        userData![ApiExecutor.TravellerName] = nameController.text.toString();
                        userData![ApiExecutor.ExpenseAmount] = expenseController.text.toString();
                        Map<dynamic,dynamic> userList = await api.updateData(userData!);
                        Navigator.of(context).pop(true);

                      }
                    }
                  },
                  child: const Text("Submit")),
            ],
          )),
    );
  }
}