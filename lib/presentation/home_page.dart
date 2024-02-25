import 'package:countdown_app/presentation/countdown.dart';
import 'package:countdown_app/presentation/create_page.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late List<Map<String, dynamic>> _countdowns;
  bool _loaded = false;

  final _db = FirebaseFirestore.instance.collection("Countdowns");

  void _onCreate() async {

    List<Map<String, dynamic>> tempList = [];
    var countdowns = await _db.get();

    countdowns.docs.forEach((element) {
      tempList.add(element.data());
    });

    setState(() {
      _countdowns = tempList;
      _loaded = true;
    });
  }

  void createCountdown() {

    showModalBottomSheet(
      enableDrag: false,
      isDismissible: false,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      context: context, 
      builder: (context) => CreatePage(
        onCreate: _onCreate,
        firestoreInstance: _db,
      ),
    );
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: createCountdown,
        shape: const CircleBorder(),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
      body: _loaded ? CustomScrollView(
        slivers: <Widget> [ 
          SliverPadding(
            padding: const EdgeInsets.all(15.0),
            sliver: SliverFixedExtentList(
              itemExtent: 160.0,
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return Column(
                    children: [
                      CountdownTile(
                        countdownName: _countdowns[index]["CountdownName"],
                        hour: _countdowns[index]["Hour"],
                        minute: _countdowns[index]["Minute"],
                        timeOffset: _countdowns[index]["TimeOffset"],
                        deadline: _countdowns[index]["SelectedDate"].toDate(),
                      ),
                      const SizedBox(height: 20.0,),
                    ],
                  );
                },
                childCount: _countdowns.length,
              ),
            ),
          ),
        ],
      ) : const Text(""),
    );
  }
}