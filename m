Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98AA03D1403
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Jul 2021 18:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233137AbhGUPlW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Jul 2021 11:41:22 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:57889 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234515AbhGUPlT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Jul 2021 11:41:19 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1626884515; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=MUIvbdt0ZwzrJAqKb1xeWwN6tMnH/mlUM5bGMQ9rGoY=; b=Pz3N4/IoT2HhiPi5+miXT26PkryFiP/hEqPjcQmxvQ+Us2ZnNhB4lofGqaJrP6R8kP6KCzxy
 vYYNqleXE17s1OiW+nA7hZnNYRh+J4rdiLRunuKwKOvcQ9DiZcI+XqJlgDieyfU3/ML9GZB6
 nRCJ7VtADiTcIdBOXkTHwPXFUcE=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 60f84985b653fbdadd2bc503 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 21 Jul 2021 16:21:25
 GMT
Sender: jouni=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 1B2B5C4338A; Wed, 21 Jul 2021 16:21:23 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from jouni.codeaurora.org (85-76-67-217-nat.elisa-mobile.fi [85.76.67.217])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jouni)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 786C8C4360C;
        Wed, 21 Jul 2021 16:21:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 786C8C4360C
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=jouni@codeaurora.org
From:   Jouni Malinen <jouni@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Seevalamuthu Mariappan <seevalam@codeaurora.org>,
        Miles Hu <milehu@codeaurora.org>,
        Vasanthakumar Thiagarajan <vthiagar@codeaurora.org>,
        Jouni Malinen <jouni@codeaurora.org>
Subject: [PATCH 3/3] ath11k: monitor mode clean up to use separate APIs
Date:   Wed, 21 Jul 2021 19:20:53 +0300
Message-Id: <20210721162053.46290-4-jouni@codeaurora.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210721162053.46290-1-jouni@codeaurora.org>
References: <20210721162053.46290-1-jouni@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Seevalamuthu Mariappan <seevalam@codeaurora.org>

If monitor interface is enabled in co-exist mode, only local traffic are
captured. It's caused by missing monitor vdev in co-exist mode. So,
monitor mode clean up is done with separate Monitor APIs. For this,
introduce monitor_started and monitor_vdev_created boolean flags.

Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.4.0.1-01725-QCAHKSWPL_SILICONZ-1

Co-developed-by: Miles Hu <milehu@codeaurora.org>
Signed-off-by: Miles Hu <milehu@codeaurora.org>
Co-developed-by: Vasanthakumar Thiagarajan <vthiagar@codeaurora.org>
Signed-off-by: Vasanthakumar Thiagarajan <vthiagar@codeaurora.org>
Signed-off-by: Seevalamuthu Mariappan <seevalam@codeaurora.org>
Signed-off-by: Jouni Malinen <jouni@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/core.h  |   5 --
 drivers/net/wireless/ath/ath11k/dp_rx.c |   2 +-
 drivers/net/wireless/ath/ath11k/dp_tx.c |   9 +-
 drivers/net/wireless/ath/ath11k/mac.c   | 112 ++++++++++++++----------
 4 files changed, 73 insertions(+), 55 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index 3cddab695031..0ad5a935b52b 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -192,10 +192,6 @@ enum ath11k_dev_flags {
 	ATH11K_FLAG_HTC_SUSPEND_COMPLETE,
 };
 
-enum ath11k_monitor_flags {
-	ATH11K_FLAG_MONITOR_ENABLED,
-};
-
 struct ath11k_vif {
 	u32 vdev_id;
 	enum wmi_vdev_type vdev_type;
@@ -478,7 +474,6 @@ struct ath11k {
 
 	unsigned long dev_flags;
 	unsigned int filter_flags;
-	unsigned long monitor_flags;
 	u32 min_tx_power;
 	u32 max_tx_power;
 	u32 txpower_limit_2g;
diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
index 9a224817630a..6fde70914e1a 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
@@ -5029,7 +5029,7 @@ int ath11k_dp_rx_process_mon_rings(struct ath11k_base *ab, int mac_id,
 	struct ath11k *ar = ath11k_ab_to_ar(ab, mac_id);
 	int ret = 0;
 
-	if (test_bit(ATH11K_FLAG_MONITOR_ENABLED, &ar->monitor_flags))
+	if (ar->monitor_started)
 		ret = ath11k_dp_mon_process_rx(ab, mac_id, napi, budget);
 	else
 		ret = ath11k_dp_rx_process_mon_status(ab, mac_id, napi, budget);
diff --git a/drivers/net/wireless/ath/ath11k/dp_tx.c b/drivers/net/wireless/ath/ath11k/dp_tx.c
index 3acdd4050d5b..253d0564f923 100644
--- a/drivers/net/wireless/ath/ath11k/dp_tx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_tx.c
@@ -1076,11 +1076,16 @@ int ath11k_dp_tx_htt_monitor_mode_ring_config(struct ath11k *ar, bool reset)
 
 	for (i = 0; i < ab->hw_params.num_rxmda_per_pdev; i++) {
 		ring_id = dp->rx_mon_status_refill_ring[i].refill_buf_ring.ring_id;
-		if (!reset)
+		if (!reset) {
 			tlv_filter.rx_filter =
 					HTT_RX_MON_FILTER_TLV_FLAGS_MON_STATUS_RING;
-		else
+		} else {
 			tlv_filter = ath11k_mac_mon_status_filter_default;
+#ifdef CONFIG_ATH11K_DEBUGFS
+			if (ar->debug.extd_rx_stats)
+				tlv_filter.rx_filter = ar->debug.rx_filter;
+#endif
+		}
 
 		ret = ath11k_dp_tx_htt_rx_filter_setup(ab, ring_id,
 						       dp->mac_id + i,
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index e446817ac8b0..b9d4e8914482 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -715,22 +715,6 @@ void ath11k_mac_peer_cleanup_all(struct ath11k *ar)
 	ar->num_stations = 0;
 }
 
-static int ath11k_monitor_vdev_up(struct ath11k *ar, int vdev_id)
-{
-	int ret = 0;
-
-	ret = ath11k_wmi_vdev_up(ar, vdev_id, 0, ar->mac_addr);
-	if (ret) {
-		ath11k_warn(ar->ab, "failed to put up monitor vdev %i: %d\n",
-			    vdev_id, ret);
-		return ret;
-	}
-
-	ath11k_dbg(ar->ab, ATH11K_DBG_MAC, "mac monitor vdev %i started\n",
-		   vdev_id);
-	return 0;
-}
-
 static inline int ath11k_mac_vdev_setup_sync(struct ath11k *ar)
 {
 	lockdep_assert_held(&ar->conf_mutex);
@@ -2270,7 +2254,7 @@ static int ath11k_mac_config_obss_pd(struct ath11k *ar,
 
 	/* Set and enable SRG/non-SRG OBSS PD Threshold */
 	param_id = WMI_PDEV_PARAM_SET_CMD_OBSS_PD_THRESHOLD;
-	if (test_bit(ATH11K_FLAG_MONITOR_ENABLED, &ar->monitor_flags)) {
+	if (ar->monitor_started) {
 		ret = ath11k_wmi_pdev_set_param(ar, param_id, 0, pdev_id);
 		if (ret)
 			ath11k_warn(ar->ab,
@@ -5044,8 +5028,8 @@ static int ath11k_mac_op_add_interface(struct ieee80211_hw *hw,
 	}
 
 	if (ar->num_created_vdevs > (TARGET_NUM_VDEVS - 1)) {
-		ath11k_warn(ab, "failed to create vdev, reached max vdev limit %d\n",
-			    TARGET_NUM_VDEVS);
+		ath11k_warn(ab, "failed to create vdev %u, reached max vdev limit %d\n",
+			    ar->num_created_vdevs, TARGET_NUM_VDEVS);
 		ret = -EBUSY;
 		goto err;
 	}
@@ -5085,6 +5069,7 @@ static int ath11k_mac_op_add_interface(struct ieee80211_hw *hw,
 		break;
 	case NL80211_IFTYPE_MONITOR:
 		arvif->vdev_type = WMI_VDEV_TYPE_MONITOR;
+		ar->monitor_vdev_id = bit;
 		break;
 	default:
 		WARN_ON(1);
@@ -5186,6 +5171,9 @@ static int ath11k_mac_op_add_interface(struct ieee80211_hw *hw,
 			goto err_peer_del;
 		}
 		break;
+	case WMI_VDEV_TYPE_MONITOR:
+		ar->monitor_vdev_created = true;
+		break;
 	default:
 		break;
 	}
@@ -5206,6 +5194,12 @@ static int ath11k_mac_op_add_interface(struct ieee80211_hw *hw,
 
 	ath11k_dp_vdev_tx_attach(ar, arvif);
 
+	if (vif->type != NL80211_IFTYPE_MONITOR && ar->monitor_conf_enabled) {
+		ret = ath11k_mac_monitor_vdev_create(ar);
+		if (ret)
+			goto err_peer_del;
+	}
+
 	mutex_unlock(&ar->conf_mutex);
 
 	return 0;
@@ -5303,6 +5297,13 @@ static void ath11k_mac_op_remove_interface(struct ieee80211_hw *hw,
 	ath11k_dbg(ab, ATH11K_DBG_MAC, "vdev %pM deleted, vdev_id %d\n",
 		   vif->addr, arvif->vdev_id);
 
+	if (arvif->vdev_type == WMI_VDEV_TYPE_MONITOR) {
+		ar->monitor_vdev_created = false;
+		ar->monitor_vdev_id = -1;
+	} else if (ar->monitor_vdev_created && !ar->monitor_started) {
+		ret = ath11k_mac_monitor_vdev_delete(ar);
+	}
+
 err_vdev_del:
 	spin_lock_bh(&ar->data_lock);
 	list_del(&arvif->list);
@@ -5322,7 +5323,6 @@ static void ath11k_mac_op_remove_interface(struct ieee80211_hw *hw,
 
 	/* Recalc txpower for remaining vdev */
 	ath11k_mac_txpower_recalc(ar);
-	clear_bit(ATH11K_FLAG_MONITOR_ENABLED, &ar->monitor_flags);
 
 	/* TODO: recal traffic pause state based on the available vdevs */
 
@@ -5345,8 +5345,6 @@ static void ath11k_mac_op_configure_filter(struct ieee80211_hw *hw,
 					   u64 multicast)
 {
 	struct ath11k *ar = hw->priv;
-	bool reset_flag = false;
-	int ret = 0;
 
 	mutex_lock(&ar->conf_mutex);
 
@@ -5354,23 +5352,6 @@ static void ath11k_mac_op_configure_filter(struct ieee80211_hw *hw,
 	*total_flags &= SUPPORTED_FILTERS;
 	ar->filter_flags = *total_flags;
 
-	/* For monitor mode */
-	reset_flag = !(ar->filter_flags & FIF_BCN_PRBRESP_PROMISC);
-
-	ret = ath11k_dp_tx_htt_monitor_mode_ring_config(ar, reset_flag);
-	if (!ret) {
-		if (!reset_flag)
-			set_bit(ATH11K_FLAG_MONITOR_ENABLED, &ar->monitor_flags);
-		else
-			clear_bit(ATH11K_FLAG_MONITOR_ENABLED, &ar->monitor_flags);
-	} else {
-		ath11k_warn(ar->ab,
-			    "fail to set monitor filter: %d\n", ret);
-	}
-	ath11k_dbg(ar->ab, ATH11K_DBG_MAC,
-		   "changed_flags:0x%x, total_flags:0x%x, reset_flag:%d\n",
-		   changed_flags, *total_flags, reset_flag);
-
 	mutex_unlock(&ar->conf_mutex);
 }
 
@@ -5561,7 +5542,9 @@ ath11k_mac_vdev_start_restart(struct ath11k_vif *arvif,
 		return ret;
 	}
 
-	ar->num_started_vdevs++;
+	if (!restart)
+		ar->num_started_vdevs++;
+
 	ath11k_dbg(ab, ATH11K_DBG_MAC,  "vdev %pM started, vdev_id %d\n",
 		   arvif->vif->addr, arvif->vdev_id);
 
@@ -5689,12 +5672,16 @@ ath11k_mac_update_vif_chan(struct ath11k *ar,
 	struct ath11k_vif *arvif;
 	int ret;
 	int i;
+	bool monitor_vif = false;
 
 	lockdep_assert_held(&ar->conf_mutex);
 
 	for (i = 0; i < n_vifs; i++) {
 		arvif = (void *)vifs[i].vif->drv_priv;
 
+		if (vifs[i].vif->type == NL80211_IFTYPE_MONITOR)
+			monitor_vif = true;
+
 		ath11k_dbg(ab, ATH11K_DBG_MAC,
 			   "mac chanctx switch vdev_id %i freq %u->%u width %d->%d\n",
 			   arvif->vdev_id,
@@ -5715,6 +5702,8 @@ ath11k_mac_update_vif_chan(struct ath11k *ar,
 				    arvif->vdev_id, ret);
 			continue;
 		}
+
+		ar->num_started_vdevs--;
 	}
 
 	/* All relevant vdevs are downed and associated channel resources
@@ -5752,6 +5741,12 @@ ath11k_mac_update_vif_chan(struct ath11k *ar,
 			continue;
 		}
 	}
+
+	/* Restart the internal monitor vdev on new channel */
+	if (!monitor_vif && ar->monitor_vdev_created) {
+		if (!ath11k_mac_monitor_stop(ar))
+			ath11k_mac_monitor_start(ar);
+	}
 }
 
 static void
@@ -5831,7 +5826,7 @@ static int ath11k_start_vdev_delay(struct ieee80211_hw *hw,
 	}
 
 	if (arvif->vdev_type == WMI_VDEV_TYPE_MONITOR) {
-		ret = ath11k_monitor_vdev_up(ar, arvif->vdev_id);
+		ret = ath11k_wmi_vdev_up(ar, arvif->vdev_id, 0, ar->mac_addr);
 		if (ret) {
 			ath11k_warn(ab, "failed put monitor up: %d\n", ret);
 			return ret;
@@ -5891,6 +5886,15 @@ ath11k_mac_op_assign_vif_chanctx(struct ieee80211_hw *hw,
 		}
 	}
 
+	if (arvif->vdev_type == WMI_VDEV_TYPE_MONITOR) {
+		ret = ath11k_mac_monitor_start(ar);
+		if (ret)
+			goto out;
+
+		arvif->is_started = true;
+		goto out;
+	}
+
 	ret = ath11k_mac_vdev_start(arvif, &ctx->def);
 	if (ret) {
 		ath11k_warn(ab, "failed to start vdev %i addr %pM on freq %d: %d\n",
@@ -5898,14 +5902,13 @@ ath11k_mac_op_assign_vif_chanctx(struct ieee80211_hw *hw,
 			    ctx->def.chan->center_freq, ret);
 		goto out;
 	}
-	if (arvif->vdev_type == WMI_VDEV_TYPE_MONITOR) {
-		ret = ath11k_monitor_vdev_up(ar, arvif->vdev_id);
-		if (ret)
-			goto out;
-	}
 
 	arvif->is_started = true;
 
+	if (arvif->vdev_type != WMI_VDEV_TYPE_MONITOR &&
+	    ar->monitor_vdev_created)
+		ath11k_mac_monitor_start(ar);
+
 	/* TODO: Setup ps and cts/rts protection */
 
 	ret = 0;
@@ -5939,6 +5942,18 @@ ath11k_mac_op_unassign_vif_chanctx(struct ieee80211_hw *hw,
 	    ath11k_peer_find_by_addr(ab, ar->mac_addr))
 		ath11k_peer_delete(ar, arvif->vdev_id, ar->mac_addr);
 
+	if (arvif->vdev_type == WMI_VDEV_TYPE_MONITOR) {
+		ret = ath11k_mac_monitor_stop(ar);
+		if (ret) {
+			mutex_unlock(&ar->conf_mutex);
+			return;
+		}
+
+		arvif->is_started = false;
+		mutex_unlock(&ar->conf_mutex);
+		return;
+	}
+
 	ret = ath11k_mac_vdev_stop(arvif);
 	if (ret)
 		ath11k_warn(ab, "failed to stop vdev %i: %d\n",
@@ -5950,6 +5965,10 @@ ath11k_mac_op_unassign_vif_chanctx(struct ieee80211_hw *hw,
 	    arvif->vdev_type == WMI_VDEV_TYPE_MONITOR)
 		ath11k_wmi_vdev_down(ar, arvif->vdev_id);
 
+	if (arvif->vdev_type != WMI_VDEV_TYPE_MONITOR &&
+	    ar->num_started_vdevs == 1 && ar->monitor_vdev_created)
+		ath11k_mac_monitor_stop(ar);
+
 	mutex_unlock(&ar->conf_mutex);
 }
 
@@ -7071,7 +7090,6 @@ int ath11k_mac_allocate(struct ath11k_base *ab)
 
 		INIT_WORK(&ar->wmi_mgmt_tx_work, ath11k_mgmt_over_wmi_tx_work);
 		skb_queue_head_init(&ar->wmi_mgmt_tx_queue);
-		clear_bit(ATH11K_FLAG_MONITOR_ENABLED, &ar->monitor_flags);
 		ar->monitor_vdev_id = -1;
 		ar->monitor_vdev_created = false;
 		ar->monitor_started = false;
-- 
2.25.1

