Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 588104788B2
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Dec 2021 11:23:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232847AbhLQKXw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Dec 2021 05:23:52 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:12824 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232001AbhLQKXw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Dec 2021 05:23:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1639736632; x=1671272632;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wOMAZWMXRnHTgDK2j0vrG1FNmCs60zfnuwbEwwn/OWU=;
  b=PNWOVke/ZksFyIyy1NTRf0ntZ2V2jHIG7ZS5NpBE3zxVxncghyO6BS9P
   QTOvQZ4EtPzanYQGjMF7jKSuzNcfsNZvv1mhA85jbK/JIobStgmnQFe3Z
   7TZ7kYgc9PiqKaljiYxHmrK0//R8/H+i/rtKbeTKDwEeCn3ySHCkVfYFY
   4=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 17 Dec 2021 02:23:51 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2021 02:23:51 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Fri, 17 Dec 2021 02:23:50 -0800
Received: from wgong-HP3-Z230-SFF-Workstation.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Fri, 17 Dec 2021 02:23:48 -0800
From:   Wen Gong <quic_wgong@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <quic_wgong@quicinc.com>
Subject: [PATCH v2] ath11k: add support for hardware rfkill for QCA6390
Date:   Fri, 17 Dec 2021 05:23:34 -0500
Message-ID: <20211217102334.14907-1-quic_wgong@quicinc.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
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

Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
---
v2:
   1. rebased to ath.git ath-202112161538
   2. add hardware paramter for WCN6855 hw2.1
   3. move "cancel_work_sync(&ar->ab->rfkill_work)" from pci.c to mac.c/core.c as well as "cancel_work_sync(&ab->update_11d_work)"

 drivers/net/wireless/ath/ath11k/core.c | 70 ++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/core.h |  4 ++
 drivers/net/wireless/ath/ath11k/hw.h   |  3 ++
 drivers/net/wireless/ath/ath11k/mac.c  | 58 +++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/mac.h  |  2 +
 drivers/net/wireless/ath/ath11k/wmi.c  | 41 +++++++++++++++
 drivers/net/wireless/ath/ath11k/wmi.h  | 25 +++++++++
 7 files changed, 203 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index 606e867c36ec..b380818ef263 100644
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
@@ -113,6 +116,9 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.target_ce_count = 11,
 		.svc_to_ce_map = ath11k_target_service_to_ce_map_wlan_ipq6018,
 		.svc_to_ce_map_len = 19,
+		.rfkill_pin = 0,
+		.rfkill_cfg = 0,
+		.rfkill_on_level = 0,
 		.single_pdev_only = false,
 		.rxdma1_enable = true,
 		.num_rxmda_per_pdev = 1,
@@ -171,6 +177,9 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.target_ce_count = 9,
 		.svc_to_ce_map = ath11k_target_service_to_ce_map_wlan_qca6390,
 		.svc_to_ce_map_len = 14,
+		.rfkill_pin = 48,
+		.rfkill_cfg = 0,
+		.rfkill_on_level = 1,
 		.single_pdev_only = true,
 		.rxdma1_enable = false,
 		.num_rxmda_per_pdev = 2,
@@ -228,6 +237,9 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.target_ce_count = 9,
 		.svc_to_ce_map = ath11k_target_service_to_ce_map_wlan_qcn9074,
 		.svc_to_ce_map_len = 18,
+		.rfkill_pin = 0,
+		.rfkill_cfg = 0,
+		.rfkill_on_level = 0,
 		.rxdma1_enable = true,
 		.num_rxmda_per_pdev = 1,
 		.rx_mac_buf_ring = false,
@@ -285,6 +297,9 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.target_ce_count = 9,
 		.svc_to_ce_map = ath11k_target_service_to_ce_map_wlan_qca6390,
 		.svc_to_ce_map_len = 14,
+		.rfkill_pin = 0,
+		.rfkill_cfg = 0,
+		.rfkill_on_level = 0,
 		.single_pdev_only = true,
 		.rxdma1_enable = false,
 		.num_rxmda_per_pdev = 2,
@@ -342,6 +357,9 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.target_ce_count = 9,
 		.svc_to_ce_map = ath11k_target_service_to_ce_map_wlan_qca6390,
 		.svc_to_ce_map_len = 14,
+		.rfkill_pin = 0,
+		.rfkill_cfg = 0,
+		.rfkill_on_level = 0,
 		.single_pdev_only = true,
 		.rxdma1_enable = false,
 		.num_rxmda_per_pdev = 2,
@@ -1009,6 +1027,27 @@ static int ath11k_core_start(struct ath11k_base *ab,
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
@@ -1055,6 +1094,13 @@ int ath11k_core_qmi_firmware_ready(struct ath11k_base *ab)
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
@@ -1120,6 +1166,7 @@ void ath11k_core_halt(struct ath11k *ar)
 	cancel_delayed_work_sync(&ar->scan.timeout);
 	cancel_work_sync(&ar->regd_update_work);
 	cancel_work_sync(&ab->update_11d_work);
+	cancel_work_sync(&ab->rfkill_work);
 
 	rcu_assign_pointer(ab->pdevs_active[ar->pdev_idx], NULL);
 	synchronize_rcu();
@@ -1127,6 +1174,28 @@ void ath11k_core_halt(struct ath11k *ar)
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
@@ -1333,6 +1402,7 @@ struct ath11k_base *ath11k_core_alloc(struct device *dev, size_t priv_size,
 	init_waitqueue_head(&ab->qmi.cold_boot_waitq);
 	INIT_WORK(&ab->restart_work, ath11k_core_restart);
 	INIT_WORK(&ab->update_11d_work, ath11k_update_11d);
+	INIT_WORK(&ab->rfkill_work, ath11k_rfkill_work);
 	timer_setup(&ab->rx_replenish_retry, ath11k_ce_rx_replenish_retry, 0);
 	init_completion(&ab->htc_suspend);
 	init_completion(&ab->wow.wakeup_completed);
diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index bab3878a41a7..32b47e7016aa 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -779,6 +779,10 @@ struct ath11k_base {
 
 	struct ath11k_dbring_cap *db_caps;
 	u32 num_db_cap;
+	struct work_struct rfkill_work;
+
+	/* true means radio is on */
+	bool rfkill_radio_on;
 
 	/* To synchronize 11d scan vdev id */
 	struct mutex vdev_id_11d_lock;
diff --git a/drivers/net/wireless/ath/ath11k/hw.h b/drivers/net/wireless/ath/ath11k/hw.h
index 23f3ce741636..657e6bed6c88 100644
--- a/drivers/net/wireless/ath/ath11k/hw.h
+++ b/drivers/net/wireless/ath/ath11k/hw.h
@@ -151,6 +151,9 @@ struct ath11k_hw_params {
 	u32 svc_to_ce_map_len;
 
 	bool single_pdev_only;
+	u32 rfkill_pin;
+	u32 rfkill_cfg;
+	u32 rfkill_on_level;
 
 	bool rxdma1_enable;
 	int num_rxmda_per_pdev;
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 2bc93456b34e..15b1666f3929 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -5478,6 +5478,63 @@ static int ath11k_mac_mgmt_tx(struct ath11k *ar, struct sk_buff *skb,
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
@@ -5710,6 +5767,7 @@ static void ath11k_mac_op_stop(struct ieee80211_hw *hw)
 	cancel_delayed_work_sync(&ar->scan.timeout);
 	cancel_work_sync(&ar->regd_update_work);
 	cancel_work_sync(&ar->ab->update_11d_work);
+	cancel_work_sync(&ar->ab->rfkill_work);
 
 	spin_lock_bh(&ar->data_lock);
 	list_for_each_entry_safe(ppdu_stats, tmp, &ar->ppdu_stats_info, list) {
diff --git a/drivers/net/wireless/ath/ath11k/mac.h b/drivers/net/wireless/ath/ath11k/mac.h
index 035d6738c20b..7666b90798bf 100644
--- a/drivers/net/wireless/ath/ath11k/mac.h
+++ b/drivers/net/wireless/ath/ath11k/mac.h
@@ -147,6 +147,8 @@ u8 ath11k_mac_hw_rate_to_idx(const struct ieee80211_supported_band *sband,
 
 void __ath11k_mac_scan_finish(struct ath11k *ar);
 void ath11k_mac_scan_finish(struct ath11k *ar);
+int ath11k_mac_rfkill_enable_radio(struct ath11k *ar, bool enable);
+int ath11k_mac_rfkill_config(struct ath11k *ar);
 
 struct ath11k_vif *ath11k_mac_get_arvif(struct ath11k *ar, u32 vdev_id);
 struct ath11k_vif *ath11k_mac_get_arvif_by_vdev_id(struct ath11k_base *ab,
diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index 2b4d27d807ab..71fa428c6079 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -120,6 +120,8 @@ static const struct wmi_tlv_policy wmi_tlv_policies[] = {
 		= { .min_len = sizeof(struct wmi_peer_assoc_conf_event) },
 	[WMI_TAG_STATS_EVENT]
 		= { .min_len = sizeof(struct wmi_stats_event) },
+	[WMI_TAG_RFKILL_EVENT] = {
+		.min_len = sizeof(struct wmi_rfkill_state_change_ev) },
 	[WMI_TAG_PDEV_CTL_FAILSAFE_CHECK_EVENT]
 		= { .min_len = sizeof(struct wmi_pdev_ctl_failsafe_chk_event) },
 	[WMI_TAG_HOST_SWFDA_EVENT] = {
@@ -514,6 +516,8 @@ static int ath11k_pull_service_ready_tlv(struct ath11k_base *ab,
 	cap->default_dbs_hw_mode_index = ev->default_dbs_hw_mode_index;
 	cap->num_msdu_desc = ev->num_msdu_desc;
 
+	ath11k_dbg(ab, ATH11K_DBG_WMI, "wmi sys cap info 0x%x\n", cap->sys_cap_info);
+
 	return 0;
 }
 
@@ -7182,6 +7186,40 @@ ath11k_wmi_pdev_dfs_radar_detected_event(struct ath11k_base *ab, struct sk_buff
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
@@ -7454,6 +7492,9 @@ static void ath11k_wmi_tlv_op_rx(struct ath11k_base *ab, struct sk_buff *skb)
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
index d79eb1b7d9c2..ace8cb6f6502 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.h
+++ b/drivers/net/wireless/ath/ath11k/wmi.h
@@ -5204,6 +5204,31 @@ struct target_resource_config {
 	u32 twt_ap_sta_count;
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

base-commit: 12018ad8603a598d773e2cae12542a1981c94886
-- 
2.31.1

