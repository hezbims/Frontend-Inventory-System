import 'package:flutter/material.dart';

class SubmitButton extends FilledButton {
  final void Function()? onTap;
  final String label;
  SubmitButton({
    super.key,
    required this.onTap,
    this.label = "Submit",
  }) : super(
    onPressed: onTap,
    child: Text(label),
  );
}