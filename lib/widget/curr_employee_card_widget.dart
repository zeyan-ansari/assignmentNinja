import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

import '../edit_employee.dart';

class CurrentEmployeeCard extends StatefulWidget {
  const CurrentEmployeeCard({
    super.key,  required this.box,
  });
  final Box box;

  @override
  State<CurrentEmployeeCard> createState() => _CurrentEmployeeCardState();
}

class _CurrentEmployeeCardState extends State<CurrentEmployeeCard> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 15),
              width: double.infinity,
              color: Colors.grey.withOpacity(0.1),
              child: const Text('Current Employees',style: TextStyle(color: Colors.blue),)),
          Expanded(
            child: ListView.builder(
                itemCount: widget.box.length,
                itemBuilder: (context, index){
                  var currentBox = widget.box;
                  var personData = currentBox.getAt(index)!;
                  return personData.isCurrentEmployee?Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Dismissible(
                        // Each Dismissible must contain a Key. Keys allow Flutter to
                        // uniquely identify widgets.
                        background: Container(
                          color: Colors.red,
                          child: const Align(
                              alignment: Alignment.centerLeft,
                              child: Icon(Icons.delete,color: Colors.white,)),
                        ),
                        secondaryBackground: Container(
                          color: Colors.yellow,
                          child:  Align(
                              alignment: Alignment.centerRight,
                              child: Icon(Icons.edit,color: Colors.white,)),
                        ),
                        key: UniqueKey(),
                        // Provide a function that tells the app
                        // what to do after an item has been swiped away.
                        onDismissed: (DismissDirection direction) {
                          // Remove the item from the data source.
                          if (direction == DismissDirection.startToEnd) {
                            setState(() {
                              widget.box.deleteAt(index);

                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(content: Text(' Employee has been deleted')));
                            });
                          } else {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) =>  EditEmployer(
                                  index:index
                              )),
                            );
                          }

                          // Then show a snackbar.

                        },

                        child: Container(                          width:double.infinity,

                          margin: const EdgeInsets.symmetric(vertical: 15,horizontal: 15),
                          child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(personData.name,style: const TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 16),),
                              Text(personData.role,style: const TextStyle(color: Colors.grey,fontSize: 13),),
                              Text(DateFormat.yMMMd().format(DateTime.parse(personData.startDate)),style: const TextStyle(color: Colors.grey,fontSize: 13),)
                            ],
                          ),
                        ),
                      ),
                      Divider(color: Colors.grey.withOpacity(0.3),)

                    ],
                  ):const SizedBox();
                }),
          ),
        ],
      ),
    );
  }
}
