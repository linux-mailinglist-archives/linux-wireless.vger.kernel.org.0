Return-Path: <linux-wireless+bounces-6794-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B25478B1471
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Apr 2024 22:21:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D698B1C2241F
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Apr 2024 20:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03EFC13DDAA;
	Wed, 24 Apr 2024 20:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Q1tyHBbf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750BC13DB99
	for <linux-wireless@vger.kernel.org>; Wed, 24 Apr 2024 20:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713990027; cv=none; b=LZCDCj7HQP4BKU/St+TK3z5gQiil03Mm2mHn6Xr71wv6gFJOIRBka1Pp2gO9WMZ+Z9wXnt8vXEUxJm+MUlar5PtFz+r3gh6dGhpowW45WdCovrAwBSeAW00gHYAJqsSvOHKW8vkoBZ2Zbsu7aIl8wZg1++GMpSzMawCfyM+l6Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713990027; c=relaxed/simple;
	bh=oV4gEDndNETDIPHKrT9rgwXuPFYryGuTJV1sWuMU5w8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fuzgfBXOuSPtiR+9XzGh0r/mz7FNiRAywr6MciuYXW8sgkoWQsDRo2VeYFkbTnCEPN94GzFwsa/d09bGMpUsmsIbArJ8frs4btlOYNFmwPx1FIc3+7MNTjbhUlP9LVOfbumjL7jtv0OCby+OsEAF0N/JEDF/054mKpIbl3wX8jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Q1tyHBbf; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43OImQ31010859;
	Wed, 24 Apr 2024 20:20:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=K07fMtpgcGZArbXXNC/f
	ctQ3abTstwNen+mygICienY=; b=Q1tyHBbfj5d16MVQc124/kB/70prPCAl1ixG
	Zu5SXP3awjhuhoNTy1CIRU3Mp++C5kPR0PsiGOcJPrrjec2oKLO7+HtZchrkS0rZ
	tae7i4sd2b/k0QoR+YDUjLn0XEWMPPuVTCBsFiCDgM+ePJ8x8zzqFOmY+mefOuWB
	BDvan/a2+kctgjOAbSZoe79sLpoxgZcwR5nYl1h5vXDrPWNxADBgV6BpyuMxW5TR
	qP6n+tEZZfqBIn/0mOjce8WXLOgFzVrbpdqIK7qmdANlPtBkCS+FqQPYUBWKB62U
	yYTBf83nJ3utqhW6pX7nBa4NhbHwS9jByO49Mg0TVLhq8t2c2A==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xpv9e24bt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 20:20:14 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43OKKE04005182
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 20:20:14 GMT
Received: from pradeepc2-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 24 Apr 2024 13:20:13 -0700
From: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Pradeep Kumar Chitrapu
	<quic_pradeepc@quicinc.com>
Subject: [PATCH v3 10/10] wifi: ath12k: add extended NSS bandwidth support for 160 MHz
Date: Wed, 24 Apr 2024 13:19:59 -0700
Message-ID: <20240424201959.935-11-quic_pradeepc@quicinc.com>
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
X-Proofpoint-GUID: 8BEvApva_ZzBKGGoJkpY6MEfdiU10gp-
X-Proofpoint-ORIG-GUID: 8BEvApva_ZzBKGGoJkpY6MEfdiU10gp-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-24_17,2024-04-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 lowpriorityscore=0 adultscore=0 spamscore=0 impostorscore=0
 phishscore=0 mlxscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404240101

Currently rx and tx MCS map for 160 MHz under HE capabilities
are not updating properly, when 160 MHz is configured with NSS
lesser than max NSS support. Fix this by utilizing
nss_ratio_enabled and nss_ratio_info fields sent by firmware
in service ready event.

However, if firmware advertises EXT NSS BW support in VHT caps
as 1(1x2) and when nss_ratio_info indicates 1:1, reset the EXT
NSS BW Support in VHT caps to 0 which indicates 1x1. This is
to avoid incorrectly chosing 1:2 NSS ratio when using the
default VHT caps advertised by firmware.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Signed-off-by: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 33 ++++++++++++++++++++++-----
 1 file changed, 27 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 87830865bec2..418314ced1d6 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -2225,8 +2225,10 @@ static void ath12k_peer_assoc_h_he(struct ath12k *ar,
 	arg->peer_nss = min(sta->deflink.rx_nss, max_nss);
 
 	if (arg->peer_phymode == MODE_11AX_HE160) {
-		tx_nss = ath12k_get_nss_160mhz(ar, max_nss);
+		tx_nss = ath12k_get_nss_160mhz(ar, ar->num_tx_chains);
 		rx_nss = min(arg->peer_nss, tx_nss);
+
+		arg->peer_nss = min(sta->deflink.rx_nss, ar->num_rx_chains);
 		arg->peer_bw_rxnss_override = ATH12K_BW_NSS_MAP_ENABLE;
 
 		if (!rx_nss) {
@@ -5276,6 +5278,12 @@ ath12k_create_vht_cap(struct ath12k *ar, u32 rate_cap_tx_chainmask,
 	vht_cap.vht_mcs.rx_mcs_map = cpu_to_le16(rxmcs_map);
 	vht_cap.vht_mcs.tx_mcs_map = cpu_to_le16(txmcs_map);
 
+	/* Check if the HW supports 1:1 NSS ratio and reset
+	 * EXT NSS BW Support field to 0 to indicate 1:1 ratio
+	 */
+	if (ar->pdev->cap.nss_ratio_info == WMI_NSS_RATIO_1_NSS)
+		vht_cap.cap &= ~IEEE80211_VHT_CAP_EXT_NSS_BW_MASK;
+
 	return vht_cap;
 }
 
@@ -5458,11 +5466,12 @@ static void ath12k_mac_set_hemcsmap(struct ath12k *ar,
 				    struct ieee80211_sta_he_cap *he_cap)
 {
 	struct ieee80211_he_mcs_nss_supp *mcs_nss = &he_cap->he_mcs_nss_supp;
-	u16 txmcs_map, rxmcs_map;
+	u8 maxtxnss_160 = ath12k_get_nss_160mhz(ar, ar->num_tx_chains);
+	u8 maxrxnss_160 = ath12k_get_nss_160mhz(ar, ar->num_rx_chains);
+	u16 txmcs_map_160 = 0, rxmcs_map_160 = 0;
+	u16 txmcs_map = 0, rxmcs_map = 0;
 	u32 i;
 
-	rxmcs_map = 0;
-	txmcs_map = 0;
 	for (i = 0; i < 8; i++) {
 		if (i < ar->num_tx_chains &&
 		    (ar->cfg_tx_chainmask >> cap->tx_chain_mask_shift) & BIT(i))
@@ -5475,12 +5484,24 @@ static void ath12k_mac_set_hemcsmap(struct ath12k *ar,
 			rxmcs_map |= IEEE80211_HE_MCS_SUPPORT_0_11 << (i * 2);
 		else
 			rxmcs_map |= IEEE80211_HE_MCS_NOT_SUPPORTED << (i * 2);
+
+		if (i < maxtxnss_160 &&
+		    (ar->cfg_tx_chainmask >> cap->tx_chain_mask_shift) & BIT(i))
+			txmcs_map_160 |= IEEE80211_HE_MCS_SUPPORT_0_11 << (i * 2);
+		else
+			txmcs_map_160 |= IEEE80211_HE_MCS_NOT_SUPPORTED << (i * 2);
+
+		if (i < maxrxnss_160 &&
+		    (ar->cfg_tx_chainmask >> cap->tx_chain_mask_shift) & BIT(i))
+			rxmcs_map_160 |= IEEE80211_HE_MCS_SUPPORT_0_11 << (i * 2);
+		else
+			rxmcs_map_160 |= IEEE80211_HE_MCS_NOT_SUPPORTED << (i * 2);
 	}
 
 	mcs_nss->rx_mcs_80 = cpu_to_le16(rxmcs_map & 0xffff);
 	mcs_nss->tx_mcs_80 = cpu_to_le16(txmcs_map & 0xffff);
-	mcs_nss->rx_mcs_160 = cpu_to_le16(rxmcs_map & 0xffff);
-	mcs_nss->tx_mcs_160 = cpu_to_le16(txmcs_map & 0xffff);
+	mcs_nss->rx_mcs_160 = cpu_to_le16(rxmcs_map_160 & 0xffff);
+	mcs_nss->tx_mcs_160 = cpu_to_le16(txmcs_map_160 & 0xffff);
 }
 
 static void ath12k_mac_copy_he_cap(struct ath12k *ar,
-- 
2.17.1


