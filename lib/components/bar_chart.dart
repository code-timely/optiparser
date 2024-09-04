import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:optiparser/constants.dart';

class TheBarChart extends StatefulWidget {
  final List listOftransactions;
  TheBarChart({required this.listOftransactions});

  @override
  State<StatefulWidget> createState() => TheBarChartState();
}

class TheBarChartState extends State<TheBarChart> {
  final Color leftBarColor = kPrimaryColor;
  final Color rightBarColor = const Color(0xffff5182);
  final Color nullBarColor = Colors.grey.withOpacity(0.2);
  final double width = 7;
  List myList = [];
  late List<BarChartGroupData> rawBarGroups;
  late List<BarChartGroupData> showingBarGroups;

  @override
  void initState() {
    super.initState();
    makeList();

    int i = -1;
    final items = myList.reversed.map((e) {
      i++;
      return makeGroupData(
        i,
        (e['expense']).toDouble(),
        (e['income']).toDouble(),
      );
    }).toList();

    rawBarGroups = items;
    showingBarGroups = rawBarGroups;
  }

  void makeList() {
    if (widget.listOftransactions.isNotEmpty) {
      for (int i = 0; i < 7; i++) {
        var dayVar = DateTime.now().subtract(Duration(days: i));
        double expenses = 0;
        double incomes = 0;
        for (int j = 0; j < widget.listOftransactions.length; j++) {
          if (widget.listOftransactions[j].date.day == dayVar.day &&
              widget.listOftransactions[j].date.month == dayVar.month &&
              widget.listOftransactions[j].date.year == dayVar.year) {
            if( widget.listOftransactions[j].isExpense == true){
              expenses += widget.listOftransactions[j].amount;
            }
            else{
              incomes += widget.listOftransactions[j].amount;
            }
          }
        }
        widget.listOftransactions.removeWhere((element) =>
            element.date.day == dayVar.day &&
            element.date.month == dayVar.month &&
            element.date.year == dayVar.year);
        myList.add({
          'expense': expenses,
          'income': incomes,
          'day': dayVar,
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${DateFormat(DateFormat.MONTH).format(DateTime.now())} - ${DateTime.now().year}",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          SizedBox(height: 15),
          Text(
            "${DateTime.now().subtract(Duration(days: 6)).day} ${DateFormat(DateFormat.ABBR_MONTH).format(DateTime.now().subtract(Duration(days: 6)))} ----> ${DateTime.now().day} ${DateFormat(DateFormat.ABBR_MONTH).format(DateTime.now())} \n",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          AspectRatio(
            aspectRatio: 1,
            child: Card(
              margin: EdgeInsets.all(3),
              elevation: 1.2,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15, 20, 6, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        makeTransactionsIcon(),
                        const SizedBox(width: 38),
                        const Text(
                          'Transactions',
                          style: TextStyle(color: Colors.indigo, fontSize: 22),
                        ),
                        const SizedBox(width: 4),
                      ],
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                        child: BarChart(
                          BarChartData(
                            maxY: 2500,
                            titlesData: FlTitlesData(
                              bottomTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  reservedSize: 40,
                                  getTitlesWidget: (value, meta) {
                                    final index = value.toInt();
                                    final day = myList[6 - index]['day'];
                                    return SideTitleWidget(
                                      axisSide: meta.axisSide,
                                      child: Text(
                                        DateFormat(DateFormat.ABBR_WEEKDAY)
                                            .format(day)
                                            .substring(0, 2),
                                        style: const TextStyle(
                                          color: Colors.indigo,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                      ),
                                    );
                                  },
                                  // margin: 20,
                                ),
                              ),
                              leftTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  reservedSize: 40,
                                  getTitlesWidget: (value, meta) {
                                    String text;
                                    if (value == 500) {
                                      text = '500';
                                    } else if (value == 1000) {
                                      text = '1K';
                                    } else if (value == 1500) {
                                      text = '1.5K';
                                    } else if (value == 2000) {
                                      text = '2K';
                                    } else if (value == 2500) {
                                      text = '2.5K';
                                    } else {
                                      text = '';
                                    }
                                    return SideTitleWidget(
                                      axisSide: meta.axisSide,
                                      child: Text(
                                        text,
                                        style: const TextStyle(
                                          color: Colors.indigo,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                      ),
                                    );
                                  },
                                  // margin: 32,
                                ),
                              ),
                              rightTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: false,
                                  reservedSize: 40,

                                )
                              ),
                              topTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: false
                                )
                              )
                            ),
                            borderData: FlBorderData(
                              show: false,
                            ),
                            barGroups: showingBarGroups,
                            gridData: FlGridData(
                              drawVerticalLine: false,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Expanded(
                            child:
                                indicators(context, rightBarColor, "Income")),
                        Expanded(
                            child:
                                indicators(context, leftBarColor, "Expenses")),
                        Expanded(
                            child:
                                indicators(context, nullBarColor, "Not Yet")),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  FlLine horizontal_grid(){
    return FlLine(
      color: Colors.grey.shade300,
      strokeWidth: 1,
      dashArray: [5, 5], // Dashed vertical lines
    );
  }

  Widget indicators(BuildContext context, Color color, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15, top: 15),
      child: Row(
        children: <Widget>[
          CircleAvatar(
            backgroundColor: color,
            radius: 5,
          ),
          const SizedBox(width: 7),
          Text(
            text,
            style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.bold, color: color),
          ),
        ],
      ),
    );
  }

  BarChartGroupData makeGroupData(int x, double y1, double y2) {
    return BarChartGroupData(
      barsSpace: 4,
      x: x,
      barRods: [
        BarChartRodData(
          toY: y1 == 0 ? 20 : y1,
          color: y1 != 0 ? leftBarColor : nullBarColor,
          width: width,
        ),
        BarChartRodData(
          toY: y2 == 0 ? 20 : y2,
          color: y2 != 0 ? rightBarColor : nullBarColor,
          width: width,
        ),
      ],
    );
  }

  Widget makeTransactionsIcon() {
    const double width = 4.5;
    const double space = 3.5;
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          width: width,
          height: 10,
          color: Colors.blue.withOpacity(0.7),
        ),
        const SizedBox(width: space),
        Container(
          width: width,
          height: 28,
          color: Colors.amber.withOpacity(0.6),
        ),
        const SizedBox(width: space),
        Container(
          width: width,
          height: 42,
          color: Colors.blue,
        ),
        const SizedBox(width: space),
        Container(
          width: width,
          height: 28,
          color: Colors.amber.withOpacity(0.6),
        ),
        const SizedBox(width: space),
        Container(
          width: width,
          height: 10,
          color: Colors.blue.withOpacity(0.7),
        ),
      ],
    );
  }
}
