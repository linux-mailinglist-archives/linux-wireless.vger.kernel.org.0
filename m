Return-Path: <linux-wireless+bounces-1795-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AA1E82BD37
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jan 2024 10:29:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FBFB1C25171
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jan 2024 09:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 341A95D901;
	Fri, 12 Jan 2024 09:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="MBosrxZh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B315A5D908
	for <linux-wireless@vger.kernel.org>; Fri, 12 Jan 2024 09:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40C4YTxr019085;
	Fri, 12 Jan 2024 09:28:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=xaMzbaEKW/P1tSCfWBhLO489OStFVFXDTXHIV1g6vd4=; b=MB
	osrxZh1QFXqC8xu1x9fZKIusIFcdnMuBvdXviTLGjubeMIxRIVlE3IdjWDHtWsKt
	vh5b336oqzUk4ONUz0xU2LDn0s7UDNbvkC39bkSmZLtNHh+42qxTdRMha3ih7TQT
	JvxO34gX8VQlddcjro7z6QfBZCmbEXPFpIL2IrK5FKXiSOiSkZWwkDF8+aVD5zbW
	ggcXWza/dopRDLMqO3C3LVgIkKf6CovLYDZDi7aY4XBcW5xFCIPVkmRWGTfmLEHw
	9dcAT1Td80EESetNe7+QAV8zajF1iMwSYdOSWFm1aNTfptAEOIdtAmAl4D5huq4c
	Y32QLVHrsx5IIS1bhnBA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vjqx1hgd6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jan 2024 09:28:41 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40C9Se0n008489
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jan 2024 09:28:40 GMT
Received: from yk-E5440.qca.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 12 Jan 2024 01:28:39 -0800
From: Kang Yang <quic_kangyang@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_kangyang@quicinc.com>
Subject: [PATCH v2 01/10] wifi: ath12k: change interface combination for P2P mode
Date: Fri, 12 Jan 2024 17:28:15 +0800
Message-ID: <20240112092824.7664-2-quic_kangyang@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240112092824.7664-1-quic_kangyang@quicinc.com>
References: <20240112092824.7664-1-quic_kangyang@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: LjkIuisiTkAQZm1Cmd9D4gniqo-yaRmo
X-Proofpoint-GUID: LjkIuisiTkAQZm1Cmd9D4gniqo-yaRmo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 clxscore=1015 impostorscore=0 mlxlogscore=846
 malwarescore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401120072

Current interface combination doesn't support P2P mode. Change the
combination for P2P mode.

Also, there is a bug that when mesh is enabled but ap is not enabled.
In this situation, the mesh's max_interface of interface combination
won't be set.

So assign the max_interfaces for mesh directly.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
---

v2: 
    1. add Tested-on tag of QCN9274.
    2. update copyright.

---
 drivers/net/wireless/ath/ath12k/mac.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 88cec54c6c2e..bbf7224087dc 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #include <net/mac80211.h>
@@ -7259,9 +7259,10 @@ static int ath12k_mac_setup_iface_combinations(struct ath12k *ar)
 	struct ieee80211_iface_combination *combinations;
 	struct ieee80211_iface_limit *limits;
 	int n_limits, max_interfaces;
-	bool ap, mesh;
+	bool ap, mesh, p2p;
 
 	ap = ab->hw_params->interface_modes & BIT(NL80211_IFTYPE_AP);
+	p2p = ab->hw_params->interface_modes & BIT(NL80211_IFTYPE_P2P_DEVICE);
 
 	mesh = IS_ENABLED(CONFIG_MAC80211_MESH) &&
 		ab->hw_params->interface_modes & BIT(NL80211_IFTYPE_MESH_POINT);
@@ -7270,9 +7271,15 @@ static int ath12k_mac_setup_iface_combinations(struct ath12k *ar)
 	if (!combinations)
 		return -ENOMEM;
 
-	if (ap || mesh) {
+	if ((ap || mesh) && !p2p) {
 		n_limits = 2;
 		max_interfaces = 16;
+	} else if (p2p) {
+		n_limits = 3;
+		if (ap || mesh)
+			max_interfaces = 16;
+		else
+			max_interfaces = 3;
 	} else {
 		n_limits = 1;
 		max_interfaces = 1;
@@ -7287,14 +7294,22 @@ static int ath12k_mac_setup_iface_combinations(struct ath12k *ar)
 	limits[0].max = 1;
 	limits[0].types |= BIT(NL80211_IFTYPE_STATION);
 
-	if (ap) {
+	if (ap || mesh || p2p)
 		limits[1].max = max_interfaces;
+
+	if (ap)
 		limits[1].types |= BIT(NL80211_IFTYPE_AP);
-	}
 
 	if (mesh)
 		limits[1].types |= BIT(NL80211_IFTYPE_MESH_POINT);
 
+	if (p2p) {
+		limits[1].types |= BIT(NL80211_IFTYPE_P2P_CLIENT) |
+				   BIT(NL80211_IFTYPE_P2P_GO);
+		limits[2].max = 1;
+		limits[2].types |= BIT(NL80211_IFTYPE_P2P_DEVICE);
+	}
+
 	combinations[0].limits = limits;
 	combinations[0].n_limits = n_limits;
 	combinations[0].max_interfaces = max_interfaces;
-- 
2.34.1


