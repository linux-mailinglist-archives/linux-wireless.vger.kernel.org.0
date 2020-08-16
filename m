Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 029E9245756
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Aug 2020 13:31:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729046AbgHPLaH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 16 Aug 2020 07:30:07 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:60270 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728617AbgHPL2y (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 16 Aug 2020 07:28:54 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597577329; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=WjnnH3UKCzHreunH2JcbOVALJRvDea90PbkQ1K6uXWk=; b=xLRBwcwLmxstfLMxvOzxT/rDawTTHChNtN0OOYeM9j254p5FBHKIN4JMGBFsbbD3iN+9vpBk
 E6Rek4apm2Jd+RFQ2ubdIlKwqnhGilFXMGcaxHWr32UYbI3EOw8eNj9BDmwT2Hs82m2nZPLO
 gBHoCFmeHorwqCqkxld5Rrafua4=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 5f3915a003528d402494ab3f (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sun, 16 Aug 2020 11:16:48
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 78A6BC433C6; Sun, 16 Aug 2020 11:16:48 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4CFB2C43387;
        Sun, 16 Aug 2020 11:16:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4CFB2C43387
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH v2 02/12] ath11k: hal: cleanup dynamic register macros
Date:   Sun, 16 Aug 2020 14:16:29 +0300
Message-Id: <1597576599-8857-3-git-send-email-kvalo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1597576599-8857-1-git-send-email-kvalo@codeaurora.org>
References: <1597576599-8857-1-git-send-email-kvalo@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Now some of the HAL register macros access ab variable in a hidden way, make ab
variable visible in the macro by adding it as an argument.

This is done in a separate patch to keep the patches simple. No functional changes.

Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1
Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.1.0.1-01238-QCAHKSWPL_SILICONZ-2

Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/hal.c    |  66 ++++++------
 drivers/net/wireless/ath/ath11k/hal.h    | 171 +++++++++++++++++--------------
 drivers/net/wireless/ath/ath11k/hal_rx.c |   8 +-
 3 files changed, 133 insertions(+), 112 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/hal.c b/drivers/net/wireless/ath/ath11k/hal.c
index 25f2270be195..ae4dc6c39e64 100644
--- a/drivers/net/wireless/ath/ath11k/hal.c
+++ b/drivers/net/wireless/ath/ath11k/hal.c
@@ -329,7 +329,7 @@ static void ath11k_hal_srng_dst_hw_init(struct ath11k_base *ab,
 
 	if (srng->flags & HAL_SRNG_FLAGS_MSI_INTR) {
 		ath11k_hif_write32(ab, reg_base +
-				   HAL_REO1_RING_MSI1_BASE_LSB_OFFSET,
+				   HAL_REO1_RING_MSI1_BASE_LSB_OFFSET(ab),
 				   (u32)srng->msi_addr);
 
 		val = FIELD_PREP(HAL_REO1_RING_MSI1_BASE_MSB_ADDR,
@@ -337,10 +337,10 @@ static void ath11k_hal_srng_dst_hw_init(struct ath11k_base *ab,
 				  HAL_ADDR_MSB_REG_SHIFT)) |
 		      HAL_REO1_RING_MSI1_BASE_MSB_MSI1_ENABLE;
 		ath11k_hif_write32(ab, reg_base +
-				       HAL_REO1_RING_MSI1_BASE_MSB_OFFSET, val);
+				       HAL_REO1_RING_MSI1_BASE_MSB_OFFSET(ab), val);
 
 		ath11k_hif_write32(ab,
-				   reg_base + HAL_REO1_RING_MSI1_DATA_OFFSET,
+				   reg_base + HAL_REO1_RING_MSI1_DATA_OFFSET(ab),
 				   srng->msi_data);
 	}
 
@@ -351,11 +351,11 @@ static void ath11k_hal_srng_dst_hw_init(struct ath11k_base *ab,
 			  HAL_ADDR_MSB_REG_SHIFT)) |
 	      FIELD_PREP(HAL_REO1_RING_BASE_MSB_RING_SIZE,
 			 (srng->entry_size * srng->num_entries));
-	ath11k_hif_write32(ab, reg_base + HAL_REO1_RING_BASE_MSB_OFFSET, val);
+	ath11k_hif_write32(ab, reg_base + HAL_REO1_RING_BASE_MSB_OFFSET(ab), val);
 
 	val = FIELD_PREP(HAL_REO1_RING_ID_RING_ID, srng->ring_id) |
 	      FIELD_PREP(HAL_REO1_RING_ID_ENTRY_SIZE, srng->entry_size);
-	ath11k_hif_write32(ab, reg_base + HAL_REO1_RING_ID_OFFSET, val);
+	ath11k_hif_write32(ab, reg_base + HAL_REO1_RING_ID_OFFSET(ab), val);
 
 	/* interrupt setup */
 	val = FIELD_PREP(HAL_REO1_RING_PRDR_INT_SETUP_INTR_TMR_THOLD,
@@ -366,21 +366,21 @@ static void ath11k_hal_srng_dst_hw_init(struct ath11k_base *ab,
 			   srng->entry_size));
 
 	ath11k_hif_write32(ab,
-			   reg_base + HAL_REO1_RING_PRODUCER_INT_SETUP_OFFSET,
+			   reg_base + HAL_REO1_RING_PRODUCER_INT_SETUP_OFFSET(ab),
 			   val);
 
 	hp_addr = hal->rdp.paddr +
 		  ((unsigned long)srng->u.dst_ring.hp_addr -
 		   (unsigned long)hal->rdp.vaddr);
-	ath11k_hif_write32(ab, reg_base + HAL_REO1_RING_HP_ADDR_LSB_OFFSET,
+	ath11k_hif_write32(ab, reg_base + HAL_REO1_RING_HP_ADDR_LSB_OFFSET(ab),
 			   hp_addr & HAL_ADDR_LSB_REG_MASK);
-	ath11k_hif_write32(ab, reg_base + HAL_REO1_RING_HP_ADDR_MSB_OFFSET,
+	ath11k_hif_write32(ab, reg_base + HAL_REO1_RING_HP_ADDR_MSB_OFFSET(ab),
 			   hp_addr >> HAL_ADDR_MSB_REG_SHIFT);
 
 	/* Initialize head and tail pointers to indicate ring is empty */
 	reg_base = srng->hwreg_base[HAL_SRNG_REG_GRP_R2];
 	ath11k_hif_write32(ab, reg_base, 0);
-	ath11k_hif_write32(ab, reg_base + HAL_REO1_RING_TP_OFFSET, 0);
+	ath11k_hif_write32(ab, reg_base + HAL_REO1_RING_TP_OFFSET(ab), 0);
 	*srng->u.dst_ring.hp_addr = 0;
 
 	reg_base = srng->hwreg_base[HAL_SRNG_REG_GRP_R0];
@@ -393,7 +393,7 @@ static void ath11k_hal_srng_dst_hw_init(struct ath11k_base *ab,
 		val |= HAL_REO1_RING_MISC_MSI_SWAP;
 	val |= HAL_REO1_RING_MISC_SRNG_ENABLE;
 
-	ath11k_hif_write32(ab, reg_base + HAL_REO1_RING_MISC_OFFSET, val);
+	ath11k_hif_write32(ab, reg_base + HAL_REO1_RING_MISC_OFFSET(ab), val);
 }
 
 static void ath11k_hal_srng_src_hw_init(struct ath11k_base *ab,
@@ -408,7 +408,7 @@ static void ath11k_hal_srng_src_hw_init(struct ath11k_base *ab,
 
 	if (srng->flags & HAL_SRNG_FLAGS_MSI_INTR) {
 		ath11k_hif_write32(ab, reg_base +
-				    HAL_TCL1_RING_MSI1_BASE_LSB_OFFSET,
+				   HAL_TCL1_RING_MSI1_BASE_LSB_OFFSET(ab),
 				   (u32)srng->msi_addr);
 
 		val = FIELD_PREP(HAL_TCL1_RING_MSI1_BASE_MSB_ADDR,
@@ -416,11 +416,11 @@ static void ath11k_hal_srng_src_hw_init(struct ath11k_base *ab,
 				  HAL_ADDR_MSB_REG_SHIFT)) |
 		      HAL_TCL1_RING_MSI1_BASE_MSB_MSI1_ENABLE;
 		ath11k_hif_write32(ab, reg_base +
-				       HAL_TCL1_RING_MSI1_BASE_MSB_OFFSET,
+				       HAL_TCL1_RING_MSI1_BASE_MSB_OFFSET(ab),
 				   val);
 
 		ath11k_hif_write32(ab, reg_base +
-				       HAL_TCL1_RING_MSI1_DATA_OFFSET,
+				       HAL_TCL1_RING_MSI1_DATA_OFFSET(ab),
 				   srng->msi_data);
 	}
 
@@ -431,10 +431,10 @@ static void ath11k_hal_srng_src_hw_init(struct ath11k_base *ab,
 			  HAL_ADDR_MSB_REG_SHIFT)) |
 	      FIELD_PREP(HAL_TCL1_RING_BASE_MSB_RING_SIZE,
 			 (srng->entry_size * srng->num_entries));
-	ath11k_hif_write32(ab, reg_base + HAL_TCL1_RING_BASE_MSB_OFFSET, val);
+	ath11k_hif_write32(ab, reg_base + HAL_TCL1_RING_BASE_MSB_OFFSET(ab), val);
 
 	val = FIELD_PREP(HAL_REO1_RING_ID_ENTRY_SIZE, srng->entry_size);
-	ath11k_hif_write32(ab, reg_base + HAL_TCL1_RING_ID_OFFSET, val);
+	ath11k_hif_write32(ab, reg_base + HAL_TCL1_RING_ID_OFFSET(ab), val);
 
 	/* interrupt setup */
 	/* NOTE: IPQ8074 v2 requires the interrupt timer threshold in the
@@ -448,7 +448,7 @@ static void ath11k_hal_srng_src_hw_init(struct ath11k_base *ab,
 			   srng->entry_size));
 
 	ath11k_hif_write32(ab,
-			   reg_base + HAL_TCL1_RING_CONSR_INT_SETUP_IX0_OFFSET,
+			   reg_base + HAL_TCL1_RING_CONSR_INT_SETUP_IX0_OFFSET(ab),
 			   val);
 
 	val = 0;
@@ -457,7 +457,7 @@ static void ath11k_hal_srng_src_hw_init(struct ath11k_base *ab,
 				  srng->u.src_ring.low_threshold);
 	}
 	ath11k_hif_write32(ab,
-			   reg_base + HAL_TCL1_RING_CONSR_INT_SETUP_IX1_OFFSET,
+			   reg_base + HAL_TCL1_RING_CONSR_INT_SETUP_IX1_OFFSET(ab),
 			   val);
 
 	if (srng->ring_id != HAL_SRNG_RING_ID_WBM_IDLE_LINK) {
@@ -465,10 +465,10 @@ static void ath11k_hal_srng_src_hw_init(struct ath11k_base *ab,
 			  ((unsigned long)srng->u.src_ring.tp_addr -
 			   (unsigned long)hal->rdp.vaddr);
 		ath11k_hif_write32(ab,
-				   reg_base + HAL_TCL1_RING_TP_ADDR_LSB_OFFSET,
+				   reg_base + HAL_TCL1_RING_TP_ADDR_LSB_OFFSET(ab),
 				   tp_addr & HAL_ADDR_LSB_REG_MASK);
 		ath11k_hif_write32(ab,
-				   reg_base + HAL_TCL1_RING_TP_ADDR_MSB_OFFSET,
+				   reg_base + HAL_TCL1_RING_TP_ADDR_MSB_OFFSET(ab),
 				   tp_addr >> HAL_ADDR_MSB_REG_SHIFT);
 	}
 
@@ -492,7 +492,7 @@ static void ath11k_hal_srng_src_hw_init(struct ath11k_base *ab,
 
 	val |= HAL_TCL1_RING_MISC_SRNG_ENABLE;
 
-	ath11k_hif_write32(ab, reg_base + HAL_TCL1_RING_MISC_OFFSET, val);
+	ath11k_hif_write32(ab, reg_base + HAL_TCL1_RING_MISC_OFFSET(ab), val);
 }
 
 static void ath11k_hal_srng_hw_init(struct ath11k_base *ab,
@@ -1043,7 +1043,7 @@ int ath11k_hal_srng_setup(struct ath11k_base *ab, enum hal_ring_type type,
 		} else {
 			srng->u.dst_ring.tp_addr =
 				(u32 *)((unsigned long)ab->mem + reg_base +
-					(HAL_REO1_RING_TP - HAL_REO1_RING_HP));
+					(HAL_REO1_RING_TP(ab) - HAL_REO1_RING_HP(ab)));
 		}
 	}
 
@@ -1072,14 +1072,14 @@ static int ath11k_hal_srng_create_config(struct ath11k_base *ab)
 		return -ENOMEM;
 
 	s = &hal->srng_config[HAL_REO_DST];
-	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_REO_REG + HAL_REO1_RING_BASE_LSB;
-	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_REO_REG + HAL_REO1_RING_HP;
-	s->reg_size[0] = HAL_REO2_RING_BASE_LSB - HAL_REO1_RING_BASE_LSB;
-	s->reg_size[1] = HAL_REO2_RING_HP - HAL_REO1_RING_HP;
+	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_REO_REG + HAL_REO1_RING_BASE_LSB(ab);
+	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_REO_REG + HAL_REO1_RING_HP(ab);
+	s->reg_size[0] = HAL_REO2_RING_BASE_LSB(ab) - HAL_REO1_RING_BASE_LSB(ab);
+	s->reg_size[1] = HAL_REO2_RING_HP(ab) - HAL_REO1_RING_HP(ab);
 
 	s = &hal->srng_config[HAL_REO_EXCEPTION];
-	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_REO_REG + HAL_REO_TCL_RING_BASE_LSB;
-	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_REO_REG + HAL_REO_TCL_RING_HP;
+	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_REO_REG + HAL_REO_TCL_RING_BASE_LSB(ab);
+	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_REO_REG + HAL_REO_TCL_RING_HP(ab);
 
 	s = &hal->srng_config[HAL_REO_REINJECT];
 	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_REO_REG + HAL_SW2REO_RING_BASE_LSB;
@@ -1090,21 +1090,21 @@ static int ath11k_hal_srng_create_config(struct ath11k_base *ab)
 	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_REO_REG + HAL_REO_CMD_HP;
 
 	s = &hal->srng_config[HAL_REO_STATUS];
-	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_REO_REG + HAL_REO_STATUS_RING_BASE_LSB;
-	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_REO_REG + HAL_REO_STATUS_HP;
+	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_REO_REG + HAL_REO_STATUS_RING_BASE_LSB(ab);
+	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_REO_REG + HAL_REO_STATUS_HP(ab);
 
 	s = &hal->srng_config[HAL_TCL_DATA];
-	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_TCL_REG + HAL_TCL1_RING_BASE_LSB;
+	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_TCL_REG + HAL_TCL1_RING_BASE_LSB(ab);
 	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_TCL_REG + HAL_TCL1_RING_HP;
-	s->reg_size[0] = HAL_TCL2_RING_BASE_LSB - HAL_TCL1_RING_BASE_LSB;
+	s->reg_size[0] = HAL_TCL2_RING_BASE_LSB(ab) - HAL_TCL1_RING_BASE_LSB(ab);
 	s->reg_size[1] = HAL_TCL2_RING_HP - HAL_TCL1_RING_HP;
 
 	s = &hal->srng_config[HAL_TCL_CMD];
-	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_TCL_REG + HAL_TCL_RING_BASE_LSB;
+	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_TCL_REG + HAL_TCL_RING_BASE_LSB(ab);
 	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_TCL_REG + HAL_TCL_RING_HP;
 
 	s = &hal->srng_config[HAL_TCL_STATUS];
-	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_TCL_REG + HAL_TCL_STATUS_RING_BASE_LSB;
+	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_TCL_REG + HAL_TCL_STATUS_RING_BASE_LSB(ab);
 	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_TCL_REG + HAL_TCL_STATUS_RING_HP;
 
 	return 0;
diff --git a/drivers/net/wireless/ath/ath11k/hal.h b/drivers/net/wireless/ath/ath11k/hal.h
index f52fd61d685d..85192d170b6b 100644
--- a/drivers/net/wireless/ath/ath11k/hal.h
+++ b/drivers/net/wireless/ath/ath11k/hal.h
@@ -46,40 +46,47 @@ struct ath11k_base;
 /* SW2TCL(x) R0 ring configuration address */
 #define HAL_TCL1_RING_CMN_CTRL_REG		0x00000014
 #define HAL_TCL1_RING_DSCP_TID_MAP		0x0000002c
-#define HAL_TCL1_RING_BASE_LSB			ab->hw_params.regs->hal_tcl1_ring_base_lsb
-#define HAL_TCL1_RING_BASE_MSB			ab->hw_params.regs->hal_tcl1_ring_base_msb
-#define HAL_TCL1_RING_ID			ab->hw_params.regs->hal_tcl1_ring_id
-#define HAL_TCL1_RING_MISC			ab->hw_params.regs->hal_tcl1_ring_misc
-#define HAL_TCL1_RING_TP_ADDR_LSB		ab->hw_params.regs->hal_tcl1_ring_tp_addr_lsb
-#define HAL_TCL1_RING_TP_ADDR_MSB		ab->hw_params.regs->hal_tcl1_ring_tp_addr_msb
-#define HAL_TCL1_RING_CONSUMER_INT_SETUP_IX0	ab->hw_params.regs->hal_tcl1_ring_consumer_int_setup_ix0
-#define HAL_TCL1_RING_CONSUMER_INT_SETUP_IX1	ab->hw_params.regs->hal_tcl1_ring_consumer_int_setup_ix1
-#define HAL_TCL1_RING_MSI1_BASE_LSB		ab->hw_params.regs->hal_tcl1_ring_msi1_base_lsb
-#define HAL_TCL1_RING_MSI1_BASE_MSB		ab->hw_params.regs->hal_tcl1_ring_msi1_base_msb
-#define HAL_TCL1_RING_MSI1_DATA			ab->hw_params.regs->hal_tcl1_ring_msi1_data
-#define HAL_TCL2_RING_BASE_LSB			ab->hw_params.regs->hal_tcl2_ring_base_lsb
-#define HAL_TCL_RING_BASE_LSB			ab->hw_params.regs->hal_tcl_ring_base_lsb
-
-#define HAL_TCL1_RING_MSI1_BASE_LSB_OFFSET \
-		(HAL_TCL1_RING_MSI1_BASE_LSB - HAL_TCL1_RING_BASE_LSB)
-#define HAL_TCL1_RING_MSI1_BASE_MSB_OFFSET \
-		(HAL_TCL1_RING_MSI1_BASE_MSB - HAL_TCL1_RING_BASE_LSB)
-#define HAL_TCL1_RING_MSI1_DATA_OFFSET \
-		(HAL_TCL1_RING_MSI1_DATA - HAL_TCL1_RING_BASE_LSB)
-#define HAL_TCL1_RING_BASE_MSB_OFFSET \
-		(HAL_TCL1_RING_BASE_MSB - HAL_TCL1_RING_BASE_LSB)
-#define HAL_TCL1_RING_ID_OFFSET \
-		(HAL_TCL1_RING_ID - HAL_TCL1_RING_BASE_LSB)
-#define HAL_TCL1_RING_CONSR_INT_SETUP_IX0_OFFSET \
-		(HAL_TCL1_RING_CONSUMER_INT_SETUP_IX0 - HAL_TCL1_RING_BASE_LSB)
-#define HAL_TCL1_RING_CONSR_INT_SETUP_IX1_OFFSET \
-		(HAL_TCL1_RING_CONSUMER_INT_SETUP_IX1 - HAL_TCL1_RING_BASE_LSB)
-#define HAL_TCL1_RING_TP_ADDR_LSB_OFFSET \
-		(HAL_TCL1_RING_TP_ADDR_LSB - HAL_TCL1_RING_BASE_LSB)
-#define HAL_TCL1_RING_TP_ADDR_MSB_OFFSET \
-		(HAL_TCL1_RING_TP_ADDR_MSB - HAL_TCL1_RING_BASE_LSB)
-#define HAL_TCL1_RING_MISC_OFFSET \
-		(HAL_TCL1_RING_MISC - HAL_TCL1_RING_BASE_LSB)
+#define HAL_TCL1_RING_BASE_LSB(ab)		ab->hw_params.regs->hal_tcl1_ring_base_lsb
+#define HAL_TCL1_RING_BASE_MSB(ab)		ab->hw_params.regs->hal_tcl1_ring_base_msb
+#define HAL_TCL1_RING_ID(ab)			ab->hw_params.regs->hal_tcl1_ring_id
+#define HAL_TCL1_RING_MISC(ab)			ab->hw_params.regs->hal_tcl1_ring_misc
+#define HAL_TCL1_RING_TP_ADDR_LSB(ab) \
+	ab->hw_params.regs->hal_tcl1_ring_tp_addr_lsb
+#define HAL_TCL1_RING_TP_ADDR_MSB(ab) \
+	ab->hw_params.regs->hal_tcl1_ring_tp_addr_msb
+#define HAL_TCL1_RING_CONSUMER_INT_SETUP_IX0(ab) \
+	ab->hw_params.regs->hal_tcl1_ring_consumer_int_setup_ix0
+#define HAL_TCL1_RING_CONSUMER_INT_SETUP_IX1(ab) \
+	ab->hw_params.regs->hal_tcl1_ring_consumer_int_setup_ix1
+#define HAL_TCL1_RING_MSI1_BASE_LSB(ab) \
+	ab->hw_params.regs->hal_tcl1_ring_msi1_base_lsb
+#define HAL_TCL1_RING_MSI1_BASE_MSB(ab) \
+	ab->hw_params.regs->hal_tcl1_ring_msi1_base_msb
+#define HAL_TCL1_RING_MSI1_DATA(ab) \
+	ab->hw_params.regs->hal_tcl1_ring_msi1_data
+#define HAL_TCL2_RING_BASE_LSB(ab)		ab->hw_params.regs->hal_tcl2_ring_base_lsb
+#define HAL_TCL_RING_BASE_LSB(ab)		ab->hw_params.regs->hal_tcl_ring_base_lsb
+
+#define HAL_TCL1_RING_MSI1_BASE_LSB_OFFSET(ab)				\
+	(HAL_TCL1_RING_MSI1_BASE_LSB(ab) - HAL_TCL1_RING_BASE_LSB(ab))
+#define HAL_TCL1_RING_MSI1_BASE_MSB_OFFSET(ab)				\
+	(HAL_TCL1_RING_MSI1_BASE_MSB(ab) - HAL_TCL1_RING_BASE_LSB(ab))
+#define HAL_TCL1_RING_MSI1_DATA_OFFSET(ab)				\
+	(HAL_TCL1_RING_MSI1_DATA(ab) - HAL_TCL1_RING_BASE_LSB(ab))
+#define HAL_TCL1_RING_BASE_MSB_OFFSET(ab)				\
+	(HAL_TCL1_RING_BASE_MSB(ab) - HAL_TCL1_RING_BASE_LSB(ab))
+#define HAL_TCL1_RING_ID_OFFSET(ab)				\
+	(HAL_TCL1_RING_ID(ab) - HAL_TCL1_RING_BASE_LSB(ab))
+#define HAL_TCL1_RING_CONSR_INT_SETUP_IX0_OFFSET(ab)			\
+	(HAL_TCL1_RING_CONSUMER_INT_SETUP_IX0(ab) - HAL_TCL1_RING_BASE_LSB(ab))
+#define HAL_TCL1_RING_CONSR_INT_SETUP_IX1_OFFSET(ab) \
+		(HAL_TCL1_RING_CONSUMER_INT_SETUP_IX1(ab) - HAL_TCL1_RING_BASE_LSB(ab))
+#define HAL_TCL1_RING_TP_ADDR_LSB_OFFSET(ab) \
+		(HAL_TCL1_RING_TP_ADDR_LSB(ab) - HAL_TCL1_RING_BASE_LSB(ab))
+#define HAL_TCL1_RING_TP_ADDR_MSB_OFFSET(ab) \
+		(HAL_TCL1_RING_TP_ADDR_MSB(ab) - HAL_TCL1_RING_BASE_LSB(ab))
+#define HAL_TCL1_RING_MISC_OFFSET(ab) \
+		(HAL_TCL1_RING_MISC(ab) - HAL_TCL1_RING_BASE_LSB(ab))
 
 /* SW2TCL(x) R2 ring pointers (head/tail) address */
 #define HAL_TCL1_RING_HP			0x00002000
@@ -91,7 +98,8 @@ struct ath11k_base;
 		(HAL_TCL1_RING_TP - HAL_TCL1_RING_HP)
 
 /* TCL STATUS ring address */
-#define HAL_TCL_STATUS_RING_BASE_LSB   ab->hw_params.regs->hal_tcl_status_ring_base_lsb
+#define HAL_TCL_STATUS_RING_BASE_LSB(ab) \
+	ab->hw_params.regs->hal_tcl_status_ring_base_lsb
 #define HAL_TCL_STATUS_RING_HP			0x00002030
 
 /* REO2SW(x) R0 ring configuration address */
@@ -100,51 +108,63 @@ struct ath11k_base;
 #define HAL_REO1_DEST_RING_CTRL_IX_1		0x00000008
 #define HAL_REO1_DEST_RING_CTRL_IX_2		0x0000000c
 #define HAL_REO1_DEST_RING_CTRL_IX_3		0x00000010
- #define HAL_REO1_RING_BASE_LSB			ab->hw_params.regs->hal_reo1_ring_base_lsb
-#define HAL_REO1_RING_BASE_MSB			ab->hw_params.regs->hal_reo1_ring_base_msb
-#define HAL_REO1_RING_ID			ab->hw_params.regs->hal_reo1_ring_id
-#define HAL_REO1_RING_MISC			ab->hw_params.regs->hal_reo1_ring_misc
-#define HAL_REO1_RING_HP_ADDR_LSB		ab->hw_params.regs->hal_reo1_ring_hp_addr_lsb
-#define HAL_REO1_RING_HP_ADDR_MSB		ab->hw_params.regs->hal_reo1_ring_hp_addr_msb
-#define HAL_REO1_RING_PRODUCER_INT_SETUP	ab->hw_params.regs->hal_reo1_ring_producer_int_setup
-#define HAL_REO1_RING_MSI1_BASE_LSB		ab->hw_params.regs->hal_reo1_ring_msi1_base_lsb
-#define HAL_REO1_RING_MSI1_BASE_MSB		ab->hw_params.regs->hal_reo1_ring_msi1_base_msb
-#define HAL_REO1_RING_MSI1_DATA			ab->hw_params.regs->hal_reo1_ring_msi1_data
-#define HAL_REO2_RING_BASE_LSB			ab->hw_params.regs->hal_reo2_ring_base_lsb
-#define HAL_REO1_AGING_THRESH_IX_0		ab->hw_params.regs->hal_reo1_aging_thresh_ix_0
-#define HAL_REO1_AGING_THRESH_IX_1		ab->hw_params.regs->hal_reo1_aging_thresh_ix_1
-#define HAL_REO1_AGING_THRESH_IX_2		ab->hw_params.regs->hal_reo1_aging_thresh_ix_2
-#define HAL_REO1_AGING_THRESH_IX_3		ab->hw_params.regs->hal_reo1_aging_thresh_ix_3
-
-#define HAL_REO1_RING_MSI1_BASE_LSB_OFFSET \
-		(HAL_REO1_RING_MSI1_BASE_LSB - HAL_REO1_RING_BASE_LSB)
-#define HAL_REO1_RING_MSI1_BASE_MSB_OFFSET \
-		(HAL_REO1_RING_MSI1_BASE_MSB - HAL_REO1_RING_BASE_LSB)
-#define HAL_REO1_RING_MSI1_DATA_OFFSET \
-		(HAL_REO1_RING_MSI1_DATA - HAL_REO1_RING_BASE_LSB)
-#define HAL_REO1_RING_BASE_MSB_OFFSET \
-		(HAL_REO1_RING_BASE_MSB - HAL_REO1_RING_BASE_LSB)
-#define HAL_REO1_RING_ID_OFFSET (HAL_REO1_RING_ID - HAL_REO1_RING_BASE_LSB)
-#define HAL_REO1_RING_PRODUCER_INT_SETUP_OFFSET \
-		(HAL_REO1_RING_PRODUCER_INT_SETUP - HAL_REO1_RING_BASE_LSB)
-#define HAL_REO1_RING_HP_ADDR_LSB_OFFSET \
-		(HAL_REO1_RING_HP_ADDR_LSB - HAL_REO1_RING_BASE_LSB)
-#define HAL_REO1_RING_HP_ADDR_MSB_OFFSET \
-		(HAL_REO1_RING_HP_ADDR_MSB - HAL_REO1_RING_BASE_LSB)
-#define HAL_REO1_RING_MISC_OFFSET (HAL_REO1_RING_MISC - HAL_REO1_RING_BASE_LSB)
+#define HAL_REO1_RING_BASE_LSB(ab)		ab->hw_params.regs->hal_reo1_ring_base_lsb
+#define HAL_REO1_RING_BASE_MSB(ab)		ab->hw_params.regs->hal_reo1_ring_base_msb
+#define HAL_REO1_RING_ID(ab)			ab->hw_params.regs->hal_reo1_ring_id
+#define HAL_REO1_RING_MISC(ab)			ab->hw_params.regs->hal_reo1_ring_misc
+#define HAL_REO1_RING_HP_ADDR_LSB(ab) \
+	ab->hw_params.regs->hal_reo1_ring_hp_addr_lsb
+#define HAL_REO1_RING_HP_ADDR_MSB(ab) \
+	ab->hw_params.regs->hal_reo1_ring_hp_addr_msb
+#define HAL_REO1_RING_PRODUCER_INT_SETUP(ab) \
+	ab->hw_params.regs->hal_reo1_ring_producer_int_setup
+#define HAL_REO1_RING_MSI1_BASE_LSB(ab) \
+	ab->hw_params.regs->hal_reo1_ring_msi1_base_lsb
+#define HAL_REO1_RING_MSI1_BASE_MSB(ab) \
+	ab->hw_params.regs->hal_reo1_ring_msi1_base_msb
+#define HAL_REO1_RING_MSI1_DATA(ab) \
+	ab->hw_params.regs->hal_reo1_ring_msi1_data
+#define HAL_REO2_RING_BASE_LSB(ab)		ab->hw_params.regs->hal_reo2_ring_base_lsb
+#define HAL_REO1_AGING_THRESH_IX_0(ab) \
+	ab->hw_params.regs->hal_reo1_aging_thresh_ix_0
+#define HAL_REO1_AGING_THRESH_IX_1(ab) \
+	ab->hw_params.regs->hal_reo1_aging_thresh_ix_1
+#define HAL_REO1_AGING_THRESH_IX_2(ab) \
+	ab->hw_params.regs->hal_reo1_aging_thresh_ix_2
+#define HAL_REO1_AGING_THRESH_IX_3(ab) \
+	ab->hw_params.regs->hal_reo1_aging_thresh_ix_3
+
+#define HAL_REO1_RING_MSI1_BASE_LSB_OFFSET(ab) \
+		(HAL_REO1_RING_MSI1_BASE_LSB(ab) - HAL_REO1_RING_BASE_LSB(ab))
+#define HAL_REO1_RING_MSI1_BASE_MSB_OFFSET(ab) \
+		(HAL_REO1_RING_MSI1_BASE_MSB(ab) - HAL_REO1_RING_BASE_LSB(ab))
+#define HAL_REO1_RING_MSI1_DATA_OFFSET(ab) \
+		(HAL_REO1_RING_MSI1_DATA(ab) - HAL_REO1_RING_BASE_LSB(ab))
+#define HAL_REO1_RING_BASE_MSB_OFFSET(ab) \
+		(HAL_REO1_RING_BASE_MSB(ab) - HAL_REO1_RING_BASE_LSB(ab))
+#define HAL_REO1_RING_ID_OFFSET(ab) (HAL_REO1_RING_ID(ab) - HAL_REO1_RING_BASE_LSB(ab))
+#define HAL_REO1_RING_PRODUCER_INT_SETUP_OFFSET(ab) \
+		(HAL_REO1_RING_PRODUCER_INT_SETUP(ab) - HAL_REO1_RING_BASE_LSB(ab))
+#define HAL_REO1_RING_HP_ADDR_LSB_OFFSET(ab) \
+		(HAL_REO1_RING_HP_ADDR_LSB(ab) - HAL_REO1_RING_BASE_LSB(ab))
+#define HAL_REO1_RING_HP_ADDR_MSB_OFFSET(ab) \
+		(HAL_REO1_RING_HP_ADDR_MSB(ab) - HAL_REO1_RING_BASE_LSB(ab))
+#define HAL_REO1_RING_MISC_OFFSET(ab) \
+	(HAL_REO1_RING_MISC(ab) - HAL_REO1_RING_BASE_LSB(ab))
 
 /* REO2SW(x) R2 ring pointers (head/tail) address */
-#define HAL_REO1_RING_HP			ab->hw_params.regs->hal_reo1_ring_hp
-#define HAL_REO1_RING_TP			ab->hw_params.regs->hal_reo1_ring_tp
-#define HAL_REO2_RING_HP			ab->hw_params.regs->hal_reo2_ring_hp
+#define HAL_REO1_RING_HP(ab)			ab->hw_params.regs->hal_reo1_ring_hp
+#define HAL_REO1_RING_TP(ab)			ab->hw_params.regs->hal_reo1_ring_tp
+#define HAL_REO2_RING_HP(ab)			ab->hw_params.regs->hal_reo2_ring_hp
 
-#define HAL_REO1_RING_TP_OFFSET	(HAL_REO1_RING_TP - HAL_REO1_RING_HP)
+#define HAL_REO1_RING_TP_OFFSET(ab)	(HAL_REO1_RING_TP(ab) - HAL_REO1_RING_HP(ab))
 
 /* REO2TCL R0 ring configuration address */
-#define HAL_REO_TCL_RING_BASE_LSB		ab->hw_params.regs->hal_reo_tcl_ring_base_lsb
+#define HAL_REO_TCL_RING_BASE_LSB(ab) \
+	ab->hw_params.regs->hal_reo_tcl_ring_base_lsb
 
 /* REO2TCL R2 ring pointer (head/tail) address */
-#define HAL_REO_TCL_RING_HP			ab->hw_params.regs->hal_reo_tcl_ring_hp
+#define HAL_REO_TCL_RING_HP(ab)			ab->hw_params.regs->hal_reo_tcl_ring_hp
 
 /* REO CMD R0 address */
 #define HAL_REO_CMD_RING_BASE_LSB		0x00000194
@@ -168,8 +188,9 @@ struct ath11k_base;
 #define HAL_CE_DST_STATUS_RING_HP		0x00000408
 
 /* REO status address */
-#define HAL_REO_STATUS_RING_BASE_LSB		ab->hw_params.regs->hal_reo_status_ring_base_lsb
-#define HAL_REO_STATUS_HP			ab->hw_params.regs->hal_reo_status_hp
+#define HAL_REO_STATUS_RING_BASE_LSB(ab) \
+	ab->hw_params.regs->hal_reo_status_ring_base_lsb
+#define HAL_REO_STATUS_HP(ab)			ab->hw_params.regs->hal_reo_status_hp
 
 /* WBM Idle R0 address */
 #define HAL_WBM_IDLE_LINK_RING_BASE_LSB		0x00000860
diff --git a/drivers/net/wireless/ath/ath11k/hal_rx.c b/drivers/net/wireless/ath/ath11k/hal_rx.c
index b30f1931313d..4bbad2e341ee 100644
--- a/drivers/net/wireless/ath/ath11k/hal_rx.c
+++ b/drivers/net/wireless/ath/ath11k/hal_rx.c
@@ -813,13 +813,13 @@ void ath11k_hal_reo_hw_setup(struct ath11k_base *ab, u32 ring_hash_map)
 	       FIELD_PREP(HAL_REO1_GEN_ENABLE_AGING_FLUSH_ENABLE, 1);
 	ath11k_hif_write32(ab, reo_base + HAL_REO1_GEN_ENABLE, val);
 
-	ath11k_hif_write32(ab, reo_base + HAL_REO1_AGING_THRESH_IX_0,
+	ath11k_hif_write32(ab, reo_base + HAL_REO1_AGING_THRESH_IX_0(ab),
 			   HAL_DEFAULT_REO_TIMEOUT_USEC);
-	ath11k_hif_write32(ab, reo_base + HAL_REO1_AGING_THRESH_IX_1,
+	ath11k_hif_write32(ab, reo_base + HAL_REO1_AGING_THRESH_IX_1(ab),
 			   HAL_DEFAULT_REO_TIMEOUT_USEC);
-	ath11k_hif_write32(ab, reo_base + HAL_REO1_AGING_THRESH_IX_2,
+	ath11k_hif_write32(ab, reo_base + HAL_REO1_AGING_THRESH_IX_2(ab),
 			   HAL_DEFAULT_REO_TIMEOUT_USEC);
-	ath11k_hif_write32(ab, reo_base + HAL_REO1_AGING_THRESH_IX_3,
+	ath11k_hif_write32(ab, reo_base + HAL_REO1_AGING_THRESH_IX_3(ab),
 			   HAL_DEFAULT_REO_TIMEOUT_USEC);
 
 	ath11k_hif_write32(ab, reo_base + HAL_REO1_DEST_RING_CTRL_IX_0,
-- 
2.7.4

