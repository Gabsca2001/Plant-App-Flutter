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
                    child: Icon(
                      _plantList[widget.plantId].isFavorated ? Icons.favorite : Icons.favorite_border,
                      color: _plantList[widget.plantId].isFavorated ? Constants.primaryColor : Constants.primaryColor.withOpacity(.5),
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
                color: Constants.primaryColor.withOpacity(.1),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children : [
                  //sono arrivato quiii
                ],
              ),
            ),
          ),
        ],
      ),
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