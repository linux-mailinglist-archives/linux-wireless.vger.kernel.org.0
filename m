Return-Path: <linux-wireless+bounces-5440-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D41AC88F8BE
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Mar 2024 08:30:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7034C1F2779A
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Mar 2024 07:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1048653E05;
	Thu, 28 Mar 2024 07:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="hYwhuoWB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79EAC537F5
	for <linux-wireless@vger.kernel.org>; Thu, 28 Mar 2024 07:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711611020; cv=none; b=N11mvlpS47KTmafqo9XoMZScJ+ONEMp/9i1u8BwOkxv4pgyE+gFiTrjW+pMEhdcpaa6/Y7gpS8CHd/bCE2G9yQIZ0InT/pedsvlXjP/0fG4jwa7IhFhiiV2mcBAM+jfwwsh77fhiLTtTrCc/usrY+nfbz//EzgJSa+ULCaH6BWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711611020; c=relaxed/simple;
	bh=qgtUJ9Qb0c1d4ANEhpl0hr1bMgVvNbPcH7OGu6E6700=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M9nrzUKS/R3bQnjTGmCfujfM+lPaclFJmsYVef3jluekjcOvm3T1FX27ijKulz3REhKqk0LLrCDkeJAFm7XpFVjZSNESZkFHbaWjRhcMYFuOCY/m4NYWNymdptT6DTf6p87gXsUAqUh77bOX9nncKsKEhB5n4/prsAUpAfuv5y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=hYwhuoWB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42S3ns57031494;
	Thu, 28 Mar 2024 07:30:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=BVEFDZ2WTP4C+ARaLT2dCt71jFI5J76TrRdBOehoe4E=; b=hY
	whuoWBRmec3k2s1yqvZ48r9rhbXCTDCSPZ+uu0ZDNkqd/zV3MBTWasCbOsU3RJhk
	pIl1BCwzvV00oORyEDp+XDTXhhtk3fFxo+8lFnmOgMt+zVL1PDRUguu7+i7Mv1oQ
	IPupEuj/iFXElRD585u1Ly+rXqWRGaP46lbEiZLqUnspf6B408MEvNENzPF+d8pQ
	jDFVUkxSNLD+jz7e5RtwMkHKUZpb1f9xKd5zlRAmFU4QSiCDUQ3P+hkAYDmpoy79
	b8QR9d+6M45E2T1jQ88uXypSFG4cqx1XksHatURrEm2kkJH8zOyI2v3NbAMoYgKk
	+ZNEvPcAb7N6ZHM69s8g==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x4u20acu0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Mar 2024 07:30:12 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42S7UBMr013403
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Mar 2024 07:30:11 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 28 Mar 2024 00:30:09 -0700
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>, <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
Subject: [PATCH 12/13] wifi: ath12k: Introduce iface combination cleanup helper
Date: Thu, 28 Mar 2024 12:59:15 +0530
Message-ID: <20240328072916.1164195-13-quic_periyasa@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240328072916.1164195-1-quic_periyasa@quicinc.com>
References: <20240328072916.1164195-1-quic_periyasa@quicinc.com>
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
X-Proofpoint-ORIG-GUID: X6mhx8re7R4-DFU8pAIHiuENpe-xYaZ5
X-Proofpoint-GUID: X6mhx8re7R4-DFU8pAIHiuENpe-xYaZ5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-28_06,2024-03-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=961 spamscore=0
 priorityscore=1501 phishscore=0 adultscore=0 lowpriorityscore=0
 clxscore=1015 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2403210001 definitions=main-2403280048

Introduce a cleanup helper function to avoid redundant code for iface
combination cleanup. Remove the cleanup code from
ath12k_mac_hw_unregister() and ath12k_mac_hw_register() and replace it
with new cleanup helper function.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00188-QCAHKSWPL_SILICONZ-1

Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 52a5fb8b03e9..44c8bf6eb6ae 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -7781,6 +7781,14 @@ static bool ath12k_mac_is_iface_mode_enable(struct ath12k_hw *ah,
 	return is_enable;
 }
 
+static void ath12k_mac_cleanup_iface_combinations(struct ath12k_hw *ah)
+{
+	struct wiphy *wiphy = ah->hw->wiphy;
+
+	kfree(wiphy->iface_combinations[0].limits);
+	kfree(wiphy->iface_combinations);
+}
+
 static int ath12k_mac_setup_iface_combinations(struct ath12k_hw *ah)
 {
 	struct wiphy *wiphy = ah->hw->wiphy;
@@ -7905,7 +7913,6 @@ static void ath12k_mac_cleanup_unregister(struct ath12k *ar)
 static void ath12k_mac_hw_unregister(struct ath12k_hw *ah)
 {
 	struct ieee80211_hw *hw = ah->hw;
-	struct wiphy *wiphy = hw->wiphy;
 	struct ath12k *ar = ath12k_ah_to_ar(ah);
 
 	cancel_work_sync(&ar->regd_update_work);
@@ -7914,8 +7921,7 @@ static void ath12k_mac_hw_unregister(struct ath12k_hw *ah)
 
 	ath12k_mac_cleanup_unregister(ar);
 
-	kfree(wiphy->iface_combinations[0].limits);
-	kfree(wiphy->iface_combinations);
+	ath12k_mac_cleanup_iface_combinations(ah);
 
 	SET_IEEE80211_DEV(hw, NULL);
 }
@@ -8087,7 +8093,7 @@ static int ath12k_mac_hw_register(struct ath12k_hw *ah)
 	ret = ieee80211_register_hw(hw);
 	if (ret) {
 		ath12k_err(ab, "ieee80211 registration failed: %d\n", ret);
-		goto err_free_if_combs;
+		goto err_cleanup_if_combs;
 	}
 
 	if (!ab->hw_params->supports_monitor)
@@ -8110,9 +8116,8 @@ static int ath12k_mac_hw_register(struct ath12k_hw *ah)
 err_unregister_hw:
 	ieee80211_unregister_hw(hw);
 
-err_free_if_combs:
-	kfree(wiphy->iface_combinations[0].limits);
-	kfree(wiphy->iface_combinations);
+err_cleanup_if_combs:
+	ath12k_mac_cleanup_iface_combinations(ah);
 
 err_cleanup_unregister:
 	ath12k_mac_cleanup_unregister(ar);
-- 
2.34.1


