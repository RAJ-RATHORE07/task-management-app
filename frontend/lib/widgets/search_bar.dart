import 'package:flutter/material.dart';
import '../utils/debounce.dart';

class SearchBarWidget extends StatelessWidget {
  final Function(String) onChanged;
  final Debouncer debouncer = Debouncer(300);

  SearchBarWidget({super.key, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: "Search tasks...",
        prefixIcon: const Icon(Icons.search),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
      onChanged: (value) {
        debouncer.run(() => onChanged(value));
      },
    );
  }
}