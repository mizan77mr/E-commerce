import 'package:fashion/app/app_colors.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static final String name = '/home-screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _selectedLocation = 'ny';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              Text('Location', style: TextStyle(color: Colors.grey)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.location_on, color: AppColors.themeColor),
                      const SizedBox(width: 5),
                      DropdownButton<String>(
                        value: _selectedLocation,
                        elevation: 0,
                        underline: SizedBox(),
                        icon: Icon(Icons.keyboard_arrow_down_sharp),
                        items: [
                          DropdownMenuItem(
                            value: 'ny',
                            child: Text('New York, USA'),
                          ),
                          DropdownMenuItem(
                            value: 'ca',
                            child: Text('California, USA'),
                          ),
                        ],

                        onChanged: (value) {
                          if (value != null) {
                            setState(() {
                              _selectedLocation = value;
                            });
                          }
                        },
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: CircleAvatar(
                      backgroundColor: Colors.grey.withOpacity(0.2),
                      child: Icon(Icons.notification_important),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.search,
                          color: AppColors.themeColor,
                        ),
                        hintText: 'Search',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 16),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(color: AppColors.themeColor,
                    
                    borderRadius: BorderRadius.circular(10)
                    
                    ),
                    child: Icon(Icons.tune,color: Colors.white,),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
