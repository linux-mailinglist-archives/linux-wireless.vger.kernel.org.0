Return-Path: <linux-wireless+bounces-24061-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C01CAD6F6D
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Jun 2025 13:50:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7244E3B1DCE
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Jun 2025 11:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D347A220F2A;
	Thu, 12 Jun 2025 11:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bUOsZRyX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D095423A9B8
	for <linux-wireless@vger.kernel.org>; Thu, 12 Jun 2025 11:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749728966; cv=none; b=cS32jJdMq4lI2Tx0LBqbjsCHHx29yL6aGhEyhyQmzl5p8lEtsLoVDz5a21MZ2lqf94oWwN2tKIT67QpjVnts2GGqvBOSPlSZ2l8iWolnOtABroFlHayiRB7SBE6rfaOutVkhj5bxUXyHScdpC7GzFhGQRKKMehfHQQ27ldhWvZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749728966; c=relaxed/simple;
	bh=hO0uMluhPsFCzrRzd2WWHQsrlo6ugkNNwS7nnVGPy2U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LYxYo+9uB4/aMvjQxcr143dJwRMR1XQYXdcuNrzf+wUtAMOCjKDDSyXqg18z2IoeqRfvyJSEwBDmzEHOijOs1l7Ne9pEnsXRKPfzf4ZynhkIuM36JtqpyVJbw2jPrAUKRFKE01fjGVjmRcUNMabC+tJSPp3r5yfPmZEWxaP7ZHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bUOsZRyX; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749728966; x=1781264966;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hO0uMluhPsFCzrRzd2WWHQsrlo6ugkNNwS7nnVGPy2U=;
  b=bUOsZRyXsD9Os4sJlAc1eIqmoSMnfrkaE04dJjsdn/MjXkLSN+ZfDdWj
   pnwzTG8d+sgRM1jFj+fq2x81ltqerLwRuQm7v0RDDzJtyafSjZq7NTPvH
   FFo3k63wNDdXtW0Edc2zt+ntjCb7SIRqgFoz6DanBTzUDm8QnNBpY2RlG
   je/88EAhhsBzsEDh6drYMtMzz9W8EsrxOeCH24tAGL983K/KO06OWjIWG
   j+djq0WV/hgpJW4FJYbZX5Bnqvh0jEZbTzH6HHHTe+9ta/bSNw0NlMGTK
   eQ/BDls1M1/8rrIrhLV3DCG/DjUczqa7cRmvEYqEgkxUF7qCG6iRm8Mhn
   g==;
X-CSE-ConnectionGUID: CkX53yOjQ/OYy8dh4tauAg==
X-CSE-MsgGUID: BJkQqqA+RLiUjC/xBN3ptQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11461"; a="63248344"
X-IronPort-AV: E=Sophos;i="6.16,230,1744095600"; 
   d="scan'208";a="63248344"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2025 04:49:25 -0700
X-CSE-ConnectionGUID: 79sQBzqMQkeuYLglo7P7+g==
X-CSE-MsgGUID: dMO1ctHiR9q0dD/MIxtMuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,230,1744095600"; 
   d="scan'208";a="147382139"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2025 04:49:23 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Rotem Kerem <rotem.kerem@intel.com>
Subject: [PATCH iwlwifi-next 07/13] wifi: iwlwifi: pcie: move iwl_trans_pcie_dump_regs() to utils.c
Date: Thu, 12 Jun 2025 14:48:53 +0300
Message-Id: <20250612144708.06950459ce97.I3105158eb9ae698efebe4b9ada1093aeb1f1b869@changeid>
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

Move the iwl_trans_pcie_dump_regs() function to utils.c in the PCIe
directory since it operates on PCIe registers and is not
hardware-dependent.

Refactor the pcie_dbg_dumped_once indicator, previously part of the
iwl_trans_pcie struct, into a static variable within the
iwl_trans_pcie_dump_regs() function, where it is used.

Signed-off-by: Rotem Kerem <rotem.kerem@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/Makefile   |   2 +-
 .../intel/iwlwifi/pcie/gen1_2/internal.h      |   3 -
 .../intel/iwlwifi/pcie/gen1_2/trans.c         | 101 +----------------
 .../net/wireless/intel/iwlwifi/pcie/utils.c   | 104 ++++++++++++++++++
 .../net/wireless/intel/iwlwifi/pcie/utils.h   |  11 ++
 5 files changed, 120 insertions(+), 101 deletions(-)
 create mode 100644 drivers/net/wireless/intel/iwlwifi/pcie/utils.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/pcie/utils.h

diff --git a/drivers/net/wireless/intel/iwlwifi/Makefile b/drivers/net/wireless/intel/iwlwifi/Makefile
index 71101067b889..b82392978b76 100644
--- a/drivers/net/wireless/intel/iwlwifi/Makefile
+++ b/drivers/net/wireless/intel/iwlwifi/Makefile
@@ -9,7 +9,7 @@ iwlwifi-objs		+= iwl-utils.o
 iwlwifi-objs		+= iwl-phy-db.o iwl-nvm-parse.o
 
 # Bus
-iwlwifi-objs		+= pcie/ctxt-info.o pcie/ctxt-info-v2.o pcie/drv.o
+iwlwifi-objs		+= pcie/ctxt-info.o pcie/ctxt-info-v2.o pcie/drv.o pcie/utils.o
 iwlwifi-objs		+= pcie/gen1_2/rx.o pcie/gen1_2/tx.o pcie/gen1_2/trans.o
 iwlwifi-objs		+= pcie/gen1_2/trans-gen2.o pcie/gen1_2/tx-gen2.o
 
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/internal.h b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/internal.h
index b1dcaae0dc10..52c6c22e2cc6 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/internal.h
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/internal.h
@@ -384,7 +384,6 @@ struct iwl_pcie_txqs {
  * @txq_memory: TXQ allocation array
  * @sx_waitq: waitqueue for Sx transitions
  * @sx_state: state tracking Sx transitions
- * @pcie_dbg_dumped_once: indicates PCIe regs were dumped already
  * @opmode_down: indicates opmode went away
  * @num_rx_bufs: number of RX buffers to allocate/use
  * @affinity_mask: IRQ affinity mask for each RX queue
@@ -460,7 +459,6 @@ struct iwl_trans_pcie {
 
 	u16 num_rx_bufs;
 
-	bool pcie_dbg_dumped_once;
 	u32 rx_page_order;
 	u32 rx_buf_bytes;
 	u32 supported_dma_mask;
@@ -1069,7 +1067,6 @@ static inline bool iwl_pcie_dbg_on(struct iwl_trans *trans)
 }
 
 void iwl_trans_pcie_rf_kill(struct iwl_trans *trans, bool state, bool from_irq);
-void iwl_trans_pcie_dump_regs(struct iwl_trans *trans);
 
 #ifdef CONFIG_IWLWIFI_DEBUGFS
 void iwl_trans_pcie_dbgfs_register(struct iwl_trans *trans);
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
index 6054ebebd8c8..c31a62b8f925 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
@@ -29,105 +29,12 @@
 #include "internal.h"
 #include "iwl-fh.h"
 #include "pcie/iwl-context-info-v2.h"
+#include "pcie/utils.h"
 
 /* extended range in FW SRAM */
 #define IWL_FW_MEM_EXTENDED_START	0x40000
 #define IWL_FW_MEM_EXTENDED_END		0x57FFF
 
-void iwl_trans_pcie_dump_regs(struct iwl_trans *trans)
-{
-#define PCI_DUMP_SIZE		352
-#define PCI_MEM_DUMP_SIZE	64
-#define PCI_PARENT_DUMP_SIZE	524
-#define PREFIX_LEN		32
-	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
-	struct pci_dev *pdev = trans_pcie->pci_dev;
-	u32 i, pos, alloc_size, *ptr, *buf;
-	char *prefix;
-
-	if (trans_pcie->pcie_dbg_dumped_once)
-		return;
-
-	/* Should be a multiple of 4 */
-	BUILD_BUG_ON(PCI_DUMP_SIZE > 4096 || PCI_DUMP_SIZE & 0x3);
-	BUILD_BUG_ON(PCI_MEM_DUMP_SIZE > 4096 || PCI_MEM_DUMP_SIZE & 0x3);
-	BUILD_BUG_ON(PCI_PARENT_DUMP_SIZE > 4096 || PCI_PARENT_DUMP_SIZE & 0x3);
-
-	/* Alloc a max size buffer */
-	alloc_size = PCI_ERR_ROOT_ERR_SRC +  4 + PREFIX_LEN;
-	alloc_size = max_t(u32, alloc_size, PCI_DUMP_SIZE + PREFIX_LEN);
-	alloc_size = max_t(u32, alloc_size, PCI_MEM_DUMP_SIZE + PREFIX_LEN);
-	alloc_size = max_t(u32, alloc_size, PCI_PARENT_DUMP_SIZE + PREFIX_LEN);
-
-	buf = kmalloc(alloc_size, GFP_ATOMIC);
-	if (!buf)
-		return;
-	prefix = (char *)buf + alloc_size - PREFIX_LEN;
-
-	IWL_ERR(trans, "iwlwifi transaction failed, dumping registers\n");
-
-	/* Print wifi device registers */
-	sprintf(prefix, "iwlwifi %s: ", pci_name(pdev));
-	IWL_ERR(trans, "iwlwifi device config registers:\n");
-	for (i = 0, ptr = buf; i < PCI_DUMP_SIZE; i += 4, ptr++)
-		if (pci_read_config_dword(pdev, i, ptr))
-			goto err_read;
-	print_hex_dump(KERN_ERR, prefix, DUMP_PREFIX_OFFSET, 32, 4, buf, i, 0);
-
-	IWL_ERR(trans, "iwlwifi device memory mapped registers:\n");
-	for (i = 0, ptr = buf; i < PCI_MEM_DUMP_SIZE; i += 4, ptr++)
-		*ptr = iwl_read32(trans, i);
-	print_hex_dump(KERN_ERR, prefix, DUMP_PREFIX_OFFSET, 32, 4, buf, i, 0);
-
-	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_ERR);
-	if (pos) {
-		IWL_ERR(trans, "iwlwifi device AER capability structure:\n");
-		for (i = 0, ptr = buf; i < PCI_ERR_ROOT_COMMAND; i += 4, ptr++)
-			if (pci_read_config_dword(pdev, pos + i, ptr))
-				goto err_read;
-		print_hex_dump(KERN_ERR, prefix, DUMP_PREFIX_OFFSET,
-			       32, 4, buf, i, 0);
-	}
-
-	/* Print parent device registers next */
-	if (!pdev->bus->self)
-		goto out;
-
-	pdev = pdev->bus->self;
-	sprintf(prefix, "iwlwifi %s: ", pci_name(pdev));
-
-	IWL_ERR(trans, "iwlwifi parent port (%s) config registers:\n",
-		pci_name(pdev));
-	for (i = 0, ptr = buf; i < PCI_PARENT_DUMP_SIZE; i += 4, ptr++)
-		if (pci_read_config_dword(pdev, i, ptr))
-			goto err_read;
-	print_hex_dump(KERN_ERR, prefix, DUMP_PREFIX_OFFSET, 32, 4, buf, i, 0);
-
-	/* Print root port AER registers */
-	pos = 0;
-	pdev = pcie_find_root_port(pdev);
-	if (pdev)
-		pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_ERR);
-	if (pos) {
-		IWL_ERR(trans, "iwlwifi root port (%s) AER cap structure:\n",
-			pci_name(pdev));
-		sprintf(prefix, "iwlwifi %s: ", pci_name(pdev));
-		for (i = 0, ptr = buf; i <= PCI_ERR_ROOT_ERR_SRC; i += 4, ptr++)
-			if (pci_read_config_dword(pdev, pos + i, ptr))
-				goto err_read;
-		print_hex_dump(KERN_ERR, prefix, DUMP_PREFIX_OFFSET, 32,
-			       4, buf, i, 0);
-	}
-	goto out;
-
-err_read:
-	print_hex_dump(KERN_ERR, prefix, DUMP_PREFIX_OFFSET, 32, 4, buf, i, 0);
-	IWL_ERR(trans, "Read failed at 0x%X\n", i);
-out:
-	trans_pcie->pcie_dbg_dumped_once = 1;
-	kfree(buf);
-}
-
 int iwl_trans_pcie_sw_reset(struct iwl_trans *trans, bool retake_ownership)
 {
 	/* Reset entire device - do controller reset (results in SHRD_HW_RST) */
@@ -704,7 +611,7 @@ static int iwl_pcie_load_firmware_chunk(struct iwl_trans *trans,
 				 trans_pcie->ucode_write_complete, 5 * HZ);
 	if (!ret) {
 		IWL_ERR(trans, "Failed to load firmware chunk!\n");
-		iwl_trans_pcie_dump_regs(trans);
+		iwl_trans_pcie_dump_regs(trans, trans_pcie->pci_dev);
 		return -ETIMEDOUT;
 	}
 
@@ -2460,7 +2367,7 @@ bool __iwl_trans_pcie_grab_nic_access(struct iwl_trans *trans, bool silent)
 			  "Timeout waiting for hardware access (CSR_GP_CNTRL 0x%08x)\n",
 			  cntrl);
 
-		iwl_trans_pcie_dump_regs(trans);
+		iwl_trans_pcie_dump_regs(trans, trans_pcie->pci_dev);
 
 		if (iwlwifi_mod_params.remove_when_gone && cntrl == ~0U)
 			iwl_trans_pcie_reset(trans,
@@ -4057,7 +3964,7 @@ int iwl_trans_pcie_copy_imr(struct iwl_trans *trans,
 				 IMR_D2S_REQUESTED, 5 * HZ);
 	if (!ret || trans_pcie->imr_status == IMR_D2S_ERROR) {
 		IWL_ERR(trans, "Failed to copy IMR Memory chunk!\n");
-		iwl_trans_pcie_dump_regs(trans);
+		iwl_trans_pcie_dump_regs(trans, trans_pcie->pci_dev);
 		return -ETIMEDOUT;
 	}
 	trans_pcie->imr_status = IMR_D2S_IDLE;
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/utils.c b/drivers/net/wireless/intel/iwlwifi/pcie/utils.c
new file mode 100644
index 000000000000..1bb274d8390c
--- /dev/null
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/utils.c
@@ -0,0 +1,104 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/*
+ * Copyright (C) 2025 Intel Corporation
+ */
+
+#include <linux/pci.h>
+#include <linux/gfp.h>
+
+#include "iwl-io.h"
+#include "pcie/utils.h"
+
+void iwl_trans_pcie_dump_regs(struct iwl_trans *trans, struct pci_dev *pdev)
+{
+#define PCI_DUMP_SIZE		352
+#define PCI_MEM_DUMP_SIZE	64
+#define PCI_PARENT_DUMP_SIZE	524
+#define PREFIX_LEN		32
+
+	static bool pcie_dbg_dumped_once = 0;
+	u32 i, pos, alloc_size, *ptr, *buf;
+	char *prefix;
+
+	if (pcie_dbg_dumped_once)
+		return;
+
+	/* Should be a multiple of 4 */
+	BUILD_BUG_ON(PCI_DUMP_SIZE > 4096 || PCI_DUMP_SIZE & 0x3);
+	BUILD_BUG_ON(PCI_MEM_DUMP_SIZE > 4096 || PCI_MEM_DUMP_SIZE & 0x3);
+	BUILD_BUG_ON(PCI_PARENT_DUMP_SIZE > 4096 || PCI_PARENT_DUMP_SIZE & 0x3);
+
+	/* Alloc a max size buffer */
+	alloc_size = PCI_ERR_ROOT_ERR_SRC +  4 + PREFIX_LEN;
+	alloc_size = max_t(u32, alloc_size, PCI_DUMP_SIZE + PREFIX_LEN);
+	alloc_size = max_t(u32, alloc_size, PCI_MEM_DUMP_SIZE + PREFIX_LEN);
+	alloc_size = max_t(u32, alloc_size, PCI_PARENT_DUMP_SIZE + PREFIX_LEN);
+
+	buf = kmalloc(alloc_size, GFP_ATOMIC);
+	if (!buf)
+		return;
+	prefix = (char *)buf + alloc_size - PREFIX_LEN;
+
+	IWL_ERR(trans, "iwlwifi transaction failed, dumping registers\n");
+
+	/* Print wifi device registers */
+	sprintf(prefix, "iwlwifi %s: ", pci_name(pdev));
+	IWL_ERR(trans, "iwlwifi device config registers:\n");
+	for (i = 0, ptr = buf; i < PCI_DUMP_SIZE; i += 4, ptr++)
+		if (pci_read_config_dword(pdev, i, ptr))
+			goto err_read;
+	print_hex_dump(KERN_ERR, prefix, DUMP_PREFIX_OFFSET, 32, 4, buf, i, 0);
+
+	IWL_ERR(trans, "iwlwifi device memory mapped registers:\n");
+	for (i = 0, ptr = buf; i < PCI_MEM_DUMP_SIZE; i += 4, ptr++)
+		*ptr = iwl_read32(trans, i);
+	print_hex_dump(KERN_ERR, prefix, DUMP_PREFIX_OFFSET, 32, 4, buf, i, 0);
+
+	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_ERR);
+	if (pos) {
+		IWL_ERR(trans, "iwlwifi device AER capability structure:\n");
+		for (i = 0, ptr = buf; i < PCI_ERR_ROOT_COMMAND; i += 4, ptr++)
+			if (pci_read_config_dword(pdev, pos + i, ptr))
+				goto err_read;
+		print_hex_dump(KERN_ERR, prefix, DUMP_PREFIX_OFFSET,
+			       32, 4, buf, i, 0);
+	}
+
+	/* Print parent device registers next */
+	if (!pdev->bus->self)
+		goto out;
+
+	pdev = pdev->bus->self;
+	sprintf(prefix, "iwlwifi %s: ", pci_name(pdev));
+
+	IWL_ERR(trans, "iwlwifi parent port (%s) config registers:\n",
+		pci_name(pdev));
+	for (i = 0, ptr = buf; i < PCI_PARENT_DUMP_SIZE; i += 4, ptr++)
+		if (pci_read_config_dword(pdev, i, ptr))
+			goto err_read;
+	print_hex_dump(KERN_ERR, prefix, DUMP_PREFIX_OFFSET, 32, 4, buf, i, 0);
+
+	/* Print root port AER registers */
+	pos = 0;
+	pdev = pcie_find_root_port(pdev);
+	if (pdev)
+		pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_ERR);
+	if (pos) {
+		IWL_ERR(trans, "iwlwifi root port (%s) AER cap structure:\n",
+			pci_name(pdev));
+		sprintf(prefix, "iwlwifi %s: ", pci_name(pdev));
+		for (i = 0, ptr = buf; i <= PCI_ERR_ROOT_ERR_SRC; i += 4, ptr++)
+			if (pci_read_config_dword(pdev, pos + i, ptr))
+				goto err_read;
+		print_hex_dump(KERN_ERR, prefix, DUMP_PREFIX_OFFSET, 32,
+			       4, buf, i, 0);
+	}
+	goto out;
+
+err_read:
+	print_hex_dump(KERN_ERR, prefix, DUMP_PREFIX_OFFSET, 32, 4, buf, i, 0);
+	IWL_ERR(trans, "Read failed at 0x%X\n", i);
+out:
+	pcie_dbg_dumped_once = 1;
+	kfree(buf);
+}
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/utils.h b/drivers/net/wireless/intel/iwlwifi/pcie/utils.h
new file mode 100644
index 000000000000..af2a2eec7ec5
--- /dev/null
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/utils.h
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/*
+ * Copyright (C) 2025 Intel Corporation
+ */
+
+#ifndef __iwl_pcie_utils_h__
+#define __iwl_pcie_utils_h__
+
+void iwl_trans_pcie_dump_regs(struct iwl_trans *trans, struct pci_dev *pdev);
+
+#endif /* __iwl_pcie_utils_h__ */
-- 
2.34.1


