Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A00CE719FAC
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Jun 2023 16:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234134AbjFAOU7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 1 Jun 2023 10:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233795AbjFAOUv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 1 Jun 2023 10:20:51 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EB4F18F
        for <linux-wireless@vger.kernel.org>; Thu,  1 Jun 2023 07:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685629246; x=1717165246;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3hzEoPDNNRRYy/uYf6QIJ1YPIBmKL1gVjPttLtSKWH4=;
  b=DhBpEhdrLPJnXloLE1XH5Ug+M7Gdu2IrI5GWDLK0rSqXU/t287jUSG2Y
   tvNT/wptUXm2bhl9WgxFE7ms3OEBB8OgMz+8TDAQAmFjMPlzjC8vg8rUP
   3VdQh7wyz+8H76ty7npL1+c/FhG33G1g6NYVW9rZAgokMRD8MVYmTtEsb
   tvqgLyb0QAAyfLRxgQ1EbOqGAs520+eOQfLm/gTBVIfGRoGK8AtaZd94i
   RJ+S8T/JpEoU9odFmRxPpVyMlZrnjD4SXt9McX++azO9PuyHssCsPWrWJ
   PrT40VhRcvhD3HZTDNMPb/xXpknFs3FA7SdQatIXyIP6cScBhq+xColp3
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="441931879"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="441931879"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 07:20:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="819812889"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="819812889"
Received: from dvinnyc-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.249.93.27])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 07:20:35 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 6/6] wifi: iwlwifi: limit queue use independent of allocation
Date:   Thu,  1 Jun 2023 17:20:08 +0300
Message-Id: <20230601171633.1976517dabef.I87b84456adf6dcace25c1f663b4db752f9af67b7@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230601142008.375040-1-gregory.greenman@intel.com>
References: <20230601142008.375040-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

When using large queue sizes because of hardware workarounds, we
then shouldn't fill the queue according to the allocate size but
according to the desired size to avoid extra latency and lack of
A-MSDU aggregation.

This isn't pretty, but we can hopefully revert it once B-step is
there and we phase out A-step devices.

Fixes: bb16ffd561b6 ("iwlwifi: use 4k queue size for Bz A-step")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |  2 ++
 drivers/net/wireless/intel/iwlwifi/queue/tx.c | 23 ++++++++++++++++---
 2 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index 885581e636c7..7d0fa5eee4ea 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -894,6 +894,7 @@ struct iwl_pcie_first_tb_buf {
  * @read_ptr: last used entry (index) host_r
  * @dma_addr:  physical addr for BD's
  * @n_window: safe queue window
+ * @n_reduced_win: reduced @n_window in case of HW allocation workarounds
  * @id: queue id
  * @low_mark: low watermark, resume queue if free space more than this
  * @high_mark: high watermark, stop queue if free space less than this
@@ -936,6 +937,7 @@ struct iwl_txq {
 	int read_ptr;
 	dma_addr_t dma_addr;
 	int n_window;
+	int n_reduced_win;
 	u32 id;
 	int low_mark;
 	int high_mark;
diff --git a/drivers/net/wireless/intel/iwlwifi/queue/tx.c b/drivers/net/wireless/intel/iwlwifi/queue/tx.c
index d1c39c214f95..a2d83c1201d5 100644
--- a/drivers/net/wireless/intel/iwlwifi/queue/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/queue/tx.c
@@ -685,8 +685,8 @@ int iwl_txq_space(struct iwl_trans *trans, const struct iwl_txq *q)
 	 * If q->n_window is smaller than max_tfd_queue_size, there is no need
 	 * to reserve any queue entries for this purpose.
 	 */
-	if (q->n_window < trans->trans_cfg->base_params->max_tfd_queue_size)
-		max = q->n_window;
+	if (q->n_reduced_win < trans->trans_cfg->base_params->max_tfd_queue_size)
+		max = q->n_reduced_win;
 	else
 		max = trans->trans_cfg->base_params->max_tfd_queue_size - 1;
 
@@ -899,6 +899,7 @@ static void iwl_txq_gen2_free(struct iwl_trans *trans, int txq_id)
 static int iwl_queue_init(struct iwl_txq *q, int slots_num)
 {
 	q->n_window = slots_num;
+	q->n_reduced_win = slots_num;
 
 	/* slots_num must be power-of-two size, otherwise
 	 * iwl_txq_get_cmd_index is broken. */
@@ -1037,6 +1038,7 @@ int iwl_txq_alloc(struct iwl_trans *trans, struct iwl_txq *txq, int slots_num,
 	txq->trans = trans;
 
 	txq->n_window = slots_num;
+	txq->n_reduced_win = slots_num;
 
 	txq->entries = kcalloc(slots_num,
 			       sizeof(struct iwl_pcie_txq_entry),
@@ -1197,16 +1199,31 @@ int iwl_txq_dyn_alloc(struct iwl_trans *trans, u32 flags, u32 sta_mask,
 	struct iwl_host_cmd hcmd = {
 		.flags = CMD_WANT_SKB,
 	};
+	int org_size = 0;
 	int ret;
 
 	if (trans->trans_cfg->device_family == IWL_DEVICE_FAMILY_BZ &&
-	    trans->hw_rev_step == SILICON_A_STEP)
+	    trans->hw_rev_step == SILICON_A_STEP) {
+		org_size = size;
 		size = 4096;
+	}
 
 	txq = iwl_txq_dyn_alloc_dma(trans, size, timeout);
 	if (IS_ERR(txq))
 		return PTR_ERR(txq);
 
+	if (org_size) {
+		txq->n_reduced_win = org_size;
+
+		txq->low_mark = org_size / 4;
+		if (txq->low_mark < 4)
+			txq->low_mark = 4;
+
+		txq->high_mark = org_size / 8;
+		if (txq->high_mark < 2)
+			txq->high_mark = 2;
+	}
+
 	if (trans->txqs.queue_alloc_cmd_ver == 0) {
 		memset(&cmd.old, 0, sizeof(cmd.old));
 		cmd.old.tfdq_addr = cpu_to_le64(txq->dma_addr);
-- 
2.38.1

