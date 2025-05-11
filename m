Return-Path: <linux-wireless+bounces-22847-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0966AB29C9
	for <lists+linux-wireless@lfdr.de>; Sun, 11 May 2025 18:54:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1266B1897952
	for <lists+linux-wireless@lfdr.de>; Sun, 11 May 2025 16:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92EB825A658;
	Sun, 11 May 2025 16:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WxIovQ1r"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEFAB25D1FF
	for <linux-wireless@vger.kernel.org>; Sun, 11 May 2025 16:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746982427; cv=none; b=beH1On5ByzR+LOI82wrzjeqGbLN0ISBExoOW3H5UJ94E5DdRjMjRUZL3eVnVEaFeel+BJhleFiR3Cm1wLgoTC/0MjinIooTpo2ufADYQUmdfyVBZKsL79bKguaQ87FOrdHk+S+UxEY4xqTRIX60BLy4jFmCRdCqlzO9I/G26a84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746982427; c=relaxed/simple;
	bh=7J/BpUVYaYXY2bDWHufrX/ibkc9Q376JhW2ZnIxv7f8=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WYHLBcjtYNYJkXqI+aSIG9qdCCR3PXSqfgjudrZ1+1EUgU8oiH5Gubui1VATSkKuQspkFD8DAekj0vsnDGEFi0te1/ic6GnTFXSmTn7107xKkf7roafmgQEBlF6Om5xRMWxviUJcYbskbmwYS7mWh8bE5uTc8zUAyy6PYf669xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WxIovQ1r; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746982426; x=1778518426;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=7J/BpUVYaYXY2bDWHufrX/ibkc9Q376JhW2ZnIxv7f8=;
  b=WxIovQ1reiBvfq4pHad4g+lhzSjOBXbIWipxddfLX3wR0u0xRoYujTtP
   14Ikesh1suHrGAWLzXzc1jy8aKigycPOmjXRd9JbiRpQbauHyFcFhUwXe
   jZC5bAWliM9xPEjpHExgXp5S17Lyep8YVq12bxJ8NCEUr9liF5OzUog3d
   OMVeVDNkwgJy9+0rmbyzrn0F6zyrOeY3RBjkDOMGUJr7FpD854yxvUsdl
   HBISpTZm1vEdMJvi4wG7uH4JhzGIjg1LC99vHJ4cDZR3OsKzg7xHlYdkt
   XSvujo/E9zsi91qrGe9BR9j1ly1a7wwhLGLSz/i7XJRHU+PHSyHPIdUaD
   g==;
X-CSE-ConnectionGUID: tRN6ONQVRrq76225NuYZdQ==
X-CSE-MsgGUID: lTyEV3GnRamlXiERSwkctA==
X-IronPort-AV: E=McAfee;i="6700,10204,11430"; a="52582692"
X-IronPort-AV: E=Sophos;i="6.15,280,1739865600"; 
   d="scan'208";a="52582692"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2025 09:53:46 -0700
X-CSE-ConnectionGUID: F5DZkms/TByndtaiiBy72Q==
X-CSE-MsgGUID: 3v04G7wOT9yJbMIyEcfRiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,280,1739865600"; 
   d="scan'208";a="137655063"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2025 09:53:45 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Subject: [PATCH iwlwifi-next 08/15] wifi: iwlwifi: use bc entries instead of bc table also for pre-ax210
Date: Sun, 11 May 2025 19:53:14 +0300
Message-Id: <20250511195137.645cd82ebf48.Iaa7e88179372d60ef31157e379737b5babe54012@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250511165321.590808-1-miriam.rachel.korenblit@intel.com>
References: <20250511165321.590808-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

iwlagn_scd_bc_tbl is used for pre-ax210 devices,
and iwl_gen3_bc_tbl_entry is used for ax210 and on. But there is no
difference between the the 22000 version and the AX210+ one.

In order to unify the two, as first step make iwlagn_scd_bc_tbl an entry
as well, and adjust the code. In a later patch both structures will be
unified.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-fh.h      |  6 +++---
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c  |  3 ++-
 .../net/wireless/intel/iwlwifi/pcie/tx-gen2.c    |  4 ++--
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c     | 16 +++++++++-------
 4 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-fh.h b/drivers/net/wireless/intel/iwlwifi/iwl-fh.h
index df4bb499446a..ff58a59089fa 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-fh.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-fh.h
@@ -717,7 +717,7 @@ struct iwl_tfh_tfd {
 /* Fixed (non-configurable) rx data from phy */
 
 /**
- * struct iwlagn_scd_bc_tbl - scheduler byte count table
+ * struct iwlagn_scd_bc_tbl_entry - scheduler byte count table entry
  *	base physical address provided by SCD_DRAM_BASE_ADDR
  * For devices up to 22000:
  * @tfd_offset:
@@ -729,8 +729,8 @@ struct iwl_tfh_tfd {
  *		12-13 - number of 64 byte chunks
  *		14-16 - reserved
  */
-struct iwlagn_scd_bc_tbl {
-	__le16 tfd_offset[TFD_QUEUE_BC_SIZE];
+struct iwlagn_scd_bc_tbl_entry {
+	__le16 tfd_offset;
 } __packed;
 
 /**
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index 694e1ed1eae0..8e2ad3147510 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -3839,7 +3839,8 @@ iwl_trans_pcie_alloc(struct pci_dev *pdev,
 		trans_pcie->txqs.bc_tbl_size =
 			sizeof(struct iwl_gen3_bc_tbl_entry) * TFD_QUEUE_BC_SIZE_AX210;
 	else
-		trans_pcie->txqs.bc_tbl_size = sizeof(struct iwlagn_scd_bc_tbl);
+		trans_pcie->txqs.bc_tbl_size =
+			sizeof(struct iwlagn_scd_bc_tbl_entry) * TFD_QUEUE_BC_SIZE;
 	/*
 	 * For gen2 devices, we use a single allocation for each byte-count
 	 * table, but they're pretty small (1k) so use a DMA pool that we
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c b/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
index 53a02b45de5f..649fb55373c7 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
@@ -587,12 +587,12 @@ static void iwl_pcie_gen2_update_byte_tbl(struct iwl_trans *trans,
 		bc_ent = cpu_to_le16(len | (num_fetch_chunks << 14));
 		scd_bc_tbl_gen3[idx].tfd_offset = bc_ent;
 	} else {
-		struct iwlagn_scd_bc_tbl *scd_bc_tbl = txq->bc_tbl.addr;
+		struct iwlagn_scd_bc_tbl_entry *scd_bc_tbl = txq->bc_tbl.addr;
 
 		len = DIV_ROUND_UP(len, 4);
 		WARN_ON(len > 0xFFF);
 		bc_ent = cpu_to_le16(len | (num_fetch_chunks << 12));
-		scd_bc_tbl->tfd_offset[idx] = bc_ent;
+		scd_bc_tbl[idx].tfd_offset = bc_ent;
 	}
 }
 
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
index d5ba4f3fd223..432ce44c4da4 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
@@ -796,6 +796,8 @@ int iwl_pcie_txq_alloc(struct iwl_trans *trans, struct iwl_txq *txq,
 	return -ENOMEM;
 }
 
+#define BC_TABLE_SIZE	(sizeof(struct iwlagn_scd_bc_tbl_entry) * TFD_QUEUE_BC_SIZE)
+
 /*
  * iwl_pcie_tx_alloc - allocate TX context
  * Allocate all Tx DMA structures and initialize them
@@ -810,7 +812,7 @@ static int iwl_pcie_tx_alloc(struct iwl_trans *trans)
 	if (WARN_ON(trans->mac_cfg->device_family >= IWL_DEVICE_FAMILY_AX210))
 		return -EINVAL;
 
-	bc_tbls_size *= sizeof(struct iwlagn_scd_bc_tbl);
+	bc_tbls_size *= BC_TABLE_SIZE;
 
 	/*It is not allowed to alloc twice, so warn when this happens.
 	 * We cannot rely on the previous allocation, so free and fail */
@@ -2065,7 +2067,7 @@ static void iwl_txq_gen1_update_byte_cnt_tbl(struct iwl_trans *trans,
 					     int num_tbs)
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
-	struct iwlagn_scd_bc_tbl *scd_bc_tbl;
+	struct iwlagn_scd_bc_tbl_entry *scd_bc_tbl;
 	int write_ptr = txq->write_ptr;
 	int txq_id = txq->id;
 	u8 sec_ctl = 0;
@@ -2099,10 +2101,10 @@ static void iwl_txq_gen1_update_byte_cnt_tbl(struct iwl_trans *trans,
 
 	bc_ent = cpu_to_le16(len | (sta_id << 12));
 
-	scd_bc_tbl[txq_id].tfd_offset[write_ptr] = bc_ent;
+	scd_bc_tbl[txq_id * BC_TABLE_SIZE + write_ptr].tfd_offset = bc_ent;
 
 	if (write_ptr < TFD_QUEUE_SIZE_BC_DUP)
-		scd_bc_tbl[txq_id].tfd_offset[TFD_QUEUE_SIZE_MAX + write_ptr] =
+		scd_bc_tbl[txq_id * BC_TABLE_SIZE + TFD_QUEUE_SIZE_MAX + write_ptr].tfd_offset =
 			bc_ent;
 }
 
@@ -2312,7 +2314,7 @@ static void iwl_txq_gen1_inval_byte_cnt_tbl(struct iwl_trans *trans,
 					    int read_ptr)
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
-	struct iwlagn_scd_bc_tbl *scd_bc_tbl = trans_pcie->txqs.scd_bc_tbls.addr;
+	struct iwlagn_scd_bc_tbl_entry *scd_bc_tbl = trans_pcie->txqs.scd_bc_tbls.addr;
 	int txq_id = txq->id;
 	u8 sta_id = 0;
 	__le16 bc_ent;
@@ -2326,10 +2328,10 @@ static void iwl_txq_gen1_inval_byte_cnt_tbl(struct iwl_trans *trans,
 
 	bc_ent = cpu_to_le16(1 | (sta_id << 12));
 
-	scd_bc_tbl[txq_id].tfd_offset[read_ptr] = bc_ent;
+	scd_bc_tbl[txq_id * BC_TABLE_SIZE + read_ptr].tfd_offset = bc_ent;
 
 	if (read_ptr < TFD_QUEUE_SIZE_BC_DUP)
-		scd_bc_tbl[txq_id].tfd_offset[TFD_QUEUE_SIZE_MAX + read_ptr] =
+		scd_bc_tbl[txq_id * BC_TABLE_SIZE + TFD_QUEUE_SIZE_MAX + read_ptr].tfd_offset =
 			bc_ent;
 }
 
-- 
2.34.1


