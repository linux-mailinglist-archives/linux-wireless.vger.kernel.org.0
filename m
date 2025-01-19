Return-Path: <linux-wireless+bounces-17682-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B14A16050
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Jan 2025 06:23:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6917F18869ED
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Jan 2025 05:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57D53366;
	Sun, 19 Jan 2025 05:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JB0WqZvr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980F72905
	for <linux-wireless@vger.kernel.org>; Sun, 19 Jan 2025 05:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737264179; cv=none; b=iOjgJUn2uSsrJWH1fnBy5eqR1E7iGqPs+BgRrLUPUoWSOJ87dcs3T49cGdCx7Q9Hxs5a/KXTSv1+JIcd51QlKjWuVrpGE/I6DLJiI3IEu6YVn6GYb/CC8fDSuIXfDNbS4IWkWMXSSlhU4j8uv/2pac7sKrsSl4l1SOwcfeCUsiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737264179; c=relaxed/simple;
	bh=GnWuwrHDBaKV7ALVmgOXEhw/7MZePdrhZviI1AXuE90=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Z5x67nd55Xi7U/bI6QO3gyD8y8IJmR2mCBtN9+Dlj1nzxXTpkR4PhdKyzjANg67S9s5E8Bupvj56bWucDo582/6MihTxBzrYdAQoc7gwyy08sMZjcsewwn/Vr2Bwch3fRar1ih3iGWwMS0Fy4Xry3V61oMr6tZrlktov8Bl5tiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JB0WqZvr; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50J4gVjV012830
	for <linux-wireless@vger.kernel.org>; Sun, 19 Jan 2025 05:22:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=eq02/ijFMWZ
	ugmb5HSORKGMnBvWo5mBSnxxuMX0U0Pk=; b=JB0WqZvrBZTyOqjR6GwMRSTRIcJ
	39QDbyplr7swQf5INcaVs4bRFwJEp72SvUBYkXTlkpF5Ps9Jx8yaT4BO/vt9Wka9
	8lNED0IIfirdFUL2TxLQck+iTkw+YYYEzNE+tE4f1B4EA9hFApcn+CnU9lvh5i5/
	7/yHJY1wNN+cNRi//EBBsHZVw+uK5naB13VC8rl7IQHKBEESe1PcfHq2kuXOxNym
	Pr1++Fm92A7CaziAuqpYBJcx2LKPGxZn5a2HyGdJq2eNmX/BdsTf3MaVNggW3DPP
	iuIPHb5HRFJfDLrF6F2sz841/4yZ9+6f0bnytuuzfOiQDMCpLvaBlw14fGg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4485fhsg1q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Sun, 19 Jan 2025 05:22:56 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2ef9864e006so9520850a91.2
        for <linux-wireless@vger.kernel.org>; Sat, 18 Jan 2025 21:22:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737264176; x=1737868976;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eq02/ijFMWZugmb5HSORKGMnBvWo5mBSnxxuMX0U0Pk=;
        b=B6NAe1+knlkBy/CjK8OOFBZqQKOwDxZIpEXsNCSv2kQW856pBl4M1bXnNeAr7wt/84
         0B2T8/NfU6D3Do8ZVEOydSs1ay3d8exgmPG67vVTU42j424vb9T03zTqQc6csIPjON7p
         v1DtVLd2YXco2ahEgw5Hd5nwPYk6tlW9k6EgCKiQAA6V1FYon+/U9Q7ZaPhhZ9/bs0YG
         NT6j72TxifxKOUU18yUjgBia37EP1AMZ8tHT2A9DSG3CGLs+hjs51t9mSH9Awb65Fk8p
         LQNrWl6w8Iat6E3o/a3qzdqI/fZbm8Znl2MJyk9awVrPF/c3y+tzR8TMxSlmekrpWp30
         6fqw==
X-Forwarded-Encrypted: i=1; AJvYcCUJYjl9vPFEdmrH71Bqid4VGjzo7gxOV6ayU+N3CiQ8xZZrYY0zQKMoI+/TgEyzMUUmBllaSw0gphwqrU77cQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyOpzPjgYhVUrTnpmZpewxW6X9Tn15yZHuewzMY12c60i2zL+Np
	qYrP2v8uRxRKmREkXs8S5XCuX4rIM/XKeWJCdp57ZuGYTXc73P7LlOXJXFF1v8qACQfuCX5p2O1
	pIQpUVOs998ybG6dSft+DvffLXBdNhWflMxDgnH50cKmqq8Tsk7yg/b63/bfUH+iOXg==
X-Gm-Gg: ASbGncuSLOi65KpEM00IyZcLX0ZBk7cEfuyiIF6+qwtFl3ldwil6atSZ/U0lOpW+xoe
	/y86nDljrAuWBrgqYatd3KwXLj3BwG0FGWqNVQviTtjEotAvS6nvIqKh9PL+Qlwqghc7r9/WgmI
	A3y0jYvFfETXW190BVplZMPUfwQaYP/UNWv+O7ZDpFUYVSA7oqCKj7jucYT2Ybz1+77eR7fqX12
	SnItLdQxahxLlOMwa/lkVgii7A29R/C9kTfe4cOdU0gbwbsd/sJOO4CH+fb3q6Q5PTo4P926Pge
	qR8FW86C4jVDBmb1EM5TPQo8socCytplOnyNvYdi5en9B0gjOA==
X-Received: by 2002:a17:90b:4d05:b0:2ee:5958:828 with SMTP id 98e67ed59e1d1-2f782c70176mr12864087a91.9.1737264175657;
        Sat, 18 Jan 2025 21:22:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFqaegLKQh6AuDwvNiGMCJoINOQ4iJBDckVegsrHB2UM7kNeaA7ZnWUzO4ERyNj64vvODTPwA==
X-Received: by 2002:a17:90b:4d05:b0:2ee:5958:828 with SMTP id 98e67ed59e1d1-2f782c70176mr12864063a91.9.1737264175242;
        Sat, 18 Jan 2025 21:22:55 -0800 (PST)
Received: from alokad-linux.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f77611a295sm5062553a91.7.2025.01.18.21.22.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jan 2025 21:22:54 -0800 (PST)
From: aloka.dixit@oss.qualcomm.com
To: ath11k@lists.infradead.org, ath12k@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc: Aloka Dixit <aloka.dixit@oss.qualcomm.com>
Subject: [PATCH v2 1/5] wifi: ath11k: refactor transmitted arvif retrieval
Date: Sat, 18 Jan 2025 21:22:46 -0800
Message-Id: <20250119052250.3488343-2-aloka.dixit@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250119052250.3488343-1-aloka.dixit@oss.qualcomm.com>
References: <20250119052250.3488343-1-aloka.dixit@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: rDEjZO8BOA97861FKXYb8ALtzlEoeeQv
X-Proofpoint-ORIG-GUID: rDEjZO8BOA97861FKXYb8ALtzlEoeeQv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-18_10,2025-01-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 lowpriorityscore=0 clxscore=1011 priorityscore=1501 impostorscore=0
 malwarescore=0 mlxlogscore=902 adultscore=0 spamscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501190042

From: Aloka Dixit <aloka.dixit@oss.qualcomm.com>

Create a new function ath11k_mac_get_tx_arvif() to retrieve 'arvif'
for the transmitted interface of the MBSSID set. This will help
modifying the same code path to reflect mac80211 data structure
changes to support MLO. This also fixes an issue in
ath11k_mac_update_vif_chan() where tx_arvif is not reset to NULL
inside for loop during each iteration.

Signed-off-by: Aloka Dixit <aloka.dixit@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath11k/mac.c | 39 +++++++++++++--------------
 1 file changed, 19 insertions(+), 20 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 1556392f7ad4..b1a79d8f980e 100644
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
@@ -1597,7 +1605,7 @@ static int ath11k_mac_setup_bcn_tmpl_mbssid(struct ath11k_vif *arvif)
 	int ret;
 
 	if (vif->mbssid_tx_vif) {
-		tx_arvif = ath11k_vif_to_arvif(vif->mbssid_tx_vif);
+		tx_arvif = ath11k_mac_get_tx_arvif(arvif);
 		if (tx_arvif != arvif) {
 			ar = tx_arvif->ar;
 			ab = ar->ab;
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


