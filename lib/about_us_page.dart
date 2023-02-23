import 'package:flutter/material.dart';
import 'package:rating_dialog/rating_view.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(16),
          alignment: Alignment.center,
          child: Column(
            children: [
              const FlutterLogo(
                size: 100,
              ),
              Text(
                "dataFormField",
                style: Theme.of(context).textTheme.displaySmall,
              ),
              Spacer(),
              TextButton.icon(
                onPressed: () {
                  openRatingDialog(context);
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    Colors.blue.withOpacity(0.1),
                  ),
                ),
                icon: const Icon(Icons.star),
                label: Text(
                  "Rate us!",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  openRatingDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: RatingView(),
        );
      },
    );
  }
}
