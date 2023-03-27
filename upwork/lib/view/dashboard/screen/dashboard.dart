import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:upwork/constants/images.dart';
import 'package:upwork/providers/firebase_provider.dart';
import 'package:upwork/view/dashboard/widgets/stats_card.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
      await Provider.of<FirebaseProvider>(context, listen: false).getCurrentStock();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FirebaseProvider>(
      builder: (context, provider, child) {
        return Stack(
          children: [
            Container(child: Image.asset(ImageConstants.pizza, fit: BoxFit.cover), width: double.infinity),
            Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(title: const Text('Inventory App')),
              body: !provider.isLoading
                  ? ListView(
                      children: [
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            StatsCard(name: 'Pizza Bread', value: provider.sotck!.pizzaBase.toString(), unit: 'pcs'),
                            StatsCard(name: 'Cheese', value: provider.sotck!.cheese.toString(), unit: 'kg'),
                            StatsCard(name: 'Chicken', value: provider.sotck!.chicken.toString(), unit: 'kg'),
                            StatsCard(name: 'Sauce', value: provider.sotck!.sauce.toString(), unit: 'ltr'),
                          ],
                        ),
                      ],
                    )
                  : const Center(
                      child: CircularProgressIndicator(),
                    ),
              bottomNavigationBar: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                child: ElevatedButton(
                  onPressed: () async {
                    provider.makeChickenPizza(context);
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
                  ),
                  child: Text('Make Pizza'),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
