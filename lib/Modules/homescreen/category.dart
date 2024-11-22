import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'categoryDetails.dart';
import 'test.dart'; // Make sure this import is correct

class Category extends StatefulWidget {
  const Category({super.key});

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  get categoryName => null;

  @override
  void initState() {
    super.initState();
    // Initialize the TabController
    tabController = TabController(length: 4, vsync: this);
  }

  final CollectionReference categories =
      FirebaseFirestore.instance.collection("fetch data");

  int _currentIndex = 0;

  // Method to handle navigation changes
  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Inter',
      ),
      home: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex, // This controls which tab is active
          onTap: _onItemTapped, // This calls the _onItemTapped function
          showSelectedLabels: false, // Hides selected label
          showUnselectedLabels: false, // Hides unselected labels
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home', // Label is required
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: '', // Label is required
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: '', // Label is required
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.verified_user),
              label: '', // Label is required
            ),
          ],
        ),
        body: SingleChildScrollView(
          // Ensure SingleChildScrollView wraps the entire body
          child: Column(
            children: [
              // Banner Section
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/food-banner.png"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 100, left: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.location_on, color: Colors.white),
                              SizedBox(width: 8.0),
                              Text(
                                'New York City',
                                style: TextStyle(
                                  fontSize: 24,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                margin: const EdgeInsets.all(8.0),
                                child: Image.asset(
                                  'assets/images/search.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.all(1.0),
                                child: Image.asset(
                                  'assets/images/notification.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: 340,
                          padding: const EdgeInsets.all(15.0),
                          child: const Column(
                            children: <Widget>[
                              Text(
                                'Provide the best food for you',
                                style: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: 10),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Find by Category',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      'See All',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xffFE8C00),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 0),
              // Category Scrollable List
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('categories')
                        .snapshots(),
                    builder:
                        (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                      if (streamSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (streamSnapshot.hasError) {
                        return const Center(child: Text("Error fetching data"));
                      }
                      if (streamSnapshot.hasData) {
                        final docs = streamSnapshot.data!.docs;
                        log("message data from firebase: ${docs}");

                        return Row(
                          children: docs.map((doc) {
                            var categoryName =
                                (doc.data() as Map<String, dynamic>?)
                                            ?.containsKey('categoryName') ??
                                        false
                                    ? doc['categoryName']
                                    : 'No category name';

                            String imagePath = 'assets/images/burger.png';

                            // Dynamically assign images based on categoryName
                            if (categoryName == 'Burger') {
                              imagePath = 'assets/images/burger.png';
                            } else if (categoryName == 'Pizza') {
                              imagePath = 'assets/images/pizza.png';
                            } else if (categoryName == 'Drink') {
                              imagePath = 'assets/images/drink.png';
                            } else if (categoryName == 'Taco') {
                              imagePath = 'assets/images/taco.png';
                            }

                            return Padding(
                              padding: const EdgeInsets.only(right: 20.0),
                              child: CategoryItem(
                                image: imagePath,
                                title: categoryName,
                              ),
                            );
                          }).toList(),
                        );
                      } else {
                        return const Center(child: Text("No data available"));
                      }
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TabBar(
                controller: tabController,
                dividerColor: Colors.transparent,
                indicatorColor: Color(0xFFFE8C00),
                labelColor: Color(0xFFFFFFFF),
                indicator: const BoxDecoration(
                  color: Color(0xFFFE8C00),
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),
                tabs: [
                  SizedBox(
                    width: double.infinity,
                    child: Tab(
                        text: '[categoryName]',
                        icon: Image.asset('assets/images/burger.png')),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Tab(
                      text: 'two',
                      icon: Icon(Icons.email, color: Colors.indigo.shade500),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Tab(
                      text: 'three',
                      icon: Icon(Icons.star, color: Colors.indigo.shade500),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Tab(
                      text: 'four',
                      icon: Icon(Icons.person, color: Colors.indigo.shade500),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 300,
                child: TabBarView(
                  controller: tabController,
                  children: [
                    FirstScreen(tabController: tabController),
                    SecondScreen(tabController: tabController),
                    ThirdScreen(tabController: tabController),
                    FourthScreen(tabController: tabController),
                  ],
                ),
              ),
              // Navigation button
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Categorydetails()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFE8C00),
                  minimumSize: const Size(350, 0),
                  alignment: Alignment.bottomCenter,
                ),
                child: const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    'Next',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  final String image;
  final String title;

  const CategoryItem({Key? key, required this.image, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color: const Color(0xFFFF8C00),
        borderRadius: BorderRadius.circular(15),
      ),
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Image.asset(
            image,
            width: 45,
            height: 40,
          ),
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
