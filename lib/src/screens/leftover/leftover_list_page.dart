import 'package:flutter/material.dart';
import 'package:pharmacy_app/src/screens/leftover/leftover_info_card.dart';
import 'package:pharmacy_app/src/store/providers/leftover_provider.dart';
import 'package:pharmacy_app/src/utils/config.dart';
import 'package:provider/provider.dart';

class LeftoverListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Config.scaffoldBackground,
      appBar: AppBar(
        title: Text("LeftOvers"),
        centerTitle: true,
        backgroundColor: Config.scaffoldBackground,
        elevation: 0,
        actions: [
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  //todo : add pdf generation
                },
                child: Icon(
                  Icons.send,
                  size: 26.0,
                ),
              )),
        ],
      ),
      body: context.watch<LeftOverProvider>().leftOverList.length == 0
          ? Center(
        child: Text(
          "There is no LEFTOVER in the database",
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
          ),
        ),
      )
          : ListView.separated(
        padding: EdgeInsets.all(16),
        itemCount:
        context.watch<LeftOverProvider>().leftOverList.length,
        separatorBuilder: (_, index) => SizedBox(
          height: 12,
        ),
        itemBuilder: (_, position) {
          return LeftOverInfoCard(
            leftOver: context
                .read<LeftOverProvider>()
                .leftOverList[position],
          );
        },
      ),
    );
  }
}
