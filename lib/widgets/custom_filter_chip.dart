import 'package:flutter/material.dart';

import '../constants/style.dart';

class CustomFilterChip extends StatelessWidget {
  const CustomFilterChip({
    super.key,
    required this.label,
    required this.onSelected,
    this.selected = false,
  });

  final String label;
  final Function(bool) onSelected;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      showCheckmark: false,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
      side: BorderSide.none,
      label: Text(
        label,
        style: KStyle.tBodyTextStyle.copyWith(
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
      backgroundColor: Colors.black.withOpacity(0.5),
      selected: selected,
      selectedColor: KStyle.cAccent,
      onSelected: onSelected,
    );
  }
}
