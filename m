Return-Path: <linux-wireless+bounces-827-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 130EC8145CC
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Dec 2023 11:40:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D423BB22B18
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Dec 2023 10:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAF9F19BBB;
	Fri, 15 Dec 2023 10:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="wPyrU8eT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6465D1A5B6
	for <linux-wireless@vger.kernel.org>; Fri, 15 Dec 2023 10:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=aE/ap2hBvraxaPl4EVAx76kckRsT9Rkvza1mXinkCjg=; t=1702636816; x=1703846416; 
	b=wPyrU8eTWNHn6pco7PlT1OBSEaze7PXN4n19XdYbHYqO4Xw03//qOFqBADs0iB/yiIJ3m5wPv0k
	vVnumAPJehDDjHwiBtaQiLPqjpa7L/IqrhQV9ddUt7YWA15dH6+uWHC2JUVOy4nyUhj0sk8x3Texw
	GSjLfxegTz0JggaO/68zD2HJNRu4JfcWfXJ5LPe/z4GBvruYKlk5lGK3S/tKPlCDW0CW+YuqI+295
	zce7fhsfxtSa9BlYy2VeOKLM/mS1LTp4qGZtbawCbthyHiYJDIAnPJ4IamMw/FqBHjOKxxjy4KJF+
	EGk5YAqQoLmltSSjTzvlhNJrJPwhjziqY1Sw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rE5CQ-0000000C5h5-2S8b;
	Fri, 15 Dec 2023 11:13:42 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH] wifi: iwlwifi: pcie: don't synchronize IRQs from IRQ
Date: Fri, 15 Dec 2023 11:13:34 +0100
Message-ID: <20231215111335.59aab00baed7.Iadfe154d6248e7f9dfd69522e5429dbbd72925d7@changeid>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

On older devices (before unified image!) we can end up calling
stop_device from an rfkill interrupt. However, in stop_device
we attempt to synchronize IRQs, which then of course deadlocks.

Avoid this by checking the context, if running from the IRQ
thread then don't synchronize. This wouldn't be correct on a
new device since RSS is supported, but older devices only have
a single interrupt/queue.

Fixes: 37fb29bd1f90 ("wifi: iwlwifi: pcie: synchronize IRQs before NAPI")
Reviewed-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 .../net/wireless/intel/iwlwifi/pcie/internal.h  |  4 ++--
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c    |  8 ++++----
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c | 17 +++++++++--------
 3 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
index 56def20374f3..7805a42948af 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
@@ -770,7 +770,7 @@ static inline void iwl_enable_rfkill_int(struct iwl_trans *trans)
 	}
 }
 
-void iwl_pcie_handle_rfkill_irq(struct iwl_trans *trans);
+void iwl_pcie_handle_rfkill_irq(struct iwl_trans *trans, bool from_irq);
 
 static inline bool iwl_is_rfkill_set(struct iwl_trans *trans)
 {
@@ -817,7 +817,7 @@ static inline bool iwl_pcie_dbg_on(struct iwl_trans *trans)
 	return (trans->dbg.dest_tlv || iwl_trans_dbg_ini_valid(trans));
 }
 
-void iwl_trans_pcie_rf_kill(struct iwl_trans *trans, bool state);
+void iwl_trans_pcie_rf_kill(struct iwl_trans *trans, bool state, bool from_irq);
 void iwl_trans_pcie_dump_regs(struct iwl_trans *trans);
 
 #ifdef CONFIG_IWLWIFI_DEBUGFS
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
index bc6a9f861711..07931c2db494 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
@@ -1783,7 +1783,7 @@ static u32 iwl_pcie_int_cause_ict(struct iwl_trans *trans)
 	return inta;
 }
 
-void iwl_pcie_handle_rfkill_irq(struct iwl_trans *trans)
+void iwl_pcie_handle_rfkill_irq(struct iwl_trans *trans, bool from_irq)
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 	struct isr_statistics *isr_stats = &trans_pcie->isr_stats;
@@ -1807,7 +1807,7 @@ void iwl_pcie_handle_rfkill_irq(struct iwl_trans *trans)
 	isr_stats->rfkill++;
 
 	if (prev != report)
-		iwl_trans_pcie_rf_kill(trans, report);
+		iwl_trans_pcie_rf_kill(trans, report, from_irq);
 	mutex_unlock(&trans_pcie->mutex);
 
 	if (hw_rfkill) {
@@ -1947,7 +1947,7 @@ irqreturn_t iwl_pcie_irq_handler(int irq, void *dev_id)
 
 	/* HW RF KILL switch toggled */
 	if (inta & CSR_INT_BIT_RF_KILL) {
-		iwl_pcie_handle_rfkill_irq(trans);
+		iwl_pcie_handle_rfkill_irq(trans, true);
 		handled |= CSR_INT_BIT_RF_KILL;
 	}
 
@@ -2370,7 +2370,7 @@ irqreturn_t iwl_pcie_irq_msix_handler(int irq, void *dev_id)
 
 	/* HW RF KILL switch toggled */
 	if (inta_hw & MSIX_HW_INT_CAUSES_REG_RF_KILL)
-		iwl_pcie_handle_rfkill_irq(trans);
+		iwl_pcie_handle_rfkill_irq(trans, true);
 
 	if (inta_hw & MSIX_HW_INT_CAUSES_REG_HW_ERR) {
 		IWL_ERR(trans,
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index 92253260f568..d10208075ae5 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -1082,7 +1082,7 @@ bool iwl_pcie_check_hw_rf_kill(struct iwl_trans *trans)
 	report = test_bit(STATUS_RFKILL_OPMODE, &trans->status);
 
 	if (prev != report)
-		iwl_trans_pcie_rf_kill(trans, report);
+		iwl_trans_pcie_rf_kill(trans, report, false);
 
 	return hw_rfkill;
 }
@@ -1237,7 +1237,7 @@ static void iwl_pcie_init_msix(struct iwl_trans_pcie *trans_pcie)
 	trans_pcie->hw_mask = trans_pcie->hw_init_mask;
 }
 
-static void _iwl_trans_pcie_stop_device(struct iwl_trans *trans)
+static void _iwl_trans_pcie_stop_device(struct iwl_trans *trans, bool from_irq)
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 
@@ -1264,7 +1264,8 @@ static void _iwl_trans_pcie_stop_device(struct iwl_trans *trans)
 	if (test_and_clear_bit(STATUS_DEVICE_ENABLED, &trans->status)) {
 		IWL_DEBUG_INFO(trans,
 			       "DEVICE_ENABLED bit was set and is now cleared\n");
-		iwl_pcie_synchronize_irqs(trans);
+		if (!from_irq)
+			iwl_pcie_synchronize_irqs(trans);
 		iwl_pcie_rx_napi_sync(trans);
 		iwl_pcie_tx_stop(trans);
 		iwl_pcie_rx_stop(trans);
@@ -1454,7 +1455,7 @@ void iwl_trans_pcie_handle_stop_rfkill(struct iwl_trans *trans,
 		clear_bit(STATUS_RFKILL_OPMODE, &trans->status);
 	}
 	if (hw_rfkill != was_in_rfkill)
-		iwl_trans_pcie_rf_kill(trans, hw_rfkill);
+		iwl_trans_pcie_rf_kill(trans, hw_rfkill, false);
 }
 
 static void iwl_trans_pcie_stop_device(struct iwl_trans *trans)
@@ -1469,12 +1470,12 @@ static void iwl_trans_pcie_stop_device(struct iwl_trans *trans)
 	mutex_lock(&trans_pcie->mutex);
 	trans_pcie->opmode_down = true;
 	was_in_rfkill = test_bit(STATUS_RFKILL_OPMODE, &trans->status);
-	_iwl_trans_pcie_stop_device(trans);
+	_iwl_trans_pcie_stop_device(trans, false);
 	iwl_trans_pcie_handle_stop_rfkill(trans, was_in_rfkill);
 	mutex_unlock(&trans_pcie->mutex);
 }
 
-void iwl_trans_pcie_rf_kill(struct iwl_trans *trans, bool state)
+void iwl_trans_pcie_rf_kill(struct iwl_trans *trans, bool state, bool from_irq)
 {
 	struct iwl_trans_pcie __maybe_unused *trans_pcie =
 		IWL_TRANS_GET_PCIE_TRANS(trans);
@@ -1487,7 +1488,7 @@ void iwl_trans_pcie_rf_kill(struct iwl_trans *trans, bool state)
 		if (trans->trans_cfg->gen2)
 			_iwl_trans_pcie_gen2_stop_device(trans);
 		else
-			_iwl_trans_pcie_stop_device(trans);
+			_iwl_trans_pcie_stop_device(trans, from_irq);
 	}
 }
 
@@ -2887,7 +2888,7 @@ static ssize_t iwl_dbgfs_rfkill_write(struct file *file,
 	IWL_WARN(trans, "changing debug rfkill %d->%d\n",
 		 trans_pcie->debug_rfkill, new_value);
 	trans_pcie->debug_rfkill = new_value;
-	iwl_pcie_handle_rfkill_irq(trans);
+	iwl_pcie_handle_rfkill_irq(trans, false);
 
 	return count;
 }
-- 
2.43.0


