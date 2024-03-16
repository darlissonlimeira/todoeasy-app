import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String? labelText;
  final String hintText;
  final bool hiddenText;

  const InputField(
      {super.key,
      this.labelText,
      required this.hintText,
      required this.hiddenText});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        labelText != null
            ? Text(
                '$labelText:',
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              )
            : const SizedBox.shrink(),
        const SizedBox(
          height: 10,
        ),
        TextField(
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            decoration: InputDecoration(
              hintText: hintText,
            ))
      ],
    );
  }
}
