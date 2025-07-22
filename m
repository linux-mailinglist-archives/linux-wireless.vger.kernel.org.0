Return-Path: <linux-wireless+bounces-25793-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14DE7B0D079
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jul 2025 05:42:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E1BD543F43
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jul 2025 03:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE73428C03A;
	Tue, 22 Jul 2025 03:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="blZXiw6e"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23AA928C864
	for <linux-wireless@vger.kernel.org>; Tue, 22 Jul 2025 03:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753155729; cv=none; b=lauIaogN5++EFFtdUmbugzSsr5/peHZiiSrPxb2X7kOMD65QCz63f3C198KPdklMrJreQwxg0zCyvfAmrD6W8C6/EcJLBSUXEEhY68NgbKdJ//GeNPTs/y3P+EW4w0Xzm0FGhcyNuieRz0070yI3JHwPs0uhMm1/G8ED+dyG+L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753155729; c=relaxed/simple;
	bh=tkooIDmNHT8ZUzqTja3fAmKm0/p9kGoj+n5t0EqHvGo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m67y+HPMOkj/6OxlQSZOhM4o3dgkpnE3Q7MbcCiPoP4KaHJ7B6nDytpv0xZm0QWDxRv8mOK3DG0YS8oUv6rDAOttFTGDYN05WAgMLptAscTPmP34BhmN4jdi8Pz/6CHzoqx6zJQDiCSIogL0wo9RfWxKEpHIrakKrAeueSjIrwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=blZXiw6e; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753155728; x=1784691728;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tkooIDmNHT8ZUzqTja3fAmKm0/p9kGoj+n5t0EqHvGo=;
  b=blZXiw6e66qLqUSrMwv5kR1EcXHJsrei7wMh0oV1TSLHspa2B7lZtQUx
   QbNoM5aGzPdelCIDjqkDgfNhUDq6zND3gwi4M+eAMZG8B+MVc02KfR8Xm
   5Jr4DFyOB/U7rhXSGNs1p3u9nEHAAheIeP4NpAl6ZPmjLPSTFATCX/AQq
   IJ1UsWar2H06xP1sBvC9junGMLCdtEeG7qKTo0Zs+P89IL6Mva4ywdqfx
   pU7Ln2k7P2bXRKp83UqF7HhuOo3TeKVXPXOw519yeNUpSzp3GSS2NJ7SV
   ffFbQFqsi9AVDP3aPsz28RC7esnjaJNxccw8NhgumGVTxN9kwEhcrWgPh
   Q==;
X-CSE-ConnectionGUID: 5xNM9wU5SuWHSe+fdH4Naw==
X-CSE-MsgGUID: vOPGdfqQTdOc8TbOJ3fP4Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11499"; a="43006170"
X-IronPort-AV: E=Sophos;i="6.16,330,1744095600"; 
   d="scan'208";a="43006170"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 20:42:08 -0700
X-CSE-ConnectionGUID: 6v3BmrvISFCmsxrwb4Q5ag==
X-CSE-MsgGUID: 1dbs9XxNRzCFgtpQG+SNxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,330,1744095600"; 
   d="scan'208";a="159338161"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 20:42:07 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 14/15] wifi: iwlwifi: don't export symbols that we shouldn't
Date: Tue, 22 Jul 2025 06:41:24 +0300
Message-Id: <20250722063923.a3c5c2182708.Ib8abe63c9b25ef1e4ae1bc167cb23fe34bb3682a@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250722034125.1017387-1-miriam.rachel.korenblit@intel.com>
References: <20250722034125.1017387-1-miriam.rachel.korenblit@intel.com>
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


