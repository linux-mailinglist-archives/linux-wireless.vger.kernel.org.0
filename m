Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50A5A24F3FD
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Aug 2020 10:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726158AbgHXI1T (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 24 Aug 2020 04:27:19 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:30928 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725926AbgHXI1S (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 24 Aug 2020 04:27:18 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1598257636; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=kSYKj3sDduvYZ2q8CqjX3iznXkoq9FGi3EhTpdF9NV0=; b=sKo3b3Q1FiutMDrry6eVSi8LFSSqjpCatGVLWoMpCq/ZOfqHfcVhEuNLrjjT0uVY7PFPahHY
 eWh+YUbZP2uO03zaZhd6hztObiKg74vksxBQYtwHlAEYxvGLsmn5bx1vKvvwiRWnhnWz0kLX
 TrEYpHTai5PZfTLoNrxKVDNF/Ho=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 5f4379c56704ba80964294f1 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 24 Aug 2020 08:26:45
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B674CC433CB; Mon, 24 Aug 2020 08:26:44 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vnaralas-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vnaralas)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 042F7C43387;
        Mon, 24 Aug 2020 08:26:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 042F7C43387
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=vnaralas@codeaurora.org
From:   Venkateswara Naralasetty <vnaralas@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Venkateswara Naralasetty <vnaralas@codeaurora.org>
Subject: [PATCHv2 2/2] ath11k: Add ap power save support
Date:   Mon, 24 Aug 2020 13:56:29 +0530
Message-Id: <1598257589-19091-2-git-send-email-vnaralas@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1598257589-19091-1-git-send-email-vnaralas@codeaurora.org>
References: <1598257589-19091-1-git-send-email-vnaralas@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

AP power save where AP goes to power save mode when no stations associate
to it and come out of power save when any station associate to AP.

This AP power save capability can be used to save power with the drawback
of reduced range or delayed discovery of the AP

This patch also porvides user configuration to enable/disable
this feature using vendor command. This feature is disabled by default.

Tested-on: IPQ8074 WLAN.HK.2.1.0.1-01228-QCAHKSWPL_SILICONZ-1

Signed-off-by: Venkateswara Naralasetty <vnaralas@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/Makefile |  3 +-
 drivers/net/wireless/ath/ath11k/core.h   |  8 ++++
 drivers/net/wireless/ath/ath11k/mac.c    | 44 +++++++++++++++++
 drivers/net/wireless/ath/ath11k/mac.h    |  1 +
 drivers/net/wireless/ath/ath11k/vendor.c | 81 ++++++++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/vendor.h | 12 +++++
 drivers/net/wireless/ath/ath11k/wmi.c    | 32 +++++++++++++
 drivers/net/wireless/ath/ath11k/wmi.h    |  7 +++
 8 files changed, 187 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/wireless/ath/ath11k/vendor.c
 create mode 100644 drivers/net/wireless/ath/ath11k/vendor.h

diff --git a/drivers/net/wireless/ath/ath11k/Makefile b/drivers/net/wireless/ath/ath11k/Makefile
index bc4911f..f0b4975 100644
--- a/drivers/net/wireless/ath/ath11k/Makefile
+++ b/drivers/net/wireless/ath/ath11k/Makefile
@@ -16,7 +16,8 @@ ath11k-y += core.o \
 	    ce.o \
 	    peer.o \
 	    dbring.o \
-	    hw.o
+	    hw.o \
+	    vendor.o
 
 ath11k-$(CONFIG_ATH11K_DEBUGFS) += debug_htt_stats.o debugfs_sta.o
 ath11k-$(CONFIG_NL80211_TESTMODE) += testmode.o
diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index d21191c..827020f 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -23,6 +23,7 @@
 #include "thermal.h"
 #include "dbring.h"
 #include "spectral.h"
+#include "vendor.h"
 
 #define SM(_v, _f) (((_v) << _f##_LSB) & _f##_MASK)
 
@@ -419,6 +420,11 @@ struct ath11k_vdev_stop_status {
 	u32  vdev_id;
 };
 
+enum ath11k_ap_ps_state {
+	ATH11K_AP_PS_STATE_OFF,
+	ATH11K_AP_PS_STATE_ON,
+};
+
 struct ath11k {
 	struct ath11k_base *ab;
 	struct ath11k_pdev *pdev;
@@ -543,6 +549,8 @@ struct ath11k {
 #endif
 	bool dfs_block_radar_events;
 	struct ath11k_thermal thermal;
+	int ap_ps_enabled;
+	enum ath11k_ap_ps_state ap_ps_state;
 };
 
 struct ath11k_band_cap {
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index f4a085b..1885834 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -2898,6 +2898,33 @@ static void ath11k_mac_dec_num_stations(struct ath11k_vif *arvif,
 	ar->num_stations--;
 }
 
+int ath11k_mac_ap_ps_recalc(struct ath11k *ar)
+{
+	struct ath11k_vif *arvif;
+	bool has_sta_iface = false;
+	enum ath11k_ap_ps_state state = ATH11K_AP_PS_STATE_OFF;
+	int ret = 0;
+
+	list_for_each_entry(arvif, &ar->arvifs, list) {
+		if (arvif->vdev_type == WMI_VDEV_TYPE_STA) {
+			has_sta_iface = true;
+			break;
+		}
+	}
+
+	if (!has_sta_iface && !ar->num_stations && ar->ap_ps_enabled)
+		state = ATH11K_AP_PS_STATE_ON;
+
+	if (ar->ap_ps_state == state)
+		return ret;
+
+	ret = ath11k_wmi_pdev_ap_ps_cmd_send(ar, ar->pdev->pdev_id, state);
+	if (!ret)
+		ar->ap_ps_state = state;
+
+	return ret;
+}
+
 static int ath11k_mac_station_add(struct ath11k *ar,
 				  struct ieee80211_vif *vif,
 				  struct ieee80211_sta *sta)
@@ -2937,6 +2964,12 @@ static int ath11k_mac_station_add(struct ath11k *ar,
 	ath11k_dbg(ab, ATH11K_DBG_MAC, "Added peer: %pM for VDEV: %d\n",
 		   sta->addr, arvif->vdev_id);
 
+	ret = ath11k_mac_ap_ps_recalc(ar);
+	if (ret) {
+		ath11k_warn(ar->ab, "failed to send ap ps ret %d\n", ret);
+		goto exit;
+	}
+
 	if (ath11k_debug_is_extd_tx_stats_enabled(ar)) {
 		arsta->tx_stats = kzalloc(sizeof(*arsta->tx_stats), GFP_KERNEL);
 		if (!arsta->tx_stats) {
@@ -3046,6 +3079,10 @@ static int ath11k_mac_op_sta_state(struct ieee80211_hw *hw,
 
 		kfree(arsta->rx_stats);
 		arsta->rx_stats = NULL;
+
+		ret = ath11k_mac_ap_ps_recalc(ar);
+		if (ret)
+			ath11k_warn(ar->ab, "failed to send ap ps ret %d\n", ret);
 	} else if (old_state == IEEE80211_STA_AUTH &&
 		   new_state == IEEE80211_STA_ASSOC &&
 		   (vif->type == NL80211_IFTYPE_AP ||
@@ -4210,6 +4247,7 @@ static void ath11k_mac_op_stop(struct ieee80211_hw *hw)
 
 	clear_bit(ATH11K_CAC_RUNNING, &ar->dev_flags);
 	ar->state = ATH11K_STATE_OFF;
+	ar->ap_ps_state = ATH11K_AP_PS_STATE_OFF;
 	mutex_unlock(&ar->conf_mutex);
 
 	cancel_delayed_work_sync(&ar->scan.timeout);
@@ -4533,6 +4571,10 @@ static int ath11k_mac_op_add_interface(struct ieee80211_hw *hw,
 
 	ath11k_dp_vdev_tx_attach(ar, arvif);
 
+	ret = ath11k_mac_ap_ps_recalc(ar);
+	if (ret)
+		ath11k_warn(ar->ab, "failed to set ap ps ret %d\n", ret);
+
 	mutex_unlock(&ar->conf_mutex);
 
 	return 0;
@@ -4619,6 +4661,7 @@ static void ath11k_mac_op_remove_interface(struct ieee80211_hw *hw,
 
 	/* Recalc txpower for remaining vdev */
 	ath11k_mac_txpower_recalc(ar);
+	ath11k_mac_ap_ps_recalc(ar);
 	clear_bit(ATH11K_FLAG_MONITOR_ENABLED, &ar->monitor_flags);
 
 	/* TODO: recal traffic pause state based on the available vdevs */
@@ -6175,6 +6218,7 @@ static int __ath11k_mac_register(struct ath11k *ar)
 		ARRAY_SIZE(ath11k_iftypes_ext_capa);
 
 	ath11k_reg_init(ar);
+	ath11k_vendor_register(ar);
 
 	/* advertise HW checksum offload capabilities */
 	ar->hw->netdev_features = NETIF_F_HW_CSUM;
diff --git a/drivers/net/wireless/ath/ath11k/mac.h b/drivers/net/wireless/ath/ath11k/mac.h
index 0607479..18d2f28 100644
--- a/drivers/net/wireless/ath/ath11k/mac.h
+++ b/drivers/net/wireless/ath/ath11k/mac.h
@@ -146,4 +146,5 @@ int ath11k_mac_tx_mgmt_pending_free(int buf_id, void *skb, void *ctx);
 u8 ath11k_mac_bw_to_mac80211_bw(u8 bw);
 enum ath11k_supported_bw ath11k_mac_mac80211_bw_to_ath11k_bw(enum rate_info_bw bw);
 enum hal_encrypt_type ath11k_dp_tx_get_encrypt_type(u32 cipher);
+int ath11k_mac_ap_ps_recalc(struct ath11k *ar);
 #endif
diff --git a/drivers/net/wireless/ath/ath11k/vendor.c b/drivers/net/wireless/ath/ath11k/vendor.c
new file mode 100644
index 0000000..b28cc65
--- /dev/null
+++ b/drivers/net/wireless/ath/ath11k/vendor.c
@@ -0,0 +1,81 @@
+// SPDX-License-Identifier: BSD-3-Clause-Clear
+/*
+ * Copyright (c) 2019-2020 The Linux Foundation. All rights reserved.
+ */
+
+#include <net/netlink.h>
+#include <net/mac80211.h>
+#include <uapi/nl80211-vnd-qca.h>
+#include "core.h"
+#include "debug.h"
+
+static const struct nla_policy
+ath11k_vendor_set_wifi_config_policy[QCA_WLAN_VENDOR_ATTR_CONFIG_MAX + 1] = {
+	[QCA_WLAN_VENDOR_ATTR_CONFIG_GTX] = {.type = NLA_FLAG}
+};
+
+static int ath11k_vendor_set_wifi_config(struct wiphy *wihpy,
+					 struct wireless_dev *wdev,
+					 const void *data,
+					 int data_len)
+{
+	struct ieee80211_vif *vif;
+	struct ath11k_vif *arvif;
+	struct ath11k *ar;
+	struct nlattr *tb[QCA_WLAN_VENDOR_ATTR_CONFIG_MAX + 1];
+	int ret = 0;
+
+	if (!wdev)
+		return -EINVAL;
+
+	vif = wdev_to_ieee80211_vif(wdev);
+	if (!vif)
+		return -EINVAL;
+
+	arvif = (struct ath11k_vif *)vif->drv_priv;
+	if (!arvif)
+		return -EINVAL;
+
+	ar = arvif->ar;
+
+	mutex_lock(&ar->conf_mutex);
+
+	ret = nla_parse(tb, QCA_WLAN_VENDOR_ATTR_CONFIG_MAX, data, data_len,
+			ath11k_vendor_set_wifi_config_policy, NULL);
+	if (ret) {
+		ath11k_warn(ar->ab, "invalid set wifi config policy attribute\n");
+		goto exit;
+	}
+
+	ar->ap_ps_enabled = nla_get_flag(tb[QCA_WLAN_VENDOR_ATTR_CONFIG_GTX]);
+	ret = ath11k_mac_ap_ps_recalc(ar);
+	if (ret) {
+		ath11k_warn(ar->ab, "failed to send ap ps ret %d\n", ret);
+		goto exit;
+	}
+
+exit:
+	mutex_unlock(&ar->conf_mutex);
+	return ret;
+}
+
+static struct wiphy_vendor_command ath11k_vendor_commands[] = {
+	{
+		.info.vendor_id = QCA_NL80211_VENDOR_ID,
+		.info.subcmd = QCA_NL80211_VENDOR_SUBCMD_SET_WIFI_CONFIGURATION,
+		.flags = WIPHY_VENDOR_CMD_NEED_WDEV |
+			WIPHY_VENDOR_CMD_NEED_RUNNING,
+		.doit = ath11k_vendor_set_wifi_config,
+		.policy = ath11k_vendor_set_wifi_config_policy,
+		.maxattr = QCA_WLAN_VENDOR_ATTR_CONFIG_MAX
+	}
+};
+
+int ath11k_vendor_register(struct ath11k *ar)
+{
+	ar->hw->wiphy->vendor_commands = ath11k_vendor_commands;
+	ar->hw->wiphy->n_vendor_commands = ARRAY_SIZE(ath11k_vendor_commands);
+
+	return 0;
+}
+
diff --git a/drivers/net/wireless/ath/ath11k/vendor.h b/drivers/net/wireless/ath/ath11k/vendor.h
new file mode 100644
index 0000000..6eaf07e
--- /dev/null
+++ b/drivers/net/wireless/ath/ath11k/vendor.h
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: BSD-3-Clause-Clear
+/*
+ * Copyright (c) 2019-2020 The Linux Foundation. All rights reserved.
+ */
+
+#ifndef ATH11K_VENDOR_H
+#define ATH11K_VENDOR_H
+
+int ath11k_vendor_register(struct ath11k *ar);
+
+#endif /* QCA_VENDOR_H */
+
diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index a66576f..9aa1718 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -1188,6 +1188,38 @@ ath11k_wmi_rx_reord_queue_remove(struct ath11k *ar,
 	return ret;
 }
 
+int ath11k_wmi_pdev_ap_ps_cmd_send(struct ath11k *ar, u8 pdev_id,
+				   u32 param_value)
+{
+	struct ath11k_pdev_wmi *wmi = ar->wmi;
+	struct wmi_pdev_ap_ps_cmd *cmd;
+	struct sk_buff *skb;
+	int ret;
+
+	skb = ath11k_wmi_alloc_skb(wmi->wmi_ab, sizeof(*cmd));
+	if (!skb)
+		return -ENOMEM;
+
+	cmd = (struct wmi_pdev_ap_ps_cmd *)skb->data;
+	cmd->tlv_header = FIELD_PREP(WMI_TLV_TAG,
+				     WMI_TAG_PDEV_GREEN_AP_PS_ENABLE_CMD) |
+			  FIELD_PREP(WMI_TLV_LEN, sizeof(*cmd) - TLV_HDR_SIZE);
+	cmd->pdev_id = pdev_id;
+	cmd->param_value = param_value;
+
+	ret = ath11k_wmi_cmd_send(wmi, skb, WMI_PDEV_GREEN_AP_PS_ENABLE_CMDID);
+	if (ret) {
+		ath11k_warn(ar->ab, "failed to send ap ps enable/disable cmd\n");
+		dev_kfree_skb(skb);
+	}
+
+	ath11k_dbg(ar->ab, ATH11K_DBG_WMI,
+		   "wmi pdev ap ps set pdev id %d value %d\n",
+		   pdev_id, param_value);
+
+	return ret;
+}
+
 int ath11k_wmi_pdev_set_param(struct ath11k *ar, u32 param_id,
 			      u32 param_value, u8 pdev_id)
 {
diff --git a/drivers/net/wireless/ath/ath11k/wmi.h b/drivers/net/wireless/ath/ath11k/wmi.h
index 5a32ba0..e3a5751 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.h
+++ b/drivers/net/wireless/ath/ath11k/wmi.h
@@ -2901,6 +2901,12 @@ struct set_fwtest_params {
 	u32 value;
 };
 
+struct wmi_pdev_ap_ps_cmd {
+	u32 tlv_header;
+	u32 pdev_id;
+	u32 param_value;
+} __packed;
+
 struct wmi_fwtest_set_param_cmd_param {
 	u32 tlv_header;
 	u32 param_id;
@@ -5121,4 +5127,5 @@ int ath11k_wmi_vdev_spectral_enable(struct ath11k *ar, u32 vdev_id,
 				    u32 trigger, u32 enable);
 int ath11k_wmi_vdev_spectral_conf(struct ath11k *ar,
 				  struct ath11k_wmi_vdev_spectral_conf_param *param);
+int ath11k_wmi_pdev_ap_ps_cmd_send(struct ath11k *ar, u8 pdev_id, u32 value);
 #endif
-- 
2.7.4

