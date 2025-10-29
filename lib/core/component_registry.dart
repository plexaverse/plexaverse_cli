 
import 'package:plexaverse_cli/models/component.dart';

const _buttonTemplate = r'''
import 'package:flutter/material.dart';

class PxButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final ButtonStyle? style;

  const PxButton({
    super.key,
    required this.child,
    this.onPressed,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onPressed,
      style: style,
      child: child,
    );
  }
}
''';

const _cardTemplate = r'''
import 'package:flutter/material.dart';

class PxCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;

  const PxCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: padding,
        child: child,
      ),
    );
  }
}
''';

const _backgroundBeamsTemplate = r'''
import 'dart:math' as math;
import 'package:flutter/material.dart';

class BackgroundBeams extends StatefulWidget {
  final Color beamColor;
  final int beamCount;
  final double beamWidth;
  final double blurRadius;
  final double maxOpacity;
  final int minAnimationDuration;
  final int maxAnimationDuration;
  final double curviness;
  final int maxStartDelay;
  final Curve animationCurve;
  final bool shouldRepeat;
  final double gradientSpread;
  
  const BackgroundBeams({
    super.key,
    this.beamColor = Colors.blue,
    this.beamCount = 8,
    this.beamWidth = 1.0,
    this.blurRadius = 0.0,
    this.maxOpacity = 0.5,
    this.minAnimationDuration = 2000,
    this.maxAnimationDuration = 4000,
    this.curviness = 0.2,
    this.maxStartDelay = 1000,
    this.animationCurve = Curves.easeInOut,
    this.shouldRepeat = true,
    this.gradientSpread = 0.25,
  }) : assert(beamCount > 0, 'beamCount must be greater than 0'),
       assert(beamWidth > 0, 'beamWidth must be greater than 0'),
       assert(curviness >= 0.0 && curviness <= 0.5, 'curviness must be between 0.0 and 0.5'),
       assert(maxOpacity >= 0.0 && maxOpacity <= 1.0, 'maxOpacity must be between 0.0 and 1.0'),
       assert(gradientSpread > 0.0 && gradientSpread <= 1.0, 'gradientSpread must be between 0.0 and 1.0');

  @override
  State<BackgroundBeams> createState() => _BackgroundBeamsState();
}

class _BackgroundBeamsState extends State<BackgroundBeams>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<BeamPath> _beamPaths;
  late List<BeamAnimationConfig> _animationConfigs;
  
  // Cache Paint object
  late Paint _basePaint;
  
  // Reusable objects for painting
  final Path _reusablePath = Path();
  final List<Color> _reusableColors = List.filled(5, Colors.transparent);
  final List<double> _reusableStops = List.filled(5, 0.0);

  @override
  void initState() {
    super.initState();
    _initializePaint();
    _initializeBeams();
    
    // Single controller running continuously
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10), // Long duration for smooth cycles
    );
    
    if (widget.shouldRepeat) {
      _controller.repeat();
    } else {
      _controller.forward();
    }
  }

  void _initializePaint() {
    _basePaint = Paint()
      ..strokeWidth = widget.beamWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, widget.blurRadius);
  }

  void _initializeBeams() {
    _beamPaths = [];
    _animationConfigs = [];
    
    final random = math.Random();
    
    for (int i = 0; i < widget.beamCount; i++) {
      final basePosition = (i + 1) / (widget.beamCount + 1);
      
      // Create varied curve paths
      final xOffset = (random.nextDouble() - 0.5) * 0.4;
      final actualCurviness = widget.curviness + random.nextDouble() * widget.curviness;
      
      _beamPaths.add(BeamPath(
        startX: basePosition,
        startY: -0.1,
        control1X: basePosition + xOffset - actualCurviness,
        control1Y: 0.2,
        control2X: basePosition + xOffset + actualCurviness,
        control2Y: 0.7,
        endX: basePosition + xOffset * 1.5,
        endY: 1.1,
      ));
      
      // Create unique animation configuration for each beam
      // Using different frequency and phase to create independent movement
      final frequency = 0.8 + random.nextDouble() * 0.8; // 0.8 to 1.6
      final phaseOffset = random.nextDouble() * 2 * math.pi; // 0 to 2π
      final reverse = random.nextBool(); // Random direction
      
      _animationConfigs.add(BeamAnimationConfig(
        frequency: frequency,
        phaseOffset: phaseOffset,
        reverse: reverse,
      ));
    }
  }

  @override
  void didUpdateWidget(BackgroundBeams oldWidget) {
    super.didUpdateWidget(oldWidget);
    
    if (oldWidget.beamCount != widget.beamCount ||
        oldWidget.curviness != widget.curviness) {
      _initializeBeams();
    }
    
    if (oldWidget.beamWidth != widget.beamWidth ||
        oldWidget.blurRadius != widget.blurRadius) {
      _initializePaint();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return CustomPaint(
            painter: BeamsPainter(
              animationValue: _controller.value,
              beamPaths: _beamPaths,
              animationConfigs: _animationConfigs,
              beamColor: widget.beamColor,
              basePaint: _basePaint,
              maxOpacity: widget.maxOpacity,
              gradientSpread: widget.gradientSpread,
              reusablePath: _reusablePath,
              reusableColors: _reusableColors,
              reusableStops: _reusableStops,
            ),
            child: child,
          );
        },
        child: const SizedBox.expand(),
      ),
    );
  }
}

@immutable
class BeamPath {
  final double startX;
  final double startY;
  final double control1X;
  final double control1Y;
  final double control2X;
  final double control2Y;
  final double endX;
  final double endY;
  
  const BeamPath({
    required this.startX,
    required this.startY,
    required this.control1X,
    required this.control1Y,
    required this.control2X,
    required this.control2Y,
    required this.endX,
    required this.endY,
  });
}

@immutable
class BeamAnimationConfig {
  final double frequency;
  final double phaseOffset;
  final bool reverse;
  
  const BeamAnimationConfig({
    required this.frequency,
    required this.phaseOffset,
    required this.reverse,
  });
}

class BeamsPainter extends CustomPainter {
  final double animationValue;
  final List<BeamPath> beamPaths;
  final List<BeamAnimationConfig> animationConfigs;
  final Color beamColor;
  final Paint basePaint;
  final double maxOpacity;
  final double gradientSpread;
  
  // Reusable objects passed from widget state
  final Path reusablePath;
  final List<Color> reusableColors;
  final List<double> reusableStops;
  
  BeamsPainter({
    required this.animationValue,
    required this.beamPaths,
    required this.animationConfigs,
    required this.beamColor,
    required this.basePaint,
    required this.maxOpacity,
    required this.gradientSpread,
    required this.reusablePath,
    required this.reusableColors,
    required this.reusableStops,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (size.width <= 0 || size.height <= 0) return;
    
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    
    // Draw each beam with independent animation using sine wave
    for (int i = 0; i < beamPaths.length; i++) {
      final config = animationConfigs[i];
      final beamPath = beamPaths[i];
      
      // Calculate independent progress using sine wave
      // This creates smooth, continuous, and varied animation for each beam
      final time = animationValue * 2 * math.pi * config.frequency + config.phaseOffset;
      final sineValue = math.sin(time);
      
      // Convert sine (-1 to 1) to progress (0 to 1)
      var progress = (sineValue + 1.0) / 2.0;
      
      // Reverse direction for some beams
      if (config.reverse) {
        progress = 1.0 - progress;
      }
      
      _drawBeam(canvas, size, rect, progress, beamPath);
    }
  }

  void _drawBeam(Canvas canvas, Size size, Rect rect, double progress, BeamPath beamPath) {
    // Reuse path object
    reusablePath.reset();
    
    final startX = beamPath.startX * size.width;
    final startY = beamPath.startY * size.height;
    final control1X = beamPath.control1X * size.width;
    final control1Y = beamPath.control1Y * size.height;
    final control2X = beamPath.control2X * size.width;
    final control2Y = beamPath.control2Y * size.height;
    final endX = beamPath.endX * size.width;
    final endY = beamPath.endY * size.height;
    
    reusablePath.moveTo(startX, startY);
    reusablePath.cubicTo(
      control1X, control1Y,
      control2X, control2Y,
      endX, endY,
    );
    
    // Reuse color and stop lists
    final opacity0 = 0.0;
    final opacity1 = maxOpacity * 0.2;
    final opacity2 = maxOpacity;
    
    reusableColors[0] = beamColor.withValues(alpha: opacity0);
    reusableColors[1] = beamColor.withValues(alpha: opacity1);
    reusableColors[2] = beamColor.withValues(alpha: opacity2);
    reusableColors[3] = beamColor.withValues(alpha: opacity1);
    reusableColors[4] = beamColor.withValues(alpha: opacity0);
    
    reusableStops[0] = 0.0;
    reusableStops[1] = math.max(0.0, progress - gradientSpread);
    reusableStops[2] = progress;
    reusableStops[3] = math.min(1.0, progress + gradientSpread);
    reusableStops[4] = 1.0;
    
    final gradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: reusableColors,
      stops: reusableStops,
    );
    
    // Reuse base paint and only update shader
    basePaint.shader = gradient.createShader(rect);
    
    canvas.drawPath(reusablePath, basePaint);
  }

  @override
  bool shouldRepaint(BeamsPainter oldDelegate) {
    return animationValue != oldDelegate.animationValue ||
           beamColor != oldDelegate.beamColor ||
           maxOpacity != oldDelegate.maxOpacity;
  }
  
  @override
  bool shouldRebuildSemantics(BeamsPainter oldDelegate) => false;
}
'''

class ComponentRegistry {
  static final Map<String, ComponentDescriptor> _components = {
    'button': ComponentDescriptor(
      name: 'button',
      description: 'Material 3 friendly button wrapper with variants.',
      category: 'interactive',
      files: ['lib/widgets/px_button.dart'],
      dependencies: [],
      templates: {
        'lib/widgets/px_button.dart': _buttonTemplate,
      },
    ),
    'card': ComponentDescriptor(
      name: 'card',
      description: 'Card with sensible padding defaults.',
      category: 'display',
      files: ['lib/widgets/px_card.dart'],
      dependencies: [],
      templates: {
        'lib/widgets/px_card.dart': _cardTemplate,
      },
    ),
    'background_beams': ComponentDescriptor(
      name: 'background_beams',
      description: 'Animated background beams painter widget.',
      category: 'background',
      files: ['lib/widgets/background_beams.dart'],
      dependencies: [],
      templates: {
        'lib/widgets/background_beams.dart': _backgroundBeamsTemplate,
      },
    ),
  };

  static List<ComponentDescriptor> list() => _components.values.toList();
  static ComponentDescriptor? get(String name) => _components[name];
}
