import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/task_provider.dart';
import '../widgets/task_card.dart';       // ✅ correct
import '../widgets/search_bar.dart';
import 'task_form_screen.dart';           // ✅ correct

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<TaskProvider>(context, listen: false).loadTasks());
  }

  // ✅ SAFE BLOCKED LOGIC
  bool isBlocked(task, tasks) {
    if (task.blockedBy == null) return false;

    final blocker = tasks.where((t) => t.id == task.blockedBy).toList();

    if (blocker.isEmpty) return false;

    return blocker.first.status != "Done";
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TaskProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Task Manager")),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => TaskFormScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            // 🔍 SEARCH
            SearchBarWidget(
              onChanged: (val) {
                provider.search = val;
                provider.loadTasks();
              },
            ),

            const SizedBox(height: 10),

            // 📊 FILTER
            DropdownButton<String>(
              hint: const Text("Filter Status"),
              value: provider.status.isEmpty ? null : provider.status,
              items: ["To-Do", "In Progress", "Done"]
                  .map((e) => DropdownMenuItem(
                        value: e,
                        child: Text(e),
                      ))
                  .toList(),
              onChanged: (val) {
                provider.status = val!;
                provider.loadTasks();
              },
            ),

            const SizedBox(height: 10),

            // 📦 TASK LIST
            provider.isLoading
                ? const Expanded(
                    child: Center(child: CircularProgressIndicator()))
                : Expanded(
                    child: ListView.builder(
                      itemCount: provider.tasks.length,
                      itemBuilder: (context, index) {
                        final task = provider.tasks[index];

                        return TaskCard(
                          task: task,
                          isBlocked: isBlocked(task, provider.tasks),
                          refresh: provider.loadTasks,
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}