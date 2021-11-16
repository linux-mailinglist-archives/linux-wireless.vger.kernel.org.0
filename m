Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD9545310E
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Nov 2021 12:42:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235169AbhKPLpl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 16 Nov 2021 06:45:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:40290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235475AbhKPLpE (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 16 Nov 2021 06:45:04 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A2992633A7;
        Tue, 16 Nov 2021 11:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637062925;
        bh=bj/m7ykyThFNFq6FcyPA2D3HqUW4VPfXD4fJE9g7OaA=;
        h=From:To:Cc:Subject:Date:From;
        b=RCMup3b+sCbwmbf4ZR5D9LfTJlPsw+st1eNDYuTQUhQ8SqkM8eEkDiYhkvIgmUGw3
         4+GHbdvoiIqHl8R0ig/XNWhuLymlbHeMafaFlp9L+vZ4Xiyxk3rAI0xH/FBLGTdza9
         FFvr1pPw/+bpjU/RF71zAMgsI8LaG01zC+ZQP5cl/FoZljAHxEXrak3b+UcLRei2bc
         Vqd+J5UvckA9ycDPJ8gUPNJDPL/LNigjUbs+aLR57WxjPSAVo7e8QVOOAAFThRPIQr
         vUxvJpmg1WS7lbxKCl/xZojeReJJ/2aktNuw6kVPuYYUhcGMXfWxCvJyekv/f0il+w
         k2cFu+BCepVGw==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     johannes@sipsolutions.net
Cc:     nbd@nbd.name, linux-wireless@vger.kernel.org,
        lorenzo.bianconi@redhat.com, ryder.lee@mediatek.com,
        evelyn.tsai@mediatek.com, owen.peng@mediatek.com
Subject: [PATCH mac80211-next] cfg80211: schedule offchan_cac_abort_wk in cfg80211_radar_event
Date:   Tue, 16 Nov 2021 12:41:52 +0100
Message-Id: <3ff583e021e3343a3ced54a7b09b5e184d1880dc.1637062727.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

If necessary schedule offchan_cac_abort_wk work in cfg80211_radar_event
routine adding offchan parameter to cfg80211_radar_event signature.
Rename cfg80211_radar_event in __cfg80211_radar_event and introduce
the two following inline helpers:
- cfg80211_radar_event
- cfg80211_offchan_radar_event
Doing so the drv will not need to run cfg80211_offchan_cac_abort() after
radar detection on the offchannel chain.

Tested-by: Owen Peng <owen.peng@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 include/net/cfg80211.h | 24 +++++++++++++++++++++---
 net/wireless/mlme.c    | 16 ++++++++++------
 net/wireless/trace.h   | 11 +++++++----
 3 files changed, 38 insertions(+), 13 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 362da9f6bf39..a887086cb103 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -7605,15 +7605,33 @@ void cfg80211_cqm_txe_notify(struct net_device *dev, const u8 *peer,
 void cfg80211_cqm_beacon_loss_notify(struct net_device *dev, gfp_t gfp);
 
 /**
- * cfg80211_radar_event - radar detection event
+ * __cfg80211_radar_event - radar detection event
  * @wiphy: the wiphy
  * @chandef: chandef for the current channel
+ * @offchan: the radar has been detected on the offchannel chain
  * @gfp: context flags
  *
  * This function is called when a radar is detected on the current chanenl.
  */
-void cfg80211_radar_event(struct wiphy *wiphy,
-			  struct cfg80211_chan_def *chandef, gfp_t gfp);
+void __cfg80211_radar_event(struct wiphy *wiphy,
+			    struct cfg80211_chan_def *chandef,
+			    bool offchan, gfp_t gfp);
+
+static inline void
+cfg80211_radar_event(struct wiphy *wiphy,
+		     struct cfg80211_chan_def *chandef,
+		     gfp_t gfp)
+{
+	__cfg80211_radar_event(wiphy, chandef, false, gfp);
+}
+
+static inline void
+cfg80211_offchan_radar_event(struct wiphy *wiphy,
+			     struct cfg80211_chan_def *chandef,
+			     gfp_t gfp)
+{
+	__cfg80211_radar_event(wiphy, chandef, true, gfp);
+}
 
 /**
  * cfg80211_sta_opmode_change_notify - STA's ht/vht operation mode change event
diff --git a/net/wireless/mlme.c b/net/wireless/mlme.c
index ac2e5e732d94..450be1ec70b8 100644
--- a/net/wireless/mlme.c
+++ b/net/wireless/mlme.c
@@ -905,13 +905,13 @@ void cfg80211_dfs_channels_update_work(struct work_struct *work)
 }
 
 
-void cfg80211_radar_event(struct wiphy *wiphy,
-			  struct cfg80211_chan_def *chandef,
-			  gfp_t gfp)
+void __cfg80211_radar_event(struct wiphy *wiphy,
+			    struct cfg80211_chan_def *chandef,
+			    bool offchan, gfp_t gfp)
 {
 	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wiphy);
 
-	trace_cfg80211_radar_event(wiphy, chandef);
+	trace_cfg80211_radar_event(wiphy, chandef, offchan);
 
 	/* only set the chandef supplied channel to unavailable, in
 	 * case the radar is detected on only one of multiple channels
@@ -919,6 +919,9 @@ void cfg80211_radar_event(struct wiphy *wiphy,
 	 */
 	cfg80211_set_dfs_state(wiphy, chandef, NL80211_DFS_UNAVAILABLE);
 
+	if (offchan)
+		queue_work(cfg80211_wq, &rdev->offchan_cac_abort_wk);
+
 	cfg80211_sched_dfs_chan_update(rdev);
 
 	nl80211_radar_notify(rdev, chandef, NL80211_RADAR_DETECTED, NULL, gfp);
@@ -926,7 +929,7 @@ void cfg80211_radar_event(struct wiphy *wiphy,
 	memcpy(&rdev->radar_chandef, chandef, sizeof(struct cfg80211_chan_def));
 	queue_work(cfg80211_wq, &rdev->propagate_radar_detect_wk);
 }
-EXPORT_SYMBOL(cfg80211_radar_event);
+EXPORT_SYMBOL(__cfg80211_radar_event);
 
 void cfg80211_cac_event(struct net_device *netdev,
 			const struct cfg80211_chan_def *chandef,
@@ -998,7 +1001,8 @@ __cfg80211_offchan_cac_event(struct cfg80211_registered_device *rdev,
 		rdev->offchan_radar_wdev = NULL;
 		break;
 	case NL80211_RADAR_CAC_ABORTED:
-		cancel_delayed_work(&rdev->offchan_cac_done_wk);
+		if (!cancel_delayed_work(&rdev->offchan_cac_done_wk))
+			return;
 		wdev = rdev->offchan_radar_wdev;
 		rdev->offchan_radar_wdev = NULL;
 		break;
diff --git a/net/wireless/trace.h b/net/wireless/trace.h
index 0b27eaa14a18..e854d52db1a6 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -3053,18 +3053,21 @@ TRACE_EVENT(cfg80211_ch_switch_started_notify,
 );
 
 TRACE_EVENT(cfg80211_radar_event,
-	TP_PROTO(struct wiphy *wiphy, struct cfg80211_chan_def *chandef),
-	TP_ARGS(wiphy, chandef),
+	TP_PROTO(struct wiphy *wiphy, struct cfg80211_chan_def *chandef,
+		 bool offchan),
+	TP_ARGS(wiphy, chandef, offchan),
 	TP_STRUCT__entry(
 		WIPHY_ENTRY
 		CHAN_DEF_ENTRY
+		__field(bool, offchan)
 	),
 	TP_fast_assign(
 		WIPHY_ASSIGN;
 		CHAN_DEF_ASSIGN(chandef);
+		__entry->offchan = offchan;
 	),
-	TP_printk(WIPHY_PR_FMT ", " CHAN_DEF_PR_FMT,
-		  WIPHY_PR_ARG, CHAN_DEF_PR_ARG)
+	TP_printk(WIPHY_PR_FMT ", " CHAN_DEF_PR_FMT ", offchan %d",
+		  WIPHY_PR_ARG, CHAN_DEF_PR_ARG, __entry->offchan)
 );
 
 TRACE_EVENT(cfg80211_cac_event,
-- 
2.31.1

