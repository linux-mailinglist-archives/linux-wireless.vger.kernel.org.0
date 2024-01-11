Return-Path: <linux-wireless+bounces-1688-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B95A382A706
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jan 2024 05:51:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 547172882BE
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jan 2024 04:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27B222106;
	Thu, 11 Jan 2024 04:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="bUPWbJnJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC971C2D
	for <linux-wireless@vger.kernel.org>; Thu, 11 Jan 2024 04:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40B2qFSB012314;
	Thu, 11 Jan 2024 04:51:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=5hq7RvSVPTqAuq/lKCNX
	2YWoQvaNH7MSWKveuK/fxJc=; b=bUPWbJnJAkLdNs6hgCb5DQDKDuSN4Ye7oG7s
	bjF+QeVeIZ+I8lmWW084lmfSJKn5cqBx+ZS0BFXhrRU7GDX9RT1qFfky3Cawjp1E
	zJN3vTWRuBXQ87IX3pL29yV9ibmhlGuvwvUZNDUcWsNbLa82IVefUu50A0yghA2b
	MtKTwAsH1Ts9vn3i+nYeIVUOoa3YFTq4M9KA+yeeIQss5qA0w6QqE6+cI+u2fdQO
	vfb0kLpaQepLGxTV2J1mtIeJ8A4IvI4PyfA0B9Pp9gkHvbBpWldzlQu23S5i6qlS
	jNiXIw23a2bB5uvFu6GwgcR3jpKT9YVW5EX8SeLVWnxHwo6MiQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vhvhp1p59-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jan 2024 04:51:26 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40B4pPDn003817
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jan 2024 04:51:25 GMT
Received: from srirrama-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 10 Jan 2024 20:51:24 -0800
From: Sriram R <quic_srirrama@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Sriram R <quic_srirrama@quicinc.com>
Subject: [PATCH 03/12] wifi: ath12k: modify ath12k mac start/stop ops for single wiphy
Date: Thu, 11 Jan 2024 10:20:36 +0530
Message-ID: <20240111045045.28377-4-quic_srirrama@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240111045045.28377-1-quic_srirrama@quicinc.com>
References: <20240111045045.28377-1-quic_srirrama@quicinc.com>
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
X-Proofpoint-GUID: WRTCm4QNjTLYHs4EWkbdfU3BSoq6ouKE
X-Proofpoint-ORIG-GUID: WRTCm4QNjTLYHs4EWkbdfU3BSoq6ouKE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 impostorscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 clxscore=1015 mlxscore=0 mlxlogscore=680
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401110035

When mac80211 does drv start/stop, apply the state change
for all the radios within the wiphy in ath12k.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Sriram R <quic_srirrama@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 57 +++++++++++++++++++++------
 1 file changed, 45 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 2a70b7a486e3..7933d5993519 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -243,6 +243,7 @@ static const u32 ath12k_smps_map[] = {
 
 static int ath12k_start_vdev_delay(struct ath12k *ar,
 				   struct ath12k_vif *arvif);
+static void ath12k_mac_stop(struct ath12k *ar);
 
 static const char *ath12k_mac_phymode_str(enum wmi_phy_mode mode)
 {
@@ -5302,28 +5303,56 @@ static int ath12k_mac_start(struct ath12k *ar)
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
+
+	ath12k_drain_tx(ah);
 
-	ath12k_mac_drain_tx(ar);
+	ar = ah->radio;
+	ab = ar->ab;
 
 	mutex_lock(&ah->conf_mutex);
 
-	ret = ath12k_mac_start(ar);
-	if (ret) {
-		ath12k_err(ab, "fail to start mac operations in pdev idx %d ret %d\n",
-			   ar->pdev_idx, ret);
-		mutex_unlock(&ah->conf_mutex);
-		return ret;
+	for (i = 0; i < ah->num_radio; i++) {
+		ret = ath12k_mac_start(ar);
+		if (ret) {
+			ath12k_err(ab, "fail to start mac operations in pdev idx %d ret %d\n",
+				   ar->pdev_idx, ret);
+			goto fail;
+		}
+		ar++;
+		ab = ar->ab;
 	}
 
 	mutex_unlock(&ah->conf_mutex);
 
 	return 0;
+fail:
+	for (; i > 0; i--) {
+		ar--;
+		ath12k_mac_stop(ar);
+	}
+
+	mutex_unlock(&ah->conf_mutex);
+	return ret;
 }
 
 int ath12k_mac_rfkill_config(struct ath12k *ar)
@@ -5420,12 +5449,16 @@ static void ath12k_mac_op_stop(struct ieee80211_hw *hw)
 {
 	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
 	struct ath12k *ar = ath12k_ah_to_ar(ah, 0);
+	int i;
 
-	ath12k_mac_drain_tx(ar);
+	ath12k_drain_tx(ah);
 
 	mutex_lock(&ah->conf_mutex);
 
-	ath12k_mac_stop(ar);
+	for (i = 0; i < ah->num_radio; i++) {
+		ath12k_mac_stop(ar);
+		ar++;
+	}
 
 	mutex_unlock(&ah->conf_mutex);
 }
-- 
2.17.1


