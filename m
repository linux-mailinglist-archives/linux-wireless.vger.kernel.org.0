Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC31E22F6F
	for <lists+linux-wireless@lfdr.de>; Mon, 20 May 2019 10:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731683AbfETIz0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 May 2019 04:55:26 -0400
Received: from nbd.name ([46.4.11.11]:41476 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731674AbfETIzZ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 May 2019 04:55:25 -0400
Received: from p548c87ba.dip0.t-ipconnect.de ([84.140.135.186] helo=bertha.datto.lan)
        by ds12 with esmtpa (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1hSe4m-0002Y7-07; Mon, 20 May 2019 10:55:20 +0200
From:   John Crispin <john@phrozen.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        John Crispin <john@phrozen.org>,
        Shashidhar Lakkavalli <slakkavalli@datto.com>
Subject: [PATCH V5 8/8] ath11k: add HE support
Date:   Mon, 20 May 2019 10:55:08 +0200
Message-Id: <20190520085508.5888-9-john@phrozen.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190520085508.5888-1-john@phrozen.org>
References: <20190520085508.5888-1-john@phrozen.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add basic HE support to the driver. The sband_iftype data is generated from
the capabilities read from the FW.

Signed-off-by: Shashidhar Lakkavalli <slakkavalli@datto.com>
Signed-off-by: John Crispin <john@phrozen.org>
---
 drivers/net/wireless/ath/ath11k/core.h |   2 +
 drivers/net/wireless/ath/ath11k/mac.c  | 240 ++++++++++++++++++++++++-
 drivers/net/wireless/ath/ath11k/reg.c  |   1 +
 drivers/net/wireless/ath/ath11k/wmi.c  |   6 +-
 drivers/net/wireless/ath/ath11k/wmi.h  |   6 +-
 5 files changed, 245 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index d0d960b384e7..54b136a4d6e9 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -443,6 +443,8 @@ struct ath11k {
 
 	struct {
 		struct ieee80211_supported_band sbands[NUM_NL80211_BANDS];
+		struct ieee80211_sband_iftype_data
+			iftype[NUM_NL80211_BANDS][NUM_NL80211_IFTYPES];
 	} mac;
 	unsigned long dev_flags;
 	unsigned int filter_flags;
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index c5a55fb893ae..b436e90f627a 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -1281,7 +1281,75 @@ static void ath11k_peer_assoc_h_he(struct ath11k *ar,
 				   struct ieee80211_sta *sta,
 				   struct peer_assoc_params *arg)
 {
-	/* TODO: Implementation */
+	const struct ieee80211_sta_he_cap *he_cap = &sta->he_cap;
+
+	if (!he_cap->has_he)
+		return;
+
+	arg->he_flag = true;
+
+	memcpy(&arg->peer_he_cap_macinfo, he_cap->he_cap_elem.mac_cap_info,
+	       sizeof(arg->peer_he_cap_macinfo));
+	memcpy(&arg->peer_he_cap_phyinfo, he_cap->he_cap_elem.phy_cap_info,
+	       sizeof(arg->peer_he_cap_phyinfo));
+	memcpy(&arg->peer_he_ops, &sta->he_operation, sizeof(arg->peer_he_ops));
+
+	if (he_cap->he_cap_elem.phy_cap_info[6] &
+	    IEEE80211_HE_PHY_CAP6_PPE_THRESHOLD_PRESENT) {
+		int bit = 7;
+		int nss, ru;
+
+		arg->peer_ppet.numss_m1 = he_cap->ppe_thres[0] &
+					  IEEE80211_PPE_THRES_NSS_MASK;
+		arg->peer_ppet.ru_bit_mask =
+			(he_cap->ppe_thres[0] &
+			 IEEE80211_PPE_THRES_RU_INDEX_BITMASK_MASK) >>
+			IEEE80211_PPE_THRES_RU_INDEX_BITMASK_POS;
+
+		for (nss = 0; nss <= arg->peer_ppet.numss_m1; nss++) {
+			for (ru = 0; ru < 4; ru++) {
+				u32 val = 0;
+				int i;
+
+				if ((arg->peer_ppet.ru_bit_mask & BIT(ru)) == 0)
+					continue;
+				for (i = 0; i < 6; i++) {
+					val >>= 1;
+					val |= ((he_cap->ppe_thres[bit / 8] >>
+						 (bit % 8)) & 0x1) << 5;
+					bit++;
+				}
+				arg->peer_ppet.ppet16_ppet8_ru3_ru0[nss] |=
+								val << (ru * 6);
+			}
+		}
+	}
+
+	switch (sta->bandwidth) {
+	case IEEE80211_STA_RX_BW_160:
+		if (he_cap->he_cap_elem.phy_cap_info[0] &
+		    IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_80PLUS80_MHZ_IN_5G) {
+			arg->peer_he_rx_mcs_set[WMI_HECAP_TXRX_MCS_NSS_IDX_80_80] =
+				he_cap->he_mcs_nss_supp.rx_mcs_80p80;
+			arg->peer_he_tx_mcs_set[WMI_HECAP_TXRX_MCS_NSS_IDX_80_80] =
+				he_cap->he_mcs_nss_supp.tx_mcs_80p80;
+			arg->peer_he_mcs_count++;
+		}
+		arg->peer_he_rx_mcs_set[WMI_HECAP_TXRX_MCS_NSS_IDX_160] =
+			he_cap->he_mcs_nss_supp.rx_mcs_160;
+		arg->peer_he_tx_mcs_set[WMI_HECAP_TXRX_MCS_NSS_IDX_160] =
+			he_cap->he_mcs_nss_supp.tx_mcs_160;
+		arg->peer_he_mcs_count++;
+		/* drop through */
+
+	default:
+		arg->peer_he_rx_mcs_set[WMI_HECAP_TXRX_MCS_NSS_IDX_80] =
+			he_cap->he_mcs_nss_supp.rx_mcs_80;
+		arg->peer_he_tx_mcs_set[WMI_HECAP_TXRX_MCS_NSS_IDX_80] =
+			he_cap->he_mcs_nss_supp.tx_mcs_80;
+		arg->peer_he_mcs_count++;
+		break;
+	}
 }
 
 static void ath11k_peer_assoc_h_smps(struct ieee80211_sta *sta,
@@ -1448,6 +1516,32 @@ static enum wmi_phy_mode ath11k_mac_get_phymode_vht(struct ath11k *ar,
 	return MODE_UNKNOWN;
 }
 
+static enum wmi_phy_mode ath11k_mac_get_phymode_he(struct ath11k *ar,
+						   struct ieee80211_sta *sta)
+{
+	if (sta->bandwidth == IEEE80211_STA_RX_BW_160) {
+		if (sta->he_cap.he_cap_elem.phy_cap_info[0] &
+		     IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_160MHZ_IN_5G)
+			return MODE_11AX_HE160;
+		else if (sta->he_cap.he_cap_elem.phy_cap_info[0] &
+		     IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_80PLUS80_MHZ_IN_5G)
+			return MODE_11AX_HE80_80;
+		/* not sure if this is a valid case? */
+		return MODE_11AX_HE160;
+	}
+
+	if (sta->bandwidth == IEEE80211_STA_RX_BW_80)
+		return MODE_11AX_HE80;
+
+	if (sta->bandwidth == IEEE80211_STA_RX_BW_40)
+		return MODE_11AX_HE40;
+
+	if (sta->bandwidth == IEEE80211_STA_RX_BW_20)
+		return MODE_11AX_HE20;
+
+	return MODE_UNKNOWN;
+}
+
 static void ath11k_peer_assoc_h_phymode(struct ath11k *ar,
 					struct ieee80211_vif *vif,
 					struct ieee80211_sta *sta,
@@ -1469,7 +1563,14 @@ static void ath11k_peer_assoc_h_phymode(struct ath11k *ar,
 
 	switch (band) {
 	case NL80211_BAND_2GHZ:
-		if (sta->vht_cap.vht_supported &&
+		if (sta->he_cap.has_he) {
+			if (sta->bandwidth == IEEE80211_STA_RX_BW_80)
+				phymode = MODE_11AX_HE80_2G;
+			else if (sta->bandwidth == IEEE80211_STA_RX_BW_40)
+				phymode = MODE_11AX_HE40_2G;
+			else
+				phymode = MODE_11AX_HE20_2G;
+		} else if (sta->vht_cap.vht_supported &&
 		    !ath11k_peer_assoc_h_vht_masked(vht_mcs_mask)) {
 			if (sta->bandwidth == IEEE80211_STA_RX_BW_40)
 				phymode = MODE_11AC_VHT40;
@@ -1486,12 +1587,12 @@ static void ath11k_peer_assoc_h_phymode(struct ath11k *ar,
 		} else {
 			phymode = MODE_11B;
 		}
-		/* TODO: HE */
-
 		break;
 	case NL80211_BAND_5GHZ:
-		/* Check VHT first */
-		if (sta->vht_cap.vht_supported &&
+		/* Check HE first */
+		if (sta->he_cap.has_he) {
+			phymode = ath11k_mac_get_phymode_he(ar, sta);
+		} else if (sta->vht_cap.vht_supported &&
 		    !ath11k_peer_assoc_h_vht_masked(vht_mcs_mask)) {
 			phymode = ath11k_mac_get_phymode_vht(ar, sta);
 		} else if (sta->ht_cap.ht_supported &&
@@ -1503,7 +1604,6 @@ static void ath11k_peer_assoc_h_phymode(struct ath11k *ar,
 		} else {
 			phymode = MODE_11A;
 		}
-		/* TODO: HE Phymode */
 		break;
 	default:
 		break;
@@ -3077,6 +3177,128 @@ static int ath11k_check_chain_mask(struct ath11k *ar, u32 ant, bool is_tx_ant)
 	return 0;
 }
 
+static void ath11k_gen_ppe_thresh(struct ath11k_ppe_threshold *fw_ppet,
+				  u8 *he_ppet)
+{
+	int nss, ru;
+	u8 bit = 7;
+
+	he_ppet[0] = fw_ppet->numss_m1 & IEEE80211_PPE_THRES_NSS_MASK;
+	he_ppet[0] |= (fw_ppet->ru_bit_mask <<
+		       IEEE80211_PPE_THRES_RU_INDEX_BITMASK_POS) &
+		      IEEE80211_PPE_THRES_RU_INDEX_BITMASK_MASK;
+	for (nss = 0; nss <= fw_ppet->numss_m1; nss++) {
+		for (ru = 0; ru < 4; ru++) {
+			u8 val;
+			int i;
+
+			if ((fw_ppet->ru_bit_mask & BIT(ru)) == 0)
+				continue;
+			val = (fw_ppet->ppet16_ppet8_ru3_ru0[nss] >> (ru * 6)) &
+			       0x3f;
+			val = ((val >> 3) & 0x7) | ((val & 0x7) << 3);
+			for (i = 5; i >= 0; i--) {
+				he_ppet[bit / 8] |=
+					((val >> i) & 0x1) << ((bit % 8));
+				bit++;
+			}
+		}
+	}
+}
+
+static int ath11k_mac_copy_he_cap(struct ath11k_pdev_cap *cap,
+				  struct ieee80211_sband_iftype_data *data,
+				  int band)
+{
+	int i, idx = 0;
+
+	for (i = 0; i < NUM_NL80211_IFTYPES; i++) {
+		struct ieee80211_sta_he_cap *he_cap = &data[idx].he_cap;
+		struct ath11k_band_cap *band_cap = &cap->band[band];
+		struct ieee80211_he_cap_elem *he_cap_elem =
+				&he_cap->he_cap_elem;
+
+		switch (i) {
+		case NL80211_IFTYPE_STATION:
+		case NL80211_IFTYPE_AP:
+			break;
+
+		default:
+			continue;
+		}
+
+		data[idx].types_mask = BIT(i);
+		he_cap->has_he = true;
+		memcpy(he_cap_elem->mac_cap_info, band_cap->he_cap_info,
+		       sizeof(he_cap_elem->mac_cap_info));
+		memcpy(he_cap_elem->phy_cap_info, band_cap->he_cap_phy_info,
+		       sizeof(he_cap_elem->phy_cap_info));
+
+		he_cap_elem->mac_cap_info[1] |=
+			IEEE80211_HE_MAC_CAP1_TF_MAC_PAD_DUR_MASK;
+		switch (i) {
+		case NL80211_IFTYPE_AP:
+			he_cap_elem->phy_cap_info[9] |=
+				IEEE80211_HE_PHY_CAP9_RX_1024_QAM_LESS_THAN_242_TONE_RU;
+			break;
+		case NL80211_IFTYPE_STATION:
+			he_cap_elem->mac_cap_info[0] &=
+				~IEEE80211_HE_MAC_CAP0_TWT_RES;
+			he_cap_elem->mac_cap_info[0] |=
+				IEEE80211_HE_MAC_CAP0_TWT_REQ;
+			he_cap_elem->phy_cap_info[9] |=
+				IEEE80211_HE_PHY_CAP9_TX_1024_QAM_LESS_THAN_242_TONE_RU;
+			break;
+		}
+
+		he_cap->he_mcs_nss_supp.rx_mcs_80 =
+			cpu_to_le16(band_cap->he_mcs & 0xffff);
+		he_cap->he_mcs_nss_supp.tx_mcs_80 =
+			cpu_to_le16(band_cap->he_mcs & 0xffff);
+		he_cap->he_mcs_nss_supp.rx_mcs_160 =
+			cpu_to_le16((band_cap->he_mcs >> 16) & 0xffff);
+		he_cap->he_mcs_nss_supp.tx_mcs_160 =
+			cpu_to_le16((band_cap->he_mcs >> 16) & 0xffff);
+		he_cap->he_mcs_nss_supp.rx_mcs_80p80 =
+			cpu_to_le16((band_cap->he_mcs >> 16) & 0xffff);
+		he_cap->he_mcs_nss_supp.tx_mcs_80p80 =
+			cpu_to_le16((band_cap->he_mcs >> 16) & 0xffff);
+
+		memset(he_cap->ppe_thres, 0, sizeof(he_cap->ppe_thres));
+		if (he_cap_elem->phy_cap_info[6] &
+		    IEEE80211_HE_PHY_CAP6_PPE_THRESHOLD_PRESENT)
+			ath11k_gen_ppe_thresh(&band_cap->he_ppet, he_cap->ppe_thres);
+		idx++;
+	}
+
+	return idx;
+}
+
+static void ath11k_mac_setup_he_cap(struct ath11k *ar,
+				    struct ath11k_pdev_cap *cap)
+{
+	struct ieee80211_supported_band *band = NULL;
+	int count = 0;
+
+	if (cap->supported_bands & WMI_HOST_WLAN_2G_CAP) {
+		count = ath11k_mac_copy_he_cap(cap,
+				ar->mac.iftype[NL80211_BAND_2GHZ],
+				NL80211_BAND_2GHZ);
+		band = &ar->mac.sbands[NL80211_BAND_2GHZ];
+		band->iftype_data = ar->mac.iftype[NL80211_BAND_2GHZ];
+	}
+
+	if (cap->supported_bands & WMI_HOST_WLAN_5G_CAP) {
+		count = ath11k_mac_copy_he_cap(cap,
+				ar->mac.iftype[NL80211_BAND_5GHZ],
+				NL80211_BAND_5GHZ);
+		band = &ar->mac.sbands[NL80211_BAND_5GHZ];
+		band->iftype_data = ar->mac.iftype[NL80211_BAND_5GHZ];
+	}
+
+	band->n_iftype_data = count;
+}
+
 static int __ath11k_set_antenna(struct ath11k *ar, u32 tx_ant, u32 rx_ant)
 {
 	int ret;
@@ -3112,8 +3334,9 @@ static int __ath11k_set_antenna(struct ath11k *ar, u32 tx_ant, u32 rx_ant)
 		return ret;
 	}
 
-	/* Reload HT/VHT capability */
+	/* Reload HT/VHT/HE capability */
 	ath11k_mac_setup_ht_vht_cap(ar, &ar->pdev->cap, NULL);
+	ath11k_mac_setup_he_cap(ar, &ar->pdev->cap);
 
 	return 0;
 }
@@ -4976,6 +5199,7 @@ static int ath11k_mac_register(struct ath11k *ar)
 		goto err_free;
 
 	ath11k_mac_setup_ht_vht_cap(ar, cap, &ht_cap);
+	ath11k_mac_setup_he_cap(ar, cap);
 
 	ar->hw->wiphy->available_antennas_rx = cap->rx_chain_mask;
 	ar->hw->wiphy->available_antennas_tx = cap->tx_chain_mask;
diff --git a/drivers/net/wireless/ath/ath11k/reg.c b/drivers/net/wireless/ath/ath11k/reg.c
index 1fef6886088f..d9ff9d631eea 100644
--- a/drivers/net/wireless/ath/ath11k/reg.c
+++ b/drivers/net/wireless/ath/ath11k/reg.c
@@ -138,6 +138,7 @@ int ath11k_reg_update_chan_list(struct ath11k *ar)
 			/* TODO: Set to true/false based on some condition? */
 			ch->allow_ht = true;
 			ch->allow_vht = true;
+			ch->allow_he = true;
 
 			ch->dfs_set =
 				!!(channel->flags & IEEE80211_CHAN_RADAR);
diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index 807c42d5bb22..05b955a9749f 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -741,6 +741,8 @@ static void ath11k_wmi_put_wmi_channel(struct wmi_channel *chan,
 		chan->info |= WMI_CHAN_INFO_ALLOW_HT;
 	if (arg->channel.allow_vht)
 		chan->info |= WMI_CHAN_INFO_ALLOW_VHT;
+	if (arg->channel.allow_he)
+		chan->info |= WMI_CHAN_INFO_ALLOW_HE;
 	if (arg->channel.ht40plus)
 		chan->info |= WMI_CHAN_INFO_HT40_PLUS;
 	if (arg->channel.chan_radar)
@@ -2193,7 +2195,9 @@ int ath11k_wmi_send_scan_chan_list_cmd(struct ath11k *ar,
 
 		if (tchan_info->is_chan_passive)
 			chan_info->info |= WMI_CHAN_INFO_PASSIVE;
-		if (tchan_info->allow_vht)
+		if (tchan_info->allow_he)
+			chan_info->info |= WMI_CHAN_INFO_ALLOW_HE;
+		else if (tchan_info->allow_vht)
 			chan_info->info |= WMI_CHAN_INFO_ALLOW_VHT;
 		else if (tchan_info->allow_ht)
 			chan_info->info |= WMI_CHAN_INFO_ALLOW_HT;
diff --git a/drivers/net/wireless/ath/ath11k/wmi.h b/drivers/net/wireless/ath/ath11k/wmi.h
index 0fa33f38abdf..2e3e0cf866e9 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.h
+++ b/drivers/net/wireless/ath/ath11k/wmi.h
@@ -2996,6 +2996,7 @@ struct channel_param {
 	    is_chan_passive:1,
 	    allow_ht:1,
 	    allow_vht:1,
+	    allow_he:1,
 	    set_agile:1;
 	u32 phy_mode;
 	u32 cfreq1;
@@ -3841,7 +3842,10 @@ struct wmi_vdev_install_key_arg {
 
 #define WMI_MAX_SUPPORTED_RATES			128
 #define WMI_HOST_MAX_HECAP_PHY_SIZE		3
-#define WMI_HOST_MAX_HE_RATE_SET		1
+#define WMI_HOST_MAX_HE_RATE_SET		3
+#define WMI_HECAP_TXRX_MCS_NSS_IDX_80		0
+#define WMI_HECAP_TXRX_MCS_NSS_IDX_160		1
+#define WMI_HECAP_TXRX_MCS_NSS_IDX_80_80	2
 
 struct wmi_rate_set_arg {
 	u32 num_rates;
-- 
2.20.1

