import 'package:fitur_buat_laporan/presentation/style/text_style.dart';
import 'package:pdf/widgets.dart';

class LaporanTitleHeader extends StatelessWidget {
  final String period;
  LaporanTitleHeader({required this.period});

  @override
  Widget build(Context context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
              "MACHINE SPARE PART STOCK TAKING LIST\n"
              "BUSINESS UNIT : FAN\n"
              "PERIOD : $period",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 7
            ),
            textAlign: TextAlign.center
          )
        ),

        SizedBox(
          width: 136,
          child: Table(
            border: TableBorder.all(width: 0.5),
            children: [
              TableRow(
                children: [
                  Text("Approved" , style: textNormalStyle , textAlign: TextAlign.center),
                  Text("Checked" , style: textNormalStyle , textAlign: TextAlign.center),
                  Text("Proposed" , style: textNormalStyle , textAlign: TextAlign.center),
                ]
              ),

              TableRow(
                children: [
                  SizedBox(height: 30),
                  SizedBox(height: 30),
                  SizedBox(height: 30),
                ]
              ),
            ]
          )
        )
      ]
    );
  }

}