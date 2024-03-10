import 'dart:async';

import 'package:flutter/material.dart';

class AdComponent extends StatefulWidget {
  @override
  _AdComponentState createState() => _AdComponentState();
}

class _AdComponentState extends State<AdComponent> {
  static final List<Map<String, String>> ads = [
    {
      'image':
          'https://images.pexels.com/photos/2529148/pexels-photo-2529148.jpeg?auto=compress&cs=tinysrgb&w=400',
      'title': 'Nike Shoe',
    },
    {
      'image':
          'https://images.pexels.com/photos/1670766/pexels-photo-1670766.jpeg?auto=compress&cs=tinysrgb&w=400',
      'title': 'Converse',
    },
    {
      'image':
          'https://images.pexels.com/photos/1152077/pexels-photo-1152077.jpeg?auto=compress&cs=tinysrgb&w=400',
      'title': 'Adiddas Bag',
    },
    {
      'image':
          'https://images.pexels.com/photos/1936848/pexels-photo-1936848.jpeg?auto=compress&cs=tinysrgb&w=400',
      'title': 'Carrier Bag',
    },
    {
      'image':
          'https://images.pexels.com/photos/129208/pexels-photo-129208.jpeg?auto=compress&cs=tinysrgb&w=400',
      'title': 'HP Envy x360',
    },
  ];

  PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  void _startAutoScroll() {
    const Duration autoScrollDuration = Duration(seconds: 5);

    Timer.periodic(autoScrollDuration, (Timer timer) {
      if (_currentPage < ads.length - 1) {
        _currentPage++;
        _pageController.animateToPage(
          _currentPage,
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      } else {
        _currentPage = 0;
        _pageController.jumpToPage(_currentPage);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 340, // Adjust the height as needed
          // color: Colors.green,
          child: PageView.builder(
            controller: _pageController,
            itemCount: ads.length,
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
            itemBuilder: (context, index) {
              return AdCard(
                imageUrl: ads[index]['image']!,
                title: ads[index]['title']!,
              );
            },
          ),
        ),
        const SizedBox(height: 20),
        // const Text(
        //   'Swipe left or right to view more ads',
        //   style: TextStyle(fontSize: 16),
        // ),
      ],
    );
  }
}

class AdCard extends StatelessWidget {
  final String imageUrl;
  final String title;

  AdCard({required this.imageUrl, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.red,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 3 / 4 * 340,
            child: ClipRRect(
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          ),
          Container(
            height: 1 / 4 * 340,
            padding: const EdgeInsets.all(8.0), // Adjust the opacity as needed
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
