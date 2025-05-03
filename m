Return-Path: <linux-wireless+bounces-22375-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8808AA825F
	for <lists+linux-wireless@lfdr.de>; Sat,  3 May 2025 21:45:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F5E5189D50D
	for <lists+linux-wireless@lfdr.de>; Sat,  3 May 2025 19:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45BE627E1CF;
	Sat,  3 May 2025 19:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ad9CriFN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C6D27F736
	for <linux-wireless@vger.kernel.org>; Sat,  3 May 2025 19:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746301508; cv=none; b=losFvjs0rzyaXes+ZuHsL5xztsXOA4jUbMJsXdxrr6rGlL+UXDZrl3L1EM5jIxJFOJihaiOp5L7ygy9P700UMpMO6WtMmUWkOyuWqP5QxpUATg1WtbbBEU2xdHco1tvimq32jAuy7N055cfmK6+ybKHgIF2kxWKHo/okrmSHMKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746301508; c=relaxed/simple;
	bh=wt8xcmBEoXwOpDZ7xtqiudexy6CNJJ0mUFE7pb0mqYQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lmSQgxtNDaxlu2OcQXSUcUuJw+yWZdX304cseyjO3n0/k0XZ9e7fbgRZkGof6QU+3ULOcPZl1iEvOE9+4V/DPvQxmXGTYeOgKlbYRfX+/x5im0iorP8VkT6XXa4afgGKIIrnjHxLuXGLA0kFGhmiCFn72IbQUwEh04nGE3XbIeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ad9CriFN; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746301506; x=1777837506;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wt8xcmBEoXwOpDZ7xtqiudexy6CNJJ0mUFE7pb0mqYQ=;
  b=Ad9CriFN2+NboSO09hgkfDVTGXGWRl7sFIM8FD5aiNBudYeXAe7AT4Oi
   uZHMdCAybU+Ut5hSz8oBnjK9S+AnluvoRjq84quwefYapDmcroRwzHHGx
   TEGbtTn/4TJ3qlNoKtAqujHSHwtQmj6uM8g2QaD2IK9Gov4Vnlsw2rwL/
   sTKtmsTKWStX00F+5BZRRtDMhtKxcp1+Tqmp9pUO3EqCRSgvWBmYcpIkh
   61YNDf+uF5fsQ3aEizT6li5BJE0ar5pwt9tehElo+0zq8eVpDqhJrfHvx
   KhvA/vETLbHX+WeUMmXtIY3IkDHuoSeVOBazs6mvn5LZTP/yPAQj5ikp9
   Q==;
X-CSE-ConnectionGUID: qZnlN2/WTpqKIbtfUQ2puQ==
X-CSE-MsgGUID: Chv+hqrhQ4G6BAk76LwO7Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11422"; a="58613265"
X-IronPort-AV: E=Sophos;i="6.15,258,1739865600"; 
   d="scan'208";a="58613265"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2025 12:45:05 -0700
X-CSE-ConnectionGUID: 9PR69/c7QtKEOhHlWRj7rA==
X-CSE-MsgGUID: h96Gn8ToQn6Jjflzd4xzSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,258,1739865600"; 
   d="scan'208";a="134644320"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2025 12:45:03 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: miriam.rachel.korenblit@intel.com
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH iwlwifi-next 08/15] wifi: iwlwifi: pass full FW info to transport
Date: Sat,  3 May 2025 22:44:27 +0300
Message-Id: <20250503224231.eac4006e81c5.Iebadc56bb2762e5f4d71f66bb2609d74b33daf11@changeid>
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

The code currently passes only the specific image that should
be loaded, but then has to pass the IML (image loader) out of
band, which is confusing. Pass the full FW data together with
desired image type, and use the IML from that.

This also cleans up the code in the various sub-drivers a bit
as they no longer have to look up and check for the image.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/dvm/ucode.c    |  8 ++-----
 .../intel/iwlwifi/iwl-context-info-gen3.h     |  3 ++-
 .../wireless/intel/iwlwifi/iwl-context-info.h |  2 +-
 .../net/wireless/intel/iwlwifi/iwl-trans.c    | 15 +++++++++----
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |  9 ++------
 drivers/net/wireless/intel/iwlwifi/mld/fw.c   |  4 +---
 drivers/net/wireless/intel/iwlwifi/mld/mld.c  |  2 --
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   | 10 +++------
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |  3 ---
 .../intel/iwlwifi/pcie/ctxt-info-gen3.c       | 22 ++++++++++---------
 .../wireless/intel/iwlwifi/pcie/ctxt-info.c   |  4 ++--
 .../wireless/intel/iwlwifi/pcie/internal.h    | 10 +++++++--
 .../wireless/intel/iwlwifi/pcie/trans-gen2.c  |  8 ++++---
 .../net/wireless/intel/iwlwifi/pcie/trans.c   |  8 ++++---
 14 files changed, 54 insertions(+), 54 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/ucode.c b/drivers/net/wireless/intel/iwlwifi/dvm/ucode.c
index bb13ca5d666c..d504fa178cbe 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/ucode.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/ucode.c
@@ -3,6 +3,7 @@
  *
  * Copyright(c) 2008 - 2014 Intel Corporation. All rights reserved.
  * Copyright(c) 2015 Intel Deutschland GmbH
+ * Copyright (C) 2025 Intel Corporation
  *****************************************************************************/
 
 #include <linux/kernel.h>
@@ -293,15 +294,10 @@ int iwl_load_ucode_wait_alive(struct iwl_priv *priv,
 {
 	struct iwl_notification_wait alive_wait;
 	struct iwl_alive_data alive_data;
-	const struct fw_img *fw;
 	int ret;
 	enum iwl_ucode_type old_type;
 	static const u16 alive_cmd[] = { REPLY_ALIVE };
 
-	fw = iwl_get_ucode_image(priv->fw, ucode_type);
-	if (WARN_ON(!fw))
-		return -EINVAL;
-
 	old_type = priv->cur_ucode;
 	priv->cur_ucode = ucode_type;
 	priv->ucode_loaded = false;
@@ -310,7 +306,7 @@ int iwl_load_ucode_wait_alive(struct iwl_priv *priv,
 				   alive_cmd, ARRAY_SIZE(alive_cmd),
 				   iwl_alive_fn, &alive_data);
 
-	ret = iwl_trans_start_fw(priv->trans, fw, false);
+	ret = iwl_trans_start_fw(priv->trans, priv->fw, ucode_type, false);
 	if (ret) {
 		priv->cur_ucode = old_type;
 		iwl_remove_notification(&priv->notif_wait, &alive_wait);
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-context-info-gen3.h b/drivers/net/wireless/intel/iwlwifi/iwl-context-info-gen3.h
index b028343672cc..3eba27fd5293 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-context-info-gen3.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-context-info-gen3.h
@@ -324,7 +324,8 @@ struct iwl_context_info_gen3 {
 } __packed; /* IPC_CONTEXT_INFO_S */
 
 int iwl_pcie_ctxt_info_gen3_alloc(struct iwl_trans *trans,
-				  const struct fw_img *fw);
+				  const struct iwl_fw *fw,
+				  const struct fw_img *img);
 void iwl_pcie_ctxt_info_gen3_kick(struct iwl_trans *trans);
 void iwl_pcie_ctxt_info_gen3_free(struct iwl_trans *trans, bool alive);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-context-info.h b/drivers/net/wireless/intel/iwlwifi/iwl-context-info.h
index b495eb94d126..062334e1c449 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-context-info.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-context-info.h
@@ -181,7 +181,7 @@ struct iwl_context_info {
 	__le32 reserved3[16];
 } __packed;
 
-int iwl_pcie_ctxt_info_init(struct iwl_trans *trans, const struct fw_img *fw);
+int iwl_pcie_ctxt_info_init(struct iwl_trans *trans, const struct fw_img *img);
 void iwl_pcie_ctxt_info_free(struct iwl_trans *trans);
 void iwl_pcie_ctxt_info_free_paging(struct iwl_trans *trans);
 int iwl_pcie_init_fw_sec(struct iwl_trans *trans,
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.c b/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
index 9f1c2870c5b7..0c3b713ac526 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
@@ -605,21 +605,28 @@ void iwl_trans_fw_alive(struct iwl_trans *trans, u32 scd_addr)
 }
 IWL_EXPORT_SYMBOL(iwl_trans_fw_alive);
 
-int iwl_trans_start_fw(struct iwl_trans *trans, const struct fw_img *fw,
-		       bool run_in_rfkill)
+int iwl_trans_start_fw(struct iwl_trans *trans, const struct iwl_fw *fw,
+		       enum iwl_ucode_type ucode_type, bool run_in_rfkill)
 {
+	const struct fw_img *img;
 	int ret;
 
 	might_sleep();
 
 	WARN_ON_ONCE(!trans->rx_mpdu_cmd);
 
+	img = iwl_get_ucode_image(fw, ucode_type);
+	if (!img)
+		return -EINVAL;
+
 	clear_bit(STATUS_FW_ERROR, &trans->status);
 
 	if (trans->trans_cfg->gen2)
-		ret = iwl_trans_pcie_gen2_start_fw(trans, fw, run_in_rfkill);
+		ret = iwl_trans_pcie_gen2_start_fw(trans, fw, img,
+						   run_in_rfkill);
 	else
-		ret = iwl_trans_pcie_start_fw(trans, fw, run_in_rfkill);
+		ret = iwl_trans_pcie_start_fw(trans, fw, img,
+					      run_in_rfkill);
 
 	if (ret == 0)
 		trans->state = IWL_TRANS_FW_STARTED;
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index 550045438223..cdd16c37a585 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -838,8 +838,6 @@ struct iwl_txq {
  * @wide_cmd_header: true when ucode supports wide command header format
  * @num_rx_queues: number of RX queues allocated by the transport;
  *	the transport must set this before calling iwl_drv_start()
- * @iml_len: the length of the image loader
- * @iml: a pointer to the image loader itself
  * @dev_cmd_pool: pool for Tx cmd allocation - for internal use only.
  *	The user should use iwl_trans_{alloc,free}_tx_cmd.
  * @dev_cmd_pool_name: name for the TX command allocation pool
@@ -914,9 +912,6 @@ struct iwl_trans {
 
 	u8 num_rx_queues;
 
-	size_t iml_len;
-	u8 *iml;
-
 	/* The following fields are internal only */
 	struct kmem_cache *dev_cmd_pool;
 	char dev_cmd_pool_name[50];
@@ -961,8 +956,8 @@ void iwl_trans_op_mode_leave(struct iwl_trans *trans);
 
 void iwl_trans_fw_alive(struct iwl_trans *trans, u32 scd_addr);
 
-int iwl_trans_start_fw(struct iwl_trans *trans, const struct fw_img *fw,
-		       bool run_in_rfkill);
+int iwl_trans_start_fw(struct iwl_trans *trans, const struct iwl_fw *fw,
+		       enum iwl_ucode_type ucode_type, bool run_in_rfkill);
 
 void iwl_trans_stop_device(struct iwl_trans *trans);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/fw.c b/drivers/net/wireless/intel/iwlwifi/mld/fw.c
index 268ff7eceb47..c2ee4b2a7523 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/fw.c
@@ -227,8 +227,6 @@ static void iwl_mld_print_alive_notif_timeout(struct iwl_mld *mld)
 
 static int iwl_mld_load_fw_wait_alive(struct iwl_mld *mld)
 {
-	const struct fw_img *fw =
-		iwl_get_ucode_image(mld->fw, IWL_UCODE_REGULAR);
 	static const u16 alive_cmd[] = { UCODE_ALIVE_NTFY };
 	struct iwl_notification_wait alive_wait;
 	bool alive_valid = false;
@@ -242,7 +240,7 @@ static int iwl_mld_load_fw_wait_alive(struct iwl_mld *mld)
 
 	iwl_dbg_tlv_time_point(&mld->fwrt, IWL_FW_INI_TIME_POINT_EARLY, NULL);
 
-	ret = iwl_trans_start_fw(mld->trans, fw, true);
+	ret = iwl_trans_start_fw(mld->trans, mld->fw, IWL_UCODE_REGULAR, true);
 	if (ret) {
 		iwl_remove_notification(&mld->notif_wait, &alive_wait);
 		return ret;
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mld.c b/drivers/net/wireless/intel/iwlwifi/mld/mld.c
index 81a4443d3b4c..8fb33b4459d7 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mld.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mld.c
@@ -348,8 +348,6 @@ iwl_mld_configure_trans(struct iwl_op_mode *op_mode)
 
 	trans->rx_mpdu_cmd = REPLY_RX_MPDU_CMD;
 	trans->rx_mpdu_cmd_hdr_size = sizeof(struct iwl_rx_mpdu_res_start);
-	trans->iml = mld->fw->iml;
-	trans->iml_len = mld->fw->iml_len;
 	trans->wide_cmd_header = true;
 
 	iwl_trans_configure(trans, &trans_cfg);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index d955f7c4ab8a..2ef5a48a970d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -315,7 +315,6 @@ static int iwl_mvm_load_ucode_wait_alive(struct iwl_mvm *mvm,
 {
 	struct iwl_notification_wait alive_wait;
 	struct iwl_mvm_alive_data alive_data = {};
-	const struct fw_img *fw;
 	int ret;
 	enum iwl_ucode_type old_type = mvm->fwrt.cur_fw_img;
 	static const u16 alive_cmd[] = { UCODE_ALIVE_NTFY };
@@ -328,11 +327,7 @@ static int iwl_mvm_load_ucode_wait_alive(struct iwl_mvm *mvm,
 	    iwl_fw_dbg_conf_usniffer(mvm->fw, FW_DBG_START_FROM_ALIVE) &&
 	    !(fw_has_capa(&mvm->fw->ucode_capa,
 			  IWL_UCODE_TLV_CAPA_USNIFFER_UNIFIED)))
-		fw = iwl_get_ucode_image(mvm->fw, IWL_UCODE_REGULAR_USNIFFER);
-	else
-		fw = iwl_get_ucode_image(mvm->fw, ucode_type);
-	if (WARN_ON(!fw))
-		return -EINVAL;
+		ucode_type = IWL_UCODE_REGULAR_USNIFFER;
 	iwl_fw_set_current_image(&mvm->fwrt, ucode_type);
 	clear_bit(IWL_MVM_STATUS_FIRMWARE_RUNNING, &mvm->status);
 
@@ -345,7 +340,8 @@ static int iwl_mvm_load_ucode_wait_alive(struct iwl_mvm *mvm,
 	 * For the unified firmware case, the ucode_type is not
 	 * INIT, but we still need to run it.
 	 */
-	ret = iwl_trans_start_fw(mvm->trans, fw, run_in_rfkill);
+	ret = iwl_trans_start_fw(mvm->trans, mvm->fw, ucode_type,
+				 run_in_rfkill);
 	if (ret) {
 		iwl_fw_set_current_image(&mvm->fwrt, old_type);
 		iwl_remove_notification(&mvm->notif_wait, &alive_wait);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index 5629aa0a91fd..17aa614a2632 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -1482,9 +1482,6 @@ iwl_op_mode_mvm_start(struct iwl_trans *trans, const struct iwl_cfg *cfg,
 	trans->dbg.dest_tlv = mvm->fw->dbg.dest_tlv;
 	trans->dbg.n_dest_reg = mvm->fw->dbg.n_dest_reg;
 
-	trans->iml = mvm->fw->iml;
-	trans->iml_len = mvm->fw->iml_len;
-
 	/* set up notification wait support */
 	iwl_notification_wait_init(&mvm->notif_wait);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
index 644ef3fb7ab7..c11ea1d4f7fc 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
@@ -98,7 +98,8 @@ iwl_pcie_ctxt_info_dbg_enable(struct iwl_trans *trans,
 }
 
 int iwl_pcie_ctxt_info_gen3_alloc(struct iwl_trans *trans,
-				  const struct fw_img *fw)
+				  const struct iwl_fw *fw,
+				  const struct fw_img *img)
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 	struct iwl_context_info_gen3 *ctxt_info_gen3;
@@ -187,7 +188,7 @@ int iwl_pcie_ctxt_info_gen3_alloc(struct iwl_trans *trans,
 	prph_sc_ctrl->step_cfg.mbx_addr_1 = cpu_to_le32(trans->mbx_addr_1_step);
 
 	/* allocate ucode sections in dram and set addresses */
-	ret = iwl_pcie_init_fw_sec(trans, fw, &prph_scratch->dram.common);
+	ret = iwl_pcie_init_fw_sec(trans, img, &prph_scratch->dram.common);
 	if (ret)
 		goto err_free_prph_scratch;
 
@@ -261,7 +262,8 @@ int iwl_pcie_ctxt_info_gen3_alloc(struct iwl_trans *trans,
 	trans_pcie->prph_scratch = prph_scratch;
 
 	/* Allocate IML */
-	trans_pcie->iml = dma_alloc_coherent(trans->dev, trans->iml_len,
+	trans_pcie->iml_len = fw->iml_len;
+	trans_pcie->iml = dma_alloc_coherent(trans->dev, fw->iml_len,
 					     &trans_pcie->iml_dma_addr,
 					     GFP_KERNEL);
 	if (!trans_pcie->iml) {
@@ -269,7 +271,7 @@ int iwl_pcie_ctxt_info_gen3_alloc(struct iwl_trans *trans,
 		goto err_free_ctxt_info;
 	}
 
-	memcpy(trans_pcie->iml, trans->iml, trans->iml_len);
+	memcpy(trans_pcie->iml, fw->iml, fw->iml_len);
 
 	return 0;
 
@@ -298,11 +300,9 @@ void iwl_pcie_ctxt_info_gen3_kick(struct iwl_trans *trans)
 	iwl_enable_fw_load_int_ctx_info(trans, trans->do_top_reset);
 
 	/* kick FW self load */
-	iwl_write64(trans, CSR_CTXT_INFO_ADDR,
-		    trans_pcie->ctxt_info_dma_addr);
-	iwl_write64(trans, CSR_IML_DATA_ADDR,
-		    trans_pcie->iml_dma_addr);
-	iwl_write32(trans, CSR_IML_SIZE_ADDR, trans->iml_len);
+	iwl_write64(trans, CSR_CTXT_INFO_ADDR, trans_pcie->ctxt_info_dma_addr);
+	iwl_write64(trans, CSR_IML_DATA_ADDR, trans_pcie->iml_dma_addr);
+	iwl_write32(trans, CSR_IML_SIZE_ADDR, trans_pcie->iml_len);
 
 	iwl_set_bit(trans, CSR_CTXT_INFO_BOOT_CTRL,
 		    CSR_AUTO_FUNC_BOOT_ENA);
@@ -313,9 +313,11 @@ void iwl_pcie_ctxt_info_gen3_free(struct iwl_trans *trans, bool alive)
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 
 	if (trans_pcie->iml) {
-		dma_free_coherent(trans->dev, trans->iml_len, trans_pcie->iml,
+		dma_free_coherent(trans->dev, trans_pcie->iml_len,
+				  trans_pcie->iml,
 				  trans_pcie->iml_dma_addr);
 		trans_pcie->iml_dma_addr = 0;
+		trans_pcie->iml_len = 0;
 		trans_pcie->iml = NULL;
 	}
 
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info.c b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info.c
index 4e79ca7e47b2..81a8cac3bb0a 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info.c
@@ -161,7 +161,7 @@ int iwl_pcie_init_fw_sec(struct iwl_trans *trans,
 }
 
 int iwl_pcie_ctxt_info_init(struct iwl_trans *trans,
-			    const struct fw_img *fw)
+			    const struct fw_img *img)
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 	struct iwl_context_info *ctxt_info;
@@ -223,7 +223,7 @@ int iwl_pcie_ctxt_info_init(struct iwl_trans *trans,
 		TFD_QUEUE_CB_SIZE(IWL_CMD_QUEUE_SIZE);
 
 	/* allocate ucode sections in dram and set addresses */
-	ret = iwl_pcie_init_fw_sec(trans, fw, &ctxt_info->dram);
+	ret = iwl_pcie_init_fw_sec(trans, img, &ctxt_info->dram);
 	if (ret) {
 		dma_free_coherent(trans->dev, sizeof(*trans_pcie->ctxt_info),
 				  ctxt_info, trans_pcie->ctxt_info_dma_addr);
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
index 259ad96c012d..360367bf6988 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
@@ -353,6 +353,7 @@ struct iwl_pcie_txqs {
  * @prph_scratch_dma_addr: dma addr of prph scratch
  * @ctxt_info_dma_addr: dma addr of context information
  * @iml: image loader image virtual address
+ * @iml_len: image loader image size
  * @iml_dma_addr: image loader image DMA address
  * @trans: pointer to the generic transport area
  * @scd_base_addr: scheduler sram base address in SRAM
@@ -438,6 +439,7 @@ struct iwl_trans_pcie {
 	struct iwl_prph_info *prph_info;
 	struct iwl_prph_scratch *prph_scratch;
 	void *iml;
+	size_t iml_len;
 	dma_addr_t ctxt_info_dma_addr;
 	dma_addr_t prph_info_dma_addr;
 	dma_addr_t prph_scratch_dma_addr;
@@ -1135,7 +1137,9 @@ void iwl_trans_pcie_release_nic_access(struct iwl_trans *trans);
 /* transport gen 1 exported functions */
 void iwl_trans_pcie_fw_alive(struct iwl_trans *trans, u32 scd_addr);
 int iwl_trans_pcie_start_fw(struct iwl_trans *trans,
-			    const struct fw_img *fw, bool run_in_rfkill);
+			    const struct iwl_fw *fw,
+			    const struct fw_img *img,
+			    bool run_in_rfkill);
 void iwl_trans_pcie_stop_device(struct iwl_trans *trans);
 
 /* common functions that are used by gen2 transport */
@@ -1158,7 +1162,9 @@ void iwl_pcie_alloc_fw_monitor(struct iwl_trans *trans, u8 max_power);
 
 /* transport gen 2 exported functions */
 int iwl_trans_pcie_gen2_start_fw(struct iwl_trans *trans,
-				 const struct fw_img *fw, bool run_in_rfkill);
+				 const struct iwl_fw *fw,
+				 const struct fw_img *img,
+				 bool run_in_rfkill);
 void iwl_trans_pcie_gen2_fw_alive(struct iwl_trans *trans);
 int iwl_trans_pcie_gen2_send_hcmd(struct iwl_trans *trans,
 				  struct iwl_host_cmd *cmd);
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
index bc19f082a8f5..9283547e9616 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
@@ -484,7 +484,9 @@ static void iwl_pcie_spin_for_iml(struct iwl_trans *trans)
 }
 
 int iwl_trans_pcie_gen2_start_fw(struct iwl_trans *trans,
-				 const struct fw_img *fw, bool run_in_rfkill)
+				 const struct iwl_fw *fw,
+				 const struct fw_img *img,
+				 bool run_in_rfkill)
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 	bool hw_rfkill, keep_ram_busy;
@@ -553,14 +555,14 @@ int iwl_trans_pcie_gen2_start_fw(struct iwl_trans *trans,
 
 	if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_AX210) {
 		if (!top_reset_done) {
-			ret = iwl_pcie_ctxt_info_gen3_alloc(trans, fw);
+			ret = iwl_pcie_ctxt_info_gen3_alloc(trans, fw, img);
 			if (ret)
 				goto out;
 		}
 
 		iwl_pcie_ctxt_info_gen3_kick(trans);
 	} else {
-		ret = iwl_pcie_ctxt_info_init(trans, fw);
+		ret = iwl_pcie_ctxt_info_init(trans, img);
 		if (ret)
 			goto out;
 	}
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index c418be1ff75c..cdcd3c8e47a8 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -1337,7 +1337,9 @@ void iwl_pcie_synchronize_irqs(struct iwl_trans *trans)
 }
 
 int iwl_trans_pcie_start_fw(struct iwl_trans *trans,
-			    const struct fw_img *fw, bool run_in_rfkill)
+			    const struct iwl_fw *fw,
+			    const struct fw_img *img,
+			    bool run_in_rfkill)
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 	bool hw_rfkill;
@@ -1409,9 +1411,9 @@ int iwl_trans_pcie_start_fw(struct iwl_trans *trans,
 
 	/* Load the given image to the HW */
 	if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_8000)
-		ret = iwl_pcie_load_given_ucode_8000(trans, fw);
+		ret = iwl_pcie_load_given_ucode_8000(trans, img);
 	else
-		ret = iwl_pcie_load_given_ucode(trans, fw);
+		ret = iwl_pcie_load_given_ucode(trans, img);
 
 	/* re-check RF-Kill state since we may have missed the interrupt */
 	hw_rfkill = iwl_pcie_check_hw_rf_kill(trans);
-- 
2.34.1


