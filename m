Return-Path: <linux-wireless+bounces-17520-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A0E9A11438
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jan 2025 23:37:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B843166F9F
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jan 2025 22:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83C382144DB;
	Tue, 14 Jan 2025 22:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="St2ZIyuu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86CB2139CF
	for <linux-wireless@vger.kernel.org>; Tue, 14 Jan 2025 22:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736894198; cv=none; b=WSaCdL6eY1nBfHDMEDWWDz0P9oLGk2imA0qrfReCWXyNQjb5fd2EEJq0M8ZTwMkFP2/JNOYHQFrvChckSgfW7FnbshgW/XsTNJJNgBqhdHSLXBs6/rocGeQRu0x7G55xkqwELbVxa5XHrEmX6iC8rwYpPR+ckE+lLOsP7G34CEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736894198; c=relaxed/simple;
	bh=FZS1OkaPPIl2x2ye7nyFrPreM/CX4ZhiIBN8tRpld7g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lw3ML/NvaKCGWqIKGfmka46iUMPxLchde8a2441zWBma1VLG2PJl+G/u9vdsBj1Mrwf4oagsFHAsRK5ajpkr4iOUI0GGVUA7X9g/LFUevkL8+Ux0XHXbbuPbYn+6F/rvTF8q4ArP2oxjJU5/2oEXfDXt5+hwU9m1Xi5cJAqzuCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=St2ZIyuu; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50EFjZ2d005103;
	Tue, 14 Jan 2025 22:36:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7Dky27Yuz4tpKwQGtHC5nDPAp2FT3K2WtCbmPeEAOxo=; b=St2ZIyuu/yqetEVa
	l+ZZDKNbDAfM4xm/cNZwlyxz1ji2VWeqBbi4IRmE2k/UC9a+xPiiyQY7ZE8WjZXV
	k2NeYOCI7vT5qmse4eRfwyFNvrbdU7BfUD3dLI3WoGa5hZFlax3dti+x77F3i/Bb
	wm5LxrOtYdcXl6FV1XxzglgZvLUQESfmK8DvWyoAwnGKbA3EpZvFCuLmmcJOmG4B
	qcBFB10lDlPSri3BvSzHe7P/2dizKXTqOXK2mDc45pR5RGcP41H5wh2kuCew+xmo
	TMPxz4Ia8tYonlF4gojzv0eeyw6lqFGHb4ORlkEESc4lFJT7kUlpje8VmMwu+MLP
	tRf0HA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 445tuq0wxh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Jan 2025 22:36:33 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50EMaWLp006715
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Jan 2025 22:36:32 GMT
Received: from alokad-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 14 Jan 2025 14:36:31 -0800
From: Aloka Dixit <quic_alokad@quicinc.com>
To: <ath11k@lists.infradead.org>, <ath12k@lists.infradead.org>,
        <linux-wireless@vger.kernel.org>
CC: Aloka Dixit <quic_alokad@quicinc.com>
Subject: [PATCH 5/5] wifi: ath12k: pass BSSID index as input for EMA
Date: Tue, 14 Jan 2025 14:36:12 -0800
Message-ID: <20250114223612.2979310-6-quic_alokad@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250114223612.2979310-1-quic_alokad@quicinc.com>
References: <20250114223612.2979310-1-quic_alokad@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 9ypc-kctWkiCm9455zpE32BlRL8Jhti3
X-Proofpoint-ORIG-GUID: 9ypc-kctWkiCm9455zpE32BlRL8Jhti3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-14_07,2025-01-13_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 mlxlogscore=999 spamscore=0
 impostorscore=0 mlxscore=0 clxscore=1011 bulkscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501140170

Function ath12k_mac_setup_bcn_tmpl_ema() retrieves 'bss_conf'
only to get BSSID index which is an overhead because the
caller ath12k_mac_setup_bcn_tmpl() has already stored this
locally. Pass the index as an input instead.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1

Signed-off-by: Aloka Dixit <quic_alokad@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index a6626d419294..5f76b3264f64 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -1563,24 +1563,15 @@ static void ath12k_mac_set_arvif_ies(struct ath12k_link_vif *arvif, struct sk_bu
 }
 
 static int ath12k_mac_setup_bcn_tmpl_ema(struct ath12k_link_vif *arvif,
-					 struct ath12k_link_vif *tx_arvif)
+					 struct ath12k_link_vif *tx_arvif,
+					 u8 bssid_index)
 {
-	struct ath12k_vif *ahvif = arvif->ahvif;
-	struct ieee80211_bss_conf *bss_conf;
 	struct ath12k_wmi_bcn_tmpl_ema_arg ema_args;
 	struct ieee80211_ema_beacons *beacons;
 	bool nontx_profile_found = false;
 	int ret = 0;
 	u8 i;
 
-	bss_conf = ath12k_mac_get_link_bss_conf(arvif);
-	if (!bss_conf) {
-		ath12k_warn(arvif->ar->ab,
-			    "failed to get link bss conf to update bcn tmpl for vif %pM link %u\n",
-			    ahvif->vif->addr, arvif->link_id);
-		return -ENOLINK;
-	}
-
 	beacons = ieee80211_beacon_get_template_ema_list(ath12k_ar_to_hw(tx_arvif->ar),
 							 tx_arvif->ahvif->vif,
 							 tx_arvif->link_id);
@@ -1596,7 +1587,7 @@ static int ath12k_mac_setup_bcn_tmpl_ema(struct ath12k_link_vif *arvif,
 	for (i = 0; i < beacons->cnt; i++) {
 		if (tx_arvif != arvif && !nontx_profile_found)
 			ath12k_mac_set_arvif_ies(arvif, beacons->bcn[i].skb,
-						 bss_conf->bssid_index,
+						 bssid_index,
 						 &nontx_profile_found);
 
 		ema_args.bcn_cnt = beacons->cnt;
@@ -1615,7 +1606,7 @@ static int ath12k_mac_setup_bcn_tmpl_ema(struct ath12k_link_vif *arvif,
 	if (tx_arvif != arvif && !nontx_profile_found)
 		ath12k_warn(arvif->ar->ab,
 			    "nontransmitted bssid index %u not found in beacon template\n",
-			    bss_conf->bssid_index);
+			    bssid_index);
 
 	ieee80211_beacon_free_ema_list(beacons);
 	return ret;
@@ -1650,7 +1641,8 @@ static int ath12k_mac_setup_bcn_tmpl(struct ath12k_link_vif *arvif)
 			return 0;
 
 		if (link_conf->ema_ap)
-			return ath12k_mac_setup_bcn_tmpl_ema(arvif, tx_arvif);
+			return ath12k_mac_setup_bcn_tmpl_ema(arvif, tx_arvif,
+							     link_conf->bssid_index);
 	} else {
 		tx_arvif = arvif;
 	}
-- 
2.34.1


