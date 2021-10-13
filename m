Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5998E42B8CC
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Oct 2021 09:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238439AbhJMHSw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Oct 2021 03:18:52 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:20615 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238342AbhJMHSs (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Oct 2021 03:18:48 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1634109405; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=lZcGMxjrlQiaepQ5Z7Wu31gF3QT6BchtTAYkQItKDyA=; b=H3S8fjMSLPu5L7dpVTrQAtoRNUxEK0E1MDQu2wzMRr3O6XgGZh0KlYGA4On7q510Fyw4R6F+
 uXgVvCkSp+9dsktJChtlejb+o6+r2hm6kHNFGGuPmL5VK6eHUizrKjOspPkGmhAP1BC7Pqsy
 1Y03t6PpqOSa9RFcxlnWuj/rUjM=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 616687d6f3e5b80f1f50d2da (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 13 Oct 2021 07:16:38
 GMT
Sender: wgong=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 7B53EC43616; Wed, 13 Oct 2021 07:16:38 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from wgong-HP3-Z230-SFF-Workstation.qca.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wgong)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A404BC4338F;
        Wed, 13 Oct 2021 07:16:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org A404BC4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Wen Gong <wgong@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, wgong@codeaurora.org
Subject: [PATCH] ath11k: add support for hardware rfkill for QCA6390
Date:   Wed, 13 Oct 2021 03:16:27 -0400
Message-Id: <20211013071627.15618-1-wgong@codeaurora.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When hardware rfkill is enabled in the firmware it will report the
capability via using WMI_SYS_CAP_INFO_RFKILL bit in the WMI_SERVICE_READY
event to the host. ath11k will check the capability, and if it is enabled then
ath11k will set the GPIO information to firmware using WMI_PDEV_SET_PARAM. When
the firmware detects hardware rfkill is enabled by the user, it will report it
via WMI_RFKILL_STATE_CHANGE_EVENTID. Once ath11k receives the event it will
send wmi command WMI_PDEV_SET_PARAM to the firmware and also notifies cfg80211.

This only enable rfkill feature for QCA6390, rfkill_pin is all initialized to 0
for other chips in ath11k_hw_params.

Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1

Signed-off-by: Wen Gong <wgong@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/core.c | 66 ++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/core.h |  4 ++
 drivers/net/wireless/ath/ath11k/hw.h   |  3 ++
 drivers/net/wireless/ath/ath11k/mac.c  | 57 ++++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/mac.h  |  2 +
 drivers/net/wireless/ath/ath11k/pci.c  |  1 +
 drivers/net/wireless/ath/ath11k/wmi.c  | 41 ++++++++++++++++
 drivers/net/wireless/ath/ath11k/wmi.h  | 25 ++++++++++
 8 files changed, 199 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index deae282aa1d5..b6da131410cc 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -52,6 +52,9 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.target_ce_count = 11,
 		.svc_to_ce_map = ath11k_target_service_to_ce_map_wlan_ipq8074,
 		.svc_to_ce_map_len = 21,
+		.rfkill_pin = 0,
+		.rfkill_cfg = 0,
+		.rfkill_on_level = 0,
 		.single_pdev_only = false,
 		.rxdma1_enable = true,
 		.num_rxmda_per_pdev = 1,
@@ -93,6 +96,9 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.target_ce_count = 11,
 		.svc_to_ce_map = ath11k_target_service_to_ce_map_wlan_ipq6018,
 		.svc_to_ce_map_len = 19,
+		.rfkill_pin = 0,
+		.rfkill_cfg = 0,
+		.rfkill_on_level = 0,
 		.single_pdev_only = false,
 		.rxdma1_enable = true,
 		.num_rxmda_per_pdev = 1,
@@ -134,6 +140,9 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.target_ce_count = 9,
 		.svc_to_ce_map = ath11k_target_service_to_ce_map_wlan_qca6390,
 		.svc_to_ce_map_len = 14,
+		.rfkill_pin = 48,
+		.rfkill_cfg = 0,
+		.rfkill_on_level = 1,
 		.single_pdev_only = true,
 		.rxdma1_enable = false,
 		.num_rxmda_per_pdev = 2,
@@ -174,6 +183,9 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.target_ce_count = 9,
 		.svc_to_ce_map = ath11k_target_service_to_ce_map_wlan_qcn9074,
 		.svc_to_ce_map_len = 18,
+		.rfkill_pin = 0,
+		.rfkill_cfg = 0,
+		.rfkill_on_level = 0,
 		.rxdma1_enable = true,
 		.num_rxmda_per_pdev = 1,
 		.rx_mac_buf_ring = false,
@@ -212,6 +224,9 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.target_ce_count = 9,
 		.svc_to_ce_map = ath11k_target_service_to_ce_map_wlan_qca6390,
 		.svc_to_ce_map_len = 14,
+		.rfkill_pin = 0,
+		.rfkill_cfg = 0,
+		.rfkill_on_level = 0,
 		.single_pdev_only = true,
 		.rxdma1_enable = false,
 		.num_rxmda_per_pdev = 2,
@@ -852,6 +867,27 @@ static int ath11k_core_start(struct ath11k_base *ab,
 	return ret;
 }
 
+static int ath11k_core_rfkill_config(struct ath11k_base *ab)
+{
+	struct ath11k *ar;
+	int ret = 0, i;
+
+	if (!(ab->target_caps.sys_cap_info & WMI_SYS_CAP_INFO_RFKILL))
+		return 0;
+
+	for (i = 0; i < ab->num_radios; i++) {
+		ar = ab->pdevs[i].ar;
+
+		ret = ath11k_mac_rfkill_config(ar);
+		if (ret && ret != -EOPNOTSUPP) {
+			ath11k_warn(ab, "failed to configure rfkill: %d", ret);
+			return ret;
+		}
+	}
+
+	return ret;
+}
+
 int ath11k_core_qmi_firmware_ready(struct ath11k_base *ab)
 {
 	int ret;
@@ -898,6 +934,13 @@ int ath11k_core_qmi_firmware_ready(struct ath11k_base *ab)
 		goto err_core_stop;
 	}
 	ath11k_hif_irq_enable(ab);
+
+	ret = ath11k_core_rfkill_config(ab);
+	if (ret && ret != -EOPNOTSUPP) {
+		ath11k_err(ab, "failed to config rfkill: %d\n", ret);
+		goto err_core_stop;
+	}
+
 	mutex_unlock(&ab->core_lock);
 
 	return 0;
@@ -969,6 +1012,28 @@ void ath11k_core_halt(struct ath11k *ar)
 	idr_init(&ar->txmgmt_idr);
 }
 
+static void ath11k_rfkill_work(struct work_struct *work)
+{
+	struct ath11k_base *ab = container_of(work, struct ath11k_base, rfkill_work);
+	struct ath11k *ar;
+	bool rfkill_radio_on;
+	int i;
+
+	spin_lock_bh(&ab->base_lock);
+	rfkill_radio_on = ab->rfkill_radio_on;
+	spin_unlock_bh(&ab->base_lock);
+
+	for (i = 0; i < ab->num_radios; i++) {
+		ar = ab->pdevs[i].ar;
+		if (!ar)
+			continue;
+
+		/* notify cfg80211 radio state change */
+		ath11k_mac_rfkill_enable_radio(ar, rfkill_radio_on);
+		wiphy_rfkill_set_hw_state(ar->hw->wiphy, !rfkill_radio_on);
+	}
+}
+
 static void ath11k_update_11d(struct work_struct *work)
 {
 	struct ath11k_base *ab = container_of(work, struct ath11k_base, update_11d_work);
@@ -1186,6 +1251,7 @@ struct ath11k_base *ath11k_core_alloc(struct device *dev, size_t priv_size,
 	init_waitqueue_head(&ab->qmi.cold_boot_waitq);
 	INIT_WORK(&ab->restart_work, ath11k_core_restart);
 	INIT_WORK(&ab->update_11d_work, ath11k_update_11d);
+	INIT_WORK(&ab->rfkill_work, ath11k_rfkill_work);
 	timer_setup(&ab->rx_replenish_retry, ath11k_ce_rx_replenish_retry, 0);
 	init_completion(&ab->htc_suspend);
 	init_completion(&ab->wow.wakeup_completed);
diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index 9fe4a4a0b942..3acbf98ad146 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -801,6 +801,10 @@ struct ath11k_base {
 	u32 num_db_cap;
 	bool ftm_segment_handler;
 	struct ath11k_ftm_event_obj ftm_event_obj;
+	struct work_struct rfkill_work;
+
+	/* true means radio is on */
+	bool rfkill_radio_on;
 
 	/* To synchronize 11d scan vdev id */
 	struct mutex vdev_id_11d_lock;
diff --git a/drivers/net/wireless/ath/ath11k/hw.h b/drivers/net/wireless/ath/ath11k/hw.h
index 4876b6ac12cc..7f58b0b3dfc5 100644
--- a/drivers/net/wireless/ath/ath11k/hw.h
+++ b/drivers/net/wireless/ath/ath11k/hw.h
@@ -171,6 +171,9 @@ struct ath11k_hw_params {
 	bool fix_l1ss;
 	bool support_ext_cc;
 	enum ath11k_prefer_reg_type default_reg_type;
+	u32 rfkill_pin;
+	u32 rfkill_cfg;
+	u32 rfkill_on_level;
 };
 
 struct ath11k_hw_ops {
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index f508a60619f9..d8f623b54aa7 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -4400,6 +4400,63 @@ static int ath11k_mac_mgmt_tx(struct ath11k *ar, struct sk_buff *skb,
 	return 0;
 }
 
+int ath11k_mac_rfkill_config(struct ath11k *ar)
+{
+	struct ath11k_base *ab = ar->ab;
+	u32 param;
+	int ret;
+
+	if (ab->hw_params.rfkill_pin == 0)
+		return -EOPNOTSUPP;
+
+	ath11k_dbg(ab, ATH11K_DBG_MAC,
+		   "mac rfkill_pin %d rfkill_cfg %d rfkill_on_level %d",
+		   ab->hw_params.rfkill_pin, ab->hw_params.rfkill_cfg,
+		   ab->hw_params.rfkill_on_level);
+
+	param = FIELD_PREP(WMI_RFKILL_CFG_RADIO_LEVEL,
+			   ab->hw_params.rfkill_on_level) |
+		FIELD_PREP(WMI_RFKILL_CFG_GPIO_PIN_NUM,
+			   ab->hw_params.rfkill_pin) |
+		FIELD_PREP(WMI_RFKILL_CFG_PIN_AS_GPIO,
+			   ab->hw_params.rfkill_cfg);
+
+	ret = ath11k_wmi_pdev_set_param(ar, WMI_PDEV_PARAM_HW_RFKILL_CONFIG,
+					param, ar->pdev->pdev_id);
+	if (ret) {
+		ath11k_warn(ab,
+			    "failed to set rfkill config 0x%x: %d\n",
+			    param, ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+int ath11k_mac_rfkill_enable_radio(struct ath11k *ar, bool enable)
+{
+	enum wmi_rfkill_enable_radio param;
+	int ret;
+
+	if (enable)
+		param = WMI_RFKILL_ENABLE_RADIO_ON;
+	else
+		param = WMI_RFKILL_ENABLE_RADIO_OFF;
+
+	ath11k_dbg(ar->ab, ATH11K_DBG_MAC, "mac %d rfkill enable %d",
+		   ar->pdev_idx, param);
+
+	ret = ath11k_wmi_pdev_set_param(ar, WMI_PDEV_PARAM_RFKILL_ENABLE,
+					param, ar->pdev->pdev_id);
+	if (ret) {
+		ath11k_warn(ar->ab, "failed to set rfkill enable param %d: %d\n",
+			    param, ret);
+		return ret;
+	}
+
+	return 0;
+}
+
 static void ath11k_mac_op_tx(struct ieee80211_hw *hw,
 			     struct ieee80211_tx_control *control,
 			     struct sk_buff *skb)
diff --git a/drivers/net/wireless/ath/ath11k/mac.h b/drivers/net/wireless/ath/ath11k/mac.h
index 3d4cf3c58f0b..86a186d32e99 100644
--- a/drivers/net/wireless/ath/ath11k/mac.h
+++ b/drivers/net/wireless/ath/ath11k/mac.h
@@ -144,6 +144,8 @@ u8 ath11k_mac_hw_rate_to_idx(const struct ieee80211_supported_band *sband,
 
 void __ath11k_mac_scan_finish(struct ath11k *ar);
 void ath11k_mac_scan_finish(struct ath11k *ar);
+int ath11k_mac_rfkill_enable_radio(struct ath11k *ar, bool enable);
+int ath11k_mac_rfkill_config(struct ath11k *ar);
 
 struct ath11k_vif *ath11k_mac_get_arvif(struct ath11k *ar, u32 vdev_id);
 struct ath11k_vif *ath11k_mac_get_arvif_by_vdev_id(struct ath11k_base *ab,
diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless/ath/ath11k/pci.c
index 2163f48e237a..865bf505ed5f 100644
--- a/drivers/net/wireless/ath/ath11k/pci.c
+++ b/drivers/net/wireless/ath/ath11k/pci.c
@@ -1348,6 +1348,7 @@ static void ath11k_pci_remove(struct pci_dev *pdev)
 	set_bit(ATH11K_FLAG_UNREGISTERING, &ab->dev_flags);
 
 	cancel_work_sync(&ab->update_11d_work);
+	cancel_work_sync(&ab->rfkill_work);
 	ath11k_core_deinit(ab);
 
 qmi_fail:
diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index a0a6a675ec98..aee00f1e5375 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -131,6 +131,8 @@ static const struct wmi_tlv_policy wmi_tlv_policies[] = {
 		.min_len = sizeof(struct wmi_probe_resp_tx_status_event) },
 	[WMI_TAG_VDEV_DELETE_RESP_EVENT] = {
 		.min_len = sizeof(struct wmi_vdev_delete_resp_event) },
+	[WMI_TAG_RFKILL_EVENT] = {
+		.min_len = sizeof(struct wmi_rfkill_state_change_ev) },
 };
 
 #define PRIMAP(_hw_mode_) \
@@ -486,6 +488,8 @@ static int ath11k_pull_service_ready_tlv(struct ath11k_base *ab,
 	cap->default_dbs_hw_mode_index = ev->default_dbs_hw_mode_index;
 	cap->num_msdu_desc = ev->num_msdu_desc;
 
+	ath11k_dbg(ab, ATH11K_DBG_WMI, "wmi sys cap info 0x%x\n", cap->sys_cap_info);
+
 	return 0;
 }
 
@@ -7631,6 +7635,40 @@ ath11k_wmi_pdev_dfs_radar_detected_event(struct ath11k_base *ab, struct sk_buff
 	kfree(tb);
 }
 
+static void ath11k_rfkill_state_change_event(struct ath11k_base *ab,
+					     struct sk_buff *skb)
+{
+	const struct wmi_rfkill_state_change_ev *ev;
+	const void **tb;
+	int ret;
+
+	tb = ath11k_wmi_tlv_parse_alloc(ab, skb->data, skb->len, GFP_ATOMIC);
+	if (IS_ERR(tb)) {
+		ret = PTR_ERR(tb);
+		ath11k_warn(ab, "failed to parse tlv: %d\n", ret);
+		return;
+	}
+
+	ev = tb[WMI_TAG_RFKILL_EVENT];
+	if (!ev) {
+		kfree(tb);
+		return;
+	}
+
+	ath11k_dbg(ab, ATH11K_DBG_MAC,
+		   "wmi tlv rfkill state change gpio %d type %d radio_state %d\n",
+		   ev->gpio_pin_num,
+		   ev->int_type,
+		   ev->radio_state);
+
+	spin_lock_bh(&ab->base_lock);
+	ab->rfkill_radio_on = (ev->radio_state == WMI_RFKILL_RADIO_STATE_ON);
+	spin_unlock_bh(&ab->base_lock);
+
+	queue_work(ab->workqueue, &ab->rfkill_work);
+	kfree(tb);
+}
+
 static void
 ath11k_wmi_pdev_temperature_event(struct ath11k_base *ab,
 				  struct sk_buff *skb)
@@ -7938,6 +7976,9 @@ static void ath11k_wmi_tlv_op_rx(struct ath11k_base *ab, struct sk_buff *skb)
 	case WMI_11D_NEW_COUNTRY_EVENTID:
 		ath11k_reg_11d_new_cc_event(ab, skb);
 		break;
+	case WMI_RFKILL_STATE_CHANGE_EVENTID:
+		ath11k_rfkill_state_change_event(ab, skb);
+		break;
 	/* TODO: Add remaining events */
 	default:
 		ath11k_dbg(ab, ATH11K_DBG_WMI, "Unknown eventid: 0x%x\n", id);
diff --git a/drivers/net/wireless/ath/ath11k/wmi.h b/drivers/net/wireless/ath/ath11k/wmi.h
index 40aa39ca1124..38e7eda0e1e1 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.h
+++ b/drivers/net/wireless/ath/ath11k/wmi.h
@@ -5301,6 +5301,31 @@ struct target_resource_config {
 	u8 is_reg_cc_ext_event_supported;
 };
 
+enum wmi_sys_cap_info_flags {
+	WMI_SYS_CAP_INFO_RXTX_LED	= BIT(0),
+	WMI_SYS_CAP_INFO_RFKILL	= BIT(1),
+};
+
+#define WMI_RFKILL_CFG_GPIO_PIN_NUM		GENMASK(5, 0)
+#define WMI_RFKILL_CFG_RADIO_LEVEL		BIT(6)
+#define WMI_RFKILL_CFG_PIN_AS_GPIO		GENMASK(10, 7)
+
+enum wmi_rfkill_enable_radio {
+	WMI_RFKILL_ENABLE_RADIO_ON	= 0,
+	WMI_RFKILL_ENABLE_RADIO_OFF	= 1,
+};
+
+enum wmi_rfkill_radio_state {
+	WMI_RFKILL_RADIO_STATE_OFF	= 1,
+	WMI_RFKILL_RADIO_STATE_ON	= 2,
+};
+
+struct wmi_rfkill_state_change_ev {
+	u32 gpio_pin_num;
+	u32 int_type;
+	u32 radio_state;
+} __packed;
+
 #define WMI_MAX_MEM_REQS 32
 
 #define MAX_RADIOS 3
-- 
2.31.1

