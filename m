Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 502E5386BF2
	for <lists+linux-wireless@lfdr.de>; Mon, 17 May 2021 23:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237474AbhEQVJ0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 17 May 2021 17:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234755AbhEQVJU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 17 May 2021 17:09:20 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64A23C061760
        for <linux-wireless@vger.kernel.org>; Mon, 17 May 2021 14:08:03 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1likT2-00AVFx-Gm; Mon, 17 May 2021 23:08:00 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 3/4] mac80211: use sdata->skb_queue for TDLS
Date:   Mon, 17 May 2021 23:07:56 +0200
Message-Id: <20210517230754.17034990abef.I5342f2183c0d246b18d36c511eb3b6be298a6572@changeid>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210517230754.113b65febd5a.Ie0e1d58a2885e75f242cb6e06f3b9660117fef93@changeid>
References: <20210517230754.113b65febd5a.Ie0e1d58a2885e75f242cb6e06f3b9660117fef93@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

We need to differentiate these frames since the ones we
currently put on the skb_queue_tdls_chsw have already
been converted to ethernet format, but now that we've
got a single place to enqueue to the sdata->skb_queue
this isn't hard. Just differentiate based on protocol
and adjust the code to queue the SKBs appropriately.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/ieee80211_i.h | 10 +++++-----
 net/mac80211/iface.c       |  5 ++++-
 net/mac80211/main.c        |  5 -----
 net/mac80211/rx.c          | 21 +++++++++++++--------
 net/mac80211/tdls.c        | 28 +---------------------------
 5 files changed, 23 insertions(+), 46 deletions(-)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 8fcbaa1eedf3..a27225be1a1e 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1427,10 +1427,6 @@ struct ieee80211_local {
 
 	/* extended capabilities provided by mac80211 */
 	u8 ext_capa[8];
-
-	/* TDLS channel switch */
-	struct work_struct tdls_chsw_work;
-	struct sk_buff_head skb_queue_tdls_chsw;
 };
 
 static inline struct ieee80211_sub_if_data *
@@ -2300,9 +2296,13 @@ void ieee80211_tdls_cancel_channel_switch(struct wiphy *wiphy,
 					  struct net_device *dev,
 					  const u8 *addr);
 void ieee80211_teardown_tdls_peers(struct ieee80211_sub_if_data *sdata);
-void ieee80211_tdls_chsw_work(struct work_struct *wk);
 void ieee80211_tdls_handle_disconnect(struct ieee80211_sub_if_data *sdata,
 				      const u8 *peer, u16 reason);
+void
+ieee80211_process_tdls_channel_switch(struct ieee80211_sub_if_data *sdata,
+				      struct sk_buff *skb);
+
+
 const char *ieee80211_get_reason_code_string(u16 reason_code);
 u16 ieee80211_encode_usf(int val);
 u8 *ieee80211_get_bssid(struct ieee80211_hdr *hdr, size_t len,
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 3a998ae50429..8625f19a2547 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -1458,7 +1458,10 @@ static void ieee80211_iface_work(struct work_struct *work)
 	while ((skb = skb_dequeue(&sdata->skb_queue))) {
 		kcov_remote_start_common(skb_get_kcov_handle(skb));
 
-		ieee80211_iface_process_skb(local, sdata, skb);
+		if (skb->protocol == cpu_to_be16(ETH_P_TDLS))
+			ieee80211_process_tdls_channel_switch(sdata, skb);
+		else
+			ieee80211_iface_process_skb(local, sdata, skb);
 
 		kfree_skb(skb);
 		kcov_remote_stop();
diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index 62145e5f9628..9a12db51fdb6 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -734,8 +734,6 @@ struct ieee80211_hw *ieee80211_alloc_hw_nm(size_t priv_data_len,
 	INIT_WORK(&local->sched_scan_stopped_work,
 		  ieee80211_sched_scan_stopped_work);
 
-	INIT_WORK(&local->tdls_chsw_work, ieee80211_tdls_chsw_work);
-
 	spin_lock_init(&local->ack_status_lock);
 	idr_init(&local->ack_status_frames);
 
@@ -752,7 +750,6 @@ struct ieee80211_hw *ieee80211_alloc_hw_nm(size_t priv_data_len,
 
 	skb_queue_head_init(&local->skb_queue);
 	skb_queue_head_init(&local->skb_queue_unreliable);
-	skb_queue_head_init(&local->skb_queue_tdls_chsw);
 
 	ieee80211_alloc_led_names(local);
 
@@ -1384,7 +1381,6 @@ void ieee80211_unregister_hw(struct ieee80211_hw *hw)
 	cancel_delayed_work_sync(&local->roc_work);
 	cancel_work_sync(&local->restart_work);
 	cancel_work_sync(&local->reconfig_filter);
-	cancel_work_sync(&local->tdls_chsw_work);
 	flush_work(&local->sched_scan_stopped_work);
 	flush_work(&local->radar_detected_work);
 
@@ -1396,7 +1392,6 @@ void ieee80211_unregister_hw(struct ieee80211_hw *hw)
 		wiphy_warn(local->hw.wiphy, "skb_queue not empty\n");
 	skb_queue_purge(&local->skb_queue);
 	skb_queue_purge(&local->skb_queue_unreliable);
-	skb_queue_purge(&local->skb_queue_tdls_chsw);
 
 	wiphy_unregister(local->hw.wiphy);
 	destroy_workqueue(local->workqueue);
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 06ea259bb385..69acca2cfe88 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -214,9 +214,9 @@ ieee80211_rx_radiotap_hdrlen(struct ieee80211_local *local,
 	return len;
 }
 
-static void ieee80211_queue_skb_to_iface(struct ieee80211_sub_if_data *sdata,
-					 struct sta_info *sta,
-					 struct sk_buff *skb)
+static void __ieee80211_queue_skb_to_iface(struct ieee80211_sub_if_data *sdata,
+					   struct sta_info *sta,
+					   struct sk_buff *skb)
 {
 	skb_queue_tail(&sdata->skb_queue, skb);
 	ieee80211_queue_work(&sdata->local->hw, &sdata->work);
@@ -224,6 +224,14 @@ static void ieee80211_queue_skb_to_iface(struct ieee80211_sub_if_data *sdata,
 		sta->rx_stats.packets++;
 }
 
+static void ieee80211_queue_skb_to_iface(struct ieee80211_sub_if_data *sdata,
+					 struct sta_info *sta,
+					 struct sk_buff *skb)
+{
+	skb->protocol = 0;
+	__ieee80211_queue_skb_to_iface(sdata, sta, skb);
+}
+
 static void ieee80211_handle_mu_mimo_mon(struct ieee80211_sub_if_data *sdata,
 					 struct sk_buff *skb,
 					 int rtap_space)
@@ -2935,11 +2943,8 @@ ieee80211_rx_h_data(struct ieee80211_rx_data *rx)
 		    tf->category == WLAN_CATEGORY_TDLS &&
 		    (tf->action_code == WLAN_TDLS_CHANNEL_SWITCH_REQUEST ||
 		     tf->action_code == WLAN_TDLS_CHANNEL_SWITCH_RESPONSE)) {
-			skb_queue_tail(&local->skb_queue_tdls_chsw, rx->skb);
-			schedule_work(&local->tdls_chsw_work);
-			if (rx->sta)
-				rx->sta->rx_stats.packets++;
-
+			rx->skb->protocol = cpu_to_be16(ETH_P_TDLS);
+			__ieee80211_queue_skb_to_iface(sdata, rx->sta, rx->skb);
 			return RX_QUEUED;
 		}
 	}
diff --git a/net/mac80211/tdls.c b/net/mac80211/tdls.c
index f91d02b81b92..45e532ad1215 100644
--- a/net/mac80211/tdls.c
+++ b/net/mac80211/tdls.c
@@ -1920,7 +1920,7 @@ ieee80211_process_tdls_channel_switch_req(struct ieee80211_sub_if_data *sdata,
 	return ret;
 }
 
-static void
+void
 ieee80211_process_tdls_channel_switch(struct ieee80211_sub_if_data *sdata,
 				      struct sk_buff *skb)
 {
@@ -1971,32 +1971,6 @@ void ieee80211_teardown_tdls_peers(struct ieee80211_sub_if_data *sdata)
 	rcu_read_unlock();
 }
 
-void ieee80211_tdls_chsw_work(struct work_struct *wk)
-{
-	struct ieee80211_local *local =
-		container_of(wk, struct ieee80211_local, tdls_chsw_work);
-	struct ieee80211_sub_if_data *sdata;
-	struct sk_buff *skb;
-	struct ieee80211_tdls_data *tf;
-
-	wiphy_lock(local->hw.wiphy);
-	while ((skb = skb_dequeue(&local->skb_queue_tdls_chsw))) {
-		tf = (struct ieee80211_tdls_data *)skb->data;
-		list_for_each_entry(sdata, &local->interfaces, list) {
-			if (!ieee80211_sdata_running(sdata) ||
-			    sdata->vif.type != NL80211_IFTYPE_STATION ||
-			    !ether_addr_equal(tf->da, sdata->vif.addr))
-				continue;
-
-			ieee80211_process_tdls_channel_switch(sdata, skb);
-			break;
-		}
-
-		kfree_skb(skb);
-	}
-	wiphy_unlock(local->hw.wiphy);
-}
-
 void ieee80211_tdls_handle_disconnect(struct ieee80211_sub_if_data *sdata,
 				      const u8 *peer, u16 reason)
 {
-- 
2.31.1

