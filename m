Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47DB957B7EE
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Jul 2022 15:51:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbiGTNvk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 Jul 2022 09:51:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240480AbiGTNvf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 Jul 2022 09:51:35 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AF0430F61
        for <linux-wireless@vger.kernel.org>; Wed, 20 Jul 2022 06:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1658325094; x=1689861094;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UKaUJPEO4CFW8xiG3a5giDAdwObc+gTj9D9Vpu6hfv0=;
  b=sQLSsqQFZy9dNE1vDDss4v4fblTPgT1sh9f2NbtFbtu5HC0Q0Zij7ONh
   6r7pcgj7pQ9217gDc8WoClHjnj6hSqX1USx9VLE68SvCEmOYmxpLq65AU
   BXsYw9NPJV2wfQqJ9VAo0y5oGNPuCfeWuiirYwFWSigQYAk91xPlfSZp/
   0=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 20 Jul 2022 06:51:34 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2022 06:51:34 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 20 Jul 2022 06:51:33 -0700
Received: from mpubbise-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 20 Jul 2022 06:51:32 -0700
From:   Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Subject: [PATCH 3/3] ath11k: Increase TCL data ring size for WCN6750
Date:   Wed, 20 Jul 2022 19:21:13 +0530
Message-ID: <20220720135113.15755-4-quic_mpubbise@quicinc.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220720135113.15755-1-quic_mpubbise@quicinc.com>
References: <20220720135113.15755-1-quic_mpubbise@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Increase TCL data ring size to 2048 for WCN6750. This is
needed to meet 160 MHz TX throughput.

Add a new hw_param to indicate the TX ring size for
individual devices.

Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-00887-QCAMSLSWPLZ-1

Signed-off-by: Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/core.c | 7 +++++++
 drivers/net/wireless/ath/ath11k/dp.c   | 2 +-
 drivers/net/wireless/ath/ath11k/dp.h   | 2 ++
 drivers/net/wireless/ath/ath11k/hw.h   | 1 +
 4 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index a7eaec5798a0..4e1fe062c3c9 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -112,6 +112,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.fixed_fw_mem = false,
 		.support_off_channel_tx = false,
 		.tcl_ring_retry = true,
+		.tx_ring_size = DP_TCL_DATA_RING_SIZE,
 	},
 	{
 		.hw_rev = ATH11K_HW_IPQ6018_HW10,
@@ -189,6 +190,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.fixed_fw_mem = false,
 		.support_off_channel_tx = false,
 		.tcl_ring_retry = true,
+		.tx_ring_size = DP_TCL_DATA_RING_SIZE,
 	},
 	{
 		.name = "qca6390 hw2.0",
@@ -265,6 +267,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.fixed_fw_mem = false,
 		.support_off_channel_tx = true,
 		.tcl_ring_retry = true,
+		.tx_ring_size = DP_TCL_DATA_RING_SIZE,
 	},
 	{
 		.name = "qcn9074 hw1.0",
@@ -341,6 +344,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.fixed_fw_mem = false,
 		.support_off_channel_tx = false,
 		.tcl_ring_retry = true,
+		.tx_ring_size = DP_TCL_DATA_RING_SIZE,
 	},
 	{
 		.name = "wcn6855 hw2.0",
@@ -417,6 +421,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.fixed_fw_mem = false,
 		.support_off_channel_tx = true,
 		.tcl_ring_retry = true,
+		.tx_ring_size = DP_TCL_DATA_RING_SIZE,
 	},
 	{
 		.name = "wcn6855 hw2.1",
@@ -492,6 +497,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.fixed_fw_mem = false,
 		.support_off_channel_tx = true,
 		.tcl_ring_retry = true,
+		.tx_ring_size = DP_TCL_DATA_RING_SIZE,
 	},
 	{
 		.name = "wcn6750 hw1.0",
@@ -567,6 +573,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.fixed_fw_mem = true,
 		.support_off_channel_tx = false,
 		.tcl_ring_retry = false,
+		.tx_ring_size = DP_TCL_DATA_RING_SIZE_WCN6750,
 	},
 };
 
diff --git a/drivers/net/wireless/ath/ath11k/dp.c b/drivers/net/wireless/ath/ath11k/dp.c
index 4f7381719840..fff8decf311b 100644
--- a/drivers/net/wireless/ath/ath11k/dp.c
+++ b/drivers/net/wireless/ath/ath11k/dp.c
@@ -401,7 +401,7 @@ static int ath11k_dp_srng_common_setup(struct ath11k_base *ab)
 
 		ret = ath11k_dp_srng_setup(ab, &dp->tx_ring[i].tcl_data_ring,
 					   HAL_TCL_DATA, tcl_num, 0,
-					   DP_TCL_DATA_RING_SIZE);
+					   ab->hw_params.tx_ring_size);
 		if (ret) {
 			ath11k_warn(ab, "failed to set up tcl_data ring (%d) :%d\n",
 				    i, ret);
diff --git a/drivers/net/wireless/ath/ath11k/dp.h b/drivers/net/wireless/ath/ath11k/dp.h
index 8af2985ca2d9..16fb536da5cf 100644
--- a/drivers/net/wireless/ath/ath11k/dp.h
+++ b/drivers/net/wireless/ath/ath11k/dp.h
@@ -1,6 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
+ * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #ifndef ATH11K_DP_H
@@ -203,6 +204,7 @@ struct ath11k_pdev_dp {
 
 #define DP_WBM_RELEASE_RING_SIZE	64
 #define DP_TCL_DATA_RING_SIZE		512
+#define DP_TCL_DATA_RING_SIZE_WCN6750	2048
 #define DP_TX_COMP_RING_SIZE		32768
 #define DP_TX_IDR_SIZE			DP_TX_COMP_RING_SIZE
 #define DP_TCL_CMD_RING_SIZE		32
diff --git a/drivers/net/wireless/ath/ath11k/hw.h b/drivers/net/wireless/ath/ath11k/hw.h
index 9adfd6622c5f..a3b2df51c5b7 100644
--- a/drivers/net/wireless/ath/ath11k/hw.h
+++ b/drivers/net/wireless/ath/ath11k/hw.h
@@ -213,6 +213,7 @@ struct ath11k_hw_params {
 	bool fixed_fw_mem;
 	bool support_off_channel_tx;
 	bool tcl_ring_retry;
+	u32 tx_ring_size;
 };
 
 struct ath11k_hw_ops {
-- 
2.35.1

