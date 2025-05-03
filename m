Return-Path: <linux-wireless+bounces-22379-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D11B4AA8263
	for <lists+linux-wireless@lfdr.de>; Sat,  3 May 2025 21:45:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89668189D74C
	for <lists+linux-wireless@lfdr.de>; Sat,  3 May 2025 19:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55AD11A239E;
	Sat,  3 May 2025 19:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ku6Ru60x"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6B327EC9F
	for <linux-wireless@vger.kernel.org>; Sat,  3 May 2025 19:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746301515; cv=none; b=eGZHXIobxoesPwDaJTi07etIqq4+WA3Vre3Rw/lEdvyFRvlFgh57nRJSbR5e3fa/uEDoUVA0gzO9nDYmZANio9OmYYPt0ofCy64TVV8sIj16j47BGmBOy/92K8x/AVoC5WIWnZZBfaKYjoH6whcS3Izh0dXJ7Qbxjqp126EcTIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746301515; c=relaxed/simple;
	bh=txuJbvCEQ2kIL+9hr+8c1H8JTUzRJ4aDfcUqkUm5rys=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TLUIlnVhgoQ6kWLcoXb/+cF1p7bELpaPSeNC2NKzmrxxBxXUFK9ULJX0vUtDoK/ARs5AGggMcNZK+Jaw8cP3Pp6vLtaRVTl6k8Or4rf7XUdtqGz+7ra5bB+fVrYcA99LRkvjrGLmr9qzrMonEhjPl6almrs3KHNKG7meoRFEHic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ku6Ru60x; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746301513; x=1777837513;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=txuJbvCEQ2kIL+9hr+8c1H8JTUzRJ4aDfcUqkUm5rys=;
  b=ku6Ru60xDDjlZWdmYW845CU/JPcsSmcmx/KYnypUAUcrK0BPerdU36A2
   A8Rza38LEE8UsDNHl0P+68eFDtQbSd3Y+jJWDzpn2LgLrcQnarC+Os+d9
   6Z6tVNTFzE06JO77r5KvdPxNg0QT17C1jEBs2sF4ocy3RPJvU3TOK+iFA
   E5VR0EpMoA0blQWQ4k9HPCGH9jfGIEc124+GD76TrKbDfZRRn3g6/dvxa
   zOxwVQYI4mHX6LvTh9twnTLGTQwyaELsYEuTy4kLjjuMzyWWWqVFZR0Q3
   TTNVboNwL0F491J1qmHdZ+dtxUAYJsQR8xhXmizyhkcFVjQAUam5BRlHM
   Q==;
X-CSE-ConnectionGUID: +2i7TyqbSpObfXAj9cxq0g==
X-CSE-MsgGUID: 31HyP5OaQBSvNJudFPC9Jg==
X-IronPort-AV: E=McAfee;i="6700,10204,11422"; a="58613270"
X-IronPort-AV: E=Sophos;i="6.15,258,1739865600"; 
   d="scan'208";a="58613270"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2025 12:45:13 -0700
X-CSE-ConnectionGUID: rE8E6Y3wTESElDvpHlke3g==
X-CSE-MsgGUID: p6jlHRS3SuS3s6cJYWxenQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,258,1739865600"; 
   d="scan'208";a="134644361"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2025 12:45:11 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: miriam.rachel.korenblit@intel.com
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH iwlwifi-next 12/15] wifi: iwlwifi: remove bc_table_dword transport config
Date: Sat,  3 May 2025 22:44:31 +0300
Message-Id: <20250503224232.6af4ea001226.I693f72a7c3a76e44f9ef2cefd62d606ad100a734@changeid>
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

There's really no point in configuring this, it's just
a question of hardware capability. Remove it.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-trans.h     | 3 ---
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c       | 2 --
 drivers/net/wireless/intel/iwlwifi/pcie/internal.h | 2 --
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c    | 1 -
 drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c  | 5 -----
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c       | 3 ++-
 6 files changed, 2 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index 548cee430bbe..ef0f02769f8f 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -401,8 +401,6 @@ struct iwl_dump_sanitize_ops {
  * @n_no_reclaim_cmds: # of commands in list
  * @rx_buf_size: RX buffer size needed for A-MSDUs
  *	if unset 4k will be the RX buffer size
- * @bc_table_dword: set to true if the BC table expects the byte count to be
- *	in DWORD (as opposed to bytes)
  * @scd_set_active: should the transport configure the SCD for HCMD queue
  * @command_groups: array of command groups, each member is an array of the
  *	commands in the group; for debugging only
@@ -423,7 +421,6 @@ struct iwl_trans_config {
 	unsigned int n_no_reclaim_cmds;
 
 	enum iwl_amsdu_size rx_buf_size;
-	bool bc_table_dword;
 	bool scd_set_active;
 	const struct iwl_hcmd_arr *command_groups;
 	int command_groups_size;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index 17aa614a2632..135d5b89ac25 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -1445,8 +1445,6 @@ iwl_op_mode_mvm_start(struct iwl_trans *trans, const struct iwl_cfg *cfg,
 	trans_cfg.rx_buf_size = iwl_amsdu_size_to_rxb_size();
 
 	trans->wide_cmd_header = true;
-	trans_cfg.bc_table_dword =
-		mvm->trans->trans_cfg->device_family < IWL_DEVICE_FAMILY_AX210;
 
 	trans_cfg.command_groups = iwl_mvm_groups;
 	trans_cfg.command_groups_size = ARRAY_SIZE(iwl_mvm_groups);
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
index f08978d4402e..c48cbedbcbfa 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
@@ -289,7 +289,6 @@ enum iwl_pcie_imr_status {
 /**
  * struct iwl_pcie_txqs - TX queues data
  *
- * @bc_table_dword: true if the BC table expects DWORD (as opposed to bytes)
  * @page_offs: offset from skb->cb to mac header page pointer
  * @dev_cmd_offs: offset from skb->cb to iwl_device_tx_cmd pointer
  * @queue_used: bit mask of used queues
@@ -315,7 +314,6 @@ struct iwl_pcie_txqs {
 	struct iwl_txq *txq[IWL_MAX_TVQM_QUEUES];
 	struct dma_pool *bc_pool;
 	size_t bc_tbl_size;
-	bool bc_table_dword;
 	u8 page_offs;
 	u8 dev_cmd_offs;
 	struct iwl_tso_hdr_page __percpu *tso_hdr_page;
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index db9431f09738..7c688745b01a 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -1993,7 +1993,6 @@ void iwl_trans_pcie_configure(struct iwl_trans *trans,
 	if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_AX210)
 		trans_pcie->supported_dma_mask = DMA_BIT_MASK(11);
 
-	trans_pcie->txqs.bc_table_dword = trans_cfg->bc_table_dword;
 	trans_pcie->scd_set_active = trans_cfg->scd_set_active;
 
 	trans->command_groups = trans_cfg->command_groups;
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c b/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
index 71227fd3dac0..19f033ed3221 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
@@ -561,7 +561,6 @@ static void iwl_pcie_gen2_update_byte_tbl(struct iwl_trans *trans,
 					  struct iwl_txq *txq, u16 byte_cnt,
 					  int num_tbs)
 {
-	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 	int idx = iwl_txq_get_cmd_index(txq, txq->write_ptr);
 	u8 filled_tfd_size, num_fetch_chunks;
 	u16 len = byte_cnt;
@@ -585,16 +584,12 @@ static void iwl_pcie_gen2_update_byte_tbl(struct iwl_trans *trans,
 	if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_AX210) {
 		struct iwl_gen3_bc_tbl_entry *scd_bc_tbl_gen3 = txq->bc_tbl.addr;
 
-		/* Starting from AX210, the HW expects bytes */
-		WARN_ON(trans_pcie->txqs.bc_table_dword);
 		WARN_ON(len > 0x3FFF);
 		bc_ent = cpu_to_le16(len | (num_fetch_chunks << 14));
 		scd_bc_tbl_gen3[idx].tfd_offset = bc_ent;
 	} else {
 		struct iwlagn_scd_bc_tbl *scd_bc_tbl = txq->bc_tbl.addr;
 
-		/* Before AX210, the HW expects DW */
-		WARN_ON(!trans_pcie->txqs.bc_table_dword);
 		len = DIV_ROUND_UP(len, 4);
 		WARN_ON(len > 0xFFF);
 		bc_ent = cpu_to_le16(len | (num_fetch_chunks << 12));
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
index 6c2477eec97d..cf9ec491c086 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
@@ -2095,7 +2095,8 @@ static void iwl_txq_gen1_update_byte_cnt_tbl(struct iwl_trans *trans,
 		len += IEEE80211_WEP_IV_LEN + IEEE80211_WEP_ICV_LEN;
 		break;
 	}
-	if (trans_pcie->txqs.bc_table_dword)
+
+	if (trans->trans_cfg->device_family < IWL_DEVICE_FAMILY_AX210)
 		len = DIV_ROUND_UP(len, 4);
 
 	if (WARN_ON(len > 0xFFF || write_ptr >= TFD_QUEUE_SIZE_MAX))
-- 
2.34.1


