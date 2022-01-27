Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D03249DA40
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Jan 2022 06:34:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236274AbiA0Fd7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Jan 2022 00:33:59 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:2556 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236275AbiA0Fd6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Jan 2022 00:33:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1643261638; x=1674797638;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=A9qrRu+Dmdhu4SUyoeKXbRdopzhAN13BrqLccQXocaE=;
  b=WsAF+ZUSGwLaqniMtHCZQ09oL/rFWpQdcUkiji/QUahVlmmxztvYlIbq
   qgcX26/Od7dDPOkWWZUg1GlsKpV3BpDTGlGo/ezbSCqhZGi87N34gPG9Z
   mTnt2PDSys4NHDyBHWZbdH6LGgDt7dw+HO9S21wn53IsFZbGcuWC1SlG5
   E=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 26 Jan 2022 21:33:58 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 21:33:58 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 26 Jan 2022 21:33:58 -0800
Received: from mpubbise-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 26 Jan 2022 21:33:55 -0800
From:   Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Subject: [PATCH RFC 7/8] ath11k: Add multi TX ring support for WCN6750
Date:   Thu, 27 Jan 2022 11:03:28 +0530
Message-ID: <1643261609-13500-8-git-send-email-quic_mpubbise@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1643261609-13500-1-git-send-email-quic_mpubbise@quicinc.com>
References: <1643261609-13500-1-git-send-email-quic_mpubbise@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Currently in the case of WCN6750, only one TCL ring is
enabled for TX, all TX activity happens only on one ring,
this is limiting the TX throughput in 160Mhz case, enabling
mutliple TCL rings on WCN6750 has shown an improvement of
nearly 300 Mbps in the case of TCP TX, therefore add the
support of multi TX ring for WCN6750.

Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-00573-QCAMSLSWPLZ-1

Signed-off-by: Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/core.c   |  11 ++-
 drivers/net/wireless/ath/ath11k/dp.c     |  23 ++++---
 drivers/net/wireless/ath/ath11k/dp.h     |   2 +
 drivers/net/wireless/ath/ath11k/dp_tx.c  |  14 ++--
 drivers/net/wireless/ath/ath11k/hal.c    |   4 +-
 drivers/net/wireless/ath/ath11k/hal.h    |   4 +-
 drivers/net/wireless/ath/ath11k/hal_tx.c |   4 +-
 drivers/net/wireless/ath/ath11k/hal_tx.h |   2 +
 drivers/net/wireless/ath/ath11k/hw.c     | 113 +++++++++++++++++++++++++++++--
 drivers/net/wireless/ath/ath11k/hw.h     |  12 ++++
 10 files changed, 160 insertions(+), 29 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index 161bddf..fa507a27 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -100,6 +100,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.fw_wmi_diag_event = false,
 		.non_wow_suspend = false,
 		.threaded_napi = false,
+		.tcl_wbm_map = ath11k_hw_tcl_wbm_ring_map_ipq8074,
 	},
 	{
 		.hw_rev = ATH11K_HW_IPQ6018_HW10,
@@ -166,6 +167,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.fw_wmi_diag_event = false,
 		.non_wow_suspend = false,
 		.threaded_napi = false,
+		.tcl_wbm_map = ath11k_hw_tcl_wbm_ring_map_ipq8074,
 	},
 	{
 		.name = "qca6390 hw2.0",
@@ -231,6 +233,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.fw_wmi_diag_event = true,
 		.non_wow_suspend = false,
 		.threaded_napi = false,
+		.tcl_wbm_map = ath11k_hw_tcl_wbm_ring_map_ipq8074,
 	},
 	{
 		.name = "qcn9074 hw1.0",
@@ -296,6 +299,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.fw_wmi_diag_event = false,
 		.non_wow_suspend = false,
 		.threaded_napi = false,
+		.tcl_wbm_map = ath11k_hw_tcl_wbm_ring_map_ipq8074,
 	},
 	{
 		.name = "wcn6855 hw2.0",
@@ -361,6 +365,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.fw_wmi_diag_event = true,
 		.non_wow_suspend = false,
 		.threaded_napi = false,
+		.tcl_wbm_map = ath11k_hw_tcl_wbm_ring_map_ipq8074,
 	},
 	{
 		.name = "wcn6855 hw2.1",
@@ -425,6 +430,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.fw_wmi_diag_event = true,
 		.non_wow_suspend = false,
 		.threaded_napi = false,
+		.tcl_wbm_map = ath11k_hw_tcl_wbm_ring_map_ipq8074,
 	},
 	{
 		.name = "wcn6750 hw1.0",
@@ -437,7 +443,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.max_radios = 1,
 		.bdf_addr = 0x4B0C0000,
 		.hw_ops = &wcn6750_ops,
-		.ring_mask = &ath11k_hw_ring_mask_qca6390,
+		.ring_mask = &ath11k_hw_ring_mask_wcn6750,
 		.internal_sleep_clock = false,
 		.regs = &wcn6750_regs,
 		.qmi_service_ins_id = ATH11K_QMI_WLFW_SERVICE_INS_ID_V01_WCN6750,
@@ -481,7 +487,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.supports_regdb = true,
 		.fix_l1ss = true,
 		.credit_flow = true,
-		.max_tx_ring = DP_TCL_NUM_RING_MAX_QCA6390,
+		.max_tx_ring = DP_TCL_NUM_RING_MAX,
 		.hal_params = &ath11k_hw_hal_params_qca6390,
 		.supports_dynamic_smps_6ghz = false,
 		.alloc_cacheable_memory = false,
@@ -489,6 +495,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.fw_wmi_diag_event = false,
 		.non_wow_suspend = true,
 		.threaded_napi = true,
+		.tcl_wbm_map = ath11k_hw_tcl_wbm_ring_map_wcn6750,
 	},
 };
 
diff --git a/drivers/net/wireless/ath/ath11k/dp.c b/drivers/net/wireless/ath/ath11k/dp.c
index 8b790ce..c44b081 100644
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
+		tcl_num = ab->hw_params.tcl_wbm_map[i].tcl_ring_num;
+		wbm_num = ab->hw_params.tcl_wbm_map[i].wbm_ring_num;
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
@@ -774,8 +777,10 @@ int ath11k_dp_service_srng(struct ath11k_base *ab,
 	int i, j;
 	int tot_work_done = 0;
 
-	if (ab->hw_params.ring_mask->tx[grp_id]) {
-		i = __fls(ab->hw_params.ring_mask->tx[grp_id]);
+	for (i = 0; i < ab->hw_params.max_tx_ring; i++) {
+		if (!(BIT(ab->hw_params.tcl_wbm_map[i].wbm_ring_num) &
+		      ab->hw_params.ring_mask->tx[grp_id]))
+			continue;
 		ath11k_dp_tx_completion_handler(ab, i);
 	}
 
diff --git a/drivers/net/wireless/ath/ath11k/dp.h b/drivers/net/wireless/ath/ath11k/dp.h
index 9a30367..946510f 100644
--- a/drivers/net/wireless/ath/ath11k/dp.h
+++ b/drivers/net/wireless/ath/ath11k/dp.h
@@ -220,6 +220,8 @@ struct ath11k_pdev_dp {
 #define DP_RXDMA_MONITOR_DST_RING_SIZE	2048
 #define DP_RXDMA_MONITOR_DESC_RING_SIZE	4096
 
+#define DP_RX_RELEASE_RING_NUM	3
+
 #define DP_RX_BUFFER_SIZE	2048
 #define	DP_RX_BUFFER_SIZE_LITE  1024
 #define DP_RX_BUFFER_ALIGN_SIZE	128
diff --git a/drivers/net/wireless/ath/ath11k/dp_tx.c b/drivers/net/wireless/ath/ath11k/dp_tx.c
index 91d6244..770bdc5 100644
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
+	ti.rbm_id = ab->hw_params.tcl_wbm_map[ti.ring_id].rbm_id;
 
 	ring_map |= BIT(ti.ring_id);
 
diff --git a/drivers/net/wireless/ath/ath11k/hal.c b/drivers/net/wireless/ath/ath11k/hal.c
index 9a6340d..92038c5 100644
--- a/drivers/net/wireless/ath/ath11k/hal.c
+++ b/drivers/net/wireless/ath/ath11k/hal.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021, Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2022, Qualcomm Innovation Center, Inc. All rights reserved.
  */
 #include <linux/dma-mapping.h>
 #include "hal_tx.h"
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
index 347d456..f1b6336 100644
--- a/drivers/net/wireless/ath/ath11k/hal.h
+++ b/drivers/net/wireless/ath/ath11k/hal.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021, Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2022, Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #ifndef ATH11K_HAL_H
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
index c8929de..d1b0e36 100644
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
index 36f4f6f..c5e8836 100644
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
index c19f9101..4d3c433 100644
--- a/drivers/net/wireless/ath/ath11k/hw.c
+++ b/drivers/net/wireless/ath/ath11k/hw.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2020 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021, Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2022, Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #include <linux/types.h>
@@ -814,6 +814,30 @@ static u16 ath11k_hw_wcn6855_mpdu_info_get_peerid(u8 *tlv_data)
 	return peer_id;
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
+	/* Select the TCL ring based on the flow hash of the SKB,
+	 * since applications pumping the traffic can be scheduled
+	 * on multiple CPUs, there is a chance that packets of the
+	 * same flow could end on different TCL rings, this could
+	 * sometimes results in an out of order arrival of the
+	 * packets at the receiver.
+	 */
+	return skb_get_hash(skb);
+}
+
 const struct ath11k_hw_ops ipq8074_ops = {
 	.get_hw_mac_from_pdev_id = ath11k_hw_ipq8074_mac_from_pdev_id,
 	.wmi_init_config = ath11k_init_wmi_config_ipq8074,
@@ -851,6 +875,7 @@ const struct ath11k_hw_ops ipq8074_ops = {
 	.mpdu_info_get_peerid = ath11k_hw_ipq8074_mpdu_info_get_peerid,
 	.rx_desc_mac_addr2_valid = ath11k_hw_ipq8074_rx_desc_mac_addr2_valid,
 	.rx_desc_mpdu_start_addr2 = ath11k_hw_ipq8074_rx_desc_mpdu_start_addr2,
+	.get_ring_selector = ath11k_hw_ipq8074_get_tcl_ring_selector,
 };
 
 const struct ath11k_hw_ops ipq6018_ops = {
@@ -890,6 +915,7 @@ const struct ath11k_hw_ops ipq6018_ops = {
 	.mpdu_info_get_peerid = ath11k_hw_ipq8074_mpdu_info_get_peerid,
 	.rx_desc_mac_addr2_valid = ath11k_hw_ipq8074_rx_desc_mac_addr2_valid,
 	.rx_desc_mpdu_start_addr2 = ath11k_hw_ipq8074_rx_desc_mpdu_start_addr2,
+	.get_ring_selector = ath11k_hw_ipq8074_get_tcl_ring_selector,
 };
 
 const struct ath11k_hw_ops qca6390_ops = {
@@ -929,6 +955,7 @@ const struct ath11k_hw_ops qca6390_ops = {
 	.mpdu_info_get_peerid = ath11k_hw_ipq8074_mpdu_info_get_peerid,
 	.rx_desc_mac_addr2_valid = ath11k_hw_ipq8074_rx_desc_mac_addr2_valid,
 	.rx_desc_mpdu_start_addr2 = ath11k_hw_ipq8074_rx_desc_mpdu_start_addr2,
+	.get_ring_selector = ath11k_hw_ipq8074_get_tcl_ring_selector,
 };
 
 const struct ath11k_hw_ops qcn9074_ops = {
@@ -968,6 +995,7 @@ const struct ath11k_hw_ops qcn9074_ops = {
 	.mpdu_info_get_peerid = ath11k_hw_ipq8074_mpdu_info_get_peerid,
 	.rx_desc_mac_addr2_valid = ath11k_hw_ipq9074_rx_desc_mac_addr2_valid,
 	.rx_desc_mpdu_start_addr2 = ath11k_hw_ipq9074_rx_desc_mpdu_start_addr2,
+	.get_ring_selector = ath11k_hw_ipq8074_get_tcl_ring_selector,
 };
 
 const struct ath11k_hw_ops wcn6855_ops = {
@@ -1006,6 +1034,7 @@ const struct ath11k_hw_ops wcn6855_ops = {
 	.mpdu_info_get_peerid = ath11k_hw_wcn6855_mpdu_info_get_peerid,
 	.rx_desc_mac_addr2_valid = ath11k_hw_wcn6855_rx_desc_mac_addr2_valid,
 	.rx_desc_mpdu_start_addr2 = ath11k_hw_wcn6855_rx_desc_mpdu_start_addr2,
+	.get_ring_selector = ath11k_hw_ipq8074_get_tcl_ring_selector,
 };
 
 const struct ath11k_hw_ops wcn6750_ops = {
@@ -1044,11 +1073,14 @@ const struct ath11k_hw_ops wcn6750_ops = {
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
@@ -1895,6 +1927,43 @@ const struct ath11k_hw_ring_mask ath11k_hw_ring_mask_qcn9074 = {
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
@@ -2318,3 +2387,39 @@ const struct ath11k_hw_hal_params ath11k_hw_hal_params_ipq8074 = {
 const struct ath11k_hw_hal_params ath11k_hw_hal_params_qca6390 = {
 	.rx_buf_rbm = HAL_RX_BUF_RBM_SW1_BM,
 };
+
+const struct ath11k_hw_tcl_wbm_ring_map ath11k_hw_tcl_wbm_ring_map_ipq8074[] = {
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
+const struct ath11k_hw_tcl_wbm_ring_map ath11k_hw_tcl_wbm_ring_map_wcn6750[] = {
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
diff --git a/drivers/net/wireless/ath/ath11k/hw.h b/drivers/net/wireless/ath/ath11k/hw.h
index d33b9b7..f7c6ad5 100644
--- a/drivers/net/wireless/ath/ath11k/hw.h
+++ b/drivers/net/wireless/ath/ath11k/hw.h
@@ -126,6 +126,12 @@ struct ath11k_hw_hal_params {
 	enum hal_rx_buf_return_buf_manager rx_buf_rbm;
 };
 
+struct ath11k_hw_tcl_wbm_ring_map {
+	u8 tcl_ring_num;
+	u8 wbm_ring_num;
+	u8 rbm_id;
+};
+
 struct ath11k_hw_params {
 	const char *name;
 	u16 hw_rev;
@@ -195,6 +201,7 @@ struct ath11k_hw_params {
 	bool non_wow_suspend;
 	bool cold_boot_fw_restart;
 	bool threaded_napi;
+	const struct ath11k_hw_tcl_wbm_ring_map *tcl_wbm_map;
 };
 
 struct ath11k_hw_ops {
@@ -237,6 +244,7 @@ struct ath11k_hw_ops {
 	u16 (*mpdu_info_get_peerid)(u8 *tlv_data);
 	bool (*rx_desc_mac_addr2_valid)(struct hal_rx_desc *desc);
 	u8* (*rx_desc_mpdu_start_addr2)(struct hal_rx_desc *desc);
+	u32 (*get_ring_selector)(struct sk_buff *skb);
 };
 
 extern const struct ath11k_hw_ops ipq8074_ops;
@@ -249,10 +257,14 @@ extern const struct ath11k_hw_ops wcn6750_ops;
 extern const struct ath11k_hw_ring_mask ath11k_hw_ring_mask_ipq8074;
 extern const struct ath11k_hw_ring_mask ath11k_hw_ring_mask_qca6390;
 extern const struct ath11k_hw_ring_mask ath11k_hw_ring_mask_qcn9074;
+extern const struct ath11k_hw_ring_mask ath11k_hw_ring_mask_wcn6750;
 
 extern const struct ath11k_hw_hal_params ath11k_hw_hal_params_ipq8074;
 extern const struct ath11k_hw_hal_params ath11k_hw_hal_params_qca6390;
 
+extern const struct ath11k_hw_tcl_wbm_ring_map ath11k_hw_tcl_wbm_ring_map_ipq8074[];
+extern const struct ath11k_hw_tcl_wbm_ring_map ath11k_hw_tcl_wbm_ring_map_wcn6750[];
+
 static inline
 int ath11k_hw_get_mac_from_pdev_id(struct ath11k_hw_params *hw,
 				   int pdev_idx)
-- 
2.7.4

