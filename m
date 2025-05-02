Return-Path: <linux-wireless+bounces-22348-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A684AA72B3
	for <lists+linux-wireless@lfdr.de>; Fri,  2 May 2025 14:57:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4FD677A764C
	for <lists+linux-wireless@lfdr.de>; Fri,  2 May 2025 12:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B24F7255243;
	Fri,  2 May 2025 12:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FKUawuof"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110452550BB
	for <linux-wireless@vger.kernel.org>; Fri,  2 May 2025 12:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746190616; cv=none; b=CPjxd2FO06uc4rvPeXIOQKHCuT386B0XZzZHeJdBZLUeV52Zq941SJME84N6ogVNyLNPDu6VbvP6n7b4HmB3Ntgy4P+wBonjIcqNgYMfsrsUrj2CIZoNvZZUjU4dfzhwiOdgMMrz1u7n13EU2O3OBlwYYaw3aCBQx5QL1LYx5vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746190616; c=relaxed/simple;
	bh=BmjtXTo8bIftVzLyWdLW53bTdwpiIkuhksQTqmFCHSA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=InKz+TKkzjiU9EtR/CplQ/73Kjh3zzF8fZu8f6QKl68M1+MoU11RR3SH0TNfWga9XhH642tkalYcGqX1fNp4QwNs+9ShDKrpDwpS5xzddj2XKJ0dP6bljDSHK5VL7MnfAm7j/YkspvP6PTQnUDtN+dU8xQFcjF4pYAv2R+jp/rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FKUawuof; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746190616; x=1777726616;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BmjtXTo8bIftVzLyWdLW53bTdwpiIkuhksQTqmFCHSA=;
  b=FKUawuofGA1vlEL5Tuegl0CjGWC+ETxR5IeqzQWeBYpPL3P8Lmmw8NB+
   zYG9JdOdTQ/NOFKtgi0ZIfCXmpFDnEh6a+UUBG7/aQkpKXf+XkKh3pw0l
   IFDJK+8Y2yIL/vxyadqMKc2uHJI3t9SpLt/J1aVaz27hQh1DnixgndmQP
   7x3kODUuREvhbuK5KBLi2vG6wB0tQjSeXco6RkywG5FbBe/LdN8Vc0gsY
   5wm415AKRlmnpCmNS3vbUVCEpbcBQ57kg2akhzC1P1sUlbMB1ENP+Qqz4
   ew8cqgW/EpCsd0ax3aQxB8BOyqEToFEaLNvaJjdB2Absc7BMI8aoCTkMs
   Q==;
X-CSE-ConnectionGUID: /Rhv68EaR1ylXVQxHeXpOg==
X-CSE-MsgGUID: J1nGETMFR+qTd5wO56qMCw==
X-IronPort-AV: E=McAfee;i="6700,10204,11421"; a="59255542"
X-IronPort-AV: E=Sophos;i="6.15,256,1739865600"; 
   d="scan'208";a="59255542"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2025 05:56:55 -0700
X-CSE-ConnectionGUID: NCV2v2eaS4qHMGcviWg6bA==
X-CSE-MsgGUID: 92vUpO1cRPuxAetXkvVoxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,256,1739865600"; 
   d="scan'208";a="165554715"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2025 05:56:53 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: miriam.rachel.korenblit@intel.com
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 06/15] wifi: iwlwifi: pcie: remove 'ent' argument from alloc
Date: Fri,  2 May 2025 15:56:22 +0300
Message-Id: <20250502155404.0351805072bc.Id309b38817edc116bf9a921608a93b7734f21b05@changeid>
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

The alloc function iwl_trans_pcie_alloc() doesn't use the
'ent' argument, so remove it.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c      | 2 +-
 drivers/net/wireless/intel/iwlwifi/pcie/internal.h | 1 -
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c    | 6 +++---
 3 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 618b6b9fefa7..4c2786655f7d 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -1422,7 +1422,7 @@ static int iwl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	/* make sure trans is the first element in iwl_cfg */
 	BUILD_BUG_ON(offsetof(struct iwl_cfg, trans));
 
-	iwl_trans = iwl_trans_pcie_alloc(pdev, ent, trans);
+	iwl_trans = iwl_trans_pcie_alloc(pdev, trans);
 	if (IS_ERR(iwl_trans))
 		return PTR_ERR(iwl_trans);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
index 390e447b452c..c0a670994ce7 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
@@ -553,7 +553,6 @@ iwl_trans_pcie_get_trans(struct iwl_trans_pcie *trans_pcie)
  */
 struct iwl_trans
 *iwl_trans_pcie_alloc(struct pci_dev *pdev,
-		      const struct pci_device_id *ent,
 		      const struct iwl_cfg_trans_params *cfg_trans);
 void iwl_trans_pcie_free(struct iwl_trans *trans);
 void iwl_trans_pcie_free_pnvm_dram_regions(struct iwl_dram_regions *dram_regions,
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index b0c145f0322c..2a6b9f80360d 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -3797,9 +3797,9 @@ void iwl_trans_pcie_sync_nmi(struct iwl_trans *trans)
 	iwl_trans_sync_nmi_with_addr(trans, inta_addr, sw_err_bit);
 }
 
-struct iwl_trans *iwl_trans_pcie_alloc(struct pci_dev *pdev,
-			       const struct pci_device_id *ent,
-			       const struct iwl_cfg_trans_params *cfg_trans)
+struct iwl_trans *
+iwl_trans_pcie_alloc(struct pci_dev *pdev,
+		     const struct iwl_cfg_trans_params *cfg_trans)
 {
 	struct iwl_trans_pcie *trans_pcie, **priv;
 	struct iwl_trans *trans;
-- 
2.34.1


