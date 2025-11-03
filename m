Return-Path: <linux-wireless+bounces-28494-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E79FC2B4B9
	for <lists+linux-wireless@lfdr.de>; Mon, 03 Nov 2025 12:23:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8790B4F05B4
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Nov 2025 11:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E8A02ED84A;
	Mon,  3 Nov 2025 11:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="TvcBP8zy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436E22EB87A
	for <linux-wireless@vger.kernel.org>; Mon,  3 Nov 2025 11:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762168905; cv=none; b=Ze+B8YdoF+mZXcn6lf0W8KwRDuKdgmdor1TM9iIEG97A5WbrF/GMaj6EwZJ7t0qmOdUtZM8rJtDvBfA237eh15vBbek0HUbXL6k1PMTrSjnhCganKryAFtbhlfFwkRty2vMsmqsRHo69zJ14HGpnns3UNt079HyZYhrTXXcT5Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762168905; c=relaxed/simple;
	bh=JKnfB3hBwtEIwoUBF4bqiCPX8D4ppG2vmMIC9B65fKI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NebGDQBopNXXpF+9NF/XYAJyYWLkUD+YyQjO2rJwMeQwG0VqolN7DwsVAHU5VjHvQ0X7C10RGMwZti4PjeZ9Yl2e731p9myvjJRrAzKMh8ZvBaJ6ExJ5cFgk52PsVOsEesjmGEbaCRaWWUPR3mR3QLkw3DTniWDl24LeEGmnhsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=TvcBP8zy; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A36BDFw2267766;
	Mon, 3 Nov 2025 11:21:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YD+QppXKWlCUdoqf8BLOxfkI2Fll2ghC6F4l8i+49q8=; b=TvcBP8zy99YfgMVw
	97v27MieL2DNJ+SdfaD90bhQNtls5TPzk3uerGNgoTI5ThQYBxxnaR7taPq9IOj2
	ePhU0lFtWkeRYLL5HTr5vDSteaXQZe6v/hNxQCpMLPmgq0X6HnnqM/30FwZhdcMz
	To2A2WU3Lw/pF1i+BgDRhnnUYnQIs1DmihmMfFk23GUDpXNfVNfP/1sW1mzSmIX+
	Cmfrc+V8SizauFnEWtTVgeY8RvjFJUEPNN+TnNKiKhuMBJQldAb5qKPlgRYuENlY
	orIUQE80I66lr3vC/oU3eVC6a2F6xSb0tebInJ/3dhfilXpiv4rntb9yXDnrWx9V
	Qj5RbA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a6pwagwv6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Nov 2025 11:21:39 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5A3BLdjh022595
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 3 Nov 2025 11:21:39 GMT
Received: from hu-rdeuri-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Mon, 3 Nov 2025 03:21:37 -0800
From: Ripan Deuri <quic_rdeuri@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH ath12k-ng 02/12] wifi: ath12k: Move DP device stats to ath12k_dp
Date: Mon, 3 Nov 2025 16:51:01 +0530
Message-ID: <20251103112111.2260639-3-quic_rdeuri@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251103112111.2260639-1-quic_rdeuri@quicinc.com>
References: <20251103112111.2260639-1-quic_rdeuri@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=OrdCCi/t c=1 sm=1 tr=0 ts=69089044 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=COk6AnOGAAAA:8 a=9IeWorGjo1jfHnS62loA:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: lHFAZdPiql_K2ttdlfHCYVDyYB7OD496
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAzMDEwNCBTYWx0ZWRfX1Q81OUFqjtku
 hB0I0yU3NrftpA8BD9LN3buBkDmhyO8my2kiSzY4Dvk18KDhmjKwWsBR1rZmSCilc3y9eURQuYc
 L8HCUC56AOsmoldQel0VkvBfeHqV+lUAFGmsp9YJmQApSH/ARwG4SY6EOoA5wrji5Ey6kMNzOQ3
 Z5ogB7LJI6vL/KBBsmZDxXjkBIL3+a6iqCli0s1ZGBvJ8eYgA3wsOeIzFmQgZYQJoqj5uRICieL
 UlurFPkEgKnfJZWnwkFYQ8t40LbM4SuCzJCPcqFN3nqsY/sMDd+Ly2O5xgnlNVz7Loz5ew7nSTh
 xL+eVgjDwrYHQQbBEuV8izdrBZgjHP+5DrzolN1s7zVBfmHnlaunCSnd/cfeUw+NkK0yWmZO4go
 Wzs32v31Y3aDtEGwjXGeQHn5FnMgyg==
X-Proofpoint-GUID: lHFAZdPiql_K2ttdlfHCYVDyYB7OD496
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_01,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 suspectscore=0 bulkscore=0 impostorscore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511030104

From: Pavankumar Nandeshwar <quic_pnandesh@quicinc.com>

As part of data path modularization of device object framework, the per packet
tx/rx operations now use ath12k_dp. Move all the device stats 'device_stats'
from ath12k_base to ath12k_dp, consolidating all device stats within ath12k_dp.
This would improve the performance by allowing the datapath to reach to the
stats counters without to having to reach out to ath12k_base object.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Pavankumar Nandeshwar <quic_pnandesh@quicinc.com>
Signed-off-by: Ripan Deuri <quic_rdeuri@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.h        | 26 ------------------
 drivers/net/wireless/ath/ath12k/debug.c       |  3 ++-
 drivers/net/wireless/ath/ath12k/debugfs.c     |  3 ++-
 drivers/net/wireless/ath/ath12k/dp.h          | 27 +++++++++++++++++++
 drivers/net/wireless/ath/ath12k/dp_rx.c       |  4 +--
 drivers/net/wireless/ath/ath12k/dp_rx.h       |  2 +-
 drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c | 22 +++++++--------
 drivers/net/wireless/ath/ath12k/wifi7/dp_tx.c | 19 ++++++-------
 .../net/wireless/ath/ath12k/wifi7/hal_rx.c    |  8 +++---
 9 files changed, 60 insertions(+), 54 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index bc1d94963251..b6ed0e082fc6 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -902,31 +902,6 @@ struct ath12k_board_data {
 	size_t len;
 };
 
-struct ath12k_device_dp_tx_err_stats {
-	/* TCL Ring Descriptor unavailable */
-	u32 desc_na[DP_TCL_NUM_RING_MAX];
-	/* Other failures during dp_tx due to mem allocation failure
-	 * idr unavailable etc.
-	 */
-	atomic_t misc_fail;
-};
-
-struct ath12k_device_dp_stats {
-	u32 err_ring_pkts;
-	u32 invalid_rbm;
-	u32 rxdma_error[HAL_REO_ENTR_RING_RXDMA_ECODE_MAX];
-	u32 reo_error[HAL_REO_DEST_RING_ERROR_CODE_MAX];
-	u32 hal_reo_error[DP_REO_DST_RING_MAX];
-	struct ath12k_device_dp_tx_err_stats tx_err;
-	u32 reo_rx[DP_REO_DST_RING_MAX][ATH12K_MAX_DEVICES];
-	u32 rx_wbm_rel_source[HAL_WBM_REL_SRC_MODULE_MAX][ATH12K_MAX_DEVICES];
-	u32 tqm_rel_reason[MAX_TQM_RELEASE_REASON];
-	u32 fw_tx_status[MAX_FW_TX_STATUS];
-	u32 tx_wbm_rel_source[HAL_WBM_REL_SRC_MODULE_MAX];
-	u32 tx_enqueued[DP_TCL_NUM_RING_MAX];
-	u32 tx_completed[DP_TCL_NUM_RING_MAX];
-};
-
 struct ath12k_reg_freq {
 	u32 start_freq;
 	u32 end_freq;
@@ -1105,7 +1080,6 @@ struct ath12k_base {
 
 	/* Current DFS Regulatory */
 	enum ath12k_dfs_region dfs_region;
-	struct ath12k_device_dp_stats device_stats;
 #ifdef CONFIG_ATH12K_DEBUGFS
 	struct dentry *debugfs_soc;
 #endif
diff --git a/drivers/net/wireless/ath/ath12k/debug.c b/drivers/net/wireless/ath/ath12k/debug.c
index 9910c60f30ce..5fe9b2fbf509 100644
--- a/drivers/net/wireless/ath/ath12k/debug.c
+++ b/drivers/net/wireless/ath/ath12k/debug.c
@@ -1,7 +1,8 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ *
  */
 
 #include <linux/vmalloc.h>
diff --git a/drivers/net/wireless/ath/ath12k/debugfs.c b/drivers/net/wireless/ath/ath12k/debugfs.c
index 5af7f27e2d8d..ea2282a82006 100644
--- a/drivers/net/wireless/ath/ath12k/debugfs.c
+++ b/drivers/net/wireless/ath/ath12k/debugfs.c
@@ -1027,7 +1027,8 @@ static ssize_t ath12k_debugfs_dump_device_dp_stats(struct file *file,
 						   size_t count, loff_t *ppos)
 {
 	struct ath12k_base *ab = file->private_data;
-	struct ath12k_device_dp_stats *device_stats = &ab->device_stats;
+	struct ath12k_dp *dp = ath12k_ab_to_dp(ab);
+	struct ath12k_device_dp_stats *device_stats = &dp->device_stats;
 	int len = 0, i, j, ret;
 	struct ath12k *ar;
 	const int size = 4096;
diff --git a/drivers/net/wireless/ath/ath12k/dp.h b/drivers/net/wireless/ath/ath12k/dp.h
index e223cd85b08a..7877e862010c 100644
--- a/drivers/net/wireless/ath/ath12k/dp.h
+++ b/drivers/net/wireless/ath/ath12k/dp.h
@@ -11,6 +11,7 @@
 #include "dp_htt.h"
 #include "dp_cmn.h"
 #include <linux/rhashtable.h>
+#include "wifi7/hal_desc.h"
 
 #define MAX_RXDMA_PER_PDEV     2
 
@@ -420,6 +421,31 @@ struct ath12k_dp_arch_ops {
 				       dma_addr_t paddr);
 };
 
+struct ath12k_device_dp_tx_err_stats {
+	/* TCL Ring Descriptor unavailable */
+	u32 desc_na[DP_TCL_NUM_RING_MAX];
+	/* Other failures during dp_tx due to mem allocation failure
+	 * idr unavailable etc.
+	 */
+	atomic_t misc_fail;
+};
+
+struct ath12k_device_dp_stats {
+	u32 err_ring_pkts;
+	u32 invalid_rbm;
+	u32 rxdma_error[HAL_REO_ENTR_RING_RXDMA_ECODE_MAX];
+	u32 reo_error[HAL_REO_DEST_RING_ERROR_CODE_MAX];
+	u32 hal_reo_error[DP_REO_DST_RING_MAX];
+	struct ath12k_device_dp_tx_err_stats tx_err;
+	u32 reo_rx[DP_REO_DST_RING_MAX][ATH12K_MAX_DEVICES];
+	u32 rx_wbm_rel_source[HAL_WBM_REL_SRC_MODULE_MAX][ATH12K_MAX_DEVICES];
+	u32 tqm_rel_reason[MAX_TQM_RELEASE_REASON];
+	u32 fw_tx_status[MAX_FW_TX_STATUS];
+	u32 tx_wbm_rel_source[HAL_WBM_REL_SRC_MODULE_MAX];
+	u32 tx_enqueued[DP_TCL_NUM_RING_MAX];
+	u32 tx_completed[DP_TCL_NUM_RING_MAX];
+};
+
 struct ath12k_dp {
 	struct ath12k_base *ab;
 	u32 mon_dest_ring_stuck_cnt;
@@ -514,6 +540,7 @@ struct ath12k_dp {
 	/* The rhashtable containing struct ath12k_link_peer keyed by mac addr */
 	struct rhashtable *rhead_peer_addr;
 	struct rhashtable_params rhash_peer_addr_param;
+	struct ath12k_device_dp_stats device_stats;
 };
 
 static inline u32 ath12k_dp_arch_tx_get_vdev_bank_config(struct ath12k_dp *dp,
diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
index aa88f7cd1b56..5bc2aa52dd48 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -1272,7 +1272,7 @@ void ath12k_dp_rx_deliver_msdu(struct ath12k_pdev_dp *dp_pdev, struct napi_struc
 	ieee80211_rx_napi(ath12k_pdev_dp_to_hw(dp_pdev), pubsta, msdu, napi);
 }
 
-bool ath12k_dp_rx_check_nwifi_hdr_len_valid(struct ath12k_base *ab,
+bool ath12k_dp_rx_check_nwifi_hdr_len_valid(struct ath12k_dp *dp,
 					    struct hal_rx_desc *rx_desc,
 					    struct sk_buff *msdu,
 					    struct hal_rx_desc_data *rx_info)
@@ -1289,7 +1289,7 @@ bool ath12k_dp_rx_check_nwifi_hdr_len_valid(struct ath12k_base *ab,
 	if ((likely(hdr_len <= DP_MAX_NWIFI_HDR_LEN)))
 		return true;
 
-	ab->device_stats.invalid_rbm++;
+	dp->device_stats.invalid_rbm++;
 	WARN_ON_ONCE(1);
 	return false;
 }
diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.h b/drivers/net/wireless/ath/ath12k/dp_rx.h
index 1ad798fe1cb8..d995774168e5 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.h
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.h
@@ -183,7 +183,7 @@ void ath12k_dp_rx_h_undecap(struct ath12k_pdev_dp *dp_pdev, struct sk_buff *msdu
 void ath12k_dp_rx_deliver_msdu(struct ath12k_pdev_dp *dp_pdev, struct napi_struct *napi,
 			       struct sk_buff *msdu,
 			       struct hal_rx_desc_data *rx_info);
-bool ath12k_dp_rx_check_nwifi_hdr_len_valid(struct ath12k_base *ab,
+bool ath12k_dp_rx_check_nwifi_hdr_len_valid(struct ath12k_dp *dp,
 					    struct hal_rx_desc *rx_desc,
 					    struct sk_buff *msdu,
 					    struct hal_rx_desc_data *rx_info);
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c b/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c
index f4855b001fda..0cf8a8f7b5f6 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c
@@ -538,7 +538,7 @@ static int ath12k_wifi7_dp_rx_process_msdu(struct ath12k_pdev_dp *dp_pdev,
 		}
 	}
 
-	if (unlikely(!ath12k_dp_rx_check_nwifi_hdr_len_valid(ab, rx_desc, msdu,
+	if (unlikely(!ath12k_dp_rx_check_nwifi_hdr_len_valid(dp, rx_desc, msdu,
 							     rx_info))) {
 		ret = -EINVAL;
 		goto free_out;
@@ -710,14 +710,14 @@ int ath12k_wifi7_dp_rx_process(struct ath12k_base *ab, int ring_id,
 				 DMA_FROM_DEVICE);
 
 		num_buffs_reaped[device_id]++;
-		ab->device_stats.reo_rx[ring_id][ab->device_id]++;
+		dp->device_stats.reo_rx[ring_id][ab->device_id]++;
 
 		push_reason = le32_get_bits(desc->info0,
 					    HAL_REO_DEST_RING_INFO0_PUSH_REASON);
 		if (push_reason !=
 		    HAL_REO_DEST_RING_PUSH_REASON_ROUTING_INSTRUCTION) {
 			dev_kfree_skb_any(msdu);
-			ab->device_stats.hal_reo_error[ring_id]++;
+			dp->device_stats.hal_reo_error[ring_id]++;
 			continue;
 		}
 
@@ -1021,7 +1021,7 @@ static int ath12k_wifi7_dp_rx_h_verify_tkip_mic(struct ath12k_pdev_dp *dp_pdev,
 		    RX_FLAG_IV_STRIPPED | RX_FLAG_DECRYPTED;
 	skb_pull(msdu, hal_rx_desc_sz);
 
-	if (unlikely(!ath12k_dp_rx_check_nwifi_hdr_len_valid(ab, rx_desc, msdu,
+	if (unlikely(!ath12k_dp_rx_check_nwifi_hdr_len_valid(dp, rx_desc, msdu,
 							     rx_info)))
 		return -EINVAL;
 
@@ -1357,7 +1357,7 @@ int ath12k_wifi7_dp_rx_process_err(struct ath12k_base *ab, struct napi_struct *n
 	while (budget &&
 	       (reo_desc = ath12k_hal_srng_dst_get_next_entry(ab, srng))) {
 		drop = false;
-		ab->device_stats.err_ring_pkts++;
+		dp->device_stats.err_ring_pkts++;
 
 		ret = ath12k_wifi7_hal_desc_reo_parse_err(ab, reo_desc, &paddr,
 							  &desc_bank);
@@ -1385,7 +1385,7 @@ int ath12k_wifi7_dp_rx_process_err(struct ath12k_base *ab, struct napi_struct *n
 		    rbm != HAL_RX_BUF_RBM_SW3_BM &&
 		    rbm != partner_ab->hal.hal_params->rx_buf_rbm) {
 			act = HAL_WBM_REL_BM_ACT_REL_MSDU;
-			ab->device_stats.invalid_rbm++;
+			dp->device_stats.invalid_rbm++;
 			ath12k_warn(ab, "invalid return buffer manager %d\n", rbm);
 			ath12k_wifi7_dp_rx_link_desc_return(partner_ab,
 							    &reo_desc->buf_addr_info,
@@ -1539,7 +1539,7 @@ static int ath12k_wifi7_dp_rx_h_null_q_desc(struct ath12k_pdev_dp *dp_pdev,
 		skb_put(msdu, hal_rx_desc_sz + l3pad_bytes + msdu_len);
 		skb_pull(msdu, hal_rx_desc_sz + l3pad_bytes);
 	}
-	if (unlikely(!ath12k_dp_rx_check_nwifi_hdr_len_valid(ab, desc, msdu, rx_info)))
+	if (unlikely(!ath12k_dp_rx_check_nwifi_hdr_len_valid(dp, desc, msdu, rx_info)))
 		return -EINVAL;
 
 	ath12k_dp_rx_h_ppdu(dp_pdev, rx_info);
@@ -1580,7 +1580,7 @@ static bool ath12k_wifi7_dp_rx_h_tkip_mic_err(struct ath12k_pdev_dp *dp_pdev,
 	skb_put(msdu, hal_rx_desc_sz + l3pad_bytes + msdu_len);
 	skb_pull(msdu, hal_rx_desc_sz + l3pad_bytes);
 
-	if (unlikely(!ath12k_dp_rx_check_nwifi_hdr_len_valid(ab, desc, msdu, rx_info)))
+	if (unlikely(!ath12k_dp_rx_check_nwifi_hdr_len_valid(dp, desc, msdu, rx_info)))
 		return true;
 
 	ath12k_dp_rx_h_ppdu(dp_pdev, rx_info);
@@ -1601,7 +1601,7 @@ static bool ath12k_wifi7_dp_rx_h_rxdma_err(struct ath12k_pdev_dp *dp_pdev,
 	struct ath12k_skb_rxcb *rxcb = ATH12K_SKB_RXCB(msdu);
 	bool drop = false;
 
-	dp->ab->device_stats.rxdma_error[rxcb->err_code]++;
+	dp->device_stats.rxdma_error[rxcb->err_code]++;
 
 	switch (rxcb->err_code) {
 	case HAL_REO_ENTR_RING_RXDMA_ECODE_DECRYPT_ERR:
@@ -1631,7 +1631,7 @@ static bool ath12k_wifi7_dp_rx_h_reo_err(struct ath12k_pdev_dp *dp_pdev,
 	struct ath12k_skb_rxcb *rxcb = ATH12K_SKB_RXCB(msdu);
 	bool drop = false;
 
-	dp->ab->device_stats.reo_error[rxcb->err_code]++;
+	dp->device_stats.reo_error[rxcb->err_code]++;
 
 	switch (rxcb->err_code) {
 	case HAL_REO_DEST_RING_ERROR_CODE_DESC_ADDR_ZERO:
@@ -1744,7 +1744,7 @@ int ath12k_wifi7_dp_rx_process_wbm_err(struct ath12k_base *ab,
 	int num_buffs_reaped[ATH12K_MAX_DEVICES] = {};
 	int total_num_buffs_reaped = 0;
 	struct ath12k_rx_desc_info *desc_info;
-	struct ath12k_device_dp_stats *device_stats = &ab->device_stats;
+	struct ath12k_device_dp_stats *device_stats = &dp->device_stats;
 	struct ath12k_hw_link *hw_links = ag->hw_links;
 	u8 hw_link_id, device_id;
 	int ret, pdev_idx;
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/dp_tx.c b/drivers/net/wireless/ath/ath12k/wifi7/dp_tx.c
index 950614a217a0..454d5a7532cf 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/dp_tx.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/dp_tx.c
@@ -205,7 +205,7 @@ int ath12k_wifi7_dp_tx(struct ath12k_pdev_dp *dp_pdev, struct ath12k_link_vif *a
 	default:
 		/* TODO: Take care of other encap modes as well */
 		ret = -EINVAL;
-		atomic_inc(&ab->device_stats.tx_err.misc_fail);
+		atomic_inc(&dp->device_stats.tx_err.misc_fail);
 		goto fail_remove_tx_buf;
 	}
 
@@ -228,7 +228,7 @@ int ath12k_wifi7_dp_tx(struct ath12k_pdev_dp *dp_pdev, struct ath12k_link_vif *a
 map:
 	ti.paddr = dma_map_single(ab->dev, skb->data, skb->len, DMA_TO_DEVICE);
 	if (dma_mapping_error(ab->dev, ti.paddr)) {
-		atomic_inc(&ab->device_stats.tx_err.misc_fail);
+		atomic_inc(&dp->device_stats.tx_err.misc_fail);
 		ath12k_warn(ab, "failed to DMA map data Tx buffer\n");
 		ret = -ENOMEM;
 		goto fail_remove_tx_buf;
@@ -311,7 +311,7 @@ int ath12k_wifi7_dp_tx(struct ath12k_pdev_dp *dp_pdev, struct ath12k_link_vif *a
 		 * desc because the desc is directly enqueued onto hw queue.
 		 */
 		ath12k_hal_srng_access_end(ab, tcl_ring);
-		ab->device_stats.tx_err.desc_na[ti.ring_id]++;
+		dp->device_stats.tx_err.desc_na[ti.ring_id]++;
 		spin_unlock_bh(&tcl_ring->lock);
 		ret = -ENOMEM;
 
@@ -340,7 +340,7 @@ int ath12k_wifi7_dp_tx(struct ath12k_pdev_dp *dp_pdev, struct ath12k_link_vif *a
 		arvif->link_stats.tx_enqueued++;
 	spin_unlock_bh(&arvif->link_stats_lock);
 
-	ab->device_stats.tx_enqueued[ti.ring_id]++;
+	dp->device_stats.tx_enqueued[ti.ring_id]++;
 
 	ath12k_wifi7_hal_tx_cmd_desc_setup(ab, hal_tcl_desc, &ti);
 
@@ -403,7 +403,7 @@ ath12k_dp_tx_htt_tx_complete_buf(struct ath12k_base *ab,
 
 	ar = skb_cb->ar;
 	dp_pdev = &ar->dp;
-	ab->device_stats.tx_completed[tx_ring->tcl_data_ring_id]++;
+	ab->dp->device_stats.tx_completed[tx_ring->tcl_data_ring_id]++;
 
 	if (atomic_dec_and_test(&ar->dp.num_tx_pending))
 		wake_up(&ar->dp.tx_empty_waitq);
@@ -475,13 +475,14 @@ ath12k_dp_tx_process_htt_tx_complete(struct ath12k_base *ab, void *desc,
 	struct htt_tx_wbm_completion *status_desc;
 	struct ath12k_dp_htt_wbm_tx_status ts = {};
 	enum hal_wbm_htt_tx_comp_status wbm_status;
+	struct ath12k_dp *dp = ath12k_ab_to_dp(ab);
 	u16 peer_id;
 
 	status_desc = desc;
 
 	wbm_status = le32_get_bits(status_desc->info0,
 				   HTT_TX_WBM_COMP_INFO0_STATUS);
-	ab->device_stats.fw_tx_status[wbm_status]++;
+	dp->device_stats.fw_tx_status[wbm_status]++;
 
 	switch (wbm_status) {
 	case HAL_WBM_REL_HTT_TX_COMP_STATUS_OK:
@@ -656,7 +657,7 @@ static void ath12k_wifi7_dp_tx_complete_msdu(struct ath12k_pdev_dp *dp_pdev,
 	}
 
 	skb_cb = ATH12K_SKB_CB(msdu);
-	ab->device_stats.tx_completed[ring]++;
+	dp->device_stats.tx_completed[ring]++;
 
 	dma_unmap_single(ab->dev, skb_cb->paddr, msdu->len, DMA_TO_DEVICE);
 	if (skb_cb->paddr_ext_desc) {
@@ -883,11 +884,11 @@ void ath12k_wifi7_dp_tx_completion_handler(struct ath12k_base *ab, int ring_id)
 		/* Find the HAL_WBM_RELEASE_INFO0_REL_SRC_MODULE value */
 		buf_rel_source = le32_get_bits(tx_status->info0,
 					       HAL_WBM_RELEASE_INFO0_REL_SRC_MODULE);
-		ab->device_stats.tx_wbm_rel_source[buf_rel_source]++;
+		dp->device_stats.tx_wbm_rel_source[buf_rel_source]++;
 
 		rel_status = le32_get_bits(tx_status->info0,
 					   HAL_WBM_COMPL_TX_INFO0_TQM_RELEASE_REASON);
-		ab->device_stats.tqm_rel_reason[rel_status]++;
+		dp->device_stats.tqm_rel_reason[rel_status]++;
 
 		/* Release descriptor as soon as extracting necessary info
 		 * to reduce contention
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal_rx.c b/drivers/net/wireless/ath/ath12k/wifi7/hal_rx.c
index 09a41e110e08..47d047d87c34 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hal_rx.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal_rx.c
@@ -326,13 +326,14 @@ int ath12k_wifi7_hal_desc_reo_parse_err(struct ath12k_base *ab,
 {
 	enum hal_reo_dest_ring_push_reason push_reason;
 	enum hal_reo_dest_ring_error_code err_code;
+	struct ath12k_dp *dp = ath12k_ab_to_dp(ab);
 	u32 cookie, val;
 
 	push_reason = le32_get_bits(desc->info0,
 				    HAL_REO_DEST_RING_INFO0_PUSH_REASON);
 	err_code = le32_get_bits(desc->info0,
 				 HAL_REO_DEST_RING_INFO0_ERROR_CODE);
-	ab->device_stats.reo_error[err_code]++;
+	dp->device_stats.reo_error[err_code]++;
 
 	if (push_reason != HAL_REO_DEST_RING_PUSH_REASON_ERR_DETECTED &&
 	    push_reason != HAL_REO_DEST_RING_PUSH_REASON_ROUTING_INSTRUCTION) {
@@ -359,6 +360,7 @@ int ath12k_wifi7_hal_wbm_desc_parse_err(struct ath12k_base *ab, void *desc,
 {
 	struct hal_wbm_release_ring *wbm_desc = desc;
 	struct hal_wbm_release_ring_cc_rx *wbm_cc_desc = desc;
+	struct ath12k_dp *dp = ath12k_ab_to_dp(ab);
 	enum hal_wbm_rel_desc_type type;
 	enum hal_wbm_rel_src_module rel_src;
 	bool hw_cc_done;
@@ -388,7 +390,7 @@ int ath12k_wifi7_hal_wbm_desc_parse_err(struct ath12k_base *ab, void *desc,
 		val = le32_get_bits(wbm_desc->buf_addr_info.info1,
 				    BUFFER_ADDR_INFO1_RET_BUF_MGR);
 		if (val != HAL_RX_BUF_RBM_SW3_BM) {
-			ab->device_stats.invalid_rbm++;
+			dp->device_stats.invalid_rbm++;
 			return -EINVAL;
 		}
 
@@ -400,7 +402,7 @@ int ath12k_wifi7_hal_wbm_desc_parse_err(struct ath12k_base *ab, void *desc,
 		val = le32_get_bits(wbm_cc_desc->info0,
 				    HAL_WBM_RELEASE_RX_CC_INFO0_RBM);
 		if (val != HAL_RX_BUF_RBM_SW3_BM) {
-			ab->device_stats.invalid_rbm++;
+			dp->device_stats.invalid_rbm++;
 			return -EINVAL;
 		}
 
-- 
2.34.1


