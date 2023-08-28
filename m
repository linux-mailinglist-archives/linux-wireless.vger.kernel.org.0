Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AAAE78AF9C
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Aug 2023 14:06:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232578AbjH1MGT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Aug 2023 08:06:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232604AbjH1MFq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Aug 2023 08:05:46 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8404F12F
        for <linux-wireless@vger.kernel.org>; Mon, 28 Aug 2023 05:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=hDEraigGvGyA5i1ekWSKPDwq/grQUubeX/Iq1YIbyb8=;
        t=1693224341; x=1694433941; b=VmBoKGR0gZoQx9HADmy79T31POFeJ9HvMfD84xTs9dFYHV0
        yzDgL+jLIG3UsRDmTxM/5iFqqOVqRYqF+8fcCO0Yzdx0XMvenAKWf4AavRimVa3zcXg0bXzxYD3Lp
        zTj4ivYg4R3ZG1JjjJmloMy9kivkW+mt+tyw1DXAjSZ1z3MLfcA7U/g3HLg4jvLeUUlsNKdFy9Qme
        XIEZiiKC3Bu+jUaggwhPMj/uaUScS5mWnwK4UvCh+3LKzoVAR6xdesQu4bsWpLGMoc7JFEiJZp4Dw
        xujBpnj/wiH6ZoBKf/YOl+d4EUVa55LQ0FX/nN/7emYzo/Vc1QGdpCDVLNPxiLOA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qaazz-00Gjgt-07;
        Mon, 28 Aug 2023 14:05:39 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH 24/40] wifi: mac80211: check wiphy mutex in ops
Date:   Mon, 28 Aug 2023 13:59:52 +0200
Message-ID: <20230828135928.dd985cf9b0cc.Icf0383240e3bd0dedba1c2f972bb5086e733b491@changeid>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230828115927.116700-41-johannes@sipsolutions.net>
References: <20230828115927.116700-41-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Check that we hold the wiphy mutex in the ops when
calling the driver, since we're now on our way to
always hold it, and simplify the locking.

Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/driver-ops.c | 20 +++++++++++
 net/mac80211/driver-ops.h | 75 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 95 insertions(+)

diff --git a/net/mac80211/driver-ops.c b/net/mac80211/driver-ops.c
index 376dae58b5a6..97043d732f2e 100644
--- a/net/mac80211/driver-ops.c
+++ b/net/mac80211/driver-ops.c
@@ -15,6 +15,7 @@ int drv_start(struct ieee80211_local *local)
 	int ret;
 
 	might_sleep();
+	lockdep_assert_wiphy(local->hw.wiphy);
 
 	if (WARN_ON(local->started))
 		return -EALREADY;
@@ -35,6 +36,7 @@ int drv_start(struct ieee80211_local *local)
 void drv_stop(struct ieee80211_local *local)
 {
 	might_sleep();
+	lockdep_assert_wiphy(local->hw.wiphy);
 
 	if (WARN_ON(!local->started))
 		return;
@@ -58,6 +60,7 @@ int drv_add_interface(struct ieee80211_local *local,
 	int ret;
 
 	might_sleep();
+	lockdep_assert_wiphy(local->hw.wiphy);
 
 	if (WARN_ON(sdata->vif.type == NL80211_IFTYPE_AP_VLAN ||
 		    (sdata->vif.type == NL80211_IFTYPE_MONITOR &&
@@ -82,6 +85,7 @@ int drv_change_interface(struct ieee80211_local *local,
 	int ret;
 
 	might_sleep();
+	lockdep_assert_wiphy(local->hw.wiphy);
 
 	if (!check_sdata_in_driver(sdata))
 		return -EIO;
@@ -96,6 +100,7 @@ void drv_remove_interface(struct ieee80211_local *local,
 			  struct ieee80211_sub_if_data *sdata)
 {
 	might_sleep();
+	lockdep_assert_wiphy(local->hw.wiphy);
 
 	if (!check_sdata_in_driver(sdata))
 		return;
@@ -116,6 +121,7 @@ int drv_sta_state(struct ieee80211_local *local,
 	int ret = 0;
 
 	might_sleep();
+	lockdep_assert_wiphy(local->hw.wiphy);
 
 	sdata = get_bss_sdata(sdata);
 	if (!check_sdata_in_driver(sdata))
@@ -149,6 +155,7 @@ int drv_sta_set_txpwr(struct ieee80211_local *local,
 	int ret = -EOPNOTSUPP;
 
 	might_sleep();
+	lockdep_assert_wiphy(local->hw.wiphy);
 
 	sdata = get_bss_sdata(sdata);
 	if (!check_sdata_in_driver(sdata))
@@ -190,6 +197,7 @@ int drv_conf_tx(struct ieee80211_local *local,
 	int ret = -EOPNOTSUPP;
 
 	might_sleep();
+	lockdep_assert_wiphy(local->hw.wiphy);
 
 	if (!check_sdata_in_driver(sdata))
 		return -EIO;
@@ -223,6 +231,7 @@ u64 drv_get_tsf(struct ieee80211_local *local,
 	u64 ret = -1ULL;
 
 	might_sleep();
+	lockdep_assert_wiphy(local->hw.wiphy);
 
 	if (!check_sdata_in_driver(sdata))
 		return ret;
@@ -239,6 +248,7 @@ void drv_set_tsf(struct ieee80211_local *local,
 		 u64 tsf)
 {
 	might_sleep();
+	lockdep_assert_wiphy(local->hw.wiphy);
 
 	if (!check_sdata_in_driver(sdata))
 		return;
@@ -254,6 +264,7 @@ void drv_offset_tsf(struct ieee80211_local *local,
 		    s64 offset)
 {
 	might_sleep();
+	lockdep_assert_wiphy(local->hw.wiphy);
 
 	if (!check_sdata_in_driver(sdata))
 		return;
@@ -268,6 +279,7 @@ void drv_reset_tsf(struct ieee80211_local *local,
 		   struct ieee80211_sub_if_data *sdata)
 {
 	might_sleep();
+	lockdep_assert_wiphy(local->hw.wiphy);
 
 	if (!check_sdata_in_driver(sdata))
 		return;
@@ -286,6 +298,7 @@ int drv_assign_vif_chanctx(struct ieee80211_local *local,
 	int ret = 0;
 
 	might_sleep();
+	lockdep_assert_wiphy(local->hw.wiphy);
 
 	drv_verify_link_exists(sdata, link_conf);
 	if (!check_sdata_in_driver(sdata))
@@ -314,6 +327,7 @@ void drv_unassign_vif_chanctx(struct ieee80211_local *local,
 			      struct ieee80211_chanctx *ctx)
 {
 	might_sleep();
+	lockdep_assert_wiphy(local->hw.wiphy);
 
 	drv_verify_link_exists(sdata, link_conf);
 	if (!check_sdata_in_driver(sdata))
@@ -342,6 +356,7 @@ int drv_switch_vif_chanctx(struct ieee80211_local *local,
 	int i;
 
 	might_sleep();
+	lockdep_assert_wiphy(local->hw.wiphy);
 
 	if (!local->ops->switch_vif_chanctx)
 		return -EOPNOTSUPP;
@@ -394,6 +409,7 @@ int drv_ampdu_action(struct ieee80211_local *local,
 	int ret = -EOPNOTSUPP;
 
 	might_sleep();
+	lockdep_assert_wiphy(local->hw.wiphy);
 
 	if (!sdata)
 		return -EIO;
@@ -418,6 +434,7 @@ void drv_link_info_changed(struct ieee80211_local *local,
 			   int link_id, u64 changed)
 {
 	might_sleep();
+	lockdep_assert_wiphy(local->hw.wiphy);
 
 	if (WARN_ON_ONCE(changed & (BSS_CHANGED_BEACON |
 				    BSS_CHANGED_BEACON_ENABLED) &&
@@ -460,6 +477,7 @@ int drv_set_key(struct ieee80211_local *local,
 	int ret;
 
 	might_sleep();
+	lockdep_assert_wiphy(local->hw.wiphy);
 
 	sdata = get_bss_sdata(sdata);
 	if (!check_sdata_in_driver(sdata))
@@ -487,6 +505,7 @@ int drv_change_vif_links(struct ieee80211_local *local,
 	int ret = -EOPNOTSUPP;
 
 	might_sleep();
+	lockdep_assert_wiphy(local->hw.wiphy);
 
 	if (!check_sdata_in_driver(sdata))
 		return -EIO;
@@ -534,6 +553,7 @@ int drv_change_sta_links(struct ieee80211_local *local,
 	int ret = -EOPNOTSUPP;
 
 	might_sleep();
+	lockdep_assert_wiphy(local->hw.wiphy);
 
 	if (!check_sdata_in_driver(sdata))
 		return -EIO;
diff --git a/net/mac80211/driver-ops.h b/net/mac80211/driver-ops.h
index d95ff2282f54..2fac7dc2eb9d 100644
--- a/net/mac80211/driver-ops.h
+++ b/net/mac80211/driver-ops.h
@@ -41,6 +41,7 @@ static inline void drv_sync_rx_queues(struct ieee80211_local *local,
 				      struct sta_info *sta)
 {
 	might_sleep();
+	lockdep_assert_wiphy(local->hw.wiphy);
 
 	if (local->ops->sync_rx_queues) {
 		trace_drv_sync_rx_queues(local, sta->sdata, &sta->sta);
@@ -96,6 +97,7 @@ static inline int drv_suspend(struct ieee80211_local *local,
 	int ret;
 
 	might_sleep();
+	lockdep_assert_wiphy(local->hw.wiphy);
 
 	trace_drv_suspend(local);
 	ret = local->ops->suspend(&local->hw, wowlan);
@@ -108,6 +110,7 @@ static inline int drv_resume(struct ieee80211_local *local)
 	int ret;
 
 	might_sleep();
+	lockdep_assert_wiphy(local->hw.wiphy);
 
 	trace_drv_resume(local);
 	ret = local->ops->resume(&local->hw);
@@ -119,6 +122,7 @@ static inline void drv_set_wakeup(struct ieee80211_local *local,
 				  bool enabled)
 {
 	might_sleep();
+	lockdep_assert_wiphy(local->hw.wiphy);
 
 	if (!local->ops->set_wakeup)
 		return;
@@ -144,6 +148,7 @@ static inline int drv_config(struct ieee80211_local *local, u32 changed)
 	int ret;
 
 	might_sleep();
+	lockdep_assert_wiphy(local->hw.wiphy);
 
 	trace_drv_config(local, changed);
 	ret = local->ops->config(&local->hw, changed);
@@ -156,6 +161,7 @@ static inline void drv_vif_cfg_changed(struct ieee80211_local *local,
 				       u64 changed)
 {
 	might_sleep();
+	lockdep_assert_wiphy(local->hw.wiphy);
 
 	if (!check_sdata_in_driver(sdata))
 		return;
@@ -195,6 +201,7 @@ static inline void drv_configure_filter(struct ieee80211_local *local,
 					u64 multicast)
 {
 	might_sleep();
+	lockdep_assert_wiphy(local->hw.wiphy);
 
 	trace_drv_configure_filter(local, changed_flags, total_flags,
 				   multicast);
@@ -209,6 +216,7 @@ static inline void drv_config_iface_filter(struct ieee80211_local *local,
 					   unsigned int changed_flags)
 {
 	might_sleep();
+	lockdep_assert_wiphy(local->hw.wiphy);
 
 	trace_drv_config_iface_filter(local, sdata, filter_flags,
 				      changed_flags);
@@ -265,6 +273,7 @@ static inline int drv_hw_scan(struct ieee80211_local *local,
 	int ret;
 
 	might_sleep();
+	lockdep_assert_wiphy(local->hw.wiphy);
 
 	if (!check_sdata_in_driver(sdata))
 		return -EIO;
@@ -279,6 +288,7 @@ static inline void drv_cancel_hw_scan(struct ieee80211_local *local,
 				      struct ieee80211_sub_if_data *sdata)
 {
 	might_sleep();
+	lockdep_assert_wiphy(local->hw.wiphy);
 
 	if (!check_sdata_in_driver(sdata))
 		return;
@@ -297,6 +307,7 @@ drv_sched_scan_start(struct ieee80211_local *local,
 	int ret;
 
 	might_sleep();
+	lockdep_assert_wiphy(local->hw.wiphy);
 
 	if (!check_sdata_in_driver(sdata))
 		return -EIO;
@@ -314,6 +325,7 @@ static inline int drv_sched_scan_stop(struct ieee80211_local *local,
 	int ret;
 
 	might_sleep();
+	lockdep_assert_wiphy(local->hw.wiphy);
 
 	if (!check_sdata_in_driver(sdata))
 		return -EIO;
@@ -330,6 +342,7 @@ static inline void drv_sw_scan_start(struct ieee80211_local *local,
 				     const u8 *mac_addr)
 {
 	might_sleep();
+	lockdep_assert_wiphy(local->hw.wiphy);
 
 	trace_drv_sw_scan_start(local, sdata, mac_addr);
 	if (local->ops->sw_scan_start)
@@ -341,6 +354,7 @@ static inline void drv_sw_scan_complete(struct ieee80211_local *local,
 					struct ieee80211_sub_if_data *sdata)
 {
 	might_sleep();
+	lockdep_assert_wiphy(local->hw.wiphy);
 
 	trace_drv_sw_scan_complete(local, sdata);
 	if (local->ops->sw_scan_complete)
@@ -354,6 +368,7 @@ static inline int drv_get_stats(struct ieee80211_local *local,
 	int ret = -EOPNOTSUPP;
 
 	might_sleep();
+	lockdep_assert_wiphy(local->hw.wiphy);
 
 	if (local->ops->get_stats)
 		ret = local->ops->get_stats(&local->hw, stats);
@@ -377,6 +392,7 @@ static inline int drv_set_frag_threshold(struct ieee80211_local *local,
 	int ret = 0;
 
 	might_sleep();
+	lockdep_assert_wiphy(local->hw.wiphy);
 
 	trace_drv_set_frag_threshold(local, value);
 	if (local->ops->set_frag_threshold)
@@ -391,6 +407,7 @@ static inline int drv_set_rts_threshold(struct ieee80211_local *local,
 	int ret = 0;
 
 	might_sleep();
+	lockdep_assert_wiphy(local->hw.wiphy);
 
 	trace_drv_set_rts_threshold(local, value);
 	if (local->ops->set_rts_threshold)
@@ -404,6 +421,7 @@ static inline int drv_set_coverage_class(struct ieee80211_local *local,
 {
 	int ret = 0;
 	might_sleep();
+	lockdep_assert_wiphy(local->hw.wiphy);
 
 	trace_drv_set_coverage_class(local, value);
 	if (local->ops->set_coverage_class)
@@ -437,6 +455,7 @@ static inline int drv_sta_add(struct ieee80211_local *local,
 	int ret = 0;
 
 	might_sleep();
+	lockdep_assert_wiphy(local->hw.wiphy);
 
 	sdata = get_bss_sdata(sdata);
 	if (!check_sdata_in_driver(sdata))
@@ -456,6 +475,7 @@ static inline void drv_sta_remove(struct ieee80211_local *local,
 				  struct ieee80211_sta *sta)
 {
 	might_sleep();
+	lockdep_assert_wiphy(local->hw.wiphy);
 
 	sdata = get_bss_sdata(sdata);
 	if (!check_sdata_in_driver(sdata))
@@ -475,6 +495,7 @@ static inline void drv_link_add_debugfs(struct ieee80211_local *local,
 					struct dentry *dir)
 {
 	might_sleep();
+	lockdep_assert_wiphy(local->hw.wiphy);
 
 	sdata = get_bss_sdata(sdata);
 	if (!check_sdata_in_driver(sdata))
@@ -491,6 +512,7 @@ static inline void drv_sta_add_debugfs(struct ieee80211_local *local,
 				       struct dentry *dir)
 {
 	might_sleep();
+	lockdep_assert_wiphy(local->hw.wiphy);
 
 	sdata = get_bss_sdata(sdata);
 	if (!check_sdata_in_driver(sdata))
@@ -507,6 +529,7 @@ static inline void drv_link_sta_add_debugfs(struct ieee80211_local *local,
 					    struct dentry *dir)
 {
 	might_sleep();
+	lockdep_assert_wiphy(local->hw.wiphy);
 
 	sdata = get_bss_sdata(sdata);
 	if (!check_sdata_in_driver(sdata))
@@ -523,6 +546,7 @@ static inline void drv_sta_pre_rcu_remove(struct ieee80211_local *local,
 					  struct sta_info *sta)
 {
 	might_sleep();
+	lockdep_assert_wiphy(local->hw.wiphy);
 
 	sdata = get_bss_sdata(sdata);
 	if (!check_sdata_in_driver(sdata))
@@ -572,6 +596,7 @@ static inline void drv_sta_statistics(struct ieee80211_local *local,
 				      struct station_info *sinfo)
 {
 	might_sleep();
+	lockdep_assert_wiphy(local->hw.wiphy);
 
 	sdata = get_bss_sdata(sdata);
 	if (!check_sdata_in_driver(sdata))
@@ -603,6 +628,7 @@ static inline int drv_tx_last_beacon(struct ieee80211_local *local)
 	int ret = 0; /* default unsupported op for less congestion */
 
 	might_sleep();
+	lockdep_assert_wiphy(local->hw.wiphy);
 
 	trace_drv_tx_last_beacon(local);
 	if (local->ops->tx_last_beacon)
@@ -621,6 +647,7 @@ static inline int drv_get_survey(struct ieee80211_local *local, int idx,
 	int ret = -EOPNOTSUPP;
 
 	might_sleep();
+	lockdep_assert_wiphy(local->hw.wiphy);
 
 	trace_drv_get_survey(local, idx, survey);
 
@@ -635,6 +662,7 @@ static inline int drv_get_survey(struct ieee80211_local *local, int idx,
 static inline void drv_rfkill_poll(struct ieee80211_local *local)
 {
 	might_sleep();
+	lockdep_assert_wiphy(local->hw.wiphy);
 
 	if (local->ops->rfkill_poll)
 		local->ops->rfkill_poll(&local->hw);
@@ -647,6 +675,7 @@ static inline void drv_flush(struct ieee80211_local *local,
 	struct ieee80211_vif *vif = sdata ? &sdata->vif : NULL;
 
 	might_sleep();
+	lockdep_assert_wiphy(local->hw.wiphy);
 
 	if (sdata && !check_sdata_in_driver(sdata))
 		return;
@@ -662,6 +691,7 @@ static inline void drv_flush_sta(struct ieee80211_local *local,
 				 struct sta_info *sta)
 {
 	might_sleep();
+	lockdep_assert_wiphy(local->hw.wiphy);
 
 	if (sdata && !check_sdata_in_driver(sdata))
 		return;
@@ -677,6 +707,7 @@ static inline void drv_channel_switch(struct ieee80211_local *local,
 				      struct ieee80211_channel_switch *ch_switch)
 {
 	might_sleep();
+	lockdep_assert_wiphy(local->hw.wiphy);
 
 	trace_drv_channel_switch(local, sdata, ch_switch);
 	local->ops->channel_switch(&local->hw, &sdata->vif, ch_switch);
@@ -689,6 +720,7 @@ static inline int drv_set_antenna(struct ieee80211_local *local,
 {
 	int ret = -EOPNOTSUPP;
 	might_sleep();
+	lockdep_assert_wiphy(local->hw.wiphy);
 	if (local->ops->set_antenna)
 		ret = local->ops->set_antenna(&local->hw, tx_ant, rx_ant);
 	trace_drv_set_antenna(local, tx_ant, rx_ant, ret);
@@ -700,6 +732,7 @@ static inline int drv_get_antenna(struct ieee80211_local *local,
 {
 	int ret = -EOPNOTSUPP;
 	might_sleep();
+	lockdep_assert_wiphy(local->hw.wiphy);
 	if (local->ops->get_antenna)
 		ret = local->ops->get_antenna(&local->hw, tx_ant, rx_ant);
 	trace_drv_get_antenna(local, *tx_ant, *rx_ant, ret);
@@ -715,6 +748,7 @@ static inline int drv_remain_on_channel(struct ieee80211_local *local,
 	int ret;
 
 	might_sleep();
+	lockdep_assert_wiphy(local->hw.wiphy);
 
 	trace_drv_remain_on_channel(local, sdata, chan, duration, type);
 	ret = local->ops->remain_on_channel(&local->hw, &sdata->vif,
@@ -731,6 +765,7 @@ drv_cancel_remain_on_channel(struct ieee80211_local *local,
 	int ret;
 
 	might_sleep();
+	lockdep_assert_wiphy(local->hw.wiphy);
 
 	trace_drv_cancel_remain_on_channel(local, sdata);
 	ret = local->ops->cancel_remain_on_channel(&local->hw, &sdata->vif);
@@ -745,6 +780,7 @@ static inline int drv_set_ringparam(struct ieee80211_local *local,
 	int ret = -ENOTSUPP;
 
 	might_sleep();
+	lockdep_assert_wiphy(local->hw.wiphy);
 
 	trace_drv_set_ringparam(local, tx, rx);
 	if (local->ops->set_ringparam)
@@ -758,6 +794,7 @@ static inline void drv_get_ringparam(struct ieee80211_local *local,
 				     u32 *tx, u32 *tx_max, u32 *rx, u32 *rx_max)
 {
 	might_sleep();
+	lockdep_assert_wiphy(local->hw.wiphy);
 
 	trace_drv_get_ringparam(local, tx, tx_max, rx, rx_max);
 	if (local->ops->get_ringparam)
@@ -770,6 +807,7 @@ static inline bool drv_tx_frames_pending(struct ieee80211_local *local)
 	bool ret = false;
 
 	might_sleep();
+	lockdep_assert_wiphy(local->hw.wiphy);
 
 	trace_drv_tx_frames_pending(local);
 	if (local->ops->tx_frames_pending)
@@ -786,6 +824,7 @@ static inline int drv_set_bitrate_mask(struct ieee80211_local *local,
 	int ret = -EOPNOTSUPP;
 
 	might_sleep();
+	lockdep_assert_wiphy(local->hw.wiphy);
 
 	if (!check_sdata_in_driver(sdata))
 		return -EIO;
@@ -804,6 +843,7 @@ static inline void drv_set_rekey_data(struct ieee80211_local *local,
 				      struct cfg80211_gtk_rekey_data *data)
 {
 	might_sleep();
+	lockdep_assert_wiphy(local->hw.wiphy);
 
 	if (!check_sdata_in_driver(sdata))
 		return;
@@ -859,6 +899,7 @@ static inline void drv_mgd_prepare_tx(struct ieee80211_local *local,
 				      struct ieee80211_prep_tx_info *info)
 {
 	might_sleep();
+	lockdep_assert_wiphy(local->hw.wiphy);
 
 	if (!check_sdata_in_driver(sdata))
 		return;
@@ -876,6 +917,7 @@ static inline void drv_mgd_complete_tx(struct ieee80211_local *local,
 				       struct ieee80211_prep_tx_info *info)
 {
 	might_sleep();
+	lockdep_assert_wiphy(local->hw.wiphy);
 
 	if (!check_sdata_in_driver(sdata))
 		return;
@@ -893,6 +935,7 @@ drv_mgd_protect_tdls_discover(struct ieee80211_local *local,
 			      struct ieee80211_sub_if_data *sdata)
 {
 	might_sleep();
+	lockdep_assert_wiphy(local->hw.wiphy);
 
 	if (!check_sdata_in_driver(sdata))
 		return;
@@ -910,6 +953,7 @@ static inline int drv_add_chanctx(struct ieee80211_local *local,
 	int ret = -EOPNOTSUPP;
 
 	might_sleep();
+	lockdep_assert_wiphy(local->hw.wiphy);
 
 	trace_drv_add_chanctx(local, ctx);
 	if (local->ops->add_chanctx)
@@ -925,6 +969,7 @@ static inline void drv_remove_chanctx(struct ieee80211_local *local,
 				      struct ieee80211_chanctx *ctx)
 {
 	might_sleep();
+	lockdep_assert_wiphy(local->hw.wiphy);
 
 	if (WARN_ON(!ctx->driver_present))
 		return;
@@ -941,6 +986,7 @@ static inline void drv_change_chanctx(struct ieee80211_local *local,
 				      u32 changed)
 {
 	might_sleep();
+	lockdep_assert_wiphy(local->hw.wiphy);
 
 	trace_drv_change_chanctx(local, ctx, changed);
 	if (local->ops->change_chanctx) {
@@ -980,6 +1026,7 @@ static inline int drv_start_ap(struct ieee80211_local *local,
 	drv_verify_link_exists(sdata, link_conf);
 
 	might_sleep();
+	lockdep_assert_wiphy(local->hw.wiphy);
 
 	if (!check_sdata_in_driver(sdata))
 		return -EIO;
@@ -996,6 +1043,7 @@ static inline void drv_stop_ap(struct ieee80211_local *local,
 			       struct ieee80211_bss_conf *link_conf)
 {
 	might_sleep();
+	lockdep_assert_wiphy(local->hw.wiphy);
 
 	/* make sure link_conf is protected */
 	drv_verify_link_exists(sdata, link_conf);
@@ -1014,6 +1062,7 @@ drv_reconfig_complete(struct ieee80211_local *local,
 		      enum ieee80211_reconfig_type reconfig_type)
 {
 	might_sleep();
+	lockdep_assert_wiphy(local->hw.wiphy);
 
 	trace_drv_reconfig_complete(local, reconfig_type);
 	if (local->ops->reconfig_complete)
@@ -1027,6 +1076,7 @@ drv_set_default_unicast_key(struct ieee80211_local *local,
 			    int key_idx)
 {
 	might_sleep();
+	lockdep_assert_wiphy(local->hw.wiphy);
 
 	if (!check_sdata_in_driver(sdata))
 		return;
@@ -1059,6 +1109,7 @@ drv_channel_switch_beacon(struct ieee80211_sub_if_data *sdata,
 	struct ieee80211_local *local = sdata->local;
 
 	might_sleep();
+	lockdep_assert_wiphy(local->hw.wiphy);
 
 	if (local->ops->channel_switch_beacon) {
 		trace_drv_channel_switch_beacon(local, sdata, chandef);
@@ -1075,6 +1126,7 @@ drv_pre_channel_switch(struct ieee80211_sub_if_data *sdata,
 	int ret = 0;
 
 	might_sleep();
+	lockdep_assert_wiphy(local->hw.wiphy);
 
 	if (!check_sdata_in_driver(sdata))
 		return -EIO;
@@ -1094,6 +1146,7 @@ drv_post_channel_switch(struct ieee80211_sub_if_data *sdata)
 	int ret = 0;
 
 	might_sleep();
+	lockdep_assert_wiphy(local->hw.wiphy);
 
 	if (!check_sdata_in_driver(sdata))
 		return -EIO;
@@ -1111,6 +1164,7 @@ drv_abort_channel_switch(struct ieee80211_sub_if_data *sdata)
 	struct ieee80211_local *local = sdata->local;
 
 	might_sleep();
+	lockdep_assert_wiphy(local->hw.wiphy);
 
 	if (!check_sdata_in_driver(sdata))
 		return;
@@ -1128,6 +1182,7 @@ drv_channel_switch_rx_beacon(struct ieee80211_sub_if_data *sdata,
 	struct ieee80211_local *local = sdata->local;
 
 	might_sleep();
+	lockdep_assert_wiphy(local->hw.wiphy);
 
 	if (!check_sdata_in_driver(sdata))
 		return;
@@ -1144,6 +1199,7 @@ static inline int drv_join_ibss(struct ieee80211_local *local,
 	int ret = 0;
 
 	might_sleep();
+	lockdep_assert_wiphy(local->hw.wiphy);
 	if (!check_sdata_in_driver(sdata))
 		return -EIO;
 
@@ -1158,6 +1214,7 @@ static inline void drv_leave_ibss(struct ieee80211_local *local,
 				  struct ieee80211_sub_if_data *sdata)
 {
 	might_sleep();
+	lockdep_assert_wiphy(local->hw.wiphy);
 	if (!check_sdata_in_driver(sdata))
 		return;
 
@@ -1186,6 +1243,7 @@ static inline int drv_get_txpower(struct ieee80211_local *local,
 	int ret;
 
 	might_sleep();
+	lockdep_assert_wiphy(local->hw.wiphy);
 
 	if (!local->ops->get_txpower)
 		return -EOPNOTSUPP;
@@ -1206,6 +1264,7 @@ drv_tdls_channel_switch(struct ieee80211_local *local,
 	int ret;
 
 	might_sleep();
+	lockdep_assert_wiphy(local->hw.wiphy);
 	if (!check_sdata_in_driver(sdata))
 		return -EIO;
 
@@ -1226,6 +1285,7 @@ drv_tdls_cancel_channel_switch(struct ieee80211_local *local,
 			       struct ieee80211_sta *sta)
 {
 	might_sleep();
+	lockdep_assert_wiphy(local->hw.wiphy);
 	if (!check_sdata_in_driver(sdata))
 		return;
 
@@ -1292,6 +1352,7 @@ drv_get_ftm_responder_stats(struct ieee80211_local *local,
 	u32 ret = -EOPNOTSUPP;
 
 	might_sleep();
+	lockdep_assert_wiphy(local->hw.wiphy);
 	if (!check_sdata_in_driver(sdata))
 		return -EIO;
 
@@ -1311,6 +1372,7 @@ static inline int drv_start_pmsr(struct ieee80211_local *local,
 	int ret = -EOPNOTSUPP;
 
 	might_sleep();
+	lockdep_assert_wiphy(local->hw.wiphy);
 	if (!check_sdata_in_driver(sdata))
 		return -EIO;
 
@@ -1330,6 +1392,7 @@ static inline void drv_abort_pmsr(struct ieee80211_local *local,
 	trace_drv_abort_pmsr(local, sdata);
 
 	might_sleep();
+	lockdep_assert_wiphy(local->hw.wiphy);
 	if (!check_sdata_in_driver(sdata))
 		return;
 
@@ -1345,6 +1408,7 @@ static inline int drv_start_nan(struct ieee80211_local *local,
 	int ret;
 
 	might_sleep();
+	lockdep_assert_wiphy(local->hw.wiphy);
 	check_sdata_in_driver(sdata);
 
 	trace_drv_start_nan(local, sdata, conf);
@@ -1357,6 +1421,7 @@ static inline void drv_stop_nan(struct ieee80211_local *local,
 				struct ieee80211_sub_if_data *sdata)
 {
 	might_sleep();
+	lockdep_assert_wiphy(local->hw.wiphy);
 	check_sdata_in_driver(sdata);
 
 	trace_drv_stop_nan(local, sdata);
@@ -1372,6 +1437,7 @@ static inline int drv_nan_change_conf(struct ieee80211_local *local,
 	int ret;
 
 	might_sleep();
+	lockdep_assert_wiphy(local->hw.wiphy);
 	check_sdata_in_driver(sdata);
 
 	if (!local->ops->nan_change_conf)
@@ -1392,6 +1458,7 @@ static inline int drv_add_nan_func(struct ieee80211_local *local,
 	int ret;
 
 	might_sleep();
+	lockdep_assert_wiphy(local->hw.wiphy);
 	check_sdata_in_driver(sdata);
 
 	if (!local->ops->add_nan_func)
@@ -1409,6 +1476,7 @@ static inline void drv_del_nan_func(struct ieee80211_local *local,
 				   u8 instance_id)
 {
 	might_sleep();
+	lockdep_assert_wiphy(local->hw.wiphy);
 	check_sdata_in_driver(sdata);
 
 	trace_drv_del_nan_func(local, sdata, instance_id);
@@ -1425,6 +1493,7 @@ static inline int drv_set_tid_config(struct ieee80211_local *local,
 	int ret;
 
 	might_sleep();
+	lockdep_assert_wiphy(local->hw.wiphy);
 	ret = local->ops->set_tid_config(&local->hw, &sdata->vif, sta,
 					 tid_conf);
 	trace_drv_return_int(local, ret);
@@ -1439,6 +1508,7 @@ static inline int drv_reset_tid_config(struct ieee80211_local *local,
 	int ret;
 
 	might_sleep();
+	lockdep_assert_wiphy(local->hw.wiphy);
 	ret = local->ops->reset_tid_config(&local->hw, &sdata->vif, sta, tids);
 	trace_drv_return_int(local, ret);
 
@@ -1449,6 +1519,7 @@ static inline void drv_update_vif_offload(struct ieee80211_local *local,
 					  struct ieee80211_sub_if_data *sdata)
 {
 	might_sleep();
+	lockdep_assert_wiphy(local->hw.wiphy);
 	check_sdata_in_driver(sdata);
 
 	if (!local->ops->update_vif_offload)
@@ -1466,6 +1537,7 @@ static inline void drv_sta_set_4addr(struct ieee80211_local *local,
 	sdata = get_bss_sdata(sdata);
 
 	might_sleep();
+	lockdep_assert_wiphy(local->hw.wiphy);
 	if (!check_sdata_in_driver(sdata))
 		return;
 
@@ -1483,6 +1555,7 @@ static inline void drv_sta_set_decap_offload(struct ieee80211_local *local,
 	sdata = get_bss_sdata(sdata);
 
 	might_sleep();
+	lockdep_assert_wiphy(local->hw.wiphy);
 	if (!check_sdata_in_driver(sdata))
 		return;
 
@@ -1501,6 +1574,7 @@ static inline void drv_add_twt_setup(struct ieee80211_local *local,
 	struct ieee80211_twt_params *twt_agrt;
 
 	might_sleep();
+	lockdep_assert_wiphy(local->hw.wiphy);
 
 	if (!check_sdata_in_driver(sdata))
 		return;
@@ -1518,6 +1592,7 @@ static inline void drv_twt_teardown_request(struct ieee80211_local *local,
 					    u8 flowid)
 {
 	might_sleep();
+	lockdep_assert_wiphy(local->hw.wiphy);
 	if (!check_sdata_in_driver(sdata))
 		return;
 
-- 
2.41.0

