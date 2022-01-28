Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89F0749FAD1
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Jan 2022 14:34:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348956AbiA1Neu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Jan 2022 08:34:50 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:37860 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1348934AbiA1Net (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Jan 2022 08:34:49 -0500
Received: from 91-155-254-253.elisa-laajakaista.fi ([91.155.254.253] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <luca@coelho.fi>)
        id 1nDROo-0002DK-OW;
        Fri, 28 Jan 2022 15:34:47 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@kernel.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Fri, 28 Jan 2022 15:34:30 +0200
Message-Id: <iwlwifi.20220128153014.16b43fe3e92f.I853c57648feee4b69ccb01ef4c75354377d60be2@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220128133433.591765-1-luca@coelho.fi>
References: <20220128133433.591765-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 10/13] iwlwifi: cfg: add support for 1K BA queue
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Mordechay Goodstein <mordechay.goodstein@intel.com>

In order to support 1K aggregations start ba queue with at least double
the size, also allocate based on the connecting type to save memory
usage.

Signed-off-by: Mordechay Goodstein <mordechay.goodstein@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/cfg/22000.c    |  5 ++--
 .../net/wireless/intel/iwlwifi/fw/api/txq.h   |  4 ++-
 .../net/wireless/intel/iwlwifi/iwl-config.h   |  6 ++---
 drivers/net/wireless/intel/iwlwifi/iwl-fh.h   | 11 ++++----
 .../net/wireless/intel/iwlwifi/iwl-trans.c    |  8 ++++--
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c  | 26 +++++++++++++++++--
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c  |  4 +--
 drivers/net/wireless/intel/iwlwifi/queue/tx.c |  4 +--
 8 files changed, 49 insertions(+), 19 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
index 330ef04ca51a..7fb209ec442d 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
@@ -7,6 +7,7 @@
 #include <linux/stringify.h>
 #include "iwl-config.h"
 #include "iwl-prph.h"
+#include "fw/api/txq.h"
 
 /* Highest firmware API version supported */
 #define IWL_22000_UCODE_API_MAX	69
@@ -224,7 +225,7 @@ static const struct iwl_ht_params iwl_22000_ht_params = {
 	.trans.base_params = &iwl_ax210_base_params,			\
 	.min_txq_size = 128,						\
 	.gp2_reg_addr = 0xd02c68,					\
-	.min_256_ba_txq_size = 1024,					\
+	.min_ba_txq_size = IWL_DEFAULT_QUEUE_SIZE_HE,		\
 	.mon_dram_regs = {						\
 		.write_ptr = {						\
 			.addr = DBGC_CUR_DBGBUF_STATUS,			\
@@ -285,7 +286,7 @@ static const struct iwl_ht_params iwl_22000_ht_params = {
 	.trans.base_params = &iwl_ax210_base_params,			\
 	.min_txq_size = 128,						\
 	.gp2_reg_addr = 0xd02c68,					\
-	.min_256_ba_txq_size = 1024,					\
+	.min_ba_txq_size = IWL_DEFAULT_QUEUE_SIZE_EHT,		\
 	.mon_dram_regs = {						\
 		.write_ptr = {						\
 			.addr = DBGC_CUR_DBGBUF_STATUS,			\
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/txq.h b/drivers/net/wireless/intel/iwlwifi/fw/api/txq.h
index 8b3a00df41da..e018946310d1 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/txq.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/txq.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2005-2014, 2019-2020 Intel Corporation
+ * Copyright (C) 2005-2014, 2019-2021 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -76,6 +76,8 @@ enum iwl_tx_queue_cfg_actions {
 	TX_QUEUE_CFG_TFD_SHORT_FORMAT		= BIT(1),
 };
 
+#define IWL_DEFAULT_QUEUE_SIZE_EHT (1024 * 4)
+#define IWL_DEFAULT_QUEUE_SIZE_HE 1024
 #define IWL_DEFAULT_QUEUE_SIZE 256
 #define IWL_MGMT_QUEUE_SIZE 16
 #define IWL_CMD_QUEUE_SIZE 32
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index e122b8b4e1fc..f46ec44da1eb 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -343,8 +343,8 @@ struct iwl_fw_mon_regs {
  * @bisr_workaround: BISR hardware workaround (for 22260 series devices)
  * @min_txq_size: minimum number of slots required in a TX queue
  * @uhb_supported: ultra high band channels supported
- * @min_256_ba_txq_size: minimum number of slots required in a TX queue which
- *	supports 256 BA aggregation
+ * @min_ba_txq_size: minimum number of slots required in a TX queue which
+ *	based on hardware support (HE - 256, EHT - 1K).
  * @num_rbds: number of receive buffer descriptors to use
  *	(only used for multi-queue capable devices)
  * @mac_addr_csr_base: CSR base register for MAC address access, if not set
@@ -405,7 +405,7 @@ struct iwl_cfg {
 	u32 d3_debug_data_length;
 	u32 min_txq_size;
 	u32 gp2_reg_addr;
-	u32 min_256_ba_txq_size;
+	u32 min_ba_txq_size;
 	const struct iwl_fw_mon_regs mon_dram_regs;
 	const struct iwl_fw_mon_regs mon_smem_regs;
 };
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-fh.h b/drivers/net/wireless/intel/iwlwifi/iwl-fh.h
index e6fd4941a4cb..5558f9925e11 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-fh.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-fh.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2005-2014, 2018-2020 Intel Corporation
+ * Copyright (C) 2005-2014, 2018-2021 Intel Corporation
  * Copyright (C) 2015-2017 Intel Deutschland GmbH
  */
 #ifndef __iwl_fh_h__
@@ -590,7 +590,8 @@ struct iwl_rb_status {
 #define TFD_QUEUE_CB_SIZE(x)	(ilog2(x) - 3)
 #define TFD_QUEUE_SIZE_BC_DUP	(64)
 #define TFD_QUEUE_BC_SIZE	(TFD_QUEUE_SIZE_MAX + TFD_QUEUE_SIZE_BC_DUP)
-#define TFD_QUEUE_BC_SIZE_GEN3	1024
+#define TFD_QUEUE_BC_SIZE_GEN3_AX210	1024
+#define TFD_QUEUE_BC_SIZE_GEN3_BZ	(1024 * 4)
 #define IWL_TX_DMA_MASK        DMA_BIT_MASK(36)
 #define IWL_NUM_OF_TBS		20
 #define IWL_TFH_NUM_TBS		25
@@ -707,14 +708,14 @@ struct iwlagn_scd_bc_tbl {
 } __packed;
 
 /**
- * struct iwl_gen3_bc_tbl scheduler byte count table gen3
+ * struct iwl_gen3_bc_tbl_entry scheduler byte count table entry gen3
  * For AX210 and on:
  * @tfd_offset: 0-12 - tx command byte count
  *		12-13 - number of 64 byte chunks
  *		14-16 - reserved
  */
-struct iwl_gen3_bc_tbl {
-	__le16 tfd_offset[TFD_QUEUE_BC_SIZE_GEN3];
+struct iwl_gen3_bc_tbl_entry {
+	__le16 tfd_offset;
 } __packed;
 
 #endif /* !__iwl_fh_h__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.c b/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
index a522bd97bc04..b1af9359cea5 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
@@ -78,8 +78,12 @@ int iwl_trans_init(struct iwl_trans *trans)
 	if (WARN_ON(trans->trans_cfg->gen2 && txcmd_size >= txcmd_align))
 		return -EINVAL;
 
-	if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_AX210)
-		trans->txqs.bc_tbl_size = sizeof(struct iwl_gen3_bc_tbl);
+	if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_BZ)
+		trans->txqs.bc_tbl_size =
+			sizeof(struct iwl_gen3_bc_tbl_entry) * TFD_QUEUE_BC_SIZE_GEN3_BZ;
+	else if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_AX210)
+		trans->txqs.bc_tbl_size =
+			sizeof(struct iwl_gen3_bc_tbl_entry) * TFD_QUEUE_BC_SIZE_GEN3_AX210;
 	else
 		trans->txqs.bc_tbl_size = sizeof(struct iwlagn_scd_bc_tbl);
 	/*
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
index 1e08b7ffb79a..ea3be00d5d1e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
@@ -716,15 +716,37 @@ static int iwl_mvm_find_free_queue(struct iwl_mvm *mvm, u8 sta_id,
 static int iwl_mvm_tvqm_enable_txq(struct iwl_mvm *mvm,
 				   u8 sta_id, u8 tid, unsigned int timeout)
 {
-	int queue, size = max_t(u32, IWL_DEFAULT_QUEUE_SIZE,
-				mvm->trans->cfg->min_256_ba_txq_size);
+	int queue, size;
 
 	if (tid == IWL_MAX_TID_COUNT) {
 		tid = IWL_MGMT_TID;
 		size = max_t(u32, IWL_MGMT_QUEUE_SIZE,
 			     mvm->trans->cfg->min_txq_size);
+	} else {
+		struct ieee80211_sta *sta;
+
+		rcu_read_lock();
+		sta = rcu_dereference(mvm->fw_id_to_mac_id[sta_id]);
+
+		/* this queue isn't used for traffic (cab_queue) */
+		if (IS_ERR_OR_NULL(sta)) {
+			size = IWL_MGMT_QUEUE_SIZE;
+		} else if (sta->he_cap.has_he) {
+			/* support for 256 ba size */
+			size = IWL_DEFAULT_QUEUE_SIZE_HE;
+		} else {
+			size = IWL_DEFAULT_QUEUE_SIZE;
+		}
+
+		rcu_read_unlock();
 	}
 
+	/* take the min with bc tbl entries allowed */
+	size = min_t(u32, size, mvm->trans->txqs.bc_tbl_size / sizeof(u16));
+
+	/* size needs to be power of 2 values for calculating read/write pointers */
+	size = rounddown_pow_of_two(size);
+
 	do {
 		__le16 enable = cpu_to_le16(TX_QUEUE_CFG_ENABLE_QUEUE);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
index e3b69476f515..3546c5269c3b 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
@@ -540,7 +540,7 @@ static int iwl_pcie_tx_alloc(struct iwl_trans *trans)
 					  trans->cfg->min_txq_size);
 		else
 			slots_num = max_t(u32, IWL_DEFAULT_QUEUE_SIZE,
-					  trans->cfg->min_256_ba_txq_size);
+					  trans->cfg->min_ba_txq_size);
 		trans->txqs.txq[txq_id] = &trans_pcie->txq_memory[txq_id];
 		ret = iwl_txq_alloc(trans, trans->txqs.txq[txq_id], slots_num,
 				    cmd_queue);
@@ -594,7 +594,7 @@ int iwl_pcie_tx_init(struct iwl_trans *trans)
 					  trans->cfg->min_txq_size);
 		else
 			slots_num = max_t(u32, IWL_DEFAULT_QUEUE_SIZE,
-					  trans->cfg->min_256_ba_txq_size);
+					  trans->cfg->min_ba_txq_size);
 		ret = iwl_txq_init(trans, trans->txqs.txq[txq_id], slots_num,
 				   cmd_queue);
 		if (ret) {
diff --git a/drivers/net/wireless/intel/iwlwifi/queue/tx.c b/drivers/net/wireless/intel/iwlwifi/queue/tx.c
index e31ae5d0e26a..e12d36a25652 100644
--- a/drivers/net/wireless/intel/iwlwifi/queue/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/queue/tx.c
@@ -41,13 +41,13 @@ static void iwl_pcie_gen2_update_byte_tbl(struct iwl_trans *trans,
 	num_fetch_chunks = DIV_ROUND_UP(filled_tfd_size, 64) - 1;
 
 	if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_AX210) {
-		struct iwl_gen3_bc_tbl *scd_bc_tbl_gen3 = txq->bc_tbl.addr;
+		struct iwl_gen3_bc_tbl_entry *scd_bc_tbl_gen3 = txq->bc_tbl.addr;
 
 		/* Starting from AX210, the HW expects bytes */
 		WARN_ON(trans->txqs.bc_table_dword);
 		WARN_ON(len > 0x3FFF);
 		bc_ent = cpu_to_le16(len | (num_fetch_chunks << 14));
-		scd_bc_tbl_gen3->tfd_offset[idx] = bc_ent;
+		scd_bc_tbl_gen3[idx].tfd_offset = bc_ent;
 	} else {
 		struct iwlagn_scd_bc_tbl *scd_bc_tbl = txq->bc_tbl.addr;
 
-- 
2.34.1

