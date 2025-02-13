Return-Path: <linux-wireless+bounces-18877-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B2C2A33494
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Feb 2025 02:25:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B972188A114
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Feb 2025 01:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1693480604;
	Thu, 13 Feb 2025 01:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="PZI4b1eG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52AD8139579
	for <linux-wireless@vger.kernel.org>; Thu, 13 Feb 2025 01:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739409901; cv=none; b=F3NqkF6k/btbG073Ixfjsu+wWa18nVbKi8wI5fxfNPU8eBbzdn3HZh81zHo6BFNa4wKq+jV1f6zMba2XqESa1RkfU4hjFZsKlu2K6eu7ouD2Umwrw6QC2l4sAIuTCsFTq7r385THDhmK9XjgQunW7DjSlGLDf3JaVsaD0o8/fMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739409901; c=relaxed/simple;
	bh=Xx2Ii1zaJMo3/ZgtcRu5jwOVjlDv25lwj18jvNHN0lc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WZ9OMzy/qUycy2Fc3ImwXhQrvIK2pvoX7NsQdpSlq51NzeBGShRx7NYSB1WJzhmbbdlJUVk3fDxXj0PjoyUFkkBZBQSs3tbMq7L2Orl31skfJW6l2OCkCGy+BT99ya6hdYHdwOgMvWK5IjaUZ6zpqhr53Fl/RdBDgv9Omm3fZrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=PZI4b1eG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51CI2h43025864;
	Thu, 13 Feb 2025 01:24:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Wk/eGtrXFeZ+pDQ+V9ZUdqFfnlRruO/M6S69i8BpXe0=; b=PZI4b1eGu4+oaqEZ
	EgQ0q2Hrt8UMRlaraq05NW/cD02ZftWO93No/R3UIBkuAVHF07N+fNQ2vhrnIejb
	cIO6h/BXPYXSExZ+CDX5PNj5mv3jLTK4Bibb/JLLzVrpH4CtGZIqkm1UvsvIjgWc
	hW+6XKiH6H/WvJj9GvrYfwDj8xnLcmsv7QpqzcKdu059TnqMrjwojgqJkDG0yifj
	Z6b/TJafmQ8l/H4Zr9fNB/ZtHNy/dGDiACFkh8awy4G/Gd0bLathm2cufxdUbP7n
	Kc/8hWfxNoeBK0vUbIrgnEGrEMc/rf/pi6GATrJntlkJJz3bCv9raZ5CmHZsDo8l
	m9O4VA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44r5j5dfgx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Feb 2025 01:24:54 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51D1OrZ1005943
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
        Jeff Johnson <quic_jjohnson@quicinc.com>
Subject: [PATCH V10 7/9] wifi: ath12k: clean up 80P80 support
Date: Wed, 12 Feb 2025 17:24:37 -0800
Message-ID: <20250213012439.278373-8-quic_pradeepc@quicinc.com>
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
X-Proofpoint-ORIG-GUID: SokDwRVg6-xkliJiaDQyu72wQnuzQPKG
X-Proofpoint-GUID: SokDwRVg6-xkliJiaDQyu72wQnuzQPKG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-12_08,2025-02-11_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 mlxscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 phishscore=0 adultscore=0 spamscore=0 clxscore=1015 impostorscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502130008

Clean up unused 80P80 references as hardware does not support
it. This is applicable to both QCN9274 and WCN7850.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Signed-off-by: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 48 ++++++---------------------
 drivers/net/wireless/ath/ath12k/wmi.c |  5 +--
 drivers/net/wireless/ath/ath12k/wmi.h |  1 -
 3 files changed, 11 insertions(+), 43 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 6dff8228a670..a8cfa498fab6 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -209,7 +209,7 @@ ath12k_phymodes[NUM_NL80211_BANDS][ATH12K_CHAN_WIDTH_NUM] = {
 			[NL80211_CHAN_WIDTH_40] = MODE_11BE_EHT40,
 			[NL80211_CHAN_WIDTH_80] = MODE_11BE_EHT80,
 			[NL80211_CHAN_WIDTH_160] = MODE_11BE_EHT160,
-			[NL80211_CHAN_WIDTH_80P80] = MODE_11BE_EHT80_80,
+			[NL80211_CHAN_WIDTH_80P80] = MODE_UNKNOWN,
 			[NL80211_CHAN_WIDTH_320] = MODE_11BE_EHT320,
 	},
 	[NL80211_BAND_6GHZ] = {
@@ -220,7 +220,7 @@ ath12k_phymodes[NUM_NL80211_BANDS][ATH12K_CHAN_WIDTH_NUM] = {
 			[NL80211_CHAN_WIDTH_40] = MODE_11BE_EHT40,
 			[NL80211_CHAN_WIDTH_80] = MODE_11BE_EHT80,
 			[NL80211_CHAN_WIDTH_160] = MODE_11BE_EHT160,
-			[NL80211_CHAN_WIDTH_80P80] = MODE_11BE_EHT80_80,
+			[NL80211_CHAN_WIDTH_80P80] = MODE_UNKNOWN,
 			[NL80211_CHAN_WIDTH_320] = MODE_11BE_EHT320,
 	},
 
@@ -2642,17 +2642,6 @@ static void ath12k_peer_assoc_h_he(struct ath12k *ar,
 
 	switch (link_sta->bandwidth) {
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
 
@@ -2937,16 +2926,11 @@ static enum wmi_phy_mode ath12k_mac_get_phymode_vht(struct ath12k *ar,
 						    struct ieee80211_link_sta *link_sta)
 {
 	if (link_sta->bandwidth == IEEE80211_STA_RX_BW_160) {
-		switch (link_sta->vht_cap.cap &
-			IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_MASK) {
-		case IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_160MHZ:
-			return MODE_11AC_VHT160;
-		case IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_160_80PLUS80MHZ:
-			return MODE_11AC_VHT80_80;
-		default:
-			/* not sure if this is a valid case? */
+		if (link_sta->vht_cap.cap & IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_160MHZ)
 			return MODE_11AC_VHT160;
-		}
+
+		/* not sure if this is a valid case? */
+		return MODE_11AC_VHT160;
 	}
 
 	if (link_sta->bandwidth == IEEE80211_STA_RX_BW_80)
@@ -2968,11 +2952,8 @@ static enum wmi_phy_mode ath12k_mac_get_phymode_he(struct ath12k *ar,
 		if (link_sta->he_cap.he_cap_elem.phy_cap_info[0] &
 		     IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_160MHZ_IN_5G)
 			return MODE_11AX_HE160;
-		else if (link_sta->he_cap.he_cap_elem.phy_cap_info[0] &
-		     IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_80PLUS80_MHZ_IN_5G)
-			return MODE_11AX_HE80_80;
-		/* not sure if this is a valid case? */
-		return MODE_11AX_HE160;
+
+		return MODE_UNKNOWN;
 	}
 
 	if (link_sta->bandwidth == IEEE80211_STA_RX_BW_80)
@@ -3000,14 +2981,10 @@ static enum wmi_phy_mode ath12k_mac_get_phymode_eht(struct ath12k *ar,
 		    IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_160MHZ_IN_5G)
 			return MODE_11BE_EHT160;
 
-		if (link_sta->he_cap.he_cap_elem.phy_cap_info[0] &
-			 IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_80PLUS80_MHZ_IN_5G)
-			return MODE_11BE_EHT80_80;
-
 		ath12k_warn(ar->ab, "invalid EHT PHY capability info for 160 Mhz: %d\n",
 			    link_sta->he_cap.he_cap_elem.phy_cap_info[0]);
 
-		return MODE_11BE_EHT160;
+		return MODE_UNKNOWN;
 	}
 
 	if (link_sta->bandwidth == IEEE80211_STA_RX_BW_80)
@@ -7126,8 +7103,6 @@ static void ath12k_mac_set_hemcsmap(struct ath12k *ar,
 	mcs_nss->tx_mcs_80 = cpu_to_le16(txmcs_map & 0xffff);
 	mcs_nss->rx_mcs_160 = cpu_to_le16(rxmcs_map & 0xffff);
 	mcs_nss->tx_mcs_160 = cpu_to_le16(txmcs_map & 0xffff);
-	mcs_nss->rx_mcs_80p80 = cpu_to_le16(rxmcs_map & 0xffff);
-	mcs_nss->tx_mcs_80p80 = cpu_to_le16(txmcs_map & 0xffff);
 }
 
 static void ath12k_mac_copy_he_cap(struct ath12k *ar,
@@ -7149,6 +7124,7 @@ static void ath12k_mac_copy_he_cap(struct ath12k *ar,
 		IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_IN_2G |
 		IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_80MHZ_IN_5G |
 		IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_160MHZ_IN_5G;
+	/* 80PLUS80 is not supported */
 	he_cap_elem->phy_cap_info[0] &=
 		~IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_80PLUS80_MHZ_IN_5G;
 	he_cap_elem->phy_cap_info[5] &=
@@ -10198,10 +10174,6 @@ ath12k_mac_has_single_legacy_rate(struct ath12k *ar,
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
index d1fc8a1ed60f..86dee5fecf4b 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -1041,10 +1041,7 @@ static void ath12k_wmi_put_wmi_channel(struct ath12k_wmi_channel_params *chan,
 
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
index c08a91d9ec2b..aa7fe4234695 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -3762,7 +3762,6 @@ struct wmi_vdev_install_key_arg {
 #define WMI_HOST_MAX_HE_RATE_SET		3
 #define WMI_HECAP_TXRX_MCS_NSS_IDX_80		0
 #define WMI_HECAP_TXRX_MCS_NSS_IDX_160		1
-#define WMI_HECAP_TXRX_MCS_NSS_IDX_80_80	2
 
 #define ATH12K_WMI_MLO_MAX_PARTNER_LINKS \
 	(ATH12K_WMI_MLO_MAX_LINKS + ATH12K_MAX_NUM_BRIDGE_LINKS - 1)
-- 
2.34.1


