Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C37B7DDD65
	for <lists+linux-wireless@lfdr.de>; Sun, 20 Oct 2019 10:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbfJTI4G (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 20 Oct 2019 04:56:06 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:50818 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726115AbfJTI4G (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 20 Oct 2019 04:56:06 -0400
Received: from [91.156.6.193] (helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1iM70L-0003LY-0b; Sun, 20 Oct 2019 11:56:01 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sun, 20 Oct 2019 11:55:43 +0300
Message-Id: <20191020085545.16407-9-luca@coelho.fi>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191020085545.16407-1-luca@coelho.fi>
References: <20191020085545.16407-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: [PATCH 10/12] iwlwifi: remove IWL_DEVICE_22560/IWL_DEVICE_FAMILY_22560
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

This is dead code, nothing uses the IWL_DEVICE_22560 macro and
thus nothing every uses IWL_DEVICE_FAMILY_22560. Remove it all.

While at it, remove some code and definitions used only in this
case, and clean up some comments/names that still refer to it.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/cfg/22000.c    | 20 +------
 .../net/wireless/intel/iwlwifi/fw/api/tx.h    |  6 +--
 .../net/wireless/intel/iwlwifi/iwl-config.h   |  1 -
 drivers/net/wireless/intel/iwlwifi/iwl-csr.h  |  2 -
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c  |  2 +-
 drivers/net/wireless/intel/iwlwifi/iwl-fh.h   |  2 +-
 .../net/wireless/intel/iwlwifi/mvm/debugfs.c  |  2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |  6 +--
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c |  4 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c   |  2 +-
 .../wireless/intel/iwlwifi/pcie/internal.h    |  4 +-
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c  | 53 ++++++-------------
 .../wireless/intel/iwlwifi/pcie/trans-gen2.c  |  4 +-
 .../net/wireless/intel/iwlwifi/pcie/trans.c   | 29 ++--------
 .../net/wireless/intel/iwlwifi/pcie/tx-gen2.c | 12 ++---
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c  |  2 +-
 16 files changed, 45 insertions(+), 106 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
index 9ebb3376ffb9..37bcf157f0bb 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
@@ -138,7 +138,7 @@ static const struct iwl_base_params iwl_22000_base_params = {
 	.pcie_l1_allowed = true,
 };
 
-static const struct iwl_base_params iwl_22560_base_params = {
+static const struct iwl_base_params iwl_ax210_base_params = {
 	.eeprom_size = OTP_LOW_IMAGE_SIZE_32K,
 	.num_of_queues = 512,
 	.max_tfd_queue_size = 65536,
@@ -212,27 +212,11 @@ static const struct iwl_ht_params iwl_22000_ht_params = {
 		},							\
 	}
 
-#define IWL_DEVICE_22560						\
-	IWL_DEVICE_22000_COMMON,					\
-	.trans.device_family = IWL_DEVICE_FAMILY_22560,			\
-	.trans.base_params = &iwl_22560_base_params,			\
-	.trans.csr = &iwl_csr_v2,					\
-	.mon_dram_regs = {						\
-		.write_ptr = {						\
-			.addr = MON_BUFF_WRPTR_VER2,			\
-			.mask = 0xffffffff,				\
-		},							\
-		.cycle_cnt = {						\
-			.addr = MON_BUFF_CYCLE_CNT_VER2,		\
-			.mask = 0xffffffff,				\
-		},							\
-	}
-
 #define IWL_DEVICE_AX210						\
 	IWL_DEVICE_22000_COMMON,					\
 	.trans.umac_prph_offset = 0x300000,				\
 	.trans.device_family = IWL_DEVICE_FAMILY_AX210,			\
-	.trans.base_params = &iwl_22560_base_params,			\
+	.trans.base_params = &iwl_ax210_base_params,			\
 	.trans.csr = &iwl_csr_v1,					\
 	.min_txq_size = 128,						\
 	.gp2_reg_addr = 0xd02c68,					\
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/tx.h b/drivers/net/wireless/intel/iwlwifi/fw/api/tx.h
index 8511e735c374..f89a9e16a8c0 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/tx.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/tx.h
@@ -7,7 +7,7 @@
  *
  * Copyright(c) 2012 - 2014 Intel Corporation. All rights reserved.
  * Copyright(c) 2016 - 2017 Intel Deutschland GmbH
- * Copyright(c) 2018 Intel Corporation
+ * Copyright(c) 2018 - 2019 Intel Corporation
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of version 2 of the GNU General Public License as
@@ -29,7 +29,7 @@
  *
  * Copyright(c) 2012 - 2014 Intel Corporation. All rights reserved.
  * Copyright(c) 2016 - 2017 Intel Deutschland GmbH
- * Copyright(c) 2018 Intel Corporation
+ * Copyright(c) 2018 - 2019 Intel Corporation
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
@@ -323,7 +323,7 @@ struct iwl_tx_cmd_gen2 {
 } __packed; /* TX_CMD_API_S_VER_7 */
 
 /**
- * struct iwl_tx_cmd_gen3 - TX command struct to FW for 22560 devices
+ * struct iwl_tx_cmd_gen3 - TX command struct to FW for AX210+ devices
  * ( TX_CMD = 0x1c )
  * @len: in bytes of the payload, see below for details
  * @flags: combination of &enum iwl_tx_cmd_flags
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index 1b027a138b6b..59bb960b460a 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -88,7 +88,6 @@ enum iwl_device_family {
 	IWL_DEVICE_FAMILY_8000,
 	IWL_DEVICE_FAMILY_9000,
 	IWL_DEVICE_FAMILY_22000,
-	IWL_DEVICE_FAMILY_22560,
 	IWL_DEVICE_FAMILY_AX210,
 };
 
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-csr.h b/drivers/net/wireless/intel/iwlwifi/iwl-csr.h
index cb4c5514a556..61efb3cbfdf7 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-csr.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-csr.h
@@ -602,9 +602,7 @@ enum msix_fh_int_causes {
 enum msix_hw_int_causes {
 	MSIX_HW_INT_CAUSES_REG_ALIVE		= BIT(0),
 	MSIX_HW_INT_CAUSES_REG_WAKEUP		= BIT(1),
-	MSIX_HW_INT_CAUSES_REG_IPC		= BIT(1),
 	MSIX_HW_INT_CAUSES_REG_IML              = BIT(2),
-	MSIX_HW_INT_CAUSES_REG_SW_ERR_V2	= BIT(5),
 	MSIX_HW_INT_CAUSES_REG_CT_KILL		= BIT(6),
 	MSIX_HW_INT_CAUSES_REG_RF_KILL		= BIT(7),
 	MSIX_HW_INT_CAUSES_REG_PERIODIC		= BIT(8),
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
index b0881e713b48..4096ccf58b07 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
@@ -1804,7 +1804,7 @@ MODULE_PARM_DESC(11n_disable,
 	"disable 11n functionality, bitmap: 1: full, 2: disable agg TX, 4: disable agg RX, 8 enable agg TX");
 module_param_named(amsdu_size, iwlwifi_mod_params.amsdu_size, int, 0444);
 MODULE_PARM_DESC(amsdu_size,
-		 "amsdu size 0: 12K for multi Rx queue devices, 2K for 22560 devices, "
+		 "amsdu size 0: 12K for multi Rx queue devices, 2K for AX210 devices, "
 		 "4K for other devices 1:4K 2:8K 3:12K 4: 2K (default 0)");
 module_param_named(fw_restart, iwlwifi_mod_params.fw_restart, bool, 0444);
 MODULE_PARM_DESC(fw_restart, "restart firmware in case of error (default true)");
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-fh.h b/drivers/net/wireless/intel/iwlwifi/iwl-fh.h
index 0c12df558240..07162795287e 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-fh.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-fh.h
@@ -768,7 +768,7 @@ struct iwlagn_scd_bc_tbl {
 
 /**
  * struct iwl_gen3_bc_tbl scheduler byte count table gen3
- * For 22560 and on:
+ * For AX210 and on:
  * @tfd_offset: 0-12 - tx command byte count
  *		12-13 - number of 64 byte chunks
  *		14-16 - reserved
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
index 9970f61b9f9f..aa659162a7c2 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
@@ -1175,7 +1175,7 @@ static ssize_t iwl_dbgfs_inject_packet_write(struct iwl_mvm *mvm,
 	int bin_len = count / 2;
 	int ret = -EINVAL;
 	size_t mpdu_cmd_hdr_size = (mvm->trans->trans_cfg->device_family >=
-				    IWL_DEVICE_FAMILY_22560) ?
+				    IWL_DEVICE_FAMILY_AX210) ?
 		sizeof(struct iwl_rx_mpdu_desc) :
 		IWL_RX_DESC_SIZE_V1;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index dcdc195ac1d6..3b0637311e3c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -692,7 +692,7 @@ iwl_op_mode_mvm_start(struct iwl_trans *trans, const struct iwl_cfg *cfg,
 		op_mode->ops = &iwl_mvm_ops_mq;
 		trans->rx_mpdu_cmd_hdr_size =
 			(trans->trans_cfg->device_family >=
-			 IWL_DEVICE_FAMILY_22560) ?
+			 IWL_DEVICE_FAMILY_AX210) ?
 			sizeof(struct iwl_rx_mpdu_desc) :
 			IWL_RX_DESC_SIZE_V1;
 	} else {
@@ -761,7 +761,7 @@ iwl_op_mode_mvm_start(struct iwl_trans *trans, const struct iwl_cfg *cfg,
 	trans_cfg.no_reclaim_cmds = no_reclaim_cmds;
 	trans_cfg.n_no_reclaim_cmds = ARRAY_SIZE(no_reclaim_cmds);
 
-	if (mvm->trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_22560)
+	if (mvm->trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_AX210)
 		rb_size_default = IWL_AMSDU_2K;
 	else
 		rb_size_default = IWL_AMSDU_4K;
@@ -787,7 +787,7 @@ iwl_op_mode_mvm_start(struct iwl_trans *trans, const struct iwl_cfg *cfg,
 
 	trans->wide_cmd_header = true;
 	trans_cfg.bc_table_dword =
-		mvm->trans->trans_cfg->device_family < IWL_DEVICE_FAMILY_22560;
+		mvm->trans->trans_cfg->device_family < IWL_DEVICE_FAMILY_AX210;
 
 	trans_cfg.command_groups = iwl_mvm_groups;
 	trans_cfg.command_groups_size = ARRAY_SIZE(iwl_mvm_groups);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
index b488cd702058..75a7af5ad7b2 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
@@ -1578,7 +1578,7 @@ void iwl_mvm_rx_mpdu_mq(struct iwl_mvm *mvm, struct napi_struct *napi,
 	if (unlikely(test_bit(IWL_MVM_STATUS_IN_HW_RESTART, &mvm->status)))
 		return;
 
-	if (mvm->trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_22560) {
+	if (mvm->trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_AX210) {
 		rate_n_flags = le32_to_cpu(desc->v3.rate_n_flags);
 		channel = desc->v3.channel;
 		gp2_on_air_rise = le32_to_cpu(desc->v3.gp2_on_air_rise);
@@ -1680,7 +1680,7 @@ void iwl_mvm_rx_mpdu_mq(struct iwl_mvm *mvm, struct napi_struct *napi,
 		u64 tsf_on_air_rise;
 
 		if (mvm->trans->trans_cfg->device_family >=
-		    IWL_DEVICE_FAMILY_22560)
+		    IWL_DEVICE_FAMILY_AX210)
 			tsf_on_air_rise = le64_to_cpu(desc->v3.tsf_on_air_rise);
 		else
 			tsf_on_air_rise = le64_to_cpu(desc->v1.tsf_on_air_rise);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
index 81a88a89ea74..dc5c02fbc65a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
@@ -550,7 +550,7 @@ iwl_mvm_set_tx_params(struct iwl_mvm *mvm, struct sk_buff *skb,
 		}
 
 		if (mvm->trans->trans_cfg->device_family >=
-		    IWL_DEVICE_FAMILY_22560) {
+		    IWL_DEVICE_FAMILY_AX210) {
 			struct iwl_tx_cmd_gen3 *cmd = (void *)dev_cmd->payload;
 
 			cmd->offload_assist |= cpu_to_le32(offload_assist);
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
index fcef2806ebb1..3da2c7e38ffa 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
@@ -166,7 +166,7 @@ struct iwl_rx_completion_desc {
  * @id: queue index
  * @bd: driver's pointer to buffer of receive buffer descriptors (rbd).
  *	Address size is 32 bit in pre-9000 devices and 64 bit in 9000 devices.
- *	In 22560 devices it is a pointer to a list of iwl_rx_transfer_desc's
+ *	In AX210 devices it is a pointer to a list of iwl_rx_transfer_desc's
  * @bd_dma: bus address of buffer of receive buffer descriptors (rbd)
  * @ubd: driver's pointer to buffer of used receive buffer descriptors (rbd)
  * @ubd_dma: physical address of buffer of used receive buffer descriptors (rbd)
@@ -264,7 +264,7 @@ static inline int iwl_queue_inc_wrap(struct iwl_trans *trans, int index)
 static inline __le16 iwl_get_closed_rb_stts(struct iwl_trans *trans,
 					    struct iwl_rxq *rxq)
 {
-	if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_22560) {
+	if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_AX210) {
 		__le16 *rb_stts = rxq->rb_stts;
 
 		return READ_ONCE(*rb_stts);
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
index 19dd075f2f63..4bba6b8a863c 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
@@ -200,8 +200,8 @@ static inline __le32 iwl_pcie_dma_addr2rbd_ptr(dma_addr_t dma_addr)
  */
 int iwl_pcie_rx_stop(struct iwl_trans *trans)
 {
-	if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_22560) {
-		/* TODO: remove this for 22560 once fw does it */
+	if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_AX210) {
+		/* TODO: remove this once fw does it */
 		iwl_write_umac_prph(trans, RFH_RXF_DMA_CFG_GEN3, 0);
 		return iwl_poll_umac_prph_bit(trans, RFH_GEN_STATUS_GEN3,
 					      RXF_DMA_IDLE, RXF_DMA_IDLE, 1000);
@@ -247,11 +247,7 @@ static void iwl_pcie_rxq_inc_wr_ptr(struct iwl_trans *trans,
 	}
 
 	rxq->write_actual = round_down(rxq->write, 8);
-	if (trans->trans_cfg->device_family == IWL_DEVICE_FAMILY_22560)
-		iwl_write32(trans, HBUS_TARG_WRPTR,
-			    (rxq->write_actual |
-			     ((FIRST_RX_QUEUE + rxq->id) << 16)));
-	else if (trans->trans_cfg->mq_rx_supported)
+	if (trans->trans_cfg->mq_rx_supported)
 		iwl_write32(trans, RFH_Q_FRBDCB_WIDX_TRG(rxq->id),
 			    rxq->write_actual);
 	else
@@ -279,7 +275,7 @@ static void iwl_pcie_restock_bd(struct iwl_trans *trans,
 				struct iwl_rxq *rxq,
 				struct iwl_rx_mem_buffer *rxb)
 {
-	if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_22560) {
+	if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_AX210) {
 		struct iwl_rx_transfer_desc *bd = rxq->bd;
 
 		BUILD_BUG_ON(sizeof(*bd) != 2 * sizeof(u64));
@@ -691,7 +687,7 @@ static void iwl_pcie_free_rxq_dma(struct iwl_trans *trans,
 {
 	struct device *dev = trans->dev;
 	bool use_rx_td = (trans->trans_cfg->device_family >=
-			  IWL_DEVICE_FAMILY_22560);
+			  IWL_DEVICE_FAMILY_AX210);
 	int free_size = iwl_pcie_free_bd_size(trans, use_rx_td);
 
 	if (rxq->bd)
@@ -712,7 +708,7 @@ static void iwl_pcie_free_rxq_dma(struct iwl_trans *trans,
 	rxq->used_bd_dma = 0;
 	rxq->used_bd = NULL;
 
-	if (trans->trans_cfg->device_family < IWL_DEVICE_FAMILY_22560)
+	if (trans->trans_cfg->device_family < IWL_DEVICE_FAMILY_AX210)
 		return;
 
 	if (rxq->tr_tail)
@@ -736,7 +732,7 @@ static int iwl_pcie_alloc_rxq_dma(struct iwl_trans *trans,
 	int i;
 	int free_size;
 	bool use_rx_td = (trans->trans_cfg->device_family >=
-			  IWL_DEVICE_FAMILY_22560);
+			  IWL_DEVICE_FAMILY_AX210);
 	size_t rb_stts_size = use_rx_td ? sizeof(__le16) :
 			      sizeof(struct iwl_rb_status);
 
@@ -784,11 +780,6 @@ static int iwl_pcie_alloc_rxq_dma(struct iwl_trans *trans,
 					  &rxq->cr_tail_dma, GFP_KERNEL);
 	if (!rxq->cr_tail)
 		goto err;
-	/*
-	 * W/A 22560 device step Z0 must be non zero bug
-	 * TODO: remove this when stop supporting Z0
-	 */
-	*rxq->cr_tail = cpu_to_le16(500);
 
 	return 0;
 
@@ -808,7 +799,7 @@ int iwl_pcie_rx_alloc(struct iwl_trans *trans)
 	struct iwl_rb_allocator *rba = &trans_pcie->rba;
 	int i, ret;
 	size_t rb_stts_size = trans->trans_cfg->device_family >=
-			      IWL_DEVICE_FAMILY_22560 ?
+				IWL_DEVICE_FAMILY_AX210 ?
 			      sizeof(__le16) : sizeof(struct iwl_rb_status);
 
 	if (WARN_ON(trans_pcie->rxq))
@@ -1074,8 +1065,9 @@ int _iwl_pcie_rx_init(struct iwl_trans *trans)
 		rxq->read = 0;
 		rxq->write = 0;
 		rxq->write_actual = 0;
-		memset(rxq->rb_stts, 0, (trans->trans_cfg->device_family >=
-					 IWL_DEVICE_FAMILY_22560) ?
+		memset(rxq->rb_stts, 0,
+		       (trans->trans_cfg->device_family >=
+			IWL_DEVICE_FAMILY_AX210) ?
 		       sizeof(__le16) : sizeof(struct iwl_rb_status));
 
 		iwl_pcie_rx_init_rxb_lists(rxq);
@@ -1152,7 +1144,7 @@ void iwl_pcie_rx_free(struct iwl_trans *trans)
 	struct iwl_rb_allocator *rba = &trans_pcie->rba;
 	int i;
 	size_t rb_stts_size = trans->trans_cfg->device_family >=
-			      IWL_DEVICE_FAMILY_22560 ?
+				IWL_DEVICE_FAMILY_AX210 ?
 			      sizeof(__le16) : sizeof(struct iwl_rb_status);
 
 	/*
@@ -1347,7 +1339,7 @@ static void iwl_pcie_rx_handle_rb(struct iwl_trans *trans,
 		}
 
 		page_stolen |= rxcb._page_stolen;
-		if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_22560)
+		if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_AX210)
 			break;
 		offset += ALIGN(len, FH_RSCSR_FRAME_ALIGN);
 	}
@@ -1399,7 +1391,7 @@ static struct iwl_rx_mem_buffer *iwl_pcie_get_rxb(struct iwl_trans *trans,
 	}
 
 	/* used_bd is a 32/16 bit but only 12 are used to retrieve the vid */
-	if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_22560)
+	if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_AX210)
 		vid = le16_to_cpu(rxq->cd[i].rbid) & 0x0FFF;
 	else
 		vid = le32_to_cpu(rxq->bd_32[i]) & 0x0FFF;
@@ -1515,7 +1507,7 @@ static void iwl_pcie_rx_handle(struct iwl_trans *trans, int queue)
 	/* Backtrack one entry */
 	rxq->read = i;
 	/* update cr tail with the rxq read pointer */
-	if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_22560)
+	if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_AX210)
 		*rxq->cr_tail = cpu_to_le16(r);
 	spin_unlock(&rxq->lock);
 
@@ -2152,8 +2144,7 @@ irqreturn_t iwl_pcie_irq_msix_handler(int irq, void *dev_id)
 
 	/* Error detected by uCode */
 	if ((inta_fh & MSIX_FH_INT_CAUSES_FH_ERR) ||
-	    (inta_hw & MSIX_HW_INT_CAUSES_REG_SW_ERR) ||
-	    (inta_hw & MSIX_HW_INT_CAUSES_REG_SW_ERR_V2)) {
+	    (inta_hw & MSIX_HW_INT_CAUSES_REG_SW_ERR)) {
 		IWL_ERR(trans,
 			"Microcode SW error detected. Restarting 0x%X.\n",
 			inta_fh);
@@ -2185,17 +2176,7 @@ irqreturn_t iwl_pcie_irq_msix_handler(int irq, void *dev_id)
 		}
 	}
 
-	if (trans->trans_cfg->device_family == IWL_DEVICE_FAMILY_22560 &&
-	    inta_hw & MSIX_HW_INT_CAUSES_REG_IPC) {
-		/* Reflect IML transfer status */
-		int res = iwl_read32(trans, CSR_IML_RESP_ADDR);
-
-		IWL_DEBUG_ISR(trans, "IML transfer status: %d\n", res);
-		if (res == IWL_IMAGE_RESP_FAIL) {
-			isr_stats->sw++;
-			iwl_pcie_irq_handle_error(trans);
-		}
-	} else if (inta_hw & MSIX_HW_INT_CAUSES_REG_WAKEUP) {
+	if (inta_hw & MSIX_HW_INT_CAUSES_REG_WAKEUP) {
 		u32 sleep_notif =
 			le32_to_cpu(trans_pcie->prph_info->sleep_notif);
 		if (sleep_notif == IWL_D3_SLEEP_STATUS_SUSPEND ||
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
index df8455f14e4d..0d8b2a8ffa5d 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
@@ -168,7 +168,7 @@ void _iwl_trans_pcie_gen2_stop_device(struct iwl_trans *trans)
 	}
 
 	iwl_pcie_ctxt_info_free_paging(trans);
-	if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_22560)
+	if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_AX210)
 		iwl_pcie_ctxt_info_gen3_free(trans);
 	else
 		iwl_pcie_ctxt_info_free(trans);
@@ -340,7 +340,7 @@ int iwl_trans_pcie_gen2_start_fw(struct iwl_trans *trans,
 		goto out;
 	}
 
-	if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_22560)
+	if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_AX210)
 		ret = iwl_pcie_ctxt_info_gen3_init(trans, fw);
 	else
 		ret = iwl_pcie_ctxt_info_init(trans, fw);
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index dc02584dcd68..bdd0a6fe6fda 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -1135,30 +1135,12 @@ static struct iwl_causes_list causes_list[] = {
 	{MSIX_HW_INT_CAUSES_REG_HAP,		CSR_MSIX_HW_INT_MASK_AD, 0x2E},
 };
 
-static struct iwl_causes_list causes_list_v2[] = {
-	{MSIX_FH_INT_CAUSES_D2S_CH0_NUM,	CSR_MSIX_FH_INT_MASK_AD, 0},
-	{MSIX_FH_INT_CAUSES_D2S_CH1_NUM,	CSR_MSIX_FH_INT_MASK_AD, 0x1},
-	{MSIX_FH_INT_CAUSES_S2D,		CSR_MSIX_FH_INT_MASK_AD, 0x3},
-	{MSIX_FH_INT_CAUSES_FH_ERR,		CSR_MSIX_FH_INT_MASK_AD, 0x5},
-	{MSIX_HW_INT_CAUSES_REG_ALIVE,		CSR_MSIX_HW_INT_MASK_AD, 0x10},
-	{MSIX_HW_INT_CAUSES_REG_IPC,		CSR_MSIX_HW_INT_MASK_AD, 0x11},
-	{MSIX_HW_INT_CAUSES_REG_SW_ERR_V2,	CSR_MSIX_HW_INT_MASK_AD, 0x15},
-	{MSIX_HW_INT_CAUSES_REG_CT_KILL,	CSR_MSIX_HW_INT_MASK_AD, 0x16},
-	{MSIX_HW_INT_CAUSES_REG_RF_KILL,	CSR_MSIX_HW_INT_MASK_AD, 0x17},
-	{MSIX_HW_INT_CAUSES_REG_PERIODIC,	CSR_MSIX_HW_INT_MASK_AD, 0x18},
-	{MSIX_HW_INT_CAUSES_REG_SCD,		CSR_MSIX_HW_INT_MASK_AD, 0x2A},
-	{MSIX_HW_INT_CAUSES_REG_FH_TX,		CSR_MSIX_HW_INT_MASK_AD, 0x2B},
-	{MSIX_HW_INT_CAUSES_REG_HW_ERR,		CSR_MSIX_HW_INT_MASK_AD, 0x2D},
-	{MSIX_HW_INT_CAUSES_REG_HAP,		CSR_MSIX_HW_INT_MASK_AD, 0x2E},
-};
-
 static void iwl_pcie_map_non_rx_causes(struct iwl_trans *trans)
 {
 	struct iwl_trans_pcie *trans_pcie =  IWL_TRANS_GET_PCIE_TRANS(trans);
 	int val = trans_pcie->def_irq | MSIX_NON_AUTO_CLEAR_CAUSE;
-	int i, arr_size =
-		(trans->trans_cfg->device_family != IWL_DEVICE_FAMILY_22560) ?
-		ARRAY_SIZE(causes_list) : ARRAY_SIZE(causes_list_v2);
+	int i, arr_size = ARRAY_SIZE(causes_list);
+	struct iwl_causes_list *causes = causes_list;
 
 	/*
 	 * Access all non RX causes and map them to the default irq.
@@ -1166,11 +1148,6 @@ static void iwl_pcie_map_non_rx_causes(struct iwl_trans *trans)
 	 * the first interrupt vector will serve non-RX and FBQ causes.
 	 */
 	for (i = 0; i < arr_size; i++) {
-		struct iwl_causes_list *causes =
-			(trans->trans_cfg->device_family !=
-			 IWL_DEVICE_FAMILY_22560) ?
-			causes_list : causes_list_v2;
-
 		iwl_write8(trans, CSR_MSIX_IVAR(causes[i].addr), val);
 		iwl_clear_bit(trans, causes[i].mask_reg,
 			      causes[i].cause_num);
@@ -1894,7 +1871,7 @@ static u32 iwl_trans_pcie_read32(struct iwl_trans *trans, u32 ofs)
 
 static u32 iwl_trans_pcie_prph_msk(struct iwl_trans *trans)
 {
-	if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_22560)
+	if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_AX210)
 		return 0x00FFFFFF;
 	else
 		return 0x000FFFFF;
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c b/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
index 1c69a2ddd7c7..4c9c78d1ba98 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
@@ -113,14 +113,14 @@ static void iwl_pcie_gen2_update_byte_tbl(struct iwl_trans_pcie *trans_pcie,
 	 */
 	num_fetch_chunks = DIV_ROUND_UP(filled_tfd_size, 64) - 1;
 
-	if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_22560) {
-		/* Starting from 22560, the HW expects bytes */
+	if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_AX210) {
+		/* Starting from AX210, the HW expects bytes */
 		WARN_ON(trans_pcie->bc_table_dword);
 		WARN_ON(len > 0x3FFF);
 		bc_ent = cpu_to_le16(len | (num_fetch_chunks << 14));
 		scd_bc_tbl_gen3->tfd_offset[idx] = bc_ent;
 	} else {
-		/* Until 22560, the HW expects DW */
+		/* Before AX210, the HW expects DW */
 		WARN_ON(!trans_pcie->bc_table_dword);
 		len = DIV_ROUND_UP(len, 4);
 		WARN_ON(len > 0xFFF);
@@ -547,7 +547,7 @@ struct iwl_tfh_tfd *iwl_pcie_gen2_build_tfd(struct iwl_trans *trans,
 
 	memset(tfd, 0, sizeof(*tfd));
 
-	if (trans->trans_cfg->device_family < IWL_DEVICE_FAMILY_22560)
+	if (trans->trans_cfg->device_family < IWL_DEVICE_FAMILY_AX210)
 		len = sizeof(struct iwl_tx_cmd_gen2);
 	else
 		len = sizeof(struct iwl_tx_cmd_gen3);
@@ -629,7 +629,7 @@ int iwl_trans_pcie_gen2_tx(struct iwl_trans *trans, struct sk_buff *skb,
 		return -1;
 	}
 
-	if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_22560) {
+	if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_AX210) {
 		struct iwl_tx_cmd_gen3 *tx_cmd_gen3 =
 			(void *)dev_cmd->payload;
 
@@ -1130,7 +1130,7 @@ int iwl_trans_pcie_dyn_txq_alloc_dma(struct iwl_trans *trans,
 		return -ENOMEM;
 	ret = iwl_pcie_alloc_dma_ptr(trans, &txq->bc_tbl,
 				     (trans->trans_cfg->device_family >=
-				      IWL_DEVICE_FAMILY_22560) ?
+				      IWL_DEVICE_FAMILY_AX210) ?
 				     sizeof(struct iwl_gen3_bc_tbl) :
 				     sizeof(struct iwlagn_scd_bc_tbl));
 	if (ret) {
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
index 4806a04cec8c..b710b8a25b54 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
@@ -949,7 +949,7 @@ static int iwl_pcie_tx_alloc(struct iwl_trans *trans)
 	u16 bc_tbls_size = trans->trans_cfg->base_params->num_of_queues;
 
 	bc_tbls_size *= (trans->trans_cfg->device_family >=
-			 IWL_DEVICE_FAMILY_22560) ?
+			 IWL_DEVICE_FAMILY_AX210) ?
 		sizeof(struct iwl_gen3_bc_tbl) :
 		sizeof(struct iwlagn_scd_bc_tbl);
 
-- 
2.23.0

