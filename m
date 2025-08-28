Return-Path: <linux-wireless+bounces-26821-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 472E9B3A844
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Aug 2025 19:37:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59A34189B0A1
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Aug 2025 17:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09D8D338F5E;
	Thu, 28 Aug 2025 17:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ZaHixMwO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF6233EB17
	for <linux-wireless@vger.kernel.org>; Thu, 28 Aug 2025 17:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756402591; cv=none; b=MEOq724Yyy3PNn6HGkGXWpfyzJiVQXfXZv/xKqWBvRXia8DXpIQOle3lfZ9M8GGVzcAdTyC3glBE9mlisIsR6SGF1WCveX2Y4A+TgnlolwkjQhb0eEyfTLoVpg0zimfNOiqpKKS3edWyuFGkVbeikXQwif6Vq/FIz4jrIFsneGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756402591; c=relaxed/simple;
	bh=7tcE/JEIj+ChPZ0u/5nEAxIBhyuC73r/9bhcPxjVJWM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CMsurXBe2D/+HzfE9JpPX5ukzZMbIvs7k736kiqfVXDzEG/ZUz9UQVixDcMKTO/biIptxgoQzMDouD2GRMRNQSoLARZ+3S74oHa8qyzbv2csVT0xBXXhf/QOJMk89twgkgq2OVigQJnXmO1I41w0Fb8IljPHO3s9fgQbs/3lpy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ZaHixMwO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57SDMUs8008229;
	Thu, 28 Aug 2025 17:36:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LGxPvR67xa79RTlYYzMClpCKj9/3BXcuMptLUCym0Ps=; b=ZaHixMwOXqZYk2kr
	pP831WJ+442QQzTHCGj59LOgIMbyNRhdgU8xMALqKQ26CntS6QhW4DT33zZLvJ4W
	FHecW1Tm8sy8gNiYM7kh198IYVyUxtxKNDxBX+WQ+glWU5MrScaFruNpJBYsNT3v
	2ud1qAgUlu3JDfUUwKhW+hlnM8/8TpCajuWdC3fa72/c6KGUzdfPH8cJaZ18mi0X
	Twrq7oLCRSlDVzJ18ZE7Mgeghj5iq6zpEzO7M+3U4AvlBzXAQVT8HRW85QJN6Z+3
	m8B5XDQ5kAd+nBcg+wT+bl6VYSwXpWnioF7BXET67ggXc6OOgEeLZWqtR6oytCZA
	4H5rwQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48sh8aqcxk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Aug 2025 17:36:27 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 57SHaRCT019703
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Aug 2025 17:36:27 GMT
Received: from hu-rdeuri-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Thu, 28 Aug 2025 10:36:25 -0700
From: Ripan Deuri <quic_rdeuri@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH ath12k-ng 11/20] wifi: ath12k: Move srng processing to wifi7 directory
Date: Thu, 28 Aug 2025 23:05:44 +0530
Message-ID: <20250828173553.3341351-12-quic_rdeuri@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250828173553.3341351-1-quic_rdeuri@quicinc.com>
References: <20250828173553.3341351-1-quic_rdeuri@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=cLDgskeN c=1 sm=1 tr=0 ts=68b0939b cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=A9GyCDMPox1emiypKBYA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI2MDE1MyBTYWx0ZWRfX+nCa7fNNgnFu
 wPAKaW2lvejF22oOvQMBOa65w+U/zV2kZeOVLZP5IxvubwhM0McPf8CXKJgQ35CRfOwM7C5RIUA
 lgdO0i4pz1/EYKhh9f8eR+qSEGV1yBK3Nk8fRL0TCcuQI61isgvY058oETIuuOPUkpyANr3utqr
 tQGg+wZ5ttX2HjF7Njd2MmKk+2I7rc+rJlNMzZieq0TxH/6Pc8e2d6JY0ZUXpeMv4HONB/VXrCI
 9sYBej4okr4CL+3G84JyQBu1fHHuLRjAqkfdIFnP59iuFruKp927+pYZB5vHAsgTUupscPx5zWX
 zpb2G0z4a3dRQNiSGrkC4F+4+1tU9DknvRvEESvl3tZPIMLIdDNKyLY/vBw7OrHP4PTfMKW+0La
 37eAtwne
X-Proofpoint-GUID: ui6xM5szoliTTiYXMaJljJmz9_0fgA7G
X-Proofpoint-ORIG-GUID: ui6xM5szoliTTiYXMaJljJmz9_0fgA7G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_04,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 malwarescore=0 spamscore=0 adultscore=0
 impostorscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508260153

From: Pavankumar Nandeshwar <quic_pnandesh@quicinc.com>

Move ath12k_dp_service_srng API and ath12k_dp_rx_process_reo_status
to wifi7 directory.

As srng processing is specific to architecture (wifi7 / wifi8), the
API ath12k_dp_service_srng is being moved to wifi7 directory. The
file wifi7/dp.c can be used to define wifi7-specifi functions that are
common to both tx and rx.

The API which is invoked as part of service srng,
ath12k_dp_rx_process_reo_status is also moved to wifi7 directory, as
the implementation is specific to HW due to the usage of wifi7
specific HAL macros.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Pavankumar Nandeshwar <quic_pnandesh@quicinc.com>
Signed-off-by: Ripan Deuri <quic_rdeuri@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/Makefile      |   3 +-
 drivers/net/wireless/ath/ath12k/ahb.c         |   3 +-
 drivers/net/wireless/ath/ath12k/dp.c          | 124 ----------------
 drivers/net/wireless/ath/ath12k/dp.h          |   3 -
 drivers/net/wireless/ath/ath12k/dp_rx.c       |  79 ----------
 drivers/net/wireless/ath/ath12k/dp_rx.h       |   1 -
 drivers/net/wireless/ath/ath12k/pci.c         |   3 +-
 drivers/net/wireless/ath/ath12k/wifi7/dp.c    | 136 ++++++++++++++++++
 drivers/net/wireless/ath/ath12k/wifi7/dp.h    |  15 ++
 drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c |  79 ++++++++++
 drivers/net/wireless/ath/ath12k/wifi7/dp_rx.h |   1 +
 11 files changed, 237 insertions(+), 210 deletions(-)
 create mode 100644 drivers/net/wireless/ath/ath12k/wifi7/dp.c
 create mode 100644 drivers/net/wireless/ath/ath12k/wifi7/dp.h

diff --git a/drivers/net/wireless/ath/ath12k/Makefile b/drivers/net/wireless/ath/ath12k/Makefile
index d7628bb7af02..ed1f1dba3d3b 100644
--- a/drivers/net/wireless/ath/ath12k/Makefile
+++ b/drivers/net/wireless/ath/ath12k/Makefile
@@ -24,7 +24,8 @@ ath12k-$(CONFIG_ATH12K_AHB) += ahb.o
 
 ath12k-y += wifi7/hal_tx.o \
 	    wifi7/hal_rx.o \
-	    wifi7/dp_rx.o
+	    wifi7/dp_rx.o \
+	    wifi7/dp.o
 
 obj-$(CONFIG_ATH12K) += wifi7/
 
diff --git a/drivers/net/wireless/ath/ath12k/ahb.c b/drivers/net/wireless/ath/ath12k/ahb.c
index efb0ef609dcf..ed61dc7ffa68 100644
--- a/drivers/net/wireless/ath/ath12k/ahb.c
+++ b/drivers/net/wireless/ath/ath12k/ahb.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
- * Copyright (c) 2022-2025 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
 #include <linux/dma-mapping.h>
@@ -15,6 +15,7 @@
 #include "ahb.h"
 #include "debug.h"
 #include "hif.h"
+#include "wifi7/dp.h"
 
 #define ATH12K_IRQ_CE0_OFFSET 4
 #define ATH12K_MAX_UPDS 1
diff --git a/drivers/net/wireless/ath/ath12k/dp.c b/drivers/net/wireless/ath/ath12k/dp.c
index 1b4fab3073b0..d0bdf058633f 100644
--- a/drivers/net/wireless/ath/ath12k/dp.c
+++ b/drivers/net/wireless/ath/ath12k/dp.c
@@ -883,130 +883,6 @@ int ath12k_dp_link_desc_setup(struct ath12k_base *ab,
 	return ret;
 }
 
-int ath12k_dp_service_srng(struct ath12k_base *ab,
-			   struct ath12k_ext_irq_grp *irq_grp,
-			   int budget)
-{
-	struct napi_struct *napi = &irq_grp->napi;
-	int grp_id = irq_grp->grp_id;
-	int work_done = 0;
-	int i = 0, j;
-	int tot_work_done = 0;
-	enum dp_monitor_mode monitor_mode;
-	u8 ring_mask;
-
-	if (ab->hw_params->ring_mask->tx[grp_id]) {
-		i = fls(ab->hw_params->ring_mask->tx[grp_id]) - 1;
-		ath12k_dp_tx_completion_handler(ab, i);
-	}
-
-	if (ab->hw_params->ring_mask->rx_err[grp_id]) {
-		work_done = ath12k_dp_rx_process_err(ab, napi, budget);
-		budget -= work_done;
-		tot_work_done += work_done;
-		if (budget <= 0)
-			goto done;
-	}
-
-	if (ab->hw_params->ring_mask->rx_wbm_rel[grp_id]) {
-		work_done = ath12k_dp_rx_process_wbm_err(ab,
-							 napi,
-							 budget);
-		budget -= work_done;
-		tot_work_done += work_done;
-
-		if (budget <= 0)
-			goto done;
-	}
-
-	if (ab->hw_params->ring_mask->rx[grp_id]) {
-		i = fls(ab->hw_params->ring_mask->rx[grp_id]) - 1;
-		work_done = ath12k_dp_rx_process(ab, i, napi,
-						 budget);
-		budget -= work_done;
-		tot_work_done += work_done;
-		if (budget <= 0)
-			goto done;
-	}
-
-	if (ab->hw_params->ring_mask->rx_mon_status[grp_id]) {
-		ring_mask = ab->hw_params->ring_mask->rx_mon_status[grp_id];
-		for (i = 0; i < ab->num_radios; i++) {
-			for (j = 0; j < ab->hw_params->num_rxdma_per_pdev; j++) {
-				int id = i * ab->hw_params->num_rxdma_per_pdev + j;
-
-				if (ring_mask & BIT(id)) {
-					work_done =
-					ath12k_dp_mon_process_ring(ab, id, napi, budget,
-								   0);
-					budget -= work_done;
-					tot_work_done += work_done;
-					if (budget <= 0)
-						goto done;
-				}
-			}
-		}
-	}
-
-	if (ab->hw_params->ring_mask->rx_mon_dest[grp_id]) {
-		monitor_mode = ATH12K_DP_RX_MONITOR_MODE;
-		ring_mask = ab->hw_params->ring_mask->rx_mon_dest[grp_id];
-		for (i = 0; i < ab->num_radios; i++) {
-			for (j = 0; j < ab->hw_params->num_rxdma_per_pdev; j++) {
-				int id = i * ab->hw_params->num_rxdma_per_pdev + j;
-
-				if (ring_mask & BIT(id)) {
-					work_done =
-					ath12k_dp_mon_process_ring(ab, id, napi, budget,
-								   monitor_mode);
-					budget -= work_done;
-					tot_work_done += work_done;
-
-					if (budget <= 0)
-						goto done;
-				}
-			}
-		}
-	}
-
-	if (ab->hw_params->ring_mask->tx_mon_dest[grp_id]) {
-		monitor_mode = ATH12K_DP_TX_MONITOR_MODE;
-		ring_mask = ab->hw_params->ring_mask->tx_mon_dest[grp_id];
-		for (i = 0; i < ab->num_radios; i++) {
-			for (j = 0; j < ab->hw_params->num_rxdma_per_pdev; j++) {
-				int id = i * ab->hw_params->num_rxdma_per_pdev + j;
-
-				if (ring_mask & BIT(id)) {
-					work_done =
-					ath12k_dp_mon_process_ring(ab, id, napi, budget,
-								   monitor_mode);
-					budget -= work_done;
-					tot_work_done += work_done;
-
-					if (budget <= 0)
-						goto done;
-				}
-			}
-		}
-	}
-
-	if (ab->hw_params->ring_mask->reo_status[grp_id])
-		ath12k_dp_rx_process_reo_status(ab);
-
-	if (ab->hw_params->ring_mask->host2rxdma[grp_id]) {
-		struct ath12k_dp *dp = &ab->dp;
-		struct dp_rxdma_ring *rx_ring = &dp->rx_refill_buf_ring;
-		LIST_HEAD(list);
-
-		ath12k_dp_rx_bufs_replenish(ab, rx_ring, &list, 0);
-	}
-
-	/* TODO: Implement handler for other interrupts */
-
-done:
-	return tot_work_done;
-}
-
 void ath12k_dp_pdev_free(struct ath12k_base *ab)
 {
 	int i;
diff --git a/drivers/net/wireless/ath/ath12k/dp.h b/drivers/net/wireless/ath/ath12k/dp.h
index 6ab74d773261..51af354ee769 100644
--- a/drivers/net/wireless/ath/ath12k/dp.h
+++ b/drivers/net/wireless/ath/ath12k/dp.h
@@ -1936,9 +1936,6 @@ static inline void ath12k_dp_get_mac_addr(u32 addr_l32, u16 addr_h16, u8 *addr)
 	memcpy(addr + 4, &addr_h16, ETH_ALEN - 4);
 }
 
-int ath12k_dp_service_srng(struct ath12k_base *ab,
-			   struct ath12k_ext_irq_grp *irq_grp,
-			   int budget);
 int ath12k_dp_htt_connect(struct ath12k_dp *dp);
 void ath12k_dp_vdev_tx_attach(struct ath12k *ar, struct ath12k_link_vif *arvif);
 void ath12k_dp_free(struct ath12k_base *ab);
diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
index 6809c50ee871..8832ba5f5cdb 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -2444,85 +2444,6 @@ u64 ath12k_dp_rx_h_get_pn(struct ath12k *ar, struct sk_buff *skb)
 	return pn;
 }
 
-void ath12k_dp_rx_process_reo_status(struct ath12k_base *ab)
-{
-	struct ath12k_dp *dp = &ab->dp;
-	struct hal_tlv_64_hdr *hdr;
-	struct hal_srng *srng;
-	struct ath12k_dp_rx_reo_cmd *cmd, *tmp;
-	bool found = false;
-	u16 tag;
-	struct hal_reo_status reo_status;
-
-	srng = &ab->hal.srng_list[dp->reo_status_ring.ring_id];
-
-	memset(&reo_status, 0, sizeof(reo_status));
-
-	spin_lock_bh(&srng->lock);
-
-	ath12k_hal_srng_access_begin(ab, srng);
-
-	while ((hdr = ath12k_hal_srng_dst_get_next_entry(ab, srng))) {
-		tag = le64_get_bits(hdr->tl, HAL_SRNG_TLV_HDR_TAG);
-
-		switch (tag) {
-		case HAL_REO_GET_QUEUE_STATS_STATUS:
-			ath12k_hal_reo_status_queue_stats(ab, hdr,
-							  &reo_status);
-			break;
-		case HAL_REO_FLUSH_QUEUE_STATUS:
-			ath12k_hal_reo_flush_queue_status(ab, hdr,
-							  &reo_status);
-			break;
-		case HAL_REO_FLUSH_CACHE_STATUS:
-			ath12k_hal_reo_flush_cache_status(ab, hdr,
-							  &reo_status);
-			break;
-		case HAL_REO_UNBLOCK_CACHE_STATUS:
-			ath12k_hal_reo_unblk_cache_status(ab, hdr,
-							  &reo_status);
-			break;
-		case HAL_REO_FLUSH_TIMEOUT_LIST_STATUS:
-			ath12k_hal_reo_flush_timeout_list_status(ab, hdr,
-								 &reo_status);
-			break;
-		case HAL_REO_DESCRIPTOR_THRESHOLD_REACHED_STATUS:
-			ath12k_hal_reo_desc_thresh_reached_status(ab, hdr,
-								  &reo_status);
-			break;
-		case HAL_REO_UPDATE_RX_REO_QUEUE_STATUS:
-			ath12k_hal_reo_update_rx_reo_queue_status(ab, hdr,
-								  &reo_status);
-			break;
-		default:
-			ath12k_warn(ab, "Unknown reo status type %d\n", tag);
-			continue;
-		}
-
-		spin_lock_bh(&dp->reo_cmd_lock);
-		list_for_each_entry_safe(cmd, tmp, &dp->reo_cmd_list, list) {
-			if (reo_status.uniform_hdr.cmd_num == cmd->cmd_num) {
-				found = true;
-				list_del(&cmd->list);
-				break;
-			}
-		}
-		spin_unlock_bh(&dp->reo_cmd_lock);
-
-		if (found) {
-			cmd->handler(dp, (void *)&cmd->data,
-				     reo_status.uniform_hdr.cmd_status);
-			kfree(cmd);
-		}
-
-		found = false;
-	}
-
-	ath12k_hal_srng_access_end(ab, srng);
-
-	spin_unlock_bh(&srng->lock);
-}
-
 void ath12k_dp_rx_free(struct ath12k_base *ab)
 {
 	struct ath12k_dp *dp = &ab->dp;
diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.h b/drivers/net/wireless/ath/ath12k/dp_rx.h
index 5fc9adeb49bd..b3095fd46cd5 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.h
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.h
@@ -394,7 +394,6 @@ void ath12k_dp_rx_free(struct ath12k_base *ab);
 int ath12k_dp_rx_pdev_alloc(struct ath12k_base *ab, int pdev_idx);
 void ath12k_dp_rx_pdev_free(struct ath12k_base *ab, int pdev_idx);
 void ath12k_dp_rx_reo_cmd_list_cleanup(struct ath12k_base *ab);
-void ath12k_dp_rx_process_reo_status(struct ath12k_base *ab);
 int ath12k_dp_rx_bufs_replenish(struct ath12k_base *ab,
 				struct dp_rxdma_ring *rx_ring,
 				struct list_head *used_list,
diff --git a/drivers/net/wireless/ath/ath12k/pci.c b/drivers/net/wireless/ath/ath12k/pci.c
index 72bcaab6f542..2de566444719 100644
--- a/drivers/net/wireless/ath/ath12k/pci.c
+++ b/drivers/net/wireless/ath/ath12k/pci.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2019-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
 #include <linux/module.h>
@@ -15,6 +15,7 @@
 #include "hif.h"
 #include "mhi.h"
 #include "debug.h"
+#include "wifi7/dp.h"
 
 #define ATH12K_PCI_BAR_NUM		0
 #define ATH12K_PCI_DMA_MASK		36
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/dp.c b/drivers/net/wireless/ath/ath12k/wifi7/dp.c
new file mode 100644
index 000000000000..2e7b9bbd3d8e
--- /dev/null
+++ b/drivers/net/wireless/ath/ath12k/wifi7/dp.c
@@ -0,0 +1,136 @@
+// SPDX-License-Identifier: BSD-3-Clause-Clear
+/*
+ * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+#include "../core.h"
+#include "../debug.h"
+#include "../dp_rx.h"
+#include "../dp_tx.h"
+#include "../dp_mon.h"
+#include "dp_rx.h"
+#include "dp.h"
+
+int ath12k_dp_service_srng(struct ath12k_base *ab,
+			   struct ath12k_ext_irq_grp *irq_grp,
+			   int budget)
+{
+	struct napi_struct *napi = &irq_grp->napi;
+	int grp_id = irq_grp->grp_id;
+	int work_done = 0;
+	int i = 0, j;
+	int tot_work_done = 0;
+	enum dp_monitor_mode monitor_mode;
+	u8 ring_mask;
+
+	if (ab->hw_params->ring_mask->tx[grp_id]) {
+		i = fls(ab->hw_params->ring_mask->tx[grp_id]) - 1;
+		ath12k_dp_tx_completion_handler(ab, i);
+	}
+
+	if (ab->hw_params->ring_mask->rx_err[grp_id]) {
+		work_done = ath12k_dp_rx_process_err(ab, napi, budget);
+		budget -= work_done;
+		tot_work_done += work_done;
+		if (budget <= 0)
+			goto done;
+	}
+
+	if (ab->hw_params->ring_mask->rx_wbm_rel[grp_id]) {
+		work_done = ath12k_dp_rx_process_wbm_err(ab,
+							 napi,
+							 budget);
+		budget -= work_done;
+		tot_work_done += work_done;
+
+		if (budget <= 0)
+			goto done;
+	}
+
+	if (ab->hw_params->ring_mask->rx[grp_id]) {
+		i = fls(ab->hw_params->ring_mask->rx[grp_id]) - 1;
+		work_done = ath12k_dp_rx_process(ab, i, napi,
+						 budget);
+		budget -= work_done;
+		tot_work_done += work_done;
+		if (budget <= 0)
+			goto done;
+	}
+
+	if (ab->hw_params->ring_mask->rx_mon_status[grp_id]) {
+		ring_mask = ab->hw_params->ring_mask->rx_mon_status[grp_id];
+		for (i = 0; i < ab->num_radios; i++) {
+			for (j = 0; j < ab->hw_params->num_rxdma_per_pdev; j++) {
+				int id = i * ab->hw_params->num_rxdma_per_pdev + j;
+
+				if (ring_mask & BIT(id)) {
+					work_done =
+					ath12k_dp_mon_process_ring(ab, id, napi, budget,
+								   0);
+					budget -= work_done;
+					tot_work_done += work_done;
+					if (budget <= 0)
+						goto done;
+				}
+			}
+		}
+	}
+
+	if (ab->hw_params->ring_mask->rx_mon_dest[grp_id]) {
+		monitor_mode = ATH12K_DP_RX_MONITOR_MODE;
+		ring_mask = ab->hw_params->ring_mask->rx_mon_dest[grp_id];
+		for (i = 0; i < ab->num_radios; i++) {
+			for (j = 0; j < ab->hw_params->num_rxdma_per_pdev; j++) {
+				int id = i * ab->hw_params->num_rxdma_per_pdev + j;
+
+				if (ring_mask & BIT(id)) {
+					work_done =
+					ath12k_dp_mon_process_ring(ab, id, napi, budget,
+								   monitor_mode);
+					budget -= work_done;
+					tot_work_done += work_done;
+
+					if (budget <= 0)
+						goto done;
+				}
+			}
+		}
+	}
+
+	if (ab->hw_params->ring_mask->tx_mon_dest[grp_id]) {
+		monitor_mode = ATH12K_DP_TX_MONITOR_MODE;
+		ring_mask = ab->hw_params->ring_mask->tx_mon_dest[grp_id];
+		for (i = 0; i < ab->num_radios; i++) {
+			for (j = 0; j < ab->hw_params->num_rxdma_per_pdev; j++) {
+				int id = i * ab->hw_params->num_rxdma_per_pdev + j;
+
+				if (ring_mask & BIT(id)) {
+					work_done =
+					ath12k_dp_mon_process_ring(ab, id, napi, budget,
+								   monitor_mode);
+					budget -= work_done;
+					tot_work_done += work_done;
+
+					if (budget <= 0)
+						goto done;
+				}
+			}
+		}
+	}
+
+	if (ab->hw_params->ring_mask->reo_status[grp_id])
+		ath12k_dp_rx_process_reo_status(ab);
+
+	if (ab->hw_params->ring_mask->host2rxdma[grp_id]) {
+		struct ath12k_dp *dp = &ab->dp;
+		struct dp_rxdma_ring *rx_ring = &dp->rx_refill_buf_ring;
+		LIST_HEAD(list);
+
+		ath12k_dp_rx_bufs_replenish(ab, rx_ring, &list, 0);
+	}
+
+	/* TODO: Implement handler for other interrupts */
+
+done:
+	return tot_work_done;
+}
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/dp.h b/drivers/net/wireless/ath/ath12k/wifi7/dp.h
new file mode 100644
index 000000000000..17255a5671d7
--- /dev/null
+++ b/drivers/net/wireless/ath/ath12k/wifi7/dp.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: BSD-3-Clause-Clear */
+/*
+ * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef ATH12K_DP_WIFI7_H
+#define ATH12K_DP_WIFI7_H
+
+#include "hw.h"
+
+int ath12k_dp_service_srng(struct ath12k_base *ab,
+			   struct ath12k_ext_irq_grp *irq_grp,
+			   int budget);
+#endif
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c b/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c
index b55cfb926571..cbc51a9a2c42 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c
@@ -1642,3 +1642,82 @@ int ath12k_dp_rxdma_ring_sel_config_wcn7850(struct ath12k_base *ab)
 	return ret;
 }
 EXPORT_SYMBOL(ath12k_dp_rxdma_ring_sel_config_wcn7850);
+
+void ath12k_dp_rx_process_reo_status(struct ath12k_base *ab)
+{
+	struct ath12k_dp *dp = &ab->dp;
+	struct hal_tlv_64_hdr *hdr;
+	struct hal_srng *srng;
+	struct ath12k_dp_rx_reo_cmd *cmd, *tmp;
+	bool found = false;
+	u16 tag;
+	struct hal_reo_status reo_status;
+
+	srng = &ab->hal.srng_list[dp->reo_status_ring.ring_id];
+
+	memset(&reo_status, 0, sizeof(reo_status));
+
+	spin_lock_bh(&srng->lock);
+
+	ath12k_hal_srng_access_begin(ab, srng);
+
+	while ((hdr = ath12k_hal_srng_dst_get_next_entry(ab, srng))) {
+		tag = le64_get_bits(hdr->tl, HAL_SRNG_TLV_HDR_TAG);
+
+		switch (tag) {
+		case HAL_REO_GET_QUEUE_STATS_STATUS:
+			ath12k_hal_reo_status_queue_stats(ab, hdr,
+							  &reo_status);
+			break;
+		case HAL_REO_FLUSH_QUEUE_STATUS:
+			ath12k_hal_reo_flush_queue_status(ab, hdr,
+							  &reo_status);
+			break;
+		case HAL_REO_FLUSH_CACHE_STATUS:
+			ath12k_hal_reo_flush_cache_status(ab, hdr,
+							  &reo_status);
+			break;
+		case HAL_REO_UNBLOCK_CACHE_STATUS:
+			ath12k_hal_reo_unblk_cache_status(ab, hdr,
+							  &reo_status);
+			break;
+		case HAL_REO_FLUSH_TIMEOUT_LIST_STATUS:
+			ath12k_hal_reo_flush_timeout_list_status(ab, hdr,
+								 &reo_status);
+			break;
+		case HAL_REO_DESCRIPTOR_THRESHOLD_REACHED_STATUS:
+			ath12k_hal_reo_desc_thresh_reached_status(ab, hdr,
+								  &reo_status);
+			break;
+		case HAL_REO_UPDATE_RX_REO_QUEUE_STATUS:
+			ath12k_hal_reo_update_rx_reo_queue_status(ab, hdr,
+								  &reo_status);
+			break;
+		default:
+			ath12k_warn(ab, "Unknown reo status type %d\n", tag);
+			continue;
+		}
+
+		spin_lock_bh(&dp->reo_cmd_lock);
+		list_for_each_entry_safe(cmd, tmp, &dp->reo_cmd_list, list) {
+			if (reo_status.uniform_hdr.cmd_num == cmd->cmd_num) {
+				found = true;
+				list_del(&cmd->list);
+				break;
+			}
+		}
+		spin_unlock_bh(&dp->reo_cmd_lock);
+
+		if (found) {
+			cmd->handler(dp, (void *)&cmd->data,
+				     reo_status.uniform_hdr.cmd_status);
+			kfree(cmd);
+		}
+
+		found = false;
+	}
+
+	ath12k_hal_srng_access_end(ab, srng);
+
+	spin_unlock_bh(&srng->lock);
+}
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.h b/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.h
index fa44e454cee6..63176a53c1e7 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.h
+++ b/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.h
@@ -16,6 +16,7 @@ int ath12k_dp_rx_process_err(struct ath12k_base *ab, struct napi_struct *napi,
 int ath12k_dp_rx_process(struct ath12k_base *ab, int mac_id,
 			 struct napi_struct *napi,
 			 int budget);
+void ath12k_dp_rx_process_reo_status(struct ath12k_base *ab);
 int ath12k_dp_rxdma_ring_sel_config_qcn9274(struct ath12k_base *ab);
 int ath12k_dp_rxdma_ring_sel_config_wcn7850(struct ath12k_base *ab);
 #endif
-- 
2.34.1


