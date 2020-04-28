import 'package:flutter/material.dart';

class DashLineWidget extends StatelessWidget {
  final double lineLength;//线长
  final double gapLength;//间隙长
  final double width;//线粗
  final Color color;
  final Axis direction;

  const DashLineWidget({this.width = 1, this.lineLength = 5, this.gapLength = 5, this.color = Colors.grey, this.direction = Axis.horizontal});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final total = direction == Axis.horizontal ? constraints.constrainWidth() : constraints.constrainHeight();
        final dashCount = (total / (lineLength + gapLength)).floor();
        return Flex(
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: direction == Axis.horizontal ? lineLength : width,
              height: direction == Axis.horizontal ? width : lineLength,
              child: DecoratedBox(
                decoration: BoxDecoration(color: color),
              ),
            );
          }),
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: direction,
        );
      },
    );
  }
}
