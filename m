Return-Path: <linux-wireless+bounces-3201-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D439784B100
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Feb 2024 10:22:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 050451C22559
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Feb 2024 09:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1C1F12E1EB;
	Tue,  6 Feb 2024 09:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="h/sqaowp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4AE12DD91
	for <linux-wireless@vger.kernel.org>; Tue,  6 Feb 2024 09:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707211316; cv=none; b=SJGGmQeS5RGe2xf5YGK5URnPMTO/rGJuhyIrux0K9HBpGi+qxIXQWkUbnjkh6BWVhGzm6lDgshgqwdwftFanmW6pWbOBv6+rhGNNLHlPq/FemQEzD8LVTvJw7rrX4LRw5xE2FIFAmuI2t7Sw4PjBNczgG/EXMQQkBn2nbR9IyPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707211316; c=relaxed/simple;
	bh=jnKuJmGNcvsPzDLec1UCfzLd3Tt85Z/0FAXgCT9yXtE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cowK2lJA+pm+UpMsm3FrvS6snjg8xNOOWe4Pu+eIN5yMJZum/8CtPtMEIVbMpQh3f5Kl2Cj4WcHeu6GBsHzH282LsQpEvCYtFYjIiMeb2a3NT7zzsC/Wt6Odt8dsfCkBkNEXAyFoZwz9V/Tj8uSrq3b6BEpypbSGsE0RJfEkqoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=h/sqaowp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4165Kelg002526;
	Tue, 6 Feb 2024 09:21:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=tgPu1IGPSkoodtjXL+roS8cawxMXT5/Ei4a544A4YAU=; b=h/
	sqaowpSSYOZEb6mGqUm0FJyvslBpTR+LqLdnunVSmwY9AeEBIjN/dlMZ3mxTAAmu
	ca6t1GGehk5A4RlEBDa3g0yzFcka+TP+og15pU9W3qGiw6qnDH8IuAPogmj8qBig
	1CjKXM/ZulDbHe5n+7weYatXdJVQ0vrMcc4n9BJQTwtjMzzWV0tY9kUSNxYS2ZAy
	sfXk9lt1r35ZOhuX1Ksyk2BbqQCWMYp+8DeKn/XMbfI1sy5CI9sy17ocJihJYL/3
	YFXEx5hNMo77y77jTBKco5lpkMUAZ2T9kez6hthbI3pIGMkyvDKQOlSi4PUkrFes
	9SAbRoLi7OM6528rdntw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w3cafrpra-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Feb 2024 09:21:43 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4169Lg1h017216
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 6 Feb 2024 09:21:42 GMT
Received: from hu-ramess-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 6 Feb 2024 01:21:40 -0800
From: Rameshkumar Sundaram <quic_ramess@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Sriram R <quic_srirrama@quicinc.com>,
        Rameshkumar Sundaram <quic_ramess@quicinc.com>
Subject: [PATCH v2 03/12] wifi: ath12k: modify ath12k mac start/stop ops for single wiphy
Date: Tue, 6 Feb 2024 14:49:45 +0530
Message-ID: <20240206091954.4144454-4-quic_ramess@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240206091954.4144454-1-quic_ramess@quicinc.com>
References: <20240206091954.4144454-1-quic_ramess@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: crDhHytIWFKiUn6xuG9P6V8Wi33NGtfQ
X-Proofpoint-GUID: crDhHytIWFKiUn6xuG9P6V8Wi33NGtfQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-06_02,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 mlxscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0 clxscore=1015
 bulkscore=0 impostorscore=0 priorityscore=1501 suspectscore=0
 mlxlogscore=762 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402060065

From: Sriram R <quic_srirrama@quicinc.com>

When mac80211 does drv start/stop, apply the state change
for all the radios within the wiphy in ath12k.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Sriram R <quic_srirrama@quicinc.com>
Signed-off-by: Rameshkumar Sundaram <quic_ramess@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 57 +++++++++++++++++++++------
 1 file changed, 45 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index c58f753d4a10..ef952e8e4086 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -243,6 +243,7 @@ static const u32 ath12k_smps_map[] = {
 
 static int ath12k_start_vdev_delay(struct ath12k *ar,
 				   struct ath12k_vif *arvif);
+static void ath12k_mac_stop(struct ath12k *ar);
 
 static const char *ath12k_mac_phymode_str(enum wmi_phy_mode mode)
 {
@@ -5256,15 +5257,31 @@ static int ath12k_mac_start(struct ath12k *ar)
 	return ret;
 }
 
+static void ath12k_drain_tx(struct ath12k_hw *ah)
+{
+	int i;
+	struct ath12k *ar;
+
+	ar = ah->radio;
+
+	for (i = 0; i < ah->num_radio; i++) {
+		ath12k_mac_drain_tx(ar);
+		ar++;
+	}
+}
+
 static int ath12k_mac_op_start(struct ieee80211_hw *hw)
 {
 	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
-	struct ath12k *ar = ath12k_ah_to_ar(ah, 0);
-	struct ath12k_base *ab = ar->ab;
-	int ret;
+	struct ath12k *ar;
+	struct ath12k_base *ab;
+	int ret = 0;
+	int i;
 
-	ath12k_mac_drain_tx(ar);
+	ath12k_drain_tx(ah);
 
+	ar = ah->radio;
+	ab = ar->ab;
 	mutex_lock(&ah->conf_mutex);
 
 	switch (ah->state) {
@@ -5285,14 +5302,26 @@ static int ath12k_mac_op_start(struct ieee80211_hw *hw)
 		goto err;
 	}
 
-	ret = ath12k_mac_start(ar);
-	if (ret) {
-		ah->state = ATH12K_HW_STATE_OFF;
-
-		ath12k_err(ab, "fail to start mac operations in pdev idx %d ret %d\n",
-			   ar->pdev_idx, ret);
+	for (i = 0; i < ah->num_radio; i++) {
+		ret = ath12k_mac_start(ar);
+		if (ret) {
+			ah->state = ATH12K_HW_STATE_OFF;
+			ath12k_err(ab, "fail to start mac operations in pdev idx %d ret %d\n",
+				   ar->pdev_idx, ret);
+			goto fail_start;
+		}
+		ar++;
+		ab = ar->ab;
 	}
 
+	mutex_unlock(&ah->conf_mutex);
+
+	return 0;
+fail_start:
+	for (; i > 0; i--) {
+		ar--;
+		ath12k_mac_stop(ar);
+	}
 err:
 	mutex_unlock(&ah->conf_mutex);
 
@@ -5395,13 +5424,17 @@ static void ath12k_mac_op_stop(struct ieee80211_hw *hw)
 {
 	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
 	struct ath12k *ar = ath12k_ah_to_ar(ah, 0);
+	int i;
 
-	ath12k_mac_drain_tx(ar);
+	ath12k_drain_tx(ah);
 
 	mutex_lock(&ah->conf_mutex);
 
 	ah->state = ATH12K_HW_STATE_OFF;
-	ath12k_mac_stop(ar);
+	for (i = 0; i < ah->num_radio; i++) {
+		ath12k_mac_stop(ar);
+		ar++;
+	}
 
 	mutex_unlock(&ah->conf_mutex);
 }
-- 
2.25.1


