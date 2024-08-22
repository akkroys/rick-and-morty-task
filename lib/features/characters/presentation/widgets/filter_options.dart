// filter_options.dart
import 'package:flutter/material.dart';

class FilterOptions extends StatelessWidget {
  final String selectedStatus;
  final String selectedSpecies;
  final ValueChanged<String?> onStatusChanged;
  final ValueChanged<String?> onSpeciesChanged;
  final VoidCallback onReset;

  const FilterOptions({
    super.key,
    required this.selectedStatus,
    required this.selectedSpecies,
    required this.onStatusChanged,
    required this.onSpeciesChanged,
    required this.onReset,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.bottomNavigationBarTheme.selectedItemColor!;
    
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(left: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey),
              ),
              child: DropdownButton<String>(
                value: selectedStatus,
                onChanged: onStatusChanged,
                items: ['All', 'Alive', 'Dead', 'unknown']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                underline: const SizedBox(),
                isExpanded: true,
                icon: Icon(Icons.arrow_drop_down, color: primaryColor),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(left: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey),
              ),
              child: DropdownButton<String>(
                value: selectedSpecies,
                onChanged: onSpeciesChanged,
                items: ['All', 'Alien', 'Human']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                underline: const SizedBox(),
                isExpanded: true,
                icon: Icon(Icons.arrow_drop_down, color: primaryColor),
              ),
            ),
          ),
          const SizedBox(width: 10),
          ElevatedButton(
            onPressed: onReset,
            child: const Text('Reset'),
          ),
        ],
      ),
    );
  }
}
