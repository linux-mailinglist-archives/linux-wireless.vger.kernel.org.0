Return-Path: <linux-wireless+bounces-11423-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6D309518E2
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Aug 2024 12:34:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 609131F215D2
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Aug 2024 10:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C2BD1AE02E;
	Wed, 14 Aug 2024 10:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="PUWJ1dPy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB1D3D552
	for <linux-wireless@vger.kernel.org>; Wed, 14 Aug 2024 10:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723631688; cv=none; b=fRB/nBNX71sxtBh0qxAJL996bQIvjTqz9uqMgGm2/NQQFvxOpfjGSI1qn0VUwFCHWW4NxdJGihGURmmYqm+m4PB5v2lJVdikrfrWfIzelaS0GguHaFkkBHz0cRQaxv/p4NZecPzC+nPzngXAIWyLyeGQLNtlNlh244H95NqIY3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723631688; c=relaxed/simple;
	bh=kaGTZcJaF4I9XQgs7fqxOUZeo6uEJo5l6rl8CD/KhhU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r+JT22Aa+ottROL2zq2Ei7yRPjkm2NzAi82vNABn8xBpUc+hjkhnPW2rpezhQf1mcjDNjNmFjHp9JI08TJjRtxKMbunUB+2I2PdJa+HMSQn6a8h/X1NPaGXGjAEB0m08kKeYOOMNI8BxFfLMuRldeVTg88gN2fHMNUh6fIU9oNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=PUWJ1dPy; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47DNFmMo006123;
	Wed, 14 Aug 2024 10:34:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0eKkORUW4pAsjU0mHkTjGGGwEjGUBj3lRsvZQp8N/zU=; b=PUWJ1dPy+2lavMrZ
	ynytoR3k29u//VOhz/cLvSb7MLzqLPuYClEgSMIKLbh7PXHkodrt7J6DGAJQOpIh
	Y3OFrMvtaHk83tfpTHHPsyD1aWd+dloJ3XQmltev7zatNYvyB0VcsrRtaaONqp7N
	3RMRnl7XI3kWxvN2VZM0zPsQ7iU8j3aKImv3PoPwoXZWOFaZjdEkgnp78jO5gWia
	+RQihSxEnnUaXOGE8dDfrmK/gUHn0SOZmEpHES7AlcRfrmdHwke3xDDP3RjbPxqt
	TO1d8yALVunIMDr2E488grTsyQNuez04RgSj2QFqyLjnVghUVZzJnvSatvVm8Gs+
	8U055A==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40yxwv4te1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Aug 2024 10:34:43 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47EAYfTC002528
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Aug 2024 10:34:41 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 14 Aug 2024 03:34:40 -0700
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
Subject: [PATCH 1/3] wifi: ath12k: Introduce iface combination cleanup helper
Date: Wed, 14 Aug 2024 16:04:21 +0530
Message-ID: <20240814103423.3980958-2-quic_periyasa@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240814103423.3980958-1-quic_periyasa@quicinc.com>
References: <20240814103423.3980958-1-quic_periyasa@quicinc.com>
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
X-Proofpoint-GUID: GhJJJWkqAUC7Wf-epzJ0gAWjGFS7F5Vq
X-Proofpoint-ORIG-GUID: GhJJJWkqAUC7Wf-epzJ0gAWjGFS7F5Vq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-14_07,2024-08-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 mlxlogscore=796 suspectscore=0 phishscore=0 malwarescore=0 clxscore=1015
 spamscore=0 adultscore=0 impostorscore=0 priorityscore=1501 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408140072

Introduce a cleanup helper function to avoid redundant code for iface
combination cleanup. Remove the cleanup code from
ath12k_mac_hw_unregister() and ath12k_mac_hw_register() and replace it
with new cleanup helper function.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00188-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00183-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1

Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index a3248d977532..69f50c1a52d6 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -8865,6 +8865,14 @@ static bool ath12k_mac_is_iface_mode_enable(struct ath12k_hw *ah,
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
@@ -8993,7 +9001,6 @@ static void ath12k_mac_cleanup_unregister(struct ath12k *ar)
 static void ath12k_mac_hw_unregister(struct ath12k_hw *ah)
 {
 	struct ieee80211_hw *hw = ah->hw;
-	struct wiphy *wiphy = hw->wiphy;
 	struct ath12k *ar;
 	int i;
 
@@ -9007,8 +9014,7 @@ static void ath12k_mac_hw_unregister(struct ath12k_hw *ah)
 	for_each_ar(ah, ar, i)
 		ath12k_mac_cleanup_unregister(ar);
 
-	kfree(wiphy->iface_combinations[0].limits);
-	kfree(wiphy->iface_combinations);
+	ath12k_mac_cleanup_iface_combinations(ah);
 
 	SET_IEEE80211_DEV(hw, NULL);
 }
@@ -9238,13 +9244,13 @@ static int ath12k_mac_hw_register(struct ath12k_hw *ah)
 	ret = ath12k_wow_init(ar);
 	if (ret) {
 		ath12k_warn(ar->ab, "failed to init wow: %d\n", ret);
-		goto err_free_if_combs;
+		goto err_cleanup_if_combs;
 	}
 
 	ret = ieee80211_register_hw(hw);
 	if (ret) {
 		ath12k_err(ab, "ieee80211 registration failed: %d\n", ret);
-		goto err_free_if_combs;
+		goto err_cleanup_if_combs;
 	}
 
 	if (is_monitor_disable)
@@ -9274,9 +9280,8 @@ static int ath12k_mac_hw_register(struct ath12k_hw *ah)
 
 	ieee80211_unregister_hw(hw);
 
-err_free_if_combs:
-	kfree(wiphy->iface_combinations[0].limits);
-	kfree(wiphy->iface_combinations);
+err_cleanup_if_combs:
+	ath12k_mac_cleanup_iface_combinations(ah);
 
 err_complete_cleanup_unregister:
 	i = ah->num_radio;
-- 
2.34.1


