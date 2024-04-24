import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DialogUtils {
  final BuildContext context;
  DialogUtils(this.context);
  showLoader() {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return const SimpleDialog(
          children: [
            Center(
              child: CircularProgressIndicator(),
            ),
          ],
        );
      },
    );
  }

  void hideLoader() {
    context.pop();
  }
}
