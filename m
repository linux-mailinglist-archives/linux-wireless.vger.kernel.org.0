Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E37A7652027
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Dec 2022 13:07:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232328AbiLTMHL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Dec 2022 07:07:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232937AbiLTMHH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Dec 2022 07:07:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B867E03F
        for <linux-wireless@vger.kernel.org>; Tue, 20 Dec 2022 04:07:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B2D08B8122D
        for <linux-wireless@vger.kernel.org>; Tue, 20 Dec 2022 12:07:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DECDEC433EF;
        Tue, 20 Dec 2022 12:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671538023;
        bh=QxMrnwNBu4v93t4mRmVTx+CyQtgobAjnfpLfICSD/+0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X2igKxeg+b9+h58h1uZykgQLhuFwMRr16uXmiRA14GnrH8tt4pv2b4fLzGEqN6Ydu
         oXPr0QaxtDmk7PZNllKGu6UW8jq5Ii42Wc3fsOjRGb35JEG1IP1KYqPZsHjV2lFpU2
         dl808ZEUtxx8smKpZU82rgYv3x8TeocJvwbdRZVviFxSfpBNExcG27dejWY/bDZz+2
         uSVhykuOL6aNKgEf00omNOF7wHNIe85hdVJn8kvThQDjQ6+Kyyzf7qrCZPTZTs1o6R
         CgS4+yn0pJqUQ+TspPmrZejLkydpyzs+rN+3e/WH9gPgfqqpC4u3ohm04nd9e2Y2JV
         GtDDfL7YrzudQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     ath12k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH 2/3] wifi: ath12k: hal: convert offset macros to functions
Date:   Tue, 20 Dec 2022 14:06:54 +0200
Message-Id: <20221220120655.19389-3-kvalo@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221220120655.19389-1-kvalo@kernel.org>
References: <20221220120655.19389-1-kvalo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Kalle Valo <quic_kvalo@quicinc.com>

After previous patch checkpatch was giving warnings:

drivers/net/wireless/ath/ath12k/hal.h:158: Macro argument reuse 'ab' - possible side-effects?
drivers/net/wireless/ath/ath12k/hal.h:160: Macro argument reuse 'ab' - possible side-effects?
drivers/net/wireless/ath/ath12k/hal.h:162: Macro argument reuse 'ab' - possible side-effects?
drivers/net/wireless/ath/ath12k/hal.h:164: Macro argument reuse 'ab' - possible side-effects?
drivers/net/wireless/ath/ath12k/hal.h:173: Macro argument reuse 'ab' - possible side-effects?
drivers/net/wireless/ath/ath12k/hal.h:175: Macro argument reuse 'ab' - possible side-effects?
drivers/net/wireless/ath/ath12k/hal.h:177: Macro argument reuse 'ab' - possible side-effects?
drivers/net/wireless/ath/ath12k/hal.h:179: Macro argument reuse 'ab' - possible side-effects?

To fix those convert the macros into functions. As it was difficult to use
struct ath12k_base within hal.h, core.h was already including hal.h so
including back core.h would not work, move the functions also to hal.c.

No functional changes.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4

Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/hal.c | 63 +++++++++++++++++++++++----
 drivers/net/wireless/ath/ath12k/hal.h | 24 ----------
 2 files changed, 54 insertions(+), 33 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/hal.c b/drivers/net/wireless/ath/ath12k/hal.c
index 7b4a75ce5c82..95d04819083f 100644
--- a/drivers/net/wireless/ath/ath12k/hal.c
+++ b/drivers/net/wireless/ath/ath12k/hal.c
@@ -242,6 +242,51 @@ ath12k_hal_wcn7850_tcl_to_wbm_rbm_map[DP_TCL_NUM_RING_MAX] = {
 	},
 };
 
+static unsigned int ath12k_hal_reo1_ring_id_offset(struct ath12k_base *ab)
+{
+	return HAL_REO1_RING_ID(ab) - HAL_REO1_RING_BASE_LSB(ab);
+}
+
+static unsigned int ath12k_hal_reo1_ring_msi1_base_lsb_offset(struct ath12k_base *ab)
+{
+	return HAL_REO1_RING_MSI1_BASE_LSB(ab) - HAL_REO1_RING_BASE_LSB(ab);
+}
+
+static unsigned int ath12k_hal_reo1_ring_msi1_base_msb_offset(struct ath12k_base *ab)
+{
+	return HAL_REO1_RING_MSI1_BASE_MSB(ab) - HAL_REO1_RING_BASE_LSB(ab);
+}
+
+static unsigned int ath12k_hal_reo1_ring_msi1_data_offset(struct ath12k_base *ab)
+{
+	return HAL_REO1_RING_MSI1_DATA(ab) - HAL_REO1_RING_BASE_LSB(ab);
+}
+
+static unsigned int ath12k_hal_reo1_ring_base_msb_offset(struct ath12k_base *ab)
+{
+	return HAL_REO1_RING_BASE_MSB(ab) - HAL_REO1_RING_BASE_LSB(ab);
+}
+
+static unsigned int ath12k_hal_reo1_ring_producer_int_setup_offset(struct ath12k_base *ab)
+{
+	return HAL_REO1_RING_PRODUCER_INT_SETUP(ab) - HAL_REO1_RING_BASE_LSB(ab);
+}
+
+static unsigned int ath12k_hal_reo1_ring_hp_addr_lsb_offset(struct ath12k_base *ab)
+{
+	return HAL_REO1_RING_HP_ADDR_LSB(ab) - HAL_REO1_RING_BASE_LSB(ab);
+}
+
+static unsigned int ath12k_hal_reo1_ring_hp_addr_msb_offset(struct ath12k_base *ab)
+{
+	return HAL_REO1_RING_HP_ADDR_MSB(ab) - HAL_REO1_RING_BASE_LSB(ab);
+}
+
+static unsigned int ath12k_hal_reo1_ring_misc_offset(struct ath12k_base *ab)
+{
+	return HAL_REO1_RING_MISC(ab) - HAL_REO1_RING_BASE_LSB(ab);
+}
+
 static bool ath12k_hw_qcn9274_rx_desc_get_first_msdu(struct hal_rx_desc *desc)
 {
 	return !!le16_get_bits(desc->u.qcn9274.msdu_end.info5,
@@ -1217,17 +1262,17 @@ static void ath12k_hal_srng_dst_hw_init(struct ath12k_base *ab,
 
 	if (srng->flags & HAL_SRNG_FLAGS_MSI_INTR) {
 		ath12k_hif_write32(ab, reg_base +
-				   HAL_REO1_RING_MSI1_BASE_LSB_OFFSET(ab),
+				   ath12k_hal_reo1_ring_msi1_base_lsb_offset(ab),
 				   srng->msi_addr);
 
 		val = u32_encode_bits(((u64)srng->msi_addr >> HAL_ADDR_MSB_REG_SHIFT),
 				      HAL_REO1_RING_MSI1_BASE_MSB_ADDR) |
 				      HAL_REO1_RING_MSI1_BASE_MSB_MSI1_ENABLE;
 		ath12k_hif_write32(ab, reg_base +
-				   HAL_REO1_RING_MSI1_BASE_MSB_OFFSET(ab), val);
+				   ath12k_hal_reo1_ring_msi1_base_msb_offset(ab), val);
 
 		ath12k_hif_write32(ab,
-				   reg_base + HAL_REO1_RING_MSI1_DATA_OFFSET(ab),
+				   reg_base + ath12k_hal_reo1_ring_msi1_data_offset(ab),
 				   srng->msi_data);
 	}
 
@@ -1237,11 +1282,11 @@ static void ath12k_hal_srng_dst_hw_init(struct ath12k_base *ab,
 			      HAL_REO1_RING_BASE_MSB_RING_BASE_ADDR_MSB) |
 	      u32_encode_bits((srng->entry_size * srng->num_entries),
 			      HAL_REO1_RING_BASE_MSB_RING_SIZE);
-	ath12k_hif_write32(ab, reg_base + HAL_REO1_RING_BASE_MSB_OFFSET(ab), val);
+	ath12k_hif_write32(ab, reg_base + ath12k_hal_reo1_ring_base_msb_offset(ab), val);
 
 	val = u32_encode_bits(srng->ring_id, HAL_REO1_RING_ID_RING_ID) |
 	      u32_encode_bits(srng->entry_size, HAL_REO1_RING_ID_ENTRY_SIZE);
-	ath12k_hif_write32(ab, reg_base + HAL_REO1_RING_ID_OFFSET(ab), val);
+	ath12k_hif_write32(ab, reg_base + ath12k_hal_reo1_ring_id_offset(ab), val);
 
 	/* interrupt setup */
 	val = u32_encode_bits((srng->intr_timer_thres_us >> 3),
@@ -1251,15 +1296,15 @@ static void ath12k_hal_srng_dst_hw_init(struct ath12k_base *ab,
 				HAL_REO1_RING_PRDR_INT_SETUP_BATCH_COUNTER_THOLD);
 
 	ath12k_hif_write32(ab,
-			   reg_base + HAL_REO1_RING_PRODUCER_INT_SETUP_OFFSET(ab),
+			   reg_base + ath12k_hal_reo1_ring_producer_int_setup_offset(ab),
 			   val);
 
 	hp_addr = hal->rdp.paddr +
 		  ((unsigned long)srng->u.dst_ring.hp_addr -
 		   (unsigned long)hal->rdp.vaddr);
-	ath12k_hif_write32(ab, reg_base + HAL_REO1_RING_HP_ADDR_LSB_OFFSET(ab),
+	ath12k_hif_write32(ab, reg_base + ath12k_hal_reo1_ring_hp_addr_lsb_offset(ab),
 			   hp_addr & HAL_ADDR_LSB_REG_MASK);
-	ath12k_hif_write32(ab, reg_base + HAL_REO1_RING_HP_ADDR_MSB_OFFSET(ab),
+	ath12k_hif_write32(ab, reg_base + ath12k_hal_reo1_ring_hp_addr_msb_offset(ab),
 			   hp_addr >> HAL_ADDR_MSB_REG_SHIFT);
 
 	/* Initialize head and tail pointers to indicate ring is empty */
@@ -1278,7 +1323,7 @@ static void ath12k_hal_srng_dst_hw_init(struct ath12k_base *ab,
 		val |= HAL_REO1_RING_MISC_MSI_SWAP;
 	val |= HAL_REO1_RING_MISC_SRNG_ENABLE;
 
-	ath12k_hif_write32(ab, reg_base + HAL_REO1_RING_MISC_OFFSET(ab), val);
+	ath12k_hif_write32(ab, reg_base + ath12k_hal_reo1_ring_misc_offset(ab), val);
 }
 
 static void ath12k_hal_srng_src_hw_init(struct ath12k_base *ab,
diff --git a/drivers/net/wireless/ath/ath12k/hal.h b/drivers/net/wireless/ath/ath12k/hal.h
index 9d0f1d68c534..dfbd8bce70e5 100644
--- a/drivers/net/wireless/ath/ath12k/hal.h
+++ b/drivers/net/wireless/ath/ath12k/hal.h
@@ -155,30 +155,6 @@ struct ath12k_base;
 #define HAL_REO1_AGING_THRESH_IX_2(ab)	((ab)->hw_params->regs->hal_reo1_aging_thres_ix2)
 #define HAL_REO1_AGING_THRESH_IX_3(ab)	((ab)->hw_params->regs->hal_reo1_aging_thres_ix3)
 
-#define HAL_REO1_RING_MSI1_BASE_LSB_OFFSET(ab)				\
-		(HAL_REO1_RING_MSI1_BASE_LSB(ab) - HAL_REO1_RING_BASE_LSB(ab))
-#define HAL_REO1_RING_MSI1_BASE_MSB_OFFSET(ab)				\
-		(HAL_REO1_RING_MSI1_BASE_MSB(ab) - HAL_REO1_RING_BASE_LSB(ab))
-#define HAL_REO1_RING_MSI1_DATA_OFFSET(ab)				\
-		(HAL_REO1_RING_MSI1_DATA(ab) - HAL_REO1_RING_BASE_LSB(ab))
-#define HAL_REO1_RING_BASE_MSB_OFFSET(ab)				\
-		(HAL_REO1_RING_BASE_MSB(ab) - HAL_REO1_RING_BASE_LSB(ab))
-
-#define HAL_REO1_RING_ID_OFFSET(ab)					\
-	({								\
-		struct ath12k_base *_ab = (ab);				\
-		(HAL_REO1_RING_ID(_ab) - HAL_REO1_RING_BASE_LSB(_ab));	\
-	})
-
-#define HAL_REO1_RING_PRODUCER_INT_SETUP_OFFSET(ab)			\
-		(HAL_REO1_RING_PRODUCER_INT_SETUP(ab) - HAL_REO1_RING_BASE_LSB(ab))
-#define HAL_REO1_RING_HP_ADDR_LSB_OFFSET(ab)				\
-		(HAL_REO1_RING_HP_ADDR_LSB(ab) - HAL_REO1_RING_BASE_LSB(ab))
-#define HAL_REO1_RING_HP_ADDR_MSB_OFFSET(ab)				\
-		(HAL_REO1_RING_HP_ADDR_MSB(ab) - HAL_REO1_RING_BASE_LSB(ab))
-#define HAL_REO1_RING_MISC_OFFSET(ab)					\
-		(HAL_REO1_RING_MISC(ab) - HAL_REO1_RING_BASE_LSB(ab))
-
 /* REO2SW(x) R2 ring pointers (head/tail) address */
 #define HAL_REO1_RING_HP			0x00003048
 #define HAL_REO1_RING_TP			0x0000304c
-- 
2.30.2

