import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

Widget loading() {
  return Container(
    child: Center(
      child: SpinKitCubeGrid(
        size: 100,
        itemBuilder: (context, index) {
          return DecoratedBox(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: index.isEven ? Colors.red : Colors.green,
            ),
          );
        },
      ),
    ),
  );
}

Widget error(String error) {
  return Container(
    child: Center(
      child: Text(
        error,
        style: TextStyle(
          color: Colors.red,
        ),
      ),
    ),
  );
}
