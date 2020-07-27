Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 442CA22E4B0
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Jul 2020 06:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726119AbgG0ESo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 27 Jul 2020 00:18:44 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:17987 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726064AbgG0ESn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 27 Jul 2020 00:18:43 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1595823523; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=9Cy2RtpaXex6Iq/5791SxWr74JkA6OYL1KJiBACfoIg=; b=vyI1XOI2LxfO6QFsNDoioYDhlS12kfdL4o1hgHlw2dIcMKfGfZRP3KktwbHnFcpDeyO4J/7Y
 V9WdLPblPTLB9w9nIGHL0gzC0PEndPXF1BNY8ANfF062rh//xfH+mItvd3gF3l7KkHvQMVcz
 3HNuamxaYIDkTI8s68VahxP24L8=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n09.prod.us-east-1.postgun.com with SMTP id
 5f1e5561fcbecb3df1592958 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 27 Jul 2020 04:17:37
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id CA22DC433C9; Mon, 27 Jul 2020 04:17:36 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from gongwen-ThinkPad-T420.qca.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wgong)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E2BB3C433C6;
        Mon, 27 Jul 2020 04:17:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E2BB3C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=wgong@codeaurora.org
From:   Wen Gong <wgong@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, wgong@codeaurora.org
Subject: [PATCH v2 2/2] ath10k: allow dynamic SAR power limits to be configured
Date:   Mon, 27 Jul 2020 12:17:38 +0800
Message-Id: <1595823458-3926-3-git-send-email-wgong@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1595823458-3926-1-git-send-email-wgong@codeaurora.org>
References: <1595823458-3926-1-git-send-email-wgong@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add support for a vendor command for STATION, the command
QCA_NL80211_VENDOR_SUBCMD_SET_SAR_LIMITS which is already defined in
git://w1.fi/hostap.git (src/command/qca-vendor.h). This allows user
space to configure power limits for 2.4 GHz and 5 GHz bands.

ath10k set pdev parameter WMI_PDEV_PARAM_TXPOWER_LIMIT2G and
WMI_PDEV_PARAM_TXPOWER_LIMIT5G to firmware, the 2 value will
be used as one input source to affect the tx power.

When QCA_NL80211_VENDOR_SUBCMD_SET_SAR_LIMITS set to ath10k, it will
be saved the 2.4G and 5G limit value, If STATION is connected meanwhile,
then the 2.4G and 5G WMI command will be set to firmware, otherwise
it will not set to firmware at this moment. When STATION connect
next time, it will set to firmware.

Tested with QCA6174 SDIO with firmware WLAN.RMH.4.4.1-00029.

Signed-off-by: Wen Gong <wgong@codeaurora.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
---
 drivers/net/wireless/ath/ath10k/Makefile |   1 +
 drivers/net/wireless/ath/ath10k/core.c   |   2 +
 drivers/net/wireless/ath/ath10k/core.h   |   2 +
 drivers/net/wireless/ath/ath10k/hw.h     |   3 +
 drivers/net/wireless/ath/ath10k/mac.c    |  64 +++++++++++++
 drivers/net/wireless/ath/ath10k/mac.h    |   2 +-
 drivers/net/wireless/ath/ath10k/vendor.c | 114 +++++++++++++++++++++++
 drivers/net/wireless/ath/ath10k/vendor.h |  13 +++
 8 files changed, 200 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/wireless/ath/ath10k/vendor.c
 create mode 100644 drivers/net/wireless/ath/ath10k/vendor.h

diff --git a/drivers/net/wireless/ath/ath10k/Makefile b/drivers/net/wireless/ath/ath10k/Makefile
index 142c777b287f..6cdc7eba5d25 100644
--- a/drivers/net/wireless/ath/ath10k/Makefile
+++ b/drivers/net/wireless/ath/ath10k/Makefile
@@ -13,6 +13,7 @@ ath10k_core-y += mac.o \
 		 bmi.o \
 		 hw.o \
 		 p2p.o \
+		 vendor.o \
 		 swap.o
 
 ath10k_core-$(CONFIG_ATH10K_SPECTRAL) += spectral.o
diff --git a/drivers/net/wireless/ath/ath10k/core.c b/drivers/net/wireless/ath/ath10k/core.c
index 22b6937ac225..1bab901a28ab 100644
--- a/drivers/net/wireless/ath/ath10k/core.c
+++ b/drivers/net/wireless/ath/ath10k/core.c
@@ -25,6 +25,7 @@
 #include "testmode.h"
 #include "wmi-ops.h"
 #include "coredump.h"
+#include "vendor.h"
 
 unsigned int ath10k_debug_mask;
 EXPORT_SYMBOL(ath10k_debug_mask);
@@ -191,6 +192,7 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 		.tx_stats_over_pktlog = false,
 		.bmi_large_size_download = true,
 		.supports_peer_stats_info = true,
+		.dynamic_sar_support = true,
 	},
 	{
 		.id = QCA6174_HW_2_1_VERSION,
diff --git a/drivers/net/wireless/ath/ath10k/core.h b/drivers/net/wireless/ath/ath10k/core.h
index 5c18f6c20462..c8b8e1398ead 100644
--- a/drivers/net/wireless/ath/ath10k/core.h
+++ b/drivers/net/wireless/ath/ath10k/core.h
@@ -1016,6 +1016,8 @@ struct ath10k {
 	u8 ps_state_enable;
 
 	bool nlo_enabled;
+	u32 tx_power_2g_limit;
+	u32 tx_power_5g_limit;
 	bool p2p;
 
 	struct {
diff --git a/drivers/net/wireless/ath/ath10k/hw.h b/drivers/net/wireless/ath/ath10k/hw.h
index f16edcb9f326..4bc929e3ed67 100644
--- a/drivers/net/wireless/ath/ath10k/hw.h
+++ b/drivers/net/wireless/ath/ath10k/hw.h
@@ -626,6 +626,9 @@ struct ath10k_hw_params {
 
 	/* provides bitrates for sta_statistics using WMI_TLV_PEER_STATS_INFO_EVENTID */
 	bool supports_peer_stats_info;
+
+	/* support dynamic sar */
+	bool dynamic_sar_support;
 };
 
 struct htt_rx_desc;
diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
index 3e3896214e8b..74ee81e21559 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -24,6 +24,7 @@
 #include "wmi-tlv.h"
 #include "wmi-ops.h"
 #include "wow.h"
+#include "vendor.h"
 
 /*********/
 /* Rates */
@@ -2885,6 +2886,65 @@ static int ath10k_mac_vif_recalc_txbf(struct ath10k *ar,
 	return 0;
 }
 
+static bool ath10k_mac_get_connected(struct ath10k *ar)
+{
+	struct ath10k_vif *arvif;
+
+	list_for_each_entry(arvif, &ar->arvifs, list) {
+		if (arvif->is_up && arvif->vdev_type == WMI_VDEV_TYPE_STA)
+			return true;
+	}
+
+	return false;
+}
+
+int ath10k_mac_set_sar_power_limit(struct ath10k *ar)
+{
+	u32 ret, param, pwr_limit_2G, pwr_limit_5G;
+	bool connected, tx_power_valid;
+
+	if (!ar->hw_params.dynamic_sar_support)
+		return 0;
+
+	connected = ath10k_mac_get_connected(ar);
+	tx_power_valid = (ar->tx_power_2g_limit != 0 && ar->tx_power_5g_limit != 0);
+
+	ath10k_dbg(ar, ATH10K_DBG_MAC, "mac connected %d sar power valid %d\n",
+		   connected, tx_power_valid);
+
+	if (!connected || !tx_power_valid)
+		return 0;
+
+	pwr_limit_2G = ar->tx_power_2g_limit;
+	pwr_limit_5G = ar->tx_power_5g_limit;
+
+	ath10k_dbg(ar, ATH10K_DBG_MAC, "mac sar limits max %d 2.4G %d 5G %d\n",
+		   ar->hw_max_tx_power,
+		   pwr_limit_2G,
+		   pwr_limit_5G);
+
+	param = ar->wmi.pdev_param->txpower_limit2g;
+	ret = ath10k_wmi_pdev_set_param(ar, param, pwr_limit_2G);
+	if (ret) {
+		ath10k_warn(ar, "failed to set 2.4G txpower %d: %d\n",
+			    pwr_limit_2G, ret);
+		return ret;
+	}
+	ath10k_dbg(ar, ATH10K_DBG_MAC, "mac set 2.4G txpower %d success\n", pwr_limit_2G);
+
+	param = ar->wmi.pdev_param->txpower_limit5g;
+	ret = ath10k_wmi_pdev_set_param(ar, param, pwr_limit_5G);
+	if (ret) {
+		ath10k_warn(ar, "failed to set 5G txpower %d: %d\n",
+			    pwr_limit_5G, ret);
+		return ret;
+	}
+
+	ath10k_dbg(ar, ATH10K_DBG_MAC, "mac set 5G txpower %d success\n", pwr_limit_5G);
+
+	return 0;
+}
+
 /* can be called only in mac80211 callbacks due to `key_count` usage */
 static void ath10k_bss_assoc(struct ieee80211_hw *hw,
 			     struct ieee80211_vif *vif,
@@ -2973,6 +3033,8 @@ static void ath10k_bss_assoc(struct ieee80211_hw *hw,
 
 	arvif->is_up = true;
 
+	ath10k_mac_set_sar_power_limit(ar);
+
 	/* Workaround: Some firmware revisions (tested with qca6174
 	 * WLAN.RM.2.0-00073) have buggy powersave state machine and must be
 	 * poked with peer param command.
@@ -9363,6 +9425,8 @@ int ath10k_mac_register(struct ath10k *ar)
 			NL80211_FEATURE_SCAN_RANDOM_MAC_ADDR;
 	}
 
+	ath10k_vendor_register(ar);
+
 	ar->hw->wiphy->cipher_suites = cipher_suites;
 
 	/* QCA988x and QCA6174 family chips do not support CCMP-256, GCMP-128
diff --git a/drivers/net/wireless/ath/ath10k/mac.h b/drivers/net/wireless/ath/ath10k/mac.h
index 98d83a26ea60..54c8cfcef611 100644
--- a/drivers/net/wireless/ath/ath10k/mac.h
+++ b/drivers/net/wireless/ath/ath10k/mac.h
@@ -58,7 +58,7 @@ u8 ath10k_mac_hw_rate_to_idx(const struct ieee80211_supported_band *sband,
 			     u8 hw_rate, bool cck);
 u8 ath10k_mac_bitrate_to_idx(const struct ieee80211_supported_band *sband,
 			     u32 bitrate);
-
+int ath10k_mac_set_sar_power_limit(struct ath10k *ar);
 void ath10k_mac_tx_lock(struct ath10k *ar, int reason);
 void ath10k_mac_tx_unlock(struct ath10k *ar, int reason);
 void ath10k_mac_vif_tx_lock(struct ath10k_vif *arvif, int reason);
diff --git a/drivers/net/wireless/ath/ath10k/vendor.c b/drivers/net/wireless/ath/ath10k/vendor.c
new file mode 100644
index 000000000000..755dbf7146cb
--- /dev/null
+++ b/drivers/net/wireless/ath/ath10k/vendor.c
@@ -0,0 +1,114 @@
+// SPDX-License-Identifier: ISC
+/*
+ * Copyright (c) 2019, The Linux Foundation. All rights reserved.
+ */
+
+#include <net/netlink.h>
+#include <uapi/nl80211-vnd-qca.h>
+
+#include "mac.h"
+#include "debug.h"
+#include "vendor.h"
+
+static const struct nla_policy
+sar_limits_policy[QCA_WLAN_VENDOR_ATTR_SAR_LIMITS_MAX + 1] = {
+	[QCA_WLAN_VENDOR_ATTR_SAR_LIMITS_SPEC_BAND] = {.type = NLA_U32},
+	[QCA_WLAN_VENDOR_ATTR_SAR_LIMITS_SPEC_POWER_LIMIT] = {.type = NLA_U32},
+};
+
+static int ath10k_vendor_set_dynamic_sar_power_limits(struct wiphy *wiphy,
+						      struct wireless_dev *wdev,
+						      const void *data,
+						      int data_len)
+{
+	int rem;
+	struct ieee80211_hw *hw = wiphy_to_ieee80211_hw(wiphy);
+	struct ath10k *ar = hw->priv;
+	struct nlattr *spec[QCA_WLAN_VENDOR_ATTR_SAR_LIMITS_MAX + 1];
+	struct nlattr *tb[QCA_WLAN_VENDOR_ATTR_SAR_LIMITS_MAX + 1];
+	struct nlattr *spec_list;
+	u32 limit;
+	enum nl80211_band band;
+	bool sar_valid = false;
+
+	if (!ar->hw_params.dynamic_sar_support)
+		return -ENOTSUPP;
+
+	if (nla_parse(tb, QCA_WLAN_VENDOR_ATTR_SAR_LIMITS_MAX, data, data_len,
+		      sar_limits_policy, NULL)) {
+		ath10k_warn(ar, "invalid SAR attr\n");
+		return -EINVAL;
+	}
+
+	if (!tb[QCA_WLAN_VENDOR_ATTR_SAR_LIMITS_SPEC]) {
+		ath10k_warn(ar, "invalid SAR specification list\n");
+		return -EINVAL;
+	}
+
+	nla_for_each_nested(spec_list, tb[QCA_WLAN_VENDOR_ATTR_SAR_LIMITS_SPEC], rem) {
+		if (nla_parse(spec,
+			      QCA_WLAN_VENDOR_ATTR_SAR_LIMITS_MAX,
+			      nla_data(spec_list),
+			      nla_len(spec_list),
+			      sar_limits_policy,
+			      NULL)) {
+			ath10k_warn(ar, "nla_parse failed for SAR Spec list\n");
+			return -EINVAL;
+		}
+
+		if (spec[QCA_WLAN_VENDOR_ATTR_SAR_LIMITS_SPEC_POWER_LIMIT]) {
+			limit = nla_get_u32(
+				spec[QCA_WLAN_VENDOR_ATTR_SAR_LIMITS_SPEC_POWER_LIMIT]);
+		} else {
+			ath10k_warn(ar, "not have spec power limit\n");
+			return -EINVAL;
+		}
+
+		if (spec[QCA_WLAN_VENDOR_ATTR_SAR_LIMITS_SPEC_BAND]) {
+			band = nla_get_u32(
+				spec[QCA_WLAN_VENDOR_ATTR_SAR_LIMITS_SPEC_BAND]);
+		} else {
+			/* if QCA_WLAN_VENDOR_ATTR_SAR_LIMITS_SPEC_BAND is
+			 * unset the limit applies to both bands
+			 */
+			if (limit <= ar->hw_max_tx_power) {
+				ar->tx_power_2g_limit = limit;
+				ar->tx_power_5g_limit = limit;
+				sar_valid = true;
+			}
+
+			break;
+		}
+
+		sar_valid = true;
+		if (band == NL80211_BAND_2GHZ && limit <= ar->hw_max_tx_power)
+			ar->tx_power_2g_limit = limit;
+		else if (band == NL80211_BAND_5GHZ && limit <= ar->hw_max_tx_power)
+			ar->tx_power_5g_limit = limit;
+	}
+
+	if (sar_valid)
+		return ath10k_mac_set_sar_power_limit(ar);
+
+	return 0;
+}
+
+static const struct wiphy_vendor_command ath10k_vendor_commands[] = {
+	{
+		.info = {
+			.vendor_id = QCA_NL80211_VENDOR_ID,
+			.subcmd = QCA_NL80211_VENDOR_SUBCMD_SET_SAR_LIMITS,
+		},
+		.flags = WIPHY_VENDOR_CMD_NEED_WDEV |
+			 WIPHY_VENDOR_CMD_NEED_RUNNING,
+		.doit = ath10k_vendor_set_dynamic_sar_power_limits,
+		.policy = sar_limits_policy,
+	}
+};
+
+void ath10k_vendor_register(struct ath10k *ar)
+{
+	ar->hw->wiphy->vendor_commands = ath10k_vendor_commands;
+	ar->hw->wiphy->n_vendor_commands = ARRAY_SIZE(ath10k_vendor_commands);
+}
+
diff --git a/drivers/net/wireless/ath/ath10k/vendor.h b/drivers/net/wireless/ath/ath10k/vendor.h
new file mode 100644
index 000000000000..827614cb6991
--- /dev/null
+++ b/drivers/net/wireless/ath/ath10k/vendor.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: ISC */
+/*
+ * Copyright (c) 2019 The Linux Foundation. All rights reserved.
+ */
+
+#ifndef _VENDOR_H_
+#define _VENDOR_H_
+
+#include <linux/kernel.h>
+
+void ath10k_vendor_register(struct ath10k *ar);
+
+#endif /* _VENDOR_H_ */
-- 
2.23.0

