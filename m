Return-Path: <linux-wireless+bounces-10742-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D3E6942DC7
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jul 2024 14:08:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CF611F25961
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jul 2024 12:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F28EB1AE84C;
	Wed, 31 Jul 2024 12:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RoQGfLOY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E3C1AD416
	for <linux-wireless@vger.kernel.org>; Wed, 31 Jul 2024 12:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722427692; cv=none; b=oUYeQ6v5WDgWciWyJ593aOtLcKPhaDYvsLWILS5ruParWDsmCKR4lZG8NdErs4V/gXBJqVLUCbECCh+NXCkSuTC6FTKBoJQfoWHGhrTBrb0FXqWu7oyoXog9sIufXV+NBL8j9HQOAa0GZKej02tiBbWFAFM3ARZylv/fm/yeuCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722427692; c=relaxed/simple;
	bh=QSC49CXsrk4wHXJccx9G7IPjpab7nWwQhY7gDt5lKmI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BrmyiXDeykBHxZ08Cvafe70g4LK6URv8+0yDoPZ6AmjwQtxEmZounIEC13FWCk5x0MS3BHY07OM04t47H3IHknN0Xv5FOjeSOfMbEOxuaeJqVz67ASImaQzM35+FXtPkmdZ4n0AURVLM3Le21Q8j3AL/IPTrsyLb1eBTn0qk3rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RoQGfLOY; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722427691; x=1753963691;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=QSC49CXsrk4wHXJccx9G7IPjpab7nWwQhY7gDt5lKmI=;
  b=RoQGfLOYhyathASgX72MBV30NALrAQAWUJjaqlRn/4JkcT5MzOmNhfP/
   ULntD8OyCvVb4l6Pyn8r8JAT7CbLh+pkXTbVOxdEC0Iw3uoB2kEwEOm9C
   WhrCiGHPoDRuW9XGIaAv0SYRF8SbXL2pUJnI+y+ZavMg+UNT9tg337pKu
   0sCqX1qvUSflSoagPx7rlaAzYH+5GZXbyO1PDQogZXH6FGXHgau7o1wKI
   y8FjPfqmyA/9+Q2n1kFEKaCKJR1SgyzCyo1Hdxvo963s8KS50ZnpBE22C
   eZZ6BuRh3CVjR9pPsEBtn/xjzDAIxfqUwFDSGUnE8GDoydc+WPwAgxgoT
   Q==;
X-CSE-ConnectionGUID: LWiIoGLOQ9aEJbL5bhxtnw==
X-CSE-MsgGUID: Y25EE5anSXWGKjSpyqsN4w==
X-IronPort-AV: E=McAfee;i="6700,10204,11149"; a="20184185"
X-IronPort-AV: E=Sophos;i="6.09,251,1716274800"; 
   d="scan'208";a="20184185"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2024 05:08:10 -0700
X-CSE-ConnectionGUID: pmnBzVohQS2OzVFqi9awzA==
X-CSE-MsgGUID: yKQ/Ad9ITcCdxcfKu11RoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,251,1716274800"; 
   d="scan'208";a="85301078"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2024 05:08:09 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH v2] wifi: iwlwifi: mvm: fix hibernation
Date: Wed, 31 Jul 2024 15:07:59 +0300
Message-Id: <20240731150730.3052e3cb78e5.I3837810318dbef0a0a773cf4c4fcf89cdc6fdbd3@changeid>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

Fast resume is a feature that was recently introduced to speed up the
resume time. It basically keeps the firmware alive while the system
is suspended and that avoids starting again the whole device.

This flow can't work for hibernation, since when the system boots,
before the frozen image is loaded, the kernel may touch the device. As a
result, we can't assume the device is in the exact same state as before
the hibernation.

Detect that we are resuming from hibernation through the PCI device and
forbid the fast resume flow. We also need to shut down the device
cleanly when that happens.

In addition, in case the device is power gated during S3, we won't be
able to keep the device alive. Detect this situation with BE200 at least
with the help of the CSR_FUNC_SCRATCH register and reset the device upon
resume if it was power gated during S3.

Fixes: e8bb19c1d590 ("wifi: iwlwifi: support fast resume")
Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
v2: fixed !CONFIG_PM build

 .../net/wireless/intel/iwlwifi/iwl-op-mode.h  | 12 ++++++
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c   | 10 +++++
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  | 17 +++++++-
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 41 +++++++++++++++++--
 4 files changed, 76 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-op-mode.h b/drivers/net/wireless/intel/iwlwifi/iwl-op-mode.h
index 595fa6ddf084..8ef5ed2db051 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-op-mode.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-op-mode.h
@@ -85,6 +85,10 @@ struct iwl_cfg;
  *	May sleep
  * @wimax_active: invoked when WiMax becomes active. May sleep
  * @time_point: called when transport layer wants to collect debug data
+ * @device_powered_off: called upon resume from hibernation but not only.
+ *	Op_mode needs to reset its internal state because the device did not
+ *	survive the system state transition. The firmware is no longer running,
+ *	etc...
  */
 struct iwl_op_mode_ops {
 	struct iwl_op_mode *(*start)(struct iwl_trans *trans,
@@ -107,6 +111,7 @@ struct iwl_op_mode_ops {
 	void (*time_point)(struct iwl_op_mode *op_mode,
 			   enum iwl_fw_ini_time_point tp_id,
 			   union iwl_dbg_tlv_tp_data *tp_data);
+	void (*device_powered_off)(struct iwl_op_mode *op_mode);
 };
 
 int iwl_opmode_register(const char *name, const struct iwl_op_mode_ops *ops);
@@ -204,4 +209,11 @@ static inline void iwl_op_mode_time_point(struct iwl_op_mode *op_mode,
 	op_mode->ops->time_point(op_mode, tp_id, tp_data);
 }
 
+static inline void iwl_op_mode_device_powered_off(struct iwl_op_mode *op_mode)
+{
+	if (!op_mode || !op_mode->ops || !op_mode->ops->device_powered_off)
+		return;
+	op_mode->ops->device_powered_off(op_mode);
+}
+
 #endif /* __iwl_op_mode_h__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index b4d650583ac2..99a541d442bb 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -3439,6 +3439,16 @@ static int __iwl_mvm_resume(struct iwl_mvm *mvm, bool test)
 
 	mutex_lock(&mvm->mutex);
 
+	/* Apparently, the device went away and device_powered_off() was called,
+	 * don't even try to read the rt_status, the device is currently
+	 * inaccessible.
+	 */
+	if (!test_bit(IWL_MVM_STATUS_IN_D3, &mvm->status)) {
+		IWL_INFO(mvm,
+			 "Can't resume, device_powered_off() was called during wowlan\n");
+		goto err;
+	}
+
 	mvm->last_reset_or_resume_time_jiffies = jiffies;
 
 	/* get the BSS vif pointer again */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index b7dcae76a05d..75fc60a4808c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -2090,6 +2090,20 @@ static void iwl_op_mode_mvm_time_point(struct iwl_op_mode *op_mode,
 	iwl_dbg_tlv_time_point(&mvm->fwrt, tp_id, tp_data);
 }
 
+static void iwl_op_mode_mvm_device_powered_off(struct iwl_op_mode *op_mode)
+{
+	struct iwl_mvm *mvm = IWL_OP_MODE_GET_MVM(op_mode);
+
+	mutex_lock(&mvm->mutex);
+	clear_bit(IWL_MVM_STATUS_IN_D3, &mvm->status);
+	mvm->trans->system_pm_mode = IWL_PLAT_PM_MODE_DISABLED;
+	iwl_mvm_stop_device(mvm);
+#ifdef CONFIG_PM
+	mvm->fast_resume = false;
+#endif
+	mutex_unlock(&mvm->mutex);
+}
+
 #define IWL_MVM_COMMON_OPS					\
 	/* these could be differentiated */			\
 	.queue_full = iwl_mvm_stop_sw_queue,			\
@@ -2102,7 +2116,8 @@ static void iwl_op_mode_mvm_time_point(struct iwl_op_mode *op_mode,
 	/* as we only register one, these MUST be common! */	\
 	.start = iwl_op_mode_mvm_start,				\
 	.stop = iwl_op_mode_mvm_stop,				\
-	.time_point = iwl_op_mode_mvm_time_point
+	.time_point = iwl_op_mode_mvm_time_point,		\
+	.device_powered_off = iwl_op_mode_mvm_device_powered_off
 
 static const struct iwl_op_mode_ops iwl_mvm_ops = {
 	IWL_MVM_COMMON_OPS,
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 9ad43464b702..84fd93278450 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -1577,11 +1577,12 @@ static int iwl_pci_suspend(struct device *device)
 	return 0;
 }
 
-static int iwl_pci_resume(struct device *device)
+static int _iwl_pci_resume(struct device *device, bool restore)
 {
 	struct pci_dev *pdev = to_pci_dev(device);
 	struct iwl_trans *trans = pci_get_drvdata(pdev);
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
+	bool device_was_powered_off = false;
 
 	/* Before you put code here, think about WoWLAN. You cannot check here
 	 * whether WoWLAN is enabled or not, and your code will run even if
@@ -1597,6 +1598,26 @@ static int iwl_pci_resume(struct device *device)
 	if (!trans->op_mode)
 		return 0;
 
+	/*
+	 * Scratch value was altered, this means the device was powered off, we
+	 * need to reset it completely.
+	 * Note: MAC (bits 0:7) will be cleared upon suspend even with wowlan,
+	 * so assume that any bits there mean that the device is usable.
+	 */
+	if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_BZ &&
+	    !iwl_read32(trans, CSR_FUNC_SCRATCH))
+		device_was_powered_off = true;
+
+	if (restore || device_was_powered_off) {
+		trans->state = IWL_TRANS_NO_FW;
+		/* Hope for the best here ... If one of those steps fails we
+		 * won't really know how to recover.
+		 */
+		iwl_pcie_prepare_card_hw(trans);
+		iwl_finish_nic_init(trans);
+		iwl_op_mode_device_powered_off(trans->op_mode);
+	}
+
 	/* In WOWLAN, let iwl_trans_pcie_d3_resume do the rest of the work */
 	if (test_bit(STATUS_DEVICE_ENABLED, &trans->status))
 		return 0;
@@ -1617,9 +1638,23 @@ static int iwl_pci_resume(struct device *device)
 	return 0;
 }
 
+static int iwl_pci_restore(struct device *device)
+{
+	return _iwl_pci_resume(device, true);
+}
+
+static int iwl_pci_resume(struct device *device)
+{
+	return _iwl_pci_resume(device, false);
+}
+
 static const struct dev_pm_ops iwl_dev_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(iwl_pci_suspend,
-				iwl_pci_resume)
+	.suspend = pm_sleep_ptr(iwl_pci_suspend),
+	.resume = pm_sleep_ptr(iwl_pci_resume),
+	.freeze = pm_sleep_ptr(iwl_pci_suspend),
+	.thaw = pm_sleep_ptr(iwl_pci_resume),
+	.poweroff = pm_sleep_ptr(iwl_pci_suspend),
+	.restore = pm_sleep_ptr(iwl_pci_restore),
 };
 
 #define IWL_PM_OPS	(&iwl_dev_pm_ops)
-- 
2.34.1


