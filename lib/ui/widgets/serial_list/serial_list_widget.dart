import 'package:cinema_app/ui/widgets/elements/radial_percent_widget.dart';
import 'package:flutter/material.dart';

class SerialListWidget extends StatelessWidget {
  const SerialListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 100,
        height: 100,
        child: const RadialPercentWidget(
          percent: 0.72,
          fillColor: Colors.black,
          lineColor: Colors.yellow,
          freeColor: Colors.red,
          lineWidth: 5,
          child: Text(
            '72',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
