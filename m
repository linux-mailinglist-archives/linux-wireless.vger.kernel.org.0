Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ACBA56C020
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Jul 2022 20:36:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238512AbiGHQrC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 8 Jul 2022 12:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238539AbiGHQrB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 8 Jul 2022 12:47:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36ED3735AD
        for <linux-wireless@vger.kernel.org>; Fri,  8 Jul 2022 09:47:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C1272622D6
        for <linux-wireless@vger.kernel.org>; Fri,  8 Jul 2022 16:46:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BBE9C341C0;
        Fri,  8 Jul 2022 16:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657298819;
        bh=gjR9BYlOI4S1rvFfrddHDI26uXcoNJdicj/7toxXOA4=;
        h=From:To:Cc:Subject:Date:From;
        b=sWnV6fLW8WETI/2wSWGDXf3MRYGxcadrVPTj1erDwSF96Vvqjb5ixao2dChevczT/
         y0CQq8boORr9a1JBVix9oRhi+jSmjk+eI/Gw0rQdieGt0Bmgq6gA8cmyJ9iUaT2LjY
         UKNybGNDKlIk0UCCaC6nMBMOJ+ZxAUR/qnDWDawZYW14TAZheogoUvz1QM6D1cIQwg
         zGCz1A8ZuMmzCIv5lfbqGxUQxjFc3XvdLVfgxMlqnORFBXqyeHpD9wa/yoXxCPfugR
         wMr/k3RGF7uOkNPih2Lj2ihfrOJNbsIzEcT4XaM8JkXuBLf9QM44S35QvGXzUhjqx2
         2YWlKWg7YY33A==
From:   Kalle Valo <kvalo@kernel.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH] Revert "ath11k: add support for hardware rfkill for QCA6390"
Date:   Fri,  8 Jul 2022 19:46:56 +0300
Message-Id: <20220708164656.29549-1-kvalo@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Kalle Valo <quic_kvalo@quicinc.com>

This reverts commit ec038c6127fa772d2c5604e329f22371830d5fa6. Tyler reported
that on L390 Yoga Thinkpad with QCA6390 the suspend was failing because of this commit.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.9

Link: https://bugzilla.kernel.org/show_bug.cgi?id=215881
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/core.c | 73 --------------------------
 drivers/net/wireless/ath/ath11k/core.h |  4 --
 drivers/net/wireless/ath/ath11k/hw.h   |  3 --
 drivers/net/wireless/ath/ath11k/mac.c  | 58 --------------------
 drivers/net/wireless/ath/ath11k/mac.h  |  2 -
 drivers/net/wireless/ath/ath11k/wmi.c  | 41 ---------------
 drivers/net/wireless/ath/ath11k/wmi.h  | 25 ---------
 7 files changed, 206 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index c8e0bc935838..dbdcc888454c 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -54,9 +54,6 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.target_ce_count = 11,
 		.svc_to_ce_map = ath11k_target_service_to_ce_map_wlan_ipq8074,
 		.svc_to_ce_map_len = 21,
-		.rfkill_pin = 0,
-		.rfkill_cfg = 0,
-		.rfkill_on_level = 0,
 		.single_pdev_only = false,
 		.rxdma1_enable = true,
 		.num_rxmda_per_pdev = 1,
@@ -133,9 +130,6 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.target_ce_count = 11,
 		.svc_to_ce_map = ath11k_target_service_to_ce_map_wlan_ipq6018,
 		.svc_to_ce_map_len = 19,
-		.rfkill_pin = 0,
-		.rfkill_cfg = 0,
-		.rfkill_on_level = 0,
 		.single_pdev_only = false,
 		.rxdma1_enable = true,
 		.num_rxmda_per_pdev = 1,
@@ -209,9 +203,6 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.target_ce_count = 9,
 		.svc_to_ce_map = ath11k_target_service_to_ce_map_wlan_qca6390,
 		.svc_to_ce_map_len = 14,
-		.rfkill_pin = 48,
-		.rfkill_cfg = 0,
-		.rfkill_on_level = 1,
 		.single_pdev_only = true,
 		.rxdma1_enable = false,
 		.num_rxmda_per_pdev = 2,
@@ -284,9 +275,6 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.target_ce_count = 9,
 		.svc_to_ce_map = ath11k_target_service_to_ce_map_wlan_qcn9074,
 		.svc_to_ce_map_len = 18,
-		.rfkill_pin = 0,
-		.rfkill_cfg = 0,
-		.rfkill_on_level = 0,
 		.rxdma1_enable = true,
 		.num_rxmda_per_pdev = 1,
 		.rx_mac_buf_ring = false,
@@ -359,9 +347,6 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.target_ce_count = 9,
 		.svc_to_ce_map = ath11k_target_service_to_ce_map_wlan_qca6390,
 		.svc_to_ce_map_len = 14,
-		.rfkill_pin = 0,
-		.rfkill_cfg = 0,
-		.rfkill_on_level = 0,
 		.single_pdev_only = true,
 		.rxdma1_enable = false,
 		.num_rxmda_per_pdev = 2,
@@ -434,9 +419,6 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.target_ce_count = 9,
 		.svc_to_ce_map = ath11k_target_service_to_ce_map_wlan_qca6390,
 		.svc_to_ce_map_len = 14,
-		.rfkill_pin = 0,
-		.rfkill_cfg = 0,
-		.rfkill_on_level = 0,
 		.single_pdev_only = true,
 		.rxdma1_enable = false,
 		.num_rxmda_per_pdev = 2,
@@ -508,9 +490,6 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.target_ce_count = 9,
 		.svc_to_ce_map = ath11k_target_service_to_ce_map_wlan_qca6390,
 		.svc_to_ce_map_len = 14,
-		.rfkill_pin = 0,
-		.rfkill_cfg = 0,
-		.rfkill_on_level = 0,
 		.single_pdev_only = true,
 		.rxdma1_enable = false,
 		.num_rxmda_per_pdev = 1,
@@ -1402,27 +1381,6 @@ static int ath11k_core_start_firmware(struct ath11k_base *ab,
 	return ret;
 }
 
-static int ath11k_core_rfkill_config(struct ath11k_base *ab)
-{
-	struct ath11k *ar;
-	int ret = 0, i;
-
-	if (!(ab->target_caps.sys_cap_info & WMI_SYS_CAP_INFO_RFKILL))
-		return 0;
-
-	for (i = 0; i < ab->num_radios; i++) {
-		ar = ab->pdevs[i].ar;
-
-		ret = ath11k_mac_rfkill_config(ar);
-		if (ret && ret != -EOPNOTSUPP) {
-			ath11k_warn(ab, "failed to configure rfkill: %d", ret);
-			return ret;
-		}
-	}
-
-	return ret;
-}
-
 int ath11k_core_qmi_firmware_ready(struct ath11k_base *ab)
 {
 	int ret;
@@ -1475,13 +1433,6 @@ int ath11k_core_qmi_firmware_ready(struct ath11k_base *ab)
 		goto err_core_stop;
 	}
 	ath11k_hif_irq_enable(ab);
-
-	ret = ath11k_core_rfkill_config(ab);
-	if (ret && ret != -EOPNOTSUPP) {
-		ath11k_err(ab, "failed to config rfkill: %d\n", ret);
-		goto err_core_stop;
-	}
-
 	mutex_unlock(&ab->core_lock);
 
 	return 0;
@@ -1550,7 +1501,6 @@ void ath11k_core_halt(struct ath11k *ar)
 	cancel_delayed_work_sync(&ar->scan.timeout);
 	cancel_work_sync(&ar->regd_update_work);
 	cancel_work_sync(&ab->update_11d_work);
-	cancel_work_sync(&ab->rfkill_work);
 
 	rcu_assign_pointer(ab->pdevs_active[ar->pdev_idx], NULL);
 	synchronize_rcu();
@@ -1558,28 +1508,6 @@ void ath11k_core_halt(struct ath11k *ar)
 	idr_init(&ar->txmgmt_idr);
 }
 
-static void ath11k_rfkill_work(struct work_struct *work)
-{
-	struct ath11k_base *ab = container_of(work, struct ath11k_base, rfkill_work);
-	struct ath11k *ar;
-	bool rfkill_radio_on;
-	int i;
-
-	spin_lock_bh(&ab->base_lock);
-	rfkill_radio_on = ab->rfkill_radio_on;
-	spin_unlock_bh(&ab->base_lock);
-
-	for (i = 0; i < ab->num_radios; i++) {
-		ar = ab->pdevs[i].ar;
-		if (!ar)
-			continue;
-
-		/* notify cfg80211 radio state change */
-		ath11k_mac_rfkill_enable_radio(ar, rfkill_radio_on);
-		wiphy_rfkill_set_hw_state(ar->hw->wiphy, !rfkill_radio_on);
-	}
-}
-
 static void ath11k_update_11d(struct work_struct *work)
 {
 	struct ath11k_base *ab = container_of(work, struct ath11k_base, update_11d_work);
@@ -1891,7 +1819,6 @@ struct ath11k_base *ath11k_core_alloc(struct device *dev, size_t priv_size,
 	init_waitqueue_head(&ab->qmi.cold_boot_waitq);
 	INIT_WORK(&ab->restart_work, ath11k_core_restart);
 	INIT_WORK(&ab->update_11d_work, ath11k_update_11d);
-	INIT_WORK(&ab->rfkill_work, ath11k_rfkill_work);
 	INIT_WORK(&ab->reset_work, ath11k_core_reset);
 	timer_setup(&ab->rx_replenish_retry, ath11k_ce_rx_replenish_retry, 0);
 	init_completion(&ab->htc_suspend);
diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index 2bd5eb9df4d4..afad8f55e433 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -929,10 +929,6 @@ struct ath11k_base {
 
 	struct ath11k_dbring_cap *db_caps;
 	u32 num_db_cap;
-	struct work_struct rfkill_work;
-
-	/* true means radio is on */
-	bool rfkill_radio_on;
 
 	/* To synchronize 11d scan vdev id */
 	struct mutex vdev_id_11d_lock;
diff --git a/drivers/net/wireless/ath/ath11k/hw.h b/drivers/net/wireless/ath/ath11k/hw.h
index 77dc5c851c9b..14c6d092fcdd 100644
--- a/drivers/net/wireless/ath/ath11k/hw.h
+++ b/drivers/net/wireless/ath/ath11k/hw.h
@@ -153,9 +153,6 @@ struct ath11k_hw_params {
 	u32 svc_to_ce_map_len;
 
 	bool single_pdev_only;
-	u32 rfkill_pin;
-	u32 rfkill_cfg;
-	u32 rfkill_on_level;
 
 	bool rxdma1_enable;
 	int num_rxmda_per_pdev;
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 17dbc7d9cf29..f00c6b181cba 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -5609,63 +5609,6 @@ static int ath11k_mac_mgmt_tx(struct ath11k *ar, struct sk_buff *skb,
 	return 0;
 }
 
-int ath11k_mac_rfkill_config(struct ath11k *ar)
-{
-	struct ath11k_base *ab = ar->ab;
-	u32 param;
-	int ret;
-
-	if (ab->hw_params.rfkill_pin == 0)
-		return -EOPNOTSUPP;
-
-	ath11k_dbg(ab, ATH11K_DBG_MAC,
-		   "mac rfkill_pin %d rfkill_cfg %d rfkill_on_level %d",
-		   ab->hw_params.rfkill_pin, ab->hw_params.rfkill_cfg,
-		   ab->hw_params.rfkill_on_level);
-
-	param = FIELD_PREP(WMI_RFKILL_CFG_RADIO_LEVEL,
-			   ab->hw_params.rfkill_on_level) |
-		FIELD_PREP(WMI_RFKILL_CFG_GPIO_PIN_NUM,
-			   ab->hw_params.rfkill_pin) |
-		FIELD_PREP(WMI_RFKILL_CFG_PIN_AS_GPIO,
-			   ab->hw_params.rfkill_cfg);
-
-	ret = ath11k_wmi_pdev_set_param(ar, WMI_PDEV_PARAM_HW_RFKILL_CONFIG,
-					param, ar->pdev->pdev_id);
-	if (ret) {
-		ath11k_warn(ab,
-			    "failed to set rfkill config 0x%x: %d\n",
-			    param, ret);
-		return ret;
-	}
-
-	return 0;
-}
-
-int ath11k_mac_rfkill_enable_radio(struct ath11k *ar, bool enable)
-{
-	enum wmi_rfkill_enable_radio param;
-	int ret;
-
-	if (enable)
-		param = WMI_RFKILL_ENABLE_RADIO_ON;
-	else
-		param = WMI_RFKILL_ENABLE_RADIO_OFF;
-
-	ath11k_dbg(ar->ab, ATH11K_DBG_MAC, "mac %d rfkill enable %d",
-		   ar->pdev_idx, param);
-
-	ret = ath11k_wmi_pdev_set_param(ar, WMI_PDEV_PARAM_RFKILL_ENABLE,
-					param, ar->pdev->pdev_id);
-	if (ret) {
-		ath11k_warn(ar->ab, "failed to set rfkill enable param %d: %d\n",
-			    param, ret);
-		return ret;
-	}
-
-	return 0;
-}
-
 static void ath11k_mac_op_tx(struct ieee80211_hw *hw,
 			     struct ieee80211_tx_control *control,
 			     struct sk_buff *skb)
@@ -5920,7 +5863,6 @@ static void ath11k_mac_op_stop(struct ieee80211_hw *hw)
 	cancel_delayed_work_sync(&ar->scan.timeout);
 	cancel_work_sync(&ar->regd_update_work);
 	cancel_work_sync(&ar->ab->update_11d_work);
-	cancel_work_sync(&ar->ab->rfkill_work);
 
 	if (ar->state_11d == ATH11K_11D_PREPARING) {
 		ar->state_11d = ATH11K_11D_IDLE;
diff --git a/drivers/net/wireless/ath/ath11k/mac.h b/drivers/net/wireless/ath/ath11k/mac.h
index 57ebfc592b00..2a0d3afb0c99 100644
--- a/drivers/net/wireless/ath/ath11k/mac.h
+++ b/drivers/net/wireless/ath/ath11k/mac.h
@@ -148,8 +148,6 @@ u8 ath11k_mac_hw_rate_to_idx(const struct ieee80211_supported_band *sband,
 
 void __ath11k_mac_scan_finish(struct ath11k *ar);
 void ath11k_mac_scan_finish(struct ath11k *ar);
-int ath11k_mac_rfkill_enable_radio(struct ath11k *ar, bool enable);
-int ath11k_mac_rfkill_config(struct ath11k *ar);
 
 struct ath11k_vif *ath11k_mac_get_arvif(struct ath11k *ar, u32 vdev_id);
 struct ath11k_vif *ath11k_mac_get_arvif_by_vdev_id(struct ath11k_base *ab,
diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index 5d9437ea92cf..88ee4f9d19da 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -129,8 +129,6 @@ static const struct wmi_tlv_policy wmi_tlv_policies[] = {
 		= { .min_len = sizeof(struct wmi_peer_assoc_conf_event) },
 	[WMI_TAG_STATS_EVENT]
 		= { .min_len = sizeof(struct wmi_stats_event) },
-	[WMI_TAG_RFKILL_EVENT] = {
-		.min_len = sizeof(struct wmi_rfkill_state_change_ev) },
 	[WMI_TAG_PDEV_CTL_FAILSAFE_CHECK_EVENT]
 		= { .min_len = sizeof(struct wmi_pdev_ctl_failsafe_chk_event) },
 	[WMI_TAG_HOST_SWFDA_EVENT] = {
@@ -533,8 +531,6 @@ static int ath11k_pull_service_ready_tlv(struct ath11k_base *ab,
 	cap->default_dbs_hw_mode_index = ev->default_dbs_hw_mode_index;
 	cap->num_msdu_desc = ev->num_msdu_desc;
 
-	ath11k_dbg(ab, ATH11K_DBG_WMI, "wmi sys cap info 0x%x\n", cap->sys_cap_info);
-
 	return 0;
 }
 
@@ -7566,40 +7562,6 @@ ath11k_wmi_pdev_dfs_radar_detected_event(struct ath11k_base *ab, struct sk_buff
 	kfree(tb);
 }
 
-static void ath11k_rfkill_state_change_event(struct ath11k_base *ab,
-					     struct sk_buff *skb)
-{
-	const struct wmi_rfkill_state_change_ev *ev;
-	const void **tb;
-	int ret;
-
-	tb = ath11k_wmi_tlv_parse_alloc(ab, skb->data, skb->len, GFP_ATOMIC);
-	if (IS_ERR(tb)) {
-		ret = PTR_ERR(tb);
-		ath11k_warn(ab, "failed to parse tlv: %d\n", ret);
-		return;
-	}
-
-	ev = tb[WMI_TAG_RFKILL_EVENT];
-	if (!ev) {
-		kfree(tb);
-		return;
-	}
-
-	ath11k_dbg(ab, ATH11K_DBG_MAC,
-		   "wmi tlv rfkill state change gpio %d type %d radio_state %d\n",
-		   ev->gpio_pin_num,
-		   ev->int_type,
-		   ev->radio_state);
-
-	spin_lock_bh(&ab->base_lock);
-	ab->rfkill_radio_on = (ev->radio_state == WMI_RFKILL_RADIO_STATE_ON);
-	spin_unlock_bh(&ab->base_lock);
-
-	queue_work(ab->workqueue, &ab->rfkill_work);
-	kfree(tb);
-}
-
 static void
 ath11k_wmi_pdev_temperature_event(struct ath11k_base *ab,
 				  struct sk_buff *skb)
@@ -7995,9 +7957,6 @@ static void ath11k_wmi_tlv_op_rx(struct ath11k_base *ab, struct sk_buff *skb)
 	case WMI_11D_NEW_COUNTRY_EVENTID:
 		ath11k_reg_11d_new_cc_event(ab, skb);
 		break;
-	case WMI_RFKILL_STATE_CHANGE_EVENTID:
-		ath11k_rfkill_state_change_event(ab, skb);
-		break;
 	case WMI_DIAG_EVENTID:
 		ath11k_wmi_diag_event(ab, skb);
 		break;
diff --git a/drivers/net/wireless/ath/ath11k/wmi.h b/drivers/net/wireless/ath/ath11k/wmi.h
index b1fad4707dc6..4da248ffa318 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.h
+++ b/drivers/net/wireless/ath/ath11k/wmi.h
@@ -5328,31 +5328,6 @@ struct target_resource_config {
 	u32 twt_ap_sta_count;
 };
 
-enum wmi_sys_cap_info_flags {
-	WMI_SYS_CAP_INFO_RXTX_LED	= BIT(0),
-	WMI_SYS_CAP_INFO_RFKILL	= BIT(1),
-};
-
-#define WMI_RFKILL_CFG_GPIO_PIN_NUM		GENMASK(5, 0)
-#define WMI_RFKILL_CFG_RADIO_LEVEL		BIT(6)
-#define WMI_RFKILL_CFG_PIN_AS_GPIO		GENMASK(10, 7)
-
-enum wmi_rfkill_enable_radio {
-	WMI_RFKILL_ENABLE_RADIO_ON	= 0,
-	WMI_RFKILL_ENABLE_RADIO_OFF	= 1,
-};
-
-enum wmi_rfkill_radio_state {
-	WMI_RFKILL_RADIO_STATE_OFF	= 1,
-	WMI_RFKILL_RADIO_STATE_ON	= 2,
-};
-
-struct wmi_rfkill_state_change_ev {
-	u32 gpio_pin_num;
-	u32 int_type;
-	u32 radio_state;
-} __packed;
-
 enum wmi_debug_log_param {
 	WMI_DEBUG_LOG_PARAM_LOG_LEVEL = 0x1,
 	WMI_DEBUG_LOG_PARAM_VDEV_ENABLE,

base-commit: f6bb3df74ceb88929dd7e09170ec156ac2e5d809
-- 
2.30.2

