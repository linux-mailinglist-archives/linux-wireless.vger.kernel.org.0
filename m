Return-Path: <linux-wireless+bounces-7318-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 902AF8BF38A
	for <lists+linux-wireless@lfdr.de>; Wed,  8 May 2024 02:21:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B46671C23413
	for <lists+linux-wireless@lfdr.de>; Wed,  8 May 2024 00:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37C823D9E;
	Wed,  8 May 2024 00:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="iDpc29KS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F79376
	for <linux-wireless@vger.kernel.org>; Wed,  8 May 2024 00:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715127674; cv=none; b=iQGXVTZQ6iC+h7nWF6jDlGUe4tsjT2llvym24gyYqNXYK1ZW8b0ia09c4VbzJJzfsu3qktYFaSkwoLFyCzoKw51Fj7VcsnnKUXHHULMCZOKYlqnfetx0YaRVoDxqlUbiO9RxRE8HDHMP28HeZADzyJpYMcxS/CP32P2JXplH1KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715127674; c=relaxed/simple;
	bh=kmH/3BORwhsf72JWDRuCQn5hyf3iVodfxXi8lWpSSoc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iRir58uA1VC3rSeQ8a0rq67y6fo9KD5GhSW2Cb1pl/zuK7AIvnGBFKfBdmqbFeDg3ldaH7guY2lZyLmB50Cb6f5gYOfpk0XYGdRtvjr2UBc5B6aBtelBSLLq24gDY42nwZXZegp5ey0+mFO5HUaqvGPvSiOB7fPPOdLC+e9rN9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=iDpc29KS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 447LUpm4022774;
	Wed, 8 May 2024 00:21:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=CC9M9XRkdulY62ZELhkK
	OPURNVOCxJ4FXcRUM3o7SwI=; b=iDpc29KSXAH58tCfUf8JNmMV6i+YCxmDuOIQ
	aYLmJuSC66fpNYJo6cws+3f7hyDgKtG6pODfeimw+dsK1np51SX/GJ4ptNNiWIEF
	dHC9Gul4HmRlouATqxzeCKQAGxoLehfsnBZktwmVAtYVpdl40Y/sbZ0njjOKBEhW
	sFXLMj9DCoAeird+aOUK3LeTRHEr4cPfkl5ZLKdwg4bOnfMhFUDRAantgotS6h5A
	zYt3clJxGcfnwcvIF0HXVwn/5uGdLo1i5iTp//KsU/AG1D5YwsqIJI85ScfCpJy+
	ReScovWvIWln2tmbv2YOo6KpO4Ugs8uGQitvrqfybZZ9+z34eA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xysgc8kvb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 May 2024 00:21:09 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4480L9US021214
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 8 May 2024 00:21:09 GMT
Received: from pradeepc2-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 7 May 2024 17:21:08 -0700
From: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Pradeep Kumar Chitrapu
	<quic_pradeepc@quicinc.com>
Subject: [PATCH V4 10/10] wifi: ath12k: add extended NSS bandwidth support for 160 MHz
Date: Tue, 7 May 2024 17:20:55 -0700
Message-ID: <20240508002055.17705-11-quic_pradeepc@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240508002055.17705-1-quic_pradeepc@quicinc.com>
References: <20240508002055.17705-1-quic_pradeepc@quicinc.com>
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
X-Proofpoint-GUID: wKAiSWnGvX5G6Uiq0pjMorIKq9pzXbVz
X-Proofpoint-ORIG-GUID: wKAiSWnGvX5G6Uiq0pjMorIKq9pzXbVz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-07_16,2024-05-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 bulkscore=0 suspectscore=0
 spamscore=0 mlxlogscore=999 mlxscore=0 lowpriorityscore=0 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405080001

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
index eb04c1c3bab7..181e7d5766b9 100644
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
@@ -5277,6 +5279,12 @@ ath12k_create_vht_cap(struct ath12k *ar, u32 rate_cap_tx_chainmask,
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
 
@@ -5459,11 +5467,12 @@ static void ath12k_mac_set_hemcsmap(struct ath12k *ar,
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
@@ -5476,12 +5485,24 @@ static void ath12k_mac_set_hemcsmap(struct ath12k *ar,
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


