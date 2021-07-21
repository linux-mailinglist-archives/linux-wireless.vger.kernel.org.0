Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D5243D152D
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Jul 2021 19:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbhGUQ4f (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Jul 2021 12:56:35 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:24415 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229767AbhGUQ4f (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Jul 2021 12:56:35 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1626889031; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=lF1ojJptZPwZovzBlNtOoNgPKW8QTeEKCq2RB6a8Z+4=; b=LA2hIcYLsUHpnXbyTqn4yR/XSj5WvrLDmq/6e4pwvapc8zGlom/XbwEhlmuISHZM22tKGL7y
 Ya1lvIE0cr6FNosu4biRMmNQM6aNUgZFPyfXIj9zH6PjdTXy5WYzl2AWoU+D+H/erSLWlVHg
 p44FuzWsd26CJtrzJ7yvdwUEUa4=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 60f85b341dd16c87882bae14 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 21 Jul 2021 17:36:52
 GMT
Sender: jouni=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D2AA2C433F1; Wed, 21 Jul 2021 17:36:51 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from jouni.codeaurora.org (85-76-67-217-nat.elisa-mobile.fi [85.76.67.217])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jouni)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 45C92C4338A;
        Wed, 21 Jul 2021 17:36:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 45C92C4338A
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=jouni@codeaurora.org
From:   Jouni Malinen <jouni@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        P Praneesh <ppranees@codeaurora.org>,
        Ganesh Sesetti <gseset@codeaurora.org>,
        Sathishkumar Muruganandam <murugana@codeaurora.org>,
        Jouni Malinen <jouni@codeaurora.org>
Subject: [PATCH 2/2] ath11k: add support for 80P80 and 160 MHz bandwidth
Date:   Wed, 21 Jul 2021 20:36:15 +0300
Message-Id: <20210721173615.75637-2-jouni@codeaurora.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210721173615.75637-1-jouni@codeaurora.org>
References: <20210721173615.75637-1-jouni@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: P Praneesh <ppranees@codeaurora.org>

For 160 MHz, nss_ratio_enabled flag is added to indicate firmware
supports sending NSS ratio information from firmware as a part of
service ready ext event. Extract this NSS ratio info from service
ready ext event and save this information in ath11k_pdev_cap to
calculate NSS ratio.

Current firmware configurations support two types of NSS ratio
which is WMI_NSS_RATIO_1_NSS for QCN9074 and WMI_NSS_RATIO_1BY2_NSS
for IPQ8074. Based on this two configuration, max supported
NSS getting calculated.

Move ath11k_peer_assoc_h_phymode() before ath11k_peer_assoc_h_vht()
to get arg->peer_phymode updated.

Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.4.0.1-00097-QCAHKSWPL_SILICONZ-1
Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.4.0.1-01467-QCAHKSWPL_SILICONZ-1

Co-developed-by: Ganesh Sesetti <gseset@codeaurora.org>
Signed-off-by: Ganesh Sesetti <gseset@codeaurora.org>
Co-developed-by: Sathishkumar Muruganandam <murugana@codeaurora.org>
Signed-off-by: Sathishkumar Muruganandam <murugana@codeaurora.org>
Signed-off-by: P Praneesh <ppranees@codeaurora.org>
Signed-off-by: Jouni Malinen <jouni@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/core.h |  2 +
 drivers/net/wireless/ath/ath11k/mac.c  | 94 ++++++++++++++++++++++----
 drivers/net/wireless/ath/ath11k/mac.h  |  3 +
 drivers/net/wireless/ath/ath11k/wmi.c  | 20 +++++-
 drivers/net/wireless/ath/ath11k/wmi.h  | 30 ++++++++
 5 files changed, 135 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index 0ad5a935b52b..c73001014795 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -593,6 +593,8 @@ struct ath11k_pdev_cap {
 	u32 tx_chain_mask_shift;
 	u32 rx_chain_mask_shift;
 	struct ath11k_band_cap band[NUM_NL80211_BANDS];
+	bool nss_ratio_enabled;
+	u8 nss_ratio_info;
 };
 
 struct ath11k_pdev {
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 4dcc1b377642..11d919d3c23e 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -1525,6 +1525,33 @@ ath11k_peer_assoc_h_vht_limit(u16 tx_mcs_set,
 	return tx_mcs_set;
 }
 
+static u8 ath11k_get_nss_160mhz(struct ath11k *ar,
+				u8 max_nss)
+{
+	u8 nss_ratio_info = ar->pdev->cap.nss_ratio_info;
+	u8 max_sup_nss = 0;
+
+	switch (nss_ratio_info) {
+	case WMI_NSS_RATIO_1BY2_NSS:
+		max_sup_nss = max_nss >> 1;
+		break;
+	case WMI_NSS_RATIO_3BY4_NSS:
+		ath11k_warn(ar->ab, "WMI_NSS_RATIO_3BY4_NSS not supported\n");
+		break;
+	case WMI_NSS_RATIO_1_NSS:
+		max_sup_nss = max_nss;
+		break;
+	case WMI_NSS_RATIO_2_NSS:
+		ath11k_warn(ar->ab, "WMI_NSS_RATIO_2_NSS not supported\n");
+		break;
+	default:
+		ath11k_warn(ar->ab, "invalid nss ratio received from fw\n");
+		break;
+	}
+
+	return max_sup_nss;
+}
+
 static void ath11k_peer_assoc_h_vht(struct ath11k *ar,
 				    struct ieee80211_vif *vif,
 				    struct ieee80211_sta *sta,
@@ -1539,6 +1566,7 @@ static void ath11k_peer_assoc_h_vht(struct ath11k *ar,
 	u8 max_nss, vht_mcs;
 	int i, vht_nss, nss_idx;
 	bool user_rate_valid = true;
+	u32 rx_nss, tx_nss, nss_160;
 
 	if (WARN_ON(ath11k_mac_vif_chan(vif, &def)))
 		return;
@@ -1631,10 +1659,29 @@ static void ath11k_peer_assoc_h_vht(struct ath11k *ar,
 	/* TODO:  Check */
 	arg->tx_max_mcs_nss = 0xFF;
 
-	ath11k_dbg(ar->ab, ATH11K_DBG_MAC, "mac vht peer %pM max_mpdu %d flags 0x%x\n",
-		   sta->addr, arg->peer_max_mpdu, arg->peer_flags);
+	if (arg->peer_phymode == MODE_11AC_VHT160 ||
+	    arg->peer_phymode == MODE_11AC_VHT80_80) {
+		tx_nss = ath11k_get_nss_160mhz(ar, max_nss);
+		rx_nss = min(arg->peer_nss, tx_nss);
+		arg->peer_bw_rxnss_override = ATH11K_BW_NSS_MAP_ENABLE;
+
+		if (!rx_nss) {
+			ath11k_warn(ar->ab, "invalid max_nss\n");
+			return;
+		}
+
+		if (arg->peer_phymode == MODE_11AC_VHT160)
+			nss_160 = FIELD_PREP(ATH11K_PEER_RX_NSS_160MHZ, rx_nss - 1);
+		else
+			nss_160 = FIELD_PREP(ATH11K_PEER_RX_NSS_80_80MHZ, rx_nss - 1);
 
-	/* TODO: rxnss_override */
+		arg->peer_bw_rxnss_override |= nss_160;
+	}
+
+	ath11k_dbg(ar->ab, ATH11K_DBG_MAC,
+		   "mac vht peer %pM max_mpdu %d flags 0x%x nss_override 0x%x\n",
+		   sta->addr, arg->peer_max_mpdu, arg->peer_flags,
+		   arg->peer_bw_rxnss_override);
 }
 
 static int ath11k_mac_get_max_he_mcs_map(u16 mcs_map, int nss)
@@ -1718,6 +1765,7 @@ static void ath11k_peer_assoc_h_he(struct ath11k *ar,
 	u16 he_tx_mcs = 0, v = 0;
 	int i, he_nss, nss_idx;
 	bool user_rate_valid = true;
+	u32 rx_nss, tx_nss, nss_160;
 
 	if (WARN_ON(ath11k_mac_vif_chan(vif, &def)))
 		return;
@@ -1881,9 +1929,30 @@ static void ath11k_peer_assoc_h_he(struct ath11k *ar,
 	}
 	arg->peer_nss = min(sta->rx_nss, max_nss);
 
+	if (arg->peer_phymode == MODE_11AX_HE160 ||
+	    arg->peer_phymode == MODE_11AX_HE80_80) {
+		tx_nss = ath11k_get_nss_160mhz(ar, max_nss);
+		rx_nss = min(arg->peer_nss, tx_nss);
+		arg->peer_bw_rxnss_override = ATH11K_BW_NSS_MAP_ENABLE;
+
+		if (!rx_nss) {
+			ath11k_warn(ar->ab, "invalid max_nss\n");
+			return;
+		}
+
+		if (arg->peer_phymode == MODE_11AX_HE160)
+			nss_160 = FIELD_PREP(ATH11K_PEER_RX_NSS_160MHZ, rx_nss - 1);
+		else
+			nss_160 = FIELD_PREP(ATH11K_PEER_RX_NSS_80_80MHZ, rx_nss - 1);
+
+		arg->peer_bw_rxnss_override |= nss_160;
+	}
+
 	ath11k_dbg(ar->ab, ATH11K_DBG_MAC,
-		   "mac he peer %pM nss %d mcs cnt %d\n",
-		   sta->addr, arg->peer_nss, arg->peer_he_mcs_count);
+		   "mac he peer %pM nss %d mcs cnt %d nss_override 0x%x\n",
+		   sta->addr, arg->peer_nss,
+		   arg->peer_he_mcs_count,
+		   arg->peer_bw_rxnss_override);
 }
 
 static void ath11k_peer_assoc_h_smps(struct ieee80211_sta *sta,
@@ -2171,11 +2240,11 @@ static void ath11k_peer_assoc_prepare(struct ath11k *ar,
 	ath11k_peer_assoc_h_basic(ar, vif, sta, arg);
 	ath11k_peer_assoc_h_crypto(ar, vif, sta, arg);
 	ath11k_peer_assoc_h_rates(ar, vif, sta, arg);
+	ath11k_peer_assoc_h_phymode(ar, vif, sta, arg);
 	ath11k_peer_assoc_h_ht(ar, vif, sta, arg);
 	ath11k_peer_assoc_h_vht(ar, vif, sta, arg);
 	ath11k_peer_assoc_h_he(ar, vif, sta, arg);
 	ath11k_peer_assoc_h_qos(ar, vif, sta, arg);
-	ath11k_peer_assoc_h_phymode(ar, vif, sta, arg);
 	ath11k_peer_assoc_h_smps(sta, arg);
 
 	/* TODO: amsdu_disable req? */
@@ -4371,11 +4440,6 @@ ath11k_create_vht_cap(struct ath11k *ar, u32 rate_cap_tx_chainmask,
 
 	ath11k_set_vht_txbf_cap(ar, &vht_cap.cap);
 
-	/* TODO: Enable back VHT160 mode once association issues are fixed */
-	/* Disabling VHT160 and VHT80+80 modes */
-	vht_cap.cap &= ~IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_MASK;
-	vht_cap.cap &= ~IEEE80211_VHT_CAP_SHORT_GI_160;
-
 	rxmcs_map = 0;
 	txmcs_map = 0;
 	for (i = 0; i < 8; i++) {
@@ -7244,7 +7308,9 @@ static int ath11k_mac_setup_iface_combinations(struct ath11k *ar)
 	combinations[0].radar_detect_widths = BIT(NL80211_CHAN_WIDTH_20_NOHT) |
 						BIT(NL80211_CHAN_WIDTH_20) |
 						BIT(NL80211_CHAN_WIDTH_40) |
-						BIT(NL80211_CHAN_WIDTH_80);
+						BIT(NL80211_CHAN_WIDTH_80) |
+						BIT(NL80211_CHAN_WIDTH_80P80) |
+						BIT(NL80211_CHAN_WIDTH_160);
 
 	ar->hw->wiphy->iface_combinations = combinations;
 	ar->hw->wiphy->n_iface_combinations = 1;
@@ -7383,6 +7449,10 @@ static int __ath11k_mac_register(struct ath11k *ar)
 	ieee80211_hw_set(ar->hw, SUPPORTS_TX_FRAG);
 	ieee80211_hw_set(ar->hw, REPORTS_LOW_ACK);
 	ieee80211_hw_set(ar->hw, SUPPORTS_TX_ENCAP_OFFLOAD);
+
+	if (cap->nss_ratio_enabled)
+		ieee80211_hw_set(ar->hw, SUPPORTS_VHT_EXT_NSS_BW);
+
 	if (ht_cap & WMI_HT_CAP_ENABLED) {
 		ieee80211_hw_set(ar->hw, AMPDU_AGGREGATION);
 		ieee80211_hw_set(ar->hw, TX_AMPDU_SETUP_IN_HW);
diff --git a/drivers/net/wireless/ath/ath11k/mac.h b/drivers/net/wireless/ath/ath11k/mac.h
index 4bc59bdaf244..254ca4acc8e8 100644
--- a/drivers/net/wireless/ath/ath11k/mac.h
+++ b/drivers/net/wireless/ath/ath11k/mac.h
@@ -115,6 +115,9 @@ struct ath11k_generic_iter {
 #define WMI_MAX_SPATIAL_STREAM			3
 
 #define ATH11K_CHAN_WIDTH_NUM			8
+#define ATH11K_BW_NSS_MAP_ENABLE		BIT(31)
+#define ATH11K_PEER_RX_NSS_160MHZ		GENMASK(2, 0)
+#define ATH11K_PEER_RX_NSS_80_80MHZ		GENMASK(5, 3)
 
 #define ATH11K_OBSS_PD_MAX_THRESHOLD			-82
 #define ATH11K_OBSS_PD_NON_SRG_MAX_THRESHOLD		-62
diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index 330b435e0ed3..7ac84ac86aab 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -360,6 +360,10 @@ ath11k_pull_mac_phy_cap_svc_ready_ext(struct ath11k_pdev_wmi *wmi_handle,
 		pdev_cap->he_mcs = mac_phy_caps->he_supp_mcs_5g;
 		pdev_cap->tx_chain_mask = mac_phy_caps->tx_chain_mask_5g;
 		pdev_cap->rx_chain_mask = mac_phy_caps->rx_chain_mask_5g;
+		pdev_cap->nss_ratio_enabled =
+			WMI_NSS_RATIO_ENABLE_DISABLE_GET(mac_phy_caps->nss_ratio);
+		pdev_cap->nss_ratio_info =
+			WMI_NSS_RATIO_INFO_GET(mac_phy_caps->nss_ratio);
 	} else {
 		return -EINVAL;
 	}
@@ -783,14 +787,26 @@ int ath11k_wmi_vdev_down(struct ath11k *ar, u8 vdev_id)
 static void ath11k_wmi_put_wmi_channel(struct wmi_channel *chan,
 				       struct wmi_vdev_start_req_arg *arg)
 {
+	u32 center_freq1 = arg->channel.band_center_freq1;
+
 	memset(chan, 0, sizeof(*chan));
 
 	chan->mhz = arg->channel.freq;
 	chan->band_center_freq1 = arg->channel.band_center_freq1;
-	if (arg->channel.mode == MODE_11AC_VHT80_80)
+
+	if (arg->channel.mode == MODE_11AX_HE160) {
+		if (arg->channel.freq > arg->channel.band_center_freq1)
+			chan->band_center_freq1 = center_freq1 + 40;
+		else
+			chan->band_center_freq1 = center_freq1 - 40;
+
+		chan->band_center_freq2 = arg->channel.band_center_freq1;
+
+	} else if (arg->channel.mode == MODE_11AC_VHT80_80) {
 		chan->band_center_freq2 = arg->channel.band_center_freq2;
-	else
+	} else {
 		chan->band_center_freq2 = 0;
+	}
 
 	chan->info |= FIELD_PREP(WMI_CHAN_INFO_MODE, arg->channel.mode);
 	if (arg->channel.passive)
diff --git a/drivers/net/wireless/ath/ath11k/wmi.h b/drivers/net/wireless/ath/ath11k/wmi.h
index 097023a94e06..fb27a8d0f0fd 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.h
+++ b/drivers/net/wireless/ath/ath11k/wmi.h
@@ -2146,6 +2146,24 @@ enum wmi_direct_buffer_module {
 	WMI_DIRECT_BUF_MAX
 };
 
+/* enum wmi_nss_ratio - NSS ratio received from FW during service ready ext
+ *			event
+ * WMI_NSS_RATIO_1BY2_NSS -Max nss of 160MHz is equals to half of the max nss
+ *			   of 80MHz
+ * WMI_NSS_RATIO_3BY4_NSS - Max nss of 160MHz is equals to 3/4 of the max nss
+ *			    of 80MHz
+ * WMI_NSS_RATIO_1_NSS - Max nss of 160MHz is equals to the max nss of 80MHz
+ * WMI_NSS_RATIO_2_NSS - Max nss of 160MHz is equals to two times the max
+ *			 nss of 80MHz
+ */
+
+enum wmi_nss_ratio {
+	WMI_NSS_RATIO_1BY2_NSS = 0x0,
+	WMI_NSS_RATIO_3BY4_NSS = 0x1,
+	WMI_NSS_RATIO_1_NSS = 0x2,
+	WMI_NSS_RATIO_2_NSS = 0x3,
+};
+
 struct wmi_host_pdev_band_to_mac {
 	u32 pdev_id;
 	u32 start_freq;
@@ -2390,6 +2408,12 @@ struct wmi_hw_mode_capabilities {
 } __packed;
 
 #define WMI_MAX_HECAP_PHY_SIZE                 (3)
+#define WMI_NSS_RATIO_ENABLE_DISABLE_BITPOS    BIT(0)
+#define WMI_NSS_RATIO_ENABLE_DISABLE_GET(_val) \
+	FIELD_GET(WMI_NSS_RATIO_ENABLE_DISABLE_BITPOS, _val)
+#define WMI_NSS_RATIO_INFO_BITPOS              GENMASK(4, 1)
+#define WMI_NSS_RATIO_INFO_GET(_val) \
+	FIELD_GET(WMI_NSS_RATIO_INFO_BITPOS, _val)
 
 struct wmi_mac_phy_capabilities {
 	u32 hw_mode_id;
@@ -2423,6 +2447,12 @@ struct wmi_mac_phy_capabilities {
 	u32 he_cap_info_2g_ext;
 	u32 he_cap_info_5g_ext;
 	u32 he_cap_info_internal;
+	u32 wireless_modes;
+	u32 low_2ghz_chan_freq;
+	u32 high_2ghz_chan_freq;
+	u32 low_5ghz_chan_freq;
+	u32 high_5ghz_chan_freq;
+	u32 nss_ratio;
 } __packed;
 
 struct wmi_hal_reg_capabilities_ext {
-- 
2.25.1

