import 'package:flutter/material.dart';

class InstructorContainer extends StatefulWidget {
  final TextEditingController replyController;

  const InstructorContainer({
    Key? key,
    required this.replyController,
  }) : super(key: key);

  @override
  State<InstructorContainer> createState() => _InstructorContainerState();
}

class _InstructorContainerState extends State<InstructorContainer> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          TextField(
            controller: widget.replyController,
            cursorColor: const Color(0xFF8CC13F),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Leave a reply...',
              hintStyle: TextStyle(
                color: Colors.grey[600],
                fontSize: 16,
              ),
              prefixIcon: const Padding(
                padding: EdgeInsets.only(right: 12),
                child: CircleAvatar(
                  backgroundColor: Colors.grey,
                  child: Icon(Icons.person, color: Colors.white),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF78A03F),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: _isLoading
                  ? null
                  : () {
                if (widget.replyController.text.trim().isNotEmpty) {
                  widget.replyController.clear();
                }
              },
              child: _isLoading
                  ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
                  : const Text(
                'Reply',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}