Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA69652026
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Dec 2022 13:07:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233339AbiLTMHJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Dec 2022 07:07:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbiLTMHH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Dec 2022 07:07:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4667B15F1A
        for <linux-wireless@vger.kernel.org>; Tue, 20 Dec 2022 04:07:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B7227B8120F
        for <linux-wireless@vger.kernel.org>; Tue, 20 Dec 2022 12:07:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2406C433F0;
        Tue, 20 Dec 2022 12:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671538022;
        bh=Y1kTfbdM42byAQZeBosdaf7QeTdLvj+mtpvhxkW8yW8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Xq860ZBOn1ShkSrig2vVwiACco742atbj7DqH67poaUYBeDKkVtFbLU8hPremCMjJ
         etKccMpL90QSuJtGgu11qBosniXgN+HHTj35lClRCPgeaShXtIXk33DafCJDn0KP88
         M8UgijGYURO8ACPP/s9CZqHTfgojRH3BAmNc9dJ2hcQ2+/KZf72bERXUcUvWdOQrhj
         snnqasGARv0U9yd8QaCsq3n/31nUOKATQd26S3t6DCYloYc9ntpFWJwrlIjUNU1rsT
         kHYDeor+McDIw+IRzJUjwdUbAHKyCHoVHZBeO9/wlvIgZRoEC9ZwIb7dt56xRamDX/
         fZ4r1WKdA+34A==
From:   Kalle Valo <kvalo@kernel.org>
To:     ath12k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH 1/3] wifi: ath12k: hal: add ab parameter to macros using it
Date:   Tue, 20 Dec 2022 14:06:53 +0200
Message-Id: <20221220120655.19389-2-kvalo@kernel.org>
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

It's considered evil if a macro is using a variable but not having the variable
as a parameter. So add the ab parameter to macros using that.

No functional changes.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4

Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/hal.c | 16 ++++++++--------
 drivers/net/wireless/ath/ath12k/hal.h | 16 ++++++++--------
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/hal.c b/drivers/net/wireless/ath/ath12k/hal.c
index 1e05e876af51..7b4a75ce5c82 100644
--- a/drivers/net/wireless/ath/ath12k/hal.c
+++ b/drivers/net/wireless/ath/ath12k/hal.c
@@ -1217,17 +1217,17 @@ static void ath12k_hal_srng_dst_hw_init(struct ath12k_base *ab,
 
 	if (srng->flags & HAL_SRNG_FLAGS_MSI_INTR) {
 		ath12k_hif_write32(ab, reg_base +
-				   HAL_REO1_RING_MSI1_BASE_LSB_OFFSET,
+				   HAL_REO1_RING_MSI1_BASE_LSB_OFFSET(ab),
 				   srng->msi_addr);
 
 		val = u32_encode_bits(((u64)srng->msi_addr >> HAL_ADDR_MSB_REG_SHIFT),
 				      HAL_REO1_RING_MSI1_BASE_MSB_ADDR) |
 				      HAL_REO1_RING_MSI1_BASE_MSB_MSI1_ENABLE;
 		ath12k_hif_write32(ab, reg_base +
-				       HAL_REO1_RING_MSI1_BASE_MSB_OFFSET, val);
+				   HAL_REO1_RING_MSI1_BASE_MSB_OFFSET(ab), val);
 
 		ath12k_hif_write32(ab,
-				   reg_base + HAL_REO1_RING_MSI1_DATA_OFFSET,
+				   reg_base + HAL_REO1_RING_MSI1_DATA_OFFSET(ab),
 				   srng->msi_data);
 	}
 
@@ -1237,7 +1237,7 @@ static void ath12k_hal_srng_dst_hw_init(struct ath12k_base *ab,
 			      HAL_REO1_RING_BASE_MSB_RING_BASE_ADDR_MSB) |
 	      u32_encode_bits((srng->entry_size * srng->num_entries),
 			      HAL_REO1_RING_BASE_MSB_RING_SIZE);
-	ath12k_hif_write32(ab, reg_base + HAL_REO1_RING_BASE_MSB_OFFSET, val);
+	ath12k_hif_write32(ab, reg_base + HAL_REO1_RING_BASE_MSB_OFFSET(ab), val);
 
 	val = u32_encode_bits(srng->ring_id, HAL_REO1_RING_ID_RING_ID) |
 	      u32_encode_bits(srng->entry_size, HAL_REO1_RING_ID_ENTRY_SIZE);
@@ -1251,15 +1251,15 @@ static void ath12k_hal_srng_dst_hw_init(struct ath12k_base *ab,
 				HAL_REO1_RING_PRDR_INT_SETUP_BATCH_COUNTER_THOLD);
 
 	ath12k_hif_write32(ab,
-			   reg_base + HAL_REO1_RING_PRODUCER_INT_SETUP_OFFSET,
+			   reg_base + HAL_REO1_RING_PRODUCER_INT_SETUP_OFFSET(ab),
 			   val);
 
 	hp_addr = hal->rdp.paddr +
 		  ((unsigned long)srng->u.dst_ring.hp_addr -
 		   (unsigned long)hal->rdp.vaddr);
-	ath12k_hif_write32(ab, reg_base + HAL_REO1_RING_HP_ADDR_LSB_OFFSET,
+	ath12k_hif_write32(ab, reg_base + HAL_REO1_RING_HP_ADDR_LSB_OFFSET(ab),
 			   hp_addr & HAL_ADDR_LSB_REG_MASK);
-	ath12k_hif_write32(ab, reg_base + HAL_REO1_RING_HP_ADDR_MSB_OFFSET,
+	ath12k_hif_write32(ab, reg_base + HAL_REO1_RING_HP_ADDR_MSB_OFFSET(ab),
 			   hp_addr >> HAL_ADDR_MSB_REG_SHIFT);
 
 	/* Initialize head and tail pointers to indicate ring is empty */
@@ -1278,7 +1278,7 @@ static void ath12k_hal_srng_dst_hw_init(struct ath12k_base *ab,
 		val |= HAL_REO1_RING_MISC_MSI_SWAP;
 	val |= HAL_REO1_RING_MISC_SRNG_ENABLE;
 
-	ath12k_hif_write32(ab, reg_base + HAL_REO1_RING_MISC_OFFSET, val);
+	ath12k_hif_write32(ab, reg_base + HAL_REO1_RING_MISC_OFFSET(ab), val);
 }
 
 static void ath12k_hal_srng_src_hw_init(struct ath12k_base *ab,
diff --git a/drivers/net/wireless/ath/ath12k/hal.h b/drivers/net/wireless/ath/ath12k/hal.h
index 4962fa81d1c1..9d0f1d68c534 100644
--- a/drivers/net/wireless/ath/ath12k/hal.h
+++ b/drivers/net/wireless/ath/ath12k/hal.h
@@ -155,13 +155,13 @@ struct ath12k_base;
 #define HAL_REO1_AGING_THRESH_IX_2(ab)	((ab)->hw_params->regs->hal_reo1_aging_thres_ix2)
 #define HAL_REO1_AGING_THRESH_IX_3(ab)	((ab)->hw_params->regs->hal_reo1_aging_thres_ix3)
 
-#define HAL_REO1_RING_MSI1_BASE_LSB_OFFSET \
+#define HAL_REO1_RING_MSI1_BASE_LSB_OFFSET(ab)				\
 		(HAL_REO1_RING_MSI1_BASE_LSB(ab) - HAL_REO1_RING_BASE_LSB(ab))
-#define HAL_REO1_RING_MSI1_BASE_MSB_OFFSET \
+#define HAL_REO1_RING_MSI1_BASE_MSB_OFFSET(ab)				\
 		(HAL_REO1_RING_MSI1_BASE_MSB(ab) - HAL_REO1_RING_BASE_LSB(ab))
-#define HAL_REO1_RING_MSI1_DATA_OFFSET \
+#define HAL_REO1_RING_MSI1_DATA_OFFSET(ab)				\
 		(HAL_REO1_RING_MSI1_DATA(ab) - HAL_REO1_RING_BASE_LSB(ab))
-#define HAL_REO1_RING_BASE_MSB_OFFSET \
+#define HAL_REO1_RING_BASE_MSB_OFFSET(ab)				\
 		(HAL_REO1_RING_BASE_MSB(ab) - HAL_REO1_RING_BASE_LSB(ab))
 
 #define HAL_REO1_RING_ID_OFFSET(ab)					\
@@ -170,13 +170,13 @@ struct ath12k_base;
 		(HAL_REO1_RING_ID(_ab) - HAL_REO1_RING_BASE_LSB(_ab));	\
 	})
 
-#define HAL_REO1_RING_PRODUCER_INT_SETUP_OFFSET \
+#define HAL_REO1_RING_PRODUCER_INT_SETUP_OFFSET(ab)			\
 		(HAL_REO1_RING_PRODUCER_INT_SETUP(ab) - HAL_REO1_RING_BASE_LSB(ab))
-#define HAL_REO1_RING_HP_ADDR_LSB_OFFSET \
+#define HAL_REO1_RING_HP_ADDR_LSB_OFFSET(ab)				\
 		(HAL_REO1_RING_HP_ADDR_LSB(ab) - HAL_REO1_RING_BASE_LSB(ab))
-#define HAL_REO1_RING_HP_ADDR_MSB_OFFSET \
+#define HAL_REO1_RING_HP_ADDR_MSB_OFFSET(ab)				\
 		(HAL_REO1_RING_HP_ADDR_MSB(ab) - HAL_REO1_RING_BASE_LSB(ab))
-#define HAL_REO1_RING_MISC_OFFSET \
+#define HAL_REO1_RING_MISC_OFFSET(ab)					\
 		(HAL_REO1_RING_MISC(ab) - HAL_REO1_RING_BASE_LSB(ab))
 
 /* REO2SW(x) R2 ring pointers (head/tail) address */
-- 
2.30.2

