Return-Path: <linux-wireless+bounces-25829-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C979B0D4AB
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jul 2025 10:30:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27E881AA0092
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jul 2025 08:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ABC92DCBE0;
	Tue, 22 Jul 2025 08:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aXGqr1os"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF862DBF76
	for <linux-wireless@vger.kernel.org>; Tue, 22 Jul 2025 08:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753172991; cv=none; b=epmRji9pusokeb4O3cXQAwRc2kQvfSQVHXGhNBt6du4XegJUB/TTwuVxTIaY0bA7PbOvklU2FPRDLsOpLthljFDDUtfhNCF4kIABXPzE6EImO1RuqC8Gyo+b2EqQ2D8MVCG8i/TWliM/XmQa2obJNCfoz5mJHPxpURGQZNVZNbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753172991; c=relaxed/simple;
	bh=tkooIDmNHT8ZUzqTja3fAmKm0/p9kGoj+n5t0EqHvGo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GKD0HVDqfZGkohoydwrlA37ewkgySHII/KvdxkgI6i2BLeUBuTaMreQfDbjXReOL2z28MlQj9DhypEhkpjYsvxkaFxmqbvd2ATXZXdgVeSRqI2GiUhDkTbnOZ4I//WEpwWoN6vHyzIqdWiuE1NlsOGctXMngHq6TI5Y6oxPh+DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aXGqr1os; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753172990; x=1784708990;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tkooIDmNHT8ZUzqTja3fAmKm0/p9kGoj+n5t0EqHvGo=;
  b=aXGqr1oseEZrdHUdUejWjAQDqc8e80aIIemkRa8QzZDyse0QKCb1VudK
   zoLfhZWAFDQim1TODWgHUA8VyHGdqqfC+pjtYeptjRi93CGJqA68Z4VeW
   LaTYY4XqrHpW0n14wkISyMecSkjuL+pAlYHaxSYVFagwX9uUVsXSngTJZ
   k9NBiaY2SrVrWA8TQzm4QQdJ0vo9karzg8QSbyceEpNN5vL9taCn83FSp
   JCouQ6y9b0IALAL21CJZ8hJj6oHfsolgh91GwXQ4AC2cIK2JIWwpbK5q3
   7h20gGPZioYcCbMQ8mQyGdkYDcKIwfXQsgZc2K7FNJHYrE1PI8P1AAEFJ
   g==;
X-CSE-ConnectionGUID: mV8vY6PMRbiRprwFZXxvSg==
X-CSE-MsgGUID: WI4x9dpLQriSBZzvMIlWgA==
X-IronPort-AV: E=McAfee;i="6800,10657,11499"; a="55569970"
X-IronPort-AV: E=Sophos;i="6.16,331,1744095600"; 
   d="scan'208";a="55569970"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 01:29:50 -0700
X-CSE-ConnectionGUID: Y0Mp5FRyQXGysrnnPcy+Vg==
X-CSE-MsgGUID: rkNceODfTZ6F7lt35RmrCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,331,1744095600"; 
   d="scan'208";a="163124315"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 01:29:48 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 14/15] wifi: iwlwifi: don't export symbols that we shouldn't
Date: Tue, 22 Jul 2025 11:29:09 +0300
Message-Id: <20250722112718.a3c5c2182708.Ib8abe63c9b25ef1e4ae1bc167cb23fe34bb3682a@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250722082910.1206370-1-miriam.rachel.korenblit@intel.com>
References: <20250722082910.1206370-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

Functions that are not called from the opmodes shouldn't be exported.

Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-io.c    |  6 ------
 drivers/net/wireless/intel/iwlwifi/iwl-trans.c | 16 ----------------
 2 files changed, 22 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-io.c b/drivers/net/wireless/intel/iwlwifi/iwl-io.c
index ad857a05d3c3..5e483a55a4ba 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-io.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-io.c
@@ -75,7 +75,6 @@ u32 iwl_read_direct32(struct iwl_trans *trans, u32 reg)
 	/* return as if we have a HW timeout/failure */
 	return 0x5a5a5a5a;
 }
-IWL_EXPORT_SYMBOL(iwl_read_direct32);
 
 void iwl_write_direct32(struct iwl_trans *trans, u32 reg, u32 value)
 {
@@ -93,7 +92,6 @@ void iwl_write_direct64(struct iwl_trans *trans, u64 reg, u64 value)
 		iwl_trans_release_nic_access(trans);
 	}
 }
-IWL_EXPORT_SYMBOL(iwl_write_direct64);
 
 int iwl_poll_direct_bit(struct iwl_trans *trans, u32 addr, u32 mask,
 			int timeout)
@@ -109,7 +107,6 @@ int iwl_poll_direct_bit(struct iwl_trans *trans, u32 addr, u32 mask,
 
 	return -ETIMEDOUT;
 }
-IWL_EXPORT_SYMBOL(iwl_poll_direct_bit);
 
 u32 iwl_read_prph_no_grab(struct iwl_trans *trans, u32 ofs)
 {
@@ -117,14 +114,12 @@ u32 iwl_read_prph_no_grab(struct iwl_trans *trans, u32 ofs)
 	trace_iwlwifi_dev_ioread_prph32(trans->dev, ofs, val);
 	return val;
 }
-IWL_EXPORT_SYMBOL(iwl_read_prph_no_grab);
 
 void iwl_write_prph_no_grab(struct iwl_trans *trans, u32 ofs, u32 val)
 {
 	trace_iwlwifi_dev_iowrite_prph32(trans->dev, ofs, val);
 	iwl_trans_write_prph(trans, ofs, val);
 }
-IWL_EXPORT_SYMBOL(iwl_write_prph_no_grab);
 
 void iwl_write_prph64_no_grab(struct iwl_trans *trans, u64 ofs, u64 val)
 {
@@ -132,7 +127,6 @@ void iwl_write_prph64_no_grab(struct iwl_trans *trans, u64 ofs, u64 val)
 	iwl_write_prph_no_grab(trans, ofs, val & 0xffffffff);
 	iwl_write_prph_no_grab(trans, ofs + 4, val >> 32);
 }
-IWL_EXPORT_SYMBOL(iwl_write_prph64_no_grab);
 
 u32 iwl_read_prph(struct iwl_trans *trans, u32 ofs)
 {
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.c b/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
index 810923053053..3694b41d6621 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
@@ -437,31 +437,26 @@ void iwl_trans_write8(struct iwl_trans *trans, u32 ofs, u8 val)
 {
 	iwl_trans_pcie_write8(trans, ofs, val);
 }
-IWL_EXPORT_SYMBOL(iwl_trans_write8);
 
 void iwl_trans_write32(struct iwl_trans *trans, u32 ofs, u32 val)
 {
 	iwl_trans_pcie_write32(trans, ofs, val);
 }
-IWL_EXPORT_SYMBOL(iwl_trans_write32);
 
 u32 iwl_trans_read32(struct iwl_trans *trans, u32 ofs)
 {
 	return iwl_trans_pcie_read32(trans, ofs);
 }
-IWL_EXPORT_SYMBOL(iwl_trans_read32);
 
 u32 iwl_trans_read_prph(struct iwl_trans *trans, u32 ofs)
 {
 	return iwl_trans_pcie_read_prph(trans, ofs);
 }
-IWL_EXPORT_SYMBOL(iwl_trans_read_prph);
 
 void iwl_trans_write_prph(struct iwl_trans *trans, u32 ofs, u32 val)
 {
 	return iwl_trans_pcie_write_prph(trans, ofs, val);
 }
-IWL_EXPORT_SYMBOL(iwl_trans_write_prph);
 
 int iwl_trans_read_mem(struct iwl_trans *trans, u32 addr,
 		       void *buf, int dwords)
@@ -502,7 +497,6 @@ int iwl_trans_sw_reset(struct iwl_trans *trans)
 {
 	return iwl_trans_pcie_sw_reset(trans, true);
 }
-IWL_EXPORT_SYMBOL(iwl_trans_sw_reset);
 
 struct iwl_trans_dump_data *
 iwl_trans_dump_data(struct iwl_trans *trans, u32 dump_mask,
@@ -512,7 +506,6 @@ iwl_trans_dump_data(struct iwl_trans *trans, u32 dump_mask,
 	return iwl_trans_pcie_dump_data(trans, dump_mask,
 					sanitize_ops, sanitize_ctx);
 }
-IWL_EXPORT_SYMBOL(iwl_trans_dump_data);
 
 int iwl_trans_d3_suspend(struct iwl_trans *trans, bool test, bool reset)
 {
@@ -548,20 +541,17 @@ void iwl_trans_interrupts(struct iwl_trans *trans, bool enable)
 {
 	iwl_trans_pci_interrupts(trans, enable);
 }
-IWL_EXPORT_SYMBOL(iwl_trans_interrupts);
 
 void iwl_trans_sync_nmi(struct iwl_trans *trans)
 {
 	iwl_trans_pcie_sync_nmi(trans);
 }
-IWL_EXPORT_SYMBOL(iwl_trans_sync_nmi);
 
 int iwl_trans_write_imr_mem(struct iwl_trans *trans, u32 dst_addr,
 			    u64 src_addr, u32 byte_cnt)
 {
 	return iwl_trans_pcie_copy_imr(trans, dst_addr, src_addr, byte_cnt);
 }
-IWL_EXPORT_SYMBOL(iwl_trans_write_imr_mem);
 
 void iwl_trans_set_bits_mask(struct iwl_trans *trans, u32 reg,
 			     u32 mask, u32 value)
@@ -575,7 +565,6 @@ int iwl_trans_read_config32(struct iwl_trans *trans, u32 ofs,
 {
 	return iwl_trans_pcie_read_config32(trans, ofs, val);
 }
-IWL_EXPORT_SYMBOL(iwl_trans_read_config32);
 
 bool _iwl_trans_grab_nic_access(struct iwl_trans *trans)
 {
@@ -771,7 +760,6 @@ void iwl_trans_debugfs_cleanup(struct iwl_trans *trans)
 {
 	iwl_trans_pcie_debugfs_cleanup(trans);
 }
-IWL_EXPORT_SYMBOL(iwl_trans_debugfs_cleanup);
 #endif
 
 void iwl_trans_set_q_ptrs(struct iwl_trans *trans, int queue, int ptr)
@@ -809,7 +797,6 @@ int iwl_trans_get_rxq_dma_data(struct iwl_trans *trans, int queue,
 {
 	return iwl_trans_pcie_rxq_dma_data(trans, queue, data);
 }
-IWL_EXPORT_SYMBOL(iwl_trans_get_rxq_dma_data);
 
 int iwl_trans_load_pnvm(struct iwl_trans *trans,
 			const struct iwl_pnvm_image *pnvm_data,
@@ -824,7 +811,6 @@ void iwl_trans_set_pnvm(struct iwl_trans *trans,
 {
 	iwl_trans_pcie_ctx_info_v2_set_pnvm(trans, capa);
 }
-IWL_EXPORT_SYMBOL(iwl_trans_set_pnvm);
 
 int iwl_trans_load_reduce_power(struct iwl_trans *trans,
 				const struct iwl_pnvm_image *payloads,
@@ -833,11 +819,9 @@ int iwl_trans_load_reduce_power(struct iwl_trans *trans,
 	return iwl_trans_pcie_ctx_info_v2_load_reduce_power(trans, payloads,
 							      capa);
 }
-IWL_EXPORT_SYMBOL(iwl_trans_load_reduce_power);
 
 void iwl_trans_set_reduce_power(struct iwl_trans *trans,
 				const struct iwl_ucode_capabilities *capa)
 {
 	iwl_trans_pcie_ctx_info_v2_set_reduce_power(trans, capa);
 }
-IWL_EXPORT_SYMBOL(iwl_trans_set_reduce_power);
-- 
2.34.1


