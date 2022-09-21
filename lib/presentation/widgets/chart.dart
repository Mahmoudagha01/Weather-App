// import 'package:flutter/material.dart';

// import 'package:syncfusion_flutter_charts/charts.dart';

// import '../../data/models/five_days_data.dart';




// class MyChart {

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: MediaQuery.of(context).size.width,
//       height: 240,
//       child: Card(
//         elevation: 5,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(15),
//         ),
//         child: SfCartesianChart(
//           primaryXAxis: CategoryAxis(),
//           series: <ChartSeries<FiveDayData, String>>[
//             SplineSeries<FiveDayData, String>(
//              dataSource: ,
//               xValueMapper: (FiveDayData f, _) =>
//               f.dateTime,
//               yValueMapper: (FiveDayData f, _) =>
//               f.temp,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }