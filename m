Return-Path: <linux-wireless+bounces-16838-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 203F89FD1C1
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Dec 2024 09:02:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3343161766
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Dec 2024 08:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C2F514F9F8;
	Fri, 27 Dec 2024 08:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cPNL+KML"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081FA155336
	for <linux-wireless@vger.kernel.org>; Fri, 27 Dec 2024 08:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735286511; cv=none; b=IiVHNVU63QpQgu6QdmVG4YqaHTwdudXZRb3E1CcO3fo1fm+vQGbnWCb+/eyhV8kr911zJLXeRQ4GuyYirATxUCs2fWqmOYBaMhcv/Lacw7ZdSqn01PwCtEF/vxvy//dWVNPfyoYHpHcyA62bcWge4cN+5YHdoozH8rVSVh9CVTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735286511; c=relaxed/simple;
	bh=wUb4mkMNDiy6bj79JVRzq+ll7dj20TK4WvhTBG+NL3o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y8GwoVLdLJuahEYoVHiqGCRiBAu3Um0hd5sZw0xjSl008QjCIj/mIlr2XaZt7fmhBzZinrIbk5qGdIAb9XURHhgT3qDujc2V4D69ckCFWjmvM0fiXUL5TUvkdOZa0cnbkieTnTjjxSsPpva/JyZgh7Z+Uze7SuTlhj/QpQ8WYb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cPNL+KML; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735286509; x=1766822509;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wUb4mkMNDiy6bj79JVRzq+ll7dj20TK4WvhTBG+NL3o=;
  b=cPNL+KML6y8WeNnD21JCMK0Y+zGqFCiRI1RIiL/wZFmAN/43QP3pw0+j
   xqVoOqm2MhgkBzbbmRIM2p1aQGne+iAwAHxm5a3+k14rEvlN9SCqLeFPT
   QbdN15aC6dqNKqgHxrYN5/wkJ8As2ZwyHv/0v+U0LXdMcOP5Ou5YCG8bj
   dHlLRlWc9Vc01Y4oxX7IEEOCjJqQY+JOtWQ6d5uP5EIAnfy0HBZTinRqC
   OyfLv9KIwYmchLoiS9boUL2WxUCjCwnlJveTh9V89wzs/aY/FkySlYfuI
   HzZIETt44ylqmDlbBsAHqKicer+J1Wt4fq5sWV2wB1KhDOjN7WqyQdwMQ
   g==;
X-CSE-ConnectionGUID: xDHum4t7TReWPc8W1YSLVw==
X-CSE-MsgGUID: 2D38nF7PQ4qLhoXmyvHEbA==
X-IronPort-AV: E=McAfee;i="6700,10204,11297"; a="46691007"
X-IronPort-AV: E=Sophos;i="6.12,268,1728975600"; 
   d="scan'208";a="46691007"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2024 00:01:48 -0800
X-CSE-ConnectionGUID: 9J0dllAXRxSlDJSIZ5RNLw==
X-CSE-MsgGUID: yTWq8gEZRyiHeWF+/lfgyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,268,1728975600"; 
   d="scan'208";a="99858475"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2024 00:01:47 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 16/17] wifi: iwlwifi: rework firmware error handling
Date: Fri, 27 Dec 2024 10:01:11 +0200
Message-Id: <20241227095718.6d4f741ae907.I96a9243e7877808ed6d1bff6967c15d6c24882f0@changeid>
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

In order to later add the ability to do deeper resets of the
device when it crashes, first restructure the firmware error
handling. Instead of having just a single nic_error() method
that handles all, split it:
 - nic_error() just handles and prints the error itself,
 - dump_error() synchronously creates an error dump, and
 - sw_reset() will be called to request doing a SW reset.

This changes the architecture so that the transport is now
responsible for deciding how to do the reset, and therefore
the handling of reprobe if error occurs during reconfig
moves there, which necessitates adding a method there that
notifies the transport that the recovery was completed.

Actually introducing the model under which deeper resets can
be done will be in future patches.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/dvm/mac80211.c |  11 ++
 drivers/net/wireless/intel/iwlwifi/dvm/main.c |  27 +++-
 .../net/wireless/intel/iwlwifi/iwl-op-mode.h  |  53 ++++++-
 .../net/wireless/intel/iwlwifi/iwl-trans.c    | 109 ++++++++++++-
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |  56 ++++++-
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |   1 +
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  | 143 +++++++-----------
 .../wireless/intel/iwlwifi/pcie/trans-gen2.c  |  11 +-
 .../net/wireless/intel/iwlwifi/pcie/tx-gen2.c |   1 +
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c  |   1 +
 10 files changed, 312 insertions(+), 101 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/dvm/mac80211.c
index 74d163e56511..56d19a034c24 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/mac80211.c
@@ -1565,6 +1565,16 @@ static void iwlagn_mac_sta_notify(struct ieee80211_hw *hw,
 	IWL_DEBUG_MAC80211(priv, "leave\n");
 }
 
+static void
+iwlagn_mac_reconfig_complete(struct ieee80211_hw *hw,
+			     enum ieee80211_reconfig_type reconfig_type)
+{
+	struct iwl_priv *priv = IWL_MAC80211_GET_DVM(hw);
+
+	if (reconfig_type == IEEE80211_RECONFIG_TYPE_RESTART)
+		iwl_trans_finish_sw_reset(priv->trans);
+}
+
 const struct ieee80211_ops iwlagn_hw_ops = {
 	.add_chanctx = ieee80211_emulate_add_chanctx,
 	.remove_chanctx = ieee80211_emulate_remove_chanctx,
@@ -1598,6 +1608,7 @@ const struct ieee80211_ops iwlagn_hw_ops = {
 	.tx_last_beacon = iwlagn_mac_tx_last_beacon,
 	.event_callback = iwlagn_mac_event_callback,
 	.set_tim = iwlagn_mac_set_tim,
+	.reconfig_complete = iwlagn_mac_reconfig_complete,
 };
 
 /* This function both allocates and initializes hw and priv. */
diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/main.c b/drivers/net/wireless/intel/iwlwifi/dvm/main.c
index 797b7c360acf..30789ba06d9d 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/main.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/main.c
@@ -1905,17 +1905,9 @@ static void iwlagn_fw_error(struct iwl_priv *priv, bool ondemand)
 	unsigned int reload_msec;
 	unsigned long reload_jiffies;
 
-	if (iwl_have_debug_level(IWL_DL_FW))
-		iwl_print_rx_config_cmd(priv, IWL_RXON_CTX_BSS);
-
 	/* uCode is no longer loaded. */
 	priv->ucode_loaded = false;
 
-	/* Set the FW error flag -- cleared on iwl_down */
-	set_bit(STATUS_FW_ERROR, &priv->status);
-
-	iwl_abort_notification_waits(&priv->notif_wait);
-
 	/* Keep the restart process from trying to send host
 	 * commands by clearing the ready bit */
 	clear_bit(STATUS_READY, &priv->status);
@@ -1957,6 +1949,11 @@ static void iwl_nic_error(struct iwl_op_mode *op_mode,
 {
 	struct iwl_priv *priv = IWL_OP_MODE_GET_DVM(op_mode);
 
+	/* Set the FW error flag -- cleared on iwl_down */
+	set_bit(STATUS_FW_ERROR, &priv->status);
+
+	iwl_abort_notification_waits(&priv->notif_wait);
+
 	if (type == IWL_ERR_TYPE_CMD_QUEUE_FULL && iwl_check_for_ct_kill(priv))
 		return;
 
@@ -1970,7 +1967,20 @@ static void iwl_nic_error(struct iwl_op_mode *op_mode,
 		iwl_dump_nic_event_log(priv, false, NULL);
 	}
 
+	if (iwl_have_debug_level(IWL_DL_FW))
+		iwl_print_rx_config_cmd(priv, IWL_RXON_CTX_BSS);
+}
+
+static bool iwlagn_sw_reset(struct iwl_op_mode *op_mode,
+			    enum iwl_fw_error_type type)
+{
+	struct iwl_priv *priv = IWL_OP_MODE_GET_DVM(op_mode);
+
+	if (type == IWL_ERR_TYPE_CMD_QUEUE_FULL && iwl_check_for_ct_kill(priv))
+		return false;
+
 	iwlagn_fw_error(priv, false);
+	return true;
 }
 
 #define EEPROM_RF_CONFIG_TYPE_MAX      0x3
@@ -2125,6 +2135,7 @@ static const struct iwl_op_mode_ops iwl_dvm_ops = {
 	.hw_rf_kill = iwl_set_hw_rfkill_state,
 	.free_skb = iwl_free_skb,
 	.nic_error = iwl_nic_error,
+	.sw_reset = iwlagn_sw_reset,
 	.nic_config = iwl_nic_config,
 	.wimax_active = iwl_wimax_active,
 };
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-op-mode.h b/drivers/net/wireless/intel/iwlwifi/iwl-op-mode.h
index 3b4085d3aad2..34eca1a568ea 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-op-mode.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-op-mode.h
@@ -60,6 +60,39 @@ enum iwl_fw_error_type {
 	IWL_ERR_TYPE_CMD_QUEUE_FULL,
 };
 
+/**
+ * enum iwl_fw_error_context - error dump context
+ * @IWL_ERR_CONTEXT_WORKER: regular from worker context,
+ *	opmode must acquire locks and must also check
+ *	for @IWL_ERR_CONTEXT_ABORT after acquiring locks
+ * @IWL_ERR_CONTEXT_FROM_OPMODE: context is in a call
+ *	originating from the opmode, e.g. while resetting
+ *	or stopping the device, so opmode must not acquire
+ *	any locks
+ * @IWL_ERR_CONTEXT_ABORT: after lock acquisition, indicates
+ *	that the dump already happened via another callback
+ *	(currently only while stopping the device) via the
+ *	@IWL_ERR_CONTEXT_FROM_OPMODE context, and this call
+ *	must be aborted
+ */
+enum iwl_fw_error_context {
+	IWL_ERR_CONTEXT_WORKER,
+	IWL_ERR_CONTEXT_FROM_OPMODE,
+	IWL_ERR_CONTEXT_ABORT,
+};
+
+/**
+ * struct iwl_fw_error_dump_mode - error dump mode for callback
+ * @type: The reason for the dump, per &enum iwl_fw_error_type.
+ * @context: The context for the dump, may also indicate this
+ *	call needs to be skipped. This MUST be checked before
+ *	and after acquiring any locks in the op-mode!
+ */
+struct iwl_fw_error_dump_mode {
+	enum iwl_fw_error_type type;
+	enum iwl_fw_error_context context;
+};
+
 /**
  * struct iwl_op_mode_ops - op_mode specific operations
  *
@@ -93,8 +126,11 @@ enum iwl_fw_error_type {
  *	reclaimed by the op_mode. This can happen when the driver is freed and
  *	there are Tx packets pending in the transport layer.
  *	Must be atomic
- * @nic_error: error notification. Must be atomic and must be called with BH
- *	disabled, unless the type is IWL_ERR_TYPE_RESET_HS_TIMEOUT
+ * @nic_error: error notification. Must be atomic, the op mode should handle
+ *	the error (e.g. abort notification waiters) and print the error if
+ *	applicable
+ * @dump_error: NIC error dump collection (can sleep, synchronous)
+ * @sw_reset: (maybe) initiate a software reset, return %true if started
  * @nic_config: configure NIC, called before firmware is started.
  *	May sleep
  * @wimax_active: invoked when WiMax becomes active. May sleep
@@ -120,6 +156,10 @@ struct iwl_op_mode_ops {
 	void (*free_skb)(struct iwl_op_mode *op_mode, struct sk_buff *skb);
 	void (*nic_error)(struct iwl_op_mode *op_mode,
 			  enum iwl_fw_error_type type);
+	void (*dump_error)(struct iwl_op_mode *op_mode,
+			   struct iwl_fw_error_dump_mode *mode);
+	bool (*sw_reset)(struct iwl_op_mode *op_mode,
+			 enum iwl_fw_error_type type);
 	void (*nic_config)(struct iwl_op_mode *op_mode);
 	void (*wimax_active)(struct iwl_op_mode *op_mode);
 	void (*time_point)(struct iwl_op_mode *op_mode,
@@ -197,6 +237,15 @@ static inline void iwl_op_mode_nic_error(struct iwl_op_mode *op_mode,
 	op_mode->ops->nic_error(op_mode, type);
 }
 
+static inline void iwl_op_mode_dump_error(struct iwl_op_mode *op_mode,
+					  struct iwl_fw_error_dump_mode *mode)
+{
+	might_sleep();
+
+	if (op_mode->ops->dump_error)
+		op_mode->ops->dump_error(op_mode, mode);
+}
+
 static inline void iwl_op_mode_nic_config(struct iwl_op_mode *op_mode)
 {
 	might_sleep();
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.c b/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
index 3c9d91496c82..a941a525dd7d 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
@@ -16,13 +16,87 @@
 #include "pcie/internal.h"
 #include "iwl-context-info-gen3.h"
 
+struct iwl_trans_reprobe {
+	struct device *dev;
+	struct work_struct work;
+};
+
+static void iwl_trans_reprobe_wk(struct work_struct *wk)
+{
+	struct iwl_trans_reprobe *reprobe;
+
+	reprobe = container_of(wk, typeof(*reprobe), work);
+
+	if (device_reprobe(reprobe->dev))
+		dev_err(reprobe->dev, "reprobe failed!\n");
+	put_device(reprobe->dev);
+	kfree(reprobe);
+	module_put(THIS_MODULE);
+}
+
+static void iwl_trans_restart_wk(struct work_struct *wk)
+{
+	struct iwl_trans *trans = container_of(wk, typeof(*trans), restart.wk);
+	struct iwl_trans_reprobe *reprobe;
+
+	if (!trans->op_mode)
+		return;
+
+	/* might have been scheduled before marked as dead, re-check */
+	if (test_bit(STATUS_TRANS_DEAD, &trans->status))
+		return;
+
+	iwl_op_mode_dump_error(trans->op_mode, &trans->restart.mode);
+
+	/*
+	 * If the opmode stopped the device while we were trying to dump and
+	 * reset, then we'll have done the dump already (synchronized by the
+	 * opmode lock that it will acquire in iwl_op_mode_dump_error()) and
+	 * managed that via trans->restart.mode.
+	 * Additionally, make sure that in such a case we won't attempt to do
+	 * any resets now, since it's no longer requested.
+	 */
+	if (!test_and_clear_bit(STATUS_RESET_PENDING, &trans->status))
+		return;
+
+	if (!iwlwifi_mod_params.fw_restart)
+		return;
+
+	if (!trans->restart.during_reset) {
+		iwl_trans_opmode_sw_reset(trans, trans->restart.mode.type);
+		return;
+	}
+
+	IWL_ERR(trans,
+		"Device error during reconfiguration - reprobe!\n");
+
+	/*
+	 * get a module reference to avoid doing this while unloading
+	 * anyway and to avoid scheduling a work with code that's
+	 * being removed.
+	 */
+	if (!try_module_get(THIS_MODULE)) {
+		IWL_ERR(trans, "Module is being unloaded - abort\n");
+		return;
+	}
+
+	reprobe = kzalloc(sizeof(*reprobe), GFP_KERNEL);
+	if (!reprobe) {
+		module_put(THIS_MODULE);
+		return;
+	}
+	reprobe->dev = get_device(trans->dev);
+	INIT_WORK(&reprobe->work, iwl_trans_reprobe_wk);
+	schedule_work(&reprobe->work);
+}
+
 struct iwl_trans *iwl_trans_alloc(unsigned int priv_size,
 				  struct device *dev,
 				  const struct iwl_cfg_trans_params *cfg_trans)
 {
 	struct iwl_trans *trans;
 #ifdef CONFIG_LOCKDEP
-	static struct lock_class_key __key;
+	static struct lock_class_key __sync_cmd_key;
 #endif
 
 	trans = devm_kzalloc(dev, sizeof(*trans) + priv_size, GFP_KERNEL);
@@ -33,12 +107,14 @@ struct iwl_trans *iwl_trans_alloc(unsigned int priv_size,
 
 #ifdef CONFIG_LOCKDEP
 	lockdep_init_map(&trans->sync_cmd_lockdep_map, "sync_cmd_lockdep_map",
-			 &__key, 0);
+			 &__sync_cmd_key, 0);
 #endif
 
 	trans->dev = dev;
 	trans->num_rx_queues = 1;
 
+	INIT_WORK(&trans->restart.wk, iwl_trans_restart_wk);
+
 	return trans;
 }
 
@@ -81,6 +157,7 @@ int iwl_trans_init(struct iwl_trans *trans)
 
 void iwl_trans_free(struct iwl_trans *trans)
 {
+	cancel_work_sync(&trans->restart.wk);
 	kmem_cache_destroy(trans->dev_cmd_pool);
 }
 
@@ -391,6 +468,34 @@ void iwl_trans_stop_device(struct iwl_trans *trans)
 {
 	might_sleep();
 
+	/*
+	 * See also the comment in iwl_trans_restart_wk().
+	 *
+	 * When the opmode stops the device while a reset is pending, the
+	 * worker (iwl_trans_restart_wk) might not have run yet or, more
+	 * likely, will be blocked on the opmode lock. Due to the locking,
+	 * we can't just flush the worker.
+	 *
+	 * If this is the case, then the test_and_clear_bit() ensures that
+	 * the worker won't attempt to do anything after the stop.
+	 *
+	 * The trans->restart.mode is a handshake with the opmode, we set
+	 * the context there to ABORT so that when the worker can finally
+	 * acquire the lock in the opmode, the code there won't attempt to
+	 * do any dumps. Since we'd really like to have the dump though,
+	 * also do it inline here (with the opmode locks already held),
+	 * but use a separate mode struct to avoid races.
+	 */
+	if (test_and_clear_bit(STATUS_RESET_PENDING, &trans->status)) {
+		struct iwl_fw_error_dump_mode mode;
+
+		mode = trans->restart.mode;
+		mode.context = IWL_ERR_CONTEXT_FROM_OPMODE;
+		trans->restart.mode.context = IWL_ERR_CONTEXT_ABORT;
+
+		iwl_op_mode_dump_error(trans->op_mode, &mode);
+	}
+
 	if (trans->trans_cfg->gen2)
 		iwl_trans_pcie_gen2_stop_device(trans);
 	else
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index 22c0864b5704..0a9881c3291e 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -300,6 +300,10 @@ enum iwl_d3_status {
  * @STATUS_TRANS_DEAD: trans is dead - avoid any read/write operation
  * @STATUS_SUPPRESS_CMD_ERROR_ONCE: suppress "FW error in SYNC CMD" once,
  *	e.g. for testing
+ * @STATUS_IN_SW_RESET: device is undergoing reset, cleared by opmode
+ *	via iwl_trans_finish_sw_reset()
+ * @STATUS_RESET_PENDING: reset worker was scheduled, but didn't dump
+ *	the firmware state yet
  */
 enum iwl_trans_status {
 	STATUS_SYNC_HCMD_ACTIVE,
@@ -311,6 +315,8 @@ enum iwl_trans_status {
 	STATUS_FW_ERROR,
 	STATUS_TRANS_DEAD,
 	STATUS_SUPPRESS_CMD_ERROR_ONCE,
+	STATUS_IN_SW_RESET,
+	STATUS_RESET_PENDING,
 };
 
 static inline int
@@ -322,7 +328,6 @@ iwl_trans_get_rb_size_order(enum iwl_amsdu_size rb_size)
 	case IWL_AMSDU_4K:
 		return get_order(4 * 1024);
 	case IWL_AMSDU_8K:
-		return get_order(8 * 1024);
 	case IWL_AMSDU_12K:
 		return get_order(16 * 1024);
 	default:
@@ -877,6 +882,10 @@ struct iwl_txq {
  * @reduced_cap_sku: reduced capability supported SKU
  * @no_160: device not supporting 160 MHz
  * @step_urm: STEP is in URM, no support for MCS>9 in 320 MHz
+ * @restart: restart worker data
+ * @restart.wk: restart worker
+ * @restart.mode: reset/restart error mode information
+ * @restart.during_reset: error occurred during previous software reset
  * @trans_specific: data for the specific transport this is allocated for/with
  * @dsbr_urm_fw_dependent: switch to URM based on fw settings
  * @dsbr_urm_permanent: switch to URM permanently
@@ -949,6 +958,12 @@ struct iwl_trans {
 
 	struct iwl_dma_ptr invalid_tx_cmd;
 
+	struct {
+		struct work_struct wk;
+		struct iwl_fw_error_dump_mode mode;
+		bool during_reset;
+	} restart;
+
 	/* pointer to trans specific struct */
 	/*Ensure that this pointer will always be aligned to sizeof pointer */
 	char trans_specific[] __aligned(sizeof(void *));
@@ -1125,6 +1140,26 @@ bool _iwl_trans_grab_nic_access(struct iwl_trans *trans);
 void __releases(nic_access)
 iwl_trans_release_nic_access(struct iwl_trans *trans);
 
+static inline void iwl_trans_schedule_reset(struct iwl_trans *trans,
+					    enum iwl_fw_error_type type)
+{
+	if (test_bit(STATUS_TRANS_DEAD, &trans->status))
+		return;
+
+	trans->restart.mode.type = type;
+	trans->restart.mode.context = IWL_ERR_CONTEXT_WORKER;
+
+	set_bit(STATUS_RESET_PENDING, &trans->status);
+
+	/*
+	 * keep track of whether or not this happened while resetting,
+	 * by the timer the worker runs it might have finished
+	 */
+	trans->restart.during_reset = test_bit(STATUS_IN_SW_RESET,
+					       &trans->status);
+	queue_work(system_unbound_wq, &trans->restart.wk);
+}
+
 static inline void iwl_trans_fw_error(struct iwl_trans *trans,
 				      enum iwl_fw_error_type type)
 {
@@ -1135,9 +1170,23 @@ static inline void iwl_trans_fw_error(struct iwl_trans *trans,
 	if (!test_and_set_bit(STATUS_FW_ERROR, &trans->status)) {
 		trans->state = IWL_TRANS_NO_FW;
 		iwl_op_mode_nic_error(trans->op_mode, type);
+		iwl_trans_schedule_reset(trans, type);
 	}
 }
 
+static inline void iwl_trans_opmode_sw_reset(struct iwl_trans *trans,
+					     enum iwl_fw_error_type type)
+{
+	if (WARN_ON_ONCE(!trans->op_mode))
+		return;
+
+	set_bit(STATUS_IN_SW_RESET, &trans->status);
+
+	if (!trans->op_mode->ops->sw_reset ||
+	    !trans->op_mode->ops->sw_reset(trans->op_mode, type))
+		clear_bit(STATUS_IN_SW_RESET, &trans->status);
+}
+
 static inline bool iwl_trans_fw_running(struct iwl_trans *trans)
 {
 	return trans->state == IWL_TRANS_FW_ALIVE;
@@ -1170,6 +1219,11 @@ static inline bool iwl_trans_dbg_ini_valid(struct iwl_trans *trans)
 
 void iwl_trans_interrupts(struct iwl_trans *trans, bool enable);
 
+static inline void iwl_trans_finish_sw_reset(struct iwl_trans *trans)
+{
+	clear_bit(STATUS_IN_SW_RESET, &trans->status);
+}
+
 /*****************************************************
  * transport helper functions
  *****************************************************/
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 039d0d6ed61d..a88ca5b48eca 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -1340,6 +1340,7 @@ static void iwl_mvm_restart_complete(struct iwl_mvm *mvm)
 	iwl_mvm_teardown_tdls_peers(mvm);
 
 	IWL_INFO(mvm, "restart completed\n");
+	iwl_trans_finish_sw_reset(mvm->trans);
 }
 
 void iwl_mvm_mac_reconfig_complete(struct ieee80211_hw *hw,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index ef54ba818d1f..08c59df593b2 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -2008,27 +2008,62 @@ static void iwl_mvm_free_skb(struct iwl_op_mode *op_mode, struct sk_buff *skb)
 	ieee80211_free_txskb(mvm->hw, skb);
 }
 
-struct iwl_mvm_reprobe {
-	struct device *dev;
-	struct work_struct work;
-};
+static void iwl_mvm_nic_error(struct iwl_op_mode *op_mode,
+			      enum iwl_fw_error_type type)
+{
+	struct iwl_mvm *mvm = IWL_OP_MODE_GET_MVM(op_mode);
+
+	iwl_abort_notification_waits(&mvm->notif_wait);
+	iwl_dbg_tlv_del_timers(mvm->trans);
+
+	if (type == IWL_ERR_TYPE_CMD_QUEUE_FULL)
+		IWL_ERR(mvm, "Command queue full!\n");
+	else if (!test_bit(STATUS_TRANS_DEAD, &mvm->trans->status) &&
+		 !test_and_clear_bit(IWL_MVM_STATUS_SUPPRESS_ERROR_LOG_ONCE,
+				     &mvm->status))
+		iwl_mvm_dump_nic_error_log(mvm);
+
+	/*
+	 * This should be first thing before trying to collect any
+	 * data to avoid endless loops if any HW error happens while
+	 * collecting debug data.
+	 * It might not actually be true that we'll restart, but the
+	 * setting of the bit doesn't matter if we're going to be
+	 * unbound either.
+	 */
+	if (type != IWL_ERR_TYPE_RESET_HS_TIMEOUT)
+		set_bit(IWL_MVM_STATUS_HW_RESTART_REQUESTED, &mvm->status);
+}
 
-static void iwl_mvm_reprobe_wk(struct work_struct *wk)
+static void iwl_mvm_dump_error(struct iwl_op_mode *op_mode,
+			       struct iwl_fw_error_dump_mode *mode)
 {
-	struct iwl_mvm_reprobe *reprobe;
-
-	reprobe = container_of(wk, struct iwl_mvm_reprobe, work);
-	if (device_reprobe(reprobe->dev))
-		dev_err(reprobe->dev, "reprobe failed!\n");
-	put_device(reprobe->dev);
-	kfree(reprobe);
-	module_put(THIS_MODULE);
+	struct iwl_mvm *mvm = IWL_OP_MODE_GET_MVM(op_mode);
+
+	/* if we come in from opmode we have the mutex held */
+	if (mode->context == IWL_ERR_CONTEXT_FROM_OPMODE) {
+		lockdep_assert_held(&mvm->mutex);
+		iwl_fw_error_collect(&mvm->fwrt, true);
+	} else {
+		mutex_lock(&mvm->mutex);
+		if (mode->context != IWL_ERR_CONTEXT_ABORT)
+			iwl_fw_error_collect(&mvm->fwrt, true);
+		mutex_unlock(&mvm->mutex);
+	}
 }
 
-static void iwl_mvm_nic_restart(struct iwl_mvm *mvm)
+static bool iwl_mvm_sw_reset(struct iwl_op_mode *op_mode,
+			     enum iwl_fw_error_type type)
 {
-	iwl_abort_notification_waits(&mvm->notif_wait);
-	iwl_dbg_tlv_del_timers(mvm->trans);
+	struct iwl_mvm *mvm = IWL_OP_MODE_GET_MVM(op_mode);
+
+	/*
+	 * If the firmware crashes while we're already considering it
+	 * to be dead then don't ask for a restart, that cannot do
+	 * anything useful anyway.
+	 */
+	if (!test_bit(IWL_MVM_STATUS_FIRMWARE_RUNNING, &mvm->status))
+		return false;
 
 	/*
 	 * This is a bit racy, but worst case we tell mac80211 about
@@ -2043,47 +2078,11 @@ static void iwl_mvm_nic_restart(struct iwl_mvm *mvm)
 	iwl_mvm_report_scan_aborted(mvm);
 
 	/*
-	 * If we're restarting already, don't cycle restarts.
 	 * If INIT fw asserted, it will likely fail again.
 	 * If WoWLAN fw asserted, don't restart either, mac80211
 	 * can't recover this since we're already half suspended.
 	 */
-	if (test_bit(IWL_MVM_STATUS_IN_HW_RESTART, &mvm->status)) {
-		struct iwl_mvm_reprobe *reprobe;
-
-		IWL_ERR(mvm,
-			"Firmware error during reconfiguration - reprobe!\n");
-
-		/*
-		 * get a module reference to avoid doing this while unloading
-		 * anyway and to avoid scheduling a work with code that's
-		 * being removed.
-		 */
-		if (!try_module_get(THIS_MODULE)) {
-			IWL_ERR(mvm, "Module is being unloaded - abort\n");
-			return;
-		}
-
-		reprobe = kzalloc(sizeof(*reprobe), GFP_ATOMIC);
-		if (!reprobe) {
-			module_put(THIS_MODULE);
-			return;
-		}
-		reprobe->dev = get_device(mvm->trans->dev);
-		INIT_WORK(&reprobe->work, iwl_mvm_reprobe_wk);
-		schedule_work(&reprobe->work);
-	} else if (test_bit(IWL_MVM_STATUS_HW_RESTART_REQUESTED,
-			    &mvm->status)) {
-		IWL_ERR(mvm, "HW restart already requested, but not started\n");
-	} else if (mvm->fwrt.cur_fw_img == IWL_UCODE_REGULAR &&
-		   mvm->hw_registered &&
-		   !test_bit(STATUS_TRANS_DEAD, &mvm->trans->status)) {
-		/* This should be first thing before trying to collect any
-		 * data to avoid endless loops if any HW error happens while
-		 * collecting debug data.
-		 */
-		set_bit(IWL_MVM_STATUS_HW_RESTART_REQUESTED, &mvm->status);
-
+	if (mvm->fwrt.cur_fw_img == IWL_UCODE_REGULAR && mvm->hw_registered) {
 		if (mvm->fw->ucode_capa.error_log_size) {
 			u32 src_size = mvm->fw->ucode_capa.error_log_size;
 			u32 src_addr = mvm->fw->ucode_capa.error_log_addr;
@@ -2098,48 +2097,18 @@ static void iwl_mvm_nic_restart(struct iwl_mvm *mvm)
 			}
 		}
 
-		iwl_fw_error_collect(&mvm->fwrt, false);
-
-		if (!iwlwifi_mod_params.fw_restart)
-			return;
-
 		if (mvm->fwrt.trans->dbg.restart_required) {
 			IWL_DEBUG_INFO(mvm, "FW restart requested after debug collection\n");
 			mvm->fwrt.trans->dbg.restart_required = false;
 			ieee80211_restart_hw(mvm->hw);
+			return true;
 		} else if (mvm->trans->trans_cfg->device_family <= IWL_DEVICE_FAMILY_8000) {
 			ieee80211_restart_hw(mvm->hw);
+			return true;
 		}
 	}
-}
-
-static void iwl_mvm_nic_error(struct iwl_op_mode *op_mode,
-			      enum iwl_fw_error_type type)
-{
-	struct iwl_mvm *mvm = IWL_OP_MODE_GET_MVM(op_mode);
-
-	if (type == IWL_ERR_TYPE_CMD_QUEUE_FULL)
-		IWL_ERR(mvm, "Command queue full!\n");
-	else if (!test_bit(STATUS_TRANS_DEAD, &mvm->trans->status) &&
-		 !test_and_clear_bit(IWL_MVM_STATUS_SUPPRESS_ERROR_LOG_ONCE,
-				     &mvm->status))
-		iwl_mvm_dump_nic_error_log(mvm);
-
-	/* reset HS timeout is during shutdown, so collect right now */
-	if (type == IWL_ERR_TYPE_RESET_HS_TIMEOUT) {
-		iwl_fw_error_collect(&mvm->fwrt, true);
-		return;
-	}
-
-	/*
-	 * If the firmware crashes while we're already considering it
-	 * to be dead then don't ask for a restart, that cannot do
-	 * anything useful anyway.
-	 */
-	if (!test_bit(IWL_MVM_STATUS_FIRMWARE_RUNNING, &mvm->status))
-		return;
 
-	iwl_mvm_nic_restart(mvm);
+	return false;
 }
 
 static void iwl_op_mode_mvm_time_point(struct iwl_op_mode *op_mode,
@@ -2175,6 +2144,8 @@ static void iwl_op_mode_mvm_device_powered_off(struct iwl_op_mode *op_mode)
 	.hw_rf_kill = iwl_mvm_set_hw_rfkill_state,		\
 	.free_skb = iwl_mvm_free_skb,				\
 	.nic_error = iwl_mvm_nic_error,				\
+	.dump_error = iwl_mvm_dump_error,			\
+	.sw_reset = iwl_mvm_sw_reset,				\
 	.nic_config = iwl_mvm_nic_config,			\
 	/* as we only register one, these MUST be common! */	\
 	.start = iwl_op_mode_mvm_start,				\
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
index 469ef32a3e26..5f6cd60b50b9 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
@@ -123,8 +123,15 @@ static void iwl_trans_pcie_fw_reset_handshake(struct iwl_trans *trans)
 			"timeout waiting for FW reset ACK (inta_hw=0x%x)\n",
 			inta_hw);
 
-		if (!(inta_hw & MSIX_HW_INT_CAUSES_REG_RESET_DONE))
-			iwl_trans_fw_error(trans, IWL_ERR_TYPE_RESET_HS_TIMEOUT);
+		if (!(inta_hw & MSIX_HW_INT_CAUSES_REG_RESET_DONE)) {
+			struct iwl_fw_error_dump_mode mode = {
+				.type = IWL_ERR_TYPE_RESET_HS_TIMEOUT,
+				.context = IWL_ERR_CONTEXT_FROM_OPMODE,
+			};
+			iwl_op_mode_nic_error(trans->op_mode,
+					      IWL_ERR_TYPE_RESET_HS_TIMEOUT);
+			iwl_op_mode_dump_error(trans->op_mode, &mode);
+		}
 	}
 
 	trans_pcie->fw_reset_state = FW_RESET_IDLE;
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c b/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
index 4c92588d15cb..1f483f15c238 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
@@ -1300,6 +1300,7 @@ int iwl_pcie_gen2_enqueue_hcmd(struct iwl_trans *trans,
 		IWL_ERR(trans, "No space in command queue\n");
 		iwl_op_mode_nic_error(trans->op_mode,
 				      IWL_ERR_TYPE_CMD_QUEUE_FULL);
+		iwl_trans_schedule_reset(trans, IWL_ERR_TYPE_CMD_QUEUE_FULL);
 		idx = -ENOSPC;
 		goto free_dup_buf;
 	}
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
index aaa1b87ee265..334ebd4c12fa 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
@@ -1451,6 +1451,7 @@ int iwl_pcie_enqueue_hcmd(struct iwl_trans *trans,
 		IWL_ERR(trans, "No space in command queue\n");
 		iwl_op_mode_nic_error(trans->op_mode,
 				      IWL_ERR_TYPE_CMD_QUEUE_FULL);
+		iwl_trans_schedule_reset(trans, IWL_ERR_TYPE_CMD_QUEUE_FULL);
 		idx = -ENOSPC;
 		goto free_dup_buf;
 	}
-- 
2.34.1


