Return-Path: <linux-wireless+bounces-17258-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F4ACA0800A
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Jan 2025 19:43:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37A9A7A060D
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Jan 2025 18:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 230B21AB526;
	Thu,  9 Jan 2025 18:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="f5SghFAB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979431A4F1F;
	Thu,  9 Jan 2025 18:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736448213; cv=none; b=niZ+57s6jbKcy7Pd/4ykqQNkp2oeyjJ8scKLphwqjfQt5clVfKqLpGKjoY/VFufc0fEqIG3IRpN97wuoKvuSKpEooNa52PEw4cg3ePd5pvzsuCgYa73okIkHcMLUkq+bqOzWBzAkoOAvQg4nC0N1EjAGId9+7zGNB5CV0oFqVr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736448213; c=relaxed/simple;
	bh=Xo37EZJ79vK5IZ12aVvtQLWdFzRLa1B9M53peR7E3bA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Da9LysnkWrT8VmScBZ+WWBRTO2UA1pRhvtFV3ODSMyQUwy2PerBKI3sjnopgK/4am7A9t87oAZuhR3uuTjGFbvWEAmCRgDnQF5FKATB8w9tcHwz4UzRuwpQRVMSquwhoGVYzgvRXwxXb+RCBwKMz9aYXNbquCzkMgdQYhIA8k/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=f5SghFAB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 509HImmB012208;
	Thu, 9 Jan 2025 18:43:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AqiIpvAZ99re8rEBS9GXslVIHfe324kt3aa5jkCv7DA=; b=f5SghFAB5Igfo4Yo
	p3kaAnL5lQWk+7ORI8PfwqvdiyPn7mdMXf7owfLUNVfkfGOmUxc7thxRyXqxd+DI
	WfLP5RGfegBdHmM++afeE+HCvtM+INK+nvdXyJWXND4KNuihEF80iIzC7gJ1ERYK
	aO57O4hEdb7RczpoayA3sig7ovDTSH2lI7dJMbW4+vF6gLHlSH9njpGwgywvf+aP
	IRAYN8G9TJWnp0cUdDRjS+j+S5cIA2LSBeBJP8/24OkC3isd3M/ThAPrKsGQkkDG
	zhF8K6La7PtlAnSf/t4o00lsU5z/pUvCYykgtUI2MpPCLPIwvQmu2AM9X6AuChAC
	VakXtg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 442jra867x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jan 2025 18:43:26 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 509IhPxJ004311
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 9 Jan 2025 18:43:25 GMT
Received: from hu-adisi-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 9 Jan 2025 10:43:23 -0800
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
Date: Fri, 10 Jan 2025 00:13:13 +0530
Subject: [PATCH 2/2] wifi: ath12k: handle
 ath12k_mac_ieee80211_sta_bw_to_wmi() for link sta
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250110-fix_link_sta_bandwidth_update-v1-2-61b6f3ef2ea3@quicinc.com>
References: <20250110-fix_link_sta_bandwidth_update-v1-0-61b6f3ef2ea3@quicinc.com>
In-Reply-To: <20250110-fix_link_sta_bandwidth_update-v1-0-61b6f3ef2ea3@quicinc.com>
To: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <ath12k@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Aditya Kumar Singh <quic_adisi@quicinc.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: BjsEdfjqIRdnXF1r9CqdPpLTBcxmGWOo
X-Proofpoint-ORIG-GUID: BjsEdfjqIRdnXF1r9CqdPpLTBcxmGWOo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 impostorscore=0
 phishscore=0 mlxscore=0 bulkscore=0 spamscore=0 clxscore=1015
 mlxlogscore=999 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2501090148

Currently ath12k_mac_ieee80211_sta_bw_to_wmi() handles the bandwidth from
sta's deflink member. This works only for non-ML station. Now that MLO
support is there, extend this function to use link sta instead of deflink.

Additionally, in ath12k_mac_handle_link_sta_state(), the link sta structure
is not accessible, making it difficult to fetch the bandwidth there.
However, ath12k_mac_station_assoc() does reference the link sta structure.
Therefore, move the initial assignment of the arsta bandwidth member to
ath12k_mac_station_assoc().

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1

Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 750b41ec29e2c329fe98b7b717ec183fd6807eb0..67ae213a1dcd7bc3be0838d7948097c559dde625 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -3139,11 +3139,11 @@ static int ath12k_setup_peer_smps(struct ath12k *ar, struct ath12k_link_vif *arv
 }
 
 static u32 ath12k_mac_ieee80211_sta_bw_to_wmi(struct ath12k *ar,
-					      struct ieee80211_sta *sta)
+					      struct ieee80211_link_sta *link_sta)
 {
-	u32 bw = WMI_PEER_CHWIDTH_20MHZ;
+	u32 bw;
 
-	switch (sta->deflink.bandwidth) {
+	switch (link_sta->bandwidth) {
 	case IEEE80211_STA_RX_BW_20:
 		bw = WMI_PEER_CHWIDTH_20MHZ;
 		break;
@@ -3160,8 +3160,8 @@ static u32 ath12k_mac_ieee80211_sta_bw_to_wmi(struct ath12k *ar,
 		bw = WMI_PEER_CHWIDTH_320MHZ;
 		break;
 	default:
-		ath12k_warn(ar->ab, "Invalid bandwidth %d in rc update for %pM\n",
-			    sta->deflink.bandwidth, sta->addr);
+		ath12k_warn(ar->ab, "Invalid bandwidth %d for link station %pM\n",
+			    link_sta->bandwidth, link_sta->addr);
 		bw = WMI_PEER_CHWIDTH_20MHZ;
 		break;
 	}
@@ -4934,6 +4934,11 @@ static int ath12k_mac_station_assoc(struct ath12k *ar,
 		return -EINVAL;
 	}
 
+	spin_lock_bh(&ar->data_lock);
+	arsta->bw = ath12k_mac_ieee80211_sta_bw_to_wmi(ar, link_sta);
+	arsta->bw_prev = link_sta->bandwidth;
+	spin_unlock_bh(&ar->data_lock);
+
 	if (link_sta->vht_cap.vht_supported && num_vht_rates == 1) {
 		ret = ath12k_mac_set_peer_vht_fixed_rate(arvif, arsta, mask,
 							 band);
@@ -5523,7 +5528,6 @@ static int ath12k_mac_handle_link_sta_state(struct ieee80211_hw *hw,
 					    enum ieee80211_sta_state new_state)
 {
 	struct ieee80211_vif *vif = ath12k_ahvif_to_vif(arvif->ahvif);
-	struct ieee80211_sta *sta = ath12k_ahsta_to_sta(arsta->ahsta);
 	struct ath12k *ar = arvif->ar;
 	int ret = 0;
 
@@ -5566,13 +5570,6 @@ static int ath12k_mac_handle_link_sta_state(struct ieee80211_hw *hw,
 			ath12k_warn(ar->ab, "Failed to associate station: %pM\n",
 				    arsta->addr);
 
-		spin_lock_bh(&ar->data_lock);
-
-		arsta->bw = ath12k_mac_ieee80211_sta_bw_to_wmi(ar, sta);
-		arsta->bw_prev = sta->deflink.bandwidth;
-
-		spin_unlock_bh(&ar->data_lock);
-
 	/* IEEE80211_STA_ASSOC -> IEEE80211_STA_AUTHORIZED: set peer status as
 	 * authorized
 	 */
@@ -5840,7 +5837,7 @@ static void ath12k_mac_op_link_sta_rc_update(struct ieee80211_hw *hw,
 	spin_lock_bh(&ar->data_lock);
 
 	if (changed & IEEE80211_RC_BW_CHANGED) {
-		bw = ath12k_mac_ieee80211_sta_bw_to_wmi(ar, sta);
+		bw = ath12k_mac_ieee80211_sta_bw_to_wmi(ar, link_sta);
 		arsta->bw_prev = arsta->bw;
 		arsta->bw = bw;
 	}

-- 
2.34.1


