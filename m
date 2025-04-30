Return-Path: <linux-wireless+bounces-22267-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF4B0AA4C6B
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Apr 2025 15:02:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D6201B614EE
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Apr 2025 12:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F5CE25A2B0;
	Wed, 30 Apr 2025 12:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h/eZElJX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02CCB25D8EB
	for <linux-wireless@vger.kernel.org>; Wed, 30 Apr 2025 12:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746017874; cv=none; b=gN8CiNYl8jZ2LxtQ1uQl+FjuIT9kDFTiu60wR0CS8xl+rRBLTT8yEaJqTwVoh6WUVDSs2fI1YB1rQuN4j+ZoQyB6VQjGtWOpCSWPfs3YfaqBYIMmTRH190slkJYRL5hzIl84II9pOQD0RQuPxJuzqKE8PIco8z1Ui8lPsp9f9U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746017874; c=relaxed/simple;
	bh=SUKspII+5BY+gsO/dgJYv6tis30kP33RHBSjEeauhBM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nQbEnusNhyivsW3SqRHFxNFWN/Ywm07x1cZBrXDuFVEsylpen+hJb3R/B39WNHV1TCQEjWz5zvVKO+OXjXlT8+2s9XYDXShd7MY1XVQzY3wt8uH0tLB80m5yRY8zNe43WliPWQRqoJbo72Mxj7TaaUXdZy6HpUuDV9FwEDlik4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h/eZElJX; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746017872; x=1777553872;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SUKspII+5BY+gsO/dgJYv6tis30kP33RHBSjEeauhBM=;
  b=h/eZElJXZDGxhpWo6lCyNDHT7L1aaxuoe+vsUp2VUbD2j4av41XUwZZf
   rvPBDpRaMNkmVG7hh1UT1s6yHNa+kC9hY2tgfw+syWJGEs0S1/+vO7XZJ
   ftXxj/tMZPQ+U02yAtZMlXVx+OIrIWw1MoEdBx2PJKJLjTR75Paw9EUGF
   +EebVjycTQNJgaucgrRuWfiRti0obaQ4u0jndN4KZmT36cqiR+F8/PLQ2
   y3q8S3haAuNrQhxb9asUExJp+QmYDKhdOuGg+zGRXTTY3r3I6iUV1wKZM
   fXuJK0rsp81rHjK7SVWq+QmJzfWOhILeUKhgMMH3I/a+/SMD18Ui6gZpY
   Q==;
X-CSE-ConnectionGUID: A+D/oPIrRoC+rcEIto/KjQ==
X-CSE-MsgGUID: svoxulUzQE2CGAfdSzdwQw==
X-IronPort-AV: E=McAfee;i="6700,10204,11419"; a="58332337"
X-IronPort-AV: E=Sophos;i="6.15,251,1739865600"; 
   d="scan'208";a="58332337"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 05:57:52 -0700
X-CSE-ConnectionGUID: xrof3OkGSTimvBkKlgndbQ==
X-CSE-MsgGUID: 9LLm1/WRQsqM1OOU9LM/kg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,251,1739865600"; 
   d="scan'208";a="134632103"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 05:57:50 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: miriam.rachel.korenblit@intel.com
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 06/15] wifi: iwlwifi: implement TOP reset
Date: Wed, 30 Apr 2025 15:57:20 +0300
Message-Id: <20250430155443.12f38024a3b4.I9c22f6c4f6de64f3b34ccd898370ec1859ab7dbf@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250430125729.1122751-1-miriam.rachel.korenblit@intel.com>
References: <20250430125729.1122751-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Implement TOP reset (new in the SC family), which resets much
of the (shared) hardware without resetting the bus interfaces.
Use it to recover from TOP fatal error, or if manually used;
we'll need to add using it for FSEQ updates later.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../intel/iwlwifi/iwl-context-info-gen3.h     |  7 +-
 .../net/wireless/intel/iwlwifi/iwl-op-mode.h  |  6 ++
 .../net/wireless/intel/iwlwifi/iwl-trans.c    | 47 ++++++++++++--
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |  9 +++
 .../intel/iwlwifi/pcie/ctxt-info-gen3.c       | 38 +++++++----
 .../wireless/intel/iwlwifi/pcie/ctxt-info.c   |  2 +-
 .../wireless/intel/iwlwifi/pcie/internal.h    | 22 +++++--
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c  | 12 ++--
 .../wireless/intel/iwlwifi/pcie/trans-gen2.c  | 65 ++++++++++++++++---
 .../net/wireless/intel/iwlwifi/pcie/trans.c   | 19 ++++--
 10 files changed, 182 insertions(+), 45 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-context-info-gen3.h b/drivers/net/wireless/intel/iwlwifi/iwl-context-info-gen3.h
index 6111ca970ed2..b028343672cc 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-context-info-gen3.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-context-info-gen3.h
@@ -58,6 +58,7 @@ enum iwl_prph_scratch_mtr_format {
  * @IWL_PRPH_SCRATCH_RB_SIZE_EXT_16K: 16kB RB size
  * @IWL_PRPH_SCRATCH_SCU_FORCE_ACTIVE: Indicate fw to set SCU_FORCE_ACTIVE
  *	upon reset.
+ * @IWL_PRPH_SCRATCH_TOP_RESET: request TOP reset
  */
 enum iwl_prph_scratch_flags {
 	IWL_PRPH_SCRATCH_IMR_DEBUG_EN		= BIT(1),
@@ -74,6 +75,7 @@ enum iwl_prph_scratch_flags {
 	IWL_PRPH_SCRATCH_RB_SIZE_EXT_12K	= 9 << 20,
 	IWL_PRPH_SCRATCH_RB_SIZE_EXT_16K	= 10 << 20,
 	IWL_PRPH_SCRATCH_SCU_FORCE_ACTIVE	= BIT(29),
+	IWL_PRPH_SCRATCH_TOP_RESET		= BIT(30),
 };
 
 /**
@@ -321,8 +323,9 @@ struct iwl_context_info_gen3 {
 	__le32 reserved;
 } __packed; /* IPC_CONTEXT_INFO_S */
 
-int iwl_pcie_ctxt_info_gen3_init(struct iwl_trans *trans,
-				 const struct fw_img *fw);
+int iwl_pcie_ctxt_info_gen3_alloc(struct iwl_trans *trans,
+				  const struct fw_img *fw);
+void iwl_pcie_ctxt_info_gen3_kick(struct iwl_trans *trans);
 void iwl_pcie_ctxt_info_gen3_free(struct iwl_trans *trans, bool alive);
 
 int iwl_trans_pcie_ctx_info_gen3_load_pnvm(struct iwl_trans *trans,
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-op-mode.h b/drivers/net/wireless/intel/iwlwifi/iwl-op-mode.h
index 6bccb30c0981..b5d39026fa2f 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-op-mode.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-op-mode.h
@@ -53,6 +53,9 @@ struct iwl_cfg;
  *	the device will be shut down
  * @IWL_ERR_TYPE_CMD_QUEUE_FULL: command queue was full
  * @IWL_ERR_TYPE_TOP_RESET_BY_BT: TOP reset initiated by BT
+ * @IWL_ERR_TYPE_TOP_FATAL_ERROR: TOP fatal error
+ * @IWL_ERR_TYPE_TOP_RESET_FAILED: TOP reset failed
+ * @IWL_ERR_TYPE_DEBUGFS: error/reset indication from debugfs
  */
 enum iwl_fw_error_type {
 	IWL_ERR_TYPE_IRQ,
@@ -60,6 +63,9 @@ enum iwl_fw_error_type {
 	IWL_ERR_TYPE_RESET_HS_TIMEOUT,
 	IWL_ERR_TYPE_CMD_QUEUE_FULL,
 	IWL_ERR_TYPE_TOP_RESET_BY_BT,
+	IWL_ERR_TYPE_TOP_FATAL_ERROR,
+	IWL_ERR_TYPE_TOP_RESET_FAILED,
+	IWL_ERR_TYPE_DEBUGFS,
 };
 
 /**
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.c b/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
index 22f91e2afebf..bd5e022906af 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
@@ -131,18 +131,46 @@ iwl_trans_determine_restart_mode(struct iwl_trans *trans)
 	struct iwl_trans_dev_restart_data *data;
 	enum iwl_reset_mode at_least = 0;
 	unsigned int index;
-	static const enum iwl_reset_mode escalation_list[] = {
+	static const enum iwl_reset_mode escalation_list_old[] = {
 		IWL_RESET_MODE_SW_RESET,
 		IWL_RESET_MODE_REPROBE,
 		IWL_RESET_MODE_REPROBE,
 		IWL_RESET_MODE_FUNC_RESET,
-		/* FIXME: add TOP reset */
 		IWL_RESET_MODE_PROD_RESET,
-		/* FIXME: add TOP reset */
+	};
+	static const enum iwl_reset_mode escalation_list_sc[] = {
+		IWL_RESET_MODE_SW_RESET,
+		IWL_RESET_MODE_REPROBE,
+		IWL_RESET_MODE_REPROBE,
+		IWL_RESET_MODE_FUNC_RESET,
+		IWL_RESET_MODE_TOP_RESET,
 		IWL_RESET_MODE_PROD_RESET,
-		/* FIXME: add TOP reset */
+		IWL_RESET_MODE_TOP_RESET,
+		IWL_RESET_MODE_PROD_RESET,
+		IWL_RESET_MODE_TOP_RESET,
 		IWL_RESET_MODE_PROD_RESET,
 	};
+	const enum iwl_reset_mode *escalation_list;
+	size_t escalation_list_size;
+
+	/* used by TOP fatal error/TOP reset */
+	if (trans->restart.mode.type == IWL_ERR_TYPE_TOP_RESET_FAILED)
+		return IWL_RESET_MODE_PROD_RESET;
+
+	if (trans->request_top_reset) {
+		trans->request_top_reset = 0;
+		if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_SC)
+			return IWL_RESET_MODE_TOP_RESET;
+		return IWL_RESET_MODE_PROD_RESET;
+	}
+
+	if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_SC) {
+		escalation_list = escalation_list_sc;
+		escalation_list_size = ARRAY_SIZE(escalation_list_sc);
+	} else {
+		escalation_list = escalation_list_old;
+		escalation_list_size = ARRAY_SIZE(escalation_list_old);
+	}
 
 	if (trans->restart.during_reset)
 		at_least = IWL_RESET_MODE_REPROBE;
@@ -157,8 +185,8 @@ iwl_trans_determine_restart_mode(struct iwl_trans *trans)
 		data->restart_count = 0;
 
 	index = data->restart_count;
-	if (index >= ARRAY_SIZE(escalation_list)) {
-		index = ARRAY_SIZE(escalation_list) - 1;
+	if (index >= escalation_list_size) {
+		index = escalation_list_size - 1;
 		if (!data->backoff) {
 			data->backoff = true;
 			return IWL_RESET_MODE_BACKOFF;
@@ -218,8 +246,13 @@ static void iwl_trans_restart_wk(struct work_struct *wk)
 	iwl_trans_inc_restart_count(trans->dev);
 
 	switch (mode) {
+	case IWL_RESET_MODE_TOP_RESET:
+		trans->do_top_reset = 1;
+		IWL_ERR(trans, "Device error - TOP reset\n");
+		fallthrough;
 	case IWL_RESET_MODE_SW_RESET:
-		IWL_ERR(trans, "Device error - SW reset\n");
+		if (mode == IWL_RESET_MODE_SW_RESET)
+			IWL_ERR(trans, "Device error - SW reset\n");
 		iwl_trans_opmode_sw_reset(trans, trans->restart.mode.type);
 		break;
 	case IWL_RESET_MODE_REPROBE:
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index 0a4f69258715..7378a8e74314 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -893,6 +893,10 @@ struct iwl_txq {
  * @dsbr_urm_fw_dependent: switch to URM based on fw settings
  * @dsbr_urm_permanent: switch to URM permanently
  * @ext_32khz_clock_valid: if true, the external 32 KHz clock can be used
+ * @request_top_reset: TOP reset was requested, used by the reset
+ *	worker that should be scheduled (with appropriate reason)
+ * @do_top_reset: indication to the (PCIe) transport/context-info
+ *	to do the TOP reset
  */
 struct iwl_trans {
 	bool csme_own;
@@ -974,6 +978,9 @@ struct iwl_trans {
 	struct delayed_work me_recheck_wk;
 	s8 me_present;
 
+	u8 request_top_reset:1,
+	   do_top_reset:1;
+
 	/* pointer to trans specific struct */
 	/*Ensure that this pointer will always be aligned to sizeof pointer */
 	char trans_specific[] __aligned(sizeof(void *));
@@ -1267,6 +1274,8 @@ enum iwl_reset_mode {
 	/* upper level modes: */
 	IWL_RESET_MODE_SW_RESET,
 	IWL_RESET_MODE_REPROBE,
+	/* TOP reset doesn't require PCIe remove */
+	IWL_RESET_MODE_TOP_RESET,
 	/* PCIE level modes: */
 	IWL_RESET_MODE_REMOVE_ONLY,
 	IWL_RESET_MODE_RESCAN,
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
index 4f367c7fce25..e383757cfbe0 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
@@ -97,8 +97,8 @@ iwl_pcie_ctxt_info_dbg_enable(struct iwl_trans *trans,
 		*control_flags |= IWL_PRPH_SCRATCH_EARLY_DEBUG_EN | dbg_flags;
 }
 
-int iwl_pcie_ctxt_info_gen3_init(struct iwl_trans *trans,
-				 const struct fw_img *fw)
+int iwl_pcie_ctxt_info_gen3_alloc(struct iwl_trans *trans,
+				  const struct fw_img *fw)
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 	struct iwl_context_info_gen3 *ctxt_info_gen3;
@@ -168,6 +168,11 @@ int iwl_pcie_ctxt_info_gen3_init(struct iwl_trans *trans,
 			     IWL_PRPH_SCRATCH_SCU_FORCE_ACTIVE);
 	}
 
+	if (trans->do_top_reset) {
+		WARN_ON(trans->trans_cfg->device_family < IWL_DEVICE_FAMILY_SC);
+		control_flags |= IWL_PRPH_SCRATCH_TOP_RESET;
+	}
+
 	/* initialize RX default queue */
 	prph_sc_ctrl->rbd_cfg.free_rbd_addr =
 		cpu_to_le64(trans_pcie->rxq->bd_dma);
@@ -266,18 +271,6 @@ int iwl_pcie_ctxt_info_gen3_init(struct iwl_trans *trans,
 
 	memcpy(trans_pcie->iml, trans->iml, trans->iml_len);
 
-	iwl_enable_fw_load_int_ctx_info(trans);
-
-	/* kick FW self load */
-	iwl_write64(trans, CSR_CTXT_INFO_ADDR,
-		    trans_pcie->ctxt_info_dma_addr);
-	iwl_write64(trans, CSR_IML_DATA_ADDR,
-		    trans_pcie->iml_dma_addr);
-	iwl_write32(trans, CSR_IML_SIZE_ADDR, trans->iml_len);
-
-	iwl_set_bit(trans, CSR_CTXT_INFO_BOOT_CTRL,
-		    CSR_AUTO_FUNC_BOOT_ENA);
-
 	return 0;
 
 err_free_ctxt_info:
@@ -298,6 +291,23 @@ int iwl_pcie_ctxt_info_gen3_init(struct iwl_trans *trans,
 
 }
 
+void iwl_pcie_ctxt_info_gen3_kick(struct iwl_trans *trans)
+{
+	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
+
+	iwl_enable_fw_load_int_ctx_info(trans, trans->do_top_reset);
+
+	/* kick FW self load */
+	iwl_write64(trans, CSR_CTXT_INFO_ADDR,
+		    trans_pcie->ctxt_info_dma_addr);
+	iwl_write64(trans, CSR_IML_DATA_ADDR,
+		    trans_pcie->iml_dma_addr);
+	iwl_write32(trans, CSR_IML_SIZE_ADDR, trans->iml_len);
+
+	iwl_set_bit(trans, CSR_CTXT_INFO_BOOT_CTRL,
+		    CSR_AUTO_FUNC_BOOT_ENA);
+}
+
 void iwl_pcie_ctxt_info_gen3_free(struct iwl_trans *trans, bool alive)
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info.c b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info.c
index 3f0256b3565d..4e79ca7e47b2 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info.c
@@ -232,7 +232,7 @@ int iwl_pcie_ctxt_info_init(struct iwl_trans *trans,
 
 	trans_pcie->ctxt_info = ctxt_info;
 
-	iwl_enable_fw_load_int_ctx_info(trans);
+	iwl_enable_fw_load_int_ctx_info(trans, false);
 
 	/* Configure debug, if exists */
 	if (iwl_pcie_dbg_on(trans))
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
index 45460f93d24a..390e447b452c 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
@@ -269,6 +269,7 @@ enum iwl_pcie_fw_reset_state {
 	FW_RESET_REQUESTED,
 	FW_RESET_OK,
 	FW_RESET_ERROR,
+	FW_RESET_TOP_REQUESTED,
 };
 
 /**
@@ -940,11 +941,13 @@ static inline void iwl_enable_fw_load_int(struct iwl_trans *trans)
 	}
 }
 
-static inline void iwl_enable_fw_load_int_ctx_info(struct iwl_trans *trans)
+static inline void iwl_enable_fw_load_int_ctx_info(struct iwl_trans *trans,
+						   bool top_reset)
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 
-	IWL_DEBUG_ISR(trans, "Enabling ALIVE interrupt only\n");
+	IWL_DEBUG_ISR(trans, "Enabling %s interrupt only\n",
+		      top_reset ? "RESET" : "ALIVE");
 
 	if (!trans_pcie->msix_enabled) {
 		/*
@@ -954,11 +957,20 @@ static inline void iwl_enable_fw_load_int_ctx_info(struct iwl_trans *trans)
 		 * RX interrupt which will allow us to receive the ALIVE
 		 * notification (which is Rx) and continue the flow.
 		 */
-		trans_pcie->inta_mask =  CSR_INT_BIT_ALIVE | CSR_INT_BIT_FH_RX;
+		if (top_reset)
+			trans_pcie->inta_mask =  CSR_INT_BIT_RESET_DONE;
+		else
+			trans_pcie->inta_mask =  CSR_INT_BIT_ALIVE |
+						 CSR_INT_BIT_FH_RX;
 		iwl_write32(trans, CSR_INT_MASK, trans_pcie->inta_mask);
 	} else {
-		iwl_enable_hw_int_msk_msix(trans,
-					   MSIX_HW_INT_CAUSES_REG_ALIVE);
+		u32 val = top_reset ? MSIX_HW_INT_CAUSES_REG_RESET_DONE
+				    : MSIX_HW_INT_CAUSES_REG_ALIVE;
+
+		iwl_enable_hw_int_msk_msix(trans, val);
+
+		if (top_reset)
+			return;
 		/*
 		 * Leave all the FH causes enabled to get the ALIVE
 		 * notification.
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
index bbeecb621593..b619a77f81f1 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
@@ -2133,7 +2133,7 @@ irqreturn_t iwl_pcie_irq_handler(int irq, void *dev_id)
 			iwl_enable_rfkill_int(trans);
 		/* Re-enable the ALIVE / Rx interrupt if it occurred */
 		else if (handled & (CSR_INT_BIT_ALIVE | CSR_INT_BIT_FH_RX))
-			iwl_enable_fw_load_int_ctx_info(trans);
+			iwl_enable_fw_load_int_ctx_info(trans, false);
 		spin_unlock_bh(&trans_pcie->irq_lock);
 	}
 
@@ -2356,9 +2356,13 @@ irqreturn_t iwl_pcie_irq_msix_handler(int irq, void *dev_id)
 	if (inta_hw & MSIX_HW_INT_CAUSES_REG_TOP_FATAL_ERR) {
 		IWL_ERR(trans, "TOP Fatal error detected, inta_hw=0x%x.\n",
 			inta_hw);
-		if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_BZ)
-			iwl_trans_pcie_reset(trans,
-					     IWL_RESET_MODE_PROD_RESET);
+		if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_BZ) {
+			trans->request_top_reset = 1;
+			iwl_op_mode_nic_error(trans->op_mode,
+					      IWL_ERR_TYPE_TOP_FATAL_ERROR);
+			iwl_trans_schedule_reset(trans,
+						 IWL_ERR_TYPE_TOP_FATAL_ERROR);
+		}
 	}
 
 	/* Error detected by uCode */
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
index 08409e24aed6..abddaffcaaf0 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
@@ -488,12 +488,16 @@ int iwl_trans_pcie_gen2_start_fw(struct iwl_trans *trans,
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 	bool hw_rfkill, keep_ram_busy;
+	bool top_reset_done = false;
 	int ret;
 
+	mutex_lock(&trans_pcie->mutex);
+again:
 	/* This may fail if AMT took ownership of the device */
 	if (iwl_pcie_prepare_card_hw(trans)) {
 		IWL_WARN(trans, "Exit HW not ready\n");
-		return -EIO;
+		ret = -EIO;
+		goto out;
 	}
 
 	iwl_enable_rfkill_int(trans);
@@ -510,8 +514,6 @@ int iwl_trans_pcie_gen2_start_fw(struct iwl_trans *trans,
 	/* Make sure it finished running */
 	iwl_pcie_synchronize_irqs(trans);
 
-	mutex_lock(&trans_pcie->mutex);
-
 	/* If platform's RF_KILL switch is NOT set to KILL */
 	hw_rfkill = iwl_pcie_check_hw_rf_kill(trans);
 	if (hw_rfkill && !run_in_rfkill) {
@@ -541,12 +543,27 @@ int iwl_trans_pcie_gen2_start_fw(struct iwl_trans *trans,
 		goto out;
 	}
 
-	if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_AX210)
-		ret = iwl_pcie_ctxt_info_gen3_init(trans, fw);
-	else
+	if (WARN_ON(trans->do_top_reset &&
+		    trans->trans_cfg->device_family < IWL_DEVICE_FAMILY_SC))
+		return -EINVAL;
+
+	/* we need to wait later - set state */
+	if (trans->do_top_reset)
+		trans_pcie->fw_reset_state = FW_RESET_TOP_REQUESTED;
+
+	if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_AX210) {
+		if (!top_reset_done) {
+			ret = iwl_pcie_ctxt_info_gen3_alloc(trans, fw);
+			if (ret)
+				goto out;
+		}
+
+		iwl_pcie_ctxt_info_gen3_kick(trans);
+	} else {
 		ret = iwl_pcie_ctxt_info_init(trans, fw);
-	if (ret)
-		goto out;
+		if (ret)
+			goto out;
+	}
 
 	keep_ram_busy = !iwl_pcie_set_ltr(trans);
 
@@ -565,6 +582,38 @@ int iwl_trans_pcie_gen2_start_fw(struct iwl_trans *trans,
 	if (keep_ram_busy)
 		iwl_pcie_spin_for_iml(trans);
 
+	if (trans->do_top_reset) {
+		trans->do_top_reset = 0;
+
+#define FW_TOP_RESET_TIMEOUT	(HZ / 4)
+		ret = wait_event_timeout(trans_pcie->fw_reset_waitq,
+					 trans_pcie->fw_reset_state != FW_RESET_TOP_REQUESTED,
+					 FW_TOP_RESET_TIMEOUT);
+
+		if (trans_pcie->fw_reset_state != FW_RESET_OK) {
+			if (trans_pcie->fw_reset_state != FW_RESET_TOP_REQUESTED)
+				IWL_ERR(trans,
+					"TOP reset interrupted by error (state %d)!\n",
+					trans_pcie->fw_reset_state);
+			else
+				IWL_ERR(trans, "TOP reset timed out!\n");
+			iwl_op_mode_nic_error(trans->op_mode,
+					      IWL_ERR_TYPE_TOP_RESET_FAILED);
+			iwl_trans_schedule_reset(trans,
+						 IWL_ERR_TYPE_TOP_RESET_FAILED);
+			ret = -EIO;
+			goto out;
+		}
+
+		msleep(10);
+		IWL_INFO(trans, "TOP reset successful, reinit now\n");
+		/* now load the firmware again properly */
+		trans_pcie->prph_scratch->ctrl_cfg.control.control_flags &=
+			~cpu_to_le32(IWL_PRPH_SCRATCH_TOP_RESET);
+		top_reset_done = true;
+		goto again;
+	}
+
 	/* re-check RF-Kill state since we may have missed the interrupt */
 	hw_rfkill = iwl_pcie_check_hw_rf_kill(trans);
 	if (hw_rfkill && !run_in_rfkill)
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index 5e531227aec6..b0c145f0322c 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -3262,8 +3262,9 @@ static ssize_t iwl_dbgfs_reset_write(struct file *file,
 {
 	struct iwl_trans *trans = file->private_data;
 	static const char * const modes[] = {
-		[IWL_RESET_MODE_SW_RESET] = "n/a",
-		[IWL_RESET_MODE_REPROBE] = "n/a",
+		[IWL_RESET_MODE_SW_RESET] = "sw",
+		[IWL_RESET_MODE_REPROBE] = "reprobe",
+		[IWL_RESET_MODE_TOP_RESET] = "top",
 		[IWL_RESET_MODE_REMOVE_ONLY] = "remove",
 		[IWL_RESET_MODE_RESCAN] = "rescan",
 		[IWL_RESET_MODE_FUNC_RESET] = "function",
@@ -3282,8 +3283,18 @@ static ssize_t iwl_dbgfs_reset_write(struct file *file,
 	if (mode < 0)
 		return mode;
 
-	if (mode < IWL_RESET_MODE_REMOVE_ONLY)
-		return -EINVAL;
+	if (mode < IWL_RESET_MODE_REMOVE_ONLY) {
+		if (!test_bit(STATUS_DEVICE_ENABLED, &trans->status))
+			return -EINVAL;
+		if (mode == IWL_RESET_MODE_TOP_RESET) {
+			if (trans->trans_cfg->device_family < IWL_DEVICE_FAMILY_SC)
+				return -EINVAL;
+			trans->request_top_reset = 1;
+		}
+		iwl_op_mode_nic_error(trans->op_mode, IWL_ERR_TYPE_DEBUGFS);
+		iwl_trans_schedule_reset(trans, IWL_ERR_TYPE_DEBUGFS);
+		return count;
+	}
 
 	iwl_trans_pcie_reset(trans, mode);
 
-- 
2.34.1


