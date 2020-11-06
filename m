Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF9472A93AF
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Nov 2020 11:07:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbgKFKH3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 6 Nov 2020 05:07:29 -0500
Received: from m42-4.mailgun.net ([69.72.42.4]:39903 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726775AbgKFKH0 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 6 Nov 2020 05:07:26 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1604657245; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=wg640FwDBlqtspkjM3RS0/PBee2pfxR+OMvzAYJz4d4=; b=eN/eQ4NHX2thU7TqrKqgKhmysj79o/CATyV5EwCKMy82P5NQz3+p2S2GRVTUTsZwioocOdth
 xhCgz3xJea01uy9vSoth0mTvHB4qOiUB+/a2pWO5Wxi7qHXrIAmkzbVphKZ7cekQv+ynAuQx
 +JrdQvnHuJkThzEro8b+/ZbqqDc=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 5fa5205ca39cfb5f6c337ce8 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 06 Nov 2020 10:07:24
 GMT
Sender: cjhuang=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E7396C43382; Fri,  6 Nov 2020 10:07:23 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from cjhuang-Inspiron-7590.qca.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: cjhuang)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E1682C433C8;
        Fri,  6 Nov 2020 10:07:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E1682C433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=cjhuang@codeaurora.org
From:   Carl Huang <cjhuang@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, briannorris@chromium.org,
        dianders@chromium.org, kuabhs@google.com
Subject: [PATCH 3/3] ath10k: allow dynamic SAR power limits via common API
Date:   Fri,  6 Nov 2020 05:07:08 -0500
Message-Id: <20201106100708.4609-4-cjhuang@codeaurora.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201106100708.4609-1-cjhuang@codeaurora.org>
References: <20201106100708.4609-1-cjhuang@codeaurora.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

ath10k assigns ath10k_mac_set_sar_specs to ath10k_ops, and
this function is called when user space application calls
NL80211_CMD_SET_SAR_SPECS. ath10k also registers SAR type,
and supported frequency ranges to wiphy so user space can
query SAR capabilities.

This SAR power limitation is compared to regulatory txpower
and selects the minimal one to set when station is connected.
Otherwise, it delays until the station is connected. If the
station is disconnected, it returns to regulatory txpower.

This feature is controlled by hw parameter: dynamic_sar_support.

Tested-on: QCA6174 hw3.2 PCI WLAN.RM.4.4.1-00110-QCARMSWP-1

Signed-off-by: Carl Huang <cjhuang@codeaurora.org>
---
 drivers/net/wireless/ath/ath10k/core.c |  16 +++
 drivers/net/wireless/ath/ath10k/core.h |   3 +
 drivers/net/wireless/ath/ath10k/hw.h   |   2 +
 drivers/net/wireless/ath/ath10k/mac.c  | 221 ++++++++++++++++++++++++---------
 4 files changed, 183 insertions(+), 59 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/core.c b/drivers/net/wireless/ath/ath10k/core.c
index 5f4e121..fe53ca9 100644
--- a/drivers/net/wireless/ath/ath10k/core.c
+++ b/drivers/net/wireless/ath/ath10k/core.c
@@ -90,6 +90,7 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 		.hw_filter_reset_required = true,
 		.fw_diag_ce_download = false,
 		.tx_stats_over_pktlog = true,
+		.dynamic_sar_support = false,
 	},
 	{
 		.id = QCA988X_HW_2_0_VERSION,
@@ -124,6 +125,7 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 		.hw_filter_reset_required = true,
 		.fw_diag_ce_download = false,
 		.tx_stats_over_pktlog = true,
+		.dynamic_sar_support = false,
 	},
 	{
 		.id = QCA9887_HW_1_0_VERSION,
@@ -159,6 +161,7 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 		.hw_filter_reset_required = true,
 		.fw_diag_ce_download = false,
 		.tx_stats_over_pktlog = false,
+		.dynamic_sar_support = false,
 	},
 	{
 		.id = QCA6174_HW_3_2_VERSION,
@@ -189,6 +192,7 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 		.tx_stats_over_pktlog = false,
 		.bmi_large_size_download = true,
 		.supports_peer_stats_info = true,
+		.dynamic_sar_support = true,
 	},
 	{
 		.id = QCA6174_HW_2_1_VERSION,
@@ -223,6 +227,7 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 		.hw_filter_reset_required = true,
 		.fw_diag_ce_download = false,
 		.tx_stats_over_pktlog = false,
+		.dynamic_sar_support = false,
 	},
 	{
 		.id = QCA6174_HW_2_1_VERSION,
@@ -257,6 +262,7 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 		.hw_filter_reset_required = true,
 		.fw_diag_ce_download = false,
 		.tx_stats_over_pktlog = false,
+		.dynamic_sar_support = false,
 	},
 	{
 		.id = QCA6174_HW_3_0_VERSION,
@@ -291,6 +297,7 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 		.hw_filter_reset_required = true,
 		.fw_diag_ce_download = false,
 		.tx_stats_over_pktlog = false,
+		.dynamic_sar_support = false,
 	},
 	{
 		.id = QCA6174_HW_3_2_VERSION,
@@ -329,6 +336,7 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 		.fw_diag_ce_download = true,
 		.tx_stats_over_pktlog = false,
 		.supports_peer_stats_info = true,
+		.dynamic_sar_support = true,
 	},
 	{
 		.id = QCA99X0_HW_2_0_DEV_VERSION,
@@ -369,6 +377,7 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 		.hw_filter_reset_required = true,
 		.fw_diag_ce_download = false,
 		.tx_stats_over_pktlog = false,
+		.dynamic_sar_support = false,
 	},
 	{
 		.id = QCA9984_HW_1_0_DEV_VERSION,
@@ -416,6 +425,7 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 		.hw_filter_reset_required = true,
 		.fw_diag_ce_download = false,
 		.tx_stats_over_pktlog = false,
+		.dynamic_sar_support = false,
 	},
 	{
 		.id = QCA9888_HW_2_0_DEV_VERSION,
@@ -460,6 +470,7 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 		.hw_filter_reset_required = true,
 		.fw_diag_ce_download = false,
 		.tx_stats_over_pktlog = false,
+		.dynamic_sar_support = false,
 	},
 	{
 		.id = QCA9377_HW_1_0_DEV_VERSION,
@@ -494,6 +505,7 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 		.hw_filter_reset_required = true,
 		.fw_diag_ce_download = false,
 		.tx_stats_over_pktlog = false,
+		.dynamic_sar_support = false,
 	},
 	{
 		.id = QCA9377_HW_1_1_DEV_VERSION,
@@ -530,6 +542,7 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 		.hw_filter_reset_required = true,
 		.fw_diag_ce_download = true,
 		.tx_stats_over_pktlog = false,
+		.dynamic_sar_support = false,
 	},
 	{
 		.id = QCA9377_HW_1_1_DEV_VERSION,
@@ -557,6 +570,7 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 		.ast_skid_limit = 0x10,
 		.num_wds_entries = 0x20,
 		.uart_pin_workaround = true,
+		.dynamic_sar_support = false,
 	},
 	{
 		.id = QCA4019_HW_1_0_DEV_VERSION,
@@ -598,6 +612,7 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 		.hw_filter_reset_required = true,
 		.fw_diag_ce_download = false,
 		.tx_stats_over_pktlog = false,
+		.dynamic_sar_support = false,
 	},
 	{
 		.id = WCN3990_HW_1_0_DEV_VERSION,
@@ -625,6 +640,7 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 		.hw_filter_reset_required = false,
 		.fw_diag_ce_download = false,
 		.tx_stats_over_pktlog = false,
+		.dynamic_sar_support = true,
 	},
 };
 
diff --git a/drivers/net/wireless/ath/ath10k/core.h b/drivers/net/wireless/ath/ath10k/core.h
index 4cf5bd4..f90c34a 100644
--- a/drivers/net/wireless/ath/ath10k/core.h
+++ b/drivers/net/wireless/ath/ath10k/core.h
@@ -1281,6 +1281,9 @@ struct ath10k {
 	bool coex_support;
 	int coex_gpio_pin;
 
+	u32 tx_power_2g_limit;
+	u32 tx_power_5g_limit;
+
 	/* must be last */
 	u8 drv_priv[] __aligned(sizeof(void *));
 };
diff --git a/drivers/net/wireless/ath/ath10k/hw.h b/drivers/net/wireless/ath/ath10k/hw.h
index c6ded21..6b03c77 100644
--- a/drivers/net/wireless/ath/ath10k/hw.h
+++ b/drivers/net/wireless/ath/ath10k/hw.h
@@ -623,6 +623,8 @@ struct ath10k_hw_params {
 
 	/* provides bitrates for sta_statistics using WMI_TLV_PEER_STATS_INFO_EVENTID */
 	bool supports_peer_stats_info;
+
+	bool dynamic_sar_support;
 };
 
 struct htt_rx_desc;
diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
index 2e3eb5b..c86a90c 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -81,6 +81,17 @@ static struct ieee80211_rate ath10k_rates_rev2[] = {
 	{ .bitrate = 540, .hw_value = ATH10K_HW_RATE_OFDM_54M },
 };
 
+const static struct cfg80211_sar_freq_ranges ath10k_sar_freq_ranges[] = {
+	{.start_freq = 2402, .end_freq = 2494 },
+	{.start_freq = 5170, .end_freq = 5875 },
+};
+
+const static struct cfg80211_sar_capa ath10k_sar_capa = {
+	.type = NL80211_SAR_TYPE_POWER,
+	.num_freq_ranges = (ARRAY_SIZE(ath10k_sar_freq_ranges)),
+	.freq_ranges = &ath10k_sar_freq_ranges[0],
+};
+
 #define ATH10K_MAC_FIRST_OFDM_RATE_IDX 4
 
 #define ath10k_a_rates (ath10k_rates + ATH10K_MAC_FIRST_OFDM_RATE_IDX)
@@ -2880,6 +2891,149 @@ static int ath10k_mac_vif_recalc_txbf(struct ath10k *ar,
 	return 0;
 }
 
+static bool ath10k_mac_is_connected(struct ath10k *ar)
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
+static int ath10k_mac_txpower_setup(struct ath10k *ar, int txpower)
+{
+	int ret;
+	u32 param;
+	int tx_power_2g, tx_power_5g;
+	bool connected;
+
+	lockdep_assert_held(&ar->conf_mutex);
+
+	/* ath10k internally uses unit of 0.5 dBm so multiply by 2 */
+	tx_power_2g = txpower * 2;
+	tx_power_5g = txpower * 2;
+
+	connected = ath10k_mac_is_connected(ar);
+
+	if (connected && ar->tx_power_2g_limit)
+		if (tx_power_2g > ar->tx_power_2g_limit)
+			tx_power_2g = ar->tx_power_2g_limit;
+
+	if (connected && ar->tx_power_5g_limit)
+		if (tx_power_5g > ar->tx_power_5g_limit)
+			tx_power_5g = ar->tx_power_5g_limit;
+
+	ath10k_dbg(ar, ATH10K_DBG_MAC, "mac txpower 2g:%d 5g:%d\n",
+		   tx_power_2g, tx_power_5g);
+
+	param = ar->wmi.pdev_param->txpower_limit2g;
+	ret = ath10k_wmi_pdev_set_param(ar, param, tx_power_2g);
+	if (ret) {
+		ath10k_warn(ar, "failed to set 2g txpower %d: %d\n",
+			    tx_power_2g, ret);
+		return ret;
+	}
+
+	param = ar->wmi.pdev_param->txpower_limit5g;
+	ret = ath10k_wmi_pdev_set_param(ar, param, tx_power_5g);
+	if (ret) {
+		ath10k_warn(ar, "failed to set 5g txpower %d: %d\n",
+			    tx_power_5g, ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int ath10k_mac_txpower_recalc(struct ath10k *ar)
+{
+	struct ath10k_vif *arvif;
+	int ret, txpower = -1;
+
+	lockdep_assert_held(&ar->conf_mutex);
+
+	list_for_each_entry(arvif, &ar->arvifs, list) {
+		/* txpower not initialized yet? */
+		if (arvif->txpower == INT_MIN)
+			continue;
+
+		if (txpower == -1)
+			txpower = arvif->txpower;
+		else
+			txpower = min(txpower, arvif->txpower);
+	}
+
+	if (txpower == -1)
+		return 0;
+
+	ret = ath10k_mac_txpower_setup(ar, txpower);
+	if (ret) {
+		ath10k_warn(ar, "failed to setup tx power %d: %d\n",
+			    txpower, ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int ath10k_mac_set_sar_power(struct ath10k *ar)
+{
+	if (!ar->hw_params.dynamic_sar_support)
+		return -EOPNOTSUPP;
+
+	if (!ath10k_mac_is_connected(ar))
+		return 0;
+
+	/* if connected, then arvif->txpower must be valid */
+	return ath10k_mac_txpower_recalc(ar);
+}
+
+static int ath10k_mac_set_sar_specs(struct ieee80211_hw *hw,
+				    const struct cfg80211_sar_specs *sar)
+{
+	const struct cfg80211_sar_sub_specs *sub_specs;
+	struct ath10k *ar = hw->priv;
+	int ret, i;
+
+	mutex_lock(&ar->conf_mutex);
+
+	if (!ar->hw_params.dynamic_sar_support) {
+		ret = -EOPNOTSUPP;
+		goto error;
+	}
+
+	if (!sar || sar->type != NL80211_SAR_TYPE_POWER ||
+	    sar->num_sub_specs == 0 || !sar->sub_specs) {
+		ret = -EINVAL;
+		goto error;
+	}
+
+	sub_specs = sar->sub_specs;
+
+	ar->tx_power_2g_limit = 0;
+	ar->tx_power_5g_limit = 0;
+
+	/* note the power is in 0.25dbm unit, while ath10k uses
+	 * 0.5dbm unit.
+	 */
+	for (i = 0; i < sar->num_sub_specs; i++) {
+		if (i == 0)
+			ar->tx_power_2g_limit = sub_specs->power / 2;
+		else if (i == 1)
+			ar->tx_power_5g_limit = sub_specs->power / 2;
+
+		sub_specs++;
+	}
+
+	ret = ath10k_mac_set_sar_power(ar);
+error:
+	mutex_unlock(&ar->conf_mutex);
+	return ret;
+}
+
 /* can be called only in mac80211 callbacks due to `key_count` usage */
 static void ath10k_bss_assoc(struct ieee80211_hw *hw,
 			     struct ieee80211_vif *vif,
@@ -2968,6 +3122,8 @@ static void ath10k_bss_assoc(struct ieee80211_hw *hw,
 
 	arvif->is_up = true;
 
+	ath10k_mac_set_sar_power(ar);
+
 	/* Workaround: Some firmware revisions (tested with qca6174
 	 * WLAN.RM.2.0-00073) have buggy powersave state machine and must be
 	 * poked with peer param command.
@@ -3010,6 +3166,8 @@ static void ath10k_bss_disassoc(struct ieee80211_hw *hw,
 
 	arvif->is_up = false;
 
+	ath10k_mac_txpower_recalc(ar);
+
 	cancel_delayed_work_sync(&arvif->connection_loss_work);
 }
 
@@ -5207,65 +5365,6 @@ static int ath10k_config_ps(struct ath10k *ar)
 	return ret;
 }
 
-static int ath10k_mac_txpower_setup(struct ath10k *ar, int txpower)
-{
-	int ret;
-	u32 param;
-
-	lockdep_assert_held(&ar->conf_mutex);
-
-	ath10k_dbg(ar, ATH10K_DBG_MAC, "mac txpower %d\n", txpower);
-
-	param = ar->wmi.pdev_param->txpower_limit2g;
-	ret = ath10k_wmi_pdev_set_param(ar, param, txpower * 2);
-	if (ret) {
-		ath10k_warn(ar, "failed to set 2g txpower %d: %d\n",
-			    txpower, ret);
-		return ret;
-	}
-
-	param = ar->wmi.pdev_param->txpower_limit5g;
-	ret = ath10k_wmi_pdev_set_param(ar, param, txpower * 2);
-	if (ret) {
-		ath10k_warn(ar, "failed to set 5g txpower %d: %d\n",
-			    txpower, ret);
-		return ret;
-	}
-
-	return 0;
-}
-
-static int ath10k_mac_txpower_recalc(struct ath10k *ar)
-{
-	struct ath10k_vif *arvif;
-	int ret, txpower = -1;
-
-	lockdep_assert_held(&ar->conf_mutex);
-
-	list_for_each_entry(arvif, &ar->arvifs, list) {
-		/* txpower not initialized yet? */
-		if (arvif->txpower == INT_MIN)
-			continue;
-
-		if (txpower == -1)
-			txpower = arvif->txpower;
-		else
-			txpower = min(txpower, arvif->txpower);
-	}
-
-	if (txpower == -1)
-		return 0;
-
-	ret = ath10k_mac_txpower_setup(ar, txpower);
-	if (ret) {
-		ath10k_warn(ar, "failed to setup tx power %d: %d\n",
-			    txpower, ret);
-		return ret;
-	}
-
-	return 0;
-}
-
 static int ath10k_config(struct ieee80211_hw *hw, u32 changed)
 {
 	struct ath10k *ar = hw->priv;
@@ -9270,6 +9369,7 @@ static const struct ieee80211_ops ath10k_ops = {
 #ifdef CONFIG_MAC80211_DEBUGFS
 	.sta_add_debugfs		= ath10k_sta_add_debugfs,
 #endif
+	.set_sar_specs			= ath10k_mac_set_sar_specs,
 };
 
 #define CHAN2G(_channel, _freq, _flags) { \
@@ -10009,6 +10109,9 @@ int ath10k_mac_register(struct ath10k *ar)
 		goto err_free;
 	}
 
+	if (ar->hw_params.dynamic_sar_support)
+		ar->hw->wiphy->sar_capa = &ath10k_sar_capa;
+
 	if (!test_bit(ATH10K_FLAG_RAW_MODE, &ar->dev_flags))
 		ar->hw->netdev_features = NETIF_F_HW_CSUM;
 
-- 
2.7.4

