Return-Path: <linux-wireless+bounces-11907-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A831695E443
	for <lists+linux-wireless@lfdr.de>; Sun, 25 Aug 2024 18:17:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDB801C209E3
	for <lists+linux-wireless@lfdr.de>; Sun, 25 Aug 2024 16:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4191A3D62;
	Sun, 25 Aug 2024 16:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ru9qNvPG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A281DE56E
	for <linux-wireless@vger.kernel.org>; Sun, 25 Aug 2024 16:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724602649; cv=none; b=tuVQxN3tIgqnhuGxxsph4fvOeA9sVrWzaEbPg7LOG6YjkDKmVQtiCiypCuMQugEcaSM//fZBe5D6gBhXIcXDmbBTrZXMrjX9rSN+N0cICybbipiPdgpquRt5MG5NBgIeTZ5l2Q1FcObcCqH6hs1KYqqFATwDrOuomzgqO36e7tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724602649; c=relaxed/simple;
	bh=S5XK7T5zLly+54sSle9RmoMNVRT7fZzF7Kf2iX7maNs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V/hkUbj8HM/MICMDI993e4w6c6XBgJs7BpunuyauJuHwjj4LjYaQDlAFAGB+wRaQHgDUEHB2OznQbLKWfyqODJLcUBmAQJvoa6dfWzh7Axlouf9CUuoU5ysUd1xEms+DWqO5PekNC+zuO3c2qBE9BDdePpHavumkd9u1LFuOuWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ru9qNvPG; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724602646; x=1756138646;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=S5XK7T5zLly+54sSle9RmoMNVRT7fZzF7Kf2iX7maNs=;
  b=Ru9qNvPGWD+3P27HFfAkxmjmey8BrXNXkGg5H165cZhD68Vn4BbC3HQK
   L55NUkZe/wYI/9mDH0l0WAeO2ZMpmAR5ekTxQnigHw4brpSKMxmAfeHb8
   +a/7/6zKtQNvJlTVwAgS+FWhUc8HfWLUQl6q1Kesx0+DNIIK3OyqJWFJA
   YmD9+ilp707SWIdZRnpjyr3TkS6utVsEViuibD2x7diK0cE7LeQ8aIeuc
   zUv2jpkALcNxKN8sDLMWctDvkSNpm7UEPQikvoHokp+n9YXSC/Iwa0ayk
   bMTDvRNsMteuAPL0GTjwE6KG6k1cMmyTxfoI/qhsnox8yKMjfA60HZRJ2
   Q==;
X-CSE-ConnectionGUID: d0D+RmjHTeqtR0vGedNK1g==
X-CSE-MsgGUID: 47vlNMMDSOqCMSSxACyd4w==
X-IronPort-AV: E=McAfee;i="6700,10204,11175"; a="22544118"
X-IronPort-AV: E=Sophos;i="6.10,175,1719903600"; 
   d="scan'208";a="22544118"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2024 09:17:26 -0700
X-CSE-ConnectionGUID: Bh8sRbBkSH6P/uLFHyFdBA==
X-CSE-MsgGUID: /rlDXVAzRYGu7o1h8rf2cw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,175,1719903600"; 
   d="scan'208";a="62999729"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2024 09:17:25 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH 02/13] wifi: iwlwifi: mvm: fix hibernation
Date: Sun, 25 Aug 2024 19:17:02 +0300
Message-Id: <20240825191257.24eb3b19e74f.I3837810318dbef0a0a773cf4c4fcf89cdc6fdbd3@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240825161713.3547021-1-miriam.rachel.korenblit@intel.com>
References: <20240825161713.3547021-1-miriam.rachel.korenblit@intel.com>
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


