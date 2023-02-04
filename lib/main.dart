import 'package:calendar_plus/bloc/date_bloc.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DateBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MyCalendar(),
      ),
    );
  }
}

class MyCalendar extends StatelessWidget {
  var today = DateTime.now();
  var weekDay = DateTime.now().weekday;

  Map<String, dynamic> dateObject = {
    "isActive": false,
    "dates": [],
    "isSelected": false
  };
  @override
  Widget build(BuildContext context) {
    for (int i = weekDay; i >= 0; i--) {
      DateTime date = DateTime.now().subtract(Duration(days: i - 1));
      dateObject["dates"].add(date);
    }
    for (int i = 1; i < 7 - weekDay; i++) {
      DateTime date = DateTime.now().add(Duration(days: i + 1));
      dateObject["dates"].add(date);
    }

    // print(dateObject["dates"].toString());
    print(dateObject["dates"]);
    print(dateObject["dates"].length.toString());
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('dd  LLLL, EEEE');
    final DateFormat formatter2 = DateFormat('dd');
    final DateFormat formatter4 = DateFormat(
      'EEE',
    );
    final String formatted = formatter.format(now);
    final String formatter3 = formatter2.format(now);
    final String formatter5 = formatter4.format(dateObject["dates"][3]);
    print(formatted);
    print("formatted 3 : $formatter3");
    print("formatted 5 : $formatter5");

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Calendar"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), color: Colors.black12),
            margin:const EdgeInsets.symmetric(horizontal: 4),
            child: Row(children: [
              Expanded(
                flex: 1,
                child: SizedBox(
                  height: 100,
                  child: ListView.builder(
                      padding: const EdgeInsets.all(8),
                      scrollDirection: Axis.horizontal,
                      itemCount: dateObject["dates"].length,
                      itemBuilder: (context, index) {
                        return Container(width: MediaQuery.of(context).size.width /7,
                          child: index == weekDay - 1
                              ? InkWell(
                                  onTap: () {
                                    print(
                                        "Tıklandı ${dateObject["dates"][index]}");
                                    context.read<DateBloc>().add(NewDateEvent(
                                        date: dateObject["dates"][index]));
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.blue.shade300,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        BlocBuilder<DateBloc, DateState>(
                                          builder: (context, state) {
                                            return Text(
                                              formatter4.format(
                                                  dateObject["dates"][index]),
                                              style: const TextStyle(
                                                  color: Colors.white),
                                            );
                                          },
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.all(8.0),
                                            child: Text(formatter2.format(
                                                dateObject["dates"][index])),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              : InkWell(splashColor: Colors.green,borderRadius: BorderRadius.circular(20),
                                  onTap: () {
                                    print("Tıklandı $index");
                                    context.read<DateBloc>().add(NewDateEvent(
                                        date: dateObject["dates"][index]));
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        BlocBuilder<DateBloc, DateState>(
                                          builder: (context, state) {
                                            return Text(formatter4.format(
                                                dateObject["dates"][index]));
                                          },
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Text(formatter2
                                            .format(dateObject["dates"][index]))
                                      ],
                                    ),
                                  ),
                                ),
                        );
                        //Card(child: Container(width: MediaQuery.of(context).size.width /5 ,height: 50,color: Colors.red,),);

                        ;
                      }),
                ),
              ),
            ]),
          ),
          const SizedBox(
            height: 30,
          ),
          Column(
            children: [
              ExpansionTile(
                controlAffinity: ListTileControlAffinity.leading,
                title: BlocBuilder<DateBloc, DateState>(
                  builder: (context, state) {
                    return Text(formatter.format(state.date));
                  },
                ),
                backgroundColor: Colors.white60,
                children: const [
                  Text("Flutter Bloc"),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
