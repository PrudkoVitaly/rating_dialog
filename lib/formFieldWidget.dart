import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FormFieldWidget extends StatefulWidget {
  final TextEditingController textEditingController;
  FormFieldWidget({
    Key? key,
    required this.textEditingController,
  }) : super(key: key);

  @override
  State<FormFieldWidget> createState() => _FormFieldWidgetState();
}

class _FormFieldWidgetState extends State<FormFieldWidget> {
  late TextEditingController textEditingController;

  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: TextField(
            controller: textEditingController,
            decoration: InputDecoration(
              hintText: "Write your review here",
              hintStyle: TextStyle(
                color: Colors.grey[400],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
