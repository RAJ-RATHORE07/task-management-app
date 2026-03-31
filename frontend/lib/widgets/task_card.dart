import 'package:flutter/material.dart';
import '../models/task_model.dart';
import '../services/api_service.dart';
import '../screens/task_form_screen.dart';

class TaskCard extends StatelessWidget {
  final Task task;
  final bool isBlocked;
  final Function refresh;

  const TaskCard({
    super.key,
    required this.task,
    required this.isBlocked,
    required this.refresh,
  });

  Color getStatusColor() {
    switch (task.status) {
      case "Done":
        return Colors.green;
      case "In Progress":
        return Colors.orange;
      case "To-Do":
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  IconData getStatusIcon() {
    switch (task.status) {
      case "Done":
        return Icons.check_circle;
      case "In Progress":
        return Icons.hourglass_top;
      case "To-Do":
        return Icons.radio_button_unchecked;
      default:
        return Icons.help;
    }
  }

  @override
  Widget build(BuildContext context) {
    final statusColor = getStatusColor();

    return Opacity(
      opacity: isBlocked ? 0.5 : 1,
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              left: BorderSide(
                color: statusColor,
                width: 5,
              ),
            ),
            color: task.status == "Done"
                ? Colors.green[50]
                : Colors.white,
          ),
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  Expanded(
                    child: Text(
                      task.title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        decoration: task.status == "Done"
                            ? TextDecoration.lineThrough
                            : null,
                      ),
                    ),
                  ),

                  Row(
                    children: [
                      Icon(getStatusIcon(),
                          size: 16, color: statusColor),
                      const SizedBox(width: 4),
                      Text(
                        task.status,
                        style: TextStyle(
                          color: statusColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 6),

              Text(task.description),

              const SizedBox(height: 4),

              Text(
                "Due: ${task.dueDate}",
                style: const TextStyle(color: Colors.grey),
              ),

              if (isBlocked)
                const Text("Blocked",
                    style: TextStyle(color: Colors.red)),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [

                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.blue),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => TaskFormScreen(task: task),
                        ),
                      );
                    },
                  ),

                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () async {
                      await ApiService().deleteTask(task.id);
                      refresh();
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}