Return-Path: <linux-wireless+bounces-22381-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1FB0AA8265
	for <lists+linux-wireless@lfdr.de>; Sat,  3 May 2025 21:45:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B75EA189D737
	for <lists+linux-wireless@lfdr.de>; Sat,  3 May 2025 19:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 472E627E7F1;
	Sat,  3 May 2025 19:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I/ilCrwk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E19127F736
	for <linux-wireless@vger.kernel.org>; Sat,  3 May 2025 19:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746301519; cv=none; b=DC9Am5c4lqYTdtKwpglDqEszyuAn60P+C6FrMTnAL4Dld/WbPzR30V/Ck/xlDfO+Tdje95m8RgYXk2zpCckTdBH7scuVbFEqUpe/eTvG0t7bObYA+YB3/P/22r97Z5fvujC7t8v5mIuYQHdLfKR8qdWvIOoUokdFEzCtk1P4Ug8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746301519; c=relaxed/simple;
	bh=knXpYm7DQ7PpyLSxSepwy/wW2dO8adDjme+SIXSM74Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sCUuo+8c92yBZZKSxyBrUmIK5PZvhZqcfaMWeKPsNvOCbdEIRsIUhFbKM39DikVL9AxzVuJIiHuJ+a5tj0mPE457IlzalFsU3XQN01Psx/44azzUMHdvBv9yO0ndtkDBPg1uSFBTxOcoRd5ckGHQVQCitBj0Pf9LilcKIy+eI40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I/ilCrwk; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746301517; x=1777837517;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=knXpYm7DQ7PpyLSxSepwy/wW2dO8adDjme+SIXSM74Y=;
  b=I/ilCrwkew3pKPxTm85WvG8Muq2Qt+0HKX7gSWtSx0MSej2mHGZra/vP
   PHFv8hy4JzVwJcmMP/x+dILaSFRuNChjUB8ualMTdt8zW4erwbZ4mv7a9
   Nd0oFvKaScHFVHIlUYGNUlOlwijtOpVO4vhEdz94mViDoZr6BIsgO5v2r
   YwJr/kznxCiUndMF5aP4iui8fC6khePLYqzYmD9xrJQH8HBcOBEJ3uUok
   lAav54BT9CvV6wg514A5jykDpyymyejIifuu8phkDULA5vRK6rZKPhtc3
   6eEn2f8LTcDbkGkfKvyFbQBr0gb6fTkSkvR6MIEdmodAxPeuv3MPAGGFs
   w==;
X-CSE-ConnectionGUID: MX+55w8oTKKrbWN2bKiD+Q==
X-CSE-MsgGUID: Xu2ld6rrTiixn/CHnxHEBQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11422"; a="58613275"
X-IronPort-AV: E=Sophos;i="6.15,258,1739865600"; 
   d="scan'208";a="58613275"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2025 12:45:17 -0700
X-CSE-ConnectionGUID: JP/GbTivSiGztMnjp6kgZQ==
X-CSE-MsgGUID: UO/NcAN8QHeGZJlgyVzvoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,258,1739865600"; 
   d="scan'208";a="134644393"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2025 12:45:15 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: miriam.rachel.korenblit@intel.com
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH iwlwifi-next 14/15] wifi: iwlwifi: trans: remove SCD base address validation
Date: Sat,  3 May 2025 22:44:33 +0300
Message-Id: <20250503224232.5405014d7f88.I3b74a1fd51a39c6df5674f2994189092d1635e7f@changeid>
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

We pass this parameter around a lot of places just to
validate what the firmware told us against the hardware
with a warning, which seems to never trigger. Remove it.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/dvm/ucode.c     | 2 +-
 drivers/net/wireless/intel/iwlwifi/iwl-trans.c     | 4 ++--
 drivers/net/wireless/intel/iwlwifi/iwl-trans.h     | 2 +-
 drivers/net/wireless/intel/iwlwifi/mld/fw.c        | 2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c        | 4 +---
 drivers/net/wireless/intel/iwlwifi/pcie/internal.h | 4 ++--
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c    | 4 ++--
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c       | 7 ++-----
 8 files changed, 12 insertions(+), 17 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/ucode.c b/drivers/net/wireless/intel/iwlwifi/dvm/ucode.c
index d504fa178cbe..ac90191a3973 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/ucode.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/ucode.c
@@ -223,7 +223,7 @@ static int iwl_alive_notify(struct iwl_priv *priv)
 	int ret;
 	int i;
 
-	iwl_trans_fw_alive(priv->trans, 0);
+	iwl_trans_fw_alive(priv->trans);
 
 	if (priv->fw->ucode_capa.flags & IWL_UCODE_TLV_FLAGS_PAN &&
 	    priv->nvm_data->sku_cap_ipan_enable) {
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.c b/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
index 0c3b713ac526..9d7f38991a12 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
@@ -592,7 +592,7 @@ iwl_trans_release_nic_access(struct iwl_trans *trans)
 }
 IWL_EXPORT_SYMBOL(iwl_trans_release_nic_access);
 
-void iwl_trans_fw_alive(struct iwl_trans *trans, u32 scd_addr)
+void iwl_trans_fw_alive(struct iwl_trans *trans)
 {
 	might_sleep();
 
@@ -601,7 +601,7 @@ void iwl_trans_fw_alive(struct iwl_trans *trans, u32 scd_addr)
 	if (trans->trans_cfg->gen2)
 		iwl_trans_pcie_gen2_fw_alive(trans);
 	else
-		iwl_trans_pcie_fw_alive(trans, scd_addr);
+		iwl_trans_pcie_fw_alive(trans);
 }
 IWL_EXPORT_SYMBOL(iwl_trans_fw_alive);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index ef0f02769f8f..3a025cc46348 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -947,7 +947,7 @@ int iwl_trans_start_hw(struct iwl_trans *trans);
 
 void iwl_trans_op_mode_leave(struct iwl_trans *trans);
 
-void iwl_trans_fw_alive(struct iwl_trans *trans, u32 scd_addr);
+void iwl_trans_fw_alive(struct iwl_trans *trans);
 
 int iwl_trans_start_fw(struct iwl_trans *trans, const struct iwl_fw *fw,
 		       enum iwl_ucode_type ucode_type, bool run_in_rfkill);
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/fw.c b/drivers/net/wireless/intel/iwlwifi/mld/fw.c
index c2ee4b2a7523..bd19de665a37 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/fw.c
@@ -262,7 +262,7 @@ static int iwl_mld_load_fw_wait_alive(struct iwl_mld *mld)
 		return -EIO;
 	}
 
-	iwl_trans_fw_alive(mld->trans, 0);
+	iwl_trans_fw_alive(mld->trans);
 
 	return 0;
 }
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 2ef5a48a970d..3de4c5f8bdff 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -30,7 +30,6 @@
 
 struct iwl_mvm_alive_data {
 	bool valid;
-	u32 scd_base_addr;
 };
 
 static int iwl_send_tx_ant_cfg(struct iwl_mvm *mvm, u8 valid_tx_ant)
@@ -244,7 +243,6 @@ static bool iwl_alive_fn(struct iwl_notif_wait_data *notif_wait,
 		}
 	}
 
-	alive_data->scd_base_addr = le32_to_cpu(lmac1->dbg_ptrs.scd_base_ptr);
 	alive_data->valid = status == IWL_ALIVE_STATUS_OK;
 
 	IWL_DEBUG_FW(mvm,
@@ -429,7 +427,7 @@ static int iwl_mvm_load_ucode_wait_alive(struct iwl_mvm *mvm,
 	/* if reached this point, Alive notification was received */
 	iwl_mei_alive_notif(true);
 
-	iwl_trans_fw_alive(mvm->trans, alive_data.scd_base_addr);
+	iwl_trans_fw_alive(mvm->trans);
 
 	ret = iwl_pnvm_load(mvm->trans, &mvm->notif_wait,
 			    &mvm->fw->ucode_capa);
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
index c48cbedbcbfa..07b4b28b052f 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
@@ -633,7 +633,7 @@ struct iwl_tso_page_info {
 				      IWL_TSO_PAGE_DATA_SIZE))
 
 int iwl_pcie_tx_init(struct iwl_trans *trans);
-void iwl_pcie_tx_start(struct iwl_trans *trans, u32 scd_base_addr);
+void iwl_pcie_tx_start(struct iwl_trans *trans);
 int iwl_pcie_tx_stop(struct iwl_trans *trans);
 void iwl_pcie_tx_free(struct iwl_trans *trans);
 bool iwl_trans_pcie_txq_enable(struct iwl_trans *trans, int queue, u16 ssn,
@@ -1131,7 +1131,7 @@ bool iwl_trans_pcie_grab_nic_access(struct iwl_trans *trans);
 void iwl_trans_pcie_release_nic_access(struct iwl_trans *trans);
 
 /* transport gen 1 exported functions */
-void iwl_trans_pcie_fw_alive(struct iwl_trans *trans, u32 scd_addr);
+void iwl_trans_pcie_fw_alive(struct iwl_trans *trans);
 int iwl_trans_pcie_start_fw(struct iwl_trans *trans,
 			    const struct iwl_fw *fw,
 			    const struct fw_img *img,
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index 7c688745b01a..cc4614fd226b 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -1425,10 +1425,10 @@ int iwl_trans_pcie_start_fw(struct iwl_trans *trans,
 	return ret;
 }
 
-void iwl_trans_pcie_fw_alive(struct iwl_trans *trans, u32 scd_addr)
+void iwl_trans_pcie_fw_alive(struct iwl_trans *trans)
 {
 	iwl_pcie_reset_ict(trans);
-	iwl_pcie_tx_start(trans, scd_addr);
+	iwl_pcie_tx_start(trans);
 }
 
 void iwl_trans_pcie_handle_stop_rfkill(struct iwl_trans *trans,
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
index cf9ec491c086..fcddf32196e1 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
@@ -477,7 +477,7 @@ static void iwl_pcie_txq_free(struct iwl_trans *trans, int txq_id)
 	memset(txq, 0, sizeof(*txq));
 }
 
-void iwl_pcie_tx_start(struct iwl_trans *trans, u32 scd_base_addr)
+void iwl_pcie_tx_start(struct iwl_trans *trans)
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 	int nq = trans->trans_cfg->base_params->num_of_queues;
@@ -495,9 +495,6 @@ void iwl_pcie_tx_start(struct iwl_trans *trans, u32 scd_base_addr)
 	trans_pcie->scd_base_addr =
 		iwl_read_prph(trans, SCD_SRAM_BASE_ADDR);
 
-	WARN_ON(scd_base_addr != 0 &&
-		scd_base_addr != trans_pcie->scd_base_addr);
-
 	/* reset context data, TX status and translation data */
 	iwl_trans_pcie_write_mem(trans, trans_pcie->scd_base_addr +
 					SCD_CONTEXT_MEM_LOWER_BOUND,
@@ -573,7 +570,7 @@ void iwl_trans_pcie_tx_reset(struct iwl_trans *trans)
 	 * while we were in WoWLAN in which case SCD_SRAM_BASE_ADDR will
 	 * contain garbage.
 	 */
-	iwl_pcie_tx_start(trans, 0);
+	iwl_pcie_tx_start(trans);
 }
 
 static void iwl_pcie_tx_stop_fh(struct iwl_trans *trans)
-- 
2.34.1


