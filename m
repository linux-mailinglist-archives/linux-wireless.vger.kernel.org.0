Return-Path: <linux-wireless+bounces-26641-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 70CF9B36F0F
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Aug 2025 17:57:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 354397AB108
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Aug 2025 15:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA882263C8E;
	Tue, 26 Aug 2025 15:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O46W3N2Y"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981E330ACEA
	for <linux-wireless@vger.kernel.org>; Tue, 26 Aug 2025 15:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756223748; cv=none; b=UBu4BRgCMKGhD1Gl6onnXf8IeTCtGkCz7OD4fUiB6ewnOy9D9mDKEkMj9iVzRizYlc57rTnb415EyM6mILH9L3Mmz8zkYJ+hTWI+eIn/RQst0BY7Nd3nGgMEbc5cnJpdf6jPaGUCBQJbM8KgIyUFeDGOTFtQTnLvE/MbAY7w1rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756223748; c=relaxed/simple;
	bh=p0wxvpjGPe96OFnHW7hfyVpqy6Nw93rkRMSXIRC5jDo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qZ3P14QJLGFWgBwf3gOwE0nIyHhiuXlocRCfRku9croz0LlOWtYTqEaoezmE/rQC37bnsUAQQ4RnzeNdx/upZGTGdMDgGk08RhbFDYEGiJui8jmfvF9MRFVD7+TUmovq+nj07y5mqvfmtjqbMqHJ76oHu4J7sG0kyK/Z6szw1uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O46W3N2Y; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756223746; x=1787759746;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=p0wxvpjGPe96OFnHW7hfyVpqy6Nw93rkRMSXIRC5jDo=;
  b=O46W3N2YNPBRGZj0zzokUWy0sjBRyC5h8qxs5jQKrMASd/05PVPou9fK
   gqbmMUAe2iRdmfMQak6MqhGAI5Uxt62V1b7Ret393ygdS3UQ7ivEzk0Hx
   RZFp6rwW1j5SX5P4+FVWdnMi1KUjdBdUJBK+P6/GHH01C9S5I76P8KsUH
   B9aGE9+I7rBzrXMq6XlhDBGUi38XWJBIYYA+yKEEPmvWz+v4G4joOmEaz
   x0QRrUievoK+wkEqSo2CvcM8qBNxXpJvSm/wG1926+mH95KFLhqqRR4tf
   to4OHjXX3U3fv5KldM8ChZQgBpeMw6afdbWVkHK8mXiun5Bys8nKY45LF
   w==;
X-CSE-ConnectionGUID: tFjvbNuRR46woGqE1K+WRQ==
X-CSE-MsgGUID: ai+OdFQMQ2iDLEUwHMkxKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11534"; a="62108413"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="62108413"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 08:55:35 -0700
X-CSE-ConnectionGUID: hvWRGfsATYOFhIECBMQMvw==
X-CSE-MsgGUID: jOYTmTwBQ1+oa6P11ekksg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="169218208"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 08:55:34 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Itamar Shalev <itamar.shalev@intel.com>
Subject: [PATCH iwlwifi-next 03/15] wifi: iwlwifi: pcie: relocate finish_nic_init logic to gen1_2
Date: Tue, 26 Aug 2025 18:54:52 +0300
Message-Id: <20250826184046.9fcc48d81435.I13403938219765b79c299ea081e8373d0e007785@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250826155504.2982930-1-miriam.rachel.korenblit@intel.com>
References: <20250826155504.2982930-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Itamar Shalev <itamar.shalev@intel.com>

Refactor finish_nic_init by moving its logic to the gen1_2 transport
layer.
Prepares for future gen3 support.

Signed-off-by: Itamar Shalev <itamar.shalev@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-io.c   | 89 +------------------
 .../intel/iwlwifi/pcie/gen1_2/internal.h      |  1 +
 .../intel/iwlwifi/pcie/gen1_2/trans.c         | 89 +++++++++++++++++++
 3 files changed, 92 insertions(+), 87 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-io.c b/drivers/net/wireless/intel/iwlwifi/iwl-io.c
index 5e483a55a4ba..0a68378dd505 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-io.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-io.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2003-2014, 2018-2022, 2024-2025 Intel Corporation
  * Copyright (C) 2015-2016 Intel Deutschland GmbH
  */
-#include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/export.h>
 
@@ -13,6 +12,7 @@
 #include "iwl-debug.h"
 #include "iwl-prph.h"
 #include "iwl-fh.h"
+#include "pcie/gen1_2/internal.h"
 
 void iwl_write8(struct iwl_trans *trans, u32 ofs, u8 val)
 {
@@ -396,94 +396,9 @@ int iwl_dump_fh(struct iwl_trans *trans, char **buf)
 	return 0;
 }
 
-#define IWL_HOST_MON_BLOCK_PEMON	0x00
-#define IWL_HOST_MON_BLOCK_HIPM		0x22
-
-#define IWL_HOST_MON_BLOCK_PEMON_VEC0	0x00
-#define IWL_HOST_MON_BLOCK_PEMON_VEC1	0x01
-#define IWL_HOST_MON_BLOCK_PEMON_WFPM	0x06
-
-static void iwl_dump_host_monitor_block(struct iwl_trans *trans,
-					u32 block, u32 vec, u32 iter)
-{
-	int i;
-
-	IWL_ERR(trans, "Host monitor block 0x%x vector 0x%x\n", block, vec);
-	iwl_write32(trans, CSR_MONITOR_CFG_REG, (block << 8) | vec);
-	for (i = 0; i < iter; i++)
-		IWL_ERR(trans, "    value [iter %d]: 0x%08x\n",
-			i, iwl_read32(trans, CSR_MONITOR_STATUS_REG));
-}
-
-static void iwl_dump_host_monitor(struct iwl_trans *trans)
-{
-	switch (trans->mac_cfg->device_family) {
-	case IWL_DEVICE_FAMILY_22000:
-	case IWL_DEVICE_FAMILY_AX210:
-		IWL_ERR(trans, "CSR_RESET = 0x%x\n",
-			iwl_read32(trans, CSR_RESET));
-		iwl_dump_host_monitor_block(trans, IWL_HOST_MON_BLOCK_PEMON,
-					    IWL_HOST_MON_BLOCK_PEMON_VEC0, 15);
-		iwl_dump_host_monitor_block(trans, IWL_HOST_MON_BLOCK_PEMON,
-					    IWL_HOST_MON_BLOCK_PEMON_VEC1, 15);
-		iwl_dump_host_monitor_block(trans, IWL_HOST_MON_BLOCK_PEMON,
-					    IWL_HOST_MON_BLOCK_PEMON_WFPM, 15);
-		iwl_dump_host_monitor_block(trans, IWL_HOST_MON_BLOCK_HIPM,
-					    IWL_HOST_MON_BLOCK_PEMON_VEC0, 1);
-		break;
-	default:
-		/* not supported yet */
-		return;
-	}
-}
-
 int iwl_finish_nic_init(struct iwl_trans *trans)
 {
-	const struct iwl_mac_cfg *mac_cfg = trans->mac_cfg;
-	u32 poll_ready;
-	int err;
-
-	if (mac_cfg->bisr_workaround) {
-		/* ensure the TOP FSM isn't still in previous reset */
-		mdelay(2);
-	}
-
-	/*
-	 * Set "initialization complete" bit to move adapter from
-	 * D0U* --> D0A* (powered-up active) state.
-	 */
-	if (mac_cfg->device_family >= IWL_DEVICE_FAMILY_BZ) {
-		iwl_set_bit(trans, CSR_GP_CNTRL,
-			    CSR_GP_CNTRL_REG_FLAG_BZ_MAC_ACCESS_REQ |
-			    CSR_GP_CNTRL_REG_FLAG_MAC_INIT);
-		poll_ready = CSR_GP_CNTRL_REG_FLAG_MAC_STATUS;
-	} else {
-		iwl_set_bit(trans, CSR_GP_CNTRL,
-			    CSR_GP_CNTRL_REG_FLAG_INIT_DONE);
-		poll_ready = CSR_GP_CNTRL_REG_FLAG_MAC_CLOCK_READY;
-	}
-
-	if (mac_cfg->device_family == IWL_DEVICE_FAMILY_8000)
-		udelay(2);
-
-	/*
-	 * Wait for clock stabilization; once stabilized, access to
-	 * device-internal resources is supported, e.g. iwl_write_prph()
-	 * and accesses to uCode SRAM.
-	 */
-	err = iwl_poll_bits(trans, CSR_GP_CNTRL, poll_ready, 25000);
-	if (err < 0) {
-		IWL_DEBUG_INFO(trans, "Failed to wake NIC\n");
-
-		iwl_dump_host_monitor(trans);
-	}
-
-	if (mac_cfg->bisr_workaround) {
-		/* ensure BISR shift has finished */
-		udelay(200);
-	}
-
-	return err < 0 ? err : 0;
+	return iwl_pcie_gen1_2_finish_nic_init(trans);
 }
 IWL_EXPORT_SYMBOL(iwl_finish_nic_init);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/internal.h b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/internal.h
index f48aeebb151c..eca524c6a9f3 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/internal.h
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/internal.h
@@ -1105,6 +1105,7 @@ int iwl_pcie_alloc_dma_ptr(struct iwl_trans *trans,
 			   struct iwl_dma_ptr *ptr, size_t size);
 void iwl_pcie_free_dma_ptr(struct iwl_trans *trans, struct iwl_dma_ptr *ptr);
 void iwl_pcie_apply_destination(struct iwl_trans *trans);
+int iwl_pcie_gen1_2_finish_nic_init(struct iwl_trans *trans);
 
 /* transport gen 2 exported functions */
 int iwl_trans_pcie_gen2_start_fw(struct iwl_trans *trans,
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
index 327366bf87de..3e50a935e1d0 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
@@ -32,6 +32,46 @@
 #include "pcie/iwl-context-info-v2.h"
 #include "pcie/utils.h"
 
+#define IWL_HOST_MON_BLOCK_PEMON	0x00
+#define IWL_HOST_MON_BLOCK_HIPM		0x22
+
+#define IWL_HOST_MON_BLOCK_PEMON_VEC0	0x00
+#define IWL_HOST_MON_BLOCK_PEMON_VEC1	0x01
+#define IWL_HOST_MON_BLOCK_PEMON_WFPM	0x06
+
+static void iwl_dump_host_monitor_block(struct iwl_trans *trans,
+					u32 block, u32 vec, u32 iter)
+{
+	int i;
+
+	IWL_ERR(trans, "Host monitor block 0x%x vector 0x%x\n", block, vec);
+	iwl_write32(trans, CSR_MONITOR_CFG_REG, (block << 8) | vec);
+	for (i = 0; i < iter; i++)
+		IWL_ERR(trans, "    value [iter %d]: 0x%08x\n",
+			i, iwl_read32(trans, CSR_MONITOR_STATUS_REG));
+}
+
+static void iwl_pcie_dump_host_monitor(struct iwl_trans *trans)
+{
+	switch (trans->mac_cfg->device_family) {
+	case IWL_DEVICE_FAMILY_22000:
+	case IWL_DEVICE_FAMILY_AX210:
+		IWL_ERR(trans, "CSR_RESET = 0x%x\n",
+			iwl_read32(trans, CSR_RESET));
+		iwl_dump_host_monitor_block(trans, IWL_HOST_MON_BLOCK_PEMON,
+					    IWL_HOST_MON_BLOCK_PEMON_VEC0, 15);
+		iwl_dump_host_monitor_block(trans, IWL_HOST_MON_BLOCK_PEMON,
+					    IWL_HOST_MON_BLOCK_PEMON_VEC1, 15);
+		iwl_dump_host_monitor_block(trans, IWL_HOST_MON_BLOCK_PEMON,
+					    IWL_HOST_MON_BLOCK_PEMON_WFPM, 15);
+		iwl_dump_host_monitor_block(trans, IWL_HOST_MON_BLOCK_HIPM,
+					    IWL_HOST_MON_BLOCK_PEMON_VEC0, 1);
+		break;
+	default:
+		return;
+	}
+}
+
 /* extended range in FW SRAM */
 #define IWL_FW_MEM_EXTENDED_START	0x40000
 #define IWL_FW_MEM_EXTENDED_END		0x57FFF
@@ -4271,3 +4311,52 @@ int iwl_pci_gen1_2_probe(struct pci_dev *pdev,
 	iwl_trans_pcie_free(iwl_trans);
 	return ret;
 }
+
+int iwl_pcie_gen1_2_finish_nic_init(struct iwl_trans *trans)
+{
+	const struct iwl_mac_cfg *mac_cfg = trans->mac_cfg;
+	u32 poll_ready;
+	int err;
+
+	if (mac_cfg->bisr_workaround) {
+		/* ensure the TOP FSM isn't still in previous reset */
+		mdelay(2);
+	}
+
+	/*
+	 * Set "initialization complete" bit to move adapter from
+	 * D0U* --> D0A* (powered-up active) state.
+	 */
+	if (mac_cfg->device_family >= IWL_DEVICE_FAMILY_BZ) {
+		iwl_set_bit(trans, CSR_GP_CNTRL,
+			    CSR_GP_CNTRL_REG_FLAG_BZ_MAC_ACCESS_REQ |
+			    CSR_GP_CNTRL_REG_FLAG_MAC_INIT);
+		poll_ready = CSR_GP_CNTRL_REG_FLAG_MAC_STATUS;
+	} else {
+		iwl_set_bit(trans, CSR_GP_CNTRL,
+			    CSR_GP_CNTRL_REG_FLAG_INIT_DONE);
+		poll_ready = CSR_GP_CNTRL_REG_FLAG_MAC_CLOCK_READY;
+	}
+
+	if (mac_cfg->device_family == IWL_DEVICE_FAMILY_8000)
+		udelay(2);
+
+	/*
+	 * Wait for clock stabilization; once stabilized, access to
+	 * device-internal resources is supported, e.g. iwl_write_prph()
+	 * and accesses to uCode SRAM.
+	 */
+	err = iwl_poll_bits(trans, CSR_GP_CNTRL, poll_ready, 25000);
+	if (err < 0) {
+		IWL_DEBUG_INFO(trans, "Failed to wake NIC\n");
+
+		iwl_pcie_dump_host_monitor(trans);
+	}
+
+	if (mac_cfg->bisr_workaround) {
+		/* ensure BISR shift has finished */
+		udelay(200);
+	}
+
+	return err;
+}
-- 
2.34.1


