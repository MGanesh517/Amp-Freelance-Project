class FoodItem {
  final String id;
  final String name;
  final String category;
  final double price;
  final int calories;
  final String imageUrl;
  final String description;
  final double rating;
  final bool isPopular;

  FoodItem({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.calories,
    required this.imageUrl,
    required this.description,
    required this.rating,
    this.isPopular = false,
  });

  // Sample data for demonstration
  static List<FoodItem> getSampleFoodItems() {
    return [
      FoodItem(
        id: '1',
        name: 'Classic cheese\nBurger',
        category: 'Burger',
        price: 25.00,
        calories: 170,
        imageUrl:
            'https://pngimg.com/uploads/burger_sandwich/burger_sandwich_PNG4101.png',
        description: 'Juicy beef patty with melted cheese',
        rating: 4.8,
        isPopular: true,
      ),
      FoodItem(
        id: '2',
        name: 'Homemade\nPizza',
        category: 'Pizza',
        price: 35.00,
        calories: 260,
        imageUrl: 'https://pngimg.com/uploads/pizza/pizza_PNG44077.png',
        description: 'Freshly baked homemade pizza',
        rating: 4.9,
        isPopular: true,
      ),
      FoodItem(
        id: '3',
        name: 'Creamy Tomato\nPasta',
        category: 'Pasta',
        price: 28.00,
        calories: 245,
        imageUrl: 'https://pngimg.com/d/pasta_PNG37.png',
        description: 'Rich tomato sauce with fresh herbs',
        rating: 4.7,
      ),
      FoodItem(
        id: '4',
        name: 'chocolate ice\ncream',
        category: 'Dessert',
        price: 15.00,
        calories: 189,
        imageUrl: 'https://pngimg.com/d/ice_cream_PNG20987.png',
        description: 'Creamy chocolate ice cream',
        rating: 4.9,
        isPopular: true,
      ),
    ];
  }
}
