Return-Path: <linux-wireless+bounces-24255-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54CB9ADF689
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Jun 2025 20:58:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC5187AE660
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Jun 2025 18:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DA532FCE16;
	Wed, 18 Jun 2025 18:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Sdpnz0nF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E782FCE05
	for <linux-wireless@vger.kernel.org>; Wed, 18 Jun 2025 18:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750273020; cv=none; b=m8od93bR4UftVGpuolFaUkhUaaqXSnkMLEdZXgZKnUadV498npoPx8bT5RVV1y0xl3h1j0WjDAGHtQiFLDJ5cRo2mL0iQb0KdOYOVuOvTjEvJweaNUcfJF09GzjNRIgOIwRAwK53fnur44jjWI8Z+x8C8dTmd6l9bSJsvjrB6PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750273020; c=relaxed/simple;
	bh=ArxP4doUGIDMJ8qGI2PvZuEd91oYYTBQRCGvmft8ojM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RnHzUGWaUEOZptc4kYILCWlv/JdShM40d6cU6zPpnHImoDLLkyLiJgcDQN/bvYtxBlgJzK2vA2CQJ3Ohpdof8JxFls7fVJ2aA1Gz6clvYTNBWNtsxNqLwmtmlEBQ0/HYDqwKdIHRT2XqGsOm3AyzCDA/+yATdGGm536D95uQ+2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Sdpnz0nF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55IAoaKf003033
	for <linux-wireless@vger.kernel.org>; Wed, 18 Jun 2025 18:56:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=Kx8HdG18VyDKXxGTrwIZhfVXBtWZ0wXzBh0
	CGv9KtfQ=; b=Sdpnz0nFoLlZoLjk5gmobP2vDasjPWgR25MWMxgIt3j6h5ffKgW
	4887MyJorwMz3Gc9lk7h9QQpzlNPKThHvnXNJ9sVwIMu53cHbuCUJfxYuHWv8SPD
	5B06wLL8LKN3+nY21a4nBJiY4FVzcOMDKS/NVeuuQKhUQKPh59FraLlHZLaCItJM
	vhOp6sKpjeprSNGOnFFU2kvx5xO/60MzkXfhfrvQdZzHN+IA1OjKCjYj6FL61TW+
	JgFZir1n5pZEy8BnrEsc1z0RrOCyA+e0JLhfg+0uq2kYHoyROPEn3TdFoBhtK6/I
	mwqK9A5BIPweSsOViw8KBF0KpGHDmf+y9sA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4791crw4q1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 18 Jun 2025 18:56:55 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2369dd58602so234535ad.1
        for <linux-wireless@vger.kernel.org>; Wed, 18 Jun 2025 11:56:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750273014; x=1750877814;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kx8HdG18VyDKXxGTrwIZhfVXBtWZ0wXzBh0CGv9KtfQ=;
        b=JXRidfoE1GYQ3PrbGXjwxfHmmCeaTLnXZgR4Vy6J7ZPDEiHVi7mvVjgRQxLXRzyYAh
         TotAaow0fLqGCpkXGEBVY/PBNUUZK2cDmnAMMIJASjcGlZsRmtcXiKWC+E8oXH6eNe9i
         yVXQyMDBXo8hMdZ/HL3+remb/vpqi1CUToR1ZnUmp9ZpoVz1rFgAQJwXAqD/603F+eCj
         ZMX9pDNtTGLOiB7XbzrKHqozP0VWBE/yB4v/9Fq0T3ysEsV+kdBk25LqqoQvqOQ+ZB03
         S6xCLEwceRwvan5vkQYzidHDik1N+X8Yo+OU+qjM1PrM1Brw8lUjNqQNhsQyhNib2/EB
         915w==
X-Gm-Message-State: AOJu0YxUVXeMs1ygeYYo/HeUbUeK4seJZQOAWYmpuKfG8zdp7ZORPl+j
	qaqZxOqCoUO6Z/MwII80m1exAuc52Sv1qQBD0pwuZdEkhOjA7WVIiGHTWQXj/n36gZHdDhTAAYo
	7Y7Bk3wn8Kvee2yKAdTbmDDhak9bii3hMjQQyU99/YVHB3Ea7NANeZZum7GlBF2zAlc2DVve9IL
	ECUQ==
X-Gm-Gg: ASbGnctH4UFgTjmT2/hnWVmZN5JXR2tPYwUIkpvQuTt2QNVRzc1LagJoCMQxxG8eECh
	2LXiXcLRUCqrIOxeYTY33bQSk1RfVY1RA2dVSDfkkeI91hvMVIKMp3DToQAN4zcRtbWzaHMfemr
	9wTfjYGf6VwfiCX4/IKavEvfIGO2wtqpoEsnJN3+nrcPUovK4aPgkdlWVTNS6edGSlqJjyWKq+k
	ym1+VJ2s5Wuq2L0UCa1BooHOQlYOKfQCaCLaBLvVGl4LxlLLVP3kK1zMl2HLUaaOKzoGEmiSzrR
	sj5OUGZ6AKaSkcr22jTjzM6dHl0Szljm+aHjkmVO+kT4r+Pk9IGQAS+ptbv4hYqoy24r/BXD0jD
	V7FhZ4ErUqKaNczgDNl36kjK3SXZNWFS4jQpFOVFGXQ9U/Zni+Yc=
X-Received: by 2002:a17:903:1b0c:b0:234:ba37:879e with SMTP id d9443c01a7336-2366b3c3c7cmr296753195ad.38.1750273013620;
        Wed, 18 Jun 2025 11:56:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF18Jiq7IRmgSlgVAZg7mArKxxi+Si93V0vX3POGyss1Ij62DBzXhixoYtE3oKcfMqpWtXBEw==
X-Received: by 2002:a17:903:1b0c:b0:234:ba37:879e with SMTP id d9443c01a7336-2366b3c3c7cmr296752875ad.38.1750273013183;
        Wed, 18 Jun 2025 11:56:53 -0700 (PDT)
Received: from hu-ramess-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365e0cffe6sm103589305ad.245.2025.06.18.11.56.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 11:56:52 -0700 (PDT)
From: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
Subject: [PATCH ath-next] wifi: ath12k: Avoid accessing uninitialized arvif->ar during beacon miss
Date: Thu, 19 Jun 2025 00:26:35 +0530
Message-Id: <20250618185635.750470-1-rameshkumar.sundaram@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: maNr0aYBfKOpFbAh3TmNT68P30kqNw6Y
X-Authority-Analysis: v=2.4 cv=BoedwZX5 c=1 sm=1 tr=0 ts=68530bf7 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=oDydKND7yF-1bX00yyYA:9
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: maNr0aYBfKOpFbAh3TmNT68P30kqNw6Y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE4MDE2MiBTYWx0ZWRfXxlG79LWSEXp2
 lMu/ZY0OkCVZPtTKXRaTQm2JAwp19ziWRytwlvzzy/dZk9sXDGEUN3vEs4vfu3QRcjn9PHkRklk
 3t4cGWE6v6bt9HhVSF9JTuadkWpm8Y9fSZwiSOg42Z0ibT+pqaQ5BJf8kPb0xo+ldQ+oJC3ULLO
 qg3RiD7uYWcxDXncdCxZ8C5kLtPuY32eKq88VjBrAaJW1QWQvLWPMC4EzCqYSG46R1k68ryObyI
 11h7g5Quf5SOQfH/ChcBYY/r8v9t4G/PRq5q1K91c2LD5d1r8usF7GivONjWBzdsBggjgA8smtK
 mfcAV+4lYhk3upMAWwfVAZvLOaal4wk3YrUdsJ+ivbW+6KVAVigubQdooOgVfXfgitUQMSz4Ytt
 NyEON3e/sD3M7jPA/jlfQxTwHiuROIySiOv9LX/fB1sdHGZCcB44ieNlOyeXQCYOMcrV2Oeg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-18_05,2025-06-18_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 mlxscore=0 adultscore=0 phishscore=0 lowpriorityscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 priorityscore=1501 clxscore=1015
 spamscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506180162

During beacon miss handling, ath12k driver iterates over active virtual
interfaces (vifs) and attempts to access the radio object (ar) via
arvif->deflink->ar.

However, after commit aa80f12f3bed ("wifi: ath12k: defer vdev creation for
MLO"), arvif is linked to a radio only after vdev creation, typically when
a channel is assigned or a scan is requested.
For P2P capable devices, a default P2P interface is created by
wpa_supplicant along with regular station interfaces, these serve as dummy
interfaces for P2P-capable stations, lack an associated netdev and initiate
frequent scans to discover neighbor p2p devices. When a scan is initiated
on such P2P vifs, driver selects destination radio (ar) based on scan
frequency, creates a scan vdev, and attaches arvif to the radio. Once the
scan completes or is aborted, the scan vdev is deleted, detaching arvif
from the radio and leaving arvif->ar uninitialized.

While handling beacon miss for station interfaces, P2P interface is also
encountered in the vif iteration and ath12k_mac_handle_beacon_miss_iter()
tries to dereference the uninitialized arvif->deflink->ar.

Fix this by verifying that vdev is created for the arvif before accessing
its ar during beacon miss handling and similar vif iterator callbacks.

==========================================================================
 wlp6s0: detected beacon loss from AP (missed 7 beacons) - probing
 KASAN: null-ptr-deref in range [0x0000000000000010-0x0000000000000017]

 CPU: 5 UID: 0 PID: 0 Comm: swapper/5 Not tainted 6.16.0-rc1-wt-ath+ #2 PREEMPT(full)
 RIP: 0010:ath12k_mac_handle_beacon_miss_iter+0xb5/0x1a0 [ath12k]
 Call Trace:
  __iterate_interfaces+0x11a/0x410 [mac80211]
  ieee80211_iterate_active_interfaces_atomic+0x61/0x140 [mac80211]
  ath12k_mac_handle_beacon_miss+0xa1/0xf0 [ath12k]
  ath12k_roam_event+0x393/0x560 [ath12k]
  ath12k_wmi_op_rx+0x1486/0x28c0 [ath12k]
  ath12k_htc_process_trailer.isra.0+0x2fb/0x620 [ath12k]
  ath12k_htc_rx_completion_handler+0x448/0x830 [ath12k]
  ath12k_ce_recv_process_cb+0x549/0x9e0 [ath12k]
  ath12k_ce_per_engine_service+0xbe/0xf0 [ath12k]
  ath12k_pci_ce_workqueue+0x69/0x120 [ath12k]
  process_one_work+0xe3a/0x1430

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00284.1-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Fixes: aa80f12f3bed ("wifi: ath12k: defer vdev creation for MLO")
Signed-off-by: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 15 +++++++++------
 drivers/net/wireless/ath/ath12k/p2p.c |  3 ++-
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 59ec422992d3..5be7b79db341 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -693,6 +693,9 @@ static void ath12k_get_arvif_iter(void *data, u8 *mac,
 		if (WARN_ON(!arvif))
 			continue;
 
+		if (!arvif->is_created)
+			continue;
+
 		if (arvif->vdev_id == arvif_iter->vdev_id &&
 		    arvif->ar == arvif_iter->ar) {
 			arvif_iter->arvif = arvif;
@@ -1755,7 +1758,7 @@ static void ath12k_mac_handle_beacon_iter(void *data, u8 *mac,
 	struct ath12k_vif *ahvif = ath12k_vif_to_ahvif(vif);
 	struct ath12k_link_vif *arvif = &ahvif->deflink;
 
-	if (vif->type != NL80211_IFTYPE_STATION)
+	if (vif->type != NL80211_IFTYPE_STATION || !arvif->is_created)
 		return;
 
 	if (!ether_addr_equal(mgmt->bssid, vif->bss_conf.bssid))
@@ -1778,16 +1781,16 @@ static void ath12k_mac_handle_beacon_miss_iter(void *data, u8 *mac,
 	u32 *vdev_id = data;
 	struct ath12k_vif *ahvif = ath12k_vif_to_ahvif(vif);
 	struct ath12k_link_vif *arvif = &ahvif->deflink;
-	struct ath12k *ar = arvif->ar;
-	struct ieee80211_hw *hw = ath12k_ar_to_hw(ar);
+	struct ieee80211_hw *hw;
 
-	if (arvif->vdev_id != *vdev_id)
+	if (!arvif->is_created || arvif->vdev_id != *vdev_id)
 		return;
 
 	if (!arvif->is_up)
 		return;
 
 	ieee80211_beacon_loss(vif);
+	hw = ath12k_ar_to_hw(arvif->ar);
 
 	/* Firmware doesn't report beacon loss events repeatedly. If AP probe
 	 * (done by mac80211) succeeds but beacons do not resume then it
@@ -9818,7 +9821,7 @@ ath12k_mac_change_chanctx_cnt_iter(void *data, u8 *mac,
 		if (WARN_ON(!arvif))
 			continue;
 
-		if (arvif->ar != arg->ar)
+		if (!arvif->is_created || arvif->ar != arg->ar)
 			continue;
 
 		link_conf = wiphy_dereference(ahvif->ah->hw->wiphy,
@@ -9853,7 +9856,7 @@ ath12k_mac_change_chanctx_fill_iter(void *data, u8 *mac,
 		if (WARN_ON(!arvif))
 			continue;
 
-		if (arvif->ar != arg->ar)
+		if (!arvif->is_created || arvif->ar != arg->ar)
 			continue;
 
 		link_conf = wiphy_dereference(ahvif->ah->hw->wiphy,
diff --git a/drivers/net/wireless/ath/ath12k/p2p.c b/drivers/net/wireless/ath/ath12k/p2p.c
index 84cccf7d91e7..59589748f1a8 100644
--- a/drivers/net/wireless/ath/ath12k/p2p.c
+++ b/drivers/net/wireless/ath/ath12k/p2p.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
 #include <net/mac80211.h>
@@ -124,7 +125,7 @@ static void ath12k_p2p_noa_update_vdev_iter(void *data, u8 *mac,
 
 	WARN_ON(!rcu_read_lock_any_held());
 	arvif = &ahvif->deflink;
-	if (arvif->ar != arg->ar || arvif->vdev_id != arg->vdev_id)
+	if (!arvif->is_created || arvif->ar != arg->ar || arvif->vdev_id != arg->vdev_id)
 		return;
 
 	ath12k_p2p_noa_update(arvif, arg->noa);

base-commit: ede00d893af8a50412c3b93067322d27fb8ee97d
-- 
2.34.1


