import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class WriteReviewDialog extends StatefulWidget {
  const WriteReviewDialog({Key? key}) : super(key: key);

  @override
  _WriteReviewDialogState createState() => _WriteReviewDialogState();
}

class _WriteReviewDialogState extends State<WriteReviewDialog> {
  double? _selectedRating;
  final TextEditingController _feedbackController = TextEditingController();
  bool _isSubmitPressed = false;
  String? _snackbarMessage;
  Color _snackbarColor = Colors.transparent;
  bool _showSnackbar = false;
  double _snackbarTopPosition = -50;

  void _showCustomSnackBar(String message, Color color) {
    setState(() {
      _snackbarMessage = message;
      _snackbarColor = color;
      _snackbarTopPosition = 0;
      _showSnackbar = true;
    });

    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        _snackbarTopPosition = -50;
      });
      Future.delayed(const Duration(milliseconds: 300), () {
        setState(() {
          _showSnackbar = false;
        });
      });
    });
  }

  void _submitReview() {
    setState(() {
      _isSubmitPressed = true;
    });

    final isFeedbackValid = _feedbackController.text.isNotEmpty;

    if (_selectedRating == null || !isFeedbackValid) {
      _showCustomSnackBar("Please select Star and give feedback", Colors.red);
    } else {
      _showCustomSnackBar("Your review submitted successfully", Colors.green);
      Future.delayed(const Duration(milliseconds: 500), () {
        setState(() {
          _selectedRating = null;
          _feedbackController.clear();
          _isSubmitPressed = false;
        });
        Navigator.of(context).pop();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isWebLayout = MediaQuery.of(context).size.width > 600;
    final double dialogWidth = isWebLayout ? 500 : 300;
    final double dialogHeight = isWebLayout ? 400 : 400; // Increased for Android

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Container(
        width: dialogWidth,
        height: dialogHeight,
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(isWebLayout ? 20.0 : 10.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Write a Review",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: isWebLayout ? 20 : 18,
                            fontFamily: 'Gilroy',
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ],
                    ),
                    SizedBox(height: isWebLayout ? 15 : 10),
                    Text(
                      "Select Rating",
                      style: TextStyle(
                        fontSize: isWebLayout ? 18 : 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Gilroy',
                      ),
                    ),
                    const SizedBox(height: 5),
                    RatingBar(
                      initialRating: 0,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemSize: isWebLayout ? 25 : 21,
                      glow: false,
                      ratingWidget:  RatingWidget(
                        full: Icon(Icons.star, color: Color(0xFF78A03F)),
                        half: Icon(Icons.star_half, color: Color(0xFF78A03F)),
                        empty: Icon(Icons.star_border, color: Color(0xFF78A03F)),
                      ),
                      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                      onRatingUpdate: (rating) {
                        setState(() {
                          _selectedRating = rating;
                        });
                      },
                    ),
                    if (_isSubmitPressed && _selectedRating == null)
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          "Please select a star rating",
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: isWebLayout ? 14 : 12,
                            fontFamily: 'Gilroy',
                          ),
                        ),
                      ),
                    SizedBox(height: isWebLayout ? 15 : 10),
                    Text(
                      "Feedback",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: isWebLayout ? 18 : 16,
                        fontFamily: 'Gilroy',
                      ),
                    ),
                    const SizedBox(height: 5),
                    TextFormField(
                      controller: _feedbackController,
                      maxLines: 4, // Reduced to prevent overflow
                      cursorColor: const Color(0xFF78A03F),
                      decoration: InputDecoration(
                        hintText: "Please write your feedback here",
                        hintStyle: const TextStyle(
                          color: Colors.grey,
                          fontFamily: 'Gilroy',
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: _feedbackController.text.isNotEmpty
                                ? const Color(0xFF8CC13F)
                                : Colors.red,
                            width: 1,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: _isSubmitPressed && _feedbackController.text.isEmpty
                                ? Colors.red
                                : Colors.grey,
                          ),
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {});
                      },
                      style: const TextStyle(fontFamily: 'Gilroy'),
                    ),
                    SizedBox(height: isWebLayout ? 15 : 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.grey[300],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () => Navigator.of(context).pop(),
                          child: Text(
                            "Cancel",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: isWebLayout ? 16 : 14,
                              fontFamily: 'Gilroy',
                            ),
                          ),
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: const Color(0xFF8CC13F),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: _submitReview,
                          child: Text(
                            "Submit Review",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: isWebLayout ? 16 : 14,
                              fontFamily: 'Gilroy',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              top: _snackbarTopPosition,
              left: 0,
              right: 0,
              child: _showSnackbar
                  ? Container(
                padding: const EdgeInsets.symmetric(
                    vertical: 12, horizontal: 16),
                color: _snackbarColor,
                child: Text(
                  _snackbarMessage ?? "",
                  style: const TextStyle(
                    color: Colors.white,
                    fontFamily: 'Gilroy',
                  ),
                  textAlign: TextAlign.center,
                ),
              )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
}