import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final RxList<Map<String, dynamic>> notifications = [
    {
      'title': 'New Schedule Update',
      'description': 'Your meeting with Dr. Smith has been rescheduled to 3 PM',
      'time': DateTime.now().subtract(const Duration(minutes: 30)),
      'isRead': false,
      'type': 'schedule',
    },
    {
      'title': 'Product Update',
      'description': 'New documentation available for CardioPlus medication',
      'time': DateTime.now().subtract(const Duration(hours: 2)),
      'isRead': false,
      'type': 'product',
    },
    {
      'title': 'Meeting Reminder',
      'description': 'Upcoming meeting with Dr. Johnson in 1 hour',
      'time': DateTime.now().subtract(const Duration(hours: 4)),
      'isRead': true,
      'type': 'reminder',
    },
  ].obs;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications', 
          style: GoogleFonts.poppins(color: Colors.white)),
        backgroundColor: theme.primaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          if (notifications.any((n) => !n['isRead']))
            TextButton.icon(
              onPressed: () {
                for (var notification in notifications) {
                  notification['isRead'] = true;
                }
                setState(() {});
              },
              icon: const Icon(Icons.done_all, color: Colors.white),
              label: Text('Mark all as read',
                style: GoogleFonts.poppins(color: Colors.white)),
            ),
        ],
      ),
      body: Obx(
        () => notifications.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.notifications_off_outlined,
                      size: 64,
                      color: theme.primaryColor.withOpacity(0.5),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'No notifications yet',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              )
            : ListView.builder(
                itemCount: notifications.length,
                itemBuilder: (context, index) {
                  final notification = notifications[index];
                  return _buildNotificationTile(
                    context: context,
                    notification: notification,
                    onTap: () {
                      notification['isRead'] = true;
                      setState(() {});
                      // TODO: Handle notification tap
                    },
                  );
                },
              ),
      ),
    );
  }

  Widget _buildNotificationTile({
    required BuildContext context,
    required Map<String, dynamic> notification,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);
    final IconData icon;
    final Color iconColor;

    switch (notification['type']) {
      case 'schedule':
        icon = Icons.calendar_today;
        iconColor = Colors.blue;
        break;
      case 'product':
        icon = Icons.medical_services;
        iconColor = Colors.green;
        break;
      case 'reminder':
        icon = Icons.alarm;
        iconColor = Colors.orange;
        break;
      default:
        icon = Icons.notifications;
        iconColor = theme.primaryColor;
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: notification['isRead'] 
            ? theme.cardColor
            : theme.primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: CircleAvatar(
          backgroundColor: iconColor.withOpacity(0.1),
          child: Icon(icon, color: iconColor),
        ),
        title: Text(
          notification['title'],
          style: GoogleFonts.poppins(
            fontWeight: notification['isRead'] ? FontWeight.normal : FontWeight.bold,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              notification['description'],
              style: GoogleFonts.poppins(fontSize: 12),
            ),
            const SizedBox(height: 4),
            Text(
              _getTimeAgo(notification['time']),
              style: GoogleFonts.poppins(
                fontSize: 11,
                color: Colors.grey,
              ),
            ),
          ],
        ),
        onTap: onTap,
      ),
    );
  }

  String _getTimeAgo(DateTime time) {
    final now = DateTime.now();
    final difference = now.difference(time);

    if (difference.inMinutes < 60) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hours ago';
    } else {
      return '${difference.inDays} days ago';
    }
  }
}