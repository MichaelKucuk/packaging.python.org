import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../theme.dart';

class NeonButton extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final Color color;
  final EdgeInsets padding;
  final BorderRadius borderRadius;

  const NeonButton({
    super.key,
    required this.child,
    this.onPressed,
    this.color = AuraTheme.neonCyan,
    this.padding = const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
    this.borderRadius = const BorderRadius.all(Radius.circular(16)),
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: borderRadius,
        boxShadow: AuraTheme.neonGlow(color),
        border: Border.all(color: color.withOpacity(0.6), width: 1.2),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: borderRadius,
          onTap: onPressed,
          child: Padding(padding: padding, child: DefaultTextStyle.merge(style: const TextStyle(fontWeight: FontWeight.w700), child: child)),
        ),
      ),
    );
  }
}

class NeonToggle extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final Color color;

  const NeonToggle({super.key, required this.value, required this.onChanged, this.color = AuraTheme.neonCyan});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 56,
        height: 32,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: value ? color.withOpacity(0.2) : const Color(0x33121A2C),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: value ? color : AuraTheme.textSecondary.withOpacity(0.4)),
          boxShadow: value ? AuraTheme.neonGlow(color, blur: 20) : [],
        ),
        child: Align(
          alignment: value ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: value ? color : AuraTheme.textSecondary,
              shape: BoxShape.circle,
              boxShadow: value ? AuraTheme.neonGlow(color, blur: 16) : [],
            ),
          ),
        ),
      ),
    );
  }
}

class NeonWaveform extends StatefulWidget {
  final List<double> samples; // -1..1
  final double height;
  final Color color;
  const NeonWaveform({super.key, required this.samples, this.height = 56, this.color = AuraTheme.neonCyan});

  @override
  State<NeonWaveform> createState() => _NeonWaveformState();
}

class _NeonWaveformState extends State<NeonWaveform> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 1200))..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          return CustomPaint(
            painter: _WavePainter(widget.samples, widget.color, _controller.value),
          );
        },
      ),
    );
  }
}

class _WavePainter extends CustomPainter {
  final List<double> samples;
  final Color color;
  final double phase;
  _WavePainter(this.samples, this.color, this.phase);

  @override
  void paint(Canvas canvas, Size size) {
    final paintGlow = Paint()
      ..color = color.withOpacity(0.35)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 16)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final path = Path();
    final glow = Path();
    if (samples.isEmpty) return;

    final visible = samples.length;
    for (int i = 0; i < visible; i++) {
      final normX = i / (visible - 1);
      final amp = samples[i];
      final wobble = 0.05 * math.sin((normX * 10 + phase * 2 * math.pi));
      final y = size.height / 2 - (amp + wobble) * (size.height / 2 - 4);
      final x = normX * size.width;
      if (i == 0) {
        path.moveTo(x, y);
        glow.moveTo(x, y);
      } else {
        path.lineTo(x, y);
        glow.lineTo(x, y);
      }
    }
    canvas.drawPath(glow, paintGlow);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _WavePainter oldDelegate) => oldDelegate.samples != samples || oldDelegate.phase != phase || oldDelegate.color != color;
}

