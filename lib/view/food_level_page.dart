import 'package:flutter/material.dart';
import 'package:pet_care_app/view/style.dart';

class FoodLevelPage extends StatefulWidget {
  @override
  _FoodLevelPageState createState() => _FoodLevelPageState();
}

class _FoodLevelPageState extends State<FoodLevelPage>
    with SingleTickerProviderStateMixin {
  double foodLevel = 75; // Hardcoded food level percentage
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0, end: foodLevel).animate(
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
      appBar: AppBar(title: Text('Food Level',
      ),
      backgroundColor: AppColors.ThemeColor,),
      body: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.grey[900], 
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Food Level',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
            SizedBox(height: 30),
            AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return _buildInfoBox(Icons.fastfood, 'Current Level', 
                  '${_animation.value.toStringAsFixed(0)}%');
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
