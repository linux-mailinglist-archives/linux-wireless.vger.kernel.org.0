Return-Path: <linux-wireless+bounces-18875-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79BD3A33492
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Feb 2025 02:25:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4B45188A182
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Feb 2025 01:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBC2114037F;
	Thu, 13 Feb 2025 01:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="QKX1Pmgh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAEB4132103
	for <linux-wireless@vger.kernel.org>; Thu, 13 Feb 2025 01:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739409900; cv=none; b=CFenBzGvkmJaOjlETN4OXJBYIfwYBG/lA/ijq2FlSC3Y69C1EpIwGfOfFG+9z0FgPhzV/JmUShwsZjccUOq6scQ+FwbINa/HjoF1NKKj4GQo2qdjIa80dU08jmPxzlPTyWkkZZWdeqZYjTd9mclZngwKp+aFLegWmGd/mI4EdgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739409900; c=relaxed/simple;
	bh=kgxWmVpfemYvQ+wAHRzMyVbObhxiYegX0eXkrfGpnY0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qsaBwaCy3x9bi0mtnjBQu/8EvOgbJP+ynPaZz2sHjOPVPz2Skx0naHT7sPivM/GzFeLF6unQ8VcLKRQfQEBcyTwO1lrRODfHf21qiD/WYgZC7zNdnPcnV4oDAtHQ0MvkjayBEIfxzj+z9fTYJ55X3/SGHm8Qwn494c9/60DuWaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=QKX1Pmgh; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51CC8Eht010537;
	Thu, 13 Feb 2025 01:24:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	S+K6PDXArFISkdrH0F4YPr4xJVaXvbojEaUjJjYwjrA=; b=QKX1Pmghy43F5eMB
	48orblcKIQdoypm317FTJbrixlFYeWKHa2NZAqGAs1dwBFiBWAnh0Uj1cUJIoSer
	TKX+uJqpuoDBlVeRZsd8hk8SiZwhjyfnYa4FpZLMI+FNVhftJJUO4y4QECMP0qyU
	3KFM9FLcg+zBBmR7gO12c5XAMVCIX2C1EsAr/Ij5D3Bdyo7NBIzPAcz4nKKD6egL
	flX08lX5ETY6TSDb9AYOxSirZKO8LnYv8BbCibvPzj9Vz/jbuU4R/UMww0G+KFO2
	6iGAc0+QUzGmi7cmUETFG9Dxs7Tbh1PAQ/EGsrp89aVnaPqb+m0htfYm4GlxJU+K
	BaowfQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44qcs5hjag-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Feb 2025 01:24:55 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51D1Osxs005956
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Feb 2025 01:24:54 GMT
Received: from ath12k-linux1.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 12 Feb 2025 17:24:53 -0800
From: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Pradeep Kumar Chitrapu
	<quic_pradeepc@quicinc.com>,
        P Praneesh <quic_ppranees@quicinc.com>,
        "Jeff
 Johnson" <quic_jjohnson@quicinc.com>
Subject: [PATCH V10 8/9] wifi: ath12k: add support for 160 MHz bandwidth
Date: Wed, 12 Feb 2025 17:24:38 -0800
Message-ID: <20250213012439.278373-9-quic_pradeepc@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250213012439.278373-1-quic_pradeepc@quicinc.com>
References: <20250213012439.278373-1-quic_pradeepc@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: DmmbD73vkIQ6MkTLoxupK0EUveri0R3o
X-Proofpoint-GUID: DmmbD73vkIQ6MkTLoxupK0EUveri0R3o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-12_08,2025-02-11_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 mlxlogscore=999 phishscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 adultscore=0 clxscore=1015 mlxscore=0 priorityscore=1501 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2502130007

Add support to configure maximum NSS in 160 MHz bandwidth.
Firmware advertises support for handling NSS ratio information
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
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.h |  2 +
 drivers/net/wireless/ath/ath12k/mac.c  | 88 ++++++++++++++++++++++----
 drivers/net/wireless/ath/ath12k/mac.h  |  2 +
 drivers/net/wireless/ath/ath12k/wmi.c  | 19 +++++-
 drivers/net/wireless/ath/ath12k/wmi.h  | 28 ++++++++
 5 files changed, 126 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 3fac4f00d383..894972725e8a 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -800,6 +800,8 @@ struct ath12k_pdev_cap {
 	struct ath12k_band_cap band[NUM_NL80211_BANDS];
 	u32 eml_cap;
 	u32 mld_cap;
+	bool nss_ratio_enabled;
+	u8 nss_ratio_info;
 };
 
 struct mlo_timestamp {
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index a8cfa498fab6..047042662197 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -2271,6 +2271,34 @@ ath12k_peer_assoc_h_vht_limit(u16 tx_mcs_set,
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
 				    struct ath12k_link_vif *arvif,
 				    struct ath12k_link_sta *arsta,
@@ -2288,6 +2316,7 @@ static void ath12k_peer_assoc_h_vht(struct ath12k *ar,
 	u8 max_nss, vht_mcs;
 	int i, vht_nss, nss_idx;
 	bool user_rate_valid = true;
+	u32 rx_nss, tx_nss, nss_160;
 
 	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
 
@@ -2392,10 +2421,24 @@ static void ath12k_peer_assoc_h_vht(struct ath12k *ar,
 	/* TODO:  Check */
 	arg->tx_max_mcs_nss = 0xFF;
 
-	ath12k_dbg(ar->ab, ATH12K_DBG_MAC, "mac vht peer %pM max_mpdu %d flags 0x%x\n",
-		   arsta->addr, arg->peer_max_mpdu, arg->peer_flags);
+	if (arg->peer_phymode == MODE_11AC_VHT160) {
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
 
-	/* TODO: rxnss_override */
+	ath12k_dbg(ar->ab, ATH12K_DBG_MAC,
+		   "mac vht peer %pM max_mpdu %d flags 0x%x nss_override 0x%x\n",
+		   arsta->addr, arg->peer_max_mpdu, arg->peer_flags,
+		   arg->peer_bw_rxnss_override);
 }
 
 static int ath12k_mac_get_max_he_mcs_map(u16 mcs_map, int nss)
@@ -2488,6 +2531,7 @@ static void ath12k_peer_assoc_h_he(struct ath12k *ar,
 	u16 he_tx_mcs = 0, v = 0;
 	int he_nss, nss_idx;
 	bool user_rate_valid = true;
+	u32 rx_nss, tx_nss, nss_160;
 
 	if (WARN_ON(ath12k_mac_vif_link_chan(vif, link_id, &def)))
 		return;
@@ -2682,10 +2726,27 @@ static void ath12k_peer_assoc_h_he(struct ath12k *ar,
 			max_nss = i + 1;
 	}
 	arg->peer_nss = min(link_sta->rx_nss, max_nss);
+	max_nss = min(max_nss, ar->num_tx_chains);
+
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
 
 	ath12k_dbg(ar->ab, ATH12K_DBG_MAC,
-		   "mac he peer %pM nss %d mcs cnt %d\n",
-		   arsta->addr, arg->peer_nss, arg->peer_he_mcs_count);
+		   "mac he peer %pM nss %d mcs cnt %d nss_override 0x%x\n",
+		   arsta->addr, arg->peer_nss,
+		   arg->peer_he_mcs_count,
+		   arg->peer_bw_rxnss_override);
 }
 
 static void ath12k_peer_assoc_h_he_6ghz(struct ath12k *ar,
@@ -2926,11 +2987,12 @@ static enum wmi_phy_mode ath12k_mac_get_phymode_vht(struct ath12k *ar,
 						    struct ieee80211_link_sta *link_sta)
 {
 	if (link_sta->bandwidth == IEEE80211_STA_RX_BW_160) {
-		if (link_sta->vht_cap.cap & IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_160MHZ)
+		if (link_sta->vht_cap.cap & (IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_160MHZ |
+		    IEEE80211_VHT_CAP_EXT_NSS_BW_MASK))
 			return MODE_11AC_VHT160;
 
 		/* not sure if this is a valid case? */
-		return MODE_11AC_VHT160;
+		return MODE_UNKNOWN;
 	}
 
 	if (link_sta->bandwidth == IEEE80211_STA_RX_BW_80)
@@ -6873,10 +6935,8 @@ ath12k_create_vht_cap(struct ath12k *ar, u32 rate_cap_tx_chainmask,
 
 	ath12k_set_vht_txbf_cap(ar, &vht_cap.cap);
 
-	/* TODO: Enable back VHT160 mode once association issues are fixed */
-	/* Disabling VHT160 and VHT80+80 modes */
-	vht_cap.cap &= ~IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_MASK;
-	vht_cap.cap &= ~IEEE80211_VHT_CAP_SHORT_GI_160;
+	/* 80P80 is not supported */
+	vht_cap.cap &= ~IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_160_80PLUS80MHZ;
 
 	rxmcs_map = 0;
 	txmcs_map = 0;
@@ -11515,7 +11575,8 @@ ath12k_mac_setup_radio_iface_comb(struct ath12k *ar,
 	comb[0].radar_detect_widths = BIT(NL80211_CHAN_WIDTH_20_NOHT) |
 					BIT(NL80211_CHAN_WIDTH_20) |
 					BIT(NL80211_CHAN_WIDTH_40) |
-					BIT(NL80211_CHAN_WIDTH_80);
+					BIT(NL80211_CHAN_WIDTH_80) |
+					BIT(NL80211_CHAN_WIDTH_160);
 
 	return 0;
 }
@@ -11889,6 +11950,9 @@ static int ath12k_mac_hw_register(struct ath12k_hw *ah)
 	ieee80211_hw_set(hw, SUPPORTS_TX_FRAG);
 	ieee80211_hw_set(hw, REPORTS_LOW_ACK);
 
+	if (cap->nss_ratio_enabled)
+		ieee80211_hw_set(hw, SUPPORTS_VHT_EXT_NSS_BW);
+
 	if ((ht_cap & WMI_HT_CAP_ENABLED) || is_6ghz) {
 		ieee80211_hw_set(hw, AMPDU_AGGREGATION);
 		ieee80211_hw_set(hw, TX_AMPDU_SETUP_IN_HW);
diff --git a/drivers/net/wireless/ath/ath12k/mac.h b/drivers/net/wireless/ath/ath12k/mac.h
index d54b7e39dc6b..16badb1e2b99 100644
--- a/drivers/net/wireless/ath/ath12k/mac.h
+++ b/drivers/net/wireless/ath/ath12k/mac.h
@@ -38,6 +38,8 @@ struct ath12k_generic_iter {
 #define IEEE80211_DISABLE_VHT_MCS_SUPPORT_0_11	BIT(24)
 
 #define ATH12K_CHAN_WIDTH_NUM			14
+#define ATH12K_BW_NSS_MAP_ENABLE		BIT(31)
+#define ATH12K_PEER_RX_NSS_160MHZ		GENMASK(2, 0)
 
 #define ATH12K_TX_POWER_MAX_VAL	70
 #define ATH12K_TX_POWER_MIN_VAL	0
diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index 86dee5fecf4b..013099705174 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -529,6 +529,10 @@ ath12k_pull_mac_phy_cap_svc_ready_ext(struct ath12k_wmi_pdev *wmi_handle,
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
@@ -1037,11 +1041,24 @@ int ath12k_wmi_vdev_down(struct ath12k *ar, u8 vdev_id)
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
index aa7fe4234695..c989a6fa4568 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -2306,6 +2306,21 @@ enum wmi_direct_buffer_module {
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
@@ -2622,6 +2637,12 @@ struct ath12k_wmi_hw_mode_cap_params {
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
@@ -2663,6 +2684,13 @@ struct ath12k_wmi_mac_phy_caps_params {
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
2.34.1


