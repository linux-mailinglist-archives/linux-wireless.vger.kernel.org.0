Return-Path: <linux-wireless+bounces-21980-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 267E4A9ADA7
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Apr 2025 14:38:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D5E3194053A
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Apr 2025 12:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FF0C1C701A;
	Thu, 24 Apr 2025 12:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mWKuTMaP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5932A23816F
	for <linux-wireless@vger.kernel.org>; Thu, 24 Apr 2025 12:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745498330; cv=none; b=NRRAO4TbXbKuFdOe2MIR8irnwaWF0DQh2uKor7TfmFf8UZVi51+ugTLhOfqPrNmzXnXbueWH7JH/FnzDFbR9xGhcFmsDAhkMQO2dQQpsSJ3gavJwC4XbI4UAIz9XmYMyUy6FOPDvgnZVbABpgSotOlw94US+kXOOaGybKliPKxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745498330; c=relaxed/simple;
	bh=Xm5L/rdGOp0lvC/4RkafHF8hE5ECIYrXjCGtOLoUx3w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Yk/1t3HEBhj4ZNsflLJOL5m1s+mOUia37na3UVuWo7Tk+GKliv6DZI5G5HFvDxfU2js6ZHEsDLdRiykzBgvEJorjMBKvFeoA2L3S/hy+dAyQncwPo50bUSWowbJvA4x7DCgQYiQfPAecYnUWSZfCJkLNqvHk2FgiZ66E5yHWQos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mWKuTMaP; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745498328; x=1777034328;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Xm5L/rdGOp0lvC/4RkafHF8hE5ECIYrXjCGtOLoUx3w=;
  b=mWKuTMaPSy7tC0XOFCnL9wPs9bI8L7tf3ZFOy2mn/KrJQVTy8L1/41kK
   e+rjMVxLExRj4LT4+A0HoIbUdCXp1zfPGJbEt0eHikQBOK41DzrGBdRrT
   WXBBqSjmwlWVhxatvljgVxojeA9Sqvfwx/IX6RWd6rAmg8DQT4GtHtVo6
   qwpxdpOrpHUPj+KpB+vN2JW/FAEpUaWCwcodfesDwdeFC9CUChU0eXSVa
   lBjrUfmJpUC+qEyTZoXwUSUJaRuNhXH+gZV4iwivk53uOhN/qJij86nk1
   NjTZTKS41n77yIo/L1HhurkuFyy9HQrwW8fjKZLLeZfaXCOolwRcVVoms
   Q==;
X-CSE-ConnectionGUID: eK4gZIb2RTq8KUzZd+1g8A==
X-CSE-MsgGUID: aK83RUObQD+bg8VJCSryYQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11413"; a="47302402"
X-IronPort-AV: E=Sophos;i="6.15,236,1739865600"; 
   d="scan'208";a="47302402"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 05:38:47 -0700
X-CSE-ConnectionGUID: qIE9IUgdSb65J4r+MfS6IQ==
X-CSE-MsgGUID: J5SLzKaLSTqCZxfaQrImsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,236,1739865600"; 
   d="scan'208";a="133137375"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 05:38:46 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH wireless-next 01/14] wifi: iwlwifi: pcie: add support for the reset handshake in MSI
Date: Thu, 24 Apr 2025 15:38:18 +0300
Message-Id: <20250424153620.758cdfbb78dc.Ia359071e6148218c26f18e783a8130c681d77df7@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250424123831.3524359-1-miriam.rachel.korenblit@intel.com>
References: <20250424123831.3524359-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

Add the proper case in the MSI interrupt handler and read the non-MSIx
interrupt cause register in case of timeout.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-csr.h  | 20 ++++++++++---------
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c  | 14 ++++++++++++-
 .../wireless/intel/iwlwifi/pcie/trans-gen2.c  | 18 +++++++++++++----
 3 files changed, 38 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-csr.h b/drivers/net/wireless/intel/iwlwifi/iwl-csr.h
index be9e464c9b7b..f259747e21b3 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-csr.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-csr.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2005-2014, 2018-2024 Intel Corporation
+ * Copyright (C) 2005-2014, 2018-2025 Intel Corporation
  * Copyright (C) 2013-2014 Intel Mobile Communications GmbH
  * Copyright (C) 2016 Intel Deutschland GmbH
  */
@@ -193,17 +193,19 @@
 #define CSR_INT_BIT_RF_KILL      (1 << 7)  /* HW RFKILL switch GP_CNTRL[27] toggled */
 #define CSR_INT_BIT_CT_KILL      (1 << 6)  /* Critical temp (chip too hot) rfkill */
 #define CSR_INT_BIT_SW_RX        (1 << 3)  /* Rx, command responses */
+#define CSR_INT_BIT_RESET_DONE   (1 << 2)  /* reset handshake with firmware is done */
 #define CSR_INT_BIT_WAKEUP       (1 << 1)  /* NIC controller waking up (pwr mgmt) */
 #define CSR_INT_BIT_ALIVE        (1 << 0)  /* uCode interrupts once it initializes */
 
-#define CSR_INI_SET_MASK	(CSR_INT_BIT_FH_RX   | \
-				 CSR_INT_BIT_HW_ERR  | \
-				 CSR_INT_BIT_FH_TX   | \
-				 CSR_INT_BIT_SW_ERR  | \
-				 CSR_INT_BIT_RF_KILL | \
-				 CSR_INT_BIT_SW_RX   | \
-				 CSR_INT_BIT_WAKEUP  | \
-				 CSR_INT_BIT_ALIVE   | \
+#define CSR_INI_SET_MASK	(CSR_INT_BIT_FH_RX	| \
+				 CSR_INT_BIT_HW_ERR	| \
+				 CSR_INT_BIT_FH_TX	| \
+				 CSR_INT_BIT_SW_ERR	| \
+				 CSR_INT_BIT_RF_KILL	| \
+				 CSR_INT_BIT_SW_RX	| \
+				 CSR_INT_BIT_WAKEUP	| \
+				 CSR_INT_BIT_RESET_DONE	| \
+				 CSR_INT_BIT_ALIVE	| \
 				 CSR_INT_BIT_RX_PERIODIC)
 
 /* interrupt flags in FH (flow handler) (PCI busmaster DMA) */
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
index 4a4f8de4efe2..337324eea1a1 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
@@ -1947,6 +1947,13 @@ irqreturn_t iwl_pcie_irq_handler(int irq, void *dev_id)
 		handled |= CSR_INT_BIT_ALIVE;
 	}
 
+	if (inta & CSR_INT_BIT_RESET_DONE) {
+		IWL_DEBUG_ISR(trans, "Reset flow completed\n");
+		trans_pcie->fw_reset_state = FW_RESET_OK;
+		handled |= CSR_INT_BIT_RESET_DONE;
+		wake_up(&trans_pcie->fw_reset_waitq);
+	}
+
 	/* Safely ignore these bits for debug checks below */
 	inta &= ~(CSR_INT_BIT_SCD | CSR_INT_BIT_ALIVE);
 
@@ -1968,7 +1975,12 @@ irqreturn_t iwl_pcie_irq_handler(int irq, void *dev_id)
 		IWL_ERR(trans, "Microcode SW error detected. "
 			" Restarting 0x%X.\n", inta);
 		isr_stats->sw++;
-		iwl_pcie_irq_handle_error(trans);
+		if (trans_pcie->fw_reset_state == FW_RESET_REQUESTED) {
+			trans_pcie->fw_reset_state = FW_RESET_ERROR;
+			wake_up(&trans_pcie->fw_reset_waitq);
+		} else {
+			iwl_pcie_irq_handle_error(trans);
+		}
 		handled |= CSR_INT_BIT_SW_ERR;
 	}
 
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
index cfd94205be49..08409e24aed6 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
@@ -117,13 +117,23 @@ void iwl_trans_pcie_fw_reset_handshake(struct iwl_trans *trans)
 				 trans_pcie->fw_reset_state != FW_RESET_REQUESTED,
 				 FW_RESET_TIMEOUT);
 	if (!ret || trans_pcie->fw_reset_state == FW_RESET_ERROR) {
-		u32 inta_hw = iwl_read32(trans, CSR_MSIX_HW_INT_CAUSES_AD);
+		bool reset_done;
+		u32 inta_hw;
+
+		if (trans_pcie->msix_enabled) {
+			inta_hw = iwl_read32(trans, CSR_MSIX_HW_INT_CAUSES_AD);
+			reset_done =
+				inta_hw & MSIX_HW_INT_CAUSES_REG_RESET_DONE;
+		} else {
+			inta_hw = iwl_read32(trans, CSR_INT_MASK);
+			reset_done = inta_hw & CSR_INT_BIT_RESET_DONE;
+		}
 
 		IWL_ERR(trans,
-			"timeout waiting for FW reset ACK (inta_hw=0x%x)\n",
-			inta_hw);
+			"timeout waiting for FW reset ACK (inta_hw=0x%x, reset_done %d)\n",
+			inta_hw, reset_done);
 
-		if (!(inta_hw & MSIX_HW_INT_CAUSES_REG_RESET_DONE)) {
+		if (!reset_done) {
 			struct iwl_fw_error_dump_mode mode = {
 				.type = IWL_ERR_TYPE_RESET_HS_TIMEOUT,
 				.context = IWL_ERR_CONTEXT_FROM_OPMODE,
-- 
2.34.1


