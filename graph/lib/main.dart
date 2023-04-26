import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Map<String, dynamic>> bookings = [
    {"from": "2023-03-25T18:30:00.000"},
    {"from": "2023-03-27T18:30:00.000"},
    {"from": "2023-03-27T48:30:00.000"},
    {"from": "2023-03-26T18:30:00.000"}
  ];

  List<DateTime> lastSevenDaysBookings = [];

  @override
  void initState() {
    super.initState();
    // Get the last seven days bookings from the list of bookings
    DateTime today = DateTime.now();
    for (int i = 0; i < 7; i++) {
      DateTime date = today.subtract(Duration(days: i));
      lastSevenDaysBookings.add(DateTime(date.year, date.month, date.day));
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Last Seven Days Bookings"),
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: LineChart(
            LineChartData(
              titlesData: FlTitlesData(
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: bottomTitleWidgets,
                    getTextStyles: (context, value) =>
                        const TextStyle(fontSize: 10),
                    margin: 8,
                    getTitles: (value) {
                      // Display the date in format "dd/MM"
                      return "${lastSevenDaysBookings[value.toInt()].toString().substring(8, 10)}/${lastSevenDaysBookings[value.toInt()].toString().substring(5, 7)}";
                    },
                  ),
                ),
              ),
              lineBarsData: [
                LineChartBarData(
                  spots: List.generate(
                    lastSevenDaysBookings.length,
                    (index) => FlSpot(
                      index.toDouble(),
                      getBookingsCount(lastSevenDaysBookings[index], bookings).toDouble(),
                    ),
                  ),
                  isCurved: true,
                  color: Colors.blue,
                  barWidth: 2,
                  isStrokeCapRound: true,
                  dotData: FlDotData(
                    show: true,
                    getDotPainter: (spot, percent, barData, index) =>
                        FlDotCirclePainter(
                      radius: 3,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ],
              minY: 0,
              maxY: 5,
              borderData: FlBorderData(
                border: Border.all(
                  color: Colors.grey,
                  width: 1,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
    );
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = Text('aaaaaa', style: style);
        break;
      // case 1:
      //   text = Text(las7Days[5].toString(), style: style);
      //   break;
      // case 2:
      //   text = Text(las7Days[4].toString(), style: style);
      //   break;
      // case 3:
      //   text = Text(las7Days[3].toString(), style: style);
      //   break;
      // case 4:
      //   text = Text(las7Days[2].toString(), style: style);
      //   break;
      // case 5:
      //   text = Text(las7Days[1].toString(), style: style);
      //   break;
      // case 6:
      //   text = Text(las7Days[0].toString(), style: style);
      //   break;
      default:
        text = const Text('', style: style);
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }
  int getBookingsCount(DateTime date, List<Map<String, dynamic>> bookings) {
    // Get the count of bookings for the given date
    int count = 0;
    for (Map<String, dynamic> booking in bookings) {
      DateTime bookingDate = DateTime.parse(booking["from"]).toLocal();
      if (bookingDate.year == date.year &&
          bookingDate.month == date.month &&
          bookingDate.day == date.day) {
        count++;
      }
    }
    return count;
  }
}
