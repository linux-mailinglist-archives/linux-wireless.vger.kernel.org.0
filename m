Return-Path: <linux-wireless+bounces-13109-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47600984226
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Sep 2024 11:31:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F8A4B29128
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Sep 2024 09:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9684F15B11E;
	Tue, 24 Sep 2024 09:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J8JnqmbK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CEC017966F
	for <linux-wireless@vger.kernel.org>; Tue, 24 Sep 2024 09:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727169921; cv=none; b=FeEEX8Rtpq8thEZTuzSj0woMK/qIJO8Ac3Vo8X9aQZO3vc8NFJkJ2x0QW8DkbQMlWbC8a4qveAJghK7usOVAYyj6/oHLRGxlCZrgi5QowhPVFVzPRePgOJsJPMGQ/UzVsXHh0DRxyO79X4r52PKgJnzACS1RXIb78SheMOE7cyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727169921; c=relaxed/simple;
	bh=rBIFkpFkpAed8RuZ+ISqmRznkY8/YaxIxKaAUg4djbE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Fa5hfNktOmwbLoP9XZEY7OBcSjzhOf9K+xncgFF4K1wQ66YsWVBIgmOcyTMy945YhL4XnbyPdWDq6DrrvJvbWXhwhWDZCM3IQZjNv9qGNrL/E+irBi8BEut63zcG2RITFW9aRbOTQ83XIT8fUr0fz1vbaKwQSGMMjyKLmXy2V8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J8JnqmbK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 449B9C4CEC7;
	Tue, 24 Sep 2024 09:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727169921;
	bh=rBIFkpFkpAed8RuZ+ISqmRznkY8/YaxIxKaAUg4djbE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J8JnqmbKrqnwbUJW6ZznTCMlr+t+NXDAhY6bm4m6oDWHJhHCkeIqfIQZcrNonVJKq
	 ooLLCINBVvVLMf2YeXgCSn3SbysRv0lvm0v9fJ9cu6eLtAou0mxOMuboEKWiV/nEZX
	 uw1iycSwyQ8vs7eg64N7mP+CSUSp6Br6SpqR0s+X79gBCovIneonzHJxS2PziJB+73
	 WeLUl/J8OMWbNslx6pa8QdCoVO4lD9MGSrLLSM3HnU0n78bGYEp3jDAXc42CLZV8IF
	 P0tGT2b0SWOTpVwlU8InqIqeaZH5a/uRtEyVi3vyIxQQIZWGG+M7UiNxBE0WUA5KHo
	 ibReY3bclJHyA==
From: Kalle Valo <kvalo@kernel.org>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH RFC v3 3/6] wifi: ath12k: switch to using wiphy_lock() and remove ar->conf_mutex
Date: Tue, 24 Sep 2024 12:25:12 +0300
Message-Id: <20240924092515.1049885-4-kvalo@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20240924092515.1049885-1-kvalo@kernel.org>
References: <20240924092515.1049885-1-kvalo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kalle Valo <quic_kvalo@quicinc.com>

Switch from using driver specific ar->conf_mutex to wiphy->mtx. The benefits are:

* one lock less and simplified locking

* possibility to use wiphy_work_queue() without other locks

Most of the mac80211 ops are called within wiphy_lock(), most notable exception
being tx op. This can be checked with lockdep_assert_wiphy() from
net/mac80211/driver-ops.[ch] and I veried that by manually going through all
the ops in ath12k_ops which had lockdep_assert_wiphy().

The conversion was simple:

* All conf_mutex lock() and unlock() calls which
  already were called under wiphy_lock() I replaced with
  lockdep_assert_wiphy().

* The rest of conf_mutex calls I replaced with wiphy_lock() and wiphy_unlock().

* All lockdep_asset_held(conf_mutex) calls I replaced with
  lockdep_assert_wiphy().

One exception was in ath12k_core_post_reconfigure_recovery() where the wiphy
lock needs to be taken before hw_mutex to avoid a lockdep warning.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.c        |   7 +-
 drivers/net/wireless/ath/ath12k/core.h        |   5 +-
 drivers/net/wireless/ath/ath12k/debugfs.c     |   4 +-
 .../wireless/ath/ath12k/debugfs_htt_stats.c   |  26 +-
 drivers/net/wireless/ath/ath12k/mac.c         | 277 +++++++-----------
 drivers/net/wireless/ath/ath12k/peer.c        |   6 +-
 drivers/net/wireless/ath/ath12k/wow.c         |  26 +-
 7 files changed, 143 insertions(+), 208 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index 51252e8bc1ae..9cd485ed42ab 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -1004,7 +1004,7 @@ void ath12k_core_halt(struct ath12k *ar)
 {
 	struct ath12k_base *ab = ar->ab;
 
-	lockdep_assert_held(&ar->conf_mutex);
+	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
 
 	ar->num_created_vdevs = 0;
 	ar->allocated_vdev_map = 0;
@@ -1078,6 +1078,7 @@ static void ath12k_core_post_reconfigure_recovery(struct ath12k_base *ab)
 		if (!ah || ah->state == ATH12K_HW_STATE_OFF)
 			continue;
 
+		wiphy_lock(ah->hw->wiphy);
 		mutex_lock(&ah->hw_mutex);
 
 		switch (ah->state) {
@@ -1086,10 +1087,7 @@ static void ath12k_core_post_reconfigure_recovery(struct ath12k_base *ab)
 
 			for (j = 0; j < ah->num_radio; j++) {
 				ar = &ah->radio[j];
-
-				mutex_lock(&ar->conf_mutex);
 				ath12k_core_halt(ar);
-				mutex_unlock(&ar->conf_mutex);
 			}
 
 			break;
@@ -1110,6 +1108,7 @@ static void ath12k_core_post_reconfigure_recovery(struct ath12k_base *ab)
 		}
 
 		mutex_unlock(&ah->hw_mutex);
+		wiphy_unlock(ah->hw->wiphy);
 	}
 
 	complete(&ab->driver_recovery);
diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 5163b5b07376..ebfc1e370acc 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -562,10 +562,7 @@ struct ath12k {
 	u32 num_stations;
 	u32 max_num_stations;
 	bool monitor_present;
-	/* To synchronize concurrent synchronous mac80211 callback operations,
-	 * concurrent debugfs configuration and concurrent FW statistics events.
-	 */
-	struct mutex conf_mutex;
+
 	/* protects the radio specific data like debug stats, ppdu_stats_info stats,
 	 * vdev_stop_status info, scan data, ath12k_sta info, ath12k_vif info,
 	 * channel context data, survey info, test mode data.
diff --git a/drivers/net/wireless/ath/ath12k/debugfs.c b/drivers/net/wireless/ath/ath12k/debugfs.c
index 2a977c36af00..d4b32d1a431c 100644
--- a/drivers/net/wireless/ath/ath12k/debugfs.c
+++ b/drivers/net/wireless/ath/ath12k/debugfs.c
@@ -15,14 +15,14 @@ static ssize_t ath12k_write_simulate_radar(struct file *file,
 	struct ath12k *ar = file->private_data;
 	int ret;
 
-	mutex_lock(&ar->conf_mutex);
+	wiphy_lock(ath12k_ar_to_hw(ar)->wiphy);
 	ret = ath12k_wmi_simulate_radar(ar);
 	if (ret)
 		goto exit;
 
 	ret = count;
 exit:
-	mutex_unlock(&ar->conf_mutex);
+	wiphy_unlock(ath12k_ar_to_hw(ar)->wiphy);
 	return ret;
 }
 
diff --git a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
index f1b7e74aefe4..bbdef525c17e 100644
--- a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
+++ b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
@@ -1627,9 +1627,9 @@ static ssize_t ath12k_read_htt_stats_type(struct file *file,
 	char buf[32];
 	size_t len;
 
-	mutex_lock(&ar->conf_mutex);
+	wiphy_lock(ath12k_ar_to_hw(ar)->wiphy);
 	type = ar->debug.htt_stats.type;
-	mutex_unlock(&ar->conf_mutex);
+	wiphy_unlock(ath12k_ar_to_hw(ar)->wiphy);
 
 	len = scnprintf(buf, sizeof(buf), "%u\n", type);
 
@@ -1662,7 +1662,7 @@ static ssize_t ath12k_write_htt_stats_type(struct file *file,
 	    type >= ATH12K_DBG_HTT_NUM_EXT_STATS)
 		return -EINVAL;
 
-	mutex_lock(&ar->conf_mutex);
+	wiphy_lock(ath12k_ar_to_hw(ar)->wiphy);
 
 	ar->debug.htt_stats.type = type;
 	ar->debug.htt_stats.cfg_param[0] = cfg_param[0];
@@ -1670,7 +1670,7 @@ static ssize_t ath12k_write_htt_stats_type(struct file *file,
 	ar->debug.htt_stats.cfg_param[2] = cfg_param[2];
 	ar->debug.htt_stats.cfg_param[3] = cfg_param[3];
 
-	mutex_unlock(&ar->conf_mutex);
+	wiphy_unlock(ath12k_ar_to_hw(ar)->wiphy);
 
 	return count;
 }
@@ -1691,7 +1691,7 @@ static int ath12k_debugfs_htt_stats_req(struct ath12k *ar)
 	int ret, pdev_id;
 	struct htt_ext_stats_cfg_params cfg_params = { 0 };
 
-	lockdep_assert_held(&ar->conf_mutex);
+	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
 
 	init_completion(&stats_req->htt_stats_rcvd);
 
@@ -1741,7 +1741,7 @@ static int ath12k_open_htt_stats(struct inode *inode,
 	if (type == ATH12K_DBG_HTT_EXT_STATS_RESET)
 		return -EPERM;
 
-	mutex_lock(&ar->conf_mutex);
+	wiphy_lock(ath12k_ar_to_hw(ar)->wiphy);
 
 	if (ah->state != ATH12K_HW_STATE_ON) {
 		ret = -ENETDOWN;
@@ -1776,14 +1776,14 @@ static int ath12k_open_htt_stats(struct inode *inode,
 
 	file->private_data = stats_req;
 
-	mutex_unlock(&ar->conf_mutex);
+	wiphy_unlock(ath12k_ar_to_hw(ar)->wiphy);
 
 	return 0;
 out:
 	kfree(stats_req);
 	ar->debug.htt_stats.stats_req = NULL;
 err_unlock:
-	mutex_unlock(&ar->conf_mutex);
+	wiphy_unlock(ath12k_ar_to_hw(ar)->wiphy);
 
 	return ret;
 }
@@ -1793,10 +1793,10 @@ static int ath12k_release_htt_stats(struct inode *inode,
 {
 	struct ath12k *ar = inode->i_private;
 
-	mutex_lock(&ar->conf_mutex);
+	wiphy_lock(ath12k_ar_to_hw(ar)->wiphy);
 	kfree(file->private_data);
 	ar->debug.htt_stats.stats_req = NULL;
-	mutex_unlock(&ar->conf_mutex);
+	wiphy_unlock(ath12k_ar_to_hw(ar)->wiphy);
 
 	return 0;
 }
@@ -1840,7 +1840,7 @@ static ssize_t ath12k_write_htt_stats_reset(struct file *file,
 	    type == ATH12K_DBG_HTT_EXT_STATS_RESET)
 		return -E2BIG;
 
-	mutex_lock(&ar->conf_mutex);
+	wiphy_lock(ath12k_ar_to_hw(ar)->wiphy);
 	cfg_params.cfg0 = HTT_STAT_DEFAULT_RESET_START_OFFSET;
 	param_pos = (type >> 5) + 1;
 
@@ -1866,12 +1866,12 @@ static ssize_t ath12k_write_htt_stats_reset(struct file *file,
 						 0ULL);
 	if (ret) {
 		ath12k_warn(ar->ab, "failed to send htt stats request: %d\n", ret);
-		mutex_unlock(&ar->conf_mutex);
+		wiphy_unlock(ath12k_ar_to_hw(ar)->wiphy);
 		return ret;
 	}
 
 	ar->debug.htt_stats.reset = type;
-	mutex_unlock(&ar->conf_mutex);
+	wiphy_unlock(ath12k_ar_to_hw(ar)->wiphy);
 
 	return count;
 }
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 22c4bbf47f9c..5d27e43929d8 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -677,7 +677,8 @@ static struct ath12k_vif *ath12k_mac_get_vif_up(struct ath12k *ar)
 {
 	struct ath12k_vif *arvif;
 
-	lockdep_assert_held(&ar->conf_mutex);
+	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
+
 	list_for_each_entry(arvif, &ar->arvifs, list) {
 		if (arvif->is_up)
 			return arvif;
@@ -774,7 +775,7 @@ static int ath12k_mac_txpower_recalc(struct ath12k *ar)
 	int ret, txpower = -1;
 	u32 param;
 
-	lockdep_assert_held(&ar->conf_mutex);
+	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
 
 	list_for_each_entry(arvif, &ar->arvifs, list) {
 		if (arvif->txpower <= 0)
@@ -830,7 +831,7 @@ static int ath12k_recalc_rtscts_prot(struct ath12k_vif *arvif)
 	u32 vdev_param, rts_cts;
 	int ret;
 
-	lockdep_assert_held(&ar->conf_mutex);
+	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
 
 	vdev_param = WMI_VDEV_PARAM_ENABLE_RTSCTS;
 
@@ -913,7 +914,7 @@ void ath12k_mac_peer_cleanup_all(struct ath12k *ar)
 	struct ath12k_peer *peer, *tmp;
 	struct ath12k_base *ab = ar->ab;
 
-	lockdep_assert_held(&ar->conf_mutex);
+	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
 
 	spin_lock_bh(&ab->base_lock);
 	list_for_each_entry_safe(peer, tmp, &ab->peers, list) {
@@ -929,7 +930,7 @@ void ath12k_mac_peer_cleanup_all(struct ath12k *ar)
 
 static int ath12k_mac_vdev_setup_sync(struct ath12k *ar)
 {
-	lockdep_assert_held(&ar->conf_mutex);
+	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
 
 	if (test_bit(ATH12K_FLAG_CRASH_FLUSH, &ar->ab->dev_flags))
 		return -ESHUTDOWN;
@@ -971,7 +972,7 @@ static int ath12k_mac_monitor_vdev_start(struct ath12k *ar, int vdev_id,
 	struct ath12k_wmi_vdev_up_params params = {};
 	int ret;
 
-	lockdep_assert_held(&ar->conf_mutex);
+	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
 
 	channel = chandef->chan;
 	arg.vdev_id = vdev_id;
@@ -1034,7 +1035,7 @@ static int ath12k_mac_monitor_vdev_stop(struct ath12k *ar)
 {
 	int ret;
 
-	lockdep_assert_held(&ar->conf_mutex);
+	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
 
 	reinit_completion(&ar->vdev_setup_done);
 
@@ -1066,7 +1067,7 @@ static int ath12k_mac_monitor_vdev_create(struct ath12k *ar)
 	u8 tmp_addr[6];
 	u16 nss;
 
-	lockdep_assert_held(&ar->conf_mutex);
+	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
 
 	if (ar->monitor_vdev_created)
 		return 0;
@@ -1132,7 +1133,7 @@ static int ath12k_mac_monitor_vdev_delete(struct ath12k *ar)
 	int ret;
 	unsigned long time_left;
 
-	lockdep_assert_held(&ar->conf_mutex);
+	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
 
 	if (!ar->monitor_vdev_created)
 		return 0;
@@ -1178,7 +1179,7 @@ static int ath12k_mac_monitor_start(struct ath12k *ar)
 	struct cfg80211_chan_def *chandef = NULL;
 	int ret;
 
-	lockdep_assert_held(&ar->conf_mutex);
+	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
 
 	if (ar->monitor_started)
 		return 0;
@@ -1208,7 +1209,7 @@ static int ath12k_mac_monitor_stop(struct ath12k *ar)
 {
 	int ret;
 
-	lockdep_assert_held(&ar->conf_mutex);
+	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
 
 	if (!ar->monitor_started)
 		return 0;
@@ -1231,7 +1232,7 @@ static int ath12k_mac_vdev_stop(struct ath12k_vif *arvif)
 	struct ath12k *ar = arvif->ar;
 	int ret;
 
-	lockdep_assert_held(&ar->conf_mutex);
+	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
 
 	reinit_completion(&ar->vdev_setup_done);
 
@@ -1272,7 +1273,7 @@ static int ath12k_mac_config(struct ath12k *ar, u32 changed)
 	struct ieee80211_conf *conf = &hw->conf;
 	int ret = 0;
 
-	mutex_lock(&ar->conf_mutex);
+	lockdep_assert_wiphy(hw->wiphy);
 
 	if (changed & IEEE80211_CONF_CHANGE_MONITOR) {
 		ar->monitor_conf_enabled = conf->flags & IEEE80211_CONF_MONITOR;
@@ -1296,12 +1297,10 @@ static int ath12k_mac_config(struct ath12k *ar, u32 changed)
 	}
 
 exit:
-	mutex_unlock(&ar->conf_mutex);
 	return ret;
 
 err_mon_del:
 	ath12k_mac_monitor_vdev_delete(ar);
-	mutex_unlock(&ar->conf_mutex);
 	return ret;
 }
 
@@ -1602,7 +1601,7 @@ static void ath12k_control_beaconing(struct ath12k_vif *arvif,
 	struct ath12k *ar = arvif->ar;
 	int ret;
 
-	lockdep_assert_held(&arvif->ar->conf_mutex);
+	lockdep_assert_wiphy(ath12k_ar_to_hw(arvif->ar)->wiphy);
 
 	if (!info->enable_beacon) {
 		ret = ath12k_wmi_vdev_down(ar, arvif->vdev_id);
@@ -1724,7 +1723,7 @@ static void ath12k_peer_assoc_h_basic(struct ath12k *ar,
 	struct ieee80211_hw *hw = ath12k_ar_to_hw(ar);
 	u32 aid;
 
-	lockdep_assert_held(&ar->conf_mutex);
+	lockdep_assert_wiphy(hw->wiphy);
 
 	if (vif->type == NL80211_IFTYPE_STATION)
 		aid = vif->cfg.aid;
@@ -1754,7 +1753,7 @@ static void ath12k_peer_assoc_h_crypto(struct ath12k *ar,
 	const u8 *rsnie = NULL;
 	const u8 *wpaie = NULL;
 
-	lockdep_assert_held(&ar->conf_mutex);
+	lockdep_assert_wiphy(hw->wiphy);
 
 	if (WARN_ON(ath12k_mac_vif_chan(vif, &def)))
 		return;
@@ -1819,7 +1818,7 @@ static void ath12k_peer_assoc_h_rates(struct ath12k *ar,
 	u8 rate;
 	int i;
 
-	lockdep_assert_held(&ar->conf_mutex);
+	lockdep_assert_wiphy(hw->wiphy);
 
 	if (WARN_ON(ath12k_mac_vif_chan(vif, &def)))
 		return;
@@ -1880,7 +1879,7 @@ static void ath12k_peer_assoc_h_ht(struct ath12k *ar,
 	u8 max_nss;
 	u32 stbc;
 
-	lockdep_assert_held(&ar->conf_mutex);
+	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
 
 	if (WARN_ON(ath12k_mac_vif_chan(vif, &def)))
 		return;
@@ -2420,7 +2419,7 @@ static int ath12k_peer_assoc_qos_ap(struct ath12k *ar,
 	u32 uapsd;
 	int ret;
 
-	lockdep_assert_held(&ar->conf_mutex);
+	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
 
 	arg.vdev_id = arvif->vdev_id;
 
@@ -2807,7 +2806,7 @@ static void ath12k_peer_assoc_prepare(struct ath12k *ar,
 				      struct ath12k_wmi_peer_assoc_arg *arg,
 				      bool reassoc)
 {
-	lockdep_assert_held(&ar->conf_mutex);
+	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
 
 	memset(arg, 0, sizeof(*arg));
 
@@ -2860,7 +2859,7 @@ static void ath12k_bss_assoc(struct ath12k *ar,
 	bool is_auth = false;
 	int ret;
 
-	lockdep_assert_held(&ar->conf_mutex);
+	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
 
 	ath12k_dbg(ar->ab, ATH12K_DBG_MAC, "mac vdev %i assoc bssid %pM aid %d\n",
 		   arvif->vdev_id, arvif->bssid, arvif->aid);
@@ -2953,7 +2952,7 @@ static void ath12k_bss_disassoc(struct ath12k *ar,
 {
 	int ret;
 
-	lockdep_assert_held(&ar->conf_mutex);
+	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
 
 	ath12k_dbg(ar->ab, ATH12K_DBG_MAC, "mac vdev %i disassoc bssid %pM\n",
 		   arvif->vdev_id, arvif->bssid);
@@ -3008,7 +3007,7 @@ static void ath12k_recalculate_mgmt_rate(struct ath12k *ar,
 	u16 bitrate;
 	int ret;
 
-	lockdep_assert_held(&ar->conf_mutex);
+	lockdep_assert_wiphy(hw->wiphy);
 
 	sband = hw->wiphy->bands[def->chan->band];
 	basic_rate_idx = ffs(vif->bss_conf.basic_rates) - 1;
@@ -3091,7 +3090,7 @@ static void ath12k_mac_vif_setup_ps(struct ath12k_vif *arvif)
 	int timeout;
 	bool enable_ps;
 
-	lockdep_assert_held(&ar->conf_mutex);
+	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
 
 	if (vif->type != NL80211_IFTYPE_STATION)
 		return;
@@ -3146,7 +3145,7 @@ static void ath12k_mac_bss_info_changed(struct ath12k *ar,
 	u8 rateidx;
 	u32 rate;
 
-	lockdep_assert_held(&ar->conf_mutex);
+	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
 
 	if (changed & BSS_CHANGED_BEACON_INT) {
 		arvif->beacon_interval = info->beacon_int;
@@ -3448,11 +3447,9 @@ static void ath12k_mac_op_bss_info_changed(struct ieee80211_hw *hw,
 		return;
 	}
 
-	mutex_lock(&ar->conf_mutex);
+	lockdep_assert_wiphy(hw->wiphy);
 
 	ath12k_mac_bss_info_changed(ar, arvif, info, changed);
-
-	mutex_unlock(&ar->conf_mutex);
 }
 
 static struct ath12k*
@@ -3541,7 +3538,7 @@ static int ath12k_scan_stop(struct ath12k *ar)
 	};
 	int ret;
 
-	lockdep_assert_held(&ar->conf_mutex);
+	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
 
 	/* TODO: Fill other STOP Params */
 	arg.pdev_id = ar->pdev->pdev_id;
@@ -3581,7 +3578,7 @@ static void ath12k_scan_abort(struct ath12k *ar)
 {
 	int ret;
 
-	lockdep_assert_held(&ar->conf_mutex);
+	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
 
 	spin_lock_bh(&ar->data_lock);
 
@@ -3616,9 +3613,9 @@ static void ath12k_scan_timeout_work(struct work_struct *work)
 	struct ath12k *ar = container_of(work, struct ath12k,
 					 scan.timeout.work);
 
-	mutex_lock(&ar->conf_mutex);
+	wiphy_lock(ath12k_ar_to_hw(ar)->wiphy);
 	ath12k_scan_abort(ar);
-	mutex_unlock(&ar->conf_mutex);
+	wiphy_unlock(ath12k_ar_to_hw(ar)->wiphy);
 }
 
 static int ath12k_start_scan(struct ath12k *ar,
@@ -3626,7 +3623,7 @@ static int ath12k_start_scan(struct ath12k *ar,
 {
 	int ret;
 
-	lockdep_assert_held(&ar->conf_mutex);
+	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
 
 	ret = ath12k_wmi_send_scan_start_cmd(ar, arg);
 	if (ret)
@@ -3668,6 +3665,8 @@ static int ath12k_mac_op_hw_scan(struct ieee80211_hw *hw,
 	int i;
 	bool create = true;
 
+	lockdep_assert_wiphy(hw->wiphy);
+
 	if (ah->num_radio == 1) {
 		WARN_ON(!arvif->is_created);
 		ar = ath12k_ah_to_ar(ah, 0);
@@ -3702,9 +3701,7 @@ static int ath12k_mac_op_hw_scan(struct ieee80211_hw *hw,
 			 * would assign the arvif->ar to NULL after the call
 			 */
 			prev_ar = arvif->ar;
-			mutex_lock(&prev_ar->conf_mutex);
 			ret = ath12k_mac_vdev_delete(prev_ar, vif);
-			mutex_unlock(&prev_ar->conf_mutex);
 			if (ret)
 				ath12k_warn(prev_ar->ab,
 					    "unable to delete scan vdev %d\n", ret);
@@ -3713,17 +3710,13 @@ static int ath12k_mac_op_hw_scan(struct ieee80211_hw *hw,
 		}
 	}
 	if (create) {
-		mutex_lock(&ar->conf_mutex);
 		ret = ath12k_mac_vdev_create(ar, vif);
-		mutex_unlock(&ar->conf_mutex);
 		if (ret) {
 			ath12k_warn(ar->ab, "unable to create scan vdev %d\n", ret);
 			return -EINVAL;
 		}
 	}
 scan:
-	mutex_lock(&ar->conf_mutex);
-
 	spin_lock_bh(&ar->data_lock);
 	switch (ar->scan.state) {
 	case ATH12K_SCAN_IDLE:
@@ -3805,8 +3798,6 @@ static int ath12k_mac_op_hw_scan(struct ieee80211_hw *hw,
 		kfree(arg);
 	}
 
-	mutex_unlock(&ar->conf_mutex);
-
 	return ret;
 }
 
@@ -3821,9 +3812,9 @@ static void ath12k_mac_op_cancel_hw_scan(struct ieee80211_hw *hw,
 
 	ar = arvif->ar;
 
-	mutex_lock(&ar->conf_mutex);
+	lockdep_assert_wiphy(hw->wiphy);
+
 	ath12k_scan_abort(ar);
-	mutex_unlock(&ar->conf_mutex);
 
 	cancel_delayed_work_sync(&ar->scan.timeout);
 }
@@ -3844,7 +3835,7 @@ static int ath12k_install_key(struct ath12k_vif *arvif,
 		.macaddr = macaddr,
 	};
 
-	lockdep_assert_held(&arvif->ar->conf_mutex);
+	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
 
 	reinit_completion(&ar->install_key_done);
 
@@ -3912,7 +3903,7 @@ static int ath12k_clear_peer_keys(struct ath12k_vif *arvif,
 	int i;
 	u32 flags = 0;
 
-	lockdep_assert_held(&ar->conf_mutex);
+	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
 
 	spin_lock_bh(&ab->base_lock);
 	peer = ath12k_peer_find(ab, arvif->vdev_id, addr);
@@ -3955,7 +3946,7 @@ static int ath12k_mac_set_key(struct ath12k *ar, enum set_key_cmd cmd,
 	int ret = 0;
 	u32 flags = 0;
 
-	lockdep_assert_held(&ar->conf_mutex);
+	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
 
 	if (test_bit(ATH12K_FLAG_HW_CRYPTO_DISABLED, &ab->dev_flags))
 		return 1;
@@ -3970,7 +3961,7 @@ static int ath12k_mac_set_key(struct ath12k *ar, enum set_key_cmd cmd,
 	key->hw_key_idx = key->keyidx;
 
 	/* the peer should not disappear in mid-way (unless FW goes awry) since
-	 * we already hold conf_mutex. we just make sure its there now.
+	 * we already hold wiphy lock. we just make sure its there now.
 	 */
 	spin_lock_bh(&ab->base_lock);
 	peer = ath12k_peer_find(ab, arvif->vdev_id, peer_addr);
@@ -4063,6 +4054,8 @@ static int ath12k_mac_op_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 	struct ath12k *ar;
 	int ret;
 
+	lockdep_assert_wiphy(hw->wiphy);
+
 	/* BIP needs to be done in software */
 	if (key->cipher == WLAN_CIPHER_SUITE_AES_CMAC ||
 	    key->cipher == WLAN_CIPHER_SUITE_BIP_GMAC_128 ||
@@ -4090,9 +4083,7 @@ static int ath12k_mac_op_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 		return 0;
 	}
 
-	mutex_lock(&ar->conf_mutex);
 	ret = ath12k_mac_set_key(ar, cmd, vif, sta, key);
-	mutex_unlock(&ar->conf_mutex);
 	return ret;
 }
 
@@ -4121,7 +4112,7 @@ ath12k_mac_set_peer_vht_fixed_rate(struct ath12k_vif *arvif,
 	u32 rate_code;
 	int ret, i;
 
-	lockdep_assert_held(&ar->conf_mutex);
+	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
 
 	nss = 0;
 
@@ -4169,7 +4160,7 @@ static int ath12k_station_assoc(struct ath12k *ar,
 	struct cfg80211_bitrate_mask *mask;
 	u8 num_vht_rates;
 
-	lockdep_assert_held(&ar->conf_mutex);
+	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
 
 	if (WARN_ON(ath12k_mac_vif_chan(vif, &def)))
 		return -EPERM;
@@ -4252,7 +4243,7 @@ static int ath12k_station_disassoc(struct ath12k *ar,
 	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
 	int ret;
 
-	lockdep_assert_held(&ar->conf_mutex);
+	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
 
 	if (!sta->wme) {
 		arvif->num_legacy_stations--;
@@ -4312,8 +4303,6 @@ static void ath12k_sta_rc_update_wk(struct wiphy *wiphy, struct wiphy_work *wk)
 
 	spin_unlock_bh(&ar->data_lock);
 
-	mutex_lock(&ar->conf_mutex);
-
 	nss = max_t(u32, 1, nss);
 	nss = min(nss, max(ath12k_mac_max_ht_nss(ht_mcs_mask),
 			   ath12k_mac_max_vht_nss(vht_mcs_mask)));
@@ -4336,7 +4325,7 @@ static void ath12k_sta_rc_update_wk(struct wiphy *wiphy, struct wiphy_work *wk)
 			if (err) {
 				ath12k_warn(ar->ab, "failed to update STA %pM to peer phymode %d: %d\n",
 					    sta->addr, peer_phymode, err);
-				goto err_rc_bw_changed;
+				return;
 			}
 			err = ath12k_wmi_set_peer_param(ar, sta->addr,
 							arvif->vdev_id, WMI_PEER_CHWIDTH,
@@ -4357,7 +4346,7 @@ static void ath12k_sta_rc_update_wk(struct wiphy *wiphy, struct wiphy_work *wk)
 			if (err) {
 				ath12k_warn(ar->ab, "failed to update STA %pM peer to bandwidth %d: %d\n",
 					    sta->addr, bw, err);
-				goto err_rc_bw_changed;
+				return;
 			}
 			err = ath12k_wmi_set_peer_param(ar, sta->addr,
 							arvif->vdev_id, WMI_PEER_PHYMODE,
@@ -4427,8 +4416,6 @@ static void ath12k_sta_rc_update_wk(struct wiphy *wiphy, struct wiphy_work *wk)
 					    sta->addr, arvif->vdev_id);
 		}
 	}
-err_rc_bw_changed:
-	mutex_unlock(&ar->conf_mutex);
 }
 
 static int ath12k_mac_inc_num_stations(struct ath12k_vif *arvif,
@@ -4436,7 +4423,7 @@ static int ath12k_mac_inc_num_stations(struct ath12k_vif *arvif,
 {
 	struct ath12k *ar = arvif->ar;
 
-	lockdep_assert_held(&ar->conf_mutex);
+	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
 
 	if (arvif->vdev_type == WMI_VDEV_TYPE_STA && !sta->tdls)
 		return 0;
@@ -4454,7 +4441,7 @@ static void ath12k_mac_dec_num_stations(struct ath12k_vif *arvif,
 {
 	struct ath12k *ar = arvif->ar;
 
-	lockdep_assert_held(&ar->conf_mutex);
+	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
 
 	if (arvif->vdev_type == WMI_VDEV_TYPE_STA && !sta->tdls)
 		return;
@@ -4472,7 +4459,7 @@ static int ath12k_mac_station_add(struct ath12k *ar,
 	struct ath12k_wmi_peer_create_arg peer_param;
 	int ret;
 
-	lockdep_assert_held(&ar->conf_mutex);
+	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
 
 	ret = ath12k_mac_inc_num_stations(arvif, sta);
 	if (ret) {
@@ -4593,7 +4580,7 @@ static int ath12k_mac_op_sta_state(struct ieee80211_hw *hw,
 		return -EINVAL;
 	}
 
-	mutex_lock(&ar->conf_mutex);
+	lockdep_assert_wiphy(hw->wiphy);
 
 	if (old_state == IEEE80211_STA_NOTEXIST &&
 	    new_state == IEEE80211_STA_NONE) {
@@ -4694,8 +4681,6 @@ static int ath12k_mac_op_sta_state(struct ieee80211_hw *hw,
 				    sta->addr);
 	}
 
-	mutex_unlock(&ar->conf_mutex);
-
 	return ret;
 }
 
@@ -4722,7 +4707,7 @@ static int ath12k_mac_op_sta_set_txpwr(struct ieee80211_hw *hw,
 
 	ar = ath12k_ah_to_ar(ah, 0);
 
-	mutex_lock(&ar->conf_mutex);
+	lockdep_assert_wiphy(hw->wiphy);
 
 	ret = ath12k_wmi_set_peer_param(ar, sta->addr, arvif->vdev_id,
 					WMI_PEER_USE_FIXED_PWR, txpwr);
@@ -4733,7 +4718,6 @@ static int ath12k_mac_op_sta_set_txpwr(struct ieee80211_hw *hw,
 	}
 
 out:
-	mutex_unlock(&ar->conf_mutex);
 	return ret;
 }
 
@@ -4879,7 +4863,7 @@ static int ath12k_mac_conf_tx(struct ath12k_vif *arvif,
 	struct ath12k_base *ab = ar->ab;
 	int ret;
 
-	lockdep_assert_held(&ar->conf_mutex);
+	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
 
 	switch (ac) {
 	case IEEE80211_AC_VO:
@@ -4933,6 +4917,8 @@ static int ath12k_mac_op_conf_tx(struct ieee80211_hw *hw,
 	struct ath12k_vif_cache *cache = arvif->cache;
 	int ret;
 
+	lockdep_assert_wiphy(hw->wiphy);
+
 	ar = ath12k_get_ar_by_vif(hw, vif);
 	if (!ar) {
 		/* cache the info and apply after vdev is created */
@@ -4945,9 +4931,7 @@ static int ath12k_mac_op_conf_tx(struct ieee80211_hw *hw,
 		return 0;
 	}
 
-	mutex_lock(&ar->conf_mutex);
 	ret = ath12k_mac_conf_tx(arvif, link_id, ac, params);
-	mutex_unlock(&ar->conf_mutex);
 
 	return ret;
 }
@@ -5614,7 +5598,7 @@ static int __ath12k_set_antenna(struct ath12k *ar, u32 tx_ant, u32 rx_ant)
 	struct ath12k_hw *ah = ath12k_ar_to_ah(ar);
 	int ret;
 
-	lockdep_assert_held(&ar->conf_mutex);
+	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
 
 	if (ath12k_check_chain_mask(ar, tx_ant, true))
 		return -EINVAL;
@@ -5941,8 +5925,7 @@ static int ath12k_mac_start(struct ath12k *ar)
 	int ret;
 
 	lockdep_assert_held(&ah->hw_mutex);
-
-	mutex_lock(&ar->conf_mutex);
+	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
 
 	ret = ath12k_wmi_pdev_set_param(ar, WMI_PDEV_PARAM_PMF_QOS,
 					1, pdev->pdev_id);
@@ -6027,14 +6010,11 @@ static int ath12k_mac_start(struct ath12k *ar)
 		}
 	}
 
-	mutex_unlock(&ar->conf_mutex);
-
 	rcu_assign_pointer(ab->pdevs_active[ar->pdev_idx],
 			   &ab->pdevs[ar->pdev_idx]);
 
 	return 0;
 err:
-	mutex_unlock(&ar->conf_mutex);
 
 	return ret;
 }
@@ -6160,15 +6140,14 @@ static void ath12k_mac_stop(struct ath12k *ar)
 	int ret;
 
 	lockdep_assert_held(&ah->hw_mutex);
+	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
 
-	mutex_lock(&ar->conf_mutex);
 	ret = ath12k_mac_config_mon_status_default(ar, false);
 	if (ret && (ret != -EOPNOTSUPP))
 		ath12k_err(ar->ab, "failed to clear rx_filter for monitor status ring: (%d)\n",
 			   ret);
 
 	clear_bit(ATH12K_CAC_RUNNING, &ar->dev_flags);
-	mutex_unlock(&ar->conf_mutex);
 
 	cancel_delayed_work_sync(&ar->scan.timeout);
 	cancel_work_sync(&ar->regd_update_work);
@@ -6432,7 +6411,8 @@ static int ath12k_mac_vdev_create(struct ath12k *ar, struct ieee80211_vif *vif)
 	int i;
 	int ret, vdev_id;
 
-	lockdep_assert_held(&ar->conf_mutex);
+	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
+	lockdep_assert_wiphy(hw->wiphy);
 
 	arvif->ar = ar;
 	vdev_id = __ffs64(ab->free_vdev_map);
@@ -6643,7 +6623,7 @@ static void ath12k_mac_vif_cache_flush(struct ath12k *ar,  struct ieee80211_vif
 
 	int ret;
 
-	lockdep_assert_held(&ar->conf_mutex);
+	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
 
 	if (!cache)
 		return;
@@ -6682,6 +6662,8 @@ static struct ath12k *ath12k_mac_assign_vif_to_vdev(struct ieee80211_hw *hw,
 	struct ath12k_base *ab;
 	int ret;
 
+	lockdep_assert_wiphy(hw->wiphy);
+
 	if (ah->num_radio == 1)
 		ar = ah->radio;
 	else if (ctx)
@@ -6714,20 +6696,15 @@ static struct ath12k *ath12k_mac_assign_vif_to_vdev(struct ieee80211_hw *hw,
 			 * be set to NULL after vdev delete is done
 			 */
 			prev_ar = arvif->ar;
-			mutex_lock(&prev_ar->conf_mutex);
 			ret = ath12k_mac_vdev_delete(prev_ar, vif);
-
 			if (ret)
 				ath12k_warn(prev_ar->ab, "unable to delete vdev %d\n",
 					    ret);
-			mutex_unlock(&prev_ar->conf_mutex);
 		}
 	}
 
 	ab = ar->ab;
 
-	mutex_lock(&ar->conf_mutex);
-
 	if (arvif->is_created)
 		goto flush;
 
@@ -6756,7 +6733,6 @@ static struct ath12k *ath12k_mac_assign_vif_to_vdev(struct ieee80211_hw *hw,
 	 */
 	ath12k_mac_vif_cache_flush(ar, vif);
 unlock:
-	mutex_unlock(&ar->conf_mutex);
 	return arvif->ar;
 }
 
@@ -6766,6 +6742,8 @@ static int ath12k_mac_op_add_interface(struct ieee80211_hw *hw,
 	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
 	int i;
 
+	lockdep_assert_wiphy(hw->wiphy);
+
 	memset(arvif, 0, sizeof(*arvif));
 
 	arvif->vif = vif;
@@ -6830,7 +6808,7 @@ static int ath12k_mac_vdev_delete(struct ath12k *ar, struct ieee80211_vif *vif)
 	unsigned long time_left;
 	int ret;
 
-	lockdep_assert_held(&ar->conf_mutex);
+	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
 	reinit_completion(&ar->vdev_delete_done);
 
 	ret = ath12k_wmi_vdev_delete(ar, arvif->vdev_id);
@@ -6893,6 +6871,8 @@ static void ath12k_mac_op_remove_interface(struct ieee80211_hw *hw,
 	struct ath12k *ar;
 	int ret;
 
+	lockdep_assert_wiphy(hw->wiphy);
+
 	if (!arvif->is_created) {
 		/* if we cached some config but never received assign chanctx,
 		 * free the allocated cache.
@@ -6906,8 +6886,6 @@ static void ath12k_mac_op_remove_interface(struct ieee80211_hw *hw,
 
 	cancel_delayed_work_sync(&arvif->connection_loss_work);
 
-	mutex_lock(&ar->conf_mutex);
-
 	ath12k_dbg(ab, ATH12K_DBG_MAC, "mac remove interface (vdev %d)\n",
 		   arvif->vdev_id);
 
@@ -6919,8 +6897,6 @@ static void ath12k_mac_op_remove_interface(struct ieee80211_hw *hw,
 	}
 
 	ath12k_mac_vdev_delete(ar, vif);
-
-	mutex_unlock(&ar->conf_mutex);
 }
 
 /* FIXME: Has to be verified. */
@@ -6939,7 +6915,7 @@ static void ath12k_mac_configure_filter(struct ath12k *ar,
 	bool reset_flag;
 	int ret;
 
-	lockdep_assert_held(&ar->conf_mutex);
+	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
 
 	ar->filter_flags = total_flags;
 
@@ -6966,12 +6942,10 @@ static void ath12k_mac_op_configure_filter(struct ieee80211_hw *hw,
 
 	ar = ath12k_ah_to_ar(ah, 0);
 
-	mutex_lock(&ar->conf_mutex);
+	lockdep_assert_wiphy(hw->wiphy);
 
 	*total_flags &= SUPPORTED_FILTERS;
 	ath12k_mac_configure_filter(ar, *total_flags);
-
-	mutex_unlock(&ar->conf_mutex);
 }
 
 static int ath12k_mac_op_get_antenna(struct ieee80211_hw *hw, u32 *tx_ant, u32 *rx_ant)
@@ -6981,11 +6955,11 @@ static int ath12k_mac_op_get_antenna(struct ieee80211_hw *hw, u32 *tx_ant, u32 *
 	struct ath12k *ar;
 	int i;
 
+	lockdep_assert_wiphy(hw->wiphy);
+
 	for_each_ar(ah, ar, i) {
-		mutex_lock(&ar->conf_mutex);
 		antennas_rx = max_t(u32, antennas_rx, ar->cfg_rx_chainmask);
 		antennas_tx = max_t(u32, antennas_tx, ar->cfg_tx_chainmask);
-		mutex_unlock(&ar->conf_mutex);
 	}
 
 	*tx_ant = antennas_tx;
@@ -7001,10 +6975,10 @@ static int ath12k_mac_op_set_antenna(struct ieee80211_hw *hw, u32 tx_ant, u32 rx
 	int ret = 0;
 	int i;
 
+	lockdep_assert_wiphy(hw->wiphy);
+
 	for_each_ar(ah, ar, i) {
-		mutex_lock(&ar->conf_mutex);
 		ret = __ath12k_set_antenna(ar, tx_ant, rx_ant);
-		mutex_unlock(&ar->conf_mutex);
 		if (ret)
 			break;
 	}
@@ -7018,7 +6992,7 @@ static int ath12k_mac_ampdu_action(struct ath12k_vif *arvif,
 	struct ath12k *ar = arvif->ar;
 	int ret = -EINVAL;
 
-	lockdep_assert_held(&ar->conf_mutex);
+	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
 
 	switch (params->action) {
 	case IEEE80211_AMPDU_RX_START:
@@ -7057,10 +7031,9 @@ static int ath12k_mac_op_ampdu_action(struct ieee80211_hw *hw,
 
 	ar = ath12k_ah_to_ar(ah, 0);
 
-	mutex_lock(&ar->conf_mutex);
-	ret = ath12k_mac_ampdu_action(arvif, params);
-	mutex_unlock(&ar->conf_mutex);
+	lockdep_assert_wiphy(hw->wiphy);
 
+	ret = ath12k_mac_ampdu_action(arvif, params);
 	if (ret)
 		ath12k_warn(ar->ab, "pdev idx %d unable to perform ampdu action %d ret %d\n",
 			    ar->pdev_idx, params->action, ret);
@@ -7084,7 +7057,7 @@ static int ath12k_mac_op_add_chanctx(struct ieee80211_hw *hw,
 		   "mac chanctx add freq %u width %d ptr %p\n",
 		   ctx->def.chan->center_freq, ctx->def.width, ctx);
 
-	mutex_lock(&ar->conf_mutex);
+	lockdep_assert_wiphy(hw->wiphy);
 
 	spin_lock_bh(&ar->data_lock);
 	/* TODO: In case of multiple channel context, populate rx_channel from
@@ -7093,8 +7066,6 @@ static int ath12k_mac_op_add_chanctx(struct ieee80211_hw *hw,
 	ar->rx_channel = ctx->def.chan;
 	spin_unlock_bh(&ar->data_lock);
 
-	mutex_unlock(&ar->conf_mutex);
-
 	return 0;
 }
 
@@ -7114,7 +7085,7 @@ static void ath12k_mac_op_remove_chanctx(struct ieee80211_hw *hw,
 		   "mac chanctx remove freq %u width %d ptr %p\n",
 		   ctx->def.chan->center_freq, ctx->def.width, ctx);
 
-	mutex_lock(&ar->conf_mutex);
+	lockdep_assert_wiphy(hw->wiphy);
 
 	spin_lock_bh(&ar->data_lock);
 	/* TODO: In case of there is one more channel context left, populate
@@ -7122,8 +7093,6 @@ static void ath12k_mac_op_remove_chanctx(struct ieee80211_hw *hw,
 	 */
 	ar->rx_channel = NULL;
 	spin_unlock_bh(&ar->data_lock);
-
-	mutex_unlock(&ar->conf_mutex);
 }
 
 static enum wmi_phy_mode
@@ -7201,7 +7170,7 @@ ath12k_mac_vdev_start_restart(struct ath12k_vif *arvif,
 	int he_support = arvif->vif->bss_conf.he_support;
 	int ret;
 
-	lockdep_assert_held(&ar->conf_mutex);
+	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
 
 	reinit_completion(&ar->vdev_setup_done);
 
@@ -7437,7 +7406,7 @@ ath12k_mac_update_vif_chan(struct ath12k *ar,
 	int i;
 	bool monitor_vif = false;
 
-	lockdep_assert_held(&ar->conf_mutex);
+	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
 
 	for (i = 0; i < n_vifs; i++) {
 		vif = vifs[i].vif;
@@ -7530,7 +7499,7 @@ ath12k_mac_update_active_vif_chan(struct ath12k *ar,
 	struct ath12k_mac_change_chanctx_arg arg = { .ctx = ctx, .ar = ar };
 	struct ieee80211_hw *hw = ath12k_ar_to_hw(ar);
 
-	lockdep_assert_held(&ar->conf_mutex);
+	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
 
 	ieee80211_iterate_active_interfaces_atomic(hw,
 						   IEEE80211_IFACE_ITER_NORMAL,
@@ -7566,7 +7535,7 @@ static void ath12k_mac_op_change_chanctx(struct ieee80211_hw *hw,
 
 	ab = ar->ab;
 
-	mutex_lock(&ar->conf_mutex);
+	lockdep_assert_wiphy(hw->wiphy);
 
 	ath12k_dbg(ab, ATH12K_DBG_MAC,
 		   "mac chanctx change freq %u width %d ptr %p changed %x\n",
@@ -7576,7 +7545,7 @@ static void ath12k_mac_op_change_chanctx(struct ieee80211_hw *hw,
 	 * switch_vif_chanctx().
 	 */
 	if (WARN_ON(changed & IEEE80211_CHANCTX_CHANGE_CHANNEL))
-		goto unlock;
+		return;
 
 	if (changed & IEEE80211_CHANCTX_CHANGE_WIDTH ||
 	    changed & IEEE80211_CHANCTX_CHANGE_RADAR ||
@@ -7584,9 +7553,6 @@ static void ath12k_mac_op_change_chanctx(struct ieee80211_hw *hw,
 		ath12k_mac_update_active_vif_chan(ar, ctx);
 
 	/* TODO: Recalc radar detection */
-
-unlock:
-	mutex_unlock(&ar->conf_mutex);
 }
 
 static int ath12k_start_vdev_delay(struct ath12k *ar,
@@ -7632,6 +7598,8 @@ ath12k_mac_op_assign_vif_chanctx(struct ieee80211_hw *hw,
 	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
 	int ret;
 
+	lockdep_assert_wiphy(hw->wiphy);
+
 	/* For multi radio wiphy, the vdev was not created during add_interface
 	 * create now since we have a channel ctx now to assign to a specific ar/fw
 	 */
@@ -7643,7 +7611,7 @@ ath12k_mac_op_assign_vif_chanctx(struct ieee80211_hw *hw,
 
 	ab = ar->ab;
 
-	mutex_lock(&ar->conf_mutex);
+	lockdep_assert_wiphy(hw->wiphy);
 
 	ath12k_dbg(ab, ATH12K_DBG_MAC,
 		   "mac chanctx assign ptr %p vdev_id %i\n",
@@ -7690,8 +7658,6 @@ ath12k_mac_op_assign_vif_chanctx(struct ieee80211_hw *hw,
 	/* TODO: Setup ps and cts/rts protection */
 
 out:
-	mutex_unlock(&ar->conf_mutex);
-
 	return ret;
 }
 
@@ -7719,7 +7685,7 @@ ath12k_mac_op_unassign_vif_chanctx(struct ieee80211_hw *hw,
 	ar = arvif->ar;
 	ab = ar->ab;
 
-	mutex_lock(&ar->conf_mutex);
+	lockdep_assert_wiphy(hw->wiphy);
 
 	ath12k_dbg(ab, ATH12K_DBG_MAC,
 		   "mac chanctx unassign ptr %p vdev_id %i\n",
@@ -7729,10 +7695,8 @@ ath12k_mac_op_unassign_vif_chanctx(struct ieee80211_hw *hw,
 
 	if (arvif->vdev_type == WMI_VDEV_TYPE_MONITOR) {
 		ret = ath12k_mac_monitor_stop(ar);
-		if (ret) {
-			mutex_unlock(&ar->conf_mutex);
+		if (ret)
 			return;
-		}
 
 		arvif->is_started = false;
 	}
@@ -7750,8 +7714,6 @@ ath12k_mac_op_unassign_vif_chanctx(struct ieee80211_hw *hw,
 	if (arvif->vdev_type != WMI_VDEV_TYPE_MONITOR &&
 	    ar->num_started_vdevs == 1 && ar->monitor_vdev_created)
 		ath12k_mac_monitor_stop(ar);
-
-	mutex_unlock(&ar->conf_mutex);
 }
 
 static int
@@ -7766,21 +7728,17 @@ ath12k_mac_op_switch_vif_chanctx(struct ieee80211_hw *hw,
 	if (!ar)
 		return -EINVAL;
 
-	mutex_lock(&ar->conf_mutex);
+	lockdep_assert_wiphy(hw->wiphy);
 
 	/* Switching channels across radio is not allowed */
-	if (ar != ath12k_get_ar_by_ctx(hw, vifs->new_ctx)) {
-		mutex_unlock(&ar->conf_mutex);
+	if (ar != ath12k_get_ar_by_ctx(hw, vifs->new_ctx))
 		return -EINVAL;
-	}
 
 	ath12k_dbg(ar->ab, ATH12K_DBG_MAC,
 		   "mac chanctx switch n_vifs %d mode %d\n",
 		   n_vifs, mode);
 	ath12k_mac_update_vif_chan(ar, vifs, n_vifs);
 
-	mutex_unlock(&ar->conf_mutex);
-
 	return 0;
 }
 
@@ -7790,7 +7748,8 @@ ath12k_set_vdev_param_to_all_vifs(struct ath12k *ar, int param, u32 value)
 	struct ath12k_vif *arvif;
 	int ret = 0;
 
-	mutex_lock(&ar->conf_mutex);
+	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
+
 	list_for_each_entry(arvif, &ar->arvifs, list) {
 		ath12k_dbg(ar->ab, ATH12K_DBG_MAC, "setting mac vdev %d param %d value %d\n",
 			   param, arvif->vdev_id, value);
@@ -7803,7 +7762,7 @@ ath12k_set_vdev_param_to_all_vifs(struct ath12k *ar, int param, u32 value)
 			break;
 		}
 	}
-	mutex_unlock(&ar->conf_mutex);
+
 	return ret;
 }
 
@@ -8029,7 +7988,7 @@ static int ath12k_mac_set_fixed_rate_params(struct ath12k_vif *arvif,
 	u32 vdev_param;
 	int ret;
 
-	lockdep_assert_held(&ar->conf_mutex);
+	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
 
 	ath12k_dbg(ar->ab, ATH12K_DBG_MAC, "mac set fixed rate params vdev %i rate 0x%02x nss %u sgi %u\n",
 		   arvif->vdev_id, rate, nss, sgi);
@@ -8155,6 +8114,8 @@ ath12k_mac_op_set_bitrate_mask(struct ieee80211_hw *hw,
 	int ret;
 	int num_rates;
 
+	lockdep_assert_wiphy(hw->wiphy);
+
 	if (ath12k_mac_vif_chan(vif, &def))
 		return -EPERM;
 
@@ -8236,26 +8197,18 @@ ath12k_mac_op_set_bitrate_mask(struct ieee80211_hw *hw,
 					       ath12k_mac_disable_peer_fixed_rate,
 					       arvif);
 
-		mutex_lock(&ar->conf_mutex);
-
 		arvif->bitrate_mask = *mask;
 		ieee80211_iterate_stations_mtx(hw,
 					       ath12k_mac_set_bitrate_mask_iter,
 					       arvif);
-
-		mutex_unlock(&ar->conf_mutex);
 	}
 
-	mutex_lock(&ar->conf_mutex);
-
 	ret = ath12k_mac_set_fixed_rate_params(arvif, rate, nss, sgi, ldpc);
 	if (ret) {
 		ath12k_warn(ar->ab, "failed to set fixed rate params on vdev %i: %d\n",
 			    arvif->vdev_id, ret);
 	}
 
-	mutex_unlock(&ar->conf_mutex);
-
 out:
 	return ret;
 }
@@ -8270,6 +8223,8 @@ ath12k_mac_op_reconfig_complete(struct ieee80211_hw *hw,
 	struct ath12k_vif *arvif;
 	int recovery_count, i;
 
+	lockdep_assert_wiphy(hw->wiphy);
+
 	if (reconfig_type != IEEE80211_RECONFIG_TYPE_RESTART)
 		return;
 
@@ -8282,8 +8237,6 @@ ath12k_mac_op_reconfig_complete(struct ieee80211_hw *hw,
 	ieee80211_wake_queues(hw);
 
 	for_each_ar(ah, ar, i) {
-		mutex_lock(&ar->conf_mutex);
-
 		ab = ar->ab;
 
 		ath12k_warn(ar->ab, "pdev %d successfully recovered\n",
@@ -8328,8 +8281,6 @@ ath12k_mac_op_reconfig_complete(struct ieee80211_hw *hw,
 					   "restart disconnect\n");
 			}
 		}
-
-		mutex_unlock(&ar->conf_mutex);
 	}
 }
 
@@ -8340,7 +8291,7 @@ ath12k_mac_update_bss_chan_survey(struct ath12k *ar,
 	int ret;
 	enum wmi_bss_chan_info_req_type type = WMI_BSS_SURVEY_REQ_TYPE_READ;
 
-	lockdep_assert_held(&ar->conf_mutex);
+	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
 
 	if (!test_bit(WMI_TLV_SERVICE_BSS_CHANNEL_INFO_64, ar->ab->wmi_ab.svc_map) ||
 	    ar->rx_channel != channel)
@@ -8372,6 +8323,8 @@ static int ath12k_mac_op_get_survey(struct ieee80211_hw *hw, int idx,
 	struct ieee80211_supported_band *sband;
 	struct survey_info *ar_survey;
 
+	lockdep_assert_wiphy(hw->wiphy);
+
 	if (idx >= ATH12K_NUM_CHANS)
 		return -ENOENT;
 
@@ -8405,8 +8358,6 @@ static int ath12k_mac_op_get_survey(struct ieee80211_hw *hw, int idx,
 
 	ar_survey = &ar->survey[idx];
 
-	mutex_lock(&ar->conf_mutex);
-
 	ath12k_mac_update_bss_chan_survey(ar, &sband->channels[idx]);
 
 	spin_lock_bh(&ar->data_lock);
@@ -8418,7 +8369,6 @@ static int ath12k_mac_op_get_survey(struct ieee80211_hw *hw, int idx,
 	if (ar->rx_channel == survey->channel)
 		survey->filled |= SURVEY_INFO_IN_USE;
 
-	mutex_unlock(&ar->conf_mutex);
 	return 0;
 }
 
@@ -8464,7 +8414,7 @@ static int ath12k_mac_op_cancel_remain_on_channel(struct ieee80211_hw *hw,
 
 	ar = ath12k_ah_to_ar(ah, 0);
 
-	mutex_lock(&ar->conf_mutex);
+	lockdep_assert_wiphy(hw->wiphy);
 
 	spin_lock_bh(&ar->data_lock);
 	ar->scan.roc_notify = false;
@@ -8472,8 +8422,6 @@ static int ath12k_mac_op_cancel_remain_on_channel(struct ieee80211_hw *hw,
 
 	ath12k_scan_abort(ar);
 
-	mutex_unlock(&ar->conf_mutex);
-
 	cancel_delayed_work_sync(&ar->scan.timeout);
 
 	return 0;
@@ -8493,6 +8441,8 @@ static int ath12k_mac_op_remain_on_channel(struct ieee80211_hw *hw,
 	bool create = true;
 	int ret;
 
+	lockdep_assert_wiphy(hw->wiphy);
+
 	if (ah->num_radio == 1) {
 		WARN_ON(!arvif->is_created);
 		ar = ath12k_ah_to_ar(ah, 0);
@@ -8524,9 +8474,7 @@ static int ath12k_mac_op_remain_on_channel(struct ieee80211_hw *hw,
 			 * would assign the arvif->ar to NULL after the call
 			 */
 			prev_ar = arvif->ar;
-			mutex_lock(&prev_ar->conf_mutex);
 			ret = ath12k_mac_vdev_delete(prev_ar, vif);
-			mutex_unlock(&prev_ar->conf_mutex);
 			if (ret) {
 				ath12k_warn(prev_ar->ab,
 					    "unable to delete scan vdev for roc: %d\n",
@@ -8539,9 +8487,7 @@ static int ath12k_mac_op_remain_on_channel(struct ieee80211_hw *hw,
 	}
 
 	if (create) {
-		mutex_lock(&ar->conf_mutex);
 		ret = ath12k_mac_vdev_create(ar, vif);
-		mutex_unlock(&ar->conf_mutex);
 		if (ret) {
 			ath12k_warn(ar->ab, "unable to create scan vdev for roc: %d\n",
 				    ret);
@@ -8550,7 +8496,6 @@ static int ath12k_mac_op_remain_on_channel(struct ieee80211_hw *hw,
 	}
 
 scan:
-	mutex_lock(&ar->conf_mutex);
 	spin_lock_bh(&ar->data_lock);
 
 	switch (ar->scan.state) {
@@ -8626,8 +8571,6 @@ static int ath12k_mac_op_remain_on_channel(struct ieee80211_hw *hw,
 free_chan_list:
 	kfree(arg.chan_list);
 exit:
-	mutex_unlock(&ar->conf_mutex);
-
 	return ret;
 }
 
@@ -8640,11 +8583,11 @@ static void ath12k_mac_op_set_rekey_data(struct ieee80211_hw *hw,
 	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
 	struct ath12k *ar = ath12k_ah_to_ar(ah, 0);
 
+	lockdep_assert_wiphy(hw->wiphy);
+
 	ath12k_dbg(ar->ab, ATH12K_DBG_MAC, "mac set rekey data vdev %d\n",
 		   arvif->vdev_id);
 
-	mutex_lock(&ar->conf_mutex);
-
 	memcpy(rekey_data->kck, data->kck, NL80211_KCK_LEN);
 	memcpy(rekey_data->kek, data->kek, NL80211_KEK_LEN);
 
@@ -8661,8 +8604,6 @@ static void ath12k_mac_op_set_rekey_data(struct ieee80211_hw *hw,
 			rekey_data->kck, NL80211_KEK_LEN);
 	ath12k_dbg_dump(ar->ab, ATH12K_DBG_MAC, "replay ctr", NULL,
 			&rekey_data->replay_ctr, sizeof(rekey_data->replay_ctr));
-
-	mutex_unlock(&ar->conf_mutex);
 }
 
 static const struct ieee80211_ops ath12k_ops = {
@@ -9322,7 +9263,7 @@ static void ath12k_mac_setup(struct ath12k *ar)
 	spin_lock_init(&ar->data_lock);
 	INIT_LIST_HEAD(&ar->arvifs);
 	INIT_LIST_HEAD(&ar->ppdu_stats_info);
-	mutex_init(&ar->conf_mutex);
+
 	init_completion(&ar->vdev_setup_done);
 	init_completion(&ar->vdev_delete_done);
 	init_completion(&ar->peer_assoc_done);
@@ -9511,7 +9452,7 @@ int ath12k_mac_vif_set_keepalive(struct ath12k_vif *arvif,
 	struct ath12k *ar = arvif->ar;
 	int ret;
 
-	lockdep_assert_held(&ar->conf_mutex);
+	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
 
 	if (arvif->vdev_type != WMI_VDEV_TYPE_STA)
 		return 0;
diff --git a/drivers/net/wireless/ath/ath12k/peer.c b/drivers/net/wireless/ath/ath12k/peer.c
index 19c0626fbff1..64c8a734bafb 100644
--- a/drivers/net/wireless/ath/ath12k/peer.c
+++ b/drivers/net/wireless/ath/ath12k/peer.c
@@ -186,7 +186,7 @@ void ath12k_peer_cleanup(struct ath12k *ar, u32 vdev_id)
 	struct ath12k_peer *peer, *tmp;
 	struct ath12k_base *ab = ar->ab;
 
-	lockdep_assert_held(&ar->conf_mutex);
+	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
 
 	spin_lock_bh(&ab->base_lock);
 	list_for_each_entry_safe(peer, tmp, &ab->peers, list) {
@@ -235,7 +235,7 @@ int ath12k_peer_delete(struct ath12k *ar, u32 vdev_id, u8 *addr)
 {
 	int ret;
 
-	lockdep_assert_held(&ar->conf_mutex);
+	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
 
 	reinit_completion(&ar->peer_delete_done);
 
@@ -268,7 +268,7 @@ int ath12k_peer_create(struct ath12k *ar, struct ath12k_vif *arvif,
 	struct ath12k_peer *peer;
 	int ret;
 
-	lockdep_assert_held(&ar->conf_mutex);
+	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
 
 	if (ar->num_peers > (ar->max_num_peers - 1)) {
 		ath12k_warn(ar->ab,
diff --git a/drivers/net/wireless/ath/ath12k/wow.c b/drivers/net/wireless/ath/ath12k/wow.c
index 9b8684abbe40..94a443307448 100644
--- a/drivers/net/wireless/ath/ath12k/wow.c
+++ b/drivers/net/wireless/ath/ath12k/wow.c
@@ -132,7 +132,7 @@ static int ath12k_wow_cleanup(struct ath12k *ar)
 	struct ath12k_vif *arvif;
 	int ret;
 
-	lockdep_assert_held(&ar->conf_mutex);
+	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
 
 	list_for_each_entry(arvif, &ar->arvifs, list) {
 		ret = ath12k_wow_vif_cleanup(arvif);
@@ -476,7 +476,7 @@ static int ath12k_wow_set_wakeups(struct ath12k *ar,
 	struct ath12k_vif *arvif;
 	int ret;
 
-	lockdep_assert_held(&ar->conf_mutex);
+	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
 
 	list_for_each_entry(arvif, &ar->arvifs, list) {
 		if (ath12k_wow_is_p2p_vdev(arvif))
@@ -535,7 +535,7 @@ static int ath12k_wow_nlo_cleanup(struct ath12k *ar)
 	struct ath12k_vif *arvif;
 	int ret;
 
-	lockdep_assert_held(&ar->conf_mutex);
+	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
 
 	list_for_each_entry(arvif, &ar->arvifs, list) {
 		if (ath12k_wow_is_p2p_vdev(arvif))
@@ -558,7 +558,7 @@ static int ath12k_wow_set_hw_filter(struct ath12k *ar)
 	struct ath12k_vif *arvif;
 	int ret;
 
-	lockdep_assert_held(&ar->conf_mutex);
+	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
 
 	list_for_each_entry(arvif, &ar->arvifs, list) {
 		if (arvif->vdev_type != WMI_VDEV_TYPE_STA)
@@ -584,7 +584,7 @@ static int ath12k_wow_clear_hw_filter(struct ath12k *ar)
 	struct ath12k_vif *arvif;
 	int ret;
 
-	lockdep_assert_held(&ar->conf_mutex);
+	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
 
 	list_for_each_entry(arvif, &ar->arvifs, list) {
 		if (arvif->vdev_type != WMI_VDEV_TYPE_STA)
@@ -735,7 +735,7 @@ static int ath12k_wow_arp_ns_offload(struct ath12k *ar, bool enable)
 	struct ath12k_vif *arvif;
 	int ret;
 
-	lockdep_assert_held(&ar->conf_mutex);
+	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
 
 	offload = kmalloc(sizeof(*offload), GFP_KERNEL);
 	if (!offload)
@@ -769,7 +769,7 @@ static int ath12k_gtk_rekey_offload(struct ath12k *ar, bool enable)
 	struct ath12k_vif *arvif;
 	int ret;
 
-	lockdep_assert_held(&ar->conf_mutex);
+	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
 
 	list_for_each_entry(arvif, &ar->arvifs, list) {
 		if (arvif->vdev_type != WMI_VDEV_TYPE_STA ||
@@ -827,7 +827,7 @@ static int ath12k_wow_set_keepalive(struct ath12k *ar,
 	struct ath12k_vif *arvif;
 	int ret;
 
-	lockdep_assert_held(&ar->conf_mutex);
+	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
 
 	list_for_each_entry(arvif, &ar->arvifs, list) {
 		ret = ath12k_mac_vif_set_keepalive(arvif, method, interval);
@@ -845,7 +845,7 @@ int ath12k_wow_op_suspend(struct ieee80211_hw *hw,
 	struct ath12k *ar = ath12k_ah_to_ar(ah, 0);
 	int ret;
 
-	mutex_lock(&ar->conf_mutex);
+	lockdep_assert_wiphy(hw->wiphy);
 
 	ret =  ath12k_wow_cleanup(ar);
 	if (ret) {
@@ -913,7 +913,6 @@ int ath12k_wow_op_suspend(struct ieee80211_hw *hw,
 	ath12k_wow_cleanup(ar);
 
 exit:
-	mutex_unlock(&ar->conf_mutex);
 	return ret ? 1 : 0;
 }
 
@@ -922,9 +921,9 @@ void ath12k_wow_op_set_wakeup(struct ieee80211_hw *hw, bool enabled)
 	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
 	struct ath12k *ar = ath12k_ah_to_ar(ah, 0);
 
-	mutex_lock(&ar->conf_mutex);
+	lockdep_assert_wiphy(hw->wiphy);
+
 	device_set_wakeup_enable(ar->ab->dev, enabled);
-	mutex_unlock(&ar->conf_mutex);
 }
 
 int ath12k_wow_op_resume(struct ieee80211_hw *hw)
@@ -933,7 +932,7 @@ int ath12k_wow_op_resume(struct ieee80211_hw *hw)
 	struct ath12k *ar = ath12k_ah_to_ar(ah, 0);
 	int ret;
 
-	mutex_lock(&ar->conf_mutex);
+	lockdep_assert_wiphy(hw->wiphy);
 
 	ret = ath12k_hif_resume(ar->ab);
 	if (ret) {
@@ -995,7 +994,6 @@ int ath12k_wow_op_resume(struct ieee80211_hw *hw)
 		}
 	}
 
-	mutex_unlock(&ar->conf_mutex);
 	return ret;
 }
 
-- 
2.39.5


