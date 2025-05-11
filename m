Return-Path: <linux-wireless+bounces-22848-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BB8CAB29CD
	for <lists+linux-wireless@lfdr.de>; Sun, 11 May 2025 18:54:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F2A21682F6
	for <lists+linux-wireless@lfdr.de>; Sun, 11 May 2025 16:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C27A25D1FF;
	Sun, 11 May 2025 16:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gdfz3ueE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A599B25D21C
	for <linux-wireless@vger.kernel.org>; Sun, 11 May 2025 16:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746982429; cv=none; b=WgRHbV8sQK2mXprayDnvAL3CX5afcyQRPLo+VF9iEkgK1H8v8xKmIExbcvRqxazkOKiYKh15iCV7pBebRm7scgk6Wn4rfkBn82gP3Mvr8lAWmD0D1Hr5UobgRryw0v+bzZuctu1Z19KTgByNS2zMP5RQx84I+84zWZOzKrF9N/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746982429; c=relaxed/simple;
	bh=5zPRJT1Ua3TFVryJNWJBmZ6IlZrqufr+10GgDhimKOI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rKnC78xLx7R42jNpB/5LbeHfRXNN/2+1vgD5k/vS9L8IS+xSQVKYl5y7kQ3agsIwTXFfaNrdrVn4sPeXmp6aKUyX8J5v5vFAQKvPhq3g633GEq7oBqgb3Hc3pWucwuzpVL3kprB8Ta6ERjX91Sq45pji5hAmov4EizYAkyBCz4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gdfz3ueE; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746982428; x=1778518428;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5zPRJT1Ua3TFVryJNWJBmZ6IlZrqufr+10GgDhimKOI=;
  b=Gdfz3ueEGqAPs+/VwvpGV9d8SWU30BbwZC78GzDddKoC2pd0tJdRjKd3
   auo9rmOnqy/PTtKt5EanOq8fv4oFx3u3/UOemMjTI8/6grKeuALjWdqBJ
   x9/8FWdEw3uBqsN9AeVteHJh8JiNxKPI5L1x6s/QRvLBZqfyeLZ0GHPfB
   gjh6nzIlY+8319DTga4rgSADGOQF29wU8b/vxpADIq895UFMcY6A8yJ9Q
   TBskW92cowtGAN9vYW8CaTVlHAxc7thdBHhntRwWrw2hOtzz+2Pj5vIYI
   M2f3+Fak7PPv5Z9Kd9ewdhb038wBfEirUMRyIkjqMjWmKbkdKJH15U58C
   g==;
X-CSE-ConnectionGUID: 5n0XZcd4REqoSCfNzNgwFw==
X-CSE-MsgGUID: vzRg2XsUR6i/rSf6+7ezJQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11430"; a="52582694"
X-IronPort-AV: E=Sophos;i="6.15,280,1739865600"; 
   d="scan'208";a="52582694"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2025 09:53:47 -0700
X-CSE-ConnectionGUID: mv+GtQJ6RtWToHONThEO3w==
X-CSE-MsgGUID: WZkdzyoBT4OweaHK2F0VEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,280,1739865600"; 
   d="scan'208";a="137655072"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2025 09:53:46 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 09/15] wifi: iwlwifi: unify iwlagn_scd_bc_tbl_entry and iwl_gen3_bc_tbl_entry
Date: Sun, 11 May 2025 19:53:15 +0300
Message-Id: <20250511195137.b7ddfade8fec.I2bf97252c4bd751077ade204767eed02d815614d@changeid>
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

As those are now the same, unify and adjust the documentation.

Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-fh.h     | 17 +++--------------
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c | 13 +++++++------
 .../net/wireless/intel/iwlwifi/pcie/tx-gen2.c   |  9 +++------
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c    |  6 +++---
 4 files changed, 16 insertions(+), 29 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-fh.h b/drivers/net/wireless/intel/iwlwifi/iwl-fh.h
index ff58a59089fa..ee9e41c31797 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-fh.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-fh.h
@@ -717,30 +717,19 @@ struct iwl_tfh_tfd {
 /* Fixed (non-configurable) rx data from phy */
 
 /**
- * struct iwlagn_scd_bc_tbl_entry - scheduler byte count table entry
+ * struct iwl_bc_tbl_entry - scheduler byte count table entry
  *	base physical address provided by SCD_DRAM_BASE_ADDR
  * For devices up to 22000:
  * @tfd_offset:
  *	For devices up to 22000:
  *		 0-12 - tx command byte count
  *		12-16 - station index
- *	For 22000:
+ *	For 22000 and on:
  *		 0-12 - tx command byte count
  *		12-13 - number of 64 byte chunks
  *		14-16 - reserved
  */
-struct iwlagn_scd_bc_tbl_entry {
-	__le16 tfd_offset;
-} __packed;
-
-/**
- * struct iwl_gen3_bc_tbl_entry - scheduler byte count table entry gen3
- * For AX210 and on:
- * @tfd_offset: 0-12 - tx command byte count
- *		12-13 - number of 64 byte chunks
- *		14-16 - reserved
- */
-struct iwl_gen3_bc_tbl_entry {
+struct iwl_bc_tbl_entry {
 	__le16 tfd_offset;
 } __packed;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index 8e2ad3147510..906fee5bf47e 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -3785,6 +3785,7 @@ iwl_trans_pcie_alloc(struct pci_dev *pdev,
 {
 	struct iwl_trans_pcie *trans_pcie, **priv;
 	struct iwl_trans *trans;
+	unsigned int bc_tbl_n_entries;
 	int ret, addr_size;
 	u32 bar0;
 
@@ -3833,14 +3834,14 @@ iwl_trans_pcie_alloc(struct pci_dev *pdev,
 	}
 
 	if (trans->mac_cfg->device_family >= IWL_DEVICE_FAMILY_BZ)
-		trans_pcie->txqs.bc_tbl_size =
-			sizeof(struct iwl_gen3_bc_tbl_entry) * TFD_QUEUE_BC_SIZE_BZ;
+		bc_tbl_n_entries = TFD_QUEUE_BC_SIZE_BZ;
 	else if (trans->mac_cfg->device_family >= IWL_DEVICE_FAMILY_AX210)
-		trans_pcie->txqs.bc_tbl_size =
-			sizeof(struct iwl_gen3_bc_tbl_entry) * TFD_QUEUE_BC_SIZE_AX210;
+		bc_tbl_n_entries = TFD_QUEUE_BC_SIZE_AX210;
 	else
-		trans_pcie->txqs.bc_tbl_size =
-			sizeof(struct iwlagn_scd_bc_tbl_entry) * TFD_QUEUE_BC_SIZE;
+		bc_tbl_n_entries = TFD_QUEUE_BC_SIZE;
+
+	trans_pcie->txqs.bc_tbl_size =
+		sizeof(struct iwl_bc_tbl_entry) * bc_tbl_n_entries;
 	/*
 	 * For gen2 devices, we use a single allocation for each byte-count
 	 * table, but they're pretty small (1k) so use a DMA pool that we
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c b/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
index 649fb55373c7..df0545f09da9 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
@@ -561,6 +561,7 @@ static void iwl_pcie_gen2_update_byte_tbl(struct iwl_trans *trans,
 					  int num_tbs)
 {
 	int idx = iwl_txq_get_cmd_index(txq, txq->write_ptr);
+	struct iwl_bc_tbl_entry *scd_bc_tbl = txq->bc_tbl.addr;
 	u8 filled_tfd_size, num_fetch_chunks;
 	u16 len = byte_cnt;
 	__le16 bc_ent;
@@ -581,19 +582,15 @@ static void iwl_pcie_gen2_update_byte_tbl(struct iwl_trans *trans,
 	num_fetch_chunks = DIV_ROUND_UP(filled_tfd_size, 64) - 1;
 
 	if (trans->mac_cfg->device_family >= IWL_DEVICE_FAMILY_AX210) {
-		struct iwl_gen3_bc_tbl_entry *scd_bc_tbl_gen3 = txq->bc_tbl.addr;
-
 		WARN_ON(len > 0x3FFF);
 		bc_ent = cpu_to_le16(len | (num_fetch_chunks << 14));
-		scd_bc_tbl_gen3[idx].tfd_offset = bc_ent;
 	} else {
-		struct iwlagn_scd_bc_tbl_entry *scd_bc_tbl = txq->bc_tbl.addr;
-
 		len = DIV_ROUND_UP(len, 4);
 		WARN_ON(len > 0xFFF);
 		bc_ent = cpu_to_le16(len | (num_fetch_chunks << 12));
-		scd_bc_tbl[idx].tfd_offset = bc_ent;
 	}
+
+	scd_bc_tbl[idx].tfd_offset = bc_ent;
 }
 
 static u8 iwl_txq_gen2_get_num_tbs(struct iwl_tfh_tfd *tfd)
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
index 432ce44c4da4..d050de237638 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
@@ -796,7 +796,7 @@ int iwl_pcie_txq_alloc(struct iwl_trans *trans, struct iwl_txq *txq,
 	return -ENOMEM;
 }
 
-#define BC_TABLE_SIZE	(sizeof(struct iwlagn_scd_bc_tbl_entry) * TFD_QUEUE_BC_SIZE)
+#define BC_TABLE_SIZE	(sizeof(struct iwl_bc_tbl_entry) * TFD_QUEUE_BC_SIZE)
 
 /*
  * iwl_pcie_tx_alloc - allocate TX context
@@ -2067,7 +2067,7 @@ static void iwl_txq_gen1_update_byte_cnt_tbl(struct iwl_trans *trans,
 					     int num_tbs)
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
-	struct iwlagn_scd_bc_tbl_entry *scd_bc_tbl;
+	struct iwl_bc_tbl_entry *scd_bc_tbl;
 	int write_ptr = txq->write_ptr;
 	int txq_id = txq->id;
 	u8 sec_ctl = 0;
@@ -2314,7 +2314,7 @@ static void iwl_txq_gen1_inval_byte_cnt_tbl(struct iwl_trans *trans,
 					    int read_ptr)
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
-	struct iwlagn_scd_bc_tbl_entry *scd_bc_tbl = trans_pcie->txqs.scd_bc_tbls.addr;
+	struct iwl_bc_tbl_entry *scd_bc_tbl = trans_pcie->txqs.scd_bc_tbls.addr;
 	int txq_id = txq->id;
 	u8 sta_id = 0;
 	__le16 bc_ent;
-- 
2.34.1


