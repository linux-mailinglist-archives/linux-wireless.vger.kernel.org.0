Return-Path: <linux-wireless+bounces-2758-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E7F0841ACC
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jan 2024 05:03:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 509831C24C59
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jan 2024 04:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAFF837708;
	Tue, 30 Jan 2024 04:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="XmvanMqL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC4237712
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jan 2024 04:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706587417; cv=none; b=thgzZGqVZ1HtI1Jh7Ba1HnJLhYxR+oF4cSjFQo6dsNkaY9sTyqr8VuvSz5+4howfma75yDlHM9ZH7G0PRo3woxfa9VQOp0aLaR6f14/A8/BRYp+igrWKPJAOwhCqnf3AdXi0zjvH6UYwMexnh857I6tuahPWjfYFm420Q3Ir5rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706587417; c=relaxed/simple;
	bh=uwklyzyOGK2CjHndecaucvYEejeBPda3+2po5p7eGw0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fxV79rSsV3zu8DBmu3ZosK4tqShJQPol7cyblVX2pLXeb8DrHEtNhjkdfpjQPilrDRypcvY7u7MXc2ENEvTXI92N1z3amma0fQliMGBUAvgZ4BSbfC6g+bnkUJz/hnLQyiqmE0d4hEMmkCFalw+6KIZzWeLtJEwxswkp+Bib0no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=XmvanMqL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40U3aHLg015552;
	Tue, 30 Jan 2024 04:03:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=hAi9PzN3psQoQq4HORB4lsF8pSf5v00q48lQwTucBJU=; b=Xm
	vanMqLILlrPsIZz43RqXXh2Q82Zz21vpAQvBZ+fH7Yr75ecBhMdlOyQpv3wfEpn9
	Y0e6pKeP97RrWVG1/SwDvuGilPPXkcx0MQ155gZHZXxybA4OWufWblDZCxSE4ypt
	V2eD8yBHu9nEu7JZlNYkiipgYJ4ts/AGNf8mY9pHcYYrKYB/Bue0mnnOZWIqnkX2
	vYKzPw3p1eRu6JM6L7xv9VgsiZovpi1ExQ9DYiDtHRi82xauBJHNnZiHzM86zNQj
	dtWfImkHyJlpEKxfWLts+WRzkJwnodyjME48vMgS+dKLzmfcVu8PXjQCzVXKZUlr
	X4pyzQIBdaQ0Vzf7HebA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vxhjrrxfs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jan 2024 04:03:31 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40U43U9U005108
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jan 2024 04:03:30 GMT
Received: from yk-E5440.qca.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 29 Jan 2024 20:03:29 -0800
From: Kang Yang <quic_kangyang@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_kangyang@quicinc.com>
Subject: [PATCH v6 03/11] wifi: ath12k: change interface combination for P2P mode
Date: Tue, 30 Jan 2024 12:02:55 +0800
Message-ID: <20240130040303.370590-4-quic_kangyang@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240130040303.370590-1-quic_kangyang@quicinc.com>
References: <20240130040303.370590-1-quic_kangyang@quicinc.com>
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
X-Proofpoint-GUID: nEuCfmEJ2ywKwVWGTpj0VcWtedm6nj0m
X-Proofpoint-ORIG-GUID: nEuCfmEJ2ywKwVWGTpj0VcWtedm6nj0m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-29_15,2024-01-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 mlxscore=0 bulkscore=0 priorityscore=1501 adultscore=0 spamscore=0
 mlxlogscore=840 suspectscore=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401300025

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

v6: no change.
v5: no change.
v4: no change.
v3: no change.
v2:
    1. add Tested-on tag of QCN9274.
    2. update copyright.

---
 drivers/net/wireless/ath/ath12k/mac.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 6d9660f68074..cf3c1d83063d 100644
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


