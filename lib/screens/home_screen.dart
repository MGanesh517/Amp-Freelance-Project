import 'package:flutter/material.dart';
import '../models/user_profile.dart';
import '../widgets/profile_card.dart';
import '../widgets/promo_banner.dart';
import '../widgets/floating_nav_bar.dart';
import 'details_screen.dart';

class FoodHomeScreen extends StatefulWidget {
  const FoodHomeScreen({super.key});

  @override
  State<FoodHomeScreen> createState() => _FoodHomeScreenState();
}

class _FoodHomeScreenState extends State<FoodHomeScreen> {
  int _selectedCategoryIndex = 0;
  int _selectedNavIndex = 0;
  final List<Map<String, String>> _categories = [
    {'name': 'All', 'emoji': ''},
    {'name': 'Burger', 'emoji': '🍔'},
    {'name': 'Fruits', 'emoji': '🍊'},
    {'name': 'Pizza', 'emoji': '🍕'},
  ];
  late List<FoodItem> _foodItems;

  @override
  void initState() {
    super.initState();
    _foodItems = FoodItem.getSampleFoodItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SafeArea(
            bottom: false,
            child: Column(
              children: [
                _buildHeader(),
                _buildSearchBar(),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const PromoBanner(),
                        _buildCategoriesSection(),
                        _buildProfileGrid(),
                        const SizedBox(height: 100),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Custom Floating Bottom Navigation Bar
          Positioned(
            bottom: 30,
            left: 20,
            right: 20,
            child: FloatingNavBar(
              selectedIndex: _selectedNavIndex,
              onItemSelected: (index) {
                setState(() {
                  _selectedNavIndex = index;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          // Profile Picture
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFFC5E86C), width: 2),
              image: const DecorationImage(
                image: NetworkImage(
                  'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=400',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 12),
          // Welcome Text
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome Back',
                  style: TextStyle(fontSize: 14, color: Color(0xFF8B8B8B)),
                ),
                Text(
                  'Alexander',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2D3142),
                  ),
                ),
              ],
            ),
          ),
          // Notification Button
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF9CCC65).withOpacity(0.6),
                  blurRadius: 12,
                  spreadRadius: -2,
                  offset: const Offset(0, 4),
                  blurStyle: BlurStyle.inner,
                ),
              ],
            ),
            child: const Icon(
              Icons.notifications_outlined,
              color: Colors.black87,
              size: 22,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Color(0xffc9c9c9)),
              ),
              child: Row(
                children: [
                  Icon(Icons.search, color: Colors.grey[400], size: 24),
                  const SizedBox(width: 10),
                  Text(
                    'Search any foods',
                    style: TextStyle(color: Colors.grey[400], fontSize: 15),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(color: Color(0xffc9c9c9)),
            ),
            child: const Icon(Icons.tune, color: Colors.black87, size: 24),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoriesSection() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Categories',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF2D3142),
                ),
              ),
              Text(
                'See all',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: List.generate(_categories.length, (index) {
              final isSelected = _selectedCategoryIndex == index;
              final category = _categories[index];

              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedCategoryIndex = index;
                  });
                },
                child: Container(
                  margin: const EdgeInsets.only(right: 12, top: 6, bottom: 6),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected ? const Color(0xFF9CCC65) : Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: const Color(0xff93c027),
                      width: 1.2,
                    ),
                    boxShadow: isSelected
                        ? [
                            // INNER TOP GREEN SHADOW EFFECT
                            BoxShadow(
                              color: Colors.white.withOpacity(0.35),
                              offset: const Offset(0, -2),
                              blurRadius: 6,
                              spreadRadius: -1,
                            ),
                          ]
                        : [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.08),
                              offset: const Offset(0, 2),
                              blurRadius: 4,
                            ),
                          ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (category['emoji']!.isNotEmpty) ...[
                        Text(
                          category['emoji']!,
                          style: const TextStyle(fontSize: 18),
                        ),
                        const SizedBox(width: 6),
                      ],
                      Text(
                        category['name']!,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: isSelected ? Colors.white : Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }

  Widget _buildProfileGrid() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.75,
          crossAxisSpacing: 10,
          mainAxisSpacing: 16,
        ),
        itemCount: _foodItems.length,
        itemBuilder: (context, index) {
          return FoodCard(
            foodItem: _foodItems[index],
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      DetailsScreen(foodItem: _foodItems[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
