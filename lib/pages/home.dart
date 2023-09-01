import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:appcrudsqlite/listProduct.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeScreen();
  }
}

class _HomeScreen extends State<HomeScreen> {
  late PageController _pageController;
  int activePage = 0;

  bool timerActive = true;

  List<String> images = [
    "assets/image1.jpg",
    "assets/image2.png",
    "assets/image3.png",
    "assets/image4.jpg"
  ];

  @override
  void initState() {
    _pageController = PageController(
      viewportFraction: 0.8,
      initialPage: activePage,
    );
    super.initState();
  }

  List<Widget> indicators(int imagesLength, int currentIndex) {
    return List<Widget>.generate(
      imagesLength,
      (index) {
        bool isIndicatorSelected = currentIndex == index;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          margin: const EdgeInsets.all(3),
          width: isIndicatorSelected ? 12 : 10,
          height: isIndicatorSelected ? 12 : 10,
          decoration: BoxDecoration(
            color: isIndicatorSelected ? Colors.black : Colors.black26,
            shape: BoxShape.circle,
          ),
          child: InkWell(
            onTap: () {
              setState(() {
                activePage = currentIndex;
                _pageController.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              });
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Venda da Vivia"),
        backgroundColor: Color.fromARGB(255, 0, 204, 190),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 200,
            width: MediaQuery.of(context).size.width,
            child: PageView.builder(
              itemCount: images.length,
              controller: _pageController,
              onPageChanged: (page) {
                setState(() {
                  activePage = page;
                });
              },
              pageSnapping: true,
              itemBuilder: (context, pagePosition) {
                bool active = pagePosition == activePage;

                return _CarouselSlider(
                  images: images,
                  pagePosition: pagePosition,
                  active: active,
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: indicators(images.length, activePage),
          ),
          Expanded(
            // Adicionado o Expanded widget
            child: Container(
              margin: EdgeInsets.only(top: 20, left: 10, right: 10),
              padding: EdgeInsets.all(50),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 1, 163, 153),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
              ),
              child: Column(
                children: [
                  Text(
                    "Os melhores produtos, você encontra aqui na Venda da Vivia",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10), // Espaçamento entre o texto e o botão
                  ElevatedButton(
                    onPressed: () {
                      // Navegar para a lista de produtos (ListProduct).
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ListProduct()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(
                          255, 0, 204, 190), // Define a cor verde para o botão.
                    ),
                    child: Text("Confira"), // Texto do botão
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CarouselSlider extends StatelessWidget {
  const _CarouselSlider({
    required this.images,
    required this.pagePosition,
    required this.active,
  });

  final List<String> images;
  final int pagePosition;
  final bool active;

  @override
  Widget build(BuildContext context) {
    double margin = active ? 10 : 20;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOutCubic,
      margin: EdgeInsets.all(margin),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(images[pagePosition]),
        ),
      ),
    );
  }
}
