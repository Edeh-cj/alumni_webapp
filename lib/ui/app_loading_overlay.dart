import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../controllers/_.dart';

appLoadingOverlay ({required Widget child})=> Builder(
  builder: (context) {
    return Stack(
      children: [
        child,
        Visibility(
          visible: context.watch<Controller>().isLoading,
          child: Container(
            color: Colors.white10,
            alignment: Alignment.center,
            child: const SizedBox.square(
              dimension: 30,
              child: CircularProgressIndicator(),
            ),
          ),
        )
      ],
    );
  }
);