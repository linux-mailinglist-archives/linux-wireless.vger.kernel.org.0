Return-Path: <linux-wireless+bounces-16822-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D0129FD1B1
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Dec 2024 09:01:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E3907A1147
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Dec 2024 08:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4E416F2F2;
	Fri, 27 Dec 2024 08:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O0qu7H8J"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A600CA920
	for <linux-wireless@vger.kernel.org>; Fri, 27 Dec 2024 08:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735286489; cv=none; b=pF0hcX/XIFXN0HXYCY2uo329LRMac6+ip9qXBQCuRma+/F9I/BBQz0omTVErb6YMf4vwJdgJljR52AhOQu6Y0HQDOIQOssc5Zk9B+KzxHCWeWsnvD3bvJmSAuwk3pE965sg2cuaeMm+mG7D1hALOytv8OvSfYwhwrawUQ95EW6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735286489; c=relaxed/simple;
	bh=mNCGBE/wm0QxYM001luwkd7Ldje+R/xTRtBY0J2dnqE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NaKRfB1ytd5scgc27MJ1/aeQRbcl8Iqtih1m02yZTAtG2GeO8sOED6Dccql/0iaR2CoGvXN2FEGg8URq5NXQy/tUKDkwUvH8V/QJPiiE1L4E8bij5FFFQNDVWTGcSe5U/+hKcS1oJ8eGJIv64v6ZVdDwqqVqcwqJin1iWJFANQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O0qu7H8J; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735286487; x=1766822487;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mNCGBE/wm0QxYM001luwkd7Ldje+R/xTRtBY0J2dnqE=;
  b=O0qu7H8Jb0ymrollpgLaDx3HaHcVbX2Qg1Fb6f+J983tfjzGtiOPoOl+
   Je/YNffwHLaObUhOiC206iz+9/n53RXwpJSuWVyaMGds0cIT+C9vQl4Sh
   tpz8cw+/zth7bQskcEfnzwY10ECyocIKrG5lD/EGANK6r8HrsVkKy4bLk
   OEGy5L/r1WrA03/Kf0ovAM2/nd9Stx9MATkUTk6tP6sNLlFef43yNcE5y
   /CCcaNBofyreQ0LiMwosj8maQNOAhUGVUNzf1vLWFfncl9oa6dzn2TEAm
   Ro3ddIdP2HaaZJ3n2Ac0m1ytJC2V6mwMqiv/NIvzEd+Kry780hksufPdp
   w==;
X-CSE-ConnectionGUID: LHDwrjWVRxOIpF2vw6OlPQ==
X-CSE-MsgGUID: w7E+R+BJSkOkUYl+2+Gfbw==
X-IronPort-AV: E=McAfee;i="6700,10204,11297"; a="46690907"
X-IronPort-AV: E=Sophos;i="6.12,268,1728975600"; 
   d="scan'208";a="46690907"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2024 00:01:27 -0800
X-CSE-ConnectionGUID: YCpmvJpiR+6S7h3gz+W/KA==
X-CSE-MsgGUID: RGDXrwxqQ96YBUJ58O8qcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,268,1728975600"; 
   d="scan'208";a="99858199"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2024 00:01:25 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 01/17] wifi: iwlwifi: differentiate NIC error types
Date: Fri, 27 Dec 2024 10:00:56 +0200
Message-Id: <20241227095718.aed9c9e4fac0.I2288042bec4728a75b61cb7f6ded5214bfa3ce85@changeid>
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

Instead of differentiating only sync/async, differentiate
the type of error, and document that only reset handshake
timeout (IWL_ERR_TYPE_RESET_HS_TIMEOUT) needs sync handling.

The special sync handling is somewhat temporary, the idea
is to later split the nic_error() method into error dump,
synchronizing the dump, and SW reset methods, and the type
is mostly in order to unify command queue full handling
into that new architecture as well.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/dvm/main.c |  3 ++-
 drivers/net/wireless/intel/iwlwifi/iwl-io.c   |  2 +-
 .../net/wireless/intel/iwlwifi/iwl-op-mode.h  | 24 +++++++++++++++----
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |  5 ++--
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  | 11 ++++-----
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c  |  2 +-
 .../wireless/intel/iwlwifi/pcie/trans-gen2.c  |  2 +-
 7 files changed, 32 insertions(+), 17 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/main.c b/drivers/net/wireless/intel/iwlwifi/dvm/main.c
index 769b75c3fa5b..2c4363662efd 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/main.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/main.c
@@ -1942,7 +1942,8 @@ static void iwlagn_fw_error(struct iwl_priv *priv, bool ondemand)
 	}
 }
 
-static void iwl_nic_error(struct iwl_op_mode *op_mode, bool sync)
+static void iwl_nic_error(struct iwl_op_mode *op_mode,
+			  enum iwl_fw_error_type type)
 {
 	struct iwl_priv *priv = IWL_OP_MODE_GET_DVM(op_mode);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-io.c b/drivers/net/wireless/intel/iwlwifi/iwl-io.c
index 060becfd64f3..0653ca8b974a 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-io.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-io.c
@@ -526,5 +526,5 @@ void iwl_trans_sync_nmi_with_addr(struct iwl_trans *trans, u32 inta_addr,
 	if (interrupts_enabled)
 		iwl_trans_interrupts(trans, true);
 
-	iwl_trans_fw_error(trans, false);
+	iwl_trans_fw_error(trans, IWL_ERR_TYPE_NMI_FORCED);
 }
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-op-mode.h b/drivers/net/wireless/intel/iwlwifi/iwl-op-mode.h
index 8ef5ed2db051..8febc949b610 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-op-mode.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-op-mode.h
@@ -44,6 +44,20 @@ struct iwl_cfg;
  *	5) The driver layer stops the op_mode
  */
 
+/**
+ * enum iwl_fw_error_type - FW error types/sources
+ * @IWL_ERR_TYPE_IRQ: "normal" FW error through an IRQ
+ * @IWL_ERR_TYPE_NMI_FORCED: NMI was forced by driver
+ * @IWL_ERR_TYPE_RESET_HS_TIMEOUT: reset handshake timed out,
+ *	any debug collection must happen synchronously as
+ *	the device will be shut down
+ */
+enum iwl_fw_error_type {
+	IWL_ERR_TYPE_IRQ,
+	IWL_ERR_TYPE_NMI_FORCED,
+	IWL_ERR_TYPE_RESET_HS_TIMEOUT,
+};
+
 /**
  * struct iwl_op_mode_ops - op_mode specific operations
  *
@@ -78,7 +92,7 @@ struct iwl_cfg;
  *	there are Tx packets pending in the transport layer.
  *	Must be atomic
  * @nic_error: error notification. Must be atomic and must be called with BH
- *	disabled, unless the sync parameter is true.
+ *	disabled, unless the type is IWL_ERR_TYPE_RESET_HS_TIMEOUT
  * @cmd_queue_full: Called when the command queue gets full. Must be atomic and
  *	called with BH disabled.
  * @nic_config: configure NIC, called before firmware is started.
@@ -104,7 +118,8 @@ struct iwl_op_mode_ops {
 	void (*queue_not_full)(struct iwl_op_mode *op_mode, int queue);
 	bool (*hw_rf_kill)(struct iwl_op_mode *op_mode, bool state);
 	void (*free_skb)(struct iwl_op_mode *op_mode, struct sk_buff *skb);
-	void (*nic_error)(struct iwl_op_mode *op_mode, bool sync);
+	void (*nic_error)(struct iwl_op_mode *op_mode,
+			  enum iwl_fw_error_type type);
 	void (*cmd_queue_full)(struct iwl_op_mode *op_mode);
 	void (*nic_config)(struct iwl_op_mode *op_mode);
 	void (*wimax_active)(struct iwl_op_mode *op_mode);
@@ -177,9 +192,10 @@ static inline void iwl_op_mode_free_skb(struct iwl_op_mode *op_mode,
 	op_mode->ops->free_skb(op_mode, skb);
 }
 
-static inline void iwl_op_mode_nic_error(struct iwl_op_mode *op_mode, bool sync)
+static inline void iwl_op_mode_nic_error(struct iwl_op_mode *op_mode,
+					 enum iwl_fw_error_type type)
 {
-	op_mode->ops->nic_error(op_mode, sync);
+	op_mode->ops->nic_error(op_mode, type);
 }
 
 static inline void iwl_op_mode_cmd_queue_full(struct iwl_op_mode *op_mode)
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index c70da7281551..56b551fd2156 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -1120,7 +1120,8 @@ bool _iwl_trans_grab_nic_access(struct iwl_trans *trans);
 void __releases(nic_access)
 iwl_trans_release_nic_access(struct iwl_trans *trans);
 
-static inline void iwl_trans_fw_error(struct iwl_trans *trans, bool sync)
+static inline void iwl_trans_fw_error(struct iwl_trans *trans,
+				      enum iwl_fw_error_type type)
 {
 	if (WARN_ON_ONCE(!trans->op_mode))
 		return;
@@ -1128,7 +1129,7 @@ static inline void iwl_trans_fw_error(struct iwl_trans *trans, bool sync)
 	/* prevent double restarts due to the same erroneous FW */
 	if (!test_and_set_bit(STATUS_FW_ERROR, &trans->status)) {
 		trans->state = IWL_TRANS_NO_FW;
-		iwl_op_mode_nic_error(trans->op_mode, sync);
+		iwl_op_mode_nic_error(trans->op_mode, type);
 	}
 }
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index 0deaf6ed8994..e21199313278 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -2108,7 +2108,8 @@ void iwl_mvm_nic_restart(struct iwl_mvm *mvm, bool fw_error)
 	}
 }
 
-static void iwl_mvm_nic_error(struct iwl_op_mode *op_mode, bool sync)
+static void iwl_mvm_nic_error(struct iwl_op_mode *op_mode,
+			      enum iwl_fw_error_type type)
 {
 	struct iwl_mvm *mvm = IWL_OP_MODE_GET_MVM(op_mode);
 
@@ -2117,13 +2118,9 @@ static void iwl_mvm_nic_error(struct iwl_op_mode *op_mode, bool sync)
 				&mvm->status))
 		iwl_mvm_dump_nic_error_log(mvm);
 
-	if (sync) {
+	/* reset HS timeout is during shutdown, so collect right now */
+	if (type == IWL_ERR_TYPE_RESET_HS_TIMEOUT) {
 		iwl_fw_error_collect(&mvm->fwrt, true);
-		/*
-		 * Currently, the only case for sync=true is during
-		 * shutdown, so just stop in this case. If/when that
-		 * changes, we need to be a bit smarter here.
-		 */
 		return;
 	}
 
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
index afb88eab8174..02fef6baf2e3 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
@@ -1702,7 +1702,7 @@ static void iwl_pcie_irq_handle_error(struct iwl_trans *trans)
 
 	/* The STATUS_FW_ERROR bit is set in this function. This must happen
 	 * before we wake up the command caller, to ensure a proper cleanup. */
-	iwl_trans_fw_error(trans, false);
+	iwl_trans_fw_error(trans, IWL_ERR_TYPE_IRQ);
 
 	clear_bit(STATUS_SYNC_HCMD_ACTIVE, &trans->status);
 	wake_up(&trans->wait_command_queue);
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
index 8903a5692dfb..469ef32a3e26 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
@@ -124,7 +124,7 @@ static void iwl_trans_pcie_fw_reset_handshake(struct iwl_trans *trans)
 			inta_hw);
 
 		if (!(inta_hw & MSIX_HW_INT_CAUSES_REG_RESET_DONE))
-			iwl_trans_fw_error(trans, true);
+			iwl_trans_fw_error(trans, IWL_ERR_TYPE_RESET_HS_TIMEOUT);
 	}
 
 	trans_pcie->fw_reset_state = FW_RESET_IDLE;
-- 
2.34.1


