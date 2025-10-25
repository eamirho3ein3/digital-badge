import 'package:flutter/material.dart';
import 'package:name_badge/pages/show_information/widgets/background_widget/stars_layout.dart';

class StarsContainer extends StatelessWidget {
  const StarsContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
        gradient: RadialGradient(
          colors: [Color(0xff3f218d), Color(0xff180026)],
          stops: [0, 1],
          radius: 1.1,
          center: Alignment.centerLeft,
        ),
      ),
      child: const Stars(),
    );
  }
}

class Stars extends StatefulWidget {
  const Stars({super.key});

  @override
  StarsState createState() => StarsState();
}

class StarsState extends State<Stars> with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _opacity;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _animationController.repeat(reverse: true);

    _opacity = Tween<double>(begin: 0.8, end: 0.1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    StarsLayout starsLayer = StarsLayout(context);

    return CustomPaint(painter: starsLayer.getPainter(opacity: _opacity));
  }
}
