Return-Path: <linux-wireless+bounces-23958-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06C7FAD4966
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Jun 2025 05:34:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1822189BE7F
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Jun 2025 03:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 258064C80;
	Wed, 11 Jun 2025 03:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iof5XI3A"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C57518D65E
	for <linux-wireless@vger.kernel.org>; Wed, 11 Jun 2025 03:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749612876; cv=none; b=Bnk25ONrApFjD0w+FTfp4QAOTUGEWn8skwlkjWyyAmL8VvHKeoClNbYzFMbTQydWqHu6okhvtbL/D+0OALZ+TvrmYpny2ET4s+ycQj9DJmhyVl6KTVlFWv1TAxbUEMo3rKyYo1YYrIMUR6Z4mzlmofyfAEYyXOtBneoSLlz6vJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749612876; c=relaxed/simple;
	bh=HsQBg1nzElWiynWCI10HdhPPBjwL+hw6U55LvSbNTNs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oZBXTCzaxoC7KMptSRRBSHp2JTNvI1fpl0vk371HIiaeq3Pf81B9PPSYluGLeWktMqS7mKHqjumwlJvLt3ue/A+xkhTIqqwi9sjZShOlvzVn0RIa2C7W7u2ungNKqtJrFOKOCbMOei4EMqGd6kTdYzBGRTKOACw8ITLZLUGMfns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iof5XI3A; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749612874; x=1781148874;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HsQBg1nzElWiynWCI10HdhPPBjwL+hw6U55LvSbNTNs=;
  b=iof5XI3AFvRPgy+oz0rX6o3f46xCqPaxC2AAgHXJyIKnnS6QmBOzEu7S
   2G8+1CFYDW1uaB5ToselZkFSrDa/v67WOS8ssFGcr3XRLWhJ49EbJzPhs
   OcCErD1Trx6Mg9jX9Lz57NNzsIiu4CQGMJms32y23j8Lij2uTn5ipXvgM
   L/20L5h58+AyUi+QCFwbUHB9ivBbumGjD0F1NBYK3lsH1qwD5zoG/XE56
   xi2+Sxaje8PGVSULyT49WMQL9ys/0KcDBwBgyl48w3yAnqM/eKJh9i5hH
   ygn0bhEKe5CcD303DeIbtF+Opzf6AaZsrEh626z0YtpgC0HB6FXwcfEFV
   w==;
X-CSE-ConnectionGUID: 29v9LflTScyu7mO3e0Dg+w==
X-CSE-MsgGUID: JihcOMjGRPSH7xxiMXGimw==
X-IronPort-AV: E=McAfee;i="6800,10657,11460"; a="63094878"
X-IronPort-AV: E=Sophos;i="6.16,226,1744095600"; 
   d="scan'208";a="63094878"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 20:34:33 -0700
X-CSE-ConnectionGUID: 79svyQmNTWqCt+2MSdNmog==
X-CSE-MsgGUID: Mc7u16CbQGiX4amFEcRuKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,226,1744095600"; 
   d="scan'208";a="150880905"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 20:34:32 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 01/15] wifi: iwlwifi: pcie: abort D3 handshake on error
Date: Wed, 11 Jun 2025 06:34:01 +0300
Message-Id: <20250611063124.157dca92c573.I6dd3b9d2f435c2c363224aa84e373931e56a545f@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250611033415.1175681-1-miriam.rachel.korenblit@intel.com>
References: <20250611033415.1175681-1-miriam.rachel.korenblit@intel.com>
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


