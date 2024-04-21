import 'package:flutter/material.dart';

import '../task_controller.dart';

class PriorityDropdownButton extends StatefulWidget {
  final Priority initialValue;
  final ValueChanged<Priority> onChanged;

  const PriorityDropdownButton({
    super.key,
    required this.initialValue,
    required this.onChanged,
  });

  @override
  State<PriorityDropdownButton> createState() => _PriorityDropdownButtonState();
}

class _PriorityDropdownButtonState extends State<PriorityDropdownButton> {
  late Priority _selectedPriority;

  @override
  void initState() {
    super.initState();
    _selectedPriority = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<Priority>(
      value: _selectedPriority,
      icon: const Icon(Icons.arrow_drop_down),
      iconSize: 24,
      elevation: 16,
      onChanged: (Priority? newValue) {
        setState(() {
          _selectedPriority = newValue!;
        });
        widget.onChanged(newValue!);
      },
      validator: (value) {
        if (value == null) {
          return 'Please select a priority';
        }
        return null;
      },
      items: Priority.values.map<DropdownMenuItem<Priority>>((Priority value) {
        return DropdownMenuItem<Priority>(
          value: value,
          child: Text(
            value.name.substring(0, 1).toUpperCase() +
                value.name.substring(1).toLowerCase(),
          ),
        );
      }).toList(),
    );
  }
}
