Return-Path: <linux-wireless+bounces-22213-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 500A2AA1BA0
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Apr 2025 21:54:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 240527A685E
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Apr 2025 19:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95FE926159A;
	Tue, 29 Apr 2025 19:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ITuAYK6K"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7689266F10
	for <linux-wireless@vger.kernel.org>; Tue, 29 Apr 2025 19:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745956457; cv=none; b=iQv2IohdfAFFQhcHM1xpMiNyfLX0kJ5tw2t/mfjR0sXjhcOrCOPEAVsUNfQV7rS7HyQogPOjNji5QwbrR/WlvQ2UfmpP9kU77Oy5/Mwjxb8Rcgco4vSsOP1LYubwX3SysZ7sZoQE2YNzFtiPB3agHPYvDCDkQR8lVw61ls0Ar+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745956457; c=relaxed/simple;
	bh=/aoJeCW/3/qZaEksf+mtI2lKBbW76eVjYsUpl1LQNsk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u6V3Fn04fAG8qMJ7aw70v1pJWCzQbgbGtLRq9ScF/p6rnchtQApWOCjIRn+TeILUeKQX3WSmCulPW+k0120t3vUUUlXodtjR/e7UGJJAogoGe1Za4RQnJeYo70jFqsgm2UD+/YFJW6ugp7F79n2nEhvF5VLaiyr13vo6mVUOMDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ITuAYK6K; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745956456; x=1777492456;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/aoJeCW/3/qZaEksf+mtI2lKBbW76eVjYsUpl1LQNsk=;
  b=ITuAYK6KB9QVT1ou0mLtDVUNsPsEEUBQPVP9XtEEcr3/kHAIG7cCFpW/
   wkPpew+YU/apBtK/tVs59FKUaXiK7epNu76iogr2g2HPmQKQVyCkPThcu
   u8kFDb89LehiKAFiaN37xJNH7683dFYe09umWnKHp5GJwgvDycXAzK4sL
   pTnNNHB0ZwRj60SM++hYysDShydFlBoXnts1KVjnSCDCJnvsylRxCYHwL
   ULkgRSLXPm1hfSKq+UcS3q/7XqGtJCwjvTYgfMVp/CH6SIUprbQWfkS0L
   Cos5LZ2uK3knCSzWl2wO4RqmZienploAC2BIkJTNynJmLKxayMDsjrzhK
   A==;
X-CSE-ConnectionGUID: XbAAfCqKQdSS5suij97qNw==
X-CSE-MsgGUID: oJbBlGCjRBedOnjS6hoCgg==
X-IronPort-AV: E=McAfee;i="6700,10204,11418"; a="46713569"
X-IronPort-AV: E=Sophos;i="6.15,250,1739865600"; 
   d="scan'208";a="46713569"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2025 12:54:15 -0700
X-CSE-ConnectionGUID: HN29WGCwRnSOdYNJSqAQnw==
X-CSE-MsgGUID: z/SsSqX9S4S09nNRh9qZfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,250,1739865600"; 
   d="scan'208";a="171155010"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2025 12:54:14 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: miriam.rachel.korenblit@intel.com
Cc: johannes@sipsolutions.net,
	linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 08/14] wifi: iwlwifi: implement TOP reset follower
Date: Tue, 29 Apr 2025 22:53:38 +0300
Message-Id: <20250429224932.fb86bfbdca40.Ibe40bf54003e3f8929b671324a395e76eb64a4d8@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250429195344.254957-1-miriam.rachel.korenblit@intel.com>
References: <20250429195344.254957-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

For the upcoming SC hardware, a new reset mode "(silent) TOP
reset" will be available. When BT initiates that reset, it'll
negotiate with the WiFi firmware which makes it appear to the
driver as the reset interrupt. To distinguish it from all the
other reasons for the reset interrupt, there's (now) a status
field in CSR 0x110.

Implement the part of TOP reset where we react to BT doing it.
This requires disambiguating the interrupt, depending on the
state of the device, since we can even get TOP reset from BT
while waiting for the reset handshake.

If TOP reset is done by BT while we're not trying to do reset
anyway, then simply reprobe, since we cannot keep the state
of the device as it's being reset, after waiting the needed
180ms to let the device reset/settle.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-csr.h  |  7 +++
 .../net/wireless/intel/iwlwifi/iwl-op-mode.h  |  7 ++-
 .../net/wireless/intel/iwlwifi/iwl-trans.c    | 56 ++++++++++-------
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |  3 +
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c  | 60 ++++++++++++++++---
 5 files changed, 103 insertions(+), 30 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-csr.h b/drivers/net/wireless/intel/iwlwifi/iwl-csr.h
index f259747e21b3..54765f585b9a 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-csr.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-csr.h
@@ -107,6 +107,13 @@
 /* GIO Chicken Bits (PCI Express bus link power management) */
 #define CSR_GIO_CHICKEN_BITS    (CSR_BASE+0x100)
 
+#define CSR_IPC_STATE		(CSR_BASE + 0x110)
+#define CSR_IPC_STATE_RESET	0x00000030
+#define CSR_IPC_STATE_RESET_NONE		0
+#define CSR_IPC_STATE_RESET_SW_READY		1
+#define CSR_IPC_STATE_RESET_TOP_READY		2
+#define CSR_IPC_STATE_RESET_TOP_FOLLOWER	3
+
 #define CSR_IPC_SLEEP_CONTROL	(CSR_BASE + 0x114)
 #define CSR_IPC_SLEEP_CONTROL_SUSPEND	0x3
 #define CSR_IPC_SLEEP_CONTROL_RESUME	0
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-op-mode.h b/drivers/net/wireless/intel/iwlwifi/iwl-op-mode.h
index 34eca1a568ea..6bccb30c0981 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-op-mode.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-op-mode.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2005-2014, 2018-2021, 2024 Intel Corporation
+ * Copyright (C) 2005-2014, 2018-2021, 2024-2025 Intel Corporation
  * Copyright (C) 2013-2014 Intel Mobile Communications GmbH
  * Copyright (C) 2015 Intel Deutschland GmbH
  */
@@ -52,12 +52,14 @@ struct iwl_cfg;
  *	any debug collection must happen synchronously as
  *	the device will be shut down
  * @IWL_ERR_TYPE_CMD_QUEUE_FULL: command queue was full
+ * @IWL_ERR_TYPE_TOP_RESET_BY_BT: TOP reset initiated by BT
  */
 enum iwl_fw_error_type {
 	IWL_ERR_TYPE_IRQ,
 	IWL_ERR_TYPE_NMI_FORCED,
 	IWL_ERR_TYPE_RESET_HS_TIMEOUT,
 	IWL_ERR_TYPE_CMD_QUEUE_FULL,
+	IWL_ERR_TYPE_TOP_RESET_BY_BT,
 };
 
 /**
@@ -242,6 +244,9 @@ static inline void iwl_op_mode_dump_error(struct iwl_op_mode *op_mode,
 {
 	might_sleep();
 
+	if (WARN_ON(mode->type == IWL_ERR_TYPE_TOP_RESET_BY_BT))
+		return;
+
 	if (op_mode->ops->dump_error)
 		op_mode->ops->dump_error(op_mode, mode);
 }
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.c b/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
index 9ce94af0920e..22f91e2afebf 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
@@ -82,14 +82,14 @@ void iwl_trans_free_restart_list(void)
 
 struct iwl_trans_reprobe {
 	struct device *dev;
-	struct work_struct work;
+	struct delayed_work work;
 };
 
 static void iwl_trans_reprobe_wk(struct work_struct *wk)
 {
 	struct iwl_trans_reprobe *reprobe;
 
-	reprobe = container_of(wk, typeof(*reprobe), work);
+	reprobe = container_of(wk, typeof(*reprobe), work.work);
 
 	if (device_reprobe(reprobe->dev))
 		dev_err(reprobe->dev, "reprobe failed!\n");
@@ -98,6 +98,31 @@ static void iwl_trans_reprobe_wk(struct work_struct *wk)
 	module_put(THIS_MODULE);
 }
 
+static void iwl_trans_schedule_reprobe(struct iwl_trans *trans,
+				       unsigned int delay_ms)
+{
+	struct iwl_trans_reprobe *reprobe;
+
+	/*
+	 * get a module reference to avoid doing this while unloading
+	 * anyway and to avoid scheduling a work with code that's
+	 * being removed.
+	 */
+	if (!try_module_get(THIS_MODULE)) {
+		IWL_ERR(trans, "Module is being unloaded - abort\n");
+		return;
+	}
+
+	reprobe = kzalloc(sizeof(*reprobe), GFP_KERNEL);
+	if (!reprobe) {
+		module_put(THIS_MODULE);
+		return;
+	}
+	reprobe->dev = get_device(trans->dev);
+	INIT_DELAYED_WORK(&reprobe->work, iwl_trans_reprobe_wk);
+	schedule_delayed_work(&reprobe->work, msecs_to_jiffies(delay_ms));
+}
+
 #define IWL_TRANS_RESET_OK_TIME	7 /* seconds */
 
 static enum iwl_reset_mode
@@ -144,15 +169,21 @@ iwl_trans_determine_restart_mode(struct iwl_trans *trans)
 	return max(at_least, escalation_list[index]);
 }
 
+#define IWL_TRANS_TOP_FOLLOWER_WAIT	180 /* ms */
+
 #define IWL_TRANS_RESET_DELAY	(HZ * 60)
 
 static void iwl_trans_restart_wk(struct work_struct *wk)
 {
 	struct iwl_trans *trans = container_of(wk, typeof(*trans),
 					       restart.wk.work);
-	struct iwl_trans_reprobe *reprobe;
 	enum iwl_reset_mode mode;
 
+	if (trans->restart.mode.type == IWL_ERR_TYPE_TOP_RESET_BY_BT) {
+		iwl_trans_schedule_reprobe(trans, IWL_TRANS_TOP_FOLLOWER_WAIT);
+		return;
+	}
+
 	if (!trans->op_mode)
 		return;
 
@@ -194,24 +225,7 @@ static void iwl_trans_restart_wk(struct work_struct *wk)
 	case IWL_RESET_MODE_REPROBE:
 		IWL_ERR(trans, "Device error - reprobe!\n");
 
-		/*
-		 * get a module reference to avoid doing this while unloading
-		 * anyway and to avoid scheduling a work with code that's
-		 * being removed.
-		 */
-		if (!try_module_get(THIS_MODULE)) {
-			IWL_ERR(trans, "Module is being unloaded - abort\n");
-			return;
-		}
-
-		reprobe = kzalloc(sizeof(*reprobe), GFP_KERNEL);
-		if (!reprobe) {
-			module_put(THIS_MODULE);
-			return;
-		}
-		reprobe->dev = get_device(trans->dev);
-		INIT_WORK(&reprobe->work, iwl_trans_reprobe_wk);
-		schedule_work(&reprobe->work);
+		iwl_trans_schedule_reprobe(trans, 0);
 		break;
 	default:
 		iwl_trans_pcie_reset(trans, mode);
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index 844f0c427de3..0a4f69258715 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -1195,6 +1195,9 @@ static inline void iwl_trans_opmode_sw_reset(struct iwl_trans *trans,
 
 	set_bit(STATUS_IN_SW_RESET, &trans->status);
 
+	if (WARN_ON(type == IWL_ERR_TYPE_TOP_RESET_BY_BT))
+		return;
+
 	if (!trans->op_mode->ops->sw_reset ||
 	    !trans->op_mode->ops->sw_reset(trans->op_mode, type))
 		clear_bit(STATUS_IN_SW_RESET, &trans->status);
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
index 337324eea1a1..bbeecb621593 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
@@ -13,6 +13,7 @@
 #include "internal.h"
 #include "iwl-op-mode.h"
 #include "iwl-context-info-gen3.h"
+#include "fw/dbg.h"
 
 /******************************************************************************
  *
@@ -1828,6 +1829,54 @@ void iwl_pcie_handle_rfkill_irq(struct iwl_trans *trans, bool from_irq)
 	}
 }
 
+static void iwl_trans_pcie_handle_reset_interrupt(struct iwl_trans *trans)
+{
+	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
+	u32 state;
+
+	if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_SC) {
+		u32 val = iwl_read32(trans, CSR_IPC_STATE);
+
+		state = u32_get_bits(val, CSR_IPC_STATE_RESET);
+		IWL_DEBUG_ISR(trans, "IPC state = 0x%x/%d\n", val, state);
+	} else {
+		state = CSR_IPC_STATE_RESET_SW_READY;
+	}
+
+	switch (state) {
+	case CSR_IPC_STATE_RESET_SW_READY:
+		if (trans_pcie->fw_reset_state == FW_RESET_REQUESTED) {
+			IWL_DEBUG_ISR(trans, "Reset flow completed\n");
+			trans_pcie->fw_reset_state = FW_RESET_OK;
+			wake_up(&trans_pcie->fw_reset_waitq);
+			break;
+		}
+		fallthrough;
+	case CSR_IPC_STATE_RESET_TOP_READY:
+		/* FIXME: handle this case when requesting TOP reset */
+		fallthrough;
+	case CSR_IPC_STATE_RESET_NONE:
+		IWL_FW_CHECK_FAILED(trans,
+				    "Invalid reset interrupt (state=%d)!\n",
+				    state);
+		break;
+	case CSR_IPC_STATE_RESET_TOP_FOLLOWER:
+		if (trans_pcie->fw_reset_state == FW_RESET_REQUESTED) {
+			/* if we were in reset, wake that up */
+			IWL_INFO(trans,
+				 "TOP reset from BT while doing reset\n");
+			trans_pcie->fw_reset_state = FW_RESET_OK;
+			wake_up(&trans_pcie->fw_reset_waitq);
+		} else {
+			IWL_INFO(trans, "TOP reset from BT\n");
+			trans->state = IWL_TRANS_NO_FW;
+			iwl_trans_schedule_reset(trans,
+						 IWL_ERR_TYPE_TOP_RESET_BY_BT);
+		}
+		break;
+	}
+}
+
 irqreturn_t iwl_pcie_irq_handler(int irq, void *dev_id)
 {
 	struct iwl_trans *trans = dev_id;
@@ -1948,10 +1997,8 @@ irqreturn_t iwl_pcie_irq_handler(int irq, void *dev_id)
 	}
 
 	if (inta & CSR_INT_BIT_RESET_DONE) {
-		IWL_DEBUG_ISR(trans, "Reset flow completed\n");
-		trans_pcie->fw_reset_state = FW_RESET_OK;
+		iwl_trans_pcie_handle_reset_interrupt(trans);
 		handled |= CSR_INT_BIT_RESET_DONE;
-		wake_up(&trans_pcie->fw_reset_waitq);
 	}
 
 	/* Safely ignore these bits for debug checks below */
@@ -2400,11 +2447,8 @@ irqreturn_t iwl_pcie_irq_msix_handler(int irq, void *dev_id)
 		iwl_pcie_irq_handle_error(trans);
 	}
 
-	if (inta_hw & MSIX_HW_INT_CAUSES_REG_RESET_DONE) {
-		IWL_DEBUG_ISR(trans, "Reset flow completed\n");
-		trans_pcie->fw_reset_state = FW_RESET_OK;
-		wake_up(&trans_pcie->fw_reset_waitq);
-	}
+	if (inta_hw & MSIX_HW_INT_CAUSES_REG_RESET_DONE)
+		iwl_trans_pcie_handle_reset_interrupt(trans);
 
 	if (!polling)
 		iwl_pcie_clear_irq(trans, entry->entry);
-- 
2.34.1


