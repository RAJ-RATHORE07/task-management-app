import 'package:flutter/material.dart';
import '../models/task_model.dart';
import '../services/api_service.dart';

class TaskProvider extends ChangeNotifier {
  List<Task> tasks = [];
  bool isLoading = false;

  String search = "";
  String status = "";

  Future<void> loadTasks() async {
    isLoading = true;
    notifyListeners();

    tasks = await ApiService().fetchTasks(search, status);

    isLoading = false;
    notifyListeners();
  }
}