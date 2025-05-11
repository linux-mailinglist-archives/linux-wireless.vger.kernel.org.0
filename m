Return-Path: <linux-wireless+bounces-22852-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7482AB29CC
	for <lists+linux-wireless@lfdr.de>; Sun, 11 May 2025 18:54:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30AD53A6848
	for <lists+linux-wireless@lfdr.de>; Sun, 11 May 2025 16:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A9D325D54B;
	Sun, 11 May 2025 16:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W7lKEhkz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF3D25D523
	for <linux-wireless@vger.kernel.org>; Sun, 11 May 2025 16:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746982434; cv=none; b=a3cygmmJrL7hvUOgQfMgD2DWvpvOe19mDPx6ziIfdG2bB547/QGkLke33Qf0vdW9CeUT8B6PtoTcB/ovO3GIb7pLQuNkvDd4xRi4UhecZcmwtIJjqh2SnApBB+I6nXuHYyW4OrafiCNVTQxB85BgkpH/3698uhGtf0Wr+X2BteE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746982434; c=relaxed/simple;
	bh=huQg37HN4flkIKR02Ucn+o2iFlB3GTquhKuUyk1T1mU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZeDngxZwLC1jfOVM8bsT9cQA6LOKlKu/7Snho/j6HgRPSfp0UfedXdWzMSPw/aFxrN0AVyyNw8awJ6S1gGuncnWIYc7cwkM/eosL0b5FEuNQAM9nJApPOy9A3pF9zy+lh8X36JNa5APyurMnCPJ2orjNy7HgWracGjIJWXatit4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W7lKEhkz; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746982432; x=1778518432;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=huQg37HN4flkIKR02Ucn+o2iFlB3GTquhKuUyk1T1mU=;
  b=W7lKEhkzeE306rhsxUMCzG8/qv7Kc34uiD1t75wUeGTDEI+PCivyscRB
   Pti4VeJZFSuaMywR+knlCWF8kb5DhDmCGOmqFdo+2ZYpHt7cZbSRZpXaa
   Rp5nnSrZgk6QosoP/a8XEiPMzvTtUwqQpuL9XHO9ZItcNOAeqgzkfoBpH
   pUNesCUj24dPM2BiN4ADduZeK+eTXc+Rt6xrZ4uWvDCrN9Uv2iKwID3V/
   /ElOgeXcpRAUItEpgcwlZ7toz6M/lnAHxhS8rZKgdVN5GgnXgTcQEu7Cp
   o+4UiomTnO2TabCMexKifOpuqhZmyPhOpiOc4LYbf6Npsmr51jwKHkYYx
   Q==;
X-CSE-ConnectionGUID: Vndut2+7RqOkN9xUcIBQDw==
X-CSE-MsgGUID: E+5rFbK1RGG2hderCy86Bw==
X-IronPort-AV: E=McAfee;i="6700,10204,11430"; a="52582703"
X-IronPort-AV: E=Sophos;i="6.15,280,1739865600"; 
   d="scan'208";a="52582703"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2025 09:53:52 -0700
X-CSE-ConnectionGUID: kzMF6jgJRAKGv4IAlvI1Dg==
X-CSE-MsgGUID: gGHrk6j6RX2UH7FYJNHtHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,280,1739865600"; 
   d="scan'208";a="137655103"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2025 09:53:51 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 13/15] wifi: iwlwifi: rename ctx-info-gen3 to ctx-info-v2
Date: Sun, 11 May 2025 19:53:19 +0300
Message-Id: <20250511195137.a580bd8d4f74.Ie413a02233f1a5ad538e13071c09760b9d97be3b@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250511165321.590808-1-miriam.rachel.korenblit@intel.com>
References: <20250511165321.590808-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

Context info was introduced in 22000, and was significantly changed in
ax210. The new version of context info was called 'gen3',
probably because in 22000, the gen2 transport was added.

But this name is just wrong:
- if 'gen' enumerates transports, there was not a gen3 transport, just a
  few modifications to gen1/2 transports needed for ax210.
- if 'gen' enumerates devices, then we can just use the device names.

Also, context info will soon become a lib, agnostic of the transport
generations.
Simply replace 'gen3' with 'v2'.

Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/Makefile   |  2 +-
 ...text-info-gen3.h => iwl-context-info-v2.h} | 40 ++++-----
 .../net/wireless/intel/iwlwifi/iwl-trans.c    | 10 +--
 .../pcie/{ctxt-info-gen3.c => ctxt-info-v2.c} | 84 +++++++++----------
 .../wireless/intel/iwlwifi/pcie/internal.h    |  4 +-
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c  |  2 +-
 .../wireless/intel/iwlwifi/pcie/trans-gen2.c  | 10 +--
 .../net/wireless/intel/iwlwifi/pcie/trans.c   |  2 +-
 8 files changed, 77 insertions(+), 77 deletions(-)
 rename drivers/net/wireless/intel/iwlwifi/{iwl-context-info-gen3.h => iwl-context-info-v2.h} (91%)
 rename drivers/net/wireless/intel/iwlwifi/pcie/{ctxt-info-gen3.c => ctxt-info-v2.c} (89%)

diff --git a/drivers/net/wireless/intel/iwlwifi/Makefile b/drivers/net/wireless/intel/iwlwifi/Makefile
index 031babc65a0d..3f476e333726 100644
--- a/drivers/net/wireless/intel/iwlwifi/Makefile
+++ b/drivers/net/wireless/intel/iwlwifi/Makefile
@@ -8,7 +8,7 @@ iwlwifi-objs		+= iwl-nvm-utils.o
 iwlwifi-objs		+= iwl-utils.o
 iwlwifi-objs		+= iwl-phy-db.o iwl-nvm-parse.o
 iwlwifi-objs		+= pcie/drv.o pcie/rx.o pcie/tx.o pcie/trans.o
-iwlwifi-objs		+= pcie/ctxt-info.o pcie/ctxt-info-gen3.o
+iwlwifi-objs		+= pcie/ctxt-info.o pcie/ctxt-info-v2.o
 iwlwifi-objs		+= pcie/trans-gen2.o pcie/tx-gen2.o
 
 CFLAGS_pcie/drv.o += -Wno-override-init
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-context-info-gen3.h b/drivers/net/wireless/intel/iwlwifi/iwl-context-info-v2.h
similarity index 91%
rename from drivers/net/wireless/intel/iwlwifi/iwl-context-info-gen3.h
rename to drivers/net/wireless/intel/iwlwifi/iwl-context-info-v2.h
index 70295098ae98..8c5c0ea46181 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-context-info-gen3.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-context-info-v2.h
@@ -2,8 +2,8 @@
 /*
  * Copyright (C) 2018, 2020-2025 Intel Corporation
  */
-#ifndef __iwl_context_info_file_gen3_h__
-#define __iwl_context_info_file_gen3_h__
+#ifndef __iwl_context_info_file_v2_h__
+#define __iwl_context_info_file_v2_h__
 
 #include "iwl-context-info.h"
 
@@ -250,7 +250,7 @@ struct iwl_prph_info {
 } __packed; /* PERIPH_INFO_S */
 
 /**
- * struct iwl_context_info_gen3 - device INIT configuration
+ * struct iwl_context_info_v2 - device INIT configuration
  * @version: version of the context information
  * @size: size of context information in DWs
  * @config: context in which the peripheral would execute - a subset of
@@ -293,7 +293,7 @@ struct iwl_prph_info {
  * @prph_scratch_size: the size of the peripheral scratch structure in DWs
  * @reserved: reserved
  */
-struct iwl_context_info_gen3 {
+struct iwl_context_info_v2 {
 	__le16 version;
 	__le16 size;
 	__le32 config;
@@ -323,22 +323,22 @@ struct iwl_context_info_gen3 {
 	__le32 reserved;
 } __packed; /* IPC_CONTEXT_INFO_S */
 
-int iwl_pcie_ctxt_info_gen3_alloc(struct iwl_trans *trans,
-				  const struct iwl_fw *fw,
-				  const struct fw_img *img);
-void iwl_pcie_ctxt_info_gen3_kick(struct iwl_trans *trans);
-void iwl_pcie_ctxt_info_gen3_free(struct iwl_trans *trans, bool alive);
+int iwl_pcie_ctxt_info_v2_alloc(struct iwl_trans *trans,
+				const struct iwl_fw *fw,
+				const struct fw_img *img);
+void iwl_pcie_ctxt_info_v2_kick(struct iwl_trans *trans);
+void iwl_pcie_ctxt_info_v2_free(struct iwl_trans *trans, bool alive);
 
-int iwl_trans_pcie_ctx_info_gen3_load_pnvm(struct iwl_trans *trans,
-					   const struct iwl_pnvm_image *pnvm_payloads,
-					   const struct iwl_ucode_capabilities *capa);
-void iwl_trans_pcie_ctx_info_gen3_set_pnvm(struct iwl_trans *trans,
-					   const struct iwl_ucode_capabilities *capa);
+int iwl_trans_pcie_ctx_info_v2_load_pnvm(struct iwl_trans *trans,
+					 const struct iwl_pnvm_image *pnvm_payloads,
+					 const struct iwl_ucode_capabilities *capa);
+void iwl_trans_pcie_ctx_info_v2_set_pnvm(struct iwl_trans *trans,
+					 const struct iwl_ucode_capabilities *capa);
 int
-iwl_trans_pcie_ctx_info_gen3_load_reduce_power(struct iwl_trans *trans,
-					       const struct iwl_pnvm_image *payloads,
-					       const struct iwl_ucode_capabilities *capa);
+iwl_trans_pcie_ctx_info_v2_load_reduce_power(struct iwl_trans *trans,
+					     const struct iwl_pnvm_image *payloads,
+					     const struct iwl_ucode_capabilities *capa);
 void
-iwl_trans_pcie_ctx_info_gen3_set_reduce_power(struct iwl_trans *trans,
-					      const struct iwl_ucode_capabilities *capa);
-#endif /* __iwl_context_info_file_gen3_h__ */
+iwl_trans_pcie_ctx_info_v2_set_reduce_power(struct iwl_trans *trans,
+					    const struct iwl_ucode_capabilities *capa);
+#endif /* __iwl_context_info_file_v2_h__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.c b/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
index 51bedd09dc69..59c5ea1727f4 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
@@ -15,7 +15,7 @@
 #include <linux/dmapool.h>
 #include "fw/api/commands.h"
 #include "pcie/internal.h"
-#include "iwl-context-info-gen3.h"
+#include "iwl-context-info-v2.h"
 
 struct iwl_trans_dev_restart_data {
 	struct list_head list;
@@ -813,14 +813,14 @@ int iwl_trans_load_pnvm(struct iwl_trans *trans,
 			const struct iwl_pnvm_image *pnvm_data,
 			const struct iwl_ucode_capabilities *capa)
 {
-	return iwl_trans_pcie_ctx_info_gen3_load_pnvm(trans, pnvm_data, capa);
+	return iwl_trans_pcie_ctx_info_v2_load_pnvm(trans, pnvm_data, capa);
 }
 IWL_EXPORT_SYMBOL(iwl_trans_load_pnvm);
 
 void iwl_trans_set_pnvm(struct iwl_trans *trans,
 			const struct iwl_ucode_capabilities *capa)
 {
-	iwl_trans_pcie_ctx_info_gen3_set_pnvm(trans, capa);
+	iwl_trans_pcie_ctx_info_v2_set_pnvm(trans, capa);
 }
 IWL_EXPORT_SYMBOL(iwl_trans_set_pnvm);
 
@@ -828,7 +828,7 @@ int iwl_trans_load_reduce_power(struct iwl_trans *trans,
 				const struct iwl_pnvm_image *payloads,
 				const struct iwl_ucode_capabilities *capa)
 {
-	return iwl_trans_pcie_ctx_info_gen3_load_reduce_power(trans, payloads,
+	return iwl_trans_pcie_ctx_info_v2_load_reduce_power(trans, payloads,
 							      capa);
 }
 IWL_EXPORT_SYMBOL(iwl_trans_load_reduce_power);
@@ -836,6 +836,6 @@ IWL_EXPORT_SYMBOL(iwl_trans_load_reduce_power);
 void iwl_trans_set_reduce_power(struct iwl_trans *trans,
 				const struct iwl_ucode_capabilities *capa)
 {
-	iwl_trans_pcie_ctx_info_gen3_set_reduce_power(trans, capa);
+	iwl_trans_pcie_ctx_info_v2_set_reduce_power(trans, capa);
 }
 IWL_EXPORT_SYMBOL(iwl_trans_set_reduce_power);
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-v2.c
similarity index 89%
rename from drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
rename to drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-v2.c
index 4759e570e807..976fd1f58da4 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-v2.c
@@ -5,7 +5,7 @@
 #include <linux/dmi.h>
 #include "iwl-trans.h"
 #include "iwl-fh.h"
-#include "iwl-context-info-gen3.h"
+#include "iwl-context-info-v2.h"
 #include "internal.h"
 #include "iwl-prph.h"
 
@@ -97,12 +97,12 @@ iwl_pcie_ctxt_info_dbg_enable(struct iwl_trans *trans,
 		*control_flags |= IWL_PRPH_SCRATCH_EARLY_DEBUG_EN | dbg_flags;
 }
 
-int iwl_pcie_ctxt_info_gen3_alloc(struct iwl_trans *trans,
-				  const struct iwl_fw *fw,
-				  const struct fw_img *img)
+int iwl_pcie_ctxt_info_v2_alloc(struct iwl_trans *trans,
+				const struct iwl_fw *fw,
+				const struct fw_img *img)
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
-	struct iwl_context_info_gen3 *ctxt_info_gen3;
+	struct iwl_context_info_v2 *ctxt_info_v2;
 	struct iwl_prph_scratch *prph_scratch;
 	struct iwl_prph_scratch_ctrl_cfg *prph_sc_ctrl;
 	struct iwl_prph_info *prph_info;
@@ -213,18 +213,18 @@ int iwl_pcie_ctxt_info_gen3_alloc(struct iwl_trans *trans,
 	}
 
 	/* Allocate context info */
-	ctxt_info_gen3 = dma_alloc_coherent(trans->dev,
-					    sizeof(*ctxt_info_gen3),
-					    &trans_pcie->ctxt_info_dma_addr,
-					    GFP_KERNEL);
-	if (!ctxt_info_gen3) {
+	ctxt_info_v2 = dma_alloc_coherent(trans->dev,
+					  sizeof(*ctxt_info_v2),
+					  &trans_pcie->ctxt_info_dma_addr,
+					  GFP_KERNEL);
+	if (!ctxt_info_v2) {
 		ret = -ENOMEM;
 		goto err_free_prph_info;
 	}
 
-	ctxt_info_gen3->prph_info_base_addr =
+	ctxt_info_v2->prph_info_base_addr =
 		cpu_to_le64(trans_pcie->prph_info_dma_addr);
-	ctxt_info_gen3->prph_scratch_base_addr =
+	ctxt_info_v2->prph_scratch_base_addr =
 		cpu_to_le64(trans_pcie->prph_scratch_dma_addr);
 
 	/*
@@ -236,29 +236,29 @@ int iwl_pcie_ctxt_info_gen3_alloc(struct iwl_trans *trans,
 		     sizeof(prph_scratch->dram.fseq_img) !=
 		     sizeof(*prph_scratch));
 	if (control_flags_ext & IWL_PRPH_SCRATCH_EXT_EXT_FSEQ)
-		ctxt_info_gen3->prph_scratch_size =
+		ctxt_info_v2->prph_scratch_size =
 			cpu_to_le32(sizeof(*prph_scratch));
 	else
-		ctxt_info_gen3->prph_scratch_size =
+		ctxt_info_v2->prph_scratch_size =
 			cpu_to_le32(offsetofend(typeof(*prph_scratch),
 						dram.common));
 
-	ctxt_info_gen3->cr_head_idx_arr_base_addr =
+	ctxt_info_v2->cr_head_idx_arr_base_addr =
 		cpu_to_le64(trans_pcie->rxq->rb_stts_dma);
-	ctxt_info_gen3->tr_tail_idx_arr_base_addr =
+	ctxt_info_v2->tr_tail_idx_arr_base_addr =
 		cpu_to_le64(trans_pcie->prph_info_dma_addr + PAGE_SIZE / 2);
-	ctxt_info_gen3->cr_tail_idx_arr_base_addr =
+	ctxt_info_v2->cr_tail_idx_arr_base_addr =
 		cpu_to_le64(trans_pcie->prph_info_dma_addr + 3 * PAGE_SIZE / 4);
-	ctxt_info_gen3->mtr_base_addr =
+	ctxt_info_v2->mtr_base_addr =
 		cpu_to_le64(trans_pcie->txqs.txq[trans->conf.cmd_queue]->dma_addr);
-	ctxt_info_gen3->mcr_base_addr =
+	ctxt_info_v2->mcr_base_addr =
 		cpu_to_le64(trans_pcie->rxq->used_bd_dma);
-	ctxt_info_gen3->mtr_size =
+	ctxt_info_v2->mtr_size =
 		cpu_to_le16(TFD_QUEUE_CB_SIZE(cmdq_size));
-	ctxt_info_gen3->mcr_size =
+	ctxt_info_v2->mcr_size =
 		cpu_to_le16(RX_QUEUE_CB_SIZE(iwl_trans_get_num_rbds(trans)));
 
-	trans_pcie->ctxt_info_gen3 = ctxt_info_gen3;
+	trans_pcie->ctxt_info_v2 = ctxt_info_v2;
 	trans_pcie->prph_info = prph_info;
 	trans_pcie->prph_scratch = prph_scratch;
 
@@ -277,10 +277,10 @@ int iwl_pcie_ctxt_info_gen3_alloc(struct iwl_trans *trans,
 	return 0;
 
 err_free_ctxt_info:
-	dma_free_coherent(trans->dev, sizeof(*trans_pcie->ctxt_info_gen3),
-			  trans_pcie->ctxt_info_gen3,
+	dma_free_coherent(trans->dev, sizeof(*trans_pcie->ctxt_info_v2),
+			  trans_pcie->ctxt_info_v2,
 			  trans_pcie->ctxt_info_dma_addr);
-	trans_pcie->ctxt_info_gen3 = NULL;
+	trans_pcie->ctxt_info_v2 = NULL;
 err_free_prph_info:
 	dma_free_coherent(trans->dev, PAGE_SIZE, prph_info,
 			  trans_pcie->prph_info_dma_addr);
@@ -294,7 +294,7 @@ int iwl_pcie_ctxt_info_gen3_alloc(struct iwl_trans *trans,
 
 }
 
-void iwl_pcie_ctxt_info_gen3_kick(struct iwl_trans *trans)
+void iwl_pcie_ctxt_info_v2_kick(struct iwl_trans *trans)
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 
@@ -309,7 +309,7 @@ void iwl_pcie_ctxt_info_gen3_kick(struct iwl_trans *trans)
 		    CSR_AUTO_FUNC_BOOT_ENA);
 }
 
-void iwl_pcie_ctxt_info_gen3_free(struct iwl_trans *trans, bool alive)
+void iwl_pcie_ctxt_info_v2_free(struct iwl_trans *trans, bool alive)
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 
@@ -327,15 +327,15 @@ void iwl_pcie_ctxt_info_gen3_free(struct iwl_trans *trans, bool alive)
 	if (alive)
 		return;
 
-	if (!trans_pcie->ctxt_info_gen3)
+	if (!trans_pcie->ctxt_info_v2)
 		return;
 
-	/* ctxt_info_gen3 and prph_scratch are still needed for PNVM load */
-	dma_free_coherent(trans->dev, sizeof(*trans_pcie->ctxt_info_gen3),
-			  trans_pcie->ctxt_info_gen3,
+	/* ctxt_info_v2 and prph_scratch are still needed for PNVM load */
+	dma_free_coherent(trans->dev, sizeof(*trans_pcie->ctxt_info_v2),
+			  trans_pcie->ctxt_info_v2,
 			  trans_pcie->ctxt_info_dma_addr);
 	trans_pcie->ctxt_info_dma_addr = 0;
-	trans_pcie->ctxt_info_gen3 = NULL;
+	trans_pcie->ctxt_info_v2 = NULL;
 
 	dma_free_coherent(trans->dev, sizeof(*trans_pcie->prph_scratch),
 			  trans_pcie->prph_scratch,
@@ -439,9 +439,9 @@ static int iwl_pcie_load_payloads_segments
 
 }
 
-int iwl_trans_pcie_ctx_info_gen3_load_pnvm(struct iwl_trans *trans,
-					   const struct iwl_pnvm_image *pnvm_payloads,
-					   const struct iwl_ucode_capabilities *capa)
+int iwl_trans_pcie_ctx_info_v2_load_pnvm(struct iwl_trans *trans,
+					 const struct iwl_pnvm_image *pnvm_payloads,
+					 const struct iwl_ucode_capabilities *capa)
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 	struct iwl_prph_scratch_ctrl_cfg *prph_sc_ctrl =
@@ -521,8 +521,8 @@ static void iwl_pcie_set_contig_pnvm(struct iwl_trans *trans)
 		cpu_to_le32(trans_pcie->pnvm_data.drams[0].size);
 }
 
-void iwl_trans_pcie_ctx_info_gen3_set_pnvm(struct iwl_trans *trans,
-					   const struct iwl_ucode_capabilities *capa)
+void iwl_trans_pcie_ctx_info_v2_set_pnvm(struct iwl_trans *trans,
+					 const struct iwl_ucode_capabilities *capa)
 {
 	if (trans->mac_cfg->device_family < IWL_DEVICE_FAMILY_AX210)
 		return;
@@ -533,9 +533,9 @@ void iwl_trans_pcie_ctx_info_gen3_set_pnvm(struct iwl_trans *trans,
 		iwl_pcie_set_contig_pnvm(trans);
 }
 
-int iwl_trans_pcie_ctx_info_gen3_load_reduce_power(struct iwl_trans *trans,
-						   const struct iwl_pnvm_image *payloads,
-						   const struct iwl_ucode_capabilities *capa)
+int iwl_trans_pcie_ctx_info_v2_load_reduce_power(struct iwl_trans *trans,
+						 const struct iwl_pnvm_image *payloads,
+						 const struct iwl_ucode_capabilities *capa)
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 	struct iwl_prph_scratch_ctrl_cfg *prph_sc_ctrl =
@@ -604,8 +604,8 @@ static void iwl_pcie_set_contig_reduce_power(struct iwl_trans *trans)
 }
 
 void
-iwl_trans_pcie_ctx_info_gen3_set_reduce_power(struct iwl_trans *trans,
-					      const struct iwl_ucode_capabilities *capa)
+iwl_trans_pcie_ctx_info_v2_set_reduce_power(struct iwl_trans *trans,
+					    const struct iwl_ucode_capabilities *capa)
 {
 	if (trans->mac_cfg->device_family < IWL_DEVICE_FAMILY_AX210)
 		return;
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
index a8aeb5c115fd..026401c939bb 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
@@ -326,7 +326,7 @@ struct iwl_pcie_txqs {
  * @global_table: table mapping received VID from hw to rxb
  * @rba: allocator for RX replenishing
  * @ctxt_info: context information for FW self init
- * @ctxt_info_gen3: context information for gen3 devices
+ * @ctxt_info_v2: context information for v1 devices
  * @prph_info: prph info for self init
  * @prph_scratch: prph scratch for self init
  * @ctxt_info_dma_addr: dma addr of context information
@@ -408,7 +408,7 @@ struct iwl_trans_pcie {
 	struct iwl_rb_allocator rba;
 	union {
 		struct iwl_context_info *ctxt_info;
-		struct iwl_context_info_gen3 *ctxt_info_gen3;
+		struct iwl_context_info_v2 *ctxt_info_v2;
 	};
 	struct iwl_prph_info *prph_info;
 	struct iwl_prph_scratch *prph_scratch;
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
index 72ee9ddc1b19..f0405eddc367 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
@@ -12,7 +12,7 @@
 #include "iwl-io.h"
 #include "internal.h"
 #include "iwl-op-mode.h"
-#include "iwl-context-info-gen3.h"
+#include "iwl-context-info-v2.h"
 #include "fw/dbg.h"
 
 /******************************************************************************
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
index d606c586e57c..38ad719161e6 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
@@ -6,7 +6,7 @@
 #include "iwl-trans.h"
 #include "iwl-prph.h"
 #include "iwl-context-info.h"
-#include "iwl-context-info-gen3.h"
+#include "iwl-context-info-v2.h"
 #include "internal.h"
 #include "fw/dbg.h"
 
@@ -192,7 +192,7 @@ static void _iwl_trans_pcie_gen2_stop_device(struct iwl_trans *trans)
 
 	iwl_pcie_ctxt_info_free_paging(trans);
 	if (trans->mac_cfg->device_family >= IWL_DEVICE_FAMILY_AX210)
-		iwl_pcie_ctxt_info_gen3_free(trans, false);
+		iwl_pcie_ctxt_info_v2_free(trans, false);
 	else
 		iwl_pcie_ctxt_info_free(trans);
 
@@ -375,7 +375,7 @@ void iwl_trans_pcie_gen2_fw_alive(struct iwl_trans *trans)
 	 * paging memory cannot be freed included since FW will still use it
 	 */
 	if (trans->mac_cfg->device_family >= IWL_DEVICE_FAMILY_AX210)
-		iwl_pcie_ctxt_info_gen3_free(trans, true);
+		iwl_pcie_ctxt_info_v2_free(trans, true);
 	else
 		iwl_pcie_ctxt_info_free(trans);
 
@@ -555,12 +555,12 @@ int iwl_trans_pcie_gen2_start_fw(struct iwl_trans *trans,
 
 	if (trans->mac_cfg->device_family >= IWL_DEVICE_FAMILY_AX210) {
 		if (!top_reset_done) {
-			ret = iwl_pcie_ctxt_info_gen3_alloc(trans, fw, img);
+			ret = iwl_pcie_ctxt_info_v2_alloc(trans, fw, img);
 			if (ret)
 				goto out;
 		}
 
-		iwl_pcie_ctxt_info_gen3_kick(trans);
+		iwl_pcie_ctxt_info_v2_kick(trans);
 	} else {
 		ret = iwl_pcie_ctxt_info_init(trans, img);
 		if (ret)
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index 906fee5bf47e..9462e9ee4ab1 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -28,7 +28,7 @@
 #include "mei/iwl-mei.h"
 #include "internal.h"
 #include "iwl-fh.h"
-#include "iwl-context-info-gen3.h"
+#include "iwl-context-info-v2.h"
 
 /* extended range in FW SRAM */
 #define IWL_FW_MEM_EXTENDED_START	0x40000
-- 
2.34.1


