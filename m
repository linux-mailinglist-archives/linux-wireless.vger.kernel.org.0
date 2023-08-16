Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DA4A77DBD4
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Aug 2023 10:12:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242784AbjHPILp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 16 Aug 2023 04:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242812AbjHPILZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 16 Aug 2023 04:11:25 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8229AB
        for <linux-wireless@vger.kernel.org>; Wed, 16 Aug 2023 01:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692173484; x=1723709484;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0nQQk/cA2Gj5ZDP7/h77mSOLBAqumLlDf2WqOosLJ08=;
  b=A1LU+THLWyZUDHUx88qRJ4yCDP5LBtpmSq3SLPOKqxlckn1jZViwQNOC
   32wbbGqrZalDzMgJ2HgBTP70GGLli29DqD9t8x+w+zQeyTqSBtz6kUq8t
   E+dhY3plp4N+nDT12moLM7PLiUV+9kPx8zqfEjRN0jcvx8bW+8iIW10Jp
   UE32p8Rs9N+6AcguPDlE89L5caiZ0N96QSC6w25O4UPi/tRmJHS2Hyn6A
   uTNR/l6GdqJBhTzPrDW4S8EUYZlzsos8U2dNZ3RglFtwx2Njg1LhQXz6i
   V4HXBx7eQsykFpOlWfkx0pZkdv6LO9t1bCtBAi4S9mlQUoknyAq9CfKcN
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="357447839"
X-IronPort-AV: E=Sophos;i="6.01,176,1684825200"; 
   d="scan'208";a="357447839"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2023 01:11:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="769098827"
X-IronPort-AV: E=Sophos;i="6.01,176,1684825200"; 
   d="scan'208";a="769098827"
Received: from mamir-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.226.187])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2023 01:11:22 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 07/12] wifi: iwlwifi: queue: move iwl_txq_gen2_set_tb() up
Date:   Wed, 16 Aug 2023 11:10:49 +0300
Message-Id: <20230816104355.c6d798b600bb.I9b891ee3d3dc67822a28e44941409f5b7cb637cf@changeid>
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

We need this earlier in the file next, move it up to have
an easier to read change, since this moves other things
in the diff git generates by default.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/queue/tx.c | 71 +++++++++----------
 1 file changed, 35 insertions(+), 36 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/queue/tx.c b/drivers/net/wireless/intel/iwlwifi/queue/tx.c
index 5b1100e6e1d1..95c2af54ea46 100644
--- a/drivers/net/wireless/intel/iwlwifi/queue/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/queue/tx.c
@@ -84,6 +84,41 @@ static u8 iwl_txq_gen2_get_num_tbs(struct iwl_trans *trans,
 	return le16_to_cpu(tfd->num_tbs) & 0x1f;
 }
 
+int iwl_txq_gen2_set_tb(struct iwl_trans *trans, struct iwl_tfh_tfd *tfd,
+			dma_addr_t addr, u16 len)
+{
+	int idx = iwl_txq_gen2_get_num_tbs(trans, tfd);
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
+	if (le16_to_cpu(tfd->num_tbs) >= trans->txqs.tfd.max_tbs) {
+		IWL_ERR(trans, "Error can not send more than %d chunks\n",
+			trans->txqs.tfd.max_tbs);
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
 void iwl_txq_gen2_tfd_unmap(struct iwl_trans *trans, struct iwl_cmd_meta *meta,
 			    struct iwl_tfh_tfd *tfd)
 {
@@ -142,42 +177,6 @@ void iwl_txq_gen2_free_tfd(struct iwl_trans *trans, struct iwl_txq *txq)
 	}
 }
 
-int iwl_txq_gen2_set_tb(struct iwl_trans *trans, struct iwl_tfh_tfd *tfd,
-			dma_addr_t addr, u16 len)
-{
-	int idx = iwl_txq_gen2_get_num_tbs(trans, tfd);
-	struct iwl_tfh_tb *tb;
-
-	/*
-	 * Only WARN here so we know about the issue, but we mess up our
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
 static struct page *get_workaround_page(struct iwl_trans *trans,
 					struct sk_buff *skb)
 {
-- 
2.38.1

