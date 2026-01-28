import 'package:flutter/material.dart';
import '../models/user_profile.dart';

class DetailsScreen extends StatefulWidget {
  final FoodItem foodItem;

  const DetailsScreen({super.key, required this.foodItem});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  int quantity = 1;
  int _currentPage = 0;
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 400,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    // color: Color(0xFFF5F5F5),
                    color: Colors.white10,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40),
                    ),
                  ),
                  child: Stack(
                    children: [
                      PageView.builder(
                        controller: _pageController,
                        onPageChanged: (index) {
                          setState(() {
                            _currentPage = index % 3;
                          });
                        },
                        itemCount: 9,
                        itemBuilder: (context, index) {
                          return Center(
                            child: Hero(
                              tag: index == 0
                                  ? 'food-image-${widget.foodItem.id}'
                                  : 'food-image-${widget.foodItem.id}-$index',
                              child: Container(
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(
                                        0xFF9CCC65,
                                      ).withOpacity(0.25),
                                      blurRadius: 45,
                                      spreadRadius: 10,
                                    ),
                                  ],
                                ),
                                child: Image.network(
                                  widget.foodItem.imageUrl,
                                  height: 250,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          );
                        },
                      ),

                      // Page Indicators
                      Positioned(
                        bottom: 20,
                        left: 0,
                        right: 0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(3, (index) {
                            return Container(
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              width: _currentPage == index ? 24 : 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: _currentPage == index
                                    ? const Color(0xFF9CCC65)
                                    : Colors.grey[300],
                                borderRadius: BorderRadius.circular(4),
                              ),
                            );
                          }),
                        ),
                      ),

                      Positioned(
                        top: 50,
                        left: 20,
                        child: GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(
                                    0xFF9CCC65,
                                  ).withOpacity(0.3),
                                  blurRadius: 8,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.arrow_back,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 50,
                        right: 20,
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF9CCC65).withOpacity(0.3),
                                blurRadius: 8,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.favorite_border,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24.0,
                    vertical: 30,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Row(
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     Expanded(
                      //       child:
                      //     ),
                      //   ],
                      // ),
                      const SizedBox(height: 16),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              widget.foodItem.name.replaceAll('\n', ' '),
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF1A1D26),
                                height: 1.2,
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          // Price
                          Text(
                            '\$${widget.foodItem.price.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF9CCC65),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),

                      Row(
                        children: [
                          _buildInfoItem(
                            Icons.local_fire_department_rounded,
                            '${widget.foodItem.calories} calories',
                            const Color(0xFFFF6B00),
                          ),
                          _buildDivider(),
                          _buildInfoItem(
                            Icons.access_time_rounded,
                            'Time 15-30 min',
                            const Color(0xFF1A1D26),
                          ),
                          _buildDivider(),
                          _buildInfoItem(
                            Icons.star_rounded,
                            '${widget.foodItem.rating} Rating',
                            Colors.amber,
                          ),
                        ],
                      ),

                      const SizedBox(height: 30),

                      const Text(
                        'Description',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF1A1D26),
                        ),
                      ),
                      const SizedBox(height: 12),

                      Text(
                        widget.foodItem.description.length < 50
                            ? 'This modern food delivery app combines minimal UI with smooth interactions. Order fast, track easily, and enjoy every bite without hassle...'
                            : widget.foodItem.description,
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xff676767),
                          height: 1.6,
                        ),
                      ),

                      const SizedBox(height: 24),

                      Row(
                        children: List.generate(
                          40,
                          (index) => Expanded(
                            child: Container(
                              color: index % 2 == 0
                                  ? Colors.transparent
                                  : Colors.grey[300],
                              height: 1,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 24),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Customize',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF1A1D26),
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                'More Details',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Color.fromARGB(255, 193, 226, 104),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Icon(
                                Icons.keyboard_arrow_down,
                                size: 16,
                                color: Color.fromARGB(255, 193, 226, 104),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 0,
                          vertical: 16,
                        ),
                        decoration: BoxDecoration(
                          // color: Colors.white,
                          // boxShadow: [
                          //   BoxShadow(
                          //     color: Colors.black.withOpacity(0.05),
                          //     blurRadius: 10,
                          //     offset: const Offset(0, -4),
                          //   ),
                          // ],
                        ),
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFFF9F9F9),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      if (quantity > 1)
                                        setState(() => quantity--);
                                    },
                                    icon: const Icon(
                                      Icons.remove,
                                      size: 18,
                                      color: Colors.black54,
                                    ),
                                    constraints: const BoxConstraints(
                                      minWidth: 40,
                                      minHeight: 40,
                                    ),
                                    padding: EdgeInsets.zero,
                                  ),
                                  Text(
                                    quantity.toString().padLeft(2, '0'),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(left: 8),
                                    decoration: const BoxDecoration(
                                      color: Color(0xff91bf28),
                                      shape: BoxShape.circle,
                                    ),
                                    child: IconButton(
                                      onPressed: () =>
                                          setState(() => quantity++),
                                      icon: const Icon(
                                        Icons.add,
                                        size: 18,
                                        color: Colors.white,
                                      ),
                                      constraints: const BoxConstraints(
                                        minWidth: 36,
                                        minHeight: 36,
                                      ),
                                      padding: EdgeInsets.zero,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(width: 20),

                            Expanded(
                              child: Container(
                                height: 49,
                                decoration: BoxDecoration(
                                  color: const Color(0xff87b31e),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: const Center(
                                  child: Text(
                                    'Add to Cart',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(IconData icon, String text, Color iconColor) {
    return Row(
      children: [
        Icon(icon, size: 16, color: iconColor),
        const SizedBox(width: 6),
        Text(
          text,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Color(0xFF1A1D26),
          ),
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      height: 16,
      width: 1,
      color: Colors.grey[300],
    );
  }
}
