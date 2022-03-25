Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 521174E6F28
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Mar 2022 08:49:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241974AbiCYHu4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 25 Mar 2022 03:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233984AbiCYHuz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 25 Mar 2022 03:50:55 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 366DE48396
        for <linux-wireless@vger.kernel.org>; Fri, 25 Mar 2022 00:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1648194560; x=1679730560;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=6gjgWBmI/ubBbtAWoxKRpYZMTUVzGXVpdr/23/5VaMY=;
  b=b+mStkZESNcndyKF7TmY3Dirm6C2CSFpynfSJ4r3ukeRp9MPVcQBA0ep
   0ZhQeqWxlSyn9qPCb8oCZotclZCsLjPQChNsVEQs4O9a6i8g+2Sot6VmW
   Zp6tVTdV/Bvg0n35ciuo7hSfRR24pmvOXm+QpzDwIWPAIf7WwWPBk97dG
   U=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 25 Mar 2022 00:49:20 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2022 00:49:19 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 25 Mar 2022 00:49:19 -0700
Received: from srirrama-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 25 Mar 2022 00:49:16 -0700
From:   Sriram R <quic_srirrama@quicinc.com>
To:     <johannes@sipsolutions.net>, <linux-wireless@vger.kernel.org>
CC:     Sriram R <quic_srirrama@quicinc.com>
Subject: [RFC] mac80211: prepare sta handling for MLO support
Date:   Fri, 25 Mar 2022 13:18:17 +0530
Message-ID: <1648194497-15848-1-git-send-email-quic_srirrama@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Currently in mac80211 each STA object is represented
using sta_info datastructure with the associated
STA specific information and drivers access ieee80211_sta
part of it.

With MLO (Multi Link Operation) support being added
in 802.11be standard, though the association is logically
with a single Multi Link capable STA, at the physical level
communication can happen via different advertised
links (uniquely identified by Channel, operating class,
BSSID) and hence the need to handle multiple link
STA parameters within a composite sta_info object
called the MLD STA. The different link STA part of
MLD STA are identified using the link address which can
be same or different as the MLD STA address and unique
link id based on the link vif.

To support extension of such a model, the sta_info
datastructure is modified to hold multiple link STA
objects with link specific params currently within
sta_info moved to this new structure. Similarly this is
done for ieee80211_sta as well which will be accessed
within mac80211 as well as by drivers, hence trivial
driver changes are expected to support this.

For current non MLO supported drivers, only one link STA
is present and 0th index represents its link params.

Note for MLO supported drivers:
In mac80211 ops, the link id can be fetched from the
passed link vif struct (TBD) and corresponding link STA
within ieee80211_sta can be accessed. If the vif passed to
the driver is a MLD vif in any case, it implies all
the affliated link vif and its link STA needs to
be handled for the particular mac80211 op.
For MLO usage, in cases where we need link sta(ex. to
get MLD STA from link address in 802.11 header) needs a new
lookup function to search for link sta address, This is TBD.
For legacy driver too this will work directly since the
address in sta_info and link_sta_info are same.
MLD supported drivers need to pass the link id or link
address and pubsta for ethernet mode to find the link sta.
Stats are accumulated per link sta and finally aggregated
if mld sta stats is required.

Currently all link STA pointers are accessed directly
using 0th index. These will be updated to access via link id
with MLO support patches, with link id being 0 for non MLO
supported cases.

RFC Note:
This patch breaks build since it requires changes in all
mac80211 based drivers. Only ath11k driver changes are added
here for reference. All driver changes will be covered once
we arrive at final design.
Basically for existing drivers, the link params that are moved
to a new struct within ieee80211_sta will be accessed via first link.
Ex. 'sta->rx_nss' will change to 'sta->link[0]->rx_nss'


Signed-off-by: Sriram R <quic_srirrama@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/mac.c | 142 ++++++++++++-------------
 include/net/mac80211.h                |  51 +++++++--
 net/mac80211/agg-rx.c                 |   8 +-
 net/mac80211/agg-tx.c                 |   6 +-
 net/mac80211/airtime.c                |   4 +-
 net/mac80211/cfg.c                    |   8 +-
 net/mac80211/chan.c                   |  10 +-
 net/mac80211/debugfs_sta.c            |   8 +-
 net/mac80211/ethtool.c                |  22 ++--
 net/mac80211/he.c                     |   8 +-
 net/mac80211/ht.c                     |   8 +-
 net/mac80211/ibss.c                   |  14 +--
 net/mac80211/key.c                    |   8 +-
 net/mac80211/mesh_hwmp.c              |   2 +-
 net/mac80211/mesh_plink.c             |  16 +--
 net/mac80211/mlme.c                   |  14 +--
 net/mac80211/rate.c                   |   4 +-
 net/mac80211/rc80211_minstrel_ht.c    |  20 ++--
 net/mac80211/rx.c                     |  84 +++++++--------
 net/mac80211/s1g.c                    |   4 +-
 net/mac80211/sta_info.c               | 190 ++++++++++++++++++++++++----------
 net/mac80211/sta_info.h               | 147 +++++++++++++++-----------
 net/mac80211/status.c                 |  41 ++++----
 net/mac80211/tdls.c                   |  26 ++---
 net/mac80211/trace.h                  |   4 +-
 net/mac80211/tx.c                     |  26 ++---
 net/mac80211/vht.c                    |  72 ++++++-------
 27 files changed, 544 insertions(+), 403 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 07f499d..39bbf68 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -1671,7 +1671,7 @@ static void ath11k_peer_assoc_h_ht(struct ath11k *ar,
 				   struct ieee80211_sta *sta,
 				   struct peer_assoc_params *arg)
 {
-	const struct ieee80211_sta_ht_cap *ht_cap = &sta->ht_cap;
+	const struct ieee80211_sta_ht_cap *ht_cap = &sta->link[0]->ht_cap;
 	struct ath11k_vif *arvif = (void *)vif->drv_priv;
 	struct cfg80211_chan_def def;
 	enum nl80211_band band;
@@ -1708,7 +1708,7 @@ static void ath11k_peer_assoc_h_ht(struct ath11k *ar,
 	if (ht_cap->cap & IEEE80211_HT_CAP_LDPC_CODING)
 		arg->ldpc_flag = true;
 
-	if (sta->bandwidth >= IEEE80211_STA_RX_BW_40) {
+	if (sta->link[0]->bandwidth >= IEEE80211_STA_RX_BW_40) {
 		arg->bw_40 = true;
 		arg->peer_rate_caps |= WMI_HOST_RC_CW40_FLAG;
 	}
@@ -1766,7 +1766,7 @@ static void ath11k_peer_assoc_h_ht(struct ath11k *ar,
 			arg->peer_ht_rates.rates[i] = i;
 	} else {
 		arg->peer_ht_rates.num_rates = n;
-		arg->peer_nss = min(sta->rx_nss, max_nss);
+		arg->peer_nss = min(sta->link[0]->rx_nss, max_nss);
 	}
 
 	ath11k_dbg(ar->ab, ATH11K_DBG_MAC, "mac ht peer %pM mcs cnt %d nss %d\n",
@@ -1868,7 +1868,7 @@ static void ath11k_peer_assoc_h_vht(struct ath11k *ar,
 				    struct ieee80211_sta *sta,
 				    struct peer_assoc_params *arg)
 {
-	const struct ieee80211_sta_vht_cap *vht_cap = &sta->vht_cap;
+	const struct ieee80211_sta_vht_cap *vht_cap = &sta->link[0]->vht_cap;
 	struct ath11k_vif *arvif = (void *)vif->drv_priv;
 	struct cfg80211_chan_def def;
 	enum nl80211_band band;
@@ -1914,17 +1914,17 @@ static void ath11k_peer_assoc_h_vht(struct ath11k *ar,
 				 (1U << (IEEE80211_HT_MAX_AMPDU_FACTOR +
 					ampdu_factor)) - 1);
 
-	if (sta->bandwidth == IEEE80211_STA_RX_BW_80)
+	if (sta->link[0]->bandwidth == IEEE80211_STA_RX_BW_80)
 		arg->bw_80 = true;
 
-	if (sta->bandwidth == IEEE80211_STA_RX_BW_160)
+	if (sta->link[0]->bandwidth == IEEE80211_STA_RX_BW_160)
 		arg->bw_160 = true;
 
 	vht_nss =  ath11k_mac_max_vht_nss(vht_mcs_mask);
 
-	if (vht_nss > sta->rx_nss) {
+	if (vht_nss > sta->link[0]->rx_nss) {
 		user_rate_valid = false;
-		for (nss_idx = sta->rx_nss - 1; nss_idx >= 0; nss_idx--) {
+		for (nss_idx = sta->link[0]->rx_nss - 1; nss_idx >= 0; nss_idx--) {
 			if (vht_mcs_mask[nss_idx]) {
 				user_rate_valid = true;
 				break;
@@ -1934,8 +1934,8 @@ static void ath11k_peer_assoc_h_vht(struct ath11k *ar,
 
 	if (!user_rate_valid) {
 		ath11k_dbg(ar->ab, ATH11K_DBG_MAC, "mac setting vht range mcs value to peer supported nss %d for peer %pM\n",
-			   sta->rx_nss, sta->addr);
-		vht_mcs_mask[sta->rx_nss - 1] = vht_mcs_mask[vht_nss - 1];
+			   sta->link[0]->rx_nss, sta->addr);
+		vht_mcs_mask[sta->link[0]->rx_nss - 1] = vht_mcs_mask[vht_nss - 1];
 	}
 
 	/* Calculate peer NSS capability from VHT capabilities if STA
@@ -1949,7 +1949,7 @@ static void ath11k_peer_assoc_h_vht(struct ath11k *ar,
 		    vht_mcs_mask[i])
 			max_nss = i + 1;
 	}
-	arg->peer_nss = min(sta->rx_nss, max_nss);
+	arg->peer_nss = min(sta->link[0]->rx_nss, max_nss);
 	arg->rx_max_rate = __le16_to_cpu(vht_cap->vht_mcs.rx_highest);
 	arg->rx_mcs_set = __le16_to_cpu(vht_cap->vht_mcs.rx_mcs_map);
 	arg->tx_max_rate = __le16_to_cpu(vht_cap->vht_mcs.tx_highest);
@@ -2068,7 +2068,7 @@ static void ath11k_peer_assoc_h_he(struct ath11k *ar,
 {
 	struct ath11k_vif *arvif = (void *)vif->drv_priv;
 	struct cfg80211_chan_def def;
-	const struct ieee80211_sta_he_cap *he_cap = &sta->he_cap;
+	const struct ieee80211_sta_he_cap *he_cap = &sta->link[0]->he_cap;
 	enum nl80211_band band;
 	u16 *he_mcs_mask;
 	u8 max_nss, he_mcs;
@@ -2125,7 +2125,7 @@ static void ath11k_peer_assoc_h_he(struct ath11k *ar,
 	else
 		max_nss = rx_mcs_80;
 
-	arg->peer_nss = min(sta->rx_nss, max_nss);
+	arg->peer_nss = min(sta->link[0]->rx_nss, max_nss);
 
 	memcpy_and_pad(&arg->peer_he_cap_macinfo,
 		       sizeof(arg->peer_he_cap_macinfo),
@@ -2157,10 +2157,10 @@ static void ath11k_peer_assoc_h_he(struct ath11k *ar,
 				   IEEE80211_HE_MAC_CAP3_MAX_AMPDU_LEN_EXP_MASK);
 
 	if (ampdu_factor) {
-		if (sta->vht_cap.vht_supported)
+		if (sta->link[0]->vht_cap.vht_supported)
 			arg->peer_max_mpdu = (1 << (IEEE80211_HE_VHT_MAX_AMPDU_FACTOR +
 						    ampdu_factor)) - 1;
-		else if (sta->ht_cap.ht_supported)
+		else if (sta->link[0]->ht_cap.ht_supported)
 			arg->peer_max_mpdu = (1 << (IEEE80211_HE_HT_MAX_AMPDU_FACTOR +
 						    ampdu_factor)) - 1;
 	}
@@ -2203,9 +2203,9 @@ static void ath11k_peer_assoc_h_he(struct ath11k *ar,
 
 	he_nss =  ath11k_mac_max_he_nss(he_mcs_mask);
 
-	if (he_nss > sta->rx_nss) {
+	if (he_nss > sta->link[0]->rx_nss) {
 		user_rate_valid = false;
-		for (nss_idx = sta->rx_nss - 1; nss_idx >= 0; nss_idx--) {
+		for (nss_idx = sta->link[0]->rx_nss - 1; nss_idx >= 0; nss_idx--) {
 			if (he_mcs_mask[nss_idx]) {
 				user_rate_valid = true;
 				break;
@@ -2215,11 +2215,11 @@ static void ath11k_peer_assoc_h_he(struct ath11k *ar,
 
 	if (!user_rate_valid) {
 		ath11k_dbg(ar->ab, ATH11K_DBG_MAC, "mac setting he range mcs value to peer supported nss %d for peer %pM\n",
-			   sta->rx_nss, sta->addr);
-		he_mcs_mask[sta->rx_nss - 1] = he_mcs_mask[he_nss - 1];
+			   sta->link[0]->rx_nss, sta->addr);
+		he_mcs_mask[sta->link[0]->rx_nss - 1] = he_mcs_mask[he_nss - 1];
 	}
 
-	switch (sta->bandwidth) {
+	switch (sta->link[0]->bandwidth) {
 	case IEEE80211_STA_RX_BW_160:
 		if (he_cap->he_cap_elem.phy_cap_info[0] &
 		    IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_80PLUS80_MHZ_IN_5G) {
@@ -2273,7 +2273,7 @@ static void ath11k_peer_assoc_h_he(struct ath11k *ar,
 		    he_mcs_mask[i])
 			max_nss = i + 1;
 	}
-	arg->peer_nss = min(sta->rx_nss, max_nss);
+	arg->peer_nss = min(sta->link[0]->rx_nss, max_nss);
 
 	if (arg->peer_phymode == MODE_11AX_HE160 ||
 	    arg->peer_phymode == MODE_11AX_HE80_80) {
@@ -2296,7 +2296,7 @@ static void ath11k_peer_assoc_h_he(struct ath11k *ar,
 
 	ath11k_dbg(ar->ab, ATH11K_DBG_MAC,
 		   "mac he peer %pM nss %d mcs cnt %d nss_override 0x%x\n",
-		   sta->addr, arg->peer_nss,
+		   sta->link[0]->addr, arg->peer_nss,
 		   arg->peer_he_mcs_count,
 		   arg->peer_bw_rxnss_override);
 }
@@ -2306,7 +2306,7 @@ static void ath11k_peer_assoc_h_he_6ghz(struct ath11k *ar,
 					struct ieee80211_sta *sta,
 					struct peer_assoc_params *arg)
 {
-	const struct ieee80211_sta_he_cap *he_cap = &sta->he_cap;
+	const struct ieee80211_sta_he_cap *he_cap = &sta->link[0]->he_cap;
 	struct cfg80211_chan_def def;
 	enum nl80211_band band;
 	u8  ampdu_factor;
@@ -2316,16 +2316,16 @@ static void ath11k_peer_assoc_h_he_6ghz(struct ath11k *ar,
 
 	band = def.chan->band;
 
-	if (!arg->he_flag || band != NL80211_BAND_6GHZ || !sta->he_6ghz_capa.capa)
+	if (!arg->he_flag || band != NL80211_BAND_6GHZ || !sta->link[0]->he_6ghz_capa.capa)
 		return;
 
-	if (sta->bandwidth == IEEE80211_STA_RX_BW_80)
+	if (sta->link[0]->bandwidth == IEEE80211_STA_RX_BW_80)
 		arg->bw_80 = true;
 
-	if (sta->bandwidth == IEEE80211_STA_RX_BW_160)
+	if (sta->link[0]->bandwidth == IEEE80211_STA_RX_BW_160)
 		arg->bw_160 = true;
 
-	arg->peer_he_caps_6ghz = le16_to_cpu(sta->he_6ghz_capa.capa);
+	arg->peer_he_caps_6ghz = le16_to_cpu(sta->link[0]->he_6ghz_capa.capa);
 	arg->peer_mpdu_density =
 		ath11k_parse_mpdudensity(FIELD_GET(IEEE80211_HE_6GHZ_CAP_MIN_MPDU_START,
 						   arg->peer_he_caps_6ghz));
@@ -2351,17 +2351,17 @@ static void ath11k_peer_assoc_h_he_6ghz(struct ath11k *ar,
 static void ath11k_peer_assoc_h_smps(struct ieee80211_sta *sta,
 				     struct peer_assoc_params *arg)
 {
-	const struct ieee80211_sta_ht_cap *ht_cap = &sta->ht_cap;
+	const struct ieee80211_sta_ht_cap *ht_cap = &sta->link[0]->ht_cap;
 	int smps;
 
-	if (!ht_cap->ht_supported && !sta->he_6ghz_capa.capa)
+	if (!ht_cap->ht_supported && !sta->link[0]->he_6ghz_capa.capa)
 		return;
 
 	if (ht_cap->ht_supported) {
 		smps = ht_cap->cap & IEEE80211_HT_CAP_SM_PS;
 		smps >>= IEEE80211_HT_CAP_SM_PS_SHIFT;
 	} else {
-		smps = le16_get_bits(sta->he_6ghz_capa.capa,
+		smps = le16_get_bits(sta->link[0]->he_6ghz_capa.capa,
 				     IEEE80211_HE_6GHZ_CAP_SM_PS);
 	}
 
@@ -2492,8 +2492,8 @@ static bool ath11k_mac_sta_has_ofdm_only(struct ieee80211_sta *sta)
 static enum wmi_phy_mode ath11k_mac_get_phymode_vht(struct ath11k *ar,
 						    struct ieee80211_sta *sta)
 {
-	if (sta->bandwidth == IEEE80211_STA_RX_BW_160) {
-		switch (sta->vht_cap.cap &
+	if (sta->link[0]->bandwidth == IEEE80211_STA_RX_BW_160) {
+		switch (sta->link[0]->vht_cap.cap &
 			IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_MASK) {
 		case IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_160MHZ:
 			return MODE_11AC_VHT160;
@@ -2505,13 +2505,13 @@ static enum wmi_phy_mode ath11k_mac_get_phymode_vht(struct ath11k *ar,
 		}
 	}
 
-	if (sta->bandwidth == IEEE80211_STA_RX_BW_80)
+	if (sta->link[0]->bandwidth == IEEE80211_STA_RX_BW_80)
 		return MODE_11AC_VHT80;
 
-	if (sta->bandwidth == IEEE80211_STA_RX_BW_40)
+	if (sta->link[0]->bandwidth == IEEE80211_STA_RX_BW_40)
 		return MODE_11AC_VHT40;
 
-	if (sta->bandwidth == IEEE80211_STA_RX_BW_20)
+	if (sta->link[0]->bandwidth == IEEE80211_STA_RX_BW_20)
 		return MODE_11AC_VHT20;
 
 	return MODE_UNKNOWN;
@@ -2520,24 +2520,24 @@ static enum wmi_phy_mode ath11k_mac_get_phymode_vht(struct ath11k *ar,
 static enum wmi_phy_mode ath11k_mac_get_phymode_he(struct ath11k *ar,
 						   struct ieee80211_sta *sta)
 {
-	if (sta->bandwidth == IEEE80211_STA_RX_BW_160) {
-		if (sta->he_cap.he_cap_elem.phy_cap_info[0] &
+	if (sta->link[0]->bandwidth == IEEE80211_STA_RX_BW_160) {
+		if (sta->link[0]->he_cap.he_cap_elem.phy_cap_info[0] &
 		     IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_160MHZ_IN_5G)
 			return MODE_11AX_HE160;
-		else if (sta->he_cap.he_cap_elem.phy_cap_info[0] &
+		else if (sta->link[0]->he_cap.he_cap_elem.phy_cap_info[0] &
 		     IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_80PLUS80_MHZ_IN_5G)
 			return MODE_11AX_HE80_80;
 		/* not sure if this is a valid case? */
 		return MODE_11AX_HE160;
 	}
 
-	if (sta->bandwidth == IEEE80211_STA_RX_BW_80)
+	if (sta->link[0]->bandwidth == IEEE80211_STA_RX_BW_80)
 		return MODE_11AX_HE80;
 
-	if (sta->bandwidth == IEEE80211_STA_RX_BW_40)
+	if (sta->link[0]->bandwidth == IEEE80211_STA_RX_BW_40)
 		return MODE_11AX_HE40;
 
-	if (sta->bandwidth == IEEE80211_STA_RX_BW_20)
+	if (sta->link[0]->bandwidth == IEEE80211_STA_RX_BW_20)
 		return MODE_11AX_HE20;
 
 	return MODE_UNKNOWN;
@@ -2566,23 +2566,23 @@ static void ath11k_peer_assoc_h_phymode(struct ath11k *ar,
 
 	switch (band) {
 	case NL80211_BAND_2GHZ:
-		if (sta->he_cap.has_he &&
+		if (sta->link[0]->he_cap.has_he &&
 		    !ath11k_peer_assoc_h_he_masked(he_mcs_mask)) {
-			if (sta->bandwidth == IEEE80211_STA_RX_BW_80)
+			if (sta->link[0]->bandwidth == IEEE80211_STA_RX_BW_80)
 				phymode = MODE_11AX_HE80_2G;
-			else if (sta->bandwidth == IEEE80211_STA_RX_BW_40)
+			else if (sta->link[0]->bandwidth == IEEE80211_STA_RX_BW_40)
 				phymode = MODE_11AX_HE40_2G;
 			else
 				phymode = MODE_11AX_HE20_2G;
-		} else if (sta->vht_cap.vht_supported &&
+		} else if (sta->link[0]->vht_cap.vht_supported &&
 		    !ath11k_peer_assoc_h_vht_masked(vht_mcs_mask)) {
-			if (sta->bandwidth == IEEE80211_STA_RX_BW_40)
+			if (sta->link[0]->bandwidth == IEEE80211_STA_RX_BW_40)
 				phymode = MODE_11AC_VHT40;
 			else
 				phymode = MODE_11AC_VHT20;
-		} else if (sta->ht_cap.ht_supported &&
+		} else if (sta->link[0]->ht_cap.ht_supported &&
 			   !ath11k_peer_assoc_h_ht_masked(ht_mcs_mask)) {
-			if (sta->bandwidth == IEEE80211_STA_RX_BW_40)
+			if (sta->link[0]->bandwidth == IEEE80211_STA_RX_BW_40)
 				phymode = MODE_11NG_HT40;
 			else
 				phymode = MODE_11NG_HT20;
@@ -2595,15 +2595,15 @@ static void ath11k_peer_assoc_h_phymode(struct ath11k *ar,
 	case NL80211_BAND_5GHZ:
 	case NL80211_BAND_6GHZ:
 		/* Check HE first */
-		if (sta->he_cap.has_he &&
+		if (sta->link[0]->he_cap.has_he &&
 		    !ath11k_peer_assoc_h_he_masked(he_mcs_mask)) {
 			phymode = ath11k_mac_get_phymode_he(ar, sta);
-		} else if (sta->vht_cap.vht_supported &&
+		} else if (sta->link[0]->vht_cap.vht_supported &&
 		    !ath11k_peer_assoc_h_vht_masked(vht_mcs_mask)) {
 			phymode = ath11k_mac_get_phymode_vht(ar, sta);
-		} else if (sta->ht_cap.ht_supported &&
+		} else if (sta->link[0]->ht_cap.ht_supported &&
 			   !ath11k_peer_assoc_h_ht_masked(ht_mcs_mask)) {
-			if (sta->bandwidth >= IEEE80211_STA_RX_BW_40)
+			if (sta->link[0]->bandwidth >= IEEE80211_STA_RX_BW_40)
 				phymode = MODE_11NA_HT40;
 			else
 				phymode = MODE_11NA_HT20;
@@ -2726,8 +2726,8 @@ static void ath11k_bss_assoc(struct ieee80211_hw *hw,
 	}
 
 	ret = ath11k_setup_peer_smps(ar, arvif, bss_conf->bssid,
-				     &ap_sta->ht_cap,
-				     le16_to_cpu(ap_sta->he_6ghz_capa.capa));
+				     &ap_sta->link[0]->ht_cap,
+				     le16_to_cpu(ap_sta->link[0]->he_6ghz_capa.capa));
 	if (ret) {
 		ath11k_warn(ar->ab, "failed to setup peer SMPS for vdev %d: %d\n",
 			    arvif->vdev_id, ret);
@@ -3983,7 +3983,7 @@ ath11k_mac_set_peer_vht_fixed_rate(struct ath11k_vif *arvif,
 	}
 
 	/* Avoid updating invalid nss as fixed rate*/
-	if (nss > sta->rx_nss)
+	if (nss > sta->link[0]->rx_nss)
 		return -EINVAL;
 
 	ath11k_dbg(ar->ab, ATH11K_DBG_MAC,
@@ -4033,7 +4033,7 @@ ath11k_mac_set_peer_he_fixed_rate(struct ath11k_vif *arvif,
 	}
 
 	/* Avoid updating invalid nss as fixed rate */
-	if (nss > sta->rx_nss)
+	if (nss > sta->link[0]->rx_nss)
 		return -EINVAL;
 
 	ath11k_dbg(ar->ab, ATH11K_DBG_MAC,
@@ -4100,12 +4100,12 @@ static int ath11k_station_assoc(struct ath11k *ar,
 	 * fixed param.
 	 * Note that all other rates and NSS will be disabled for this peer.
 	 */
-	if (sta->vht_cap.vht_supported && num_vht_rates == 1) {
+	if (sta->link[0]->vht_cap.vht_supported && num_vht_rates == 1) {
 		ret = ath11k_mac_set_peer_vht_fixed_rate(arvif, sta, mask,
 							 band);
 		if (ret)
 			return ret;
-	} else if (sta->he_cap.has_he && num_he_rates == 1) {
+	} else if (sta->link[0]->he_cap.has_he && num_he_rates == 1) {
 		ret = ath11k_mac_set_peer_he_fixed_rate(arvif, sta, mask,
 							band);
 		if (ret)
@@ -4119,7 +4119,7 @@ static int ath11k_station_assoc(struct ath11k *ar,
 		return 0;
 
 	ret = ath11k_setup_peer_smps(ar, arvif, sta->addr,
-				     &sta->ht_cap, le16_to_cpu(sta->he_6ghz_capa.capa));
+				     &sta->link[0]->ht_cap, le16_to_cpu(sta->link[0]->he_6ghz_capa.capa));
 	if (ret) {
 		ath11k_warn(ar->ab, "failed to setup peer SMPS for vdev %d: %d\n",
 			    arvif->vdev_id, ret);
@@ -4281,10 +4281,10 @@ static void ath11k_sta_rc_update_wk(struct work_struct *wk)
 		 * TODO: Check RATEMASK_CMDID to support auto rates selection
 		 * across HT/VHT and for multiple VHT MCS support.
 		 */
-		if (sta->vht_cap.vht_supported && num_vht_rates == 1) {
+		if (sta->link[0]->vht_cap.vht_supported && num_vht_rates == 1) {
 			ath11k_mac_set_peer_vht_fixed_rate(arvif, sta, mask,
 							   band);
-		} else if (sta->he_cap.has_he && num_he_rates == 1) {
+		} else if (sta->link[0]->he_cap.has_he && num_he_rates == 1) {
 			ath11k_mac_set_peer_he_fixed_rate(arvif, sta, mask,
 							  band);
 		} else {
@@ -4598,10 +4598,10 @@ static int ath11k_mac_op_sta_set_txpwr(struct ieee80211_hw *hw,
 	int ret = 0;
 	s16 txpwr;
 
-	if (sta->txpwr.type == NL80211_TX_POWER_AUTOMATIC) {
+	if (sta->link[0]->txpwr.type == NL80211_TX_POWER_AUTOMATIC) {
 		txpwr = 0;
 	} else {
-		txpwr = sta->txpwr.power;
+		txpwr = sta->link[0]->txpwr.power;
 		if (!txpwr)
 			return -EINVAL;
 	}
@@ -4662,7 +4662,7 @@ static void ath11k_mac_op_sta_rc_update(struct ieee80211_hw *hw,
 
 	ath11k_dbg(ar->ab, ATH11K_DBG_MAC,
 		   "mac sta rc update for %pM changed %08x bw %d nss %d smps %d\n",
-		   sta->addr, changed, sta->bandwidth, sta->rx_nss,
+		   sta->addr, changed, sta->link[0]->bandwidth, sta->link[0]->rx_nss,
 		   sta->smps_mode);
 
 	spin_lock_bh(&ar->data_lock);
@@ -4670,7 +4670,7 @@ static void ath11k_mac_op_sta_rc_update(struct ieee80211_hw *hw,
 	if (changed & IEEE80211_RC_BW_CHANGED) {
 		bw = WMI_PEER_CHWIDTH_20MHZ;
 
-		switch (sta->bandwidth) {
+		switch (sta->link[0]->bandwidth) {
 		case IEEE80211_STA_RX_BW_20:
 			bw = WMI_PEER_CHWIDTH_20MHZ;
 			break;
@@ -4685,7 +4685,7 @@ static void ath11k_mac_op_sta_rc_update(struct ieee80211_hw *hw,
 			break;
 		default:
 			ath11k_warn(ar->ab, "Invalid bandwidth %d in rc update for %pM\n",
-				    sta->bandwidth, sta->addr);
+				    sta->link[0]->bandwidth, sta->addr);
 			bw = WMI_PEER_CHWIDTH_20MHZ;
 			break;
 		}
@@ -4694,7 +4694,7 @@ static void ath11k_mac_op_sta_rc_update(struct ieee80211_hw *hw,
 	}
 
 	if (changed & IEEE80211_RC_NSS_CHANGED)
-		arsta->nss = sta->rx_nss;
+		arsta->nss = sta->link[0]->rx_nss;
 
 	if (changed & IEEE80211_RC_SMPS_CHANGED) {
 		smps = WMI_PEER_SMPS_PS_NONE;
@@ -7651,13 +7651,13 @@ ath11k_mac_validate_vht_he_fixed_rate_settings(struct ath11k *ar, enum nl80211_b
 	spin_lock_bh(&ar->ab->base_lock);
 	list_for_each_entry_safe(peer, tmp, &ar->ab->peers, list) {
 		if (peer->sta) {
-			if (vht_fixed_rate && (!peer->sta->vht_cap.vht_supported ||
-					       peer->sta->rx_nss < vht_nss)) {
+			if (vht_fixed_rate && (!peer->sta->link[0]->vht_cap.vht_supported ||
+					       peer->sta->link[0]->rx_nss < vht_nss)) {
 				ret = false;
 				goto out;
 			}
-			if (he_fixed_rate && (!peer->sta->he_cap.has_he ||
-					      peer->sta->rx_nss < he_nss)) {
+			if (he_fixed_rate && (!peer->sta->link[0]->he_cap.has_he ||
+					      peer->sta->link[0]->rx_nss < he_nss)) {
 				ret = false;
 				goto out;
 			}
diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index c50221d..0dbf755 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -2041,6 +2041,39 @@ struct ieee80211_sta_txpwr {
 	enum nl80211_tx_power_setting type;
 };
 
+#define MAX_STA_LINKS			16
+
+/**
+ * struct ieee80211_link_sta - station Link specific info
+ * All link specific info for a STA link for a non MLD STA(single)
+ * or a MLD STA(multiple entries) are stored here.
+ *
+ * @addr: MAC address
+ * @ht_cap: HT capabilities of this STA; restricted to our own capabilities
+ * @vht_cap: VHT capabilities of this STA; restricted to our own capabilities
+ * @he_cap: HE capabilities of this STA
+ * @he_6ghz_capa: on 6 GHz, holds the HE 6 GHz band capabilities
+ * @bandwidth: current bandwidth the station can receive with
+ * @rx_nss: in HT/VHT, the maximum number of spatial streams the
+ *	station can receive at the moment, changed by operating mode
+ *	notifications and capabilities. The value is only valid after
+ *	the station moves to associated state.
+ * @txpwr: the station tx power configuration
+ *
+ */
+struct ieee80211_link_sta {
+	u8 addr[ETH_ALEN];
+
+	struct ieee80211_sta_ht_cap ht_cap;
+	struct ieee80211_sta_vht_cap vht_cap;
+	struct ieee80211_sta_he_cap he_cap;
+	struct ieee80211_he_6ghz_capa he_6ghz_capa;
+
+	u8 rx_nss;
+	enum ieee80211_sta_rx_bandwidth bandwidth;
+	struct ieee80211_sta_txpwr txpwr;
+};
+
 /**
  * struct ieee80211_sta - station table entry
  *
@@ -2054,10 +2087,6 @@ struct ieee80211_sta_txpwr {
  * @addr: MAC address
  * @aid: AID we assigned to the station if we're an AP
  * @supp_rates: Bitmap of supported rates (per band)
- * @ht_cap: HT capabilities of this STA; restricted to our own capabilities
- * @vht_cap: VHT capabilities of this STA; restricted to our own capabilities
- * @he_cap: HE capabilities of this STA
- * @he_6ghz_capa: on 6 GHz, holds the HE 6 GHz band capabilities
  * @max_rx_aggregation_subframes: maximal amount of frames in a single AMPDU
  *	that this station is allowed to transmit to us.
  *	Can be modified by driver.
@@ -2069,11 +2098,6 @@ struct ieee80211_sta_txpwr {
  *	if wme is supported. The bits order is like in
  *	IEEE80211_WMM_IE_STA_QOSINFO_AC_*.
  * @max_sp: max Service Period. Only valid if wme is supported.
- * @bandwidth: current bandwidth the station can receive with
- * @rx_nss: in HT/VHT, the maximum number of spatial streams the
- *	station can receive at the moment, changed by operating mode
- *	notifications and capabilities. The value is only valid after
- *	the station moves to associated state.
  * @smps_mode: current SMPS mode (off, static or dynamic)
  * @rates: rate control selection table
  * @tdls: indicates whether the STA is a TDLS peer
@@ -2086,9 +2110,12 @@ struct ieee80211_sta_txpwr {
  * @support_p2p_ps: indicates whether the STA supports P2P PS mechanism or not.
  * @max_rc_amsdu_len: Maximum A-MSDU size in bytes recommended by rate control.
  * @max_tid_amsdu_len: Maximum A-MSDU size in bytes for this TID
- * @txpwr: the station tx power configuration
  * @txq: per-TID data TX queues (if driver uses the TXQ abstraction); note that
  *	the last entry (%IEEE80211_NUM_TIDS) is used for non-data frames
+ * @multi_link_sta: Identifies if this sta is a MLD STA
+ * @num_sta_links: Number of Link STA currently part of this MLD STA. For Legacy
+ *	STA this value is always 1.
+ * @link: reference to Link Sta entries
  */
 struct ieee80211_sta {
 	u32 supp_rates[NUM_NL80211_BANDS];
@@ -2134,6 +2161,10 @@ struct ieee80211_sta {
 
 	struct ieee80211_txq *txq[IEEE80211_NUM_TIDS + 1];
 
+	bool multi_link_sta;
+	u8 num_sta_links;
+	struct ieee80211_link_sta *link[MAX_STA_LINKS];
+
 	/* must be last */
 	u8 drv_priv[] __aligned(sizeof(void *));
 };
diff --git a/net/mac80211/agg-rx.c b/net/mac80211/agg-rx.c
index 7d2925b..a23771d 100644
--- a/net/mac80211/agg-rx.c
+++ b/net/mac80211/agg-rx.c
@@ -260,7 +260,7 @@ static void ieee80211_send_addba_resp(struct sta_info *sta, u8 *da, u16 tid,
 	mgmt->u.action.u.addba_resp.timeout = cpu_to_le16(timeout);
 	mgmt->u.action.u.addba_resp.status = cpu_to_le16(status);
 
-	if (sta->sta.he_cap.has_he && addbaext)
+	if (sta->sta.link[0]->he_cap.has_he && addbaext)
 		ieee80211_add_addbaext(sdata, skb, addbaext);
 
 	ieee80211_tx_skb(sdata, skb);
@@ -293,7 +293,7 @@ void ___ieee80211_start_rx_ba_session(struct sta_info *sta,
 		goto end;
 	}
 
-	if (!sta->sta.ht_cap.ht_supported &&
+	if (!sta->sta.link[0]->ht_cap.ht_supported &&
 	    sta->sdata->vif.bss_conf.chandef.chan->band != NL80211_BAND_6GHZ) {
 		ht_dbg(sta->sdata,
 		       "STA %pM erroneously requests BA session on tid %d w/o QoS\n",
@@ -309,7 +309,7 @@ void ___ieee80211_start_rx_ba_session(struct sta_info *sta,
 		goto end;
 	}
 
-	if (sta->sta.he_cap.has_he)
+	if (sta->sta.link[0]->he_cap.has_he)
 		max_buf_size = IEEE80211_MAX_AMPDU_BUF;
 	else
 		max_buf_size = IEEE80211_MAX_AMPDU_BUF_HT;
@@ -319,7 +319,7 @@ void ___ieee80211_start_rx_ba_session(struct sta_info *sta,
 	 * and if buffer size does not exceeds max value */
 	/* XXX: check own ht delayed BA capability?? */
 	if (((ba_policy != 1) &&
-	     (!(sta->sta.ht_cap.cap & IEEE80211_HT_CAP_DELAY_BA))) ||
+	     (!(sta->sta.link[0]->ht_cap.cap & IEEE80211_HT_CAP_DELAY_BA))) ||
 	    (buf_size > max_buf_size)) {
 		status = WLAN_STATUS_INVALID_QOS_PARAM;
 		ht_dbg_ratelimited(sta->sdata,
diff --git a/net/mac80211/agg-tx.c b/net/mac80211/agg-tx.c
index 74a878f..e838407 100644
--- a/net/mac80211/agg-tx.c
+++ b/net/mac80211/agg-tx.c
@@ -467,7 +467,7 @@ static void ieee80211_send_addba_with_timeout(struct sta_info *sta,
 	sta->ampdu_mlme.addba_req_num[tid]++;
 	spin_unlock_bh(&sta->lock);
 
-	if (sta->sta.he_cap.has_he) {
+	if (sta->sta.link[0]->he_cap.has_he) {
 		buf_size = local->hw.max_tx_aggregation_subframes;
 	} else {
 		/*
@@ -594,7 +594,7 @@ int ieee80211_start_tx_ba_session(struct ieee80211_sta *pubsta, u16 tid,
 		 "Requested to start BA session on reserved tid=%d", tid))
 		return -EINVAL;
 
-	if (!pubsta->ht_cap.ht_supported &&
+	if (!pubsta->link[0]->ht_cap.ht_supported &&
 	    sta->sdata->vif.bss_conf.chandef.chan->band != NL80211_BAND_6GHZ)
 		return -EINVAL;
 
@@ -639,7 +639,7 @@ int ieee80211_start_tx_ba_session(struct ieee80211_sta *pubsta, u16 tid,
 	 * is set when we receive a bss info from a probe response or a beacon.
 	 */
 	if (sta->sdata->vif.type == NL80211_IFTYPE_ADHOC &&
-	    !sta->sta.ht_cap.ht_supported) {
+	    !sta->sta.link[0]->ht_cap.ht_supported) {
 		ht_dbg(sdata,
 		       "BA request denied - IBSS STA %pM does not advertise HT support\n",
 		       pubsta->addr);
diff --git a/net/mac80211/airtime.c b/net/mac80211/airtime.c
index 26d2f8b..372d8f2 100644
--- a/net/mac80211/airtime.c
+++ b/net/mac80211/airtime.c
@@ -650,8 +650,8 @@ u32 ieee80211_calc_expected_tx_airtime(struct ieee80211_hw *hw,
 		struct sta_info *sta = container_of(pubsta, struct sta_info,
 						    sta);
 		struct ieee80211_rx_status stat;
-		struct ieee80211_tx_rate *rate = &sta->tx_stats.last_rate;
-		struct rate_info *ri = &sta->tx_stats.last_rate_info;
+		struct ieee80211_tx_rate *rate = &sta->link[0]->tx_stats.last_rate;
+		struct rate_info *ri = &sta->link[0]->tx_stats.last_rate_info;
 		u32 duration, overhead;
 		u8 agg_shift;
 
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 87a2080..3c881ad 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -570,7 +570,7 @@ static int ieee80211_del_key(struct wiphy *wiphy, struct net_device *dev,
 		if (pairwise)
 			key = key_mtx_dereference(local, sta->ptk[key_idx]);
 		else
-			key = key_mtx_dereference(local, sta->gtk[key_idx]);
+			key = key_mtx_dereference(local, sta->link[0]->gtk[key_idx]);
 	} else
 		key = key_mtx_dereference(local, sdata->keys[key_idx]);
 
@@ -620,7 +620,7 @@ static int ieee80211_get_key(struct wiphy *wiphy, struct net_device *dev,
 		else if (!pairwise &&
 			 key_idx < NUM_DEFAULT_KEYS + NUM_DEFAULT_MGMT_KEYS +
 			 NUM_DEFAULT_BEACON_KEYS)
-			key = rcu_dereference(sta->gtk[key_idx]);
+			key = rcu_dereference(sta->link[0]->gtk[key_idx]);
 	} else
 		key = rcu_dereference(sdata->keys[key_idx]);
 
@@ -1685,9 +1685,9 @@ static int sta_apply_parameters(struct ieee80211_local *local,
 		sta->listen_interval = params->listen_interval;
 
 	if (params->sta_modify_mask & STATION_PARAM_APPLY_STA_TXPOWER) {
-		sta->sta.txpwr.type = params->txpwr.type;
+		sta->sta.link[0]->txpwr.type = params->txpwr.type;
 		if (params->txpwr.type == NL80211_TX_POWER_LIMITED)
-			sta->sta.txpwr.power = params->txpwr.power;
+			sta->sta.link[0]->txpwr.power = params->txpwr.power;
 		ret = drv_sta_set_txpwr(local, sdata, sta);
 		if (ret)
 			return ret;
diff --git a/net/mac80211/chan.c b/net/mac80211/chan.c
index 76fc36a..b753b83 100644
--- a/net/mac80211/chan.c
+++ b/net/mac80211/chan.c
@@ -199,7 +199,7 @@ static enum nl80211_chan_width ieee80211_get_sta_bw(struct sta_info *sta)
 
 	switch (width) {
 	case IEEE80211_STA_RX_BW_20:
-		if (sta->sta.ht_cap.ht_supported)
+		if (sta->sta.link[0]->ht_cap.ht_supported)
 			return NL80211_CHAN_WIDTH_20;
 		else
 			return NL80211_CHAN_WIDTH_20_NOHT;
@@ -268,7 +268,7 @@ ieee80211_get_chanctx_max_required_bw(struct ieee80211_local *local,
 			break;
 		case NL80211_IFTYPE_STATION:
 			/*
-			 * The ap's sta->bandwidth is not set yet at this
+			 * The ap's sta->link[0]->bandwidth is not set yet at this
 			 * point, so take the width from the chandef, but
 			 * account also for TDLS peers
 			 */
@@ -373,15 +373,15 @@ static void ieee80211_chan_bw_change(struct ieee80211_local *local,
 		new_sta_bw = ieee80211_sta_cur_vht_bw(sta);
 
 		/* nothing change */
-		if (new_sta_bw == sta->sta.bandwidth)
+		if (new_sta_bw == sta->sta.link[0]->bandwidth)
 			continue;
 
 		/* vif changed to narrow BW and narrow BW for station wasn't
 		 * requested or vise versa */
-		if ((new_sta_bw < sta->sta.bandwidth) == !narrowed)
+		if ((new_sta_bw < sta->sta.link[0]->bandwidth) == !narrowed)
 			continue;
 
-		sta->sta.bandwidth = new_sta_bw;
+		sta->sta.link[0]->bandwidth = new_sta_bw;
 		rate_control_rate_update(local, sband, sta,
 					 IEEE80211_RC_BW_CHANGED);
 	}
diff --git a/net/mac80211/debugfs_sta.c b/net/mac80211/debugfs_sta.c
index 9479f27..4342050 100644
--- a/net/mac80211/debugfs_sta.c
+++ b/net/mac80211/debugfs_sta.c
@@ -447,7 +447,7 @@ static ssize_t sta_ht_capa_read(struct file *file, char __user *userbuf,
 	int i;
 	ssize_t bufsz = 512;
 	struct sta_info *sta = file->private_data;
-	struct ieee80211_sta_ht_cap *htc = &sta->sta.ht_cap;
+	struct ieee80211_sta_ht_cap *htc = &sta->sta.link[0]->ht_cap;
 	ssize_t ret;
 
 	buf = kzalloc(bufsz, GFP_KERNEL);
@@ -531,7 +531,7 @@ static ssize_t sta_vht_capa_read(struct file *file, char __user *userbuf,
 {
 	char *buf, *p;
 	struct sta_info *sta = file->private_data;
-	struct ieee80211_sta_vht_cap *vhtc = &sta->sta.vht_cap;
+	struct ieee80211_sta_vht_cap *vhtc = &sta->sta.link[0]->vht_cap;
 	ssize_t ret;
 	ssize_t bufsz = 512;
 
@@ -646,7 +646,7 @@ static ssize_t sta_he_capa_read(struct file *file, char __user *userbuf,
 	char *buf, *p;
 	size_t buf_sz = PAGE_SIZE;
 	struct sta_info *sta = file->private_data;
-	struct ieee80211_sta_he_cap *hec = &sta->sta.he_cap;
+	struct ieee80211_sta_he_cap *hec = &sta->sta.link[0]->he_cap;
 	struct ieee80211_he_mcs_nss_supp *nss = &hec->he_mcs_nss_supp;
 	u8 ppe_size;
 	u8 *cap;
@@ -1018,7 +1018,7 @@ STA_OPS(he_capa);
 		sta->debugfs_dir, sta, &sta_ ##name## _ops)
 
 #define DEBUGFS_ADD_COUNTER(name, field)				\
-	debugfs_create_ulong(#name, 0400, sta->debugfs_dir, &sta->field);
+	debugfs_create_ulong(#name, 0400, sta->debugfs_dir, &sta->link[0]->field);
 
 void ieee80211_sta_debugfs_add(struct sta_info *sta)
 {
diff --git a/net/mac80211/ethtool.c b/net/mac80211/ethtool.c
index b2253df..980385b 100644
--- a/net/mac80211/ethtool.c
+++ b/net/mac80211/ethtool.c
@@ -81,19 +81,19 @@ static void ieee80211_get_stats(struct net_device *dev,
 
 	memset(data, 0, sizeof(u64) * STA_STATS_LEN);
 
-#define ADD_STA_STATS(sta)					\
+#define ADD_STA_STATS(lsta)					\
 	do {							\
-		data[i++] += sta->rx_stats.packets;		\
-		data[i++] += sta->rx_stats.bytes;		\
-		data[i++] += sta->rx_stats.num_duplicates;	\
-		data[i++] += sta->rx_stats.fragments;		\
-		data[i++] += sta->rx_stats.dropped;		\
+		data[i++] += lsta->rx_stats.packets;		\
+		data[i++] += lsta->rx_stats.bytes;		\
+		data[i++] += lsta->rx_stats.num_duplicates;	\
+		data[i++] += lsta->rx_stats.fragments;		\
+		data[i++] += lsta->rx_stats.dropped;		\
 								\
 		data[i++] += sinfo.tx_packets;			\
 		data[i++] += sinfo.tx_bytes;			\
-		data[i++] += sta->status_stats.filtered;	\
-		data[i++] += sta->status_stats.retry_failed;	\
-		data[i++] += sta->status_stats.retry_count;	\
+		data[i++] += lsta->status_stats.filtered;	\
+		data[i++] += lsta->status_stats.retry_failed;	\
+		data[i++] += lsta->status_stats.retry_count;	\
 	} while (0)
 
 	/* For Managed stations, find the single station based on BSSID
@@ -114,7 +114,7 @@ static void ieee80211_get_stats(struct net_device *dev,
 		sta_set_sinfo(sta, &sinfo, false);
 
 		i = 0;
-		ADD_STA_STATS(sta);
+		ADD_STA_STATS(sta->link[0]);
 
 		data[i++] = sta->sta_state;
 
@@ -140,7 +140,7 @@ static void ieee80211_get_stats(struct net_device *dev,
 			memset(&sinfo, 0, sizeof(sinfo));
 			sta_set_sinfo(sta, &sinfo, false);
 			i = 0;
-			ADD_STA_STATS(sta);
+			ADD_STA_STATS(sta->link[0]);
 		}
 	}
 
diff --git a/net/mac80211/he.c b/net/mac80211/he.c
index c05af70..2dfc132 100644
--- a/net/mac80211/he.c
+++ b/net/mac80211/he.c
@@ -49,7 +49,7 @@ ieee80211_update_from_he_6ghz_capa(const struct ieee80211_he_6ghz_capa *he_6ghz_
 		break;
 	}
 
-	sta->sta.he_6ghz_capa = *he_6ghz_capa;
+	sta->sta.link[0]->he_6ghz_capa = *he_6ghz_capa;
 }
 
 static void ieee80211_he_mcs_disable(__le16 *he_mcs)
@@ -110,7 +110,7 @@ ieee80211_he_cap_ie_to_sta_he_cap(struct ieee80211_sub_if_data *sdata,
 				  const struct ieee80211_he_6ghz_capa *he_6ghz_capa,
 				  struct sta_info *sta)
 {
-	struct ieee80211_sta_he_cap *he_cap = &sta->sta.he_cap;
+	struct ieee80211_sta_he_cap *he_cap = &sta->sta.link[0]->he_cap;
 	struct ieee80211_sta_he_cap own_he_cap;
 	struct ieee80211_he_cap_elem *he_cap_ie_elem = (void *)he_cap_ie;
 	u8 he_ppe_size;
@@ -153,8 +153,8 @@ ieee80211_he_cap_ie_to_sta_he_cap(struct ieee80211_sub_if_data *sdata,
 
 	he_cap->has_he = true;
 
-	sta->cur_max_bandwidth = ieee80211_sta_cap_rx_bw(sta);
-	sta->sta.bandwidth = ieee80211_sta_cur_vht_bw(sta);
+	sta->link[0]->cur_max_bandwidth = ieee80211_sta_cap_rx_bw(sta);
+	sta->sta.link[0]->bandwidth = ieee80211_sta_cur_vht_bw(sta);
 
 	if (sband->band == NL80211_BAND_6GHZ && he_6ghz_capa)
 		ieee80211_update_from_he_6ghz_capa(he_6ghz_capa, sta);
diff --git a/net/mac80211/ht.c b/net/mac80211/ht.c
index 2eb7641..aa8333f 100644
--- a/net/mac80211/ht.c
+++ b/net/mac80211/ht.c
@@ -243,9 +243,9 @@ bool ieee80211_ht_cap_ie_to_sta_ht_cap(struct ieee80211_sub_if_data *sdata,
 		sta->sta.max_amsdu_len = IEEE80211_MAX_MPDU_LEN_HT_3839;
 
  apply:
-	changed = memcmp(&sta->sta.ht_cap, &ht_cap, sizeof(ht_cap));
+	changed = memcmp(&sta->sta.link[0]->ht_cap, &ht_cap, sizeof(ht_cap));
 
-	memcpy(&sta->sta.ht_cap, &ht_cap, sizeof(ht_cap));
+	memcpy(&sta->sta.link[0]->ht_cap, &ht_cap, sizeof(ht_cap));
 
 	switch (sdata->vif.bss_conf.chandef.width) {
 	default:
@@ -264,9 +264,9 @@ bool ieee80211_ht_cap_ie_to_sta_ht_cap(struct ieee80211_sub_if_data *sdata,
 		break;
 	}
 
-	sta->sta.bandwidth = bw;
+	sta->sta.link[0]->bandwidth = bw;
 
-	sta->cur_max_bandwidth =
+	sta->link[0]->cur_max_bandwidth =
 		ht_cap.cap & IEEE80211_HT_CAP_SUP_WIDTH_20_40 ?
 				IEEE80211_STA_RX_BW_40 : IEEE80211_STA_RX_BW_20;
 
diff --git a/net/mac80211/ibss.c b/net/mac80211/ibss.c
index 0416c4d..da6863d 100644
--- a/net/mac80211/ibss.c
+++ b/net/mac80211/ibss.c
@@ -1043,7 +1043,7 @@ static void ieee80211_update_sta_info(struct ieee80211_sub_if_data *sdata,
 		/* we both use HT */
 		struct ieee80211_ht_cap htcap_ie;
 		struct cfg80211_chan_def chandef;
-		enum ieee80211_sta_rx_bandwidth bw = sta->sta.bandwidth;
+		enum ieee80211_sta_rx_bandwidth bw = sta->sta.link[0]->bandwidth;
 
 		cfg80211_chandef_create(&chandef, channel, NL80211_CHAN_NO_HT);
 		ieee80211_chandef_ht_oper(elems->ht_operation, &chandef);
@@ -1058,7 +1058,7 @@ static void ieee80211_update_sta_info(struct ieee80211_sub_if_data *sdata,
 		    sdata->u.ibss.chandef.width != NL80211_CHAN_WIDTH_40) {
 			/* we both use VHT */
 			struct ieee80211_vht_cap cap_ie;
-			struct ieee80211_sta_vht_cap cap = sta->sta.vht_cap;
+			struct ieee80211_sta_vht_cap cap = sta->sta.link[0]->vht_cap;
 			u32 vht_cap_info =
 				le32_to_cpu(elems->vht_cap_elem->vht_cap_info);
 
@@ -1069,11 +1069,11 @@ static void ieee80211_update_sta_info(struct ieee80211_sub_if_data *sdata,
 			memcpy(&cap_ie, elems->vht_cap_elem, sizeof(cap_ie));
 			ieee80211_vht_cap_ie_to_sta_vht_cap(sdata, sband,
 							    &cap_ie, sta);
-			if (memcmp(&cap, &sta->sta.vht_cap, sizeof(cap)))
+			if (memcmp(&cap, &sta->sta.link[0]->vht_cap, sizeof(cap)))
 				rates_updated |= true;
 		}
 
-		if (bw != sta->sta.bandwidth)
+		if (bw != sta->sta.link[0]->bandwidth)
 			rates_updated |= true;
 
 		if (!cfg80211_chandef_compatible(&sdata->u.ibss.chandef,
@@ -1083,12 +1083,12 @@ static void ieee80211_update_sta_info(struct ieee80211_sub_if_data *sdata,
 
 	if (sta && rates_updated) {
 		u32 changed = IEEE80211_RC_SUPP_RATES_CHANGED;
-		u8 rx_nss = sta->sta.rx_nss;
+		u8 rx_nss = sta->sta.link[0]->rx_nss;
 
 		/* Force rx_nss recalculation */
-		sta->sta.rx_nss = 0;
+		sta->sta.link[0]->rx_nss = 0;
 		rate_control_rate_init(sta);
-		if (sta->sta.rx_nss != rx_nss)
+		if (sta->sta.link[0]->rx_nss != rx_nss)
 			changed |= IEEE80211_RC_NSS_CHANGED;
 
 		drv_sta_rc_update(local, sdata, &sta->sta, changed);
diff --git a/net/mac80211/key.c b/net/mac80211/key.c
index f695fc8..10be42cfa 100644
--- a/net/mac80211/key.c
+++ b/net/mac80211/key.c
@@ -476,7 +476,7 @@ static int ieee80211_key_replace(struct ieee80211_sub_if_data *sdata,
 			    !(new->conf.flags & IEEE80211_KEY_FLAG_NO_AUTO_TX))
 				_ieee80211_set_tx_key(new, true);
 		} else {
-			rcu_assign_pointer(sta->gtk[idx], new);
+			rcu_assign_pointer(sta->link[0]->gtk[idx], new);
 		}
 		/* Only needed for transition from no key -> key.
 		 * Still triggers unnecessary when using Extended Key ID
@@ -826,7 +826,7 @@ int ieee80211_key_link(struct ieee80211_key *key,
 		    (old_key && old_key->conf.cipher != key->conf.cipher))
 			goto out;
 	} else if (sta) {
-		old_key = key_mtx_dereference(sdata->local, sta->gtk[idx]);
+		old_key = key_mtx_dereference(sdata->local, sta->link[0]->gtk[idx]);
 	} else {
 		old_key = key_mtx_dereference(sdata->local, sdata->keys[idx]);
 	}
@@ -1076,8 +1076,8 @@ void ieee80211_free_sta_keys(struct ieee80211_local *local,
 	int i;
 
 	mutex_lock(&local->key_mtx);
-	for (i = 0; i < ARRAY_SIZE(sta->gtk); i++) {
-		key = key_mtx_dereference(local, sta->gtk[i]);
+	for (i = 0; i < ARRAY_SIZE(sta->link[0]->gtk); i++) {
+		key = key_mtx_dereference(local, sta->link[0]->gtk[i]);
 		if (!key)
 			continue;
 		ieee80211_key_replace(key->sdata, key->sta,
diff --git a/net/mac80211/mesh_hwmp.c b/net/mac80211/mesh_hwmp.c
index 44a6fdb..bf6fb62 100644
--- a/net/mac80211/mesh_hwmp.c
+++ b/net/mac80211/mesh_hwmp.c
@@ -310,7 +310,7 @@ void ieee80211s_update_metric(struct ieee80211_local *local,
 			LINK_FAIL_THRESH)
 		mesh_plink_broken(sta);
 
-	sta_set_rate_info_tx(sta, &sta->tx_stats.last_rate, &rinfo);
+	sta_set_rate_info_tx(sta, &sta->link[0]->tx_stats.last_rate, &rinfo);
 	ewma_mesh_tx_rate_avg_add(&sta->mesh->tx_rate_avg,
 				  cfg80211_calculate_bitrate(&rinfo));
 }
diff --git a/net/mac80211/mesh_plink.c b/net/mac80211/mesh_plink.c
index a829470..5432c99 100644
--- a/net/mac80211/mesh_plink.c
+++ b/net/mac80211/mesh_plink.c
@@ -61,7 +61,7 @@ static bool rssi_threshold_check(struct ieee80211_sub_if_data *sdata,
 	s32 rssi_threshold = sdata->u.mesh.mshcfg.rssi_threshold;
 	return rssi_threshold == 0 ||
 	       (sta &&
-		(s8)-ewma_signal_read(&sta->rx_stats_avg.signal) >
+		(s8)-ewma_signal_read(&sta->link[0]->rx_stats_avg.signal) >
 						rssi_threshold);
 }
 
@@ -175,10 +175,10 @@ static u32 mesh_set_ht_prot_mode(struct ieee80211_sub_if_data *sdata)
 		    sta->mesh->plink_state != NL80211_PLINK_ESTAB)
 			continue;
 
-		if (sta->sta.bandwidth > IEEE80211_STA_RX_BW_20)
+		if (sta->sta.link[0]->bandwidth > IEEE80211_STA_RX_BW_20)
 			continue;
 
-		if (!sta->sta.ht_cap.ht_supported) {
+		if (!sta->sta.link[0]->ht_cap.ht_supported) {
 			mpl_dbg(sdata, "nonHT sta (%pM) is present\n",
 				       sta->sta.addr);
 			non_ht_sta = true;
@@ -415,7 +415,7 @@ static void mesh_sta_info_init(struct ieee80211_sub_if_data *sdata,
 	struct ieee80211_local *local = sdata->local;
 	struct ieee80211_supported_band *sband;
 	u32 rates, basic_rates = 0, changed = 0;
-	enum ieee80211_sta_rx_bandwidth bw = sta->sta.bandwidth;
+	enum ieee80211_sta_rx_bandwidth bw = sta->sta.link[0]->bandwidth;
 
 	sband = ieee80211_get_sband(sdata);
 	if (!sband)
@@ -425,7 +425,7 @@ static void mesh_sta_info_init(struct ieee80211_sub_if_data *sdata,
 					&basic_rates);
 
 	spin_lock_bh(&sta->mesh->plink_lock);
-	sta->rx_stats.last_rx = jiffies;
+	sta->link[0]->rx_stats.last_rx = jiffies;
 
 	/* rates and capabilities don't change during peering */
 	if (sta->mesh->plink_state == NL80211_PLINK_ESTAB &&
@@ -449,16 +449,16 @@ static void mesh_sta_info_init(struct ieee80211_sub_if_data *sdata,
 					  elems->he_6ghz_capa,
 					  sta);
 
-	if (bw != sta->sta.bandwidth)
+	if (bw != sta->sta.link[0]->bandwidth)
 		changed |= IEEE80211_RC_BW_CHANGED;
 
 	/* HT peer is operating 20MHz-only */
 	if (elems->ht_operation &&
 	    !(elems->ht_operation->ht_param &
 	      IEEE80211_HT_PARAM_CHAN_WIDTH_ANY)) {
-		if (sta->sta.bandwidth != IEEE80211_STA_RX_BW_20)
+		if (sta->sta.link[0]->bandwidth != IEEE80211_STA_RX_BW_20)
 			changed |= IEEE80211_RC_BW_CHANGED;
-		sta->sta.bandwidth = IEEE80211_STA_RX_BW_20;
+		sta->sta.link[0]->bandwidth = IEEE80211_STA_RX_BW_20;
 	}
 
 	if (!test_sta_flag(sta, WLAN_STA_RATE_CONTROL))
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 1eeabdf..13c0c24 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -3251,7 +3251,7 @@ static bool ieee80211_twt_req_supported(const struct sta_info *sta,
 	if (!(elems->ext_capab[9] & WLAN_EXT_CAPA10_TWT_RESPONDER_SUPPORT))
 		return false;
 
-	return sta->sta.he_cap.he_cap_elem.mac_cap_info[0] &
+	return sta->sta.link[0]->he_cap.he_cap_elem.mac_cap_info[0] &
 		IEEE80211_HE_MAC_CAP0_TWT_RES;
 }
 
@@ -3278,7 +3278,7 @@ static bool ieee80211_twt_bcast_support(struct ieee80211_sub_if_data *sdata,
 					    ieee80211_vif_type_p2p(&sdata->vif));
 
 	return bss_conf->he_support &&
-		(sta->sta.he_cap.he_cap_elem.mac_cap_info[2] &
+		(sta->sta.link[0]->he_cap.he_cap_elem.mac_cap_info[2] &
 			IEEE80211_HE_MAC_CAP2_BCAST_TWT) &&
 		own_he_cap &&
 		(own_he_cap->he_cap_elem.mac_cap_info[2] &
@@ -3496,7 +3496,7 @@ static bool ieee80211_assoc_success(struct ieee80211_sub_if_data *sdata,
 						  elems->he_6ghz_capa,
 						  sta);
 
-		bss_conf->he_support = sta->sta.he_cap.has_he;
+		bss_conf->he_support = sta->sta.link[0]->he_cap.has_he;
 		if (elems->rsnx && elems->rsnx_len &&
 		    (elems->rsnx[0] & WLAN_RSNX_CAPA_PROTECTED_TWT) &&
 		    wiphy_ext_feature_isset(local->hw.wiphy,
@@ -3572,7 +3572,7 @@ static bool ieee80211_assoc_success(struct ieee80211_sub_if_data *sdata,
 		nss = *elems->opmode_notif & IEEE80211_OPMODE_NOTIF_RX_NSS_MASK;
 		nss >>= IEEE80211_OPMODE_NOTIF_RX_NSS_SHIFT;
 		nss += 1;
-		sta->sta.rx_nss = nss;
+		sta->sta.link[0]->rx_nss = nss;
 	}
 
 	rate_control_rate_init(sta);
@@ -4726,9 +4726,9 @@ static void ieee80211_sta_conn_mon_timer(struct timer_list *t)
 	if (!sta)
 		return;
 
-	timeout = sta->status_stats.last_ack;
-	if (time_before(sta->status_stats.last_ack, sta->rx_stats.last_rx))
-		timeout = sta->rx_stats.last_rx;
+	timeout = sta->link[0]->status_stats.last_ack;
+	if (time_before(sta->link[0]->status_stats.last_ack, sta->link[0]->rx_stats.last_rx))
+		timeout = sta->link[0]->rx_stats.last_rx;
 	timeout += IEEE80211_CONNECTION_IDLE_TIME;
 
 	/* If timeout is after now, then update timer to fire at
diff --git a/net/mac80211/rate.c b/net/mac80211/rate.c
index 8c64161..f65e094 100644
--- a/net/mac80211/rate.c
+++ b/net/mac80211/rate.c
@@ -783,9 +783,9 @@ static bool rate_control_cap_mask(struct ieee80211_sub_if_data *sdata,
 		/* Filter out rates that the STA does not support */
 		*mask &= sta->supp_rates[sband->band];
 		for (i = 0; i < IEEE80211_HT_MCS_MASK_LEN; i++)
-			mcs_mask[i] &= sta->ht_cap.mcs.rx_mask[i];
+			mcs_mask[i] &= sta->link[0]->ht_cap.mcs.rx_mask[i];
 
-		sta_vht_cap = sta->vht_cap.vht_mcs.rx_mcs_map;
+		sta_vht_cap = sta->link[0]->vht_cap.vht_mcs.rx_mcs_map;
 		ieee80211_get_vht_mask_from_cap(sta_vht_cap, sta_vht_mask);
 		for (i = 0; i < NL80211_VHT_NSS_MAX; i++)
 			vht_mask[i] &= sta_vht_mask[i];
diff --git a/net/mac80211/rc80211_minstrel_ht.c b/net/mac80211/rc80211_minstrel_ht.c
index 9c3b7fc..96875b5 100644
--- a/net/mac80211/rc80211_minstrel_ht.c
+++ b/net/mac80211/rc80211_minstrel_ht.c
@@ -603,7 +603,7 @@ minstrel_ht_prob_rate_reduce_streams(struct minstrel_ht_sta *mi)
 	int tmp_max_streams, group, tmp_idx, tmp_prob;
 	int tmp_tp = 0;
 
-	if (!mi->sta->ht_cap.ht_supported)
+	if (!mi->sta->link[0]->ht_cap.ht_supported)
 		return;
 
 	group = MI_RATE_GROUP(mi->max_tp_rate[0]);
@@ -993,7 +993,7 @@ minstrel_ht_update_stats(struct minstrel_priv *mp, struct minstrel_ht_sta *mi)
 	u16 tmp_mcs_tp_rate[MAX_THR_RATES], tmp_group_tp_rate[MAX_THR_RATES];
 	u16 tmp_legacy_tp_rate[MAX_THR_RATES], tmp_max_prob_rate;
 	u16 index;
-	bool ht_supported = mi->sta->ht_cap.ht_supported;
+	bool ht_supported = mi->sta->link[0]->ht_cap.ht_supported;
 
 	if (mi->ampdu_packets > 0) {
 		if (!ieee80211_hw_check(mp->hw, TX_STATUS_NO_AMPDU_LEN))
@@ -1416,7 +1416,7 @@ minstrel_ht_get_max_amsdu_len(struct minstrel_ht_sta *mi)
 	 * the limit here to avoid the complexity of having to de-aggregate
 	 * packets in the queue.
 	 */
-	if (!mi->sta->vht_cap.vht_supported)
+	if (!mi->sta->link[0]->vht_cap.vht_supported)
 		return IEEE80211_MAX_MPDU_LEN_HT_BA;
 
 	/* unlimited */
@@ -1533,7 +1533,7 @@ minstrel_ht_update_cck(struct minstrel_priv *mp, struct minstrel_ht_sta *mi,
 	if (sband->band != NL80211_BAND_2GHZ)
 		return;
 
-	if (sta->ht_cap.ht_supported &&
+	if (sta->link[0]->ht_cap.ht_supported &&
 	    !ieee80211_hw_check(mp->hw, SUPPORTS_HT_CCK_RATES))
 		return;
 
@@ -1556,7 +1556,7 @@ minstrel_ht_update_ofdm(struct minstrel_priv *mp, struct minstrel_ht_sta *mi,
 	const u8 *rates;
 	int i;
 
-	if (sta->ht_cap.ht_supported)
+	if (sta->link[0]->ht_cap.ht_supported)
 		return;
 
 	rates = mp->ofdm_rates[sband->band];
@@ -1576,9 +1576,9 @@ minstrel_ht_update_caps(void *priv, struct ieee80211_supported_band *sband,
 {
 	struct minstrel_priv *mp = priv;
 	struct minstrel_ht_sta *mi = priv_sta;
-	struct ieee80211_mcs_info *mcs = &sta->ht_cap.mcs;
-	u16 ht_cap = sta->ht_cap.cap;
-	struct ieee80211_sta_vht_cap *vht_cap = &sta->vht_cap;
+	struct ieee80211_mcs_info *mcs = &sta->link[0]->ht_cap.mcs;
+	u16 ht_cap = sta->link[0]->ht_cap.cap;
+	struct ieee80211_sta_vht_cap *vht_cap = &sta->link[0]->vht_cap;
 	const struct ieee80211_rate *ctl_rate;
 	bool ldpc, erp;
 	int use_vht;
@@ -1650,7 +1650,7 @@ minstrel_ht_update_caps(void *priv, struct ieee80211_supported_band *sband,
 		}
 
 		if (gflags & IEEE80211_TX_RC_40_MHZ_WIDTH &&
-		    sta->bandwidth < IEEE80211_STA_RX_BW_40)
+		    sta->link[0]->bandwidth < IEEE80211_STA_RX_BW_40)
 			continue;
 
 		nss = minstrel_mcs_groups[i].streams;
@@ -1677,7 +1677,7 @@ minstrel_ht_update_caps(void *priv, struct ieee80211_supported_band *sband,
 			continue;
 
 		if (gflags & IEEE80211_TX_RC_80_MHZ_WIDTH) {
-			if (sta->bandwidth < IEEE80211_STA_RX_BW_80 ||
+			if (sta->link[0]->bandwidth < IEEE80211_STA_RX_BW_80 ||
 			    ((gflags & IEEE80211_TX_RC_SHORT_GI) &&
 			     !(vht_cap->cap & IEEE80211_VHT_CAP_SHORT_GI_80))) {
 				continue;
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 93680af..fbf6fb2 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -221,7 +221,7 @@ static void __ieee80211_queue_skb_to_iface(struct ieee80211_sub_if_data *sdata,
 	skb_queue_tail(&sdata->skb_queue, skb);
 	ieee80211_queue_work(&sdata->local->hw, &sdata->work);
 	if (sta)
-		sta->rx_stats.packets++;
+		sta->link[0]->rx_stats.packets++;
 }
 
 static void ieee80211_queue_skb_to_iface(struct ieee80211_sub_if_data *sdata,
@@ -1465,7 +1465,7 @@ ieee80211_rx_h_check_dup(struct ieee80211_rx_data *rx)
 	if (unlikely(ieee80211_has_retry(hdr->frame_control) &&
 		     rx->sta->last_seq_ctrl[rx->seqno_idx] == hdr->seq_ctrl)) {
 		I802_DEBUG_INC(rx->local->dot11FrameDuplicateCount);
-		rx->sta->rx_stats.num_duplicates++;
+		rx->sta->link[0]->rx_stats.num_duplicates++;
 		return RX_DROP_UNUSABLE;
 	} else if (!(status->flag & RX_FLAG_AMSDU_MORE)) {
 		rx->sta->last_seq_ctrl[rx->seqno_idx] = hdr->seq_ctrl;
@@ -1761,46 +1761,46 @@ ieee80211_rx_h_sta_process(struct ieee80211_rx_data *rx)
 						NL80211_IFTYPE_ADHOC);
 		if (ether_addr_equal(bssid, rx->sdata->u.ibss.bssid) &&
 		    test_sta_flag(sta, WLAN_STA_AUTHORIZED)) {
-			sta->rx_stats.last_rx = jiffies;
+			sta->link[0]->rx_stats.last_rx = jiffies;
 			if (ieee80211_is_data(hdr->frame_control) &&
 			    !is_multicast_ether_addr(hdr->addr1))
-				sta->rx_stats.last_rate =
+				sta->link[0]->rx_stats.last_rate =
 					sta_stats_encode_rate(status);
 		}
 	} else if (rx->sdata->vif.type == NL80211_IFTYPE_OCB) {
-		sta->rx_stats.last_rx = jiffies;
+		sta->link[0]->rx_stats.last_rx = jiffies;
 	} else if (!ieee80211_is_s1g_beacon(hdr->frame_control) &&
 		   !is_multicast_ether_addr(hdr->addr1)) {
 		/*
 		 * Mesh beacons will update last_rx when if they are found to
 		 * match the current local configuration when processed.
 		 */
-		sta->rx_stats.last_rx = jiffies;
+		sta->link[0]->rx_stats.last_rx = jiffies;
 		if (ieee80211_is_data(hdr->frame_control))
-			sta->rx_stats.last_rate = sta_stats_encode_rate(status);
+			sta->link[0]->rx_stats.last_rate = sta_stats_encode_rate(status);
 	}
 
-	sta->rx_stats.fragments++;
+	sta->link[0]->rx_stats.fragments++;
 
-	u64_stats_update_begin(&rx->sta->rx_stats.syncp);
-	sta->rx_stats.bytes += rx->skb->len;
-	u64_stats_update_end(&rx->sta->rx_stats.syncp);
+	u64_stats_update_begin(&rx->sta->link[0]->rx_stats.syncp);
+	sta->link[0]->rx_stats.bytes += rx->skb->len;
+	u64_stats_update_end(&rx->sta->link[0]->rx_stats.syncp);
 
 	if (!(status->flag & RX_FLAG_NO_SIGNAL_VAL)) {
-		sta->rx_stats.last_signal = status->signal;
-		ewma_signal_add(&sta->rx_stats_avg.signal, -status->signal);
+		sta->link[0]->rx_stats.last_signal = status->signal;
+		ewma_signal_add(&sta->link[0]->rx_stats_avg.signal, -status->signal);
 	}
 
 	if (status->chains) {
-		sta->rx_stats.chains = status->chains;
+		sta->link[0]->rx_stats.chains = status->chains;
 		for (i = 0; i < ARRAY_SIZE(status->chain_signal); i++) {
 			int signal = status->chain_signal[i];
 
 			if (!(status->chains & BIT(i)))
 				continue;
 
-			sta->rx_stats.chain_signal_last[i] = signal;
-			ewma_signal_add(&sta->rx_stats_avg.chain_signal[i],
+			sta->link[0]->rx_stats.chain_signal_last[i] = signal;
+			ewma_signal_add(&sta->link[0]->rx_stats_avg.chain_signal[i],
 					-signal);
 		}
 	}
@@ -1861,7 +1861,7 @@ ieee80211_rx_h_sta_process(struct ieee80211_rx_data *rx)
 		 * Update counter and free packet here to avoid
 		 * counting this as a dropped packed.
 		 */
-		sta->rx_stats.packets++;
+		sta->link[0]->rx_stats.packets++;
 		dev_kfree_skb(rx->skb);
 		return RX_QUEUED;
 	}
@@ -1893,11 +1893,11 @@ ieee80211_rx_get_bigtk(struct ieee80211_rx_data *rx, int idx)
 	}
 
 	if (rx->sta)
-		key = rcu_dereference(rx->sta->gtk[idx]);
+		key = rcu_dereference(rx->sta->link[0]->gtk[idx]);
 	if (!key)
 		key = rcu_dereference(sdata->keys[idx]);
 	if (!key && rx->sta)
-		key = rcu_dereference(rx->sta->gtk[idx2]);
+		key = rcu_dereference(rx->sta->link[0]->gtk[idx2]);
 	if (!key)
 		key = rcu_dereference(sdata->keys[idx2]);
 
@@ -2012,7 +2012,7 @@ ieee80211_rx_h_decrypt(struct ieee80211_rx_data *rx)
 			    test_sta_flag(rx->sta, WLAN_STA_MFP))
 				return RX_DROP_MONITOR;
 
-			rx->key = rcu_dereference(rx->sta->gtk[mmie_keyidx]);
+			rx->key = rcu_dereference(rx->sta->link[0]->gtk[mmie_keyidx]);
 		}
 		if (!rx->key)
 			rx->key = rcu_dereference(rx->sdata->keys[mmie_keyidx]);
@@ -2035,7 +2035,7 @@ ieee80211_rx_h_decrypt(struct ieee80211_rx_data *rx)
 		} else {
 			if (rx->sta) {
 				for (i = 0; i < NUM_DEFAULT_KEYS; i++) {
-					key = rcu_dereference(rx->sta->gtk[i]);
+					key = rcu_dereference(rx->sta->link[0]->gtk[i]);
 					if (key)
 						break;
 				}
@@ -2072,7 +2072,7 @@ ieee80211_rx_h_decrypt(struct ieee80211_rx_data *rx)
 
 		/* check per-station GTK first, if multicast packet */
 		if (is_multicast_ether_addr(hdr->addr1) && rx->sta)
-			rx->key = rcu_dereference(rx->sta->gtk[keyidx]);
+			rx->key = rcu_dereference(rx->sta->link[0]->gtk[keyidx]);
 
 		/* if not found, try default key */
 		if (!rx->key) {
@@ -2398,7 +2398,7 @@ ieee80211_rx_h_defragment(struct ieee80211_rx_data *rx)
  out:
 	ieee80211_led_rx(rx->local);
 	if (rx->sta)
-		rx->sta->rx_stats.packets++;
+		rx->sta->link[0]->rx_stats.packets++;
 	return RX_CONTINUE;
 }
 
@@ -2644,9 +2644,9 @@ ieee80211_deliver_skb(struct ieee80211_rx_data *rx)
 		 * for non-QoS-data frames. Here we know it's a data
 		 * frame, so count MSDUs.
 		 */
-		u64_stats_update_begin(&rx->sta->rx_stats.syncp);
-		rx->sta->rx_stats.msdu[rx->seqno_idx]++;
-		u64_stats_update_end(&rx->sta->rx_stats.syncp);
+		u64_stats_update_begin(&rx->sta->link[0]->rx_stats.syncp);
+		rx->sta->link[0]->rx_stats.msdu[rx->seqno_idx]++;
+		u64_stats_update_end(&rx->sta->link[0]->rx_stats.syncp);
 	}
 
 	if ((sdata->vif.type == NL80211_IFTYPE_AP ||
@@ -3295,7 +3295,7 @@ ieee80211_rx_h_action(struct ieee80211_rx_data *rx)
 	switch (mgmt->u.action.category) {
 	case WLAN_CATEGORY_HT:
 		/* reject HT action frames from stations not supporting HT */
-		if (!rx->sta->sta.ht_cap.ht_supported)
+		if (!rx->sta->sta.link[0]->ht_cap.ht_supported)
 			goto invalid;
 
 		if (sdata->vif.type != NL80211_IFTYPE_STATION &&
@@ -3359,7 +3359,7 @@ ieee80211_rx_h_action(struct ieee80211_rx_data *rx)
 			struct sta_opmode_info sta_opmode = {};
 
 			/* If it doesn't support 40 MHz it can't change ... */
-			if (!(rx->sta->sta.ht_cap.cap &
+			if (!(rx->sta->sta.link[0]->ht_cap.cap &
 					IEEE80211_HT_CAP_SUP_WIDTH_20_40))
 				goto handled;
 
@@ -3369,13 +3369,13 @@ ieee80211_rx_h_action(struct ieee80211_rx_data *rx)
 				max_bw = ieee80211_sta_cap_rx_bw(rx->sta);
 
 			/* set cur_max_bandwidth and recalc sta bw */
-			rx->sta->cur_max_bandwidth = max_bw;
+			rx->sta->link[0]->cur_max_bandwidth = max_bw;
 			new_bw = ieee80211_sta_cur_vht_bw(rx->sta);
 
-			if (rx->sta->sta.bandwidth == new_bw)
+			if (rx->sta->sta.link[0]->bandwidth == new_bw)
 				goto handled;
 
-			rx->sta->sta.bandwidth = new_bw;
+			rx->sta->sta.link[0]->bandwidth = new_bw;
 			sband = rx->local->hw.wiphy->bands[status->band];
 			sta_opmode.bw =
 				ieee80211_sta_rx_bw_to_chan_width(rx->sta);
@@ -3572,7 +3572,7 @@ ieee80211_rx_h_action(struct ieee80211_rx_data *rx)
 
  handled:
 	if (rx->sta)
-		rx->sta->rx_stats.packets++;
+		rx->sta->link[0]->rx_stats.packets++;
 	dev_kfree_skb(rx->skb);
 	return RX_QUEUED;
 
@@ -3606,7 +3606,7 @@ ieee80211_rx_h_userspace_mgmt(struct ieee80211_rx_data *rx)
 				 ieee80211_rx_status_to_khz(status), sig,
 				 rx->skb->data, rx->skb->len, 0)) {
 		if (rx->sta)
-			rx->sta->rx_stats.packets++;
+			rx->sta->link[0]->rx_stats.packets++;
 		dev_kfree_skb(rx->skb);
 		return RX_QUEUED;
 	}
@@ -3644,7 +3644,7 @@ ieee80211_rx_h_action_post_userspace(struct ieee80211_rx_data *rx)
 
  handled:
 	if (rx->sta)
-		rx->sta->rx_stats.packets++;
+		rx->sta->link[0]->rx_stats.packets++;
 	dev_kfree_skb(rx->skb);
 	return RX_QUEUED;
 }
@@ -3864,7 +3864,7 @@ static void ieee80211_rx_handlers_result(struct ieee80211_rx_data *rx,
 	case RX_DROP_MONITOR:
 		I802_DEBUG_INC(rx->sdata->local->rx_handlers_drop);
 		if (rx->sta)
-			rx->sta->rx_stats.dropped++;
+			rx->sta->link[0]->rx_stats.dropped++;
 		fallthrough;
 	case RX_CONTINUE: {
 		struct ieee80211_rate *rate = NULL;
@@ -3883,7 +3883,7 @@ static void ieee80211_rx_handlers_result(struct ieee80211_rx_data *rx,
 	case RX_DROP_UNUSABLE:
 		I802_DEBUG_INC(rx->sdata->local->rx_handlers_drop);
 		if (rx->sta)
-			rx->sta->rx_stats.dropped++;
+			rx->sta->link[0]->rx_stats.dropped++;
 		dev_kfree_skb(rx->skb);
 		break;
 	case RX_QUEUED:
@@ -4435,15 +4435,15 @@ static void ieee80211_rx_8023(struct ieee80211_rx_data *rx,
 	void *sa = skb->data + ETH_ALEN;
 	void *da = skb->data;
 
-	stats = &sta->rx_stats;
+	stats = &sta->link[0]->rx_stats;
 	if (fast_rx->uses_rss)
-		stats = this_cpu_ptr(sta->pcpu_rx_stats);
+		stats = this_cpu_ptr(sta->link[0]->pcpu_rx_stats);
 
 	/* statistics part of ieee80211_rx_h_sta_process() */
 	if (!(status->flag & RX_FLAG_NO_SIGNAL_VAL)) {
 		stats->last_signal = status->signal;
 		if (!fast_rx->uses_rss)
-			ewma_signal_add(&sta->rx_stats_avg.signal,
+			ewma_signal_add(&sta->link[0]->rx_stats_avg.signal,
 					-status->signal);
 	}
 
@@ -4459,7 +4459,7 @@ static void ieee80211_rx_8023(struct ieee80211_rx_data *rx,
 
 			stats->chain_signal_last[i] = signal;
 			if (!fast_rx->uses_rss)
-				ewma_signal_add(&sta->rx_stats_avg.chain_signal[i],
+				ewma_signal_add(&sta->link[0]->rx_stats_avg.chain_signal[i],
 						-signal);
 		}
 	}
@@ -4540,7 +4540,7 @@ static bool ieee80211_invoke_fast_rx(struct ieee80211_rx_data *rx,
 		u8 da[ETH_ALEN];
 		u8 sa[ETH_ALEN];
 	} addrs __aligned(2);
-	struct ieee80211_sta_rx_stats *stats = &sta->rx_stats;
+	struct ieee80211_sta_rx_stats *stats = &sta->link[0]->rx_stats;
 
 	/* for parallel-rx, we need to have DUP_VALIDATED, otherwise we write
 	 * to a common data structure; drivers can implement that per queue
@@ -4640,7 +4640,7 @@ static bool ieee80211_invoke_fast_rx(struct ieee80211_rx_data *rx,
  drop:
 	dev_kfree_skb(skb);
 	if (fast_rx->uses_rss)
-		stats = this_cpu_ptr(sta->pcpu_rx_stats);
+		stats = this_cpu_ptr(sta->link[0]->pcpu_rx_stats);
 
 	stats->dropped++;
 	return true;
diff --git a/net/mac80211/s1g.c b/net/mac80211/s1g.c
index 4141bc8..ea7a050 100644
--- a/net/mac80211/s1g.c
+++ b/net/mac80211/s1g.c
@@ -11,8 +11,8 @@
 void ieee80211_s1g_sta_rate_init(struct sta_info *sta)
 {
 	/* avoid indicating legacy bitrates for S1G STAs */
-	sta->tx_stats.last_rate.flags |= IEEE80211_TX_RC_S1G_MCS;
-	sta->rx_stats.last_rate =
+	sta->link[0]->tx_stats.last_rate.flags |= IEEE80211_TX_RC_S1G_MCS;
+	sta->link[0]->rx_stats.last_rate =
 			STA_STATS_FIELD(TYPE, STA_STATS_RATE_TYPE_S1G);
 }
 
diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index 537535a..7652ae8 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -245,6 +245,17 @@ struct sta_info *sta_info_get_by_idx(struct ieee80211_sub_if_data *sdata,
 	return NULL;
 }
 
+static void sta_links_free(struct sta_info *sta)
+{
+	int i;
+
+	for (i = 0; i < sta->num_sta_links; i++) {
+		free_percpu(sta->link[i]->pcpu_rx_stats);
+		kfree(sta->link[i]);
+		kfree(sta->sta.link[i]);
+	}
+}
+
 /**
  * sta_info_free - free STA
  *
@@ -287,7 +298,7 @@ void sta_info_free(struct ieee80211_local *local, struct sta_info *sta)
 #ifdef CONFIG_MAC80211_MESH
 	kfree(sta->mesh);
 #endif
-	free_percpu(sta->pcpu_rx_stats);
+	sta_links_free(sta);
 	kfree(sta);
 }
 
@@ -333,6 +344,78 @@ static int sta_prepare_rate_control(struct ieee80211_local *local,
 	return 0;
 }
 
+static int sta_link_alloc(struct ieee80211_sub_if_data *sdata,
+			  struct sta_info *sta, const u8 *addr,
+			  bool update, gfp_t gfp)
+{
+	struct ieee80211_local *local = sdata->local;
+	struct ieee80211_hw *hw = &local->hw;
+	struct link_sta_info *lsinfo = NULL;
+	struct ieee80211_link_sta *lsta = NULL;
+	u8 link_id, i;
+
+	spin_lock_bh(&sta->lock);
+
+	/* TODO This is temporary, the link_id will be assigned based on sta vif */
+	link_id = sta->num_sta_links;
+
+	if (update) {
+		if (!sta->link[link_id] || !sta->sta.link[link_id])
+			return -EINVAL;
+		ether_addr_copy(sta->link[link_id]->addr, addr);
+		ether_addr_copy(sta->sta.link[link_id]->addr, addr);
+		goto out;
+	}
+
+	lsinfo = kzalloc(sizeof(*lsinfo), gfp);
+	if (!lsinfo)
+		goto free;
+
+	lsta = kzalloc(sizeof(*lsta), gfp);
+	if (!lsta)
+		goto free;
+
+	sta->link[link_id] = lsinfo;
+	lsinfo->link_id = link_id;
+	ether_addr_copy(lsinfo->addr, addr);
+	lsinfo->sta = sta;
+
+
+	sta->sta.link[link_id] = lsta;
+	ether_addr_copy(lsta->addr, addr);
+
+	if (ieee80211_hw_check(hw, USES_RSS)) {
+		lsinfo->pcpu_rx_stats =
+			alloc_percpu_gfp(struct ieee80211_sta_rx_stats, gfp);
+		if (!lsinfo->pcpu_rx_stats)
+			goto free;
+	}
+
+	lsinfo->rx_stats.last_rx = jiffies;
+
+	u64_stats_init(&lsinfo->rx_stats.syncp);
+
+	ewma_signal_init(&lsinfo->rx_stats_avg.signal);
+	ewma_avg_signal_init(&lsinfo->status_stats.avg_ack_signal);
+	for (i = 0; i < ARRAY_SIZE(lsinfo->rx_stats_avg.chain_signal); i++)
+		ewma_signal_init(&lsinfo->rx_stats_avg.chain_signal[i]);
+
+	sta->sta.num_sta_links++;
+	sta->num_sta_links++;
+
+out:
+	spin_unlock_bh(&sta->lock);
+	return 0;
+free:
+	kfree(lsta);
+
+	if (lsinfo) {
+		free_percpu(lsinfo->pcpu_rx_stats);
+		kfree(lsinfo);
+	}
+	return -ENOMEM;
+}
+
 struct sta_info *sta_info_alloc(struct ieee80211_sub_if_data *sdata,
 				const u8 *addr, gfp_t gfp)
 {
@@ -345,15 +428,19 @@ struct sta_info *sta_info_alloc(struct ieee80211_sub_if_data *sdata,
 	if (!sta)
 		return NULL;
 
-	if (ieee80211_hw_check(hw, USES_RSS)) {
-		sta->pcpu_rx_stats =
-			alloc_percpu_gfp(struct ieee80211_sta_rx_stats, gfp);
-		if (!sta->pcpu_rx_stats)
-			goto free;
-	}
-
 	spin_lock_init(&sta->lock);
 	spin_lock_init(&sta->ps_lock);
+
+	/* All sta objects get initialized as non-ml sta until new
+	 * links gets added for this sta addr, First link addr will
+	 * get overwritten during new link addition and sta->addr will
+	 * be retained as mld STA addr
+	 */
+	sta->multi_link_sta = false;
+
+	if (sta_link_alloc(sdata, sta, addr, false, gfp))
+		goto free;
+
 	INIT_WORK(&sta->drv_deliver_wk, sta_deliver_ps_frames);
 	INIT_WORK(&sta->ampdu_mlme.work, ieee80211_ba_session_work);
 	mutex_init(&sta->ampdu_mlme.mtx);
@@ -388,9 +475,6 @@ struct sta_info *sta_info_alloc(struct ieee80211_sub_if_data *sdata,
 
 	sta->local = local;
 	sta->sdata = sdata;
-	sta->rx_stats.last_rx = jiffies;
-
-	u64_stats_init(&sta->rx_stats.syncp);
 
 	ieee80211_init_frag_cache(&sta->frags);
 
@@ -400,10 +484,6 @@ struct sta_info *sta_info_alloc(struct ieee80211_sub_if_data *sdata,
 	sta->reserved_tid = IEEE80211_TID_UNRESERVED;
 
 	sta->last_connected = ktime_get_seconds();
-	ewma_signal_init(&sta->rx_stats_avg.signal);
-	ewma_avg_signal_init(&sta->status_stats.avg_ack_signal);
-	for (i = 0; i < ARRAY_SIZE(sta->rx_stats_avg.chain_signal); i++)
-		ewma_signal_init(&sta->rx_stats_avg.chain_signal[i]);
 
 	if (local->ops->wake_tx_queue) {
 		void *txq_data;
@@ -525,7 +605,7 @@ struct sta_info *sta_info_alloc(struct ieee80211_sub_if_data *sdata,
 	if (sta->sta.txq[0])
 		kfree(to_txq_info(sta->sta.txq[0]));
 free:
-	free_percpu(sta->pcpu_rx_stats);
+	sta_links_free(sta);
 #ifdef CONFIG_MAC80211_MESH
 	kfree(sta->mesh);
 #endif
@@ -2088,16 +2168,16 @@ int sta_info_move_state(struct sta_info *sta,
 
 u8 sta_info_tx_streams(struct sta_info *sta)
 {
-	struct ieee80211_sta_ht_cap *ht_cap = &sta->sta.ht_cap;
+	struct ieee80211_sta_ht_cap *ht_cap = &sta->sta.link[0]->ht_cap;
 	u8 rx_streams;
 
-	if (!sta->sta.ht_cap.ht_supported)
+	if (!sta->sta.link[0]->ht_cap.ht_supported)
 		return 1;
 
-	if (sta->sta.vht_cap.vht_supported) {
+	if (sta->sta.link[0]->vht_cap.vht_supported) {
 		int i;
 		u16 tx_mcs_map =
-			le16_to_cpu(sta->sta.vht_cap.vht_mcs.tx_mcs_map);
+			le16_to_cpu(sta->sta.link[0]->vht_cap.vht_mcs.tx_mcs_map);
 
 		for (i = 7; i >= 0; i--)
 			if ((tx_mcs_map & (0x3 << (i * 2))) !=
@@ -2124,16 +2204,16 @@ u8 sta_info_tx_streams(struct sta_info *sta)
 static struct ieee80211_sta_rx_stats *
 sta_get_last_rx_stats(struct sta_info *sta)
 {
-	struct ieee80211_sta_rx_stats *stats = &sta->rx_stats;
+	struct ieee80211_sta_rx_stats *stats = &sta->link[0]->rx_stats;
 	int cpu;
 
-	if (!sta->pcpu_rx_stats)
+	if (!sta->link[0]->pcpu_rx_stats)
 		return stats;
 
 	for_each_possible_cpu(cpu) {
 		struct ieee80211_sta_rx_stats *cpustats;
 
-		cpustats = per_cpu_ptr(sta->pcpu_rx_stats, cpu);
+		cpustats = per_cpu_ptr(sta->link[0]->pcpu_rx_stats, cpu);
 
 		if (time_after(cpustats->last_rx, stats->last_rx))
 			stats = cpustats;
@@ -2227,13 +2307,13 @@ static void sta_set_tidstats(struct sta_info *sta,
 	int cpu;
 
 	if (!(tidstats->filled & BIT(NL80211_TID_STATS_RX_MSDU))) {
-		tidstats->rx_msdu += sta_get_tidstats_msdu(&sta->rx_stats, tid);
+		tidstats->rx_msdu += sta_get_tidstats_msdu(&sta->link[0]->rx_stats, tid);
 
-		if (sta->pcpu_rx_stats) {
+		if (sta->link[0]->pcpu_rx_stats) {
 			for_each_possible_cpu(cpu) {
 				struct ieee80211_sta_rx_stats *cpurxs;
 
-				cpurxs = per_cpu_ptr(sta->pcpu_rx_stats, cpu);
+				cpurxs = per_cpu_ptr(sta->link[0]->pcpu_rx_stats, cpu);
 				tidstats->rx_msdu +=
 					sta_get_tidstats_msdu(cpurxs, tid);
 			}
@@ -2244,19 +2324,19 @@ static void sta_set_tidstats(struct sta_info *sta,
 
 	if (!(tidstats->filled & BIT(NL80211_TID_STATS_TX_MSDU))) {
 		tidstats->filled |= BIT(NL80211_TID_STATS_TX_MSDU);
-		tidstats->tx_msdu = sta->tx_stats.msdu[tid];
+		tidstats->tx_msdu = sta->link[0]->tx_stats.msdu[tid];
 	}
 
 	if (!(tidstats->filled & BIT(NL80211_TID_STATS_TX_MSDU_RETRIES)) &&
 	    ieee80211_hw_check(&local->hw, REPORTS_TX_ACK_STATUS)) {
 		tidstats->filled |= BIT(NL80211_TID_STATS_TX_MSDU_RETRIES);
-		tidstats->tx_msdu_retries = sta->status_stats.msdu_retries[tid];
+		tidstats->tx_msdu_retries = sta->link[0]->status_stats.msdu_retries[tid];
 	}
 
 	if (!(tidstats->filled & BIT(NL80211_TID_STATS_TX_MSDU_FAILED)) &&
 	    ieee80211_hw_check(&local->hw, REPORTS_TX_ACK_STATUS)) {
 		tidstats->filled |= BIT(NL80211_TID_STATS_TX_MSDU_FAILED);
-		tidstats->tx_msdu_failed = sta->status_stats.msdu_failed[tid];
+		tidstats->tx_msdu_failed = sta->link[0]->status_stats.msdu_failed[tid];
 	}
 
 	if (local->ops->wake_tx_queue && tid < IEEE80211_NUM_TIDS) {
@@ -2327,26 +2407,26 @@ void sta_set_sinfo(struct sta_info *sta, struct station_info *sinfo,
 			       BIT_ULL(NL80211_STA_INFO_TX_BYTES)))) {
 		sinfo->tx_bytes = 0;
 		for (ac = 0; ac < IEEE80211_NUM_ACS; ac++)
-			sinfo->tx_bytes += sta->tx_stats.bytes[ac];
+			sinfo->tx_bytes += sta->link[0]->tx_stats.bytes[ac];
 		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_BYTES64);
 	}
 
 	if (!(sinfo->filled & BIT_ULL(NL80211_STA_INFO_TX_PACKETS))) {
 		sinfo->tx_packets = 0;
 		for (ac = 0; ac < IEEE80211_NUM_ACS; ac++)
-			sinfo->tx_packets += sta->tx_stats.packets[ac];
+			sinfo->tx_packets += sta->link[0]->tx_stats.packets[ac];
 		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_PACKETS);
 	}
 
 	if (!(sinfo->filled & (BIT_ULL(NL80211_STA_INFO_RX_BYTES64) |
 			       BIT_ULL(NL80211_STA_INFO_RX_BYTES)))) {
-		sinfo->rx_bytes += sta_get_stats_bytes(&sta->rx_stats);
+		sinfo->rx_bytes += sta_get_stats_bytes(&sta->link[0]->rx_stats);
 
-		if (sta->pcpu_rx_stats) {
+		if (sta->link[0]->pcpu_rx_stats) {
 			for_each_possible_cpu(cpu) {
 				struct ieee80211_sta_rx_stats *cpurxs;
 
-				cpurxs = per_cpu_ptr(sta->pcpu_rx_stats, cpu);
+				cpurxs = per_cpu_ptr(sta->link[0]->pcpu_rx_stats, cpu);
 				sinfo->rx_bytes += sta_get_stats_bytes(cpurxs);
 			}
 		}
@@ -2355,12 +2435,12 @@ void sta_set_sinfo(struct sta_info *sta, struct station_info *sinfo,
 	}
 
 	if (!(sinfo->filled & BIT_ULL(NL80211_STA_INFO_RX_PACKETS))) {
-		sinfo->rx_packets = sta->rx_stats.packets;
-		if (sta->pcpu_rx_stats) {
+		sinfo->rx_packets = sta->link[0]->rx_stats.packets;
+		if (sta->link[0]->pcpu_rx_stats) {
 			for_each_possible_cpu(cpu) {
 				struct ieee80211_sta_rx_stats *cpurxs;
 
-				cpurxs = per_cpu_ptr(sta->pcpu_rx_stats, cpu);
+				cpurxs = per_cpu_ptr(sta->link[0]->pcpu_rx_stats, cpu);
 				sinfo->rx_packets += cpurxs->packets;
 			}
 		}
@@ -2368,12 +2448,12 @@ void sta_set_sinfo(struct sta_info *sta, struct station_info *sinfo,
 	}
 
 	if (!(sinfo->filled & BIT_ULL(NL80211_STA_INFO_TX_RETRIES))) {
-		sinfo->tx_retries = sta->status_stats.retry_count;
+		sinfo->tx_retries = sta->link[0]->status_stats.retry_count;
 		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_RETRIES);
 	}
 
 	if (!(sinfo->filled & BIT_ULL(NL80211_STA_INFO_TX_FAILED))) {
-		sinfo->tx_failed = sta->status_stats.retry_failed;
+		sinfo->tx_failed = sta->link[0]->status_stats.retry_failed;
 		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_FAILED);
 	}
 
@@ -2394,12 +2474,12 @@ void sta_set_sinfo(struct sta_info *sta, struct station_info *sinfo,
 		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_AIRTIME_WEIGHT);
 	}
 
-	sinfo->rx_dropped_misc = sta->rx_stats.dropped;
-	if (sta->pcpu_rx_stats) {
+	sinfo->rx_dropped_misc = sta->link[0]->rx_stats.dropped;
+	if (sta->link[0]->pcpu_rx_stats) {
 		for_each_possible_cpu(cpu) {
 			struct ieee80211_sta_rx_stats *cpurxs;
 
-			cpurxs = per_cpu_ptr(sta->pcpu_rx_stats, cpu);
+			cpurxs = per_cpu_ptr(sta->link[0]->pcpu_rx_stats, cpu);
 			sinfo->rx_dropped_misc += cpurxs->dropped;
 		}
 	}
@@ -2418,23 +2498,23 @@ void sta_set_sinfo(struct sta_info *sta, struct station_info *sinfo,
 			sinfo->filled |= BIT_ULL(NL80211_STA_INFO_SIGNAL);
 		}
 
-		if (!sta->pcpu_rx_stats &&
+		if (!sta->link[0]->pcpu_rx_stats &&
 		    !(sinfo->filled & BIT_ULL(NL80211_STA_INFO_SIGNAL_AVG))) {
 			sinfo->signal_avg =
-				-ewma_signal_read(&sta->rx_stats_avg.signal);
+				-ewma_signal_read(&sta->link[0]->rx_stats_avg.signal);
 			sinfo->filled |= BIT_ULL(NL80211_STA_INFO_SIGNAL_AVG);
 		}
 	}
 
 	/* for the average - if pcpu_rx_stats isn't set - rxstats must point to
-	 * the sta->rx_stats struct, so the check here is fine with and without
+	 * the sta->link[link_id]->rx_stats struct, so the check here is fine with and without
 	 * pcpu statistics
 	 */
 	if (last_rxstats->chains &&
 	    !(sinfo->filled & (BIT_ULL(NL80211_STA_INFO_CHAIN_SIGNAL) |
 			       BIT_ULL(NL80211_STA_INFO_CHAIN_SIGNAL_AVG)))) {
 		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_CHAIN_SIGNAL);
-		if (!sta->pcpu_rx_stats)
+		if (!sta->link[0]->pcpu_rx_stats)
 			sinfo->filled |= BIT_ULL(NL80211_STA_INFO_CHAIN_SIGNAL_AVG);
 
 		sinfo->chains = last_rxstats->chains;
@@ -2443,12 +2523,12 @@ void sta_set_sinfo(struct sta_info *sta, struct station_info *sinfo,
 			sinfo->chain_signal[i] =
 				last_rxstats->chain_signal_last[i];
 			sinfo->chain_signal_avg[i] =
-				-ewma_signal_read(&sta->rx_stats_avg.chain_signal[i]);
+				-ewma_signal_read(&sta->link[0]->rx_stats_avg.chain_signal[i]);
 		}
 	}
 
 	if (!(sinfo->filled & BIT_ULL(NL80211_STA_INFO_TX_BITRATE))) {
-		sta_set_rate_info_tx(sta, &sta->tx_stats.last_rate,
+		sta_set_rate_info_tx(sta, &sta->link[0]->tx_stats.last_rate,
 				     &sinfo->txrate);
 		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_BITRATE);
 	}
@@ -2530,16 +2610,16 @@ void sta_set_sinfo(struct sta_info *sta, struct station_info *sinfo,
 	}
 
 	if (!(sinfo->filled & BIT_ULL(NL80211_STA_INFO_ACK_SIGNAL)) &&
-	    sta->status_stats.ack_signal_filled) {
-		sinfo->ack_signal = sta->status_stats.last_ack_signal;
+	    sta->link[0]->status_stats.ack_signal_filled) {
+		sinfo->ack_signal = sta->link[0]->status_stats.last_ack_signal;
 		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_ACK_SIGNAL);
 	}
 
 	if (!(sinfo->filled & BIT_ULL(NL80211_STA_INFO_ACK_SIGNAL_AVG)) &&
-	    sta->status_stats.ack_signal_filled) {
+	    sta->link[0]->status_stats.ack_signal_filled) {
 		sinfo->avg_ack_signal =
 			-(s8)ewma_avg_signal_read(
-				&sta->status_stats.avg_ack_signal);
+				&sta->link[0]->status_stats.avg_ack_signal);
 		sinfo->filled |=
 			BIT_ULL(NL80211_STA_INFO_ACK_SIGNAL_AVG);
 	}
@@ -2574,10 +2654,10 @@ unsigned long ieee80211_sta_last_active(struct sta_info *sta)
 {
 	struct ieee80211_sta_rx_stats *stats = sta_get_last_rx_stats(sta);
 
-	if (!sta->status_stats.last_ack ||
-	    time_after(stats->last_rx, sta->status_stats.last_ack))
+	if (!sta->link[0]->status_stats.last_ack ||
+	    time_after(stats->last_rx, sta->link[0]->status_stats.last_ack))
 		return stats->last_rx;
-	return sta->status_stats.last_ack;
+	return sta->link[0]->status_stats.last_ack;
 }
 
 static void sta_update_codel_params(struct sta_info *sta, u32 thr)
diff --git a/net/mac80211/sta_info.h b/net/mac80211/sta_info.h
index 379fd36..b6467e6 100644
--- a/net/mac80211/sta_info.h
+++ b/net/mac80211/sta_info.h
@@ -484,6 +484,86 @@ struct ieee80211_fragment_cache {
 #define STA_SLOW_THRESHOLD 6000 /* 6 Mbps */
 
 /**
+ * struct link_sta_info - Link STA information
+ * All link specific sta info are stored here for reference. This can be
+ * a single entry for non-MLD STA or multiple entries for MLD STA
+ * @addr: Link MAC address - Can be same as MLD STA mac address and is always
+ *	same for non-MLD STA. This is used as key for searching link STA
+ * @link_id: Link ID uniquely identifying the link STA. This is 0 for non-MLD
+ *	and set to the corresponding vif LinkId for MLD STA
+ * @sta: Points to the STA info
+ * @gtk: group keys negotiated with this station, if any
+ * @tx_stats: TX statistics
+ * @tx_stats.packets: # of packets transmitted
+ * @tx_stats.bytes: # of bytes in all packets transmitted
+ * @tx_stats.last_rate: last TX rate
+ * @tx_stats.msdu: # of transmitted MSDUs per TID
+ * @rx_stats: RX statistics
+ * @rx_stats_avg: averaged RX statistics
+ * @rx_stats_avg.signal: averaged signal
+ * @rx_stats_avg.chain_signal: averaged per-chain signal
+ * @pcpu_rx_stats: per-CPU RX statistics, assigned only if the driver needs
+ *	this (by advertising the USES_RSS hw flag)
+ * @status_stats: TX status statistics
+ * @status_stats.filtered: # of filtered frames
+ * @status_stats.retry_failed: # of frames that failed after retry
+ * @status_stats.retry_count: # of retries attempted
+ * @status_stats.lost_packets: # of lost packets
+ * @status_stats.last_pkt_time: timestamp of last ACKed packet
+ * @status_stats.msdu_retries: # of MSDU retries
+ * @status_stats.msdu_failed: # of failed MSDUs
+ * @status_stats.last_ack: last ack timestamp (jiffies)
+ * @status_stats.last_ack_signal: last ACK signal
+ * @status_stats.ack_signal_filled: last ACK signal validity
+ * @status_stats.avg_ack_signal: average ACK signal
+ * TODO Move other link params from sta_info as required for MLD operation
+ */
+struct link_sta_info {
+	u8 addr[ETH_ALEN];
+	u8 link_id;
+
+	/* TODO rhash head/node for finding link_sta based on addr */
+
+	struct sta_info *sta;
+	struct ieee80211_key __rcu *gtk[NUM_DEFAULT_KEYS +
+					NUM_DEFAULT_MGMT_KEYS +
+					NUM_DEFAULT_BEACON_KEYS];
+	struct ieee80211_sta_rx_stats __percpu *pcpu_rx_stats;
+
+	/* Updated from RX path only, no locking requirements */
+	struct ieee80211_sta_rx_stats rx_stats;
+	struct {
+		struct ewma_signal signal;
+		struct ewma_signal chain_signal[IEEE80211_MAX_CHAINS];
+	} rx_stats_avg;
+
+	/* Updated from TX status path only, no locking requirements */
+	struct {
+		unsigned long filtered;
+		unsigned long retry_failed, retry_count;
+		unsigned int lost_packets;
+		unsigned long last_pkt_time;
+		u64 msdu_retries[IEEE80211_NUM_TIDS + 1];
+		u64 msdu_failed[IEEE80211_NUM_TIDS + 1];
+		unsigned long last_ack;
+		s8 last_ack_signal;
+		bool ack_signal_filled;
+		struct ewma_avg_signal avg_ack_signal;
+	} status_stats;
+
+	/* Updated from TX path only, no locking requirements */
+	struct {
+		u64 packets[IEEE80211_NUM_ACS];
+		u64 bytes[IEEE80211_NUM_ACS];
+		struct ieee80211_tx_rate last_rate;
+		struct rate_info last_rate_info;
+		u64 msdu[IEEE80211_NUM_TIDS + 1];
+	} tx_stats;
+
+	enum ieee80211_sta_rx_bandwidth cur_max_bandwidth;
+};
+
+/**
  * struct sta_info - STA information
  *
  * This structure collects information about a station that
@@ -498,7 +578,6 @@ struct ieee80211_fragment_cache {
  * @sdata: virtual interface this station belongs to
  * @ptk: peer keys negotiated with this station, if any
  * @ptk_idx: last installed peer key index
- * @gtk: group keys negotiated with this station, if any
  * @rate_ctrl: rate control algorithm reference
  * @rate_ctrl_lock: spinlock used to protect rate control data
  *	(data inside the algorithm, so serializes calls there)
@@ -544,30 +623,11 @@ struct ieee80211_fragment_cache {
  * @fast_rx: RX fastpath information
  * @tdls_chandef: a TDLS peer can have a wider chandef that is compatible to
  *	the BSS one.
- * @tx_stats: TX statistics
- * @tx_stats.packets: # of packets transmitted
- * @tx_stats.bytes: # of bytes in all packets transmitted
- * @tx_stats.last_rate: last TX rate
- * @tx_stats.msdu: # of transmitted MSDUs per TID
- * @rx_stats: RX statistics
- * @rx_stats_avg: averaged RX statistics
- * @rx_stats_avg.signal: averaged signal
- * @rx_stats_avg.chain_signal: averaged per-chain signal
- * @pcpu_rx_stats: per-CPU RX statistics, assigned only if the driver needs
- *	this (by advertising the USES_RSS hw flag)
- * @status_stats: TX status statistics
- * @status_stats.filtered: # of filtered frames
- * @status_stats.retry_failed: # of frames that failed after retry
- * @status_stats.retry_count: # of retries attempted
- * @status_stats.lost_packets: # of lost packets
- * @status_stats.last_pkt_time: timestamp of last ACKed packet
- * @status_stats.msdu_retries: # of MSDU retries
- * @status_stats.msdu_failed: # of failed MSDUs
- * @status_stats.last_ack: last ack timestamp (jiffies)
- * @status_stats.last_ack_signal: last ACK signal
- * @status_stats.ack_signal_filled: last ACK signal validity
- * @status_stats.avg_ack_signal: average ACK signal
  * @frags: fragment cache
+ * @multi_link_sta: Identifies if this sta is a MLD STA or regular STA
+ * @num_sta_links: Number of Link STA currently part of this MLD STA. For Legacy
+ *	STA this value is always 1.
+ * @link: reference to link specific STA info
  */
 struct sta_info {
 	/* General information, mostly static */
@@ -577,9 +637,6 @@ struct sta_info {
 	u8 addr[ETH_ALEN];
 	struct ieee80211_local *local;
 	struct ieee80211_sub_if_data *sdata;
-	struct ieee80211_key __rcu *gtk[NUM_DEFAULT_KEYS +
-					NUM_DEFAULT_MGMT_KEYS +
-					NUM_DEFAULT_BEACON_KEYS];
 	struct ieee80211_key __rcu *ptk[NUM_DEFAULT_KEYS];
 	u8 ptk_idx;
 	struct rate_control_ref *rate_ctrl;
@@ -589,7 +646,6 @@ struct sta_info {
 
 	struct ieee80211_fast_tx __rcu *fast_tx;
 	struct ieee80211_fast_rx __rcu *fast_rx;
-	struct ieee80211_sta_rx_stats __percpu *pcpu_rx_stats;
 
 #ifdef CONFIG_MAC80211_MESH
 	struct mesh_sta *mesh;
@@ -619,38 +675,9 @@ struct sta_info {
 	u64 assoc_at;
 	long last_connected;
 
-	/* Updated from RX path only, no locking requirements */
-	struct ieee80211_sta_rx_stats rx_stats;
-	struct {
-		struct ewma_signal signal;
-		struct ewma_signal chain_signal[IEEE80211_MAX_CHAINS];
-	} rx_stats_avg;
-
 	/* Plus 1 for non-QoS frames */
 	__le16 last_seq_ctrl[IEEE80211_NUM_TIDS + 1];
 
-	/* Updated from TX status path only, no locking requirements */
-	struct {
-		unsigned long filtered;
-		unsigned long retry_failed, retry_count;
-		unsigned int lost_packets;
-		unsigned long last_pkt_time;
-		u64 msdu_retries[IEEE80211_NUM_TIDS + 1];
-		u64 msdu_failed[IEEE80211_NUM_TIDS + 1];
-		unsigned long last_ack;
-		s8 last_ack_signal;
-		bool ack_signal_filled;
-		struct ewma_avg_signal avg_ack_signal;
-	} status_stats;
-
-	/* Updated from TX path only, no locking requirements */
-	struct {
-		u64 packets[IEEE80211_NUM_ACS];
-		u64 bytes[IEEE80211_NUM_ACS];
-		struct ieee80211_tx_rate last_rate;
-		struct rate_info last_rate_info;
-		u64 msdu[IEEE80211_NUM_TIDS + 1];
-	} tx_stats;
 	u16 tid_seq[IEEE80211_QOS_CTL_TID_MASK + 1];
 
 	struct airtime_info airtime[IEEE80211_NUM_ACS];
@@ -664,8 +691,6 @@ struct sta_info {
 	struct dentry *debugfs_dir;
 #endif
 
-	enum ieee80211_sta_rx_bandwidth cur_max_bandwidth;
-
 	enum ieee80211_smps_mode known_smps_mode;
 	const struct ieee80211_cipher_scheme *cipher_scheme;
 
@@ -677,6 +702,10 @@ struct sta_info {
 
 	struct ieee80211_fragment_cache frags;
 
+	bool multi_link_sta;
+	u8 num_sta_links;
+	struct link_sta_info *link[MAX_STA_LINKS];
+
 	/* keep last! */
 	struct ieee80211_sta sta;
 };
diff --git a/net/mac80211/status.c b/net/mac80211/status.c
index f6f63a0..9e7e7e0 100644
--- a/net/mac80211/status.c
+++ b/net/mac80211/status.c
@@ -71,7 +71,7 @@ static void ieee80211_handle_filtered_frame(struct ieee80211_local *local,
 	info->flags |= IEEE80211_TX_INTFL_RETRANSMISSION;
 	info->flags &= ~IEEE80211_TX_TEMPORARY_FLAGS;
 
-	sta->status_stats.filtered++;
+	sta->link[0]->status_stats.filtered++;
 
 	/*
 	 * Clear more-data bit on filtered frames, it might be set
@@ -774,7 +774,7 @@ static void ieee80211_lost_packet(struct sta_info *sta,
 	    !(info->flags & IEEE80211_TX_STAT_AMPDU))
 		return;
 
-	sta->status_stats.lost_packets++;
+	sta->link[0]->status_stats.lost_packets++;
 	if (sta->sta.tdls) {
 		pkt_time = STA_LOST_TDLS_PKT_TIME;
 		pkt_thr = STA_LOST_PKT_THRESHOLD;
@@ -787,13 +787,13 @@ static void ieee80211_lost_packet(struct sta_info *sta,
 	 * mechanism.
 	 * For non-TDLS, use STA_LOST_PKT_THRESHOLD and STA_LOST_PKT_TIME
 	 */
-	if (sta->status_stats.lost_packets < pkt_thr ||
-	    !time_after(jiffies, sta->status_stats.last_pkt_time + pkt_time))
+	if (sta->link[0]->status_stats.lost_packets < pkt_thr ||
+	    !time_after(jiffies, sta->link[0]->status_stats.last_pkt_time + pkt_time))
 		return;
 
 	cfg80211_cqm_pktloss_notify(sta->sdata->dev, sta->sta.addr,
-				    sta->status_stats.lost_packets, GFP_ATOMIC);
-	sta->status_stats.lost_packets = 0;
+				    sta->link[0]->status_stats.lost_packets, GFP_ATOMIC);
+	sta->link[0]->status_stats.lost_packets = 0;
 }
 
 static int ieee80211_tx_get_rates(struct ieee80211_hw *hw,
@@ -928,7 +928,7 @@ static void __ieee80211_tx_status(struct ieee80211_hw *hw,
 		if (ieee80211_hw_check(&local->hw, HAS_RATE_CONTROL) &&
 		    (ieee80211_is_data(hdr->frame_control)) &&
 		    (rates_idx != -1))
-			sta->tx_stats.last_rate =
+			sta->link[0]->tx_stats.last_rate =
 				info->status.rates[rates_idx];
 
 		if ((info->flags & IEEE80211_TX_STAT_AMPDU_NO_BACK) &&
@@ -974,9 +974,9 @@ static void __ieee80211_tx_status(struct ieee80211_hw *hw,
 			return;
 		} else if (ieee80211_is_data_present(fc)) {
 			if (!acked && !noack_success)
-				sta->status_stats.msdu_failed[tid]++;
+				sta->link[0]->status_stats.msdu_failed[tid]++;
 
-			sta->status_stats.msdu_retries[tid] +=
+			sta->link[0]->status_stats.msdu_retries[tid] +=
 				retry_count;
 		}
 
@@ -1109,7 +1109,7 @@ void ieee80211_tx_status_ext(struct ieee80211_hw *hw,
 		sta = container_of(pubsta, struct sta_info, sta);
 
 		if (status->rate)
-			sta->tx_stats.last_rate_info = *status->rate;
+			sta->link[0]->tx_stats.last_rate_info = *status->rate;
 	}
 
 	if (skb && (tx_time_est =
@@ -1136,10 +1136,11 @@ void ieee80211_tx_status_ext(struct ieee80211_hw *hw,
 
 	if (pubsta) {
 		struct ieee80211_sub_if_data *sdata = sta->sdata;
+		struct link_sta_info *lsta = sta->link[0];
 
 		if (!acked && !noack_success)
-			sta->status_stats.retry_failed++;
-		sta->status_stats.retry_count += retry_count;
+			sta->link[0]->status_stats.retry_failed++;
+		sta->link[0]->status_stats.retry_count += retry_count;
 
 		if (ieee80211_hw_check(&local->hw, REPORTS_TX_ACK_STATUS)) {
 			if (sdata->vif.type == NL80211_IFTYPE_STATION &&
@@ -1148,13 +1149,13 @@ void ieee80211_tx_status_ext(struct ieee80211_hw *hw,
 							acked, info->status.tx_time);
 
 			if (acked) {
-				sta->status_stats.last_ack = jiffies;
+				sta->link[0]->status_stats.last_ack = jiffies;
 
-				if (sta->status_stats.lost_packets)
-					sta->status_stats.lost_packets = 0;
+				if (sta->link[0]->status_stats.lost_packets)
+					sta->link[0]->status_stats.lost_packets = 0;
 
 				/* Track when last packet was ACKed */
-				sta->status_stats.last_pkt_time = jiffies;
+				sta->link[0]->status_stats.last_pkt_time = jiffies;
 
 				/* Reset connection monitor */
 				if (sdata->vif.type == NL80211_IFTYPE_STATION &&
@@ -1162,10 +1163,10 @@ void ieee80211_tx_status_ext(struct ieee80211_hw *hw,
 					sdata->u.mgd.probe_send_count = 0;
 
 				if (info->status.is_valid_ack_signal) {
-					sta->status_stats.last_ack_signal =
+					sta->link[0]->status_stats.last_ack_signal =
 							 (s8)info->status.ack_signal;
-					sta->status_stats.ack_signal_filled = true;
-					ewma_avg_signal_add(&sta->status_stats.avg_ack_signal,
+					sta->link[0]->status_stats.ack_signal_filled = true;
+					ewma_avg_signal_add(&lsta->status_stats.avg_ack_signal,
 							    -info->status.ack_signal);
 				}
 			} else if (test_sta_flag(sta, WLAN_STA_PS_STA)) {
@@ -1231,7 +1232,7 @@ void ieee80211_tx_rate_update(struct ieee80211_hw *hw,
 	rate_control_tx_status(local, sband, &status);
 
 	if (ieee80211_hw_check(&local->hw, HAS_RATE_CONTROL))
-		sta->tx_stats.last_rate = info->status.rates[0];
+		sta->link[0]->tx_stats.last_rate = info->status.rates[0];
 }
 EXPORT_SYMBOL(ieee80211_tx_rate_update);
 
diff --git a/net/mac80211/tdls.c b/net/mac80211/tdls.c
index 137be9e..4a6e5ff 100644
--- a/net/mac80211/tdls.c
+++ b/net/mac80211/tdls.c
@@ -459,9 +459,9 @@ ieee80211_tdls_add_setup_start_ies(struct ieee80211_sub_if_data *sdata,
 		pos = skb_put(skb, sizeof(struct ieee80211_ht_cap) + 2);
 		ieee80211_ie_build_ht_cap(pos, &ht_cap, ht_cap.cap);
 	} else if (action_code == WLAN_TDLS_SETUP_RESPONSE &&
-		   ht_cap.ht_supported && sta->sta.ht_cap.ht_supported) {
+		   ht_cap.ht_supported && sta->sta.link[0]->ht_cap.ht_supported) {
 		/* the peer caps are already intersected with our own */
-		memcpy(&ht_cap, &sta->sta.ht_cap, sizeof(ht_cap));
+		memcpy(&ht_cap, &sta->sta.link[0]->ht_cap, sizeof(ht_cap));
 
 		pos = skb_put(skb, sizeof(struct ieee80211_ht_cap) + 2);
 		ieee80211_ie_build_ht_cap(pos, &ht_cap, ht_cap.cap);
@@ -510,9 +510,9 @@ ieee80211_tdls_add_setup_start_ies(struct ieee80211_sub_if_data *sdata,
 		pos = skb_put(skb, sizeof(struct ieee80211_vht_cap) + 2);
 		ieee80211_ie_build_vht_cap(pos, &vht_cap, vht_cap.cap);
 	} else if (action_code == WLAN_TDLS_SETUP_RESPONSE &&
-		   vht_cap.vht_supported && sta->sta.vht_cap.vht_supported) {
+		   vht_cap.vht_supported && sta->sta.link[0]->vht_cap.vht_supported) {
 		/* the peer caps are already intersected with our own */
-		memcpy(&vht_cap, &sta->sta.vht_cap, sizeof(vht_cap));
+		memcpy(&vht_cap, &sta->sta.link[0]->vht_cap, sizeof(vht_cap));
 
 		/* the AID is present only when VHT is implemented */
 		ieee80211_tdls_add_aid(sdata, skb);
@@ -603,13 +603,13 @@ ieee80211_tdls_add_setup_cfm_ies(struct ieee80211_sub_if_data *sdata,
 	 * if HT support is only added in TDLS, we need an HT-operation IE.
 	 * add the IE as required by IEEE802.11-2012 9.23.3.2.
 	 */
-	if (!ap_sta->sta.ht_cap.ht_supported && sta->sta.ht_cap.ht_supported) {
+	if (!ap_sta->sta.link[0]->ht_cap.ht_supported && sta->sta.link[0]->ht_cap.ht_supported) {
 		u16 prot = IEEE80211_HT_OP_MODE_PROTECTION_NONHT_MIXED |
 			   IEEE80211_HT_OP_MODE_NON_GF_STA_PRSNT |
 			   IEEE80211_HT_OP_MODE_NON_HT_STA_PRSNT;
 
 		pos = skb_put(skb, 2 + sizeof(struct ieee80211_ht_operation));
-		ieee80211_ie_build_ht_oper(pos, &sta->sta.ht_cap,
+		ieee80211_ie_build_ht_oper(pos, &sta->sta.link[0]->ht_cap,
 					   &sdata->vif.bss_conf.chandef, prot,
 					   true);
 	}
@@ -618,7 +618,7 @@ ieee80211_tdls_add_setup_cfm_ies(struct ieee80211_sub_if_data *sdata,
 
 	/* only include VHT-operation if not on the 2.4GHz band */
 	if (sband->band != NL80211_BAND_2GHZ &&
-	    sta->sta.vht_cap.vht_supported) {
+	    sta->sta.link[0]->vht_cap.vht_supported) {
 		/*
 		 * if both peers support WIDER_BW, we can expand the chandef to
 		 * a wider compatible one, up to 80MHz
@@ -627,7 +627,7 @@ ieee80211_tdls_add_setup_cfm_ies(struct ieee80211_sub_if_data *sdata,
 			ieee80211_tdls_chandef_vht_upgrade(sdata, sta);
 
 		pos = skb_put(skb, 2 + sizeof(struct ieee80211_vht_operation));
-		ieee80211_ie_build_vht_oper(pos, &sta->sta.vht_cap,
+		ieee80211_ie_build_vht_oper(pos, &sta->sta.link[0]->vht_cap,
 					    &sta->tdls_chandef);
 	}
 
@@ -1269,8 +1269,8 @@ static void iee80211_tdls_recalc_chanctx(struct ieee80211_sub_if_data *sdata,
 
 			bw = ieee80211_chan_width_to_rx_bw(conf->def.width);
 			bw = min(bw, ieee80211_sta_cap_rx_bw(sta));
-			if (bw != sta->sta.bandwidth) {
-				sta->sta.bandwidth = bw;
+			if (bw != sta->sta.link[0]->bandwidth) {
+				sta->sta.link[0]->bandwidth = bw;
 				rate_control_rate_update(local, sband, sta,
 							 IEEE80211_RC_BW_CHANGED);
 				/*
@@ -1296,7 +1296,7 @@ static int iee80211_tdls_have_ht_peers(struct ieee80211_sub_if_data *sdata)
 		if (!sta->sta.tdls || sta->sdata != sdata || !sta->uploaded ||
 		    !test_sta_flag(sta, WLAN_STA_AUTHORIZED) ||
 		    !test_sta_flag(sta, WLAN_STA_TDLS_PEER_AUTH) ||
-		    !sta->sta.ht_cap.ht_supported)
+		    !sta->sta.link[0]->ht_cap.ht_supported)
 			continue;
 		result = true;
 		break;
@@ -1321,7 +1321,7 @@ iee80211_tdls_recalc_ht_protection(struct ieee80211_sub_if_data *sdata,
 	if (!(ifmgd->flags & IEEE80211_STA_DISABLE_HT))
 		return;
 
-	tdls_ht = (sta && sta->sta.ht_cap.ht_supported) ||
+	tdls_ht = (sta && sta->sta.link[0]->ht_cap.ht_supported) ||
 		  iee80211_tdls_have_ht_peers(sdata);
 
 	opmode = sdata->vif.bss_conf.ht_operation_mode;
@@ -1900,7 +1900,7 @@ ieee80211_process_tdls_channel_switch_req(struct ieee80211_sub_if_data *sdata,
 	}
 
 	/* peer should have known better */
-	if (!sta->sta.ht_cap.ht_supported && elems->sec_chan_offs &&
+	if (!sta->sta.link[0]->ht_cap.ht_supported && elems->sec_chan_offs &&
 	    elems->sec_chan_offs->sec_chan_offs) {
 		tdls_dbg(sdata, "TDLS chan switch - wide chan unsupported\n");
 		ret = -ENOTSUPP;
diff --git a/net/mac80211/trace.h b/net/mac80211/trace.h
index d91498f..9fe5152 100644
--- a/net/mac80211/trace.h
+++ b/net/mac80211/trace.h
@@ -860,8 +860,8 @@ TRACE_EVENT(drv_sta_set_txpwr,
 		LOCAL_ASSIGN;
 		VIF_ASSIGN;
 		STA_ASSIGN;
-		__entry->txpwr = sta->txpwr.power;
-		__entry->type = sta->txpwr.type;
+		__entry->txpwr = sta->link[0]->txpwr.power;
+		__entry->type = sta->link[0]->txpwr.type;
 	),
 
 	TP_printk(
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 6d054fe..636a837 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -768,9 +768,9 @@ ieee80211_tx_h_rate_ctrl(struct ieee80211_tx_data *tx)
 	if (txrc.reported_rate.idx < 0) {
 		txrc.reported_rate = tx->rate;
 		if (tx->sta && ieee80211_is_tx_data(tx->skb))
-			tx->sta->tx_stats.last_rate = txrc.reported_rate;
+			tx->sta->link[0]->tx_stats.last_rate = txrc.reported_rate;
 	} else if (tx->sta)
-		tx->sta->tx_stats.last_rate = txrc.reported_rate;
+		tx->sta->link[0]->tx_stats.last_rate = txrc.reported_rate;
 
 	if (ratetbl)
 		return TX_CONTINUE;
@@ -837,7 +837,7 @@ ieee80211_tx_h_sequence(struct ieee80211_tx_data *tx)
 		hdr->seq_ctrl = cpu_to_le16(tx->sdata->sequence_number);
 		tx->sdata->sequence_number += 0x10;
 		if (tx->sta)
-			tx->sta->tx_stats.msdu[IEEE80211_NUM_TIDS]++;
+			tx->sta->link[0]->tx_stats.msdu[IEEE80211_NUM_TIDS]++;
 		return TX_CONTINUE;
 	}
 
@@ -851,7 +851,7 @@ ieee80211_tx_h_sequence(struct ieee80211_tx_data *tx)
 
 	/* include per-STA, per-TID sequence counter */
 	tid = ieee80211_get_tid(hdr);
-	tx->sta->tx_stats.msdu[tid]++;
+	tx->sta->link[0]->tx_stats.msdu[tid]++;
 
 	hdr->seq_ctrl = ieee80211_tx_next_seq(tx->sta, tid);
 
@@ -1004,10 +1004,10 @@ ieee80211_tx_h_stats(struct ieee80211_tx_data *tx)
 
 	skb_queue_walk(&tx->skbs, skb) {
 		ac = skb_get_queue_mapping(skb);
-		tx->sta->tx_stats.bytes[ac] += skb->len;
+		tx->sta->link[0]->tx_stats.bytes[ac] += skb->len;
 	}
 	if (ac >= 0)
-		tx->sta->tx_stats.packets[ac]++;
+		tx->sta->link[0]->tx_stats.packets[ac]++;
 
 	return TX_CONTINUE;
 }
@@ -1159,7 +1159,7 @@ ieee80211_aggr_check(struct ieee80211_sub_if_data *sdata,
 	if (!ref || !(ref->ops->capa & RATE_CTRL_CAPA_AMPDU_TRIGGER))
 		return;
 
-	if (!sta || !sta->sta.ht_cap.ht_supported ||
+	if (!sta || !sta->sta.link[0]->ht_cap.ht_supported ||
 	    !sta->sta.wme || skb_get_queue_mapping(skb) == IEEE80211_AC_VO ||
 	    skb->protocol == sdata->control_port_protocol)
 		return;
@@ -3462,18 +3462,18 @@ ieee80211_xmit_fast_finish(struct ieee80211_sub_if_data *sdata,
 	}
 
 	if (skb_shinfo(skb)->gso_size)
-		sta->tx_stats.msdu[tid] +=
+		sta->link[0]->tx_stats.msdu[tid] +=
 			DIV_ROUND_UP(skb->len, skb_shinfo(skb)->gso_size);
 	else
-		sta->tx_stats.msdu[tid]++;
+		sta->link[0]->tx_stats.msdu[tid]++;
 
 	info->hw_queue = sdata->vif.hw_queue[skb_get_queue_mapping(skb)];
 
 	/* statistics normally done by ieee80211_tx_h_stats (but that
 	 * has to consider fragmentation, so is more complex)
 	 */
-	sta->tx_stats.bytes[skb_get_queue_mapping(skb)] += skb->len;
-	sta->tx_stats.packets[skb_get_queue_mapping(skb)]++;
+	sta->link[0]->tx_stats.bytes[skb_get_queue_mapping(skb)] += skb->len;
+	sta->link[0]->tx_stats.packets[skb_get_queue_mapping(skb)]++;
 
 	if (pn_offs) {
 		u64 pn;
@@ -4481,8 +4481,8 @@ static void ieee80211_8023_xmit(struct ieee80211_sub_if_data *sdata,
 
 	dev_sw_netstats_tx_add(dev, 1, skb->len);
 
-	sta->tx_stats.bytes[skb_get_queue_mapping(skb)] += skb->len;
-	sta->tx_stats.packets[skb_get_queue_mapping(skb)]++;
+	sta->link[0]->tx_stats.bytes[skb_get_queue_mapping(skb)] += skb->len;
+	sta->link[0]->tx_stats.packets[skb_get_queue_mapping(skb)]++;
 
 	if (sdata->vif.type == NL80211_IFTYPE_AP_VLAN)
 		sdata = container_of(sdata->bss,
diff --git a/net/mac80211/vht.c b/net/mac80211/vht.c
index e856f90..d02033e 100644
--- a/net/mac80211/vht.c
+++ b/net/mac80211/vht.c
@@ -118,14 +118,14 @@ ieee80211_vht_cap_ie_to_sta_vht_cap(struct ieee80211_sub_if_data *sdata,
 				    const struct ieee80211_vht_cap *vht_cap_ie,
 				    struct sta_info *sta)
 {
-	struct ieee80211_sta_vht_cap *vht_cap = &sta->sta.vht_cap;
+	struct ieee80211_sta_vht_cap *vht_cap = &sta->sta.link[0]->vht_cap;
 	struct ieee80211_sta_vht_cap own_cap;
 	u32 cap_info, i;
 	bool have_80mhz;
 
 	memset(vht_cap, 0, sizeof(*vht_cap));
 
-	if (!sta->sta.ht_cap.ht_supported)
+	if (!sta->sta.link[0]->ht_cap.ht_supported)
 		return;
 
 	if (!vht_cap_ie || !sband->vht_cap.vht_supported)
@@ -295,10 +295,10 @@ ieee80211_vht_cap_ie_to_sta_vht_cap(struct ieee80211_sub_if_data *sdata,
 	switch (vht_cap->cap & IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_MASK) {
 	case IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_160MHZ:
 	case IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_160_80PLUS80MHZ:
-		sta->cur_max_bandwidth = IEEE80211_STA_RX_BW_160;
+		sta->link[0]->cur_max_bandwidth = IEEE80211_STA_RX_BW_160;
 		break;
 	default:
-		sta->cur_max_bandwidth = IEEE80211_STA_RX_BW_80;
+		sta->link[0]->cur_max_bandwidth = IEEE80211_STA_RX_BW_80;
 
 		if (!(vht_cap->vht_mcs.tx_highest &
 				cpu_to_le16(IEEE80211_VHT_EXT_NSS_BW_CAPABLE)))
@@ -310,10 +310,10 @@ ieee80211_vht_cap_ie_to_sta_vht_cap(struct ieee80211_sub_if_data *sdata,
 		 * above) between 160 and 80+80 yet.
 		 */
 		if (cap_info & IEEE80211_VHT_CAP_EXT_NSS_BW_MASK)
-			sta->cur_max_bandwidth = IEEE80211_STA_RX_BW_160;
+			sta->link[0]->cur_max_bandwidth = IEEE80211_STA_RX_BW_160;
 	}
 
-	sta->sta.bandwidth = ieee80211_sta_cur_vht_bw(sta);
+	sta->sta.link[0]->bandwidth = ieee80211_sta_cur_vht_bw(sta);
 
 	switch (vht_cap->cap & IEEE80211_VHT_CAP_MAX_MPDU_MASK) {
 	case IEEE80211_VHT_CAP_MAX_MPDU_LENGTH_11454:
@@ -332,8 +332,8 @@ ieee80211_vht_cap_ie_to_sta_vht_cap(struct ieee80211_sub_if_data *sdata,
 /* FIXME: move this to some better location - parses HE now */
 enum ieee80211_sta_rx_bandwidth ieee80211_sta_cap_rx_bw(struct sta_info *sta)
 {
-	struct ieee80211_sta_vht_cap *vht_cap = &sta->sta.vht_cap;
-	struct ieee80211_sta_he_cap *he_cap = &sta->sta.he_cap;
+	struct ieee80211_sta_vht_cap *vht_cap = &sta->sta.link[0]->vht_cap;
+	struct ieee80211_sta_he_cap *he_cap = &sta->sta.link[0]->he_cap;
 	u32 cap_width;
 
 	if (he_cap->has_he) {
@@ -357,7 +357,7 @@ enum ieee80211_sta_rx_bandwidth ieee80211_sta_cap_rx_bw(struct sta_info *sta)
 	}
 
 	if (!vht_cap->vht_supported)
-		return sta->sta.ht_cap.cap & IEEE80211_HT_CAP_SUP_WIDTH_20_40 ?
+		return sta->sta.link[0]->ht_cap.cap & IEEE80211_HT_CAP_SUP_WIDTH_20_40 ?
 				IEEE80211_STA_RX_BW_40 :
 				IEEE80211_STA_RX_BW_20;
 
@@ -380,14 +380,14 @@ enum ieee80211_sta_rx_bandwidth ieee80211_sta_cap_rx_bw(struct sta_info *sta)
 
 enum nl80211_chan_width ieee80211_sta_cap_chan_bw(struct sta_info *sta)
 {
-	struct ieee80211_sta_vht_cap *vht_cap = &sta->sta.vht_cap;
+	struct ieee80211_sta_vht_cap *vht_cap = &sta->sta.link[0]->vht_cap;
 	u32 cap_width;
 
 	if (!vht_cap->vht_supported) {
-		if (!sta->sta.ht_cap.ht_supported)
+		if (!sta->sta.link[0]->ht_cap.ht_supported)
 			return NL80211_CHAN_WIDTH_20_NOHT;
 
-		return sta->sta.ht_cap.cap & IEEE80211_HT_CAP_SUP_WIDTH_20_40 ?
+		return sta->sta.link[0]->ht_cap.cap & IEEE80211_HT_CAP_SUP_WIDTH_20_40 ?
 				NL80211_CHAN_WIDTH_40 : NL80211_CHAN_WIDTH_20;
 	}
 
@@ -404,13 +404,13 @@ enum nl80211_chan_width ieee80211_sta_cap_chan_bw(struct sta_info *sta)
 enum nl80211_chan_width
 ieee80211_sta_rx_bw_to_chan_width(struct sta_info *sta)
 {
-	enum ieee80211_sta_rx_bandwidth cur_bw = sta->sta.bandwidth;
-	struct ieee80211_sta_vht_cap *vht_cap = &sta->sta.vht_cap;
+	enum ieee80211_sta_rx_bandwidth cur_bw = sta->sta.link[0]->bandwidth;
+	struct ieee80211_sta_vht_cap *vht_cap = &sta->sta.link[0]->vht_cap;
 	u32 cap_width;
 
 	switch (cur_bw) {
 	case IEEE80211_STA_RX_BW_20:
-		if (!sta->sta.ht_cap.ht_supported)
+		if (!sta->sta.link[0]->ht_cap.ht_supported)
 			return NL80211_CHAN_WIDTH_20_NOHT;
 		else
 			return NL80211_CHAN_WIDTH_20;
@@ -459,7 +459,7 @@ enum ieee80211_sta_rx_bandwidth ieee80211_sta_cur_vht_bw(struct sta_info *sta)
 	enum nl80211_chan_width bss_width = sdata->vif.bss_conf.chandef.width;
 
 	bw = ieee80211_sta_cap_rx_bw(sta);
-	bw = min(bw, sta->cur_max_bandwidth);
+	bw = min(bw, sta->link[0]->cur_max_bandwidth);
 
 	/* Don't consider AP's bandwidth for TDLS peers, section 11.23.1 of
 	 * IEEE80211-2016 specification makes higher bandwidth operation
@@ -487,13 +487,13 @@ void ieee80211_sta_set_rx_nss(struct sta_info *sta)
 	bool support_160;
 
 	/* if we received a notification already don't overwrite it */
-	if (sta->sta.rx_nss)
+	if (sta->sta.link[0]->rx_nss)
 		return;
 
-	if (sta->sta.he_cap.has_he) {
+	if (sta->sta.link[0]->he_cap.has_he) {
 		int i;
 		u8 rx_mcs_80 = 0, rx_mcs_160 = 0;
-		const struct ieee80211_sta_he_cap *he_cap = &sta->sta.he_cap;
+		const struct ieee80211_sta_he_cap *he_cap = &sta->sta.link[0]->he_cap;
 		u16 mcs_160_map =
 			le16_to_cpu(he_cap->he_mcs_nss_supp.rx_mcs_160);
 		u16 mcs_80_map = le16_to_cpu(he_cap->he_mcs_nss_supp.rx_mcs_80);
@@ -524,23 +524,23 @@ void ieee80211_sta_set_rx_nss(struct sta_info *sta)
 			he_rx_nss = rx_mcs_80;
 	}
 
-	if (sta->sta.ht_cap.ht_supported) {
-		if (sta->sta.ht_cap.mcs.rx_mask[0])
+	if (sta->sta.link[0]->ht_cap.ht_supported) {
+		if (sta->sta.link[0]->ht_cap.mcs.rx_mask[0])
 			ht_rx_nss++;
-		if (sta->sta.ht_cap.mcs.rx_mask[1])
+		if (sta->sta.link[0]->ht_cap.mcs.rx_mask[1])
 			ht_rx_nss++;
-		if (sta->sta.ht_cap.mcs.rx_mask[2])
+		if (sta->sta.link[0]->ht_cap.mcs.rx_mask[2])
 			ht_rx_nss++;
-		if (sta->sta.ht_cap.mcs.rx_mask[3])
+		if (sta->sta.link[0]->ht_cap.mcs.rx_mask[3])
 			ht_rx_nss++;
 		/* FIXME: consider rx_highest? */
 	}
 
-	if (sta->sta.vht_cap.vht_supported) {
+	if (sta->sta.link[0]->vht_cap.vht_supported) {
 		int i;
 		u16 rx_mcs_map;
 
-		rx_mcs_map = le16_to_cpu(sta->sta.vht_cap.vht_mcs.rx_mcs_map);
+		rx_mcs_map = le16_to_cpu(sta->sta.link[0]->vht_cap.vht_mcs.rx_mcs_map);
 
 		for (i = 7; i >= 0; i--) {
 			u8 mcs = (rx_mcs_map >> (2 * i)) & 3;
@@ -555,7 +555,7 @@ void ieee80211_sta_set_rx_nss(struct sta_info *sta)
 
 	rx_nss = max(vht_rx_nss, ht_rx_nss);
 	rx_nss = max(he_rx_nss, rx_nss);
-	sta->sta.rx_nss = max_t(u8, 1, rx_nss);
+	sta->sta.link[0]->rx_nss = max_t(u8, 1, rx_nss);
 }
 
 u32 __ieee80211_vht_handle_opmode(struct ieee80211_sub_if_data *sdata,
@@ -575,8 +575,8 @@ u32 __ieee80211_vht_handle_opmode(struct ieee80211_sub_if_data *sdata,
 	nss >>= IEEE80211_OPMODE_NOTIF_RX_NSS_SHIFT;
 	nss += 1;
 
-	if (sta->sta.rx_nss != nss) {
-		sta->sta.rx_nss = nss;
+	if (sta->sta.link[0]->rx_nss != nss) {
+		sta->sta.link[0]->rx_nss = nss;
 		sta_opmode.rx_nss = nss;
 		changed |= IEEE80211_RC_NSS_CHANGED;
 		sta_opmode.changed |= STA_OPMODE_N_SS_CHANGED;
@@ -585,27 +585,27 @@ u32 __ieee80211_vht_handle_opmode(struct ieee80211_sub_if_data *sdata,
 	switch (opmode & IEEE80211_OPMODE_NOTIF_CHANWIDTH_MASK) {
 	case IEEE80211_OPMODE_NOTIF_CHANWIDTH_20MHZ:
 		/* ignore IEEE80211_OPMODE_NOTIF_BW_160_80P80 must not be set */
-		sta->cur_max_bandwidth = IEEE80211_STA_RX_BW_20;
+		sta->link[0]->cur_max_bandwidth = IEEE80211_STA_RX_BW_20;
 		break;
 	case IEEE80211_OPMODE_NOTIF_CHANWIDTH_40MHZ:
 		/* ignore IEEE80211_OPMODE_NOTIF_BW_160_80P80 must not be set */
-		sta->cur_max_bandwidth = IEEE80211_STA_RX_BW_40;
+		sta->link[0]->cur_max_bandwidth = IEEE80211_STA_RX_BW_40;
 		break;
 	case IEEE80211_OPMODE_NOTIF_CHANWIDTH_80MHZ:
 		if (opmode & IEEE80211_OPMODE_NOTIF_BW_160_80P80)
-			sta->cur_max_bandwidth = IEEE80211_STA_RX_BW_160;
+			sta->link[0]->cur_max_bandwidth = IEEE80211_STA_RX_BW_160;
 		else
-			sta->cur_max_bandwidth = IEEE80211_STA_RX_BW_80;
+			sta->link[0]->cur_max_bandwidth = IEEE80211_STA_RX_BW_80;
 		break;
 	case IEEE80211_OPMODE_NOTIF_CHANWIDTH_160MHZ:
 		/* legacy only, no longer used by newer spec */
-		sta->cur_max_bandwidth = IEEE80211_STA_RX_BW_160;
+		sta->link[0]->cur_max_bandwidth = IEEE80211_STA_RX_BW_160;
 		break;
 	}
 
 	new_bw = ieee80211_sta_cur_vht_bw(sta);
-	if (new_bw != sta->sta.bandwidth) {
-		sta->sta.bandwidth = new_bw;
+	if (new_bw != sta->sta.link[0]->bandwidth) {
+		sta->sta.link[0]->bandwidth = new_bw;
 		sta_opmode.bw = ieee80211_sta_rx_bw_to_chan_width(sta);
 		changed |= IEEE80211_RC_BW_CHANGED;
 		sta_opmode.changed |= STA_OPMODE_MAX_BW_CHANGED;
-- 
2.7.4

