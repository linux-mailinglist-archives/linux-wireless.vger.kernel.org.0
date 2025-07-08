Return-Path: <linux-wireless+bounces-24983-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4C3DAFD79B
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 21:52:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DFAB3A41D2
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 19:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02E7623D2BB;
	Tue,  8 Jul 2025 19:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a0FfCMQb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C9321CC5A
	for <linux-wireless@vger.kernel.org>; Tue,  8 Jul 2025 19:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752004284; cv=none; b=OBGoww50TooNYXB0zeyFZlJ1BIclH7Mv75trGQZoy/s3EkTCX0YwABr+2lUnuUfEnVTX4oKunQX8kpNTluclSvPE4bMWQH2jToIR71zt9RqcM20ptpMbitYnUmUtdxLM0ra6qMx3uTRBQOR5B4hl+oMA4ZwyKYl9FG763nCv63Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752004284; c=relaxed/simple;
	bh=hNksU6JP0UXTn7QDTi9qij3c0Gch+NXVMX3vQXKA7Wo=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ca6/o6Aj1HPdHCUeSj7dU6/22W5zGjXt3dTDI4Ptx6H8jMhQ6T7Ql38JC0+6RDtoOYusP4vpD0fomeGu76vupK6Lu+MSOJ0exkkEVfeZkV6Ay+W286z8WBN+zMp4v1IqJubZsT195L0WUUTGZxYeRCNv++Eh2WniMEg4VZQtiMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a0FfCMQb; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752004283; x=1783540283;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=hNksU6JP0UXTn7QDTi9qij3c0Gch+NXVMX3vQXKA7Wo=;
  b=a0FfCMQbdD9zhqfgKOfOJzYpM8cQ1nIW9dOh11k7319FhDMMH8PTZ76m
   WXPPBp9IHOCXqIPTp5aa60b/MMDSAR0MeXewQjqSZ7I4c5n7OZyVLhAoM
   3/Uku9WQFU3Bz9nuiz8aluKPNoA1s7+e6E9VqrrDQ7jWvrCzoZKZXDaIz
   etV/F3GL2r18w/Q2ZmFDMoF8XDNaYW6so6C1zWtahxXp+1oeQj3Ai+/b1
   ST/r/yP4hCON8vqiQiINcmgdISW1D3mnxlaJtXMenayNuVn5sF+saa09P
   5PkB8HpcggtWlthOpIebzzTKQ0aF3mYM7RCoLeyIdu2hsv7Nejsz3iKul
   g==;
X-CSE-ConnectionGUID: Jo+jIJlNRdWiChuDXpNU7A==
X-CSE-MsgGUID: X3SDIxjJSp+C20zN7k1bDw==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="54229717"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="54229717"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 12:51:22 -0700
X-CSE-ConnectionGUID: UUUZaDkUSyq8839PDm+/OA==
X-CSE-MsgGUID: ep3JTDa3Tb+UkLrZROEuUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="155668946"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 12:51:21 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Subject: [PATCH iwlwifi-next 06/15] wifi: iwlwifi: pcie move common probe logic
Date: Tue,  8 Jul 2025 22:50:44 +0300
Message-Id: <20250708224652.b637e54a8b35.Ib762365933d4dd4fc0bf07833226cd7118dee0a1@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250708195053.451143-1-miriam.rachel.korenblit@intel.com>
References: <20250708195053.451143-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

Move the parts of the probe that are not gen specific to the common
probe function.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 38 +++++++++++++++-
 .../intel/iwlwifi/pcie/gen1_2/internal.h      |  5 ++-
 .../intel/iwlwifi/pcie/gen1_2/trans.c         | 45 +++----------------
 3 files changed, 47 insertions(+), 41 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 2729e0890fc6..a9c48b78945d 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -1127,8 +1127,44 @@ EXPORT_SYMBOL_IF_IWLWIFI_KUNIT(iwl_pci_find_dev_info);
 static int iwl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	const struct iwl_mac_cfg *mac_cfg = (void *)ent->driver_data;
+	u8 __iomem* hw_base;
+	u32 bar0, hw_rev;
+	int ret;
+
+	/* reassign our BAR 0 if invalid due to possible runtime PM races */
+	pci_read_config_dword(pdev, PCI_BASE_ADDRESS_0, &bar0);
+	if (bar0 == PCI_BASE_ADDRESS_MEM_TYPE_64) {
+		ret = pci_assign_resource(pdev, 0);
+		if (ret)
+			return ret;
+	}
+
+	ret = pcim_enable_device(pdev);
+	if (ret)
+		return ret;
+
+	pci_set_master(pdev);
+
+	ret = pcim_request_all_regions(pdev, DRV_NAME);
+	if (ret) {
+		dev_err(&pdev->dev, "Requesting all PCI BARs failed.\n");
+		return ret;
+	}
+
+	hw_base = pcim_iomap(pdev, 0, 0);
+	if (!hw_base) {
+		dev_err(&pdev->dev, "Failed to map BAR 0.\n");
+		return -ENOMEM;
+	}
+
+	/* We can't use iwl_read32 because trans wasn't allocated */
+	hw_rev = readl(hw_base + CSR_HW_REV);
+	if (hw_rev == 0xffffffff) {
+		dev_err(&pdev->dev, "HW_REV=0xFFFFFFFF, PCI issues?\n");
+		return -EIO;
+	}
 
-	return iwl_pci_gen1_2_probe(pdev, ent, mac_cfg);
+	return iwl_pci_gen1_2_probe(pdev, ent, mac_cfg, hw_base, hw_rev);
 }
 
 static void iwl_pci_remove(struct pci_dev *pdev)
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/internal.h b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/internal.h
index 5530f35042ad..ec17e2e84151 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/internal.h
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/internal.h
@@ -1078,8 +1078,9 @@ void __releases(nic_access_nobh)
 iwl_trans_pcie_release_nic_access(struct iwl_trans *trans);
 void iwl_pcie_alloc_fw_monitor(struct iwl_trans *trans, u8 max_power);
 int iwl_pci_gen1_2_probe(struct pci_dev *pdev,
-			 const struct pci_device_id *ent,
-			 const struct iwl_mac_cfg *trans);
+			const struct pci_device_id *ent,
+			const struct iwl_mac_cfg *trans, u8 __iomem *hw_base,
+			u32 hw_rev);
 
 /* transport gen 1 exported functions */
 void iwl_trans_pcie_fw_alive(struct iwl_trans *trans);
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
index 162c61e97629..ac736b6902a7 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
@@ -3687,25 +3687,12 @@ void iwl_trans_pcie_sync_nmi(struct iwl_trans *trans)
 static struct iwl_trans *
 iwl_trans_pcie_alloc(struct pci_dev *pdev,
 		     const struct iwl_mac_cfg *mac_cfg,
-		     struct iwl_trans_info *info)
+		     struct iwl_trans_info *info, u8 __iomem *hw_base)
 {
 	struct iwl_trans_pcie *trans_pcie, **priv;
 	struct iwl_trans *trans;
 	unsigned int bc_tbl_n_entries;
 	int ret, addr_size;
-	u32 bar0;
-
-	/* reassign our BAR 0 if invalid due to possible runtime PM races */
-	pci_read_config_dword(pdev, PCI_BASE_ADDRESS_0, &bar0);
-	if (bar0 == PCI_BASE_ADDRESS_MEM_TYPE_64) {
-		ret = pci_assign_resource(pdev, 0);
-		if (ret)
-			return ERR_PTR(ret);
-	}
-
-	ret = pcim_enable_device(pdev);
-	if (ret)
-		return ERR_PTR(ret);
 
 	trans = iwl_trans_alloc(sizeof(struct iwl_trans_pcie), &pdev->dev,
 				mac_cfg);
@@ -3714,6 +3701,8 @@ iwl_trans_pcie_alloc(struct pci_dev *pdev,
 
 	trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 
+	trans_pcie->hw_base = hw_base;
+
 	/* Initialize the wait queue for commands */
 	init_waitqueue_head(&trans_pcie->wait_command_queue);
 
@@ -3811,8 +3800,6 @@ iwl_trans_pcie_alloc(struct pci_dev *pdev,
 				       PCIE_LINK_STATE_CLKPM);
 	}
 
-	pci_set_master(pdev);
-
 	addr_size = trans_pcie->txqs.tfd.addr_size;
 	ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(addr_size));
 	if (ret) {
@@ -3824,19 +3811,6 @@ iwl_trans_pcie_alloc(struct pci_dev *pdev,
 		}
 	}
 
-	ret = pcim_request_all_regions(pdev, DRV_NAME);
-	if (ret) {
-		dev_err(&pdev->dev, "Requesting all PCI BARs failed.\n");
-		goto out_no_pci;
-	}
-
-	trans_pcie->hw_base = pcim_iomap(pdev, 0, 0);
-	if (!trans_pcie->hw_base) {
-		dev_err(&pdev->dev, "Could not ioremap PCI BAR 0.\n");
-		ret = -ENODEV;
-		goto out_no_pci;
-	}
-
 	/* We disable the RETRY_TIMEOUT register (0x41) to keep
 	 * PCI Tx retries from interfering with C3 CPU state */
 	pci_write_config_byte(pdev, PCI_CFG_RETRY_TIMEOUT, 0x00);
@@ -3844,13 +3818,6 @@ iwl_trans_pcie_alloc(struct pci_dev *pdev,
 	trans_pcie->pci_dev = pdev;
 	iwl_disable_interrupts(trans);
 
-	info->hw_rev = iwl_read32(trans, CSR_HW_REV);
-	if (info->hw_rev == 0xffffffff) {
-		dev_err(&pdev->dev, "HW_REV=0xFFFFFFFF, PCI issues?\n");
-		ret = -EIO;
-		goto out_no_pci;
-	}
-
 	/*
 	 * In the 8000 HW family the format of the 4 bytes of CSR_HW_REV have
 	 * changed, and now the revision step also includes bit 0-1 (no more
@@ -4135,18 +4102,20 @@ static void iwl_pcie_check_me_status(struct iwl_trans *trans)
 
 int iwl_pci_gen1_2_probe(struct pci_dev *pdev,
 			 const struct pci_device_id *ent,
-			 const struct iwl_mac_cfg *trans)
+			 const struct iwl_mac_cfg *trans, u8 __iomem *hw_base,
+			 u32 hw_rev)
 {
 	const struct iwl_dev_info *dev_info;
 	struct iwl_trans_info info = {
 		.hw_id = (pdev->device << 16) + pdev->subsystem_device,
+		.hw_rev = hw_rev,
 	};
 	struct iwl_trans *iwl_trans;
 	struct iwl_trans_pcie *trans_pcie;
 	unsigned int txcmd_size, txcmd_align;
 	int ret;
 
-	iwl_trans = iwl_trans_pcie_alloc(pdev, trans, &info);
+	iwl_trans = iwl_trans_pcie_alloc(pdev, trans, &info, hw_base);
 	if (IS_ERR(iwl_trans))
 		return PTR_ERR(iwl_trans);
 
-- 
2.34.1


