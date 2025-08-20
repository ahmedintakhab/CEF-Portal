import 'package:flutter/material.dart';
import 'conversation_container.dart';
import 'instructor_container.dart';

class DiscussionPage extends StatefulWidget {
  const DiscussionPage({Key? key}) : super(key: key);

  @override
  State<DiscussionPage> createState() => _DiscussionPageState();
}

class _DiscussionPageState extends State<DiscussionPage> {
  final TextEditingController _replyController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  int? _selectedDiscussionId;

  @override
  void initState() {
    super.initState();
    _selectedDiscussionId = 1; // Default static selection
  }

  @override
  void dispose() {
    _replyController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _selectDiscussionForReply(int discussionId) {
    setState(() {
      _selectedDiscussionId = discussionId;
      _replyController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Start Conversation Container
              ConversationContainer(
                messageController: _messageController,
              ),
              const SizedBox(height: 20),

              // Static discussion list
              ...[
                {
                  'discussion_id': 1,
                  'discussion_user_name': 'Ahmed Meer',
                  'discussion_user_type': 'Student',
                  'discussion_user_image': 'assets/images/person.png',
                  'discussion_comment': 'This is a great course!',
                  'discussion_created_at': '2025-08-20',
                  'discussion_total_replies': 2,
                  'discussion_replies_list': [
                    {
                      'reply_user_name': 'Ali Hassan',
                      'reply_user_type': 'Instructor',
                      'reply_user_image': 'assets/images/person.png',
                      'reply_comment': 'Thank you! Any questions?',
                      'reply_created_at': '2025-08-19',
                    },
                    {
                      'reply_user_name': 'Sara Khan',
                      'reply_user_type': 'Student',
                      'reply_user_image': 'assets/images/person.png',
                      'reply_comment': 'Yes, can we have more examples?',
                      'reply_created_at': '2025-08-18',
                    },
                  ],
                },
                {
                  'discussion_id': 2,
                  'discussion_user_name': 'Fatima Ali',
                  'discussion_user_type': 'Instructor',
                  'discussion_user_image': 'assets/images/person.png',
                  'discussion_comment': 'Please review the latest module.',
                  'discussion_created_at': '2025-08-17',
                  'discussion_total_replies': 1,
                  'discussion_replies_list': [
                    {
                      'reply_user_name': 'Zainab Ahmed',
                      'reply_user_type': 'Student',
                      'reply_user_image': 'assets/images/person.png',
                      'reply_comment': 'Got it, thanks!',
                      'reply_created_at': '2025-08-16',
                    },
                  ],
                },
              ].map((discussion) {
                final isSelected = discussion['discussion_id'] == _selectedDiscussionId;                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: isSelected
                      ? BoxDecoration(
                    border: Border.all(color: const Color(0xFF78A03F), width: 1),
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.grey[50],
                  )
                      : null,
                  padding: isSelected ? const EdgeInsets.all(8) : EdgeInsets.zero,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {
                          _selectDiscussionForReply(discussion['discussion_id'] as int);
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              backgroundImage: const AssetImage('assets/images/person.png'),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                padding: const EdgeInsets.all(12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          (discussion['discussion_user_name'] as String?) ?? 'Unknown User',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        if ((discussion['discussion_user_type'] as String?) == "Instructor")
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 8,
                                              vertical: 2,
                                            ),
                                            decoration: BoxDecoration(
                                              color: Colors.blue[100],
                                              borderRadius: BorderRadius.circular(12),
                                            ),
                                            child:  Text(
                                              "Instructor",
                                              style: TextStyle(
                                                color: Colors.blue[800],
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    Text((discussion['discussion_comment'] as String?) ?? 'No comment'),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 56, top: 8),
                        child: Row(
                          children: [
                            Text(
                              (discussion['discussion_created_at'] as String?) ?? 'Unknown date',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 12,
                              ),
                            ),
                            const Spacer(),
                            Row(
                              children: [
                                Icon(Icons.message, size: 16, color: Colors.grey[600]),
                                const SizedBox(width: 4),
                                Text(
                                  (discussion['discussion_total_replies'] as int? ?? 0).toString(),
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      // Static reply messages
                      if ((discussion['discussion_replies_list'] as List?)?.isNotEmpty ?? false)
                        ...((discussion['discussion_replies_list'] as List).map((reply) {
                          return Container(
                            margin: const EdgeInsets.only(left: 40, top: 16, bottom: 8),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  backgroundImage: const AssetImage('assets/images/person.png'),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    padding: const EdgeInsets.all(12),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              (reply['reply_user_name'] as String?) ?? 'Unknown User',
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                            if ((reply['reply_user_type'] as String?) == "Instructor")
                                              Container(
                                                padding: const EdgeInsets.symmetric(
                                                  horizontal: 8,
                                                  vertical: 2,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: Colors.blue[100],
                                                  borderRadius: BorderRadius.circular(12),
                                                ),
                                                child:  Text(
                                                  "Instructor",
                                                  style: TextStyle(
                                                    color: Colors.blue[800],
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ),
                                          ],
                                        ),
                                        const SizedBox(height: 4),
                                        Text((reply['reply_comment'] as String?) ?? 'No comment'),
                                        const SizedBox(height: 4),
                                        Text(
                                          (reply['reply_created_at'] as String?) ?? '',
                                          style: TextStyle(
                                            color: Colors.grey[600],
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList()),
                    ],
                  ),
                );
              }).toList(),

              // Reply container
              if (_selectedDiscussionId != null)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     Padding(
                      padding: EdgeInsets.only(left: 12, bottom: 8),
                      child: Text(
                        'Reply to discussion',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[700],
                        ),
                      ),
                    ),
                    InstructorContainer(
                      replyController: _replyController,
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}