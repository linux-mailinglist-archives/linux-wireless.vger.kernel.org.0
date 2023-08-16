Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89E8277DBD1
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Aug 2023 10:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242777AbjHPILk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 16 Aug 2023 04:11:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242804AbjHPILT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 16 Aug 2023 04:11:19 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9253EE
        for <linux-wireless@vger.kernel.org>; Wed, 16 Aug 2023 01:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692173477; x=1723709477;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=W3fh8oqXEPkasn2tRn8HPWfzUuwbU7GKbexraRXcjdQ=;
  b=Jq6lpuySCQrCalYGzJ6Jd7XDNZJFb50URHNVUrqA79vwFN06wRs60+GZ
   KDdPnNg9S1HM4VyQMk4UqZAZ4tGm+KAyfbyfNbqEXauO+DIql+iXH8jGh
   513/rTn4wVA3FgIo8YBJMoiTgPaQFjGVnDzWbUZ1TpA2oxT56w5Oy/7uj
   DmL7jq1JUMWU291FHuOU+pqE9JY3WLADFZRxc5rdgaFu6Li1jbMOdKvfk
   ir8UlBIwlqmDTPbvP6F+adDxuWQwErnJTghReX71Yq+B3bQxkaJMr1b+3
   +t+bzFp+4VCz2H+LkPP6dn7QyZmZDsSUDtznNxtkecLgOQMwt1SNR2KA6
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="357447808"
X-IronPort-AV: E=Sophos;i="6.01,176,1684825200"; 
   d="scan'208";a="357447808"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2023 01:11:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="769098768"
X-IronPort-AV: E=Sophos;i="6.01,176,1684825200"; 
   d="scan'208";a="769098768"
Received: from mamir-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.226.187])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2023 01:11:16 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 04/12] wifi: iwlwifi: pcie: clean up gen1/gen2 TFD unmap
Date:   Wed, 16 Aug 2023 11:10:46 +0300
Message-Id: <20230816104355.baf23841ec5c.I40702e94b25db05e82f935f14548316f8c6429b9@changeid>
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

This is a bit messy right now, there are functions for both,
but then gen1 function can actually deal with both gen1 and
gen2, due to the confusion about use_tfh/gen2 cleaned up in
the previous patch.

Fix the common paths to call the right functions and remove
handling of gen2 from the gen1 function.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c  |  6 +++-
 drivers/net/wireless/intel/iwlwifi/queue/tx.c | 33 ++++++-------------
 drivers/net/wireless/intel/iwlwifi/queue/tx.h | 11 +------
 3 files changed, 16 insertions(+), 34 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
index 790e5b124740..9ab1b2590dd2 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
@@ -1203,7 +1203,11 @@ void iwl_pcie_hcmd_complete(struct iwl_trans *trans,
 	group_id = cmd->hdr.group_id;
 	cmd_id = WIDE_ID(group_id, cmd->hdr.cmd);
 
-	iwl_txq_gen1_tfd_unmap(trans, meta, txq, index);
+	if (trans->trans_cfg->gen2)
+		iwl_txq_gen2_tfd_unmap(trans, meta,
+				       iwl_txq_get_tfd(trans, txq, index));
+	else
+		iwl_txq_gen1_tfd_unmap(trans, meta, txq, index);
 
 	/* Input error checking is done when commands are added to queue. */
 	if (meta->flags & CMD_WANT_SKB) {
diff --git a/drivers/net/wireless/intel/iwlwifi/queue/tx.c b/drivers/net/wireless/intel/iwlwifi/queue/tx.c
index 5bb3cc3367c9..5b1100e6e1d1 100644
--- a/drivers/net/wireless/intel/iwlwifi/queue/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/queue/tx.c
@@ -1340,22 +1340,12 @@ int iwl_txq_gen2_init(struct iwl_trans *trans, int txq_id, int queue_size)
 }
 
 static inline dma_addr_t iwl_txq_gen1_tfd_tb_get_addr(struct iwl_trans *trans,
-						      void *_tfd, u8 idx)
+						      struct iwl_tfd *tfd, u8 idx)
 {
-	struct iwl_tfd *tfd;
-	struct iwl_tfd_tb *tb;
+	struct iwl_tfd_tb *tb = &tfd->tbs[idx];
 	dma_addr_t addr;
 	dma_addr_t hi_len;
 
-	if (trans->trans_cfg->gen2) {
-		struct iwl_tfh_tfd *tfh_tfd = _tfd;
-		struct iwl_tfh_tb *tfh_tb = &tfh_tfd->tbs[idx];
-
-		return (dma_addr_t)(le64_to_cpu(tfh_tb->addr));
-	}
-
-	tfd = _tfd;
-	tb = &tfd->tbs[idx];
 	addr = get_unaligned_le32(&tb->lo);
 
 	if (sizeof(dma_addr_t) <= sizeof(u32))
@@ -1376,7 +1366,7 @@ void iwl_txq_gen1_tfd_unmap(struct iwl_trans *trans,
 			    struct iwl_txq *txq, int index)
 {
 	int i, num_tbs;
-	void *tfd = iwl_txq_get_tfd(trans, txq, index);
+	struct iwl_tfd *tfd = iwl_txq_get_tfd(trans, txq, index);
 
 	/* Sanity check on number of chunks */
 	num_tbs = iwl_txq_gen1_tfd_get_num_tbs(trans, tfd);
@@ -1408,15 +1398,7 @@ void iwl_txq_gen1_tfd_unmap(struct iwl_trans *trans,
 
 	meta->tbs = 0;
 
-	if (trans->trans_cfg->gen2) {
-		struct iwl_tfh_tfd *tfd_fh = (void *)tfd;
-
-		tfd_fh->num_tbs = 0;
-	} else {
-		struct iwl_tfd *tfd_fh = (void *)tfd;
-
-		tfd_fh->num_tbs = 0;
-	}
+	tfd->num_tbs = 0;
 }
 
 #define IWL_TX_CRC_SIZE 4
@@ -1520,7 +1502,12 @@ void iwl_txq_free_tfd(struct iwl_trans *trans, struct iwl_txq *txq)
 	/* We have only q->n_window txq->entries, but we use
 	 * TFD_QUEUE_SIZE_MAX tfds
 	 */
-	iwl_txq_gen1_tfd_unmap(trans, &txq->entries[idx].meta, txq, rd_ptr);
+	if (trans->trans_cfg->gen2)
+		iwl_txq_gen2_tfd_unmap(trans, &txq->entries[idx].meta,
+				       iwl_txq_get_tfd(trans, txq, rd_ptr));
+	else
+		iwl_txq_gen1_tfd_unmap(trans, &txq->entries[idx].meta,
+				       txq, rd_ptr);
 
 	/* free SKB */
 	skb = txq->entries[idx].skb;
diff --git a/drivers/net/wireless/intel/iwlwifi/queue/tx.h b/drivers/net/wireless/intel/iwlwifi/queue/tx.h
index 1e4a24ab9bab..15b3edce56e0 100644
--- a/drivers/net/wireless/intel/iwlwifi/queue/tx.h
+++ b/drivers/net/wireless/intel/iwlwifi/queue/tx.h
@@ -131,17 +131,8 @@ struct iwl_tso_hdr_page *get_page_hdr(struct iwl_trans *trans, size_t len,
 				      struct sk_buff *skb);
 #endif
 static inline u8 iwl_txq_gen1_tfd_get_num_tbs(struct iwl_trans *trans,
-					      void *_tfd)
+					      struct iwl_tfd *tfd)
 {
-	struct iwl_tfd *tfd;
-
-	if (trans->trans_cfg->gen2) {
-		struct iwl_tfh_tfd *tfh_tfd = _tfd;
-
-		return le16_to_cpu(tfh_tfd->num_tbs) & 0x1f;
-	}
-
-	tfd = (struct iwl_tfd *)_tfd;
 	return tfd->num_tbs & 0x1f;
 }
 
-- 
2.38.1

