Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF0D1BE1D7
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2020 16:57:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbgD2O52 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 29 Apr 2020 10:57:28 -0400
Received: from nbd.name ([46.4.11.11]:60150 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726456AbgD2O52 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 29 Apr 2020 10:57:28 -0400
Received: from [81.25.161.111] (helo=bertha8.datto.lan)
        by ds12 with esmtpa (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1jTo9K-0002aB-PX; Wed, 29 Apr 2020 16:57:22 +0200
From:   John Crispin <john@phrozen.org>
To:     Johannes Berg <johannes@sipsolutions.net>,
        Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        Miles Hu <milehu@codeaurora.org>,
        John Crispin <john@phrozen.org>
Subject: [PATCH V3 3/3] ath11k: add support for setting fixed HE rate/gi/ltf
Date:   Wed, 29 Apr 2020 16:57:08 +0200
Message-Id: <20200429145708.25992-3-john@phrozen.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200429145708.25992-1-john@phrozen.org>
References: <20200429145708.25992-1-john@phrozen.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Miles Hu <milehu@codeaurora.org>

This patch adds ath11k support for setting fixed HE rate/gi/ltf values that
we are now able to send to the kernel using nl80211. The added code is
reusing parts of the existing code path already used for HT/VHT. The new
helpers are symmetric to how we do it for HT/VHT.

Signed-off-by: Miles Hu <milehu@codeaurora.org>
Signed-off-by: John Crispin <john@phrozen.org>
---
 drivers/net/wireless/ath/ath11k/mac.c | 350 +++++++++++++++++++++++---
 drivers/net/wireless/ath/ath11k/wmi.h |   1 +
 2 files changed, 323 insertions(+), 28 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index e28f5a348be6..aef012912003 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -268,6 +268,18 @@ ath11k_mac_max_vht_nss(const u16 vht_mcs_mask[NL80211_VHT_NSS_MAX])
 	return 1;
 }
 
+static u32
+ath11k_mac_max_he_nss(const u16 he_mcs_mask[NL80211_HE_NSS_MAX])
+{
+	int nss;
+
+	for (nss = NL80211_HE_NSS_MAX - 1; nss >= 0; nss--)
+		if (he_mcs_mask[nss])
+			return nss + 1;
+
+	return 1;
+}
+
 static u8 ath11k_parse_mpdudensity(u8 mpdudensity)
 {
 /* 802.11n D2.0 defined values for "Minimum MPDU Start Spacing":
@@ -1151,17 +1163,98 @@ static void ath11k_peer_assoc_h_vht(struct ath11k *ar,
 	/* TODO: rxnss_override */
 }
 
+static int ath11k_mac_get_max_he_mcs_map(u16 mcs_map, int nss)
+{
+	switch ((mcs_map >> (2 * nss)) & 0x3) {
+	case IEEE80211_HE_MCS_SUPPORT_0_7: return BIT(8) - 1;
+	case IEEE80211_HE_MCS_SUPPORT_0_9: return BIT(10) - 1;
+	case IEEE80211_HE_MCS_SUPPORT_0_11: return BIT(12) - 1;
+	}
+	return 0;
+}
+
+static u16 ath11k_peer_assoc_h_he_limit(u16 tx_mcs_set,
+					const u16 he_mcs_limit[NL80211_HE_NSS_MAX])
+{
+	int idx_limit;
+	int nss;
+	u16 mcs_map;
+	u16 mcs;
+
+	for (nss = 0; nss < NL80211_HE_NSS_MAX; nss++) {
+		mcs_map = ath11k_mac_get_max_he_mcs_map(tx_mcs_set, nss) &
+			  he_mcs_limit[nss];
+
+		if (mcs_map)
+			idx_limit = fls(mcs_map) - 1;
+		else
+			idx_limit = -1;
+
+		switch (idx_limit) {
+		case 0 ... 7:
+			mcs = IEEE80211_HE_MCS_SUPPORT_0_7;
+			break;
+		case 8:
+		case 9:
+			mcs = IEEE80211_HE_MCS_SUPPORT_0_9;
+			break;
+		case 10:
+		case 11:
+			mcs = IEEE80211_HE_MCS_SUPPORT_0_11;
+			break;
+		default:
+			WARN_ON(1);
+			/* fall through */
+		case -1:
+			mcs = IEEE80211_HE_MCS_NOT_SUPPORTED;
+			break;
+		}
+
+		tx_mcs_set &= ~(0x3 << (nss * 2));
+		tx_mcs_set |= mcs << (nss * 2);
+	}
+
+	return tx_mcs_set;
+}
+
+static bool
+ath11k_peer_assoc_h_he_masked(const u16 he_mcs_mask[NL80211_HE_NSS_MAX])
+{
+	int nss;
+
+	for (nss = 0; nss < NL80211_HE_NSS_MAX; nss++)
+		if (he_mcs_mask[nss])
+			return false;
+
+	return true;
+}
+
 static void ath11k_peer_assoc_h_he(struct ath11k *ar,
 				   struct ieee80211_vif *vif,
 				   struct ieee80211_sta *sta,
 				   struct peer_assoc_params *arg)
 {
+	struct ath11k_vif *arvif = (void *)vif->drv_priv;
+	struct cfg80211_chan_def def;
 	const struct ieee80211_sta_he_cap *he_cap = &sta->he_cap;
-	u16 v;
+	enum nl80211_band band;
+	const u16 *he_mcs_mask;
+	u8 max_nss, he_mcs;
+	__le16 he_tx_mcs = 0, v = 0;
+	int i;
+
+	if (WARN_ON(ath11k_mac_vif_chan(vif, &def)))
+		return;
 
 	if (!he_cap->has_he)
 		return;
 
+	band = def.chan->band;
+	he_mcs_mask = arvif->bitrate_mask.control[band].he_mcs;
+
+	if (ath11k_peer_assoc_h_he_masked(he_mcs_mask))
+		return;
+
 	arg->he_flag = true;
 
 	memcpy(&arg->peer_he_cap_macinfo, he_cap->he_cap_elem.mac_cap_info,
@@ -1218,17 +1311,22 @@ static void ath11k_peer_assoc_h_he(struct ath11k *ar,
 			arg->peer_he_rx_mcs_set[WMI_HECAP_TXRX_MCS_NSS_IDX_80_80] = v;
 
 			v = le16_to_cpu(he_cap->he_mcs_nss_supp.tx_mcs_80p80);
+			v = ath11k_peer_assoc_h_he_limit(v, he_mcs_mask);
 			arg->peer_he_tx_mcs_set[WMI_HECAP_TXRX_MCS_NSS_IDX_80_80] = v;
 
 			arg->peer_he_mcs_count++;
+			he_tx_mcs = v;
 		}
 		v = le16_to_cpu(he_cap->he_mcs_nss_supp.rx_mcs_160);
 		arg->peer_he_rx_mcs_set[WMI_HECAP_TXRX_MCS_NSS_IDX_160] = v;
 
 		v = le16_to_cpu(he_cap->he_mcs_nss_supp.tx_mcs_160);
+		v = ath11k_peer_assoc_h_he_limit(v, he_mcs_mask);
 		arg->peer_he_tx_mcs_set[WMI_HECAP_TXRX_MCS_NSS_IDX_160] = v;
 
 		arg->peer_he_mcs_count++;
+		if (!he_tx_mcs)
+			he_tx_mcs = v;
 		/* fall through */
 
 	default:
@@ -1236,11 +1334,29 @@ static void ath11k_peer_assoc_h_he(struct ath11k *ar,
 		arg->peer_he_rx_mcs_set[WMI_HECAP_TXRX_MCS_NSS_IDX_80] = v;
 
 		v = le16_to_cpu(he_cap->he_mcs_nss_supp.tx_mcs_80);
+		v = ath11k_peer_assoc_h_he_limit(v, he_mcs_mask);
 		arg->peer_he_tx_mcs_set[WMI_HECAP_TXRX_MCS_NSS_IDX_80] = v;
 
 		arg->peer_he_mcs_count++;
+		if (!he_tx_mcs)
+			he_tx_mcs = v;
 		break;
 	}
+	/* Calculate peer NSS capability from HE capabilities if STA
+	 * supports HE.
+	 */
+	for (i = 0, max_nss = 0, he_mcs = 0; i < NL80211_HE_NSS_MAX; i++) {
+		he_mcs = __le16_to_cpu(he_tx_mcs) >> (2 * i) & 3;
+
+		if (he_mcs != IEEE80211_HE_MCS_NOT_SUPPORTED &&
+		    he_mcs_mask[i])
+			max_nss = i + 1;
+	}
+	arg->peer_nss = min(sta->rx_nss, max_nss);
+
+	ath11k_dbg(ar->ab, ATH11K_DBG_MAC,
+		   "mac he peer %pM nss %d mcs cnt %d\n",
+		   sta->addr, arg->peer_nss, arg->peer_he_mcs_count);
 }
 
 static void ath11k_peer_assoc_h_smps(struct ieee80211_sta *sta,
@@ -1443,6 +1559,7 @@ static void ath11k_peer_assoc_h_phymode(struct ath11k *ar,
 	enum nl80211_band band;
 	const u8 *ht_mcs_mask;
 	const u16 *vht_mcs_mask;
+	const u16 *he_mcs_mask;
 	enum wmi_phy_mode phymode = MODE_UNKNOWN;
 
 	if (WARN_ON(ath11k_mac_vif_chan(vif, &def)))
@@ -1451,10 +1568,12 @@ static void ath11k_peer_assoc_h_phymode(struct ath11k *ar,
 	band = def.chan->band;
 	ht_mcs_mask = arvif->bitrate_mask.control[band].ht_mcs;
 	vht_mcs_mask = arvif->bitrate_mask.control[band].vht_mcs;
+	he_mcs_mask = arvif->bitrate_mask.control[band].he_mcs;
 
 	switch (band) {
 	case NL80211_BAND_2GHZ:
-		if (sta->he_cap.has_he) {
+		if (sta->he_cap.has_he &&
+		    !ath11k_peer_assoc_h_he_masked(he_mcs_mask)) {
 			if (sta->bandwidth == IEEE80211_STA_RX_BW_80)
 				phymode = MODE_11AX_HE80_2G;
 			else if (sta->bandwidth == IEEE80211_STA_RX_BW_40)
@@ -1481,7 +1600,8 @@ static void ath11k_peer_assoc_h_phymode(struct ath11k *ar,
 		break;
 	case NL80211_BAND_5GHZ:
 		/* Check HE first */
-		if (sta->he_cap.has_he) {
+		if (sta->he_cap.has_he &&
+		    !ath11k_peer_assoc_h_he_masked(he_mcs_mask)) {
 			phymode = ath11k_mac_get_phymode_he(ar, sta);
 		} else if (sta->vht_cap.vht_supported &&
 		    !ath11k_peer_assoc_h_vht_masked(vht_mcs_mask)) {
@@ -2412,6 +2532,20 @@ ath11k_mac_bitrate_mask_num_vht_rates(struct ath11k *ar,
 	return num_rates;
 }
 
+static int
+ath11k_mac_bitrate_mask_num_he_rates(struct ath11k *ar,
+				     enum nl80211_band band,
+				     const struct cfg80211_bitrate_mask *mask)
+{
+	int num_rates = 0;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(mask->control[band].he_mcs); i++)
+		num_rates += hweight16(mask->control[band].he_mcs[i]);
+
+	return num_rates;
+}
+
 static int
 ath11k_mac_set_peer_vht_fixed_rate(struct ath11k_vif *arvif,
 				   struct ieee80211_sta *sta,
@@ -2458,6 +2592,52 @@ ath11k_mac_set_peer_vht_fixed_rate(struct ath11k_vif *arvif,
 	return ret;
 }
 
+static int
+ath11k_mac_set_peer_he_fixed_rate(struct ath11k_vif *arvif,
+				  struct ieee80211_sta *sta,
+				  const struct cfg80211_bitrate_mask *mask,
+				  enum nl80211_band band)
+{
+	struct ath11k *ar = arvif->ar;
+	u8 he_rate, nss;
+	u32 rate_code;
+	int ret, i;
+
+	lockdep_assert_held(&ar->conf_mutex);
+
+	nss = 0;
+
+	for (i = 0; i < ARRAY_SIZE(mask->control[band].he_mcs); i++) {
+		if (hweight16(mask->control[band].he_mcs[i]) == 1) {
+			nss = i + 1;
+			he_rate = ffs(mask->control[band].he_mcs[i]) - 1;
+		}
+	}
+
+	if (!nss) {
+		ath11k_warn(ar->ab, "No single HE Fixed rate found to set for %pM",
+			    sta->addr);
+		return -EINVAL;
+	}
+
+	ath11k_dbg(ar->ab, ATH11K_DBG_MAC,
+		   "Setting Fixed HE Rate for peer %pM. Device will not switch to any other selected rates",
+		   sta->addr);
+
+	rate_code = ATH11K_HW_RATE_CODE(he_rate, nss - 1,
+					WMI_RATE_PREAMBLE_HE);
+	ret = ath11k_wmi_set_peer_param(ar, sta->addr,
+					arvif->vdev_id,
+					WMI_PEER_PARAM_FIXED_RATE,
+					rate_code);
+	if (ret)
+		ath11k_warn(ar->ab,
+			    "failed to update STA %pM Fixed Rate %d: %d\n",
+			     sta->addr, rate_code, ret);
+
+	return ret;
+}
+
 static int ath11k_station_assoc(struct ath11k *ar,
 				struct ieee80211_vif *vif,
 				struct ieee80211_sta *sta,
@@ -2576,8 +2756,9 @@ static void ath11k_sta_rc_update_wk(struct work_struct *wk)
 	enum nl80211_band band;
 	const u8 *ht_mcs_mask;
 	const u16 *vht_mcs_mask;
+	const u16 *he_mcs_mask;
 	u32 changed, bw, nss, smps;
-	int err, num_vht_rates;
+	int err, num_vht_rates,  num_he_rates;
 	const struct cfg80211_bitrate_mask *mask;
 	struct peer_assoc_params peer_arg;
 
@@ -2592,6 +2773,7 @@ static void ath11k_sta_rc_update_wk(struct work_struct *wk)
 	band = def.chan->band;
 	ht_mcs_mask = arvif->bitrate_mask.control[band].ht_mcs;
 	vht_mcs_mask = arvif->bitrate_mask.control[band].vht_mcs;
+	he_mcs_mask = arvif->bitrate_mask.control[band].he_mcs;
 
 	spin_lock_bh(&ar->data_lock);
 
@@ -2607,8 +2789,9 @@ static void ath11k_sta_rc_update_wk(struct work_struct *wk)
 	mutex_lock(&ar->conf_mutex);
 
 	nss = max_t(u32, 1, nss);
-	nss = min(nss, max(ath11k_mac_max_ht_nss(ht_mcs_mask),
-			   ath11k_mac_max_vht_nss(vht_mcs_mask)));
+	nss = min(nss, max(max(ath11k_mac_max_ht_nss(ht_mcs_mask),
+			       ath11k_mac_max_vht_nss(vht_mcs_mask)),
+			   ath11k_mac_max_he_nss(he_mcs_mask)));
 
 	if (changed & IEEE80211_RC_BW_CHANGED) {
 		err = ath11k_wmi_set_peer_param(ar, sta->addr, arvif->vdev_id,
@@ -2644,6 +2827,8 @@ static void ath11k_sta_rc_update_wk(struct work_struct *wk)
 		mask = &arvif->bitrate_mask;
 		num_vht_rates = ath11k_mac_bitrate_mask_num_vht_rates(ar, band,
 								      mask);
+		num_he_rates = ath11k_mac_bitrate_mask_num_he_rates(ar, band,
+								    mask);
 
 		/* Peer_assoc_prepare will reject vht rates in
 		 * bitrate_mask if its not available in range format and
@@ -2659,6 +2844,9 @@ static void ath11k_sta_rc_update_wk(struct work_struct *wk)
 		if (sta->vht_cap.vht_supported && num_vht_rates == 1) {
 			ath11k_mac_set_peer_vht_fixed_rate(arvif, sta, mask,
 							   band);
+		} else if (sta->he_cap.has_he && num_he_rates == 1) {
+			ath11k_mac_set_peer_he_fixed_rate(arvif, sta, mask,
+							  band);
 		} else {
 			/* If the peer is non-VHT or no fixed VHT rate
 			 * is provided in the new bitrate mask we set the
@@ -4097,6 +4285,8 @@ static int ath11k_mac_op_add_interface(struct ieee80211_hw *hw,
 		       sizeof(arvif->bitrate_mask.control[i].ht_mcs));
 		memset(arvif->bitrate_mask.control[i].vht_mcs, 0xff,
 		       sizeof(arvif->bitrate_mask.control[i].vht_mcs));
+		memset(arvif->bitrate_mask.control[i].he_mcs, 0xff,
+		       sizeof(arvif->bitrate_mask.control[i].he_mcs));
 	}
 
 	bit = __ffs64(ab->free_vdev_map);
@@ -5022,9 +5212,25 @@ ath11k_mac_has_single_legacy_rate(struct ath11k *ar,
 	if (ath11k_mac_bitrate_mask_num_vht_rates(ar, band, mask))
 		return false;
 
+	if (ath11k_mac_bitrate_mask_num_he_rates(ar, band, mask))
+		return false;
+
 	return num_rates == 1;
 }
 
+u16 ath11k_mac_get_tx_mcs_map(const struct ieee80211_sta_he_cap *he_cap)
+{
+	if (he_cap->he_cap_elem.phy_cap_info[0] &
+	    IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_80PLUS80_MHZ_IN_5G)
+		return he_cap->he_mcs_nss_supp.tx_mcs_80p80;
+
+	if (he_cap->he_cap_elem.phy_cap_info[0] &
+	    IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_160MHZ_IN_5G)
+		return he_cap->he_mcs_nss_supp.tx_mcs_160;
+
+	return he_cap->he_mcs_nss_supp.tx_mcs_80;
+}
+
 static bool
 ath11k_mac_bitrate_mask_get_single_nss(struct ath11k *ar,
 				       enum nl80211_band band,
@@ -5033,8 +5239,10 @@ ath11k_mac_bitrate_mask_get_single_nss(struct ath11k *ar,
 {
 	struct ieee80211_supported_band *sband = &ar->mac.sbands[band];
 	u16 vht_mcs_map = le16_to_cpu(sband->vht_cap.vht_mcs.tx_mcs_map);
+	u16 he_mcs_map = 0;
 	u8 ht_nss_mask = 0;
 	u8 vht_nss_mask = 0;
+	u8 he_nss_mask = 0;
 	int i;
 
 	/* No need to consider legacy here. Basic rates are always present
@@ -5061,7 +5269,19 @@ ath11k_mac_bitrate_mask_get_single_nss(struct ath11k *ar,
 			return false;
 	}
 
-	if (ht_nss_mask != vht_nss_mask)
+	he_mcs_map = le16_to_cpu(ath11k_mac_get_tx_mcs_map(&sband->iftype_data->he_cap));
+
+	for (i = 0; i < ARRAY_SIZE(mask->control[band].he_mcs); i++) {
+		if (mask->control[band].he_mcs[i] == 0)
+			continue;
+		else if (mask->control[band].he_mcs[i] ==
+			 ath11k_mac_get_max_he_mcs_map(he_mcs_map, i))
+			he_nss_mask |= BIT(i);
+		else
+			return false;
+	}
+
+	if (ht_nss_mask != vht_nss_mask || ht_nss_mask != he_nss_mask)
 		return false;
 
 	if (ht_nss_mask == 0)
@@ -5109,7 +5329,8 @@ ath11k_mac_get_single_legacy_rate(struct ath11k *ar,
 }
 
 static int ath11k_mac_set_fixed_rate_params(struct ath11k_vif *arvif,
-					    u32 rate, u8 nss, u8 sgi, u8 ldpc)
+					    u32 rate, u8 nss, u8 sgi, u8 ldpc,
+					    u8 he_gi, u8 he_ltf)
 {
 	struct ath11k *ar = arvif->ar;
 	u32 vdev_param;
@@ -5120,15 +5341,16 @@ static int ath11k_mac_set_fixed_rate_params(struct ath11k_vif *arvif,
 	ath11k_dbg(ar->ab, ATH11K_DBG_MAC, "mac set fixed rate params vdev %i rate 0x%02hhx nss %hhu sgi %hhu\n",
 		   arvif->vdev_id, rate, nss, sgi);
 
-	vdev_param = WMI_VDEV_PARAM_FIXED_RATE;
-	ret = ath11k_wmi_vdev_set_param_cmd(ar, arvif->vdev_id,
-					    vdev_param, rate);
-	if (ret) {
-		ath11k_warn(ar->ab, "failed to set fixed rate param 0x%02x: %d\n",
-			    rate, ret);
-		return ret;
+	if (!arvif->vif->bss_conf.he_support) {
+		vdev_param = WMI_VDEV_PARAM_FIXED_RATE;
+		ret = ath11k_wmi_vdev_set_param_cmd(ar, arvif->vdev_id,
+						    vdev_param, rate);
+		if (ret) {
+			ath11k_warn(ar->ab, "failed to set fixed rate param 0x%02x: %d\n",
+				    rate, ret);
+			return ret;
+		}
 	}
-
 	vdev_param = WMI_VDEV_PARAM_NSS;
 	ret = ath11k_wmi_vdev_set_param_cmd(ar, arvif->vdev_id,
 					    vdev_param, nss);
@@ -5138,15 +5360,6 @@ static int ath11k_mac_set_fixed_rate_params(struct ath11k_vif *arvif,
 		return ret;
 	}
 
-	vdev_param = WMI_VDEV_PARAM_SGI;
-	ret = ath11k_wmi_vdev_set_param_cmd(ar, arvif->vdev_id,
-					    vdev_param, sgi);
-	if (ret) {
-		ath11k_warn(ar->ab, "failed to set sgi param %d: %d\n",
-			    sgi, ret);
-		return ret;
-	}
-
 	vdev_param = WMI_VDEV_PARAM_LDPC;
 	ret = ath11k_wmi_vdev_set_param_cmd(ar, arvif->vdev_id,
 					    vdev_param, ldpc);
@@ -5156,6 +5369,43 @@ static int ath11k_mac_set_fixed_rate_params(struct ath11k_vif *arvif,
 		return ret;
 	}
 
+	if (arvif->vif->bss_conf.he_support) {
+		if (he_gi != 0xFF) {
+			vdev_param = WMI_VDEV_PARAM_SGI;
+			/* 0.8 = 0, 1.6 = 2 and 3.2 = 3. */
+			if (he_gi)
+				he_gi += 1;
+			ret = ath11k_wmi_vdev_set_param_cmd(ar, arvif->vdev_id,
+							    vdev_param, he_gi);
+			if (ret) {
+				ath11k_warn(ar->ab, "failed to set hegi param %d: %d\n",
+					    sgi, ret);
+				return ret;
+			}
+		}
+		if (he_ltf != 0xFF) {
+			vdev_param = WMI_VDEV_PARAM_HE_LTF;
+				/* start from 1 */
+				he_ltf += 1;
+			ret = ath11k_wmi_vdev_set_param_cmd(ar, arvif->vdev_id,
+							    vdev_param, he_ltf);
+			if (ret) {
+				ath11k_warn(ar->ab, "failed to set heltf param %d: %d\n",
+					    he_ltf, ret);
+					return ret;
+			}
+		}
+	} else {
+		vdev_param = WMI_VDEV_PARAM_SGI;
+		ret = ath11k_wmi_vdev_set_param_cmd(ar, arvif->vdev_id,
+						    vdev_param, sgi);
+		if (ret) {
+			ath11k_warn(ar->ab, "failed to set sgi param %d: %d\n",
+				    sgi, ret);
+			return ret;
+		}
+	}
+
 	return 0;
 }
 
@@ -5184,6 +5434,31 @@ ath11k_mac_vht_mcs_range_present(struct ath11k *ar,
 	return true;
 }
 
+static bool
+ath11k_mac_he_mcs_range_present(struct ath11k *ar,
+				enum nl80211_band band,
+				const struct cfg80211_bitrate_mask *mask)
+{
+	int i;
+	u16 he_mcs;
+
+	for (i = 0; i < NL80211_HE_NSS_MAX; i++) {
+		he_mcs = mask->control[band].he_mcs[i];
+
+		switch (he_mcs) {
+		case 0:
+		case BIT(8) - 1:
+		case BIT(10) - 1:
+		case BIT(12) - 1:
+			break;
+		default:
+			return false;
+		}
+	}
+
+	return true;
+}
+
 static void ath11k_mac_set_bitrate_mask_iter(void *data,
 					     struct ieee80211_sta *sta)
 {
@@ -5226,6 +5501,9 @@ ath11k_mac_op_set_bitrate_mask(struct ieee80211_hw *hw,
 	enum nl80211_band band;
 	const u8 *ht_mcs_mask;
 	const u16 *vht_mcs_mask;
+	const u16 *he_mcs_mask;
+	u8 he_ltf = 0;
+	u8 he_gi = 0;
 	u32 rate;
 	u8 nss;
 	u8 sgi;
@@ -5240,12 +5518,16 @@ ath11k_mac_op_set_bitrate_mask(struct ieee80211_hw *hw,
 	band = def.chan->band;
 	ht_mcs_mask = mask->control[band].ht_mcs;
 	vht_mcs_mask = mask->control[band].vht_mcs;
+	he_mcs_mask = mask->control[band].he_mcs;
 	ldpc = !!(ar->ht_cap_info & WMI_HT_CAP_LDPC);
 
 	sgi = mask->control[band].gi;
 	if (sgi == NL80211_TXRATE_FORCE_LGI)
 		return -EINVAL;
 
+	he_gi = mask->control[band].he_gi;
+	he_ltf = mask->control[band].he_ltf;
+
 	/* mac80211 doesn't support sending a fixed HT/VHT MCS alone, rather it
 	 * requires passing atleast one of used basic rates along with them.
 	 * Fixed rate setting across different preambles(legacy, HT, VHT) is
@@ -5272,8 +5554,9 @@ ath11k_mac_op_set_bitrate_mask(struct ieee80211_hw *hw,
 	} else {
 		rate = WMI_FIXED_RATE_NONE;
 		nss = min_t(u32, ar->num_tx_chains,
-			    max(ath11k_mac_max_ht_nss(ht_mcs_mask),
-				ath11k_mac_max_vht_nss(vht_mcs_mask)));
+			    max(max(ath11k_mac_max_ht_nss(ht_mcs_mask),
+				    ath11k_mac_max_vht_nss(vht_mcs_mask)),
+				ath11k_mac_max_he_nss(he_mcs_mask)));
 
 		/* If multiple rates across different preambles are given
 		 * we can reconfigure this info with all peers using PEER_ASSOC
@@ -5308,6 +5591,16 @@ ath11k_mac_op_set_bitrate_mask(struct ieee80211_hw *hw,
 			return -EINVAL;
 		}
 
+		num_rates = ath11k_mac_bitrate_mask_num_he_rates(ar, band,
+								 mask);
+
+		if (!ath11k_mac_he_mcs_range_present(ar, band, mask) &&
+		    num_rates > 1) {
+			ath11k_warn(ar->ab,
+				    "Setting more than one HE MCS Value in bitrate mask not supported\n");
+			return -EINVAL;
+		}
+
 		ieee80211_iterate_stations_atomic(ar->hw,
 						  ath11k_mac_disable_peer_fixed_rate,
 						  arvif);
@@ -5324,7 +5617,8 @@ ath11k_mac_op_set_bitrate_mask(struct ieee80211_hw *hw,
 
 	mutex_lock(&ar->conf_mutex);
 
-	ret = ath11k_mac_set_fixed_rate_params(arvif, rate, nss, sgi, ldpc);
+	ret = ath11k_mac_set_fixed_rate_params(arvif, rate, nss, sgi, ldpc,
+					       he_gi, he_ltf);
 	if (ret) {
 		ath11k_warn(ar->ab, "failed to set fixed rate params on vdev %i: %d\n",
 			    arvif->vdev_id, ret);
diff --git a/drivers/net/wireless/ath/ath11k/wmi.h b/drivers/net/wireless/ath/ath11k/wmi.h
index 742fcd6e37a3..82929415e119 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.h
+++ b/drivers/net/wireless/ath/ath11k/wmi.h
@@ -1008,6 +1008,7 @@ enum wmi_tlv_vdev_param {
 	WMI_VDEV_PARAM_HE_RANGE_EXT,
 	WMI_VDEV_PARAM_ENABLE_BCAST_PROBE_RESPONSE,
 	WMI_VDEV_PARAM_FILS_MAX_CHANNEL_GUARD_TIME,
+	WMI_VDEV_PARAM_HE_LTF = 0x74,
 	WMI_VDEV_PARAM_BA_MODE = 0x7e,
 	WMI_VDEV_PARAM_SET_HE_SOUNDING_MODE = 0x87,
 	WMI_VDEV_PARAM_PROTOTYPE = 0x8000,
-- 
2.20.1

