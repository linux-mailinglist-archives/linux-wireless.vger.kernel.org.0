Return-Path: <linux-wireless+bounces-24692-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30931AEEBC7
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Jul 2025 03:05:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DF5C1BC4DE8
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Jul 2025 01:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A6AD1C2437;
	Tue,  1 Jul 2025 01:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="k7522as+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8183518FDBD
	for <linux-wireless@vger.kernel.org>; Tue,  1 Jul 2025 01:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751331869; cv=none; b=RRRrFrrLq+hjBiHuGpLZc6dRRD+B3k+zotq+LnO9u+YM8tYLyNNLU5HeylRcYF5BG/g90QjEF32wz85iZ9iz7vM5HIP9trX4ZOFQDLFNjkUe/g/m2Q4GxeOH9Lq9E8b9o6m184jNMf0DRniR2lrRk8P/nenmv+UFjmvpUiUzz3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751331869; c=relaxed/simple;
	bh=Q9yBR1ul9hliZubZjTn53sH3v1H6i0BOTzaI2ey+/hA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KNn+uX9XkJvlUCTZuUVDO/+pePAY6QOaoPP0S94lmq2k2SR2CyWdb39NrcaxX4Pye3cSYTMNbsdnAvVBzfS+AXb+2oERUOcmtFdqi9KFguJwqfmLz2PJGo2d50ZkKNmT0AZwtsisCDf/v/O+HAPkNVGZkpjYKMnfxcd/WOZXk2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=k7522as+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55UFfPNC029431;
	Tue, 1 Jul 2025 01:04:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sHb8PmfpHR6ayIRVEWtEORd09LKg4ndrL4jFh/Hqo9g=; b=k7522as+YM8ZUb6a
	ktYHosF1EDBlTQAdk66dYhmUuNtnIfR8dDZUrCHHQkwW2hUfIxgd1XkHCyWa8wFk
	TJb01klh/qyZqKmprwJC0WWWKAeC4vEby3UuKm8e5Q8uY47kc1i5o+rK1o77Lcx0
	bfmx00TWTRQ9gpISMlLZrFmqshSbAYROfG2HIH1fGtPmgOvBcbB5kxJ6MmgYF3cq
	NI0M7OLKqrMWn1fZDJ7jUHm/UEUd8rEC87E7DortdmXvPijkapnjpeB9G0Dhih5s
	/DmCrlvIjSL0lx/cMa7h3G2FTzrvpToYMfBG5M/I93rOfWom5jVT7LogMTQDUXKc
	ELRErw==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47j95hxfe5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Jul 2025 01:04:24 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 56114Op7017264
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 1 Jul 2025 01:04:24 GMT
Received: from ath12k-linux2.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 30 Jun 2025 18:04:23 -0700
From: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Pradeep Kumar Chitrapu
	<quic_pradeepc@quicinc.com>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
Subject: [PATCH ath-next V15 7/9] wifi: ath12k: clean up 80P80 support
Date: Mon, 30 Jun 2025 18:04:06 -0700
Message-ID: <20250701010408.1257201-8-quic_pradeepc@quicinc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250701010408.1257201-1-quic_pradeepc@quicinc.com>
References: <20250701010408.1257201-1-quic_pradeepc@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAxMDAwMyBTYWx0ZWRfX8Gz3gxKSS+XW
 w3MFel8eClJmKyGO2V/9qiVX7K+xUfHeF4eW5u3mMcl3hAWZcE9faJj/iBuuecJ5YnFBIKglWnK
 kXkxAoVn6pobh1hsx8d0QAMXHvoYtlxiSVzNmoAAzjIN7n/IJgKqN6aBYDaOVCg/AeAC6Pz8Qlv
 D4zGYJYIMvBo/zhG8WoWiJyj1XWpkHzicc/R2Ci2l70HW/FLAuV5CEgQqX6pADyZ+36nopeXhG3
 OfNQT33wZsT9cahJN6melXw98+G7eXKLXU8h9vIDfauj2jc0RSMhvvw4dKaK9z+2jmNQ69fks3C
 2RfYox8cd68XorfMcbBPMRYFMOKBsAELe7TJWNf7Laf+fzTvvN03A0GQt40ji/KcJQL4J1NNTSL
 FfIhG63JdwlCdw3pXfY69omUwo+EPyYqHNUEstU+6cYO8kbwMEFiqh2zeqUaZAZCsdMOP2Hd
X-Proofpoint-ORIG-GUID: SHKCk-c33O7H5lyvwniemj6oe0taOsBY
X-Authority-Analysis: v=2.4 cv=EuHSrTcA c=1 sm=1 tr=0 ts=68633418 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=Wb1JkmetP80A:10 a=COk6AnOGAAAA:8 a=QHHbJxpVzSBZVvfXPLwA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: SHKCk-c33O7H5lyvwniemj6oe0taOsBY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-30_06,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxlogscore=999 malwarescore=0 mlxscore=0 phishscore=0
 spamscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507010003

Clean up unused 80P80 references as hardware does not support
it. This is applicable to both QCN9274 and WCN7850.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Signed-off-by: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 48 ++++++---------------------
 drivers/net/wireless/ath/ath12k/wmi.c |  2 --
 drivers/net/wireless/ath/ath12k/wmi.h |  1 -
 3 files changed, 10 insertions(+), 41 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index aefb620b28e2..8fba1bd2e372 100644
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
 
@@ -2574,17 +2574,6 @@ static void ath12k_peer_assoc_h_he(struct ath12k *ar,
 
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
 
@@ -2871,16 +2860,11 @@ static enum wmi_phy_mode ath12k_mac_get_phymode_vht(struct ath12k *ar,
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
@@ -2902,11 +2886,8 @@ static enum wmi_phy_mode ath12k_mac_get_phymode_he(struct ath12k *ar,
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
@@ -2934,14 +2915,10 @@ static enum wmi_phy_mode ath12k_mac_get_phymode_eht(struct ath12k *ar,
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
@@ -7828,8 +7805,6 @@ static void ath12k_mac_set_hemcsmap(struct ath12k *ar,
 	mcs_nss->tx_mcs_80 = cpu_to_le16(txmcs_map & 0xffff);
 	mcs_nss->rx_mcs_160 = cpu_to_le16(rxmcs_map & 0xffff);
 	mcs_nss->tx_mcs_160 = cpu_to_le16(txmcs_map & 0xffff);
-	mcs_nss->rx_mcs_80p80 = cpu_to_le16(rxmcs_map & 0xffff);
-	mcs_nss->tx_mcs_80p80 = cpu_to_le16(txmcs_map & 0xffff);
 }
 
 static void ath12k_mac_copy_he_cap(struct ath12k *ar,
@@ -7851,6 +7826,7 @@ static void ath12k_mac_copy_he_cap(struct ath12k *ar,
 		IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_IN_2G |
 		IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_80MHZ_IN_5G |
 		IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_160MHZ_IN_5G;
+	/* 80PLUS80 is not supported */
 	he_cap_elem->phy_cap_info[0] &=
 		~IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_80PLUS80_MHZ_IN_5G;
 	he_cap_elem->phy_cap_info[5] &=
@@ -11541,10 +11517,6 @@ ath12k_mac_has_single_legacy_rate(struct ath12k *ar,
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
index cdf3406302ee..1ad21bd1583a 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -1066,8 +1066,6 @@ static void ath12k_wmi_put_wmi_channel(struct ath12k_wmi_channel_params *chan,
 			chan->band_center_freq1 = cpu_to_le32(center_freq1 - 40);
 
 		chan->band_center_freq2 = cpu_to_le32(center_freq1);
-	} else if (arg->mode == MODE_11BE_EHT80_80) {
-		chan->band_center_freq2 = cpu_to_le32(arg->band_center_freq2);
 	} else {
 		chan->band_center_freq2 = 0;
 	}
diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
index be3672304478..74f3ab90bbcd 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -3804,7 +3804,6 @@ struct wmi_vdev_install_key_arg {
 #define WMI_HOST_MAX_HE_RATE_SET		3
 #define WMI_HECAP_TXRX_MCS_NSS_IDX_80		0
 #define WMI_HECAP_TXRX_MCS_NSS_IDX_160		1
-#define WMI_HECAP_TXRX_MCS_NSS_IDX_80_80	2
 
 #define ATH12K_WMI_MLO_MAX_PARTNER_LINKS \
 	(ATH12K_WMI_MLO_MAX_LINKS + ATH12K_MAX_NUM_BRIDGE_LINKS - 1)
-- 
2.43.0


