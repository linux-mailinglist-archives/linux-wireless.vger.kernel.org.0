Return-Path: <linux-wireless+bounces-5243-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2370088B0FF
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Mar 2024 21:12:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A52351FA4883
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Mar 2024 20:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A21653365;
	Mon, 25 Mar 2024 20:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="CjswlstB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4794CDFB
	for <linux-wireless@vger.kernel.org>; Mon, 25 Mar 2024 20:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711397460; cv=none; b=LbCvcaXzL+goqeT6/C9iRipCdwC4WqFEFvphJL4MUD43P9+FimHHMITWekblID2w+N59OrSGpqY1N5bWuSmS7bVUZTMGxiqly9vdhrpQadazISbWS/5N9j4ARKqgMWdTCjmnzpGU1XpbS2MU51cFHvqesFYNoVMTeegH7IsMiUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711397460; c=relaxed/simple;
	bh=3NBDKLUf1MHUzkBXCD3Sxsn0J6nigW5zWKAwHH8izVc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GCATurUS+ltCrAW1emnl1nRu0ih7XMhyc9ml9EdzQvsXDVVsDs+It8sdLXVVsT564YkvWdC6K7Bwy7MHP9ImCZcaK1o4GGEMSKv1PYHeb5gWAkttFpRQzSLE9jrkFlGO5Gu/zCVsKbzs4cMvJNy3RuS+QvytIBKyivEDN+A0Lf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=CjswlstB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42PJPPCV013515;
	Mon, 25 Mar 2024 20:10:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=IU1jkUH46j51OlFX8bd2
	IKPiuNkxaKJMKd0QpuKP5uo=; b=CjswlstB2ClsT0aNgVdR5GsDmkPnVR76FnvQ
	vQDf799ZdXGKFe1S50khKH2mjZxxlwf7ltBIOKHISOpT/S07sJAc3hLtYCreIYre
	qnSFHJCZhdt5tzImMA1iA0UtD6L4zHF0AVeA/wOZ/ekWOpUaEfyn8G7K3hULCHNF
	fpHhGUqJwZQaHPeFOeVEQMSW5NJUgRSqQHiNBhJ48R2DKIfp9f5+YQJk1eSXHhzC
	WN0Bw3x/iaVHaLJatAdzfWGBYAWCqujAKwVXGqOMLk41cbir8Ul7BfcijNAk7OKA
	iRnn9joIhzTkpyUxdH9lt2BRLVESBNjgNG0tzD31Sl2vok+q1g==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x34hssr99-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Mar 2024 20:10:53 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42PKAqfR000531
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
	<quic_pradeepc@quicinc.com>
Subject: [PATCH 08/10] wifi: ath12k: clean up 80P80 support
Date: Mon, 25 Mar 2024 13:10:29 -0700
Message-ID: <20240325201031.10837-9-quic_pradeepc@quicinc.com>
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
X-Proofpoint-ORIG-GUID: 2HGBCccNsj1rgknC3lLnswpzoFBthPdn
X-Proofpoint-GUID: 2HGBCccNsj1rgknC3lLnswpzoFBthPdn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-25_18,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 spamscore=0 phishscore=0 lowpriorityscore=0 mlxscore=0 bulkscore=0
 impostorscore=0 clxscore=1015 mlxlogscore=999 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403250121

Clean up unused 80P80 references as hardware does not support
it. This is applicable to both QCN9274 and WCN7850.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Signed-off-by: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 51 ++++++---------------------
 drivers/net/wireless/ath/ath12k/wmi.c |  5 +--
 drivers/net/wireless/ath/ath12k/wmi.h |  1 -
 3 files changed, 11 insertions(+), 46 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 72232285d2b1..51d3219ac3e6 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -198,7 +198,7 @@ ath12k_phymodes[NUM_NL80211_BANDS][ATH12K_CHAN_WIDTH_NUM] = {
 			[NL80211_CHAN_WIDTH_40] = MODE_11BE_EHT40,
 			[NL80211_CHAN_WIDTH_80] = MODE_11BE_EHT80,
 			[NL80211_CHAN_WIDTH_160] = MODE_11BE_EHT160,
-			[NL80211_CHAN_WIDTH_80P80] = MODE_11BE_EHT80_80,
+			[NL80211_CHAN_WIDTH_80P80] = MODE_UNKNOWN,
 			[NL80211_CHAN_WIDTH_320] = MODE_11BE_EHT320,
 	},
 	[NL80211_BAND_6GHZ] = {
@@ -209,7 +209,7 @@ ath12k_phymodes[NUM_NL80211_BANDS][ATH12K_CHAN_WIDTH_NUM] = {
 			[NL80211_CHAN_WIDTH_40] = MODE_11BE_EHT40,
 			[NL80211_CHAN_WIDTH_80] = MODE_11BE_EHT80,
 			[NL80211_CHAN_WIDTH_160] = MODE_11BE_EHT160,
-			[NL80211_CHAN_WIDTH_80P80] = MODE_11BE_EHT80_80,
+			[NL80211_CHAN_WIDTH_80P80] = MODE_UNKNOWN,
 			[NL80211_CHAN_WIDTH_320] = MODE_11BE_EHT320,
 	},
 
@@ -2016,17 +2016,6 @@ static void ath12k_peer_assoc_h_he(struct ath12k *ar,
 
 	switch (sta->deflink.bandwidth) {
 	case IEEE80211_STA_RX_BW_160:
-		if (he_cap->he_cap_elem.phy_cap_info[0] &
-		    IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_80PLUS80_MHZ_IN_5G) {
-			v = ath12k_peer_assoc_h_he_limit(v, he_mcs_mask);
-			arg->peer_he_rx_mcs_set[WMI_HECAP_TXRX_MCS_NSS_IDX_80_80] = v;
-
-			v = le16_to_cpu(he_cap->he_mcs_nss_supp.tx_mcs_80p80);
-			arg->peer_he_tx_mcs_set[WMI_HECAP_TXRX_MCS_NSS_IDX_80_80] = v;
-
-			arg->peer_he_mcs_count++;
-			he_tx_mcs = v;
-		}
 		v = le16_to_cpu(he_cap->he_mcs_nss_supp.rx_mcs_160);
 		arg->peer_he_rx_mcs_set[WMI_HECAP_TXRX_MCS_NSS_IDX_160] = v;
 
@@ -2213,16 +2202,11 @@ static enum wmi_phy_mode ath12k_mac_get_phymode_vht(struct ath12k *ar,
 						    struct ieee80211_sta *sta)
 {
 	if (sta->deflink.bandwidth == IEEE80211_STA_RX_BW_160) {
-		switch (sta->deflink.vht_cap.cap &
-			IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_MASK) {
-		case IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_160MHZ:
-			return MODE_11AC_VHT160;
-		case IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_160_80PLUS80MHZ:
-			return MODE_11AC_VHT80_80;
-		default:
-			/* not sure if this is a valid case? */
+		if (sta->deflink.vht_cap.cap &
+		    IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_160MHZ)
 			return MODE_11AC_VHT160;
-		}
+
+		return MODE_UNKNOWN;
 	}
 
 	if (sta->deflink.bandwidth == IEEE80211_STA_RX_BW_80)
@@ -2244,11 +2228,8 @@ static enum wmi_phy_mode ath12k_mac_get_phymode_he(struct ath12k *ar,
 		if (sta->deflink.he_cap.he_cap_elem.phy_cap_info[0] &
 		     IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_160MHZ_IN_5G)
 			return MODE_11AX_HE160;
-		else if (sta->deflink.he_cap.he_cap_elem.phy_cap_info[0] &
-		     IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_80PLUS80_MHZ_IN_5G)
-			return MODE_11AX_HE80_80;
-		/* not sure if this is a valid case? */
-		return MODE_11AX_HE160;
+
+		return MODE_UNKNOWN;
 	}
 
 	if (sta->deflink.bandwidth == IEEE80211_STA_RX_BW_80)
@@ -2276,14 +2257,7 @@ static enum wmi_phy_mode ath12k_mac_get_phymode_eht(struct ath12k *ar,
 		    IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_160MHZ_IN_5G)
 			return MODE_11BE_EHT160;
 
-		if (sta->deflink.he_cap.he_cap_elem.phy_cap_info[0] &
-			 IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_80PLUS80_MHZ_IN_5G)
-			return MODE_11BE_EHT80_80;
-
-		ath12k_warn(ar->ab, "invalid EHT PHY capability info for 160 Mhz: %d\n",
-			    sta->deflink.he_cap.he_cap_elem.phy_cap_info[0]);
-
-		return MODE_11BE_EHT160;
+		return MODE_UNKNOWN;
 	}
 
 	if (sta->deflink.bandwidth == IEEE80211_STA_RX_BW_80)
@@ -5165,8 +5139,6 @@ static void ath12k_mac_set_hemcsmap(struct ath12k *ar,
 	mcs_nss->tx_mcs_80 = cpu_to_le16(txmcs_map & 0xffff);
 	mcs_nss->rx_mcs_160 = cpu_to_le16(rxmcs_map & 0xffff);
 	mcs_nss->tx_mcs_160 = cpu_to_le16(txmcs_map & 0xffff);
-	mcs_nss->rx_mcs_80p80 = cpu_to_le16(rxmcs_map & 0xffff);
-	mcs_nss->tx_mcs_80p80 = cpu_to_le16(txmcs_map & 0xffff);
 }
 
 static void ath12k_mac_copy_he_cap(struct ath12k *ar,
@@ -5188,6 +5160,7 @@ static void ath12k_mac_copy_he_cap(struct ath12k *ar,
 		IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_IN_2G |
 		IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_80MHZ_IN_5G |
 		IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_160MHZ_IN_5G;
+	/* 80PLUS80 is not supported */
 	he_cap_elem->phy_cap_info[0] &=
 		~IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_80PLUS80_MHZ_IN_5G;
 	he_cap_elem->phy_cap_info[5] &=
@@ -7382,10 +7355,6 @@ ath12k_mac_has_single_legacy_rate(struct ath12k *ar,
 static __le16
 ath12k_mac_get_tx_mcs_map(const struct ieee80211_sta_he_cap *he_cap)
 {
-	if (he_cap->he_cap_elem.phy_cap_info[0] &
-	    IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_80PLUS80_MHZ_IN_5G)
-		return he_cap->he_mcs_nss_supp.tx_mcs_80p80;
-
 	if (he_cap->he_cap_elem.phy_cap_info[0] &
 	    IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_160MHZ_IN_5G)
 		return he_cap->he_mcs_nss_supp.tx_mcs_160;
diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index c550ced42084..2e6a45225228 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -978,10 +978,7 @@ static void ath12k_wmi_put_wmi_channel(struct ath12k_wmi_channel_params *chan,
 
 	chan->mhz = cpu_to_le32(arg->freq);
 	chan->band_center_freq1 = cpu_to_le32(arg->band_center_freq1);
-	if (arg->mode == MODE_11AC_VHT80_80)
-		chan->band_center_freq2 = cpu_to_le32(arg->band_center_freq2);
-	else
-		chan->band_center_freq2 = 0;
+	chan->band_center_freq2 = 0;
 
 	chan->info |= le32_encode_bits(arg->mode, WMI_CHAN_INFO_MODE);
 	if (arg->passive)
diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
index ee90345431f2..00871d6be3ea 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -3567,7 +3567,6 @@ struct wmi_vdev_install_key_arg {
 #define WMI_HOST_MAX_HE_RATE_SET		3
 #define WMI_HECAP_TXRX_MCS_NSS_IDX_80		0
 #define WMI_HECAP_TXRX_MCS_NSS_IDX_160		1
-#define WMI_HECAP_TXRX_MCS_NSS_IDX_80_80	2
 
 struct wmi_rate_set_arg {
 	u32 num_rates;
-- 
2.17.1


