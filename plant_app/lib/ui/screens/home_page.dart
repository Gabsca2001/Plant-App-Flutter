import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:plant_app/constants.dart';
import 'package:plant_app/models/plants.dart';
import 'package:plant_app/ui/screens/detail_page.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    int selectedIndex = 0;
    Size size = MediaQuery.of(context).size;

    //list of plants
    List<Plant> _plantList = Plant.plantList;

    //List of categories
    List<String> _plantTypes = [
      'Recommended',
      'Indoor',
      'Outdoor',
      'Garden',
      'Supplement',
    ];

    //toggle favourite button
    bool toggleIsFavorated(bool isFavorited) {
      return !isFavorited;
    }

    return Scaffold(
      body: 
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(top:20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        ),
                      width: size.width * .9,
                      child : Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.search,
                            color: Colors.black54.withOpacity(.6),
                          ),
                          const Expanded(
                            child: TextField(
                              showCursor: false,
                              decoration: InputDecoration(
                                hintText: "Search plant",
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none
                              ),
                            ),
                          ),
                          Icon(
                            Icons.mic,
                            color: Colors.black54.withOpacity(.6),
                          ),
                        ],
                      ),
                    ),
                    
                  ],
                ),
                decoration: BoxDecoration(
                  color: Constants.primaryColor.withOpacity(.2),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                height: 50.0,
                width: size.width,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _plantTypes.length,
                  itemBuilder: (BuildContext context, int index){
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: (){
                          setState(() {
                            selectedIndex = index;
                          });
                        },
                        child: Text(
                          _plantTypes[index],
                          style: TextStyle(
                            fontWeight: selectedIndex == index ? FontWeight.bold : FontWeight.w300,
                            color: selectedIndex == index ? Constants.primaryColor : Colors.black54.withOpacity(.6),
                            fontSize: 18,
                          ),
                        ),
                      ),
                    );
                  },
                )
              ),
              SizedBox(
                height: size.height * .3,
                child: ListView.builder(
                  itemCount: _plantTypes.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index){
                    return GestureDetector(
                      onTap: (){
                        Navigator.push(context, PageTransition(
                          type: PageTransitionType.bottomToTop,
                          child: DetailPage(
                            plantId: _plantList[index].plantId,
                          ),
                        ));
                      },
                      child: Container(
                        width: 200,
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        child: Stack(
                          children: [
                            Positioned(
                              top: 10,
                              right: 20,
                              child: Container(
                                height: 50,
                                width: 50,
                                child: IconButton(
                                  onPressed: (){
                                    setState(() {
                                      bool isFavorited = toggleIsFavorated(_plantList[index].isFavorated);
                                      _plantList[index].isFavorated = isFavorited;
                                    });
                                  },
                                  icon: Icon(_plantList[index].isFavorated == true ? Icons.favorite : Icons.favorite_border),
                                  color: Constants.primaryColor,
                                  iconSize: 30,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 50,
                              right: 50,
                              top: 50,
                              bottom: 50,
                              child: Image.asset(_plantList[index].imageURL),
                            ),
                            Positioned(
                              left: 15,
                              bottom: 20,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _plantList[index].category,
                                    style: const TextStyle(
                                      color: Colors.white70,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text(
                                    _plantList[index].plantName,
                                    style: const TextStyle(
                                      color: Colors.white70,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              bottom: 15,
                              right: 20,
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  r'$' + _plantList[index].price.toString(),
                                  style: TextStyle(
                                    color: Constants.primaryColor,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        decoration: BoxDecoration(
                          color: Constants.primaryColor.withOpacity(.8),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    );
                  },),
              ),
              Container(
                padding: const EdgeInsets.only(left: 16, bottom: 20, top: 20),
                child: const Text(
                  'New Plants',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                height: size.height * .5,
                child: ListView.builder(
                  itemCount: _plantList.length,
                  scrollDirection: Axis.vertical,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (BuildContext context, int index){
                    return GestureDetector(
                      onTap: (){
                        Navigator.push(context, PageTransition(
                          type: PageTransitionType.bottomToTop,
                          child: DetailPage(
                            plantId: _plantList[index].plantId,
                          ),
                        ));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          //sfondo background
                          color: Constants.primaryColor.withOpacity(.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        height: 80,
                        padding: const EdgeInsets.only(left: 10, top: 10),
                        margin: const EdgeInsets.only(bottom: 10, top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Stack(
                              clipBehavior: Clip.none,
                              children: [
                                //cerchietto
                                Container(
                                  width: 60.0,
                                  height: 60.0,
                                  decoration: BoxDecoration(
                                    color: Constants.primaryColor.withOpacity(.5),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                // elemento interno (immagine dentro al cerchietto)
                                Positioned(
                                  bottom: 5,
                                  left: 0,
                                  right: 0,
                                  child: SizedBox(
                                    height: 80,
                                    child: Image.asset(_plantList[index].imageURL),
                                  ),
                                ),
                                //parte della card dedicata al testo
                                Positioned(
                                  bottom: 5,
                                  left: 80,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children : [
                                      Text(
                                        _plantList[index].plantName,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        _plantList[index].category,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.black54,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              padding: const EdgeInsets.only(right: 10),
                              child: Text(
                                r'$' + _plantList[index].price.toString(),
                                style: TextStyle(
                                  color: Constants.primaryColor,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
    );
  }
}