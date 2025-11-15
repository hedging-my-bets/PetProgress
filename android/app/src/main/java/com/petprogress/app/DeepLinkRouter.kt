package com.petprogress.app
import android.net.Uri
import android.content.Context
import com.petprogress.app.data.WidgetRepo
import com.petprogress.app.widget.updateAllWidgets
object DeepLinkRouter {
  fun handle(context: Context, uri: Uri): Boolean {
    val host = uri.host ?: return false
    val repo = WidgetRepo(context)
    when (host) {
      "complete" -> repo.mutate { it.completeCurrent() }
      "miss"     -> repo.mutate { it.missCurrent(applyPenalty = true) }
      "skip"     -> repo.mutate { it.skipCurrent() }
      "prev"     -> repo.mutate { it.prev() }
      "next"     -> repo.mutate { it.next() }
      else -> return false
    }
    updateAllWidgets(context); return true
  }
}