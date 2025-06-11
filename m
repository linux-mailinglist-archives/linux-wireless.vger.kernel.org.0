Return-Path: <linux-wireless+bounces-24001-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44F55AD5F05
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Jun 2025 21:27:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C33DA3A8B26
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Jun 2025 19:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D6322BD582;
	Wed, 11 Jun 2025 19:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kl++rNHf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0881224AE1
	for <linux-wireless@vger.kernel.org>; Wed, 11 Jun 2025 19:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749670014; cv=none; b=dCpvgMhG5Xmyk8VTXfWfPgyLGlKXk1FAfR1VqoPUUC9Qe4D8HQx4OcHhxoGugXjlhaF/zGZhh5e9JCAhr0WWR/I0PNrizi4qjv1nBOUaVEjAhFrWRteCyXpiK3ocFkPJfnzdpI/SufahllH5ob3XzbrOMxy4HF6hLpzB2EBaB14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749670014; c=relaxed/simple;
	bh=HsQBg1nzElWiynWCI10HdhPPBjwL+hw6U55LvSbNTNs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cDk3rsQOS4DJ14TUPv80fbvizbw6R85IwT4x+waOLEcRBqLIShxIeJMphNEbC4W9kqTNNldxkIDtDP7hMyLFrYKviw6ksb8lUsl3TyfJtRpasHLW1WWssTpDrw5Inwi3e310cfin1/Xzb4pI/ccVvzE9rclmr4L+NJifOt1o/Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Kl++rNHf; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749670013; x=1781206013;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HsQBg1nzElWiynWCI10HdhPPBjwL+hw6U55LvSbNTNs=;
  b=Kl++rNHf3XhLaLDym5UTyekEfCYmYponZ/cmlb9FGMBWBF2rRqTeXNiy
   NhHAWVOWB73wXhbLeRwnHG4s7pFLtNaFou0X6crv8UUFKgp2xdmpobo9m
   D0n5Eym822J/r1l6VcIKwbiqfyTCNubzf89DX2zd7SxDNiChMOIkJMcqU
   /tcBoHUj/GLyGk4oNdtpzTmRgBelMti1hEFzAxF7X7eMxEBhj+X8QhsqF
   HZXen0zEfPwNIi5lmZ/ZreaR4X7dj9VNnAP7yaR2ATlHfFy58s8G9S837
   vAwBmLS078ASB8bD6s+wdOHwL4bkNpTOmvxy0Ie44uFCZHZnyqM0zkmdv
   w==;
X-CSE-ConnectionGUID: YflXqrwkReuf1bmpWorIuQ==
X-CSE-MsgGUID: vEBgstNSSU6IiXnhY1mAag==
X-IronPort-AV: E=McAfee;i="6800,10657,11461"; a="74360856"
X-IronPort-AV: E=Sophos;i="6.16,228,1744095600"; 
   d="scan'208";a="74360856"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 12:26:52 -0700
X-CSE-ConnectionGUID: vxAJNp3vRX6gpLIlvVrd8g==
X-CSE-MsgGUID: VWkocDZdSwGZpDXuhJ1Miw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,228,1744095600"; 
   d="scan'208";a="147165825"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 12:26:51 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next v2 01/15] wifi: iwlwifi: pcie: abort D3 handshake on error
Date: Wed, 11 Jun 2025 22:26:20 +0300
Message-Id: <20250611222325.157dca92c573.I6dd3b9d2f435c2c363224aa84e373931e56a545f@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250611192634.2416885-1-miriam.rachel.korenblit@intel.com>
References: <20250611192634.2416885-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

The D3 handshake can be interrupted by an error, especially
on resume where we no longer want to check explicitly for
errors. Expand the sx_complete to sx_state and handle any
errors occurring during the handshake.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../intel/iwlwifi/pcie/gen1_2/internal.h      |  9 ++++--
 .../wireless/intel/iwlwifi/pcie/gen1_2/rx.c   | 16 ++++++++--
 .../intel/iwlwifi/pcie/gen1_2/trans.c         | 31 +++++++++++++------
 3 files changed, 42 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/internal.h b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/internal.h
index 796410f2fa48..ebcc174f6c62 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/internal.h
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/internal.h
@@ -382,7 +382,7 @@ struct iwl_pcie_txqs {
  * @irq_lock: lock to synchronize IRQ handling
  * @txq_memory: TXQ allocation array
  * @sx_waitq: waitqueue for Sx transitions
- * @sx_complete: completion for Sx transitions
+ * @sx_state: state tracking Sx transitions
  * @pcie_dbg_dumped_once: indicates PCIe regs were dumped already
  * @opmode_down: indicates opmode went away
  * @num_rx_bufs: number of RX buffers to allocate/use
@@ -448,7 +448,12 @@ struct iwl_trans_pcie {
 	u8 __iomem *hw_base;
 
 	bool ucode_write_complete;
-	bool sx_complete;
+	enum {
+		IWL_SX_INVALID = 0,
+		IWL_SX_WAITING,
+		IWL_SX_ERROR,
+		IWL_SX_COMPLETE,
+	} sx_state;
 	wait_queue_head_t ucode_write_waitq;
 	wait_queue_head_t sx_waitq;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/rx.c b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/rx.c
index 0c73b1fe3645..619a9505e6d9 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/rx.c
@@ -2394,6 +2394,11 @@ irqreturn_t iwl_pcie_irq_msix_handler(int irq, void *dev_id)
 		} else {
 			iwl_pcie_irq_handle_error(trans);
 		}
+
+		if (trans_pcie->sx_state == IWL_SX_WAITING) {
+			trans_pcie->sx_state = IWL_SX_ERROR;
+			wake_up(&trans_pcie->sx_waitq);
+		}
 	}
 
 	/* After checking FH register check HW register */
@@ -2428,13 +2433,20 @@ irqreturn_t iwl_pcie_irq_msix_handler(int irq, void *dev_id)
 	if (inta_hw & MSIX_HW_INT_CAUSES_REG_WAKEUP && trans_pcie->prph_info) {
 		u32 sleep_notif =
 			le32_to_cpu(trans_pcie->prph_info->sleep_notif);
+
 		if (sleep_notif == IWL_D3_SLEEP_STATUS_SUSPEND ||
 		    sleep_notif == IWL_D3_SLEEP_STATUS_RESUME) {
 			IWL_DEBUG_ISR(trans,
 				      "Sx interrupt: sleep notification = 0x%x\n",
 				      sleep_notif);
-			trans_pcie->sx_complete = true;
-			wake_up(&trans_pcie->sx_waitq);
+			if (trans_pcie->sx_state == IWL_SX_WAITING) {
+				trans_pcie->sx_state = IWL_SX_COMPLETE;
+				wake_up(&trans_pcie->sx_waitq);
+			} else {
+				IWL_ERR(trans,
+					"unexpected Sx interrupt (0x%x)\n",
+					sleep_notif);
+			}
 		} else {
 			/* uCode wakes up after power-down sleep */
 			IWL_DEBUG_ISR(trans, "Wakeup interrupt\n");
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
index bace11a949c8..6054ebebd8c8 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
@@ -1536,30 +1536,41 @@ static int iwl_pcie_d3_handshake(struct iwl_trans *trans, bool suspend)
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 	int ret;
 
+	if (trans->mac_cfg->device_family < IWL_DEVICE_FAMILY_AX210)
+		return 0;
+
+	trans_pcie->sx_state = IWL_SX_WAITING;
+
 	if (trans->mac_cfg->device_family == IWL_DEVICE_FAMILY_AX210)
 		iwl_write_umac_prph(trans, UREG_DOORBELL_TO_ISR6,
 				    suspend ? UREG_DOORBELL_TO_ISR6_SUSPEND :
 					      UREG_DOORBELL_TO_ISR6_RESUME);
-	else if (trans->mac_cfg->device_family >= IWL_DEVICE_FAMILY_BZ)
+	else
 		iwl_write32(trans, CSR_IPC_SLEEP_CONTROL,
 			    suspend ? CSR_IPC_SLEEP_CONTROL_SUSPEND :
 				      CSR_IPC_SLEEP_CONTROL_RESUME);
-	else
-		return 0;
 
 	ret = wait_event_timeout(trans_pcie->sx_waitq,
-				 trans_pcie->sx_complete, 2 * HZ);
-
-	/* Invalidate it toward next suspend or resume */
-	trans_pcie->sx_complete = false;
-
+				 trans_pcie->sx_state != IWL_SX_WAITING,
+				 2 * HZ);
 	if (!ret) {
 		IWL_ERR(trans, "Timeout %s D3\n",
 			suspend ? "entering" : "exiting");
-		return -ETIMEDOUT;
+		ret = -ETIMEDOUT;
+	} else {
+		ret = 0;
 	}
 
-	return 0;
+	if (trans_pcie->sx_state == IWL_SX_ERROR) {
+		IWL_ERR(trans, "FW error while %s D3\n",
+			suspend ? "entering" : "exiting");
+		ret = -EIO;
+	}
+
+	/* Invalidate it toward next suspend or resume */
+	trans_pcie->sx_state = IWL_SX_INVALID;
+
+	return ret;
 }
 
 int iwl_trans_pcie_d3_suspend(struct iwl_trans *trans, bool test, bool reset)
-- 
2.34.1


