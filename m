Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3A7D27D443
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Sep 2020 19:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729796AbgI2RQM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 29 Sep 2020 13:16:12 -0400
Received: from z5.mailgun.us ([104.130.96.5]:48740 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728140AbgI2RQL (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 29 Sep 2020 13:16:11 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1601399770; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=4xU0EfsbT2NEZk+onEJpwNWiTjIkBdOxicvY2aEwXOI=; b=wtkqPn9qfQeGHCIWY44mOms/Ur+1z/iAIUPXq3KXkJHYv0OWBfqzF65WtzUJxA4uTUeURZIC
 qpQd5KO4g2rk2haLNaSwHjTGt5bSgLwoDtRhhdRGEghLzJJuGBti80aiqx7ZVdQQXmP5g7sO
 iSqU55XM5Bu2pqseB0hXxehWkys=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 5f736bc1767da8a9bb7b5b61 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 29 Sep 2020 17:15:45
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 605A1C433F1; Tue, 29 Sep 2020 17:15:45 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 98EFFC43382;
        Tue, 29 Sep 2020 17:15:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 98EFFC43382
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH 3/8] ath11k: add interface_modes to hw_params
Date:   Tue, 29 Sep 2020 20:15:31 +0300
Message-Id: <1601399736-3210-4-git-send-email-kvalo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1601399736-3210-1-git-send-email-kvalo@codeaurora.org>
References: <1601399736-3210-1-git-send-email-kvalo@codeaurora.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

As QCA6390 does not support mesh interfaces, move the interface_modes to
hw_params. Also create interface combinations dynamically so that it's easy to
change the values.

Now QCA6390 does not claim to support mesh interfaces to user space, but
IPQ8074 continues to do that.

Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1

Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/core.c |  11 ++++
 drivers/net/wireless/ath/ath11k/hw.h   |   2 +
 drivers/net/wireless/ath/ath11k/mac.c  | 101 ++++++++++++++++++++-------------
 3 files changed, 75 insertions(+), 39 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index 0a85f20b6499..28aeb9fe602b 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -58,6 +58,10 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.htt_peer_map_v2 = true,
 		.tcl_0_only = false,
 		.spectral_fft_sz = 2,
+
+		.interface_modes = BIT(NL80211_IFTYPE_STATION) |
+					BIT(NL80211_IFTYPE_AP) |
+					BIT(NL80211_IFTYPE_MESH_POINT),
 	},
 	{
 		.hw_rev = ATH11K_HW_IPQ6018_HW10,
@@ -88,6 +92,10 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.htt_peer_map_v2 = true,
 		.tcl_0_only = false,
 		.spectral_fft_sz = 4,
+
+		.interface_modes = BIT(NL80211_IFTYPE_STATION) |
+					BIT(NL80211_IFTYPE_AP) |
+					BIT(NL80211_IFTYPE_MESH_POINT),
 	},
 	{
 		.name = "qca6390 hw2.0",
@@ -118,6 +126,9 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.htt_peer_map_v2 = false,
 		.tcl_0_only = true,
 		.spectral_fft_sz = 0,
+
+		.interface_modes = BIT(NL80211_IFTYPE_STATION) |
+					BIT(NL80211_IFTYPE_AP),
 	},
 };
 
diff --git a/drivers/net/wireless/ath/ath11k/hw.h b/drivers/net/wireless/ath/ath11k/hw.h
index 975d44e9c083..5bd3fe618dd8 100644
--- a/drivers/net/wireless/ath/ath11k/hw.h
+++ b/drivers/net/wireless/ath/ath11k/hw.h
@@ -156,6 +156,8 @@ struct ath11k_hw_params {
 	bool htt_peer_map_v2;
 	bool tcl_0_only;
 	u8 spectral_fft_sz;
+
+	u16 interface_modes;
 };
 
 struct ath11k_hw_ops {
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 32cbe643f734..491e62d66edc 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -5874,35 +5874,6 @@ static const struct ieee80211_ops ath11k_ops = {
 #endif
 };
 
-static const struct ieee80211_iface_limit ath11k_if_limits[] = {
-	{
-		.max = 1,
-		.types = BIT(NL80211_IFTYPE_STATION),
-	},
-	{
-		.max    = 16,
-		.types  = BIT(NL80211_IFTYPE_AP)
-#ifdef CONFIG_MAC80211_MESH
-			| BIT(NL80211_IFTYPE_MESH_POINT)
-#endif
-	},
-};
-
-static const struct ieee80211_iface_combination ath11k_if_comb[] = {
-	{
-		.limits = ath11k_if_limits,
-		.n_limits = ARRAY_SIZE(ath11k_if_limits),
-		.max_interfaces = 16,
-		.num_different_channels = 1,
-		.beacon_int_infra_match = true,
-		.beacon_int_min_gcd = 100,
-		.radar_detect_widths =	BIT(NL80211_CHAN_WIDTH_20_NOHT) |
-					BIT(NL80211_CHAN_WIDTH_20) |
-					BIT(NL80211_CHAN_WIDTH_40) |
-					BIT(NL80211_CHAN_WIDTH_80),
-	},
-};
-
 static void ath11k_mac_update_ch_list(struct ath11k *ar,
 				      struct ieee80211_supported_band *band,
 				      u32 freq_low, u32 freq_high)
@@ -6028,6 +5999,50 @@ static int ath11k_mac_setup_channels_rates(struct ath11k *ar,
 	return 0;
 }
 
+static int ath11k_mac_setup_iface_combinations(struct ath11k *ar)
+{
+	struct ath11k_base *ab = ar->ab;
+	struct ieee80211_iface_combination *combinations;
+	struct ieee80211_iface_limit *limits;
+	int n_limits;
+
+	combinations = kzalloc(sizeof(*combinations), GFP_KERNEL);
+	if (!combinations)
+		return -ENOMEM;
+
+	n_limits = 2;
+
+	limits = kcalloc(n_limits, sizeof(*limits), GFP_KERNEL);
+	if (!limits)
+		return -ENOMEM;
+
+	limits[0].max = 1;
+	limits[0].types |= BIT(NL80211_IFTYPE_STATION);
+
+	limits[1].max = 16;
+	limits[1].types |= BIT(NL80211_IFTYPE_AP);
+
+	if (IS_ENABLED(CONFIG_MAC80211_MESH) &&
+	    ab->hw_params.interface_modes & BIT(NL80211_IFTYPE_MESH_POINT))
+		limits[1].types |= BIT(NL80211_IFTYPE_MESH_POINT);
+
+	combinations[0].limits = limits;
+	combinations[0].n_limits = n_limits;
+	combinations[0].max_interfaces = 16;
+	combinations[0].num_different_channels = 1;
+	combinations[0].beacon_int_infra_match = true;
+	combinations[0].beacon_int_min_gcd = 100;
+	combinations[0].radar_detect_widths = BIT(NL80211_CHAN_WIDTH_20_NOHT) |
+						BIT(NL80211_CHAN_WIDTH_20) |
+						BIT(NL80211_CHAN_WIDTH_40) |
+						BIT(NL80211_CHAN_WIDTH_80);
+
+	ar->hw->wiphy->iface_combinations = combinations;
+	ar->hw->wiphy->n_iface_combinations = 1;
+
+	return 0;
+}
+
 static const u8 ath11k_if_types_ext_capa[] = {
 	[0] = WLAN_EXT_CAPA1_EXT_CHANNEL_SWITCHING,
 	[7] = WLAN_EXT_CAPA8_OPMODE_NOTIF,
@@ -6078,6 +6093,9 @@ static void __ath11k_mac_unregister(struct ath11k *ar)
 	kfree(ar->mac.sbands[NL80211_BAND_5GHZ].channels);
 	kfree(ar->mac.sbands[NL80211_BAND_6GHZ].channels);
 
+	kfree(ar->hw->wiphy->iface_combinations[0].limits);
+	kfree(ar->hw->wiphy->iface_combinations);
+
 	SET_IEEE80211_DEV(ar->hw, NULL);
 }
 
@@ -6129,12 +6147,16 @@ static int __ath11k_mac_register(struct ath11k *ar)
 	ath11k_mac_setup_ht_vht_cap(ar, cap, &ht_cap);
 	ath11k_mac_setup_he_cap(ar, cap);
 
+	ret = ath11k_mac_setup_iface_combinations(ar);
+	if (ret) {
+		ath11k_err(ar->ab, "failed to setup interface combinations: %d\n", ret);
+		goto err_free_channels;
+	}
+
 	ar->hw->wiphy->available_antennas_rx = cap->rx_chain_mask;
 	ar->hw->wiphy->available_antennas_tx = cap->tx_chain_mask;
 
-	ar->hw->wiphy->interface_modes = BIT(NL80211_IFTYPE_STATION) |
-					 BIT(NL80211_IFTYPE_AP) |
-					 BIT(NL80211_IFTYPE_MESH_POINT);
+	ar->hw->wiphy->interface_modes = ab->hw_params.interface_modes;
 
 	ieee80211_hw_set(ar->hw, SIGNAL_DBM);
 	ieee80211_hw_set(ar->hw, SUPPORTS_PS);
@@ -6195,9 +6217,6 @@ static int __ath11k_mac_register(struct ath11k *ar)
 	ar->hw->vif_data_size = sizeof(struct ath11k_vif);
 	ar->hw->sta_data_size = sizeof(struct ath11k_sta);
 
-	ar->hw->wiphy->iface_combinations = ath11k_if_comb;
-	ar->hw->wiphy->n_iface_combinations = ARRAY_SIZE(ath11k_if_comb);
-
 	wiphy_ext_feature_set(ar->hw->wiphy, NL80211_EXT_FEATURE_CQM_RSSI_LIST);
 	wiphy_ext_feature_set(ar->hw->wiphy, NL80211_EXT_FEATURE_STA_TX_PWR);
 
@@ -6219,25 +6238,29 @@ static int __ath11k_mac_register(struct ath11k *ar)
 	ret = ieee80211_register_hw(ar->hw);
 	if (ret) {
 		ath11k_err(ar->ab, "ieee80211 registration failed: %d\n", ret);
-		goto err_free;
+		goto err_free_if_combs;
 	}
 
 	/* Apply the regd received during initialization */
 	ret = ath11k_regd_update(ar, true);
 	if (ret) {
 		ath11k_err(ar->ab, "ath11k regd update failed: %d\n", ret);
-		goto err_free;
+		goto err_free_if_combs;
 	}
 
 	ret = ath11k_debugfs_register(ar);
 	if (ret) {
 		ath11k_err(ar->ab, "debugfs registration failed: %d\n", ret);
-		goto err_free;
+		goto err_free_if_combs;
 	}
 
 	return 0;
 
-err_free:
+err_free_if_combs:
+	kfree(ar->hw->wiphy->iface_combinations[0].limits);
+	kfree(ar->hw->wiphy->iface_combinations);
+
+err_free_channels:
 	kfree(ar->mac.sbands[NL80211_BAND_2GHZ].channels);
 	kfree(ar->mac.sbands[NL80211_BAND_5GHZ].channels);
 	kfree(ar->mac.sbands[NL80211_BAND_6GHZ].channels);
-- 
2.7.4

