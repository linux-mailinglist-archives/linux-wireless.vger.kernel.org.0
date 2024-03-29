Return-Path: <linux-wireless+bounces-5609-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 164568922E5
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Mar 2024 18:40:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47CCE1C284BF
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Mar 2024 17:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5073F136E28;
	Fri, 29 Mar 2024 17:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="arbMTZkZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF29134724
	for <linux-wireless@vger.kernel.org>; Fri, 29 Mar 2024 17:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711734019; cv=none; b=PNiXW6RxBfAKXwzs7gVGbDJbb/jPa0lFk/uKvr3s4aSe1sMp4s6PKWsGw2bBB8xXOwmQhVoW+XZLkC+bzPGCYGBOdbKDEt/tez2PLAibnY6Z8KiPRpF0/+Id5TaZq0CnYSCjwiT5+Yv8Phw0zqnqGv2gbKRrCYuCuYIlszuxH/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711734019; c=relaxed/simple;
	bh=pQ3iKSB9Ni19Siv8JClXDcLZSerRUujbQEmUWJ//OUs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Uzx7IC7EmJxaqe1hqSMRZwpcr4vTOzXavdGkqF2R6ae2+TZD/MDI3w/Yyogyv1CeOSu9BqVnXbDdjE85OdE5iXNSVEBLtw0DkpLVtv0TTdlvTk4UBGYlDsXTZvdhHj94CRKwpiWkSZY8CG5eyNTLf15LeB7Ke8wqcvDgUYMRLsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=arbMTZkZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42THeDvK025914;
	Fri, 29 Mar 2024 17:40:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=zjmpCiXLkBDEZXWfPbHG
	hk/QCgnvjyxGWw3AmpWNkgM=; b=arbMTZkZoPHEP5kbvJDZtV1TVgZE/QgfHPSf
	ut8pPV8tsbR88zZFVt0a14r0Wr5o16qDpalii8GueH0nnM63Jd92GAAdjAF84ehU
	Sy3JKkwURfWm7TAVxFkUQV1f46Jum3XgVx38/HYkqGmPG45coFXXtkhBJR2XB7N0
	CJnCeNz0EEFrNhnfqq8sTrk1EWWzpDFhuiNM/m2/aiRb2hZE8laLJeVeJIgoT31f
	/K61ZFYd4cdil33OsewOntTVEgOBpfgZwFWkANujlFsmLkQmf38FNur5+6UC4gFG
	dPV5YBKSbW3vZ+AQEt2cicjpplfnnCcXOrY45gp/jX5tYSj/1w==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x5ybmrcm3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Mar 2024 17:40:12 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42THddH3025598
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Mar 2024 17:39:39 GMT
Received: from pradeepc2-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 29 Mar 2024 10:39:38 -0700
From: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Pradeep Kumar Chitrapu
	<quic_pradeepc@quicinc.com>
Subject: [PATCH v2 5/6] wifi: ath12k: refactor smps configuration
Date: Fri, 29 Mar 2024 10:39:25 -0700
Message-ID: <20240329173926.17741-6-quic_pradeepc@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240329173926.17741-1-quic_pradeepc@quicinc.com>
References: <20240329173926.17741-1-quic_pradeepc@quicinc.com>
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
X-Proofpoint-ORIG-GUID: GC5SeX3S8VGOk6yVktNgVx7f4DNAB-k-
X-Proofpoint-GUID: GC5SeX3S8VGOk6yVktNgVx7f4DNAB-k-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-29_13,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 phishscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 priorityscore=1501 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2403210001
 definitions=main-2403290157

Move fetching smps value to a new function and use u16_get_bits
to extract smps value from capabilities. This will help in
extending the functionality when SMPS support in 6 GHz band gets
added in subsequent patches.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 32 ++++++++++++++++-----------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 7e296140439a..b4114dd22bf0 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -1963,18 +1963,29 @@ static void ath12k_peer_assoc_h_he_6ghz(struct ath12k *ar,
 				     ampdu_factor)) - 1;
 }
 
+static inline int ath12k_get_smps_from_capa(const struct ieee80211_sta_ht_cap *ht_cap,
+					    int *smps)
+{
+	if (!ht_cap->ht_supported)
+		return -EOPNOTSUPP;
+
+	*smps = u16_get_bits(ht_cap->cap, IEEE80211_HT_CAP_SM_PS);
+
+	if (*smps >= ARRAY_SIZE(ath12k_smps_map))
+		return -EINVAL;
+
+	return 0;
+}
+
 static void ath12k_peer_assoc_h_smps(struct ieee80211_sta *sta,
 				     struct ath12k_wmi_peer_assoc_arg *arg)
 {
 	const struct ieee80211_sta_ht_cap *ht_cap = &sta->deflink.ht_cap;
 	int smps;
 
-	if (!ht_cap->ht_supported)
+	if (ath12k_get_smps_from_capa(ht_cap, &smps))
 		return;
 
-	smps = ht_cap->cap & IEEE80211_HT_CAP_SM_PS;
-	smps >>= IEEE80211_HT_CAP_SM_PS_SHIFT;
-
 	switch (smps) {
 	case WLAN_HT_CAP_SM_PS_STATIC:
 		arg->static_mimops_flag = true;
@@ -2448,16 +2459,11 @@ static int ath12k_setup_peer_smps(struct ath12k *ar, struct ath12k_vif *arvif,
 				  const u8 *addr,
 				  const struct ieee80211_sta_ht_cap *ht_cap)
 {
-	int smps;
+	int smps, ret = 0;
 
-	if (!ht_cap->ht_supported)
-		return 0;
-
-	smps = ht_cap->cap & IEEE80211_HT_CAP_SM_PS;
-	smps >>= IEEE80211_HT_CAP_SM_PS_SHIFT;
-
-	if (smps >= ARRAY_SIZE(ath12k_smps_map))
-		return -EINVAL;
+	ret = ath12k_get_smps_from_capa(ht_cap, &smps);
+	if (ret < 0)
+		return ret;
 
 	return ath12k_wmi_set_peer_param(ar, addr, arvif->vdev_id,
 					 WMI_PEER_MIMO_PS_STATE,
-- 
2.17.1


