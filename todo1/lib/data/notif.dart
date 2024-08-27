import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:todo1/main.dart';

void scheduleNotification(DateTime scheduledTime, String taskName) {
  // Schedule notification 2 hours before the task's scheduled time
  final tz.TZDateTime scheduledDate =
      tz.TZDateTime.from(scheduledTime.subtract(Duration(hours: 2)), tz.local);

  flutterLocalNotificationsPlugin.zonedSchedule(
    0, // Notification ID, you can use a different ID for each task
    'Task Reminder',
    'Your task "$taskName" is due in 2 hours.',
    scheduledDate,
    const NotificationDetails(
      android: AndroidNotificationDetails(
        'your_channel_id',
        'your_channel_name',
        importance: Importance.high,
        priority: Priority.high,
      ),
    ),
    androidAllowWhileIdle: true,
    uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
    matchDateTimeComponents: DateTimeComponents
        .time, // To match time components for recurring notifications
  );
}
