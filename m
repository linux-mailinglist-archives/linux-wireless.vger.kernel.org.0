Return-Path: <linux-wireless+bounces-1564-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A504482696B
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Jan 2024 09:26:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A17F6B21581
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Jan 2024 08:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95E1ABA27;
	Mon,  8 Jan 2024 08:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ADacm3/o"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B1EB65E
	for <linux-wireless@vger.kernel.org>; Mon,  8 Jan 2024 08:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4085HM9f001800;
	Mon, 8 Jan 2024 08:26:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=mKDVYudDbYDhshCCJK/2iIrNsrUZtff+haXk/FkQ0WU=; b=AD
	acm3/olO/fMIGAd/LJMiGJuQdK0glajxg7eKUCrGALr43Z5ON50r0ae3OFdGf56k
	x/v8YlNC/Esc6U+DW+1shEqdusjEfBXPye3oNJPQ4K+0zH2rQZnKtOyG2RrH2Rp4
	aTtZ3JETDZiUEuz8koAAZmEGWmHsSN6aRQwGSOoT5TDUtmgQtIDuxTETnRSDpT/M
	5E/Px2aluKTVI5gDUHorGhVhN0zT9uL31RuwZ18S1cknOJ82bkraV5WuLqKnExas
	OIHQL+67QZf9JBpi54q4BK/faW7oLTrO57qgY82Xckn3689Nzl5CEu4tATgRY3j/
	pNh1h3SrKq2xIKDvqUyg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vg8nwrh3k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jan 2024 08:26:28 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4088QRxs007802
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 8 Jan 2024 08:26:27 GMT
Received: from yk-E5440.local (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 8 Jan
 2024 00:26:25 -0800
From: Kang Yang <quic_kangyang@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_kangyang@quicinc.com>
Subject: [PATCH 01/10] wifi: ath12k: change interface combination for P2P mode
Date: Mon, 8 Jan 2024 16:25:43 +0800
Message-ID: <20240108082552.7227-2-quic_kangyang@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240108082552.7227-1-quic_kangyang@quicinc.com>
References: <20240108082552.7227-1-quic_kangyang@quicinc.com>
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
X-Proofpoint-GUID: HBGvpzIrAfsGGzUhC8Q-LKnO4hViwlat
X-Proofpoint-ORIG-GUID: HBGvpzIrAfsGGzUhC8Q-LKnO4hViwlat
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 impostorscore=0 mlxlogscore=949 phishscore=0 mlxscore=0 bulkscore=0
 adultscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401080070

Current interface combination doesn't support P2P mode. Change the
combination for P2P mode.

Also, there is a bug that when mesh is enabled but ap is not enabled.
In this situation, the mesh's max_interface of interface combination
won't be set.

So assign the max_interfaces for mesh directly.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Fixes: ed7e818a7b50 ("wifi: ath12k: fix and enable AP mode for WCN7850")
Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 88cec54c6c2e..813808aeba32 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
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


