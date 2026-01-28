import 'package:flutter/material.dart';
import '../models/user_profile.dart';

class FoodCard extends StatefulWidget {
  final FoodItem foodItem;
  final VoidCallback? onTap;

  const FoodCard({super.key, required this.foodItem, this.onTap});

  @override
  State<FoodCard> createState() => _FoodCardState();
}

class _FoodCardState extends State<FoodCard>
    with SingleTickerProviderStateMixin {
  bool isFavorite = false;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
    });
    _animationController.forward().then((_) {
      _animationController.reverse();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Color(0xfff7f7f7),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Color(0xffededed)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    widget.foodItem.name,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF1A1D26),
                      height: 1.2,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                GestureDetector(
                  onTap: _toggleFavorite,
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x0D000000),
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: ScaleTransition(
                      scale: _scaleAnimation,
                      child: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: const Color(0xFFFF0000),
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Center(
                child: Image.network(
                  widget.foodItem.imageUrl,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(
                      Icons.fastfood,
                      size: 60,
                      color: Colors.grey,
                    );
                  },
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Color(0xfffefefe),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.local_fire_department_rounded,
                        size: 16,
                        color: Color(0xFFFF6B00),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${widget.foodItem.calories} Kal',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF1A1D26),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Color(0xfffefefe),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '\$${widget.foodItem.price.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color.fromARGB(255, 177, 194, 133),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
