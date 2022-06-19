import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class GlobalMethods {
  static Future<void> errorDialog(
      {required String errorMessage, required BuildContext context}) async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(errorMessage),
            title: Row(
              children: const [
                Icon(
                  IconlyBold.danger,
                  color: Colors.red,
                ),
                SizedBox(
                  width: 8,
                ),
                Text('An error occured'),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  if (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  }
                },
                child: const Text('Ok'),
              ),
            ],
          );
        });
  }
}
