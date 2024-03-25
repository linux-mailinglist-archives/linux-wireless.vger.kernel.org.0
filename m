Return-Path: <linux-wireless+bounces-5244-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C8B188B54A
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Mar 2024 00:29:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B565DC035AC
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Mar 2024 20:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C267535BE;
	Mon, 25 Mar 2024 20:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="HnKLslAT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174BF4CB54
	for <linux-wireless@vger.kernel.org>; Mon, 25 Mar 2024 20:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711397460; cv=none; b=aDUiRSHzml3IokTHtp7dv1U/k5xvatQ7/xeRIbfRVrPJZ7GuTDcCTBV4YAF7eT8ckjBZ4csB5eyj0sAhXFU9mKetX3CEHcbKu+apZN1OzlawJObcmNjpu8++idLX0kn6qPSwi2Qn8RsjQcOdM29Ba7rvkRXoIc1xlUFYAhpDXK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711397460; c=relaxed/simple;
	bh=ROyNDAAWQ+ctOUEfFgRVjZdxNuagJ11WPlrk3gbsIqY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tsY9V5vQmZFvum3C/6trSNrc+eef5wOBuLC8dF/70cMpjvazwLQNSK8qlFgllJQmFI7TrMnpgl2FA3o04oOlQQzAJiEXRHv1SKZ0z5xa5G9zgGjBvorwGPstjyX/c8cne6YczSvmfwEN3lqvWqnGhuOw2pFG5CMxpdDnMQ3gxqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=HnKLslAT; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42PIngcj027368;
	Mon, 25 Mar 2024 20:10:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=40NZj8JTv35W/iy5gJkY
	zHm1plq/1bHAuQ3/+quE7Nk=; b=HnKLslATK/Y6xm71T/P/6L0c+MSMMOCWB4ny
	A16sSLwPUuSSbOnzj3PBC/0eLDKrKhi4Kiw1F1wXPAGgwUlZZnNxuEXlZiLRuIRA
	FLvDYioDjpWsKREltNWJISIwtARHXdZYYHwiTyZpBVpP8inQ1KIiQEHV62DqORP9
	nnC6Roayw/4MoK0zBi2wlrKEj4VLLzz41fDWgKiXjU6nGra/rloTsV1y+sArs5bx
	T2Sb4xiMIOU1XuLe7BtTwRRvAvlVUSssed8eE/9aRCUWTibqHRTDXsTipV8CN+Iw
	mtqhkumdJtuvujnJ+/7GNfHM5/va2IdTSZFHeZmFcgLsAGa0CQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x34c2st1k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Mar 2024 20:10:53 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42PKAq39018180
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Mar 2024 20:10:52 GMT
Received: from pradeepc2-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 25 Mar 2024 13:10:52 -0700
From: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Pradeep Kumar Chitrapu
	<quic_pradeepc@quicinc.com>,
        Muna Sinada <quic_msinada@quicinc.com>
Subject: [PATCH 07/10] wifi: ath12k: add support for setting fixed HE rate/GI/LTF
Date: Mon, 25 Mar 2024 13:10:28 -0700
Message-ID: <20240325201031.10837-8-quic_pradeepc@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240325201031.10837-1-quic_pradeepc@quicinc.com>
References: <20240325201031.10837-1-quic_pradeepc@quicinc.com>
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
X-Proofpoint-GUID: KbeZVRXBYCD64oWH-zlEnYbWBdTiT-Nx
X-Proofpoint-ORIG-GUID: KbeZVRXBYCD64oWH-zlEnYbWBdTiT-Nx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-25_19,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 mlxscore=0 malwarescore=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 mlxlogscore=999 suspectscore=0 spamscore=0
 phishscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403250123

Add support to set fixed HE rate/GI/LTF values using nl80211.
Reuse parts of the existing code path already used for HT/VHT
to implement the new helpers symmetrically, similar to how
HT/VHT is handled.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Co-developed-by: Muna Sinada <quic_msinada@quicinc.com>
Signed-off-by: Muna Sinada <quic_msinada@quicinc.com>
Signed-off-by: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 588 ++++++++++++++++++++++++--
 drivers/net/wireless/ath/ath12k/wmi.h |  18 +
 2 files changed, 562 insertions(+), 44 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 46ef2d63a3de..72232285d2b1 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -430,6 +430,18 @@ ath12k_mac_max_vht_nss(const u16 *vht_mcs_mask)
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
@@ -1543,6 +1555,14 @@ static void ath12k_peer_assoc_h_ht(struct ath12k *ar,
 		arg->peer_rate_caps |= WMI_HOST_RC_CW40_FLAG;
 	}
 
+	/* As firmware handles these two flags (IEEE80211_HT_CAP_SGI_20
+	 * and IEEE80211_HT_CAP_SGI_40) for enabling SGI, reset both
+	 * flags if guard interval is Default GI
+	 */
+	if (arvif->bitrate_mask.control[band].gi == NL80211_TXRATE_DEFAULT_GI)
+		arg->peer_ht_caps &= ~(IEEE80211_HT_CAP_SGI_20 |
+				IEEE80211_HT_CAP_SGI_40);
+
 	if (arvif->bitrate_mask.control[band].gi != NL80211_TXRATE_FORCE_LGI) {
 		if (ht_cap->cap & (IEEE80211_HT_CAP_SGI_20 |
 		    IEEE80211_HT_CAP_SGI_40))
@@ -1666,11 +1686,12 @@ static void ath12k_peer_assoc_h_vht(struct ath12k *ar,
 	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
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
 
 	if (WARN_ON(ath12k_mac_vif_chan(vif, &def)))
 		return;
@@ -1713,6 +1734,25 @@ static void ath12k_peer_assoc_h_vht(struct ath12k *ar,
 	if (sta->deflink.bandwidth == IEEE80211_STA_RX_BW_160)
 		arg->bw_160 = true;
 
+	vht_nss =  ath12k_mac_max_vht_nss(vht_mcs_mask);
+
+	if (vht_nss > sta->deflink.rx_nss) {
+		user_rate_valid = false;
+		for (nss_idx = sta->deflink.rx_nss - 1; nss_idx >= 0; nss_idx--) {
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
+			   sta->deflink.rx_nss, sta->deflink.addr);
+		vht_mcs_mask[sta->deflink.rx_nss - 1] = vht_mcs_mask[vht_nss - 1];
+	}
+
 	/* Calculate peer NSS capability from VHT capabilities if STA
 	 * supports VHT.
 	 */
@@ -1752,21 +1792,103 @@ static void ath12k_peer_assoc_h_vht(struct ath12k *ar,
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
+					const u16 he_mcs_limit[NL80211_HE_NSS_MAX])
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
 				   struct ieee80211_vif *vif,
 				   struct ieee80211_sta *sta,
 				   struct ath12k_wmi_peer_assoc_arg *arg)
 {
 	const struct ieee80211_sta_he_cap *he_cap = &sta->deflink.he_cap;
+	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
+	struct cfg80211_chan_def def;
 	int i;
 	u8 ampdu_factor, rx_mcs_80, rx_mcs_160, max_nss;
 	u16 mcs_160_map, mcs_80_map;
 	bool support_160;
-	u16 v;
+	enum nl80211_band band;
+	u16 *he_mcs_mask;
+	u8 he_mcs;
+	u16 he_tx_mcs = 0, v = 0;
+	int he_nss, nss_idx;
+	bool user_rate_valid = true;
+
+	if (WARN_ON(ath12k_mac_vif_chan(vif, &def)))
+		return;
 
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
@@ -1873,25 +1995,47 @@ static void ath12k_peer_assoc_h_he(struct ath12k *ar,
 	if (he_cap->he_cap_elem.mac_cap_info[0] & IEEE80211_HE_MAC_CAP0_TWT_REQ)
 		arg->twt_requester = true;
 
+	he_nss = ath12k_mac_max_he_nss(he_mcs_mask);
+
+	if (he_nss > sta->deflink.rx_nss) {
+		user_rate_valid = false;
+		for (nss_idx = sta->deflink.rx_nss - 1; nss_idx >= 0; nss_idx--) {
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
+			   sta->deflink.rx_nss, sta->deflink.addr);
+		he_mcs_mask[sta->deflink.rx_nss - 1] = he_mcs_mask[he_nss - 1];
+	}
+
 	switch (sta->deflink.bandwidth) {
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
@@ -1899,11 +2043,34 @@ static void ath12k_peer_assoc_h_he(struct ath12k *ar,
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
+	arg->peer_nss = min(sta->deflink.rx_nss, max_nss);
+
+	ath12k_dbg(ar->ab, ATH12K_DBG_MAC,
+		   "mac he peer %pM nss %d mcs cnt %d\n",
+		   sta->deflink.addr, arg->peer_nss, arg->peer_he_mcs_count);
 }
 
 static void ath12k_peer_assoc_h_smps(struct ieee80211_sta *sta,
@@ -2141,6 +2308,7 @@ static void ath12k_peer_assoc_h_phymode(struct ath12k *ar,
 	enum nl80211_band band;
 	const u8 *ht_mcs_mask;
 	const u16 *vht_mcs_mask;
+	const u16 *he_mcs_mask;
 	enum wmi_phy_mode phymode = MODE_UNKNOWN;
 
 	if (WARN_ON(ath12k_mac_vif_chan(vif, &def)))
@@ -2149,6 +2317,7 @@ static void ath12k_peer_assoc_h_phymode(struct ath12k *ar,
 	band = def.chan->band;
 	ht_mcs_mask = arvif->bitrate_mask.control[band].ht_mcs;
 	vht_mcs_mask = arvif->bitrate_mask.control[band].vht_mcs;
+	he_mcs_mask = arvif->bitrate_mask.control[band].he_mcs;
 
 	switch (band) {
 	case NL80211_BAND_2GHZ:
@@ -2157,7 +2326,8 @@ static void ath12k_peer_assoc_h_phymode(struct ath12k *ar,
 				phymode = MODE_11BE_EHT40_2G;
 			else
 				phymode = MODE_11BE_EHT20_2G;
-		} else if (sta->deflink.he_cap.has_he) {
+		} else if (sta->deflink.he_cap.has_he &&
+			   !ath12k_peer_assoc_h_he_masked(he_mcs_mask)) {
 			if (sta->deflink.bandwidth == IEEE80211_STA_RX_BW_80)
 				phymode = MODE_11AX_HE80_2G;
 			else if (sta->deflink.bandwidth == IEEE80211_STA_RX_BW_40)
@@ -2187,7 +2357,8 @@ static void ath12k_peer_assoc_h_phymode(struct ath12k *ar,
 		/* Check EHT first */
 		if (sta->deflink.eht_cap.has_eht) {
 			phymode = ath12k_mac_get_phymode_eht(ar, sta);
-		} else if (sta->deflink.he_cap.has_he) {
+		} else if (sta->deflink.he_cap.has_he &&
+			   !ath12k_peer_assoc_h_he_masked(he_mcs_mask)) {
 			phymode = ath12k_mac_get_phymode_he(ar, sta);
 		} else if (sta->deflink.vht_cap.vht_supported &&
 		    !ath12k_peer_assoc_h_vht_masked(vht_mcs_mask)) {
@@ -3691,6 +3862,20 @@ ath12k_mac_bitrate_mask_num_vht_rates(struct ath12k *ar,
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
 ath12k_mac_set_peer_vht_fixed_rate(struct ath12k_vif *arvif,
 				   struct ieee80211_sta *sta,
@@ -3737,6 +3922,57 @@ ath12k_mac_set_peer_vht_fixed_rate(struct ath12k_vif *arvif,
 	return ret;
 }
 
+static int
+ath12k_mac_set_peer_he_fixed_rate(struct ath12k_vif *arvif,
+				  struct ieee80211_sta *sta,
+				  const struct cfg80211_bitrate_mask *mask,
+				  enum nl80211_band band)
+{
+	struct ath12k *ar = arvif->ar;
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
+		ath12k_warn(ar->ab, "No single HE Fixed rate found to set for %pM",
+			    sta->deflink.addr);
+		return -EINVAL;
+	}
+
+	/* Avoid updating invalid nss as fixed rate*/
+	if (nss > sta->deflink.rx_nss)
+		return -EINVAL;
+
+	ath12k_dbg(ar->ab, ATH12K_DBG_MAC,
+		   "Setting Fixed HE Rate for peer %pM. Device will not switch to any other selected rates",
+		   sta->deflink.addr);
+
+	rate_code = ATH12K_HW_RATE_CODE(he_rate, nss - 1,
+					WMI_RATE_PREAMBLE_HE);
+
+	ret = ath12k_wmi_set_peer_param(ar, sta->deflink.addr,
+					arvif->vdev_id,
+					WMI_PEER_PARAM_FIXED_RATE,
+					rate_code);
+	if (ret)
+		ath12k_warn(ar->ab,
+			    "failed to update STA %pM Fixed Rate %d: %d\n",
+			    sta->deflink.addr, rate_code, ret);
+
+	return ret;
+}
+
 static int ath12k_station_assoc(struct ath12k *ar,
 				struct ieee80211_vif *vif,
 				struct ieee80211_sta *sta,
@@ -3748,7 +3984,7 @@ static int ath12k_station_assoc(struct ath12k *ar,
 	struct cfg80211_chan_def def;
 	enum nl80211_band band;
 	struct cfg80211_bitrate_mask *mask;
-	u8 num_vht_rates;
+	u8 num_vht_rates, num_he_rates;
 
 	lockdep_assert_held(&ar->conf_mutex);
 
@@ -3774,15 +4010,19 @@ static int ath12k_station_assoc(struct ath12k *ar,
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
 	if (sta->deflink.vht_cap.vht_supported && num_vht_rates == 1) {
-		ret = ath12k_mac_set_peer_vht_fixed_rate(arvif, sta, mask,
-							 band);
+		ret = ath12k_mac_set_peer_vht_fixed_rate(arvif, sta, mask, band);
+		if (ret)
+			return ret;
+	} else if (sta->deflink.he_cap.has_he && num_he_rates == 1) {
+		ret = ath12k_mac_set_peer_he_fixed_rate(arvif, sta, mask, band);
 		if (ret)
 			return ret;
 	}
@@ -3855,8 +4095,9 @@ static void ath12k_sta_rc_update_wk(struct work_struct *wk)
 	enum nl80211_band band;
 	const u8 *ht_mcs_mask;
 	const u16 *vht_mcs_mask;
+	const u16 *he_mcs_mask;
 	u32 changed, bw, nss, smps, bw_prev;
-	int err, num_vht_rates;
+	int err, num_vht_rates, num_he_rates;
 	const struct cfg80211_bitrate_mask *mask;
 	struct ath12k_wmi_peer_assoc_arg peer_arg;
 	enum wmi_phy_mode peer_phymode;
@@ -3872,6 +4113,7 @@ static void ath12k_sta_rc_update_wk(struct work_struct *wk)
 	band = def.chan->band;
 	ht_mcs_mask = arvif->bitrate_mask.control[band].ht_mcs;
 	vht_mcs_mask = arvif->bitrate_mask.control[band].vht_mcs;
+	he_mcs_mask = arvif->bitrate_mask.control[band].he_mcs;
 
 	spin_lock_bh(&ar->data_lock);
 
@@ -3888,8 +4130,9 @@ static void ath12k_sta_rc_update_wk(struct work_struct *wk)
 	mutex_lock(&ar->conf_mutex);
 
 	nss = max_t(u32, 1, nss);
-	nss = min(nss, max(ath12k_mac_max_ht_nss(ht_mcs_mask),
-			   ath12k_mac_max_vht_nss(vht_mcs_mask)));
+	nss = min(nss, max3(ath12k_mac_max_ht_nss(ht_mcs_mask),
+			    ath12k_mac_max_vht_nss(vht_mcs_mask),
+			    ath12k_mac_max_he_nss(he_mcs_mask)));
 
 	if (changed & IEEE80211_RC_BW_CHANGED) {
 		ath12k_peer_assoc_h_phymode(ar, arvif->vif, sta, &peer_arg);
@@ -3967,6 +4210,8 @@ static void ath12k_sta_rc_update_wk(struct work_struct *wk)
 		mask = &arvif->bitrate_mask;
 		num_vht_rates = ath12k_mac_bitrate_mask_num_vht_rates(ar, band,
 								      mask);
+		num_he_rates = ath12k_mac_bitrate_mask_num_he_rates(ar, band,
+								    mask);
 
 		/* Peer_assoc_prepare will reject vht rates in
 		 * bitrate_mask if its not available in range format and
@@ -3982,11 +4227,24 @@ static void ath12k_sta_rc_update_wk(struct work_struct *wk)
 		if (sta->deflink.vht_cap.vht_supported && num_vht_rates == 1) {
 			ath12k_mac_set_peer_vht_fixed_rate(arvif, sta, mask,
 							   band);
+		} else if (sta->deflink.he_cap.has_he && num_he_rates == 1) {
+			ath12k_mac_set_peer_he_fixed_rate(arvif, sta, mask, band);
 		} else {
-			/* If the peer is non-VHT or no fixed VHT rate
+			/* If the peer is non-VHT/HE or no fixed VHT/HE rate
 			 * is provided in the new bitrate mask we set the
-			 * other rates using peer_assoc command.
+			 * other rates using peer_assoc command. Also clear
+			 * the peer fixed rate settings as it has higher proprity
+			 * than peer assoc
 			 */
+
+			err = ath12k_wmi_set_peer_param(ar, sta->deflink.addr,
+							arvif->vdev_id,
+							WMI_PEER_PARAM_FIXED_RATE,
+							WMI_FIXED_RATE_NONE);
+			if (err)
+				ath12k_warn(ar->ab,
+					    "failed to disable peer fixed rate for STA %pM ret %d\n",
+					    sta->deflink.addr, err);
 			ath12k_peer_assoc_prepare(ar, arvif->vif, sta,
 						  &peer_arg, true);
 
@@ -5926,10 +6184,13 @@ static int ath12k_mac_op_add_interface(struct ieee80211_hw *hw,
 
 	for (i = 0; i < ARRAY_SIZE(arvif->bitrate_mask.control); i++) {
 		arvif->bitrate_mask.control[i].legacy = 0xffffffff;
+		arvif->bitrate_mask.control[i].gi = NL80211_TXRATE_FORCE_SGI;
 		memset(arvif->bitrate_mask.control[i].ht_mcs, 0xff,
 		       sizeof(arvif->bitrate_mask.control[i].ht_mcs));
 		memset(arvif->bitrate_mask.control[i].vht_mcs, 0xff,
 		       sizeof(arvif->bitrate_mask.control[i].vht_mcs));
+		memset(arvif->bitrate_mask.control[i].he_mcs, 0xff,
+		       sizeof(arvif->bitrate_mask.control[i].he_mcs));
 	}
 
 	bit = __ffs64(ab->free_vdev_map);
@@ -7112,9 +7373,26 @@ ath12k_mac_has_single_legacy_rate(struct ath12k *ar,
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
 				       enum nl80211_band band,
@@ -7123,8 +7401,10 @@ ath12k_mac_bitrate_mask_get_single_nss(struct ath12k *ar,
 {
 	struct ieee80211_supported_band *sband = &ar->mac.sbands[band];
 	u16 vht_mcs_map = le16_to_cpu(sband->vht_cap.vht_mcs.tx_mcs_map);
+	u16 he_mcs_map = 0;
 	u8 ht_nss_mask = 0;
 	u8 vht_nss_mask = 0;
+	u8 he_nss_mask = 0;
 	int i;
 
 	/* No need to consider legacy here. Basic rates are always present
@@ -7151,7 +7431,20 @@ ath12k_mac_bitrate_mask_get_single_nss(struct ath12k *ar,
 			return false;
 	}
 
-	if (ht_nss_mask != vht_nss_mask)
+	he_mcs_map = le16_to_cpu(ath12k_mac_get_tx_mcs_map(&sband->iftype_data->he_cap));
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
@@ -7198,54 +7491,158 @@ ath12k_mac_get_single_legacy_rate(struct ath12k *ar,
 	return 0;
 }
 
-static int ath12k_mac_set_fixed_rate_params(struct ath12k_vif *arvif,
-					    u32 rate, u8 nss, u8 sgi, u8 ldpc)
+static int
+ath12k_mac_set_fixed_rate_gi_ltf(struct ath12k_vif *arvif, u8 he_gi, u8 he_ltf)
 {
 	struct ath12k *ar = arvif->ar;
-	u32 vdev_param;
 	int ret;
 
-	lockdep_assert_held(&ar->conf_mutex);
+	/* 0.8 = 0, 1.6 = 2 and 3.2 = 3. */
+	if (he_gi && he_gi != 0xFF)
+		he_gi += 1;
 
-	ath12k_dbg(ar->ab, ATH12K_DBG_MAC, "mac set fixed rate params vdev %i rate 0x%02x nss %u sgi %u\n",
-		   arvif->vdev_id, rate, nss, sgi);
+	ret = ath12k_wmi_vdev_set_param_cmd(ar, arvif->vdev_id,
+					    WMI_VDEV_PARAM_SGI, he_gi);
+	if (ret) {
+		ath12k_warn(ar->ab, "failed to set HE GI:%d, error:%d\n",
+			    he_gi, ret);
+		return ret;
+	}
+	/* start from 1 */
+	if (he_ltf != 0xFF)
+		he_ltf += 1;
 
-	vdev_param = WMI_VDEV_PARAM_FIXED_RATE;
 	ret = ath12k_wmi_vdev_set_param_cmd(ar, arvif->vdev_id,
-					    vdev_param, rate);
+					    WMI_VDEV_PARAM_HE_LTF, he_ltf);
 	if (ret) {
-		ath12k_warn(ar->ab, "failed to set fixed rate param 0x%02x: %d\n",
-			    rate, ret);
+		ath12k_warn(ar->ab, "failed to set HE LTF:%d, error:%d\n",
+			    he_ltf, ret);
 		return ret;
 	}
+	return 0;
+}
+
+static int
+ath12k_mac_set_auto_rate_gi_ltf(struct ath12k_vif *arvif, u16 he_gi, u8 he_ltf)
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
 
-	vdev_param = WMI_VDEV_PARAM_NSS;
 	ret = ath12k_wmi_vdev_set_param_cmd(ar, arvif->vdev_id,
-					    vdev_param, nss);
+					    WMI_VDEV_PARAM_AUTORATE_MISC_CFG,
+					    he_ar_gi_ltf);
 	if (ret) {
-		ath12k_warn(ar->ab, "failed to set nss param %d: %d\n",
-			    nss, ret);
+		ath12k_warn(ar->ab,
+			    "failed to set HE autorate GI:%u, LTF:%u params, error:%d\n",
+			    he_gi, he_ltf, ret);
 		return ret;
 	}
 
-	vdev_param = WMI_VDEV_PARAM_SGI;
+	return 0;
+}
+
+static int ath12k_mac_set_rate_params(struct ath12k_vif *arvif,
+				      u32 rate, u8 nss, u8 sgi, u8 ldpc,
+				      u8 he_gi, u8 he_ltf, bool he_fixed_rate)
+{
+	struct ath12k *ar = arvif->ar;
+	u32 vdev_param;
+	int ret;
+
+	lockdep_assert_held(&ar->conf_mutex);
+
+	ath12k_dbg(ar->ab, ATH12K_DBG_MAC,
+		   "mac set rate params vdev %i rate 0x%02x nss 0x%02x sgi 0x%02x ldpc 0x%02x\n",
+		   arvif->vdev_id, rate, nss, sgi, ldpc);
+
+	ath12k_dbg(ar->ab, ATH12K_DBG_MAC,
+		   "he_gi 0x%02x he_ltf 0x%02x he_fixed_rate %d\n", he_gi,
+		   he_ltf, he_fixed_rate);
+
+	if (!arvif->vif->bss_conf.he_support) {
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
 
+	if (arvif->vif->bss_conf.he_support) {
+		if (he_fixed_rate)
+			ret = ath12k_mac_set_fixed_rate_gi_ltf(arvif, he_gi, he_ltf);
+		else
+			ret = ath12k_mac_set_auto_rate_gi_ltf(arvif, he_gi, he_ltf);
+		if (ret)
+			return ret;
+	} else {
+		vdev_param = WMI_VDEV_PARAM_SGI;
+		ret = ath12k_wmi_vdev_set_param_cmd(ar, arvif->vdev_id,
+						    vdev_param, sgi);
+		if (ret) {
+			ath12k_warn(ar->ab, "failed to set sgi param %d: %d\n",
+				    sgi, ret);
+			return ret;
+		}
+	}
+
 	return 0;
 }
 
@@ -7274,6 +7671,31 @@ ath12k_mac_vht_mcs_range_present(struct ath12k *ar,
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
@@ -7305,6 +7727,54 @@ static void ath12k_mac_disable_peer_fixed_rate(void *data,
 			    sta->addr, ret);
 }
 
+static int
+ath12k_mac_validate_vht_he_fixed_rate_settings(struct ath12k *ar, enum nl80211_band band,
+					       const struct cfg80211_bitrate_mask *mask)
+{
+	bool he_fixed_rate = false, vht_fixed_rate = false;
+	struct ath12k_peer *peer;
+	const u16 *vht_mcs_mask, *he_mcs_mask;
+	u8 vht_nss, he_nss;
+	int ret = 0;
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
+		return 0;
+
+	vht_nss = ath12k_mac_max_vht_nss(vht_mcs_mask);
+	he_nss =  ath12k_mac_max_he_nss(he_mcs_mask);
+
+	rcu_read_lock();
+	spin_lock_bh(&ar->ab->base_lock);
+	list_for_each_entry(peer, &ar->ab->peers, list) {
+		if (peer->sta) {
+			if (vht_fixed_rate &&
+			    (!peer->sta->deflink.vht_cap.vht_supported ||
+			    peer->sta->deflink.rx_nss < vht_nss)) {
+				ret = -EINVAL;
+				goto exit;
+			}
+			if (he_fixed_rate && (!peer->sta->deflink.he_cap.has_he ||
+					      peer->sta->deflink.rx_nss < he_nss)) {
+				ret = -EINVAL;
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
@@ -7316,6 +7786,9 @@ ath12k_mac_op_set_bitrate_mask(struct ieee80211_hw *hw,
 	enum nl80211_band band;
 	const u8 *ht_mcs_mask;
 	const u16 *vht_mcs_mask;
+	const u16 *he_mcs_mask;
+	u8 he_ltf = 0;
+	u8 he_gi = 0;
 	u32 rate;
 	u8 nss;
 	u8 sgi;
@@ -7323,6 +7796,7 @@ ath12k_mac_op_set_bitrate_mask(struct ieee80211_hw *hw,
 	int single_nss;
 	int ret;
 	int num_rates;
+	bool he_fixed_rate = false;
 
 	if (ath12k_mac_vif_chan(vif, &def))
 		return -EPERM;
@@ -7330,6 +7804,7 @@ ath12k_mac_op_set_bitrate_mask(struct ieee80211_hw *hw,
 	band = def.chan->band;
 	ht_mcs_mask = mask->control[band].ht_mcs;
 	vht_mcs_mask = mask->control[band].vht_mcs;
+	he_mcs_mask = mask->control[band].he_mcs;
 	ldpc = !!(ar->ht_cap_info & WMI_HT_CAP_LDPC);
 
 	sgi = mask->control[band].gi;
@@ -7338,6 +7813,9 @@ ath12k_mac_op_set_bitrate_mask(struct ieee80211_hw *hw,
 		goto out;
 	}
 
+	he_gi = mask->control[band].he_gi;
+	he_ltf = mask->control[band].he_ltf;
+
 	/* mac80211 doesn't support sending a fixed HT/VHT MCS alone, rather it
 	 * requires passing at least one of used basic rates along with them.
 	 * Fixed rate setting across different preambles(legacy, HT, VHT) is
@@ -7361,11 +7839,22 @@ ath12k_mac_op_set_bitrate_mask(struct ieee80211_hw *hw,
 							  &single_nss)) {
 		rate = WMI_FIXED_RATE_NONE;
 		nss = single_nss;
+		mutex_lock(&ar->conf_mutex);
+		arvif->bitrate_mask = *mask;
+		ieee80211_iterate_stations_atomic(hw,
+						  ath12k_mac_set_bitrate_mask_iter,
+						  arvif);
+		mutex_unlock(&ar->conf_mutex);
 	} else {
 		rate = WMI_FIXED_RATE_NONE;
+
+		if (!ath12k_mac_validate_vht_he_fixed_rate_settings(ar, band, mask))
+			ath12k_warn(ar->ab,
+				    "could not update fixed rate settings to all peers due to mcs/nss incompatiblity\n");
 		nss = min_t(u32, ar->num_tx_chains,
-			    max(ath12k_mac_max_ht_nss(ht_mcs_mask),
-				ath12k_mac_max_vht_nss(vht_mcs_mask)));
+			    max3(ath12k_mac_max_ht_nss(ht_mcs_mask),
+				 ath12k_mac_max_vht_nss(vht_mcs_mask),
+				 ath12k_mac_max_he_nss(he_mcs_mask)));
 
 		/* If multiple rates across different preambles are given
 		 * we can reconfigure this info with all peers using PEER_ASSOC
@@ -7401,12 +7890,22 @@ ath12k_mac_op_set_bitrate_mask(struct ieee80211_hw *hw,
 			goto out;
 		}
 
+		num_rates = ath12k_mac_bitrate_mask_num_he_rates(ar, band, mask);
+		if (num_rates == 1)
+			he_fixed_rate = true;
+
+		if (!ath12k_mac_he_mcs_range_present(ar, band, mask) &&
+		    num_rates > 1) {
+			ath12k_warn(ar->ab,
+				    "Setting more than one HE MCS Value in bitrate mask not supported\n");
+			return -EINVAL;
+		}
+
+		mutex_lock(&ar->conf_mutex);
 		ieee80211_iterate_stations_atomic(hw,
 						  ath12k_mac_disable_peer_fixed_rate,
 						  arvif);
 
-		mutex_lock(&ar->conf_mutex);
-
 		arvif->bitrate_mask = *mask;
 		ieee80211_iterate_stations_atomic(hw,
 						  ath12k_mac_set_bitrate_mask_iter,
@@ -7417,9 +7916,10 @@ ath12k_mac_op_set_bitrate_mask(struct ieee80211_hw *hw,
 
 	mutex_lock(&ar->conf_mutex);
 
-	ret = ath12k_mac_set_fixed_rate_params(arvif, rate, nss, sgi, ldpc);
+	ret = ath12k_mac_set_rate_params(arvif, rate, nss, sgi, ldpc, he_gi,
+					 he_ltf, he_fixed_rate);
 	if (ret) {
-		ath12k_warn(ar->ab, "failed to set fixed rate params on vdev %i: %d\n",
+		ath12k_warn(ar->ab, "failed to set rate params on vdev %i: %d\n",
 			    arvif->vdev_id, ret);
 	}
 
diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
index cf273298227d..ee90345431f2 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -219,6 +219,22 @@ enum WMI_HOST_WLAN_BAND {
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
@@ -1128,7 +1144,9 @@ enum wmi_tlv_vdev_param {
 	WMI_VDEV_PARAM_HE_RANGE_EXT,
 	WMI_VDEV_PARAM_ENABLE_BCAST_PROBE_RESPONSE,
 	WMI_VDEV_PARAM_FILS_MAX_CHANNEL_GUARD_TIME,
+	WMI_VDEV_PARAM_HE_LTF = 0x74,
 	WMI_VDEV_PARAM_BA_MODE = 0x7e,
+	WMI_VDEV_PARAM_AUTORATE_MISC_CFG = 0x80,
 	WMI_VDEV_PARAM_SET_HE_SOUNDING_MODE = 0x87,
 	WMI_VDEV_PARAM_6GHZ_PARAMS = 0x99,
 	WMI_VDEV_PARAM_PROTOTYPE = 0x8000,
-- 
2.17.1


