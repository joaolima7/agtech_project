import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final String title;
  final String message;
  final String confirmButtonText;
  final String cancelButtonText;
  final Function onConfirm;
  final Function? onCancel;
  final bool isEditMode;
  final TextEditingController? textController;
  final TextEditingController? nameController;

  const CustomDialog({
    Key? key,
    required this.title,
    required this.message,
    required this.confirmButtonText,
    required this.cancelButtonText,
    required this.onConfirm,
    this.onCancel,
    this.isEditMode = false,
    this.textController,
    this.nameController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: isEditMode
          ? Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: textController,
                  decoration: const InputDecoration(labelText: 'Descrição'),
                ),
                if (nameController != null)
                  TextField(
                    controller: nameController,
                    decoration: const InputDecoration(labelText: 'Nome'),
                  )
              ],
            )
          : Text(message),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            if (onCancel != null) onCancel!();
          },
          child: Text(cancelButtonText),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            onConfirm();
          },
          child: Text(confirmButtonText),
        ),
      ],
    );
  }
}
