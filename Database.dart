import "dart:convert";
import "package:http/http.dart" as http;

class ApiExecutor {
  String API_URL = "https://65e7b5c853d564627a8f2940.mockapi.io/TravelExpense";

  static const String TravellerName = "TravellerName";
  static const String ExpenseAmount = "ExpenseAmount";
  static const String id = "id";

  Future<List<dynamic>> getAllUsingApi() async {
    http.Response res = await http.get(Uri.parse(API_URL));
    List<dynamic> userList = jsonDecode(res.body);
    return userList;
  }

  Future<Map<String, dynamic>> deleteData(String id) async {
    http.Response res = await http.delete(Uri.parse(API_URL + '/' + id));
    Map<String, dynamic> userList = jsonDecode(res.body);
    return userList;
  }

  Future<Map<dynamic,dynamic>> insertData(Map<String,dynamic> map) async {
    http.Response res = await http.post(Uri.parse(API_URL),body: map);
    Map<dynamic,dynamic> userList = jsonDecode(res.body);
    return userList;
  }
  Future<Map<dynamic,dynamic>> updateData(Map<dynamic,dynamic> map) async {
    http.Response res = await http.put(Uri.parse(API_URL + '/' + map[id]),body: map);
    Map<dynamic,dynamic> userList = jsonDecode(res.body);
    return userList;
  }
}