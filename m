Return-Path: <linux-wireless+bounces-2316-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61BFF836241
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jan 2024 12:43:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 934DA1C26C64
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jan 2024 11:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70EF33D55F;
	Mon, 22 Jan 2024 11:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="PFGQopL7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2223D0D0
	for <linux-wireless@vger.kernel.org>; Mon, 22 Jan 2024 11:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705923576; cv=none; b=d4LtKKFSDMWlq9hG1hcBnQ/rE/r2tLLDSOvUkrIrblEBDfAKN5OGfO0mG6lBOzSTTAaIn7pC6vV/c8GaNp6bd0bDLQoNpEv2vOxk38Bx2Khk7j9gb+o4UUAmlPGozPKkvxgg32QtdqaVto0obD6p2QNOmyV7capduzTeMFJbsvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705923576; c=relaxed/simple;
	bh=laFjmuLTwKnWdhL33Opkj8SmFmMtQdAK4zrpilSpSks=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jg+58wTscodsQfZmnCgNkhW7npOPlgPk7OvC3VVget0C3ipACipz3UoixDmjYtCS6hIlt3sLyh8K6nIxUIBBnjkL9GT+VRXfSDRHNq4fxdirECsVWF5okKpweQsgF4O3X4mfj4aMhzaLYI6muXjJMbc8Q8v/ZCDeAQG3rlshkVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=PFGQopL7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40MAlthd002673;
	Mon, 22 Jan 2024 11:39:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=7W3YU2YgXwVUEfQNU3/tfbR9Tp/xv6ooTwFRN9fxGyE=; b=PF
	GQopL7rRl5miASskoFJxHz+sbbVkl8BgEdHXO5e2V9IjzYBFeVTi8YzzFkafDiLJ
	A3xAjOrbMOFbgcZfSMJCMEZtESk+6+/lPyofUsi/mPyUC362wXh5kvyYG5Aqqx6e
	I00V3jT87ZtHIfHwhmUHOC4omWNJ9mLg6TSiEWhmAPD6BKw+E1jOk5vab2AoH86x
	yGZHrFTPn3KBfMyvfz/VXTR055Wf1edHAJXyXqPN2waaSjfJjsN/DkRQCZFUQZQm
	ozJYv63v7M97gLyYm5uywsyaPw9fFjlTdRxXt6jycW7i+pOchbGuxwm2QT/O3oA1
	7mkOFosSTMGsKS9mwqhA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vspw8r3xh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jan 2024 11:39:26 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40MBdPF5014889
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jan 2024 11:39:25 GMT
Received: from yk-E5440.qca.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 22 Jan 2024 03:39:24 -0800
From: Kang Yang <quic_kangyang@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_kangyang@quicinc.com>
Subject: [PATCH v3 01/10] wifi: ath12k: change interface combination for P2P mode
Date: Mon, 22 Jan 2024 19:38:55 +0800
Message-ID: <20240122113904.8938-2-quic_kangyang@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240122113904.8938-1-quic_kangyang@quicinc.com>
References: <20240122113904.8938-1-quic_kangyang@quicinc.com>
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
X-Proofpoint-GUID: SHGr0Rr_4WGmxJrIIQ2lpUeHxvGpgvh5
X-Proofpoint-ORIG-GUID: SHGr0Rr_4WGmxJrIIQ2lpUeHxvGpgvh5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-22_02,2024-01-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 adultscore=0 mlxscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 clxscore=1015 suspectscore=0 impostorscore=0 mlxlogscore=837
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401220083

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

v3: rebase on new ath-tag.
v2: 
    1. add Tested-on tag of QCN9274.
    2. update copyright.

---
 drivers/net/wireless/ath/ath12k/mac.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index fe600dbef875..4751bfeaf46f 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -7479,9 +7479,10 @@ static int ath12k_mac_setup_iface_combinations(struct ath12k_hw *ah)
 	struct ieee80211_iface_combination *combinations;
 	struct ieee80211_iface_limit *limits;
 	int n_limits, max_interfaces;
-	bool ap, mesh;
+	bool ap, mesh, p2p;
 
 	ap = ath12k_mac_is_iface_mode_enable(ah, NL80211_IFTYPE_AP);
+	p2p = ath12k_mac_is_iface_mode_enable(ah, NL80211_IFTYPE_P2P_DEVICE);
 
 	mesh = IS_ENABLED(CONFIG_MAC80211_MESH) &&
 		ath12k_mac_is_iface_mode_enable(ah, NL80211_IFTYPE_MESH_POINT);
@@ -7490,9 +7491,15 @@ static int ath12k_mac_setup_iface_combinations(struct ath12k_hw *ah)
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
@@ -7507,14 +7514,22 @@ static int ath12k_mac_setup_iface_combinations(struct ath12k_hw *ah)
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


