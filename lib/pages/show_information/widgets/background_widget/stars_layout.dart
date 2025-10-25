import 'dart:math';

import 'package:flutter/material.dart';
import 'package:name_badge/pages/show_information/widgets/background_widget/star_painter.dart';

class StarsLayout {
  final BuildContext context;

  StarsLayout(this.context);

  Size get screenSize => MediaQuery.of(context).size;

  // Stars count changes based on screen width
  int get totalStarsCount {
    if (screenSize.width > 576) {
      return 600;
    } else if (screenSize.width > 1200) {
      return 800;
    } else if (screenSize.width > 1440) {
      return 1000;
    } else {
      return 400;
    }
  }

  final Random random = Random();

  int get starsMaxXOffset {
    return screenSize.width.ceil() <= 0 ? 1 : screenSize.width.ceil();
  }

  int get starsMaxYOffset {
    return screenSize.height.ceil() <= 0 ? 1 : screenSize.height.ceil();
  }

  List<int> _getRandomStarsOffsetsList(int max) {
    return List.generate(totalStarsCount, (i) => random.nextInt(max));
  }

  List<int> get randomStarXOffsets {
    return _getRandomStarsOffsetsList(starsMaxXOffset);
  }

  List<int> get randomStarYOffsets {
    return _getRandomStarsOffsetsList(starsMaxYOffset);
  }

  List<double> get randomStarSizes {
    return List.generate(totalStarsCount, (i) => random.nextDouble() + 0.7);
  }

  CustomPainter getPainter({required Animation<double> opacity}) {
    return StarsPainter(
      xOffsets: randomStarXOffsets,
      yOffsets: randomStarYOffsets,
      sizes: randomStarSizes,
      fadeOutStarIndices: fadeOutStarIndices,
      fadeInStarIndices: fadeInStarIndices,
      totalStarsCount: totalStarsCount,
      opacityAnimation: opacity,
    );
  }

  List<int> get fadeOutStarIndices {
    List<int> indices = [];
    for (int i = 0; i <= totalStarsCount; i++) {
      if (i % 5 == 0) {
        indices.add(i);
      }
    }
    return indices;
  }

  List<int> get fadeInStarIndices {
    List<int> indices = [];
    for (int i = 0; i <= totalStarsCount; i++) {
      if (i % 3 == 0) {
        indices.add(i);
      }
    }
    return indices;
  }
}
