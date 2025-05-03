Return-Path: <linux-wireless+bounces-22370-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27589AA825A
	for <lists+linux-wireless@lfdr.de>; Sat,  3 May 2025 21:45:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86D0017CD85
	for <lists+linux-wireless@lfdr.de>; Sat,  3 May 2025 19:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B05D27E7FA;
	Sat,  3 May 2025 19:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q0Zy+wF9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1AB27E7D8
	for <linux-wireless@vger.kernel.org>; Sat,  3 May 2025 19:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746301497; cv=none; b=fiX+CZL6VhwdfDshWsamPWow+nZBCrfgJPMLmwgxTGvAn1RyO06yYWzz1qkqdxssVOShKp8ic27jVAdIED/A2UGWrJQbmvYyAXm0oPoOaXikn01UUVyCQSPKCOoD1A9D6Srx5aaYf9NmkZq+J7wDjay/SFNHORinvUZDd7P8QpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746301497; c=relaxed/simple;
	bh=jTdXv7egadhBKSd34IvOOM4NAVE5uXB10GGZUYubztU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BUaDCHPJBNp2M0+bn5+kMI69gxQZCGRyN4gUXdhudYTLiCTjilh2+khg6Ze7Y3JnBvCvA/TqomZ8XZ6RvcDw3yRI35vBmwiD+YQMtHxJ9uEBwnApIjzx4s4ReA2BN9brRuc5sN4+k64XXIebe797xs5Kv5+kiMcBMrmga43JwOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q0Zy+wF9; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746301495; x=1777837495;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jTdXv7egadhBKSd34IvOOM4NAVE5uXB10GGZUYubztU=;
  b=Q0Zy+wF9pBRcULE0hR+E5if2aTFpJP44CmyRV4LQrupJ/knnUoYcGoAS
   CSq6jFXk1f4QPolXnw4JYHwxhGWE3/YDgqrN3V0gO0Csn66Af+0QvJFWB
   2xo9J7HXGlVsvRnwpWM7Db1uSagLzKAq9c+ovD+7/Jy4aIBPx1fXX+P+h
   /HkzqUbRGJKULgz6V4tnYzqLJOR/C3uF+xOEpC/PEMP/l3FSNCV/pMn2S
   MgpU2AdQ55KiKQyb27uADkJ0d7tE5g8lMY2d6e9Yr+OaSznROr5EQr0go
   hfpIKimkVUg7D47XOB6qzXMKfC7HU0qiM0ln9aVQAMClIwemjigz2tNvF
   w==;
X-CSE-ConnectionGUID: 7HYb2qgQQaKw71IzQLLEqg==
X-CSE-MsgGUID: EfSDXJeSQGWfG1VODTt5Og==
X-IronPort-AV: E=McAfee;i="6700,10204,11422"; a="58613259"
X-IronPort-AV: E=Sophos;i="6.15,258,1739865600"; 
   d="scan'208";a="58613259"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2025 12:44:55 -0700
X-CSE-ConnectionGUID: oPIZJtHqSui0N+yl6wKmOw==
X-CSE-MsgGUID: Oo7BSoo/RkGr73+EG0pbOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,258,1739865600"; 
   d="scan'208";a="134644268"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2025 12:44:53 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: miriam.rachel.korenblit@intel.com
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH iwlwifi-next 03/15] wifi: iwlwifi: pcie: move invalid TX CMD into PCIe
Date: Sat,  3 May 2025 22:44:22 +0300
Message-Id: <20250503224231.d4916769a25b.Ife9b0283e50023efb6b3f44e81a6ff3885fe5a8d@changeid>
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

There's no reason for this to be in the generic transport
struct, move it into the PCIe code.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-trans.h     | 3 ---
 drivers/net/wireless/intel/iwlwifi/pcie/internal.h | 9 +++++++--
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c    | 9 ++++++---
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c       | 6 ++++--
 4 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index e956fcd89821..771e4a3e05f5 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -878,7 +878,6 @@ struct iwl_txq {
  * @mbx_addr_1_step: step address data 1
  * @pcie_link_speed: current PCIe link speed (%PCI_EXP_LNKSTA_CLS_*),
  *	only valid for discrete (not integrated) NICs
- * @invalid_tx_cmd: invalid TX command buffer
  * @reduced_cap_sku: reduced capability supported SKU
  * @step_urm: STEP is in URM, no support for MCS>9 in 320 MHz
  * @restart: restart worker data
@@ -962,8 +961,6 @@ struct iwl_trans {
 
 	u8 pcie_link_speed;
 
-	struct iwl_dma_ptr invalid_tx_cmd;
-
 	struct {
 		struct delayed_work wk;
 		struct iwl_fw_error_dump_mode mode;
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
index 2cf2936dbf2d..6eee20ffbfc8 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
@@ -423,6 +423,7 @@ struct iwl_pcie_txqs {
  * @me_present: WiAMT/CSME is detected as present (1), not present (0)
  *	or unknown (-1, so can still use it as a boolean safely)
  * @me_recheck_wk: worker to recheck WiAMT/CSME presence
+ * @invalid_tx_cmd: invalid TX command buffer
  */
 struct iwl_trans_pcie {
 	struct iwl_rxq *rxq;
@@ -525,6 +526,8 @@ struct iwl_trans_pcie {
 
 	s8 me_present;
 	struct delayed_work me_recheck_wk;
+
+	struct iwl_dma_ptr invalid_tx_cmd;
 };
 
 static inline struct iwl_trans_pcie *
@@ -758,10 +761,12 @@ int iwl_txq_gen2_set_tb(struct iwl_trans *trans,
 static inline void iwl_txq_set_tfd_invalid_gen2(struct iwl_trans *trans,
 						struct iwl_tfh_tfd *tfd)
 {
+	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
+
 	tfd->num_tbs = 0;
 
-	iwl_txq_gen2_set_tb(trans, tfd, trans->invalid_tx_cmd.dma,
-			    trans->invalid_tx_cmd.size);
+	iwl_txq_gen2_set_tb(trans, tfd, trans_pcie->invalid_tx_cmd.dma,
+			    trans_pcie->invalid_tx_cmd.size);
 }
 
 void iwl_txq_gen2_tfd_unmap(struct iwl_trans *trans,
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index 547adc45f164..bfde1e3dc74c 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -2026,11 +2026,14 @@ void iwl_trans_pcie_free_pnvm_dram_regions(struct iwl_dram_regions *dram_regions
 
 static void iwl_pcie_free_invalid_tx_cmd(struct iwl_trans *trans)
 {
-	iwl_pcie_free_dma_ptr(trans, &trans->invalid_tx_cmd);
+	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
+
+	iwl_pcie_free_dma_ptr(trans, &trans_pcie->invalid_tx_cmd);
 }
 
 static int iwl_pcie_alloc_invalid_tx_cmd(struct iwl_trans *trans)
 {
+	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 	struct iwl_cmd_header_wide bad_cmd = {
 		.cmd = INVALID_WR_PTR_CMD,
 		.group_id = DEBUG_GROUP,
@@ -2040,11 +2043,11 @@ static int iwl_pcie_alloc_invalid_tx_cmd(struct iwl_trans *trans)
 	};
 	int ret;
 
-	ret = iwl_pcie_alloc_dma_ptr(trans, &trans->invalid_tx_cmd,
+	ret = iwl_pcie_alloc_dma_ptr(trans, &trans_pcie->invalid_tx_cmd,
 				     sizeof(bad_cmd));
 	if (ret)
 		return ret;
-	memcpy(trans->invalid_tx_cmd.addr, &bad_cmd, sizeof(bad_cmd));
+	memcpy(trans_pcie->invalid_tx_cmd.addr, &bad_cmd, sizeof(bad_cmd));
 	return 0;
 }
 
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
index 7c8cab294321..c728722533a8 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
@@ -280,10 +280,12 @@ iwl_txq_gen1_tfd_tb_get_addr(struct iwl_tfd *tfd, u8 idx)
 static void iwl_txq_set_tfd_invalid_gen1(struct iwl_trans *trans,
 					 struct iwl_tfd *tfd)
 {
+	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
+
 	tfd->num_tbs = 0;
 
-	iwl_pcie_gen1_tfd_set_tb(tfd, 0, trans->invalid_tx_cmd.dma,
-				 trans->invalid_tx_cmd.size);
+	iwl_pcie_gen1_tfd_set_tb(tfd, 0, trans_pcie->invalid_tx_cmd.dma,
+				 trans_pcie->invalid_tx_cmd.size);
 }
 
 static void iwl_txq_gen1_tfd_unmap(struct iwl_trans *trans,
-- 
2.34.1


