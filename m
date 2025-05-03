Return-Path: <linux-wireless+bounces-22371-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25D8CAA825B
	for <lists+linux-wireless@lfdr.de>; Sat,  3 May 2025 21:45:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4717189D299
	for <lists+linux-wireless@lfdr.de>; Sat,  3 May 2025 19:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F167627E7D8;
	Sat,  3 May 2025 19:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d6Gn2rfG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24DDA27E7DB
	for <linux-wireless@vger.kernel.org>; Sat,  3 May 2025 19:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746301498; cv=none; b=d1bcmzWXyLTPTDZO9YHuTNtiCORXN4QN4LHsIqGLlqI9u66CwuAJDqTmPTdaUmsnJkI1rYv416nNIuFnrZu0o7h56AArSCR17BpDTgeOuH1M99br5xyJewzZsaPHNfop7EspC09s4C69tiQYP33NyuFZAG9+RjtIbMhq3XeHIM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746301498; c=relaxed/simple;
	bh=ydWduFFn+AwfgzuEfAsab1s9/4br6JyCRgMAveYTVXo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ue7zK/j1/T2kzVUSq3Bfqo/lxi2BkQ8WsQLFeuksbXJYCbSgTkmEBdQdrqZa7BlR9RHKDO2U52SY6zMvr8K6AWbYnkR8jq3x0z/H7VTHKU9am+wYJA9xvIGXK3x2QaKrzSZwfaDKkfFB33m5N7JegPjZR6/7Y3q7t7YtxGZfg/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d6Gn2rfG; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746301497; x=1777837497;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ydWduFFn+AwfgzuEfAsab1s9/4br6JyCRgMAveYTVXo=;
  b=d6Gn2rfG8IOrTlEO4GY43qYkt7cLjfXLy5NkSBt9inJR4t1MGU9eivyA
   Hg23C9ua0ezFVfJDsE1qfB6C48KQjl4FRq8jmMV7Xg02+Y3J7w07YEuCX
   qM1fVH3orFwnV/4JIs7pIxjH04xK7lfjPCW6aPojJxAsCDJ0BgWhBZy45
   yqrBQd36O27zPjm2Tzh8mXgdMi6zu79tLTxNI4UHk+205s+Hr9jQkXxP1
   UzuInhkLVlRyud6LxQVaWXKZ/r45gd2uHapn+gmV+kJNF2OwtmgBEvq3d
   XVyCWI0Fx8mhSHhOkLUyyMYs0bPbILs1sTyK+RhNvSfA7TjdYIYGDh914
   w==;
X-CSE-ConnectionGUID: vw6RDxVnTyqkGHlVqBqtZw==
X-CSE-MsgGUID: OIjupYUmQEqFx5H1wQTEZg==
X-IronPort-AV: E=McAfee;i="6700,10204,11422"; a="58613260"
X-IronPort-AV: E=Sophos;i="6.15,258,1739865600"; 
   d="scan'208";a="58613260"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2025 12:44:57 -0700
X-CSE-ConnectionGUID: XhAL4RiZTjq6CgvwBJ4alg==
X-CSE-MsgGUID: df/SIEklRxezFrF0OXaKfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,258,1739865600"; 
   d="scan'208";a="134644276"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2025 12:44:55 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: miriam.rachel.korenblit@intel.com
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 04/15] wifi: iwlwifi: pcie: move wait_command_queue into PCIe
Date: Sat,  3 May 2025 22:44:23 +0300
Message-Id: <20250503224231.793f625c5c2d.I64ebb402255d84c2ad045a65e5a4e4891ead5b26@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250503194434.147426-1-miriam.rachel.korenblit@intel.com>
References: <20250503194434.147426-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

There's no reason for this to be declared in the transport
struct, so move the item to the PCIe struct.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-trans.c     | 3 ---
 drivers/net/wireless/intel/iwlwifi/iwl-trans.h     | 2 --
 drivers/net/wireless/intel/iwlwifi/pcie/internal.h | 3 +++
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c       | 6 +++---
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c    | 3 +++
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c       | 4 ++--
 6 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.c b/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
index 5fc6561f4378..67f9edcdf8f6 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
@@ -325,9 +325,6 @@ int iwl_trans_init(struct iwl_trans *trans)
 	if (!trans->dev_cmd_pool)
 		return -ENOMEM;
 
-	/* Initialize the wait queue for commands */
-	init_waitqueue_head(&trans->wait_command_queue);
-
 	return 0;
 }
 
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index 771e4a3e05f5..34e386bf96b6 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -854,7 +854,6 @@ struct iwl_txq {
  * @command_groups: pointer to command group name list array
  * @command_groups_size: array size of @command_groups
  * @wide_cmd_header: true when ucode supports wide command header format
- * @wait_command_queue: wait queue for sync commands
  * @num_rx_queues: number of RX queues allocated by the transport;
  *	the transport must set this before calling iwl_drv_start()
  * @iml_len: the length of the image loader
@@ -934,7 +933,6 @@ struct iwl_trans {
 	int command_groups_size;
 	bool wide_cmd_header;
 
-	wait_queue_head_t wait_command_queue;
 	u8 num_rx_queues;
 
 	size_t iml_len;
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
index 6eee20ffbfc8..259ad96c012d 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
@@ -424,6 +424,7 @@ struct iwl_pcie_txqs {
  *	or unknown (-1, so can still use it as a boolean safely)
  * @me_recheck_wk: worker to recheck WiAMT/CSME presence
  * @invalid_tx_cmd: invalid TX command buffer
+ * @wait_command_queue: wait queue for sync commands
  */
 struct iwl_trans_pcie {
 	struct iwl_rxq *rxq;
@@ -528,6 +529,8 @@ struct iwl_trans_pcie {
 	struct delayed_work me_recheck_wk;
 
 	struct iwl_dma_ptr invalid_tx_cmd;
+
+	wait_queue_head_t wait_command_queue;
 };
 
 static inline struct iwl_trans_pcie *
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
index b619a77f81f1..d3c72cf0a5f4 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
@@ -1691,7 +1691,7 @@ static void iwl_pcie_irq_handle_error(struct iwl_trans *trans)
 			    APMG_PS_CTRL_VAL_RESET_REQ))) {
 		clear_bit(STATUS_SYNC_HCMD_ACTIVE, &trans->status);
 		iwl_op_mode_wimax_active(trans->op_mode);
-		wake_up(&trans->wait_command_queue);
+		wake_up(&trans_pcie->wait_command_queue);
 		return;
 	}
 
@@ -1706,7 +1706,7 @@ static void iwl_pcie_irq_handle_error(struct iwl_trans *trans)
 	iwl_trans_fw_error(trans, IWL_ERR_TYPE_IRQ);
 
 	clear_bit(STATUS_SYNC_HCMD_ACTIVE, &trans->status);
-	wake_up(&trans->wait_command_queue);
+	wake_up(&trans_pcie->wait_command_queue);
 }
 
 static u32 iwl_pcie_int_cause_non_ict(struct iwl_trans *trans)
@@ -1821,7 +1821,7 @@ void iwl_pcie_handle_rfkill_irq(struct iwl_trans *trans, bool from_irq)
 				       &trans->status))
 			IWL_DEBUG_RF_KILL(trans,
 					  "Rfkill while SYNC HCMD in flight\n");
-		wake_up(&trans->wait_command_queue);
+		wake_up(&trans_pcie->wait_command_queue);
 	} else {
 		clear_bit(STATUS_RFKILL_HW, &trans->status);
 		if (trans_pcie->opmode_down)
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index bfde1e3dc74c..c418be1ff75c 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -3829,6 +3829,9 @@ iwl_trans_pcie_alloc(struct pci_dev *pdev,
 
 	trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 
+	/* Initialize the wait queue for commands */
+	init_waitqueue_head(&trans_pcie->wait_command_queue);
+
 	if (trans->trans_cfg->gen2) {
 		trans_pcie->txqs.tfd.addr_size = 64;
 		trans_pcie->txqs.tfd.max_tbs = IWL_TFH_NUM_TBS;
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
index c728722533a8..51a80a0f1688 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
@@ -1686,7 +1686,7 @@ void iwl_pcie_hcmd_complete(struct iwl_trans *trans,
 		clear_bit(STATUS_SYNC_HCMD_ACTIVE, &trans->status);
 		IWL_DEBUG_INFO(trans, "Clearing HCMD_ACTIVE for command %s\n",
 			       iwl_get_cmd_string(trans, cmd_id));
-		wake_up(&trans->wait_command_queue);
+		wake_up(&trans_pcie->wait_command_queue);
 	}
 
 	meta->flags = 0;
@@ -2581,7 +2581,7 @@ static int iwl_trans_pcie_send_hcmd_sync(struct iwl_trans *trans,
 		return ret;
 	}
 
-	ret = wait_event_timeout(trans->wait_command_queue,
+	ret = wait_event_timeout(trans_pcie->wait_command_queue,
 				 !test_bit(STATUS_SYNC_HCMD_ACTIVE,
 					   &trans->status),
 				 HOST_COMPLETE_TIMEOUT);
-- 
2.34.1


