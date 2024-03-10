import 'package:flutter/material.dart';
import 'package:plant_app/models/plants.dart';
import 'package:plant_app/ui/screens/widgets/plant_widget.dart';
import 'package:plant_app/constants.dart';

class CartPage extends StatefulWidget {
  final List<Plant> addedToCartPlants;
  const CartPage({Key? key, required this.addedToCartPlants}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: widget.addedToCartPlants.isEmpty ?
      Center(
        child : Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 100,
              child: Image.asset("assets/images/add-cart.png"),
            ),
            const SizedBox(
              height: 10
            ),
            Text(
              "Your cart is Empty",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w300,
                color: Constants.primaryColor,
              ),
            ),
          ],
        ),
      )
      : Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 30),
        height: size.height * .5,
        child : ListView.builder(
          itemCount: widget.addedToCartPlants.length,
          scrollDirection: Axis.vertical,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (BuildContext context, int index){
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 30),
              height: size.height,
              child: Column(
                children: [
                  Expanded(
                    child: 
                      ListView.builder(
                        itemCount: widget.addedToCartPlants.length,
                        scrollDirection: Axis.vertical,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (BuildContext context, int index){
                          return PlantWidget(index: index, plantList: widget.addedToCartPlants);
                        },
                    ),
                  ),
                  Column(
                    children: [
                      const Divider(thickness: 1.0,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            "Total",
                            style: TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          Text(
                           r'$121', 
                           style: TextStyle(
                           fontSize: 24,
                           fontWeight: FontWeight.w300,
                           ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}