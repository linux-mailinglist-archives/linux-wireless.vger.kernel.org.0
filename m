Return-Path: <linux-wireless+bounces-16836-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 760EA9FD1BF
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Dec 2024 09:02:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15B1E163F34
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Dec 2024 08:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F29C155352;
	Fri, 27 Dec 2024 08:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FtBtUPtd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E5B1552ED
	for <linux-wireless@vger.kernel.org>; Fri, 27 Dec 2024 08:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735286509; cv=none; b=dqzXX4o1aMl1Hfvp9HYHUC9T2/G/TEwEv6mTBHv5IwrsXCMUzol+WoVDwqkzCMvkdrremXfOIAguu0vL+ECPzykRmAKb76xsMbpXe/AwWdeGKKq/ve26kKP0IvbxV0d4aAhGA4QHapDasIL0yxuws0OwEkhafzM9o87stQYw6Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735286509; c=relaxed/simple;
	bh=+Fg5sgi9mJBmI9U5Q7GI91F6PsG+9vhDeT+Tp8ayiAE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WJ5uoyoR8W9kU0XcMixhuF1lztmfcDYegkZXYIAMJqBtkqOlLhYwB29fJp5gCHAVEWG4DNMVjT0CyXn83EHnnXP+UWWO0fFM/E30VysiOIP4pxwgNEAzq4Ul+bxY5Z4jyVu9FM+PQrl7qhOtAMr00Fc3K0YJ4riYEV0uVVzsvcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FtBtUPtd; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735286507; x=1766822507;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+Fg5sgi9mJBmI9U5Q7GI91F6PsG+9vhDeT+Tp8ayiAE=;
  b=FtBtUPtdaEJruYhL25nU1NxJfN2Nuyyxcd4wE3hY0YvVW4f3rDYs62fU
   YDwVMLpS3/aPjFeiV0Q0MTxBAkms0YvZ5figOTDlx0WGFuJ77v9aMhQX/
   3p0GwwZSFAQ2QnFdwuoXc3LkxtLu3rFz9U5fzYl1+RhTD74ZxgRPlrD0k
   ZT9uw7zOZf2YwSn19f8Ewxr3GI8Yl+TLaw0cKgmsmjtUjIcE3Db3GDLFb
   A96FnJZNbJD85ZE4VQS2LfnfRhezGsRrt/wyRm66Fomx/4xPORA6qnz4B
   QUNVSo+fd2fva+SP5hpyLM6KpNXzK+fwcbtj/ILDgWohi+GogOp/QV0Ob
   Q==;
X-CSE-ConnectionGUID: DetV7dzEQGq/9yTQ3ksWTA==
X-CSE-MsgGUID: 02jLNHnnS9mN2sQJN0taFw==
X-IronPort-AV: E=McAfee;i="6700,10204,11297"; a="46690995"
X-IronPort-AV: E=Sophos;i="6.12,268,1728975600"; 
   d="scan'208";a="46690995"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2024 00:01:45 -0800
X-CSE-ConnectionGUID: ZtOvNhoPR3SvpdgTNdgQXg==
X-CSE-MsgGUID: R+XqimpUQpSTdaYONwPJQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,268,1728975600"; 
   d="scan'208";a="99858444"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2024 00:01:44 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 14/17] wifi: iwlwifi: unify cmd_queue_full() into nic_error()
Date: Fri, 27 Dec 2024 10:01:09 +0200
Message-Id: <20241227095718.0222183504aa.Ie29cef75fbd91b64a43619bc36bd5b29c5b9f957@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241227080112.1098419-1-miriam.rachel.korenblit@intel.com>
References: <20241227080112.1098419-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Except for some special handling in DVM, error dump and some
message behaviour, cmd_queue_full and nic_error are equivalent
now. Unify by giving a special error type, so DVM can continue
to differentiate.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/dvm/main.c | 22 ++++++++-----------
 .../net/wireless/intel/iwlwifi/iwl-op-mode.h  | 10 ++-------
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  | 17 +++++---------
 .../net/wireless/intel/iwlwifi/pcie/tx-gen2.c |  3 ++-
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c  |  3 ++-
 5 files changed, 20 insertions(+), 35 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/main.c b/drivers/net/wireless/intel/iwlwifi/dvm/main.c
index 4f5846953fa3..797b7c360acf 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/main.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/main.c
@@ -1957,25 +1957,22 @@ static void iwl_nic_error(struct iwl_op_mode *op_mode,
 {
 	struct iwl_priv *priv = IWL_OP_MODE_GET_DVM(op_mode);
 
+	if (type == IWL_ERR_TYPE_CMD_QUEUE_FULL && iwl_check_for_ct_kill(priv))
+		return;
+
 	IWL_ERR(priv, "Loaded firmware version: %s\n",
 		priv->fw->fw_version);
 
-	iwl_dump_nic_error_log(priv);
-	iwl_dump_nic_event_log(priv, false, NULL);
+	if (type == IWL_ERR_TYPE_CMD_QUEUE_FULL) {
+		IWL_ERR(priv, "Command queue full!\n");
+	} else {
+		iwl_dump_nic_error_log(priv);
+		iwl_dump_nic_event_log(priv, false, NULL);
+	}
 
 	iwlagn_fw_error(priv, false);
 }
 
-static void iwl_cmd_queue_full(struct iwl_op_mode *op_mode)
-{
-	struct iwl_priv *priv = IWL_OP_MODE_GET_DVM(op_mode);
-
-	if (!iwl_check_for_ct_kill(priv)) {
-		IWL_ERR(priv, "Restarting adapter queue is full\n");
-		iwlagn_fw_error(priv, false);
-	}
-}
-
 #define EEPROM_RF_CONFIG_TYPE_MAX      0x3
 
 static void iwl_nic_config(struct iwl_op_mode *op_mode)
@@ -2128,7 +2125,6 @@ static const struct iwl_op_mode_ops iwl_dvm_ops = {
 	.hw_rf_kill = iwl_set_hw_rfkill_state,
 	.free_skb = iwl_free_skb,
 	.nic_error = iwl_nic_error,
-	.cmd_queue_full = iwl_cmd_queue_full,
 	.nic_config = iwl_nic_config,
 	.wimax_active = iwl_wimax_active,
 };
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-op-mode.h b/drivers/net/wireless/intel/iwlwifi/iwl-op-mode.h
index 8febc949b610..3b4085d3aad2 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-op-mode.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-op-mode.h
@@ -51,11 +51,13 @@ struct iwl_cfg;
  * @IWL_ERR_TYPE_RESET_HS_TIMEOUT: reset handshake timed out,
  *	any debug collection must happen synchronously as
  *	the device will be shut down
+ * @IWL_ERR_TYPE_CMD_QUEUE_FULL: command queue was full
  */
 enum iwl_fw_error_type {
 	IWL_ERR_TYPE_IRQ,
 	IWL_ERR_TYPE_NMI_FORCED,
 	IWL_ERR_TYPE_RESET_HS_TIMEOUT,
+	IWL_ERR_TYPE_CMD_QUEUE_FULL,
 };
 
 /**
@@ -93,8 +95,6 @@ enum iwl_fw_error_type {
  *	Must be atomic
  * @nic_error: error notification. Must be atomic and must be called with BH
  *	disabled, unless the type is IWL_ERR_TYPE_RESET_HS_TIMEOUT
- * @cmd_queue_full: Called when the command queue gets full. Must be atomic and
- *	called with BH disabled.
  * @nic_config: configure NIC, called before firmware is started.
  *	May sleep
  * @wimax_active: invoked when WiMax becomes active. May sleep
@@ -120,7 +120,6 @@ struct iwl_op_mode_ops {
 	void (*free_skb)(struct iwl_op_mode *op_mode, struct sk_buff *skb);
 	void (*nic_error)(struct iwl_op_mode *op_mode,
 			  enum iwl_fw_error_type type);
-	void (*cmd_queue_full)(struct iwl_op_mode *op_mode);
 	void (*nic_config)(struct iwl_op_mode *op_mode);
 	void (*wimax_active)(struct iwl_op_mode *op_mode);
 	void (*time_point)(struct iwl_op_mode *op_mode,
@@ -198,11 +197,6 @@ static inline void iwl_op_mode_nic_error(struct iwl_op_mode *op_mode,
 	op_mode->ops->nic_error(op_mode, type);
 }
 
-static inline void iwl_op_mode_cmd_queue_full(struct iwl_op_mode *op_mode)
-{
-	op_mode->ops->cmd_queue_full(op_mode);
-}
-
 static inline void iwl_op_mode_nic_config(struct iwl_op_mode *op_mode)
 {
 	might_sleep();
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index aad0449fab36..13a24030acdb 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -2118,9 +2118,11 @@ static void iwl_mvm_nic_error(struct iwl_op_mode *op_mode,
 {
 	struct iwl_mvm *mvm = IWL_OP_MODE_GET_MVM(op_mode);
 
-	if (!test_bit(STATUS_TRANS_DEAD, &mvm->trans->status) &&
-	    !test_and_clear_bit(IWL_MVM_STATUS_SUPPRESS_ERROR_LOG_ONCE,
-				&mvm->status))
+	if (type == IWL_ERR_TYPE_CMD_QUEUE_FULL)
+		IWL_ERR(mvm, "Command queue full!\n");
+	else if (!test_bit(STATUS_TRANS_DEAD, &mvm->trans->status) &&
+		 !test_and_clear_bit(IWL_MVM_STATUS_SUPPRESS_ERROR_LOG_ONCE,
+				     &mvm->status))
 		iwl_mvm_dump_nic_error_log(mvm);
 
 	/* reset HS timeout is during shutdown, so collect right now */
@@ -2140,14 +2142,6 @@ static void iwl_mvm_nic_error(struct iwl_op_mode *op_mode,
 	iwl_mvm_nic_restart(mvm);
 }
 
-static void iwl_mvm_cmd_queue_full(struct iwl_op_mode *op_mode)
-{
-	struct iwl_mvm *mvm = IWL_OP_MODE_GET_MVM(op_mode);
-
-	WARN_ON(1);
-	iwl_mvm_nic_restart(mvm);
-}
-
 static void iwl_op_mode_mvm_time_point(struct iwl_op_mode *op_mode,
 				       enum iwl_fw_ini_time_point tp_id,
 				       union iwl_dbg_tlv_tp_data *tp_data)
@@ -2181,7 +2175,6 @@ static void iwl_op_mode_mvm_device_powered_off(struct iwl_op_mode *op_mode)
 	.hw_rf_kill = iwl_mvm_set_hw_rfkill_state,		\
 	.free_skb = iwl_mvm_free_skb,				\
 	.nic_error = iwl_mvm_nic_error,				\
-	.cmd_queue_full = iwl_mvm_cmd_queue_full,		\
 	.nic_config = iwl_mvm_nic_config,			\
 	/* as we only register one, these MUST be common! */	\
 	.start = iwl_op_mode_mvm_start,				\
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c b/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
index b1846abb99b7..4c92588d15cb 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
@@ -1298,7 +1298,8 @@ int iwl_pcie_gen2_enqueue_hcmd(struct iwl_trans *trans,
 		spin_unlock_irqrestore(&txq->lock, flags);
 
 		IWL_ERR(trans, "No space in command queue\n");
-		iwl_op_mode_cmd_queue_full(trans->op_mode);
+		iwl_op_mode_nic_error(trans->op_mode,
+				      IWL_ERR_TYPE_CMD_QUEUE_FULL);
 		idx = -ENOSPC;
 		goto free_dup_buf;
 	}
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
index 1ef14340953c..aaa1b87ee265 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
@@ -1449,7 +1449,8 @@ int iwl_pcie_enqueue_hcmd(struct iwl_trans *trans,
 		spin_unlock_irqrestore(&txq->lock, flags);
 
 		IWL_ERR(trans, "No space in command queue\n");
-		iwl_op_mode_cmd_queue_full(trans->op_mode);
+		iwl_op_mode_nic_error(trans->op_mode,
+				      IWL_ERR_TYPE_CMD_QUEUE_FULL);
 		idx = -ENOSPC;
 		goto free_dup_buf;
 	}
-- 
2.34.1


