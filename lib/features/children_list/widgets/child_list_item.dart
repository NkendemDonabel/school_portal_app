import 'package:flutter/material.dart';
import '../models/child_model.dart';

class ChildListItem extends StatelessWidget {
  final Child child;
  final bool isSelected;
  final ValueChanged<bool?> onChanged;

  const ChildListItem({
    super.key,
    required this.child,
    required this.isSelected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: isSelected ? Theme.of(context).primaryColor : Colors.grey.shade300,
          width: isSelected ? 2 : 1,
        ),
      ),
      child: CheckboxListTile(
        value: isSelected,
        onChanged: onChanged,
        title: Text(
          child.name,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          'Grade: ${child.grade}',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey.shade600,
          ),
        ),
        secondary: CircleAvatar(
          radius: 25,
          backgroundColor: Theme.of(context).primaryColor.withValues(alpha: 0.1),
          child: child.photoUrl != null
              ? ClipOval(
                  child: Image.network(
                    child.photoUrl!,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(
                        Icons.child_care,
                        color: Theme.of(context).primaryColor,
                      );
                    },
                  ),
                )
              : Icon(
                  Icons.child_care,
                  color: Theme.of(context).primaryColor,
                ),
        ),
        controlAffinity: ListTileControlAffinity.leading,
        contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      ),
    );
  }
}


