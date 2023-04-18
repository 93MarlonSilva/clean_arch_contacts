import 'package:flutter/material.dart';
import 'package:rx_notifier/rx_notifier.dart';

class ShowSnackBarModal extends StatelessWidget {
  const ShowSnackBarModal({super.key});

  @override
  Widget build(BuildContext context) {
    String message = '';
    return RxBuilder(
      builder: (context) {
        return SnackBar(
          content: Center(child: Text(message)),
          action: SnackBarAction(
            label: 'Undo',
            onPressed: () {},
          ),
        );
      },
    );
  }
}
