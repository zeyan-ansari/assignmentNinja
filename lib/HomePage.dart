import 'package:assignment/widget/curr_employee_card_widget.dart';
import 'package:assignment/widget/prev_employee_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';

import 'add_employee.dart';
import 'edit_employee.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final Box hPeopleBox;

  @override
  void initState() {
    hPeopleBox= Hive.box('peopleBox');
    Hive.openBox('peopleBox');
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        leading: Container(),
        leadingWidth: 0,
        title: const Text('Employee List'),
      ),
      floatingActionButton: GestureDetector(
        onTap: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddEmployer()),
          );
        },
        child: Container(
          height: 45,width: 45,
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(5)
          ),
          child: const Icon(Icons.add,color: Colors.white,),

        ),
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ValueListenableBuilder(
              valueListenable: hPeopleBox.listenable(),
              builder: (context, Box box, child) {
              return hPeopleBox.isEmpty?Center(
                child: SizedBox(
                    height: 200,width: 200,
                    child: Image.asset('assets/empty.png')),
              ):CurrentEmployeeCard(box:box);
            }
          ),
          ValueListenableBuilder(
              valueListenable: hPeopleBox.listenable(),
              builder: (context, Box box, child) {
                return hPeopleBox.isEmpty?Center(
                  child: SizedBox(
                      height: 200,width: 200,
                      child: Image.asset('assets/empty.png')),
                ):PreviousEmplyeeCard(box:box);
              }
          ),
          Container(
              height: 120,
              padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 15),
              width: double.infinity,
              color: Colors.grey.withOpacity(0.1),
              child: Column(mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('Swipe Right To Delete',style: TextStyle(color: Colors.grey),),
                  Text('Swipe Left To Edit',style: TextStyle(color: Colors.grey),),
                ],
              )),
        ],
      ),
    );
  }
}


