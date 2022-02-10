Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34B1B4B137E
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Feb 2022 17:52:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244829AbiBJQwR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Feb 2022 11:52:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244229AbiBJQwQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Feb 2022 11:52:16 -0500
Received: from farmhouse.coelho.fi (paleale.coelho.fi [176.9.41.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FE64EE
        for <linux-wireless@vger.kernel.org>; Thu, 10 Feb 2022 08:52:17 -0800 (PST)
Received: from 91-156-4-210.elisa-laajakaista.fi ([91.156.4.210] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <luca@coelho.fi>)
        id 1nICDM-000Bxy-Nd;
        Thu, 10 Feb 2022 18:22:39 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@kernel.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Thu, 10 Feb 2022 18:22:24 +0200
Message-Id: <iwlwifi.20220210181930.1f0c5d72fb89.Iefca56d535558b7a8d23204fd16129c17b6704b6@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220210162234.285578-1-luca@coelho.fi>
References: <20220210162234.285578-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
Subject: [PATCH 01/11] iwlwifi: make iwl_txq_dyn_alloc_dma() return the txq
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Use the ERR_PTR() machinery to return the queue or an
error, instead of having a separate out parameter.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/queue/tx.c | 26 +++++++++----------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/queue/tx.c b/drivers/net/wireless/intel/iwlwifi/queue/tx.c
index f80bea04e31b..49625c679a5a 100644
--- a/drivers/net/wireless/intel/iwlwifi/queue/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/queue/tx.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2020-2021 Intel Corporation
+ * Copyright (C) 2020-2022 Intel Corporation
  */
 #include <net/tso.h>
 #include <linux/tcp.h>
@@ -1083,9 +1083,8 @@ int iwl_txq_alloc(struct iwl_trans *trans, struct iwl_txq *txq, int slots_num,
 	return -ENOMEM;
 }
 
-static int iwl_txq_dyn_alloc_dma(struct iwl_trans *trans,
-				 struct iwl_txq **intxq, int size,
-				 unsigned int timeout)
+static struct iwl_txq *
+iwl_txq_dyn_alloc_dma(struct iwl_trans *trans, int size, unsigned int timeout)
 {
 	size_t bc_tbl_size, bc_tbl_entries;
 	struct iwl_txq *txq;
@@ -1097,18 +1096,18 @@ static int iwl_txq_dyn_alloc_dma(struct iwl_trans *trans,
 	bc_tbl_entries = bc_tbl_size / sizeof(u16);
 
 	if (WARN_ON(size > bc_tbl_entries))
-		return -EINVAL;
+		return ERR_PTR(-EINVAL);
 
 	txq = kzalloc(sizeof(*txq), GFP_KERNEL);
 	if (!txq)
-		return -ENOMEM;
+		return ERR_PTR(-ENOMEM);
 
 	txq->bc_tbl.addr = dma_pool_alloc(trans->txqs.bc_pool, GFP_KERNEL,
 					  &txq->bc_tbl.dma);
 	if (!txq->bc_tbl.addr) {
 		IWL_ERR(trans, "Scheduler BC Table allocation failed\n");
 		kfree(txq);
-		return -ENOMEM;
+		return ERR_PTR(-ENOMEM);
 	}
 
 	ret = iwl_txq_alloc(trans, txq, size, false);
@@ -1124,12 +1123,11 @@ static int iwl_txq_dyn_alloc_dma(struct iwl_trans *trans,
 
 	txq->wd_timeout = msecs_to_jiffies(timeout);
 
-	*intxq = txq;
-	return 0;
+	return txq;
 
 error:
 	iwl_txq_gen2_free_memory(trans, txq);
-	return ret;
+	return ERR_PTR(ret);
 }
 
 static int iwl_txq_alloc_response(struct iwl_trans *trans, struct iwl_txq *txq,
@@ -1189,7 +1187,7 @@ static int iwl_txq_alloc_response(struct iwl_trans *trans, struct iwl_txq *txq,
 int iwl_txq_dyn_alloc(struct iwl_trans *trans, __le16 flags, u8 sta_id, u8 tid,
 		      int cmd_id, int size, unsigned int timeout)
 {
-	struct iwl_txq *txq = NULL;
+	struct iwl_txq *txq;
 	struct iwl_tx_queue_cfg_cmd cmd = {
 		.flags = flags,
 		.sta_id = sta_id,
@@ -1203,9 +1201,9 @@ int iwl_txq_dyn_alloc(struct iwl_trans *trans, __le16 flags, u8 sta_id, u8 tid,
 	};
 	int ret;
 
-	ret = iwl_txq_dyn_alloc_dma(trans, &txq, size, timeout);
-	if (ret)
-		return ret;
+	txq = iwl_txq_dyn_alloc_dma(trans, size, timeout);
+	if (IS_ERR(txq))
+		return PTR_ERR(txq);
 
 	cmd.tfdq_addr = cpu_to_le64(txq->dma_addr);
 	cmd.byte_cnt_addr = cpu_to_le64(txq->bc_tbl.dma);
-- 
2.34.1

