Return-Path: <linux-wireless+bounces-6792-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C1E68B146F
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Apr 2024 22:20:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F8881C227CA
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Apr 2024 20:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A704E143C7A;
	Wed, 24 Apr 2024 20:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ebveEbTo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E196D14389F
	for <linux-wireless@vger.kernel.org>; Wed, 24 Apr 2024 20:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713990023; cv=none; b=YeQlsnlk1PrZzpk5jzNxRs8b53aUxON8CM/ByReXiBKNLFnEclqnTLelyNwNfeeQqdh65Oh5M+M8Mb+AuB5rpp5JiI836VPFR0SixafFtyy5B8I6lHFa6EF1uyV7hXDDJ5XNILVJg5t0k5epfPZf2v6F+vPWmelpNHxQbKB+GF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713990023; c=relaxed/simple;
	bh=U+vMbDJXg7S6yPGQT8FsdJx3GjXCotungNvVFLR2TLo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OlxAOIkD7CsKwrMlN/k9+KccR0T3TOaWa3cmgznr51jvrYbuc5iUdjhbv06PlTHM/YDf1nawpvGdTqClY344D/MzMQtcdv7w/CKlj1r2UGJhIDFI31lDWnFLGrH4j+tpjmPVKZaHhxl5X7YB+yNTvNy2PSxmQy1f2/A7DEx6k28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ebveEbTo; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43OIsOZQ028082;
	Wed, 24 Apr 2024 20:20:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=P9CQ0T5GnB6eZTJyhpV4
	ALHRVW+DlDGJ0jFmvcvDCXE=; b=ebveEbToMOfEw2uMfoST3oVqaVCJv9pv/8GJ
	5tXr9cAv8h5I1zAcO3N80gyhb2z2QCsaYDwCYAQZWG+fKqgkAkjErI5ViXVRWfph
	AOE1GTQbctMTOeUrtJtadaxNukALIRrxi5LMtSrguDquB/IgROAH3vXz05TKlGcu
	+CMC1kjYnSH5gbAvpynkRwD+12+MDEy4Or78a9pseCg0DDdD3msdyn9SlZ0Y3KT8
	7P48bhtQe2ShC8UFMPHBja4f8WbB/b+u54pDoBx9WzOesU6auOQWUgtCVNQndIoG
	A2r24UH4wtX3mdIg2K7Ln77HUgI951tFMNn6T5fjQ7BDbzS+XA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xpv9pj3eu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 20:20:14 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43OKKD24002720
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 20:20:13 GMT
Received: from pradeepc2-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 24 Apr 2024 13:20:13 -0700
From: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Pradeep Kumar Chitrapu
	<quic_pradeepc@quicinc.com>,
        P Praneesh <quic_ppranees@quicinc.com>
Subject: [PATCH v3 09/10] wifi: ath12k: add support for 160 MHz bandwidth
Date: Wed, 24 Apr 2024 13:19:58 -0700
Message-ID: <20240424201959.935-10-quic_pradeepc@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240424201959.935-1-quic_pradeepc@quicinc.com>
References: <20240424201959.935-1-quic_pradeepc@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: lCuq9IcuFisgtZ7eKjnncq72l9P4-NSJ
X-Proofpoint-ORIG-GUID: lCuq9IcuFisgtZ7eKjnncq72l9P4-NSJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-24_17,2024-04-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 spamscore=0 mlxscore=0 mlxlogscore=999 clxscore=1015
 adultscore=0 malwarescore=0 bulkscore=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404240101

Add support to configure maximum NSS in 160 MHz bandwidth.
Firmware advertizes support for handling NSS ratio information
as a part of service ready ext event using nss_ratio_enabled
flag. Save this information in ath12k_pdev_cap to calculate
NSS ratio.

Additionally, reorder the code by moving
ath12k_peer_assoc_h_phymode() before ath12k_peer_assoc_h_vht()
to ensure that arg->peer_phymode correctly reflects the bandwidth
in the max NSS calculation.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Co-developed-by: P Praneesh <quic_ppranees@quicinc.com>
Signed-off-by: P Praneesh <quic_ppranees@quicinc.com>
Signed-off-by: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.h |  2 +
 drivers/net/wireless/ath/ath12k/mac.c  | 85 ++++++++++++++++++++++----
 drivers/net/wireless/ath/ath12k/mac.h  |  2 +
 drivers/net/wireless/ath/ath12k/wmi.c  | 19 +++++-
 drivers/net/wireless/ath/ath12k/wmi.h  | 28 +++++++++
 5 files changed, 124 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 47dde4401210..a0375884ab95 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -673,6 +673,8 @@ struct ath12k_pdev_cap {
 	u32 tx_chain_mask_shift;
 	u32 rx_chain_mask_shift;
 	struct ath12k_band_cap band[NUM_NL80211_BANDS];
+	bool nss_ratio_enabled;
+	u8 nss_ratio_info;
 };
 
 struct mlo_timestamp {
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 3ec58b96760c..87830865bec2 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -1799,6 +1799,34 @@ ath12k_peer_assoc_h_vht_limit(u16 tx_mcs_set,
 	return tx_mcs_set;
 }
 
+static u8 ath12k_get_nss_160mhz(struct ath12k *ar,
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
+		ath12k_warn(ar->ab, "WMI_NSS_RATIO_3BY4_NSS not supported\n");
+		break;
+	case WMI_NSS_RATIO_1_NSS:
+		max_sup_nss = max_nss;
+		break;
+	case WMI_NSS_RATIO_2_NSS:
+		ath12k_warn(ar->ab, "WMI_NSS_RATIO_2_NSS not supported\n");
+		break;
+	default:
+		ath12k_warn(ar->ab, "invalid nss ratio received from fw: %d\n",
+			    nss_ratio_info);
+		break;
+	}
+
+	return max_sup_nss;
+}
+
 static void ath12k_peer_assoc_h_vht(struct ath12k *ar,
 				    struct ieee80211_vif *vif,
 				    struct ieee80211_sta *sta,
@@ -1814,6 +1842,7 @@ static void ath12k_peer_assoc_h_vht(struct ath12k *ar,
 	u8 max_nss, vht_mcs;
 	int i, vht_nss, nss_idx;
 	bool user_rate_valid = true;
+	u32 rx_nss, tx_nss, nss_160;
 
 	if (WARN_ON(ath12k_mac_vif_chan(vif, &def)))
 		return;
@@ -1908,10 +1937,24 @@ static void ath12k_peer_assoc_h_vht(struct ath12k *ar,
 	/* TODO:  Check */
 	arg->tx_max_mcs_nss = 0xFF;
 
-	ath12k_dbg(ar->ab, ATH12K_DBG_MAC, "mac vht peer %pM max_mpdu %d flags 0x%x\n",
-		   sta->addr, arg->peer_max_mpdu, arg->peer_flags);
+	if (arg->peer_phymode == MODE_11AC_VHT160) {
+		tx_nss = ath12k_get_nss_160mhz(ar, max_nss);
+		rx_nss = min(arg->peer_nss, tx_nss);
+		arg->peer_bw_rxnss_override = ATH12K_BW_NSS_MAP_ENABLE;
 
-	/* TODO: rxnss_override */
+		if (!rx_nss) {
+			ath12k_warn(ar->ab, "invalid max_nss\n");
+			return;
+		}
+
+		nss_160 = u32_encode_bits(rx_nss - 1, ATH12K_PEER_RX_NSS_160MHZ);
+		arg->peer_bw_rxnss_override |= nss_160;
+	}
+
+	ath12k_dbg(ar->ab, ATH12K_DBG_MAC,
+		   "mac vht peer %pM max_mpdu %d flags 0x%x nss_override 0x%x\n",
+		   sta->addr, arg->peer_max_mpdu, arg->peer_flags,
+		   arg->peer_bw_rxnss_override);
 }
 
 static int ath12k_mac_get_max_he_mcs_map(u16 mcs_map, int nss)
@@ -1998,6 +2041,7 @@ static void ath12k_peer_assoc_h_he(struct ath12k *ar,
 	u16 he_tx_mcs = 0, v = 0;
 	int he_nss, nss_idx;
 	bool user_rate_valid = true;
+	u32 rx_nss, tx_nss, nss_160;
 
 	if (WARN_ON(ath12k_mac_vif_chan(vif, &def)))
 		return;
@@ -2177,11 +2221,28 @@ static void ath12k_peer_assoc_h_he(struct ath12k *ar,
 		    he_mcs_mask[i])
 			max_nss = i + 1;
 	}
+	max_nss = min(max_nss, ar->num_tx_chains);
 	arg->peer_nss = min(sta->deflink.rx_nss, max_nss);
 
+	if (arg->peer_phymode == MODE_11AX_HE160) {
+		tx_nss = ath12k_get_nss_160mhz(ar, max_nss);
+		rx_nss = min(arg->peer_nss, tx_nss);
+		arg->peer_bw_rxnss_override = ATH12K_BW_NSS_MAP_ENABLE;
+
+		if (!rx_nss) {
+			ath12k_warn(ar->ab, "invalid max_nss\n");
+			return;
+		}
+
+		nss_160 = u32_encode_bits(rx_nss - 1, ATH12K_PEER_RX_NSS_160MHZ);
+		arg->peer_bw_rxnss_override |= nss_160;
+	}
+
 	ath12k_dbg(ar->ab, ATH12K_DBG_MAC,
-		   "mac he peer %pM nss %d mcs cnt %d\n",
-		   sta->deflink.addr, arg->peer_nss, arg->peer_he_mcs_count);
+		   "mac he peer %pM nss %d mcs cnt %d nss_override 0x%x\n",
+		   sta->deflink.addr, arg->peer_nss,
+		   arg->peer_he_mcs_count,
+		   arg->peer_bw_rxnss_override);
 }
 
 static void ath12k_peer_assoc_h_smps(struct ieee80211_sta *sta,
@@ -2642,12 +2703,12 @@ static void ath12k_peer_assoc_prepare(struct ath12k *ar,
 	ath12k_peer_assoc_h_basic(ar, vif, sta, arg);
 	ath12k_peer_assoc_h_crypto(ar, vif, sta, arg);
 	ath12k_peer_assoc_h_rates(ar, vif, sta, arg);
+	ath12k_peer_assoc_h_phymode(ar, vif, sta, arg);
 	ath12k_peer_assoc_h_ht(ar, vif, sta, arg);
 	ath12k_peer_assoc_h_vht(ar, vif, sta, arg);
 	ath12k_peer_assoc_h_he(ar, vif, sta, arg);
 	ath12k_peer_assoc_h_eht(ar, vif, sta, arg);
 	ath12k_peer_assoc_h_qos(ar, vif, sta, arg);
-	ath12k_peer_assoc_h_phymode(ar, vif, sta, arg);
 	ath12k_peer_assoc_h_smps(sta, arg);
 
 	/* TODO: amsdu_disable req? */
@@ -5192,10 +5253,8 @@ ath12k_create_vht_cap(struct ath12k *ar, u32 rate_cap_tx_chainmask,
 
 	ath12k_set_vht_txbf_cap(ar, &vht_cap.cap);
 
-	/* TODO: Enable back VHT160 mode once association issues are fixed */
-	/* Disabling VHT160 and VHT80+80 modes */
-	vht_cap.cap &= ~IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_MASK;
-	vht_cap.cap &= ~IEEE80211_VHT_CAP_SHORT_GI_160;
+	/* 80P80 is not supported */
+	vht_cap.cap &= ~IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_160_80PLUS80MHZ;
 
 	rxmcs_map = 0;
 	txmcs_map = 0;
@@ -9075,7 +9134,8 @@ static int ath12k_mac_setup_iface_combinations(struct ath12k_hw *ah)
 	combinations[0].radar_detect_widths = BIT(NL80211_CHAN_WIDTH_20_NOHT) |
 						BIT(NL80211_CHAN_WIDTH_20) |
 						BIT(NL80211_CHAN_WIDTH_40) |
-						BIT(NL80211_CHAN_WIDTH_80);
+						BIT(NL80211_CHAN_WIDTH_80) |
+						BIT(NL80211_CHAN_WIDTH_160);
 
 	wiphy->iface_combinations = combinations;
 	wiphy->n_iface_combinations = 1;
@@ -9282,6 +9342,9 @@ static int ath12k_mac_hw_register(struct ath12k_hw *ah)
 	ieee80211_hw_set(hw, SUPPORTS_TX_FRAG);
 	ieee80211_hw_set(hw, REPORTS_LOW_ACK);
 
+	if (cap->nss_ratio_enabled)
+		ieee80211_hw_set(hw, SUPPORTS_VHT_EXT_NSS_BW);
+
 	if (ht_cap & WMI_HT_CAP_ENABLED) {
 		ieee80211_hw_set(hw, AMPDU_AGGREGATION);
 		ieee80211_hw_set(hw, TX_AMPDU_SETUP_IN_HW);
diff --git a/drivers/net/wireless/ath/ath12k/mac.h b/drivers/net/wireless/ath/ath12k/mac.h
index e5193a44f344..ced73bb99169 100644
--- a/drivers/net/wireless/ath/ath12k/mac.h
+++ b/drivers/net/wireless/ath/ath12k/mac.h
@@ -36,6 +36,8 @@ struct ath12k_generic_iter {
 #define IEEE80211_DISABLE_VHT_MCS_SUPPORT_0_11	BIT(24)
 
 #define ATH12K_CHAN_WIDTH_NUM			14
+#define ATH12K_BW_NSS_MAP_ENABLE		BIT(31)
+#define ATH12K_PEER_RX_NSS_160MHZ		GENMASK(2, 0)
 
 #define ATH12K_TX_POWER_MAX_VAL	70
 #define ATH12K_TX_POWER_MIN_VAL	0
diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index c64d1085dfe8..414c4f8829ec 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -519,6 +519,10 @@ ath12k_pull_mac_phy_cap_svc_ready_ext(struct ath12k_wmi_pdev *wmi_handle,
 		pdev_cap->he_mcs = le32_to_cpu(mac_caps->he_supp_mcs_5g);
 		pdev_cap->tx_chain_mask = le32_to_cpu(mac_caps->tx_chain_mask_5g);
 		pdev_cap->rx_chain_mask = le32_to_cpu(mac_caps->rx_chain_mask_5g);
+		pdev_cap->nss_ratio_enabled =
+			WMI_NSS_RATIO_EN_DIS_GET(mac_caps->nss_ratio);
+		pdev_cap->nss_ratio_info =
+			WMI_NSS_RATIO_INFO_GET(mac_caps->nss_ratio);
 	} else {
 		return -EINVAL;
 	}
@@ -974,11 +978,24 @@ int ath12k_wmi_vdev_down(struct ath12k *ar, u8 vdev_id)
 static void ath12k_wmi_put_wmi_channel(struct ath12k_wmi_channel_params *chan,
 				       struct wmi_vdev_start_req_arg *arg)
 {
+	u32 center_freq1 = arg->band_center_freq1;
+
 	memset(chan, 0, sizeof(*chan));
 
 	chan->mhz = cpu_to_le32(arg->freq);
 	chan->band_center_freq1 = cpu_to_le32(arg->band_center_freq1);
-	chan->band_center_freq2 = 0;
+	if (arg->mode == MODE_11AX_HE160) {
+		if (arg->freq > center_freq1)
+			chan->band_center_freq1 =
+					cpu_to_le32(center_freq1 + 40);
+		else
+			chan->band_center_freq1 =
+					cpu_to_le32(center_freq1 - 40);
+
+		chan->band_center_freq2 = cpu_to_le32(arg->band_center_freq1);
+	} else {
+		chan->band_center_freq2 = 0;
+	}
 
 	chan->info |= le32_encode_bits(arg->mode, WMI_CHAN_INFO_MODE);
 	if (arg->passive)
diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
index 49f485477d41..d5eb5982af47 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -2262,6 +2262,21 @@ enum wmi_direct_buffer_module {
 	WMI_DIRECT_BUF_MAX
 };
 
+/**
+ * enum wmi_nss_ratio - NSS ratio received from FW during service ready ext event
+ * @WMI_NSS_RATIO_1BY2_NSS: Max nss of 160MHz is equals to half of the max nss of 80MHz
+ * @WMI_NSS_RATIO_3BY4_NSS: Max nss of 160MHz is equals to 3/4 of the max nss of 80MHz
+ * @WMI_NSS_RATIO_1_NSS: Max nss of 160MHz is equals to the max nss of 80MHz
+ * @WMI_NSS_RATIO_2_NSS: Max nss of 160MHz is equals to two times the max nss of 80MHz
+ */
+
+enum wmi_nss_ratio {
+	WMI_NSS_RATIO_1BY2_NSS,
+	WMI_NSS_RATIO_3BY4_NSS,
+	WMI_NSS_RATIO_1_NSS,
+	WMI_NSS_RATIO_2_NSS
+};
+
 struct ath12k_wmi_pdev_band_arg {
 	u32 pdev_id;
 	u32 start_freq;
@@ -2568,6 +2583,12 @@ struct ath12k_wmi_hw_mode_cap_params {
 } __packed;
 
 #define WMI_MAX_HECAP_PHY_SIZE                 (3)
+#define WMI_NSS_RATIO_EN_DIS_BITPOS    BIT(0)
+#define WMI_NSS_RATIO_EN_DIS_GET(_val) \
+	le32_get_bits(_val, WMI_NSS_RATIO_EN_DIS_BITPOS)
+#define WMI_NSS_RATIO_INFO_BITPOS              GENMASK(4, 1)
+#define WMI_NSS_RATIO_INFO_GET(_val) \
+	le32_get_bits(_val, WMI_NSS_RATIO_INFO_BITPOS)
 
 /* pdev_id is present in lower 16 bits of pdev_and_hw_link_ids in
  * ath12k_wmi_mac_phy_caps_params & ath12k_wmi_caps_ext_params.
@@ -2609,6 +2630,13 @@ struct ath12k_wmi_mac_phy_caps_params {
 	__le32 he_cap_info_2g_ext;
 	__le32 he_cap_info_5g_ext;
 	__le32 he_cap_info_internal;
+	__le32 wireless_modes;
+	__le32 low_2ghz_chan_freq;
+	__le32 high_2ghz_chan_freq;
+	__le32 low_5ghz_chan_freq;
+	__le32 high_5ghz_chan_freq;
+	__le32 nss_ratio;
+
 } __packed;
 
 struct ath12k_wmi_hal_reg_caps_ext_params {
-- 
2.17.1


