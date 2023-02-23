import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'about_us_page.dart';
import 'formFieldWidget.dart';

class RatingView extends StatefulWidget {
  RatingView({
    Key? key,
  }) : super(key: key);

  @override
  State<RatingView> createState() => _RatingViewState();
}

class _RatingViewState extends State<RatingView> {
  PageController ratingPageController = PageController();
  var _starPosition = 200.0;
  var _rating = 0;
  var _selectedChipIndex = -1;
  var _isMoreDetailActive = false;
  var _moreDetailFocusNode = FocusNode();

  final textEditingController = TextEditingController();

  // @override
  // void initState() {
  //   super.initState();
  //   textEditingController = TextEditingController();
  // }
  //
  // @override
  // void dispose() {
  //   textEditingController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          // Thanks note
          Container(
            height: max(300, MediaQuery.of(context).size.height * 0.3),
            child: PageView(
              controller: ratingPageController,
              physics: NeverScrollableScrollPhysics(),
              children: [
                _buildThanksNote(),
                _causeOfRating(),
              ],
            ),
          ),
          // Done button
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: Container(
              color: Colors.red,
              child: MaterialButton(
                onPressed: () {
                  _hideDialog();
                },
                child: Text(
                  "Done",
                ),
                textColor: Colors.white,
              ),
            ),
          ),
          // Skip button
          Positioned(
            right: 0,
            child: MaterialButton(
              onPressed: () {
                _hideDialog();
              },
              child: Text("Skip"),
            ),
          ),
          // Star rating
          AnimatedPositioned(
            top: _starPosition,
            left: 0,
            right: 0,
            duration: Duration(milliseconds: 300),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                5,
                (index) => IconButton(
                  icon: index < _rating
                      ? Icon(Icons.star, size: 32)
                      : Icon(Icons.star_border, size: 32),
                  color: Colors.red,
                  onPressed: () {
                    ratingPageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.ease,
                    );
                    setState(() {
                      _starPosition = 20.0;
                      _rating = index + 1;
                    });
                  },
                ),
              ),
            ),
          ),
          // Back button
          Positioned(
            left: 0,
            top: 0,
            child: MaterialButton(
              onPressed: () {
                setState(() {
                  _isMoreDetailActive = false;
                });
              },
              child: Icon(Icons.arrow_back_ios),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildThanksNote() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Thanks for riding on Bus on Demand",
          style: TextStyle(
            fontSize: 24,
            color: Colors.red,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        Text("We\'d love to get your feedback"),
        Text("How was your ride today"),
      ],
    );
  }

  Widget _causeOfRating() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Visibility(
          visible: !_isMoreDetailActive,
          replacement: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Tell us more"),
              Chip(
                label: Text("Text ${_selectedChipIndex + 1}"),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextField(
                  controller: textEditingController,
                  focusNode: _moreDetailFocusNode,
                  decoration: InputDecoration(
                    hintText: "Write your review here",
                    hintStyle: TextStyle(
                      color: Colors.grey[400],
                    ),
                  ),
                ),
              ),
              Text(textEditingController.text),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("What could be better?"),
              // Cause selection
              Wrap(
                spacing: 8,
                alignment: WrapAlignment.center,
                children: List.generate(
                  6,
                  (index) => InkWell(
                    onTap: () {
                      setState(() {
                        _selectedChipIndex = index;
                      });
                    },
                    child: Chip(
                      backgroundColor: _selectedChipIndex == index
                          ? Colors.red
                          : Colors.grey[300],
                      label: Text(
                        "Text ${index + 1}",
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              // More button
              InkWell(
                onTap: () {
                  _moreDetailFocusNode.requestFocus();
                  setState(() {
                    _isMoreDetailActive = true;
                  });
                },
                child: Text(
                  "Want to tell us more?",
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  _hideDialog() {
    if (Navigator.canPop(context)) Navigator.pop(context);
  }
}
