import 'package:flutter/material.dart';

class LoadingK extends StatelessWidget {
  const LoadingK({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return const Center(
      child: CircularProgressIndicator(
        color: Colors.black,
      ),
    );
  }
}
