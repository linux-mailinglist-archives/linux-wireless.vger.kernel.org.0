Return-Path: <linux-wireless+bounces-9910-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C35E925799
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2024 12:00:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C34F428C191
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2024 10:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 086B915D5B3;
	Wed,  3 Jul 2024 09:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HjE3fB3+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9FE1428E7
	for <linux-wireless@vger.kernel.org>; Wed,  3 Jul 2024 09:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720000770; cv=none; b=UQo8XqHoEKvttNNNwZm4yN2g5rNW/SGJ6DxhRpw9sDxlWa8ycMi/6AOeMiB+MdLuGBkcNx7LDrapxLSXxjhuD8pKUjAdjwv2OjSXZdBuPQJRkbtDuxDsUwOBbWF6sqrcAi9yD9hArnYutnLcXtnjtdB7YMtC7ffIn6i0VO2bIAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720000770; c=relaxed/simple;
	bh=XLtOd96TLhjnGRBv7UGKEsZt1nN1LulTbV6I+84TD7Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q8BIdLBBt8veV2LQgEul0ypaOb67jYNLXpMz0dyqL1Ih9j0RIj6eBzIRJLREoWvIJvRUQB6ZZdGEA9GLSc84PvKq4miPjCW59Ncnpd+OXwW45H0tG9CwzBN6Jh4GHLKiZTur6oT7AwkvPfJ2gOkCUgCY+2kTJ6aey22gDIgM//s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HjE3fB3+; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720000769; x=1751536769;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XLtOd96TLhjnGRBv7UGKEsZt1nN1LulTbV6I+84TD7Q=;
  b=HjE3fB3+G1lIvHuUe06xclhxN/rOK+uhDSVugES8G/RKjx4CKmX+1ui+
   xNI5sOhQDwjJgjGVm5gYd+xepEltybed4caP2aIxyNWKoCnpdV23kZ+jH
   X38+4O+EE96w0MtzUx24Gi8yQXLw3EUeXCOy9a1JSMTfRnVEmPkiYcnF/
   appPZyMeWu1YS6IbDb0tL7i7GHyCyzSCtpHQMVSJk2RWTu+FhR+yrnrlR
   39vcLTAJTcmxby3hNySwC91s4dovY932Wyli9D1masYjRjNv2X2H0NyJ6
   CrKOHjBd+S+bKjpEwYyYI0lZjKkuntERCuXU7e9p9vIgcenavIZ0mhGv2
   g==;
X-CSE-ConnectionGUID: 7YnPXwYKQD+nuIY91biK3A==
X-CSE-MsgGUID: gxVfywfaTMi+uVN90lob3A==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="27837544"
X-IronPort-AV: E=Sophos;i="6.09,181,1716274800"; 
   d="scan'208";a="27837544"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 02:59:29 -0700
X-CSE-ConnectionGUID: plcAXLewTZaOEVqLI4974g==
X-CSE-MsgGUID: Ef2n7UfKSCWNBoAbJ0XkYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,181,1716274800"; 
   d="scan'208";a="45987790"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 02:59:27 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Benjamin Berg <benjamin.berg@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 09/18] wifi: iwlwifi: release TXQ lock during reclaim
Date: Wed,  3 Jul 2024 12:58:57 +0300
Message-Id: <20240703125541.2a81021d49ac.I53698ae92fb75a0461d41176db115462cf8be1cd@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240703095906.833028-1-miriam.rachel.korenblit@intel.com>
References: <20240703095906.833028-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Benjamin Berg <benjamin.berg@intel.com>

Much of the work during reclaim can be done without holding the TXQ
lock and releasing the lock means that command submission can happen at
the same time.

Add a new reclaim_lock to prevent parallel cleanup. Release the lock
while working with an internal copy of the txq->read_ptr and only take
the lock again when updating the read pointer after the cleanup is done.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |  3 +
 .../net/wireless/intel/iwlwifi/pcie/tx-gen2.c |  6 +-
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c  | 78 +++++++++++--------
 3 files changed, 54 insertions(+), 33 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index 015f02122df6..6148acbac6af 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -752,6 +752,7 @@ struct iwl_pcie_first_tb_buf {
  * @first_tb_dma: DMA address for the first_tb_bufs start
  * @entries: transmit entries (driver state)
  * @lock: queue lock
+ * @reclaim_lock: reclaim lock
  * @stuck_timer: timer that fires if queue gets stuck
  * @trans: pointer back to transport (for timer)
  * @need_update: indicates need to update read/write index
@@ -794,6 +795,8 @@ struct iwl_txq {
 	struct iwl_pcie_txq_entry *entries;
 	/* lock for syncing changes on the queue */
 	spinlock_t lock;
+	/* lock to prevent concurrent reclaim */
+	spinlock_t reclaim_lock;
 	unsigned long frozen_expiry_remainder;
 	struct timer_list stuck_timer;
 	struct iwl_trans *trans;
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c b/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
index 21c3998a76c8..2e780fb2da42 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
@@ -821,7 +821,8 @@ static void iwl_txq_gen2_unmap(struct iwl_trans *trans, int txq_id)
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 	struct iwl_txq *txq = trans_pcie->txqs.txq[txq_id];
 
-	spin_lock_bh(&txq->lock);
+	spin_lock_bh(&txq->reclaim_lock);
+	spin_lock(&txq->lock);
 	while (txq->write_ptr != txq->read_ptr) {
 		IWL_DEBUG_TX_REPLY(trans, "Q %d Free %d\n",
 				   txq_id, txq->read_ptr);
@@ -844,7 +845,8 @@ static void iwl_txq_gen2_unmap(struct iwl_trans *trans, int txq_id)
 		iwl_op_mode_free_skb(trans->op_mode, skb);
 	}
 
-	spin_unlock_bh(&txq->lock);
+	spin_unlock(&txq->lock);
+	spin_unlock_bh(&txq->reclaim_lock);
 
 	/* just in case - this queue may have been stopped */
 	iwl_trans_pcie_wake_queue(trans, txq);
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
index 1f6db6b90f6f..748772fa6b3e 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
@@ -333,20 +333,21 @@ static void iwl_txq_gen1_tfd_unmap(struct iwl_trans *trans,
  * iwl_txq_free_tfd - Free all chunks referenced by TFD [txq->q.read_ptr]
  * @trans: transport private data
  * @txq: tx queue
+ * @read_ptr: the TXQ read_ptr to free
  *
  * Does NOT advance any TFD circular buffer read/write indexes
  * Does NOT free the TFD itself (which is within circular buffer)
  */
-static void iwl_txq_free_tfd(struct iwl_trans *trans, struct iwl_txq *txq)
+static void iwl_txq_free_tfd(struct iwl_trans *trans, struct iwl_txq *txq,
+			     int read_ptr)
 {
 	/* rd_ptr is bounded by TFD_QUEUE_SIZE_MAX and
 	 * idx is bounded by n_window
 	 */
-	int rd_ptr = txq->read_ptr;
-	int idx = iwl_txq_get_cmd_index(txq, rd_ptr);
+	int idx = iwl_txq_get_cmd_index(txq, read_ptr);
 	struct sk_buff *skb;
 
-	lockdep_assert_held(&txq->lock);
+	lockdep_assert_held(&txq->reclaim_lock);
 
 	if (!txq->entries)
 		return;
@@ -356,10 +357,10 @@ static void iwl_txq_free_tfd(struct iwl_trans *trans, struct iwl_txq *txq)
 	 */
 	if (trans->trans_cfg->gen2)
 		iwl_txq_gen2_tfd_unmap(trans, &txq->entries[idx].meta,
-				       iwl_txq_get_tfd(trans, txq, rd_ptr));
+				       iwl_txq_get_tfd(trans, txq, read_ptr));
 	else
 		iwl_txq_gen1_tfd_unmap(trans, &txq->entries[idx].meta,
-				       txq, rd_ptr);
+				       txq, read_ptr);
 
 	/* free SKB */
 	skb = txq->entries[idx].skb;
@@ -387,7 +388,8 @@ static void iwl_pcie_txq_unmap(struct iwl_trans *trans, int txq_id)
 		return;
 	}
 
-	spin_lock_bh(&txq->lock);
+	spin_lock_bh(&txq->reclaim_lock);
+	spin_lock(&txq->lock);
 	while (txq->write_ptr != txq->read_ptr) {
 		IWL_DEBUG_TX_REPLY(trans, "Q %d Free %d\n",
 				   txq_id, txq->read_ptr);
@@ -402,7 +404,7 @@ static void iwl_pcie_txq_unmap(struct iwl_trans *trans, int txq_id)
 
 			iwl_pcie_free_tso_pages(trans, skb, cmd_meta);
 		}
-		iwl_txq_free_tfd(trans, txq);
+		iwl_txq_free_tfd(trans, txq, txq->read_ptr);
 		txq->read_ptr = iwl_txq_inc_wrap(trans, txq->read_ptr);
 
 		if (txq->read_ptr == txq->write_ptr &&
@@ -416,7 +418,8 @@ static void iwl_pcie_txq_unmap(struct iwl_trans *trans, int txq_id)
 		iwl_op_mode_free_skb(trans->op_mode, skb);
 	}
 
-	spin_unlock_bh(&txq->lock);
+	spin_unlock(&txq->lock);
+	spin_unlock_bh(&txq->reclaim_lock);
 
 	/* just in case - this queue may have been stopped */
 	iwl_trans_pcie_wake_queue(trans, txq);
@@ -921,6 +924,7 @@ int iwl_txq_init(struct iwl_trans *trans, struct iwl_txq *txq,
 		return ret;
 
 	spin_lock_init(&txq->lock);
+	spin_lock_init(&txq->reclaim_lock);
 
 	if (cmd_queue) {
 		static struct lock_class_key iwl_txq_cmd_queue_lock_class;
@@ -1055,11 +1059,12 @@ static void iwl_txq_progress(struct iwl_txq *txq)
 		mod_timer(&txq->stuck_timer, jiffies + txq->wd_timeout);
 }
 
-static inline bool iwl_txq_used(const struct iwl_txq *q, int i)
+static inline bool iwl_txq_used(const struct iwl_txq *q, int i,
+				int read_ptr, int write_ptr)
 {
 	int index = iwl_txq_get_cmd_index(q, i);
-	int r = iwl_txq_get_cmd_index(q, q->read_ptr);
-	int w = iwl_txq_get_cmd_index(q, q->write_ptr);
+	int r = iwl_txq_get_cmd_index(q, read_ptr);
+	int w = iwl_txq_get_cmd_index(q, write_ptr);
 
 	return w >= r ?
 		(index >= r && index < w) :
@@ -1086,7 +1091,7 @@ static void iwl_pcie_cmdq_reclaim(struct iwl_trans *trans, int txq_id, int idx)
 	r = iwl_txq_get_cmd_index(txq, txq->read_ptr);
 
 	if (idx >= trans->trans_cfg->base_params->max_tfd_queue_size ||
-	    (!iwl_txq_used(txq, idx))) {
+	    (!iwl_txq_used(txq, idx, txq->read_ptr, txq->write_ptr))) {
 		WARN_ONCE(test_bit(txq_id, trans_pcie->txqs.queue_used),
 			  "%s: Read index for DMA queue txq id (%d), index %d is out of range [0-%d] %d %d.\n",
 			  __func__, txq_id, idx,
@@ -2284,12 +2289,12 @@ int iwl_trans_pcie_tx(struct iwl_trans *trans, struct sk_buff *skb,
 }
 
 static void iwl_txq_gen1_inval_byte_cnt_tbl(struct iwl_trans *trans,
-					    struct iwl_txq *txq)
+					    struct iwl_txq *txq,
+					    int read_ptr)
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 	struct iwlagn_scd_bc_tbl *scd_bc_tbl = trans_pcie->txqs.scd_bc_tbls.addr;
 	int txq_id = txq->id;
-	int read_ptr = txq->read_ptr;
 	u8 sta_id = 0;
 	__le16 bc_ent;
 	struct iwl_device_tx_cmd *dev_cmd = txq->entries[read_ptr].cmd;
@@ -2316,6 +2321,7 @@ void iwl_pcie_reclaim(struct iwl_trans *trans, int txq_id, int ssn,
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 	struct iwl_txq *txq = trans_pcie->txqs.txq[txq_id];
 	int tfd_num, read_ptr, last_to_free;
+	int txq_read_ptr, txq_write_ptr;
 
 	/* This function is not meant to release cmd queue*/
 	if (WARN_ON(txq_id == trans_pcie->txqs.cmd.q_id))
@@ -2326,8 +2332,14 @@ void iwl_pcie_reclaim(struct iwl_trans *trans, int txq_id, int ssn,
 
 	tfd_num = iwl_txq_get_cmd_index(txq, ssn);
 
-	spin_lock_bh(&txq->lock);
-	read_ptr = iwl_txq_get_cmd_index(txq, txq->read_ptr);
+	spin_lock_bh(&txq->reclaim_lock);
+
+	spin_lock(&txq->lock);
+	txq_read_ptr = txq->read_ptr;
+	txq_write_ptr = txq->write_ptr;
+	spin_unlock(&txq->lock);
+
+	read_ptr = iwl_txq_get_cmd_index(txq, txq_read_ptr);
 
 	if (!test_bit(txq_id, trans_pcie->txqs.queue_used)) {
 		IWL_DEBUG_TX_QUEUES(trans, "Q %d inactive - ignoring idx %d\n",
@@ -2339,19 +2351,19 @@ void iwl_pcie_reclaim(struct iwl_trans *trans, int txq_id, int ssn,
 		goto out;
 
 	IWL_DEBUG_TX_REPLY(trans, "[Q %d] %d (%d) -> %d (%d)\n",
-			   txq_id, read_ptr, txq->read_ptr, tfd_num, ssn);
+			   txq_id, read_ptr, txq_read_ptr, tfd_num, ssn);
 
 	/* Since we free until index _not_ inclusive, the one before index is
 	 * the last we will free. This one must be used
 	 */
 	last_to_free = iwl_txq_dec_wrap(trans, tfd_num);
 
-	if (!iwl_txq_used(txq, last_to_free)) {
+	if (!iwl_txq_used(txq, last_to_free, txq_read_ptr, txq_write_ptr)) {
 		IWL_ERR(trans,
 			"%s: Read index for txq id (%d), last_to_free %d is out of range [0-%d] %d %d.\n",
 			__func__, txq_id, last_to_free,
 			trans->trans_cfg->base_params->max_tfd_queue_size,
-			txq->write_ptr, txq->read_ptr);
+			txq_write_ptr, txq_read_ptr);
 
 		iwl_op_mode_time_point(trans->op_mode,
 				       IWL_FW_INI_TIME_POINT_FAKE_TX,
@@ -2364,13 +2376,13 @@ void iwl_pcie_reclaim(struct iwl_trans *trans, int txq_id, int ssn,
 
 	for (;
 	     read_ptr != tfd_num;
-	     txq->read_ptr = iwl_txq_inc_wrap(trans, txq->read_ptr),
-	     read_ptr = iwl_txq_get_cmd_index(txq, txq->read_ptr)) {
+	     txq_read_ptr = iwl_txq_inc_wrap(trans, txq_read_ptr),
+	     read_ptr = iwl_txq_get_cmd_index(txq, txq_read_ptr)) {
 		struct iwl_cmd_meta *cmd_meta = &txq->entries[read_ptr].meta;
 		struct sk_buff *skb = txq->entries[read_ptr].skb;
 
 		if (WARN_ONCE(!skb, "no SKB at %d (%d) on queue %d\n",
-			      read_ptr, txq->read_ptr, txq_id))
+			      read_ptr, txq_read_ptr, txq_id))
 			continue;
 
 		iwl_pcie_free_tso_pages(trans, skb, cmd_meta);
@@ -2380,11 +2392,15 @@ void iwl_pcie_reclaim(struct iwl_trans *trans, int txq_id, int ssn,
 		txq->entries[read_ptr].skb = NULL;
 
 		if (!trans->trans_cfg->gen2)
-			iwl_txq_gen1_inval_byte_cnt_tbl(trans, txq);
+			iwl_txq_gen1_inval_byte_cnt_tbl(trans, txq,
+							txq_read_ptr);
 
-		iwl_txq_free_tfd(trans, txq);
+		iwl_txq_free_tfd(trans, txq, txq_read_ptr);
 	}
 
+	spin_lock(&txq->lock);
+	txq->read_ptr = txq_read_ptr;
+
 	iwl_txq_progress(txq);
 
 	if (iwl_txq_space(trans, txq) > txq->low_mark &&
@@ -2406,11 +2422,10 @@ void iwl_pcie_reclaim(struct iwl_trans *trans, int txq_id, int ssn,
 		txq->overflow_tx = true;
 
 		/*
-		 * This is tricky: we are in reclaim path which is non
-		 * re-entrant, so noone will try to take the access the
-		 * txq data from that path. We stopped tx, so we can't
-		 * have tx as well. Bottom line, we can unlock and re-lock
-		 * later.
+		 * This is tricky: we are in reclaim path and are holding
+		 * reclaim_lock, so noone will try to access the txq data
+		 * from that path. We stopped tx, so we can't have tx as well.
+		 * Bottom line, we can unlock and re-lock later.
 		 */
 		spin_unlock(&txq->lock);
 
@@ -2435,8 +2450,9 @@ void iwl_pcie_reclaim(struct iwl_trans *trans, int txq_id, int ssn,
 		txq->overflow_tx = false;
 	}
 
+	spin_unlock(&txq->lock);
 out:
-	spin_unlock_bh(&txq->lock);
+	spin_unlock_bh(&txq->reclaim_lock);
 }
 
 /* Set wr_ptr of specific device and txq  */
-- 
2.34.1


