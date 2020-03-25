Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 632F8192B9E
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2020 15:58:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727351AbgCYO6P (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 25 Mar 2020 10:58:15 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:15939 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727319AbgCYO6P (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 25 Mar 2020 10:58:15 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1585148294; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=YPm5zFe6TztoMrTqRaug9PANDnGVa9P+qtPJaS5gfmk=; b=hevcO2xT39oleMfWKKs8VfTm6K52uM95i+ZJC0tZ3jl105k6p+wxS7fJUjDBz0hHJVmB7gpN
 C747JAn8UP7GwoXy1NrRg0jrsVS1DTJxg2FXyXC4SWMqZY6DbpfHG2Bghz0EvELdSdqwmAHJ
 sVrneiD+QSVX34ZtpXyMtubn2Cg=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e7b7185.7fdb15a7af48-smtp-out-n04;
 Wed, 25 Mar 2020 14:58:13 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 7A734C43637; Wed, 25 Mar 2020 14:58:12 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from c-gseset-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: ssreeela)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5519DC433D2;
        Wed, 25 Mar 2020 14:58:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5519DC433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=ssreeela@codeaurora.org
From:   Sowmiya Sree Elavalagan <ssreeela@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, Lei Wang <leiwa@codeaurora.org>,
        Sebastian Gottschall <s.gottschall@dd-wrt.com>,
        Rick Wu <rwu@codeaurora.org>,
        Sowmiya Sree Elavalagan <ssreeela@codeaurora.org>
Subject: [PATCH] ath10k: enable VHT160 and VHT80+80 modes
Date:   Wed, 25 Mar 2020 20:26:09 +0530
Message-Id: <1585148169-2320-1-git-send-email-ssreeela@codeaurora.org>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Lei Wang <leiwa@codeaurora.org>

Set right channel frequencies in VHT160 mode according to the VHT160
interoperability workaround added as part of IEEE Std 802.11™-2016 in
"Table 9-252—VHT Operation Information subfields", band_center_freq2
corresponds to CCFS1 in Table 9-253. Previous implementation
(band_center_freq2 = 0 for VHT160) is only deprecated.

Enable VHT80+80 mode and set the proper peer RX nss value for VHT160 and
VHT80+80 mode.

Based on patches by Sebastian Gottschall:

https://lkml.kernel.org/r/20180704095444.662-1-s.gottschall@dd-wrt.com

https://lkml.kernel.org/r/20180704120519.6479-1-s.gottschall@dd-wrt.com

Tested: qca9984 with firmware ver 10.4-3.10-00047

Co-developed-by: Sebastian Gottschall <s.gottschall@dd-wrt.com>
Signed-off-by: Sebastian Gottschall <s.gottschall@dd-wrt.com>
Co-developed-by: Rick Wu <rwu@codeaurora.org>
Signed-off-by: Rick Wu <rwu@codeaurora.org>
Signed-off-by: Lei Wang <leiwa@codeaurora.org>
Signed-off-by: Sowmiya Sree Elavalagan <ssreeela@codeaurora.org>
---
 drivers/net/wireless/ath/ath10k/mac.c | 84 +++++++++++++++++++++++++----------
 drivers/net/wireless/ath/ath10k/wmi.c | 23 ++++++----
 drivers/net/wireless/ath/ath10k/wmi.h |  5 ++-
 3 files changed, 80 insertions(+), 32 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
index 81e148e..7c2e396 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -2505,6 +2505,30 @@ static int ath10k_peer_assoc_qos_ap(struct ath10k *ar,
 	return tx_mcs_set;
 }
 
+static u32 get_160mhz_nss_from_maxrate(int rate)
+{
+	u32 nss;
+
+	switch (rate) {
+	case 780:
+		nss = 1;
+		break;
+	case 1560:
+		nss = 2;
+		break;
+	case 2106:
+		nss = 3; /* not support MCS9 from spec*/
+		break;
+	case 3120:
+		nss = 4;
+		break;
+	default:
+		 nss = 0;
+	}
+
+	return nss;
+}
+
 static void ath10k_peer_assoc_h_vht(struct ath10k *ar,
 				    struct ieee80211_vif *vif,
 				    struct ieee80211_sta *sta,
@@ -2512,6 +2536,7 @@ static void ath10k_peer_assoc_h_vht(struct ath10k *ar,
 {
 	const struct ieee80211_sta_vht_cap *vht_cap = &sta->vht_cap;
 	struct ath10k_vif *arvif = (void *)vif->drv_priv;
+	struct ath10k_hw_params *hw = &ar->hw_params;
 	struct cfg80211_chan_def def;
 	enum nl80211_band band;
 	const u16 *vht_mcs_mask;
@@ -2578,22 +2603,38 @@ static void ath10k_peer_assoc_h_vht(struct ath10k *ar,
 	arg->peer_vht_rates.tx_mcs_set = ath10k_peer_assoc_h_vht_limit(
 		__le16_to_cpu(vht_cap->vht_mcs.tx_mcs_map), vht_mcs_mask);
 
-	ath10k_dbg(ar, ATH10K_DBG_MAC, "mac vht peer %pM max_mpdu %d flags 0x%x\n",
-		   sta->addr, arg->peer_max_mpdu, arg->peer_flags);
+	/* Configure bandwidth-NSS mapping to FW
+	 * for the chip's tx chains setting on 160Mhz bw
+	 */
+	if (arg->peer_phymode == MODE_11AC_VHT160 ||
+	    arg->peer_phymode == MODE_11AC_VHT80_80) {
+		u32 rx_nss;
+		u32 max_rate;
 
-	if (arg->peer_vht_rates.rx_max_rate &&
-	    (sta->vht_cap.cap & IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_MASK)) {
-		switch (arg->peer_vht_rates.rx_max_rate) {
-		case 1560:
-			/* Must be 2x2 at 160Mhz is all it can do. */
-			arg->peer_bw_rxnss_override = 2;
-			break;
-		case 780:
-			/* Can only do 1x1 at 160Mhz (Long Guard Interval) */
-			arg->peer_bw_rxnss_override = 1;
-			break;
+		max_rate = arg->peer_vht_rates.rx_max_rate;
+		rx_nss = get_160mhz_nss_from_maxrate(max_rate);
+
+		if (rx_nss == 0)
+			rx_nss = arg->peer_num_spatial_streams;
+		else
+			rx_nss = min(arg->peer_num_spatial_streams, rx_nss);
+
+		max_rate = hw->vht160_mcs_tx_highest;
+		rx_nss = min(rx_nss, get_160mhz_nss_from_maxrate(max_rate));
+
+		arg->peer_bw_rxnss_override =
+			FIELD_PREP(WMI_PEER_NSS_MAP_ENABLE, 1) |
+			FIELD_PREP(WMI_PEER_NSS_160MHZ_MASK, (rx_nss - 1));
+
+		if (arg->peer_phymode == MODE_11AC_VHT80_80) {
+			arg->peer_bw_rxnss_override |=
+			FIELD_PREP(WMI_PEER_NSS_80_80MHZ_MASK, (rx_nss - 1));
 		}
 	}
+	ath10k_dbg(ar, ATH10K_DBG_MAC,
+		   "mac vht peer %pM max_mpdu %d flags 0x%x peer_rx_nss_override 0x%x\n",
+		   sta->addr, arg->peer_max_mpdu,
+		   arg->peer_flags, arg->peer_bw_rxnss_override);
 }
 
 static void ath10k_peer_assoc_h_qos(struct ath10k *ar,
@@ -2745,9 +2786,9 @@ static int ath10k_peer_assoc_prepare(struct ath10k *ar,
 	ath10k_peer_assoc_h_crypto(ar, vif, sta, arg);
 	ath10k_peer_assoc_h_rates(ar, vif, sta, arg);
 	ath10k_peer_assoc_h_ht(ar, vif, sta, arg);
+	ath10k_peer_assoc_h_phymode(ar, vif, sta, arg);
 	ath10k_peer_assoc_h_vht(ar, vif, sta, arg);
 	ath10k_peer_assoc_h_qos(ar, vif, sta, arg);
-	ath10k_peer_assoc_h_phymode(ar, vif, sta, arg);
 
 	return 0;
 }
@@ -4561,13 +4602,6 @@ static struct ieee80211_sta_vht_cap ath10k_create_vht_cap(struct ath10k *ar)
 		vht_cap.cap |= val;
 	}
 
-	/* Currently the firmware seems to be buggy, don't enable 80+80
-	 * mode until that's resolved.
-	 */
-	if ((ar->vht_cap_info & IEEE80211_VHT_CAP_SHORT_GI_160) &&
-	    (ar->vht_cap_info & IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_MASK) == 0)
-		vht_cap.cap |= IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_160MHZ;
-
 	mcs_map = 0;
 	for (i = 0; i < 8; i++) {
 		if ((i < ar->num_rf_chains) && (ar->cfg_tx_chainmask & BIT(i)))
@@ -8623,7 +8657,9 @@ void ath10k_mac_destroy(struct ath10k *ar)
 		.radar_detect_widths =	BIT(NL80211_CHAN_WIDTH_20_NOHT) |
 					BIT(NL80211_CHAN_WIDTH_20) |
 					BIT(NL80211_CHAN_WIDTH_40) |
-					BIT(NL80211_CHAN_WIDTH_80),
+					BIT(NL80211_CHAN_WIDTH_80) |
+					BIT(NL80211_CHAN_WIDTH_80P80) |
+					BIT(NL80211_CHAN_WIDTH_160),
 #endif
 	},
 };
@@ -8641,7 +8677,9 @@ void ath10k_mac_destroy(struct ath10k *ar)
 		.radar_detect_widths =  BIT(NL80211_CHAN_WIDTH_20_NOHT) |
 					BIT(NL80211_CHAN_WIDTH_20) |
 					BIT(NL80211_CHAN_WIDTH_40) |
-					BIT(NL80211_CHAN_WIDTH_80),
+					BIT(NL80211_CHAN_WIDTH_80) |
+					BIT(NL80211_CHAN_WIDTH_80P80) |
+					BIT(NL80211_CHAN_WIDTH_160),
 #endif
 	},
 };
diff --git a/drivers/net/wireless/ath/ath10k/wmi.c b/drivers/net/wireless/ath/ath10k/wmi.c
index 2ea77bb..db6f4c7 100644
--- a/drivers/net/wireless/ath/ath10k/wmi.c
+++ b/drivers/net/wireless/ath/ath10k/wmi.c
@@ -1714,12 +1714,23 @@ void ath10k_wmi_put_wmi_channel(struct wmi_channel *ch,
 	if (arg->chan_radar)
 		flags |= WMI_CHAN_FLAG_DFS;
 
+	ch->band_center_freq2 = 0;
 	ch->mhz = __cpu_to_le32(arg->freq);
 	ch->band_center_freq1 = __cpu_to_le32(arg->band_center_freq1);
 	if (arg->mode == MODE_11AC_VHT80_80)
 		ch->band_center_freq2 = __cpu_to_le32(arg->band_center_freq2);
-	else
-		ch->band_center_freq2 = 0;
+
+	if (arg->mode == MODE_11AC_VHT160) {
+		if (arg->freq > arg->band_center_freq1)
+			ch->band_center_freq1 =
+				__cpu_to_le32(arg->band_center_freq1 + 40);
+		else
+			ch->band_center_freq1 =
+				__cpu_to_le32(arg->band_center_freq1 - 40);
+
+		ch->band_center_freq2 = __cpu_to_le32(arg->band_center_freq1);
+	}
+
 	ch->min_power = arg->min_power;
 	ch->max_power = arg->max_power;
 	ch->reg_power = arg->max_reg_power;
@@ -7628,12 +7639,8 @@ void ath10k_wmi_start_scan_init(struct ath10k *ar,
 	struct wmi_10_4_peer_assoc_complete_cmd *cmd = buf;
 
 	ath10k_wmi_peer_assoc_fill_10_2(ar, buf, arg);
-	if (arg->peer_bw_rxnss_override)
-		cmd->peer_bw_rxnss_override =
-			__cpu_to_le32((arg->peer_bw_rxnss_override - 1) |
-				      BIT(PEER_BW_RXNSS_OVERRIDE_OFFSET));
-	else
-		cmd->peer_bw_rxnss_override = 0;
+	cmd->peer_bw_rxnss_override =
+		__cpu_to_le32(arg->peer_bw_rxnss_override);
 }
 
 static int
diff --git a/drivers/net/wireless/ath/ath10k/wmi.h b/drivers/net/wireless/ath/ath10k/wmi.h
index 972d53d..f722eef3 100644
--- a/drivers/net/wireless/ath/ath10k/wmi.h
+++ b/drivers/net/wireless/ath/ath10k/wmi.h
@@ -6501,7 +6501,10 @@ struct wmi_10_2_peer_assoc_complete_cmd {
 	__le32 info0; /* WMI_PEER_ASSOC_INFO0_ */
 } __packed;
 
-#define PEER_BW_RXNSS_OVERRIDE_OFFSET  31
+/* NSS Mapping to FW */
+#define WMI_PEER_NSS_MAP_ENABLE	BIT(31)
+#define WMI_PEER_NSS_160MHZ_MASK	GENMASK(2, 0)
+#define WMI_PEER_NSS_80_80MHZ_MASK	GENMASK(5, 3)
 
 struct wmi_10_4_peer_assoc_complete_cmd {
 	struct wmi_10_2_peer_assoc_complete_cmd cmd;
-- 
1.9.1
