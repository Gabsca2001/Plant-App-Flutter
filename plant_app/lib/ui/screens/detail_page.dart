import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:plant_app/constants.dart';
import 'package:plant_app/models/plants.dart';

class DetailPage extends StatefulWidget {
  final int plantId;
  const DetailPage({Key? key, required this.plantId}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {

  bool toggleIsFavorated(bool isFavorited) {
    return !isFavorited;
  }

  bool toggleIsSelected(bool isSelected) {
    return !isSelected;
  }

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    List<Plant> _plantList = Plant.plantList;

    return Scaffold(
      body: Stack(
        children: [
          Positioned (
            top: 50,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child : Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: Constants.primaryColor.withOpacity(.15),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child : Icon(
                      Icons.close, 
                      color: Constants.primaryColor,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    setState(() {
                      _plantList[widget.plantId].isFavorated = !_plantList[widget.plantId].isFavorated;
                    });
                  },
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: Constants.primaryColor.withOpacity(.15),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: IconButton(
                      onPressed: (){
                        setState(() {
                          bool isFavorited = toggleIsFavorated(_plantList[widget.plantId].isFavorated,);
                          _plantList[widget.plantId].isFavorated = isFavorited;
                        });
                      },
                      icon: Icon(
                      _plantList[widget.plantId].isFavorated ? Icons.favorite : Icons.favorite_border,
                      color: _plantList[widget.plantId].isFavorated ? Constants.primaryColor : Constants.primaryColor.withOpacity(.5),
                    ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Positioned(
            top: 100,
            left: 20,
            right: 20,
            child : Container(
              width: size.width * .8,
              height: size.height * .8,
              padding: const EdgeInsets.all(20),
              child: Stack(
                children: [
                  Positioned(
                    top: 10,
                    left: 0,
                    child: SizedBox(
                      height: 350,
                      child: Image.asset(_plantList[widget.plantId].imageURL),
                    ),
                  
                  ),
                  Positioned(
                    top: 10,
                    right: 0,
                    child: SizedBox(
                      height: 200,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children : [
                          PlantFeature(title: 'Size', plantFeature: _plantList[widget.plantId].size.toString()),
                          PlantFeature(title: 'Humidity', plantFeature: _plantList[widget.plantId].humidity.toString()),
                          PlantFeature(title: 'Temperature', plantFeature: _plantList[widget.plantId].temperature.toString()),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child : Container(
              padding: const EdgeInsets.only(top: 80, left: 30, right: 30),
              height: size.height * .5,
              width: size.width,
              decoration: BoxDecoration(
                color: Constants.primaryColor.withOpacity(.5),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children : [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children : [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _plantList[widget.plantId].plantName,
                            style: TextStyle(
                              color: Constants.primaryColor,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            r'$' + _plantList[widget.plantId].price.toString(),
                            style: TextStyle(
                              color: Constants.blackColor,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children : [
                          Text(
                            _plantList[widget.plantId].rating.toString(),
                            style: TextStyle(
                              color: Constants.primaryColor,
                              fontSize: 30,
                            ),
                          ),
                          Icon(
                            Icons.star,
                            size: 30.0,
                            color: Constants.primaryColor,
                          ),
                        ], 
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: Text(
                      _plantList[widget.plantId].decription,
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        color: Constants.blackColor.withOpacity(.7),
                        fontSize: 18,
                        height: 1.5,
                      ),
                    
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: SizedBox(
        height: 50,
        width: size.width * .9,
        child: Row(
          children : [
            Container(
              height: 50,
              width: 50,
              child: IconButton(
                onPressed: (){
                  setState(() {
                    bool isSelected = toggleIsSelected(_plantList[widget.plantId].isSelected);
                    _plantList[widget.plantId].isSelected = isSelected;
                  });
                },
                icon: Icon(
                  Icons.shopping_cart,
                  color: _plantList[widget.plantId].isSelected == true ? Colors.white : Constants.primaryColor,
                ),
              
              ),
              decoration: BoxDecoration(
                color: Constants.primaryColor.withOpacity(.5),
                borderRadius: BorderRadius.circular(50),
                boxShadow: [
                  BoxShadow(
                    color: Constants.primaryColor.withOpacity(.3),
                    blurRadius: 5,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Constants.primaryColor,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Constants.primaryColor.withOpacity(.5),
                      blurRadius: 5,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    'Buy Now',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
}

class PlantFeature extends StatelessWidget {
  final String plantFeature;
  final String title;
  const PlantFeature({
    Key? key,
    required this.plantFeature,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children : [
        Text(
          title,
          style: TextStyle(
            color: Constants.blackColor,
          ),
        ),
        Text(
          plantFeature,
          style: TextStyle(
            color: Constants.primaryColor,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}