Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01B481DE0CB
	for <lists+linux-wireless@lfdr.de>; Fri, 22 May 2020 09:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728667AbgEVHYw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 22 May 2020 03:24:52 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:64131 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728371AbgEVHYr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 22 May 2020 03:24:47 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1590132286; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=AKoelkwquh5Ve2yW2MdXiIEbV1/RQaehmQzHB9Uh288=; b=o5h+MMhVbI3r4C0acVDHGd8Ea5upLA1rICZoBxokbEeEMN4MTS2L+WlUNofCxipH9q708Z6X
 9JVGhZyRvIp53c9SHiyCii19srIa6WnayG/XhoCm6NB4yynG6dhyJymKfHVurYJ8ICstnP3K
 eB5EPSLyqZo8JDTDj2iY0qDX8dw=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ec77e3c.7f031c0c7e68-smtp-out-n05;
 Fri, 22 May 2020 07:24:44 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id DB023C433C9; Fri, 22 May 2020 07:24:44 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from pradeepc2-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pradeepc)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 93ED2C43391;
        Fri, 22 May 2020 07:24:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 93ED2C43391
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=pradeepc@codeaurora.org
From:   Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>,
        ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
Subject: [PATCH v2 3/9] ath11k: add support for 6GHz radio in driver
Date:   Fri, 22 May 2020 00:24:25 -0700
Message-Id: <20200522072431.27601-4-pradeepc@codeaurora.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200522072431.27601-1-pradeepc@codeaurora.org>
References: <20200522072431.27601-1-pradeepc@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patch adds 6GHz band support and mac80211 registration for
the 6G phy radio.

Signed-off-by: Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
---
v2:
 - fixed phymode to be set in 6ghz band

 drivers/net/wireless/ath/ath11k/core.h |   6 +-
 drivers/net/wireless/ath/ath11k/mac.c  | 103 +++++++++++++++++++++----
 drivers/net/wireless/ath/ath11k/wmi.c  |  16 +++-
 3 files changed, 105 insertions(+), 20 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index 7e51445cfa20..83bffd7f633a 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -353,7 +353,10 @@ struct ath11k_sta {
 #endif
 };
 
-#define ATH11K_NUM_CHANS 41
+#define ATH11K_MIN_5G_FREQ 4150
+#define ATH11K_MIN_6G_FREQ 5935
+#define ATH11K_MAX_6G_FREQ 7105
+#define ATH11K_NUM_CHANS 100
 #define ATH11K_MAX_5G_CHAN 173
 
 enum ath11k_state {
@@ -431,6 +434,7 @@ struct ath11k {
 	u32 vht_cap_info;
 	struct ath11k_he ar_he;
 	enum ath11k_state state;
+	bool supports_6ghz;
 	struct {
 		struct completion started;
 		struct completion completed;
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index f699e882949b..36b406ab09a3 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -205,6 +205,17 @@ ath11k_phymodes[NUM_NL80211_BANDS][ATH11K_CHAN_WIDTH_NUM] = {
 			[NL80211_CHAN_WIDTH_160] = MODE_11AX_HE160,
 			[NL80211_CHAN_WIDTH_80P80] = MODE_11AX_HE80_80,
 	},
+	[NL80211_BAND_6GHZ] = {
+			[NL80211_CHAN_WIDTH_5] = MODE_UNKNOWN,
+			[NL80211_CHAN_WIDTH_10] = MODE_UNKNOWN,
+			[NL80211_CHAN_WIDTH_20_NOHT] = MODE_11AX_HE20,
+			[NL80211_CHAN_WIDTH_20] = MODE_11AX_HE20,
+			[NL80211_CHAN_WIDTH_40] = MODE_11AX_HE40,
+			[NL80211_CHAN_WIDTH_80] = MODE_11AX_HE80,
+			[NL80211_CHAN_WIDTH_160] = MODE_11AX_HE160,
+			[NL80211_CHAN_WIDTH_80P80] = MODE_11AX_HE80_80,
+	},
+
 };
 
 const struct htt_rx_ring_tlv_filter ath11k_mac_mon_status_filter_default = {
@@ -1560,6 +1571,7 @@ static void ath11k_peer_assoc_h_phymode(struct ath11k *ar,
 		}
 		break;
 	case NL80211_BAND_5GHZ:
+	case NL80211_BAND_6GHZ:
 		/* Check HE first */
 		if (sta->he_cap.has_he) {
 			phymode = ath11k_mac_get_phymode_he(ar, sta);
@@ -3492,6 +3504,18 @@ static void ath11k_mac_setup_ht_vht_cap(struct ath11k *ar,
 		band->vht_cap = ath11k_create_vht_cap(ar, rate_cap_tx_chainmask,
 						      rate_cap_rx_chainmask);
 	}
+
+	if (cap->supported_bands & WMI_HOST_WLAN_5G_CAP &&
+	    ar->supports_6ghz) {
+		band = &ar->mac.sbands[NL80211_BAND_6GHZ];
+		ht_cap = cap->band[NL80211_BAND_6GHZ].ht_cap_info;
+		if (ht_cap_info)
+			*ht_cap_info = ht_cap;
+		band->ht_cap = ath11k_create_ht_cap(ar, ht_cap,
+						    rate_cap_rx_chainmask);
+		band->vht_cap = ath11k_create_vht_cap(ar, rate_cap_tx_chainmask,
+						      rate_cap_rx_chainmask);
+	}
 }
 
 static int ath11k_check_chain_mask(struct ath11k *ar, u32 ant, bool is_tx_ant)
@@ -3746,6 +3770,17 @@ static void ath11k_mac_setup_he_cap(struct ath11k *ar,
 		band->iftype_data = ar->mac.iftype[NL80211_BAND_5GHZ];
 		band->n_iftype_data = count;
 	}
+
+	if (cap->supported_bands & WMI_HOST_WLAN_5G_CAP &&
+	    ar->supports_6ghz) {
+		count = ath11k_mac_copy_he_cap(ar, cap,
+					       ar->mac.iftype[NL80211_BAND_6GHZ],
+					       NL80211_BAND_6GHZ);
+		band = &ar->mac.sbands[NL80211_BAND_6GHZ];
+		band->iftype_data = ar->mac.iftype[NL80211_BAND_6GHZ];
+		band->n_iftype_data = count;
+	}
+
 }
 
 static int __ath11k_set_antenna(struct ath11k *ar, u32 tx_ant, u32 rx_ant)
@@ -4188,6 +4223,12 @@ ath11k_mac_setup_vdev_create_params(struct ath11k_vif *arvif,
 		params->chains[NL80211_BAND_5GHZ].tx = ar->num_tx_chains;
 		params->chains[NL80211_BAND_5GHZ].rx = ar->num_rx_chains;
 	}
+	if (pdev->cap.supported_bands & WMI_HOST_WLAN_5G_CAP &&
+	    ar->supports_6ghz) {
+		params->chains[NL80211_BAND_6GHZ].tx = ar->num_tx_chains;
+		params->chains[NL80211_BAND_6GHZ].rx = ar->num_rx_chains;
+	}
+
 }
 
 static u32
@@ -5320,7 +5361,7 @@ ath11k_mac_get_single_legacy_rate(struct ath11k *ar,
 
 	rate_idx = ffs(mask->control[band].legacy) - 1;
 
-	if (band == NL80211_BAND_5GHZ)
+	if (band == NL80211_BAND_5GHZ || band == NL80211_BAND_6GHZ)
 		rate_idx += ATH11K_MAC_FIRST_OFDM_RATE_IDX;
 
 	hw_rate = ath11k_legacy_rates[rate_idx].hw_value;
@@ -5786,7 +5827,8 @@ static int ath11k_mac_setup_channels_rates(struct ath11k *ar,
 	void *channels;
 
 	BUILD_BUG_ON((ARRAY_SIZE(ath11k_2ghz_channels) +
-		      ARRAY_SIZE(ath11k_5ghz_channels)) !=
+		      ARRAY_SIZE(ath11k_5ghz_channels) +
+		      ARRAY_SIZE(ath11k_6ghz_channels)) !=
 		     ATH11K_NUM_CHANS);
 
 	reg_cap = &ar->ab->hal_reg_cap[ar->pdev_idx];
@@ -5799,6 +5841,7 @@ static int ath11k_mac_setup_channels_rates(struct ath11k *ar,
 			return -ENOMEM;
 
 		band = &ar->mac.sbands[NL80211_BAND_2GHZ];
+		band->band = NL80211_BAND_2GHZ;
 		band->n_channels = ARRAY_SIZE(ath11k_2ghz_channels);
 		band->channels = channels;
 		band->n_bitrates = ath11k_g_rates_size;
@@ -5810,23 +5853,48 @@ static int ath11k_mac_setup_channels_rates(struct ath11k *ar,
 	}
 
 	if (supported_bands & WMI_HOST_WLAN_5G_CAP) {
-		channels = kmemdup(ath11k_5ghz_channels,
-				   sizeof(ath11k_5ghz_channels),
-				   GFP_KERNEL);
-		if (!channels) {
-			kfree(ar->mac.sbands[NL80211_BAND_2GHZ].channels);
-			return -ENOMEM;
+		if (reg_cap->high_5ghz_chan >= ATH11K_MAX_6G_FREQ) {
+			channels = kmemdup(ath11k_6ghz_channels,
+					   sizeof(ath11k_6ghz_channels), GFP_KERNEL);
+			if (!channels) {
+				kfree(ar->mac.sbands[NL80211_BAND_2GHZ].channels);
+				return -ENOMEM;
+			}
+
+			ar->supports_6ghz = true;
+			band = &ar->mac.sbands[NL80211_BAND_6GHZ];
+			band->band = NL80211_BAND_6GHZ;
+			band->n_channels = ARRAY_SIZE(ath11k_6ghz_channels);
+			band->channels = channels;
+			band->n_bitrates = ath11k_a_rates_size;
+			band->bitrates = ath11k_a_rates;
+			ar->hw->wiphy->bands[NL80211_BAND_6GHZ] = band;
+			ath11k_mac_update_ch_list(ar, band,
+						  reg_cap->low_5ghz_chan,
+						  reg_cap->high_5ghz_chan);
 		}
 
-		band = &ar->mac.sbands[NL80211_BAND_5GHZ];
-		band->n_channels = ARRAY_SIZE(ath11k_5ghz_channels);
-		band->channels = channels;
-		band->n_bitrates = ath11k_a_rates_size;
-		band->bitrates = ath11k_a_rates;
-		ar->hw->wiphy->bands[NL80211_BAND_5GHZ] = band;
-		ath11k_mac_update_ch_list(ar, band,
-					  reg_cap->low_5ghz_chan,
-					  reg_cap->high_5ghz_chan);
+		if (reg_cap->low_5ghz_chan < ATH11K_MIN_6G_FREQ) {
+			channels = kmemdup(ath11k_5ghz_channels,
+					   sizeof(ath11k_5ghz_channels),
+					   GFP_KERNEL);
+			if (!channels) {
+				kfree(ar->mac.sbands[NL80211_BAND_2GHZ].channels);
+				kfree(ar->mac.sbands[NL80211_BAND_6GHZ].channels);
+				return -ENOMEM;
+			}
+
+			band = &ar->mac.sbands[NL80211_BAND_5GHZ];
+			band->band = NL80211_BAND_5GHZ;
+			band->n_channels = ARRAY_SIZE(ath11k_5ghz_channels);
+			band->channels = channels;
+			band->n_bitrates = ath11k_a_rates_size;
+			band->bitrates = ath11k_a_rates;
+			ar->hw->wiphy->bands[NL80211_BAND_5GHZ] = band;
+			ath11k_mac_update_ch_list(ar, band,
+						  reg_cap->low_5ghz_chan,
+						  reg_cap->high_5ghz_chan);
+		}
 	}
 
 	return 0;
@@ -5880,6 +5948,7 @@ static void __ath11k_mac_unregister(struct ath11k *ar)
 
 	kfree(ar->mac.sbands[NL80211_BAND_2GHZ].channels);
 	kfree(ar->mac.sbands[NL80211_BAND_5GHZ].channels);
+	kfree(ar->mac.sbands[NL80211_BAND_6GHZ].channels);
 
 	SET_IEEE80211_DEV(ar->hw, NULL);
 }
diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index c2a972377687..291fb274134f 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -368,6 +368,17 @@ ath11k_pull_mac_phy_cap_svc_ready_ext(struct ath11k_pdev_wmi *wmi_handle,
 	memcpy(&cap_band->he_ppet, &mac_phy_caps->he_ppet5g,
 	       sizeof(struct ath11k_ppe_threshold));
 
+	cap_band = &pdev_cap->band[NL80211_BAND_6GHZ];
+	cap_band->max_bw_supported = mac_phy_caps->max_bw_supported_5g;
+	cap_band->ht_cap_info = mac_phy_caps->ht_cap_info_5g;
+	cap_band->he_cap_info[0] = mac_phy_caps->he_cap_info_5g;
+	cap_band->he_cap_info[1] = mac_phy_caps->he_cap_info_5g_ext;
+	cap_band->he_mcs = mac_phy_caps->he_supp_mcs_5g;
+	memcpy(cap_band->he_cap_phy_info, &mac_phy_caps->he_cap_phy_info_5g,
+	       sizeof(u32) * PSOC_HOST_MAX_PHY_SIZE);
+	memcpy(&cap_band->he_ppet, &mac_phy_caps->he_ppet5g,
+	       sizeof(struct ath11k_ppe_threshold));
+
 	return 0;
 }
 
@@ -5206,9 +5217,10 @@ static void ath11k_mgmt_rx_event(struct ath11k_base *ab, struct sk_buff *skb)
 		goto exit;
 	}
 
-	if (rx_ev.phy_mode == MODE_11B && status->band == NL80211_BAND_5GHZ)
+	if (rx_ev.phy_mode == MODE_11B &&
+	    (status->band == NL80211_BAND_5GHZ || status->band == NL80211_BAND_6GHZ))
 		ath11k_dbg(ab, ATH11K_DBG_WMI,
-			   "wmi mgmt rx 11b (CCK) on 5GHz\n");
+			   "wmi mgmt rx 11b (CCK) on 5/6GHz, band = %d\n", status->band);
 
 	sband = &ar->mac.sbands[status->band];
 
-- 
2.17.1
