Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16A2227FC84
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Oct 2020 11:35:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731767AbgJAJfA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 1 Oct 2020 05:35:00 -0400
Received: from m42-4.mailgun.net ([69.72.42.4]:52198 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731611AbgJAJfA (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 1 Oct 2020 05:35:00 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1601544898; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=0QmFy+tNChiJqHzHAVklps1MkWd+XxjRVj4Rlvy9Ebo=; b=D9bbeQWDsLZ86lsr49zlx5716R4u+1cZv3mLDVqsBXokwkkUG2uEXimwT+XPE2X0BewOVF2y
 HS/77xnSt9SF06l+fjamA2ey6ZJOi7QwIxMzORBae8F5ZQUcCf3aoD9f5/a61fY6vcD/KNyP
 0+si0e0oj20uyAmVmgw+4wLoQPQ=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 5f75a2c2213a72d9e547b672 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 01 Oct 2020 09:34:58
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 47EEEC433C8; Thu,  1 Oct 2020 09:34:58 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 405D8C433F1;
        Thu,  1 Oct 2020 09:34:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 405D8C433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH 2/8] ath11k: enable shadow register configuration and access
Date:   Thu,  1 Oct 2020 12:34:44 +0300
Message-Id: <1601544890-13450-3-git-send-email-kvalo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1601544890-13450-1-git-send-email-kvalo@codeaurora.org>
References: <1601544890-13450-1-git-send-email-kvalo@codeaurora.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Carl Huang <cjhuang@codeaurora.org>

To enable shadow register access, host needs to pass shadow
register configuration to firmware via qmi message. Host also
needs to update ring's HP or TP address to shadow register
address. The write operation to shadow register will be
forwarded to target register by hardware automatically, and
the write operation to shadow register is permitted even
when the target is in power save or sleep mode.

Update the shadow config whenever power up happens.

This feature is controlled by hw parameter supports_shadow_regs which is only
enabled for QCA6390.

Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1

Signed-off-by: Carl Huang <cjhuang@codeaurora.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/ce.c   |  46 +++++++++++++
 drivers/net/wireless/ath/ath11k/ce.h   |   2 +
 drivers/net/wireless/ath/ath11k/core.c |   4 ++
 drivers/net/wireless/ath/ath11k/hal.c  | 114 ++++++++++++++++++++++++++++++++-
 drivers/net/wireless/ath/ath11k/hal.h  |  17 +++--
 drivers/net/wireless/ath/ath11k/hw.h   |   1 +
 drivers/net/wireless/ath/ath11k/pci.c  |   3 +
 drivers/net/wireless/ath/ath11k/qmi.c  |  13 +++-
 drivers/net/wireless/ath/ath11k/qmi.h  |   2 +-
 9 files changed, 194 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/ce.c b/drivers/net/wireless/ath/ath11k/ce.c
index b2da1f937478..caa356dde880 100644
--- a/drivers/net/wireless/ath/ath11k/ce.c
+++ b/drivers/net/wireless/ath/ath11k/ce.c
@@ -713,6 +713,49 @@ static void ath11k_ce_rx_pipe_cleanup(struct ath11k_ce_pipe *pipe)
 	}
 }
 
+static void ath11k_ce_shadow_config(struct ath11k_base *ab)
+{
+	int i;
+
+	for (i = 0; i < ab->hw_params.ce_count; i++) {
+		if (ab->hw_params.host_ce_config[i].src_nentries)
+			ath11k_hal_srng_update_shadow_config(ab,
+							     HAL_CE_SRC, i);
+
+		if (ab->hw_params.host_ce_config[i].dest_nentries) {
+			ath11k_hal_srng_update_shadow_config(ab,
+							     HAL_CE_DST, i);
+
+			ath11k_hal_srng_update_shadow_config(ab,
+							     HAL_CE_DST_STATUS, i);
+		}
+	}
+}
+
+void ath11k_ce_get_shadow_config(struct ath11k_base *ab,
+				 u32 **shadow_cfg, u32 *shadow_cfg_len)
+{
+	if (!ab->hw_params.supports_shadow_regs)
+		return;
+
+	ath11k_hal_srng_get_shadow_config(ab, shadow_cfg, shadow_cfg_len);
+
+	/* shadow is already configured */
+	if (*shadow_cfg_len)
+		return;
+
+	/* shadow isn't configured yet, configure now.
+	 * non-CE srngs are configured firstly, then
+	 * all CE srngs.
+	 */
+	ath11k_hal_srng_shadow_config(ab);
+	ath11k_ce_shadow_config(ab);
+
+	/* get the shadow configuration */
+	ath11k_hal_srng_get_shadow_config(ab, shadow_cfg, shadow_cfg_len);
+}
+EXPORT_SYMBOL(ath11k_ce_get_shadow_config);
+
 void ath11k_ce_cleanup_pipes(struct ath11k_base *ab)
 {
 	struct ath11k_ce_pipe *pipe;
@@ -767,6 +810,9 @@ int ath11k_ce_init_pipes(struct ath11k_base *ab)
 	int i;
 	int ret;
 
+	ath11k_ce_get_shadow_config(ab, &ab->qmi.ce_cfg.shadow_reg_v2,
+				    &ab->qmi.ce_cfg.shadow_reg_v2_len);
+
 	for (i = 0; i < ab->hw_params.ce_count; i++) {
 		pipe = &ab->ce.ce_pipe[i];
 
diff --git a/drivers/net/wireless/ath/ath11k/ce.h b/drivers/net/wireless/ath/ath11k/ce.h
index cf704f18f3a1..26ef65e2528e 100644
--- a/drivers/net/wireless/ath/ath11k/ce.h
+++ b/drivers/net/wireless/ath/ath11k/ce.h
@@ -187,4 +187,6 @@ void ath11k_ce_poll_send_completed(struct ath11k_base *ab, u8 pipe_id);
 int ath11k_ce_map_service_to_pipe(struct ath11k_base *ab, u16 service_id,
 				  u8 *ul_pipe, u8 *dl_pipe);
 int ath11k_ce_attr_attach(struct ath11k_base *ab);
+void ath11k_ce_get_shadow_config(struct ath11k_base *ab,
+				 u32 **shadow_cfg, u32 *shadow_cfg_len);
 #endif
diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index 951dca1b66b4..e94d760b21a0 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -63,6 +63,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 					BIT(NL80211_IFTYPE_AP) |
 					BIT(NL80211_IFTYPE_MESH_POINT),
 		.supports_monitor = true,
+		.supports_shadow_regs = false,
 	},
 	{
 		.hw_rev = ATH11K_HW_IPQ6018_HW10,
@@ -98,6 +99,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 					BIT(NL80211_IFTYPE_AP) |
 					BIT(NL80211_IFTYPE_MESH_POINT),
 		.supports_monitor = true,
+		.supports_shadow_regs = false,
 	},
 	{
 		.name = "qca6390 hw2.0",
@@ -132,6 +134,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.interface_modes = BIT(NL80211_IFTYPE_STATION) |
 					BIT(NL80211_IFTYPE_AP),
 		.supports_monitor = false,
+		.supports_shadow_regs = true,
 	},
 };
 
@@ -412,6 +415,7 @@ static void ath11k_core_stop(struct ath11k_base *ab)
 {
 	if (!test_bit(ATH11K_FLAG_CRASH_FLUSH, &ab->dev_flags))
 		ath11k_qmi_firmware_stop(ab);
+
 	ath11k_hif_stop(ab);
 	ath11k_wmi_detach(ab);
 	ath11k_dp_pdev_reo_cleanup(ab);
diff --git a/drivers/net/wireless/ath/ath11k/hal.c b/drivers/net/wireless/ath/ath11k/hal.c
index a23e87910056..d58dfdfe7860 100644
--- a/drivers/net/wireless/ath/ath11k/hal.c
+++ b/drivers/net/wireless/ath/ath11k/hal.c
@@ -1020,8 +1020,16 @@ int ath11k_hal_srng_setup(struct ath11k_base *ab, enum hal_ring_type type,
 						   lmac_idx);
 			srng->flags |= HAL_SRNG_FLAGS_LMAC_RING;
 		} else {
-			srng->u.src_ring.hp_addr =
+			if (!ab->hw_params.supports_shadow_regs)
+				srng->u.src_ring.hp_addr =
 				(u32 *)((unsigned long)ab->mem + reg_base);
+			else
+				ath11k_dbg(ab, ATH11k_DBG_HAL,
+					   "hal type %d ring_num %d reg_base 0x%x shadow 0x%lx\n",
+					   type, ring_num,
+					   reg_base,
+					   (unsigned long)srng->u.src_ring.hp_addr -
+					   (unsigned long)ab->mem);
 		}
 	} else {
 		/* During initialization loop count in all the descriptors
@@ -1045,9 +1053,18 @@ int ath11k_hal_srng_setup(struct ath11k_base *ab, enum hal_ring_type type,
 						   lmac_idx);
 			srng->flags |= HAL_SRNG_FLAGS_LMAC_RING;
 		} else {
-			srng->u.dst_ring.tp_addr =
+			if (!ab->hw_params.supports_shadow_regs)
+				srng->u.dst_ring.tp_addr =
 				(u32 *)((unsigned long)ab->mem + reg_base +
 					(HAL_REO1_RING_TP(ab) - HAL_REO1_RING_HP(ab)));
+			else
+				ath11k_dbg(ab, ATH11k_DBG_HAL,
+					   "type %d ring_num %d target_reg 0x%x shadow 0x%lx\n",
+					   type, ring_num,
+					   reg_base + (HAL_REO1_RING_TP(ab) -
+						       HAL_REO1_RING_HP(ab)),
+					   (unsigned long)srng->u.dst_ring.tp_addr -
+					   (unsigned long)ab->mem);
 		}
 	}
 
@@ -1064,6 +1081,99 @@ int ath11k_hal_srng_setup(struct ath11k_base *ab, enum hal_ring_type type,
 	return ring_id;
 }
 
+static void ath11k_hal_srng_update_hp_tp_addr(struct ath11k_base *ab,
+					      int shadow_cfg_idx,
+					  enum hal_ring_type ring_type,
+					  int ring_num)
+{
+	struct hal_srng *srng;
+	struct ath11k_hal *hal = &ab->hal;
+	int ring_id;
+	struct hal_srng_config *srng_config = &hal->srng_config[ring_type];
+
+	ring_id = ath11k_hal_srng_get_ring_id(ab, ring_type, ring_num, 0);
+	if (ring_id < 0)
+		return;
+
+	srng = &hal->srng_list[ring_id];
+
+	if (srng_config->ring_dir == HAL_SRNG_DIR_DST)
+		srng->u.dst_ring.tp_addr = (u32 *)(HAL_SHADOW_REG(shadow_cfg_idx) +
+						   (unsigned long)ab->mem);
+	else
+		srng->u.src_ring.hp_addr = (u32 *)(HAL_SHADOW_REG(shadow_cfg_idx) +
+						   (unsigned long)ab->mem);
+}
+
+int ath11k_hal_srng_update_shadow_config(struct ath11k_base *ab,
+					 enum hal_ring_type ring_type,
+					 int ring_num)
+{
+	struct ath11k_hal *hal = &ab->hal;
+	struct hal_srng_config *srng_config = &hal->srng_config[ring_type];
+	int shadow_cfg_idx = hal->num_shadow_reg_configured;
+	u32 target_reg;
+
+	if (shadow_cfg_idx >= HAL_SHADOW_NUM_REGS)
+		return -EINVAL;
+
+	hal->num_shadow_reg_configured++;
+
+	target_reg = srng_config->reg_start[HAL_HP_OFFSET_IN_REG_START];
+	target_reg += srng_config->reg_size[HAL_HP_OFFSET_IN_REG_START] *
+		ring_num;
+
+	/* For destination ring, shadow the TP */
+	if (srng_config->ring_dir == HAL_SRNG_DIR_DST)
+		target_reg += HAL_OFFSET_FROM_HP_TO_TP;
+
+	hal->shadow_reg_addr[shadow_cfg_idx] = target_reg;
+
+	/* update hp/tp addr to hal structure*/
+	ath11k_hal_srng_update_hp_tp_addr(ab, shadow_cfg_idx, ring_type,
+					  ring_num);
+
+	ath11k_dbg(ab, ATH11k_DBG_HAL,
+		   "target_reg %x, shadow reg 0x%x shadow_idx 0x%x, ring_type %d, ring num %d",
+		  target_reg,
+		  HAL_SHADOW_REG(shadow_cfg_idx),
+		  shadow_cfg_idx,
+		  ring_type, ring_num);
+
+	return 0;
+}
+
+void ath11k_hal_srng_shadow_config(struct ath11k_base *ab)
+{
+	struct ath11k_hal *hal = &ab->hal;
+	int ring_type, ring_num;
+
+	/* update all the non-CE srngs. */
+	for (ring_type = 0; ring_type < HAL_MAX_RING_TYPES; ring_type++) {
+		struct hal_srng_config *srng_config = &hal->srng_config[ring_type];
+
+		if (ring_type == HAL_CE_SRC ||
+		    ring_type == HAL_CE_DST ||
+			ring_type == HAL_CE_DST_STATUS)
+			continue;
+
+		if (srng_config->lmac_ring)
+			continue;
+
+		for (ring_num = 0; ring_num < srng_config->max_rings; ring_num++)
+			ath11k_hal_srng_update_shadow_config(ab, ring_type, ring_num);
+	}
+}
+
+void ath11k_hal_srng_get_shadow_config(struct ath11k_base *ab,
+				       u32 **cfg, u32 *len)
+{
+	struct ath11k_hal *hal = &ab->hal;
+
+	*len = hal->num_shadow_reg_configured;
+	*cfg = hal->shadow_reg_addr;
+}
+
 static int ath11k_hal_srng_create_config(struct ath11k_base *ab)
 {
 	struct ath11k_hal *hal = &ab->hal;
diff --git a/drivers/net/wireless/ath/ath11k/hal.h b/drivers/net/wireless/ath/ath11k/hal.h
index 85192d170b6b..fe2448b52a7d 100644
--- a/drivers/net/wireless/ath/ath11k/hal.h
+++ b/drivers/net/wireless/ath/ath11k/hal.h
@@ -31,8 +31,12 @@ struct ath11k_base;
 #define HAL_DSCP_TID_TBL_SIZE			24
 
 /* calculate the register address from bar0 of shadow register x */
-#define SHADOW_BASE_ADDRESS			0x00003024
-#define SHADOW_NUM_REGISTERS				36
+#define HAL_SHADOW_BASE_ADDR			0x000008fc
+#define HAL_SHADOW_NUM_REGS			36
+#define HAL_HP_OFFSET_IN_REG_START		1
+#define HAL_OFFSET_FROM_HP_TO_TP		4
+
+#define HAL_SHADOW_REG(x) (HAL_SHADOW_BASE_ADDR + (4 * (x)))
 
 /* WCSS Relative address */
 #define HAL_SEQ_WCSS_UMAC_REO_REG		0x00a38000
@@ -882,7 +886,7 @@ struct ath11k_hal {
 	u8 current_blk_index;
 
 	/* shadow register configuration */
-	u32 shadow_reg_addr[SHADOW_NUM_REGISTERS];
+	u32 shadow_reg_addr[HAL_SHADOW_NUM_REGS];
 	int num_shadow_reg_configured;
 };
 
@@ -935,5 +939,10 @@ int ath11k_hal_srng_setup(struct ath11k_base *ab, enum hal_ring_type type,
 int ath11k_hal_srng_init(struct ath11k_base *ath11k);
 void ath11k_hal_srng_deinit(struct ath11k_base *ath11k);
 void ath11k_hal_dump_srng_stats(struct ath11k_base *ab);
-
+void ath11k_hal_srng_get_shadow_config(struct ath11k_base *ab,
+				       u32 **cfg, u32 *len);
+int ath11k_hal_srng_update_shadow_config(struct ath11k_base *ab,
+					 enum hal_ring_type ring_type,
+					int ring_num);
+void ath11k_hal_srng_shadow_config(struct ath11k_base *ab);
 #endif
diff --git a/drivers/net/wireless/ath/ath11k/hw.h b/drivers/net/wireless/ath/ath11k/hw.h
index a281ad3bdf04..8e908bcd491e 100644
--- a/drivers/net/wireless/ath/ath11k/hw.h
+++ b/drivers/net/wireless/ath/ath11k/hw.h
@@ -159,6 +159,7 @@ struct ath11k_hw_params {
 
 	u16 interface_modes;
 	bool supports_monitor;
+	bool supports_shadow_regs;
 };
 
 struct ath11k_hw_ops {
diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless/ath/ath11k/pci.c
index e72dca4fa577..d7eb6b7160bb 100644
--- a/drivers/net/wireless/ath/ath11k/pci.c
+++ b/drivers/net/wireless/ath/ath11k/pci.c
@@ -614,6 +614,9 @@ static void ath11k_pci_init_qmi_ce_config(struct ath11k_base *ab)
 	cfg->svc_to_ce_map = ab->hw_params.svc_to_ce_map;
 	cfg->svc_to_ce_map_len = ab->hw_params.svc_to_ce_map_len;
 	ab->qmi.service_ins_id = ATH11K_QMI_WLFW_SERVICE_INS_ID_V01_QCA6390;
+
+	ath11k_ce_get_shadow_config(ab, &cfg->shadow_reg_v2,
+				    &cfg->shadow_reg_v2_len);
 }
 
 static void ath11k_pci_ce_irqs_enable(struct ath11k_base *ab)
diff --git a/drivers/net/wireless/ath/ath11k/qmi.c b/drivers/net/wireless/ath/ath11k/qmi.c
index 9144f28b37d1..c2b165158225 100644
--- a/drivers/net/wireless/ath/ath11k/qmi.c
+++ b/drivers/net/wireless/ath/ath11k/qmi.c
@@ -2275,7 +2275,18 @@ static int ath11k_qmi_wlanfw_wlan_cfg_send(struct ath11k_base *ab)
 		req->svc_cfg[pipe_num].pipe_num = svc_cfg[pipe_num].pipenum;
 	}
 	req->shadow_reg_valid = 0;
-	req->shadow_reg_v2_valid = 0;
+
+	/* set shadow v2 configuration */
+	if (ab->hw_params.supports_shadow_regs) {
+		req->shadow_reg_v2_valid = 1;
+		req->shadow_reg_v2_len = min_t(u32,
+					       ab->qmi.ce_cfg.shadow_reg_v2_len,
+					       QMI_WLANFW_MAX_NUM_SHADOW_REG_V2_V01);
+		memcpy(&req->shadow_reg_v2, ab->qmi.ce_cfg.shadow_reg_v2,
+		       sizeof(u32) * req->shadow_reg_v2_len);
+	} else {
+		req->shadow_reg_v2_valid = 0;
+	}
 
 	ret = qmi_txn_init(&ab->qmi.handle, &txn,
 			   qmi_wlanfw_wlan_cfg_resp_msg_v01_ei, &resp);
diff --git a/drivers/net/wireless/ath/ath11k/qmi.h b/drivers/net/wireless/ath/ath11k/qmi.h
index 60e904683165..b0a818f0401b 100644
--- a/drivers/net/wireless/ath/ath11k/qmi.h
+++ b/drivers/net/wireless/ath/ath11k/qmi.h
@@ -77,7 +77,7 @@ struct ath11k_qmi_ce_cfg {
 	int svc_to_ce_map_len;
 	const u8 *shadow_reg;
 	int shadow_reg_len;
-	u8 *shadow_reg_v2;
+	u32 *shadow_reg_v2;
 	int shadow_reg_v2_len;
 };
 
-- 
2.7.4

