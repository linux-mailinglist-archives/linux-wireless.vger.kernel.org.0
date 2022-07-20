Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A32657B7F0
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Jul 2022 15:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240523AbiGTNvo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 Jul 2022 09:51:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240480AbiGTNvn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 Jul 2022 09:51:43 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D50DA5006E
        for <linux-wireless@vger.kernel.org>; Wed, 20 Jul 2022 06:51:40 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26KBi6bp031681;
        Wed, 20 Jul 2022 13:51:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=YQm5tkTX6JBGEW+NCJWz949phoML48DRhI1c7zio5Nc=;
 b=clX57DffsTqgPbsmkKKdzSBJrINVgL6MCIpDtTgoVgwQ4pZhoX+Me/khKmWaKETAVc0p
 QUWRy8K+us4VzunQ4hL3fHaGU8cCK8CfYFmuj/NmqQwkK8BXu8lklXqTesIxaCRfN2w+
 sRqYswz70Ln49IUaRV7gEt2NXiZWEBGR7NTzvrhjd7KZoZNcW03ApOEjg6rhGyS6T+n8
 fFQnHmBin7MaRJHjpQ5NFoCcBtCCGFUkTNY8ILltfixOaP+Qin0w7lsnSwfyD74oX5nE
 WhjCKnn+DBPRr4q2EQJMDow0cKaZdGu7E141KZjaftf3C5voO1fXc4oZog/mumIDgEdw hA== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3heb3x182g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Jul 2022 13:51:33 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.47.97.222])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 26KDpWsS016784
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Jul 2022 13:51:32 GMT
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 20 Jul 2022 06:51:32 -0700
Received: from mpubbise-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 20 Jul 2022 06:51:30 -0700
From:   Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Subject: [PATCH 2/3] ath11k: Add multi TX ring support for WCN6750
Date:   Wed, 20 Jul 2022 19:21:12 +0530
Message-ID: <20220720135113.15755-3-quic_mpubbise@quicinc.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220720135113.15755-1-quic_mpubbise@quicinc.com>
References: <20220720135113.15755-1-quic_mpubbise@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: A3eXjW-9vVrxY6BIIyX7A_5HWIp4R2GP
X-Proofpoint-ORIG-GUID: A3eXjW-9vVrxY6BIIyX7A_5HWIp4R2GP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-20_07,2022-07-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=999 impostorscore=0 spamscore=0 clxscore=1015 suspectscore=0
 bulkscore=0 mlxscore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207200056
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Currently in the case of WCN6750, only one TCL ring is used for TX,
this is limiting the TX throughput in 160 MHz case, enabling multiple
TCL rings on WCN6750 has shown an improvement of nearly 300 Mbps in
the case of TCP TX, therefore add the support of multi TX ring for
WCN6750.

Currently TCL ring is selected based on CPU ID, this logic cannot be
applied for WCN6750 as there is chance of out of order TX of packets
and to avoid this, choose TCL ring based on flow hash so that packets
of the same flow will end up on same TCL ring. For the same reason,
TCL ring retry logic is also not applicable for WCN6750.

Also the mapping of TCL, WBM & RBM IDs for WCN6750 is different from
existing devices. Create a new TCM/WBM/RBM mapping for WCN6750.

Change does not impact existing ath11k devices.

Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-00887-QCAMSLSWPLZ-1

Signed-off-by: Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/core.c   |  13 ++-
 drivers/net/wireless/ath/ath11k/dp.c     |  24 +++--
 drivers/net/wireless/ath/ath11k/dp.h     |   2 +
 drivers/net/wireless/ath/ath11k/dp_tx.c  |  19 ++--
 drivers/net/wireless/ath/ath11k/hal.c    |   2 +-
 drivers/net/wireless/ath/ath11k/hal.h    |   2 +
 drivers/net/wireless/ath/ath11k/hal_tx.c |   4 +-
 drivers/net/wireless/ath/ath11k/hal_tx.h |   2 +
 drivers/net/wireless/ath/ath11k/hw.c     | 117 ++++++++++++++++++++++-
 drivers/net/wireless/ath/ath11k/hw.h     |  11 +++
 10 files changed, 166 insertions(+), 30 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index c8e0bc935838..a7eaec5798a0 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -111,6 +111,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.ce_window_idx = 0,
 		.fixed_fw_mem = false,
 		.support_off_channel_tx = false,
+		.tcl_ring_retry = true,
 	},
 	{
 		.hw_rev = ATH11K_HW_IPQ6018_HW10,
@@ -187,6 +188,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.ce_window_idx = 0,
 		.fixed_fw_mem = false,
 		.support_off_channel_tx = false,
+		.tcl_ring_retry = true,
 	},
 	{
 		.name = "qca6390 hw2.0",
@@ -262,6 +264,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.ce_window_idx = 0,
 		.fixed_fw_mem = false,
 		.support_off_channel_tx = true,
+		.tcl_ring_retry = true,
 	},
 	{
 		.name = "qcn9074 hw1.0",
@@ -337,6 +340,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.ce_window_idx = 2,
 		.fixed_fw_mem = false,
 		.support_off_channel_tx = false,
+		.tcl_ring_retry = true,
 	},
 	{
 		.name = "wcn6855 hw2.0",
@@ -412,6 +416,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.ce_window_idx = 0,
 		.fixed_fw_mem = false,
 		.support_off_channel_tx = true,
+		.tcl_ring_retry = true,
 	},
 	{
 		.name = "wcn6855 hw2.1",
@@ -486,6 +491,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.ce_window_idx = 0,
 		.fixed_fw_mem = false,
 		.support_off_channel_tx = true,
+		.tcl_ring_retry = true,
 	},
 	{
 		.name = "wcn6750 hw1.0",
@@ -498,7 +504,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.max_radios = 1,
 		.bdf_addr = 0x4B0C0000,
 		.hw_ops = &wcn6750_ops,
-		.ring_mask = &ath11k_hw_ring_mask_qca6390,
+		.ring_mask = &ath11k_hw_ring_mask_wcn6750,
 		.internal_sleep_clock = false,
 		.regs = &wcn6750_regs,
 		.qmi_service_ins_id = ATH11K_QMI_WLFW_SERVICE_INS_ID_V01_WCN6750,
@@ -541,8 +547,8 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.supports_regdb = true,
 		.fix_l1ss = false,
 		.credit_flow = true,
-		.max_tx_ring = DP_TCL_NUM_RING_MAX_QCA6390,
-		.hal_params = &ath11k_hw_hal_params_qca6390,
+		.max_tx_ring = DP_TCL_NUM_RING_MAX,
+		.hal_params = &ath11k_hw_hal_params_wcn6750,
 		.supports_dynamic_smps_6ghz = false,
 		.alloc_cacheable_memory = false,
 		.supports_rssi_stats = true,
@@ -560,6 +566,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.ce_window_idx = 2,
 		.fixed_fw_mem = true,
 		.support_off_channel_tx = false,
+		.tcl_ring_retry = false,
 	},
 };
 
diff --git a/drivers/net/wireless/ath/ath11k/dp.c b/drivers/net/wireless/ath/ath11k/dp.c
index 8b790ce72e5d..4f7381719840 100644
--- a/drivers/net/wireless/ath/ath11k/dp.c
+++ b/drivers/net/wireless/ath/ath11k/dp.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
+ * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #include <crypto/hash.h>
@@ -131,13 +132,11 @@ static int ath11k_dp_srng_calculate_msi_group(struct ath11k_base *ab,
 
 	switch (type) {
 	case HAL_WBM2SW_RELEASE:
-		if (ring_num < 3) {
-			grp_mask = &ab->hw_params.ring_mask->tx[0];
-		} else if (ring_num == 3) {
+		if (ring_num == DP_RX_RELEASE_RING_NUM) {
 			grp_mask = &ab->hw_params.ring_mask->rx_wbm_rel[0];
 			ring_num = 0;
 		} else {
-			return -ENOENT;
+			grp_mask = &ab->hw_params.ring_mask->tx[0];
 		}
 		break;
 	case HAL_REO_EXCEPTION:
@@ -371,6 +370,7 @@ static int ath11k_dp_srng_common_setup(struct ath11k_base *ab)
 	struct ath11k_dp *dp = &ab->dp;
 	struct hal_srng *srng;
 	int i, ret;
+	u8 tcl_num, wbm_num;
 
 	ret = ath11k_dp_srng_setup(ab, &dp->wbm_desc_rel_ring,
 				   HAL_SW2WBM_RELEASE, 0, 0,
@@ -396,8 +396,11 @@ static int ath11k_dp_srng_common_setup(struct ath11k_base *ab)
 	}
 
 	for (i = 0; i < ab->hw_params.max_tx_ring; i++) {
+		tcl_num = ab->hw_params.hal_params->tcl2wbm_rbm_map[i].tcl_ring_num;
+		wbm_num = ab->hw_params.hal_params->tcl2wbm_rbm_map[i].wbm_ring_num;
+
 		ret = ath11k_dp_srng_setup(ab, &dp->tx_ring[i].tcl_data_ring,
-					   HAL_TCL_DATA, i, 0,
+					   HAL_TCL_DATA, tcl_num, 0,
 					   DP_TCL_DATA_RING_SIZE);
 		if (ret) {
 			ath11k_warn(ab, "failed to set up tcl_data ring (%d) :%d\n",
@@ -406,7 +409,7 @@ static int ath11k_dp_srng_common_setup(struct ath11k_base *ab)
 		}
 
 		ret = ath11k_dp_srng_setup(ab, &dp->tx_ring[i].tcl_comp_ring,
-					   HAL_WBM2SW_RELEASE, i, 0,
+					   HAL_WBM2SW_RELEASE, wbm_num, 0,
 					   DP_TX_COMP_RING_SIZE);
 		if (ret) {
 			ath11k_warn(ab, "failed to set up tcl_comp ring (%d) :%d\n",
@@ -431,7 +434,7 @@ static int ath11k_dp_srng_common_setup(struct ath11k_base *ab)
 	}
 
 	ret = ath11k_dp_srng_setup(ab, &dp->rx_rel_ring, HAL_WBM2SW_RELEASE,
-				   3, 0, DP_RX_RELEASE_RING_SIZE);
+				   DP_RX_RELEASE_RING_NUM, 0, DP_RX_RELEASE_RING_SIZE);
 	if (ret) {
 		ath11k_warn(ab, "failed to set up rx_rel ring :%d\n", ret);
 		goto err;
@@ -774,9 +777,10 @@ int ath11k_dp_service_srng(struct ath11k_base *ab,
 	int i, j;
 	int tot_work_done = 0;
 
-	if (ab->hw_params.ring_mask->tx[grp_id]) {
-		i = __fls(ab->hw_params.ring_mask->tx[grp_id]);
-		ath11k_dp_tx_completion_handler(ab, i);
+	for (i = 0; i < ab->hw_params.max_tx_ring; i++) {
+		if (BIT(ab->hw_params.hal_params->tcl2wbm_rbm_map[i].wbm_ring_num) &
+		    ab->hw_params.ring_mask->tx[grp_id])
+			ath11k_dp_tx_completion_handler(ab, i);
 	}
 
 	if (ab->hw_params.ring_mask->rx_err[grp_id]) {
diff --git a/drivers/net/wireless/ath/ath11k/dp.h b/drivers/net/wireless/ath/ath11k/dp.h
index e9dfa209098b..8af2985ca2d9 100644
--- a/drivers/net/wireless/ath/ath11k/dp.h
+++ b/drivers/net/wireless/ath/ath11k/dp.h
@@ -222,6 +222,8 @@ struct ath11k_pdev_dp {
 #define DP_RXDMA_MONITOR_DST_RING_SIZE	2048
 #define DP_RXDMA_MONITOR_DESC_RING_SIZE	4096
 
+#define DP_RX_RELEASE_RING_NUM	3
+
 #define DP_RX_BUFFER_SIZE	2048
 #define	DP_RX_BUFFER_SIZE_LITE  1024
 #define DP_RX_BUFFER_ALIGN_SIZE	128
diff --git a/drivers/net/wireless/ath/ath11k/dp_tx.c b/drivers/net/wireless/ath/ath11k/dp_tx.c
index c17a2620aad7..862605858a80 100644
--- a/drivers/net/wireless/ath/ath11k/dp_tx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_tx.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
+ * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #include "core.h"
@@ -93,7 +94,8 @@ int ath11k_dp_tx(struct ath11k *ar, struct ath11k_vif *arvif,
 	u8 pool_id;
 	u8 hal_ring_id;
 	int ret;
-	u8 ring_selector = 0, ring_map = 0;
+	u32 ring_selector = 0;
+	u8 ring_map = 0;
 	bool tcl_ring_retry;
 
 	if (unlikely(test_bit(ATH11K_FLAG_CRASH_FLUSH, &ar->ab->dev_flags)))
@@ -105,19 +107,13 @@ int ath11k_dp_tx(struct ath11k *ar, struct ath11k_vif *arvif,
 
 	pool_id = skb_get_queue_mapping(skb) & (ATH11K_HW_MAX_QUEUES - 1);
 
-	/* Let the default ring selection be based on current processor
-	 * number, where one of the 3 tcl rings are selected based on
-	 * the smp_processor_id(). In case that ring
-	 * is full/busy, we resort to other available rings.
-	 * If all rings are full, we drop the packet.
-	 * //TODO Add throttling logic when all rings are full
-	 */
-	ring_selector = smp_processor_id();
+	ring_selector = ab->hw_params.hw_ops->get_ring_selector(skb);
 
 tcl_ring_sel:
 	tcl_ring_retry = false;
 
 	ti.ring_id = ring_selector % ab->hw_params.max_tx_ring;
+	ti.rbm_id = ab->hw_params.hal_params->tcl2wbm_rbm_map[ti.ring_id].rbm_id;
 
 	ring_map |= BIT(ti.ring_id);
 
@@ -129,7 +125,8 @@ int ath11k_dp_tx(struct ath11k *ar, struct ath11k_vif *arvif,
 	spin_unlock_bh(&tx_ring->tx_idr_lock);
 
 	if (unlikely(ret < 0)) {
-		if (ring_map == (BIT(ab->hw_params.max_tx_ring) - 1)) {
+		if (ring_map == (BIT(ab->hw_params.max_tx_ring) - 1) ||
+		    !ab->hw_params.tcl_ring_retry) {
 			atomic_inc(&ab->soc_stats.tx_err.misc_fail);
 			return -ENOSPC;
 		}
@@ -247,7 +244,7 @@ int ath11k_dp_tx(struct ath11k *ar, struct ath11k_vif *arvif,
 		 * Restart ring selection if some rings are not checked yet.
 		 */
 		if (unlikely(ring_map != (BIT(ab->hw_params.max_tx_ring)) - 1) &&
-		    ab->hw_params.max_tx_ring > 1) {
+		    ab->hw_params.tcl_ring_retry && ab->hw_params.max_tx_ring > 1) {
 			tcl_ring_retry = true;
 			ring_selector++;
 		}
diff --git a/drivers/net/wireless/ath/ath11k/hal.c b/drivers/net/wireless/ath/ath11k/hal.c
index bda71ab5a1f2..db8b191c7a4c 100644
--- a/drivers/net/wireless/ath/ath11k/hal.c
+++ b/drivers/net/wireless/ath/ath11k/hal.c
@@ -126,7 +126,7 @@ static const struct hal_srng_config hw_srng_config_template[] = {
 	},
 	{ /* WBM2SW_RELEASE */
 		.start_ring_id = HAL_SRNG_RING_ID_WBM2SW0_RELEASE,
-		.max_rings = 4,
+		.max_rings = 5,
 		.entry_size = sizeof(struct hal_wbm_release_ring) >> 2,
 		.lmac_ring = false,
 		.ring_dir = HAL_SRNG_DIR_DST,
diff --git a/drivers/net/wireless/ath/ath11k/hal.h b/drivers/net/wireless/ath/ath11k/hal.h
index 110c337ddf33..e0358062ca2b 100644
--- a/drivers/net/wireless/ath/ath11k/hal.h
+++ b/drivers/net/wireless/ath/ath11k/hal.h
@@ -389,6 +389,7 @@ enum hal_srng_ring_id {
 	HAL_SRNG_RING_ID_WBM2SW1_RELEASE,
 	HAL_SRNG_RING_ID_WBM2SW2_RELEASE,
 	HAL_SRNG_RING_ID_WBM2SW3_RELEASE,
+	HAL_SRNG_RING_ID_WBM2SW4_RELEASE,
 
 	HAL_SRNG_RING_ID_UMAC_ID_END = 127,
 	HAL_SRNG_RING_ID_LMAC1_ID_START,
@@ -678,6 +679,7 @@ enum hal_rx_buf_return_buf_manager {
 	HAL_RX_BUF_RBM_SW1_BM,
 	HAL_RX_BUF_RBM_SW2_BM,
 	HAL_RX_BUF_RBM_SW3_BM,
+	HAL_RX_BUF_RBM_SW4_BM,
 };
 
 #define HAL_SRNG_DESC_LOOP_CNT		0xf0000000
diff --git a/drivers/net/wireless/ath/ath11k/hal_tx.c b/drivers/net/wireless/ath/ath11k/hal_tx.c
index c8929de8ce6c..d1b0e36e04a9 100644
--- a/drivers/net/wireless/ath/ath11k/hal_tx.c
+++ b/drivers/net/wireless/ath/ath11k/hal_tx.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
+ * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #include "hal_desc.h"
@@ -44,8 +45,7 @@ void ath11k_hal_tx_cmd_desc_setup(struct ath11k_base *ab, void *cmd,
 		FIELD_PREP(BUFFER_ADDR_INFO1_ADDR,
 			   ((uint64_t)ti->paddr >> HAL_ADDR_MSB_REG_SHIFT));
 	tcl_cmd->buf_addr_info.info1 |=
-		FIELD_PREP(BUFFER_ADDR_INFO1_RET_BUF_MGR,
-			   (ti->ring_id + HAL_RX_BUF_RBM_SW0_BM)) |
+		FIELD_PREP(BUFFER_ADDR_INFO1_RET_BUF_MGR, ti->rbm_id) |
 		FIELD_PREP(BUFFER_ADDR_INFO1_SW_COOKIE, ti->desc_id);
 
 	tcl_cmd->info0 =
diff --git a/drivers/net/wireless/ath/ath11k/hal_tx.h b/drivers/net/wireless/ath/ath11k/hal_tx.h
index 36f4f6f6cbc2..c5e88364afe5 100644
--- a/drivers/net/wireless/ath/ath11k/hal_tx.h
+++ b/drivers/net/wireless/ath/ath11k/hal_tx.h
@@ -1,6 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
+ * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #ifndef ATH11K_HAL_TX_H
@@ -35,6 +36,7 @@ struct hal_tx_info {
 	u8 lmac_id;
 	u8 dscp_tid_tbl_idx;
 	bool enable_mesh;
+	u8 rbm_id;
 };
 
 /* TODO: Check if the actual desc macros can be used instead */
diff --git a/drivers/net/wireless/ath/ath11k/hw.c b/drivers/net/wireless/ath/ath11k/hw.c
index 96db85c55585..ec682f7da172 100644
--- a/drivers/net/wireless/ath/ath11k/hw.c
+++ b/drivers/net/wireless/ath/ath11k/hw.c
@@ -820,6 +820,29 @@ static bool ath11k_hw_wcn6855_rx_desc_get_ldpc_support(struct hal_rx_desc *desc)
 			 __le32_to_cpu(desc->u.wcn6855.msdu_start.info2));
 }
 
+static u32 ath11k_hw_ipq8074_get_tcl_ring_selector(struct sk_buff *skb)
+{
+	/* Let the default ring selection be based on current processor
+	 * number, where one of the 3 tcl rings are selected based on
+	 * the smp_processor_id(). In case that ring
+	 * is full/busy, we resort to other available rings.
+	 * If all rings are full, we drop the packet.
+	 * //TODO Add throttling logic when all rings are full
+	 */
+	return smp_processor_id();
+}
+
+static u32 ath11k_hw_wcn6750_get_tcl_ring_selector(struct sk_buff *skb)
+{
+	/* Select the TCL ring based on the flow hash of the SKB instead
+	 * of CPU ID. Since applications pumping the traffic can be scheduled
+	 * on multiple CPUs, there is a chance that packets of the same flow
+	 * could end on different TCL rings, this could sometimes results in
+	 * an out of order arrival of the packets at the receiver.
+	 */
+	return skb_get_hash(skb);
+}
+
 const struct ath11k_hw_ops ipq8074_ops = {
 	.get_hw_mac_from_pdev_id = ath11k_hw_ipq8074_mac_from_pdev_id,
 	.wmi_init_config = ath11k_init_wmi_config_ipq8074,
@@ -857,6 +880,7 @@ const struct ath11k_hw_ops ipq8074_ops = {
 	.mpdu_info_get_peerid = ath11k_hw_ipq8074_mpdu_info_get_peerid,
 	.rx_desc_mac_addr2_valid = ath11k_hw_ipq8074_rx_desc_mac_addr2_valid,
 	.rx_desc_mpdu_start_addr2 = ath11k_hw_ipq8074_rx_desc_mpdu_start_addr2,
+	.get_ring_selector = ath11k_hw_ipq8074_get_tcl_ring_selector,
 };
 
 const struct ath11k_hw_ops ipq6018_ops = {
@@ -896,6 +920,7 @@ const struct ath11k_hw_ops ipq6018_ops = {
 	.mpdu_info_get_peerid = ath11k_hw_ipq8074_mpdu_info_get_peerid,
 	.rx_desc_mac_addr2_valid = ath11k_hw_ipq8074_rx_desc_mac_addr2_valid,
 	.rx_desc_mpdu_start_addr2 = ath11k_hw_ipq8074_rx_desc_mpdu_start_addr2,
+	.get_ring_selector = ath11k_hw_ipq8074_get_tcl_ring_selector,
 };
 
 const struct ath11k_hw_ops qca6390_ops = {
@@ -935,6 +960,7 @@ const struct ath11k_hw_ops qca6390_ops = {
 	.mpdu_info_get_peerid = ath11k_hw_ipq8074_mpdu_info_get_peerid,
 	.rx_desc_mac_addr2_valid = ath11k_hw_ipq8074_rx_desc_mac_addr2_valid,
 	.rx_desc_mpdu_start_addr2 = ath11k_hw_ipq8074_rx_desc_mpdu_start_addr2,
+	.get_ring_selector = ath11k_hw_ipq8074_get_tcl_ring_selector,
 };
 
 const struct ath11k_hw_ops qcn9074_ops = {
@@ -974,6 +1000,7 @@ const struct ath11k_hw_ops qcn9074_ops = {
 	.mpdu_info_get_peerid = ath11k_hw_ipq8074_mpdu_info_get_peerid,
 	.rx_desc_mac_addr2_valid = ath11k_hw_ipq9074_rx_desc_mac_addr2_valid,
 	.rx_desc_mpdu_start_addr2 = ath11k_hw_ipq9074_rx_desc_mpdu_start_addr2,
+	.get_ring_selector = ath11k_hw_ipq8074_get_tcl_ring_selector,
 };
 
 const struct ath11k_hw_ops wcn6855_ops = {
@@ -1013,6 +1040,7 @@ const struct ath11k_hw_ops wcn6855_ops = {
 	.mpdu_info_get_peerid = ath11k_hw_wcn6855_mpdu_info_get_peerid,
 	.rx_desc_mac_addr2_valid = ath11k_hw_wcn6855_rx_desc_mac_addr2_valid,
 	.rx_desc_mpdu_start_addr2 = ath11k_hw_wcn6855_rx_desc_mpdu_start_addr2,
+	.get_ring_selector = ath11k_hw_ipq8074_get_tcl_ring_selector,
 };
 
 const struct ath11k_hw_ops wcn6750_ops = {
@@ -1052,11 +1080,14 @@ const struct ath11k_hw_ops wcn6750_ops = {
 	.mpdu_info_get_peerid = ath11k_hw_ipq8074_mpdu_info_get_peerid,
 	.rx_desc_mac_addr2_valid = ath11k_hw_ipq9074_rx_desc_mac_addr2_valid,
 	.rx_desc_mpdu_start_addr2 = ath11k_hw_ipq9074_rx_desc_mpdu_start_addr2,
+	.get_ring_selector = ath11k_hw_wcn6750_get_tcl_ring_selector,
 };
 
-#define ATH11K_TX_RING_MASK_0 0x1
-#define ATH11K_TX_RING_MASK_1 0x2
-#define ATH11K_TX_RING_MASK_2 0x4
+#define ATH11K_TX_RING_MASK_0 BIT(0)
+#define ATH11K_TX_RING_MASK_1 BIT(1)
+#define ATH11K_TX_RING_MASK_2 BIT(2)
+#define ATH11K_TX_RING_MASK_3 BIT(3)
+#define ATH11K_TX_RING_MASK_4 BIT(4)
 
 #define ATH11K_RX_RING_MASK_0 0x1
 #define ATH11K_RX_RING_MASK_1 0x2
@@ -1903,6 +1934,43 @@ const struct ath11k_hw_ring_mask ath11k_hw_ring_mask_qcn9074 = {
 	},
 };
 
+const struct ath11k_hw_ring_mask ath11k_hw_ring_mask_wcn6750 = {
+	.tx  = {
+		ATH11K_TX_RING_MASK_0,
+		0,
+		ATH11K_TX_RING_MASK_2,
+		0,
+		ATH11K_TX_RING_MASK_4,
+	},
+	.rx_mon_status = {
+		0, 0, 0, 0, 0, 0,
+		ATH11K_RX_MON_STATUS_RING_MASK_0,
+	},
+	.rx = {
+		0, 0, 0, 0, 0, 0, 0,
+		ATH11K_RX_RING_MASK_0,
+		ATH11K_RX_RING_MASK_1,
+		ATH11K_RX_RING_MASK_2,
+		ATH11K_RX_RING_MASK_3,
+	},
+	.rx_err = {
+		0, ATH11K_RX_ERR_RING_MASK_0,
+	},
+	.rx_wbm_rel = {
+		0, ATH11K_RX_WBM_REL_RING_MASK_0,
+	},
+	.reo_status = {
+		0, ATH11K_REO_STATUS_RING_MASK_0,
+	},
+	.rxdma2host = {
+		ATH11K_RXDMA2HOST_RING_MASK_0,
+		ATH11K_RXDMA2HOST_RING_MASK_1,
+		ATH11K_RXDMA2HOST_RING_MASK_2,
+	},
+	.host2rxdma = {
+	},
+};
+
 const struct ath11k_hw_regs ipq8074_regs = {
 	/* SW2TCL(x) R0 ring configuration address */
 	.hal_tcl1_ring_base_lsb = 0x00000510,
@@ -2332,12 +2400,55 @@ const struct ath11k_hw_regs wcn6750_regs = {
 	.hal_reo1_misc_ctl = 0x000005d8,
 };
 
+static const struct ath11k_hw_tcl2wbm_rbm_map ath11k_hw_tcl2wbm_rbm_map_ipq8074[] = {
+	{
+		.tcl_ring_num = 0,
+		.wbm_ring_num = 0,
+		.rbm_id = HAL_RX_BUF_RBM_SW0_BM,
+	},
+	{
+		.tcl_ring_num = 1,
+		.wbm_ring_num = 1,
+		.rbm_id = HAL_RX_BUF_RBM_SW1_BM,
+	},
+	{
+		.tcl_ring_num = 2,
+		.wbm_ring_num = 2,
+		.rbm_id = HAL_RX_BUF_RBM_SW2_BM,
+	},
+};
+
+static const struct ath11k_hw_tcl2wbm_rbm_map ath11k_hw_tcl2wbm_rbm_map_wcn6750[] = {
+	{
+		.tcl_ring_num = 0,
+		.wbm_ring_num = 0,
+		.rbm_id = HAL_RX_BUF_RBM_SW0_BM,
+	},
+	{
+		.tcl_ring_num = 1,
+		.wbm_ring_num = 4,
+		.rbm_id = HAL_RX_BUF_RBM_SW4_BM,
+	},
+	{
+		.tcl_ring_num = 2,
+		.wbm_ring_num = 2,
+		.rbm_id = HAL_RX_BUF_RBM_SW2_BM,
+	},
+};
+
 const struct ath11k_hw_hal_params ath11k_hw_hal_params_ipq8074 = {
 	.rx_buf_rbm = HAL_RX_BUF_RBM_SW3_BM,
+	.tcl2wbm_rbm_map = ath11k_hw_tcl2wbm_rbm_map_ipq8074,
 };
 
 const struct ath11k_hw_hal_params ath11k_hw_hal_params_qca6390 = {
 	.rx_buf_rbm = HAL_RX_BUF_RBM_SW1_BM,
+	.tcl2wbm_rbm_map = ath11k_hw_tcl2wbm_rbm_map_ipq8074,
+};
+
+const struct ath11k_hw_hal_params ath11k_hw_hal_params_wcn6750 = {
+	.rx_buf_rbm = HAL_RX_BUF_RBM_SW1_BM,
+	.tcl2wbm_rbm_map = ath11k_hw_tcl2wbm_rbm_map_wcn6750,
 };
 
 static const struct cfg80211_sar_freq_ranges ath11k_hw_sar_freq_ranges_wcn6855[] = {
diff --git a/drivers/net/wireless/ath/ath11k/hw.h b/drivers/net/wireless/ath/ath11k/hw.h
index 77dc5c851c9b..9adfd6622c5f 100644
--- a/drivers/net/wireless/ath/ath11k/hw.h
+++ b/drivers/net/wireless/ath/ath11k/hw.h
@@ -122,8 +122,15 @@ struct ath11k_hw_ring_mask {
 	u8 host2rxdma[ATH11K_EXT_IRQ_GRP_NUM_MAX];
 };
 
+struct ath11k_hw_tcl2wbm_rbm_map {
+	u8 tcl_ring_num;
+	u8 wbm_ring_num;
+	u8 rbm_id;
+};
+
 struct ath11k_hw_hal_params {
 	enum hal_rx_buf_return_buf_manager rx_buf_rbm;
+	const struct ath11k_hw_tcl2wbm_rbm_map *tcl2wbm_rbm_map;
 };
 
 struct ath11k_hw_params {
@@ -205,6 +212,7 @@ struct ath11k_hw_params {
 	u8 ce_window_idx;
 	bool fixed_fw_mem;
 	bool support_off_channel_tx;
+	bool tcl_ring_retry;
 };
 
 struct ath11k_hw_ops {
@@ -247,6 +255,7 @@ struct ath11k_hw_ops {
 	u16 (*mpdu_info_get_peerid)(u8 *tlv_data);
 	bool (*rx_desc_mac_addr2_valid)(struct hal_rx_desc *desc);
 	u8* (*rx_desc_mpdu_start_addr2)(struct hal_rx_desc *desc);
+	u32 (*get_ring_selector)(struct sk_buff *skb);
 };
 
 extern const struct ath11k_hw_ops ipq8074_ops;
@@ -259,9 +268,11 @@ extern const struct ath11k_hw_ops wcn6750_ops;
 extern const struct ath11k_hw_ring_mask ath11k_hw_ring_mask_ipq8074;
 extern const struct ath11k_hw_ring_mask ath11k_hw_ring_mask_qca6390;
 extern const struct ath11k_hw_ring_mask ath11k_hw_ring_mask_qcn9074;
+extern const struct ath11k_hw_ring_mask ath11k_hw_ring_mask_wcn6750;
 
 extern const struct ath11k_hw_hal_params ath11k_hw_hal_params_ipq8074;
 extern const struct ath11k_hw_hal_params ath11k_hw_hal_params_qca6390;
+extern const struct ath11k_hw_hal_params ath11k_hw_hal_params_wcn6750;
 
 static inline
 int ath11k_hw_get_mac_from_pdev_id(struct ath11k_hw_params *hw,
-- 
2.35.1

