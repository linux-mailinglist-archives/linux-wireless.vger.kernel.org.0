Return-Path: <linux-wireless+bounces-21300-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE631A81C11
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Apr 2025 07:27:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84593446C0C
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Apr 2025 05:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67A096F073;
	Wed,  9 Apr 2025 05:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oRDIs2yj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D170F9CB
	for <linux-wireless@vger.kernel.org>; Wed,  9 Apr 2025 05:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744176424; cv=none; b=MtI8j7mUx9KwTsChCLOjAvd4SXEk7Jwo8NB2CusUONhbQOX1Z3Iz2pNiejSctkPWXDQe5dZxNHUHRVRvIHpNUtcpxJu2wBlPdh7DfL5JQWCzmXzOrvW69Rr3aBNC7CwHJuRtdDpxYz+uttTst+e1+zmnU4iZ1bRCEsjoHG3wDls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744176424; c=relaxed/simple;
	bh=AuEQdwctn5pFZHHN4JwUwbWDWQLDTjzz4n1DlnfhKiU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=e3W/6r6oo38OkGHUyt/jHVP68mE2MYjDYmjbm5rvuJ96IEoYvDVHpdIBvIDGDvy6r4Q99rTlpLIoFXXkCcjYvgfPrwQUhUtLTBJIdRu2H21uZqr9V7U6IjrAsZMnm3PtBhceM3iPwqxZ3ER7dCbi/J+1lz3YQ6Pp6tmigYmPR7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oRDIs2yj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 538JYqTb027520
	for <linux-wireless@vger.kernel.org>; Wed, 9 Apr 2025 05:27:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=QutkmXyXq5eFcTbka2zGCG4N7MhPJeanGDV
	N3nOrxjU=; b=oRDIs2yjaaJ/WQhqS55adZWdKXHNpGsN3KMZ1/QcjuZTw6LYSF1
	VveqhmwZOVvwO/a9b0XHKKsQclkcwjpXOavNdHqyDH2F5Fx14nW/sSpXAYGSWJPP
	D/0mbekBL/G2g/1YmlMnLCbfZ6bL6KrCCNIxMWXqo/AYP+UhFevm6JDWT8eYt1Qi
	oTUo87UviU/GgQK+r1xqpL3tAD+mmsJWVFf9JnIw37VpqnzYkjpLYVGcDwCSV6k1
	U3XtnlB34j9tGFSh5DBCzpOy7LNDWRfLmnPr7VGQRJSUIxSPyB3hvTyRTs8wisbX
	QSGptSxJuhhO+9Aot1hOI0/UzDvs1eP3HTQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twcrj7mr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 09 Apr 2025 05:27:00 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-225107fbdc7so54160515ad.0
        for <linux-wireless@vger.kernel.org>; Tue, 08 Apr 2025 22:27:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744176419; x=1744781219;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QutkmXyXq5eFcTbka2zGCG4N7MhPJeanGDVN3nOrxjU=;
        b=FF4OoSY84A9je22aIzzGFcjQRzH03RM9TlseVZC1RVc9loZGfOiciKMPhzjLc3MsTm
         CNhG9lWkTRxZg0+80fPYrAy/+GgwYOUTkFPYrowVfAjMh1K2X2IsnshtmiMOkBdN/Il7
         xbd0Jx+zX/PkuRWHUJ5pIdtw6m1wMfhCfBy1NYihohxqbKfoTiuBQTybAz6ScFDIiPfH
         qc3R/LskfIuJT7hqYuaGJBJ/yLW3ncTTNaJDJjY8Hr2axVUU9MeB3UC0s1tLolErrCHN
         owq1Oqjb/YQxd9bf9EAYaCikTVDqYkE7BFTAcC6z/+Qo+4lrT8BH9TLIiYHkOgC7MlK8
         NwkQ==
X-Gm-Message-State: AOJu0YxHTlxAPwtcLm3ph/Gaq3g2PLIo8D9rjE22v32kuZT4h0kGJ5Fn
	e2Z4aJ+Z3durPyg5RKSqSg0CDRzlK8KMSmMytuuSFgW0Kj6XujJe4he5mvYGtblKEZW23zG1meL
	3r8hZA6b6TaYXoi8fB/8DMRAy71Fq23GEfEIR+JWsSv2pdOepxtALeJL/A3VhU9PQAWXj7S4fYw
	==
X-Gm-Gg: ASbGnct0ZC8sTWKRgPM31n5yhuKSE/wYPxzNUrj+vLn7rXYoW8ub2GvsFAGBTEbK9/0
	7I+qqL0B7PL7d2zClk5jkjspNRvUnASkKLoNuRY/0tOxcCb+WCxl8+ib6PNacwYkVCw7E37f9dI
	pPtGDVLjpmLiXM+TmEKHGqd6gIjVG0AKRw8KpSjQgTI9uAFaubgJtFF83lPyzmrrevLMmgRhQbU
	kvQHcBgCi6M7wicsBL4qIEMz7bB2cNzXvrTuKEII51s4ymeiJjsvjqWXW7GgWH5Hhmu5UlUh1Wl
	EwugwpKR3kOmuvfNpvwUKq+YPFFPZP32ntFkbSpCAIqc9KRiv6cjuFQMADGBlDFQn6sxhg4njuf
	F9D4W2cgMP4SVADRLUlqQCD92TAqOmURPGg==
X-Received: by 2002:a17:903:3ba7:b0:224:78e:4eb4 with SMTP id d9443c01a7336-22ac2a276a1mr24096035ad.39.1744176419240;
        Tue, 08 Apr 2025 22:26:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHGlZMelEQYaQzA5DSX62Jx9/7i7zdHhbRxpE9Zxkg24Qg0ZkCrf+7+8QdPACyRYGqWc19g2A==
X-Received: by 2002:a17:903:3ba7:b0:224:78e:4eb4 with SMTP id d9443c01a7336-22ac2a276a1mr24095815ad.39.1744176418847;
        Tue, 08 Apr 2025 22:26:58 -0700 (PDT)
Received: from hu-ppranees-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-306df4011e6sm424862a91.44.2025.04.08.22.26.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 22:26:58 -0700 (PDT)
From: P Praneesh <praneesh.p@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH ath-next] wifi: ath12k: Avoid allocating rx_stats when ext_rx_stats is disabled
Date: Wed,  9 Apr 2025 10:56:47 +0530
Message-Id: <20250409052647.81955-1-praneesh.p@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: bnQ3dzHVWMEpvcqMSeKLin4FAwxPw-_y
X-Authority-Analysis: v=2.4 cv=QuVe3Uyd c=1 sm=1 tr=0 ts=67f60524 cx=c_pps a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=hGnVruaWzbSFpmBbWLkA:9 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: bnQ3dzHVWMEpvcqMSeKLin4FAwxPw-_y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-09_02,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 spamscore=0 malwarescore=0 mlxlogscore=887 bulkscore=0 priorityscore=1501
 clxscore=1015 phishscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504090020

Currently, driver allocates the struct ath12k_rx_peer_stats for each
station regardless of whether ext_rx_stats is enabled. This structure
is populated by the monitor destination ring for both single-user and
multi-user scenarios when ext_rx_stats is enabled. However, when
ext_rx_stats is disabled, this allocation is unnecessary and results in
additional memory consumption.

To address this issue, allocate the struct ath12k_rx_peer_stats only when
ext_rx_stats is enabled through debugfs. This change prevents unnecessary
memory allocation. Additionally, ensure that the station dump RSSI is
updated irrespective of the ext_rx_stats enablement.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: P Praneesh <praneesh.p@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/dp_mon.c | 11 ++++-------
 drivers/net/wireless/ath/ath12k/mac.c    |  2 +-
 2 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp_mon.c b/drivers/net/wireless/ath/ath12k/dp_mon.c
index 6df04920a0c6..64647136620d 100644
--- a/drivers/net/wireless/ath/ath12k/dp_mon.c
+++ b/drivers/net/wireless/ath/ath12k/dp_mon.c
@@ -3203,11 +3203,10 @@ static void ath12k_dp_mon_rx_update_peer_su_stats(struct ath12k *ar,
 	struct ath12k_rx_peer_stats *rx_stats = arsta->rx_stats;
 	u32 num_msdu;
 
-	if (!rx_stats)
-		return;
-
 	arsta->rssi_comb = ppdu_info->rssi_comb;
 	ewma_avg_rssi_add(&arsta->avg_rssi, ppdu_info->rssi_comb);
+	if (!rx_stats)
+		return;
 
 	num_msdu = ppdu_info->tcp_msdu_count + ppdu_info->tcp_ack_msdu_count +
 		   ppdu_info->udp_msdu_count + ppdu_info->other_msdu_count;
@@ -3380,14 +3379,12 @@ ath12k_dp_mon_rx_update_user_stats(struct ath12k *ar,
 
 	ahsta = ath12k_sta_to_ahsta(peer->sta);
 	arsta = &ahsta->deflink;
+	arsta->rssi_comb = ppdu_info->rssi_comb;
+	ewma_avg_rssi_add(&arsta->avg_rssi, ppdu_info->rssi_comb);
 	rx_stats = arsta->rx_stats;
-
 	if (!rx_stats)
 		return;
 
-	arsta->rssi_comb = ppdu_info->rssi_comb;
-	ewma_avg_rssi_add(&arsta->avg_rssi, ppdu_info->rssi_comb);
-
 	num_msdu = user_stats->tcp_msdu_count + user_stats->tcp_ack_msdu_count +
 		   user_stats->udp_msdu_count + user_stats->other_msdu_count;
 
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index b19e30d95560..9a8f3f3cc19d 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -5578,7 +5578,7 @@ static int ath12k_mac_station_add(struct ath12k *ar,
 		goto exit;
 	}
 
-	if (!arsta->rx_stats) {
+	if (ath12k_debugfs_is_extd_rx_stats_enabled(ar) && !arsta->rx_stats) {
 		arsta->rx_stats = kzalloc(sizeof(*arsta->rx_stats), GFP_KERNEL);
 		if (!arsta->rx_stats) {
 			ret = -ENOMEM;

base-commit: 12b93f7c6d101d22e0ea3bf4a240699746c79117
-- 
2.34.1


