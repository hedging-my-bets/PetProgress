package com.petprogress.app.widget

import android.app.PendingIntent
import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.Context
import android.content.Intent
import android.net.Uri
import android.widget.RemoteViews
import com.petprogress.app.R

class PetProgressWidgetProvider : AppWidgetProvider() {

    override fun onUpdate(ctx: Context, mgr: AppWidgetManager, ids: IntArray) {
        ids.forEach { id ->
            val rv = RemoteViews(ctx.packageName, R.layout.widget_petprogress)

            fun pending(action: String): PendingIntent =
                PendingIntent.getActivity(
                    ctx, action.hashCode(),
                    Intent(Intent.ACTION_VIEW, Uri.parse("myapp://$action")),
                    PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
                )

            rv.setOnClickPendingIntent(R.id.btn_complete, pending("complete"))
            rv.setOnClickPendingIntent(R.id.btn_skip,     pending("skip"))
            rv.setOnClickPendingIntent(R.id.btn_prev,     pending("prev"))
            rv.setOnClickPendingIntent(R.id.btn_next,     pending("next"))

            // Tapping the image completes current task (like iOS small)
            rv.setOnClickPendingIntent(R.id.pet_image, pending("complete"))

            mgr.updateAppWidget(id, rv)
        }
    }
}
