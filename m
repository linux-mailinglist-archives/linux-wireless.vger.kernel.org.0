Return-Path: <linux-wireless+bounces-21738-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23046A93C38
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Apr 2025 19:49:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FA0E920277
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Apr 2025 17:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CFBA21CA00;
	Fri, 18 Apr 2025 17:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ezm4rmXp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A139B21C9F0
	for <linux-wireless@vger.kernel.org>; Fri, 18 Apr 2025 17:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744998537; cv=none; b=UOzlJcZDKMos4m1EXFTlMqgj9McMEEVbLJj39Aun8LLoVU2hwPwPIaGFnY+EAJcTdeOaOWvx/YvKH+uh14jkjIhgfrFVjhYZeDgcA0w25y2g7NgkBPt1gf7/LJ8HJnlO5ypPdGRQb6+mV+3HWJXpAFNT71NrKy7M6H/ln5qdz0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744998537; c=relaxed/simple;
	bh=4OGI4dGhSSCMwiLAVgF4iexh5itgHHy45PHr+3iko+c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XCKR2xvyI0KMxJtb7kZp03pfUFzl0GPkJltaU5wAJljz+6m7VpKDkmfL8STILt9f+E+MwVhvYsgUcdpLZdMHRM1kH/MsUTNyOJsVlmec1sq2QT28SKEjHPXZaXNUfFJcEuH/qjYCSNVEFkTY8so5wCmz+FXLSLJe99raiiWa7l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ezm4rmXp; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53IDwmcK022785;
	Fri, 18 Apr 2025 17:48:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fhXlsF2eyymP14qzD89jIysCfqmh4TTCDvVKcbZdiMw=; b=ezm4rmXpvBHnFQ6V
	WgRLNTG8HhnWuvUy7B8bMoSqZ7/fUvhUBIz9yNaeqquWgOQ9vDSOTb3dfNjbdfY/
	892IqF58YWwoBfqz0BvxKINO7Q2VImued3eIWrw0StVar3Hy2b2ggU5GKrUU1tWg
	uKas7sURax5IK+hmYAQNnnVY7sVU/8obDM1F+TSRbKDFA3D31vu1EfO/Zq6BNaRj
	8iiIt/IldDotXVygYZ4eejinQwBiGiByD99HFqgExrMjUJy/nnhOVtUMNxeDoiWi
	f6gC54hb5E0WbJgxB0qxEm3zuqWuGpojYaZENc8A2zTqNweRaEnaR3IzDAVFJZe1
	LBSwqg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45yhbq2bc5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Apr 2025 17:48:46 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53IHmkDe028435
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Apr 2025 17:48:46 GMT
Received: from ath12k-linux1.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 18 Apr 2025 10:48:45 -0700
From: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Pradeep Kumar Chitrapu
	<quic_pradeepc@quicinc.com>,
        P Praneesh <quic_ppranees@quicinc.com>,
        "Jeff
 Johnson" <quic_jjohnson@quicinc.com>
Subject: [PATCH V13 8/9] wifi: ath12k: add support for 160 MHz bandwidth
Date: Fri, 18 Apr 2025 10:48:17 -0700
Message-ID: <20250418174818.3336510-9-quic_pradeepc@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250418174818.3336510-1-quic_pradeepc@quicinc.com>
References: <20250418174818.3336510-1-quic_pradeepc@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: I8WEHKM6HjIZvT8UMylltPC-9SLx97mS
X-Proofpoint-GUID: I8WEHKM6HjIZvT8UMylltPC-9SLx97mS
X-Authority-Analysis: v=2.4 cv=I+plRMgg c=1 sm=1 tr=0 ts=6802907e cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=dOJm2eNAaUnF9U8lSB4A:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-18_06,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 phishscore=0 adultscore=0 priorityscore=1501 mlxscore=0 lowpriorityscore=0
 bulkscore=0 mlxlogscore=999 clxscore=1015 impostorscore=0 malwarescore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504180133

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
 drivers/net/wireless/ath/ath12k/wmi.c  |  7 +-
 drivers/net/wireless/ath/ath12k/wmi.h  | 28 ++++++++
 5 files changed, 114 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 4b8f434e3e9a..d2b79180a534 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -841,6 +841,8 @@ struct ath12k_pdev_cap {
 	struct ath12k_band_cap band[NUM_NL80211_BANDS];
 	u32 eml_cap;
 	u32 mld_cap;
+	bool nss_ratio_enabled;
+	u8 nss_ratio_info;
 };
 
 struct mlo_timestamp {
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index e7c15a3c4c80..ecd47f15ef95 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -2167,6 +2167,34 @@ ath12k_peer_assoc_h_vht_limit(u16 tx_mcs_set,
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
@@ -2184,6 +2212,7 @@ static void ath12k_peer_assoc_h_vht(struct ath12k *ar,
 	u8 max_nss, vht_mcs;
 	int i, vht_nss, nss_idx;
 	bool user_rate_valid = true;
+	u32 rx_nss, tx_nss, nss_160;
 
 	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
 
@@ -2288,10 +2317,24 @@ static void ath12k_peer_assoc_h_vht(struct ath12k *ar,
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
@@ -2384,6 +2427,7 @@ static void ath12k_peer_assoc_h_he(struct ath12k *ar,
 	u16 he_tx_mcs = 0, v = 0;
 	int he_nss, nss_idx;
 	bool user_rate_valid = true;
+	u32 rx_nss, tx_nss, nss_160;
 
 	if (WARN_ON(ath12k_mac_vif_link_chan(vif, link_id, &def)))
 		return;
@@ -2578,10 +2622,27 @@ static void ath12k_peer_assoc_h_he(struct ath12k *ar,
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
@@ -2822,11 +2883,12 @@ static enum wmi_phy_mode ath12k_mac_get_phymode_vht(struct ath12k *ar,
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
@@ -6983,10 +7045,8 @@ ath12k_create_vht_cap(struct ath12k *ar, u32 rate_cap_tx_chainmask,
 
 	ath12k_set_vht_txbf_cap(ar, &vht_cap.cap);
 
-	/* TODO: Enable back VHT160 mode once association issues are fixed */
-	/* Disabling VHT160 and VHT80+80 modes */
-	vht_cap.cap &= ~IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_MASK;
-	vht_cap.cap &= ~IEEE80211_VHT_CAP_SHORT_GI_160;
+	/* 80P80 is not supported */
+	vht_cap.cap &= ~IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_160_80PLUS80MHZ;
 
 	rxmcs_map = 0;
 	txmcs_map = 0;
@@ -11808,7 +11868,8 @@ ath12k_mac_setup_radio_iface_comb(struct ath12k *ar,
 		comb[0].radar_detect_widths = BIT(NL80211_CHAN_WIDTH_20_NOHT) |
 						BIT(NL80211_CHAN_WIDTH_20) |
 						BIT(NL80211_CHAN_WIDTH_40) |
-						BIT(NL80211_CHAN_WIDTH_80);
+						BIT(NL80211_CHAN_WIDTH_80) |
+						BIT(NL80211_CHAN_WIDTH_160);
 	}
 
 	return 0;
@@ -12184,6 +12245,9 @@ static int ath12k_mac_hw_register(struct ath12k_hw *ah)
 	ieee80211_hw_set(hw, REPORTS_LOW_ACK);
 	ieee80211_hw_set(hw, NO_VIRTUAL_MONITOR);
 
+	if (cap->nss_ratio_enabled)
+		ieee80211_hw_set(hw, SUPPORTS_VHT_EXT_NSS_BW);
+
 	if ((ht_cap & WMI_HT_CAP_ENABLED) || is_6ghz) {
 		ieee80211_hw_set(hw, AMPDU_AGGREGATION);
 		ieee80211_hw_set(hw, TX_AMPDU_SETUP_IN_HW);
diff --git a/drivers/net/wireless/ath/ath12k/mac.h b/drivers/net/wireless/ath/ath12k/mac.h
index 3ddfa00a5a17..e625740e57f3 100644
--- a/drivers/net/wireless/ath/ath12k/mac.h
+++ b/drivers/net/wireless/ath/ath12k/mac.h
@@ -41,6 +41,8 @@ struct ath12k_generic_iter {
 #define IEEE80211_DISABLE_VHT_MCS_SUPPORT_0_11	BIT(24)
 
 #define ATH12K_CHAN_WIDTH_NUM			14
+#define ATH12K_BW_NSS_MAP_ENABLE		BIT(31)
+#define ATH12K_PEER_RX_NSS_160MHZ		GENMASK(2, 0)
 
 #define ATH12K_TX_POWER_MAX_VAL	70
 #define ATH12K_TX_POWER_MIN_VAL	0
diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index a74a1549143b..ee837a66f6ac 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -532,6 +532,10 @@ ath12k_pull_mac_phy_cap_svc_ready_ext(struct ath12k_wmi_pdev *wmi_handle,
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
@@ -1054,7 +1058,8 @@ static void ath12k_wmi_put_wmi_channel(struct ath12k_wmi_channel_params *chan,
 
 		chan->band_center_freq2 = cpu_to_le32(center_freq1);
 
-	} else if (arg->mode == MODE_11BE_EHT160) {
+	} else if (arg->mode == MODE_11BE_EHT160 ||
+		   arg->mode == MODE_11AX_HE160) {
 		if (arg->freq > center_freq1)
 			chan->band_center_freq1 = cpu_to_le32(center_freq1 + 40);
 		else
diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
index 6747ca60b7fa..e53eb69285d0 100644
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
@@ -2623,6 +2638,12 @@ struct ath12k_wmi_hw_mode_cap_params {
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
@@ -2664,6 +2685,13 @@ struct ath12k_wmi_mac_phy_caps_params {
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


