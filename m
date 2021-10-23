Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC2A438292
	for <lists+linux-wireless@lfdr.de>; Sat, 23 Oct 2021 11:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbhJWJNu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 23 Oct 2021 05:13:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:60848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230166AbhJWJNs (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 23 Oct 2021 05:13:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0E4C061090;
        Sat, 23 Oct 2021 09:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634980290;
        bh=2lSMxPgXNvOnfBq9+fRQ86iDDXDwmQ5IITIUwHcot5Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ehtzRgcw/Gn6A0OkIWwiUAWgIiDJMQK49l5K5fj+rIDhhCrboOt26wPmTmY4sI+v5
         jA75Y/Fn79wmg0WXmnpBerS+vW1Zdr1dqrXllkL+ybhK/niwDaZfDb3VGkvufMeElD
         Y9nXhi4JXDrVnXvD6jkPRLcmkBdgoo110Gxa5bUaNYpPFgCRQk8jqry1ae4D8AWXYv
         KFJL753V/P787MX4U9WPshk6yt5dOjj8nPIll5zMjikdLNrsT7XzXXX8oKzyjQ/CGW
         1L5xqXB5BqeX1Pu9QPcmSZY0hn/4kyT91aoIA72flfb3qvIXoT2Y0fNp+5W49lTJ88
         njHUF7wfvwVGQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     johannes@sipsolutions.net
Cc:     nbd@nbd.name, linux-wireless@vger.kernel.org,
        lorenzo.bianconi@redhat.com, ryder.lee@mediatek.com,
        evelyn.tsai@mediatek.com
Subject: [PATCH v2 mac80211-next 4/6] cfg80211: introduce cfg80211_cac_offchan_event routine
Date:   Sat, 23 Oct 2021 11:10:53 +0200
Message-Id: <85fa50f57fc3adb2934c8d9ca0be30394de6b7e8.1634979655.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1634979655.git.lorenzo@kernel.org>
References: <cover.1634979655.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce cfg80211_cac_offchan_event routine in order to notify
userland when a Channel Availability Check (CAC) is finished, started
or aborted by a offchannel dedicated chain.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 include/net/cfg80211.h | 13 ++++++++++
 net/wireless/mlme.c    | 57 ++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 68 insertions(+), 2 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 3bb76835f4b1..8d075e11a1f8 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -7646,6 +7646,19 @@ void cfg80211_cac_event(struct net_device *netdev,
 			const struct cfg80211_chan_def *chandef,
 			enum nl80211_radar_event event, gfp_t gfp);
 
+/**
+ * cfg80211_offchan_cac_event - Channel Availability Check (CAC) offchan event
+ * @wiphy: the wiphy
+ * @chandef: chandef for the current channel
+ * @event: type of event
+ * @gfp: context flags
+ *
+ * This function is called when a Channel Availability Check (CAC) is finished,
+ * started or aborted by a offchannel dedicated chain.
+ */
+void cfg80211_offchan_cac_event(struct wiphy *wiphy,
+				const struct cfg80211_chan_def *chandef,
+				enum nl80211_radar_event event, gfp_t gfp);
 
 /**
  * cfg80211_gtk_rekey_notify - notify userspace about driver rekeying
diff --git a/net/wireless/mlme.c b/net/wireless/mlme.c
index 053293f51188..9f379a91d7fd 100644
--- a/net/wireless/mlme.c
+++ b/net/wireless/mlme.c
@@ -969,6 +969,57 @@ void cfg80211_cac_event(struct net_device *netdev,
 }
 EXPORT_SYMBOL(cfg80211_cac_event);
 
+static void
+__cfg80211_offchan_cac_event(struct cfg80211_registered_device *rdev,
+			     struct wireless_dev *wdev,
+			     const struct cfg80211_chan_def *chandef,
+			     enum nl80211_radar_event event, gfp_t gfp)
+{
+	struct wiphy *wiphy = &rdev->wiphy;
+	struct net_device *netdev;
+
+	lockdep_assert_held(&rdev->offchan_mutex);
+
+	if (event != NL80211_RADAR_CAC_STARTED && !rdev->offchan_radar_wdev)
+		return;
+
+	switch (event) {
+	case NL80211_RADAR_CAC_FINISHED:
+		cfg80211_set_dfs_state(wiphy, chandef, NL80211_DFS_AVAILABLE);
+		memcpy(&rdev->cac_done_chandef, chandef, sizeof(*chandef));
+		queue_work(cfg80211_wq, &rdev->propagate_cac_done_wk);
+		cfg80211_sched_dfs_chan_update(rdev);
+		wdev = rdev->offchan_radar_wdev;
+		rdev->offchan_radar_wdev = NULL;
+		break;
+	case NL80211_RADAR_CAC_ABORTED:
+		wdev = rdev->offchan_radar_wdev;
+		rdev->offchan_radar_wdev = NULL;
+		break;
+	case NL80211_RADAR_CAC_STARTED:
+		WARN_ON(!wdev);
+		rdev->offchan_radar_wdev = wdev;
+		break;
+	default:
+		return;
+	}
+
+	netdev = wdev ? wdev->netdev : NULL;
+	nl80211_radar_notify(rdev, chandef, event, netdev, gfp);
+}
+
+void cfg80211_offchan_cac_event(struct wiphy *wiphy,
+				const struct cfg80211_chan_def *chandef,
+				enum nl80211_radar_event event, gfp_t gfp)
+{
+	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wiphy);
+
+	mutex_lock(&rdev->offchan_mutex);
+	__cfg80211_offchan_cac_event(rdev, NULL, chandef, event, gfp);
+	mutex_unlock(&rdev->offchan_mutex);
+}
+EXPORT_SYMBOL(cfg80211_offchan_cac_event);
+
 int
 cfg80211_start_offchan_radar_detection(struct cfg80211_registered_device *rdev,
 				       struct wireless_dev *wdev,
@@ -984,7 +1035,8 @@ cfg80211_start_offchan_radar_detection(struct cfg80211_registered_device *rdev,
 	if (err)
 		goto out;
 
-	rdev->offchan_radar_wdev = wdev;
+	__cfg80211_offchan_cac_event(rdev, wdev, chandef,
+				     NL80211_RADAR_CAC_STARTED, GFP_KERNEL);
 out:
 	mutex_unlock(&rdev->offchan_mutex);
 	return err;
@@ -1003,7 +1055,8 @@ cfg80211_stop_offchan_radar_detection(struct cfg80211_registered_device *rdev)
 	if (err)
 		goto out;
 
-	rdev->offchan_radar_wdev = NULL;
+	__cfg80211_offchan_cac_event(rdev, NULL, NULL,
+				     NL80211_RADAR_CAC_ABORTED, GFP_KERNEL);
 out:
 	mutex_unlock(&rdev->offchan_mutex);
 	return err;
-- 
2.31.1

