Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FFD6519A10
	for <lists+linux-wireless@lfdr.de>; Wed,  4 May 2022 10:39:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240893AbiEDIm7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 May 2022 04:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240868AbiEDImz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 May 2022 04:42:55 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D8A524977
        for <linux-wireless@vger.kernel.org>; Wed,  4 May 2022 01:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1651653560; x=1683189560;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wjwJhR2OAxHa5P8ARk9m0NUgZJn5+8QZrILgs2vpKZ8=;
  b=BG/yoIFCUsAwLYfyChLID7E3Uv5qkPfSe3O9Bco8gGh4DRbSGTWduur/
   YfAYaPHO7i/c72I9uMowZ0lp4XWfNnC/EMtl0uskw+s0GZ4nAY7fB07vK
   Y9cI3TLB4vW/038i0Xid02toe0sXhAeqeNsaNdMcHlfYhnGbYMROHk/Bi
   g=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 04 May 2022 01:39:19 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2022 01:39:19 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 4 May 2022 01:39:19 -0700
Received: from mpubbise-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 4 May 2022 01:39:17 -0700
From:   Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Subject: [PATCH v4] ath11k: Fix RX de-fragmentation issue on WCN6750
Date:   Wed, 4 May 2022 14:09:00 +0530
Message-ID: <20220504083900.31513-1-quic_mpubbise@quicinc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The offset of REO register where the RX fragment destination ring
is configured is different in WCN6750 as compared to WCN6855.
Due to this differnce in offsets, on WCN6750, fragment destination
ring will be configured incorrectly, leading to RX fragments not
getting delivered to the driver. Fix this by defining HW specific
offsets for the REO MISC CTL register.

Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-00887-QCAMSLSWPLZ-1
Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1
Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.5.0.1-01100-QCAHKSWPL_SILICONZ-1
Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.4.0.1-00192-QCAHKSWPL_SILICONZ-1

Signed-off-by: Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
---
V4:
 - Added relevant comments wherever needed
 - Initialized REO misc control register to zero on other HWs that don't use this register
 - Rebased on ToT SHAID: b04efb72cd9d2d471a14f0a5758873f6c78923c2

V3:
 - Rebased on ToT SHAID: 7316a74e54318d0cd648242b18ea83cdef6dda96

V2:
 - Rebased on ToT

 drivers/net/wireless/ath/ath11k/hal.h |  2 +-
 drivers/net/wireless/ath/ath11k/hw.c  | 23 +++++++++++++++++++++--
 drivers/net/wireless/ath/ath11k/hw.h  |  1 +
 3 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/hal.h b/drivers/net/wireless/ath/ath11k/hal.h
index 1aadb1566df8..110c337ddf33 100644
--- a/drivers/net/wireless/ath/ath11k/hal.h
+++ b/drivers/net/wireless/ath/ath11k/hal.h
@@ -121,7 +121,7 @@ struct ath11k_base;
 #define HAL_REO1_DEST_RING_CTRL_IX_1		0x00000008
 #define HAL_REO1_DEST_RING_CTRL_IX_2		0x0000000c
 #define HAL_REO1_DEST_RING_CTRL_IX_3		0x00000010
-#define HAL_REO1_MISC_CTL			0x00000630
+#define HAL_REO1_MISC_CTL(ab)			ab->hw_params.regs->hal_reo1_misc_ctl
 #define HAL_REO1_RING_BASE_LSB(ab)		ab->hw_params.regs->hal_reo1_ring_base_lsb
 #define HAL_REO1_RING_BASE_MSB(ab)		ab->hw_params.regs->hal_reo1_ring_base_msb
 #define HAL_REO1_RING_ID(ab)			ab->hw_params.regs->hal_reo1_ring_id
diff --git a/drivers/net/wireless/ath/ath11k/hw.c b/drivers/net/wireless/ath/ath11k/hw.c
index 09ce357f0f0d..96db85c55585 100644
--- a/drivers/net/wireless/ath/ath11k/hw.c
+++ b/drivers/net/wireless/ath/ath11k/hw.c
@@ -771,10 +771,10 @@ static void ath11k_hw_wcn6855_reo_setup(struct ath11k_base *ab)
 		FIELD_PREP(HAL_REO1_GEN_ENABLE_AGING_FLUSH_ENABLE, 1);
 	ath11k_hif_write32(ab, reo_base + HAL_REO1_GEN_ENABLE, val);
 
-	val = ath11k_hif_read32(ab, reo_base + HAL_REO1_MISC_CTL);
+	val = ath11k_hif_read32(ab, reo_base + HAL_REO1_MISC_CTL(ab));
 	val &= ~HAL_REO1_MISC_CTL_FRAGMENT_DST_RING;
 	val |= FIELD_PREP(HAL_REO1_MISC_CTL_FRAGMENT_DST_RING, HAL_SRNG_RING_ID_REO2SW1);
-	ath11k_hif_write32(ab, reo_base + HAL_REO1_MISC_CTL, val);
+	ath11k_hif_write32(ab, reo_base + HAL_REO1_MISC_CTL(ab), val);
 
 	ath11k_hif_write32(ab, reo_base + HAL_REO1_AGING_THRESH_IX_0(ab),
 			   HAL_DEFAULT_REO_TIMEOUT_USEC);
@@ -1983,6 +1983,9 @@ const struct ath11k_hw_regs ipq8074_regs = {
 
 	/* Shadow register area */
 	.hal_shadow_base_addr = 0x0,
+
+	/* REO misc control register, not used in IPQ8074 */
+	.hal_reo1_misc_ctl = 0x0,
 };
 
 const struct ath11k_hw_regs qca6390_regs = {
@@ -2065,6 +2068,9 @@ const struct ath11k_hw_regs qca6390_regs = {
 
 	/* Shadow register area */
 	.hal_shadow_base_addr = 0x000008fc,
+
+	/* REO misc control register, not used in QCA6390 */
+	.hal_reo1_misc_ctl = 0x0,
 };
 
 const struct ath11k_hw_regs qcn9074_regs = {
@@ -2147,6 +2153,9 @@ const struct ath11k_hw_regs qcn9074_regs = {
 
 	/* Shadow register area */
 	.hal_shadow_base_addr = 0x0,
+
+	/* REO misc control register, not used in QCN9074 */
+	.hal_reo1_misc_ctl = 0x0,
 };
 
 const struct ath11k_hw_regs wcn6855_regs = {
@@ -2229,6 +2238,11 @@ const struct ath11k_hw_regs wcn6855_regs = {
 
 	/* Shadow register area */
 	.hal_shadow_base_addr = 0x000008fc,
+
+	/* REO misc control register, used for fragment
+	 * destination ring config in WCN6855.
+	 */
+	.hal_reo1_misc_ctl = 0x00000630,
 };
 
 const struct ath11k_hw_regs wcn6750_regs = {
@@ -2311,6 +2325,11 @@ const struct ath11k_hw_regs wcn6750_regs = {
 
 	/* Shadow register area */
 	.hal_shadow_base_addr = 0x00000504,
+
+	/* REO misc control register, used for fragment
+	 * destination ring config in WCN6750.
+	 */
+	.hal_reo1_misc_ctl = 0x000005d8,
 };
 
 const struct ath11k_hw_hal_params ath11k_hw_hal_params_ipq8074 = {
diff --git a/drivers/net/wireless/ath/ath11k/hw.h b/drivers/net/wireless/ath/ath11k/hw.h
index 6d588cd80093..3a2abde63489 100644
--- a/drivers/net/wireless/ath/ath11k/hw.h
+++ b/drivers/net/wireless/ath/ath11k/hw.h
@@ -379,6 +379,7 @@ struct ath11k_hw_regs {
 	u32 pcie_pcs_osc_dtct_config_base;
 
 	u32 hal_shadow_base_addr;
+	u32 hal_reo1_misc_ctl;
 };
 
 extern const struct ath11k_hw_regs ipq8074_regs;
-- 
2.35.1

