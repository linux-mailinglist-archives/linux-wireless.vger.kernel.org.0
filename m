Return-Path: <linux-wireless+bounces-8545-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 768658FC9B2
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Jun 2024 13:06:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62ADDB22F79
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Jun 2024 11:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B74CC192B64;
	Wed,  5 Jun 2024 11:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tdb/S/SG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF711922E8
	for <linux-wireless@vger.kernel.org>; Wed,  5 Jun 2024 11:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717585532; cv=none; b=O6h7WNbo0hYneHoenHx7uzQOiaJ5eIPm+gheN+kNil0Q5qBmJ6BkITPcJblHBlgDCXCwUWxV8eRdKGCJ4jxvy68S0sjkx6oFVAgv/w8xI+8KR5tN+ajMQlvNTnxuJZv71/1LkqJ33g0X3WYEfuLQzSEy74oIXLSfdTMrsXm8BB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717585532; c=relaxed/simple;
	bh=NaYNaCHWcAvLEzLqZsbkxeRN3aMH04aamAWwCSeQ4Vc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lq3YIxw7jLgNo0ZfLWFCUkAixrq1Bj4trSNFQEvZQekCEOyl4bQXVbKo/OKo+mhraxuL8KWG3dEdkn4louJjjy14uaXdaCXAXZCSZE+zKWQLHa+7w/BiwFiV2JnK8mzVFipsbFnK+qaSXwbucsbgEfMwMRQ82/e8IsDXAsagqBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tdb/S/SG; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717585525; x=1749121525;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NaYNaCHWcAvLEzLqZsbkxeRN3aMH04aamAWwCSeQ4Vc=;
  b=Tdb/S/SGUN0UPVx/8t1zzaO7XjubLt0yEByRO8rajVlAA23hD5s+MIHa
   vyAFax59vFASA4k5MmbDLh3IUht7CydShzPr99UBXvbmrofpPFrgKnMt1
   uOhDCbKhy0C08IDddDtXKGPQ4uFlOLGKkyabRdciKjlSAe+JzEAC9BTUz
   cxQPdi3qdHd/48LUXU+oHOq1k+b2wjKLkyeJWeBAlrbB13HRXoqmVq1bx
   ROz2yl/AiwiDEuPdQmm3QS+iqsU4g8ejgGP8NGeXh0p5MF/79rADyR8Ed
   MVrxfxWiZ2CycMMBLod5roVVNllT10VRYKc8uZSM8DMYBECiTA+W873d2
   w==;
X-CSE-ConnectionGUID: 01xrgJ4/RTeTBAJEWUudng==
X-CSE-MsgGUID: E2sJlllhRomTDg+Y2YLxLg==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="14402188"
X-IronPort-AV: E=Sophos;i="6.08,216,1712646000"; 
   d="scan'208";a="14402188"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 04:05:24 -0700
X-CSE-ConnectionGUID: mfyv0DpsQTS2omoxDiXaQQ==
X-CSE-MsgGUID: 4gPJynfLTE2AIPk0FS8w/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,216,1712646000"; 
   d="scan'208";a="41997378"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 04:05:22 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 06/11] wifi: iwlwifi: pcie: integrate TX queue code
Date: Wed,  5 Jun 2024 14:05:02 +0300
Message-Id: <20240605140327.936b13f45071.Ib219ce01a1e67bcad79d5131626db950252aaa46@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240605110507.2044059-1-miriam.rachel.korenblit@intel.com>
References: <20240605110507.2044059-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

The TX queue code was mostly moved out to support an internal
transport that we were never going to publish, but we're no
longer using that. Since we're also going to be dissolving
the virtual transport layer entirely, integrate the TX queue
code into the PCIe layer.

This also has a small kernel of already removing the virtual
transport function layer, since iwl_trans_send_cmd() calls
iwl_trans_pcie_send_hcmd() directly now, even if that still
calls the transport send_cmd method for now, we'll clean it
up later.

Also, not everything is renamed yet.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/Makefile   |    1 -
 .../net/wireless/intel/iwlwifi/iwl-trans.c    |   61 +-
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |   71 +-
 .../intel/iwlwifi/pcie/ctxt-info-gen3.c       |    2 +-
 .../wireless/intel/iwlwifi/pcie/ctxt-info.c   |    4 +-
 .../wireless/intel/iwlwifi/pcie/internal.h    |  211 +-
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c  |    9 +-
 .../wireless/intel/iwlwifi/pcie/trans-gen2.c  |   11 +-
 .../net/wireless/intel/iwlwifi/pcie/trans.c   |  114 +-
 .../net/wireless/intel/iwlwifi/pcie/tx-gen2.c | 1130 +++++++++-
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c  |  991 ++++++++-
 drivers/net/wireless/intel/iwlwifi/queue/tx.c | 1918 -----------------
 drivers/net/wireless/intel/iwlwifi/queue/tx.h |  191 --
 13 files changed, 2366 insertions(+), 2348 deletions(-)
 delete mode 100644 drivers/net/wireless/intel/iwlwifi/queue/tx.c
 delete mode 100644 drivers/net/wireless/intel/iwlwifi/queue/tx.h

diff --git a/drivers/net/wireless/intel/iwlwifi/Makefile b/drivers/net/wireless/intel/iwlwifi/Makefile
index 93cce88f2e27..64c123314245 100644
--- a/drivers/net/wireless/intel/iwlwifi/Makefile
+++ b/drivers/net/wireless/intel/iwlwifi/Makefile
@@ -14,7 +14,6 @@ iwlwifi-$(CONFIG_IWLMVM) += cfg/7000.o cfg/8000.o cfg/9000.o cfg/22000.o
 iwlwifi-$(CONFIG_IWLMVM) += cfg/ax210.o cfg/bz.o cfg/sc.o
 iwlwifi-objs		+= iwl-dbg-tlv.o
 iwlwifi-objs		+= iwl-trans.o
-iwlwifi-objs		+= queue/tx.o
 
 iwlwifi-objs		+= fw/img.o fw/notif-wait.o fw/rs.o
 iwlwifi-objs		+= fw/dbg.o fw/pnvm.o fw/dump.o
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.c b/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
index f95098c21c7d..327db93e8d84 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
@@ -2,7 +2,7 @@
 /*
  * Copyright (C) 2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
- * Copyright (C) 2019-2021, 2023 Intel Corporation
+ * Copyright (C) 2019-2021, 2023-2024 Intel Corporation
  */
 #include <linux/kernel.h>
 #include <linux/bsearch.h>
@@ -11,7 +11,6 @@
 #include "iwl-trans.h"
 #include "iwl-drv.h"
 #include "iwl-fh.h"
-#include "queue/tx.h"
 #include <linux/dmapool.h>
 #include "fw/api/commands.h"
 
@@ -42,17 +41,6 @@ struct iwl_trans *iwl_trans_alloc(unsigned int priv_size,
 
 	WARN_ON(!ops->wait_txq_empty && !ops->wait_tx_queues_empty);
 
-	if (trans->trans_cfg->gen2) {
-		trans->txqs.tfd.addr_size = 64;
-		trans->txqs.tfd.max_tbs = IWL_TFH_NUM_TBS;
-		trans->txqs.tfd.size = sizeof(struct iwl_tfh_tfd);
-	} else {
-		trans->txqs.tfd.addr_size = 36;
-		trans->txqs.tfd.max_tbs = IWL_NUM_OF_TBS;
-		trans->txqs.tfd.size = sizeof(struct iwl_tfd);
-	}
-	trans->max_skb_frags = IWL_TRANS_MAX_FRAGS(trans);
-
 	return trans;
 }
 
@@ -78,31 +66,6 @@ int iwl_trans_init(struct iwl_trans *trans)
 	if (WARN_ON(trans->trans_cfg->gen2 && txcmd_size >= txcmd_align))
 		return -EINVAL;
 
-	if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_BZ)
-		trans->txqs.bc_tbl_size =
-			sizeof(struct iwl_gen3_bc_tbl_entry) * TFD_QUEUE_BC_SIZE_GEN3_BZ;
-	else if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_AX210)
-		trans->txqs.bc_tbl_size =
-			sizeof(struct iwl_gen3_bc_tbl_entry) * TFD_QUEUE_BC_SIZE_GEN3_AX210;
-	else
-		trans->txqs.bc_tbl_size = sizeof(struct iwlagn_scd_bc_tbl);
-	/*
-	 * For gen2 devices, we use a single allocation for each byte-count
-	 * table, but they're pretty small (1k) so use a DMA pool that we
-	 * allocate here.
-	 */
-	if (trans->trans_cfg->gen2) {
-		trans->txqs.bc_pool = dmam_pool_create("iwlwifi:bc", trans->dev,
-						       trans->txqs.bc_tbl_size,
-						       256, 0);
-		if (!trans->txqs.bc_pool)
-			return -ENOMEM;
-	}
-
-	/* Some things must not change even if the config does */
-	WARN_ON(trans->txqs.tfd.addr_size !=
-		(trans->trans_cfg->gen2 ? 64 : 36));
-
 	snprintf(trans->dev_cmd_pool_name, sizeof(trans->dev_cmd_pool_name),
 		 "iwl_cmd_pool:%s", dev_name(trans->dev));
 	trans->dev_cmd_pool =
@@ -112,12 +75,6 @@ int iwl_trans_init(struct iwl_trans *trans)
 	if (!trans->dev_cmd_pool)
 		return -ENOMEM;
 
-	trans->txqs.tso_hdr_page = alloc_percpu(struct iwl_tso_hdr_page);
-	if (!trans->txqs.tso_hdr_page) {
-		kmem_cache_destroy(trans->dev_cmd_pool);
-		return -ENOMEM;
-	}
-
 	/* Initialize the wait queue for commands */
 	init_waitqueue_head(&trans->wait_command_queue);
 
@@ -126,20 +83,6 @@ int iwl_trans_init(struct iwl_trans *trans)
 
 void iwl_trans_free(struct iwl_trans *trans)
 {
-	int i;
-
-	if (trans->txqs.tso_hdr_page) {
-		for_each_possible_cpu(i) {
-			struct iwl_tso_hdr_page *p =
-				per_cpu_ptr(trans->txqs.tso_hdr_page, i);
-
-			if (p && p->page)
-				__free_page(p->page);
-		}
-
-		free_percpu(trans->txqs.tso_hdr_page);
-	}
-
 	kmem_cache_destroy(trans->dev_cmd_pool);
 }
 
@@ -180,7 +123,7 @@ int iwl_trans_send_cmd(struct iwl_trans *trans, struct iwl_host_cmd *cmd)
 			cmd->id = DEF_ID(cmd->id);
 	}
 
-	ret = iwl_trans_txq_send_hcmd(trans, cmd);
+	ret = iwl_trans_pcie_send_hcmd(trans, cmd);
 
 	if (!(cmd->flags & CMD_ASYNC))
 		lock_map_release(&trans->sync_cmd_lockdep_map);
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index b93cef7b2330..27f92b393f8e 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -26,11 +26,9 @@
  * DOC: Transport layer - what is it ?
  *
  * The transport layer is the layer that deals with the HW directly. It provides
- * an abstraction of the underlying HW to the upper layer. The transport layer
- * doesn't provide any policy, algorithm or anything of this kind, but only
- * mechanisms to make the HW do something. It is not completely stateless but
- * close to it.
- * We will have an implementation for each different supported bus.
+ * the PCIe access to the underlying hardwarwe. The transport layer doesn't
+ * provide any policy, algorithm or anything of this kind, but only mechanisms
+ * to make the HW do something. It is not completely stateless but close to it.
  */
 
 /**
@@ -167,12 +165,6 @@ struct iwl_device_tx_cmd {
  */
 #define IWL_MAX_CMD_TBS_PER_TFD	2
 
-/* We need 2 entries for the TX command and header, and another one might
- * be needed for potential data in the SKB's head. The remaining ones can
- * be used for frags.
- */
-#define IWL_TRANS_MAX_FRAGS(trans) ((trans)->txqs.tfd.max_tbs - 3)
-
 /**
  * enum iwl_hcmd_dataflag - flag for each one of the chunks of the command
  *
@@ -998,54 +990,6 @@ struct iwl_txq {
 	bool overflow_tx;
 };
 
-/**
- * struct iwl_trans_txqs - transport tx queues data
- *
- * @bc_table_dword: true if the BC table expects DWORD (as opposed to bytes)
- * @page_offs: offset from skb->cb to mac header page pointer
- * @dev_cmd_offs: offset from skb->cb to iwl_device_tx_cmd pointer
- * @queue_used: bit mask of used queues
- * @queue_stopped: bit mask of stopped queues
- * @txq: array of TXQ data structures representing the TXQs
- * @scd_bc_tbls: gen1 pointer to the byte count table of the scheduler
- * @queue_alloc_cmd_ver: queue allocation command version
- * @bc_pool: bytecount DMA allocations pool
- * @bc_tbl_size: bytecount table size
- * @tso_hdr_page: page allocated (per CPU) for A-MSDU headers when doing TSO
- *	(and similar usage)
- * @tfd: TFD data
- * @tfd.max_tbs: max number of buffers per TFD
- * @tfd.size: TFD size
- * @tfd.addr_size: TFD/TB address size
- */
-struct iwl_trans_txqs {
-	unsigned long queue_used[BITS_TO_LONGS(IWL_MAX_TVQM_QUEUES)];
-	unsigned long queue_stopped[BITS_TO_LONGS(IWL_MAX_TVQM_QUEUES)];
-	struct iwl_txq *txq[IWL_MAX_TVQM_QUEUES];
-	struct dma_pool *bc_pool;
-	size_t bc_tbl_size;
-	bool bc_table_dword;
-	u8 page_offs;
-	u8 dev_cmd_offs;
-	struct iwl_tso_hdr_page __percpu *tso_hdr_page;
-
-	struct {
-		u8 fifo;
-		u8 q_id;
-		unsigned int wdg_timeout;
-	} cmd;
-
-	struct {
-		u8 max_tbs;
-		u16 size;
-		u8 addr_size;
-	} tfd;
-
-	struct iwl_dma_ptr scd_bc_tbls;
-
-	u8 queue_alloc_cmd_ver;
-};
-
 /**
  * struct iwl_trans - transport common data
  *
@@ -1099,7 +1043,6 @@ struct iwl_trans_txqs {
  *	This mode is set dynamically, depending on the WoWLAN values
  *	configured from the userspace at runtime.
  * @name: the device name
- * @txqs: transport tx queues data.
  * @mbx_addr_0_step: step address data 0
  * @mbx_addr_1_step: step address data 1
  * @pcie_link_speed: current PCIe link speed (%PCI_EXP_LNKSTA_CLS_*),
@@ -1169,7 +1112,6 @@ struct iwl_trans {
 	enum iwl_plat_pm_mode system_pm_mode;
 
 	const char *name;
-	struct iwl_trans_txqs txqs;
 	u32 mbx_addr_0_step;
 	u32 mbx_addr_1_step;
 
@@ -1656,10 +1598,13 @@ static inline bool iwl_trans_is_hw_error_value(u32 val)
 }
 
 /*****************************************************
-* driver (transport) register/unregister functions
-******************************************************/
+ * PCIe handling
+ *****************************************************/
 int __must_check iwl_pci_register_driver(void);
 void iwl_pci_unregister_driver(void);
 void iwl_trans_pcie_remove(struct iwl_trans *trans, bool rescan);
 
+int iwl_trans_pcie_send_hcmd(struct iwl_trans *trans,
+			     struct iwl_host_cmd *cmd);
+
 #endif /* __iwl_trans_h__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
index ebf11f276b20..e63efbf809f0 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
@@ -216,7 +216,7 @@ int iwl_pcie_ctxt_info_gen3_init(struct iwl_trans *trans,
 	ctxt_info_gen3->cr_tail_idx_arr_base_addr =
 		cpu_to_le64(trans_pcie->prph_info_dma_addr + 3 * PAGE_SIZE / 4);
 	ctxt_info_gen3->mtr_base_addr =
-		cpu_to_le64(trans->txqs.txq[trans->txqs.cmd.q_id]->dma_addr);
+		cpu_to_le64(trans_pcie->txqs.txq[trans_pcie->txqs.cmd.q_id]->dma_addr);
 	ctxt_info_gen3->mcr_base_addr =
 		cpu_to_le64(trans_pcie->rxq->used_bd_dma);
 	ctxt_info_gen3->mtr_size =
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info.c b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info.c
index 0fa92704cd14..344e4d5a1c6e 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
  * Copyright (C) 2017 Intel Deutschland GmbH
- * Copyright (C) 2018-2023 Intel Corporation
+ * Copyright (C) 2018-2024 Intel Corporation
  */
 #include "iwl-trans.h"
 #include "iwl-fh.h"
@@ -218,7 +218,7 @@ int iwl_pcie_ctxt_info_init(struct iwl_trans *trans,
 
 	/* initialize TX command queue */
 	ctxt_info->hcmd_cfg.cmd_queue_addr =
-		cpu_to_le64(trans->txqs.txq[trans->txqs.cmd.q_id]->dma_addr);
+		cpu_to_le64(trans_pcie->txqs.txq[trans_pcie->txqs.cmd.q_id]->dma_addr);
 	ctxt_info->hcmd_cfg.cmd_queue_size =
 		TFD_QUEUE_CB_SIZE(IWL_CMD_QUEUE_SIZE);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
index a7eebe400b5b..3bdbb907d91a 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2003-2015, 2018-2023 Intel Corporation
+ * Copyright (C) 2003-2015, 2018-2024 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -22,7 +22,6 @@
 #include "iwl-io.h"
 #include "iwl-op-mode.h"
 #include "iwl-drv.h"
-#include "queue/tx.h"
 #include "iwl-context-info.h"
 
 /*
@@ -286,6 +285,54 @@ enum iwl_pcie_imr_status {
 	IMR_D2S_ERROR,
 };
 
+/**
+ * struct iwl_pcie_txqs - TX queues data
+ *
+ * @bc_table_dword: true if the BC table expects DWORD (as opposed to bytes)
+ * @page_offs: offset from skb->cb to mac header page pointer
+ * @dev_cmd_offs: offset from skb->cb to iwl_device_tx_cmd pointer
+ * @queue_used: bit mask of used queues
+ * @queue_stopped: bit mask of stopped queues
+ * @txq: array of TXQ data structures representing the TXQs
+ * @scd_bc_tbls: gen1 pointer to the byte count table of the scheduler
+ * @queue_alloc_cmd_ver: queue allocation command version
+ * @bc_pool: bytecount DMA allocations pool
+ * @bc_tbl_size: bytecount table size
+ * @tso_hdr_page: page allocated (per CPU) for A-MSDU headers when doing TSO
+ *	(and similar usage)
+ * @tfd: TFD data
+ * @tfd.max_tbs: max number of buffers per TFD
+ * @tfd.size: TFD size
+ * @tfd.addr_size: TFD/TB address size
+ */
+struct iwl_pcie_txqs {
+	unsigned long queue_used[BITS_TO_LONGS(IWL_MAX_TVQM_QUEUES)];
+	unsigned long queue_stopped[BITS_TO_LONGS(IWL_MAX_TVQM_QUEUES)];
+	struct iwl_txq *txq[IWL_MAX_TVQM_QUEUES];
+	struct dma_pool *bc_pool;
+	size_t bc_tbl_size;
+	bool bc_table_dword;
+	u8 page_offs;
+	u8 dev_cmd_offs;
+	struct iwl_tso_hdr_page __percpu *tso_hdr_page;
+
+	struct {
+		u8 fifo;
+		u8 q_id;
+		unsigned int wdg_timeout;
+	} cmd;
+
+	struct {
+		u8 max_tbs;
+		u16 size;
+		u8 addr_size;
+	} tfd;
+
+	struct iwl_dma_ptr scd_bc_tbls;
+
+	u8 queue_alloc_cmd_ver;
+};
+
 /**
  * struct iwl_trans_pcie - PCIe transport specific data
  * @rxq: all the RX queue data
@@ -367,6 +414,7 @@ enum iwl_pcie_imr_status {
  * @is_down: indicates the NIC is down
  * @isr_stats: interrupt statistics
  * @napi_dev: (fake) netdev for NAPI registration
+ * @txqs: transport tx queues data.
  */
 struct iwl_trans_pcie {
 	struct iwl_rxq *rxq;
@@ -464,6 +512,8 @@ struct iwl_trans_pcie {
 	enum iwl_pcie_imr_status imr_status;
 	wait_queue_head_t imr_waitq;
 	char rf_name[32];
+
+	struct iwl_pcie_txqs txqs;
 };
 
 static inline struct iwl_trans_pcie *
@@ -538,6 +588,17 @@ void iwl_pcie_disable_ict(struct iwl_trans *trans);
 /*****************************************************
 * TX / HCMD
 ******************************************************/
+/* We need 2 entries for the TX command and header, and another one might
+ * be needed for potential data in the SKB's head. The remaining ones can
+ * be used for frags.
+ */
+#define IWL_TRANS_PCIE_MAX_FRAGS(trans_pcie) ((trans_pcie)->txqs.tfd.max_tbs - 3)
+
+struct iwl_tso_hdr_page {
+	struct page *page;
+	u8 *pos;
+};
+
 int iwl_pcie_tx_init(struct iwl_trans *trans);
 void iwl_pcie_tx_start(struct iwl_trans *trans, u32 scd_base_addr);
 int iwl_pcie_tx_stop(struct iwl_trans *trans);
@@ -552,10 +613,154 @@ void iwl_trans_pcie_txq_set_shared_mode(struct iwl_trans *trans, u32 txq_id,
 int iwl_trans_pcie_tx(struct iwl_trans *trans, struct sk_buff *skb,
 		      struct iwl_device_tx_cmd *dev_cmd, int txq_id);
 void iwl_pcie_txq_check_wrptrs(struct iwl_trans *trans);
-int iwl_trans_pcie_send_hcmd(struct iwl_trans *trans, struct iwl_host_cmd *cmd);
 void iwl_pcie_hcmd_complete(struct iwl_trans *trans,
 			    struct iwl_rx_cmd_buffer *rxb);
 void iwl_trans_pcie_tx_reset(struct iwl_trans *trans);
+int iwl_pcie_txq_alloc(struct iwl_trans *trans, struct iwl_txq *txq,
+		       int slots_num, bool cmd_queue);
+
+struct iwl_tso_hdr_page *iwl_pcie_get_page_hdr(struct iwl_trans *trans,
+					       size_t len, struct sk_buff *skb);
+void iwl_pcie_free_tso_page(struct iwl_trans *trans, struct sk_buff *skb);
+
+static inline dma_addr_t
+iwl_txq_get_first_tb_dma(struct iwl_txq *txq, int idx)
+{
+	return txq->first_tb_dma +
+	       sizeof(struct iwl_pcie_first_tb_buf) * idx;
+}
+
+static inline u16 iwl_txq_get_cmd_index(const struct iwl_txq *q, u32 index)
+{
+	return index & (q->n_window - 1);
+}
+
+static inline void *iwl_txq_get_tfd(struct iwl_trans *trans,
+				    struct iwl_txq *txq, int idx)
+{
+	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
+
+	if (trans->trans_cfg->gen2)
+		idx = iwl_txq_get_cmd_index(txq, idx);
+
+	return (u8 *)txq->tfds + trans_pcie->txqs.tfd.size * idx;
+}
+
+/*
+ * We need this inline in case dma_addr_t is only 32-bits - since the
+ * hardware is always 64-bit, the issue can still occur in that case,
+ * so use u64 for 'phys' here to force the addition in 64-bit.
+ */
+static inline bool iwl_txq_crosses_4g_boundary(u64 phys, u16 len)
+{
+	return upper_32_bits(phys) != upper_32_bits(phys + len);
+}
+
+int iwl_txq_space(struct iwl_trans *trans, const struct iwl_txq *q);
+
+static inline void iwl_txq_stop(struct iwl_trans *trans, struct iwl_txq *txq)
+{
+	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
+
+	if (!test_and_set_bit(txq->id, trans_pcie->txqs.queue_stopped)) {
+		iwl_op_mode_queue_full(trans->op_mode, txq->id);
+		IWL_DEBUG_TX_QUEUES(trans, "Stop hwq %d\n", txq->id);
+	} else {
+		IWL_DEBUG_TX_QUEUES(trans, "hwq %d already stopped\n",
+				    txq->id);
+	}
+}
+
+/**
+ * iwl_txq_inc_wrap - increment queue index, wrap back to beginning
+ * @trans: the transport (for configuration data)
+ * @index: current index
+ */
+static inline int iwl_txq_inc_wrap(struct iwl_trans *trans, int index)
+{
+	return ++index &
+		(trans->trans_cfg->base_params->max_tfd_queue_size - 1);
+}
+
+/**
+ * iwl_txq_dec_wrap - decrement queue index, wrap back to end
+ * @trans: the transport (for configuration data)
+ * @index: current index
+ */
+static inline int iwl_txq_dec_wrap(struct iwl_trans *trans, int index)
+{
+	return --index &
+		(trans->trans_cfg->base_params->max_tfd_queue_size - 1);
+}
+
+void iwl_txq_log_scd_error(struct iwl_trans *trans, struct iwl_txq *txq);
+
+static inline void
+iwl_trans_pcie_wake_queue(struct iwl_trans *trans, struct iwl_txq *txq)
+{
+	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
+
+	if (test_and_clear_bit(txq->id, trans_pcie->txqs.queue_stopped)) {
+		IWL_DEBUG_TX_QUEUES(trans, "Wake hwq %d\n", txq->id);
+		iwl_op_mode_queue_not_full(trans->op_mode, txq->id);
+	}
+}
+
+int iwl_txq_gen2_set_tb(struct iwl_trans *trans,
+			struct iwl_tfh_tfd *tfd, dma_addr_t addr,
+			u16 len);
+
+static inline void iwl_txq_set_tfd_invalid_gen2(struct iwl_trans *trans,
+						struct iwl_tfh_tfd *tfd)
+{
+	tfd->num_tbs = 0;
+
+	iwl_txq_gen2_set_tb(trans, tfd, trans->invalid_tx_cmd.dma,
+			    trans->invalid_tx_cmd.size);
+}
+
+void iwl_txq_gen2_tfd_unmap(struct iwl_trans *trans,
+			    struct iwl_cmd_meta *meta,
+			    struct iwl_tfh_tfd *tfd);
+
+int iwl_txq_dyn_alloc(struct iwl_trans *trans, u32 flags,
+		      u32 sta_mask, u8 tid,
+		      int size, unsigned int timeout);
+
+int iwl_txq_gen2_tx(struct iwl_trans *trans, struct sk_buff *skb,
+		    struct iwl_device_tx_cmd *dev_cmd, int txq_id);
+
+void iwl_txq_dyn_free(struct iwl_trans *trans, int queue);
+void iwl_txq_gen2_tx_free(struct iwl_trans *trans);
+int iwl_txq_init(struct iwl_trans *trans, struct iwl_txq *txq,
+		 int slots_num, bool cmd_queue);
+int iwl_txq_gen2_init(struct iwl_trans *trans, int txq_id,
+		      int queue_size);
+
+static inline u16 iwl_txq_gen1_tfd_tb_get_len(struct iwl_trans *trans,
+					      void *_tfd, u8 idx)
+{
+	struct iwl_tfd *tfd;
+	struct iwl_tfd_tb *tb;
+
+	if (trans->trans_cfg->gen2) {
+		struct iwl_tfh_tfd *tfh_tfd = _tfd;
+		struct iwl_tfh_tb *tfh_tb = &tfh_tfd->tbs[idx];
+
+		return le16_to_cpu(tfh_tb->tb_len);
+	}
+
+	tfd = (struct iwl_tfd *)_tfd;
+	tb = &tfd->tbs[idx];
+
+	return le16_to_cpu(tb->hi_n_len) >> 4;
+}
+
+void iwl_pcie_reclaim(struct iwl_trans *trans, int txq_id, int ssn,
+		      struct sk_buff_head *skbs, bool is_flush);
+void iwl_pcie_set_q_ptrs(struct iwl_trans *trans, int txq_id, int ptr);
+void iwl_pcie_freeze_txq_timer(struct iwl_trans *trans,
+			       unsigned long txqs, bool freeze);
 
 /*****************************************************
 * Error handling
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
index 984d7bcd381f..afb88eab8174 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2003-2014, 2018-2023 Intel Corporation
+ * Copyright (C) 2003-2014, 2018-2024 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -1301,7 +1301,7 @@ static void iwl_pcie_rx_handle_rb(struct iwl_trans *trans,
 				int i)
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
-	struct iwl_txq *txq = trans->txqs.txq[trans->txqs.cmd.q_id];
+	struct iwl_txq *txq = trans_pcie->txqs.txq[trans_pcie->txqs.cmd.q_id];
 	bool page_stolen = false;
 	int max_len = trans_pcie->rx_buf_bytes;
 	u32 offset = 0;
@@ -1678,6 +1678,7 @@ irqreturn_t iwl_pcie_irq_rx_msix_handler(int irq, void *dev_id)
  */
 static void iwl_pcie_irq_handle_error(struct iwl_trans *trans)
 {
+	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 	int i;
 
 	/* W/A for WiFi/WiMAX coex and WiMAX own the RF */
@@ -1694,9 +1695,9 @@ static void iwl_pcie_irq_handle_error(struct iwl_trans *trans)
 	}
 
 	for (i = 0; i < trans->trans_cfg->base_params->num_of_queues; i++) {
-		if (!trans->txqs.txq[i])
+		if (!trans_pcie->txqs.txq[i])
 			continue;
-		del_timer(&trans->txqs.txq[i]->stuck_timer);
+		del_timer(&trans_pcie->txqs.txq[i]->stuck_timer);
 	}
 
 	/* The STATUS_FW_ERROR bit is set in this function. This must happen
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
index a4a4772330cf..c1446d550b4f 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
  * Copyright (C) 2017 Intel Deutschland GmbH
- * Copyright (C) 2018-2023 Intel Corporation
+ * Copyright (C) 2018-2024 Intel Corporation
  */
 #include "iwl-trans.h"
 #include "iwl-prph.h"
@@ -247,7 +247,7 @@ static int iwl_pcie_gen2_nic_init(struct iwl_trans *trans)
 		return -ENOMEM;
 
 	/* Allocate or reset and init all Tx and Command queues */
-	if (iwl_txq_gen2_init(trans, trans->txqs.cmd.q_id, queue_size))
+	if (iwl_txq_gen2_init(trans, trans_pcie->txqs.cmd.q_id, queue_size))
 		return -ENOMEM;
 
 	/* enable shadow regs in HW */
@@ -346,9 +346,10 @@ void iwl_trans_pcie_gen2_fw_alive(struct iwl_trans *trans, u32 scd_addr)
 	iwl_pcie_reset_ict(trans);
 
 	/* make sure all queue are not stopped/used */
-	memset(trans->txqs.queue_stopped, 0,
-	       sizeof(trans->txqs.queue_stopped));
-	memset(trans->txqs.queue_used, 0, sizeof(trans->txqs.queue_used));
+	memset(trans_pcie->txqs.queue_stopped, 0,
+	       sizeof(trans_pcie->txqs.queue_stopped));
+	memset(trans_pcie->txqs.queue_used, 0,
+	       sizeof(trans_pcie->txqs.queue_used));
 
 	/* now that we got alive we can free the fw image & the context info.
 	 * paging memory cannot be freed included since FW will still use it
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index d5a887b3a4bb..48ae38f3120d 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2007-2015, 2018-2023 Intel Corporation
+ * Copyright (C) 2007-2015, 2018-2024 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -1956,12 +1956,12 @@ static void iwl_trans_pcie_configure(struct iwl_trans *trans,
 	/* free all first - we might be reconfigured for a different size */
 	iwl_pcie_free_rbs_pool(trans);
 
-	trans->txqs.cmd.q_id = trans_cfg->cmd_queue;
-	trans->txqs.cmd.fifo = trans_cfg->cmd_fifo;
-	trans->txqs.cmd.wdg_timeout = trans_cfg->cmd_q_wdg_timeout;
-	trans->txqs.page_offs = trans_cfg->cb_data_offs;
-	trans->txqs.dev_cmd_offs = trans_cfg->cb_data_offs + sizeof(void *);
-	trans->txqs.queue_alloc_cmd_ver = trans_cfg->queue_alloc_cmd_ver;
+	trans_pcie->txqs.cmd.q_id = trans_cfg->cmd_queue;
+	trans_pcie->txqs.cmd.fifo = trans_cfg->cmd_fifo;
+	trans_pcie->txqs.cmd.wdg_timeout = trans_cfg->cmd_q_wdg_timeout;
+	trans_pcie->txqs.page_offs = trans_cfg->cb_data_offs;
+	trans_pcie->txqs.dev_cmd_offs = trans_cfg->cb_data_offs + sizeof(void *);
+	trans_pcie->txqs.queue_alloc_cmd_ver = trans_cfg->queue_alloc_cmd_ver;
 
 	if (WARN_ON(trans_cfg->n_no_reclaim_cmds > MAX_NO_RECLAIM_CMDS))
 		trans_pcie->n_no_reclaim_cmds = 0;
@@ -1980,7 +1980,7 @@ static void iwl_trans_pcie_configure(struct iwl_trans *trans,
 	if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_AX210)
 		trans_pcie->supported_dma_mask = DMA_BIT_MASK(11);
 
-	trans->txqs.bc_table_dword = trans_cfg->bc_table_dword;
+	trans_pcie->txqs.bc_table_dword = trans_cfg->bc_table_dword;
 	trans_pcie->scd_set_active = trans_cfg->scd_set_active;
 
 	trans->command_groups = trans_cfg->command_groups;
@@ -2079,6 +2079,19 @@ void iwl_trans_pcie_free(struct iwl_trans *trans)
 					      trans->dev);
 
 	mutex_destroy(&trans_pcie->mutex);
+
+	if (trans_pcie->txqs.tso_hdr_page) {
+		for_each_possible_cpu(i) {
+			struct iwl_tso_hdr_page *p =
+				per_cpu_ptr(trans_pcie->txqs.tso_hdr_page, i);
+
+			if (p && p->page)
+				__free_page(p->page);
+		}
+
+		free_percpu(trans_pcie->txqs.tso_hdr_page);
+	}
+
 	iwl_trans_free(trans);
 }
 
@@ -2392,6 +2405,7 @@ static int iwl_trans_pcie_rxq_dma_data(struct iwl_trans *trans, int queue,
 
 static int iwl_trans_pcie_wait_txq_empty(struct iwl_trans *trans, int txq_idx)
 {
+	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 	struct iwl_txq *txq;
 	unsigned long now = jiffies;
 	bool overflow_tx;
@@ -2401,11 +2415,11 @@ static int iwl_trans_pcie_wait_txq_empty(struct iwl_trans *trans, int txq_idx)
 	if (test_bit(STATUS_TRANS_DEAD, &trans->status))
 		return -ENODEV;
 
-	if (!test_bit(txq_idx, trans->txqs.queue_used))
+	if (!test_bit(txq_idx, trans_pcie->txqs.queue_used))
 		return -EINVAL;
 
 	IWL_DEBUG_TX_QUEUES(trans, "Emptying queue %d...\n", txq_idx);
-	txq = trans->txqs.txq[txq_idx];
+	txq = trans_pcie->txqs.txq[txq_idx];
 
 	spin_lock_bh(&txq->lock);
 	overflow_tx = txq->overflow_tx ||
@@ -2453,6 +2467,7 @@ static int iwl_trans_pcie_wait_txq_empty(struct iwl_trans *trans, int txq_idx)
 
 static int iwl_trans_pcie_wait_txqs_empty(struct iwl_trans *trans, u32 txq_bm)
 {
+	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 	int cnt;
 	int ret = 0;
 
@@ -2461,9 +2476,9 @@ static int iwl_trans_pcie_wait_txqs_empty(struct iwl_trans *trans, u32 txq_bm)
 	     cnt < trans->trans_cfg->base_params->num_of_queues;
 	     cnt++) {
 
-		if (cnt == trans->txqs.cmd.q_id)
+		if (cnt == trans_pcie->txqs.cmd.q_id)
 			continue;
-		if (!test_bit(cnt, trans->txqs.queue_used))
+		if (!test_bit(cnt, trans_pcie->txqs.queue_used))
 			continue;
 		if (!(BIT(cnt) & txq_bm))
 			continue;
@@ -2636,12 +2651,13 @@ static int iwl_dbgfs_tx_queue_seq_show(struct seq_file *seq, void *v)
 	struct iwl_dbgfs_tx_queue_priv *priv = seq->private;
 	struct iwl_dbgfs_tx_queue_state *state = v;
 	struct iwl_trans *trans = priv->trans;
-	struct iwl_txq *txq = trans->txqs.txq[state->pos];
+	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
+	struct iwl_txq *txq = trans_pcie->txqs.txq[state->pos];
 
 	seq_printf(seq, "hwq %.3u: used=%d stopped=%d ",
 		   (unsigned int)state->pos,
-		   !!test_bit(state->pos, trans->txqs.queue_used),
-		   !!test_bit(state->pos, trans->txqs.queue_stopped));
+		   !!test_bit(state->pos, trans_pcie->txqs.queue_used),
+		   !!test_bit(state->pos, trans_pcie->txqs.queue_stopped));
 	if (txq)
 		seq_printf(seq,
 			   "read=%u write=%u need_update=%d frozen=%d n_window=%d ampdu=%d",
@@ -2651,7 +2667,7 @@ static int iwl_dbgfs_tx_queue_seq_show(struct seq_file *seq, void *v)
 	else
 		seq_puts(seq, "(unallocated)");
 
-	if (state->pos == trans->txqs.cmd.q_id)
+	if (state->pos == trans_pcie->txqs.cmd.q_id)
 		seq_puts(seq, " (HCMD)");
 	seq_puts(seq, "\n");
 
@@ -3068,10 +3084,11 @@ static void iwl_trans_pcie_debugfs_cleanup(struct iwl_trans *trans)
 
 static u32 iwl_trans_pcie_get_cmdlen(struct iwl_trans *trans, void *tfd)
 {
+	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 	u32 cmdlen = 0;
 	int i;
 
-	for (i = 0; i < trans->txqs.tfd.max_tbs; i++)
+	for (i = 0; i < trans_pcie->txqs.tfd.max_tbs; i++)
 		cmdlen += iwl_txq_gen1_tfd_tb_get_len(trans, tfd, i);
 
 	return cmdlen;
@@ -3340,7 +3357,7 @@ iwl_trans_pcie_dump_data(struct iwl_trans *trans,
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 	struct iwl_fw_error_dump_data *data;
-	struct iwl_txq *cmdq = trans->txqs.txq[trans->txqs.cmd.q_id];
+	struct iwl_txq *cmdq = trans_pcie->txqs.txq[trans_pcie->txqs.cmd.q_id];
 	struct iwl_fw_error_dump_txcmd *txcmd;
 	struct iwl_trans_dump_data *dump_data;
 	u32 len, num_rbs = 0, monitor_len = 0;
@@ -3407,7 +3424,7 @@ iwl_trans_pcie_dump_data(struct iwl_trans *trans,
 	data = (void *)dump_data->data;
 
 	if (dump_mask & BIT(IWL_FW_ERROR_DUMP_TXCMD) && cmdq) {
-		u16 tfd_size = trans->txqs.tfd.size;
+		u16 tfd_size = trans_pcie->txqs.tfd.size;
 
 		data->type = cpu_to_le32(IWL_FW_ERROR_DUMP_TXCMD);
 		txcmd = (void *)data->data;
@@ -3543,7 +3560,7 @@ static const struct iwl_trans_ops trans_ops_pcie = {
 	.send_cmd = iwl_pcie_enqueue_hcmd,
 
 	.tx = iwl_trans_pcie_tx,
-	.reclaim = iwl_txq_reclaim,
+	.reclaim = iwl_pcie_reclaim,
 
 	.txq_disable = iwl_trans_pcie_txq_disable,
 	.txq_enable = iwl_trans_pcie_txq_enable,
@@ -3552,7 +3569,7 @@ static const struct iwl_trans_ops trans_ops_pcie = {
 
 	.wait_tx_queues_empty = iwl_trans_pcie_wait_txqs_empty,
 
-	.freeze_txq_timer = iwl_trans_txq_freeze_timer,
+	.freeze_txq_timer = iwl_pcie_freeze_txq_timer,
 #ifdef CONFIG_IWLWIFI_DEBUGFS
 	.debugfs_cleanup = iwl_trans_pcie_debugfs_cleanup,
 #endif
@@ -3568,9 +3585,9 @@ static const struct iwl_trans_ops trans_ops_pcie_gen2 = {
 	.send_cmd = iwl_pcie_gen2_enqueue_hcmd,
 
 	.tx = iwl_txq_gen2_tx,
-	.reclaim = iwl_txq_reclaim,
+	.reclaim = iwl_pcie_reclaim,
 
-	.set_q_ptrs = iwl_txq_set_q_ptrs,
+	.set_q_ptrs = iwl_pcie_set_q_ptrs,
 
 	.txq_alloc = iwl_txq_dyn_alloc,
 	.txq_free = iwl_txq_dyn_free,
@@ -3618,13 +3635,58 @@ struct iwl_trans *iwl_trans_pcie_alloc(struct pci_dev *pdev,
 
 	trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 
+	if (trans->trans_cfg->gen2) {
+		trans_pcie->txqs.tfd.addr_size = 64;
+		trans_pcie->txqs.tfd.max_tbs = IWL_TFH_NUM_TBS;
+		trans_pcie->txqs.tfd.size = sizeof(struct iwl_tfh_tfd);
+	} else {
+		trans_pcie->txqs.tfd.addr_size = 36;
+		trans_pcie->txqs.tfd.max_tbs = IWL_NUM_OF_TBS;
+		trans_pcie->txqs.tfd.size = sizeof(struct iwl_tfd);
+	}
+	trans->max_skb_frags = IWL_TRANS_PCIE_MAX_FRAGS(trans_pcie);
+
+	trans_pcie->txqs.tso_hdr_page = alloc_percpu(struct iwl_tso_hdr_page);
+	if (!trans_pcie->txqs.tso_hdr_page) {
+		ret = -ENOMEM;
+		goto out_free_trans;
+	}
+
+	if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_BZ)
+		trans_pcie->txqs.bc_tbl_size =
+			sizeof(struct iwl_gen3_bc_tbl_entry) * TFD_QUEUE_BC_SIZE_GEN3_BZ;
+	else if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_AX210)
+		trans_pcie->txqs.bc_tbl_size =
+			sizeof(struct iwl_gen3_bc_tbl_entry) * TFD_QUEUE_BC_SIZE_GEN3_AX210;
+	else
+		trans_pcie->txqs.bc_tbl_size = sizeof(struct iwlagn_scd_bc_tbl);
+	/*
+	 * For gen2 devices, we use a single allocation for each byte-count
+	 * table, but they're pretty small (1k) so use a DMA pool that we
+	 * allocate here.
+	 */
+	if (trans->trans_cfg->gen2) {
+		trans_pcie->txqs.bc_pool =
+			dmam_pool_create("iwlwifi:bc", trans->dev,
+					 trans_pcie->txqs.bc_tbl_size,
+					 256, 0);
+		if (!trans_pcie->txqs.bc_pool) {
+			ret = -ENOMEM;
+			goto out_free_tso;
+		}
+	}
+
+	/* Some things must not change even if the config does */
+	WARN_ON(trans_pcie->txqs.tfd.addr_size !=
+		(trans->trans_cfg->gen2 ? 64 : 36));
+
 	/* Initialize NAPI here - it should be before registering to mac80211
 	 * in the opmode but after the HW struct is allocated.
 	 */
 	trans_pcie->napi_dev = alloc_netdev_dummy(sizeof(struct iwl_trans_pcie *));
 	if (!trans_pcie->napi_dev) {
 		ret = -ENOMEM;
-		goto out_free_trans;
+		goto out_free_tso;
 	}
 	/* The private struct in netdev is a pointer to struct iwl_trans_pcie */
 	priv = netdev_priv(trans_pcie->napi_dev);
@@ -3663,7 +3725,7 @@ struct iwl_trans *iwl_trans_pcie_alloc(struct pci_dev *pdev,
 
 	pci_set_master(pdev);
 
-	addr_size = trans->txqs.tfd.addr_size;
+	addr_size = trans_pcie->txqs.tfd.addr_size;
 	ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(addr_size));
 	if (ret) {
 		ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
@@ -3766,6 +3828,8 @@ struct iwl_trans *iwl_trans_pcie_alloc(struct pci_dev *pdev,
 	destroy_workqueue(trans_pcie->rba.alloc_wq);
 out_free_ndev:
 	free_netdev(trans_pcie->napi_dev);
+out_free_tso:
+	free_percpu(trans_pcie->txqs.tso_hdr_page);
 out_free_trans:
 	iwl_trans_free(trans);
 	return ERR_PTR(ret);
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c b/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
index aabbef114bc2..b897de1b9226 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
  * Copyright (C) 2017 Intel Deutschland GmbH
- * Copyright (C) 2018-2020, 2023 Intel Corporation
+ * Copyright (C) 2018-2020, 2023-2024 Intel Corporation
  */
 #include <net/tso.h>
 #include <linux/tcp.h>
@@ -11,7 +11,1127 @@
 #include "iwl-io.h"
 #include "internal.h"
 #include "fw/api/tx.h"
-#include "queue/tx.h"
+#include "fw/api/commands.h"
+#include "fw/api/datapath.h"
+#include "iwl-scd.h"
+
+static struct page *get_workaround_page(struct iwl_trans *trans,
+					struct sk_buff *skb)
+{
+	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
+	struct page **page_ptr;
+	struct page *ret;
+
+	page_ptr = (void *)((u8 *)skb->cb + trans_pcie->txqs.page_offs);
+
+	ret = alloc_page(GFP_ATOMIC);
+	if (!ret)
+		return NULL;
+
+	/* set the chaining pointer to the previous page if there */
+	*(void **)((u8 *)page_address(ret) + PAGE_SIZE - sizeof(void *)) = *page_ptr;
+	*page_ptr = ret;
+
+	return ret;
+}
+
+/*
+ * Add a TB and if needed apply the FH HW bug workaround;
+ * meta != NULL indicates that it's a page mapping and we
+ * need to dma_unmap_page() and set the meta->tbs bit in
+ * this case.
+ */
+static int iwl_txq_gen2_set_tb_with_wa(struct iwl_trans *trans,
+				       struct sk_buff *skb,
+				       struct iwl_tfh_tfd *tfd,
+				       dma_addr_t phys, void *virt,
+				       u16 len, struct iwl_cmd_meta *meta)
+{
+	dma_addr_t oldphys = phys;
+	struct page *page;
+	int ret;
+
+	if (unlikely(dma_mapping_error(trans->dev, phys)))
+		return -ENOMEM;
+
+	if (likely(!iwl_txq_crosses_4g_boundary(phys, len))) {
+		ret = iwl_txq_gen2_set_tb(trans, tfd, phys, len);
+
+		if (ret < 0)
+			goto unmap;
+
+		if (meta)
+			meta->tbs |= BIT(ret);
+
+		ret = 0;
+		goto trace;
+	}
+
+	/*
+	 * Work around a hardware bug. If (as expressed in the
+	 * condition above) the TB ends on a 32-bit boundary,
+	 * then the next TB may be accessed with the wrong
+	 * address.
+	 * To work around it, copy the data elsewhere and make
+	 * a new mapping for it so the device will not fail.
+	 */
+
+	if (WARN_ON(len > PAGE_SIZE - sizeof(void *))) {
+		ret = -ENOBUFS;
+		goto unmap;
+	}
+
+	page = get_workaround_page(trans, skb);
+	if (!page) {
+		ret = -ENOMEM;
+		goto unmap;
+	}
+
+	memcpy(page_address(page), virt, len);
+
+	phys = dma_map_single(trans->dev, page_address(page), len,
+			      DMA_TO_DEVICE);
+	if (unlikely(dma_mapping_error(trans->dev, phys)))
+		return -ENOMEM;
+	ret = iwl_txq_gen2_set_tb(trans, tfd, phys, len);
+	if (ret < 0) {
+		/* unmap the new allocation as single */
+		oldphys = phys;
+		meta = NULL;
+		goto unmap;
+	}
+	IWL_DEBUG_TX(trans,
+		     "TB bug workaround: copied %d bytes from 0x%llx to 0x%llx\n",
+		     len, (unsigned long long)oldphys,
+		     (unsigned long long)phys);
+
+	ret = 0;
+unmap:
+	if (meta)
+		dma_unmap_page(trans->dev, oldphys, len, DMA_TO_DEVICE);
+	else
+		dma_unmap_single(trans->dev, oldphys, len, DMA_TO_DEVICE);
+trace:
+	trace_iwlwifi_dev_tx_tb(trans->dev, skb, virt, phys, len);
+
+	return ret;
+}
+
+static int iwl_txq_gen2_build_amsdu(struct iwl_trans *trans,
+				    struct sk_buff *skb,
+				    struct iwl_tfh_tfd *tfd, int start_len,
+				    u8 hdr_len,
+				    struct iwl_device_tx_cmd *dev_cmd)
+{
+#ifdef CONFIG_INET
+	struct iwl_tx_cmd_gen2 *tx_cmd = (void *)dev_cmd->payload;
+	struct ieee80211_hdr *hdr = (void *)skb->data;
+	unsigned int snap_ip_tcp_hdrlen, ip_hdrlen, total_len, hdr_room;
+	unsigned int mss = skb_shinfo(skb)->gso_size;
+	u16 length, amsdu_pad;
+	u8 *start_hdr;
+	struct iwl_tso_hdr_page *hdr_page;
+	struct tso_t tso;
+
+	trace_iwlwifi_dev_tx(trans->dev, skb, tfd, sizeof(*tfd),
+			     &dev_cmd->hdr, start_len, 0);
+
+	ip_hdrlen = skb_network_header_len(skb);
+	snap_ip_tcp_hdrlen = 8 + ip_hdrlen + tcp_hdrlen(skb);
+	total_len = skb->len - snap_ip_tcp_hdrlen - hdr_len;
+	amsdu_pad = 0;
+
+	/* total amount of header we may need for this A-MSDU */
+	hdr_room = DIV_ROUND_UP(total_len, mss) *
+		(3 + snap_ip_tcp_hdrlen + sizeof(struct ethhdr));
+
+	/* Our device supports 9 segments at most, it will fit in 1 page */
+	hdr_page = iwl_pcie_get_page_hdr(trans, hdr_room, skb);
+	if (!hdr_page)
+		return -ENOMEM;
+
+	start_hdr = hdr_page->pos;
+
+	/*
+	 * Pull the ieee80211 header to be able to use TSO core,
+	 * we will restore it for the tx_status flow.
+	 */
+	skb_pull(skb, hdr_len);
+
+	/*
+	 * Remove the length of all the headers that we don't actually
+	 * have in the MPDU by themselves, but that we duplicate into
+	 * all the different MSDUs inside the A-MSDU.
+	 */
+	le16_add_cpu(&tx_cmd->len, -snap_ip_tcp_hdrlen);
+
+	tso_start(skb, &tso);
+
+	while (total_len) {
+		/* this is the data left for this subframe */
+		unsigned int data_left = min_t(unsigned int, mss, total_len);
+		unsigned int tb_len;
+		dma_addr_t tb_phys;
+		u8 *subf_hdrs_start = hdr_page->pos;
+
+		total_len -= data_left;
+
+		memset(hdr_page->pos, 0, amsdu_pad);
+		hdr_page->pos += amsdu_pad;
+		amsdu_pad = (4 - (sizeof(struct ethhdr) + snap_ip_tcp_hdrlen +
+				  data_left)) & 0x3;
+		ether_addr_copy(hdr_page->pos, ieee80211_get_DA(hdr));
+		hdr_page->pos += ETH_ALEN;
+		ether_addr_copy(hdr_page->pos, ieee80211_get_SA(hdr));
+		hdr_page->pos += ETH_ALEN;
+
+		length = snap_ip_tcp_hdrlen + data_left;
+		*((__be16 *)hdr_page->pos) = cpu_to_be16(length);
+		hdr_page->pos += sizeof(length);
+
+		/*
+		 * This will copy the SNAP as well which will be considered
+		 * as MAC header.
+		 */
+		tso_build_hdr(skb, hdr_page->pos, &tso, data_left, !total_len);
+
+		hdr_page->pos += snap_ip_tcp_hdrlen;
+
+		tb_len = hdr_page->pos - start_hdr;
+		tb_phys = dma_map_single(trans->dev, start_hdr,
+					 tb_len, DMA_TO_DEVICE);
+		if (unlikely(dma_mapping_error(trans->dev, tb_phys)))
+			goto out_err;
+		/*
+		 * No need for _with_wa, this is from the TSO page and
+		 * we leave some space at the end of it so can't hit
+		 * the buggy scenario.
+		 */
+		iwl_txq_gen2_set_tb(trans, tfd, tb_phys, tb_len);
+		trace_iwlwifi_dev_tx_tb(trans->dev, skb, start_hdr,
+					tb_phys, tb_len);
+		/* add this subframe's headers' length to the tx_cmd */
+		le16_add_cpu(&tx_cmd->len, hdr_page->pos - subf_hdrs_start);
+
+		/* prepare the start_hdr for the next subframe */
+		start_hdr = hdr_page->pos;
+
+		/* put the payload */
+		while (data_left) {
+			int ret;
+
+			tb_len = min_t(unsigned int, tso.size, data_left);
+			tb_phys = dma_map_single(trans->dev, tso.data,
+						 tb_len, DMA_TO_DEVICE);
+			ret = iwl_txq_gen2_set_tb_with_wa(trans, skb, tfd,
+							  tb_phys, tso.data,
+							  tb_len, NULL);
+			if (ret)
+				goto out_err;
+
+			data_left -= tb_len;
+			tso_build_data(skb, &tso, tb_len);
+		}
+	}
+
+	/* re -add the WiFi header */
+	skb_push(skb, hdr_len);
+
+	return 0;
+
+out_err:
+#endif
+	return -EINVAL;
+}
+
+static struct
+iwl_tfh_tfd *iwl_txq_gen2_build_tx_amsdu(struct iwl_trans *trans,
+					 struct iwl_txq *txq,
+					 struct iwl_device_tx_cmd *dev_cmd,
+					 struct sk_buff *skb,
+					 struct iwl_cmd_meta *out_meta,
+					 int hdr_len,
+					 int tx_cmd_len)
+{
+	int idx = iwl_txq_get_cmd_index(txq, txq->write_ptr);
+	struct iwl_tfh_tfd *tfd = iwl_txq_get_tfd(trans, txq, idx);
+	dma_addr_t tb_phys;
+	int len;
+	void *tb1_addr;
+
+	tb_phys = iwl_txq_get_first_tb_dma(txq, idx);
+
+	/*
+	 * No need for _with_wa, the first TB allocation is aligned up
+	 * to a 64-byte boundary and thus can't be at the end or cross
+	 * a page boundary (much less a 2^32 boundary).
+	 */
+	iwl_txq_gen2_set_tb(trans, tfd, tb_phys, IWL_FIRST_TB_SIZE);
+
+	/*
+	 * The second TB (tb1) points to the remainder of the TX command
+	 * and the 802.11 header - dword aligned size
+	 * (This calculation modifies the TX command, so do it before the
+	 * setup of the first TB)
+	 */
+	len = tx_cmd_len + sizeof(struct iwl_cmd_header) + hdr_len -
+	      IWL_FIRST_TB_SIZE;
+
+	/* do not align A-MSDU to dword as the subframe header aligns it */
+
+	/* map the data for TB1 */
+	tb1_addr = ((u8 *)&dev_cmd->hdr) + IWL_FIRST_TB_SIZE;
+	tb_phys = dma_map_single(trans->dev, tb1_addr, len, DMA_TO_DEVICE);
+	if (unlikely(dma_mapping_error(trans->dev, tb_phys)))
+		goto out_err;
+	/*
+	 * No need for _with_wa(), we ensure (via alignment) that the data
+	 * here can never cross or end at a page boundary.
+	 */
+	iwl_txq_gen2_set_tb(trans, tfd, tb_phys, len);
+
+	if (iwl_txq_gen2_build_amsdu(trans, skb, tfd, len + IWL_FIRST_TB_SIZE,
+				     hdr_len, dev_cmd))
+		goto out_err;
+
+	/* building the A-MSDU might have changed this data, memcpy it now */
+	memcpy(&txq->first_tb_bufs[idx], dev_cmd, IWL_FIRST_TB_SIZE);
+	return tfd;
+
+out_err:
+	iwl_txq_gen2_tfd_unmap(trans, out_meta, tfd);
+	return NULL;
+}
+
+static int iwl_txq_gen2_tx_add_frags(struct iwl_trans *trans,
+				     struct sk_buff *skb,
+				     struct iwl_tfh_tfd *tfd,
+				     struct iwl_cmd_meta *out_meta)
+{
+	int i;
+
+	for (i = 0; i < skb_shinfo(skb)->nr_frags; i++) {
+		const skb_frag_t *frag = &skb_shinfo(skb)->frags[i];
+		dma_addr_t tb_phys;
+		unsigned int fragsz = skb_frag_size(frag);
+		int ret;
+
+		if (!fragsz)
+			continue;
+
+		tb_phys = skb_frag_dma_map(trans->dev, frag, 0,
+					   fragsz, DMA_TO_DEVICE);
+		ret = iwl_txq_gen2_set_tb_with_wa(trans, skb, tfd, tb_phys,
+						  skb_frag_address(frag),
+						  fragsz, out_meta);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static struct
+iwl_tfh_tfd *iwl_txq_gen2_build_tx(struct iwl_trans *trans,
+				   struct iwl_txq *txq,
+				   struct iwl_device_tx_cmd *dev_cmd,
+				   struct sk_buff *skb,
+				   struct iwl_cmd_meta *out_meta,
+				   int hdr_len,
+				   int tx_cmd_len,
+				   bool pad)
+{
+	int idx = iwl_txq_get_cmd_index(txq, txq->write_ptr);
+	struct iwl_tfh_tfd *tfd = iwl_txq_get_tfd(trans, txq, idx);
+	dma_addr_t tb_phys;
+	int len, tb1_len, tb2_len;
+	void *tb1_addr;
+	struct sk_buff *frag;
+
+	tb_phys = iwl_txq_get_first_tb_dma(txq, idx);
+
+	/* The first TB points to bi-directional DMA data */
+	memcpy(&txq->first_tb_bufs[idx], dev_cmd, IWL_FIRST_TB_SIZE);
+
+	/*
+	 * No need for _with_wa, the first TB allocation is aligned up
+	 * to a 64-byte boundary and thus can't be at the end or cross
+	 * a page boundary (much less a 2^32 boundary).
+	 */
+	iwl_txq_gen2_set_tb(trans, tfd, tb_phys, IWL_FIRST_TB_SIZE);
+
+	/*
+	 * The second TB (tb1) points to the remainder of the TX command
+	 * and the 802.11 header - dword aligned size
+	 * (This calculation modifies the TX command, so do it before the
+	 * setup of the first TB)
+	 */
+	len = tx_cmd_len + sizeof(struct iwl_cmd_header) + hdr_len -
+	      IWL_FIRST_TB_SIZE;
+
+	if (pad)
+		tb1_len = ALIGN(len, 4);
+	else
+		tb1_len = len;
+
+	/* map the data for TB1 */
+	tb1_addr = ((u8 *)&dev_cmd->hdr) + IWL_FIRST_TB_SIZE;
+	tb_phys = dma_map_single(trans->dev, tb1_addr, tb1_len, DMA_TO_DEVICE);
+	if (unlikely(dma_mapping_error(trans->dev, tb_phys)))
+		goto out_err;
+	/*
+	 * No need for _with_wa(), we ensure (via alignment) that the data
+	 * here can never cross or end at a page boundary.
+	 */
+	iwl_txq_gen2_set_tb(trans, tfd, tb_phys, tb1_len);
+	trace_iwlwifi_dev_tx(trans->dev, skb, tfd, sizeof(*tfd), &dev_cmd->hdr,
+			     IWL_FIRST_TB_SIZE + tb1_len, hdr_len);
+
+	/* set up TFD's third entry to point to remainder of skb's head */
+	tb2_len = skb_headlen(skb) - hdr_len;
+
+	if (tb2_len > 0) {
+		int ret;
+
+		tb_phys = dma_map_single(trans->dev, skb->data + hdr_len,
+					 tb2_len, DMA_TO_DEVICE);
+		ret = iwl_txq_gen2_set_tb_with_wa(trans, skb, tfd, tb_phys,
+						  skb->data + hdr_len, tb2_len,
+						  NULL);
+		if (ret)
+			goto out_err;
+	}
+
+	if (iwl_txq_gen2_tx_add_frags(trans, skb, tfd, out_meta))
+		goto out_err;
+
+	skb_walk_frags(skb, frag) {
+		int ret;
+
+		tb_phys = dma_map_single(trans->dev, frag->data,
+					 skb_headlen(frag), DMA_TO_DEVICE);
+		ret = iwl_txq_gen2_set_tb_with_wa(trans, skb, tfd, tb_phys,
+						  frag->data,
+						  skb_headlen(frag), NULL);
+		if (ret)
+			goto out_err;
+		if (iwl_txq_gen2_tx_add_frags(trans, frag, tfd, out_meta))
+			goto out_err;
+	}
+
+	return tfd;
+
+out_err:
+	iwl_txq_gen2_tfd_unmap(trans, out_meta, tfd);
+	return NULL;
+}
+
+static
+struct iwl_tfh_tfd *iwl_txq_gen2_build_tfd(struct iwl_trans *trans,
+					   struct iwl_txq *txq,
+					   struct iwl_device_tx_cmd *dev_cmd,
+					   struct sk_buff *skb,
+					   struct iwl_cmd_meta *out_meta)
+{
+	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
+	int idx = iwl_txq_get_cmd_index(txq, txq->write_ptr);
+	struct iwl_tfh_tfd *tfd = iwl_txq_get_tfd(trans, txq, idx);
+	int len, hdr_len;
+	bool amsdu;
+
+	/* There must be data left over for TB1 or this code must be changed */
+	BUILD_BUG_ON(sizeof(struct iwl_tx_cmd_gen2) < IWL_FIRST_TB_SIZE);
+	BUILD_BUG_ON(sizeof(struct iwl_cmd_header) +
+		     offsetofend(struct iwl_tx_cmd_gen2, dram_info) >
+		     IWL_FIRST_TB_SIZE);
+	BUILD_BUG_ON(sizeof(struct iwl_tx_cmd_gen3) < IWL_FIRST_TB_SIZE);
+	BUILD_BUG_ON(sizeof(struct iwl_cmd_header) +
+		     offsetofend(struct iwl_tx_cmd_gen3, dram_info) >
+		     IWL_FIRST_TB_SIZE);
+
+	memset(tfd, 0, sizeof(*tfd));
+
+	if (trans->trans_cfg->device_family < IWL_DEVICE_FAMILY_AX210)
+		len = sizeof(struct iwl_tx_cmd_gen2);
+	else
+		len = sizeof(struct iwl_tx_cmd_gen3);
+
+	amsdu = ieee80211_is_data_qos(hdr->frame_control) &&
+			(*ieee80211_get_qos_ctl(hdr) &
+			 IEEE80211_QOS_CTL_A_MSDU_PRESENT);
+
+	hdr_len = ieee80211_hdrlen(hdr->frame_control);
+
+	/*
+	 * Only build A-MSDUs here if doing so by GSO, otherwise it may be
+	 * an A-MSDU for other reasons, e.g. NAN or an A-MSDU having been
+	 * built in the higher layers already.
+	 */
+	if (amsdu && skb_shinfo(skb)->gso_size)
+		return iwl_txq_gen2_build_tx_amsdu(trans, txq, dev_cmd, skb,
+						    out_meta, hdr_len, len);
+	return iwl_txq_gen2_build_tx(trans, txq, dev_cmd, skb, out_meta,
+				      hdr_len, len, !amsdu);
+}
+
+int iwl_txq_space(struct iwl_trans *trans, const struct iwl_txq *q)
+{
+	unsigned int max;
+	unsigned int used;
+
+	/*
+	 * To avoid ambiguity between empty and completely full queues, there
+	 * should always be less than max_tfd_queue_size elements in the queue.
+	 * If q->n_window is smaller than max_tfd_queue_size, there is no need
+	 * to reserve any queue entries for this purpose.
+	 */
+	if (q->n_window < trans->trans_cfg->base_params->max_tfd_queue_size)
+		max = q->n_window;
+	else
+		max = trans->trans_cfg->base_params->max_tfd_queue_size - 1;
+
+	/*
+	 * max_tfd_queue_size is a power of 2, so the following is equivalent to
+	 * modulo by max_tfd_queue_size and is well defined.
+	 */
+	used = (q->write_ptr - q->read_ptr) &
+		(trans->trans_cfg->base_params->max_tfd_queue_size - 1);
+
+	if (WARN_ON(used > max))
+		return 0;
+
+	return max - used;
+}
+
+/*
+ * iwl_pcie_gen2_update_byte_tbl - Set up entry in Tx byte-count array
+ */
+static void iwl_pcie_gen2_update_byte_tbl(struct iwl_trans *trans,
+					  struct iwl_txq *txq, u16 byte_cnt,
+					  int num_tbs)
+{
+	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
+	int idx = iwl_txq_get_cmd_index(txq, txq->write_ptr);
+	u8 filled_tfd_size, num_fetch_chunks;
+	u16 len = byte_cnt;
+	__le16 bc_ent;
+
+	if (WARN(idx >= txq->n_window, "%d >= %d\n", idx, txq->n_window))
+		return;
+
+	filled_tfd_size = offsetof(struct iwl_tfh_tfd, tbs) +
+			  num_tbs * sizeof(struct iwl_tfh_tb);
+	/*
+	 * filled_tfd_size contains the number of filled bytes in the TFD.
+	 * Dividing it by 64 will give the number of chunks to fetch
+	 * to SRAM- 0 for one chunk, 1 for 2 and so on.
+	 * If, for example, TFD contains only 3 TBs then 32 bytes
+	 * of the TFD are used, and only one chunk of 64 bytes should
+	 * be fetched
+	 */
+	num_fetch_chunks = DIV_ROUND_UP(filled_tfd_size, 64) - 1;
+
+	if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_AX210) {
+		struct iwl_gen3_bc_tbl_entry *scd_bc_tbl_gen3 = txq->bc_tbl.addr;
+
+		/* Starting from AX210, the HW expects bytes */
+		WARN_ON(trans_pcie->txqs.bc_table_dword);
+		WARN_ON(len > 0x3FFF);
+		bc_ent = cpu_to_le16(len | (num_fetch_chunks << 14));
+		scd_bc_tbl_gen3[idx].tfd_offset = bc_ent;
+	} else {
+		struct iwlagn_scd_bc_tbl *scd_bc_tbl = txq->bc_tbl.addr;
+
+		/* Before AX210, the HW expects DW */
+		WARN_ON(!trans_pcie->txqs.bc_table_dword);
+		len = DIV_ROUND_UP(len, 4);
+		WARN_ON(len > 0xFFF);
+		bc_ent = cpu_to_le16(len | (num_fetch_chunks << 12));
+		scd_bc_tbl->tfd_offset[idx] = bc_ent;
+	}
+}
+
+static u8 iwl_txq_gen2_get_num_tbs(struct iwl_tfh_tfd *tfd)
+{
+	return le16_to_cpu(tfd->num_tbs) & 0x1f;
+}
+
+int iwl_txq_gen2_set_tb(struct iwl_trans *trans, struct iwl_tfh_tfd *tfd,
+			dma_addr_t addr, u16 len)
+{
+	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
+	int idx = iwl_txq_gen2_get_num_tbs(tfd);
+	struct iwl_tfh_tb *tb;
+
+	/* Only WARN here so we know about the issue, but we mess up our
+	 * unmap path because not every place currently checks for errors
+	 * returned from this function - it can only return an error if
+	 * there's no more space, and so when we know there is enough we
+	 * don't always check ...
+	 */
+	WARN(iwl_txq_crosses_4g_boundary(addr, len),
+	     "possible DMA problem with iova:0x%llx, len:%d\n",
+	     (unsigned long long)addr, len);
+
+	if (WARN_ON(idx >= IWL_TFH_NUM_TBS))
+		return -EINVAL;
+	tb = &tfd->tbs[idx];
+
+	/* Each TFD can point to a maximum max_tbs Tx buffers */
+	if (le16_to_cpu(tfd->num_tbs) >= trans_pcie->txqs.tfd.max_tbs) {
+		IWL_ERR(trans, "Error can not send more than %d chunks\n",
+			trans_pcie->txqs.tfd.max_tbs);
+		return -EINVAL;
+	}
+
+	put_unaligned_le64(addr, &tb->addr);
+	tb->tb_len = cpu_to_le16(len);
+
+	tfd->num_tbs = cpu_to_le16(idx + 1);
+
+	return idx;
+}
+
+void iwl_txq_gen2_tfd_unmap(struct iwl_trans *trans,
+			    struct iwl_cmd_meta *meta,
+			    struct iwl_tfh_tfd *tfd)
+{
+	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
+	int i, num_tbs;
+
+	/* Sanity check on number of chunks */
+	num_tbs = iwl_txq_gen2_get_num_tbs(tfd);
+
+	if (num_tbs > trans_pcie->txqs.tfd.max_tbs) {
+		IWL_ERR(trans, "Too many chunks: %i\n", num_tbs);
+		return;
+	}
+
+	/* first TB is never freed - it's the bidirectional DMA data */
+	for (i = 1; i < num_tbs; i++) {
+		if (meta->tbs & BIT(i))
+			dma_unmap_page(trans->dev,
+				       le64_to_cpu(tfd->tbs[i].addr),
+				       le16_to_cpu(tfd->tbs[i].tb_len),
+				       DMA_TO_DEVICE);
+		else
+			dma_unmap_single(trans->dev,
+					 le64_to_cpu(tfd->tbs[i].addr),
+					 le16_to_cpu(tfd->tbs[i].tb_len),
+					 DMA_TO_DEVICE);
+	}
+
+	iwl_txq_set_tfd_invalid_gen2(trans, tfd);
+}
+
+static void iwl_txq_gen2_free_tfd(struct iwl_trans *trans, struct iwl_txq *txq)
+{
+	/* rd_ptr is bounded by TFD_QUEUE_SIZE_MAX and
+	 * idx is bounded by n_window
+	 */
+	int idx = iwl_txq_get_cmd_index(txq, txq->read_ptr);
+	struct sk_buff *skb;
+
+	lockdep_assert_held(&txq->lock);
+
+	if (!txq->entries)
+		return;
+
+	iwl_txq_gen2_tfd_unmap(trans, &txq->entries[idx].meta,
+			       iwl_txq_get_tfd(trans, txq, idx));
+
+	skb = txq->entries[idx].skb;
+
+	/* Can be called from irqs-disabled context
+	 * If skb is not NULL, it means that the whole queue is being
+	 * freed and that the queue is not empty - free the skb
+	 */
+	if (skb) {
+		iwl_op_mode_free_skb(trans->op_mode, skb);
+		txq->entries[idx].skb = NULL;
+	}
+}
+
+/*
+ * iwl_txq_inc_wr_ptr - Send new write index to hardware
+ */
+static void iwl_txq_inc_wr_ptr(struct iwl_trans *trans, struct iwl_txq *txq)
+{
+	lockdep_assert_held(&txq->lock);
+
+	IWL_DEBUG_TX(trans, "Q:%d WR: 0x%x\n", txq->id, txq->write_ptr);
+
+	/*
+	 * if not in power-save mode, uCode will never sleep when we're
+	 * trying to tx (during RFKILL, we're not trying to tx).
+	 */
+	iwl_write32(trans, HBUS_TARG_WRPTR, txq->write_ptr | (txq->id << 16));
+}
+
+int iwl_txq_gen2_tx(struct iwl_trans *trans, struct sk_buff *skb,
+		    struct iwl_device_tx_cmd *dev_cmd, int txq_id)
+{
+	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
+	struct iwl_cmd_meta *out_meta;
+	struct iwl_txq *txq = trans_pcie->txqs.txq[txq_id];
+	u16 cmd_len;
+	int idx;
+	void *tfd;
+
+	if (WARN_ONCE(txq_id >= IWL_MAX_TVQM_QUEUES,
+		      "queue %d out of range", txq_id))
+		return -EINVAL;
+
+	if (WARN_ONCE(!test_bit(txq_id, trans_pcie->txqs.queue_used),
+		      "TX on unused queue %d\n", txq_id))
+		return -EINVAL;
+
+	if (skb_is_nonlinear(skb) &&
+	    skb_shinfo(skb)->nr_frags > IWL_TRANS_PCIE_MAX_FRAGS(trans_pcie) &&
+	    __skb_linearize(skb))
+		return -ENOMEM;
+
+	spin_lock(&txq->lock);
+
+	if (iwl_txq_space(trans, txq) < txq->high_mark) {
+		iwl_txq_stop(trans, txq);
+
+		/* don't put the packet on the ring, if there is no room */
+		if (unlikely(iwl_txq_space(trans, txq) < 3)) {
+			struct iwl_device_tx_cmd **dev_cmd_ptr;
+
+			dev_cmd_ptr = (void *)((u8 *)skb->cb +
+					       trans_pcie->txqs.dev_cmd_offs);
+
+			*dev_cmd_ptr = dev_cmd;
+			__skb_queue_tail(&txq->overflow_q, skb);
+			spin_unlock(&txq->lock);
+			return 0;
+		}
+	}
+
+	idx = iwl_txq_get_cmd_index(txq, txq->write_ptr);
+
+	/* Set up driver data for this TFD */
+	txq->entries[idx].skb = skb;
+	txq->entries[idx].cmd = dev_cmd;
+
+	dev_cmd->hdr.sequence =
+		cpu_to_le16((u16)(QUEUE_TO_SEQ(txq_id) |
+			    INDEX_TO_SEQ(idx)));
+
+	/* Set up first empty entry in queue's array of Tx/cmd buffers */
+	out_meta = &txq->entries[idx].meta;
+	out_meta->flags = 0;
+
+	tfd = iwl_txq_gen2_build_tfd(trans, txq, dev_cmd, skb, out_meta);
+	if (!tfd) {
+		spin_unlock(&txq->lock);
+		return -1;
+	}
+
+	if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_AX210) {
+		struct iwl_tx_cmd_gen3 *tx_cmd_gen3 =
+			(void *)dev_cmd->payload;
+
+		cmd_len = le16_to_cpu(tx_cmd_gen3->len);
+	} else {
+		struct iwl_tx_cmd_gen2 *tx_cmd_gen2 =
+			(void *)dev_cmd->payload;
+
+		cmd_len = le16_to_cpu(tx_cmd_gen2->len);
+	}
+
+	/* Set up entry for this TFD in Tx byte-count array */
+	iwl_pcie_gen2_update_byte_tbl(trans, txq, cmd_len,
+				      iwl_txq_gen2_get_num_tbs(tfd));
+
+	/* start timer if queue currently empty */
+	if (txq->read_ptr == txq->write_ptr && txq->wd_timeout)
+		mod_timer(&txq->stuck_timer, jiffies + txq->wd_timeout);
+
+	/* Tell device the write index *just past* this latest filled TFD */
+	txq->write_ptr = iwl_txq_inc_wrap(trans, txq->write_ptr);
+	iwl_txq_inc_wr_ptr(trans, txq);
+	/*
+	 * At this point the frame is "transmitted" successfully
+	 * and we will get a TX status notification eventually.
+	 */
+	spin_unlock(&txq->lock);
+	return 0;
+}
+
+/*************** HOST COMMAND QUEUE FUNCTIONS   *****/
+
+/*
+ * iwl_txq_gen2_unmap -  Unmap any remaining DMA mappings and free skb's
+ */
+static void iwl_txq_gen2_unmap(struct iwl_trans *trans, int txq_id)
+{
+	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
+	struct iwl_txq *txq = trans_pcie->txqs.txq[txq_id];
+
+	spin_lock_bh(&txq->lock);
+	while (txq->write_ptr != txq->read_ptr) {
+		IWL_DEBUG_TX_REPLY(trans, "Q %d Free %d\n",
+				   txq_id, txq->read_ptr);
+
+		if (txq_id != trans_pcie->txqs.cmd.q_id) {
+			int idx = iwl_txq_get_cmd_index(txq, txq->read_ptr);
+			struct sk_buff *skb = txq->entries[idx].skb;
+
+			if (!WARN_ON_ONCE(!skb))
+				iwl_pcie_free_tso_page(trans, skb);
+		}
+		iwl_txq_gen2_free_tfd(trans, txq);
+		txq->read_ptr = iwl_txq_inc_wrap(trans, txq->read_ptr);
+	}
+
+	while (!skb_queue_empty(&txq->overflow_q)) {
+		struct sk_buff *skb = __skb_dequeue(&txq->overflow_q);
+
+		iwl_op_mode_free_skb(trans->op_mode, skb);
+	}
+
+	spin_unlock_bh(&txq->lock);
+
+	/* just in case - this queue may have been stopped */
+	iwl_trans_pcie_wake_queue(trans, txq);
+}
+
+static void iwl_txq_gen2_free_memory(struct iwl_trans *trans,
+				     struct iwl_txq *txq)
+{
+	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
+	struct device *dev = trans->dev;
+
+	/* De-alloc circular buffer of TFDs */
+	if (txq->tfds) {
+		dma_free_coherent(dev,
+				  trans_pcie->txqs.tfd.size * txq->n_window,
+				  txq->tfds, txq->dma_addr);
+		dma_free_coherent(dev,
+				  sizeof(*txq->first_tb_bufs) * txq->n_window,
+				  txq->first_tb_bufs, txq->first_tb_dma);
+	}
+
+	kfree(txq->entries);
+	if (txq->bc_tbl.addr)
+		dma_pool_free(trans_pcie->txqs.bc_pool,
+			      txq->bc_tbl.addr, txq->bc_tbl.dma);
+	kfree(txq);
+}
+
+/*
+ * iwl_pcie_txq_free - Deallocate DMA queue.
+ * @txq: Transmit queue to deallocate.
+ *
+ * Empty queue by removing and destroying all BD's.
+ * Free all buffers.
+ * 0-fill, but do not free "txq" descriptor structure.
+ */
+static void iwl_txq_gen2_free(struct iwl_trans *trans, int txq_id)
+{
+	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
+	struct iwl_txq *txq;
+	int i;
+
+	if (WARN_ONCE(txq_id >= IWL_MAX_TVQM_QUEUES,
+		      "queue %d out of range", txq_id))
+		return;
+
+	txq = trans_pcie->txqs.txq[txq_id];
+
+	if (WARN_ON(!txq))
+		return;
+
+	iwl_txq_gen2_unmap(trans, txq_id);
+
+	/* De-alloc array of command/tx buffers */
+	if (txq_id == trans_pcie->txqs.cmd.q_id)
+		for (i = 0; i < txq->n_window; i++) {
+			kfree_sensitive(txq->entries[i].cmd);
+			kfree_sensitive(txq->entries[i].free_buf);
+		}
+	del_timer_sync(&txq->stuck_timer);
+
+	iwl_txq_gen2_free_memory(trans, txq);
+
+	trans_pcie->txqs.txq[txq_id] = NULL;
+
+	clear_bit(txq_id, trans_pcie->txqs.queue_used);
+}
+
+static struct iwl_txq *
+iwl_txq_dyn_alloc_dma(struct iwl_trans *trans, int size, unsigned int timeout)
+{
+	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
+	size_t bc_tbl_size, bc_tbl_entries;
+	struct iwl_txq *txq;
+	int ret;
+
+	WARN_ON(!trans_pcie->txqs.bc_tbl_size);
+
+	bc_tbl_size = trans_pcie->txqs.bc_tbl_size;
+	bc_tbl_entries = bc_tbl_size / sizeof(u16);
+
+	if (WARN_ON(size > bc_tbl_entries))
+		return ERR_PTR(-EINVAL);
+
+	txq = kzalloc(sizeof(*txq), GFP_KERNEL);
+	if (!txq)
+		return ERR_PTR(-ENOMEM);
+
+	txq->bc_tbl.addr = dma_pool_alloc(trans_pcie->txqs.bc_pool, GFP_KERNEL,
+					  &txq->bc_tbl.dma);
+	if (!txq->bc_tbl.addr) {
+		IWL_ERR(trans, "Scheduler BC Table allocation failed\n");
+		kfree(txq);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	ret = iwl_pcie_txq_alloc(trans, txq, size, false);
+	if (ret) {
+		IWL_ERR(trans, "Tx queue alloc failed\n");
+		goto error;
+	}
+	ret = iwl_txq_init(trans, txq, size, false);
+	if (ret) {
+		IWL_ERR(trans, "Tx queue init failed\n");
+		goto error;
+	}
+
+	txq->wd_timeout = msecs_to_jiffies(timeout);
+
+	return txq;
+
+error:
+	iwl_txq_gen2_free_memory(trans, txq);
+	return ERR_PTR(ret);
+}
+
+static int iwl_pcie_txq_alloc_response(struct iwl_trans *trans,
+				       struct iwl_txq *txq,
+				       struct iwl_host_cmd *hcmd)
+{
+	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
+	struct iwl_tx_queue_cfg_rsp *rsp;
+	int ret, qid;
+	u32 wr_ptr;
+
+	if (WARN_ON(iwl_rx_packet_payload_len(hcmd->resp_pkt) !=
+		    sizeof(*rsp))) {
+		ret = -EINVAL;
+		goto error_free_resp;
+	}
+
+	rsp = (void *)hcmd->resp_pkt->data;
+	qid = le16_to_cpu(rsp->queue_number);
+	wr_ptr = le16_to_cpu(rsp->write_pointer);
+
+	if (qid >= ARRAY_SIZE(trans_pcie->txqs.txq)) {
+		WARN_ONCE(1, "queue index %d unsupported", qid);
+		ret = -EIO;
+		goto error_free_resp;
+	}
+
+	if (test_and_set_bit(qid, trans_pcie->txqs.queue_used)) {
+		WARN_ONCE(1, "queue %d already used", qid);
+		ret = -EIO;
+		goto error_free_resp;
+	}
+
+	if (WARN_ONCE(trans_pcie->txqs.txq[qid],
+		      "queue %d already allocated\n", qid)) {
+		ret = -EIO;
+		goto error_free_resp;
+	}
+
+	txq->id = qid;
+	trans_pcie->txqs.txq[qid] = txq;
+	wr_ptr &= (trans->trans_cfg->base_params->max_tfd_queue_size - 1);
+
+	/* Place first TFD at index corresponding to start sequence number */
+	txq->read_ptr = wr_ptr;
+	txq->write_ptr = wr_ptr;
+
+	IWL_DEBUG_TX_QUEUES(trans, "Activate queue %d\n", qid);
+
+	iwl_free_resp(hcmd);
+	return qid;
+
+error_free_resp:
+	iwl_free_resp(hcmd);
+	iwl_txq_gen2_free_memory(trans, txq);
+	return ret;
+}
+
+int iwl_txq_dyn_alloc(struct iwl_trans *trans, u32 flags, u32 sta_mask,
+		      u8 tid, int size, unsigned int timeout)
+{
+	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
+	struct iwl_txq *txq;
+	union {
+		struct iwl_tx_queue_cfg_cmd old;
+		struct iwl_scd_queue_cfg_cmd new;
+	} cmd;
+	struct iwl_host_cmd hcmd = {
+		.flags = CMD_WANT_SKB,
+	};
+	int ret;
+
+	/* take the min with bytecount table entries allowed */
+	size = min_t(u32, size, trans_pcie->txqs.bc_tbl_size / sizeof(u16));
+	/* but must be power of 2 values for calculating read/write pointers */
+	size = rounddown_pow_of_two(size);
+
+	if (trans->trans_cfg->device_family == IWL_DEVICE_FAMILY_BZ &&
+	    trans->hw_rev_step == SILICON_A_STEP) {
+		size = 4096;
+		txq = iwl_txq_dyn_alloc_dma(trans, size, timeout);
+	} else {
+		do {
+			txq = iwl_txq_dyn_alloc_dma(trans, size, timeout);
+			if (!IS_ERR(txq))
+				break;
+
+			IWL_DEBUG_TX_QUEUES(trans,
+					    "Failed allocating TXQ of size %d for sta mask %x tid %d, ret: %ld\n",
+					    size, sta_mask, tid,
+					    PTR_ERR(txq));
+			size /= 2;
+		} while (size >= 16);
+	}
+
+	if (IS_ERR(txq))
+		return PTR_ERR(txq);
+
+	if (trans_pcie->txqs.queue_alloc_cmd_ver == 0) {
+		memset(&cmd.old, 0, sizeof(cmd.old));
+		cmd.old.tfdq_addr = cpu_to_le64(txq->dma_addr);
+		cmd.old.byte_cnt_addr = cpu_to_le64(txq->bc_tbl.dma);
+		cmd.old.cb_size = cpu_to_le32(TFD_QUEUE_CB_SIZE(size));
+		cmd.old.flags = cpu_to_le16(flags | TX_QUEUE_CFG_ENABLE_QUEUE);
+		cmd.old.tid = tid;
+
+		if (hweight32(sta_mask) != 1) {
+			ret = -EINVAL;
+			goto error;
+		}
+		cmd.old.sta_id = ffs(sta_mask) - 1;
+
+		hcmd.id = SCD_QUEUE_CFG;
+		hcmd.len[0] = sizeof(cmd.old);
+		hcmd.data[0] = &cmd.old;
+	} else if (trans_pcie->txqs.queue_alloc_cmd_ver == 3) {
+		memset(&cmd.new, 0, sizeof(cmd.new));
+		cmd.new.operation = cpu_to_le32(IWL_SCD_QUEUE_ADD);
+		cmd.new.u.add.tfdq_dram_addr = cpu_to_le64(txq->dma_addr);
+		cmd.new.u.add.bc_dram_addr = cpu_to_le64(txq->bc_tbl.dma);
+		cmd.new.u.add.cb_size = cpu_to_le32(TFD_QUEUE_CB_SIZE(size));
+		cmd.new.u.add.flags = cpu_to_le32(flags);
+		cmd.new.u.add.sta_mask = cpu_to_le32(sta_mask);
+		cmd.new.u.add.tid = tid;
+
+		hcmd.id = WIDE_ID(DATA_PATH_GROUP, SCD_QUEUE_CONFIG_CMD);
+		hcmd.len[0] = sizeof(cmd.new);
+		hcmd.data[0] = &cmd.new;
+	} else {
+		ret = -EOPNOTSUPP;
+		goto error;
+	}
+
+	ret = iwl_trans_send_cmd(trans, &hcmd);
+	if (ret)
+		goto error;
+
+	return iwl_pcie_txq_alloc_response(trans, txq, &hcmd);
+
+error:
+	iwl_txq_gen2_free_memory(trans, txq);
+	return ret;
+}
+
+void iwl_txq_dyn_free(struct iwl_trans *trans, int queue)
+{
+	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
+
+	if (WARN(queue >= IWL_MAX_TVQM_QUEUES,
+		 "queue %d out of range", queue))
+		return;
+
+	/*
+	 * Upon HW Rfkill - we stop the device, and then stop the queues
+	 * in the op_mode. Just for the sake of the simplicity of the op_mode,
+	 * allow the op_mode to call txq_disable after it already called
+	 * stop_device.
+	 */
+	if (!test_and_clear_bit(queue, trans_pcie->txqs.queue_used)) {
+		WARN_ONCE(test_bit(STATUS_DEVICE_ENABLED, &trans->status),
+			  "queue %d not used", queue);
+		return;
+	}
+
+	iwl_txq_gen2_free(trans, queue);
+
+	IWL_DEBUG_TX_QUEUES(trans, "Deactivate queue %d\n", queue);
+}
+
+void iwl_txq_gen2_tx_free(struct iwl_trans *trans)
+{
+	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
+	int i;
+
+	memset(trans_pcie->txqs.queue_used, 0,
+	       sizeof(trans_pcie->txqs.queue_used));
+
+	/* Free all TX queues */
+	for (i = 0; i < ARRAY_SIZE(trans_pcie->txqs.txq); i++) {
+		if (!trans_pcie->txqs.txq[i])
+			continue;
+
+		iwl_txq_gen2_free(trans, i);
+	}
+}
+
+int iwl_txq_gen2_init(struct iwl_trans *trans, int txq_id, int queue_size)
+{
+	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
+	struct iwl_txq *queue;
+	int ret;
+
+	/* alloc and init the tx queue */
+	if (!trans_pcie->txqs.txq[txq_id]) {
+		queue = kzalloc(sizeof(*queue), GFP_KERNEL);
+		if (!queue) {
+			IWL_ERR(trans, "Not enough memory for tx queue\n");
+			return -ENOMEM;
+		}
+		trans_pcie->txqs.txq[txq_id] = queue;
+		ret = iwl_pcie_txq_alloc(trans, queue, queue_size, true);
+		if (ret) {
+			IWL_ERR(trans, "Tx %d queue init failed\n", txq_id);
+			goto error;
+		}
+	} else {
+		queue = trans_pcie->txqs.txq[txq_id];
+	}
+
+	ret = iwl_txq_init(trans, queue, queue_size,
+			   (txq_id == trans_pcie->txqs.cmd.q_id));
+	if (ret) {
+		IWL_ERR(trans, "Tx %d queue alloc failed\n", txq_id);
+		goto error;
+	}
+	trans_pcie->txqs.txq[txq_id]->id = txq_id;
+	set_bit(txq_id, trans_pcie->txqs.queue_used);
+
+	return 0;
+
+error:
+	iwl_txq_gen2_tx_free(trans);
+	return ret;
+}
 
 /*************** HOST COMMAND QUEUE FUNCTIONS   *****/
 
@@ -28,7 +1148,7 @@ int iwl_pcie_gen2_enqueue_hcmd(struct iwl_trans *trans,
 			       struct iwl_host_cmd *cmd)
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
-	struct iwl_txq *txq = trans->txqs.txq[trans->txqs.cmd.q_id];
+	struct iwl_txq *txq = trans_pcie->txqs.txq[trans_pcie->txqs.cmd.q_id];
 	struct iwl_device_cmd *out_cmd;
 	struct iwl_cmd_meta *out_meta;
 	void *dup_buf = NULL;
@@ -143,7 +1263,7 @@ int iwl_pcie_gen2_enqueue_hcmd(struct iwl_trans *trans,
 		cpu_to_le16(cmd_size - sizeof(struct iwl_cmd_header_wide));
 	out_cmd->hdr_wide.reserved = 0;
 	out_cmd->hdr_wide.sequence =
-		cpu_to_le16(QUEUE_TO_SEQ(trans->txqs.cmd.q_id) |
+		cpu_to_le16(QUEUE_TO_SEQ(trans_pcie->txqs.cmd.q_id) |
 					 INDEX_TO_SEQ(txq->write_ptr));
 
 	cmd_pos = sizeof(struct iwl_cmd_header_wide);
@@ -191,7 +1311,7 @@ int iwl_pcie_gen2_enqueue_hcmd(struct iwl_trans *trans,
 		     "Sending command %s (%.2x.%.2x), seq: 0x%04X, %d bytes at %d[%d]:%d\n",
 		     iwl_get_cmd_string(trans, cmd->id), group_id,
 		     out_cmd->hdr.cmd, le16_to_cpu(out_cmd->hdr.sequence),
-		     cmd_size, txq->write_ptr, idx, trans->txqs.cmd.q_id);
+		     cmd_size, txq->write_ptr, idx, trans_pcie->txqs.cmd.q_id);
 
 	/* start the TFD with the minimum copy bytes */
 	tb0_size = min_t(int, copy_size, IWL_FIRST_TB_SIZE);
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
index fa8eba47dc4c..fd47c4400b4e 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
@@ -1,16 +1,22 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2003-2014, 2018-2021, 2023 Intel Corporation
+ * Copyright (C) 2003-2014, 2018-2021, 2023-2024 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
 #include <linux/etherdevice.h>
 #include <linux/ieee80211.h>
+#include <linux/dmapool.h>
 #include <linux/slab.h>
 #include <linux/sched.h>
+#include <linux/tcp.h>
 #include <net/ip6_checksum.h>
 #include <net/tso.h>
 
+#include "fw/api/commands.h"
+#include "fw/api/datapath.h"
+#include "fw/api/debug.h"
+#include "iwl-fh.h"
 #include "iwl-debug.h"
 #include "iwl-csr.h"
 #include "iwl-prph.h"
@@ -72,6 +78,7 @@ void iwl_pcie_free_dma_ptr(struct iwl_trans *trans, struct iwl_dma_ptr *ptr)
 static void iwl_pcie_txq_inc_wr_ptr(struct iwl_trans *trans,
 				    struct iwl_txq *txq)
 {
+	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 	u32 reg = 0;
 	int txq_id = txq->id;
 
@@ -84,7 +91,7 @@ static void iwl_pcie_txq_inc_wr_ptr(struct iwl_trans *trans,
 	 * 3. there is a chance that the NIC is asleep
 	 */
 	if (!trans->trans_cfg->base_params->shadow_reg_enable &&
-	    txq_id != trans->txqs.cmd.q_id &&
+	    txq_id != trans_pcie->txqs.cmd.q_id &&
 	    test_bit(STATUS_TPOWER_PMI, &trans->status)) {
 		/*
 		 * wake up nic if it's powered down ...
@@ -115,12 +122,13 @@ static void iwl_pcie_txq_inc_wr_ptr(struct iwl_trans *trans,
 
 void iwl_pcie_txq_check_wrptrs(struct iwl_trans *trans)
 {
+	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 	int i;
 
 	for (i = 0; i < trans->trans_cfg->base_params->num_of_queues; i++) {
-		struct iwl_txq *txq = trans->txqs.txq[i];
+		struct iwl_txq *txq = trans_pcie->txqs.txq[i];
 
-		if (!test_bit(i, trans->txqs.queue_used))
+		if (!test_bit(i, trans_pcie->txqs.queue_used))
 			continue;
 
 		spin_lock_bh(&txq->lock);
@@ -132,23 +140,43 @@ void iwl_pcie_txq_check_wrptrs(struct iwl_trans *trans)
 	}
 }
 
+static inline void iwl_pcie_gen1_tfd_set_tb(struct iwl_tfd *tfd,
+					    u8 idx, dma_addr_t addr, u16 len)
+{
+	struct iwl_tfd_tb *tb = &tfd->tbs[idx];
+	u16 hi_n_len = len << 4;
+
+	put_unaligned_le32(addr, &tb->lo);
+	hi_n_len |= iwl_get_dma_hi_addr(addr);
+
+	tb->hi_n_len = cpu_to_le16(hi_n_len);
+
+	tfd->num_tbs = idx + 1;
+}
+
+static inline u8 iwl_txq_gen1_tfd_get_num_tbs(struct iwl_tfd *tfd)
+{
+	return tfd->num_tbs & 0x1f;
+}
+
 static int iwl_pcie_txq_build_tfd(struct iwl_trans *trans, struct iwl_txq *txq,
 				  dma_addr_t addr, u16 len, bool reset)
 {
+	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 	void *tfd;
 	u32 num_tbs;
 
-	tfd = (u8 *)txq->tfds + trans->txqs.tfd.size * txq->write_ptr;
+	tfd = (u8 *)txq->tfds + trans_pcie->txqs.tfd.size * txq->write_ptr;
 
 	if (reset)
-		memset(tfd, 0, trans->txqs.tfd.size);
+		memset(tfd, 0, trans_pcie->txqs.tfd.size);
 
-	num_tbs = iwl_txq_gen1_tfd_get_num_tbs(trans, tfd);
+	num_tbs = iwl_txq_gen1_tfd_get_num_tbs(tfd);
 
 	/* Each TFD can point to a maximum max_tbs Tx buffers */
-	if (num_tbs >= trans->txqs.tfd.max_tbs) {
+	if (num_tbs >= trans_pcie->txqs.tfd.max_tbs) {
 		IWL_ERR(trans, "Error can not send more than %d chunks\n",
-			trans->txqs.tfd.max_tbs);
+			trans_pcie->txqs.tfd.max_tbs);
 		return -EINVAL;
 	}
 
@@ -156,7 +184,7 @@ static int iwl_pcie_txq_build_tfd(struct iwl_trans *trans, struct iwl_txq *txq,
 		 "Unaligned address = %llx\n", (unsigned long long)addr))
 		return -EINVAL;
 
-	iwl_pcie_gen1_tfd_set_tb(trans, tfd, num_tbs, addr, len);
+	iwl_pcie_gen1_tfd_set_tb(tfd, num_tbs, addr, len);
 
 	return num_tbs;
 }
@@ -181,12 +209,147 @@ static void iwl_pcie_clear_cmd_in_flight(struct iwl_trans *trans)
 	spin_unlock(&trans_pcie->reg_lock);
 }
 
+void iwl_pcie_free_tso_page(struct iwl_trans *trans, struct sk_buff *skb)
+{
+	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
+	struct page **page_ptr;
+	struct page *next;
+
+	page_ptr = (void *)((u8 *)skb->cb + trans_pcie->txqs.page_offs);
+	next = *page_ptr;
+	*page_ptr = NULL;
+
+	while (next) {
+		struct page *tmp = next;
+
+		next = *(void **)((u8 *)page_address(next) + PAGE_SIZE -
+				  sizeof(void *));
+		__free_page(tmp);
+	}
+}
+
+static inline dma_addr_t
+iwl_txq_gen1_tfd_tb_get_addr(struct iwl_tfd *tfd, u8 idx)
+{
+	struct iwl_tfd_tb *tb = &tfd->tbs[idx];
+	dma_addr_t addr;
+	dma_addr_t hi_len;
+
+	addr = get_unaligned_le32(&tb->lo);
+
+	if (sizeof(dma_addr_t) <= sizeof(u32))
+		return addr;
+
+	hi_len = le16_to_cpu(tb->hi_n_len) & 0xF;
+
+	/*
+	 * shift by 16 twice to avoid warnings on 32-bit
+	 * (where this code never runs anyway due to the
+	 * if statement above)
+	 */
+	return addr | ((hi_len << 16) << 16);
+}
+
+static void iwl_txq_set_tfd_invalid_gen1(struct iwl_trans *trans,
+					 struct iwl_tfd *tfd)
+{
+	tfd->num_tbs = 0;
+
+	iwl_pcie_gen1_tfd_set_tb(tfd, 0, trans->invalid_tx_cmd.dma,
+				 trans->invalid_tx_cmd.size);
+}
+
+static void iwl_txq_gen1_tfd_unmap(struct iwl_trans *trans,
+				   struct iwl_cmd_meta *meta,
+				   struct iwl_txq *txq, int index)
+{
+	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
+	int i, num_tbs;
+	struct iwl_tfd *tfd = iwl_txq_get_tfd(trans, txq, index);
+
+	/* Sanity check on number of chunks */
+	num_tbs = iwl_txq_gen1_tfd_get_num_tbs(tfd);
+
+	if (num_tbs > trans_pcie->txqs.tfd.max_tbs) {
+		IWL_ERR(trans, "Too many chunks: %i\n", num_tbs);
+		/* @todo issue fatal error, it is quite serious situation */
+		return;
+	}
+
+	/* first TB is never freed - it's the bidirectional DMA data */
+
+	for (i = 1; i < num_tbs; i++) {
+		if (meta->tbs & BIT(i))
+			dma_unmap_page(trans->dev,
+				       iwl_txq_gen1_tfd_tb_get_addr(tfd, i),
+				       iwl_txq_gen1_tfd_tb_get_len(trans,
+								   tfd, i),
+				       DMA_TO_DEVICE);
+		else
+			dma_unmap_single(trans->dev,
+					 iwl_txq_gen1_tfd_tb_get_addr(tfd, i),
+					 iwl_txq_gen1_tfd_tb_get_len(trans,
+								     tfd, i),
+					 DMA_TO_DEVICE);
+	}
+
+	meta->tbs = 0;
+
+	iwl_txq_set_tfd_invalid_gen1(trans, tfd);
+}
+
+/**
+ * iwl_txq_free_tfd - Free all chunks referenced by TFD [txq->q.read_ptr]
+ * @trans: transport private data
+ * @txq: tx queue
+ *
+ * Does NOT advance any TFD circular buffer read/write indexes
+ * Does NOT free the TFD itself (which is within circular buffer)
+ */
+static void iwl_txq_free_tfd(struct iwl_trans *trans, struct iwl_txq *txq)
+{
+	/* rd_ptr is bounded by TFD_QUEUE_SIZE_MAX and
+	 * idx is bounded by n_window
+	 */
+	int rd_ptr = txq->read_ptr;
+	int idx = iwl_txq_get_cmd_index(txq, rd_ptr);
+	struct sk_buff *skb;
+
+	lockdep_assert_held(&txq->lock);
+
+	if (!txq->entries)
+		return;
+
+	/* We have only q->n_window txq->entries, but we use
+	 * TFD_QUEUE_SIZE_MAX tfds
+	 */
+	if (trans->trans_cfg->gen2)
+		iwl_txq_gen2_tfd_unmap(trans, &txq->entries[idx].meta,
+				       iwl_txq_get_tfd(trans, txq, rd_ptr));
+	else
+		iwl_txq_gen1_tfd_unmap(trans, &txq->entries[idx].meta,
+				       txq, rd_ptr);
+
+	/* free SKB */
+	skb = txq->entries[idx].skb;
+
+	/* Can be called from irqs-disabled context
+	 * If skb is not NULL, it means that the whole queue is being
+	 * freed and that the queue is not empty - free the skb
+	 */
+	if (skb) {
+		iwl_op_mode_free_skb(trans->op_mode, skb);
+		txq->entries[idx].skb = NULL;
+	}
+}
+
 /*
  * iwl_pcie_txq_unmap -  Unmap any remaining DMA mappings and free skb's
  */
 static void iwl_pcie_txq_unmap(struct iwl_trans *trans, int txq_id)
 {
-	struct iwl_txq *txq = trans->txqs.txq[txq_id];
+	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
+	struct iwl_txq *txq = trans_pcie->txqs.txq[txq_id];
 
 	if (!txq) {
 		IWL_ERR(trans, "Trying to free a queue that wasn't allocated?\n");
@@ -198,19 +361,19 @@ static void iwl_pcie_txq_unmap(struct iwl_trans *trans, int txq_id)
 		IWL_DEBUG_TX_REPLY(trans, "Q %d Free %d\n",
 				   txq_id, txq->read_ptr);
 
-		if (txq_id != trans->txqs.cmd.q_id) {
+		if (txq_id != trans_pcie->txqs.cmd.q_id) {
 			struct sk_buff *skb = txq->entries[txq->read_ptr].skb;
 
 			if (WARN_ON_ONCE(!skb))
 				continue;
 
-			iwl_txq_free_tso_page(trans, skb);
+			iwl_pcie_free_tso_page(trans, skb);
 		}
 		iwl_txq_free_tfd(trans, txq);
 		txq->read_ptr = iwl_txq_inc_wrap(trans, txq->read_ptr);
 
 		if (txq->read_ptr == txq->write_ptr &&
-		    txq_id == trans->txqs.cmd.q_id)
+		    txq_id == trans_pcie->txqs.cmd.q_id)
 			iwl_pcie_clear_cmd_in_flight(trans);
 	}
 
@@ -223,7 +386,7 @@ static void iwl_pcie_txq_unmap(struct iwl_trans *trans, int txq_id)
 	spin_unlock_bh(&txq->lock);
 
 	/* just in case - this queue may have been stopped */
-	iwl_wake_queue(trans, txq);
+	iwl_trans_pcie_wake_queue(trans, txq);
 }
 
 /*
@@ -236,7 +399,8 @@ static void iwl_pcie_txq_unmap(struct iwl_trans *trans, int txq_id)
  */
 static void iwl_pcie_txq_free(struct iwl_trans *trans, int txq_id)
 {
-	struct iwl_txq *txq = trans->txqs.txq[txq_id];
+	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
+	struct iwl_txq *txq = trans_pcie->txqs.txq[txq_id];
 	struct device *dev = trans->dev;
 	int i;
 
@@ -246,7 +410,7 @@ static void iwl_pcie_txq_free(struct iwl_trans *trans, int txq_id)
 	iwl_pcie_txq_unmap(trans, txq_id);
 
 	/* De-alloc array of command/tx buffers */
-	if (txq_id == trans->txqs.cmd.q_id)
+	if (txq_id == trans_pcie->txqs.cmd.q_id)
 		for (i = 0; i < txq->n_window; i++) {
 			kfree_sensitive(txq->entries[i].cmd);
 			kfree_sensitive(txq->entries[i].free_buf);
@@ -255,7 +419,7 @@ static void iwl_pcie_txq_free(struct iwl_trans *trans, int txq_id)
 	/* De-alloc circular buffer of TFDs */
 	if (txq->tfds) {
 		dma_free_coherent(dev,
-				  trans->txqs.tfd.size *
+				  trans_pcie->txqs.tfd.size *
 				  trans->trans_cfg->base_params->max_tfd_queue_size,
 				  txq->tfds, txq->dma_addr);
 		txq->dma_addr = 0;
@@ -285,9 +449,10 @@ void iwl_pcie_tx_start(struct iwl_trans *trans, u32 scd_base_addr)
 				SCD_CONTEXT_MEM_LOWER_BOUND) / sizeof(u32);
 
 	/* make sure all queue are not stopped/used */
-	memset(trans->txqs.queue_stopped, 0,
-	       sizeof(trans->txqs.queue_stopped));
-	memset(trans->txqs.queue_used, 0, sizeof(trans->txqs.queue_used));
+	memset(trans_pcie->txqs.queue_stopped, 0,
+	       sizeof(trans_pcie->txqs.queue_stopped));
+	memset(trans_pcie->txqs.queue_used, 0,
+	       sizeof(trans_pcie->txqs.queue_used));
 
 	trans_pcie->scd_base_addr =
 		iwl_read_prph(trans, SCD_SRAM_BASE_ADDR);
@@ -301,7 +466,7 @@ void iwl_pcie_tx_start(struct iwl_trans *trans, u32 scd_base_addr)
 			    NULL, clear_dwords);
 
 	iwl_write_prph(trans, SCD_DRAM_BASE_ADDR,
-		       trans->txqs.scd_bc_tbls.dma >> 10);
+		       trans_pcie->txqs.scd_bc_tbls.dma >> 10);
 
 	/* The chain extension of the SCD doesn't work well. This feature is
 	 * enabled by default by the HW, so we need to disable it manually.
@@ -309,9 +474,9 @@ void iwl_pcie_tx_start(struct iwl_trans *trans, u32 scd_base_addr)
 	if (trans->trans_cfg->base_params->scd_chain_ext_wa)
 		iwl_write_prph(trans, SCD_CHAINEXT_EN, 0);
 
-	iwl_trans_ac_txq_enable(trans, trans->txqs.cmd.q_id,
-				trans->txqs.cmd.fifo,
-				trans->txqs.cmd.wdg_timeout);
+	iwl_trans_ac_txq_enable(trans, trans_pcie->txqs.cmd.q_id,
+				trans_pcie->txqs.cmd.fifo,
+				trans_pcie->txqs.cmd.wdg_timeout);
 
 	/* Activate all Tx DMA/FIFO channels */
 	iwl_scd_activate_fifos(trans);
@@ -347,7 +512,7 @@ void iwl_trans_pcie_tx_reset(struct iwl_trans *trans)
 
 	for (txq_id = 0; txq_id < trans->trans_cfg->base_params->num_of_queues;
 	     txq_id++) {
-		struct iwl_txq *txq = trans->txqs.txq[txq_id];
+		struct iwl_txq *txq = trans_pcie->txqs.txq[txq_id];
 		if (trans->trans_cfg->gen2)
 			iwl_write_direct64(trans,
 					   FH_MEM_CBBC_QUEUE(trans, txq_id),
@@ -422,9 +587,10 @@ int iwl_pcie_tx_stop(struct iwl_trans *trans)
 	 * queues. This happens when we have an rfkill interrupt.
 	 * Since we stop Tx altogether - mark the queues as stopped.
 	 */
-	memset(trans->txqs.queue_stopped, 0,
-	       sizeof(trans->txqs.queue_stopped));
-	memset(trans->txqs.queue_used, 0, sizeof(trans->txqs.queue_used));
+	memset(trans_pcie->txqs.queue_stopped, 0,
+	       sizeof(trans_pcie->txqs.queue_stopped));
+	memset(trans_pcie->txqs.queue_used, 0,
+	       sizeof(trans_pcie->txqs.queue_used));
 
 	/* This can happen: start_hw, stop_device */
 	if (!trans_pcie->txq_memory)
@@ -448,7 +614,8 @@ void iwl_pcie_tx_free(struct iwl_trans *trans)
 	int txq_id;
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 
-	memset(trans->txqs.queue_used, 0, sizeof(trans->txqs.queue_used));
+	memset(trans_pcie->txqs.queue_used, 0,
+	       sizeof(trans_pcie->txqs.queue_used));
 
 	/* Tx queues */
 	if (trans_pcie->txq_memory) {
@@ -456,7 +623,7 @@ void iwl_pcie_tx_free(struct iwl_trans *trans)
 		     txq_id < trans->trans_cfg->base_params->num_of_queues;
 		     txq_id++) {
 			iwl_pcie_txq_free(trans, txq_id);
-			trans->txqs.txq[txq_id] = NULL;
+			trans_pcie->txqs.txq[txq_id] = NULL;
 		}
 	}
 
@@ -465,7 +632,135 @@ void iwl_pcie_tx_free(struct iwl_trans *trans)
 
 	iwl_pcie_free_dma_ptr(trans, &trans_pcie->kw);
 
-	iwl_pcie_free_dma_ptr(trans, &trans->txqs.scd_bc_tbls);
+	iwl_pcie_free_dma_ptr(trans, &trans_pcie->txqs.scd_bc_tbls);
+}
+
+void iwl_txq_log_scd_error(struct iwl_trans *trans, struct iwl_txq *txq)
+{
+	u32 txq_id = txq->id;
+	u32 status;
+	bool active;
+	u8 fifo;
+
+	if (trans->trans_cfg->gen2) {
+		IWL_ERR(trans, "Queue %d is stuck %d %d\n", txq_id,
+			txq->read_ptr, txq->write_ptr);
+		/* TODO: access new SCD registers and dump them */
+		return;
+	}
+
+	status = iwl_read_prph(trans, SCD_QUEUE_STATUS_BITS(txq_id));
+	fifo = (status >> SCD_QUEUE_STTS_REG_POS_TXF) & 0x7;
+	active = !!(status & BIT(SCD_QUEUE_STTS_REG_POS_ACTIVE));
+
+	IWL_ERR(trans,
+		"Queue %d is %sactive on fifo %d and stuck for %u ms. SW [%d, %d] HW [%d, %d] FH TRB=0x0%x\n",
+		txq_id, active ? "" : "in", fifo,
+		jiffies_to_msecs(txq->wd_timeout),
+		txq->read_ptr, txq->write_ptr,
+		iwl_read_prph(trans, SCD_QUEUE_RDPTR(txq_id)) &
+			(trans->trans_cfg->base_params->max_tfd_queue_size - 1),
+			iwl_read_prph(trans, SCD_QUEUE_WRPTR(txq_id)) &
+			(trans->trans_cfg->base_params->max_tfd_queue_size - 1),
+			iwl_read_direct32(trans, FH_TX_TRB_REG(fifo)));
+}
+
+static void iwl_txq_stuck_timer(struct timer_list *t)
+{
+	struct iwl_txq *txq = from_timer(txq, t, stuck_timer);
+	struct iwl_trans *trans = txq->trans;
+
+	spin_lock(&txq->lock);
+	/* check if triggered erroneously */
+	if (txq->read_ptr == txq->write_ptr) {
+		spin_unlock(&txq->lock);
+		return;
+	}
+	spin_unlock(&txq->lock);
+
+	iwl_txq_log_scd_error(trans, txq);
+
+	iwl_force_nmi(trans);
+}
+
+int iwl_pcie_txq_alloc(struct iwl_trans *trans, struct iwl_txq *txq,
+		       int slots_num, bool cmd_queue)
+{
+	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
+	size_t num_entries = trans->trans_cfg->gen2 ?
+		slots_num : trans->trans_cfg->base_params->max_tfd_queue_size;
+	size_t tfd_sz;
+	size_t tb0_buf_sz;
+	int i;
+
+	if (WARN_ONCE(slots_num <= 0, "Invalid slots num:%d\n", slots_num))
+		return -EINVAL;
+
+	if (WARN_ON(txq->entries || txq->tfds))
+		return -EINVAL;
+
+	tfd_sz = trans_pcie->txqs.tfd.size * num_entries;
+
+	timer_setup(&txq->stuck_timer, iwl_txq_stuck_timer, 0);
+	txq->trans = trans;
+
+	txq->n_window = slots_num;
+
+	txq->entries = kcalloc(slots_num,
+			       sizeof(struct iwl_pcie_txq_entry),
+			       GFP_KERNEL);
+
+	if (!txq->entries)
+		goto error;
+
+	if (cmd_queue)
+		for (i = 0; i < slots_num; i++) {
+			txq->entries[i].cmd =
+				kmalloc(sizeof(struct iwl_device_cmd),
+					GFP_KERNEL);
+			if (!txq->entries[i].cmd)
+				goto error;
+		}
+
+	/* Circular buffer of transmit frame descriptors (TFDs),
+	 * shared with device
+	 */
+	txq->tfds = dma_alloc_coherent(trans->dev, tfd_sz,
+				       &txq->dma_addr, GFP_KERNEL);
+	if (!txq->tfds)
+		goto error;
+
+	BUILD_BUG_ON(sizeof(*txq->first_tb_bufs) != IWL_FIRST_TB_SIZE_ALIGN);
+
+	tb0_buf_sz = sizeof(*txq->first_tb_bufs) * slots_num;
+
+	txq->first_tb_bufs = dma_alloc_coherent(trans->dev, tb0_buf_sz,
+						&txq->first_tb_dma,
+						GFP_KERNEL);
+	if (!txq->first_tb_bufs)
+		goto err_free_tfds;
+
+	for (i = 0; i < num_entries; i++) {
+		void *tfd = iwl_txq_get_tfd(trans, txq, i);
+
+		if (trans->trans_cfg->gen2)
+			iwl_txq_set_tfd_invalid_gen2(trans, tfd);
+		else
+			iwl_txq_set_tfd_invalid_gen1(trans, tfd);
+	}
+
+	return 0;
+err_free_tfds:
+	dma_free_coherent(trans->dev, tfd_sz, txq->tfds, txq->dma_addr);
+	txq->tfds = NULL;
+error:
+	if (txq->entries && cmd_queue)
+		for (i = 0; i < slots_num; i++)
+			kfree(txq->entries[i].cmd);
+	kfree(txq->entries);
+	txq->entries = NULL;
+
+	return -ENOMEM;
 }
 
 /*
@@ -491,7 +786,7 @@ static int iwl_pcie_tx_alloc(struct iwl_trans *trans)
 		goto error;
 	}
 
-	ret = iwl_pcie_alloc_dma_ptr(trans, &trans->txqs.scd_bc_tbls,
+	ret = iwl_pcie_alloc_dma_ptr(trans, &trans_pcie->txqs.scd_bc_tbls,
 				     bc_tbls_size);
 	if (ret) {
 		IWL_ERR(trans, "Scheduler BC Table allocation failed\n");
@@ -517,7 +812,7 @@ static int iwl_pcie_tx_alloc(struct iwl_trans *trans)
 	/* Alloc and init all Tx queues, including the command queue (#4/#9) */
 	for (txq_id = 0; txq_id < trans->trans_cfg->base_params->num_of_queues;
 	     txq_id++) {
-		bool cmd_queue = (txq_id == trans->txqs.cmd.q_id);
+		bool cmd_queue = (txq_id == trans_pcie->txqs.cmd.q_id);
 
 		if (cmd_queue)
 			slots_num = max_t(u32, IWL_CMD_QUEUE_SIZE,
@@ -525,14 +820,14 @@ static int iwl_pcie_tx_alloc(struct iwl_trans *trans)
 		else
 			slots_num = max_t(u32, IWL_DEFAULT_QUEUE_SIZE,
 					  trans->cfg->min_ba_txq_size);
-		trans->txqs.txq[txq_id] = &trans_pcie->txq_memory[txq_id];
-		ret = iwl_txq_alloc(trans, trans->txqs.txq[txq_id], slots_num,
-				    cmd_queue);
+		trans_pcie->txqs.txq[txq_id] = &trans_pcie->txq_memory[txq_id];
+		ret = iwl_pcie_txq_alloc(trans, trans_pcie->txqs.txq[txq_id],
+					 slots_num, cmd_queue);
 		if (ret) {
 			IWL_ERR(trans, "Tx %d queue alloc failed\n", txq_id);
 			goto error;
 		}
-		trans->txqs.txq[txq_id]->id = txq_id;
+		trans_pcie->txqs.txq[txq_id]->id = txq_id;
 	}
 
 	return 0;
@@ -543,6 +838,68 @@ static int iwl_pcie_tx_alloc(struct iwl_trans *trans)
 	return ret;
 }
 
+/*
+ * iwl_queue_init - Initialize queue's high/low-water and read/write indexes
+ */
+static int iwl_queue_init(struct iwl_txq *q, int slots_num)
+{
+	q->n_window = slots_num;
+
+	/* slots_num must be power-of-two size, otherwise
+	 * iwl_txq_get_cmd_index is broken.
+	 */
+	if (WARN_ON(!is_power_of_2(slots_num)))
+		return -EINVAL;
+
+	q->low_mark = q->n_window / 4;
+	if (q->low_mark < 4)
+		q->low_mark = 4;
+
+	q->high_mark = q->n_window / 8;
+	if (q->high_mark < 2)
+		q->high_mark = 2;
+
+	q->write_ptr = 0;
+	q->read_ptr = 0;
+
+	return 0;
+}
+
+int iwl_txq_init(struct iwl_trans *trans, struct iwl_txq *txq,
+		 int slots_num, bool cmd_queue)
+{
+	u32 tfd_queue_max_size =
+		trans->trans_cfg->base_params->max_tfd_queue_size;
+	int ret;
+
+	txq->need_update = false;
+
+	/* max_tfd_queue_size must be power-of-two size, otherwise
+	 * iwl_txq_inc_wrap and iwl_txq_dec_wrap are broken.
+	 */
+	if (WARN_ONCE(tfd_queue_max_size & (tfd_queue_max_size - 1),
+		      "Max tfd queue size must be a power of two, but is %d",
+		      tfd_queue_max_size))
+		return -EINVAL;
+
+	/* Initialize queue's high/low-water marks, and head/tail indexes */
+	ret = iwl_queue_init(txq, slots_num);
+	if (ret)
+		return ret;
+
+	spin_lock_init(&txq->lock);
+
+	if (cmd_queue) {
+		static struct lock_class_key iwl_txq_cmd_queue_lock_class;
+
+		lockdep_set_class(&txq->lock, &iwl_txq_cmd_queue_lock_class);
+	}
+
+	__skb_queue_head_init(&txq->overflow_q);
+
+	return 0;
+}
+
 int iwl_pcie_tx_init(struct iwl_trans *trans)
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
@@ -571,7 +928,7 @@ int iwl_pcie_tx_init(struct iwl_trans *trans)
 	/* Alloc and init all Tx queues, including the command queue (#4/#9) */
 	for (txq_id = 0; txq_id < trans->trans_cfg->base_params->num_of_queues;
 	     txq_id++) {
-		bool cmd_queue = (txq_id == trans->txqs.cmd.q_id);
+		bool cmd_queue = (txq_id == trans_pcie->txqs.cmd.q_id);
 
 		if (cmd_queue)
 			slots_num = max_t(u32, IWL_CMD_QUEUE_SIZE,
@@ -579,7 +936,7 @@ int iwl_pcie_tx_init(struct iwl_trans *trans)
 		else
 			slots_num = max_t(u32, IWL_DEFAULT_QUEUE_SIZE,
 					  trans->cfg->min_ba_txq_size);
-		ret = iwl_txq_init(trans, trans->txqs.txq[txq_id], slots_num,
+		ret = iwl_txq_init(trans, trans_pcie->txqs.txq[txq_id], slots_num,
 				   cmd_queue);
 		if (ret) {
 			IWL_ERR(trans, "Tx %d queue init failed\n", txq_id);
@@ -593,7 +950,7 @@ int iwl_pcie_tx_init(struct iwl_trans *trans)
 		 * Circular buffer (TFD queue in DRAM) physical base address
 		 */
 		iwl_write_direct32(trans, FH_MEM_CBBC_QUEUE(trans, txq_id),
-				   trans->txqs.txq[txq_id]->dma_addr >> 8);
+				   trans_pcie->txqs.txq[txq_id]->dma_addr >> 8);
 	}
 
 	iwl_set_bits_prph(trans, SCD_GP_CTRL, SCD_GP_CTRL_AUTO_ACTIVE_MODE);
@@ -641,6 +998,41 @@ static int iwl_pcie_set_cmd_in_flight(struct iwl_trans *trans,
 	return 0;
 }
 
+static void iwl_txq_progress(struct iwl_txq *txq)
+{
+	lockdep_assert_held(&txq->lock);
+
+	if (!txq->wd_timeout)
+		return;
+
+	/*
+	 * station is asleep and we send data - that must
+	 * be uAPSD or PS-Poll. Don't rearm the timer.
+	 */
+	if (txq->frozen)
+		return;
+
+	/*
+	 * if empty delete timer, otherwise move timer forward
+	 * since we're making progress on this queue
+	 */
+	if (txq->read_ptr == txq->write_ptr)
+		del_timer(&txq->stuck_timer);
+	else
+		mod_timer(&txq->stuck_timer, jiffies + txq->wd_timeout);
+}
+
+static inline bool iwl_txq_used(const struct iwl_txq *q, int i)
+{
+	int index = iwl_txq_get_cmd_index(q, i);
+	int r = iwl_txq_get_cmd_index(q, q->read_ptr);
+	int w = iwl_txq_get_cmd_index(q, q->write_ptr);
+
+	return w >= r ?
+		(index >= r && index < w) :
+		!(index < r && index >= w);
+}
+
 /*
  * iwl_pcie_cmdq_reclaim - Reclaim TX command queue entries already Tx'd
  *
@@ -650,7 +1042,8 @@ static int iwl_pcie_set_cmd_in_flight(struct iwl_trans *trans,
  */
 static void iwl_pcie_cmdq_reclaim(struct iwl_trans *trans, int txq_id, int idx)
 {
-	struct iwl_txq *txq = trans->txqs.txq[txq_id];
+	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
+	struct iwl_txq *txq = trans_pcie->txqs.txq[txq_id];
 	int nfreed = 0;
 	u16 r;
 
@@ -661,7 +1054,7 @@ static void iwl_pcie_cmdq_reclaim(struct iwl_trans *trans, int txq_id, int idx)
 
 	if (idx >= trans->trans_cfg->base_params->max_tfd_queue_size ||
 	    (!iwl_txq_used(txq, idx))) {
-		WARN_ONCE(test_bit(txq_id, trans->txqs.queue_used),
+		WARN_ONCE(test_bit(txq_id, trans_pcie->txqs.queue_used),
 			  "%s: Read index for DMA queue txq id (%d), index %d is out of range [0-%d] %d %d.\n",
 			  __func__, txq_id, idx,
 			  trans->trans_cfg->base_params->max_tfd_queue_size,
@@ -720,11 +1113,11 @@ bool iwl_trans_pcie_txq_enable(struct iwl_trans *trans, int txq_id, u16 ssn,
 			       unsigned int wdg_timeout)
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
-	struct iwl_txq *txq = trans->txqs.txq[txq_id];
+	struct iwl_txq *txq = trans_pcie->txqs.txq[txq_id];
 	int fifo = -1;
 	bool scd_bug = false;
 
-	if (test_and_set_bit(txq_id, trans->txqs.queue_used))
+	if (test_and_set_bit(txq_id, trans_pcie->txqs.queue_used))
 		WARN_ONCE(1, "queue %d already used - expect issues", txq_id);
 
 	txq->wd_timeout = msecs_to_jiffies(wdg_timeout);
@@ -733,7 +1126,7 @@ bool iwl_trans_pcie_txq_enable(struct iwl_trans *trans, int txq_id, u16 ssn,
 		fifo = cfg->fifo;
 
 		/* Disable the scheduler prior configuring the cmd queue */
-		if (txq_id == trans->txqs.cmd.q_id &&
+		if (txq_id == trans_pcie->txqs.cmd.q_id &&
 		    trans_pcie->scd_set_active)
 			iwl_scd_enable_set_active(trans, 0);
 
@@ -741,7 +1134,7 @@ bool iwl_trans_pcie_txq_enable(struct iwl_trans *trans, int txq_id, u16 ssn,
 		iwl_scd_txq_set_inactive(trans, txq_id);
 
 		/* Set this queue as a chain-building queue unless it is CMD */
-		if (txq_id != trans->txqs.cmd.q_id)
+		if (txq_id != trans_pcie->txqs.cmd.q_id)
 			iwl_scd_txq_set_chain(trans, txq_id);
 
 		if (cfg->aggregate) {
@@ -811,7 +1204,7 @@ bool iwl_trans_pcie_txq_enable(struct iwl_trans *trans, int txq_id, u16 ssn,
 			       SCD_QUEUE_STTS_REG_MSK);
 
 		/* enable the scheduler for this queue (only) */
-		if (txq_id == trans->txqs.cmd.q_id &&
+		if (txq_id == trans_pcie->txqs.cmd.q_id &&
 		    trans_pcie->scd_set_active)
 			iwl_scd_enable_set_active(trans, BIT(txq_id));
 
@@ -830,7 +1223,8 @@ bool iwl_trans_pcie_txq_enable(struct iwl_trans *trans, int txq_id, u16 ssn,
 void iwl_trans_pcie_txq_set_shared_mode(struct iwl_trans *trans, u32 txq_id,
 					bool shared_mode)
 {
-	struct iwl_txq *txq = trans->txqs.txq[txq_id];
+	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
+	struct iwl_txq *txq = trans_pcie->txqs.txq[txq_id];
 
 	txq->ampdu = !shared_mode;
 }
@@ -843,8 +1237,8 @@ void iwl_trans_pcie_txq_disable(struct iwl_trans *trans, int txq_id,
 			SCD_TX_STTS_QUEUE_OFFSET(txq_id);
 	static const u32 zero_val[4] = {};
 
-	trans->txqs.txq[txq_id]->frozen_expiry_remainder = 0;
-	trans->txqs.txq[txq_id]->frozen = false;
+	trans_pcie->txqs.txq[txq_id]->frozen_expiry_remainder = 0;
+	trans_pcie->txqs.txq[txq_id]->frozen = false;
 
 	/*
 	 * Upon HW Rfkill - we stop the device, and then stop the queues
@@ -852,7 +1246,7 @@ void iwl_trans_pcie_txq_disable(struct iwl_trans *trans, int txq_id,
 	 * allow the op_mode to call txq_disable after it already called
 	 * stop_device.
 	 */
-	if (!test_and_clear_bit(txq_id, trans->txqs.queue_used)) {
+	if (!test_and_clear_bit(txq_id, trans_pcie->txqs.queue_used)) {
 		WARN_ONCE(test_bit(STATUS_DEVICE_ENABLED, &trans->status),
 			  "queue %d not used", txq_id);
 		return;
@@ -866,7 +1260,7 @@ void iwl_trans_pcie_txq_disable(struct iwl_trans *trans, int txq_id,
 	}
 
 	iwl_pcie_txq_unmap(trans, txq_id);
-	trans->txqs.txq[txq_id]->ampdu = false;
+	trans_pcie->txqs.txq[txq_id]->ampdu = false;
 
 	IWL_DEBUG_TX_QUEUES(trans, "Deactivate queue %d\n", txq_id);
 }
@@ -875,12 +1269,13 @@ void iwl_trans_pcie_txq_disable(struct iwl_trans *trans, int txq_id,
 
 static void iwl_trans_pcie_block_txq_ptrs(struct iwl_trans *trans, bool block)
 {
+	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 	int i;
 
 	for (i = 0; i < trans->trans_cfg->base_params->num_of_queues; i++) {
-		struct iwl_txq *txq = trans->txqs.txq[i];
+		struct iwl_txq *txq = trans_pcie->txqs.txq[i];
 
-		if (i == trans->txqs.cmd.q_id)
+		if (i == trans_pcie->txqs.cmd.q_id)
 			continue;
 
 		/* we skip the command queue (obviously) so it's OK to nest */
@@ -912,7 +1307,8 @@ static void iwl_trans_pcie_block_txq_ptrs(struct iwl_trans *trans, bool block)
 int iwl_pcie_enqueue_hcmd(struct iwl_trans *trans,
 			  struct iwl_host_cmd *cmd)
 {
-	struct iwl_txq *txq = trans->txqs.txq[trans->txqs.cmd.q_id];
+	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
+	struct iwl_txq *txq = trans_pcie->txqs.txq[trans_pcie->txqs.cmd.q_id];
 	struct iwl_device_cmd *out_cmd;
 	struct iwl_cmd_meta *out_meta;
 	void *dup_buf = NULL;
@@ -1038,7 +1434,7 @@ int iwl_pcie_enqueue_hcmd(struct iwl_trans *trans,
 				    sizeof(struct iwl_cmd_header_wide));
 		out_cmd->hdr_wide.reserved = 0;
 		out_cmd->hdr_wide.sequence =
-			cpu_to_le16(QUEUE_TO_SEQ(trans->txqs.cmd.q_id) |
+			cpu_to_le16(QUEUE_TO_SEQ(trans_pcie->txqs.cmd.q_id) |
 						 INDEX_TO_SEQ(txq->write_ptr));
 
 		cmd_pos = sizeof(struct iwl_cmd_header_wide);
@@ -1046,7 +1442,7 @@ int iwl_pcie_enqueue_hcmd(struct iwl_trans *trans,
 	} else {
 		out_cmd->hdr.cmd = iwl_cmd_opcode(cmd->id);
 		out_cmd->hdr.sequence =
-			cpu_to_le16(QUEUE_TO_SEQ(trans->txqs.cmd.q_id) |
+			cpu_to_le16(QUEUE_TO_SEQ(trans_pcie->txqs.cmd.q_id) |
 						 INDEX_TO_SEQ(txq->write_ptr));
 		out_cmd->hdr.group_id = 0;
 
@@ -1097,7 +1493,7 @@ int iwl_pcie_enqueue_hcmd(struct iwl_trans *trans,
 		     iwl_get_cmd_string(trans, cmd->id),
 		     group_id, out_cmd->hdr.cmd,
 		     le16_to_cpu(out_cmd->hdr.sequence),
-		     cmd_size, txq->write_ptr, idx, trans->txqs.cmd.q_id);
+		     cmd_size, txq->write_ptr, idx, trans_pcie->txqs.cmd.q_id);
 
 	/* start the TFD with the minimum copy bytes */
 	tb0_size = min_t(int, copy_size, IWL_FIRST_TB_SIZE);
@@ -1196,14 +1592,14 @@ void iwl_pcie_hcmd_complete(struct iwl_trans *trans,
 	struct iwl_device_cmd *cmd;
 	struct iwl_cmd_meta *meta;
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
-	struct iwl_txq *txq = trans->txqs.txq[trans->txqs.cmd.q_id];
+	struct iwl_txq *txq = trans_pcie->txqs.txq[trans_pcie->txqs.cmd.q_id];
 
 	/* If a Tx command is being handled and it isn't in the actual
 	 * command queue then there a command routing bug has been introduced
 	 * in the queue management code. */
-	if (WARN(txq_id != trans->txqs.cmd.q_id,
+	if (WARN(txq_id != trans_pcie->txqs.cmd.q_id,
 		 "wrong command queue %d (should be %d), sequence 0x%X readp=%d writep=%d\n",
-		 txq_id, trans->txqs.cmd.q_id, sequence, txq->read_ptr,
+		 txq_id, trans_pcie->txqs.cmd.q_id, sequence, txq->read_ptr,
 		 txq->write_ptr)) {
 		iwl_print_hex_error(trans, pkt, 32);
 		return;
@@ -1306,12 +1702,58 @@ static int iwl_fill_data_tbs(struct iwl_trans *trans, struct sk_buff *skb,
 }
 
 #ifdef CONFIG_INET
+struct iwl_tso_hdr_page *iwl_pcie_get_page_hdr(struct iwl_trans *trans,
+					       size_t len, struct sk_buff *skb)
+{
+	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
+	struct iwl_tso_hdr_page *p = this_cpu_ptr(trans_pcie->txqs.tso_hdr_page);
+	struct page **page_ptr;
+
+	page_ptr = (void *)((u8 *)skb->cb + trans_pcie->txqs.page_offs);
+
+	if (WARN_ON(*page_ptr))
+		return NULL;
+
+	if (!p->page)
+		goto alloc;
+
+	/*
+	 * Check if there's enough room on this page
+	 *
+	 * Note that we put a page chaining pointer *last* in the
+	 * page - we need it somewhere, and if it's there then we
+	 * avoid DMA mapping the last bits of the page which may
+	 * trigger the 32-bit boundary hardware bug.
+	 *
+	 * (see also get_workaround_page() in tx-gen2.c)
+	 */
+	if (p->pos + len < (u8 *)page_address(p->page) + PAGE_SIZE -
+			   sizeof(void *))
+		goto out;
+
+	/* We don't have enough room on this page, get a new one. */
+	__free_page(p->page);
+
+alloc:
+	p->page = alloc_page(GFP_ATOMIC);
+	if (!p->page)
+		return NULL;
+	p->pos = page_address(p->page);
+	/* set the chaining pointer to NULL */
+	*(void **)((u8 *)page_address(p->page) + PAGE_SIZE - sizeof(void *)) = NULL;
+out:
+	*page_ptr = p->page;
+	get_page(p->page);
+	return p;
+}
+
 static int iwl_fill_data_tbs_amsdu(struct iwl_trans *trans, struct sk_buff *skb,
 				   struct iwl_txq *txq, u8 hdr_len,
 				   struct iwl_cmd_meta *out_meta,
 				   struct iwl_device_tx_cmd *dev_cmd,
 				   u16 tb1_len)
 {
+	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 	struct iwl_tx_cmd *tx_cmd = (void *)dev_cmd->payload;
 	struct ieee80211_hdr *hdr = (void *)skb->data;
 	unsigned int snap_ip_tcp_hdrlen, ip_hdrlen, total_len, hdr_room;
@@ -1328,7 +1770,7 @@ static int iwl_fill_data_tbs_amsdu(struct iwl_trans *trans, struct sk_buff *skb,
 
 	trace_iwlwifi_dev_tx(trans->dev, skb,
 			     iwl_txq_get_tfd(trans, txq, txq->write_ptr),
-			     trans->txqs.tfd.size,
+			     trans_pcie->txqs.tfd.size,
 			     &dev_cmd->hdr, IWL_FIRST_TB_SIZE + tb1_len, 0);
 
 	ip_hdrlen = skb_network_header_len(skb);
@@ -1341,7 +1783,7 @@ static int iwl_fill_data_tbs_amsdu(struct iwl_trans *trans, struct sk_buff *skb,
 		(3 + snap_ip_tcp_hdrlen + sizeof(struct ethhdr)) + iv_len;
 
 	/* Our device supports 9 segments at most, it will fit in 1 page */
-	hdr_page = get_page_hdr(trans, hdr_room, skb);
+	hdr_page = iwl_pcie_get_page_hdr(trans, hdr_room, skb);
 	if (!hdr_page)
 		return -ENOMEM;
 
@@ -1450,9 +1892,61 @@ static int iwl_fill_data_tbs_amsdu(struct iwl_trans *trans, struct sk_buff *skb,
 }
 #endif /* CONFIG_INET */
 
+#define IWL_TX_CRC_SIZE 4
+#define IWL_TX_DELIMITER_SIZE 4
+
+/*
+ * iwl_txq_gen1_update_byte_cnt_tbl - Set up entry in Tx byte-count array
+ */
+static void iwl_txq_gen1_update_byte_cnt_tbl(struct iwl_trans *trans,
+					     struct iwl_txq *txq, u16 byte_cnt,
+					     int num_tbs)
+{
+	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
+	struct iwlagn_scd_bc_tbl *scd_bc_tbl;
+	int write_ptr = txq->write_ptr;
+	int txq_id = txq->id;
+	u8 sec_ctl = 0;
+	u16 len = byte_cnt + IWL_TX_CRC_SIZE + IWL_TX_DELIMITER_SIZE;
+	__le16 bc_ent;
+	struct iwl_device_tx_cmd *dev_cmd = txq->entries[txq->write_ptr].cmd;
+	struct iwl_tx_cmd *tx_cmd = (void *)dev_cmd->payload;
+	u8 sta_id = tx_cmd->sta_id;
+
+	scd_bc_tbl = trans_pcie->txqs.scd_bc_tbls.addr;
+
+	sec_ctl = tx_cmd->sec_ctl;
+
+	switch (sec_ctl & TX_CMD_SEC_MSK) {
+	case TX_CMD_SEC_CCM:
+		len += IEEE80211_CCMP_MIC_LEN;
+		break;
+	case TX_CMD_SEC_TKIP:
+		len += IEEE80211_TKIP_ICV_LEN;
+		break;
+	case TX_CMD_SEC_WEP:
+		len += IEEE80211_WEP_IV_LEN + IEEE80211_WEP_ICV_LEN;
+		break;
+	}
+	if (trans_pcie->txqs.bc_table_dword)
+		len = DIV_ROUND_UP(len, 4);
+
+	if (WARN_ON(len > 0xFFF || write_ptr >= TFD_QUEUE_SIZE_MAX))
+		return;
+
+	bc_ent = cpu_to_le16(len | (sta_id << 12));
+
+	scd_bc_tbl[txq_id].tfd_offset[write_ptr] = bc_ent;
+
+	if (write_ptr < TFD_QUEUE_SIZE_BC_DUP)
+		scd_bc_tbl[txq_id].tfd_offset[TFD_QUEUE_SIZE_MAX + write_ptr] =
+			bc_ent;
+}
+
 int iwl_trans_pcie_tx(struct iwl_trans *trans, struct sk_buff *skb,
 		      struct iwl_device_tx_cmd *dev_cmd, int txq_id)
 {
+	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 	struct ieee80211_hdr *hdr;
 	struct iwl_tx_cmd *tx_cmd = (struct iwl_tx_cmd *)dev_cmd->payload;
 	struct iwl_cmd_meta *out_meta;
@@ -1467,14 +1961,14 @@ int iwl_trans_pcie_tx(struct iwl_trans *trans, struct sk_buff *skb,
 	u16 wifi_seq;
 	bool amsdu;
 
-	txq = trans->txqs.txq[txq_id];
+	txq = trans_pcie->txqs.txq[txq_id];
 
-	if (WARN_ONCE(!test_bit(txq_id, trans->txqs.queue_used),
+	if (WARN_ONCE(!test_bit(txq_id, trans_pcie->txqs.queue_used),
 		      "TX on unused queue %d\n", txq_id))
 		return -EINVAL;
 
 	if (skb_is_nonlinear(skb) &&
-	    skb_shinfo(skb)->nr_frags > IWL_TRANS_MAX_FRAGS(trans) &&
+	    skb_shinfo(skb)->nr_frags > IWL_TRANS_PCIE_MAX_FRAGS(trans_pcie) &&
 	    __skb_linearize(skb))
 		return -ENOMEM;
 
@@ -1495,7 +1989,7 @@ int iwl_trans_pcie_tx(struct iwl_trans *trans, struct sk_buff *skb,
 			struct iwl_device_tx_cmd **dev_cmd_ptr;
 
 			dev_cmd_ptr = (void *)((u8 *)skb->cb +
-					       trans->txqs.dev_cmd_offs);
+					       trans_pcie->txqs.dev_cmd_offs);
 
 			*dev_cmd_ptr = dev_cmd;
 			__skb_queue_tail(&txq->overflow_q, skb);
@@ -1578,7 +2072,7 @@ int iwl_trans_pcie_tx(struct iwl_trans *trans, struct sk_buff *skb,
 
 	trace_iwlwifi_dev_tx(trans->dev, skb,
 			     iwl_txq_get_tfd(trans, txq, txq->write_ptr),
-			     trans->txqs.tfd.size,
+			     trans_pcie->txqs.tfd.size,
 			     &dev_cmd->hdr, IWL_FIRST_TB_SIZE + tb1_len,
 			     hdr_len);
 
@@ -1613,8 +2107,7 @@ int iwl_trans_pcie_tx(struct iwl_trans *trans, struct sk_buff *skb,
 	tfd = iwl_txq_get_tfd(trans, txq, txq->write_ptr);
 	/* Set up entry for this TFD in Tx byte-count array */
 	iwl_txq_gen1_update_byte_cnt_tbl(trans, txq, le16_to_cpu(tx_cmd->len),
-					 iwl_txq_gen1_tfd_get_num_tbs(trans,
-								      tfd));
+					 iwl_txq_gen1_tfd_get_num_tbs(tfd));
 
 	wait_write_ptr = ieee80211_has_morefrags(fc);
 
@@ -1649,3 +2142,359 @@ int iwl_trans_pcie_tx(struct iwl_trans *trans, struct sk_buff *skb,
 	spin_unlock(&txq->lock);
 	return -1;
 }
+
+static void iwl_txq_gen1_inval_byte_cnt_tbl(struct iwl_trans *trans,
+					    struct iwl_txq *txq)
+{
+	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
+	struct iwlagn_scd_bc_tbl *scd_bc_tbl = trans_pcie->txqs.scd_bc_tbls.addr;
+	int txq_id = txq->id;
+	int read_ptr = txq->read_ptr;
+	u8 sta_id = 0;
+	__le16 bc_ent;
+	struct iwl_device_tx_cmd *dev_cmd = txq->entries[read_ptr].cmd;
+	struct iwl_tx_cmd *tx_cmd = (void *)dev_cmd->payload;
+
+	WARN_ON(read_ptr >= TFD_QUEUE_SIZE_MAX);
+
+	if (txq_id != trans_pcie->txqs.cmd.q_id)
+		sta_id = tx_cmd->sta_id;
+
+	bc_ent = cpu_to_le16(1 | (sta_id << 12));
+
+	scd_bc_tbl[txq_id].tfd_offset[read_ptr] = bc_ent;
+
+	if (read_ptr < TFD_QUEUE_SIZE_BC_DUP)
+		scd_bc_tbl[txq_id].tfd_offset[TFD_QUEUE_SIZE_MAX + read_ptr] =
+			bc_ent;
+}
+
+/* Frees buffers until index _not_ inclusive */
+void iwl_pcie_reclaim(struct iwl_trans *trans, int txq_id, int ssn,
+		      struct sk_buff_head *skbs, bool is_flush)
+{
+	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
+	struct iwl_txq *txq = trans_pcie->txqs.txq[txq_id];
+	int tfd_num, read_ptr, last_to_free;
+
+	/* This function is not meant to release cmd queue*/
+	if (WARN_ON(txq_id == trans_pcie->txqs.cmd.q_id))
+		return;
+
+	if (WARN_ON(!txq))
+		return;
+
+	tfd_num = iwl_txq_get_cmd_index(txq, ssn);
+
+	spin_lock_bh(&txq->lock);
+	read_ptr = iwl_txq_get_cmd_index(txq, txq->read_ptr);
+
+	if (!test_bit(txq_id, trans_pcie->txqs.queue_used)) {
+		IWL_DEBUG_TX_QUEUES(trans, "Q %d inactive - ignoring idx %d\n",
+				    txq_id, ssn);
+		goto out;
+	}
+
+	if (read_ptr == tfd_num)
+		goto out;
+
+	IWL_DEBUG_TX_REPLY(trans, "[Q %d] %d (%d) -> %d (%d)\n",
+			   txq_id, read_ptr, txq->read_ptr, tfd_num, ssn);
+
+	/* Since we free until index _not_ inclusive, the one before index is
+	 * the last we will free. This one must be used
+	 */
+	last_to_free = iwl_txq_dec_wrap(trans, tfd_num);
+
+	if (!iwl_txq_used(txq, last_to_free)) {
+		IWL_ERR(trans,
+			"%s: Read index for txq id (%d), last_to_free %d is out of range [0-%d] %d %d.\n",
+			__func__, txq_id, last_to_free,
+			trans->trans_cfg->base_params->max_tfd_queue_size,
+			txq->write_ptr, txq->read_ptr);
+
+		iwl_op_mode_time_point(trans->op_mode,
+				       IWL_FW_INI_TIME_POINT_FAKE_TX,
+				       NULL);
+		goto out;
+	}
+
+	if (WARN_ON(!skb_queue_empty(skbs)))
+		goto out;
+
+	for (;
+	     read_ptr != tfd_num;
+	     txq->read_ptr = iwl_txq_inc_wrap(trans, txq->read_ptr),
+	     read_ptr = iwl_txq_get_cmd_index(txq, txq->read_ptr)) {
+		struct sk_buff *skb = txq->entries[read_ptr].skb;
+
+		if (WARN_ONCE(!skb, "no SKB at %d (%d) on queue %d\n",
+			      read_ptr, txq->read_ptr, txq_id))
+			continue;
+
+		iwl_pcie_free_tso_page(trans, skb);
+
+		__skb_queue_tail(skbs, skb);
+
+		txq->entries[read_ptr].skb = NULL;
+
+		if (!trans->trans_cfg->gen2)
+			iwl_txq_gen1_inval_byte_cnt_tbl(trans, txq);
+
+		iwl_txq_free_tfd(trans, txq);
+	}
+
+	iwl_txq_progress(txq);
+
+	if (iwl_txq_space(trans, txq) > txq->low_mark &&
+	    test_bit(txq_id, trans_pcie->txqs.queue_stopped)) {
+		struct sk_buff_head overflow_skbs;
+		struct sk_buff *skb;
+
+		__skb_queue_head_init(&overflow_skbs);
+		skb_queue_splice_init(&txq->overflow_q,
+				      is_flush ? skbs : &overflow_skbs);
+
+		/*
+		 * We are going to transmit from the overflow queue.
+		 * Remember this state so that wait_for_txq_empty will know we
+		 * are adding more packets to the TFD queue. It cannot rely on
+		 * the state of &txq->overflow_q, as we just emptied it, but
+		 * haven't TXed the content yet.
+		 */
+		txq->overflow_tx = true;
+
+		/*
+		 * This is tricky: we are in reclaim path which is non
+		 * re-entrant, so noone will try to take the access the
+		 * txq data from that path. We stopped tx, so we can't
+		 * have tx as well. Bottom line, we can unlock and re-lock
+		 * later.
+		 */
+		spin_unlock_bh(&txq->lock);
+
+		while ((skb = __skb_dequeue(&overflow_skbs))) {
+			struct iwl_device_tx_cmd *dev_cmd_ptr;
+
+			dev_cmd_ptr = *(void **)((u8 *)skb->cb +
+						 trans_pcie->txqs.dev_cmd_offs);
+
+			/*
+			 * Note that we can very well be overflowing again.
+			 * In that case, iwl_txq_space will be small again
+			 * and we won't wake mac80211's queue.
+			 */
+			iwl_trans_tx(trans, skb, dev_cmd_ptr, txq_id);
+		}
+
+		if (iwl_txq_space(trans, txq) > txq->low_mark)
+			iwl_trans_pcie_wake_queue(trans, txq);
+
+		spin_lock_bh(&txq->lock);
+		txq->overflow_tx = false;
+	}
+
+out:
+	spin_unlock_bh(&txq->lock);
+}
+
+/* Set wr_ptr of specific device and txq  */
+void iwl_pcie_set_q_ptrs(struct iwl_trans *trans, int txq_id, int ptr)
+{
+	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
+	struct iwl_txq *txq = trans_pcie->txqs.txq[txq_id];
+
+	spin_lock_bh(&txq->lock);
+
+	txq->write_ptr = ptr;
+	txq->read_ptr = txq->write_ptr;
+
+	spin_unlock_bh(&txq->lock);
+}
+
+void iwl_pcie_freeze_txq_timer(struct iwl_trans *trans,
+			       unsigned long txqs, bool freeze)
+{
+	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
+	int queue;
+
+	for_each_set_bit(queue, &txqs, BITS_PER_LONG) {
+		struct iwl_txq *txq = trans_pcie->txqs.txq[queue];
+		unsigned long now;
+
+		spin_lock_bh(&txq->lock);
+
+		now = jiffies;
+
+		if (txq->frozen == freeze)
+			goto next_queue;
+
+		IWL_DEBUG_TX_QUEUES(trans, "%s TXQ %d\n",
+				    freeze ? "Freezing" : "Waking", queue);
+
+		txq->frozen = freeze;
+
+		if (txq->read_ptr == txq->write_ptr)
+			goto next_queue;
+
+		if (freeze) {
+			if (unlikely(time_after(now,
+						txq->stuck_timer.expires))) {
+				/*
+				 * The timer should have fired, maybe it is
+				 * spinning right now on the lock.
+				 */
+				goto next_queue;
+			}
+			/* remember how long until the timer fires */
+			txq->frozen_expiry_remainder =
+				txq->stuck_timer.expires - now;
+			del_timer(&txq->stuck_timer);
+			goto next_queue;
+		}
+
+		/*
+		 * Wake a non-empty queue -> arm timer with the
+		 * remainder before it froze
+		 */
+		mod_timer(&txq->stuck_timer,
+			  now + txq->frozen_expiry_remainder);
+
+next_queue:
+		spin_unlock_bh(&txq->lock);
+	}
+}
+
+#define HOST_COMPLETE_TIMEOUT	(2 * HZ)
+
+static int iwl_trans_pcie_send_hcmd_sync(struct iwl_trans *trans,
+					 struct iwl_host_cmd *cmd)
+{
+	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
+	const char *cmd_str = iwl_get_cmd_string(trans, cmd->id);
+	struct iwl_txq *txq = trans_pcie->txqs.txq[trans_pcie->txqs.cmd.q_id];
+	int cmd_idx;
+	int ret;
+
+	IWL_DEBUG_INFO(trans, "Attempting to send sync command %s\n", cmd_str);
+
+	if (WARN(test_and_set_bit(STATUS_SYNC_HCMD_ACTIVE,
+				  &trans->status),
+		 "Command %s: a command is already active!\n", cmd_str))
+		return -EIO;
+
+	IWL_DEBUG_INFO(trans, "Setting HCMD_ACTIVE for command %s\n", cmd_str);
+
+	cmd_idx = trans->ops->send_cmd(trans, cmd);
+	if (cmd_idx < 0) {
+		ret = cmd_idx;
+		clear_bit(STATUS_SYNC_HCMD_ACTIVE, &trans->status);
+		IWL_ERR(trans, "Error sending %s: enqueue_hcmd failed: %d\n",
+			cmd_str, ret);
+		return ret;
+	}
+
+	ret = wait_event_timeout(trans->wait_command_queue,
+				 !test_bit(STATUS_SYNC_HCMD_ACTIVE,
+					   &trans->status),
+				 HOST_COMPLETE_TIMEOUT);
+	if (!ret) {
+		IWL_ERR(trans, "Error sending %s: time out after %dms.\n",
+			cmd_str, jiffies_to_msecs(HOST_COMPLETE_TIMEOUT));
+
+		IWL_ERR(trans, "Current CMD queue read_ptr %d write_ptr %d\n",
+			txq->read_ptr, txq->write_ptr);
+
+		clear_bit(STATUS_SYNC_HCMD_ACTIVE, &trans->status);
+		IWL_DEBUG_INFO(trans, "Clearing HCMD_ACTIVE for command %s\n",
+			       cmd_str);
+		ret = -ETIMEDOUT;
+
+		iwl_trans_sync_nmi(trans);
+		goto cancel;
+	}
+
+	if (test_bit(STATUS_FW_ERROR, &trans->status)) {
+		if (!test_and_clear_bit(STATUS_SUPPRESS_CMD_ERROR_ONCE,
+					&trans->status)) {
+			IWL_ERR(trans, "FW error in SYNC CMD %s\n", cmd_str);
+			dump_stack();
+		}
+		ret = -EIO;
+		goto cancel;
+	}
+
+	if (!(cmd->flags & CMD_SEND_IN_RFKILL) &&
+	    test_bit(STATUS_RFKILL_OPMODE, &trans->status)) {
+		IWL_DEBUG_RF_KILL(trans, "RFKILL in SYNC CMD... no rsp\n");
+		ret = -ERFKILL;
+		goto cancel;
+	}
+
+	if ((cmd->flags & CMD_WANT_SKB) && !cmd->resp_pkt) {
+		IWL_ERR(trans, "Error: Response NULL in '%s'\n", cmd_str);
+		ret = -EIO;
+		goto cancel;
+	}
+
+	return 0;
+
+cancel:
+	if (cmd->flags & CMD_WANT_SKB) {
+		/*
+		 * Cancel the CMD_WANT_SKB flag for the cmd in the
+		 * TX cmd queue. Otherwise in case the cmd comes
+		 * in later, it will possibly set an invalid
+		 * address (cmd->meta.source).
+		 */
+		txq->entries[cmd_idx].meta.flags &= ~CMD_WANT_SKB;
+	}
+
+	if (cmd->resp_pkt) {
+		iwl_free_resp(cmd);
+		cmd->resp_pkt = NULL;
+	}
+
+	return ret;
+}
+
+int iwl_trans_pcie_send_hcmd(struct iwl_trans *trans,
+			     struct iwl_host_cmd *cmd)
+{
+	/* Make sure the NIC is still alive in the bus */
+	if (test_bit(STATUS_TRANS_DEAD, &trans->status))
+		return -ENODEV;
+
+	if (!(cmd->flags & CMD_SEND_IN_RFKILL) &&
+	    test_bit(STATUS_RFKILL_OPMODE, &trans->status)) {
+		IWL_DEBUG_RF_KILL(trans, "Dropping CMD 0x%x: RF KILL\n",
+				  cmd->id);
+		return -ERFKILL;
+	}
+
+	if (unlikely(trans->system_pm_mode == IWL_PLAT_PM_MODE_D3 &&
+		     !(cmd->flags & CMD_SEND_IN_D3))) {
+		IWL_DEBUG_WOWLAN(trans, "Dropping CMD 0x%x: D3\n", cmd->id);
+		return -EHOSTDOWN;
+	}
+
+	if (cmd->flags & CMD_ASYNC) {
+		int ret;
+
+		/* An asynchronous command can not expect an SKB to be set. */
+		if (WARN_ON(cmd->flags & CMD_WANT_SKB))
+			return -EINVAL;
+
+		ret = trans->ops->send_cmd(trans, cmd);
+		if (ret < 0) {
+			IWL_ERR(trans,
+				"Error sending %s: enqueue_hcmd failed: %d\n",
+				iwl_get_cmd_string(trans, cmd->id), ret);
+			return ret;
+		}
+		return 0;
+	}
+
+	return iwl_trans_pcie_send_hcmd_sync(trans, cmd);
+}
+IWL_EXPORT_SYMBOL(iwl_trans_pcie_send_hcmd);
diff --git a/drivers/net/wireless/intel/iwlwifi/queue/tx.c b/drivers/net/wireless/intel/iwlwifi/queue/tx.c
deleted file mode 100644
index 726035dfa5cd..000000000000
--- a/drivers/net/wireless/intel/iwlwifi/queue/tx.c
+++ /dev/null
@@ -1,1918 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
-/*
- * Copyright (C) 2020-2024 Intel Corporation
- */
-#include <net/tso.h>
-#include <linux/tcp.h>
-
-#include "iwl-debug.h"
-#include "iwl-io.h"
-#include "fw/api/commands.h"
-#include "fw/api/tx.h"
-#include "fw/api/datapath.h"
-#include "fw/api/debug.h"
-#include "queue/tx.h"
-#include "iwl-fh.h"
-#include "iwl-scd.h"
-#include <linux/dmapool.h>
-
-/*
- * iwl_txq_update_byte_tbl - Set up entry in Tx byte-count array
- */
-static void iwl_pcie_gen2_update_byte_tbl(struct iwl_trans *trans,
-					  struct iwl_txq *txq, u16 byte_cnt,
-					  int num_tbs)
-{
-	int idx = iwl_txq_get_cmd_index(txq, txq->write_ptr);
-	u8 filled_tfd_size, num_fetch_chunks;
-	u16 len = byte_cnt;
-	__le16 bc_ent;
-
-	if (WARN(idx >= txq->n_window, "%d >= %d\n", idx, txq->n_window))
-		return;
-
-	filled_tfd_size = offsetof(struct iwl_tfh_tfd, tbs) +
-			  num_tbs * sizeof(struct iwl_tfh_tb);
-	/*
-	 * filled_tfd_size contains the number of filled bytes in the TFD.
-	 * Dividing it by 64 will give the number of chunks to fetch
-	 * to SRAM- 0 for one chunk, 1 for 2 and so on.
-	 * If, for example, TFD contains only 3 TBs then 32 bytes
-	 * of the TFD are used, and only one chunk of 64 bytes should
-	 * be fetched
-	 */
-	num_fetch_chunks = DIV_ROUND_UP(filled_tfd_size, 64) - 1;
-
-	if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_AX210) {
-		struct iwl_gen3_bc_tbl_entry *scd_bc_tbl_gen3 = txq->bc_tbl.addr;
-
-		/* Starting from AX210, the HW expects bytes */
-		WARN_ON(trans->txqs.bc_table_dword);
-		WARN_ON(len > 0x3FFF);
-		bc_ent = cpu_to_le16(len | (num_fetch_chunks << 14));
-		scd_bc_tbl_gen3[idx].tfd_offset = bc_ent;
-	} else {
-		struct iwlagn_scd_bc_tbl *scd_bc_tbl = txq->bc_tbl.addr;
-
-		/* Before AX210, the HW expects DW */
-		WARN_ON(!trans->txqs.bc_table_dword);
-		len = DIV_ROUND_UP(len, 4);
-		WARN_ON(len > 0xFFF);
-		bc_ent = cpu_to_le16(len | (num_fetch_chunks << 12));
-		scd_bc_tbl->tfd_offset[idx] = bc_ent;
-	}
-}
-
-/*
- * iwl_txq_inc_wr_ptr - Send new write index to hardware
- */
-void iwl_txq_inc_wr_ptr(struct iwl_trans *trans, struct iwl_txq *txq)
-{
-	lockdep_assert_held(&txq->lock);
-
-	IWL_DEBUG_TX(trans, "Q:%d WR: 0x%x\n", txq->id, txq->write_ptr);
-
-	/*
-	 * if not in power-save mode, uCode will never sleep when we're
-	 * trying to tx (during RFKILL, we're not trying to tx).
-	 */
-	iwl_write32(trans, HBUS_TARG_WRPTR, txq->write_ptr | (txq->id << 16));
-}
-
-static u8 iwl_txq_gen2_get_num_tbs(struct iwl_trans *trans,
-				   struct iwl_tfh_tfd *tfd)
-{
-	return le16_to_cpu(tfd->num_tbs) & 0x1f;
-}
-
-int iwl_txq_gen2_set_tb(struct iwl_trans *trans, struct iwl_tfh_tfd *tfd,
-			dma_addr_t addr, u16 len)
-{
-	int idx = iwl_txq_gen2_get_num_tbs(trans, tfd);
-	struct iwl_tfh_tb *tb;
-
-	/* Only WARN here so we know about the issue, but we mess up our
-	 * unmap path because not every place currently checks for errors
-	 * returned from this function - it can only return an error if
-	 * there's no more space, and so when we know there is enough we
-	 * don't always check ...
-	 */
-	WARN(iwl_txq_crosses_4g_boundary(addr, len),
-	     "possible DMA problem with iova:0x%llx, len:%d\n",
-	     (unsigned long long)addr, len);
-
-	if (WARN_ON(idx >= IWL_TFH_NUM_TBS))
-		return -EINVAL;
-	tb = &tfd->tbs[idx];
-
-	/* Each TFD can point to a maximum max_tbs Tx buffers */
-	if (le16_to_cpu(tfd->num_tbs) >= trans->txqs.tfd.max_tbs) {
-		IWL_ERR(trans, "Error can not send more than %d chunks\n",
-			trans->txqs.tfd.max_tbs);
-		return -EINVAL;
-	}
-
-	put_unaligned_le64(addr, &tb->addr);
-	tb->tb_len = cpu_to_le16(len);
-
-	tfd->num_tbs = cpu_to_le16(idx + 1);
-
-	return idx;
-}
-
-static void iwl_txq_set_tfd_invalid_gen2(struct iwl_trans *trans,
-					 struct iwl_tfh_tfd *tfd)
-{
-	tfd->num_tbs = 0;
-
-	iwl_txq_gen2_set_tb(trans, tfd, trans->invalid_tx_cmd.dma,
-			    trans->invalid_tx_cmd.size);
-}
-
-void iwl_txq_gen2_tfd_unmap(struct iwl_trans *trans, struct iwl_cmd_meta *meta,
-			    struct iwl_tfh_tfd *tfd)
-{
-	int i, num_tbs;
-
-	/* Sanity check on number of chunks */
-	num_tbs = iwl_txq_gen2_get_num_tbs(trans, tfd);
-
-	if (num_tbs > trans->txqs.tfd.max_tbs) {
-		IWL_ERR(trans, "Too many chunks: %i\n", num_tbs);
-		return;
-	}
-
-	/* first TB is never freed - it's the bidirectional DMA data */
-	for (i = 1; i < num_tbs; i++) {
-		if (meta->tbs & BIT(i))
-			dma_unmap_page(trans->dev,
-				       le64_to_cpu(tfd->tbs[i].addr),
-				       le16_to_cpu(tfd->tbs[i].tb_len),
-				       DMA_TO_DEVICE);
-		else
-			dma_unmap_single(trans->dev,
-					 le64_to_cpu(tfd->tbs[i].addr),
-					 le16_to_cpu(tfd->tbs[i].tb_len),
-					 DMA_TO_DEVICE);
-	}
-
-	iwl_txq_set_tfd_invalid_gen2(trans, tfd);
-}
-
-void iwl_txq_gen2_free_tfd(struct iwl_trans *trans, struct iwl_txq *txq)
-{
-	/* rd_ptr is bounded by TFD_QUEUE_SIZE_MAX and
-	 * idx is bounded by n_window
-	 */
-	int idx = iwl_txq_get_cmd_index(txq, txq->read_ptr);
-	struct sk_buff *skb;
-
-	lockdep_assert_held(&txq->lock);
-
-	if (!txq->entries)
-		return;
-
-	iwl_txq_gen2_tfd_unmap(trans, &txq->entries[idx].meta,
-			       iwl_txq_get_tfd(trans, txq, idx));
-
-	skb = txq->entries[idx].skb;
-
-	/* Can be called from irqs-disabled context
-	 * If skb is not NULL, it means that the whole queue is being
-	 * freed and that the queue is not empty - free the skb
-	 */
-	if (skb) {
-		iwl_op_mode_free_skb(trans->op_mode, skb);
-		txq->entries[idx].skb = NULL;
-	}
-}
-
-static struct page *get_workaround_page(struct iwl_trans *trans,
-					struct sk_buff *skb)
-{
-	struct page **page_ptr;
-	struct page *ret;
-
-	page_ptr = (void *)((u8 *)skb->cb + trans->txqs.page_offs);
-
-	ret = alloc_page(GFP_ATOMIC);
-	if (!ret)
-		return NULL;
-
-	/* set the chaining pointer to the previous page if there */
-	*(void **)((u8 *)page_address(ret) + PAGE_SIZE - sizeof(void *)) = *page_ptr;
-	*page_ptr = ret;
-
-	return ret;
-}
-
-/*
- * Add a TB and if needed apply the FH HW bug workaround;
- * meta != NULL indicates that it's a page mapping and we
- * need to dma_unmap_page() and set the meta->tbs bit in
- * this case.
- */
-static int iwl_txq_gen2_set_tb_with_wa(struct iwl_trans *trans,
-				       struct sk_buff *skb,
-				       struct iwl_tfh_tfd *tfd,
-				       dma_addr_t phys, void *virt,
-				       u16 len, struct iwl_cmd_meta *meta)
-{
-	dma_addr_t oldphys = phys;
-	struct page *page;
-	int ret;
-
-	if (unlikely(dma_mapping_error(trans->dev, phys)))
-		return -ENOMEM;
-
-	if (likely(!iwl_txq_crosses_4g_boundary(phys, len))) {
-		ret = iwl_txq_gen2_set_tb(trans, tfd, phys, len);
-
-		if (ret < 0)
-			goto unmap;
-
-		if (meta)
-			meta->tbs |= BIT(ret);
-
-		ret = 0;
-		goto trace;
-	}
-
-	/*
-	 * Work around a hardware bug. If (as expressed in the
-	 * condition above) the TB ends on a 32-bit boundary,
-	 * then the next TB may be accessed with the wrong
-	 * address.
-	 * To work around it, copy the data elsewhere and make
-	 * a new mapping for it so the device will not fail.
-	 */
-
-	if (WARN_ON(len > PAGE_SIZE - sizeof(void *))) {
-		ret = -ENOBUFS;
-		goto unmap;
-	}
-
-	page = get_workaround_page(trans, skb);
-	if (!page) {
-		ret = -ENOMEM;
-		goto unmap;
-	}
-
-	memcpy(page_address(page), virt, len);
-
-	phys = dma_map_single(trans->dev, page_address(page), len,
-			      DMA_TO_DEVICE);
-	if (unlikely(dma_mapping_error(trans->dev, phys)))
-		return -ENOMEM;
-	ret = iwl_txq_gen2_set_tb(trans, tfd, phys, len);
-	if (ret < 0) {
-		/* unmap the new allocation as single */
-		oldphys = phys;
-		meta = NULL;
-		goto unmap;
-	}
-	IWL_DEBUG_TX(trans,
-		     "TB bug workaround: copied %d bytes from 0x%llx to 0x%llx\n",
-		     len, (unsigned long long)oldphys,
-		     (unsigned long long)phys);
-
-	ret = 0;
-unmap:
-	if (meta)
-		dma_unmap_page(trans->dev, oldphys, len, DMA_TO_DEVICE);
-	else
-		dma_unmap_single(trans->dev, oldphys, len, DMA_TO_DEVICE);
-trace:
-	trace_iwlwifi_dev_tx_tb(trans->dev, skb, virt, phys, len);
-
-	return ret;
-}
-
-#ifdef CONFIG_INET
-struct iwl_tso_hdr_page *get_page_hdr(struct iwl_trans *trans, size_t len,
-				      struct sk_buff *skb)
-{
-	struct iwl_tso_hdr_page *p = this_cpu_ptr(trans->txqs.tso_hdr_page);
-	struct page **page_ptr;
-
-	page_ptr = (void *)((u8 *)skb->cb + trans->txqs.page_offs);
-
-	if (WARN_ON(*page_ptr))
-		return NULL;
-
-	if (!p->page)
-		goto alloc;
-
-	/*
-	 * Check if there's enough room on this page
-	 *
-	 * Note that we put a page chaining pointer *last* in the
-	 * page - we need it somewhere, and if it's there then we
-	 * avoid DMA mapping the last bits of the page which may
-	 * trigger the 32-bit boundary hardware bug.
-	 *
-	 * (see also get_workaround_page() in tx-gen2.c)
-	 */
-	if (p->pos + len < (u8 *)page_address(p->page) + PAGE_SIZE -
-			   sizeof(void *))
-		goto out;
-
-	/* We don't have enough room on this page, get a new one. */
-	__free_page(p->page);
-
-alloc:
-	p->page = alloc_page(GFP_ATOMIC);
-	if (!p->page)
-		return NULL;
-	p->pos = page_address(p->page);
-	/* set the chaining pointer to NULL */
-	*(void **)((u8 *)page_address(p->page) + PAGE_SIZE - sizeof(void *)) = NULL;
-out:
-	*page_ptr = p->page;
-	get_page(p->page);
-	return p;
-}
-#endif
-
-static int iwl_txq_gen2_build_amsdu(struct iwl_trans *trans,
-				    struct sk_buff *skb,
-				    struct iwl_tfh_tfd *tfd, int start_len,
-				    u8 hdr_len,
-				    struct iwl_device_tx_cmd *dev_cmd)
-{
-#ifdef CONFIG_INET
-	struct iwl_tx_cmd_gen2 *tx_cmd = (void *)dev_cmd->payload;
-	struct ieee80211_hdr *hdr = (void *)skb->data;
-	unsigned int snap_ip_tcp_hdrlen, ip_hdrlen, total_len, hdr_room;
-	unsigned int mss = skb_shinfo(skb)->gso_size;
-	u16 length, amsdu_pad;
-	u8 *start_hdr;
-	struct iwl_tso_hdr_page *hdr_page;
-	struct tso_t tso;
-
-	trace_iwlwifi_dev_tx(trans->dev, skb, tfd, sizeof(*tfd),
-			     &dev_cmd->hdr, start_len, 0);
-
-	ip_hdrlen = skb_network_header_len(skb);
-	snap_ip_tcp_hdrlen = 8 + ip_hdrlen + tcp_hdrlen(skb);
-	total_len = skb->len - snap_ip_tcp_hdrlen - hdr_len;
-	amsdu_pad = 0;
-
-	/* total amount of header we may need for this A-MSDU */
-	hdr_room = DIV_ROUND_UP(total_len, mss) *
-		(3 + snap_ip_tcp_hdrlen + sizeof(struct ethhdr));
-
-	/* Our device supports 9 segments at most, it will fit in 1 page */
-	hdr_page = get_page_hdr(trans, hdr_room, skb);
-	if (!hdr_page)
-		return -ENOMEM;
-
-	start_hdr = hdr_page->pos;
-
-	/*
-	 * Pull the ieee80211 header to be able to use TSO core,
-	 * we will restore it for the tx_status flow.
-	 */
-	skb_pull(skb, hdr_len);
-
-	/*
-	 * Remove the length of all the headers that we don't actually
-	 * have in the MPDU by themselves, but that we duplicate into
-	 * all the different MSDUs inside the A-MSDU.
-	 */
-	le16_add_cpu(&tx_cmd->len, -snap_ip_tcp_hdrlen);
-
-	tso_start(skb, &tso);
-
-	while (total_len) {
-		/* this is the data left for this subframe */
-		unsigned int data_left = min_t(unsigned int, mss, total_len);
-		unsigned int tb_len;
-		dma_addr_t tb_phys;
-		u8 *subf_hdrs_start = hdr_page->pos;
-
-		total_len -= data_left;
-
-		memset(hdr_page->pos, 0, amsdu_pad);
-		hdr_page->pos += amsdu_pad;
-		amsdu_pad = (4 - (sizeof(struct ethhdr) + snap_ip_tcp_hdrlen +
-				  data_left)) & 0x3;
-		ether_addr_copy(hdr_page->pos, ieee80211_get_DA(hdr));
-		hdr_page->pos += ETH_ALEN;
-		ether_addr_copy(hdr_page->pos, ieee80211_get_SA(hdr));
-		hdr_page->pos += ETH_ALEN;
-
-		length = snap_ip_tcp_hdrlen + data_left;
-		*((__be16 *)hdr_page->pos) = cpu_to_be16(length);
-		hdr_page->pos += sizeof(length);
-
-		/*
-		 * This will copy the SNAP as well which will be considered
-		 * as MAC header.
-		 */
-		tso_build_hdr(skb, hdr_page->pos, &tso, data_left, !total_len);
-
-		hdr_page->pos += snap_ip_tcp_hdrlen;
-
-		tb_len = hdr_page->pos - start_hdr;
-		tb_phys = dma_map_single(trans->dev, start_hdr,
-					 tb_len, DMA_TO_DEVICE);
-		if (unlikely(dma_mapping_error(trans->dev, tb_phys)))
-			goto out_err;
-		/*
-		 * No need for _with_wa, this is from the TSO page and
-		 * we leave some space at the end of it so can't hit
-		 * the buggy scenario.
-		 */
-		iwl_txq_gen2_set_tb(trans, tfd, tb_phys, tb_len);
-		trace_iwlwifi_dev_tx_tb(trans->dev, skb, start_hdr,
-					tb_phys, tb_len);
-		/* add this subframe's headers' length to the tx_cmd */
-		le16_add_cpu(&tx_cmd->len, hdr_page->pos - subf_hdrs_start);
-
-		/* prepare the start_hdr for the next subframe */
-		start_hdr = hdr_page->pos;
-
-		/* put the payload */
-		while (data_left) {
-			int ret;
-
-			tb_len = min_t(unsigned int, tso.size, data_left);
-			tb_phys = dma_map_single(trans->dev, tso.data,
-						 tb_len, DMA_TO_DEVICE);
-			ret = iwl_txq_gen2_set_tb_with_wa(trans, skb, tfd,
-							  tb_phys, tso.data,
-							  tb_len, NULL);
-			if (ret)
-				goto out_err;
-
-			data_left -= tb_len;
-			tso_build_data(skb, &tso, tb_len);
-		}
-	}
-
-	/* re -add the WiFi header */
-	skb_push(skb, hdr_len);
-
-	return 0;
-
-out_err:
-#endif
-	return -EINVAL;
-}
-
-static struct
-iwl_tfh_tfd *iwl_txq_gen2_build_tx_amsdu(struct iwl_trans *trans,
-					 struct iwl_txq *txq,
-					 struct iwl_device_tx_cmd *dev_cmd,
-					 struct sk_buff *skb,
-					 struct iwl_cmd_meta *out_meta,
-					 int hdr_len,
-					 int tx_cmd_len)
-{
-	int idx = iwl_txq_get_cmd_index(txq, txq->write_ptr);
-	struct iwl_tfh_tfd *tfd = iwl_txq_get_tfd(trans, txq, idx);
-	dma_addr_t tb_phys;
-	int len;
-	void *tb1_addr;
-
-	tb_phys = iwl_txq_get_first_tb_dma(txq, idx);
-
-	/*
-	 * No need for _with_wa, the first TB allocation is aligned up
-	 * to a 64-byte boundary and thus can't be at the end or cross
-	 * a page boundary (much less a 2^32 boundary).
-	 */
-	iwl_txq_gen2_set_tb(trans, tfd, tb_phys, IWL_FIRST_TB_SIZE);
-
-	/*
-	 * The second TB (tb1) points to the remainder of the TX command
-	 * and the 802.11 header - dword aligned size
-	 * (This calculation modifies the TX command, so do it before the
-	 * setup of the first TB)
-	 */
-	len = tx_cmd_len + sizeof(struct iwl_cmd_header) + hdr_len -
-	      IWL_FIRST_TB_SIZE;
-
-	/* do not align A-MSDU to dword as the subframe header aligns it */
-
-	/* map the data for TB1 */
-	tb1_addr = ((u8 *)&dev_cmd->hdr) + IWL_FIRST_TB_SIZE;
-	tb_phys = dma_map_single(trans->dev, tb1_addr, len, DMA_TO_DEVICE);
-	if (unlikely(dma_mapping_error(trans->dev, tb_phys)))
-		goto out_err;
-	/*
-	 * No need for _with_wa(), we ensure (via alignment) that the data
-	 * here can never cross or end at a page boundary.
-	 */
-	iwl_txq_gen2_set_tb(trans, tfd, tb_phys, len);
-
-	if (iwl_txq_gen2_build_amsdu(trans, skb, tfd, len + IWL_FIRST_TB_SIZE,
-				     hdr_len, dev_cmd))
-		goto out_err;
-
-	/* building the A-MSDU might have changed this data, memcpy it now */
-	memcpy(&txq->first_tb_bufs[idx], dev_cmd, IWL_FIRST_TB_SIZE);
-	return tfd;
-
-out_err:
-	iwl_txq_gen2_tfd_unmap(trans, out_meta, tfd);
-	return NULL;
-}
-
-static int iwl_txq_gen2_tx_add_frags(struct iwl_trans *trans,
-				     struct sk_buff *skb,
-				     struct iwl_tfh_tfd *tfd,
-				     struct iwl_cmd_meta *out_meta)
-{
-	int i;
-
-	for (i = 0; i < skb_shinfo(skb)->nr_frags; i++) {
-		const skb_frag_t *frag = &skb_shinfo(skb)->frags[i];
-		dma_addr_t tb_phys;
-		unsigned int fragsz = skb_frag_size(frag);
-		int ret;
-
-		if (!fragsz)
-			continue;
-
-		tb_phys = skb_frag_dma_map(trans->dev, frag, 0,
-					   fragsz, DMA_TO_DEVICE);
-		ret = iwl_txq_gen2_set_tb_with_wa(trans, skb, tfd, tb_phys,
-						  skb_frag_address(frag),
-						  fragsz, out_meta);
-		if (ret)
-			return ret;
-	}
-
-	return 0;
-}
-
-static struct
-iwl_tfh_tfd *iwl_txq_gen2_build_tx(struct iwl_trans *trans,
-				   struct iwl_txq *txq,
-				   struct iwl_device_tx_cmd *dev_cmd,
-				   struct sk_buff *skb,
-				   struct iwl_cmd_meta *out_meta,
-				   int hdr_len,
-				   int tx_cmd_len,
-				   bool pad)
-{
-	int idx = iwl_txq_get_cmd_index(txq, txq->write_ptr);
-	struct iwl_tfh_tfd *tfd = iwl_txq_get_tfd(trans, txq, idx);
-	dma_addr_t tb_phys;
-	int len, tb1_len, tb2_len;
-	void *tb1_addr;
-	struct sk_buff *frag;
-
-	tb_phys = iwl_txq_get_first_tb_dma(txq, idx);
-
-	/* The first TB points to bi-directional DMA data */
-	memcpy(&txq->first_tb_bufs[idx], dev_cmd, IWL_FIRST_TB_SIZE);
-
-	/*
-	 * No need for _with_wa, the first TB allocation is aligned up
-	 * to a 64-byte boundary and thus can't be at the end or cross
-	 * a page boundary (much less a 2^32 boundary).
-	 */
-	iwl_txq_gen2_set_tb(trans, tfd, tb_phys, IWL_FIRST_TB_SIZE);
-
-	/*
-	 * The second TB (tb1) points to the remainder of the TX command
-	 * and the 802.11 header - dword aligned size
-	 * (This calculation modifies the TX command, so do it before the
-	 * setup of the first TB)
-	 */
-	len = tx_cmd_len + sizeof(struct iwl_cmd_header) + hdr_len -
-	      IWL_FIRST_TB_SIZE;
-
-	if (pad)
-		tb1_len = ALIGN(len, 4);
-	else
-		tb1_len = len;
-
-	/* map the data for TB1 */
-	tb1_addr = ((u8 *)&dev_cmd->hdr) + IWL_FIRST_TB_SIZE;
-	tb_phys = dma_map_single(trans->dev, tb1_addr, tb1_len, DMA_TO_DEVICE);
-	if (unlikely(dma_mapping_error(trans->dev, tb_phys)))
-		goto out_err;
-	/*
-	 * No need for _with_wa(), we ensure (via alignment) that the data
-	 * here can never cross or end at a page boundary.
-	 */
-	iwl_txq_gen2_set_tb(trans, tfd, tb_phys, tb1_len);
-	trace_iwlwifi_dev_tx(trans->dev, skb, tfd, sizeof(*tfd), &dev_cmd->hdr,
-			     IWL_FIRST_TB_SIZE + tb1_len, hdr_len);
-
-	/* set up TFD's third entry to point to remainder of skb's head */
-	tb2_len = skb_headlen(skb) - hdr_len;
-
-	if (tb2_len > 0) {
-		int ret;
-
-		tb_phys = dma_map_single(trans->dev, skb->data + hdr_len,
-					 tb2_len, DMA_TO_DEVICE);
-		ret = iwl_txq_gen2_set_tb_with_wa(trans, skb, tfd, tb_phys,
-						  skb->data + hdr_len, tb2_len,
-						  NULL);
-		if (ret)
-			goto out_err;
-	}
-
-	if (iwl_txq_gen2_tx_add_frags(trans, skb, tfd, out_meta))
-		goto out_err;
-
-	skb_walk_frags(skb, frag) {
-		int ret;
-
-		tb_phys = dma_map_single(trans->dev, frag->data,
-					 skb_headlen(frag), DMA_TO_DEVICE);
-		ret = iwl_txq_gen2_set_tb_with_wa(trans, skb, tfd, tb_phys,
-						  frag->data,
-						  skb_headlen(frag), NULL);
-		if (ret)
-			goto out_err;
-		if (iwl_txq_gen2_tx_add_frags(trans, frag, tfd, out_meta))
-			goto out_err;
-	}
-
-	return tfd;
-
-out_err:
-	iwl_txq_gen2_tfd_unmap(trans, out_meta, tfd);
-	return NULL;
-}
-
-static
-struct iwl_tfh_tfd *iwl_txq_gen2_build_tfd(struct iwl_trans *trans,
-					   struct iwl_txq *txq,
-					   struct iwl_device_tx_cmd *dev_cmd,
-					   struct sk_buff *skb,
-					   struct iwl_cmd_meta *out_meta)
-{
-	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
-	int idx = iwl_txq_get_cmd_index(txq, txq->write_ptr);
-	struct iwl_tfh_tfd *tfd = iwl_txq_get_tfd(trans, txq, idx);
-	int len, hdr_len;
-	bool amsdu;
-
-	/* There must be data left over for TB1 or this code must be changed */
-	BUILD_BUG_ON(sizeof(struct iwl_tx_cmd_gen2) < IWL_FIRST_TB_SIZE);
-	BUILD_BUG_ON(sizeof(struct iwl_cmd_header) +
-		     offsetofend(struct iwl_tx_cmd_gen2, dram_info) >
-		     IWL_FIRST_TB_SIZE);
-	BUILD_BUG_ON(sizeof(struct iwl_tx_cmd_gen3) < IWL_FIRST_TB_SIZE);
-	BUILD_BUG_ON(sizeof(struct iwl_cmd_header) +
-		     offsetofend(struct iwl_tx_cmd_gen3, dram_info) >
-		     IWL_FIRST_TB_SIZE);
-
-	memset(tfd, 0, sizeof(*tfd));
-
-	if (trans->trans_cfg->device_family < IWL_DEVICE_FAMILY_AX210)
-		len = sizeof(struct iwl_tx_cmd_gen2);
-	else
-		len = sizeof(struct iwl_tx_cmd_gen3);
-
-	amsdu = ieee80211_is_data_qos(hdr->frame_control) &&
-			(*ieee80211_get_qos_ctl(hdr) &
-			 IEEE80211_QOS_CTL_A_MSDU_PRESENT);
-
-	hdr_len = ieee80211_hdrlen(hdr->frame_control);
-
-	/*
-	 * Only build A-MSDUs here if doing so by GSO, otherwise it may be
-	 * an A-MSDU for other reasons, e.g. NAN or an A-MSDU having been
-	 * built in the higher layers already.
-	 */
-	if (amsdu && skb_shinfo(skb)->gso_size)
-		return iwl_txq_gen2_build_tx_amsdu(trans, txq, dev_cmd, skb,
-						    out_meta, hdr_len, len);
-	return iwl_txq_gen2_build_tx(trans, txq, dev_cmd, skb, out_meta,
-				      hdr_len, len, !amsdu);
-}
-
-int iwl_txq_space(struct iwl_trans *trans, const struct iwl_txq *q)
-{
-	unsigned int max;
-	unsigned int used;
-
-	/*
-	 * To avoid ambiguity between empty and completely full queues, there
-	 * should always be less than max_tfd_queue_size elements in the queue.
-	 * If q->n_window is smaller than max_tfd_queue_size, there is no need
-	 * to reserve any queue entries for this purpose.
-	 */
-	if (q->n_window < trans->trans_cfg->base_params->max_tfd_queue_size)
-		max = q->n_window;
-	else
-		max = trans->trans_cfg->base_params->max_tfd_queue_size - 1;
-
-	/*
-	 * max_tfd_queue_size is a power of 2, so the following is equivalent to
-	 * modulo by max_tfd_queue_size and is well defined.
-	 */
-	used = (q->write_ptr - q->read_ptr) &
-		(trans->trans_cfg->base_params->max_tfd_queue_size - 1);
-
-	if (WARN_ON(used > max))
-		return 0;
-
-	return max - used;
-}
-
-int iwl_txq_gen2_tx(struct iwl_trans *trans, struct sk_buff *skb,
-		    struct iwl_device_tx_cmd *dev_cmd, int txq_id)
-{
-	struct iwl_cmd_meta *out_meta;
-	struct iwl_txq *txq = trans->txqs.txq[txq_id];
-	u16 cmd_len;
-	int idx;
-	void *tfd;
-
-	if (WARN_ONCE(txq_id >= IWL_MAX_TVQM_QUEUES,
-		      "queue %d out of range", txq_id))
-		return -EINVAL;
-
-	if (WARN_ONCE(!test_bit(txq_id, trans->txqs.queue_used),
-		      "TX on unused queue %d\n", txq_id))
-		return -EINVAL;
-
-	if (skb_is_nonlinear(skb) &&
-	    skb_shinfo(skb)->nr_frags > IWL_TRANS_MAX_FRAGS(trans) &&
-	    __skb_linearize(skb))
-		return -ENOMEM;
-
-	spin_lock(&txq->lock);
-
-	if (iwl_txq_space(trans, txq) < txq->high_mark) {
-		iwl_txq_stop(trans, txq);
-
-		/* don't put the packet on the ring, if there is no room */
-		if (unlikely(iwl_txq_space(trans, txq) < 3)) {
-			struct iwl_device_tx_cmd **dev_cmd_ptr;
-
-			dev_cmd_ptr = (void *)((u8 *)skb->cb +
-					       trans->txqs.dev_cmd_offs);
-
-			*dev_cmd_ptr = dev_cmd;
-			__skb_queue_tail(&txq->overflow_q, skb);
-			spin_unlock(&txq->lock);
-			return 0;
-		}
-	}
-
-	idx = iwl_txq_get_cmd_index(txq, txq->write_ptr);
-
-	/* Set up driver data for this TFD */
-	txq->entries[idx].skb = skb;
-	txq->entries[idx].cmd = dev_cmd;
-
-	dev_cmd->hdr.sequence =
-		cpu_to_le16((u16)(QUEUE_TO_SEQ(txq_id) |
-			    INDEX_TO_SEQ(idx)));
-
-	/* Set up first empty entry in queue's array of Tx/cmd buffers */
-	out_meta = &txq->entries[idx].meta;
-	out_meta->flags = 0;
-
-	tfd = iwl_txq_gen2_build_tfd(trans, txq, dev_cmd, skb, out_meta);
-	if (!tfd) {
-		spin_unlock(&txq->lock);
-		return -1;
-	}
-
-	if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_AX210) {
-		struct iwl_tx_cmd_gen3 *tx_cmd_gen3 =
-			(void *)dev_cmd->payload;
-
-		cmd_len = le16_to_cpu(tx_cmd_gen3->len);
-	} else {
-		struct iwl_tx_cmd_gen2 *tx_cmd_gen2 =
-			(void *)dev_cmd->payload;
-
-		cmd_len = le16_to_cpu(tx_cmd_gen2->len);
-	}
-
-	/* Set up entry for this TFD in Tx byte-count array */
-	iwl_pcie_gen2_update_byte_tbl(trans, txq, cmd_len,
-				      iwl_txq_gen2_get_num_tbs(trans, tfd));
-
-	/* start timer if queue currently empty */
-	if (txq->read_ptr == txq->write_ptr && txq->wd_timeout)
-		mod_timer(&txq->stuck_timer, jiffies + txq->wd_timeout);
-
-	/* Tell device the write index *just past* this latest filled TFD */
-	txq->write_ptr = iwl_txq_inc_wrap(trans, txq->write_ptr);
-	iwl_txq_inc_wr_ptr(trans, txq);
-	/*
-	 * At this point the frame is "transmitted" successfully
-	 * and we will get a TX status notification eventually.
-	 */
-	spin_unlock(&txq->lock);
-	return 0;
-}
-
-/*************** HOST COMMAND QUEUE FUNCTIONS   *****/
-
-/*
- * iwl_txq_gen2_unmap -  Unmap any remaining DMA mappings and free skb's
- */
-void iwl_txq_gen2_unmap(struct iwl_trans *trans, int txq_id)
-{
-	struct iwl_txq *txq = trans->txqs.txq[txq_id];
-
-	spin_lock_bh(&txq->lock);
-	while (txq->write_ptr != txq->read_ptr) {
-		IWL_DEBUG_TX_REPLY(trans, "Q %d Free %d\n",
-				   txq_id, txq->read_ptr);
-
-		if (txq_id != trans->txqs.cmd.q_id) {
-			int idx = iwl_txq_get_cmd_index(txq, txq->read_ptr);
-			struct sk_buff *skb = txq->entries[idx].skb;
-
-			if (!WARN_ON_ONCE(!skb))
-				iwl_txq_free_tso_page(trans, skb);
-		}
-		iwl_txq_gen2_free_tfd(trans, txq);
-		txq->read_ptr = iwl_txq_inc_wrap(trans, txq->read_ptr);
-	}
-
-	while (!skb_queue_empty(&txq->overflow_q)) {
-		struct sk_buff *skb = __skb_dequeue(&txq->overflow_q);
-
-		iwl_op_mode_free_skb(trans->op_mode, skb);
-	}
-
-	spin_unlock_bh(&txq->lock);
-
-	/* just in case - this queue may have been stopped */
-	iwl_wake_queue(trans, txq);
-}
-
-static void iwl_txq_gen2_free_memory(struct iwl_trans *trans,
-				     struct iwl_txq *txq)
-{
-	struct device *dev = trans->dev;
-
-	/* De-alloc circular buffer of TFDs */
-	if (txq->tfds) {
-		dma_free_coherent(dev,
-				  trans->txqs.tfd.size * txq->n_window,
-				  txq->tfds, txq->dma_addr);
-		dma_free_coherent(dev,
-				  sizeof(*txq->first_tb_bufs) * txq->n_window,
-				  txq->first_tb_bufs, txq->first_tb_dma);
-	}
-
-	kfree(txq->entries);
-	if (txq->bc_tbl.addr)
-		dma_pool_free(trans->txqs.bc_pool,
-			      txq->bc_tbl.addr, txq->bc_tbl.dma);
-	kfree(txq);
-}
-
-/*
- * iwl_pcie_txq_free - Deallocate DMA queue.
- * @txq: Transmit queue to deallocate.
- *
- * Empty queue by removing and destroying all BD's.
- * Free all buffers.
- * 0-fill, but do not free "txq" descriptor structure.
- */
-static void iwl_txq_gen2_free(struct iwl_trans *trans, int txq_id)
-{
-	struct iwl_txq *txq;
-	int i;
-
-	if (WARN_ONCE(txq_id >= IWL_MAX_TVQM_QUEUES,
-		      "queue %d out of range", txq_id))
-		return;
-
-	txq = trans->txqs.txq[txq_id];
-
-	if (WARN_ON(!txq))
-		return;
-
-	iwl_txq_gen2_unmap(trans, txq_id);
-
-	/* De-alloc array of command/tx buffers */
-	if (txq_id == trans->txqs.cmd.q_id)
-		for (i = 0; i < txq->n_window; i++) {
-			kfree_sensitive(txq->entries[i].cmd);
-			kfree_sensitive(txq->entries[i].free_buf);
-		}
-	del_timer_sync(&txq->stuck_timer);
-
-	iwl_txq_gen2_free_memory(trans, txq);
-
-	trans->txqs.txq[txq_id] = NULL;
-
-	clear_bit(txq_id, trans->txqs.queue_used);
-}
-
-/*
- * iwl_queue_init - Initialize queue's high/low-water and read/write indexes
- */
-static int iwl_queue_init(struct iwl_txq *q, int slots_num)
-{
-	q->n_window = slots_num;
-
-	/* slots_num must be power-of-two size, otherwise
-	 * iwl_txq_get_cmd_index is broken. */
-	if (WARN_ON(!is_power_of_2(slots_num)))
-		return -EINVAL;
-
-	q->low_mark = q->n_window / 4;
-	if (q->low_mark < 4)
-		q->low_mark = 4;
-
-	q->high_mark = q->n_window / 8;
-	if (q->high_mark < 2)
-		q->high_mark = 2;
-
-	q->write_ptr = 0;
-	q->read_ptr = 0;
-
-	return 0;
-}
-
-int iwl_txq_init(struct iwl_trans *trans, struct iwl_txq *txq, int slots_num,
-		 bool cmd_queue)
-{
-	int ret;
-	u32 tfd_queue_max_size =
-		trans->trans_cfg->base_params->max_tfd_queue_size;
-
-	txq->need_update = false;
-
-	/* max_tfd_queue_size must be power-of-two size, otherwise
-	 * iwl_txq_inc_wrap and iwl_txq_dec_wrap are broken. */
-	if (WARN_ONCE(tfd_queue_max_size & (tfd_queue_max_size - 1),
-		      "Max tfd queue size must be a power of two, but is %d",
-		      tfd_queue_max_size))
-		return -EINVAL;
-
-	/* Initialize queue's high/low-water marks, and head/tail indexes */
-	ret = iwl_queue_init(txq, slots_num);
-	if (ret)
-		return ret;
-
-	spin_lock_init(&txq->lock);
-
-	if (cmd_queue) {
-		static struct lock_class_key iwl_txq_cmd_queue_lock_class;
-
-		lockdep_set_class(&txq->lock, &iwl_txq_cmd_queue_lock_class);
-	}
-
-	__skb_queue_head_init(&txq->overflow_q);
-
-	return 0;
-}
-
-void iwl_txq_free_tso_page(struct iwl_trans *trans, struct sk_buff *skb)
-{
-	struct page **page_ptr;
-	struct page *next;
-
-	page_ptr = (void *)((u8 *)skb->cb + trans->txqs.page_offs);
-	next = *page_ptr;
-	*page_ptr = NULL;
-
-	while (next) {
-		struct page *tmp = next;
-
-		next = *(void **)((u8 *)page_address(next) + PAGE_SIZE -
-				  sizeof(void *));
-		__free_page(tmp);
-	}
-}
-
-void iwl_txq_log_scd_error(struct iwl_trans *trans, struct iwl_txq *txq)
-{
-	u32 txq_id = txq->id;
-	u32 status;
-	bool active;
-	u8 fifo;
-
-	if (trans->trans_cfg->gen2) {
-		IWL_ERR(trans, "Queue %d is stuck %d %d\n", txq_id,
-			txq->read_ptr, txq->write_ptr);
-		/* TODO: access new SCD registers and dump them */
-		return;
-	}
-
-	status = iwl_read_prph(trans, SCD_QUEUE_STATUS_BITS(txq_id));
-	fifo = (status >> SCD_QUEUE_STTS_REG_POS_TXF) & 0x7;
-	active = !!(status & BIT(SCD_QUEUE_STTS_REG_POS_ACTIVE));
-
-	IWL_ERR(trans,
-		"Queue %d is %sactive on fifo %d and stuck for %u ms. SW [%d, %d] HW [%d, %d] FH TRB=0x0%x\n",
-		txq_id, active ? "" : "in", fifo,
-		jiffies_to_msecs(txq->wd_timeout),
-		txq->read_ptr, txq->write_ptr,
-		iwl_read_prph(trans, SCD_QUEUE_RDPTR(txq_id)) &
-			(trans->trans_cfg->base_params->max_tfd_queue_size - 1),
-			iwl_read_prph(trans, SCD_QUEUE_WRPTR(txq_id)) &
-			(trans->trans_cfg->base_params->max_tfd_queue_size - 1),
-			iwl_read_direct32(trans, FH_TX_TRB_REG(fifo)));
-}
-
-static void iwl_txq_stuck_timer(struct timer_list *t)
-{
-	struct iwl_txq *txq = from_timer(txq, t, stuck_timer);
-	struct iwl_trans *trans = txq->trans;
-
-	spin_lock(&txq->lock);
-	/* check if triggered erroneously */
-	if (txq->read_ptr == txq->write_ptr) {
-		spin_unlock(&txq->lock);
-		return;
-	}
-	spin_unlock(&txq->lock);
-
-	iwl_txq_log_scd_error(trans, txq);
-
-	iwl_force_nmi(trans);
-}
-
-static void iwl_txq_set_tfd_invalid_gen1(struct iwl_trans *trans,
-					 struct iwl_tfd *tfd)
-{
-	tfd->num_tbs = 0;
-
-	iwl_pcie_gen1_tfd_set_tb(trans, tfd, 0, trans->invalid_tx_cmd.dma,
-				 trans->invalid_tx_cmd.size);
-}
-
-int iwl_txq_alloc(struct iwl_trans *trans, struct iwl_txq *txq, int slots_num,
-		  bool cmd_queue)
-{
-	size_t num_entries = trans->trans_cfg->gen2 ?
-		slots_num : trans->trans_cfg->base_params->max_tfd_queue_size;
-	size_t tfd_sz;
-	size_t tb0_buf_sz;
-	int i;
-
-	if (WARN_ONCE(slots_num <= 0, "Invalid slots num:%d\n", slots_num))
-		return -EINVAL;
-
-	if (WARN_ON(txq->entries || txq->tfds))
-		return -EINVAL;
-
-	tfd_sz = trans->txqs.tfd.size * num_entries;
-
-	timer_setup(&txq->stuck_timer, iwl_txq_stuck_timer, 0);
-	txq->trans = trans;
-
-	txq->n_window = slots_num;
-
-	txq->entries = kcalloc(slots_num,
-			       sizeof(struct iwl_pcie_txq_entry),
-			       GFP_KERNEL);
-
-	if (!txq->entries)
-		goto error;
-
-	if (cmd_queue)
-		for (i = 0; i < slots_num; i++) {
-			txq->entries[i].cmd =
-				kmalloc(sizeof(struct iwl_device_cmd),
-					GFP_KERNEL);
-			if (!txq->entries[i].cmd)
-				goto error;
-		}
-
-	/* Circular buffer of transmit frame descriptors (TFDs),
-	 * shared with device */
-	txq->tfds = dma_alloc_coherent(trans->dev, tfd_sz,
-				       &txq->dma_addr, GFP_KERNEL);
-	if (!txq->tfds)
-		goto error;
-
-	BUILD_BUG_ON(sizeof(*txq->first_tb_bufs) != IWL_FIRST_TB_SIZE_ALIGN);
-
-	tb0_buf_sz = sizeof(*txq->first_tb_bufs) * slots_num;
-
-	txq->first_tb_bufs = dma_alloc_coherent(trans->dev, tb0_buf_sz,
-						&txq->first_tb_dma,
-						GFP_KERNEL);
-	if (!txq->first_tb_bufs)
-		goto err_free_tfds;
-
-	for (i = 0; i < num_entries; i++) {
-		void *tfd = iwl_txq_get_tfd(trans, txq, i);
-
-		if (trans->trans_cfg->gen2)
-			iwl_txq_set_tfd_invalid_gen2(trans, tfd);
-		else
-			iwl_txq_set_tfd_invalid_gen1(trans, tfd);
-	}
-
-	return 0;
-err_free_tfds:
-	dma_free_coherent(trans->dev, tfd_sz, txq->tfds, txq->dma_addr);
-	txq->tfds = NULL;
-error:
-	if (txq->entries && cmd_queue)
-		for (i = 0; i < slots_num; i++)
-			kfree(txq->entries[i].cmd);
-	kfree(txq->entries);
-	txq->entries = NULL;
-
-	return -ENOMEM;
-}
-
-static struct iwl_txq *
-iwl_txq_dyn_alloc_dma(struct iwl_trans *trans, int size, unsigned int timeout)
-{
-	size_t bc_tbl_size, bc_tbl_entries;
-	struct iwl_txq *txq;
-	int ret;
-
-	WARN_ON(!trans->txqs.bc_tbl_size);
-
-	bc_tbl_size = trans->txqs.bc_tbl_size;
-	bc_tbl_entries = bc_tbl_size / sizeof(u16);
-
-	if (WARN_ON(size > bc_tbl_entries))
-		return ERR_PTR(-EINVAL);
-
-	txq = kzalloc(sizeof(*txq), GFP_KERNEL);
-	if (!txq)
-		return ERR_PTR(-ENOMEM);
-
-	txq->bc_tbl.addr = dma_pool_alloc(trans->txqs.bc_pool, GFP_KERNEL,
-					  &txq->bc_tbl.dma);
-	if (!txq->bc_tbl.addr) {
-		IWL_ERR(trans, "Scheduler BC Table allocation failed\n");
-		kfree(txq);
-		return ERR_PTR(-ENOMEM);
-	}
-
-	ret = iwl_txq_alloc(trans, txq, size, false);
-	if (ret) {
-		IWL_ERR(trans, "Tx queue alloc failed\n");
-		goto error;
-	}
-	ret = iwl_txq_init(trans, txq, size, false);
-	if (ret) {
-		IWL_ERR(trans, "Tx queue init failed\n");
-		goto error;
-	}
-
-	txq->wd_timeout = msecs_to_jiffies(timeout);
-
-	return txq;
-
-error:
-	iwl_txq_gen2_free_memory(trans, txq);
-	return ERR_PTR(ret);
-}
-
-static int iwl_txq_alloc_response(struct iwl_trans *trans, struct iwl_txq *txq,
-				  struct iwl_host_cmd *hcmd)
-{
-	struct iwl_tx_queue_cfg_rsp *rsp;
-	int ret, qid;
-	u32 wr_ptr;
-
-	if (WARN_ON(iwl_rx_packet_payload_len(hcmd->resp_pkt) !=
-		    sizeof(*rsp))) {
-		ret = -EINVAL;
-		goto error_free_resp;
-	}
-
-	rsp = (void *)hcmd->resp_pkt->data;
-	qid = le16_to_cpu(rsp->queue_number);
-	wr_ptr = le16_to_cpu(rsp->write_pointer);
-
-	if (qid >= ARRAY_SIZE(trans->txqs.txq)) {
-		WARN_ONCE(1, "queue index %d unsupported", qid);
-		ret = -EIO;
-		goto error_free_resp;
-	}
-
-	if (test_and_set_bit(qid, trans->txqs.queue_used)) {
-		WARN_ONCE(1, "queue %d already used", qid);
-		ret = -EIO;
-		goto error_free_resp;
-	}
-
-	if (WARN_ONCE(trans->txqs.txq[qid],
-		      "queue %d already allocated\n", qid)) {
-		ret = -EIO;
-		goto error_free_resp;
-	}
-
-	txq->id = qid;
-	trans->txqs.txq[qid] = txq;
-	wr_ptr &= (trans->trans_cfg->base_params->max_tfd_queue_size - 1);
-
-	/* Place first TFD at index corresponding to start sequence number */
-	txq->read_ptr = wr_ptr;
-	txq->write_ptr = wr_ptr;
-
-	IWL_DEBUG_TX_QUEUES(trans, "Activate queue %d\n", qid);
-
-	iwl_free_resp(hcmd);
-	return qid;
-
-error_free_resp:
-	iwl_free_resp(hcmd);
-	iwl_txq_gen2_free_memory(trans, txq);
-	return ret;
-}
-
-int iwl_txq_dyn_alloc(struct iwl_trans *trans, u32 flags, u32 sta_mask,
-		      u8 tid, int size, unsigned int timeout)
-{
-	struct iwl_txq *txq;
-	union {
-		struct iwl_tx_queue_cfg_cmd old;
-		struct iwl_scd_queue_cfg_cmd new;
-	} cmd;
-	struct iwl_host_cmd hcmd = {
-		.flags = CMD_WANT_SKB,
-	};
-	int ret;
-
-	/* take the min with bytecount table entries allowed */
-	size = min_t(u32, size, trans->txqs.bc_tbl_size / sizeof(u16));
-	/* but must be power of 2 values for calculating read/write pointers */
-	size = rounddown_pow_of_two(size);
-
-	if (trans->trans_cfg->device_family == IWL_DEVICE_FAMILY_BZ &&
-	    trans->hw_rev_step == SILICON_A_STEP) {
-		size = 4096;
-		txq = iwl_txq_dyn_alloc_dma(trans, size, timeout);
-	} else {
-		do {
-			txq = iwl_txq_dyn_alloc_dma(trans, size, timeout);
-			if (!IS_ERR(txq))
-				break;
-
-			IWL_DEBUG_TX_QUEUES(trans,
-					    "Failed allocating TXQ of size %d for sta mask %x tid %d, ret: %ld\n",
-					    size, sta_mask, tid,
-					    PTR_ERR(txq));
-			size /= 2;
-		} while (size >= 16);
-	}
-
-	if (IS_ERR(txq))
-		return PTR_ERR(txq);
-
-	if (trans->txqs.queue_alloc_cmd_ver == 0) {
-		memset(&cmd.old, 0, sizeof(cmd.old));
-		cmd.old.tfdq_addr = cpu_to_le64(txq->dma_addr);
-		cmd.old.byte_cnt_addr = cpu_to_le64(txq->bc_tbl.dma);
-		cmd.old.cb_size = cpu_to_le32(TFD_QUEUE_CB_SIZE(size));
-		cmd.old.flags = cpu_to_le16(flags | TX_QUEUE_CFG_ENABLE_QUEUE);
-		cmd.old.tid = tid;
-
-		if (hweight32(sta_mask) != 1) {
-			ret = -EINVAL;
-			goto error;
-		}
-		cmd.old.sta_id = ffs(sta_mask) - 1;
-
-		hcmd.id = SCD_QUEUE_CFG;
-		hcmd.len[0] = sizeof(cmd.old);
-		hcmd.data[0] = &cmd.old;
-	} else if (trans->txqs.queue_alloc_cmd_ver == 3) {
-		memset(&cmd.new, 0, sizeof(cmd.new));
-		cmd.new.operation = cpu_to_le32(IWL_SCD_QUEUE_ADD);
-		cmd.new.u.add.tfdq_dram_addr = cpu_to_le64(txq->dma_addr);
-		cmd.new.u.add.bc_dram_addr = cpu_to_le64(txq->bc_tbl.dma);
-		cmd.new.u.add.cb_size = cpu_to_le32(TFD_QUEUE_CB_SIZE(size));
-		cmd.new.u.add.flags = cpu_to_le32(flags);
-		cmd.new.u.add.sta_mask = cpu_to_le32(sta_mask);
-		cmd.new.u.add.tid = tid;
-
-		hcmd.id = WIDE_ID(DATA_PATH_GROUP, SCD_QUEUE_CONFIG_CMD);
-		hcmd.len[0] = sizeof(cmd.new);
-		hcmd.data[0] = &cmd.new;
-	} else {
-		ret = -EOPNOTSUPP;
-		goto error;
-	}
-
-	ret = iwl_trans_send_cmd(trans, &hcmd);
-	if (ret)
-		goto error;
-
-	return iwl_txq_alloc_response(trans, txq, &hcmd);
-
-error:
-	iwl_txq_gen2_free_memory(trans, txq);
-	return ret;
-}
-
-void iwl_txq_dyn_free(struct iwl_trans *trans, int queue)
-{
-	if (WARN(queue >= IWL_MAX_TVQM_QUEUES,
-		 "queue %d out of range", queue))
-		return;
-
-	/*
-	 * Upon HW Rfkill - we stop the device, and then stop the queues
-	 * in the op_mode. Just for the sake of the simplicity of the op_mode,
-	 * allow the op_mode to call txq_disable after it already called
-	 * stop_device.
-	 */
-	if (!test_and_clear_bit(queue, trans->txqs.queue_used)) {
-		WARN_ONCE(test_bit(STATUS_DEVICE_ENABLED, &trans->status),
-			  "queue %d not used", queue);
-		return;
-	}
-
-	iwl_txq_gen2_free(trans, queue);
-
-	IWL_DEBUG_TX_QUEUES(trans, "Deactivate queue %d\n", queue);
-}
-
-void iwl_txq_gen2_tx_free(struct iwl_trans *trans)
-{
-	int i;
-
-	memset(trans->txqs.queue_used, 0, sizeof(trans->txqs.queue_used));
-
-	/* Free all TX queues */
-	for (i = 0; i < ARRAY_SIZE(trans->txqs.txq); i++) {
-		if (!trans->txqs.txq[i])
-			continue;
-
-		iwl_txq_gen2_free(trans, i);
-	}
-}
-
-int iwl_txq_gen2_init(struct iwl_trans *trans, int txq_id, int queue_size)
-{
-	struct iwl_txq *queue;
-	int ret;
-
-	/* alloc and init the tx queue */
-	if (!trans->txqs.txq[txq_id]) {
-		queue = kzalloc(sizeof(*queue), GFP_KERNEL);
-		if (!queue) {
-			IWL_ERR(trans, "Not enough memory for tx queue\n");
-			return -ENOMEM;
-		}
-		trans->txqs.txq[txq_id] = queue;
-		ret = iwl_txq_alloc(trans, queue, queue_size, true);
-		if (ret) {
-			IWL_ERR(trans, "Tx %d queue init failed\n", txq_id);
-			goto error;
-		}
-	} else {
-		queue = trans->txqs.txq[txq_id];
-	}
-
-	ret = iwl_txq_init(trans, queue, queue_size,
-			   (txq_id == trans->txqs.cmd.q_id));
-	if (ret) {
-		IWL_ERR(trans, "Tx %d queue alloc failed\n", txq_id);
-		goto error;
-	}
-	trans->txqs.txq[txq_id]->id = txq_id;
-	set_bit(txq_id, trans->txqs.queue_used);
-
-	return 0;
-
-error:
-	iwl_txq_gen2_tx_free(trans);
-	return ret;
-}
-
-static inline dma_addr_t iwl_txq_gen1_tfd_tb_get_addr(struct iwl_trans *trans,
-						      struct iwl_tfd *tfd, u8 idx)
-{
-	struct iwl_tfd_tb *tb = &tfd->tbs[idx];
-	dma_addr_t addr;
-	dma_addr_t hi_len;
-
-	addr = get_unaligned_le32(&tb->lo);
-
-	if (sizeof(dma_addr_t) <= sizeof(u32))
-		return addr;
-
-	hi_len = le16_to_cpu(tb->hi_n_len) & 0xF;
-
-	/*
-	 * shift by 16 twice to avoid warnings on 32-bit
-	 * (where this code never runs anyway due to the
-	 * if statement above)
-	 */
-	return addr | ((hi_len << 16) << 16);
-}
-
-void iwl_txq_gen1_tfd_unmap(struct iwl_trans *trans,
-			    struct iwl_cmd_meta *meta,
-			    struct iwl_txq *txq, int index)
-{
-	int i, num_tbs;
-	struct iwl_tfd *tfd = iwl_txq_get_tfd(trans, txq, index);
-
-	/* Sanity check on number of chunks */
-	num_tbs = iwl_txq_gen1_tfd_get_num_tbs(trans, tfd);
-
-	if (num_tbs > trans->txqs.tfd.max_tbs) {
-		IWL_ERR(trans, "Too many chunks: %i\n", num_tbs);
-		/* @todo issue fatal error, it is quite serious situation */
-		return;
-	}
-
-	/* first TB is never freed - it's the bidirectional DMA data */
-
-	for (i = 1; i < num_tbs; i++) {
-		if (meta->tbs & BIT(i))
-			dma_unmap_page(trans->dev,
-				       iwl_txq_gen1_tfd_tb_get_addr(trans,
-								    tfd, i),
-				       iwl_txq_gen1_tfd_tb_get_len(trans,
-								   tfd, i),
-				       DMA_TO_DEVICE);
-		else
-			dma_unmap_single(trans->dev,
-					 iwl_txq_gen1_tfd_tb_get_addr(trans,
-								      tfd, i),
-					 iwl_txq_gen1_tfd_tb_get_len(trans,
-								     tfd, i),
-					 DMA_TO_DEVICE);
-	}
-
-	meta->tbs = 0;
-
-	iwl_txq_set_tfd_invalid_gen1(trans, tfd);
-}
-
-#define IWL_TX_CRC_SIZE 4
-#define IWL_TX_DELIMITER_SIZE 4
-
-/*
- * iwl_txq_gen1_update_byte_cnt_tbl - Set up entry in Tx byte-count array
- */
-void iwl_txq_gen1_update_byte_cnt_tbl(struct iwl_trans *trans,
-				      struct iwl_txq *txq, u16 byte_cnt,
-				      int num_tbs)
-{
-	struct iwlagn_scd_bc_tbl *scd_bc_tbl;
-	int write_ptr = txq->write_ptr;
-	int txq_id = txq->id;
-	u8 sec_ctl = 0;
-	u16 len = byte_cnt + IWL_TX_CRC_SIZE + IWL_TX_DELIMITER_SIZE;
-	__le16 bc_ent;
-	struct iwl_device_tx_cmd *dev_cmd = txq->entries[txq->write_ptr].cmd;
-	struct iwl_tx_cmd *tx_cmd = (void *)dev_cmd->payload;
-	u8 sta_id = tx_cmd->sta_id;
-
-	scd_bc_tbl = trans->txqs.scd_bc_tbls.addr;
-
-	sec_ctl = tx_cmd->sec_ctl;
-
-	switch (sec_ctl & TX_CMD_SEC_MSK) {
-	case TX_CMD_SEC_CCM:
-		len += IEEE80211_CCMP_MIC_LEN;
-		break;
-	case TX_CMD_SEC_TKIP:
-		len += IEEE80211_TKIP_ICV_LEN;
-		break;
-	case TX_CMD_SEC_WEP:
-		len += IEEE80211_WEP_IV_LEN + IEEE80211_WEP_ICV_LEN;
-		break;
-	}
-	if (trans->txqs.bc_table_dword)
-		len = DIV_ROUND_UP(len, 4);
-
-	if (WARN_ON(len > 0xFFF || write_ptr >= TFD_QUEUE_SIZE_MAX))
-		return;
-
-	bc_ent = cpu_to_le16(len | (sta_id << 12));
-
-	scd_bc_tbl[txq_id].tfd_offset[write_ptr] = bc_ent;
-
-	if (write_ptr < TFD_QUEUE_SIZE_BC_DUP)
-		scd_bc_tbl[txq_id].tfd_offset[TFD_QUEUE_SIZE_MAX + write_ptr] =
-			bc_ent;
-}
-
-void iwl_txq_gen1_inval_byte_cnt_tbl(struct iwl_trans *trans,
-				     struct iwl_txq *txq)
-{
-	struct iwlagn_scd_bc_tbl *scd_bc_tbl = trans->txqs.scd_bc_tbls.addr;
-	int txq_id = txq->id;
-	int read_ptr = txq->read_ptr;
-	u8 sta_id = 0;
-	__le16 bc_ent;
-	struct iwl_device_tx_cmd *dev_cmd = txq->entries[read_ptr].cmd;
-	struct iwl_tx_cmd *tx_cmd = (void *)dev_cmd->payload;
-
-	WARN_ON(read_ptr >= TFD_QUEUE_SIZE_MAX);
-
-	if (txq_id != trans->txqs.cmd.q_id)
-		sta_id = tx_cmd->sta_id;
-
-	bc_ent = cpu_to_le16(1 | (sta_id << 12));
-
-	scd_bc_tbl[txq_id].tfd_offset[read_ptr] = bc_ent;
-
-	if (read_ptr < TFD_QUEUE_SIZE_BC_DUP)
-		scd_bc_tbl[txq_id].tfd_offset[TFD_QUEUE_SIZE_MAX + read_ptr] =
-			bc_ent;
-}
-
-/*
- * iwl_txq_free_tfd - Free all chunks referenced by TFD [txq->q.read_ptr]
- * @trans - transport private data
- * @txq - tx queue
- * @dma_dir - the direction of the DMA mapping
- *
- * Does NOT advance any TFD circular buffer read/write indexes
- * Does NOT free the TFD itself (which is within circular buffer)
- */
-void iwl_txq_free_tfd(struct iwl_trans *trans, struct iwl_txq *txq)
-{
-	/* rd_ptr is bounded by TFD_QUEUE_SIZE_MAX and
-	 * idx is bounded by n_window
-	 */
-	int rd_ptr = txq->read_ptr;
-	int idx = iwl_txq_get_cmd_index(txq, rd_ptr);
-	struct sk_buff *skb;
-
-	lockdep_assert_held(&txq->lock);
-
-	if (!txq->entries)
-		return;
-
-	/* We have only q->n_window txq->entries, but we use
-	 * TFD_QUEUE_SIZE_MAX tfds
-	 */
-	if (trans->trans_cfg->gen2)
-		iwl_txq_gen2_tfd_unmap(trans, &txq->entries[idx].meta,
-				       iwl_txq_get_tfd(trans, txq, rd_ptr));
-	else
-		iwl_txq_gen1_tfd_unmap(trans, &txq->entries[idx].meta,
-				       txq, rd_ptr);
-
-	/* free SKB */
-	skb = txq->entries[idx].skb;
-
-	/* Can be called from irqs-disabled context
-	 * If skb is not NULL, it means that the whole queue is being
-	 * freed and that the queue is not empty - free the skb
-	 */
-	if (skb) {
-		iwl_op_mode_free_skb(trans->op_mode, skb);
-		txq->entries[idx].skb = NULL;
-	}
-}
-
-void iwl_txq_progress(struct iwl_txq *txq)
-{
-	lockdep_assert_held(&txq->lock);
-
-	if (!txq->wd_timeout)
-		return;
-
-	/*
-	 * station is asleep and we send data - that must
-	 * be uAPSD or PS-Poll. Don't rearm the timer.
-	 */
-	if (txq->frozen)
-		return;
-
-	/*
-	 * if empty delete timer, otherwise move timer forward
-	 * since we're making progress on this queue
-	 */
-	if (txq->read_ptr == txq->write_ptr)
-		del_timer(&txq->stuck_timer);
-	else
-		mod_timer(&txq->stuck_timer, jiffies + txq->wd_timeout);
-}
-
-/* Frees buffers until index _not_ inclusive */
-void iwl_txq_reclaim(struct iwl_trans *trans, int txq_id, int ssn,
-		     struct sk_buff_head *skbs, bool is_flush)
-{
-	struct iwl_txq *txq = trans->txqs.txq[txq_id];
-	int tfd_num, read_ptr, last_to_free;
-
-	/* This function is not meant to release cmd queue*/
-	if (WARN_ON(txq_id == trans->txqs.cmd.q_id))
-		return;
-
-	if (WARN_ON(!txq))
-		return;
-
-	tfd_num = iwl_txq_get_cmd_index(txq, ssn);
-
-	spin_lock_bh(&txq->lock);
-	read_ptr = iwl_txq_get_cmd_index(txq, txq->read_ptr);
-
-	if (!test_bit(txq_id, trans->txqs.queue_used)) {
-		IWL_DEBUG_TX_QUEUES(trans, "Q %d inactive - ignoring idx %d\n",
-				    txq_id, ssn);
-		goto out;
-	}
-
-	if (read_ptr == tfd_num)
-		goto out;
-
-	IWL_DEBUG_TX_REPLY(trans, "[Q %d] %d (%d) -> %d (%d)\n",
-			   txq_id, read_ptr, txq->read_ptr, tfd_num, ssn);
-
-	/*Since we free until index _not_ inclusive, the one before index is
-	 * the last we will free. This one must be used */
-	last_to_free = iwl_txq_dec_wrap(trans, tfd_num);
-
-	if (!iwl_txq_used(txq, last_to_free)) {
-		IWL_ERR(trans,
-			"%s: Read index for txq id (%d), last_to_free %d is out of range [0-%d] %d %d.\n",
-			__func__, txq_id, last_to_free,
-			trans->trans_cfg->base_params->max_tfd_queue_size,
-			txq->write_ptr, txq->read_ptr);
-
-		iwl_op_mode_time_point(trans->op_mode,
-				       IWL_FW_INI_TIME_POINT_FAKE_TX,
-				       NULL);
-		goto out;
-	}
-
-	if (WARN_ON(!skb_queue_empty(skbs)))
-		goto out;
-
-	for (;
-	     read_ptr != tfd_num;
-	     txq->read_ptr = iwl_txq_inc_wrap(trans, txq->read_ptr),
-	     read_ptr = iwl_txq_get_cmd_index(txq, txq->read_ptr)) {
-		struct sk_buff *skb = txq->entries[read_ptr].skb;
-
-		if (WARN_ONCE(!skb, "no SKB at %d (%d) on queue %d\n",
-			      read_ptr, txq->read_ptr, txq_id))
-			continue;
-
-		iwl_txq_free_tso_page(trans, skb);
-
-		__skb_queue_tail(skbs, skb);
-
-		txq->entries[read_ptr].skb = NULL;
-
-		if (!trans->trans_cfg->gen2)
-			iwl_txq_gen1_inval_byte_cnt_tbl(trans, txq);
-
-		iwl_txq_free_tfd(trans, txq);
-	}
-
-	iwl_txq_progress(txq);
-
-	if (iwl_txq_space(trans, txq) > txq->low_mark &&
-	    test_bit(txq_id, trans->txqs.queue_stopped)) {
-		struct sk_buff_head overflow_skbs;
-		struct sk_buff *skb;
-
-		__skb_queue_head_init(&overflow_skbs);
-		skb_queue_splice_init(&txq->overflow_q,
-				      is_flush ? skbs : &overflow_skbs);
-
-		/*
-		 * We are going to transmit from the overflow queue.
-		 * Remember this state so that wait_for_txq_empty will know we
-		 * are adding more packets to the TFD queue. It cannot rely on
-		 * the state of &txq->overflow_q, as we just emptied it, but
-		 * haven't TXed the content yet.
-		 */
-		txq->overflow_tx = true;
-
-		/*
-		 * This is tricky: we are in reclaim path which is non
-		 * re-entrant, so noone will try to take the access the
-		 * txq data from that path. We stopped tx, so we can't
-		 * have tx as well. Bottom line, we can unlock and re-lock
-		 * later.
-		 */
-		spin_unlock_bh(&txq->lock);
-
-		while ((skb = __skb_dequeue(&overflow_skbs))) {
-			struct iwl_device_tx_cmd *dev_cmd_ptr;
-
-			dev_cmd_ptr = *(void **)((u8 *)skb->cb +
-						 trans->txqs.dev_cmd_offs);
-
-			/*
-			 * Note that we can very well be overflowing again.
-			 * In that case, iwl_txq_space will be small again
-			 * and we won't wake mac80211's queue.
-			 */
-			iwl_trans_tx(trans, skb, dev_cmd_ptr, txq_id);
-		}
-
-		if (iwl_txq_space(trans, txq) > txq->low_mark)
-			iwl_wake_queue(trans, txq);
-
-		spin_lock_bh(&txq->lock);
-		txq->overflow_tx = false;
-	}
-
-out:
-	spin_unlock_bh(&txq->lock);
-}
-
-/* Set wr_ptr of specific device and txq  */
-void iwl_txq_set_q_ptrs(struct iwl_trans *trans, int txq_id, int ptr)
-{
-	struct iwl_txq *txq = trans->txqs.txq[txq_id];
-
-	spin_lock_bh(&txq->lock);
-
-	txq->write_ptr = ptr;
-	txq->read_ptr = txq->write_ptr;
-
-	spin_unlock_bh(&txq->lock);
-}
-
-void iwl_trans_txq_freeze_timer(struct iwl_trans *trans, unsigned long txqs,
-				bool freeze)
-{
-	int queue;
-
-	for_each_set_bit(queue, &txqs, BITS_PER_LONG) {
-		struct iwl_txq *txq = trans->txqs.txq[queue];
-		unsigned long now;
-
-		spin_lock_bh(&txq->lock);
-
-		now = jiffies;
-
-		if (txq->frozen == freeze)
-			goto next_queue;
-
-		IWL_DEBUG_TX_QUEUES(trans, "%s TXQ %d\n",
-				    freeze ? "Freezing" : "Waking", queue);
-
-		txq->frozen = freeze;
-
-		if (txq->read_ptr == txq->write_ptr)
-			goto next_queue;
-
-		if (freeze) {
-			if (unlikely(time_after(now,
-						txq->stuck_timer.expires))) {
-				/*
-				 * The timer should have fired, maybe it is
-				 * spinning right now on the lock.
-				 */
-				goto next_queue;
-			}
-			/* remember how long until the timer fires */
-			txq->frozen_expiry_remainder =
-				txq->stuck_timer.expires - now;
-			del_timer(&txq->stuck_timer);
-			goto next_queue;
-		}
-
-		/*
-		 * Wake a non-empty queue -> arm timer with the
-		 * remainder before it froze
-		 */
-		mod_timer(&txq->stuck_timer,
-			  now + txq->frozen_expiry_remainder);
-
-next_queue:
-		spin_unlock_bh(&txq->lock);
-	}
-}
-
-#define HOST_COMPLETE_TIMEOUT	(2 * HZ)
-
-static int iwl_trans_txq_send_hcmd_sync(struct iwl_trans *trans,
-					struct iwl_host_cmd *cmd)
-{
-	const char *cmd_str = iwl_get_cmd_string(trans, cmd->id);
-	struct iwl_txq *txq = trans->txqs.txq[trans->txqs.cmd.q_id];
-	int cmd_idx;
-	int ret;
-
-	IWL_DEBUG_INFO(trans, "Attempting to send sync command %s\n", cmd_str);
-
-	if (WARN(test_and_set_bit(STATUS_SYNC_HCMD_ACTIVE,
-				  &trans->status),
-		 "Command %s: a command is already active!\n", cmd_str))
-		return -EIO;
-
-	IWL_DEBUG_INFO(trans, "Setting HCMD_ACTIVE for command %s\n", cmd_str);
-
-	cmd_idx = trans->ops->send_cmd(trans, cmd);
-	if (cmd_idx < 0) {
-		ret = cmd_idx;
-		clear_bit(STATUS_SYNC_HCMD_ACTIVE, &trans->status);
-		IWL_ERR(trans, "Error sending %s: enqueue_hcmd failed: %d\n",
-			cmd_str, ret);
-		return ret;
-	}
-
-	ret = wait_event_timeout(trans->wait_command_queue,
-				 !test_bit(STATUS_SYNC_HCMD_ACTIVE,
-					   &trans->status),
-				 HOST_COMPLETE_TIMEOUT);
-	if (!ret) {
-		IWL_ERR(trans, "Error sending %s: time out after %dms.\n",
-			cmd_str, jiffies_to_msecs(HOST_COMPLETE_TIMEOUT));
-
-		IWL_ERR(trans, "Current CMD queue read_ptr %d write_ptr %d\n",
-			txq->read_ptr, txq->write_ptr);
-
-		clear_bit(STATUS_SYNC_HCMD_ACTIVE, &trans->status);
-		IWL_DEBUG_INFO(trans, "Clearing HCMD_ACTIVE for command %s\n",
-			       cmd_str);
-		ret = -ETIMEDOUT;
-
-		iwl_trans_sync_nmi(trans);
-		goto cancel;
-	}
-
-	if (test_bit(STATUS_FW_ERROR, &trans->status)) {
-		if (!test_and_clear_bit(STATUS_SUPPRESS_CMD_ERROR_ONCE,
-					&trans->status)) {
-			IWL_ERR(trans, "FW error in SYNC CMD %s\n", cmd_str);
-			dump_stack();
-		}
-		ret = -EIO;
-		goto cancel;
-	}
-
-	if (!(cmd->flags & CMD_SEND_IN_RFKILL) &&
-	    test_bit(STATUS_RFKILL_OPMODE, &trans->status)) {
-		IWL_DEBUG_RF_KILL(trans, "RFKILL in SYNC CMD... no rsp\n");
-		ret = -ERFKILL;
-		goto cancel;
-	}
-
-	if ((cmd->flags & CMD_WANT_SKB) && !cmd->resp_pkt) {
-		IWL_ERR(trans, "Error: Response NULL in '%s'\n", cmd_str);
-		ret = -EIO;
-		goto cancel;
-	}
-
-	return 0;
-
-cancel:
-	if (cmd->flags & CMD_WANT_SKB) {
-		/*
-		 * Cancel the CMD_WANT_SKB flag for the cmd in the
-		 * TX cmd queue. Otherwise in case the cmd comes
-		 * in later, it will possibly set an invalid
-		 * address (cmd->meta.source).
-		 */
-		txq->entries[cmd_idx].meta.flags &= ~CMD_WANT_SKB;
-	}
-
-	if (cmd->resp_pkt) {
-		iwl_free_resp(cmd);
-		cmd->resp_pkt = NULL;
-	}
-
-	return ret;
-}
-
-int iwl_trans_txq_send_hcmd(struct iwl_trans *trans,
-			    struct iwl_host_cmd *cmd)
-{
-	/* Make sure the NIC is still alive in the bus */
-	if (test_bit(STATUS_TRANS_DEAD, &trans->status))
-		return -ENODEV;
-
-	if (!(cmd->flags & CMD_SEND_IN_RFKILL) &&
-	    test_bit(STATUS_RFKILL_OPMODE, &trans->status)) {
-		IWL_DEBUG_RF_KILL(trans, "Dropping CMD 0x%x: RF KILL\n",
-				  cmd->id);
-		return -ERFKILL;
-	}
-
-	if (unlikely(trans->system_pm_mode == IWL_PLAT_PM_MODE_D3 &&
-		     !(cmd->flags & CMD_SEND_IN_D3))) {
-		IWL_DEBUG_WOWLAN(trans, "Dropping CMD 0x%x: D3\n", cmd->id);
-		return -EHOSTDOWN;
-	}
-
-	if (cmd->flags & CMD_ASYNC) {
-		int ret;
-
-		/* An asynchronous command can not expect an SKB to be set. */
-		if (WARN_ON(cmd->flags & CMD_WANT_SKB))
-			return -EINVAL;
-
-		ret = trans->ops->send_cmd(trans, cmd);
-		if (ret < 0) {
-			IWL_ERR(trans,
-				"Error sending %s: enqueue_hcmd failed: %d\n",
-				iwl_get_cmd_string(trans, cmd->id), ret);
-			return ret;
-		}
-		return 0;
-	}
-
-	return iwl_trans_txq_send_hcmd_sync(trans, cmd);
-}
-
diff --git a/drivers/net/wireless/intel/iwlwifi/queue/tx.h b/drivers/net/wireless/intel/iwlwifi/queue/tx.h
deleted file mode 100644
index 124b29aac4a1..000000000000
--- a/drivers/net/wireless/intel/iwlwifi/queue/tx.h
+++ /dev/null
@@ -1,191 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
-/*
- * Copyright (C) 2020-2023 Intel Corporation
- */
-#ifndef __iwl_trans_queue_tx_h__
-#define __iwl_trans_queue_tx_h__
-#include "iwl-fh.h"
-#include "fw/api/tx.h"
-
-struct iwl_tso_hdr_page {
-	struct page *page;
-	u8 *pos;
-};
-
-static inline dma_addr_t
-iwl_txq_get_first_tb_dma(struct iwl_txq *txq, int idx)
-{
-	return txq->first_tb_dma +
-	       sizeof(struct iwl_pcie_first_tb_buf) * idx;
-}
-
-static inline u16 iwl_txq_get_cmd_index(const struct iwl_txq *q, u32 index)
-{
-	return index & (q->n_window - 1);
-}
-
-void iwl_txq_gen2_unmap(struct iwl_trans *trans, int txq_id);
-
-static inline void iwl_wake_queue(struct iwl_trans *trans,
-				  struct iwl_txq *txq)
-{
-	if (test_and_clear_bit(txq->id, trans->txqs.queue_stopped)) {
-		IWL_DEBUG_TX_QUEUES(trans, "Wake hwq %d\n", txq->id);
-		iwl_op_mode_queue_not_full(trans->op_mode, txq->id);
-	}
-}
-
-static inline void *iwl_txq_get_tfd(struct iwl_trans *trans,
-				    struct iwl_txq *txq, int idx)
-{
-	if (trans->trans_cfg->gen2)
-		idx = iwl_txq_get_cmd_index(txq, idx);
-
-	return (u8 *)txq->tfds + trans->txqs.tfd.size * idx;
-}
-
-int iwl_txq_alloc(struct iwl_trans *trans, struct iwl_txq *txq, int slots_num,
-		  bool cmd_queue);
-/*
- * We need this inline in case dma_addr_t is only 32-bits - since the
- * hardware is always 64-bit, the issue can still occur in that case,
- * so use u64 for 'phys' here to force the addition in 64-bit.
- */
-static inline bool iwl_txq_crosses_4g_boundary(u64 phys, u16 len)
-{
-	return upper_32_bits(phys) != upper_32_bits(phys + len);
-}
-
-int iwl_txq_space(struct iwl_trans *trans, const struct iwl_txq *q);
-
-static inline void iwl_txq_stop(struct iwl_trans *trans, struct iwl_txq *txq)
-{
-	if (!test_and_set_bit(txq->id, trans->txqs.queue_stopped)) {
-		iwl_op_mode_queue_full(trans->op_mode, txq->id);
-		IWL_DEBUG_TX_QUEUES(trans, "Stop hwq %d\n", txq->id);
-	} else {
-		IWL_DEBUG_TX_QUEUES(trans, "hwq %d already stopped\n",
-				    txq->id);
-	}
-}
-
-/**
- * iwl_txq_inc_wrap - increment queue index, wrap back to beginning
- * @trans: the transport (for configuration data)
- * @index: current index
- */
-static inline int iwl_txq_inc_wrap(struct iwl_trans *trans, int index)
-{
-	return ++index &
-		(trans->trans_cfg->base_params->max_tfd_queue_size - 1);
-}
-
-/**
- * iwl_txq_dec_wrap - decrement queue index, wrap back to end
- * @trans: the transport (for configuration data)
- * @index: current index
- */
-static inline int iwl_txq_dec_wrap(struct iwl_trans *trans, int index)
-{
-	return --index &
-		(trans->trans_cfg->base_params->max_tfd_queue_size - 1);
-}
-
-static inline bool iwl_txq_used(const struct iwl_txq *q, int i)
-{
-	int index = iwl_txq_get_cmd_index(q, i);
-	int r = iwl_txq_get_cmd_index(q, q->read_ptr);
-	int w = iwl_txq_get_cmd_index(q, q->write_ptr);
-
-	return w >= r ?
-		(index >= r && index < w) :
-		!(index < r && index >= w);
-}
-
-void iwl_txq_free_tso_page(struct iwl_trans *trans, struct sk_buff *skb);
-
-void iwl_txq_log_scd_error(struct iwl_trans *trans, struct iwl_txq *txq);
-
-int iwl_txq_gen2_set_tb(struct iwl_trans *trans,
-			struct iwl_tfh_tfd *tfd, dma_addr_t addr,
-			u16 len);
-
-void iwl_txq_gen2_tfd_unmap(struct iwl_trans *trans,
-			    struct iwl_cmd_meta *meta,
-			    struct iwl_tfh_tfd *tfd);
-
-int iwl_txq_dyn_alloc(struct iwl_trans *trans, u32 flags,
-		      u32 sta_mask, u8 tid,
-		      int size, unsigned int timeout);
-
-int iwl_txq_gen2_tx(struct iwl_trans *trans, struct sk_buff *skb,
-		    struct iwl_device_tx_cmd *dev_cmd, int txq_id);
-
-void iwl_txq_dyn_free(struct iwl_trans *trans, int queue);
-void iwl_txq_gen2_free_tfd(struct iwl_trans *trans, struct iwl_txq *txq);
-void iwl_txq_inc_wr_ptr(struct iwl_trans *trans, struct iwl_txq *txq);
-void iwl_txq_gen2_tx_free(struct iwl_trans *trans);
-int iwl_txq_init(struct iwl_trans *trans, struct iwl_txq *txq, int slots_num,
-		 bool cmd_queue);
-int iwl_txq_gen2_init(struct iwl_trans *trans, int txq_id, int queue_size);
-#ifdef CONFIG_INET
-struct iwl_tso_hdr_page *get_page_hdr(struct iwl_trans *trans, size_t len,
-				      struct sk_buff *skb);
-#endif
-static inline u8 iwl_txq_gen1_tfd_get_num_tbs(struct iwl_trans *trans,
-					      struct iwl_tfd *tfd)
-{
-	return tfd->num_tbs & 0x1f;
-}
-
-static inline u16 iwl_txq_gen1_tfd_tb_get_len(struct iwl_trans *trans,
-					      void *_tfd, u8 idx)
-{
-	struct iwl_tfd *tfd;
-	struct iwl_tfd_tb *tb;
-
-	if (trans->trans_cfg->gen2) {
-		struct iwl_tfh_tfd *tfh_tfd = _tfd;
-		struct iwl_tfh_tb *tfh_tb = &tfh_tfd->tbs[idx];
-
-		return le16_to_cpu(tfh_tb->tb_len);
-	}
-
-	tfd = (struct iwl_tfd *)_tfd;
-	tb = &tfd->tbs[idx];
-
-	return le16_to_cpu(tb->hi_n_len) >> 4;
-}
-
-static inline void iwl_pcie_gen1_tfd_set_tb(struct iwl_trans *trans,
-					    struct iwl_tfd *tfd,
-					    u8 idx, dma_addr_t addr, u16 len)
-{
-	struct iwl_tfd_tb *tb = &tfd->tbs[idx];
-	u16 hi_n_len = len << 4;
-
-	put_unaligned_le32(addr, &tb->lo);
-	hi_n_len |= iwl_get_dma_hi_addr(addr);
-
-	tb->hi_n_len = cpu_to_le16(hi_n_len);
-
-	tfd->num_tbs = idx + 1;
-}
-
-void iwl_txq_gen1_tfd_unmap(struct iwl_trans *trans,
-			    struct iwl_cmd_meta *meta,
-			    struct iwl_txq *txq, int index);
-void iwl_txq_gen1_inval_byte_cnt_tbl(struct iwl_trans *trans,
-				     struct iwl_txq *txq);
-void iwl_txq_gen1_update_byte_cnt_tbl(struct iwl_trans *trans,
-				      struct iwl_txq *txq, u16 byte_cnt,
-				      int num_tbs);
-void iwl_txq_reclaim(struct iwl_trans *trans, int txq_id, int ssn,
-		     struct sk_buff_head *skbs, bool is_flush);
-void iwl_txq_set_q_ptrs(struct iwl_trans *trans, int txq_id, int ptr);
-void iwl_trans_txq_freeze_timer(struct iwl_trans *trans, unsigned long txqs,
-				bool freeze);
-void iwl_txq_progress(struct iwl_txq *txq);
-void iwl_txq_free_tfd(struct iwl_trans *trans, struct iwl_txq *txq);
-int iwl_trans_txq_send_hcmd(struct iwl_trans *trans, struct iwl_host_cmd *cmd);
-#endif /* __iwl_trans_queue_tx_h__ */
-- 
2.34.1


