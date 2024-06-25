Return-Path: <linux-wireless+bounces-9542-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F23A916E7D
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jun 2024 18:52:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 477D7288324
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jun 2024 16:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2AAB17B4FA;
	Tue, 25 Jun 2024 16:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fu/uWZsY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29B3176248
	for <linux-wireless@vger.kernel.org>; Tue, 25 Jun 2024 16:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719334305; cv=none; b=oUrIBVh+pO1IvTDt81bfR1xJ1D1DFT0IyMFZO7/g2+pZpEL4gXe5cV0sEh2rnEJIBRihy0iRc9AIQ87Uxo1fEtAWRjAbD4zpwExt9lvZF01vW2OtXAwZ4bHH6DCHz7L0QO8PS1+TRAxzByOiWvoR7W5mdcRQKc1vwljY8GbKBxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719334305; c=relaxed/simple;
	bh=tK+1viRmlDJIBg0Pe2Lx5oZqshjpaqj1oLIfHM1mWSk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pR60+f+PIH4+sfSn4+l5uBQX3zm1bHrnsyANl/6lR+40Pjpt7nOJsmMO4ov+Ru22XBynV7fj0s8lp/UgvxMN+t3ePutNYzSAHulmfuYo8SkXb7YvxcWIArw7Rf7UuU7n3u55eCjD7Zx75At7+TzT8YpNhiEKjTNSoAO5LcBX5pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fu/uWZsY; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719334304; x=1750870304;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tK+1viRmlDJIBg0Pe2Lx5oZqshjpaqj1oLIfHM1mWSk=;
  b=fu/uWZsYeuV6q7wqQbNGi9u8fM11lTyhEDlUGR9gKOMMync7TCQ+xVht
   Ytu8+POPp/FVGemE7IB2ewZAKTJ1kFDK4EifgX96YoXw+YOQ21nYvCz76
   ysX4/WvksZGqKHWoFZxV1aCRuJU2qpDWQL3ejT2qgFZ8zDzmZStasBvHw
   AB93KZk648h/e6S6g2Gbn7bqyAtI7EVnKfcQFrR4Zjood9gnZfy6qDu6x
   kc7LqPTcHaIgyXDZgClsJOUVq2s9t/mnyQn+4hI2HxS45ii4tzIytS6Ah
   ZY+bCn45p+MzgzXk3xdPBjSU3EUCOZsr1guo5topG8O/s8nNMlTBetFHK
   Q==;
X-CSE-ConnectionGUID: UXF+KBl8QNmYk4zIZUCZGg==
X-CSE-MsgGUID: ekUBculRSUuXlp9N2sZWoQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11114"; a="16594739"
X-IronPort-AV: E=Sophos;i="6.08,264,1712646000"; 
   d="scan'208";a="16594739"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 09:51:44 -0700
X-CSE-ConnectionGUID: LQFZ3JnrQ+ixHimQFBS4fg==
X-CSE-MsgGUID: BsjZy/PJQ3WbPw4B3L4NRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,264,1712646000"; 
   d="scan'208";a="48632626"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 09:51:42 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 08/17] wifi: iwlwifi: trans: make bad state warnings
Date: Tue, 25 Jun 2024 19:51:14 +0300
Message-Id: <20240625194805.be7a3a95afae.Ie8606d36783818c043c971bf0bc6f4df6a6e8f5b@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240625165123.1624974-1-miriam.rachel.korenblit@intel.com>
References: <20240625165123.1624974-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Kalle reported that this triggers very occasionally, but
we don't even know which place, except that it wasn't one
with a warning. Make all of them warnings since this is
really not meant to happen and indicates driver bugs.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/iwl-trans.c    | 46 ++++++++-----------
 1 file changed, 18 insertions(+), 28 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.c b/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
index bd21bbe7e7e3..3c9d91496c82 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
@@ -108,10 +108,9 @@ int iwl_trans_send_cmd(struct iwl_trans *trans, struct iwl_host_cmd *cmd)
 	if (unlikely(test_bit(STATUS_FW_ERROR, &trans->status)))
 		return -EIO;
 
-	if (unlikely(trans->state != IWL_TRANS_FW_ALIVE)) {
-		IWL_ERR(trans, "%s bad state = %d\n", __func__, trans->state);
+	if (WARN_ONCE(trans->state != IWL_TRANS_FW_ALIVE,
+		      "bad state = %d\n", trans->state))
 		return -EIO;
-	}
 
 	if (!(cmd->flags & CMD_ASYNC))
 		lock_map_acquire_read(&trans->sync_cmd_lockdep_map);
@@ -407,10 +406,9 @@ int iwl_trans_tx(struct iwl_trans *trans, struct sk_buff *skb,
 	if (unlikely(test_bit(STATUS_FW_ERROR, &trans->status)))
 		return -EIO;
 
-	if (WARN_ON_ONCE(trans->state != IWL_TRANS_FW_ALIVE)) {
-		IWL_ERR(trans, "%s bad state = %d\n", __func__, trans->state);
+	if (WARN_ONCE(trans->state != IWL_TRANS_FW_ALIVE,
+		      "bad state = %d\n", trans->state))
 		return -EIO;
-	}
 
 	if (trans->trans_cfg->gen2)
 		return iwl_txq_gen2_tx(trans, skb, dev_cmd, queue);
@@ -422,10 +420,9 @@ IWL_EXPORT_SYMBOL(iwl_trans_tx);
 void iwl_trans_reclaim(struct iwl_trans *trans, int queue, int ssn,
 		       struct sk_buff_head *skbs, bool is_flush)
 {
-	if (WARN_ON_ONCE(trans->state != IWL_TRANS_FW_ALIVE)) {
-		IWL_ERR(trans, "%s bad state = %d\n", __func__, trans->state);
+	if (WARN_ONCE(trans->state != IWL_TRANS_FW_ALIVE,
+		      "bad state = %d\n", trans->state))
 		return;
-	}
 
 	iwl_pcie_reclaim(trans, queue, ssn, skbs, is_flush);
 }
@@ -444,10 +441,9 @@ bool iwl_trans_txq_enable_cfg(struct iwl_trans *trans, int queue, u16 ssn,
 {
 	might_sleep();
 
-	if (WARN_ON_ONCE(trans->state != IWL_TRANS_FW_ALIVE)) {
-		IWL_ERR(trans, "%s bad state = %d\n", __func__, trans->state);
+	if (WARN_ONCE(trans->state != IWL_TRANS_FW_ALIVE,
+		      "bad state = %d\n", trans->state))
 		return false;
-	}
 
 	return iwl_trans_pcie_txq_enable(trans, queue, ssn,
 					 cfg, queue_wdg_timeout);
@@ -456,10 +452,9 @@ IWL_EXPORT_SYMBOL(iwl_trans_txq_enable_cfg);
 
 int iwl_trans_wait_txq_empty(struct iwl_trans *trans, int queue)
 {
-	if (WARN_ON_ONCE(trans->state != IWL_TRANS_FW_ALIVE)) {
-		IWL_ERR(trans, "%s bad state = %d\n", __func__, trans->state);
+	if (WARN_ONCE(trans->state != IWL_TRANS_FW_ALIVE,
+		      "bad state = %d\n", trans->state))
 		return -EIO;
-	}
 
 	return iwl_trans_pcie_wait_txq_empty(trans, queue);
 }
@@ -467,11 +462,9 @@ IWL_EXPORT_SYMBOL(iwl_trans_wait_txq_empty);
 
 int iwl_trans_wait_tx_queues_empty(struct iwl_trans *trans, u32 txqs)
 {
-	/* No need to wait if the firmware is not alive */
-	if (trans->state != IWL_TRANS_FW_ALIVE) {
-		IWL_ERR(trans, "%s bad state = %d\n", __func__, trans->state);
+	if (WARN_ONCE(trans->state != IWL_TRANS_FW_ALIVE,
+		      "bad state = %d\n", trans->state))
 		return -EIO;
-	}
 
 	return iwl_trans_pcie_wait_txqs_empty(trans, txqs);
 }
@@ -480,10 +473,9 @@ IWL_EXPORT_SYMBOL(iwl_trans_wait_tx_queues_empty);
 void iwl_trans_freeze_txq_timer(struct iwl_trans *trans,
 				unsigned long txqs, bool freeze)
 {
-	if (WARN_ON_ONCE(trans->state != IWL_TRANS_FW_ALIVE)) {
-		IWL_ERR(trans, "%s bad state = %d\n", __func__, trans->state);
+	if (WARN_ONCE(trans->state != IWL_TRANS_FW_ALIVE,
+		      "bad state = %d\n", trans->state))
 		return;
-	}
 
 	iwl_pcie_freeze_txq_timer(trans, txqs, freeze);
 }
@@ -506,10 +498,9 @@ IWL_EXPORT_SYMBOL(iwl_trans_debugfs_cleanup);
 
 void iwl_trans_set_q_ptrs(struct iwl_trans *trans, int queue, int ptr)
 {
-	if (WARN_ON_ONCE(trans->state != IWL_TRANS_FW_ALIVE)) {
-		IWL_ERR(trans, "%s bad state = %d\n", __func__, trans->state);
+	if (WARN_ONCE(trans->state != IWL_TRANS_FW_ALIVE,
+		      "bad state = %d\n", trans->state))
 		return;
-	}
 
 	iwl_pcie_set_q_ptrs(trans, queue, ptr);
 }
@@ -520,10 +511,9 @@ int iwl_trans_txq_alloc(struct iwl_trans *trans, u32 flags, u32 sta_mask,
 {
 	might_sleep();
 
-	if (WARN_ON_ONCE(trans->state != IWL_TRANS_FW_ALIVE)) {
-		IWL_ERR(trans, "%s bad state = %d\n", __func__, trans->state);
+	if (WARN_ONCE(trans->state != IWL_TRANS_FW_ALIVE,
+		      "bad state = %d\n", trans->state))
 		return -EIO;
-	}
 
 	return iwl_txq_dyn_alloc(trans, flags, sta_mask, tid,
 				 size, wdg_timeout);
-- 
2.34.1


