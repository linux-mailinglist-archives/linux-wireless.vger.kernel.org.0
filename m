Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CC28461A28
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Nov 2021 15:43:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350620AbhK2Oq2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Nov 2021 09:46:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378763AbhK2Oo1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Nov 2021 09:44:27 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28C06C03AA18
        for <linux-wireless@vger.kernel.org>; Mon, 29 Nov 2021 05:11:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BDB06B81133
        for <linux-wireless@vger.kernel.org>; Mon, 29 Nov 2021 13:11:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A437AC004E1;
        Mon, 29 Nov 2021 13:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638191493;
        bh=ZI4/LP6QR4qDDQN3n3M9KxIyFhzDOSg6KtcDytZuWBE=;
        h=From:To:Cc:Subject:Date:From;
        b=XRu6TAqrSqytZnvBZDzShpgcMhC8dy11zsak+qPs1Zqtpz4UwxERhHdT29ckgSjdE
         qK2e2HhHwXv/fg/o7pZcgfasXVSSuE6KotdUvetnigYIlK1BTChOnzCiVF1OToHFhF
         1lnTMv4GsRndHlOnxGECID73mAaiWweSvyVePR7WI1AwBrvyxhMYsUODFJQV5IZggf
         yQCZRpCjlInu82Fe0rtBEcTlCbCKRYINLlu3c99ysrG0cFG2yo0estcIwZza18+OzH
         DP4qnLZ3R0xNb/U6MWzxJzvSZj8ahoP3x7haUY7O6YkwPzjZo5qf0DbRJBVRaE/TEw
         qxb8HWkYkrOZw==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     johannes@sipsolutions.net
Cc:     nbd@nbd.name, linux-wireless@vger.kernel.org,
        lorenzo.bianconi@redhat.com, ryder.lee@mediatek.com,
        evelyn.tsai@mediatek.com, owen.peng@mediatek.com,
        janusz.dziedzic@gmail.com
Subject: [PATCH mac80211-next] cfg80211: rename offchannel_chain structs to background_chain to avoid confusion with ETSI standard
Date:   Mon, 29 Nov 2021 14:11:24 +0100
Message-Id: <4204cc1d648d76b44557981713231e030a3bd991.1638190762.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

ETSI standard defines "Offchannel CAC" as:
"Off-Channel CAC is performed by a number of non-continuous checks
spread over a period in time. This period, which is required to
determine the presence of radar signals, is defined as the Off-Channel
CAC Time..
Minimum Off-Channel CAC Time 6 minutes and Maximum Off-Channel CAC Time
4 hours..".
mac80211 implementation refers to a dedicated hw chain used for continuous
radar monitoring. Rename offchannel_* references to background_* in
order to avoid confusion with ETSI standard.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 include/net/cfg80211.h       | 20 ++++----
 include/net/mac80211.h       | 10 ++--
 include/uapi/linux/nl80211.h | 14 +++---
 net/mac80211/cfg.c           | 10 ++--
 net/wireless/chan.c          |  6 +--
 net/wireless/core.c          | 13 +++---
 net/wireless/core.h          | 20 ++++----
 net/wireless/mlme.c          | 89 ++++++++++++++++++------------------
 net/wireless/nl80211.c       |  8 ++--
 net/wireless/rdev-ops.h      | 10 ++--
 net/wireless/trace.h         |  2 +-
 11 files changed, 102 insertions(+), 100 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index a887086cb103..6b443fb37b70 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -4073,14 +4073,14 @@ struct mgmt_frame_regs {
  *	those to decrypt (Re)Association Request and encrypt (Re)Association
  *	Response frame.
  *
- * @set_radar_offchan: Configure dedicated offchannel chain available for
+ * @set_radar_background: Configure dedicated offchannel chain available for
  *	radar/CAC detection on some hw. This chain can't be used to transmit
  *	or receive frames and it is bounded to a running wdev.
- *	Offchannel radar/CAC detection allows to avoid the CAC downtime
+ *	Background radar/CAC detection allows to avoid the CAC downtime
  *	switching to a different channel during CAC detection on the selected
  *	radar channel.
  *	The caller is expected to set chandef pointer to NULL in order to
- *	disable offchannel CAC/radar detection.
+ *	disable background CAC/radar detection.
  */
 struct cfg80211_ops {
 	int	(*suspend)(struct wiphy *wiphy, struct cfg80211_wowlan *wow);
@@ -4413,8 +4413,8 @@ struct cfg80211_ops {
 				struct cfg80211_color_change_settings *params);
 	int     (*set_fils_aad)(struct wiphy *wiphy, struct net_device *dev,
 				struct cfg80211_fils_aad *fils_aad);
-	int	(*set_radar_offchan)(struct wiphy *wiphy,
-				     struct cfg80211_chan_def *chandef);
+	int	(*set_radar_background)(struct wiphy *wiphy,
+					struct cfg80211_chan_def *chandef);
 };
 
 /*
@@ -7626,9 +7626,9 @@ cfg80211_radar_event(struct wiphy *wiphy,
 }
 
 static inline void
-cfg80211_offchan_radar_event(struct wiphy *wiphy,
-			     struct cfg80211_chan_def *chandef,
-			     gfp_t gfp)
+cfg80211_background_radar_event(struct wiphy *wiphy,
+				struct cfg80211_chan_def *chandef,
+				gfp_t gfp)
 {
 	__cfg80211_radar_event(wiphy, chandef, true, gfp);
 }
@@ -7663,13 +7663,13 @@ void cfg80211_cac_event(struct net_device *netdev,
 			enum nl80211_radar_event event, gfp_t gfp);
 
 /**
- * cfg80211_offchan_cac_abort - Channel Availability Check offchan abort event
+ * cfg80211_background_cac_abort - Channel Availability Check offchan abort event
  * @wiphy: the wiphy
  *
  * This function is called by the driver when a Channel Availability Check
  * (CAC) is aborted by a offchannel dedicated chain.
  */
-void cfg80211_offchan_cac_abort(struct wiphy *wiphy);
+void cfg80211_background_cac_abort(struct wiphy *wiphy);
 
 /**
  * cfg80211_gtk_rekey_notify - notify userspace about driver rekeying
diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index e349f57d19ae..605f54421b78 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -3939,14 +3939,14 @@ struct ieee80211_prep_tx_info {
  *	twt structure.
  * @twt_teardown_request: Update the hw with TWT teardown request received
  *	from the peer.
- * @set_radar_offchan: Configure dedicated offchannel chain available for
+ * @set_radar_background: Configure dedicated offchannel chain available for
  *	radar/CAC detection on some hw. This chain can't be used to transmit
  *	or receive frames and it is bounded to a running wdev.
- *	Offchannel radar/CAC detection allows to avoid the CAC downtime
+ *	Background radar/CAC detection allows to avoid the CAC downtime
  *	switching to a different channel during CAC detection on the selected
  *	radar channel.
  *	The caller is expected to set chandef pointer to NULL in order to
- *	disable offchannel CAC/radar detection.
+ *	disable background CAC/radar detection.
  * @net_fill_forward_path: Called from .ndo_fill_forward_path in order to
  *	resolve a path for hardware flow offloading
  */
@@ -4277,8 +4277,8 @@ struct ieee80211_ops {
 			      struct ieee80211_twt_setup *twt);
 	void (*twt_teardown_request)(struct ieee80211_hw *hw,
 				     struct ieee80211_sta *sta, u8 flowid);
-	int (*set_radar_offchan)(struct ieee80211_hw *hw,
-				 struct cfg80211_chan_def *chandef);
+	int (*set_radar_background)(struct ieee80211_hw *hw,
+				    struct cfg80211_chan_def *chandef);
 	int (*net_fill_forward_path)(struct ieee80211_hw *hw,
 				     struct ieee80211_vif *vif,
 				     struct ieee80211_sta *sta,
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 3e734826792f..a6e6d3761544 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -2639,10 +2639,10 @@ enum nl80211_commands {
  *	Mandatory parameter for the transmitting interface to enable MBSSID.
  *	Optional for the non-transmitting interfaces.
  *
- * @NL80211_ATTR_RADAR_OFFCHAN: Configure dedicated offchannel chain available for
- *	radar/CAC detection on some hw. This chain can't be used to transmit
- *	or receive frames and it is bounded to a running wdev.
- *	Offchannel radar/CAC detection allows to avoid the CAC downtime
+ * @NL80211_ATTR_RADAR_BACKGROUND: Configure dedicated offchannel chain
+ *	available for radar/CAC detection on some hw. This chain can't be used
+ *	to transmit or receive frames and it is bounded to a running wdev.
+ *	Background radar/CAC detection allows to avoid the CAC downtime
  *	switching on a different channel during CAC detection on the selected
  *	radar channel.
  *
@@ -3152,7 +3152,7 @@ enum nl80211_attrs {
 	NL80211_ATTR_MBSSID_CONFIG,
 	NL80211_ATTR_MBSSID_ELEMS,
 
-	NL80211_ATTR_RADAR_OFFCHAN,
+	NL80211_ATTR_RADAR_BACKGROUND,
 
 	/* add attributes here, update the policy in nl80211.c */
 
@@ -6060,7 +6060,7 @@ enum nl80211_feature_flags {
  *	frames. Userspace has to share FILS AAD details to the driver by using
  *	@NL80211_CMD_SET_FILS_AAD.
  *
- * @NL80211_EXT_FEATURE_RADAR_OFFCHAN: Device supports offchannel radar/CAC
+ * @NL80211_EXT_FEATURE_RADAR_BACKGROUND: Device supports background radar/CAC
  *	detection.
  *
  * @NUM_NL80211_EXT_FEATURES: number of extended features.
@@ -6129,7 +6129,7 @@ enum nl80211_ext_feature_index {
 	NL80211_EXT_FEATURE_PROT_RANGE_NEGO_AND_MEASURE,
 	NL80211_EXT_FEATURE_BSS_COLOR,
 	NL80211_EXT_FEATURE_FILS_CRYPTO_OFFLOAD,
-	NL80211_EXT_FEATURE_RADAR_OFFCHAN,
+	NL80211_EXT_FEATURE_RADAR_BACKGROUND,
 
 	/* add new features before the definition below */
 	NUM_NL80211_EXT_FEATURES,
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 26cc762835f7..53f557a7919a 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -4402,15 +4402,15 @@ ieee80211_color_change(struct wiphy *wiphy, struct net_device *dev,
 }
 
 static int
-ieee80211_set_radar_offchan(struct wiphy *wiphy,
-			    struct cfg80211_chan_def *chandef)
+ieee80211_set_radar_background(struct wiphy *wiphy,
+			       struct cfg80211_chan_def *chandef)
 {
 	struct ieee80211_local *local = wiphy_priv(wiphy);
 
-	if (!local->ops->set_radar_offchan)
+	if (!local->ops->set_radar_background)
 		return -EOPNOTSUPP;
 
-	return local->ops->set_radar_offchan(&local->hw, chandef);
+	return local->ops->set_radar_background(&local->hw, chandef);
 }
 
 const struct cfg80211_ops mac80211_config_ops = {
@@ -4517,5 +4517,5 @@ const struct cfg80211_ops mac80211_config_ops = {
 	.reset_tid_config = ieee80211_reset_tid_config,
 	.set_sar_specs = ieee80211_set_sar_specs,
 	.color_change = ieee80211_color_change,
-	.set_radar_offchan = ieee80211_set_radar_offchan,
+	.set_radar_background = ieee80211_set_radar_background,
 };
diff --git a/net/wireless/chan.c b/net/wireless/chan.c
index 00fc7b78063c..33186e3f42ef 100644
--- a/net/wireless/chan.c
+++ b/net/wireless/chan.c
@@ -716,13 +716,13 @@ static bool
 cfg80211_offchan_chain_is_active(struct cfg80211_registered_device *rdev,
 				 struct ieee80211_channel *channel)
 {
-	if (!rdev->offchan_radar_wdev)
+	if (!rdev->background_radar_wdev)
 		return false;
 
-	if (!cfg80211_chandef_valid(&rdev->offchan_radar_chandef))
+	if (!cfg80211_chandef_valid(&rdev->background_radar_chandef))
 		return false;
 
-	return cfg80211_is_sub_chan(&rdev->offchan_radar_chandef, channel);
+	return cfg80211_is_sub_chan(&rdev->background_radar_chandef, channel);
 }
 
 bool cfg80211_any_wiphy_oper_chan(struct wiphy *wiphy,
diff --git a/net/wireless/core.c b/net/wireless/core.c
index c4ea903f8184..132c575c5540 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -545,9 +545,10 @@ struct wiphy *wiphy_new_nm(const struct cfg80211_ops *ops, int sizeof_priv,
 	INIT_WORK(&rdev->rfkill_block, cfg80211_rfkill_block_work);
 	INIT_WORK(&rdev->conn_work, cfg80211_conn_work);
 	INIT_WORK(&rdev->event_work, cfg80211_event_work);
-	INIT_WORK(&rdev->offchan_cac_abort_wk, cfg80211_offchan_cac_abort_wk);
-	INIT_DELAYED_WORK(&rdev->offchan_cac_done_wk,
-			  cfg80211_offchan_cac_done_wk);
+	INIT_WORK(&rdev->background_cac_abort_wk,
+		  cfg80211_background_cac_abort_wk);
+	INIT_DELAYED_WORK(&rdev->background_cac_done_wk,
+			  cfg80211_background_cac_done_wk);
 
 	init_waitqueue_head(&rdev->dev_wait);
 
@@ -1057,13 +1058,13 @@ void wiphy_unregister(struct wiphy *wiphy)
 	cancel_work_sync(&rdev->conn_work);
 	flush_work(&rdev->event_work);
 	cancel_delayed_work_sync(&rdev->dfs_update_channels_wk);
-	cancel_delayed_work_sync(&rdev->offchan_cac_done_wk);
+	cancel_delayed_work_sync(&rdev->background_cac_done_wk);
 	flush_work(&rdev->destroy_work);
 	flush_work(&rdev->sched_scan_stop_wk);
 	flush_work(&rdev->propagate_radar_detect_wk);
 	flush_work(&rdev->propagate_cac_done_wk);
 	flush_work(&rdev->mgmt_registrations_update_wk);
-	flush_work(&rdev->offchan_cac_abort_wk);
+	flush_work(&rdev->background_cac_abort_wk);
 
 #ifdef CONFIG_PM
 	if (rdev->wiphy.wowlan_config && rdev->ops->set_wakeup)
@@ -1212,7 +1213,7 @@ void __cfg80211_leave(struct cfg80211_registered_device *rdev,
 
 	cfg80211_pmsr_wdev_down(wdev);
 
-	cfg80211_stop_offchan_radar_detection(wdev);
+	cfg80211_stop_background_radar_detection(wdev);
 
 	switch (wdev->iftype) {
 	case NL80211_IFTYPE_ADHOC:
diff --git a/net/wireless/core.h b/net/wireless/core.h
index fb8d9006d838..3a7dbd63d8c6 100644
--- a/net/wireless/core.h
+++ b/net/wireless/core.h
@@ -84,10 +84,10 @@ struct cfg80211_registered_device {
 
 	struct delayed_work dfs_update_channels_wk;
 
-	struct wireless_dev *offchan_radar_wdev;
-	struct cfg80211_chan_def offchan_radar_chandef;
-	struct delayed_work offchan_cac_done_wk;
-	struct work_struct offchan_cac_abort_wk;
+	struct wireless_dev *background_radar_wdev;
+	struct cfg80211_chan_def background_radar_chandef;
+	struct delayed_work background_cac_done_wk;
+	struct work_struct background_cac_abort_wk;
 
 	/* netlink port which started critical protocol (0 means not started) */
 	u32 crit_proto_nlportid;
@@ -497,15 +497,15 @@ cfg80211_chandef_dfs_cac_time(struct wiphy *wiphy,
 void cfg80211_sched_dfs_chan_update(struct cfg80211_registered_device *rdev);
 
 int
-cfg80211_start_offchan_radar_detection(struct cfg80211_registered_device *rdev,
-				       struct wireless_dev *wdev,
-				       struct cfg80211_chan_def *chandef);
+cfg80211_start_background_radar_detection(struct cfg80211_registered_device *rdev,
+					  struct wireless_dev *wdev,
+					  struct cfg80211_chan_def *chandef);
 
-void cfg80211_stop_offchan_radar_detection(struct wireless_dev *wdev);
+void cfg80211_stop_background_radar_detection(struct wireless_dev *wdev);
 
-void cfg80211_offchan_cac_done_wk(struct work_struct *work);
+void cfg80211_background_cac_done_wk(struct work_struct *work);
 
-void cfg80211_offchan_cac_abort_wk(struct work_struct *work);
+void cfg80211_background_cac_abort_wk(struct work_struct *work);
 
 bool cfg80211_any_wiphy_oper_chan(struct wiphy *wiphy,
 				  struct ieee80211_channel *chan);
diff --git a/net/wireless/mlme.c b/net/wireless/mlme.c
index e970076e1098..c8155a483ec2 100644
--- a/net/wireless/mlme.c
+++ b/net/wireless/mlme.c
@@ -920,7 +920,7 @@ void __cfg80211_radar_event(struct wiphy *wiphy,
 	cfg80211_set_dfs_state(wiphy, chandef, NL80211_DFS_UNAVAILABLE);
 
 	if (offchan)
-		queue_work(cfg80211_wq, &rdev->offchan_cac_abort_wk);
+		queue_work(cfg80211_wq, &rdev->background_cac_abort_wk);
 
 	cfg80211_sched_dfs_chan_update(rdev);
 
@@ -975,10 +975,10 @@ void cfg80211_cac_event(struct net_device *netdev,
 EXPORT_SYMBOL(cfg80211_cac_event);
 
 static void
-__cfg80211_offchan_cac_event(struct cfg80211_registered_device *rdev,
-			     struct wireless_dev *wdev,
-			     const struct cfg80211_chan_def *chandef,
-			     enum nl80211_radar_event event)
+__cfg80211_background_cac_event(struct cfg80211_registered_device *rdev,
+				struct wireless_dev *wdev,
+				const struct cfg80211_chan_def *chandef,
+				enum nl80211_radar_event event)
 {
 	struct wiphy *wiphy = &rdev->wiphy;
 	struct net_device *netdev;
@@ -988,7 +988,7 @@ __cfg80211_offchan_cac_event(struct cfg80211_registered_device *rdev,
 	if (!cfg80211_chandef_valid(chandef))
 		return;
 
-	if (!rdev->offchan_radar_wdev)
+	if (!rdev->background_radar_wdev)
 		return;
 
 	switch (event) {
@@ -997,12 +997,12 @@ __cfg80211_offchan_cac_event(struct cfg80211_registered_device *rdev,
 		memcpy(&rdev->cac_done_chandef, chandef, sizeof(*chandef));
 		queue_work(cfg80211_wq, &rdev->propagate_cac_done_wk);
 		cfg80211_sched_dfs_chan_update(rdev);
-		wdev = rdev->offchan_radar_wdev;
+		wdev = rdev->background_radar_wdev;
 		break;
 	case NL80211_RADAR_CAC_ABORTED:
-		if (!cancel_delayed_work(&rdev->offchan_cac_done_wk))
+		if (!cancel_delayed_work(&rdev->background_cac_done_wk))
 			return;
-		wdev = rdev->offchan_radar_wdev;
+		wdev = rdev->background_radar_wdev;
 		break;
 	case NL80211_RADAR_CAC_STARTED:
 		break;
@@ -1015,49 +1015,49 @@ __cfg80211_offchan_cac_event(struct cfg80211_registered_device *rdev,
 }
 
 static void
-cfg80211_offchan_cac_event(struct cfg80211_registered_device *rdev,
-			   const struct cfg80211_chan_def *chandef,
-			   enum nl80211_radar_event event)
+cfg80211_background_cac_event(struct cfg80211_registered_device *rdev,
+			      const struct cfg80211_chan_def *chandef,
+			      enum nl80211_radar_event event)
 {
 	wiphy_lock(&rdev->wiphy);
-	__cfg80211_offchan_cac_event(rdev, rdev->offchan_radar_wdev,
-				     chandef, event);
+	__cfg80211_background_cac_event(rdev, rdev->background_radar_wdev,
+					chandef, event);
 	wiphy_unlock(&rdev->wiphy);
 }
 
-void cfg80211_offchan_cac_done_wk(struct work_struct *work)
+void cfg80211_background_cac_done_wk(struct work_struct *work)
 {
 	struct delayed_work *delayed_work = to_delayed_work(work);
 	struct cfg80211_registered_device *rdev;
 
 	rdev = container_of(delayed_work, struct cfg80211_registered_device,
-			    offchan_cac_done_wk);
-	cfg80211_offchan_cac_event(rdev, &rdev->offchan_radar_chandef,
-				   NL80211_RADAR_CAC_FINISHED);
+			    background_cac_done_wk);
+	cfg80211_background_cac_event(rdev, &rdev->background_radar_chandef,
+				      NL80211_RADAR_CAC_FINISHED);
 }
 
-void cfg80211_offchan_cac_abort_wk(struct work_struct *work)
+void cfg80211_background_cac_abort_wk(struct work_struct *work)
 {
 	struct cfg80211_registered_device *rdev;
 
 	rdev = container_of(work, struct cfg80211_registered_device,
-			    offchan_cac_abort_wk);
-	cfg80211_offchan_cac_event(rdev, &rdev->offchan_radar_chandef,
-				   NL80211_RADAR_CAC_ABORTED);
+			    background_cac_abort_wk);
+	cfg80211_background_cac_event(rdev, &rdev->background_radar_chandef,
+				      NL80211_RADAR_CAC_ABORTED);
 }
 
-void cfg80211_offchan_cac_abort(struct wiphy *wiphy)
+void cfg80211_background_cac_abort(struct wiphy *wiphy)
 {
 	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wiphy);
 
-	queue_work(cfg80211_wq, &rdev->offchan_cac_abort_wk);
+	queue_work(cfg80211_wq, &rdev->background_cac_abort_wk);
 }
-EXPORT_SYMBOL(cfg80211_offchan_cac_abort);
+EXPORT_SYMBOL(cfg80211_background_cac_abort);
 
 int
-cfg80211_start_offchan_radar_detection(struct cfg80211_registered_device *rdev,
-				       struct wireless_dev *wdev,
-				       struct cfg80211_chan_def *chandef)
+cfg80211_start_background_radar_detection(struct cfg80211_registered_device *rdev,
+					  struct wireless_dev *wdev,
+					  struct cfg80211_chan_def *chandef)
 {
 	unsigned int cac_time_ms;
 	int err;
@@ -1065,19 +1065,19 @@ cfg80211_start_offchan_radar_detection(struct cfg80211_registered_device *rdev,
 	lockdep_assert_wiphy(&rdev->wiphy);
 
 	if (!wiphy_ext_feature_isset(&rdev->wiphy,
-				     NL80211_EXT_FEATURE_RADAR_OFFCHAN))
+				     NL80211_EXT_FEATURE_RADAR_BACKGROUND))
 		return -EOPNOTSUPP;
 
 	/* Offchannel chain already locked by another wdev */
-	if (rdev->offchan_radar_wdev && rdev->offchan_radar_wdev != wdev)
+	if (rdev->background_radar_wdev && rdev->background_radar_wdev != wdev)
 		return -EBUSY;
 
 	/* CAC already in progress on the offchannel chain */
-	if (rdev->offchan_radar_wdev == wdev &&
-	    delayed_work_pending(&rdev->offchan_cac_done_wk))
+	if (rdev->background_radar_wdev == wdev &&
+	    delayed_work_pending(&rdev->background_cac_done_wk))
 		return -EBUSY;
 
-	err = rdev_set_radar_offchan(rdev, chandef);
+	err = rdev_set_radar_background(rdev, chandef);
 	if (err)
 		return err;
 
@@ -1085,30 +1085,31 @@ cfg80211_start_offchan_radar_detection(struct cfg80211_registered_device *rdev,
 	if (!cac_time_ms)
 		cac_time_ms = IEEE80211_DFS_MIN_CAC_TIME_MS;
 
-	rdev->offchan_radar_chandef = *chandef;
-	rdev->offchan_radar_wdev = wdev; /* Get offchain ownership */
+	rdev->background_radar_chandef = *chandef;
+	rdev->background_radar_wdev = wdev; /* Get offchain ownership */
 
-	__cfg80211_offchan_cac_event(rdev, wdev, chandef,
-				     NL80211_RADAR_CAC_STARTED);
-	queue_delayed_work(cfg80211_wq, &rdev->offchan_cac_done_wk,
+	__cfg80211_background_cac_event(rdev, wdev, chandef,
+					NL80211_RADAR_CAC_STARTED);
+	queue_delayed_work(cfg80211_wq, &rdev->background_cac_done_wk,
 			   msecs_to_jiffies(cac_time_ms));
 
 	return 0;
 }
 
-void cfg80211_stop_offchan_radar_detection(struct wireless_dev *wdev)
+void cfg80211_stop_background_radar_detection(struct wireless_dev *wdev)
 {
 	struct wiphy *wiphy = wdev->wiphy;
 	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wiphy);
 
 	lockdep_assert_wiphy(wiphy);
 
-	if (wdev != rdev->offchan_radar_wdev)
+	if (wdev != rdev->background_radar_wdev)
 		return;
 
-	rdev_set_radar_offchan(rdev, NULL);
-	rdev->offchan_radar_wdev = NULL; /* Release offchain ownership */
+	rdev_set_radar_background(rdev, NULL);
+	rdev->background_radar_wdev = NULL; /* Release offchain ownership */
 
-	__cfg80211_offchan_cac_event(rdev, wdev, &rdev->offchan_radar_chandef,
-				     NL80211_RADAR_CAC_ABORTED);
+	__cfg80211_background_cac_event(rdev, wdev,
+					&rdev->background_radar_chandef,
+					NL80211_RADAR_CAC_ABORTED);
 }
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index bfa5d7428a3f..fd19d3146b58 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -776,7 +776,7 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 	[NL80211_ATTR_MBSSID_CONFIG] =
 			NLA_POLICY_NESTED(nl80211_mbssid_config_policy),
 	[NL80211_ATTR_MBSSID_ELEMS] = { .type = NLA_NESTED },
-	[NL80211_ATTR_RADAR_OFFCHAN] = { .type = NLA_FLAG },
+	[NL80211_ATTR_RADAR_BACKGROUND] = { .type = NLA_FLAG },
 };
 
 /* policy for the key attributes */
@@ -9305,9 +9305,9 @@ static int nl80211_start_radar_detection(struct sk_buff *skb,
 		goto unlock;
 	}
 
-	if (nla_get_flag(info->attrs[NL80211_ATTR_RADAR_OFFCHAN])) {
-		err = cfg80211_start_offchan_radar_detection(rdev, wdev,
-							     &chandef);
+	if (nla_get_flag(info->attrs[NL80211_ATTR_RADAR_BACKGROUND])) {
+		err = cfg80211_start_background_radar_detection(rdev, wdev,
+								&chandef);
 		goto unlock;
 	}
 
diff --git a/net/wireless/rdev-ops.h b/net/wireless/rdev-ops.h
index 8672b3ef99e4..439bcf52369c 100644
--- a/net/wireless/rdev-ops.h
+++ b/net/wireless/rdev-ops.h
@@ -1396,17 +1396,17 @@ rdev_set_fils_aad(struct cfg80211_registered_device *rdev,
 }
 
 static inline int
-rdev_set_radar_offchan(struct cfg80211_registered_device *rdev,
-		       struct cfg80211_chan_def *chandef)
+rdev_set_radar_background(struct cfg80211_registered_device *rdev,
+			  struct cfg80211_chan_def *chandef)
 {
 	struct wiphy *wiphy = &rdev->wiphy;
 	int ret;
 
-	if (!rdev->ops->set_radar_offchan)
+	if (!rdev->ops->set_radar_background)
 		return -EOPNOTSUPP;
 
-	trace_rdev_set_radar_offchan(wiphy, chandef);
-	ret = rdev->ops->set_radar_offchan(wiphy, chandef);
+	trace_rdev_set_radar_background(wiphy, chandef);
+	ret = rdev->ops->set_radar_background(wiphy, chandef);
 	trace_rdev_return_int(wiphy, ret);
 
 	return ret;
diff --git a/net/wireless/trace.h b/net/wireless/trace.h
index e854d52db1a6..cc6b45229d4b 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -3677,7 +3677,7 @@ TRACE_EVENT(cfg80211_bss_color_notify,
 		  __entry->color_bitmap)
 );
 
-TRACE_EVENT(rdev_set_radar_offchan,
+TRACE_EVENT(rdev_set_radar_background,
 	TP_PROTO(struct wiphy *wiphy, struct cfg80211_chan_def *chandef),
 
 	TP_ARGS(wiphy, chandef),
-- 
2.31.1

