import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // width: 200.0,
      // height: 100.0,
      child: Card(
        child: Column(
          children: [
            Shimmer.fromColors(
                baseColor: Colors.grey[300],
                highlightColor: Colors.grey[100],
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: Center(
                      child: Container(
                        height: 200,
                        width: MediaQuery.of(context).size.width,
                      ),
                    ),
                  ),
                )),
            Shimmer.fromColors(
                baseColor: Colors.grey[300],
                highlightColor: Colors.grey[100],
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                  child: Card(
                    child: Center(
                      child: Container(
                        height: 15,
                        width: MediaQuery.of(context).size.width,
                      ),
                    ),
                  ),
                )),
            Shimmer.fromColors(
                baseColor: Colors.grey[300],
                highlightColor: Colors.grey[100],
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                  child: Card(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 80.0),
                        child: Container(
                          height: 15,
                          width: 60,
                        ),
                      ),
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
