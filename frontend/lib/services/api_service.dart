import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/task_model.dart';
import '../core/constants.dart';

class ApiService {
  Future<List<Task>> fetchTasks(String search, String status) async {
    final res = await http.get(
      Uri.parse("$baseUrl/tasks?search=$search&status=$status"),
    );

    final data = jsonDecode(res.body);
    return data.map<Task>((e) => Task.fromJson(e)).toList();
  }

  Future<void> createTask(Map data) async {
    await http.post(
      Uri.parse("$baseUrl/tasks/"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(data),
    );
  }

  Future<void> updateTask(int id, Map data) async {
    await http.put(
      Uri.parse("$baseUrl/tasks/$id"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(data),
    );
  }

  Future<void> deleteTask(int id) async {
    await http.delete(Uri.parse("$baseUrl/tasks/$id"));
  }
}