import 'package:assignment/HomePage.dart';
import 'package:assignment/widget/btn_widget.dart';
import 'package:assignment/widget/txtfielld_widget.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import 'model/employee_model.dart';

class EditEmployer extends StatefulWidget {
  const EditEmployer({Key? key, required this.index}) : super(key: key);
final int index;
  @override
  State<EditEmployer> createState() => _EditEmployerState();
}

class _EditEmployerState extends State<EditEmployer> {
  late TextEditingController nameContoroller;
  String dropdownvalue = 'Item 1';

  // List of items in our dropdown menu
  var items = [
    'Product Designer',
    'Flutter Developer',
    'QA Tester',
    'Product Owner',
  ];
  late String selectedText='Select Role';
  late final Box box;
  String _selectedDate = '2002-02-27T14:00:00-0500';
  String _selectedEndDate = '2002-02-27T14:00:00-0500';
  bool isCurrentWorking=false;
  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {

    setState(() {
      if (args.value is DateTime) {
        _selectedDate = args.value.toString();
      }
    });
  }
  void _onSelectionEndChanged(DateRangePickerSelectionChangedArgs args) {

    setState(() {
      if (args.value is DateTime) {
        _selectedEndDate = args.value.toString();
      }
    });
  }
  @override
  void initState() {
    Hive.openBox('peopleBox');

    nameContoroller=TextEditingController();
    box = Hive.box('peopleBox');

    // TODO: implement initState
    super.initState();
  }

  _updateInfo() async {
    People newPerson = People(
        name: nameContoroller.text,
        role: selectedText,
        startDate: _selectedDate,
        endDate: _selectedEndDate,
        isCurrentEmployee:isCurrentWorking

    );
    box.putAt(widget.index,newPerson);
    final snackBar = SnackBar(
      content: Row(
        children: const [
          Icon(Icons.check_circle_outline,color: Colors.white,),
          SizedBox(width: 15,),
          Text('Employee Data Added'),
        ],
      ),
      backgroundColor: (Colors.green),
      action: SnackBarAction(
        label: 'dismiss',
        textColor: Colors.white,
        onPressed: () {
        },
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    print('Info added to box!');
    Future.delayed(const Duration(milliseconds: 1000), () {


      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );

    });

  }

  @override
  void dispose() {
    // Closes all Hive boxes
    Hive.close();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SafeArea(
        child: Container(height: 75,
          child: Column(

            children: [
              Divider(
                color: Colors.grey.withOpacity(.5),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                child: Row(mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    button_widget(fun: () {
                      Navigator.pop(context);
                    }, text: 'Cancel', color: Color(0xffEDF8FF), textColor: Colors.blue,),
                    SizedBox(width: 8,),
                    button_widget(fun: () async{
                      await _updateInfo();
                    }, text: 'Save', color: Colors.blue, textColor: Colors.white,),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        centerTitle: false,
        title: const Text('Edit Employee Details'),
        actions: [],
      ),
      body: Column(
        children: [
          TextFieldWidget(textEditingController: nameContoroller, text: 'Employee Name', iconName: Icons.account_circle_outlined,),
          GestureDetector(
            onTap: (){
              showModalBottomSheet<void>(
                backgroundColor: Colors.transparent,

                // context and builder are
                // required properties in this widget
                context: context,
                builder: (BuildContext context) {
                  // we set up a container inside which
                  // we create center column and display text

                  // Returning SizedBox instead of a Container
                  return Container(
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15))
                    ),
                    height: 250,
                    child: Container(margin: const EdgeInsets.symmetric(vertical: 15),
                      child: ListView.builder(
                          itemCount: items.length,
                          itemBuilder: (context, index){
                            return GestureDetector(
                              onTap: (){
                                setState(() {
                                  selectedText=items[index];
                                  Navigator.pop(context);
                                });
                              },
                              child: Center(child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(items[index],style: const TextStyle(
                                        fontSize: 16,fontWeight: FontWeight.w400
                                    ),),
                                  ),
                                  Divider(color: Colors.grey.withOpacity(0.4),)
                                ],
                              )),
                            );
                          }),
                    ),
                  );
                },
              );
            },
            child: Container(width: double.infinity,
              height: 40,
              decoration: BoxDecoration(color: Colors.white,
                  border: Border.all(color: Colors.grey.withOpacity(0.3))),
              margin: const EdgeInsets.symmetric(horizontal: 15),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  const Icon(Icons.work_outline,color: Colors.blue,),
                  const SizedBox(width: 15,),
                  Expanded(
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('$selectedText'),
                        const Icon(Icons.arrow_drop_down_outlined,color: Colors.blue,)

                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: (){
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                              content: SizedBox(height: 300,width: 50,
                                child: SfDateRangePicker(
                                  onSelectionChanged: _onSelectionChanged,
                                  selectionMode: DateRangePickerSelectionMode.single,

                                ),
                              )
                          );
                        }
                    );

                  },
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(color: Colors.white,
                        border: Border.all(color: Colors.grey.withOpacity(0.3))),
                    margin: const EdgeInsets.symmetric(horizontal: 15,vertical: 15),
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        const Icon(Icons.date_range,color: Colors.blue,),
                        SizedBox(width: 15,),
                        Text(DateFormat.yMMMd().format(DateTime.parse(_selectedDate)))
                      ],
                    ),
                  ),
                ),
              ),
              !isCurrentWorking?Icon(Icons.arrow_forward,color: Colors.blue,):SizedBox(),
              !isCurrentWorking?Expanded(
                child: GestureDetector(
                  onTap: (){
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                              content: SizedBox(height: 300,width: 50,
                                child: SfDateRangePicker(
                                  onSelectionChanged: _onSelectionEndChanged,
                                  selectionMode: DateRangePickerSelectionMode.single,

                                ),
                              )
                          );
                        }
                    );

                  },
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(color: Colors.white,
                        border: Border.all(color: Colors.grey.withOpacity(0.3))),
                    margin: const EdgeInsets.symmetric(horizontal: 15,vertical: 15),
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        const Icon(Icons.calendar_month_rounded,color: Colors.blue,),
                        SizedBox(width: 15,),
                        Text(DateFormat.yMMMd().format(DateTime.parse(_selectedEndDate)))
                      ],
                    ),
                  ),
                ),
              ):SizedBox(),
            ],
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15,vertical: 15),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                GestureDetector(
                  child: !isCurrentWorking?Icon(Icons.circle_outlined):Icon(Icons.check_circle_outline,color: Colors.green,),
                  onTap: () {
                    setState(() {
                      isCurrentWorking = !isCurrentWorking!;
                    });
                  },
                ),
                SizedBox(width: 5,),
                Text('Are You Currently Working Here?')
              ],
            ),
          ),

        ],
      ),
    );
  }
}
