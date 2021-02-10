Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3568A316167
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Feb 2021 09:48:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231124AbhBJIrt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 10 Feb 2021 03:47:49 -0500
Received: from so15.mailgun.net ([198.61.254.15]:36303 "EHLO so15.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230253AbhBJIn5 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 10 Feb 2021 03:43:57 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1612946594; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=yEgQE5tOLBxulJG8us8dJ2JI2mShk2ODmm0/mbMY+5k=; b=Fqp364Sk7+u13d8Mz3PBZq38rDdcVNiqjzZktbER2bjxdtSrg4sQJAhsy+UF2jw6UqzeOMNN
 vpUCUGPe0nNYG0qUf6OUpIJy3DNKNZKoZrs2/G8mrEna3Y7K4lowwGJAdqSxviDsK70lcQ4P
 9F8foxIIeKXT7DaIRK52933Bq0A=
X-Mailgun-Sending-Ip: 198.61.254.15
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 60239c7f81f6c45dce17170f (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 10 Feb 2021 08:42:39
 GMT
Sender: akolli=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A7CE9C43462; Wed, 10 Feb 2021 08:42:38 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from vnaralas-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: akolli)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B0614C433C6;
        Wed, 10 Feb 2021 08:42:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B0614C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=akolli@codeaurora.org
From:   Anilkumar Kolli <akolli@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Karthikeyan Periyasamy <periyasa@codeaurora.org>
Subject: [PATCH 07/11] ath11k: add hal support for QCN9074
Date:   Wed, 10 Feb 2021 14:12:06 +0530
Message-Id: <1612946530-28504-8-git-send-email-akolli@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1612946530-28504-1-git-send-email-akolli@codeaurora.org>
References: <1612946530-28504-1-git-send-email-akolli@codeaurora.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Karthikeyan Periyasamy <periyasa@codeaurora.org>

Define the hal ring address and ring meta descriptor mask for
QCN9074. Move the platform specific address to the ath11k_hw_regs.
Define tx_mesh_enable ops in ath11k_hw_ops since its accessing
platform specific TCL descriptor.

Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.4.0.1.r2-00012-QCAHKSWPL_SILICONZ-1

Signed-off-by: Karthikeyan Periyasamy <periyasa@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/core.c     |  17 ++++
 drivers/net/wireless/ath/ath11k/dp_tx.c    |   2 +-
 drivers/net/wireless/ath/ath11k/hal.c      |  88 +++++++-----------
 drivers/net/wireless/ath/ath11k/hal.h      |  27 ++++--
 drivers/net/wireless/ath/ath11k/hal_desc.h |  13 +--
 drivers/net/wireless/ath/ath11k/hal_tx.c   |   3 +
 drivers/net/wireless/ath/ath11k/hal_tx.h   |   1 +
 drivers/net/wireless/ath/ath11k/hw.c       | 137 +++++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/hw.h       |  22 +++++
 drivers/net/wireless/ath/ath11k/pci.c      |  20 ++---
 drivers/net/wireless/ath/ath11k/pci.h      |  20 +++--
 11 files changed, 261 insertions(+), 89 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index fa452de49457..2d9a00d96885 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -158,6 +158,23 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.max_radios = 1,
 		.single_pdev_only = false,
 		.qmi_service_ins_id = ATH11K_QMI_WLFW_SERVICE_INS_ID_V01_QCN9074,
+		.hw_ops = &qcn9074_ops,
+		.internal_sleep_clock = false,
+		.regs = &qcn9074_regs,
+		.rxdma1_enable = true,
+		.num_rxmda_per_pdev = 1,
+		.rx_mac_buf_ring = false,
+		.vdev_start_delay = false,
+		.htt_peer_map_v2 = true,
+		.tcl_0_only = false,
+		.interface_modes = BIT(NL80211_IFTYPE_STATION) |
+					BIT(NL80211_IFTYPE_AP) |
+					BIT(NL80211_IFTYPE_MESH_POINT),
+		.supports_monitor = true,
+		.supports_shadow_regs = false,
+		.idle_ps = false,
+		.cold_boot_calib = false,
+		.supports_suspend = false,
 	},
 };
 
diff --git a/drivers/net/wireless/ath/ath11k/dp_tx.c b/drivers/net/wireless/ath/ath11k/dp_tx.c
index 1a0b9be9ce6a..f5c277977e08 100644
--- a/drivers/net/wireless/ath/ath11k/dp_tx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_tx.c
@@ -178,7 +178,7 @@ int ath11k_dp_tx(struct ath11k *ar, struct ath11k_vif *arvif,
 	}
 
 	if (ieee80211_vif_is_mesh(arvif->vif))
-		ti.flags1 |= FIELD_PREP(HAL_TCL_DATA_CMD_INFO2_MESH_ENABLE, 1);
+		ti.enable_mesh = true;
 
 	ti.flags1 |= FIELD_PREP(HAL_TCL_DATA_CMD_INFO2_TID_OVERWRITE, 1);
 
diff --git a/drivers/net/wireless/ath/ath11k/hal.c b/drivers/net/wireless/ath/ath11k/hal.c
index 9904c0eb7587..e3c056b21554 100644
--- a/drivers/net/wireless/ath/ath11k/hal.c
+++ b/drivers/net/wireless/ath/ath11k/hal.c
@@ -89,17 +89,6 @@ static const struct hal_srng_config hw_srng_config_template[] = {
 		.entry_size = sizeof(struct hal_ce_srng_src_desc) >> 2,
 		.lmac_ring = false,
 		.ring_dir = HAL_SRNG_DIR_SRC,
-		.reg_start = {
-			(HAL_SEQ_WCSS_UMAC_CE0_SRC_REG +
-			 HAL_CE_DST_RING_BASE_LSB),
-			HAL_SEQ_WCSS_UMAC_CE0_SRC_REG + HAL_CE_DST_RING_HP,
-		},
-		.reg_size = {
-			(HAL_SEQ_WCSS_UMAC_CE1_SRC_REG -
-			 HAL_SEQ_WCSS_UMAC_CE0_SRC_REG),
-			(HAL_SEQ_WCSS_UMAC_CE1_SRC_REG -
-			 HAL_SEQ_WCSS_UMAC_CE0_SRC_REG),
-		},
 		.max_size = HAL_CE_SRC_RING_BASE_MSB_RING_SIZE,
 	},
 	{ /* CE_DST */
@@ -108,17 +97,6 @@ static const struct hal_srng_config hw_srng_config_template[] = {
 		.entry_size = sizeof(struct hal_ce_srng_dest_desc) >> 2,
 		.lmac_ring = false,
 		.ring_dir = HAL_SRNG_DIR_SRC,
-		.reg_start = {
-			(HAL_SEQ_WCSS_UMAC_CE0_DST_REG +
-			 HAL_CE_DST_RING_BASE_LSB),
-			HAL_SEQ_WCSS_UMAC_CE0_DST_REG + HAL_CE_DST_RING_HP,
-		},
-		.reg_size = {
-			(HAL_SEQ_WCSS_UMAC_CE1_DST_REG -
-			 HAL_SEQ_WCSS_UMAC_CE0_DST_REG),
-			(HAL_SEQ_WCSS_UMAC_CE1_DST_REG -
-			 HAL_SEQ_WCSS_UMAC_CE0_DST_REG),
-		},
 		.max_size = HAL_CE_DST_RING_BASE_MSB_RING_SIZE,
 	},
 	{ /* CE_DST_STATUS */
@@ -127,18 +105,6 @@ static const struct hal_srng_config hw_srng_config_template[] = {
 		.entry_size = sizeof(struct hal_ce_srng_dst_status_desc) >> 2,
 		.lmac_ring = false,
 		.ring_dir = HAL_SRNG_DIR_DST,
-		.reg_start = {
-			(HAL_SEQ_WCSS_UMAC_CE0_DST_REG +
-			 HAL_CE_DST_STATUS_RING_BASE_LSB),
-			(HAL_SEQ_WCSS_UMAC_CE0_DST_REG +
-			 HAL_CE_DST_STATUS_RING_HP),
-		},
-		.reg_size = {
-			(HAL_SEQ_WCSS_UMAC_CE1_DST_REG -
-			 HAL_SEQ_WCSS_UMAC_CE0_DST_REG),
-			(HAL_SEQ_WCSS_UMAC_CE1_DST_REG -
-			 HAL_SEQ_WCSS_UMAC_CE0_DST_REG),
-		},
 		.max_size = HAL_CE_DST_STATUS_RING_BASE_MSB_RING_SIZE,
 	},
 	{ /* WBM_IDLE_LINK */
@@ -147,11 +113,6 @@ static const struct hal_srng_config hw_srng_config_template[] = {
 		.entry_size = sizeof(struct hal_wbm_link_desc) >> 2,
 		.lmac_ring = false,
 		.ring_dir = HAL_SRNG_DIR_SRC,
-		.reg_start = {
-			(HAL_SEQ_WCSS_UMAC_WBM_REG +
-			 HAL_WBM_IDLE_LINK_RING_BASE_LSB),
-			(HAL_SEQ_WCSS_UMAC_WBM_REG + HAL_WBM_IDLE_LINK_RING_HP),
-		},
 		.max_size = HAL_WBM_IDLE_LINK_RING_BASE_MSB_RING_SIZE,
 	},
 	{ /* SW2WBM_RELEASE */
@@ -160,11 +121,6 @@ static const struct hal_srng_config hw_srng_config_template[] = {
 		.entry_size = sizeof(struct hal_wbm_release_ring) >> 2,
 		.lmac_ring = false,
 		.ring_dir = HAL_SRNG_DIR_SRC,
-		.reg_start = {
-			(HAL_SEQ_WCSS_UMAC_WBM_REG +
-			 HAL_WBM_RELEASE_RING_BASE_LSB),
-			(HAL_SEQ_WCSS_UMAC_WBM_REG + HAL_WBM_RELEASE_RING_HP),
-		},
 		.max_size = HAL_SW2WBM_RELEASE_RING_BASE_MSB_RING_SIZE,
 	},
 	{ /* WBM2SW_RELEASE */
@@ -173,16 +129,6 @@ static const struct hal_srng_config hw_srng_config_template[] = {
 		.entry_size = sizeof(struct hal_wbm_release_ring) >> 2,
 		.lmac_ring = false,
 		.ring_dir = HAL_SRNG_DIR_DST,
-		.reg_start = {
-			(HAL_SEQ_WCSS_UMAC_WBM_REG +
-			 HAL_WBM0_RELEASE_RING_BASE_LSB),
-			(HAL_SEQ_WCSS_UMAC_WBM_REG + HAL_WBM0_RELEASE_RING_HP),
-		},
-		.reg_size = {
-			(HAL_WBM1_RELEASE_RING_BASE_LSB -
-			 HAL_WBM0_RELEASE_RING_BASE_LSB),
-			(HAL_WBM1_RELEASE_RING_HP - HAL_WBM0_RELEASE_RING_HP),
-		},
 		.max_size = HAL_WBM2SW_RELEASE_RING_BASE_MSB_RING_SIZE,
 	},
 	{ /* RXDMA_BUF */
@@ -955,7 +901,7 @@ void ath11k_hal_setup_link_idle_list(struct ath11k_base *ab,
 	/* Enable the SRNG */
 	ath11k_hif_write32(ab,
 			   HAL_SEQ_WCSS_UMAC_WBM_REG +
-			   HAL_WBM_IDLE_LINK_RING_MISC_ADDR, 0x40);
+			   HAL_WBM_IDLE_LINK_RING_MISC_ADDR(ab), 0x40);
 }
 
 int ath11k_hal_srng_setup(struct ath11k_base *ab, enum hal_ring_type type,
@@ -1234,6 +1180,38 @@ static int ath11k_hal_srng_create_config(struct ath11k_base *ab)
 	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_TCL_REG + HAL_TCL_STATUS_RING_BASE_LSB(ab);
 	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_TCL_REG + HAL_TCL_STATUS_RING_HP;
 
+	s = &hal->srng_config[HAL_CE_SRC];
+	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_CE0_SRC_REG(ab) + HAL_CE_DST_RING_BASE_LSB;
+	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_CE0_SRC_REG(ab) + HAL_CE_DST_RING_HP;
+	s->reg_size[0] = HAL_SEQ_WCSS_UMAC_CE1_SRC_REG(ab) - HAL_SEQ_WCSS_UMAC_CE0_SRC_REG(ab);
+	s->reg_size[1] = HAL_SEQ_WCSS_UMAC_CE1_SRC_REG(ab) - HAL_SEQ_WCSS_UMAC_CE0_SRC_REG(ab);
+
+	s = &hal->srng_config[HAL_CE_DST];
+	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_CE0_DST_REG(ab) + HAL_CE_DST_RING_BASE_LSB;
+	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_CE0_DST_REG(ab) + HAL_CE_DST_RING_HP;
+	s->reg_size[0] = HAL_SEQ_WCSS_UMAC_CE1_DST_REG(ab) - HAL_SEQ_WCSS_UMAC_CE0_DST_REG(ab);
+	s->reg_size[1] = HAL_SEQ_WCSS_UMAC_CE1_DST_REG(ab) - HAL_SEQ_WCSS_UMAC_CE0_DST_REG(ab);
+
+	s = &hal->srng_config[HAL_CE_DST_STATUS];
+	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_CE0_DST_REG(ab) + HAL_CE_DST_STATUS_RING_BASE_LSB;
+	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_CE0_DST_REG(ab) + HAL_CE_DST_STATUS_RING_HP;
+	s->reg_size[0] = HAL_SEQ_WCSS_UMAC_CE1_DST_REG(ab) - HAL_SEQ_WCSS_UMAC_CE0_DST_REG(ab);
+	s->reg_size[1] = HAL_SEQ_WCSS_UMAC_CE1_DST_REG(ab) - HAL_SEQ_WCSS_UMAC_CE0_DST_REG(ab);
+
+	s = &hal->srng_config[HAL_WBM_IDLE_LINK];
+	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_WBM_REG + HAL_WBM_IDLE_LINK_RING_BASE_LSB(ab);
+	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_WBM_REG + HAL_WBM_IDLE_LINK_RING_HP;
+
+	s = &hal->srng_config[HAL_SW2WBM_RELEASE];
+	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_WBM_REG + HAL_WBM_RELEASE_RING_BASE_LSB(ab);
+	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_WBM_REG + HAL_WBM_RELEASE_RING_HP;
+
+	s = &hal->srng_config[HAL_WBM2SW_RELEASE];
+	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_WBM_REG + HAL_WBM0_RELEASE_RING_BASE_LSB(ab);
+	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_WBM_REG + HAL_WBM0_RELEASE_RING_HP;
+	s->reg_size[0] = HAL_WBM1_RELEASE_RING_BASE_LSB(ab) - HAL_WBM0_RELEASE_RING_BASE_LSB(ab);
+	s->reg_size[1] = HAL_WBM1_RELEASE_RING_HP - HAL_WBM0_RELEASE_RING_HP;
+
 	return 0;
 }
 
diff --git a/drivers/net/wireless/ath/ath11k/hal.h b/drivers/net/wireless/ath/ath11k/hal.h
index 3f5687ebe1fc..8a28a51999b7 100644
--- a/drivers/net/wireless/ath/ath11k/hal.h
+++ b/drivers/net/wireless/ath/ath11k/hal.h
@@ -42,10 +42,14 @@ struct ath11k_base;
 #define HAL_SEQ_WCSS_UMAC_OFFSET		0x00a00000
 #define HAL_SEQ_WCSS_UMAC_REO_REG		0x00a38000
 #define HAL_SEQ_WCSS_UMAC_TCL_REG		0x00a44000
-#define HAL_SEQ_WCSS_UMAC_CE0_SRC_REG		0x00a00000
-#define HAL_SEQ_WCSS_UMAC_CE0_DST_REG		0x00a01000
-#define HAL_SEQ_WCSS_UMAC_CE1_SRC_REG		0x00a02000
-#define HAL_SEQ_WCSS_UMAC_CE1_DST_REG		0x00a03000
+#define HAL_SEQ_WCSS_UMAC_CE0_SRC_REG(x) \
+		(ab->hw_params.regs->hal_seq_wcss_umac_ce0_src_reg)
+#define HAL_SEQ_WCSS_UMAC_CE0_DST_REG(x) \
+		(ab->hw_params.regs->hal_seq_wcss_umac_ce0_dst_reg)
+#define HAL_SEQ_WCSS_UMAC_CE1_SRC_REG(x) \
+		(ab->hw_params.regs->hal_seq_wcss_umac_ce1_src_reg)
+#define HAL_SEQ_WCSS_UMAC_CE1_DST_REG(x) \
+		(ab->hw_params.regs->hal_seq_wcss_umac_ce1_dst_reg)
 #define HAL_SEQ_WCSS_UMAC_WBM_REG		0x00a34000
 
 #define HAL_CE_WFSS_CE_REG_BASE			0x01b80000
@@ -201,8 +205,10 @@ struct ath11k_base;
 #define HAL_REO_STATUS_HP(ab)			ab->hw_params.regs->hal_reo_status_hp
 
 /* WBM Idle R0 address */
-#define HAL_WBM_IDLE_LINK_RING_BASE_LSB		0x00000860
-#define HAL_WBM_IDLE_LINK_RING_MISC_ADDR	0x00000870
+#define HAL_WBM_IDLE_LINK_RING_BASE_LSB(x) \
+		(ab->hw_params.regs->hal_wbm_idle_link_ring_base_lsb)
+#define HAL_WBM_IDLE_LINK_RING_MISC_ADDR(x) \
+		(ab->hw_params.regs->hal_wbm_idle_link_ring_misc)
 #define HAL_WBM_R0_IDLE_LIST_CONTROL_ADDR	0x00000048
 #define HAL_WBM_R0_IDLE_LIST_SIZE_ADDR		0x0000004c
 #define HAL_WBM_SCATTERED_RING_BASE_LSB		0x00000058
@@ -217,14 +223,17 @@ struct ath11k_base;
 #define HAL_WBM_IDLE_LINK_RING_HP		0x000030b0
 
 /* SW2WBM R0 release address */
-#define HAL_WBM_RELEASE_RING_BASE_LSB		0x000001d8
+#define HAL_WBM_RELEASE_RING_BASE_LSB(x) \
+		(ab->hw_params.regs->hal_wbm_release_ring_base_lsb)
 
 /* SW2WBM R2 release address */
 #define HAL_WBM_RELEASE_RING_HP			0x00003018
 
 /* WBM2SW R0 release address */
-#define HAL_WBM0_RELEASE_RING_BASE_LSB		0x00000910
-#define HAL_WBM1_RELEASE_RING_BASE_LSB		0x00000968
+#define HAL_WBM0_RELEASE_RING_BASE_LSB(x) \
+		(ab->hw_params.regs->hal_wbm0_release_ring_base_lsb)
+#define HAL_WBM1_RELEASE_RING_BASE_LSB(x) \
+		(ab->hw_params.regs->hal_wbm1_release_ring_base_lsb)
 
 /* WBM2SW R2 release address */
 #define HAL_WBM0_RELEASE_RING_HP		0x000030c0
diff --git a/drivers/net/wireless/ath/ath11k/hal_desc.h b/drivers/net/wireless/ath/ath11k/hal_desc.h
index 1b713cb13b90..d54ec6aa6281 100644
--- a/drivers/net/wireless/ath/ath11k/hal_desc.h
+++ b/drivers/net/wireless/ath/ath11k/hal_desc.h
@@ -949,16 +949,17 @@ struct hal_reo_flush_cache {
 #define HAL_TCL_DATA_CMD_INFO1_TO_FW		BIT(21)
 #define HAL_TCL_DATA_CMD_INFO1_PKT_OFFSET	GENMASK(31, 23)
 
-#define HAL_TCL_DATA_CMD_INFO2_BUF_TIMESTAMP	GENMASK(18, 0)
-#define HAL_TCL_DATA_CMD_INFO2_BUF_T_VALID	BIT(19)
-#define HAL_TCL_DATA_CMD_INFO2_MESH_ENABLE	BIT(20)
-#define HAL_TCL_DATA_CMD_INFO2_TID_OVERWRITE	BIT(21)
-#define HAL_TCL_DATA_CMD_INFO2_TID		GENMASK(25, 22)
-#define HAL_TCL_DATA_CMD_INFO2_LMAC_ID		GENMASK(27, 26)
+#define HAL_TCL_DATA_CMD_INFO2_BUF_TIMESTAMP		GENMASK(18, 0)
+#define HAL_TCL_DATA_CMD_INFO2_BUF_T_VALID		BIT(19)
+#define HAL_IPQ8074_TCL_DATA_CMD_INFO2_MESH_ENABLE	BIT(20)
+#define HAL_TCL_DATA_CMD_INFO2_TID_OVERWRITE		BIT(21)
+#define HAL_TCL_DATA_CMD_INFO2_TID			GENMASK(25, 22)
+#define HAL_TCL_DATA_CMD_INFO2_LMAC_ID			GENMASK(27, 26)
 
 #define HAL_TCL_DATA_CMD_INFO3_DSCP_TID_TABLE_IDX	GENMASK(5, 0)
 #define HAL_TCL_DATA_CMD_INFO3_SEARCH_INDEX		GENMASK(25, 6)
 #define HAL_TCL_DATA_CMD_INFO3_CACHE_SET_NUM		GENMASK(29, 26)
+#define HAL_QCN9074_TCL_DATA_CMD_INFO3_MESH_ENABLE	GENMASK(31, 30)
 
 #define HAL_TCL_DATA_CMD_INFO4_RING_ID			GENMASK(27, 20)
 #define HAL_TCL_DATA_CMD_INFO4_LOOPING_COUNT		GENMASK(31, 28)
diff --git a/drivers/net/wireless/ath/ath11k/hal_tx.c b/drivers/net/wireless/ath/ath11k/hal_tx.c
index 569e790d83a1..86ed450f8238 100644
--- a/drivers/net/wireless/ath/ath11k/hal_tx.c
+++ b/drivers/net/wireless/ath/ath11k/hal_tx.c
@@ -75,6 +75,9 @@ void ath11k_hal_tx_cmd_desc_setup(struct ath11k_base *ab, void *cmd,
 			 FIELD_PREP(HAL_TCL_DATA_CMD_INFO3_CACHE_SET_NUM,
 				    ti->bss_ast_hash);
 	tcl_cmd->info4 = 0;
+
+	if (ti->enable_mesh && ab->hw_params.hw_ops->tx_mesh_enable)
+		ab->hw_params.hw_ops->tx_mesh_enable(ab, tcl_cmd);
 }
 
 void ath11k_hal_tx_set_dscp_tid_map(struct ath11k_base *ab, int id)
diff --git a/drivers/net/wireless/ath/ath11k/hal_tx.h b/drivers/net/wireless/ath/ath11k/hal_tx.h
index c291e59c3ca6..36f4f6f6cbc2 100644
--- a/drivers/net/wireless/ath/ath11k/hal_tx.h
+++ b/drivers/net/wireless/ath/ath11k/hal_tx.h
@@ -34,6 +34,7 @@ struct hal_tx_info {
 	u8 search_type; /* %HAL_TX_ADDR_SEARCH_ */
 	u8 lmac_id;
 	u8 dscp_tid_tbl_idx;
+	bool enable_mesh;
 };
 
 /* TODO: Check if the actual desc macros can be used instead */
diff --git a/drivers/net/wireless/ath/ath11k/hw.c b/drivers/net/wireless/ath/ath11k/hw.c
index 66331da35012..626739b54989 100644
--- a/drivers/net/wireless/ath/ath11k/hw.c
+++ b/drivers/net/wireless/ath/ath11k/hw.c
@@ -31,6 +31,20 @@ static u8 ath11k_hw_ipq6018_mac_from_pdev_id(int pdev_idx)
 	return pdev_idx;
 }
 
+static void ath11k_hw_ipq8074_tx_mesh_enable(struct ath11k_base *ab,
+					     struct hal_tcl_data_cmd *tcl_cmd)
+{
+	tcl_cmd->info2 |= FIELD_PREP(HAL_IPQ8074_TCL_DATA_CMD_INFO2_MESH_ENABLE,
+				     true);
+}
+
+static void ath11k_hw_qcn9074_tx_mesh_enable(struct ath11k_base *ab,
+					     struct hal_tcl_data_cmd *tcl_cmd)
+{
+	tcl_cmd->info3 |= FIELD_PREP(HAL_QCN9074_TCL_DATA_CMD_INFO3_MESH_ENABLE,
+				     true);
+}
+
 static void ath11k_init_wmi_config_qca6390(struct ath11k_base *ab,
 					   struct target_resource_config *config)
 {
@@ -160,6 +174,7 @@ const struct ath11k_hw_ops ipq8074_ops = {
 	.wmi_init_config = ath11k_init_wmi_config_ipq8074,
 	.mac_id_to_pdev_id = ath11k_hw_mac_id_to_pdev_id_ipq8074,
 	.mac_id_to_srng_id = ath11k_hw_mac_id_to_srng_id_ipq8074,
+	.tx_mesh_enable = ath11k_hw_ipq8074_tx_mesh_enable,
 };
 
 const struct ath11k_hw_ops ipq6018_ops = {
@@ -167,6 +182,7 @@ const struct ath11k_hw_ops ipq6018_ops = {
 	.wmi_init_config = ath11k_init_wmi_config_ipq8074,
 	.mac_id_to_pdev_id = ath11k_hw_mac_id_to_pdev_id_ipq8074,
 	.mac_id_to_srng_id = ath11k_hw_mac_id_to_srng_id_ipq8074,
+	.tx_mesh_enable = ath11k_hw_ipq8074_tx_mesh_enable,
 };
 
 const struct ath11k_hw_ops qca6390_ops = {
@@ -174,6 +190,15 @@ const struct ath11k_hw_ops qca6390_ops = {
 	.wmi_init_config = ath11k_init_wmi_config_qca6390,
 	.mac_id_to_pdev_id = ath11k_hw_mac_id_to_pdev_id_qca6390,
 	.mac_id_to_srng_id = ath11k_hw_mac_id_to_srng_id_qca6390,
+	.tx_mesh_enable = ath11k_hw_ipq8074_tx_mesh_enable,
+};
+
+const struct ath11k_hw_ops qcn9074_ops = {
+	.get_hw_mac_from_pdev_id = ath11k_hw_ipq6018_mac_from_pdev_id,
+	.wmi_init_config = ath11k_init_wmi_config_ipq8074,
+	.mac_id_to_pdev_id = ath11k_hw_mac_id_to_pdev_id_ipq8074,
+	.mac_id_to_srng_id = ath11k_hw_mac_id_to_srng_id_ipq8074,
+	.tx_mesh_enable = ath11k_hw_qcn9074_tx_mesh_enable,
 };
 
 #define ATH11K_TX_RING_MASK_0 0x1
@@ -841,6 +866,26 @@ const struct ath11k_hw_regs ipq8074_regs = {
 	.hal_reo_status_ring_base_lsb = 0x00000504,
 	.hal_reo_status_hp = 0x00003070,
 
+	/* WCSS relative address */
+	.hal_seq_wcss_umac_ce0_src_reg = 0x00a00000,
+	.hal_seq_wcss_umac_ce0_dst_reg = 0x00a01000,
+	.hal_seq_wcss_umac_ce1_src_reg = 0x00a02000,
+	.hal_seq_wcss_umac_ce1_dst_reg = 0x00a03000,
+
+	/* WBM Idle address */
+	.hal_wbm_idle_link_ring_base_lsb = 0x00000860,
+	.hal_wbm_idle_link_ring_misc = 0x00000870,
+
+	/* SW2WBM release address */
+	.hal_wbm_release_ring_base_lsb = 0x000001d8,
+
+	/* WBM2SW release address */
+	.hal_wbm0_release_ring_base_lsb = 0x00000910,
+	.hal_wbm1_release_ring_base_lsb = 0x00000968,
+
+	/* PCIe base address */
+	.pcie_qserdes_sysclk_en_sel = 0x0,
+	.pcie_pcs_osc_dtct_config_base = 0x0,
 };
 
 const struct ath11k_hw_regs qca6390_regs = {
@@ -891,4 +936,96 @@ const struct ath11k_hw_regs qca6390_regs = {
 	/* REO status address */
 	.hal_reo_status_ring_base_lsb = 0x000004ac,
 	.hal_reo_status_hp = 0x00003068,
+
+	/* WCSS relative address */
+	.hal_seq_wcss_umac_ce0_src_reg = 0x00a00000,
+	.hal_seq_wcss_umac_ce0_dst_reg = 0x00a01000,
+	.hal_seq_wcss_umac_ce1_src_reg = 0x00a02000,
+	.hal_seq_wcss_umac_ce1_dst_reg = 0x00a03000,
+
+	/* WBM Idle address */
+	.hal_wbm_idle_link_ring_base_lsb = 0x00000860,
+	.hal_wbm_idle_link_ring_misc = 0x00000870,
+
+	/* SW2WBM release address */
+	.hal_wbm_release_ring_base_lsb = 0x000001d8,
+
+	/* WBM2SW release address */
+	.hal_wbm0_release_ring_base_lsb = 0x00000910,
+	.hal_wbm1_release_ring_base_lsb = 0x00000968,
+
+	/* PCIe base address */
+	.pcie_qserdes_sysclk_en_sel = 0x01e0c0ac,
+	.pcie_pcs_osc_dtct_config_base = 0x01e0c628,
+};
+
+const struct ath11k_hw_regs qcn9074_regs = {
+	/* SW2TCL(x) R0 ring configuration address */
+	.hal_tcl1_ring_base_lsb = 0x000004f0,
+	.hal_tcl1_ring_base_msb = 0x000004f4,
+	.hal_tcl1_ring_id = 0x000004f8,
+	.hal_tcl1_ring_misc = 0x00000500,
+	.hal_tcl1_ring_tp_addr_lsb = 0x0000050c,
+	.hal_tcl1_ring_tp_addr_msb = 0x00000510,
+	.hal_tcl1_ring_consumer_int_setup_ix0 = 0x00000520,
+	.hal_tcl1_ring_consumer_int_setup_ix1 = 0x00000524,
+	.hal_tcl1_ring_msi1_base_lsb = 0x00000538,
+	.hal_tcl1_ring_msi1_base_msb = 0x0000053c,
+	.hal_tcl1_ring_msi1_data = 0x00000540,
+	.hal_tcl2_ring_base_lsb = 0x00000548,
+	.hal_tcl_ring_base_lsb = 0x000005f8,
+
+	/* TCL STATUS ring address */
+	.hal_tcl_status_ring_base_lsb = 0x00000700,
+
+	/* REO2SW(x) R0 ring configuration address */
+	.hal_reo1_ring_base_lsb = 0x0000029c,
+	.hal_reo1_ring_base_msb = 0x000002a0,
+	.hal_reo1_ring_id = 0x000002a4,
+	.hal_reo1_ring_misc = 0x000002ac,
+	.hal_reo1_ring_hp_addr_lsb = 0x000002b0,
+	.hal_reo1_ring_hp_addr_msb = 0x000002b4,
+	.hal_reo1_ring_producer_int_setup = 0x000002c0,
+	.hal_reo1_ring_msi1_base_lsb = 0x000002e4,
+	.hal_reo1_ring_msi1_base_msb = 0x000002e8,
+	.hal_reo1_ring_msi1_data = 0x000002ec,
+	.hal_reo2_ring_base_lsb = 0x000002f4,
+	.hal_reo1_aging_thresh_ix_0 = 0x00000564,
+	.hal_reo1_aging_thresh_ix_1 = 0x00000568,
+	.hal_reo1_aging_thresh_ix_2 = 0x0000056c,
+	.hal_reo1_aging_thresh_ix_3 = 0x00000570,
+
+	/* REO2SW(x) R2 ring pointers (head/tail) address */
+	.hal_reo1_ring_hp = 0x00003038,
+	.hal_reo1_ring_tp = 0x0000303c,
+	.hal_reo2_ring_hp = 0x00003040,
+
+	/* REO2TCL R0 ring configuration address */
+	.hal_reo_tcl_ring_base_lsb = 0x000003fc,
+	.hal_reo_tcl_ring_hp = 0x00003058,
+
+	/* REO status address */
+	.hal_reo_status_ring_base_lsb = 0x00000504,
+	.hal_reo_status_hp = 0x00003070,
+
+	/* WCSS relative address */
+	.hal_seq_wcss_umac_ce0_src_reg = 0x01b80000,
+	.hal_seq_wcss_umac_ce0_dst_reg = 0x01b81000,
+	.hal_seq_wcss_umac_ce1_src_reg = 0x01b82000,
+	.hal_seq_wcss_umac_ce1_dst_reg = 0x01b83000,
+
+	/* WBM Idle address */
+	.hal_wbm_idle_link_ring_base_lsb = 0x00000874,
+	.hal_wbm_idle_link_ring_misc = 0x00000884,
+
+	/* SW2WBM release address */
+	.hal_wbm_release_ring_base_lsb = 0x000001ec,
+
+	/* WBM2SW release address */
+	.hal_wbm0_release_ring_base_lsb = 0x00000924,
+	.hal_wbm1_release_ring_base_lsb = 0x0000097c,
+
+	/* PCIe base address */
+	.pcie_qserdes_sysclk_en_sel = 0x01e0e0a8,
+	.pcie_pcs_osc_dtct_config_base = 0x01e0f45c,
 };
diff --git a/drivers/net/wireless/ath/ath11k/hw.h b/drivers/net/wireless/ath/ath11k/hw.h
index 94c36e6149cf..13f4f9c9814b 100644
--- a/drivers/net/wireless/ath/ath11k/hw.h
+++ b/drivers/net/wireless/ath/ath11k/hw.h
@@ -105,6 +105,8 @@ enum ath11k_bus {
 
 #define ATH11K_EXT_IRQ_GRP_NUM_MAX 11
 
+struct hal_tcl_data_cmd;
+
 struct ath11k_hw_ring_mask {
 	u8 tx[ATH11K_EXT_IRQ_GRP_NUM_MAX];
 	u8 rx_mon_status[ATH11K_EXT_IRQ_GRP_NUM_MAX];
@@ -166,11 +168,14 @@ struct ath11k_hw_ops {
 				struct target_resource_config *config);
 	int (*mac_id_to_pdev_id)(struct ath11k_hw_params *hw, int mac_id);
 	int (*mac_id_to_srng_id)(struct ath11k_hw_params *hw, int mac_id);
+	void (*tx_mesh_enable)(struct ath11k_base *ab,
+			       struct hal_tcl_data_cmd *tcl_cmd);
 };
 
 extern const struct ath11k_hw_ops ipq8074_ops;
 extern const struct ath11k_hw_ops ipq6018_ops;
 extern const struct ath11k_hw_ops qca6390_ops;
+extern const struct ath11k_hw_ops qcn9074_ops;
 
 extern const struct ath11k_hw_ring_mask ath11k_hw_ring_mask_ipq8074;
 extern const struct ath11k_hw_ring_mask ath11k_hw_ring_mask_qca6390;
@@ -262,9 +267,26 @@ struct ath11k_hw_regs {
 
 	u32 hal_reo_status_ring_base_lsb;
 	u32 hal_reo_status_hp;
+
+	u32 hal_seq_wcss_umac_ce0_src_reg;
+	u32 hal_seq_wcss_umac_ce0_dst_reg;
+	u32 hal_seq_wcss_umac_ce1_src_reg;
+	u32 hal_seq_wcss_umac_ce1_dst_reg;
+
+	u32 hal_wbm_idle_link_ring_base_lsb;
+	u32 hal_wbm_idle_link_ring_misc;
+
+	u32 hal_wbm_release_ring_base_lsb;
+
+	u32 hal_wbm0_release_ring_base_lsb;
+	u32 hal_wbm1_release_ring_base_lsb;
+
+	u32 pcie_qserdes_sysclk_en_sel;
+	u32 pcie_pcs_osc_dtct_config_base;
 };
 
 extern const struct ath11k_hw_regs ipq8074_regs;
 extern const struct ath11k_hw_regs qca6390_regs;
+extern const struct ath11k_hw_regs qcn9074_regs;
 
 #endif
diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless/ath/ath11k/pci.c
index f112ebd9d98b..71cad954f65f 100644
--- a/drivers/net/wireless/ath/ath11k/pci.c
+++ b/drivers/net/wireless/ath/ath11k/pci.c
@@ -324,7 +324,7 @@ static int ath11k_pci_fix_l1ss(struct ath11k_base *ab)
 	int ret;
 
 	ret = ath11k_pci_set_link_reg(ab,
-				      PCIE_QSERDES_COM_SYSCLK_EN_SEL_REG,
+				      PCIE_QSERDES_COM_SYSCLK_EN_SEL_REG(ab),
 				      PCIE_QSERDES_COM_SYSCLK_EN_SEL_VAL,
 				      PCIE_QSERDES_COM_SYSCLK_EN_SEL_MSK);
 	if (ret) {
@@ -333,27 +333,27 @@ static int ath11k_pci_fix_l1ss(struct ath11k_base *ab)
 	}
 
 	ret = ath11k_pci_set_link_reg(ab,
-				      PCIE_USB3_PCS_MISC_OSC_DTCT_CONFIG1_REG,
-				      PCIE_USB3_PCS_MISC_OSC_DTCT_CONFIG1_VAL,
-				      PCIE_USB3_PCS_MISC_OSC_DTCT_CONFIG_MSK);
+				      PCIE_PCS_OSC_DTCT_CONFIG1_REG(ab),
+				      PCIE_PCS_OSC_DTCT_CONFIG1_VAL,
+				      PCIE_PCS_OSC_DTCT_CONFIG_MSK);
 	if (ret) {
 		ath11k_warn(ab, "failed to set dtct config1 error: %d\n", ret);
 		return ret;
 	}
 
 	ret = ath11k_pci_set_link_reg(ab,
-				      PCIE_USB3_PCS_MISC_OSC_DTCT_CONFIG2_REG,
-				      PCIE_USB3_PCS_MISC_OSC_DTCT_CONFIG2_VAL,
-				      PCIE_USB3_PCS_MISC_OSC_DTCT_CONFIG_MSK);
+				      PCIE_PCS_OSC_DTCT_CONFIG2_REG(ab),
+				      PCIE_PCS_OSC_DTCT_CONFIG2_VAL,
+				      PCIE_PCS_OSC_DTCT_CONFIG_MSK);
 	if (ret) {
 		ath11k_warn(ab, "failed to set dtct config2: %d\n", ret);
 		return ret;
 	}
 
 	ret = ath11k_pci_set_link_reg(ab,
-				      PCIE_USB3_PCS_MISC_OSC_DTCT_CONFIG4_REG,
-				      PCIE_USB3_PCS_MISC_OSC_DTCT_CONFIG4_VAL,
-				      PCIE_USB3_PCS_MISC_OSC_DTCT_CONFIG_MSK);
+				      PCIE_PCS_OSC_DTCT_CONFIG4_REG(ab),
+				      PCIE_PCS_OSC_DTCT_CONFIG4_VAL,
+				      PCIE_PCS_OSC_DTCT_CONFIG_MSK);
 	if (ret) {
 		ath11k_warn(ab, "failed to set dtct config4: %d\n", ret);
 		return ret;
diff --git a/drivers/net/wireless/ath/ath11k/pci.h b/drivers/net/wireless/ath/ath11k/pci.h
index 92eeb7c30546..264804a7c6c7 100644
--- a/drivers/net/wireless/ath/ath11k/pci.h
+++ b/drivers/net/wireless/ath/ath11k/pci.h
@@ -34,16 +34,20 @@
 #define PCIE_SMLH_REQ_RST_LINK_DOWN		0x2
 #define PCIE_INT_CLEAR_ALL			0xffffffff
 
-#define PCIE_QSERDES_COM_SYSCLK_EN_SEL_REG	0x01e0c0ac
+#define PCIE_QSERDES_COM_SYSCLK_EN_SEL_REG(x) \
+		(ab->hw_params.regs->pcie_qserdes_sysclk_en_sel)
 #define PCIE_QSERDES_COM_SYSCLK_EN_SEL_VAL	0x10
 #define PCIE_QSERDES_COM_SYSCLK_EN_SEL_MSK	0xffffffff
-#define PCIE_USB3_PCS_MISC_OSC_DTCT_CONFIG1_REG	0x01e0c628
-#define PCIE_USB3_PCS_MISC_OSC_DTCT_CONFIG1_VAL	0x02
-#define PCIE_USB3_PCS_MISC_OSC_DTCT_CONFIG2_REG	0x01e0c62c
-#define PCIE_USB3_PCS_MISC_OSC_DTCT_CONFIG2_VAL	0x52
-#define PCIE_USB3_PCS_MISC_OSC_DTCT_CONFIG4_REG	0x01e0c634
-#define PCIE_USB3_PCS_MISC_OSC_DTCT_CONFIG4_VAL	0xff
-#define PCIE_USB3_PCS_MISC_OSC_DTCT_CONFIG_MSK	0x000000ff
+#define PCIE_PCS_OSC_DTCT_CONFIG1_REG(x) \
+		(ab->hw_params.regs->pcie_pcs_osc_dtct_config_base)
+#define PCIE_PCS_OSC_DTCT_CONFIG1_VAL		0x02
+#define PCIE_PCS_OSC_DTCT_CONFIG2_REG(x) \
+		(ab->hw_params.regs->pcie_pcs_osc_dtct_config_base + 0x4)
+#define PCIE_PCS_OSC_DTCT_CONFIG2_VAL		0x52
+#define PCIE_PCS_OSC_DTCT_CONFIG4_REG(x) \
+		(ab->hw_params.regs->pcie_pcs_osc_dtct_config_base + 0xc)
+#define PCIE_PCS_OSC_DTCT_CONFIG4_VAL		0xff
+#define PCIE_PCS_OSC_DTCT_CONFIG_MSK		0x000000ff
 
 #define WLAON_QFPROM_PWR_CTRL_REG		0x01f8031c
 #define QFPROM_PWR_CTRL_VDD4BLOW_MASK		0x4
-- 
2.7.4

