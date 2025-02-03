Return-Path: <linux-wireless+bounces-18319-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB02A265F3
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Feb 2025 22:45:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5A86163B12
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Feb 2025 21:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4841C20FAA2;
	Mon,  3 Feb 2025 21:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aIMWNip4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BBFD20F09A
	for <linux-wireless@vger.kernel.org>; Mon,  3 Feb 2025 21:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738619096; cv=none; b=roxAaQ7D0d9jSW2ZZxaXviCisoJ9I28KZs5Tt7tazcDXQeswfaFyZtAaCBpTU0wTBBsjHDBkbsUCo9eP36GDTntkS/FrQpEP2z0FdxMlfyMlZ+2i9PG4f2yuB9/FfjZOuf1x1Qlc2AxowF9e+H5kAutyqzX1+Tu+w/S8tNblpM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738619096; c=relaxed/simple;
	bh=2GHjavYXML4ZttJ1rmAyHdv9oiaeQE56/XYeIgxWeMk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AqoPmfqMALScMHxNcUBoamKXbfh56I7CNqFJUYg9yvLwV3azGKamH3eavIhlC9eSQWY/UZUOcAerniUSh1G6O7g+nFUF/JiG2p9RGCFG7oLeTmGGiFYlEqf0nyqVpr7ECkkRycawrcwvpH5uwqxKroLHxQ1beenMQW4koFCapJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aIMWNip4; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 513KQm77027045
	for <linux-wireless@vger.kernel.org>; Mon, 3 Feb 2025 21:44:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=QzgQ7WEzKjk
	qJTUuDP5NT6Dy6EKSLNgaW54nzToTabM=; b=aIMWNip4kHAyANI0oKXlo3cMZMA
	4/69cCR4V+4B5fzJEY1m01rGB33giUufw3NNLTiGqE0FqaJjsu0ZSzDENyvYXgv5
	u2ML4TxAmpQQ+VWj66vGXtBIrOFM944XQCbvWqA2ZqAZiKflxw+uKZojErsmMojm
	x6FiQy0ItyedNHefQkeyshcf4t5PW/H3/9cDeBgM3J9z6WHmgHXmrj0T3KWrvLT6
	ArzAF0piulH5obOWvQlKiSvBJxCEFtCyPqlLvqifPigXVQqeLJgQugiS1sY/XUJj
	XYncyUtiC2+D2T8N3CmBXhFAEW9Vwz0az5CiclvFRKXUBOK8HlrBeL/l6Wg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44k4ufr4wt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 03 Feb 2025 21:44:52 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2ef9e4c5343so13671141a91.0
        for <linux-wireless@vger.kernel.org>; Mon, 03 Feb 2025 13:44:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738619092; x=1739223892;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QzgQ7WEzKjkqJTUuDP5NT6Dy6EKSLNgaW54nzToTabM=;
        b=ELgJ8X3PcO9MVAHsQ64pZs59frvrJZgm+5USq7siUZzfEgQ5YboMOgASW6a2/5hYE/
         An6SwAOiFK7NwBtmH51+33TWyfNkx+UOuqGiBXaqB7Z7uNlxW6lH0yYTL7sTTm8IleKf
         JN76CHAx+VPHKz7hFXnUbQQVcUWOAP4NqkyGL+lgN+yt+Rj7/oitCWevVlDhGLWTyVZP
         iq9j9SETzS1nJOPsex4tIoG8D4rWkGINOXvnoGxYWSEYb+HGNdpeGscUk+Ke4w7RL3aU
         oBAGnbwIr4EDIfi+Z96HETLR0pqH4gi3gRj0FYs9n+8pgJ0aGvD93Qvt2fF9NbK1hvMO
         K+Ug==
X-Forwarded-Encrypted: i=1; AJvYcCX4doPIw0pDOcdqWCIANAwbZMis8mMcgFu/sT32sUPLHw0S3lxcNGC3vkINGCb7+Vw7Fwxg+3r2xmxUW2LEyA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwSyTy/Q31djpFpOuetGqZVoyWWiZu/0rgimzbheKBqNaxSXAvV
	oG37G4eT7TJM48aq+eHR6SWK355Fi69tPRYSSQlIR/vVkET8AjjwnehXSiP9kTDMzBbE06GZzaE
	6+YHlcUZ+FsuGi8aco9ktA2NT4nTVt9bC9WT+3GSsIg0/Uo1Ztiv9q3bNvsng8BpdTBOrt6kHHA
	==
X-Gm-Gg: ASbGncvIMHdRChEMSEYxCXaDhsm4xe1Nym5+++uv9/uyymzJE5lR06G6PrHshp5rwRT
	zLe3Q2xHbmcHG7avbmVuGQ6x4nkojSPtyrAEXjXXMdTF10gIQper/UhMhGlDjdQjliIz+NBIk6q
	yLKMvh74DPHG0PiTbfxsFoG79NmzwS19VNDsKRYeAGkaK4I5TWtZwez7FzYs3uQuLfc/wqxyA/d
	WBflahoUCVbvd1IPRwGFfVfV9SEqrWmVKnJFEK3i08MXaBhmDDG6V7x4bON7qkRfk3HQMJnlB/o
	cwsDLH742IMAatdiBMTqF23IjOMS2sfDUzrbTGLMFbCMreAzje1tBYtsh9TS
X-Received: by 2002:a17:90b:520d:b0:2f6:f107:fae4 with SMTP id 98e67ed59e1d1-2f83abd7cdamr33973424a91.8.1738619091722;
        Mon, 03 Feb 2025 13:44:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEfncbyH+z3ef2HHy3M5k7kIczzJ+qP6vF0ACkktpzZsvaYdcrXOgcKU4O7yZ/PVgow0po8QA==
X-Received: by 2002:a17:90b:520d:b0:2f6:f107:fae4 with SMTP id 98e67ed59e1d1-2f83abd7cdamr33973402a91.8.1738619091341;
        Mon, 03 Feb 2025 13:44:51 -0800 (PST)
Received: from alokad-linux.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21de331ce6asm82357895ad.209.2025.02.03.13.44.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 13:44:51 -0800 (PST)
From: Aloka Dixit <aloka.dixit@oss.qualcomm.com>
To: ath11k@lists.infradead.org, ath12k@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc: Aloka Dixit <aloka.dixit@oss.qualcomm.com>
Subject: [PATCH v3 1/5] wifi: ath11k: refactor transmitted arvif retrieval
Date: Mon,  3 Feb 2025 13:44:44 -0800
Message-Id: <20250203214448.1978156-2-aloka.dixit@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250203214448.1978156-1-aloka.dixit@oss.qualcomm.com>
References: <20250203214448.1978156-1-aloka.dixit@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: KlHdLZcYb23JjiEZQnuOG-ByniabKkPB
X-Proofpoint-ORIG-GUID: KlHdLZcYb23JjiEZQnuOG-ByniabKkPB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-03_09,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 adultscore=0 bulkscore=0 mlxscore=0 priorityscore=1501 suspectscore=0
 spamscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0 mlxlogscore=950
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2502030157

Create a new function ath11k_mac_get_tx_arvif() to retrieve 'arvif'
for the transmitted interface of the MBSSID set. This will help
modifying the same code path to reflect mac80211 data structure
changes to support MLO. This also fixes an issue in
ath11k_mac_update_vif_chan() where tx_arvif is not reset to NULL
inside for loop during each iteration.

Signed-off-by: Aloka Dixit <aloka.dixit@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath11k/mac.c | 55 +++++++++++++--------------
 1 file changed, 27 insertions(+), 28 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 1556392f7ad4..8b81f450a216 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #include <net/mac80211.h>
@@ -1529,6 +1529,14 @@ static int ath11k_mac_set_vif_params(struct ath11k_vif *arvif,
 	return ret;
 }
 
+static struct ath11k_vif *ath11k_mac_get_tx_arvif(struct ath11k_vif *arvif)
+{
+	if (arvif->vif->mbssid_tx_vif)
+		return ath11k_vif_to_arvif(arvif->vif->mbssid_tx_vif);
+
+	return NULL;
+}
+
 static int ath11k_mac_setup_bcn_tmpl_ema(struct ath11k_vif *arvif)
 {
 	struct ath11k_vif *tx_arvif;
@@ -1538,7 +1546,7 @@ static int ath11k_mac_setup_bcn_tmpl_ema(struct ath11k_vif *arvif)
 	u32 params = 0;
 	u8 i = 0;
 
-	tx_arvif = ath11k_vif_to_arvif(arvif->vif->mbssid_tx_vif);
+	tx_arvif = ath11k_mac_get_tx_arvif(arvif);
 
 	beacons = ieee80211_beacon_get_template_ema_list(tx_arvif->ar->hw,
 							 tx_arvif->vif, 0);
@@ -1589,21 +1597,21 @@ static int ath11k_mac_setup_bcn_tmpl_mbssid(struct ath11k_vif *arvif)
 {
 	struct ath11k *ar = arvif->ar;
 	struct ath11k_base *ab = ar->ab;
-	struct ath11k_vif *tx_arvif = arvif;
+	struct ath11k_vif *tx_arvif;
 	struct ieee80211_hw *hw = ar->hw;
 	struct ieee80211_vif *vif = arvif->vif;
 	struct ieee80211_mutable_offsets offs = {};
 	struct sk_buff *bcn;
 	int ret;
 
-	if (vif->mbssid_tx_vif) {
-		tx_arvif = ath11k_vif_to_arvif(vif->mbssid_tx_vif);
-		if (tx_arvif != arvif) {
-			ar = tx_arvif->ar;
-			ab = ar->ab;
-			hw = ar->hw;
-			vif = tx_arvif->vif;
-		}
+	tx_arvif = ath11k_mac_get_tx_arvif(arvif);
+	if (tx_arvif && tx_arvif != arvif) {
+		ar = tx_arvif->ar;
+		ab = ar->ab;
+		hw = ar->hw;
+		vif = tx_arvif->vif;
+	} else {
+		tx_arvif = arvif;
 	}
 
 	bcn = ieee80211_beacon_get_template(hw, vif, &offs, 0);
@@ -1674,7 +1682,7 @@ static void ath11k_control_beaconing(struct ath11k_vif *arvif,
 				     struct ieee80211_bss_conf *info)
 {
 	struct ath11k *ar = arvif->ar;
-	struct ath11k_vif *tx_arvif = NULL;
+	struct ath11k_vif *tx_arvif;
 	int ret = 0;
 
 	lockdep_assert_held(&arvif->ar->conf_mutex);
@@ -1701,9 +1709,7 @@ static void ath11k_control_beaconing(struct ath11k_vif *arvif,
 
 	ether_addr_copy(arvif->bssid, info->bssid);
 
-	if (arvif->vif->mbssid_tx_vif)
-		tx_arvif = ath11k_vif_to_arvif(arvif->vif->mbssid_tx_vif);
-
+	tx_arvif = ath11k_mac_get_tx_arvif(arvif);
 	ret = ath11k_wmi_vdev_up(arvif->ar, arvif->vdev_id, arvif->aid,
 				 arvif->bssid,
 				 tx_arvif ? tx_arvif->bssid : NULL,
@@ -6330,23 +6336,20 @@ static int ath11k_mac_setup_vdev_params_mbssid(struct ath11k_vif *arvif,
 {
 	struct ath11k *ar = arvif->ar;
 	struct ath11k_vif *tx_arvif;
-	struct ieee80211_vif *tx_vif;
 
 	*tx_vdev_id = 0;
-	tx_vif = arvif->vif->mbssid_tx_vif;
-	if (!tx_vif) {
+	tx_arvif = ath11k_mac_get_tx_arvif(arvif);
+	if (!tx_arvif) {
 		*flags = WMI_HOST_VDEV_FLAGS_NON_MBSSID_AP;
 		return 0;
 	}
 
-	tx_arvif = ath11k_vif_to_arvif(tx_vif);
-
 	if (arvif->vif->bss_conf.nontransmitted) {
-		if (ar->hw->wiphy != ieee80211_vif_to_wdev(tx_vif)->wiphy)
+		if (ar->hw->wiphy != tx_arvif->ar->hw->wiphy)
 			return -EINVAL;
 
 		*flags = WMI_HOST_VDEV_FLAGS_NON_TRANSMIT_AP;
-		*tx_vdev_id = ath11k_vif_to_arvif(tx_vif)->vdev_id;
+		*tx_vdev_id = tx_arvif->vdev_id;
 	} else if (tx_arvif == arvif) {
 		*flags = WMI_HOST_VDEV_FLAGS_TRANSMIT_AP;
 	} else {
@@ -7306,8 +7309,7 @@ ath11k_mac_update_vif_chan(struct ath11k *ar,
 			   int n_vifs)
 {
 	struct ath11k_base *ab = ar->ab;
-	struct ath11k_vif *arvif, *tx_arvif = NULL;
-	struct ieee80211_vif *mbssid_tx_vif;
+	struct ath11k_vif *arvif, *tx_arvif;
 	int ret;
 	int i;
 	bool monitor_vif = false;
@@ -7361,10 +7363,7 @@ ath11k_mac_update_vif_chan(struct ath11k *ar,
 			ath11k_warn(ab, "failed to update bcn tmpl during csa: %d\n",
 				    ret);
 
-		mbssid_tx_vif = arvif->vif->mbssid_tx_vif;
-		if (mbssid_tx_vif)
-			tx_arvif = ath11k_vif_to_arvif(mbssid_tx_vif);
-
+		tx_arvif = ath11k_mac_get_tx_arvif(arvif);
 		ret = ath11k_wmi_vdev_up(arvif->ar, arvif->vdev_id, arvif->aid,
 					 arvif->bssid,
 					 tx_arvif ? tx_arvif->bssid : NULL,
-- 
2.34.1


