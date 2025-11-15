package com.petprogress.app.notify
import android.app.*
import android.content.*
import android.os.Build
import androidx.core.app.NotificationCompat
import java.util.*
object NightNudge {
  private const val CHANNEL_ID = "pp_daily"
  fun schedule8pm(context: Context) {
    val am = context.getSystemService(Context.ALARM_SERVICE) as AlarmManager
    val intent = Intent(context, NudgeReceiver::class.java)
    val pi = PendingIntent.getBroadcast(context, 1001, intent, PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE)
    val cal = Calendar.getInstance().apply { set(Calendar.HOUR_OF_DAY, 20); set(Calendar.MINUTE, 0); set(Calendar.SECOND, 0); set(Calendar.MILLISECOND, 0) }
    var trigger = cal.timeInMillis
    if (trigger <= System.currentTimeMillis()) trigger += 24*60*60*1000
    if (Build.VERSION.SDK_INT >= 23) am.setExactAndAllowWhileIdle(AlarmManager.RTC_WAKEUP, trigger, pi) else am.setExact(AlarmManager.RTC_WAKEUP, trigger, pi)
  }
}
class NudgeReceiver: BroadcastReceiver() {
  override fun onReceive(context: Context, intent: Intent?) {
    val nm = context.getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
    if (Build.VERSION.SDK_INT >= 26) nm.createNotificationChannel(NotificationChannel("pp_daily","Daily", NotificationManager.IMPORTANCE_DEFAULT))
    val open = PendingIntent.getActivity(context, 0, Intent(context, Class.forName("com.petprogress.app.MainActivity")), PendingIntent.FLAG_IMMUTABLE)
    val done = PendingIntent.getActivity(context, 1, Intent(Intent.ACTION_VIEW, android.net.Uri.parse("myapp://complete")), PendingIntent.FLAG_IMMUTABLE)
    val notif = NotificationCompat.Builder(context, "pp_daily")
      .setSmallIcon(android.R.drawable.ic_dialog_info)
      .setContentTitle("Daily check-in")
      .setContentText("Finish your habits and evolve your pet.")
      .setContentIntent(open)
      .addAction(0, "Mark Done", done)
      .build()
    nm.notify(1002, notif); NightNudge.schedule8pm(context)
  }
}