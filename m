Return-Path: <linux-wireless+bounces-28060-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F1EEDBEE0F2
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Oct 2025 10:45:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5E4F64E5555
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Oct 2025 08:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ACDA22FDE6;
	Sun, 19 Oct 2025 08:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WQ6hqqRT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8454629E0F6
	for <linux-wireless@vger.kernel.org>; Sun, 19 Oct 2025 08:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760863538; cv=none; b=cvKKmYYvtgiv8B8UMeH2Qd76KsXQiURF9/EEowWBc9fs6RguoenSLwXgsfdi+OXVkAwUn9gdt3ohcti+YLZvhSYr72VU63K9fMgL3cfhDVVkXEvc/GDNVb8P3n5HSo822hYojegIOWqapTpiF7BkeSLQMrjHb/RIeg1v11NpsjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760863538; c=relaxed/simple;
	bh=Lm9rXFU1wTYxnM5/LNDlvAi2k1fpm4uel3ZfqRmaQMY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HoWHdiDvuS3OpXgz/L9RuHqKX4Q8go1I9Ud3GTdZQxSYkm87Yk1uEyjWPZKBvyeHw45xZpx0ymaYOeTBCSIALRUIYtPszIVOAnjBgHj9SGky+bFJru4r4ZYTSwxGuqlT0TK1D5LDipjp4FCaZScQzAVm81x9fgAHhi6/WnWT5zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WQ6hqqRT; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760863537; x=1792399537;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Lm9rXFU1wTYxnM5/LNDlvAi2k1fpm4uel3ZfqRmaQMY=;
  b=WQ6hqqRTBhvb1vCl2FBnY91HhRTJS0hcUQcfAGpmufwEpNmyuJxUziCl
   VVTDURhFdYEfSXR1cfQo3KucDtivXVzBclESuoJj9parO2acih2wn7sTj
   n6N1nP0RD+wAgFzASPqp5BWIWYRWt4KkXxEKELZhhaMZSfeCFI+gOd1qu
   1prHWfcJZXVrawuuI7tOk+ED8O0RrS3YcqFVSWIaNbdfjo4gXsXczYSjq
   isbESB4aABGo4p9YG4HLxYuFp/k9GY2Zoxi1jDKq6Ilgv5/vG07zDRmFi
   TOrsQBHTtDH0hNUMkKRWs3nvlMJO/adXNLBB28v6mxnc5keHYqWAOIPgw
   Q==;
X-CSE-ConnectionGUID: v4ZngGvqTxSmasmRwdRhxw==
X-CSE-MsgGUID: u2QT/xA9SLGVZ+9gOd/1WA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="74363183"
X-IronPort-AV: E=Sophos;i="6.19,240,1754982000"; 
   d="scan'208";a="74363183"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2025 01:45:36 -0700
X-CSE-ConnectionGUID: 85y7mJbDQa+Yr7CQh2OSOQ==
X-CSE-MsgGUID: 4FCuG50NSBy5DhORd8WT5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,240,1754982000"; 
   d="scan'208";a="182279874"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2025 01:45:35 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH iwlwifi-next 05/15] wifi: iwlwifi: stop checking the firmware's error pointer
Date: Sun, 19 Oct 2025 11:45:06 +0300
Message-Id: <20251019114304.a64d0803150f.Ie2db385f68e17fb0adcdcb16e5bf0125289e177d@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251019084516.2568208-1-miriam.rachel.korenblit@intel.com>
References: <20251019084516.2568208-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

It is not very clear what values we put in min_umac_error_event_table.
For Ma (Meteor Lake), this value is wrong and we get the print:
Not valid error log pointer ...

Just remove the check.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/cfg/22000.c  |  1 -
 drivers/net/wireless/intel/iwlwifi/cfg/8000.c   |  1 -
 drivers/net/wireless/intel/iwlwifi/cfg/9000.c   |  1 -
 drivers/net/wireless/intel/iwlwifi/cfg/ax210.c  |  1 -
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c     |  1 -
 drivers/net/wireless/intel/iwlwifi/cfg/dr.c     |  1 -
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c     |  1 -
 drivers/net/wireless/intel/iwlwifi/iwl-config.h |  2 --
 drivers/net/wireless/intel/iwlwifi/mld/fw.c     |  6 +-----
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c     | 13 ++-----------
 10 files changed, 3 insertions(+), 25 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
index ca488931a33c..f0453f3f6ba6 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
@@ -38,7 +38,6 @@ static const struct iwl_family_base_params iwl_22000_base = {
 	.features = IWL_TX_CSUM_NETIF_FLAGS | NETIF_F_RXCSUM,
 	.apmg_not_supported = true,
 	.mac_addr_from_csr = 0x380,
-	.min_umac_error_event_table = 0x400000,
 	.d3_debug_data_base_addr = 0x401000,
 	.d3_debug_data_length = 60 * 1024,
 	.mon_smem_regs = {
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/8000.c b/drivers/net/wireless/intel/iwlwifi/cfg/8000.c
index b56574006ee0..3c844cd419e8 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/8000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/8000.c
@@ -50,7 +50,6 @@ static const struct iwl_family_base_params iwl8000_base = {
 	.smem_offset = IWL8260_SMEM_OFFSET,
 	.smem_len = IWL8260_SMEM_LEN,
 	.apmg_not_supported = true,
-	.min_umac_error_event_table = 0x800000,
 };
 
 static const struct iwl_tt_params iwl8000_tt_params = {
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/9000.c b/drivers/net/wireless/intel/iwlwifi/cfg/9000.c
index ac1fa291cf2f..5872fc9b8caf 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/9000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/9000.c
@@ -41,7 +41,6 @@ static const struct iwl_family_base_params iwl9000_base = {
 	.features = IWL_TX_CSUM_NETIF_FLAGS | NETIF_F_RXCSUM,
 	.apmg_not_supported = true,
 	.mac_addr_from_csr = 0x380,
-	.min_umac_error_event_table = 0x800000,
 	.d3_debug_data_base_addr = 0x401000,
 	.d3_debug_data_length = 92 * 1024,
 	.nvm_hw_section_num = 10,
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c b/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c
index ddf3d313da5a..582f61661062 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c
@@ -33,7 +33,6 @@ static const struct iwl_family_base_params iwl_ax210_base = {
 	.features = IWL_TX_CSUM_NETIF_FLAGS | NETIF_F_RXCSUM,
 	.apmg_not_supported = true,
 	.mac_addr_from_csr = 0x380,
-	.min_umac_error_event_table = 0x400000,
 	.d3_debug_data_base_addr = 0x401000,
 	.d3_debug_data_length = 60 * 1024,
 	.mon_smem_regs = {
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
index 18c9244ee8ef..7babb60463be 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
@@ -38,7 +38,6 @@ static const struct iwl_family_base_params iwl_bz_base = {
 	.smem_len = IWL_BZ_SMEM_LEN,
 	.apmg_not_supported = true,
 	.mac_addr_from_csr = 0x30,
-	.min_umac_error_event_table = 0xD0000,
 	.d3_debug_data_base_addr = 0x401000,
 	.d3_debug_data_length = 60 * 1024,
 	.mon_smem_regs = {
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/dr.c b/drivers/net/wireless/intel/iwlwifi/cfg/dr.c
index e53a785686c8..ad65951d5643 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/dr.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/dr.c
@@ -33,7 +33,6 @@ static const struct iwl_family_base_params iwl_dr_base = {
 	.smem_len = IWL_DR_SMEM_LEN,
 	.apmg_not_supported = true,
 	.mac_addr_from_csr = 0x30,
-	.min_umac_error_event_table = 0xD0000,
 	.d3_debug_data_base_addr = 0x401000,
 	.d3_debug_data_length = 60 * 1024,
 	.mon_smem_regs = {
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/sc.c b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
index e9449b59114a..abb6283dfb8f 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
@@ -41,7 +41,6 @@ static const struct iwl_family_base_params iwl_sc_base = {
 	.smem_len = IWL_SC_SMEM_LEN,
 	.apmg_not_supported = true,
 	.mac_addr_from_csr = 0x30,
-	.min_umac_error_event_table = 0xD0000,
 	.d3_debug_data_base_addr = 0x401000,
 	.d3_debug_data_length = 60 * 1024,
 	.mon_smem_regs = {
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index 0b34c9f90b3f..e44936204068 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -170,7 +170,6 @@ struct iwl_fw_mon_regs {
  *	for aggregation
  * @min_txq_size: minimum number of slots required in a TX queue
  * @gp2_reg_addr: GP2 (timer) register address
- * @min_umac_error_event_table: minimum SMEM location of UMAC error table
  * @mon_dbgi_regs: monitor DBGI registers
  * @mon_dram_regs: monitor DRAM registers
  * @mon_smem_regs: monitor SMEM registers
@@ -203,7 +202,6 @@ struct iwl_family_base_params {
 	netdev_features_t features;
 	u32 smem_offset;
 	u32 smem_len;
-	u32 min_umac_error_event_table;
 	u32 d3_debug_data_base_addr;
 	u32 d3_debug_data_length;
 	u32 min_txq_size;
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/fw.c b/drivers/net/wireless/intel/iwlwifi/mld/fw.c
index b3abfa1ec810..19da521a4bab 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/fw.c
@@ -167,11 +167,7 @@ static bool iwl_alive_fn(struct iwl_notif_wait_data *notif_wait,
 	umac_error_table = le32_to_cpu(umac->dbg_ptrs.error_info_addr) &
 		~FW_ADDR_CACHE_CONTROL;
 
-	if (umac_error_table >= trans->mac_cfg->base->min_umac_error_event_table)
-		iwl_fw_umac_set_alive_err_table(trans, umac_error_table);
-	else
-		IWL_ERR(mld, "Not valid error log pointer 0x%08X\n",
-			umac_error_table);
+	iwl_fw_umac_set_alive_err_table(trans, umac_error_table);
 
 	alive_data->valid = status == IWL_ALIVE_STATUS_OK;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 6b76ce35443d..edae13755ee6 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -214,17 +214,8 @@ static bool iwl_alive_fn(struct iwl_notif_wait_data *notif_wait,
 							~FW_ADDR_CACHE_CONTROL;
 
 	if (umac_error_table) {
-		if (umac_error_table >=
-		    mvm->trans->mac_cfg->base->min_umac_error_event_table) {
-			iwl_fw_umac_set_alive_err_table(mvm->trans,
-							umac_error_table);
-		} else {
-			IWL_ERR(mvm,
-				"Not valid error log pointer 0x%08X for %s uCode\n",
-				umac_error_table,
-				(mvm->fwrt.cur_fw_img == IWL_UCODE_INIT) ?
-				"Init" : "RT");
-		}
+		iwl_fw_umac_set_alive_err_table(mvm->trans,
+						umac_error_table);
 	}
 
 	alive_data->valid = status == IWL_ALIVE_STATUS_OK;
-- 
2.34.1


