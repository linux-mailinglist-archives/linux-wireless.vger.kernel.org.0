Return-Path: <linux-wireless+bounces-22355-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50F6DAA72BB
	for <lists+linux-wireless@lfdr.de>; Fri,  2 May 2025 14:58:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 223A71BC35DA
	for <lists+linux-wireless@lfdr.de>; Fri,  2 May 2025 12:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A58B255F2A;
	Fri,  2 May 2025 12:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hVfzi0Uj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F148255E53
	for <linux-wireless@vger.kernel.org>; Fri,  2 May 2025 12:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746190628; cv=none; b=mjiFzLXeCaXqZsK1u1Na4HGWXiWJfhIBTIksqizJiQtozPR65LiWx6KFKKxONF+H65HpxJeqKj2ALXgMOJNE7fcmBN6fb2DB62CxK5vniQN4R2+C1wAKTy7QvKcgh95nb8/pP7OPXK/DtPxlwJmV9SJ0qqm8crDboE/u+89b460=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746190628; c=relaxed/simple;
	bh=OuEWQJY0TVzuRVTr8kjhAYzirPnzeyukCqBa7/jQubk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FrNqSxi5mVeTfCu7BjcE3ZuZLcMu2nKDl5+IbpXZHZlQSSEnYpSjsEXm9AwzGTSkeDuXANJealVPIKFZi56lL7Gb6mg9G9IxnvCfk9VMYbz3Ow+QDT6vXGRHOfPhYbu/Z5HuB1O1IVGWRClRhmP1lgbbhC9S+GWzmFdG6secjjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hVfzi0Uj; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746190627; x=1777726627;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OuEWQJY0TVzuRVTr8kjhAYzirPnzeyukCqBa7/jQubk=;
  b=hVfzi0UjjSxNd8cY41tFsvTZQkaD/NMEvc3svUSKL95g2bOaHyCnhmEU
   XcMc9yKk6RT4cooRqJow5bHqUw486r66TY4a4bsv06IV44+9HUcNYjWLB
   bONmhrkakU1S66WR6OBbay3z45ptr9Wp/I8zct4sR13Z+7c8e7YQxL/Ey
   2waKeJ7NkckXgeWSDpr9UVtl3e5a2L3Qv3JD7ctBrTemftscZ4MaYTz3H
   wGZu6vXPdhXGd9bKVHRWbqwLafXCl8iMfa5fnp8RP0mYN3+wEH7iatttr
   al/lu4GyApDDcVkMhwH0Jae8D4BYCZsM4/De98cRrP1zkR7YpimhsNXDW
   Q==;
X-CSE-ConnectionGUID: iFg8P/mgQQi1hCfxkWANiQ==
X-CSE-MsgGUID: f/7M3GbqTZ241dnM8i5Ezw==
X-IronPort-AV: E=McAfee;i="6700,10204,11421"; a="59255566"
X-IronPort-AV: E=Sophos;i="6.15,256,1739865600"; 
   d="scan'208";a="59255566"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2025 05:57:07 -0700
X-CSE-ConnectionGUID: Ehky+E/rTASXjQvYNJjDNw==
X-CSE-MsgGUID: BLU/HN28SbCXEzli1N1Bfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,256,1739865600"; 
   d="scan'208";a="165554762"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2025 05:57:05 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: miriam.rachel.korenblit@intel.com
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Yedidya Ben Shimol <yedidya.ben.shimol@intel.com>
Subject: [PATCH iwlwifi-next 13/15] wifi: iwlwifi: pcie: don't call itself indirectly
Date: Fri,  2 May 2025 15:56:29 +0300
Message-Id: <20250502155404.52db0b9fba15.I062e766ded86f61ec86104c28b84767f1c29ea78@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250502125631.3184319-1-miriam.rachel.korenblit@intel.com>
References: <20250502125631.3184319-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

There's no reason for pcie code to call itself indirectly,
directly use the pcie functions instead.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Reviewed-by: Yedidya Ben Shimol <yedidya.ben.shimol@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/pcie/trans-gen2.c    |  4 ++--
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c     |  4 ++--
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c        | 13 +++++++------
 3 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
index abddaffcaaf0..bc19f082a8f5 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
@@ -81,7 +81,7 @@ static void iwl_pcie_gen2_apm_stop(struct iwl_trans *trans, bool op_mode_leave)
 	/* Stop device's DMA activity */
 	iwl_pcie_apm_stop_master(trans);
 
-	iwl_trans_sw_reset(trans, false);
+	iwl_trans_pcie_sw_reset(trans, false);
 
 	/*
 	 * Clear "initialization complete" bit to move adapter from
@@ -200,7 +200,7 @@ static void _iwl_trans_pcie_gen2_stop_device(struct iwl_trans *trans)
 	iwl_pcie_gen2_apm_stop(trans, false);
 
 	/* re-take ownership to prevent other users from stealing the device */
-	iwl_trans_sw_reset(trans, true);
+	iwl_trans_pcie_sw_reset(trans, true);
 
 	/*
 	 * Upon stop, the IVAR table gets erased, so msi-x won't
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index 2a6b9f80360d..904922581b42 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -3552,8 +3552,8 @@ iwl_trans_pcie_dump_monitor(struct iwl_trans *trans,
 				       trans->dbg.dest_tlv->base_shift;
 			}
 
-			iwl_trans_read_mem(trans, base, fw_mon_data->data,
-					   monitor_len / sizeof(u32));
+			iwl_trans_pcie_read_mem(trans, base, fw_mon_data->data,
+						monitor_len / sizeof(u32));
 		} else if (trans->dbg.dest_tlv->monitor_mode == MARBH_MODE) {
 			monitor_len =
 				iwl_trans_pci_dump_marbh_monitor(trans,
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
index bb90bcfc6763..7c8cab294321 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
@@ -497,9 +497,9 @@ void iwl_pcie_tx_start(struct iwl_trans *trans, u32 scd_base_addr)
 		scd_base_addr != trans_pcie->scd_base_addr);
 
 	/* reset context data, TX status and translation data */
-	iwl_trans_write_mem(trans, trans_pcie->scd_base_addr +
-				   SCD_CONTEXT_MEM_LOWER_BOUND,
-			    NULL, clear_dwords);
+	iwl_trans_pcie_write_mem(trans, trans_pcie->scd_base_addr +
+					SCD_CONTEXT_MEM_LOWER_BOUND,
+				 NULL, clear_dwords);
 
 	iwl_write_prph(trans, SCD_DRAM_BASE_ADDR,
 		       trans_pcie->txqs.scd_bc_tbls.dma >> 10);
@@ -1293,8 +1293,9 @@ void iwl_trans_pcie_txq_disable(struct iwl_trans *trans, int txq_id,
 	if (configure_scd) {
 		iwl_scd_txq_set_inactive(trans, txq_id);
 
-		iwl_trans_write_mem(trans, stts_addr, (const void *)zero_val,
-				    ARRAY_SIZE(zero_val));
+		iwl_trans_pcie_write_mem(trans, stts_addr,
+					 (const void *)zero_val,
+					 ARRAY_SIZE(zero_val));
 	}
 
 	iwl_pcie_txq_unmap(trans, txq_id);
@@ -2594,7 +2595,7 @@ static int iwl_trans_pcie_send_hcmd_sync(struct iwl_trans *trans,
 			       cmd_str);
 		ret = -ETIMEDOUT;
 
-		iwl_trans_sync_nmi(trans);
+		iwl_trans_pcie_sync_nmi(trans);
 		goto cancel;
 	}
 
-- 
2.34.1


