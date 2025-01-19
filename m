Return-Path: <linux-wireless+bounces-17683-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E3C9A16051
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Jan 2025 06:23:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4BA73A6D61
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Jan 2025 05:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76C842905;
	Sun, 19 Jan 2025 05:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oImtoWZb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5AD76BB5B
	for <linux-wireless@vger.kernel.org>; Sun, 19 Jan 2025 05:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737264180; cv=none; b=FkWPFprmLhTXED3HG6nOc4q5+cg8wsI1tzo8qgwaWW9YoBm/iv7wPPMujA63XBce80YfR/VV1AWiWomuktvDVnKl03iQlpqBk9VxuCarKP1Dhnj/s/omlLlXvyWYDI1/IrbQwSooFkMVUqzA/TRCWoPjvM2yqwGbelLgMKkf2cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737264180; c=relaxed/simple;
	bh=QCzfzgIm1rTzeY0+jZli5MvB+vT0jB5SAKiIWTWWJm4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oiZkUp1cU3PYJljGfTjkrth6aBZr/NYatK7hDLKUnRH3f+2U76wg28BLlcRV2nUYlt6L7AQQB69EgwrxMfjkVRYwr6oqWeuIsdQLCRsAET4pPfwGeH8EDG2L1DfA8rdHrwdkevpGoYmLt7b3ktw0uzCcVSuTPHnyaCfkaqtCCgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oImtoWZb; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50J5Hlp2012884
	for <linux-wireless@vger.kernel.org>; Sun, 19 Jan 2025 05:22:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=ZtwpAc6bTYO
	Zp2y9MNdtJ/nCT7pbm01eyDD9XK50KFQ=; b=oImtoWZbx2aaHYXVfYmKDe+mh1F
	fs0UTXyhmpUxdCk+T1F6mBLKFmF6iOMyTKUmOuayAhV3X38eTTiGvLqNkwo9LDPG
	Qh8hkTaZHGwPn4438MKCmAr/yJcaf/4PdHN7ae611rG23usgRD30i9wu5YP3vdwA
	B50gNauxKByw9nW9hVJw6+lgw2b+FDjY8fkWWPAlre8iEm0Ge3B5gl6cVr6DEIcQ
	h5N5AI4NIqBzWQnCmiEATwE3+99j3ymlW/VpnoUhan3DpT3git2chquEWcHMBApt
	2sEZEjpI7CxYbmFM2DgSZZ/wrcaopCQLCC9gTaw3vy9clbTVYMhfBTfG4MQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44852d1gv0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Sun, 19 Jan 2025 05:22:57 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2ef9da03117so9838021a91.1
        for <linux-wireless@vger.kernel.org>; Sat, 18 Jan 2025 21:22:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737264177; x=1737868977;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZtwpAc6bTYOZp2y9MNdtJ/nCT7pbm01eyDD9XK50KFQ=;
        b=jgxVRzCCtdvN6zdGZHrf4EgThZYQUfXiL6YmgexbE26/Dldv4VcfT+hLpODnaoXHr3
         3PZ8EabB1hwj2MovhQJAUzIYhJ0SZWlz6LHvjMJpyPjCRp7YIR6YoYVbwczKKgdj6FSJ
         AmemOBEAJd/0409AYpiLfiXTU7MxAnysIJU4DawHTb71PeF/ryrBBSHgiDJWoyZbTc5D
         TBjqePgW+MGdCqGQV37lEOfTuRlmEVQHxHGh5aq+t+JVKoxq/afC8Z3jsoqOe4J+k85i
         r7rhfI7e8hNNu78uYymw/I2UI4k2QO0M4ofn97358ziwdp0xfMoYPYGbIenCccOYI5di
         ZinQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgDk/jfRkS8fckNkbdXcvwbmqmOq6G3zYfVU7XBXHQRpn5ipGC+p4eyMQLlcHkqbzZdvYxjRPfmIabCZx4Vg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyuhkH1TNXtpbtGlTGuks+J2rjzek7FR8u7cGfOE9WWhTlYr1ZK
	q0C+LFy/uUa2rbGSZDjpF31QwTUpiy1zGw4o079iFcu6F6HMLsp1toBurLduabj3fypiHfh0yLk
	qlInVORYdcbGrjvIy0Jpneujg0aIsHERHumS8zEG31IOn3fT9YmShpllXTQttAm/+aA==
X-Gm-Gg: ASbGncvNhaik5SPjMnPHarFeSo9LN+aHPHgeZeKrNTNBM3JgeR6ASZVtzK/IUgmKhVg
	70hTc57bP2y0lrCceZP6Zhx13RakSDWjsx7ofHxG8chsZIn/9GORcE9vsf4qacjTuvOhR0VkGRJ
	o3YdKH0SmmUWmWrQM+sU4W6siuIfAkQUO53+LbxCsFZUG1arRU6I3pHrn7hbsHwE07O9tGBX7Ot
	81ddj/Q4ubn3cPmaqym01Ka5YLyQzUNT6zoK4G9tuLbIlJyR8DEIhRIb8ZN9glzvHKrforPpN43
	d1ByRHeqftXgrz+9EDhQqN5zARgCLRhIebljCxy8OX0GIq+IlQ==
X-Received: by 2002:a17:90b:258b:b0:2ee:48bf:7dc9 with SMTP id 98e67ed59e1d1-2f782cb092dmr13280283a91.15.1737264176974;
        Sat, 18 Jan 2025 21:22:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG6SYzua+L9zOXH7ZMjBP2BXe/Zm+CgoCUSMQWNJge1vtZEYocFxke10dX6xubn0KCvA3fnFw==
X-Received: by 2002:a17:90b:258b:b0:2ee:48bf:7dc9 with SMTP id 98e67ed59e1d1-2f782cb092dmr13280265a91.15.1737264176605;
        Sat, 18 Jan 2025 21:22:56 -0800 (PST)
Received: from alokad-linux.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f77611a295sm5062553a91.7.2025.01.18.21.22.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jan 2025 21:22:55 -0800 (PST)
From: aloka.dixit@oss.qualcomm.com
To: ath11k@lists.infradead.org, ath12k@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc: Aloka Dixit <aloka.dixit@oss.qualcomm.com>
Subject: [PATCH v2 2/5] wifi: ath11k: pass tx arvif for MBSSID and EMA beacon generation
Date: Sat, 18 Jan 2025 21:22:47 -0800
Message-Id: <20250119052250.3488343-3-aloka.dixit@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: PIVxeh767IoHKR85bvxSK-sQOF6DwhSF
X-Proofpoint-GUID: PIVxeh767IoHKR85bvxSK-sQOF6DwhSF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-18_10,2025-01-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 clxscore=1011 bulkscore=0 mlxscore=0 phishscore=0 mlxlogscore=999
 impostorscore=0 priorityscore=1501 suspectscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501190042

From: Aloka Dixit <aloka.dixit@oss.qualcomm.com>

Function ath11k_mac_setup_bcn_tmpl() retrieves tx_arvif only for
a sanity check and then calls ath11k_mac_setup_bcn_tmpl_mbssid()
or ath11k_mac_setup_bcn_tmpl_ema() both of which again retrieve
the same pointer. Instead store the pointer and pass it to the
latter two functions.

Signed-off-by: Aloka Dixit <aloka.dixit@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath11k/mac.c | 40 +++++++++++++--------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index b1a79d8f980e..67f733aac759 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -1537,17 +1537,15 @@ static struct ath11k_vif *ath11k_mac_get_tx_arvif(struct ath11k_vif *arvif)
 	return NULL;
 }
 
-static int ath11k_mac_setup_bcn_tmpl_ema(struct ath11k_vif *arvif)
+static int ath11k_mac_setup_bcn_tmpl_ema(struct ath11k_vif *arvif,
+					 struct ath11k_vif *tx_arvif)
 {
-	struct ath11k_vif *tx_arvif;
 	struct ieee80211_ema_beacons *beacons;
 	int ret = 0;
 	bool nontx_vif_params_set = false;
 	u32 params = 0;
 	u8 i = 0;
 
-	tx_arvif = ath11k_mac_get_tx_arvif(arvif);
-
 	beacons = ieee80211_beacon_get_template_ema_list(tx_arvif->ar->hw,
 							 tx_arvif->vif, 0);
 	if (!beacons || !beacons->cnt) {
@@ -1593,25 +1591,22 @@ static int ath11k_mac_setup_bcn_tmpl_ema(struct ath11k_vif *arvif)
 	return ret;
 }
 
-static int ath11k_mac_setup_bcn_tmpl_mbssid(struct ath11k_vif *arvif)
+static int ath11k_mac_setup_bcn_tmpl_mbssid(struct ath11k_vif *arvif,
+					    struct ath11k_vif *tx_arvif)
 {
 	struct ath11k *ar = arvif->ar;
 	struct ath11k_base *ab = ar->ab;
-	struct ath11k_vif *tx_arvif = arvif;
 	struct ieee80211_hw *hw = ar->hw;
 	struct ieee80211_vif *vif = arvif->vif;
 	struct ieee80211_mutable_offsets offs = {};
 	struct sk_buff *bcn;
 	int ret;
 
-	if (vif->mbssid_tx_vif) {
-		tx_arvif = ath11k_mac_get_tx_arvif(arvif);
-		if (tx_arvif != arvif) {
-			ar = tx_arvif->ar;
-			ab = ar->ab;
-			hw = ar->hw;
-			vif = tx_arvif->vif;
-		}
+	if (tx_arvif != arvif) {
+		ar = tx_arvif->ar;
+		ab = ar->ab;
+		hw = ar->hw;
+		vif = tx_arvif->vif;
 	}
 
 	bcn = ieee80211_beacon_get_template(hw, vif, &offs, 0);
@@ -1640,6 +1635,7 @@ static int ath11k_mac_setup_bcn_tmpl_mbssid(struct ath11k_vif *arvif)
 static int ath11k_mac_setup_bcn_tmpl(struct ath11k_vif *arvif)
 {
 	struct ieee80211_vif *vif = arvif->vif;
+	struct ath11k_vif *tx_arvif;
 
 	if (arvif->vdev_type != WMI_VDEV_TYPE_AP)
 		return 0;
@@ -1647,14 +1643,18 @@ static int ath11k_mac_setup_bcn_tmpl(struct ath11k_vif *arvif)
 	/* Target does not expect beacon templates for the already up
 	 * non-transmitting interfaces, and results in a crash if sent.
 	 */
-	if (vif->mbssid_tx_vif &&
-	    arvif != ath11k_vif_to_arvif(vif->mbssid_tx_vif) && arvif->is_up)
-		return 0;
+	tx_arvif = ath11k_mac_get_tx_arvif(arvif);
+	if (tx_arvif) {
+		if (arvif != tx_arvif && arvif->is_up)
+			return 0;
 
-	if (vif->bss_conf.ema_ap && vif->mbssid_tx_vif)
-		return ath11k_mac_setup_bcn_tmpl_ema(arvif);
+		if (vif->bss_conf.ema_ap)
+			return ath11k_mac_setup_bcn_tmpl_ema(arvif, tx_arvif);
+	} else {
+		tx_arvif = arvif;
+	}
 
-	return ath11k_mac_setup_bcn_tmpl_mbssid(arvif);
+	return ath11k_mac_setup_bcn_tmpl_mbssid(arvif, tx_arvif);
 }
 
 void ath11k_mac_bcn_tx_event(struct ath11k_vif *arvif)
-- 
2.34.1


