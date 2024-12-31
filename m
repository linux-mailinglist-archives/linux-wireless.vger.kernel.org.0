Return-Path: <linux-wireless+bounces-16936-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E9BA9FEF3B
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Dec 2024 12:59:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 904603A302C
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Dec 2024 11:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87E1C19D072;
	Tue, 31 Dec 2024 11:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X8iIfJc3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92EA919CD1D
	for <linux-wireless@vger.kernel.org>; Tue, 31 Dec 2024 11:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735646377; cv=none; b=l3s7XvbUBJMVvHnCiUB1mOLfxf6b81rx0ckoSpTxAoMg/F6kGxQgm8c7yanJpuU5u0uhtdsNfJ+lCS9Twg5A5fURXWmqbQ/opmnJWUL5Y0VNMWIqWz+8RuaPrIBC3Qcv5lt8IvJH8jKl9p6R7WG45ZGOrc0vZq5W2lnTzGEwd30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735646377; c=relaxed/simple;
	bh=hAQdTSZQS2A2ZKHbuKxP1ccqZqQ5LpGSnnHTjIgb5aI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IyHHXDmqV3K0Mpglb3e0PVVOcGsZ8x4Fv/JCXboYxfY/s8KjiCg1RcbaIT8+xvyN21EWZfvTl//mIhzJCw8QuGqM34dq0JJ228DU32yTV6ZnSXLi2l8kETknEpZYkd2Lj3ft0zShZ4RCbHNCiVIu/oO5d6EtJzu/Zyt2K3W9J8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X8iIfJc3; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735646376; x=1767182376;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hAQdTSZQS2A2ZKHbuKxP1ccqZqQ5LpGSnnHTjIgb5aI=;
  b=X8iIfJc3BK3Fhs71wbFHILRNhbxoXgk9RYRnH/W/shWW+IV7e1yIAIhk
   4Z8Z1ecSYPVvTj0dYIWBZfdp+F1Vb87Za7TFmOgsqYhwfu2E/W0zhG/YQ
   9q39RrYhKXKoMea8THXXgsZfDLZRikJin+Tq71cLbyAV0bLSUqQA89ylH
   podqDmCIjskZMM0xBafVAMWhFuCTkPjW3c3gHOHFraNpLd8AFrwXVFoYO
   R1//61iMi6nTBL7MD+AiOW7L46G5xcCRsZSfUqP5+ZZ80h0XBmhg0p2y4
   AW0FYwgyVb+NLmRZSKBQRx3wpqQKQV4owZWPySWkKE6wusEKS9+kMVDoc
   w==;
X-CSE-ConnectionGUID: vzaMXpmPSFicf3xH6/bIEw==
X-CSE-MsgGUID: ocR89LE6TF6vP/2aAGTXYw==
X-IronPort-AV: E=McAfee;i="6700,10204,11302"; a="53330166"
X-IronPort-AV: E=Sophos;i="6.12,279,1728975600"; 
   d="scan'208";a="53330166"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2024 03:59:35 -0800
X-CSE-ConnectionGUID: bPGTmSV3TLKWZ7O5G+c5Ow==
X-CSE-MsgGUID: 8FQzk5DuTPi38sbcikw6wA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="138380280"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2024 03:59:35 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 04/15] wifi: iwlwifi: implement reset escalation
Date: Tue, 31 Dec 2024 13:59:04 +0200
Message-Id: <20241231135726.804e005403d8.I9558f09cd68eec16b02373b1e47adafd28fdffa3@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241231115915.1082656-1-miriam.rachel.korenblit@intel.com>
References: <20241231115915.1082656-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

If the normal reset methods don't work well, attempt to
escalate to ever increasing methods. TOP reset will only
be available for SC (and presumably higher) devices, and
still needs to be filled in.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c  |   1 +
 .../net/wireless/intel/iwlwifi/iwl-trans.c    | 160 +++++++++++++++---
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |   6 +
 .../net/wireless/intel/iwlwifi/pcie/trans.c   |   8 +
 4 files changed, 152 insertions(+), 23 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
index 57991c251cbf..d3a65f33097c 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
@@ -1949,6 +1949,7 @@ module_init(iwl_drv_init);
 static void __exit iwl_drv_exit(void)
 {
 	iwl_pci_unregister_driver();
+	iwl_trans_free_restart_list();
 
 #ifdef CONFIG_IWLWIFI_DEBUGFS
 	debugfs_remove_recursive(iwl_dbgfs_root);
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.c b/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
index a941a525dd7d..49c8507d1a6b 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
@@ -6,6 +6,7 @@
  */
 #include <linux/kernel.h>
 #include <linux/bsearch.h>
+#include <linux/list.h>
 
 #include "fw/api/tx.h"
 #include "iwl-trans.h"
@@ -16,6 +17,68 @@
 #include "pcie/internal.h"
 #include "iwl-context-info-gen3.h"
 
+struct iwl_trans_dev_restart_data {
+	struct list_head list;
+	unsigned int restart_count;
+	time64_t last_error;
+	char name[];
+};
+
+static LIST_HEAD(restart_data_list);
+static DEFINE_SPINLOCK(restart_data_lock);
+
+static struct iwl_trans_dev_restart_data *
+iwl_trans_get_restart_data(struct device *dev)
+{
+	struct iwl_trans_dev_restart_data *tmp, *data = NULL;
+	const char *name = dev_name(dev);
+
+	spin_lock(&restart_data_lock);
+	list_for_each_entry(tmp, &restart_data_list, list) {
+		if (strcmp(tmp->name, name))
+			continue;
+		data = tmp;
+		break;
+	}
+	spin_unlock(&restart_data_lock);
+
+	if (data)
+		return data;
+
+	data = kzalloc(struct_size(data, name, strlen(name) + 1), GFP_ATOMIC);
+	if (!data)
+		return NULL;
+
+	strcpy(data->name, name);
+	spin_lock(&restart_data_lock);
+	list_add_tail(&data->list, &restart_data_list);
+	spin_unlock(&restart_data_lock);
+
+	return data;
+}
+
+static void iwl_trans_inc_restart_count(struct device *dev)
+{
+	struct iwl_trans_dev_restart_data *data;
+
+	data = iwl_trans_get_restart_data(dev);
+	if (data) {
+		data->last_error = ktime_get_boottime_seconds();
+		data->restart_count++;
+	}
+}
+
+void iwl_trans_free_restart_list(void)
+{
+	struct iwl_trans_dev_restart_data *tmp;
+
+	while ((tmp = list_first_entry_or_null(&restart_data_list,
+					       typeof(*tmp), list))) {
+		list_del(&tmp->list);
+		kfree(tmp);
+	}
+}
+
 struct iwl_trans_reprobe {
 	struct device *dev;
 	struct work_struct work;
@@ -34,10 +97,52 @@ static void iwl_trans_reprobe_wk(struct work_struct *wk)
 	module_put(THIS_MODULE);
 }
 
+#define IWL_TRANS_RESET_OK_TIME	180 /* seconds */
+
+static enum iwl_reset_mode
+iwl_trans_determine_restart_mode(struct iwl_trans *trans)
+{
+	struct iwl_trans_dev_restart_data *data;
+	enum iwl_reset_mode at_least = 0;
+	unsigned int index;
+	static const enum iwl_reset_mode escalation_list[] = {
+		IWL_RESET_MODE_SW_RESET,
+		IWL_RESET_MODE_REPROBE,
+		IWL_RESET_MODE_REPROBE,
+		IWL_RESET_MODE_FUNC_RESET,
+		/* FIXME: add TOP reset */
+		IWL_RESET_MODE_PROD_RESET,
+		/* FIXME: add TOP reset */
+		IWL_RESET_MODE_PROD_RESET,
+		/* FIXME: add TOP reset */
+		IWL_RESET_MODE_PROD_RESET,
+	};
+
+	if (trans->restart.during_reset)
+		at_least = IWL_RESET_MODE_REPROBE;
+
+	data = iwl_trans_get_restart_data(trans->dev);
+	if (!data)
+		return at_least;
+
+	if (ktime_get_boottime_seconds() - data->last_error >=
+			IWL_TRANS_RESET_OK_TIME)
+		data->restart_count = 0;
+
+	index = data->restart_count;
+	if (index >= ARRAY_SIZE(escalation_list))
+		index = ARRAY_SIZE(escalation_list) - 1;
+
+	return max(at_least, escalation_list[index]);
+}
+
+#define IWL_TRANS_RESET_DELAY	(HZ * 60)
+
 static void iwl_trans_restart_wk(struct work_struct *wk)
 {
 	struct iwl_trans *trans = container_of(wk, typeof(*trans), restart.wk);
 	struct iwl_trans_reprobe *reprobe;
+	enum iwl_reset_mode mode;
 
 	if (!trans->op_mode)
 		return;
@@ -62,32 +167,41 @@ static void iwl_trans_restart_wk(struct work_struct *wk)
 	if (!iwlwifi_mod_params.fw_restart)
 		return;
 
-	if (!trans->restart.during_reset) {
-		iwl_trans_opmode_sw_reset(trans, trans->restart.mode.type);
-		return;
-	}
+	mode = iwl_trans_determine_restart_mode(trans);
 
-	IWL_ERR(trans,
-		"Device error during reconfiguration - reprobe!\n");
+	iwl_trans_inc_restart_count(trans->dev);
 
-	/*
-	 * get a module reference to avoid doing this while unloading
-	 * anyway and to avoid scheduling a work with code that's
-	 * being removed.
-	 */
-	if (!try_module_get(THIS_MODULE)) {
-		IWL_ERR(trans, "Module is being unloaded - abort\n");
-		return;
-	}
-
-	reprobe = kzalloc(sizeof(*reprobe), GFP_KERNEL);
-	if (!reprobe) {
-		module_put(THIS_MODULE);
-		return;
+	switch (mode) {
+	case IWL_RESET_MODE_SW_RESET:
+		IWL_ERR(trans, "Device error - SW reset\n");
+		iwl_trans_opmode_sw_reset(trans, trans->restart.mode.type);
+		break;
+	case IWL_RESET_MODE_REPROBE:
+		IWL_ERR(trans, "Device error - reprobe!\n");
+
+		/*
+		 * get a module reference to avoid doing this while unloading
+		 * anyway and to avoid scheduling a work with code that's
+		 * being removed.
+		 */
+		if (!try_module_get(THIS_MODULE)) {
+			IWL_ERR(trans, "Module is being unloaded - abort\n");
+			return;
+		}
+
+		reprobe = kzalloc(sizeof(*reprobe), GFP_KERNEL);
+		if (!reprobe) {
+			module_put(THIS_MODULE);
+			return;
+		}
+		reprobe->dev = get_device(trans->dev);
+		INIT_WORK(&reprobe->work, iwl_trans_reprobe_wk);
+		schedule_work(&reprobe->work);
+		break;
+	default:
+		iwl_trans_pcie_reset(trans, mode);
+		break;
 	}
-	reprobe->dev = get_device(trans->dev);
-	INIT_WORK(&reprobe->work, iwl_trans_reprobe_wk);
-	schedule_work(&reprobe->work);
 }
 
 struct iwl_trans *iwl_trans_alloc(unsigned int priv_size,
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index 62c4b2e29e93..f6234065dbdd 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -1240,6 +1240,8 @@ static inline bool iwl_trans_is_hw_error_value(u32 val)
 	return ((val & ~0xf) == 0xa5a5a5a0) || ((val & ~0xf) == 0x5a5a5a50);
 }
 
+void iwl_trans_free_restart_list(void);
+
 /*****************************************************
  * PCIe handling
  *****************************************************/
@@ -1248,6 +1250,10 @@ void iwl_pci_unregister_driver(void);
 
 /* Note: order matters */
 enum iwl_reset_mode {
+	/* upper level modes: */
+	IWL_RESET_MODE_SW_RESET,
+	IWL_RESET_MODE_REPROBE,
+	/* PCIE level modes: */
 	IWL_RESET_MODE_REMOVE_ONLY,
 	IWL_RESET_MODE_RESCAN,
 	IWL_RESET_MODE_FUNC_RESET,
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index 79967a3ff8dc..044f46fa4ba7 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -2351,6 +2351,9 @@ void iwl_trans_pcie_reset(struct iwl_trans *trans, enum iwl_reset_mode mode)
 	struct iwl_trans_pcie_removal *removal;
 	char _msg = 0, *msg = &_msg;
 
+	if (WARN_ON(mode < IWL_RESET_MODE_REMOVE_ONLY))
+		return;
+
 	if (test_bit(STATUS_TRANS_DEAD, &trans->status))
 		return;
 
@@ -3255,6 +3258,8 @@ static ssize_t iwl_dbgfs_reset_write(struct file *file,
 {
 	struct iwl_trans *trans = file->private_data;
 	static const char * const modes[] = {
+		[IWL_RESET_MODE_SW_RESET] = "n/a",
+		[IWL_RESET_MODE_REPROBE] = "n/a",
 		[IWL_RESET_MODE_REMOVE_ONLY] = "remove",
 		[IWL_RESET_MODE_RESCAN] = "rescan",
 		[IWL_RESET_MODE_FUNC_RESET] = "function",
@@ -3273,6 +3278,9 @@ static ssize_t iwl_dbgfs_reset_write(struct file *file,
 	if (mode < 0)
 		return mode;
 
+	if (mode < IWL_RESET_MODE_REMOVE_ONLY)
+		return -EINVAL;
+
 	iwl_trans_pcie_reset(trans, mode);
 
 	return count;
-- 
2.34.1


