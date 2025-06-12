Return-Path: <linux-wireless+bounces-24062-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A5E9AD6F68
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Jun 2025 13:50:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E37B8177214
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Jun 2025 11:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ABB423D2A5;
	Thu, 12 Jun 2025 11:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MrldOZ46"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69CD23C8C5
	for <linux-wireless@vger.kernel.org>; Thu, 12 Jun 2025 11:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749728967; cv=none; b=rGDZqkKqp/UpUporqOYXidyF5RtUd94pvPi8IgvMychW2x6Krmp/dkKdUzOQ2ZyhJ8N5C+cWDqI/HwFXeQkjNhDZylkDGIzRxBCmmg6FYAuwLpZZOmAjXaBABoYsuQqIEI65HxihDkF4m5JkPbQBbSX3AIqBlrOlkmmk9tFWJrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749728967; c=relaxed/simple;
	bh=wDpGeJrC9XIHsmqB3mX31e2G6EU7QjPYeyp6d/F9oRw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=okYnD+w5feHOz8xynWQjZBIkafKGaCXfphm3CAhuCqovl/GTsMewLfg6fpu+QyBh83poFFlFpOCLiZOix/Qj7+LhYTkMwrzaij3wj16Dh5luzMhWM+7sWu9qv8hyXP7TTRavCAbsJkOMNikJMYnzt9BLNMF2Nhen3tJf/vcHFXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MrldOZ46; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749728967; x=1781264967;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wDpGeJrC9XIHsmqB3mX31e2G6EU7QjPYeyp6d/F9oRw=;
  b=MrldOZ46516m1z0dzjLXHmLMfZE9dXHwOfcdDTjzFG0qvXGX3pXddDBC
   P26LzNskTw1w2bMleqR/bvTw5EnxzmxRN1GLEdrRtfrXshl+QEptC1Kdh
   yqIKSZabovY9XnRvA6nO8GYqKO0K9B966zt99WnJ1vYxs9F2VKWDsWiG3
   xiJjREACjkcWLLMBgjD0CmeFxsnZZw/XgWN8csM4PPLZrqzKqT9BAXzUi
   E9iz7iDdNsIVm81qCIGmS7O+gNIHLiUq7llju08QaNSaBQidrhlmfORDR
   /G6BTqIhjz6KGFPF9hhL19KO5Ugi6jX6pHCA60RCmIUPS4gxhJjCJhCwv
   A==;
X-CSE-ConnectionGUID: R/JF9ziCSwmMzpxjRDClsA==
X-CSE-MsgGUID: s8zyigPpR8itSjhKMmy+iA==
X-IronPort-AV: E=McAfee;i="6800,10657,11461"; a="63248345"
X-IronPort-AV: E=Sophos;i="6.16,230,1744095600"; 
   d="scan'208";a="63248345"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2025 04:49:27 -0700
X-CSE-ConnectionGUID: pZ5d14ClTrCDMjJEYEui/Q==
X-CSE-MsgGUID: ahJfIdFqQeORuMed7Zbe8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,230,1744095600"; 
   d="scan'208";a="147382148"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2025 04:49:24 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Rotem Kerem <rotem.kerem@intel.com>
Subject: [PATCH iwlwifi-next 08/13] wifi: iwlwifi: move iwl_trans_pcie_write_mem to iwl-trans.c
Date: Thu, 12 Jun 2025 14:48:54 +0300
Message-Id: <20250612144708.52034d131773.Ie783304faae7ec3a95a510dfee925838fe6466b4@changeid>
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

Move the iwl_trans_pcie_write_mem function to iwl_trans_write_mem
in iwl-trans.c as it is not specific to PCIe.

Signed-off-by: Rotem Kerem <rotem.kerem@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-trans.c | 14 +++++++++++++-
 .../intel/iwlwifi/pcie/gen1_2/internal.h       |  2 --
 .../wireless/intel/iwlwifi/pcie/gen1_2/trans.c | 18 ------------------
 .../wireless/intel/iwlwifi/pcie/gen1_2/tx.c    | 11 +++++------
 4 files changed, 18 insertions(+), 27 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.c b/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
index 5dba76b009a6..78808c956444 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
@@ -497,7 +497,19 @@ IWL_EXPORT_SYMBOL(iwl_trans_read_mem);
 int iwl_trans_write_mem(struct iwl_trans *trans, u32 addr,
 			const void *buf, int dwords)
 {
-	return iwl_trans_pcie_write_mem(trans, addr, buf, dwords);
+	int offs, ret = 0;
+	const u32 *vals = buf;
+
+	if (iwl_trans_grab_nic_access(trans)) {
+		iwl_write32(trans, HBUS_TARG_MEM_WADDR, addr);
+		for (offs = 0; offs < dwords; offs++)
+			iwl_write32(trans, HBUS_TARG_MEM_WDAT,
+				    vals ? vals[offs] : 0);
+		iwl_trans_release_nic_access(trans);
+	} else {
+		ret = -EBUSY;
+	}
+	return ret;
 }
 IWL_EXPORT_SYMBOL(iwl_trans_write_mem);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/internal.h b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/internal.h
index 52c6c22e2cc6..007f63a8d3c8 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/internal.h
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/internal.h
@@ -1089,8 +1089,6 @@ u32 iwl_trans_pcie_read_prph(struct iwl_trans *trans, u32 reg);
 void iwl_trans_pcie_write_prph(struct iwl_trans *trans, u32 addr, u32 val);
 int iwl_trans_pcie_read_mem(struct iwl_trans *trans, u32 addr,
 			    void *buf, int dwords);
-int iwl_trans_pcie_write_mem(struct iwl_trans *trans, u32 addr,
-			     const void *buf, int dwords);
 int iwl_trans_pcie_sw_reset(struct iwl_trans *trans, bool retake_ownership);
 struct iwl_trans_dump_data *
 iwl_trans_pcie_dump_data(struct iwl_trans *trans, u32 dump_mask,
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
index c31a62b8f925..174bfc66c285 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
@@ -2485,24 +2485,6 @@ int iwl_trans_pcie_read_mem(struct iwl_trans *trans, u32 addr,
 	return 0;
 }
 
-int iwl_trans_pcie_write_mem(struct iwl_trans *trans, u32 addr,
-			     const void *buf, int dwords)
-{
-	int offs, ret = 0;
-	const u32 *vals = buf;
-
-	if (iwl_trans_grab_nic_access(trans)) {
-		iwl_write32(trans, HBUS_TARG_MEM_WADDR, addr);
-		for (offs = 0; offs < dwords; offs++)
-			iwl_write32(trans, HBUS_TARG_MEM_WDAT,
-				    vals ? vals[offs] : 0);
-		iwl_trans_release_nic_access(trans);
-	} else {
-		ret = -EBUSY;
-	}
-	return ret;
-}
-
 int iwl_trans_pcie_read_config32(struct iwl_trans *trans, u32 ofs,
 				 u32 *val)
 {
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/tx.c b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/tx.c
index 7abd7c7daa89..e39451d27a93 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/tx.c
@@ -494,9 +494,9 @@ void iwl_pcie_tx_start(struct iwl_trans *trans)
 		iwl_read_prph(trans, SCD_SRAM_BASE_ADDR);
 
 	/* reset context data, TX status and translation data */
-	iwl_trans_pcie_write_mem(trans, trans_pcie->scd_base_addr +
-					SCD_CONTEXT_MEM_LOWER_BOUND,
-				 NULL, clear_dwords);
+	iwl_trans_write_mem(trans, trans_pcie->scd_base_addr +
+				   SCD_CONTEXT_MEM_LOWER_BOUND,
+			    NULL, clear_dwords);
 
 	iwl_write_prph(trans, SCD_DRAM_BASE_ADDR,
 		       trans_pcie->txqs.scd_bc_tbls.dma >> 10);
@@ -1292,9 +1292,8 @@ void iwl_trans_pcie_txq_disable(struct iwl_trans *trans, int txq_id,
 	if (configure_scd) {
 		iwl_scd_txq_set_inactive(trans, txq_id);
 
-		iwl_trans_pcie_write_mem(trans, stts_addr,
-					 (const void *)zero_val,
-					 ARRAY_SIZE(zero_val));
+		iwl_trans_write_mem(trans, stts_addr, (const void *)zero_val,
+				    ARRAY_SIZE(zero_val));
 	}
 
 	iwl_pcie_txq_unmap(trans, txq_id);
-- 
2.34.1


