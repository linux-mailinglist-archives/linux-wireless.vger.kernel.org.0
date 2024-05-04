Return-Path: <linux-wireless+bounces-7172-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CF728BBE30
	for <lists+linux-wireless@lfdr.de>; Sat,  4 May 2024 23:36:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3ED2281B92
	for <lists+linux-wireless@lfdr.de>; Sat,  4 May 2024 21:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35D2C757F5;
	Sat,  4 May 2024 21:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nPGh4N+c"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53CF1BF3F;
	Sat,  4 May 2024 21:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714858610; cv=none; b=snukfQDeAU8LifkcXTn7X2nt6OlHhegjNmjilAO297yfdAaTsQ3CWRGImaCWLStwDZbbU45JxAP8e/mZW7VJTKQq13//KSm9Gnrheq0u09jz40B8v47O/MGQ7MnGMGcyvI5WsOHKuyLvOxinaLm9xdym4HEykJRjMwncgX7jtH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714858610; c=relaxed/simple;
	bh=AE5O4YRZJlCDMrRcuWe2Dt7nI9fAACMlvGK82pKtDAc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=HoKxv3gbGxPX5Yk3hqmbUj8O5Su9YOiwt3d092pwcKPsiI3k+4UJWXXng0WAR9UfdMsNneYM5ETWE5UexTPiKd4SZKZfR1UYhymyvr4s65GkHFvLciojX7DLBVILYzp45QTm1KVR6if7U0kLyP4oZNUDuwS34vYur8Z4tHi/dD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=nPGh4N+c; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 444LEBaS020085;
	Sat, 4 May 2024 21:36:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:to:cc; s=qcppdkim1; bh=9sZ
	/GHLSwizHP2i5dEDasu3GrO1hp+EymMagi7diVIU=; b=nPGh4N+clp/+W1AWLkC
	bDuETlZuK+5ppWCfE6BXuxTDA5/pDT2VHdhtoVi/HItL4sUdggYqfewSnn/LzMjJ
	0R3fqtxSJOF8EaWD9ziDMPGBYkOzxN61wSi8q5huiN7qfbD3cPWhnaGmMEfUW0gW
	ug6qehrlKMaVmn55zUcPHiT0vTkkRc1hQCLk9eIKxA3HDh6ixaaTDpPlSmLn+Co0
	zPhunfTyNgvG8Uaw3Ji8TdzWvzeoZ/I2lR7iDtgMZchU0GaGt+Ha+UwEG+fyaU4n
	f7WVzgUpmRrLld/dKH3lBi2VszS6LAjDYL36F0C3XCIg7Mk86wGD9QJFxp2ZBj39
	ozg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xwacsh7v1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 04 May 2024 21:36:38 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 444Lab4Y008808
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 4 May 2024 21:36:37 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sat, 4 May 2024
 14:36:37 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Sat, 4 May 2024 14:36:35 -0700
Subject: [PATCH] wifi: ath11k: fix misspelling of "dma" in
 num_rxmda_per_pdev
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240504-ath11k-num_rxmda_per_pdev-v1-1-7f97bced8495@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAGKqNmYC/42OQQ6DIBREr9KwLg1gNdpV79E0Bj7fQhrRghIb4
 90L7rpz+ZKZN7OSgN5iILfTSjxGG+zgEvDziYCR7oXU6sREMHFlJeNUTobzN3Vz3/ql17Id0be
 jxkiZhqIWUCgARVJ/9NjZZXc/nomVDEiVlw5MNvYyTOhz0NgwDf67f4g8x4/MRU45rVSFXdWUt
 dTd/TNbsA4uMPQkD0Zx2CWSC5UqkbNGF7r+d23b9gOU0aznKQEAAA==
To: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-wireless@vger.kernel.org>,
        <ath11k@lists.infradead.org>, Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: qVFWYHbHTnq90FdkCtyKnm62DJOK1d0A
X-Proofpoint-ORIG-GUID: qVFWYHbHTnq90FdkCtyKnm62DJOK1d0A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-04_17,2024-05-03_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 bulkscore=0 spamscore=0 phishscore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 adultscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2405040139

The ath11k_hw_params member num_rxmda_per_pdev contains a misspelling
of "dma" so fix it.

No functional changes, compile tested only.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
Encountered this spelling issue while working on ath12k, and since it
is also present in ath11k, fix it here as well.
---
 drivers/net/wireless/ath/ath11k/core.c    | 20 ++++++++++----------
 drivers/net/wireless/ath/ath11k/debugfs.c |  6 +++---
 drivers/net/wireless/ath/ath11k/dp.c      | 12 ++++++------
 drivers/net/wireless/ath/ath11k/dp_rx.c   | 24 ++++++++++++------------
 drivers/net/wireless/ath/ath11k/dp_tx.c   |  6 +++---
 drivers/net/wireless/ath/ath11k/hw.h      |  4 ++--
 drivers/net/wireless/ath/ath11k/mac.c     |  2 +-
 drivers/net/wireless/ath/ath11k/reg.c     |  4 ++--
 drivers/net/wireless/ath/ath11k/wmi.c     |  2 +-
 9 files changed, 40 insertions(+), 40 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index 3cc817a3b4a4..d4ef556852c2 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -62,7 +62,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.ce_ie_addr = &ath11k_ce_ie_addr_ipq8074,
 		.single_pdev_only = false,
 		.rxdma1_enable = true,
-		.num_rxmda_per_pdev = 1,
+		.num_rxdma_per_pdev = 1,
 		.rx_mac_buf_ring = false,
 		.vdev_start_delay = false,
 		.htt_peer_map_v2 = true,
@@ -148,7 +148,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.ce_ie_addr = &ath11k_ce_ie_addr_ipq8074,
 		.single_pdev_only = false,
 		.rxdma1_enable = true,
-		.num_rxmda_per_pdev = 1,
+		.num_rxdma_per_pdev = 1,
 		.rx_mac_buf_ring = false,
 		.vdev_start_delay = false,
 		.htt_peer_map_v2 = true,
@@ -232,7 +232,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.ce_ie_addr = &ath11k_ce_ie_addr_ipq8074,
 		.single_pdev_only = true,
 		.rxdma1_enable = false,
-		.num_rxmda_per_pdev = 2,
+		.num_rxdma_per_pdev = 2,
 		.rx_mac_buf_ring = true,
 		.vdev_start_delay = true,
 		.htt_peer_map_v2 = false,
@@ -320,7 +320,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.svc_to_ce_map_len = 18,
 		.ce_ie_addr = &ath11k_ce_ie_addr_ipq8074,
 		.rxdma1_enable = true,
-		.num_rxmda_per_pdev = 1,
+		.num_rxdma_per_pdev = 1,
 		.rx_mac_buf_ring = false,
 		.vdev_start_delay = false,
 		.htt_peer_map_v2 = true,
@@ -404,7 +404,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.ce_ie_addr = &ath11k_ce_ie_addr_ipq8074,
 		.single_pdev_only = true,
 		.rxdma1_enable = false,
-		.num_rxmda_per_pdev = 2,
+		.num_rxdma_per_pdev = 2,
 		.rx_mac_buf_ring = true,
 		.vdev_start_delay = true,
 		.htt_peer_map_v2 = false,
@@ -492,7 +492,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.svc_to_ce_map_len = 14,
 		.single_pdev_only = true,
 		.rxdma1_enable = false,
-		.num_rxmda_per_pdev = 2,
+		.num_rxdma_per_pdev = 2,
 		.rx_mac_buf_ring = true,
 		.vdev_start_delay = true,
 		.htt_peer_map_v2 = false,
@@ -580,7 +580,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.ce_ie_addr = &ath11k_ce_ie_addr_ipq8074,
 		.single_pdev_only = true,
 		.rxdma1_enable = false,
-		.num_rxmda_per_pdev = 1,
+		.num_rxdma_per_pdev = 1,
 		.rx_mac_buf_ring = true,
 		.vdev_start_delay = true,
 		.htt_peer_map_v2 = false,
@@ -673,7 +673,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.ce_ie_addr = &ath11k_ce_ie_addr_ipq5018,
 		.ce_remap = &ath11k_ce_remap_ipq5018,
 		.rxdma1_enable = true,
-		.num_rxmda_per_pdev = RXDMA_PER_PDEV_5018,
+		.num_rxdma_per_pdev = RXDMA_PER_PDEV_5018,
 		.rx_mac_buf_ring = false,
 		.vdev_start_delay = false,
 		.htt_peer_map_v2 = true,
@@ -744,7 +744,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.ce_ie_addr = &ath11k_ce_ie_addr_ipq8074,
 		.single_pdev_only = true,
 		.rxdma1_enable = false,
-		.num_rxmda_per_pdev = 2,
+		.num_rxdma_per_pdev = 2,
 		.rx_mac_buf_ring = true,
 		.vdev_start_delay = true,
 		.htt_peer_map_v2 = false,
@@ -1801,7 +1801,7 @@ static int ath11k_core_start(struct ath11k_base *ab)
 	}
 
 	/* put hardware to DBS mode */
-	if (ab->hw_params.single_pdev_only && ab->hw_params.num_rxmda_per_pdev > 1) {
+	if (ab->hw_params.single_pdev_only && ab->hw_params.num_rxdma_per_pdev > 1) {
 		ret = ath11k_wmi_set_hw_mode(ab, WMI_HOST_HW_MODE_DBS);
 		if (ret) {
 			ath11k_err(ab, "failed to send dbs mode: %d\n", ret);
diff --git a/drivers/net/wireless/ath/ath11k/debugfs.c b/drivers/net/wireless/ath/ath11k/debugfs.c
index 414a5ce279f7..57281a135dd7 100644
--- a/drivers/net/wireless/ath/ath11k/debugfs.c
+++ b/drivers/net/wireless/ath/ath11k/debugfs.c
@@ -668,7 +668,7 @@ static ssize_t ath11k_write_extd_rx_stats(struct file *file,
 
 	ar->debug.rx_filter = tlv_filter.rx_filter;
 
-	for (i = 0; i < ab->hw_params.num_rxmda_per_pdev; i++) {
+	for (i = 0; i < ab->hw_params.num_rxdma_per_pdev; i++) {
 		ring_id = ar->dp.rx_mon_status_refill_ring[i].refill_buf_ring.ring_id;
 		ret = ath11k_dp_tx_htt_rx_filter_setup(ar->ab, ring_id, ar->dp.mac_id,
 						       HAL_RXDMA_MONITOR_STATUS,
@@ -1112,7 +1112,7 @@ static ssize_t ath11k_write_pktlog_filter(struct file *file,
 	}
 
 	/* Clear rx filter set for monitor mode and rx status */
-	for (i = 0; i < ab->hw_params.num_rxmda_per_pdev; i++) {
+	for (i = 0; i < ab->hw_params.num_rxdma_per_pdev; i++) {
 		ring_id = ar->dp.rx_mon_status_refill_ring[i].refill_buf_ring.ring_id;
 		ret = ath11k_dp_tx_htt_rx_filter_setup(ar->ab, ring_id, ar->dp.mac_id,
 						       HAL_RXDMA_MONITOR_STATUS,
@@ -1171,7 +1171,7 @@ static ssize_t ath11k_write_pktlog_filter(struct file *file,
 					       HTT_RX_FP_DATA_FILTER_FLASG3;
 	}
 
-	for (i = 0; i < ab->hw_params.num_rxmda_per_pdev; i++) {
+	for (i = 0; i < ab->hw_params.num_rxdma_per_pdev; i++) {
 		ring_id = ar->dp.rx_mon_status_refill_ring[i].refill_buf_ring.ring_id;
 		ret = ath11k_dp_tx_htt_rx_filter_setup(ab, ring_id,
 						       ar->dp.mac_id + i,
diff --git a/drivers/net/wireless/ath/ath11k/dp.c b/drivers/net/wireless/ath/ath11k/dp.c
index 1a62407e5a9f..fbf666d0ecf1 100644
--- a/drivers/net/wireless/ath/ath11k/dp.c
+++ b/drivers/net/wireless/ath/ath11k/dp.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #include <crypto/hash.h>
@@ -830,8 +830,8 @@ int ath11k_dp_service_srng(struct ath11k_base *ab,
 
 	if (ab->hw_params.ring_mask->rx_mon_status[grp_id]) {
 		for (i = 0; i < ab->num_radios; i++) {
-			for (j = 0; j < ab->hw_params.num_rxmda_per_pdev; j++) {
-				int id = i * ab->hw_params.num_rxmda_per_pdev + j;
+			for (j = 0; j < ab->hw_params.num_rxdma_per_pdev; j++) {
+				int id = i * ab->hw_params.num_rxdma_per_pdev + j;
 
 				if (ab->hw_params.ring_mask->rx_mon_status[grp_id] &
 					BIT(id)) {
@@ -853,8 +853,8 @@ int ath11k_dp_service_srng(struct ath11k_base *ab,
 		ath11k_dp_process_reo_status(ab);
 
 	for (i = 0; i < ab->num_radios; i++) {
-		for (j = 0; j < ab->hw_params.num_rxmda_per_pdev; j++) {
-			int id = i * ab->hw_params.num_rxmda_per_pdev + j;
+		for (j = 0; j < ab->hw_params.num_rxdma_per_pdev; j++) {
+			int id = i * ab->hw_params.num_rxdma_per_pdev + j;
 
 			if (ab->hw_params.ring_mask->rxdma2host[grp_id] & BIT(id)) {
 				work_done = ath11k_dp_process_rxdma_err(ab, id, budget);
@@ -913,7 +913,7 @@ void ath11k_dp_pdev_pre_alloc(struct ath11k_base *ab)
 		spin_lock_init(&dp->rx_refill_buf_ring.idr_lock);
 		atomic_set(&dp->num_tx_pending, 0);
 		init_waitqueue_head(&dp->tx_empty_waitq);
-		for (j = 0; j < ab->hw_params.num_rxmda_per_pdev; j++) {
+		for (j = 0; j < ab->hw_params.num_rxdma_per_pdev; j++) {
 			idr_init(&dp->rx_mon_status_refill_ring[j].bufs_idr);
 			spin_lock_init(&dp->rx_mon_status_refill_ring[j].idr_lock);
 		}
diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
index afd481f5858f..f2c055c50818 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #include <linux/ieee80211.h>
@@ -311,7 +311,7 @@ static void ath11k_dp_service_mon_ring(struct timer_list *t)
 	struct ath11k_base *ab = from_timer(ab, t, mon_reap_timer);
 	int i;
 
-	for (i = 0; i < ab->hw_params.num_rxmda_per_pdev; i++)
+	for (i = 0; i < ab->hw_params.num_rxdma_per_pdev; i++)
 		ath11k_dp_rx_process_mon_rings(ab, i, NULL, DP_MON_SERVICE_BUDGET);
 
 	mod_timer(&ab->mon_reap_timer, jiffies +
@@ -324,7 +324,7 @@ static int ath11k_dp_purge_mon_ring(struct ath11k_base *ab)
 	unsigned long timeout = jiffies + msecs_to_jiffies(DP_MON_PURGE_TIMEOUT_MS);
 
 	do {
-		for (i = 0; i < ab->hw_params.num_rxmda_per_pdev; i++)
+		for (i = 0; i < ab->hw_params.num_rxdma_per_pdev; i++)
 			reaped += ath11k_dp_rx_process_mon_rings(ab, i,
 								 NULL,
 								 DP_MON_SERVICE_BUDGET);
@@ -468,7 +468,7 @@ static int ath11k_dp_rxdma_pdev_buf_free(struct ath11k *ar)
 	rx_ring = &dp->rxdma_mon_buf_ring;
 	ath11k_dp_rxdma_buf_ring_free(ar, rx_ring);
 
-	for (i = 0; i < ab->hw_params.num_rxmda_per_pdev; i++) {
+	for (i = 0; i < ab->hw_params.num_rxdma_per_pdev; i++) {
 		rx_ring = &dp->rx_mon_status_refill_ring[i];
 		ath11k_dp_rxdma_buf_ring_free(ar, rx_ring);
 	}
@@ -506,7 +506,7 @@ static int ath11k_dp_rxdma_pdev_buf_setup(struct ath11k *ar)
 		ath11k_dp_rxdma_ring_buf_setup(ar, rx_ring, HAL_RXDMA_MONITOR_BUF);
 	}
 
-	for (i = 0; i < ab->hw_params.num_rxmda_per_pdev; i++) {
+	for (i = 0; i < ab->hw_params.num_rxdma_per_pdev; i++) {
 		rx_ring = &dp->rx_mon_status_refill_ring[i];
 		ath11k_dp_rxdma_ring_buf_setup(ar, rx_ring, HAL_RXDMA_MONITOR_STATUS);
 	}
@@ -522,7 +522,7 @@ static void ath11k_dp_rx_pdev_srng_free(struct ath11k *ar)
 
 	ath11k_dp_srng_cleanup(ab, &dp->rx_refill_buf_ring.refill_buf_ring);
 
-	for (i = 0; i < ab->hw_params.num_rxmda_per_pdev; i++) {
+	for (i = 0; i < ab->hw_params.num_rxdma_per_pdev; i++) {
 		if (ab->hw_params.rx_mac_buf_ring)
 			ath11k_dp_srng_cleanup(ab, &dp->rx_mac_buf_ring[i]);
 
@@ -585,7 +585,7 @@ static int ath11k_dp_rx_pdev_srng_alloc(struct ath11k *ar)
 	}
 
 	if (ar->ab->hw_params.rx_mac_buf_ring) {
-		for (i = 0; i < ab->hw_params.num_rxmda_per_pdev; i++) {
+		for (i = 0; i < ab->hw_params.num_rxdma_per_pdev; i++) {
 			ret = ath11k_dp_srng_setup(ar->ab,
 						   &dp->rx_mac_buf_ring[i],
 						   HAL_RXDMA_BUF, 1,
@@ -598,7 +598,7 @@ static int ath11k_dp_rx_pdev_srng_alloc(struct ath11k *ar)
 		}
 	}
 
-	for (i = 0; i < ab->hw_params.num_rxmda_per_pdev; i++) {
+	for (i = 0; i < ab->hw_params.num_rxdma_per_pdev; i++) {
 		ret = ath11k_dp_srng_setup(ar->ab, &dp->rxdma_err_dst_ring[i],
 					   HAL_RXDMA_DST, 0, dp->mac_id + i,
 					   DP_RXDMA_ERR_DST_RING_SIZE);
@@ -608,7 +608,7 @@ static int ath11k_dp_rx_pdev_srng_alloc(struct ath11k *ar)
 		}
 	}
 
-	for (i = 0; i < ab->hw_params.num_rxmda_per_pdev; i++) {
+	for (i = 0; i < ab->hw_params.num_rxdma_per_pdev; i++) {
 		srng = &dp->rx_mon_status_refill_ring[i].refill_buf_ring;
 		ret = ath11k_dp_srng_setup(ar->ab,
 					   srng,
@@ -4391,7 +4391,7 @@ int ath11k_dp_rx_pdev_alloc(struct ath11k_base *ab, int mac_id)
 	}
 
 	if (ab->hw_params.rx_mac_buf_ring) {
-		for (i = 0; i < ab->hw_params.num_rxmda_per_pdev; i++) {
+		for (i = 0; i < ab->hw_params.num_rxdma_per_pdev; i++) {
 			ring_id = dp->rx_mac_buf_ring[i].ring_id;
 			ret = ath11k_dp_tx_htt_srng_setup(ab, ring_id,
 							  mac_id + i, HAL_RXDMA_BUF);
@@ -4403,7 +4403,7 @@ int ath11k_dp_rx_pdev_alloc(struct ath11k_base *ab, int mac_id)
 		}
 	}
 
-	for (i = 0; i < ab->hw_params.num_rxmda_per_pdev; i++) {
+	for (i = 0; i < ab->hw_params.num_rxdma_per_pdev; i++) {
 		ring_id = dp->rxdma_err_dst_ring[i].ring_id;
 		ret = ath11k_dp_tx_htt_srng_setup(ab, ring_id,
 						  mac_id + i, HAL_RXDMA_DST);
@@ -4443,7 +4443,7 @@ int ath11k_dp_rx_pdev_alloc(struct ath11k_base *ab, int mac_id)
 	}
 
 config_refill_ring:
-	for (i = 0; i < ab->hw_params.num_rxmda_per_pdev; i++) {
+	for (i = 0; i < ab->hw_params.num_rxdma_per_pdev; i++) {
 		ring_id = dp->rx_mon_status_refill_ring[i].refill_buf_ring.ring_id;
 		ret = ath11k_dp_tx_htt_srng_setup(ab, ring_id, mac_id + i,
 						  HAL_RXDMA_MONITOR_STATUS);
diff --git a/drivers/net/wireless/ath/ath11k/dp_tx.c b/drivers/net/wireless/ath/ath11k/dp_tx.c
index 272b1c35f98d..21819b741701 100644
--- a/drivers/net/wireless/ath/ath11k/dp_tx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_tx.c
@@ -1035,7 +1035,7 @@ int ath11k_dp_tx_htt_h2t_ppdu_stats_req(struct ath11k *ar, u32 mask)
 	int ret;
 	int i;
 
-	for (i = 0; i < ab->hw_params.num_rxmda_per_pdev; i++) {
+	for (i = 0; i < ab->hw_params.num_rxdma_per_pdev; i++) {
 		skb = ath11k_htc_alloc_skb(ab, len);
 		if (!skb)
 			return -ENOMEM;
@@ -1218,7 +1218,7 @@ int ath11k_dp_tx_htt_monitor_mode_ring_config(struct ath11k *ar, bool reset)
 						       &tlv_filter);
 	} else if (!reset) {
 		/* set in monitor mode only */
-		for (i = 0; i < ab->hw_params.num_rxmda_per_pdev; i++) {
+		for (i = 0; i < ab->hw_params.num_rxdma_per_pdev; i++) {
 			ring_id = dp->rx_mac_buf_ring[i].ring_id;
 			ret = ath11k_dp_tx_htt_rx_filter_setup(ar->ab, ring_id,
 							       dp->mac_id + i,
@@ -1231,7 +1231,7 @@ int ath11k_dp_tx_htt_monitor_mode_ring_config(struct ath11k *ar, bool reset)
 	if (ret)
 		return ret;
 
-	for (i = 0; i < ab->hw_params.num_rxmda_per_pdev; i++) {
+	for (i = 0; i < ab->hw_params.num_rxdma_per_pdev; i++) {
 		ring_id = dp->rx_mon_status_refill_ring[i].refill_buf_ring.ring_id;
 		if (!reset) {
 			tlv_filter.rx_filter =
diff --git a/drivers/net/wireless/ath/ath11k/hw.h b/drivers/net/wireless/ath/ath11k/hw.h
index 14ef4eb48f80..300322535766 100644
--- a/drivers/net/wireless/ath/ath11k/hw.h
+++ b/drivers/net/wireless/ath/ath11k/hw.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #ifndef ATH11K_HW_H
@@ -167,7 +167,7 @@ struct ath11k_hw_params {
 	bool single_pdev_only;
 
 	bool rxdma1_enable;
-	int num_rxmda_per_pdev;
+	int num_rxdma_per_pdev;
 	bool rx_mac_buf_ring;
 	bool vdev_start_delay;
 	bool htt_peer_map_v2;
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index a71195344288..17b06c0cd062 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -6108,7 +6108,7 @@ static int ath11k_mac_config_mon_status_default(struct ath11k *ar, bool enable)
 			tlv_filter.rx_filter = ath11k_debugfs_rx_filter(ar);
 	}
 
-	for (i = 0; i < ab->hw_params.num_rxmda_per_pdev; i++) {
+	for (i = 0; i < ab->hw_params.num_rxdma_per_pdev; i++) {
 		ring_id = ar->dp.rx_mon_status_refill_ring[i].refill_buf_ring.ring_id;
 		ret = ath11k_dp_tx_htt_rx_filter_setup(ar->ab, ring_id,
 						       ar->dp.mac_id + i,
diff --git a/drivers/net/wireless/ath/ath11k/reg.c b/drivers/net/wireless/ath/ath11k/reg.c
index 737fcd450d4b..4c3aefbbabbe 100644
--- a/drivers/net/wireless/ath/ath11k/reg.c
+++ b/drivers/net/wireless/ath/ath11k/reg.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 #include <linux/rtnetlink.h>
 
@@ -878,7 +878,7 @@ int ath11k_reg_handle_chan_list(struct ath11k_base *ab,
 		ath11k_reg_reset_info(reg_info);
 
 		if (ab->hw_params.single_pdev_only &&
-		    pdev_idx < ab->hw_params.num_rxmda_per_pdev)
+		    pdev_idx < ab->hw_params.num_rxdma_per_pdev)
 			return 0;
 		goto fallback;
 	}
diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index 6ff01c45f165..38f175dd1557 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -9082,7 +9082,7 @@ int ath11k_wmi_attach(struct ath11k_base *ab)
 	ab->wmi_ab.preferred_hw_mode = WMI_HOST_HW_MODE_MAX;
 
 	/* It's overwritten when service_ext_ready is handled */
-	if (ab->hw_params.single_pdev_only && ab->hw_params.num_rxmda_per_pdev > 1)
+	if (ab->hw_params.single_pdev_only && ab->hw_params.num_rxdma_per_pdev > 1)
 		ab->wmi_ab.preferred_hw_mode = WMI_HOST_HW_MODE_SINGLE;
 
 	/* TODO: Init remaining wmi soc resources required */

---
base-commit: 50971dc6694c0845fcddfe337ea39c5b723d5a92
change-id: 20240501-ath11k-num_rxmda_per_pdev-0dc382c3bccb


