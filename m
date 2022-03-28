Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE7414E8E0A
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Mar 2022 08:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238402AbiC1GVy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Mar 2022 02:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbiC1GVw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Mar 2022 02:21:52 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6FD247384
        for <linux-wireless@vger.kernel.org>; Sun, 27 Mar 2022 23:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1648448412; x=1679984412;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qjk65JAd61BChtmQHdz7jRHmgWpg89M3JwstGTzeJig=;
  b=CXcyjF6ZDMw6btIXorRHuouXynn2hZd9BMv/qcOWn2mF7c8cyNWQJjce
   909vw5GoqvUrpdCQBv37HNPcbsyIhEUEVpnr8rxqwvWMmWOI7v7FF74dS
   W5JL8b0AVpSobiBGe3v6HrMJcRoRCS2D5g4UoaR+1oEVluWwQmpQ0xdnN
   4=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 27 Mar 2022 23:20:12 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2022 23:20:11 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Sun, 27 Mar 2022 23:20:11 -0700
Received: from mpubbise-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Sun, 27 Mar 2022 23:20:09 -0700
From:   Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Subject: [PATCH v3] ath11k: Fix RX de-fragmentation issue on WCN6750
Date:   Mon, 28 Mar 2022 11:49:47 +0530
Message-ID: <20220328061947.28813-1-quic_mpubbise@quicinc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
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
offset for the REO MISC CTL register.

Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-00573-QCAMSLSWPLZ-1
Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1
Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.5.0.1-01100-QCAHKSWPL_SILICONZ-1
Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.4.0.1-00192-QCAHKSWPL_SILICONZ-1

Signed-off-by: Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
---
Note:
*	Dependent on Series "add support for WCN6750"
	Link: https://patchwork.kernel.org/project/linux-wireless/cover/20220328060937.16738-1-quic_mpubbise@quicinc.com/

V3:
 - Rebased on ToT SHAID: 7316a74e54318d0cd648242b18ea83cdef6dda96

V2:
 - Rebased on ToT

 drivers/net/wireless/ath/ath11k/hal.h |  2 +-
 drivers/net/wireless/ath/ath11k/hw.c  | 10 ++++++++--
 drivers/net/wireless/ath/ath11k/hw.h  |  1 +
 3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/hal.h b/drivers/net/wireless/ath/ath11k/hal.h
index 6fbda016cd63..347d45656536 100644
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
index 3b9e45f9705c..87b0a9febcc1 100644
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
@@ -2229,6 +2229,9 @@ const struct ath11k_hw_regs wcn6855_regs = {
 
 	/* Shadow register area */
 	.hal_shadow_base_addr = 0x000008fc,
+
+	/* REO MISC CTRL */
+	.hal_reo1_misc_ctl = 0x00000630,
 };
 
 const struct ath11k_hw_regs wcn6750_regs = {
@@ -2311,6 +2314,9 @@ const struct ath11k_hw_regs wcn6750_regs = {
 
 	/* Shadow register area */
 	.hal_shadow_base_addr = 0x00000504,
+
+	/* REO MISC CTRL */
+	.hal_reo1_misc_ctl = 0x000005d8,
 };
 
 const struct ath11k_hw_hal_params ath11k_hw_hal_params_ipq8074 = {
diff --git a/drivers/net/wireless/ath/ath11k/hw.h b/drivers/net/wireless/ath/ath11k/hw.h
index f02120e76f99..72a04e8c6594 100644
--- a/drivers/net/wireless/ath/ath11k/hw.h
+++ b/drivers/net/wireless/ath/ath11k/hw.h
@@ -364,6 +364,7 @@ struct ath11k_hw_regs {
 	u32 pcie_pcs_osc_dtct_config_base;
 
 	u32 hal_shadow_base_addr;
+	u32 hal_reo1_misc_ctl;
 };
 
 extern const struct ath11k_hw_regs ipq8074_regs;
-- 
2.35.1

