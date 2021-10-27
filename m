Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EADC143C60A
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Oct 2021 11:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbhJ0JGY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 27 Oct 2021 05:06:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:33196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241169AbhJ0JGW (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 27 Oct 2021 05:06:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1D52A61039;
        Wed, 27 Oct 2021 09:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635325437;
        bh=/egQCEPRE/eAy1USBty0X0DOrwXMjnUfOHnXn0v/EgA=;
        h=From:To:Cc:Subject:Date:From;
        b=ZheQoqsH+DEX6WbAwGzAsBc74Tn49NAG8nEWqpF8JM+xy6y7ZV8YkN3G8Q+uqM37f
         ZiGsj0jHqpefVKxV+f0kYxM5RLqTmeJEQOX32TiDqpjfpoOq5JitKE/V97Z1jaklAj
         ahC2N2Gx8qS/W90Jv5g8s9LIMDn3HueMHf0pUgYEyIkLFbcKA59pyT8noiH8cqWEN5
         ZBT24hGrSP68HFn+r/6ZeKhSr7znc4gnxMdvGhFeSWvH0PuNgvDQ7Xk7oljd5eh5B4
         QDG6me0y85eSDvL0+bIxs8CytOOQdpv3dq3i+DFhWV0n0T5zA1chiZ1E06a7agyRB8
         ahO5qWH8UK6CQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     johannes@sipsolutions.net
Cc:     nbd@nbd.name, linux-wireless@vger.kernel.org,
        lorenzo.bianconi@redhat.com, ryder.lee@mediatek.com,
        evelyn.tsai@mediatek.com
Subject: [PATCH mac80211-next] cfg80211: move offchan_cac_event to a dedicate work
Date:   Wed, 27 Oct 2021 11:03:42 +0200
Message-Id: <6145c3d0f30400a568023f67981981d24c7c6133.1635325205.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In order to be run in atomic context, move offchan_cac_event to a
dedicate work.
Rename offchan_cac_work in offchan_cac_done_wk.
Rename cfg80211_offchan_cac_event routine in cfg80211_offchan_cac_abort.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 include/net/cfg80211.h | 14 +++--------
 net/wireless/core.c    |  6 ++++-
 net/wireless/core.h    |  7 ++++--
 net/wireless/mlme.c    | 56 +++++++++++++++++++++++++++---------------
 4 files changed, 50 insertions(+), 33 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 908794b82a49..6528f49104c3 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -7647,19 +7647,13 @@ void cfg80211_cac_event(struct net_device *netdev,
 			enum nl80211_radar_event event, gfp_t gfp);
 
 /**
- * cfg80211_offchan_cac_event - Channel Availability Check (CAC) offchan event
+ * cfg80211_offchan_cac_abort - Channel Availability Check offchan abort event
  * @wiphy: the wiphy
- * @chandef: chandef for the current channel
- * @event: type of event
- *
- * This function is called when a Channel Availability Check (CAC) is finished,
- * started or aborted by a offchannel dedicated chain.
  *
- * Note that this acquires the wiphy lock.
+ * This function is called by the driver when a Channel Availability Check
+ * (CAC) is aborted by a offchannel dedicated chain.
  */
-void cfg80211_offchan_cac_event(struct wiphy *wiphy,
-				const struct cfg80211_chan_def *chandef,
-				enum nl80211_radar_event event);
+void cfg80211_offchan_cac_abort(struct wiphy *wiphy);
 
 /**
  * cfg80211_gtk_rekey_notify - notify userspace about driver rekeying
diff --git a/net/wireless/core.c b/net/wireless/core.c
index 230f04a628b9..a924e7c2957d 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -544,7 +544,9 @@ struct wiphy *wiphy_new_nm(const struct cfg80211_ops *ops, int sizeof_priv,
 	INIT_WORK(&rdev->rfkill_block, cfg80211_rfkill_block_work);
 	INIT_WORK(&rdev->conn_work, cfg80211_conn_work);
 	INIT_WORK(&rdev->event_work, cfg80211_event_work);
-	INIT_DELAYED_WORK(&rdev->offchan_cac_work, cfg80211_offchan_cac_work);
+	INIT_WORK(&rdev->offchan_cac_abort_wk, cfg80211_offchan_cac_abort_wk);
+	INIT_DELAYED_WORK(&rdev->offchan_cac_done_wk,
+			  cfg80211_offchan_cac_done_wk);
 
 	init_waitqueue_head(&rdev->dev_wait);
 
@@ -1054,11 +1056,13 @@ void wiphy_unregister(struct wiphy *wiphy)
 	cancel_work_sync(&rdev->conn_work);
 	flush_work(&rdev->event_work);
 	cancel_delayed_work_sync(&rdev->dfs_update_channels_wk);
+	cancel_delayed_work_sync(&rdev->offchan_cac_done_wk);
 	flush_work(&rdev->destroy_work);
 	flush_work(&rdev->sched_scan_stop_wk);
 	flush_work(&rdev->propagate_radar_detect_wk);
 	flush_work(&rdev->propagate_cac_done_wk);
 	flush_work(&rdev->mgmt_registrations_update_wk);
+	flush_work(&rdev->offchan_cac_abort_wk);
 
 #ifdef CONFIG_PM
 	if (rdev->wiphy.wowlan_config && rdev->ops->set_wakeup)
diff --git a/net/wireless/core.h b/net/wireless/core.h
index 48ebbece468c..2cde69da1f27 100644
--- a/net/wireless/core.h
+++ b/net/wireless/core.h
@@ -86,7 +86,8 @@ struct cfg80211_registered_device {
 
 	struct wireless_dev *offchan_radar_wdev;
 	struct cfg80211_chan_def offchan_radar_chandef;
-	struct delayed_work offchan_cac_work;
+	struct delayed_work offchan_cac_done_wk;
+	struct work_struct offchan_cac_abort_wk;
 
 	/* netlink port which started critical protocol (0 means not started) */
 	u32 crit_proto_nlportid;
@@ -500,7 +501,9 @@ cfg80211_start_offchan_radar_detection(struct cfg80211_registered_device *rdev,
 
 void cfg80211_stop_offchan_radar_detection(struct wireless_dev *wdev);
 
-void cfg80211_offchan_cac_work(struct work_struct *work);
+void cfg80211_offchan_cac_done_wk(struct work_struct *work);
+
+void cfg80211_offchan_cac_abort_wk(struct work_struct *work);
 
 bool cfg80211_any_wiphy_oper_chan(struct wiphy *wiphy,
 				  struct ieee80211_channel *chan);
diff --git a/net/wireless/mlme.c b/net/wireless/mlme.c
index 61512e201999..abf81e71210a 100644
--- a/net/wireless/mlme.c
+++ b/net/wireless/mlme.c
@@ -969,17 +969,6 @@ void cfg80211_cac_event(struct net_device *netdev,
 }
 EXPORT_SYMBOL(cfg80211_cac_event);
 
-void cfg80211_offchan_cac_work(struct work_struct *work)
-{
-	struct delayed_work *delayed_work = to_delayed_work(work);
-	struct cfg80211_registered_device *rdev;
-
-	rdev = container_of(delayed_work, struct cfg80211_registered_device,
-			    offchan_cac_work);
-	cfg80211_offchan_cac_event(&rdev->wiphy, &rdev->offchan_radar_chandef,
-				   NL80211_RADAR_CAC_FINISHED);
-}
-
 static void
 __cfg80211_offchan_cac_event(struct cfg80211_registered_device *rdev,
 			     struct wireless_dev *wdev,
@@ -1004,7 +993,7 @@ __cfg80211_offchan_cac_event(struct cfg80211_registered_device *rdev,
 		rdev->offchan_radar_wdev = NULL;
 		break;
 	case NL80211_RADAR_CAC_ABORTED:
-		cancel_delayed_work(&rdev->offchan_cac_work);
+		cancel_delayed_work(&rdev->offchan_cac_done_wk);
 		wdev = rdev->offchan_radar_wdev;
 		rdev->offchan_radar_wdev = NULL;
 		break;
@@ -1020,17 +1009,44 @@ __cfg80211_offchan_cac_event(struct cfg80211_registered_device *rdev,
 	nl80211_radar_notify(rdev, chandef, event, netdev, GFP_KERNEL);
 }
 
-void cfg80211_offchan_cac_event(struct wiphy *wiphy,
-				const struct cfg80211_chan_def *chandef,
-				enum nl80211_radar_event event)
+static void
+cfg80211_offchan_cac_event(struct cfg80211_registered_device *rdev,
+			   const struct cfg80211_chan_def *chandef,
+			   enum nl80211_radar_event event)
+{
+	wiphy_lock(&rdev->wiphy);
+	__cfg80211_offchan_cac_event(rdev, NULL, chandef, event);
+	wiphy_unlock(&rdev->wiphy);
+}
+
+void cfg80211_offchan_cac_done_wk(struct work_struct *work)
+{
+	struct delayed_work *delayed_work = to_delayed_work(work);
+	struct cfg80211_registered_device *rdev;
+
+	rdev = container_of(delayed_work, struct cfg80211_registered_device,
+			    offchan_cac_done_wk);
+	cfg80211_offchan_cac_event(rdev, &rdev->offchan_radar_chandef,
+				   NL80211_RADAR_CAC_FINISHED);
+}
+
+void cfg80211_offchan_cac_abort_wk(struct work_struct *work)
+{
+	struct cfg80211_registered_device *rdev;
+
+	rdev = container_of(work, struct cfg80211_registered_device,
+			    offchan_cac_abort_wk);
+	cfg80211_offchan_cac_event(rdev, &rdev->offchan_radar_chandef,
+				   NL80211_RADAR_CAC_ABORTED);
+}
+
+void cfg80211_offchan_cac_abort(struct wiphy *wiphy)
 {
 	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wiphy);
 
-	wiphy_lock(wiphy);
-	__cfg80211_offchan_cac_event(rdev, NULL, chandef, event);
-	wiphy_unlock(wiphy);
+	queue_work(cfg80211_wq, &rdev->offchan_cac_abort_wk);
 }
-EXPORT_SYMBOL(cfg80211_offchan_cac_event);
+EXPORT_SYMBOL(cfg80211_offchan_cac_abort);
 
 int
 cfg80211_start_offchan_radar_detection(struct cfg80211_registered_device *rdev,
@@ -1060,7 +1076,7 @@ cfg80211_start_offchan_radar_detection(struct cfg80211_registered_device *rdev,
 	rdev->offchan_radar_chandef = *chandef;
 	__cfg80211_offchan_cac_event(rdev, wdev, chandef,
 				     NL80211_RADAR_CAC_STARTED);
-	queue_delayed_work(cfg80211_wq, &rdev->offchan_cac_work,
+	queue_delayed_work(cfg80211_wq, &rdev->offchan_cac_done_wk,
 			   msecs_to_jiffies(cac_time_ms));
 
 	return 0;
-- 
2.31.1

