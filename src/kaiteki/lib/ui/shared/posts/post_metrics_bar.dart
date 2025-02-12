import "package:flutter/material.dart";
import "package:kaiteki/fediverse/model/post/metrics.dart";
import "package:tuple/tuple.dart";

class PostMetricBar extends StatelessWidget {
  final PostMetrics metrics;

  const PostMetricBar(this.metrics, {super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      Tuple2(metrics.repeatCount, "repeats"),
      Tuple2(metrics.favoriteCount, "favorites"),
    ];
    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: [
        for (final item in items)
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: item.item1.toString(),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: " ${item.item2}",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.outline,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
