Return-Path: <linux-wireless+bounces-18879-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58ECEA33496
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Feb 2025 02:25:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 002CB1668B1
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Feb 2025 01:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78B9F1448E3;
	Thu, 13 Feb 2025 01:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="c8L3BEVd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80C313B29B
	for <linux-wireless@vger.kernel.org>; Thu, 13 Feb 2025 01:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739409901; cv=none; b=JPYMoGKC7nd5t+O2W/kEQUWmTb69UheYqHErDZl9ZodPZmpBHNOrWX+TVhYgYEEAO7ULfBgiJTIbqeqAwEAR8URahGGV7+2AHLXKYdTDm2cx7J1oLhPjtfCdWE7psTZFjS0lc+UgkZ720pTk33C/ibgLm2PyUHmlfsRFF/7o/ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739409901; c=relaxed/simple;
	bh=tIo6Z6UKpOoYjOIwrGpi4/zDgNgWjJQ/AMYKg+sb/UA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uw0tZyhc8KIJ8va4RRXgOR7umNvdwpx5mhVQBf9LMzHq2Y8AQH7fB78bJeqGs1tC6o1MYf0uMXWmPj+Y2iJynlQbKkmHZ0IIczSKJL5QcdvNyxtwJD4xMoltN+yGgQcluRhKdKR5dZMuHPMfvtUfM4Zh//+zNQvF7A2v8yiIdYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=c8L3BEVd; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51CJc30v011688;
	Thu, 13 Feb 2025 01:24:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LgBbskVfuomIT5LJl7PX7j2Ltbe7ANEp3wO5usvTkEQ=; b=c8L3BEVd65rUncO0
	HpqECnMMv4iSJOr7n7ANvoC1D5kYIeDOkmOSwS/VBgr+o7S9E5mCnsGnyRVtp3Mg
	RcjgsaewZgKYVUx1vP2UeK+Ix7XQl+5JMxcDlr56jueGibwVCzGkQe66MeH9P/JC
	2DJqa3OhpVq9GIr3O6lL9BGN9AGa6KgbBTLyyWifKsRmxX+rPwQDFdRCeiMczn9A
	+9a5nY1o26k1hSlFT69dNb3+cGHIJWnhntcdqFpURiBuoehICkB0NGrw8E3w4tR5
	qFp8y8/iK3UJjjzRkd6Slzbe/UU2xVSZ10iRrLvz1H/zWZvFFRdHGDPYZ3hwhKeh
	rDq9GA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44s1yngmse-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Feb 2025 01:24:55 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51D1OsR9013044
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Feb 2025 01:24:54 GMT
Received: from ath12k-linux1.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 12 Feb 2025 17:24:54 -0800
From: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Pradeep Kumar Chitrapu
	<quic_pradeepc@quicinc.com>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
Subject: [PATCH V10 9/9] wifi: ath12k: add extended NSS bandwidth support for 160 MHz
Date: Wed, 12 Feb 2025 17:24:39 -0800
Message-ID: <20250213012439.278373-10-quic_pradeepc@quicinc.com>
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
X-Proofpoint-ORIG-GUID: ZeocotTrilqM6WRxr7_Hp56hfdZtF--7
X-Proofpoint-GUID: ZeocotTrilqM6WRxr7_Hp56hfdZtF--7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-12_08,2025-02-11_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 bulkscore=0 lowpriorityscore=0 impostorscore=0 mlxlogscore=999
 clxscore=1015 adultscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502130008

Currently rx and tx MCS map for 160 MHz under HE capabilities
are not updating properly, when 160 MHz is configured with NSS
lesser than max NSS support. Fix this by utilizing
nss_ratio_enabled and nss_ratio_info fields sent by firmware
in service ready event.

However, if firmware advertises EXT NSS BW support in VHT caps
as 1(1x2) and when nss_ratio_info indicates 1:1, reset the EXT
NSS BW Support in VHT caps to 0 which indicates 1x1. This is
to avoid incorrectly choosing 1:2 NSS ratio when using the
default VHT caps advertised by firmware.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Signed-off-by: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 33 ++++++++++++++++++++++-----
 1 file changed, 27 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 047042662197..c3afc6d9c8e9 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -2729,8 +2729,10 @@ static void ath12k_peer_assoc_h_he(struct ath12k *ar,
 	max_nss = min(max_nss, ar->num_tx_chains);
 
 	if (arg->peer_phymode == MODE_11AX_HE160) {
-		tx_nss = ath12k_get_nss_160mhz(ar, max_nss);
+		tx_nss = ath12k_get_nss_160mhz(ar, ar->num_tx_chains);
 		rx_nss = min(arg->peer_nss, tx_nss);
+
+		arg->peer_nss = min(link_sta->rx_nss, ar->num_rx_chains);
 		arg->peer_bw_rxnss_override = ATH12K_BW_NSS_MAP_ENABLE;
 
 		if (!rx_nss) {
@@ -6958,6 +6960,12 @@ ath12k_create_vht_cap(struct ath12k *ar, u32 rate_cap_tx_chainmask,
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
 
@@ -7140,11 +7148,12 @@ static void ath12k_mac_set_hemcsmap(struct ath12k *ar,
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
@@ -7157,12 +7166,24 @@ static void ath12k_mac_set_hemcsmap(struct ath12k *ar,
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
2.34.1


