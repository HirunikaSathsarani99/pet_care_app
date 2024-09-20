import 'package:flutter/material.dart';
import 'package:pet_care_app/view/style.dart';

class FoodLevelPage extends StatefulWidget {
  @override
  _FoodLevelPageState createState() => _FoodLevelPageState();
}

class _FoodLevelPageState extends State<FoodLevelPage>
    with SingleTickerProviderStateMixin {
  double foodLevel = 75; 
  double waterLevel = 50; 
  late AnimationController _controller;
  late Animation<double> _foodAnimation;
  late Animation<double> _waterAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _foodAnimation = Tween<double>(begin: 0, end: foodLevel).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _waterAnimation = Tween<double>(begin: 0, end: waterLevel).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Food and Water Levels'),
        backgroundColor: AppColors.ThemeColor,
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.grey[900],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          
             
            Center(child: Image.asset('assets/food.png', height: 300)),
            SizedBox(height: 30),
            AnimatedBuilder(
              animation: _foodAnimation,
              builder: (context, child) {
                return _buildInfoBox(Icons.fastfood, 'Food Level',
                    '${_foodAnimation.value.toStringAsFixed(0)}%');
              },
            ),
            SizedBox(height: 20), 
            AnimatedBuilder(
              animation: _waterAnimation,
              builder: (context, child) {
                return _buildInfoBox(Icons.local_drink, 'Water Level',
                    '${_waterAnimation.value.toStringAsFixed(0)}%');
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoBox(IconData icon, String title, String value) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey[700],
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon, color: AppColors.ThemeColor, size: 30),
              SizedBox(width: 20),
              Text(
                title,
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ],
          ),
          Text(
            value,
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ],
      ),
    );
  }
}
