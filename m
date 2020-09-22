Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 723C4273A47
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Sep 2020 07:37:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728972AbgIVFhu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Sep 2020 01:37:50 -0400
Received: from z5.mailgun.us ([104.130.96.5]:36929 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729097AbgIVFhu (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Sep 2020 01:37:50 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1600753069; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=p0JQ2ulvewYCOFPPfpRBG2W9Q4eP63ZtkvVOnNcRLSM=; b=LSWDwbFsDXMVrRk54E7xKiw5WOxz2Cnq1eRA98C53rjY9nJxPNK64glotnotWILNCK1bJOVl
 4JznLppoDHzfOaQ63G4+y+RKMEZJpCozVp54fCI/KF5Q0n0KaAIGx/gDYiFP8iqlcglrOQiQ
 +7KI5vX+1ypSHl2fC+biqtcSyc8=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 5f698d860049ea5816bd6294 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 22 Sep 2020 05:37:10
 GMT
Sender: cjhuang=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 133A2C43382; Tue, 22 Sep 2020 05:37:10 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from cjhuang-station.qca.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: cjhuang)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7EF65C433FE;
        Tue, 22 Sep 2020 05:37:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7EF65C433FE
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=cjhuang@codeaurora.org
From:   Carl Huang <cjhuang@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, briannorris@chromium.org,
        dianders@chromium.org
Subject: [RFC 2/2] ath10k: allow dynamic SAR power limits via common API
Date:   Tue, 22 Sep 2020 13:36:57 +0800
Message-Id: <1600753017-4614-2-git-send-email-cjhuang@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1600753017-4614-1-git-send-email-cjhuang@codeaurora.org>
References: <1600753017-4614-1-git-send-email-cjhuang@codeaurora.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

ath10k assigns ath10k_mac_set_sar_specs to ath10k_ops, and
this function is called when user space application calls
NL80211_CMD_SET_SAR_SPECS. ath10k also registers SAR type,
and supported frequency ranges to wiphy so user space can
query SAR capabilities.

ath10k_mac_set_sar_specs further sets the power to firmware
to limit the TX power.

This feature is controlled by hw parameter: dynamic_sar_support.

Signed-off-by: Carl Huang <cjhuang@codeaurora.org>
---
 drivers/net/wireless/ath/ath10k/core.c |  16 +++++
 drivers/net/wireless/ath/ath10k/core.h |   3 +
 drivers/net/wireless/ath/ath10k/hw.h   |   2 +
 drivers/net/wireless/ath/ath10k/mac.c  | 106 +++++++++++++++++++++++++++++++++
 4 files changed, 127 insertions(+)

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
index 2e3eb5b..830c61f 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -81,6 +81,17 @@ static struct ieee80211_rate ath10k_rates_rev2[] = {
 	{ .bitrate = 540, .hw_value = ATH10K_HW_RATE_OFDM_54M },
 };
 
+static const struct cfg80211_sar_freq_ranges ath10k_sar_freq_ranges[] = {
+	{ .index = 0, .start_freq = 2412000, .end_freq = 2484000 },
+	{ .index = 1, .start_freq = 2484000, .end_freq = 5865000 },
+};
+
+static const struct cfg80211_sar_capa ath10k_sar_capa = {
+	.type = NL80211_SAR_TYPE_POWER,
+	.num_freq_ranges = (ARRAY_SIZE(ath10k_sar_freq_ranges)),
+	.freq_ranges = &ath10k_sar_freq_ranges[0],
+};
+
 #define ATH10K_MAC_FIRST_OFDM_RATE_IDX 4
 
 #define ath10k_a_rates (ath10k_rates + ATH10K_MAC_FIRST_OFDM_RATE_IDX)
@@ -2880,6 +2891,95 @@ static int ath10k_mac_vif_recalc_txbf(struct ath10k *ar,
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
+int ath10k_mac_set_sar_power(struct ath10k *ar)
+{
+	int ret;
+
+	if (!ar->hw_params.dynamic_sar_support)
+		return 0;
+
+	if (ar->tx_power_2g_limit == 0 || ar->tx_power_5g_limit == 0)
+		return 0;
+
+	if (!ath10k_mac_is_connected(ar))
+		return 0;
+
+	ret = ath10k_wmi_pdev_set_param(ar,
+					ar->wmi.pdev_param->txpower_limit2g,
+					ar->tx_power_2g_limit);
+	if (ret) {
+		ath10k_warn(ar, "failed to set 2.4G txpower %d: %d\n",
+			    ar->tx_power_2g_limit, ret);
+		return ret;
+	}
+
+	ret = ath10k_wmi_pdev_set_param(ar,
+					ar->wmi.pdev_param->txpower_limit5g,
+					ar->tx_power_5g_limit);
+	if (ret) {
+		ath10k_warn(ar, "failed to set 5G txpower %d: %d\n",
+			    ar->tx_power_5g_limit, ret);
+		return ret;
+	}
+
+	ath10k_dbg(ar, ATH10K_DBG_MAC, "set txpower 2G:%d, 5G:%d successfully\n",
+		   ar->tx_power_2g_limit, ar->tx_power_5g_limit);
+
+	return ret;
+}
+
+static int ath10k_mac_set_sar_specs(struct ieee80211_hw *hw,
+				    const struct cfg80211_sar_specs *sar)
+{
+	struct cfg80211_sar_sub_specs *sub_specs;
+	struct ath10k *ar = hw->priv;
+	int i;
+
+	if (!ar->hw_params.dynamic_sar_support)
+		return -EOPNOTSUPP;
+
+	if (!sar || sar->type != NL80211_SAR_TYPE_POWER ||
+	    sar->num_sub_specs == 0 || !sar->sub_specs)
+		return -EINVAL;
+
+	sub_specs = sar->sub_specs;
+
+	/* note the power is in 0.25dbm unit, while ath10k uses
+	 * 0.5dbm unit.
+	 */
+	for (i = 0; i < sar->num_sub_specs; i++) {
+		if (sub_specs->freq_range_index == NL80211_SAR_ALL_FREQ_RNAGES) {
+			ar->tx_power_2g_limit = sub_specs->power / 2;
+			ar->tx_power_5g_limit = sub_specs->power / 2;
+			goto set_power;
+		}
+
+		if (sub_specs->freq_range_index == 0)
+			ar->tx_power_2g_limit = sub_specs->power / 2;
+		else if (sub_specs->freq_range_index == 1)
+			ar->tx_power_5g_limit = sub_specs->power / 2;
+		else
+			return -EINVAL;
+
+		sub_specs++;
+	}
+
+set_power:
+	return ath10k_mac_set_sar_power(ar);
+}
+
 /* can be called only in mac80211 callbacks due to `key_count` usage */
 static void ath10k_bss_assoc(struct ieee80211_hw *hw,
 			     struct ieee80211_vif *vif,
@@ -2968,6 +3068,8 @@ static void ath10k_bss_assoc(struct ieee80211_hw *hw,
 
 	arvif->is_up = true;
 
+	ath10k_mac_set_sar_power(ar);
+
 	/* Workaround: Some firmware revisions (tested with qca6174
 	 * WLAN.RM.2.0-00073) have buggy powersave state machine and must be
 	 * poked with peer param command.
@@ -9270,6 +9372,7 @@ static const struct ieee80211_ops ath10k_ops = {
 #ifdef CONFIG_MAC80211_DEBUGFS
 	.sta_add_debugfs		= ath10k_sta_add_debugfs,
 #endif
+	.set_sar_specs			= ath10k_mac_set_sar_specs,
 };
 
 #define CHAN2G(_channel, _freq, _flags) { \
@@ -10009,6 +10112,9 @@ int ath10k_mac_register(struct ath10k *ar)
 		goto err_free;
 	}
 
+	if (ar->hw_params.dynamic_sar_support)
+		ar->hw->wiphy->sar_capa = &ath10k_sar_capa;
+
 	if (!test_bit(ATH10K_FLAG_RAW_MODE, &ar->dev_flags))
 		ar->hw->netdev_features = NETIF_F_HW_CSUM;
 
-- 
2.7.4

