import 'package:flutter/material.dart';

import '../services/utils.dart';

class EmptyNewsWidget extends StatelessWidget {
  const EmptyNewsWidget({Key? key, required this.text, required this.imagePath})
      : super(key: key);
  final String text, imagePath;
  @override
  Widget build(BuildContext context) {
    Color color = Utils(context).getColor;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Image.asset(
              imagePath,
            ),
          ),
          Flexible(
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: color, fontSize: 30, fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }
}
