import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/task_provider.dart';
import '../services/api_service.dart';

class TaskFormScreen extends StatefulWidget {
  final dynamic task;

  TaskFormScreen({this.task});

  @override
  State<TaskFormScreen> createState() => _TaskFormScreenState();
}

class _TaskFormScreenState extends State<TaskFormScreen> {
  final title = TextEditingController();
  final desc = TextEditingController();

  String status = "To-Do";
  DateTime? selectedDate;
  int? blockedBy;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    if (widget.task != null) {
      title.text = widget.task.title;
      desc.text = widget.task.description;
      status = widget.task.status;
      selectedDate = DateTime.parse(widget.task.dueDate);
      blockedBy = widget.task.blockedBy;
    }
  }

  void save() async {
    setState(() => isLoading = true);

    final data = {
      "title": title.text,
      "description": desc.text,
      "status": status,
      "due_date": selectedDate.toString().split(" ")[0],
      "blocked_by": blockedBy,
    };

    if (widget.task != null) {
      await ApiService().updateTask(widget.task.id, data);
    } else {
      await ApiService().createTask(data);
    }

    await Provider.of<TaskProvider>(context, listen: false).loadTasks();

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TaskProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Task Form")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: title,
              decoration: const InputDecoration(labelText: "Title"),
            ),
            TextField(
              controller: desc,
              decoration: const InputDecoration(labelText: "Description"),
            ),

            const SizedBox(height: 10),

            ElevatedButton(
              onPressed: () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2020),
                  lastDate: DateTime(2100),
                );
                if (picked != null) {
                  setState(() => selectedDate = picked);
                }
              },
              child: Text(selectedDate == null
                  ? "Select Due Date"
                  : selectedDate.toString().split(" ")[0]),
            ),

            const SizedBox(height: 10),

            DropdownButtonFormField<String>(
              value: status,
              items: ["To-Do", "In Progress", "Done"]
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (v) => setState(() => status = v!),
            ),

           

            const SizedBox(height: 10),

            DropdownButtonFormField<int>(
              hint: const Text("Blocked By"),
              value: blockedBy,
              items: provider.tasks
                  .map((t) => DropdownMenuItem(
                        value: t.id,
                        child: Text(t.title),
                      ))
                  .toList(),
              onChanged: (v) => setState(() => blockedBy = v),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: isLoading ? null : save,
              child: isLoading
                  ? const CircularProgressIndicator()
                  : const Text("Save"),
            ),
          ],
        ),
      ),
    );
  }
}