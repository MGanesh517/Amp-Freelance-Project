import 'package:flutter/material.dart';
import 'dart:math' as math;

class FloatingNavBar extends StatefulWidget {
  final int selectedIndex;
  final Function(int) onItemSelected;

  const FloatingNavBar({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
  });

  @override
  State<FloatingNavBar> createState() => _FloatingNavBarState();
}

class _FloatingNavBarState extends State<FloatingNavBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      child: Stack(
        children: [
          CustomPaint(
            size: Size.infinite,
            painter: NavBarShapePainter(
              color: const Color(0xff040301),
              borderColor: const Color(0xffe7e6e5),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Center(child: _buildNavItem(Icons.home_rounded, 0)),
              ),
              Expanded(
                child: Center(child: _buildNavItem(Icons.map_outlined, 1)),
              ),
              Expanded(
                child: Center(child: _buildNavItem(Icons.favorite_border, 2)),
              ),
              Expanded(
                child: Center(child: _buildNavItem(Icons.person_outline, 3)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, int index) {
    final isSelected = widget.selectedIndex == index;
    return GestureDetector(
      onTap: () {
        widget.onItemSelected(index);
      },
      child: Container(
        width: 65,
        height: 80,
        alignment: Alignment.center,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF9CCC65) : Colors.white,
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: isSelected ? Colors.white : Colors.black,
            size: 24,
          ),
        ),
      ),
    );
  }
}

class NavBarShapePainter extends CustomPainter {
  final Color color;
  final Color borderColor;

  NavBarShapePainter({required this.color, required this.borderColor});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final borderPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 11.0;

    final path = Path();
    final width = size.width;
    final height = size.height;

    final itemWidth = width / 4;
    final radius = 38.0;
    final cy = height / 2;

    final c0x = itemWidth / 2;
    path.moveTo(c0x - radius, cy);

    for (int i = 0; i < 4; i++) {
      double cx = (itemWidth / 2) + (i * itemWidth);
      Rect rect = Rect.fromCircle(center: Offset(cx, cy), radius: radius);

      if (i == 3) {
        path.arcTo(rect, -math.pi * 0.75, math.pi * 1.5, false);
      } else {
        if (i == 0) {
          path.arcTo(rect, math.pi, math.pi * 0.75, false);
        } else {
          path.arcTo(rect, -math.pi * 0.75, math.pi * 0.5, false);
        }

        double nextCx = (itemWidth / 2) + ((i + 1) * itemWidth);
        double midX = (cx + nextCx) / 2;

        path.quadraticBezierTo(
          midX,
          cy - 10,
          nextCx + radius * 0.707 * -1,
          cy + radius * 0.707 * -1,
        );
      }
    }

    for (int i = 2; i >= 0; i--) {
      double cx = (itemWidth / 2) + (i * itemWidth);
      Rect rect = Rect.fromCircle(center: Offset(cx, cy), radius: radius);

      double nextCx = (itemWidth / 2) + ((i + 1) * itemWidth);
      double midX = (cx + nextCx) / 2;

      path.quadraticBezierTo(
        midX,
        cy + 10,
        cx + radius * 0.707,
        cy + radius * 0.707,
      );

      if (i == 0) {
        path.arcTo(rect, math.pi * 0.25, math.pi * 0.75, false);
      } else {
        path.arcTo(rect, math.pi * 0.25, math.pi * 0.5, false);
      }
    }

    path.close();

    canvas.drawShadow(path, Colors.black.withOpacity(0.3), 8, true);
    canvas.drawPath(path, borderPaint);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
