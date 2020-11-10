Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E575B2AD442
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Nov 2020 11:59:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbgKJK7y (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 10 Nov 2020 05:59:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726344AbgKJK7x (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 10 Nov 2020 05:59:53 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8AE2C0613D1
        for <linux-wireless@vger.kernel.org>; Tue, 10 Nov 2020 02:59:53 -0800 (PST)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1kcRNN-004slV-Cw; Tue, 10 Nov 2020 11:59:49 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 2/2] mac80211: make sta_info_free() handle it all
Date:   Tue, 10 Nov 2020 11:59:44 +0100
Message-Id: <20201110115943.d88e5b3a60ee.If80e314ab63f7fc4bdc5cedbfab738459928e04d@changeid>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201110115943.a44a8e309b18.I9c31d667a0ea2151441cc64ed6613d36c18a48e0@changeid>
References: <20201110115943.a44a8e309b18.I9c31d667a0ea2151441cc64ed6613d36c18a48e0@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

There's no need to not call __cleanup_single_sta() here, as
it won't do anything if the relevant setup hasn't been done.
As such, move all the code into sta_info_free() and adjust
it a bit to not skip all the rest when powersave isn't set
up quite right.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/sta_info.c | 172 ++++++++++++++++++----------------------
 1 file changed, 77 insertions(+), 95 deletions(-)

diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index f7070674d1c8..22af230b79d8 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -81,99 +81,6 @@ static int sta_info_hash_del(struct ieee80211_local *local,
 			       sta_rht_params);
 }
 
-static void __cleanup_single_sta(struct sta_info *sta)
-{
-	int ac, i;
-	struct tid_ampdu_tx *tid_tx;
-	struct ieee80211_sub_if_data *sdata = sta->sdata;
-	struct ieee80211_local *local = sdata->local;
-	struct ps_data *ps;
-
-	if (test_sta_flag(sta, WLAN_STA_PS_STA) ||
-	    test_sta_flag(sta, WLAN_STA_PS_DRIVER) ||
-	    test_sta_flag(sta, WLAN_STA_PS_DELIVER)) {
-		if (sta->sdata->vif.type == NL80211_IFTYPE_AP ||
-		    sta->sdata->vif.type == NL80211_IFTYPE_AP_VLAN)
-			ps = &sdata->bss->ps;
-		else if (ieee80211_vif_is_mesh(&sdata->vif))
-			ps = &sdata->u.mesh.ps;
-		else
-			return;
-
-		clear_sta_flag(sta, WLAN_STA_PS_STA);
-		clear_sta_flag(sta, WLAN_STA_PS_DRIVER);
-		clear_sta_flag(sta, WLAN_STA_PS_DELIVER);
-
-		atomic_dec(&ps->num_sta_ps);
-	}
-
-	if (sta->sta.txq[0]) {
-		for (i = 0; i < ARRAY_SIZE(sta->sta.txq); i++) {
-			struct txq_info *txqi;
-
-			if (!sta->sta.txq[i])
-				continue;
-
-			txqi = to_txq_info(sta->sta.txq[i]);
-
-			ieee80211_txq_purge(local, txqi);
-		}
-	}
-
-	for (ac = 0; ac < IEEE80211_NUM_ACS; ac++) {
-		local->total_ps_buffered -= skb_queue_len(&sta->ps_tx_buf[ac]);
-		ieee80211_purge_tx_queue(&local->hw, &sta->ps_tx_buf[ac]);
-		ieee80211_purge_tx_queue(&local->hw, &sta->tx_filtered[ac]);
-	}
-
-	if (ieee80211_vif_is_mesh(&sdata->vif))
-		mesh_sta_cleanup(sta);
-
-	cancel_work_sync(&sta->drv_deliver_wk);
-
-	/*
-	 * Destroy aggregation state here. It would be nice to wait for the
-	 * driver to finish aggregation stop and then clean up, but for now
-	 * drivers have to handle aggregation stop being requested, followed
-	 * directly by station destruction.
-	 */
-	for (i = 0; i < IEEE80211_NUM_TIDS; i++) {
-		kfree(sta->ampdu_mlme.tid_start_tx[i]);
-		tid_tx = rcu_dereference_raw(sta->ampdu_mlme.tid_tx[i]);
-		if (!tid_tx)
-			continue;
-		ieee80211_purge_tx_queue(&local->hw, &tid_tx->pending);
-		kfree(tid_tx);
-	}
-
-	/*
-	 * If we had used sta_info_pre_move_state() then we might not
-	 * have gone through the state transitions down again, so do
-	 * it here now (and warn if it's inserted).
-	 *
-	 * This will clear state such as fast TX/RX that may have been
-	 * allocated during state transitions.
-	 */
-	while (sta->sta_state > IEEE80211_STA_NONE) {
-		int ret;
-
-		WARN_ON_ONCE(test_sta_flag(sta, WLAN_STA_INSERTED));
-
-		ret = sta_info_move_state(sta, sta->sta_state - 1);
-		if (WARN_ONCE(ret, "sta_info_move_state() returned %d\n", ret))
-			break;
-	}
-}
-
-static void cleanup_single_sta(struct sta_info *sta)
-{
-	struct ieee80211_sub_if_data *sdata = sta->sdata;
-	struct ieee80211_local *local = sdata->local;
-
-	__cleanup_single_sta(sta);
-	sta_info_free(local, sta);
-}
-
 struct rhlist_head *sta_info_hash_lookup(struct ieee80211_local *local,
 					 const u8 *addr)
 {
@@ -276,6 +183,81 @@ struct sta_info *sta_info_get_by_idx(struct ieee80211_sub_if_data *sdata,
  */
 void sta_info_free(struct ieee80211_local *local, struct sta_info *sta)
 {
+	struct ieee80211_sub_if_data *sdata = sta->sdata;
+	struct tid_ampdu_tx *tid_tx;
+	int ac, i;
+
+	if (test_sta_flag(sta, WLAN_STA_PS_STA) ||
+	    test_sta_flag(sta, WLAN_STA_PS_DRIVER) ||
+	    test_sta_flag(sta, WLAN_STA_PS_DELIVER)) {
+		if (sta->sdata->vif.type == NL80211_IFTYPE_AP ||
+		    sta->sdata->vif.type == NL80211_IFTYPE_AP_VLAN)
+			atomic_dec(&sdata->bss->ps.num_sta_ps);
+		else if (ieee80211_vif_is_mesh(&sdata->vif))
+			atomic_dec(&sdata->u.mesh.ps.num_sta_ps);
+
+		clear_sta_flag(sta, WLAN_STA_PS_STA);
+		clear_sta_flag(sta, WLAN_STA_PS_DRIVER);
+		clear_sta_flag(sta, WLAN_STA_PS_DELIVER);
+	}
+
+	if (sta->sta.txq[0]) {
+		for (i = 0; i < ARRAY_SIZE(sta->sta.txq); i++) {
+			struct txq_info *txqi;
+
+			if (!sta->sta.txq[i])
+				continue;
+
+			txqi = to_txq_info(sta->sta.txq[i]);
+
+			ieee80211_txq_purge(local, txqi);
+		}
+	}
+
+	for (ac = 0; ac < IEEE80211_NUM_ACS; ac++) {
+		local->total_ps_buffered -= skb_queue_len(&sta->ps_tx_buf[ac]);
+		ieee80211_purge_tx_queue(&local->hw, &sta->ps_tx_buf[ac]);
+		ieee80211_purge_tx_queue(&local->hw, &sta->tx_filtered[ac]);
+	}
+
+	if (ieee80211_vif_is_mesh(&sdata->vif))
+		mesh_sta_cleanup(sta);
+
+	cancel_work_sync(&sta->drv_deliver_wk);
+
+	/*
+	 * Destroy aggregation state here. It would be nice to wait for the
+	 * driver to finish aggregation stop and then clean up, but for now
+	 * drivers have to handle aggregation stop being requested, followed
+	 * directly by station destruction.
+	 */
+	for (i = 0; i < IEEE80211_NUM_TIDS; i++) {
+		kfree(sta->ampdu_mlme.tid_start_tx[i]);
+		tid_tx = rcu_dereference_raw(sta->ampdu_mlme.tid_tx[i]);
+		if (!tid_tx)
+			continue;
+		ieee80211_purge_tx_queue(&local->hw, &tid_tx->pending);
+		kfree(tid_tx);
+	}
+
+	/*
+	 * If we had used sta_info_pre_move_state() then we might not
+	 * have gone through the state transitions down again, so do
+	 * it here now (and warn if it's inserted).
+	 *
+	 * This will clear state such as fast TX/RX that may have been
+	 * allocated during state transitions.
+	 */
+	while (sta->sta_state > IEEE80211_STA_NONE) {
+		int ret;
+
+		WARN_ON_ONCE(test_sta_flag(sta, WLAN_STA_INSERTED));
+
+		ret = sta_info_move_state(sta, sta->sta_state - 1);
+		if (WARN_ONCE(ret, "sta_info_move_state() returned %d\n", ret))
+			break;
+	}
+
 	if (sta->rate_ctrl)
 		rate_control_free_sta(sta);
 
@@ -705,7 +687,7 @@ static int sta_info_insert_finish(struct sta_info *sta) __acquires(RCU)
  out_drop_sta:
 	local->num_sta--;
 	synchronize_net();
-	cleanup_single_sta(sta);
+	sta_info_free(local, sta);
  out_err:
 	mutex_unlock(&local->sta_mtx);
 	kfree(sinfo);
@@ -1102,7 +1084,7 @@ static void __sta_info_destroy_part2(struct sta_info *sta)
 
 	ieee80211_sta_debugfs_remove(sta);
 
-	cleanup_single_sta(sta);
+	sta_info_free(local, sta);
 }
 
 int __must_check __sta_info_destroy(struct sta_info *sta)
-- 
2.26.2

