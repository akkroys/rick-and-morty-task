import 'package:flutter/material.dart';
import 'package:rick_morty_task/core/platform/network_info.dart';
import 'package:rick_morty_task/injection_container.dart' as di;

Future<void> showNoInternetDialog(BuildContext context) async {
  final networkInfo = di.sl<NetworkInfo>();

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        title: const Text('No internet connection'),
        content: const Text('Please check your internet connection and try again.'),
        actions: <Widget>[
          TextButton(
            onPressed: () async {
              if (await networkInfo.isConnected) {
                Navigator.of(context).pop();
              } else {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('No internet connection. Showing cached data.'),
                  ),
                );
              }
            },
            child: const Text('Try again'),
          ),
        ],
      );
    },
  ).then((_) {
    if (!Navigator.of(context).canPop()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Internet's connected."),
        ),
      );
    }
  });
}
