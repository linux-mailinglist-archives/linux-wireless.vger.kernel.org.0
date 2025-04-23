Return-Path: <linux-wireless+bounces-21876-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A0BCA97E59
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Apr 2025 07:51:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 553AE3B9C73
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Apr 2025 05:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E185C266588;
	Wed, 23 Apr 2025 05:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VrQWfTdj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33EE8266EEC
	for <linux-wireless@vger.kernel.org>; Wed, 23 Apr 2025 05:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745387474; cv=none; b=CH/NIq1e6e3WT7jBqlGO5J2IvGVpxX+33ZRIC/L0VhpwrS0D1AeeXeOY3GvqwznhNHyy9H/jD4yNa4VV0g/mRWzbso8mq7QkDOKTf/052wZIznz1MSm9X53GqGULotMN9aN8oQJsIMEPlR+77DhbhMPe7KGu8mm/GxRgqbiXMZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745387474; c=relaxed/simple;
	bh=UkAADFo0UYHBV0q0TZkSj04OYM6ck3zpHYZFaj2SALw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jrSDdzwgFqLgfIgnUyk/I+3bY7gcDmwuNM49lMeJktd4EAW8hS4JHopHPyIfuaiJq+k6oXn0PyHw6pykVXkXJduXdpK9YpqoNBnd+a5V4mren5N/OqiOC1wFr3mIgv8viveaqYirTokVpHlvwK/VsnjnCeGA0+4Wht3R1Gaphto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VrQWfTdj; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745387473; x=1776923473;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UkAADFo0UYHBV0q0TZkSj04OYM6ck3zpHYZFaj2SALw=;
  b=VrQWfTdjNYLmeDjMxiF7lnOvxEnJIHh5a06w81/sKB6ziKfRowXIu5rP
   j6m2N3bNBNMCDXCEXS+V2cuT0uX/MTo56gHAikfmLHc9vybNJ6OM7MCS7
   w1yxxwE/SGsxwm4cpX4l49Q0Kp6ZqWTxjMKnYgIGe9YcMR1WqWm8C9MK/
   em3Q0djSpnludnoyC0Xgfok1sfVs7NkoupJu9F5fZqdTXORrrzJx0KCR6
   sfs5uZChqyAsLyhU1fZYz/P6rS9DMS4TS3Sk9Jp5q2pgheyL8WTUvUcBw
   4kRjwFkNLrQ3afcI8ZGYKA8ykXS55hMWOeItgXju/umyvd0Goag4dkltk
   A==;
X-CSE-ConnectionGUID: YkgaNbK2RbSxZlmchWJBrw==
X-CSE-MsgGUID: PqXEGy2+QaebwZRJJR62QA==
X-IronPort-AV: E=McAfee;i="6700,10204,11411"; a="46844656"
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="46844656"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 22:51:13 -0700
X-CSE-ConnectionGUID: vIYhwt5wSNiMtQzx1Zg7PA==
X-CSE-MsgGUID: 1vRZLk38Q5a12ZUmwsuZKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="133164378"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 22:51:12 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH wireless 16/17] wifi: iwlwifi: pcie: add support for the reset handshake in MSI
Date: Wed, 23 Apr 2025 08:50:35 +0300
Message-Id: <20250423084826.ea278ad99247.Ia359071e6148218c26f18e783a8130c681d77df7@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250423055036.2262960-1-miriam.rachel.korenblit@intel.com>
References: <20250423055036.2262960-1-miriam.rachel.korenblit@intel.com>
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
index bfa050d987db..413a271beb9b 100644
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


