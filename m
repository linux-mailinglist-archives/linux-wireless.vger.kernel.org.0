Return-Path: <linux-wireless+bounces-18878-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D77BA33495
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Feb 2025 02:25:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1F42188A1A1
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Feb 2025 01:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 571F9142E77;
	Thu, 13 Feb 2025 01:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="cVBOLgNj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81318634D
	for <linux-wireless@vger.kernel.org>; Thu, 13 Feb 2025 01:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739409901; cv=none; b=Tt7GsCE/UgdnLb5OQ1Och63+2j0HL61cfr4X8xRiQlfkdzDFNHGIuoeFl1/Sqiab0ykrZVzD4aHP3QlO6xQpoMeygIcikwu7mv8nUVdbIKGqKRQi0nkGqM6jkjHl4o8k8zwquB/7tHFuKN0L89gkS3NZV0+tGq318oj30A23/wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739409901; c=relaxed/simple;
	bh=UJCvfvbgCA+l+39V8bnH6n1zNBjGD3tMuszx6NfxMrQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a/hPdNb05L9E8K9l1AYsUFiah6eu/TmgsW9fv6s8mazqXN2OtR90xtx8PrnamvRnp3uSRmhu4Hu2tMaKQCc+olkqiAw88eX1iw7AWYaj4C8racQHNDGVJmppnxrKtZ9sZdJJsOZTLGt0l2fS/dC7sZdTnbzU447kS2rq3XMwPKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=cVBOLgNj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51CJWaAV026330;
	Thu, 13 Feb 2025 01:24:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WsZyCo0WNxMjfLD81RaRXSxZnrwnG/cNz3J0nVh7uUU=; b=cVBOLgNjBZqnSrjH
	2kJci7c6JOtPq4yYirzQiYsow5/21gcbkpUdxI3Gn4uDL4BLUNdKHV4LDBpyOZXp
	G7Wqp3+FZFfFJmwwFeGbfg45qQLgCHSW/kzcZ6rNgbFOsmgvHeOo+ZbjGFnFUoFk
	WKDcepoTREVi8mj32UanCy4RRSmaeTzT1eacL6S7VWFYQSLV5cvngkRj6C+6aj97
	DZH1sIMq4yi+ZkVsmOEWHqCWYu3CvXMSKeqxZJuZUjpTOliQAjt/fD3PKrAVoY51
	n3UI8EBEEUuB93pae6yaky/SKcWWuHHzre8zFAcMhoMi+64V+fuws4HUnQpAfzxy
	ylp7yA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44r5j5dfgw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Feb 2025 01:24:54 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51D1OrFf017415
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Feb 2025 01:24:53 GMT
Received: from ath12k-linux1.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 12 Feb 2025 17:24:53 -0800
From: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Pradeep Kumar Chitrapu
	<quic_pradeepc@quicinc.com>,
        Muna Sinada <quic_msinada@quicinc.com>
Subject: [PATCH V10 6/9] wifi: ath12k: add support for setting fixed HE rate/GI/LTF
Date: Wed, 12 Feb 2025 17:24:36 -0800
Message-ID: <20250213012439.278373-7-quic_pradeepc@quicinc.com>
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
X-Proofpoint-ORIG-GUID: -KgwZnoimmpsr7oxo1TWEAX2hJPMOC4Q
X-Proofpoint-GUID: -KgwZnoimmpsr7oxo1TWEAX2hJPMOC4Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-12_08,2025-02-11_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 mlxscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 phishscore=0 adultscore=0 spamscore=0 clxscore=1015 impostorscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502130008

Add support to set fixed HE rate/GI/LTF values using nl80211.
Reuse parts of the existing code path already used for HT/VHT
to implement the new helpers symmetrically, similar to how
HT/VHT is handled.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Co-developed-by: Muna Sinada <quic_msinada@quicinc.com>
Signed-off-by: Muna Sinada <quic_msinada@quicinc.com>
Signed-off-by: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 646 +++++++++++++++++++++++---
 drivers/net/wireless/ath/ath12k/wmi.h |  27 ++
 2 files changed, 621 insertions(+), 52 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 8e25f5449390..6dff8228a670 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -520,6 +520,18 @@ ath12k_mac_max_vht_nss(const u16 *vht_mcs_mask)
 	return 1;
 }
 
+static u32
+ath12k_mac_max_he_nss(const u16 he_mcs_mask[NL80211_HE_NSS_MAX])
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
 static u8 ath12k_parse_mpdudensity(u8 mpdudensity)
 {
 /*  From IEEE Std 802.11-2020 defined values for "Minimum MPDU Start Spacing":
@@ -2139,9 +2151,15 @@ static void ath12k_peer_assoc_h_ht(struct ath12k *ar,
 		arg->peer_rate_caps |= WMI_HOST_RC_CW40_FLAG;
 	}
 
-	if (arvif->bitrate_mask.control[band].gi != NL80211_TXRATE_FORCE_LGI) {
-		if (ht_cap->cap & (IEEE80211_HT_CAP_SGI_20 |
-		    IEEE80211_HT_CAP_SGI_40))
+	/* As firmware handles these two flags (IEEE80211_HT_CAP_SGI_20
+	 * and IEEE80211_HT_CAP_SGI_40) for enabling SGI, reset both
+	 * flags if guard interval is to force Long GI
+	 */
+	if (arvif->bitrate_mask.control[band].gi == NL80211_TXRATE_FORCE_LGI) {
+		arg->peer_ht_caps &= ~(IEEE80211_HT_CAP_SGI_20 | IEEE80211_HT_CAP_SGI_40);
+	} else {
+		/* Enable SGI flag if either SGI_20 or SGI_40 is supported */
+		if (ht_cap->cap & (IEEE80211_HT_CAP_SGI_20 | IEEE80211_HT_CAP_SGI_40))
 			arg->peer_rate_caps |= WMI_HOST_RC_SGI_FLAG;
 	}
 
@@ -2264,11 +2282,12 @@ static void ath12k_peer_assoc_h_vht(struct ath12k *ar,
 	struct ieee80211_link_sta *link_sta;
 	struct cfg80211_chan_def def;
 	enum nl80211_band band;
-	const u16 *vht_mcs_mask;
+	u16 *vht_mcs_mask;
 	u16 tx_mcs_map;
 	u8 ampdu_factor;
 	u8 max_nss, vht_mcs;
-	int i;
+	int i, vht_nss, nss_idx;
+	bool user_rate_valid = true;
 
 	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
 
@@ -2321,6 +2340,25 @@ static void ath12k_peer_assoc_h_vht(struct ath12k *ar,
 	if (link_sta->bandwidth == IEEE80211_STA_RX_BW_160)
 		arg->bw_160 = true;
 
+	vht_nss =  ath12k_mac_max_vht_nss(vht_mcs_mask);
+
+	if (vht_nss > link_sta->rx_nss) {
+		user_rate_valid = false;
+		for (nss_idx = link_sta->rx_nss - 1; nss_idx >= 0; nss_idx--) {
+			if (vht_mcs_mask[nss_idx]) {
+				user_rate_valid = true;
+				break;
+			}
+		}
+	}
+
+	if (!user_rate_valid) {
+		ath12k_dbg(ar->ab, ATH12K_DBG_MAC,
+			   "Setting vht range MCS value to peer supported nss:%d for peer %pM\n",
+			   link_sta->rx_nss, arsta->addr);
+		vht_mcs_mask[link_sta->rx_nss - 1] = vht_mcs_mask[vht_nss - 1];
+	}
+
 	/* Calculate peer NSS capability from VHT capabilities if STA
 	 * supports VHT.
 	 */
@@ -2360,6 +2398,72 @@ static void ath12k_peer_assoc_h_vht(struct ath12k *ar,
 	/* TODO: rxnss_override */
 }
 
+static int ath12k_mac_get_max_he_mcs_map(u16 mcs_map, int nss)
+{
+	switch ((mcs_map >> (2 * nss)) & 0x3) {
+	case IEEE80211_HE_MCS_SUPPORT_0_7: return BIT(8) - 1;
+	case IEEE80211_HE_MCS_SUPPORT_0_9: return BIT(10) - 1;
+	case IEEE80211_HE_MCS_SUPPORT_0_11: return BIT(12) - 1;
+	}
+	return 0;
+}
+
+static u16 ath12k_peer_assoc_h_he_limit(u16 tx_mcs_set,
+					const u16 *he_mcs_limit)
+{
+	int idx_limit;
+	int nss;
+	u16 mcs_map;
+	u16 mcs;
+
+	for (nss = 0; nss < NL80211_HE_NSS_MAX; nss++) {
+		mcs_map = ath12k_mac_get_max_he_mcs_map(tx_mcs_set, nss) &
+			he_mcs_limit[nss];
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
+			fallthrough;
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
+ath12k_peer_assoc_h_he_masked(const u16 he_mcs_mask[NL80211_HE_NSS_MAX])
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
 static void ath12k_peer_assoc_h_he(struct ath12k *ar,
 				   struct ath12k_link_vif *arvif,
 				   struct ath12k_link_sta *arsta,
@@ -2370,18 +2474,28 @@ static void ath12k_peer_assoc_h_he(struct ath12k *ar,
 	const struct ieee80211_sta_he_cap *he_cap;
 	struct ieee80211_bss_conf *link_conf;
 	struct ieee80211_link_sta *link_sta;
+	struct cfg80211_chan_def def;
 	int i;
 	u8 ampdu_factor, max_nss;
 	u8 rx_mcs_80 = IEEE80211_HE_MCS_NOT_SUPPORTED;
 	u8 rx_mcs_160 = IEEE80211_HE_MCS_NOT_SUPPORTED;
 	u16 mcs_160_map, mcs_80_map;
+	u8 link_id = arvif->link_id;
 	bool support_160;
-	u16 v;
+	enum nl80211_band band;
+	u16 *he_mcs_mask;
+	u8 he_mcs;
+	u16 he_tx_mcs = 0, v = 0;
+	int he_nss, nss_idx;
+	bool user_rate_valid = true;
+
+	if (WARN_ON(ath12k_mac_vif_link_chan(vif, link_id, &def)))
+		return;
 
 	link_conf = ath12k_mac_get_link_bss_conf(arvif);
 	if (!link_conf) {
 		ath12k_warn(ar->ab, "unable to access bss link conf in peer assoc he for vif %pM link %u",
-			    vif->addr, arvif->link_id);
+			    vif->addr, link_id);
 		return;
 	}
 
@@ -2396,6 +2510,12 @@ static void ath12k_peer_assoc_h_he(struct ath12k *ar,
 	if (!he_cap->has_he)
 		return;
 
+	band = def.chan->band;
+	he_mcs_mask = arvif->bitrate_mask.control[band].he_mcs;
+
+	if (ath12k_peer_assoc_h_he_masked(he_mcs_mask))
+		return;
+
 	arg->he_flag = true;
 
 	support_160 = !!(he_cap->he_cap_elem.phy_cap_info[0] &
@@ -2501,25 +2621,47 @@ static void ath12k_peer_assoc_h_he(struct ath12k *ar,
 	if (he_cap->he_cap_elem.mac_cap_info[0] & IEEE80211_HE_MAC_CAP0_TWT_REQ)
 		arg->twt_requester = true;
 
+	he_nss = ath12k_mac_max_he_nss(he_mcs_mask);
+
+	if (he_nss > link_sta->rx_nss) {
+		user_rate_valid = false;
+		for (nss_idx = link_sta->rx_nss - 1; nss_idx >= 0; nss_idx--) {
+			if (he_mcs_mask[nss_idx]) {
+				user_rate_valid = true;
+				break;
+			}
+		}
+	}
+
+	if (!user_rate_valid) {
+		ath12k_dbg(ar->ab, ATH12K_DBG_MAC,
+			   "Setting he range MCS value to peer supported nss:%d for peer %pM\n",
+			   link_sta->rx_nss, arsta->addr);
+		he_mcs_mask[link_sta->rx_nss - 1] = he_mcs_mask[he_nss - 1];
+	}
+
 	switch (link_sta->bandwidth) {
 	case IEEE80211_STA_RX_BW_160:
 		if (he_cap->he_cap_elem.phy_cap_info[0] &
 		    IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_80PLUS80_MHZ_IN_5G) {
-			v = le16_to_cpu(he_cap->he_mcs_nss_supp.rx_mcs_80p80);
+			v = ath12k_peer_assoc_h_he_limit(v, he_mcs_mask);
 			arg->peer_he_rx_mcs_set[WMI_HECAP_TXRX_MCS_NSS_IDX_80_80] = v;
 
 			v = le16_to_cpu(he_cap->he_mcs_nss_supp.tx_mcs_80p80);
 			arg->peer_he_tx_mcs_set[WMI_HECAP_TXRX_MCS_NSS_IDX_80_80] = v;
 
 			arg->peer_he_mcs_count++;
+			he_tx_mcs = v;
 		}
 		v = le16_to_cpu(he_cap->he_mcs_nss_supp.rx_mcs_160);
 		arg->peer_he_rx_mcs_set[WMI_HECAP_TXRX_MCS_NSS_IDX_160] = v;
 
-		v = le16_to_cpu(he_cap->he_mcs_nss_supp.tx_mcs_160);
+		v = ath12k_peer_assoc_h_he_limit(v, he_mcs_mask);
 		arg->peer_he_tx_mcs_set[WMI_HECAP_TXRX_MCS_NSS_IDX_160] = v;
 
 		arg->peer_he_mcs_count++;
+		if (!he_tx_mcs)
+			he_tx_mcs = v;
 		fallthrough;
 
 	default:
@@ -2527,11 +2669,34 @@ static void ath12k_peer_assoc_h_he(struct ath12k *ar,
 		arg->peer_he_rx_mcs_set[WMI_HECAP_TXRX_MCS_NSS_IDX_80] = v;
 
 		v = le16_to_cpu(he_cap->he_mcs_nss_supp.tx_mcs_80);
+		v = ath12k_peer_assoc_h_he_limit(v, he_mcs_mask);
 		arg->peer_he_tx_mcs_set[WMI_HECAP_TXRX_MCS_NSS_IDX_80] = v;
 
 		arg->peer_he_mcs_count++;
+		if (!he_tx_mcs)
+			he_tx_mcs = v;
 		break;
 	}
+
+	/* Calculate peer NSS capability from HE capabilities if STA
+	 * supports HE.
+	 */
+	for (i = 0, max_nss = 0, he_mcs = 0; i < NL80211_HE_NSS_MAX; i++) {
+		he_mcs = he_tx_mcs >> (2 * i) & 3;
+
+		/* In case of fixed rates, MCS Range in he_tx_mcs might have
+		 * unsupported range, with he_mcs_mask set, so check either of them
+		 * to find nss.
+		 */
+		if (he_mcs != IEEE80211_HE_MCS_NOT_SUPPORTED ||
+		    he_mcs_mask[i])
+			max_nss = i + 1;
+	}
+	arg->peer_nss = min(link_sta->rx_nss, max_nss);
+
+	ath12k_dbg(ar->ab, ATH12K_DBG_MAC,
+		   "mac he peer %pM nss %d mcs cnt %d\n",
+		   arsta->addr, arg->peer_nss, arg->peer_he_mcs_count);
 }
 
 static void ath12k_peer_assoc_h_he_6ghz(struct ath12k *ar,
@@ -2867,6 +3032,7 @@ static void ath12k_peer_assoc_h_phymode(struct ath12k *ar,
 	enum nl80211_band band;
 	const u8 *ht_mcs_mask;
 	const u16 *vht_mcs_mask;
+	const u16 *he_mcs_mask;
 	enum wmi_phy_mode phymode = MODE_UNKNOWN;
 
 	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
@@ -2880,6 +3046,7 @@ static void ath12k_peer_assoc_h_phymode(struct ath12k *ar,
 	band = def.chan->band;
 	ht_mcs_mask = arvif->bitrate_mask.control[band].ht_mcs;
 	vht_mcs_mask = arvif->bitrate_mask.control[band].vht_mcs;
+	he_mcs_mask = arvif->bitrate_mask.control[band].he_mcs;
 
 	link_sta = ath12k_mac_get_link_sta(arsta);
 	if (!link_sta) {
@@ -2895,7 +3062,8 @@ static void ath12k_peer_assoc_h_phymode(struct ath12k *ar,
 				phymode = MODE_11BE_EHT40_2G;
 			else
 				phymode = MODE_11BE_EHT20_2G;
-		} else if (link_sta->he_cap.has_he) {
+		} else if (link_sta->he_cap.has_he &&
+			   !ath12k_peer_assoc_h_he_masked(he_mcs_mask)) {
 			if (link_sta->bandwidth == IEEE80211_STA_RX_BW_80)
 				phymode = MODE_11AX_HE80_2G;
 			else if (link_sta->bandwidth == IEEE80211_STA_RX_BW_40)
@@ -2925,7 +3093,8 @@ static void ath12k_peer_assoc_h_phymode(struct ath12k *ar,
 		/* Check EHT first */
 		if (link_sta->eht_cap.has_eht) {
 			phymode = ath12k_mac_get_phymode_eht(ar, link_sta);
-		} else if (link_sta->he_cap.has_he) {
+		} else if (link_sta->he_cap.has_he &&
+			   !ath12k_peer_assoc_h_he_masked(he_mcs_mask)) {
 			phymode = ath12k_mac_get_phymode_he(ar, link_sta);
 		} else if (link_sta->vht_cap.vht_supported &&
 		    !ath12k_peer_assoc_h_vht_masked(vht_mcs_mask)) {
@@ -3690,6 +3859,7 @@ static void ath12k_mac_init_arvif(struct ath12k_vif *ahvif,
 
 	for (i = 0; i < ARRAY_SIZE(arvif->bitrate_mask.control); i++) {
 		arvif->bitrate_mask.control[i].legacy = 0xffffffff;
+		arvif->bitrate_mask.control[i].gi = NL80211_TXRATE_DEFAULT_GI;
 		memset(arvif->bitrate_mask.control[i].ht_mcs, 0xff,
 		       sizeof(arvif->bitrate_mask.control[i].ht_mcs));
 		memset(arvif->bitrate_mask.control[i].vht_mcs, 0xff,
@@ -5166,6 +5336,20 @@ ath12k_mac_bitrate_mask_num_vht_rates(struct ath12k *ar,
 	return num_rates;
 }
 
+static int
+ath12k_mac_bitrate_mask_num_he_rates(struct ath12k *ar,
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
 ath12k_mac_set_peer_vht_fixed_rate(struct ath12k_link_vif *arvif,
 				   struct ath12k_link_sta *arsta,
@@ -5212,6 +5396,60 @@ ath12k_mac_set_peer_vht_fixed_rate(struct ath12k_link_vif *arvif,
 	return ret;
 }
 
+static int
+ath12k_mac_set_peer_he_fixed_rate(struct ath12k_link_vif *arvif,
+				  struct ath12k_link_sta *arsta,
+				  const struct cfg80211_bitrate_mask *mask,
+				  enum nl80211_band band)
+{
+	struct ath12k *ar = arvif->ar;
+	u8 he_rate, nss;
+	u32 rate_code;
+	int ret, i;
+	struct ath12k_sta *ahsta = arsta->ahsta;
+	struct ieee80211_sta *sta;
+
+	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
+
+	sta = ath12k_ahsta_to_sta(ahsta);
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
+		ath12k_warn(ar->ab, "No single HE Fixed rate found to set for %pM",
+			    arsta->addr);
+		return -EINVAL;
+	}
+
+	/* Avoid updating invalid nss as fixed rate*/
+	if (nss > sta->deflink.rx_nss)
+		return -EINVAL;
+
+	ath12k_dbg(ar->ab, ATH12K_DBG_MAC,
+		   "Setting Fixed HE Rate for peer %pM. Device will not switch to any other selected rates",
+		   arsta->addr);
+
+	rate_code = ATH12K_HW_RATE_CODE(he_rate, nss - 1,
+					WMI_RATE_PREAMBLE_HE);
+
+	ret = ath12k_wmi_set_peer_param(ar, arsta->addr,
+					arvif->vdev_id,
+					WMI_PEER_PARAM_FIXED_RATE,
+					rate_code);
+	if (ret)
+		ath12k_warn(ar->ab,
+			    "failed to update STA %pM Fixed Rate %d: %d\n",
+			    arsta->addr, rate_code, ret);
+
+	return ret;
+}
+
 static int ath12k_mac_station_assoc(struct ath12k *ar,
 				    struct ath12k_link_vif *arvif,
 				    struct ath12k_link_sta *arsta,
@@ -5224,7 +5462,7 @@ static int ath12k_mac_station_assoc(struct ath12k *ar,
 	struct cfg80211_chan_def def;
 	enum nl80211_band band;
 	struct cfg80211_bitrate_mask *mask;
-	u8 num_vht_rates;
+	u8 num_vht_rates, num_he_rates;
 	u8 link_id = arvif->link_id;
 
 	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
@@ -5264,9 +5502,10 @@ static int ath12k_mac_station_assoc(struct ath12k *ar,
 	}
 
 	num_vht_rates = ath12k_mac_bitrate_mask_num_vht_rates(ar, band, mask);
+	num_he_rates = ath12k_mac_bitrate_mask_num_he_rates(ar, band, mask);
 
-	/* If single VHT rate is configured (by set_bitrate_mask()),
-	 * peer_assoc will disable VHT. This is now enabled by a peer specific
+	/* If single VHT/HE rate is configured (by set_bitrate_mask()),
+	 * peer_assoc will disable VHT/HE. This is now enabled by a peer specific
 	 * fixed param.
 	 * Note that all other rates and NSS will be disabled for this peer.
 	 */
@@ -5282,8 +5521,9 @@ static int ath12k_mac_station_assoc(struct ath12k *ar,
 	spin_unlock_bh(&ar->data_lock);
 
 	if (link_sta->vht_cap.vht_supported && num_vht_rates == 1) {
-		ret = ath12k_mac_set_peer_vht_fixed_rate(arvif, arsta, mask,
-							 band);
+		ret = ath12k_mac_set_peer_vht_fixed_rate(arvif, arsta, mask, band);
+	} else if (link_sta->he_cap.has_he && num_he_rates == 1) {
+		ret = ath12k_mac_set_peer_he_fixed_rate(arvif, arsta, mask, band);
 		if (ret)
 			return ret;
 	}
@@ -5347,8 +5587,9 @@ static void ath12k_sta_rc_update_wk(struct wiphy *wiphy, struct wiphy_work *wk)
 	enum nl80211_band band;
 	const u8 *ht_mcs_mask;
 	const u16 *vht_mcs_mask;
-	u32 changed, bw, nss, smps, bw_prev;
-	int err, num_vht_rates;
+	const u16 *he_mcs_mask;
+	u32 changed, bw, nss, mac_nss, smps, bw_prev;
+	int err, num_vht_rates, num_he_rates;
 	const struct cfg80211_bitrate_mask *mask;
 	enum wmi_phy_mode peer_phymode;
 	struct ath12k_link_sta *arsta;
@@ -5368,6 +5609,7 @@ static void ath12k_sta_rc_update_wk(struct wiphy *wiphy, struct wiphy_work *wk)
 	band = def.chan->band;
 	ht_mcs_mask = arvif->bitrate_mask.control[band].ht_mcs;
 	vht_mcs_mask = arvif->bitrate_mask.control[band].vht_mcs;
+	he_mcs_mask = arvif->bitrate_mask.control[band].he_mcs;
 
 	spin_lock_bh(&ar->data_lock);
 
@@ -5382,8 +5624,10 @@ static void ath12k_sta_rc_update_wk(struct wiphy *wiphy, struct wiphy_work *wk)
 	spin_unlock_bh(&ar->data_lock);
 
 	nss = max_t(u32, 1, nss);
-	nss = min(nss, max(ath12k_mac_max_ht_nss(ht_mcs_mask),
-			   ath12k_mac_max_vht_nss(vht_mcs_mask)));
+	mac_nss = max3(ath12k_mac_max_ht_nss(ht_mcs_mask),
+		       ath12k_mac_max_vht_nss(vht_mcs_mask),
+		       ath12k_mac_max_he_nss(he_mcs_mask));
+	nss = min(nss, mac_nss);
 
 	struct ath12k_wmi_peer_assoc_arg *peer_arg __free(kfree) =
 					kzalloc(sizeof(*peer_arg), GFP_KERNEL);
@@ -5466,6 +5710,8 @@ static void ath12k_sta_rc_update_wk(struct wiphy *wiphy, struct wiphy_work *wk)
 		mask = &arvif->bitrate_mask;
 		num_vht_rates = ath12k_mac_bitrate_mask_num_vht_rates(ar, band,
 								      mask);
+		num_he_rates = ath12k_mac_bitrate_mask_num_he_rates(ar, band,
+								    mask);
 
 		/* Peer_assoc_prepare will reject vht rates in
 		 * bitrate_mask if its not available in range format and
@@ -5488,11 +5734,24 @@ static void ath12k_sta_rc_update_wk(struct wiphy *wiphy, struct wiphy_work *wk)
 		if (link_sta->vht_cap.vht_supported && num_vht_rates == 1) {
 			ath12k_mac_set_peer_vht_fixed_rate(arvif, arsta, mask,
 							   band);
+		} else if (link_sta->he_cap.has_he && num_he_rates == 1) {
+			ath12k_mac_set_peer_he_fixed_rate(arvif, arsta, mask, band);
 		} else {
-			/* If the peer is non-VHT or no fixed VHT rate
+			/* If the peer is non-VHT/HE or no fixed VHT/HE rate
 			 * is provided in the new bitrate mask we set the
-			 * other rates using peer_assoc command.
+			 * other rates using peer_assoc command. Also clear
+			 * the peer fixed rate settings as it has higher proprity
+			 * than peer assoc
 			 */
+			err = ath12k_wmi_set_peer_param(ar, arsta->addr,
+							arvif->vdev_id,
+							WMI_PEER_PARAM_FIXED_RATE,
+							WMI_FIXED_RATE_NONE);
+			if (err)
+				ath12k_warn(ar->ab,
+					    "failed to disable peer fixed rate for STA %pM ret %d\n",
+					    arsta->addr, err);
+
 			ath12k_peer_assoc_prepare(ar, arvif, arsta,
 						  peer_arg, true);
 
@@ -9930,19 +10189,40 @@ ath12k_mac_has_single_legacy_rate(struct ath12k *ar,
 	if (ath12k_mac_bitrate_mask_num_vht_rates(ar, band, mask))
 		return false;
 
+	if (ath12k_mac_bitrate_mask_num_he_rates(ar, band, mask))
+		return false;
+
 	return num_rates == 1;
 }
 
+static __le16
+ath12k_mac_get_tx_mcs_map(const struct ieee80211_sta_he_cap *he_cap)
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
 ath12k_mac_bitrate_mask_get_single_nss(struct ath12k *ar,
+				       struct ieee80211_vif *vif,
 				       enum nl80211_band band,
 				       const struct cfg80211_bitrate_mask *mask,
 				       int *nss)
 {
 	struct ieee80211_supported_band *sband = &ar->mac.sbands[band];
 	u16 vht_mcs_map = le16_to_cpu(sband->vht_cap.vht_mcs.tx_mcs_map);
+	const struct ieee80211_sta_he_cap *he_cap;
+	u16 he_mcs_map = 0;
 	u8 ht_nss_mask = 0;
 	u8 vht_nss_mask = 0;
+	u8 he_nss_mask = 0;
 	int i;
 
 	/* No need to consider legacy here. Basic rates are always present
@@ -9969,7 +10249,24 @@ ath12k_mac_bitrate_mask_get_single_nss(struct ath12k *ar,
 			return false;
 	}
 
-	if (ht_nss_mask != vht_nss_mask)
+	he_cap = ieee80211_get_he_iftype_cap_vif(sband, vif);
+	if (!he_cap)
+		return false;
+
+	he_mcs_map = le16_to_cpu(ath12k_mac_get_tx_mcs_map(he_cap));
+
+	for (i = 0; i < ARRAY_SIZE(mask->control[band].he_mcs); i++) {
+		if (mask->control[band].he_mcs[i] == 0)
+			continue;
+
+		if (mask->control[band].he_mcs[i] ==
+		    ath12k_mac_get_max_he_mcs_map(he_mcs_map, i))
+			he_nss_mask |= BIT(i);
+		else
+			return false;
+	}
+
+	if (ht_nss_mask != vht_nss_mask || ht_nss_mask != he_nss_mask)
 		return false;
 
 	if (ht_nss_mask == 0)
@@ -10016,54 +10313,182 @@ ath12k_mac_get_single_legacy_rate(struct ath12k *ar,
 	return 0;
 }
 
-static int ath12k_mac_set_fixed_rate_params(struct ath12k_link_vif *arvif,
-					    u32 rate, u8 nss, u8 sgi, u8 ldpc)
+static int
+ath12k_mac_set_fixed_rate_gi_ltf(struct ath12k_link_vif *arvif, u8 he_gi, u8 he_ltf)
 {
 	struct ath12k *ar = arvif->ar;
-	u32 vdev_param;
 	int ret;
 
 	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
 
-	ath12k_dbg(ar->ab, ATH12K_DBG_MAC, "mac set fixed rate params vdev %i rate 0x%02x nss %u sgi %u\n",
-		   arvif->vdev_id, rate, nss, sgi);
+	/* 0.8 = 0, 1.6 = 2 and 3.2 = 3. */
+	if (he_gi && he_gi != 0xFF)
+		he_gi += 1;
 
-	vdev_param = WMI_VDEV_PARAM_FIXED_RATE;
 	ret = ath12k_wmi_vdev_set_param_cmd(ar, arvif->vdev_id,
-					    vdev_param, rate);
+					    WMI_VDEV_PARAM_SGI, he_gi);
 	if (ret) {
-		ath12k_warn(ar->ab, "failed to set fixed rate param 0x%02x: %d\n",
-			    rate, ret);
+		ath12k_warn(ar->ab, "failed to set HE GI:%d, error:%d\n",
+			    he_gi, ret);
 		return ret;
 	}
+	/* start from 1 */
+	if (he_ltf != 0xFF)
+		he_ltf += 1;
 
-	vdev_param = WMI_VDEV_PARAM_NSS;
 	ret = ath12k_wmi_vdev_set_param_cmd(ar, arvif->vdev_id,
-					    vdev_param, nss);
+					    WMI_VDEV_PARAM_HE_LTF, he_ltf);
 	if (ret) {
-		ath12k_warn(ar->ab, "failed to set nss param %d: %d\n",
-			    nss, ret);
+		ath12k_warn(ar->ab, "failed to set HE LTF:%d, error:%d\n",
+			    he_ltf, ret);
+		return ret;
+	}
+	return 0;
+}
+
+static int
+ath12k_mac_set_auto_rate_gi_ltf(struct ath12k_link_vif *arvif, u16 he_gi, u8 he_ltf)
+{
+	struct ath12k *ar = arvif->ar;
+	int ret;
+	u32 he_ar_gi_ltf;
+
+	if (he_gi != 0xFF) {
+		switch (he_gi) {
+		case NL80211_RATE_INFO_HE_GI_0_8:
+			he_gi = WMI_AUTORATE_800NS_GI;
+			break;
+		case NL80211_RATE_INFO_HE_GI_1_6:
+			he_gi = WMI_AUTORATE_1600NS_GI;
+			break;
+		case NL80211_RATE_INFO_HE_GI_3_2:
+			he_gi = WMI_AUTORATE_3200NS_GI;
+			break;
+		default:
+			ath12k_warn(ar->ab, "Invalid GI\n");
+			return -EINVAL;
+		}
+	}
+
+	if (he_ltf != 0xFF) {
+		switch (he_ltf) {
+		case NL80211_RATE_INFO_HE_1XLTF:
+			he_ltf = WMI_HE_AUTORATE_LTF_1X;
+			break;
+		case NL80211_RATE_INFO_HE_2XLTF:
+			he_ltf = WMI_HE_AUTORATE_LTF_2X;
+			break;
+		case NL80211_RATE_INFO_HE_4XLTF:
+			he_ltf = WMI_HE_AUTORATE_LTF_4X;
+			break;
+		default:
+			ath12k_warn(ar->ab, "Invalid LTF\n");
+			return -EINVAL;
+		}
+	}
+
+	he_ar_gi_ltf = he_gi | he_ltf;
+
+	ret = ath12k_wmi_vdev_set_param_cmd(ar, arvif->vdev_id,
+					    WMI_VDEV_PARAM_AUTORATE_MISC_CFG,
+					    he_ar_gi_ltf);
+	if (ret) {
+		ath12k_warn(ar->ab,
+			    "failed to set HE autorate GI:%u, LTF:%u params, error:%d\n",
+			    he_gi, he_ltf, ret);
 		return ret;
 	}
 
-	vdev_param = WMI_VDEV_PARAM_SGI;
+	return 0;
+}
+
+static u32 ath12k_mac_nlgi_to_wmigi(enum nl80211_txrate_gi gi)
+{
+	switch (gi) {
+	case NL80211_TXRATE_DEFAULT_GI:
+		return WMI_GI_400_NS;
+	case NL80211_TXRATE_FORCE_LGI:
+		return WMI_GI_800_NS;
+	default:
+		return WMI_GI_400_NS;
+	}
+}
+
+static int ath12k_mac_set_rate_params(struct ath12k_link_vif *arvif,
+				      u32 rate, u8 nss, u8 sgi, u8 ldpc,
+				      u8 he_gi, u8 he_ltf, bool he_fixed_rate)
+{
+	struct ieee80211_bss_conf *link_conf;
+	struct ath12k *ar = arvif->ar;
+	u32 vdev_param;
+	u32 param_value;
+	int ret;
+	bool he_support;
+
+	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
+
+	link_conf = ath12k_mac_get_link_bss_conf(arvif);
+	if (!link_conf)
+		return -EINVAL;
+
+	he_support = link_conf->he_support;
+
+	ath12k_dbg(ar->ab, ATH12K_DBG_MAC,
+		   "mac set rate params vdev %i rate 0x%02x nss 0x%02x sgi 0x%02x ldpc 0x%02x\n",
+		   arvif->vdev_id, rate, nss, sgi, ldpc);
+
+	ath12k_dbg(ar->ab, ATH12K_DBG_MAC,
+		   "he_gi 0x%02x he_ltf 0x%02x he_fixed_rate %d\n", he_gi,
+		   he_ltf, he_fixed_rate);
+
+	if (!he_support) {
+		vdev_param = WMI_VDEV_PARAM_FIXED_RATE;
+		ret = ath12k_wmi_vdev_set_param_cmd(ar, arvif->vdev_id,
+						    vdev_param, rate);
+		if (ret) {
+			ath12k_warn(ar->ab, "failed to set fixed rate param 0x%02x: %d\n",
+				    rate, ret);
+			return ret;
+		}
+	}
+
+	vdev_param = WMI_VDEV_PARAM_NSS;
+
 	ret = ath12k_wmi_vdev_set_param_cmd(ar, arvif->vdev_id,
-					    vdev_param, sgi);
+					    vdev_param, nss);
 	if (ret) {
-		ath12k_warn(ar->ab, "failed to set sgi param %d: %d\n",
-			    sgi, ret);
+		ath12k_warn(ar->ab, "failed to set nss param %d: %d\n",
+			    nss, ret);
 		return ret;
 	}
 
-	vdev_param = WMI_VDEV_PARAM_LDPC;
 	ret = ath12k_wmi_vdev_set_param_cmd(ar, arvif->vdev_id,
-					    vdev_param, ldpc);
+					    WMI_VDEV_PARAM_LDPC, ldpc);
 	if (ret) {
 		ath12k_warn(ar->ab, "failed to set ldpc param %d: %d\n",
 			    ldpc, ret);
 		return ret;
 	}
 
+	if (he_support) {
+		if (he_fixed_rate)
+			ret = ath12k_mac_set_fixed_rate_gi_ltf(arvif, he_gi, he_ltf);
+		else
+			ret = ath12k_mac_set_auto_rate_gi_ltf(arvif, he_gi, he_ltf);
+		if (ret)
+			return ret;
+	} else {
+		vdev_param = WMI_VDEV_PARAM_SGI;
+		param_value = ath12k_mac_nlgi_to_wmigi(sgi);
+		ret = ath12k_wmi_vdev_set_param_cmd(ar, arvif->vdev_id,
+						    vdev_param, param_value);
+		if (ret) {
+			ath12k_warn(ar->ab, "failed to set sgi param %d: %d\n",
+				    sgi, ret);
+			return ret;
+		}
+	}
+
 	return 0;
 }
 
@@ -10092,6 +10517,31 @@ ath12k_mac_vht_mcs_range_present(struct ath12k *ar,
 	return true;
 }
 
+static bool
+ath12k_mac_he_mcs_range_present(struct ath12k *ar,
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
 static void ath12k_mac_set_bitrate_mask_iter(void *data,
 					     struct ieee80211_sta *sta)
 {
@@ -10100,7 +10550,10 @@ static void ath12k_mac_set_bitrate_mask_iter(void *data,
 	struct ath12k_link_sta *arsta;
 	struct ath12k *ar = arvif->ar;
 
-	arsta = rcu_dereference(ahsta->link[arvif->link_id]);
+	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
+
+	arsta = wiphy_dereference(ath12k_ar_to_hw(ar)->wiphy,
+				  ahsta->link[arvif->link_id]);
 	if (!arsta || arsta->arvif != arvif)
 		return;
 
@@ -10138,6 +10591,61 @@ static void ath12k_mac_disable_peer_fixed_rate(void *data,
 			    arsta->addr, ret);
 }
 
+static bool
+ath12k_mac_validate_fixed_rate_settings(struct ath12k *ar, enum nl80211_band band,
+					const struct cfg80211_bitrate_mask *mask,
+					unsigned int link_id)
+{
+	bool he_fixed_rate = false, vht_fixed_rate = false;
+	const u16 *vht_mcs_mask, *he_mcs_mask;
+	struct ieee80211_link_sta *link_sta;
+	struct ath12k_peer *peer, *tmp;
+	u8 vht_nss, he_nss;
+	int ret = true;
+
+	vht_mcs_mask = mask->control[band].vht_mcs;
+	he_mcs_mask = mask->control[band].he_mcs;
+
+	if (ath12k_mac_bitrate_mask_num_vht_rates(ar, band, mask) == 1)
+		vht_fixed_rate = true;
+
+	if (ath12k_mac_bitrate_mask_num_he_rates(ar, band, mask) == 1)
+		he_fixed_rate = true;
+
+	if (!vht_fixed_rate && !he_fixed_rate)
+		return true;
+
+	vht_nss = ath12k_mac_max_vht_nss(vht_mcs_mask);
+	he_nss =  ath12k_mac_max_he_nss(he_mcs_mask);
+
+	rcu_read_lock();
+	spin_lock_bh(&ar->ab->base_lock);
+	list_for_each_entry_safe(peer, tmp, &ar->ab->peers, list) {
+		if (peer->sta) {
+			link_sta = rcu_dereference(peer->sta->link[link_id]);
+			if (!link_sta) {
+				ret = false;
+				goto exit;
+			}
+
+			if (vht_fixed_rate && (!link_sta->vht_cap.vht_supported ||
+					       link_sta->rx_nss < vht_nss)) {
+				ret = false;
+				goto exit;
+			}
+			if (he_fixed_rate && (!link_sta->he_cap.has_he ||
+					      link_sta->rx_nss < he_nss)) {
+				ret = false;
+				goto exit;
+			}
+		}
+	}
+exit:
+	spin_unlock_bh(&ar->ab->base_lock);
+	rcu_read_unlock();
+	return ret;
+}
+
 static int
 ath12k_mac_op_set_bitrate_mask(struct ieee80211_hw *hw,
 			       struct ieee80211_vif *vif,
@@ -10150,13 +10658,17 @@ ath12k_mac_op_set_bitrate_mask(struct ieee80211_hw *hw,
 	enum nl80211_band band;
 	const u8 *ht_mcs_mask;
 	const u16 *vht_mcs_mask;
+	const u16 *he_mcs_mask;
+	u8 he_ltf = 0;
+	u8 he_gi = 0;
 	u32 rate;
-	u8 nss;
+	u8 nss, mac_nss;
 	u8 sgi;
 	u8 ldpc;
 	int single_nss;
 	int ret;
 	int num_rates;
+	bool he_fixed_rate = false;
 
 	lockdep_assert_wiphy(hw->wiphy);
 
@@ -10171,14 +10683,18 @@ ath12k_mac_op_set_bitrate_mask(struct ieee80211_hw *hw,
 	band = def.chan->band;
 	ht_mcs_mask = mask->control[band].ht_mcs;
 	vht_mcs_mask = mask->control[band].vht_mcs;
+	he_mcs_mask = mask->control[band].he_mcs;
 	ldpc = !!(ar->ht_cap_info & WMI_HT_CAP_LDPC);
 
 	sgi = mask->control[band].gi;
-	if (sgi == NL80211_TXRATE_FORCE_LGI) {
+	if (sgi == NL80211_TXRATE_FORCE_SGI) {
 		ret = -EINVAL;
 		goto out;
 	}
 
+	he_gi = mask->control[band].he_gi;
+	he_ltf = mask->control[band].he_ltf;
+
 	/* mac80211 doesn't support sending a fixed HT/VHT MCS alone, rather it
 	 * requires passing at least one of used basic rates along with them.
 	 * Fixed rate setting across different preambles(legacy, HT, VHT) is
@@ -10195,18 +10711,31 @@ ath12k_mac_op_set_bitrate_mask(struct ieee80211_hw *hw,
 				    arvif->vdev_id, ret);
 			goto out;
 		}
+
 		ieee80211_iterate_stations_mtx(hw,
 					       ath12k_mac_disable_peer_fixed_rate,
 					       arvif);
-	} else if (ath12k_mac_bitrate_mask_get_single_nss(ar, band, mask,
+	} else if (ath12k_mac_bitrate_mask_get_single_nss(ar, vif, band, mask,
 							  &single_nss)) {
 		rate = WMI_FIXED_RATE_NONE;
 		nss = single_nss;
+		arvif->bitrate_mask = *mask;
+
+		ieee80211_iterate_stations_atomic(hw,
+						  ath12k_mac_set_bitrate_mask_iter,
+						  arvif);
 	} else {
 		rate = WMI_FIXED_RATE_NONE;
-		nss = min_t(u32, ar->num_tx_chains,
-			    max(ath12k_mac_max_ht_nss(ht_mcs_mask),
-				ath12k_mac_max_vht_nss(vht_mcs_mask)));
+
+		if (!ath12k_mac_validate_fixed_rate_settings(ar, band,
+							     mask, arvif->link_id))
+			ath12k_warn(ar->ab,
+				    "failed to update fixed rate settings due to mcs/nss incompatibility\n");
+
+		mac_nss = max3(ath12k_mac_max_ht_nss(ht_mcs_mask),
+			       ath12k_mac_max_vht_nss(vht_mcs_mask),
+			       ath12k_mac_max_he_nss(he_mcs_mask));
+		nss = min_t(u32, ar->num_tx_chains, mac_nss);
 
 		/* If multiple rates across different preambles are given
 		 * we can reconfigure this info with all peers using PEER_ASSOC
@@ -10238,9 +10767,21 @@ ath12k_mac_op_set_bitrate_mask(struct ieee80211_hw *hw,
 			 */
 			ath12k_warn(ar->ab,
 				    "Setting more than one MCS Value in bitrate mask not supported\n");
-			return -EINVAL;
+			ret = -EINVAL;
+			goto out;
 		}
 
+		num_rates = ath12k_mac_bitrate_mask_num_he_rates(ar, band, mask);
+		if (num_rates == 1)
+			he_fixed_rate = true;
+
+		if (!ath12k_mac_he_mcs_range_present(ar, band, mask) &&
+		    num_rates > 1) {
+			ath12k_warn(ar->ab,
+				    "Setting more than one HE MCS Value in bitrate mask not supported\n");
+			ret = -EINVAL;
+			goto out;
+		}
 		ieee80211_iterate_stations_mtx(hw,
 					       ath12k_mac_disable_peer_fixed_rate,
 					       arvif);
@@ -10251,9 +10792,10 @@ ath12k_mac_op_set_bitrate_mask(struct ieee80211_hw *hw,
 					       arvif);
 	}
 
-	ret = ath12k_mac_set_fixed_rate_params(arvif, rate, nss, sgi, ldpc);
+	ret = ath12k_mac_set_rate_params(arvif, rate, nss, sgi, ldpc, he_gi,
+					 he_ltf, he_fixed_rate);
 	if (ret) {
-		ath12k_warn(ar->ab, "failed to set fixed rate params on vdev %i: %d\n",
+		ath12k_warn(ar->ab, "failed to set rate params on vdev %i: %d\n",
 			    arvif->vdev_id, ret);
 	}
 
diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
index 1572f7daffb2..c08a91d9ec2b 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -221,6 +221,22 @@ enum WMI_HOST_WLAN_BAND {
 	WMI_HOST_WLAN_2G_5G_CAP	= 3,
 };
 
+/* Parameters used for WMI_VDEV_PARAM_AUTORATE_MISC_CFG command.
+ * Used only for HE auto rate mode.
+ */
+enum {
+	/* HE LTF related configuration */
+	WMI_HE_AUTORATE_LTF_1X = BIT(0),
+	WMI_HE_AUTORATE_LTF_2X = BIT(1),
+	WMI_HE_AUTORATE_LTF_4X = BIT(2),
+
+	/* HE GI related configuration */
+	WMI_AUTORATE_400NS_GI = BIT(8),
+	WMI_AUTORATE_800NS_GI = BIT(9),
+	WMI_AUTORATE_1600NS_GI = BIT(10),
+	WMI_AUTORATE_3200NS_GI = BIT(11),
+};
+
 enum wmi_cmd_group {
 	/* 0 to 2 are reserved */
 	WMI_GRP_START = 0x3,
@@ -1152,7 +1168,9 @@ enum wmi_tlv_vdev_param {
 	WMI_VDEV_PARAM_HE_RANGE_EXT,
 	WMI_VDEV_PARAM_ENABLE_BCAST_PROBE_RESPONSE,
 	WMI_VDEV_PARAM_FILS_MAX_CHANNEL_GUARD_TIME,
+	WMI_VDEV_PARAM_HE_LTF = 0x74,
 	WMI_VDEV_PARAM_BA_MODE = 0x7e,
+	WMI_VDEV_PARAM_AUTORATE_MISC_CFG = 0x80,
 	WMI_VDEV_PARAM_SET_HE_SOUNDING_MODE = 0x87,
 	WMI_VDEV_PARAM_6GHZ_PARAMS = 0x99,
 	WMI_VDEV_PARAM_PROTOTYPE = 0x8000,
@@ -3595,6 +3613,15 @@ struct wmi_force_fw_hang_cmd {
 	__le32 delay_time_ms;
 } __packed;
 
+/* Param values to be sent for WMI_VDEV_PARAM_SGI param_id
+ * which are used in 11n, 11ac systems
+ * @WMI_GI_800_NS - Always uses 0.8us (Long GI)
+ * @WMI_GI_400_NS - Firmware switches between 0.4us (Short GI)
+ *			and 0.8us (Long GI) based on packet error rate.
+ */
+#define WMI_GI_800_NS 0
+#define WMI_GI_400_NS 1
+
 struct wmi_vdev_set_param_cmd {
 	__le32 tlv_header;
 	__le32 vdev_id;
-- 
2.34.1


