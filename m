Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6AC477DBD5
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Aug 2023 10:12:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242786AbjHPILp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 16 Aug 2023 04:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242813AbjHPIL2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 16 Aug 2023 04:11:28 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6782AAB
        for <linux-wireless@vger.kernel.org>; Wed, 16 Aug 2023 01:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692173487; x=1723709487;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uKuL0c1IDSH+tUQGHSh6f3XjFatiPMXT8Il7fsHyUSk=;
  b=A5s6xfVKlHP/wOgoZURyZywwjhUNRTJkGNwxMG0vkQBAJ/rPZhHgMXif
   3aC6bfE14/6o7OozC4sg4Ts1VbG3GA4UwlsW9cPeDrJmTI1u8ECMlK8nU
   Ewt6P+ZX9Vm9+cV5a0Ga5o7pJ5Rn4aOo5ASyebmSHdGb7go0X1lpVvwFx
   l2fv07c79H9Gutw6c6hzQcTc+8rQEdt/SYflmhXsEVipT58yUzTDpWqHv
   JBFLlrOAeZfa8gzkyW23guBGJ+ZdCUqZ6OMUKZBUBD+DX6NhTCa/Uj1Rc
   veUyciMN8NDb2FoCAtIem5HRrvK/oOWYjGsZAIISnDMIaCbQH84cRvME+
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="357447856"
X-IronPort-AV: E=Sophos;i="6.01,176,1684825200"; 
   d="scan'208";a="357447856"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2023 01:11:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="769098832"
X-IronPort-AV: E=Sophos;i="6.01,176,1684825200"; 
   d="scan'208";a="769098832"
Received: from mamir-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.226.187])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2023 01:11:25 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 08/12] wifi: iwlwifi: pcie: point invalid TFDs to invalid data
Date:   Wed, 16 Aug 2023 11:10:50 +0300
Message-Id: <20230816104355.10a9af1ca91f.Ifc790d62c52b4bc9a74c9581610af498509f5759@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230816081054.245480-1-gregory.greenman@intel.com>
References: <20230816081054.245480-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

There are occasionally bugs which cause the device to try
to use a TFD that it wasn't supposed to, and these are
very hard to diagnose. Fill all unused TFDs with a debug
command that immediately causes an error to be detected
in these cases.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 .../net/wireless/intel/iwlwifi/fw/api/debug.h |  5 +++
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |  3 ++
 .../net/wireless/intel/iwlwifi/pcie/trans.c   | 29 ++++++++++++++
 drivers/net/wireless/intel/iwlwifi/queue/tx.c | 40 ++++++++++++++++---
 4 files changed, 71 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/debug.h b/drivers/net/wireless/intel/iwlwifi/fw/api/debug.h
index 48ffab22bb7b..90ce8d9b6ad3 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/debug.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/debug.h
@@ -29,6 +29,11 @@ enum iwl_debug_cmds {
 	 * &struct iwl_dbg_host_event_cfg_cmd
 	 */
 	HOST_EVENT_CFG = 0x3,
+	/**
+	 * @INVALID_WR_PTR_CMD: invalid write pointer, set in the TFD
+	 *	when it's not in use
+	 */
+	INVALID_WR_PTR_CMD = 0x6,
 	/**
 	 * @DBGC_SUSPEND_RESUME:
 	 * DBGC suspend/resume commad. Uses a single dword as data:
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index 8a6ddb5fb0c3..3b6b0e03037f 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -1069,6 +1069,7 @@ struct iwl_trans_txqs {
  * @mbx_addr_1_step: step address data 1
  * @pcie_link_speed: current PCIe link speed (%PCI_EXP_LNKSTA_CLS_*),
  *	only valid for discrete (not integrated) NICs
+ * @invalid_tx_cmd: invalid TX command buffer
  */
 struct iwl_trans {
 	bool csme_own;
@@ -1133,6 +1134,8 @@ struct iwl_trans {
 
 	u8 pcie_link_speed;
 
+	struct iwl_dma_ptr invalid_tx_cmd;
+
 	/* pointer to trans specific struct */
 	/*Ensure that this pointer will always be aligned to sizeof pointer */
 	char trans_specific[] __aligned(sizeof(void *));
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index 2096f7158728..198933f853c5 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -2018,6 +2018,30 @@ void iwl_trans_pcie_free_pnvm_dram_regions(struct iwl_dram_regions *dram_regions
 	memset(desc_dram, 0, sizeof(*desc_dram));
 }
 
+static void iwl_pcie_free_invalid_tx_cmd(struct iwl_trans *trans)
+{
+	iwl_pcie_free_dma_ptr(trans, &trans->invalid_tx_cmd);
+}
+
+static int iwl_pcie_alloc_invalid_tx_cmd(struct iwl_trans *trans)
+{
+	struct iwl_cmd_header_wide bad_cmd = {
+		.cmd = INVALID_WR_PTR_CMD,
+		.group_id = DEBUG_GROUP,
+		.sequence = cpu_to_le16(0xffff),
+		.length = cpu_to_le16(0),
+		.version = 0,
+	};
+	int ret;
+
+	ret = iwl_pcie_alloc_dma_ptr(trans, &trans->invalid_tx_cmd,
+				     sizeof(bad_cmd));
+	if (ret)
+		return ret;
+	memcpy(trans->invalid_tx_cmd.addr, &bad_cmd, sizeof(bad_cmd));
+	return 0;
+}
+
 void iwl_trans_pcie_free(struct iwl_trans *trans)
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
@@ -2048,6 +2072,8 @@ void iwl_trans_pcie_free(struct iwl_trans *trans)
 		iwl_pcie_free_ict(trans);
 	}
 
+	iwl_pcie_free_invalid_tx_cmd(trans);
+
 	iwl_pcie_free_fw_monitor(trans);
 
 	iwl_trans_pcie_free_pnvm_dram_regions(&trans_pcie->pnvm_data,
@@ -3684,6 +3710,9 @@ struct iwl_trans *iwl_trans_pcie_alloc(struct pci_dev *pdev,
 
 	init_waitqueue_head(&trans_pcie->sx_waitq);
 
+	ret = iwl_pcie_alloc_invalid_tx_cmd(trans);
+	if (ret)
+		goto out_no_pci;
 
 	if (trans_pcie->msix_enabled) {
 		ret = iwl_pcie_init_msix_handler(pdev, trans_pcie);
diff --git a/drivers/net/wireless/intel/iwlwifi/queue/tx.c b/drivers/net/wireless/intel/iwlwifi/queue/tx.c
index 95c2af54ea46..340240b8954f 100644
--- a/drivers/net/wireless/intel/iwlwifi/queue/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/queue/tx.c
@@ -10,6 +10,7 @@
 #include "fw/api/commands.h"
 #include "fw/api/tx.h"
 #include "fw/api/datapath.h"
+#include "fw/api/debug.h"
 #include "queue/tx.h"
 #include "iwl-fh.h"
 #include "iwl-scd.h"
@@ -119,6 +120,15 @@ int iwl_txq_gen2_set_tb(struct iwl_trans *trans, struct iwl_tfh_tfd *tfd,
 	return idx;
 }
 
+static void iwl_txq_set_tfd_invalid_gen2(struct iwl_trans *trans,
+					 struct iwl_tfh_tfd *tfd)
+{
+	tfd->num_tbs = 0;
+
+	iwl_txq_gen2_set_tb(trans, tfd, trans->invalid_tx_cmd.dma,
+			    trans->invalid_tx_cmd.size);
+}
+
 void iwl_txq_gen2_tfd_unmap(struct iwl_trans *trans, struct iwl_cmd_meta *meta,
 			    struct iwl_tfh_tfd *tfd)
 {
@@ -146,7 +156,7 @@ void iwl_txq_gen2_tfd_unmap(struct iwl_trans *trans, struct iwl_cmd_meta *meta,
 					 DMA_TO_DEVICE);
 	}
 
-	tfd->num_tbs = 0;
+	iwl_txq_set_tfd_invalid_gen2(trans, tfd);
 }
 
 void iwl_txq_gen2_free_tfd(struct iwl_trans *trans, struct iwl_txq *txq)
@@ -1025,11 +1035,21 @@ static void iwl_txq_stuck_timer(struct timer_list *t)
 	iwl_force_nmi(trans);
 }
 
+static void iwl_txq_set_tfd_invalid_gen1(struct iwl_trans *trans,
+					 struct iwl_tfd *tfd)
+{
+	tfd->num_tbs = 0;
+
+	iwl_pcie_gen1_tfd_set_tb(trans, tfd, 0, trans->invalid_tx_cmd.dma,
+				 trans->invalid_tx_cmd.size);
+}
+
 int iwl_txq_alloc(struct iwl_trans *trans, struct iwl_txq *txq, int slots_num,
 		  bool cmd_queue)
 {
-	size_t tfd_sz = trans->txqs.tfd.size *
-		trans->trans_cfg->base_params->max_tfd_queue_size;
+	size_t num_entries = trans->trans_cfg->gen2 ?
+		slots_num : trans->trans_cfg->base_params->max_tfd_queue_size;
+	size_t tfd_sz;
 	size_t tb0_buf_sz;
 	int i;
 
@@ -1039,8 +1059,7 @@ int iwl_txq_alloc(struct iwl_trans *trans, struct iwl_txq *txq, int slots_num,
 	if (WARN_ON(txq->entries || txq->tfds))
 		return -EINVAL;
 
-	if (trans->trans_cfg->gen2)
-		tfd_sz = trans->txqs.tfd.size * slots_num;
+	tfd_sz = trans->txqs.tfd.size * num_entries;
 
 	timer_setup(&txq->stuck_timer, iwl_txq_stuck_timer, 0);
 	txq->trans = trans;
@@ -1080,6 +1099,15 @@ int iwl_txq_alloc(struct iwl_trans *trans, struct iwl_txq *txq, int slots_num,
 	if (!txq->first_tb_bufs)
 		goto err_free_tfds;
 
+	for (i = 0; i < num_entries; i++) {
+		void *tfd = iwl_txq_get_tfd(trans, txq, i);
+
+		if (trans->trans_cfg->gen2)
+			iwl_txq_set_tfd_invalid_gen2(trans, tfd);
+		else
+			iwl_txq_set_tfd_invalid_gen1(trans, tfd);
+	}
+
 	return 0;
 err_free_tfds:
 	dma_free_coherent(trans->dev, tfd_sz, txq->tfds, txq->dma_addr);
@@ -1397,7 +1425,7 @@ void iwl_txq_gen1_tfd_unmap(struct iwl_trans *trans,
 
 	meta->tbs = 0;
 
-	tfd->num_tbs = 0;
+	iwl_txq_set_tfd_invalid_gen1(trans, tfd);
 }
 
 #define IWL_TX_CRC_SIZE 4
-- 
2.38.1

