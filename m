Return-Path: <linux-wireless+bounces-24064-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 905D4AD6F70
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Jun 2025 13:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 128793B1ADE
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Jun 2025 11:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0417242D84;
	Thu, 12 Jun 2025 11:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gPO7n01S"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AEF223E226
	for <linux-wireless@vger.kernel.org>; Thu, 12 Jun 2025 11:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749728969; cv=none; b=lh4oJGcvf4JCl/m0MXQqbu9lP8Jlpf08PDqeXkdRIvVe9CIrYe5f6AgpdI5kXe6rV3wVkN41/csxdL5HybfoHNel79JAT1tk215T+x9/6hYrWDeTN0cqUnR5h8cV63V2wGMGnW3bn3J3cXt/rtEMcgWCVDZsr9IxYjV25Kv9cag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749728969; c=relaxed/simple;
	bh=OTabgXKvZi6w5k2UoY1Kpq/TjaJ/ZoS6LBcnx5T4xCI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ns4wE18P+2HULkOLMk03VQutRl/S71wttAyfPPlJ0tx3hxKLNM0JcxlZcSMLQnBtxCWyteg60B3fJgIqBOxmhW4K9CQCcaNyY1xnUPtgKXM5oIes0QvLvTWz4g0Zj5Jzgg1pE1NRxHghr0y139mecWVO7JV0xSZMV/5yFMK+2cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gPO7n01S; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749728968; x=1781264968;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OTabgXKvZi6w5k2UoY1Kpq/TjaJ/ZoS6LBcnx5T4xCI=;
  b=gPO7n01Sn1PoMD1x7gxoQFASJDI+5lHKyN5n15ZIQdexkm9ABFEt0n/b
   XKXsoUagrSgPtVyVOj9mVoQGhWftVGJR3w5HYJa5MkrKex9pnzi0OSx0f
   imaQyqcQ+l9U3Nb0KdgYzhqwLR/a7rYJfQiruJ3uEoC4JTZa2MyeNVYxe
   J867SgGTaiDtf66+9t9Lxwt+zOV47qFr88zboa7SDWpWiKCIzKzRpKdCh
   ylz9bbzekQASl4+gFuEZRgPJPqJg3ZlJop6/QDG9fwrDnhqZRrhNlRUZ2
   Wo0T+0Jd6zFrZNgcgPLQ6XqGUh04oCa+og5rjPNu/5w0DXusqC42ezqmP
   A==;
X-CSE-ConnectionGUID: pDpAo9wASL6hDGTqwwOWHg==
X-CSE-MsgGUID: YJudlm9/QFCLdUF7wBSCRg==
X-IronPort-AV: E=McAfee;i="6800,10657,11461"; a="63248347"
X-IronPort-AV: E=Sophos;i="6.16,230,1744095600"; 
   d="scan'208";a="63248347"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2025 04:49:28 -0700
X-CSE-ConnectionGUID: 3HLBE3toT+m0YVokxue+SA==
X-CSE-MsgGUID: j3DDp/SUSqqtkioLayl54Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,230,1744095600"; 
   d="scan'208";a="147382167"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2025 04:49:27 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Rotem Kerem <rotem.kerem@intel.com>
Subject: [PATCH iwlwifi-next 10/13] wifi: iwlwifi: move _iwl_trans_set_bits_mask utilities
Date: Thu, 12 Jun 2025 14:48:56 +0300
Message-Id: <20250612144708.4049f1eda9fa.Iddcb6f7437beee2cfe232315384d8517b40c56d1@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250612114859.3094387-1-miriam.rachel.korenblit@intel.com>
References: <20250612114859.3094387-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Rotem Kerem <rotem.kerem@intel.com>

Move set_bits_mask utility functions to utils.h as they are generic
utilities and is not hardware-dependent.

Signed-off-by: Rotem Kerem <rotem.kerem@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../intel/iwlwifi/pcie/gen1_2/internal.h      | 27 ------------------
 .../intel/iwlwifi/pcie/gen1_2/trans.c         | 28 +++++++++----------
 .../wireless/intel/iwlwifi/pcie/gen1_2/tx.c   |  5 ++--
 .../net/wireless/intel/iwlwifi/pcie/utils.h   | 27 ++++++++++++++++++
 4 files changed, 44 insertions(+), 43 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/internal.h b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/internal.h
index 007f63a8d3c8..23c0771a4231 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/internal.h
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/internal.h
@@ -1034,33 +1034,6 @@ static inline bool iwl_is_rfkill_set(struct iwl_trans *trans)
 		CSR_GP_CNTRL_REG_FLAG_HW_RF_KILL_SW);
 }
 
-static inline void __iwl_trans_pcie_set_bits_mask(struct iwl_trans *trans,
-						  u32 reg, u32 mask, u32 value)
-{
-	u32 v;
-
-#ifdef CONFIG_IWLWIFI_DEBUG
-	WARN_ON_ONCE(value & ~mask);
-#endif
-
-	v = iwl_read32(trans, reg);
-	v &= ~mask;
-	v |= value;
-	iwl_write32(trans, reg, v);
-}
-
-static inline void __iwl_trans_pcie_clear_bit(struct iwl_trans *trans,
-					      u32 reg, u32 mask)
-{
-	__iwl_trans_pcie_set_bits_mask(trans, reg, mask, 0);
-}
-
-static inline void __iwl_trans_pcie_set_bit(struct iwl_trans *trans,
-					    u32 reg, u32 mask)
-{
-	__iwl_trans_pcie_set_bits_mask(trans, reg, mask, mask);
-}
-
 static inline bool iwl_pcie_dbg_on(struct iwl_trans *trans)
 {
 	return (trans->dbg.dest_tlv || iwl_trans_dbg_ini_valid(trans));
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
index 174bfc66c285..97e90cbeb6cd 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
@@ -294,8 +294,8 @@ static void iwl_pcie_apm_lp_xtal_enable(struct iwl_trans *trans)
 	u32 dl_cfg_reg;
 
 	/* Force XTAL ON */
-	__iwl_trans_pcie_set_bit(trans, CSR_GP_CNTRL,
-				 CSR_GP_CNTRL_REG_FLAG_XTAL_ON);
+	iwl_trans_set_bit(trans, CSR_GP_CNTRL,
+			  CSR_GP_CNTRL_REG_FLAG_XTAL_ON);
 
 	ret = iwl_trans_pcie_sw_reset(trans, true);
 
@@ -304,8 +304,8 @@ static void iwl_pcie_apm_lp_xtal_enable(struct iwl_trans *trans)
 
 	if (WARN_ON(ret)) {
 		/* Release XTAL ON request */
-		__iwl_trans_pcie_clear_bit(trans, CSR_GP_CNTRL,
-					   CSR_GP_CNTRL_REG_FLAG_XTAL_ON);
+		iwl_trans_clear_bit(trans, CSR_GP_CNTRL,
+				    CSR_GP_CNTRL_REG_FLAG_XTAL_ON);
 		return;
 	}
 
@@ -356,12 +356,12 @@ static void iwl_pcie_apm_lp_xtal_enable(struct iwl_trans *trans)
 	iwl_clear_bit(trans, CSR_GP_CNTRL, CSR_GP_CNTRL_REG_FLAG_INIT_DONE);
 
 	/* Activates XTAL resources monitor */
-	__iwl_trans_pcie_set_bit(trans, CSR_MONITOR_CFG_REG,
-				 CSR_MONITOR_XTAL_RESOURCES);
+	iwl_trans_set_bit(trans, CSR_MONITOR_CFG_REG,
+			  CSR_MONITOR_XTAL_RESOURCES);
 
 	/* Release XTAL ON request */
-	__iwl_trans_pcie_clear_bit(trans, CSR_GP_CNTRL,
-				   CSR_GP_CNTRL_REG_FLAG_XTAL_ON);
+	iwl_trans_clear_bit(trans, CSR_GP_CNTRL,
+			    CSR_GP_CNTRL_REG_FLAG_XTAL_ON);
 	udelay(10);
 
 	/* Release APMG XTAL */
@@ -2330,7 +2330,7 @@ bool __iwl_trans_pcie_grab_nic_access(struct iwl_trans *trans, bool silent)
 	}
 
 	/* this bit wakes up the NIC */
-	__iwl_trans_pcie_set_bit(trans, CSR_GP_CNTRL, write);
+	iwl_trans_set_bit(trans, CSR_GP_CNTRL, write);
 	if (trans->mac_cfg->device_family >= IWL_DEVICE_FAMILY_8000)
 		udelay(2);
 
@@ -2419,11 +2419,11 @@ iwl_trans_pcie_release_nic_access(struct iwl_trans *trans)
 	if (trans_pcie->cmd_hold_nic_awake)
 		goto out;
 	if (trans->mac_cfg->device_family >= IWL_DEVICE_FAMILY_BZ)
-		__iwl_trans_pcie_clear_bit(trans, CSR_GP_CNTRL,
-					   CSR_GP_CNTRL_REG_FLAG_BZ_MAC_ACCESS_REQ);
+		iwl_trans_clear_bit(trans, CSR_GP_CNTRL,
+				    CSR_GP_CNTRL_REG_FLAG_BZ_MAC_ACCESS_REQ);
 	else
-		__iwl_trans_pcie_clear_bit(trans, CSR_GP_CNTRL,
-					   CSR_GP_CNTRL_REG_FLAG_MAC_ACCESS_REQ);
+		iwl_trans_clear_bit(trans, CSR_GP_CNTRL,
+				    CSR_GP_CNTRL_REG_FLAG_MAC_ACCESS_REQ);
 	/*
 	 * Above we read the CSR_GP_CNTRL register, which will flush
 	 * any previous writes, but we need the write that clears the
@@ -2604,7 +2604,7 @@ void iwl_trans_pcie_set_bits_mask(struct iwl_trans *trans, u32 reg,
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 
 	spin_lock_bh(&trans_pcie->reg_lock);
-	__iwl_trans_pcie_set_bits_mask(trans, reg, mask, value);
+	_iwl_trans_set_bits_mask(trans, reg, mask, value);
 	spin_unlock_bh(&trans_pcie->reg_lock);
 }
 
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/tx.c b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/tx.c
index e39451d27a93..6b052b36dfa7 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/tx.c
@@ -25,6 +25,7 @@
 #include "iwl-op-mode.h"
 #include "internal.h"
 #include "fw/api/tx.h"
+#include "pcie/utils.h"
 
 /*************** DMA-QUEUE-GENERAL-FUNCTIONS  *****
  * DMA services
@@ -203,8 +204,8 @@ static void iwl_pcie_clear_cmd_in_flight(struct iwl_trans *trans)
 	}
 
 	trans_pcie->cmd_hold_nic_awake = false;
-	__iwl_trans_pcie_clear_bit(trans, CSR_GP_CNTRL,
-				   CSR_GP_CNTRL_REG_FLAG_MAC_ACCESS_REQ);
+	iwl_trans_clear_bit(trans, CSR_GP_CNTRL,
+			    CSR_GP_CNTRL_REG_FLAG_MAC_ACCESS_REQ);
 	spin_unlock(&trans_pcie->reg_lock);
 }
 
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/utils.h b/drivers/net/wireless/intel/iwlwifi/pcie/utils.h
index af2a2eec7ec5..031dfdf4bba4 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/utils.h
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/utils.h
@@ -8,4 +8,31 @@
 
 void iwl_trans_pcie_dump_regs(struct iwl_trans *trans, struct pci_dev *pdev);
 
+static inline void _iwl_trans_set_bits_mask(struct iwl_trans *trans,
+					    u32 reg, u32 mask, u32 value)
+{
+	u32 v;
+
+#ifdef CONFIG_IWLWIFI_DEBUG
+	WARN_ON_ONCE(value & ~mask);
+#endif
+
+	v = iwl_read32(trans, reg);
+	v &= ~mask;
+	v |= value;
+	iwl_write32(trans, reg, v);
+}
+
+static inline void iwl_trans_clear_bit(struct iwl_trans *trans,
+				       u32 reg, u32 mask)
+{
+	_iwl_trans_set_bits_mask(trans, reg, mask, 0);
+}
+
+static inline void iwl_trans_set_bit(struct iwl_trans *trans,
+				     u32 reg, u32 mask)
+{
+	_iwl_trans_set_bits_mask(trans, reg, mask, mask);
+}
+
 #endif /* __iwl_pcie_utils_h__ */
-- 
2.34.1


