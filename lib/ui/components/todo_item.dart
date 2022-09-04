import 'package:flutter/material.dart';

class TodoItem extends StatelessWidget {
  const TodoItem({
    Key? key,
    required this.description,
  }) : super(key: key);

  final String description;

  @override
  Widget build(BuildContext context) {
    final itemFocusNode = FocusNode();

    return Material(
      color: Colors.white,
      child: Focus(
        focusNode: itemFocusNode,
        onFocusChange: (focused) {},
        child: Container(
          decoration: const BoxDecoration(
            border: Border(
              left: BorderSide(
                color: Color(0xFFEEEEEE),
              ),
              right: BorderSide(
                color: Color(0xFFEEEEEE),
              ),
              top: BorderSide(
                color: Color(0xFFEEEEEE),
              ),
            ),
          ),
          child: Column(
            children: [
              ListTile(
                onTap: () {},
                leading: Checkbox(
                  value: true,
                  onChanged: (value) {},
                ),
                title: Text(description),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
