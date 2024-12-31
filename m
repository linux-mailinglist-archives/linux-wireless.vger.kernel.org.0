Return-Path: <linux-wireless+bounces-16935-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07FCC9FEF3A
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Dec 2024 12:59:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF40818830DF
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Dec 2024 11:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80F09195962;
	Tue, 31 Dec 2024 11:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lTy9uVtg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348CB19C546
	for <linux-wireless@vger.kernel.org>; Tue, 31 Dec 2024 11:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735646376; cv=none; b=pvsYO+CwbAINNx1xUKUChFF8DXs/FUViv24PUtT3SuaJhQXSe8JymH1l7jqvQr+r+SuSMI32SdEGSLM6eyw/N4IjXiaR9tlz5M2iM8WQydaukHZ/wOmwEKYmgPVkWgP+cUesdKeRm/vtbFhxqJ4Ked/BQhhCPdJREbrjm3vhdHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735646376; c=relaxed/simple;
	bh=Dyy5WALCX5wdwe5ssJ+zGdzb/C/Js137g45opQecrTY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZiZA8ytwgntmJcBi5jfu4Oy55wyMfRhaNxIMN1t1FDSa/ISrqt3f2U3en8/c1vosEd9FZzP8qM+3v179LlXrPK5ksPKVuFxuYU3tBh18pyrPZwjMAp/wRQ+B+11XS/C1uPO31nHYyDIWPdg2uDctm5g5PzgJTLeVSsFjYDc0MX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lTy9uVtg; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735646374; x=1767182374;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Dyy5WALCX5wdwe5ssJ+zGdzb/C/Js137g45opQecrTY=;
  b=lTy9uVtgiDeEBt94MCWwTXXgJdSDcQGgGYqQh60S7oMz1eRObNxLvgBD
   UEimMsebUwzOmS+4okPQJqlwnHMTwps7kn+aAWoagUcEALyF+F8nAqaxo
   lOu38pq2jwEBY6nU4mix66VZwFUcAzkWhNCoj5ypauad4I2IjUFRMP1fz
   rDAo5ACLtfGiyS0p4u6kX+ygjbpUMsaMLO66SQd1n/IHMe07ilBYOFRY3
   EAhvKBZTvNQvBKDgRyN9X0v+skBpXiWqTfL0Bsfho5HNQs31O2Q2yG5fU
   AnPE3RBVlXo1CdMaJ1+fPS9c1L8obBt2Q+PGKDVDAYbBcqKDSW6zxttNy
   w==;
X-CSE-ConnectionGUID: aPljMANLQy2XyyV7D3R4KA==
X-CSE-MsgGUID: L+Jse7wdR/mCUMIqwmD8LQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11302"; a="53330163"
X-IronPort-AV: E=Sophos;i="6.12,279,1728975600"; 
   d="scan'208";a="53330163"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2024 03:59:34 -0800
X-CSE-ConnectionGUID: ggHpE11nSRaWEa46DxPexw==
X-CSE-MsgGUID: DGVehKZ1R6eleEF3BjUxxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="138380274"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2024 03:59:33 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 03/15] wifi: iwlwifi: implement product reset for TOP errors
Date: Tue, 31 Dec 2024 13:59:03 +0200
Message-Id: <20241231135726.5b0f846d3e13.Ia14ccac38ac3d48adf5f341b17c7e34ccc41c065@changeid>
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

The TOP is a shared (between BT and WiFi) hardware component,
and if it has an error we need to reset the whole device, i.e.
both BT and WiFi. This is achieved by calling a specific ACPI
DSM (device-specific method) with the right arguments before
doing a reset via the object referenced by _PRR.

Since this is needed here, but a function reset will always do
better than just re-enumerating the bus in case of errors, we
can always try to at least do a function reset and do the full
product reset only when needed for TOP errors.

Also, for some Bz and Sc devices where BT is PCIe/IOSF as well,
find the BT device and unbind that device as well so the BT
driver can recover from the reset that's going to happen,
rather than having to somehow detect that the device was reset.

Also add - currently unused - the function reset mode, this is
going to get used in the upcoming escalation model.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c  |   6 +-
 drivers/net/wireless/intel/iwlwifi/fw/acpi.h  |  33 ++-
 .../net/wireless/intel/iwlwifi/iwl-debug.h    |   3 +-
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |  11 +-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   |   3 +-
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c |   3 +
 .../wireless/intel/iwlwifi/pcie/internal.h    |   3 +
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c  |   4 +-
 .../net/wireless/intel/iwlwifi/pcie/trans.c   | 261 +++++++++++++++++-
 9 files changed, 309 insertions(+), 18 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
index b32d5141dbbe..747b18ebbd66 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
@@ -79,9 +79,9 @@ static void *iwl_acpi_get_object(struct device *dev, acpi_string method)
  * method (DSM) interface. The returned acpi object must be freed by calling
  * function.
  */
-static void *iwl_acpi_get_dsm_object(struct device *dev, int rev, int func,
-				     union acpi_object *args,
-				     const guid_t *guid)
+union acpi_object *iwl_acpi_get_dsm_object(struct device *dev, int rev,
+					   int func, union acpi_object *args,
+					   const guid_t *guid)
 {
 	union acpi_object *obj;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.h b/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
index e153c44d5c1d..e50b93472dd2 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
@@ -109,6 +109,30 @@
 
 #define ACPI_DSM_REV 0
 
+#define DSM_INTERNAL_FUNC_GET_PLAT_INFO	1
+/* TBD: VPRO is BIT(0) in the result, but what's the result? */
+
+#define DSM_INTERNAL_FUNC_PRODUCT_RESET	2
+
+/* DSM_INTERNAL_FUNC_PRODUCT_RESET - product reset (aka "PLDR") */
+enum iwl_dsm_internal_product_reset_cmds {
+	DSM_INTERNAL_PLDR_CMD_GET_MODE = 1,
+	DSM_INTERNAL_PLDR_CMD_SET_MODE = 2,
+	DSM_INTERNAL_PLDR_CMD_GET_STATUS = 3,
+};
+
+enum iwl_dsm_internal_product_reset_mode {
+	DSM_INTERNAL_PLDR_MODE_EN_PROD_RESET	= BIT(0),
+	DSM_INTERNAL_PLDR_MODE_EN_WIFI_FLR	= BIT(1),
+	DSM_INTERNAL_PLDR_MODE_EN_BT_OFF_ON	= BIT(2),
+};
+
+struct iwl_dsm_internal_product_reset_cmd {
+	/* cmd is from enum iwl_dsm_internal_product_reset_cmds */
+	u16 cmd;
+	u16 value;
+} __packed;
+
 #define IWL_ACPI_WBEM_REV0_MASK (BIT(0) | BIT(1))
 #define IWL_ACPI_WBEM_REVISION 0
 
@@ -118,6 +142,10 @@ struct iwl_fw_runtime;
 
 extern const guid_t iwl_guid;
 
+union acpi_object *iwl_acpi_get_dsm_object(struct device *dev, int rev,
+					   int func, union acpi_object *args,
+					   const guid_t *guid);
+
 /**
  * iwl_acpi_get_mcc - read MCC from ACPI, if available
  *
@@ -166,8 +194,9 @@ int iwl_acpi_get_dsbr(struct iwl_fw_runtime *fwrt, u32 *value);
 
 #else /* CONFIG_ACPI */
 
-static inline void *iwl_acpi_get_dsm_object(struct device *dev, int rev,
-					    int func, union acpi_object *args)
+static inline union acpi_object *
+iwl_acpi_get_dsm_object(struct device *dev, int rev, int func,
+			union acpi_object *args, const guid_t *guid)
 {
 	return ERR_PTR(-ENOENT);
 }
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-debug.h b/drivers/net/wireless/intel/iwlwifi/iwl-debug.h
index 1b9f16a31b54..bf52c2edaad1 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-debug.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-debug.h
@@ -2,7 +2,7 @@
 /******************************************************************************
  *
  * Copyright(c) 2003 - 2014 Intel Corporation. All rights reserved.
- * Copyright(c) 2018 - 2021 Intel Corporation
+ * Copyright(c) 2018 - 2021, 2024 Intel Corporation
  *
  * Portions of this file are derived from the ipw3945 project.
  *****************************************************************************/
@@ -209,6 +209,7 @@ do {                                            			\
 #define IWL_DEBUG_RADIO(p, f, a...)	IWL_DEBUG(p, IWL_DL_RADIO, f, ## a)
 #define IWL_DEBUG_DEV_RADIO(p, f, a...)	IWL_DEBUG_DEV(p, IWL_DL_RADIO, f, ## a)
 #define IWL_DEBUG_POWER(p, f, a...)	IWL_DEBUG(p, IWL_DL_POWER, f, ## a)
+#define IWL_DEBUG_DEV_POWER(p, f, a...)	IWL_DEBUG_DEV(p, IWL_DL_POWER, f, ## a)
 #define IWL_DEBUG_11H(p, f, a...)	IWL_DEBUG(p, IWL_DL_11H, f, ## a)
 #define IWL_DEBUG_TPT(p, f, a...)	IWL_DEBUG(p, IWL_DL_TPT, f, ## a)
 #define IWL_DEBUG_WOWLAN(p, f, a...)	IWL_DEBUG(p, IWL_DL_WOWLAN, f, ## a)
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index c342a4d6ca6c..62c4b2e29e93 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -1245,7 +1245,16 @@ static inline bool iwl_trans_is_hw_error_value(u32 val)
  *****************************************************/
 int __must_check iwl_pci_register_driver(void);
 void iwl_pci_unregister_driver(void);
-void iwl_trans_pcie_remove(struct iwl_trans *trans, bool rescan);
+
+/* Note: order matters */
+enum iwl_reset_mode {
+	IWL_RESET_MODE_REMOVE_ONLY,
+	IWL_RESET_MODE_RESCAN,
+	IWL_RESET_MODE_FUNC_RESET,
+	IWL_RESET_MODE_PROD_RESET,
+};
+
+void iwl_trans_pcie_reset(struct iwl_trans *trans, enum iwl_reset_mode mode);
 
 int iwl_trans_pcie_send_hcmd(struct iwl_trans *trans,
 			     struct iwl_host_cmd *cmd);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 029347b79655..52056f489797 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -642,7 +642,8 @@ static int iwl_run_unified_mvm_ucode(struct iwl_mvm *mvm)
 		/* if we needed reset then fail here, but notify and remove */
 		if (mvm->fw_product_reset) {
 			iwl_mei_alive_notif(false);
-			iwl_trans_pcie_remove(mvm->trans, true);
+			iwl_trans_pcie_reset(mvm->trans,
+					     IWL_RESET_MODE_RESCAN);
 		}
 
 		goto error;
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 892444844a9b..7a93ab513edd 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -1445,6 +1445,9 @@ static int iwl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	trans_pcie = IWL_TRANS_GET_PCIE_TRANS(iwl_trans);
 
+	iwl_trans_pcie_check_product_reset_status(pdev);
+	iwl_trans_pcie_check_product_reset_mode(pdev);
+
 	/*
 	 * Let's try to grab NIC access early here. Sometimes, NICs may
 	 * fail to initialize, and if that happens it's better if we see
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
index 27a7e0b5b3d5..617ec598de65 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
@@ -563,6 +563,9 @@ bool __iwl_trans_pcie_grab_nic_access(struct iwl_trans *trans);
 	__cond_lock(nic_access_nobh,				\
 		    likely(__iwl_trans_pcie_grab_nic_access(trans)))
 
+void iwl_trans_pcie_check_product_reset_status(struct pci_dev *pdev);
+void iwl_trans_pcie_check_product_reset_mode(struct pci_dev *pdev);
+
 /*****************************************************
 * RX
 ******************************************************/
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
index 02fef6baf2e3..4a442d03d8d2 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
@@ -2297,7 +2297,9 @@ irqreturn_t iwl_pcie_irq_msix_handler(int irq, void *dev_id)
 	if (inta_hw & MSIX_HW_INT_CAUSES_REG_TOP_FATAL_ERR) {
 		IWL_ERR(trans, "TOP Fatal error detected, inta_hw=0x%x.\n",
 			inta_hw);
-		/* TODO: PLDR flow required here for >= Bz */
+		if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_BZ)
+			iwl_trans_pcie_reset(trans,
+					     IWL_RESET_MODE_PROD_RESET);
 	}
 
 	/* Error detected by uCode */
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index 053f0ac756be..79967a3ff8dc 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -24,6 +24,7 @@
 #include "fw/error-dump.h"
 #include "fw/dbg.h"
 #include "fw/api/tx.h"
+#include "fw/acpi.h"
 #include "mei/iwl-mei.h"
 #include "internal.h"
 #include "iwl-fh.h"
@@ -2105,10 +2106,157 @@ void iwl_trans_pcie_free(struct iwl_trans *trans)
 	iwl_trans_free(trans);
 }
 
+static union acpi_object *
+iwl_trans_pcie_call_prod_reset_dsm(struct pci_dev *pdev, u16 cmd, u16 value)
+{
+#ifdef CONFIG_ACPI
+	struct iwl_dsm_internal_product_reset_cmd pldr_arg = {
+		.cmd = cmd,
+		.value = value,
+	};
+	union acpi_object arg = {
+		.buffer.type = ACPI_TYPE_BUFFER,
+		.buffer.length = sizeof(pldr_arg),
+		.buffer.pointer = (void *)&pldr_arg,
+	};
+	static const guid_t dsm_guid = GUID_INIT(0x7266172C, 0x220B, 0x4B29,
+						 0x81, 0x4F, 0x75, 0xE4,
+						 0xDD, 0x26, 0xB5, 0xFD);
+
+	if (!acpi_check_dsm(ACPI_HANDLE(&pdev->dev), &dsm_guid, ACPI_DSM_REV,
+			    DSM_INTERNAL_FUNC_PRODUCT_RESET))
+		return ERR_PTR(-ENODEV);
+
+	return iwl_acpi_get_dsm_object(&pdev->dev, ACPI_DSM_REV,
+				       DSM_INTERNAL_FUNC_PRODUCT_RESET,
+				       &arg, &dsm_guid);
+#else
+	return ERR_PTR(-EOPNOTSUPP);
+#endif
+}
+
+void iwl_trans_pcie_check_product_reset_mode(struct pci_dev *pdev)
+{
+	union acpi_object *res;
+
+	res = iwl_trans_pcie_call_prod_reset_dsm(pdev,
+						 DSM_INTERNAL_PLDR_CMD_GET_MODE,
+						 0);
+	if (IS_ERR(res))
+		return;
+
+	if (res->type != ACPI_TYPE_INTEGER)
+		IWL_ERR_DEV(&pdev->dev,
+			    "unexpected return type from product reset DSM\n");
+	else
+		IWL_DEBUG_DEV_POWER(&pdev->dev,
+				    "product reset mode is 0x%llx\n",
+				    res->integer.value);
+
+	ACPI_FREE(res);
+}
+
+static void iwl_trans_pcie_set_product_reset(struct pci_dev *pdev, bool enable,
+					     bool integrated)
+{
+	union acpi_object *res;
+	u16 mode = enable ? DSM_INTERNAL_PLDR_MODE_EN_PROD_RESET : 0;
+
+	if (!integrated)
+		mode |= DSM_INTERNAL_PLDR_MODE_EN_WIFI_FLR |
+			DSM_INTERNAL_PLDR_MODE_EN_BT_OFF_ON;
+
+	res = iwl_trans_pcie_call_prod_reset_dsm(pdev,
+						 DSM_INTERNAL_PLDR_CMD_SET_MODE,
+						 mode);
+	if (IS_ERR(res)) {
+		if (enable)
+			IWL_ERR_DEV(&pdev->dev,
+				    "ACPI _DSM not available (%d), cannot do product reset\n",
+				    (int)PTR_ERR(res));
+		return;
+	}
+
+	ACPI_FREE(res);
+	IWL_DEBUG_DEV_POWER(&pdev->dev, "%sabled product reset via DSM\n",
+			    enable ? "En" : "Dis");
+	iwl_trans_pcie_check_product_reset_mode(pdev);
+}
+
+void iwl_trans_pcie_check_product_reset_status(struct pci_dev *pdev)
+{
+	union acpi_object *res;
+
+	res = iwl_trans_pcie_call_prod_reset_dsm(pdev,
+						 DSM_INTERNAL_PLDR_CMD_GET_STATUS,
+						 0);
+	if (IS_ERR(res))
+		return;
+
+	if (res->type != ACPI_TYPE_INTEGER)
+		IWL_ERR_DEV(&pdev->dev,
+			    "unexpected return type from product reset DSM\n");
+	else
+		IWL_DEBUG_DEV_POWER(&pdev->dev,
+				    "product reset status is 0x%llx\n",
+				    res->integer.value);
+
+	ACPI_FREE(res);
+}
+
+static void iwl_trans_pcie_call_reset(struct pci_dev *pdev)
+{
+#ifdef CONFIG_ACPI
+	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
+	union acpi_object *p, *ref;
+	acpi_status status;
+	int ret = -EINVAL;
+
+	status = acpi_evaluate_object(ACPI_HANDLE(&pdev->dev),
+				      "_PRR", NULL, &buffer);
+	if (ACPI_FAILURE(status)) {
+		IWL_DEBUG_DEV_POWER(&pdev->dev, "No _PRR method found\n");
+		goto out;
+	}
+	p = buffer.pointer;
+
+	if (p->type != ACPI_TYPE_PACKAGE || p->package.count != 1) {
+		pci_err(pdev, "Bad _PRR return type\n");
+		goto out;
+	}
+
+	ref = &p->package.elements[0];
+	if (ref->type != ACPI_TYPE_LOCAL_REFERENCE) {
+		pci_err(pdev, "_PRR wasn't a reference\n");
+		goto out;
+	}
+
+	status = acpi_evaluate_object(ref->reference.handle,
+				      "_RST", NULL, NULL);
+	if (ACPI_FAILURE(status)) {
+		pci_err(pdev,
+			"Failed to call _RST on object returned by _PRR (%d)\n",
+			status);
+		goto out;
+	}
+	ret = 0;
+out:
+	kfree(buffer.pointer);
+	if (!ret) {
+		IWL_DEBUG_DEV_POWER(&pdev->dev, "called _RST on _PRR object\n");
+		return;
+	}
+	IWL_DEBUG_DEV_POWER(&pdev->dev,
+			    "No BIOS support, using pci_reset_function()\n");
+#endif
+	pci_reset_function(pdev);
+}
+
 struct iwl_trans_pcie_removal {
 	struct pci_dev *pdev;
 	struct work_struct work;
-	bool rescan;
+	enum iwl_reset_mode mode;
+	bool integrated;
 };
 
 static void iwl_trans_pcie_removal_wk(struct work_struct *wk)
@@ -2126,14 +2274,66 @@ static void iwl_trans_pcie_removal_wk(struct work_struct *wk)
 	if (!bus)
 		goto out;
 
-	dev_err(&pdev->dev, "Device gone - attempting removal\n");
-
 	kobject_uevent_env(&pdev->dev.kobj, KOBJ_CHANGE, prop);
 
+	if (removal->mode == IWL_RESET_MODE_PROD_RESET) {
+		struct pci_dev *bt = NULL;
+
+		if (!removal->integrated) {
+			/* discrete devices have WiFi/BT at function 0/1 */
+			int slot = PCI_SLOT(pdev->devfn);
+			int func = PCI_FUNC(pdev->devfn);
+
+			if (func == 0)
+				bt = pci_get_slot(bus, PCI_DEVFN(slot, 1));
+			else
+				pci_info(pdev, "Unexpected function %d\n",
+					 func);
+		} else {
+			/* on integrated we have to look up by ID (same bus) */
+			static const struct pci_device_id bt_device_ids[] = {
+#define BT_DEV(_id) { PCI_DEVICE(PCI_VENDOR_ID_INTEL, _id) }
+				BT_DEV(0xA876), /* LNL */
+				BT_DEV(0xE476), /* PTL-P */
+				BT_DEV(0xE376), /* PTL-H */
+				BT_DEV(0xD346), /* NVL-H */
+				BT_DEV(0x6E74), /* NVL-S */
+				BT_DEV(0x4D76), /* WCL */
+				BT_DEV(0xD246), /* RZL-H */
+				BT_DEV(0x6C46), /* RZL-M */
+				{}
+			};
+			struct pci_dev *tmp = NULL;
+
+			for_each_pci_dev(tmp) {
+				if (tmp->bus != bus)
+					continue;
+
+				if (pci_match_id(bt_device_ids, tmp)) {
+					bt = tmp;
+					break;
+				}
+			}
+		}
+
+		if (bt) {
+			pci_info(bt, "Removal by WiFi due to product reset\n");
+			pci_stop_and_remove_bus_device(bt);
+			pci_dev_put(bt);
+		}
+	}
+
+	iwl_trans_pcie_set_product_reset(pdev,
+					 removal->mode ==
+						IWL_RESET_MODE_PROD_RESET,
+					 removal->integrated);
+	if (removal->mode >= IWL_RESET_MODE_FUNC_RESET)
+		iwl_trans_pcie_call_reset(pdev);
+
 	pci_stop_and_remove_bus_device(pdev);
 	pci_dev_put(pdev);
 
-	if (removal->rescan) {
+	if (removal->mode >= IWL_RESET_MODE_RESCAN) {
 		if (bus->parent)
 			bus = bus->parent;
 		pci_rescan_bus(bus);
@@ -2146,14 +2346,24 @@ static void iwl_trans_pcie_removal_wk(struct work_struct *wk)
 	module_put(THIS_MODULE);
 }
 
-void iwl_trans_pcie_remove(struct iwl_trans *trans, bool rescan)
+void iwl_trans_pcie_reset(struct iwl_trans *trans, enum iwl_reset_mode mode)
 {
 	struct iwl_trans_pcie_removal *removal;
+	char _msg = 0, *msg = &_msg;
 
 	if (test_bit(STATUS_TRANS_DEAD, &trans->status))
 		return;
 
-	IWL_ERR(trans, "Device gone - scheduling removal!\n");
+	if (trans->me_present && mode == IWL_RESET_MODE_PROD_RESET) {
+		mode = IWL_RESET_MODE_FUNC_RESET;
+		if (trans->me_present < 0)
+			msg = " instead of product reset as ME may be present";
+		else
+			msg = " instead of product reset as ME is present";
+	}
+
+	IWL_INFO(trans, "scheduling reset (mode=%d%s)\n", mode, msg);
+
 	iwl_pcie_dump_csr(trans);
 
 	/*
@@ -2180,12 +2390,13 @@ void iwl_trans_pcie_remove(struct iwl_trans *trans, bool rescan)
 	set_bit(STATUS_TRANS_DEAD, &trans->status);
 
 	removal->pdev = to_pci_dev(trans->dev);
-	removal->rescan = rescan;
+	removal->mode = mode;
+	removal->integrated = trans->trans_cfg->integrated;
 	INIT_WORK(&removal->work, iwl_trans_pcie_removal_wk);
 	pci_dev_get(removal->pdev);
 	schedule_work(&removal->work);
 }
-EXPORT_SYMBOL(iwl_trans_pcie_remove);
+EXPORT_SYMBOL(iwl_trans_pcie_reset);
 
 /*
  * This version doesn't disable BHs but rather assumes they're
@@ -2250,7 +2461,8 @@ bool __iwl_trans_pcie_grab_nic_access(struct iwl_trans *trans)
 		iwl_trans_pcie_dump_regs(trans);
 
 		if (iwlwifi_mod_params.remove_when_gone && cntrl == ~0U)
-			iwl_trans_pcie_remove(trans, false);
+			iwl_trans_pcie_reset(trans,
+					     IWL_RESET_MODE_REMOVE_ONLY);
 		else
 			iwl_write32(trans, CSR_RESET,
 				    CSR_RESET_REG_FLAG_FORCE_NMI);
@@ -3037,12 +3249,42 @@ static ssize_t iwl_dbgfs_rf_read(struct file *file,
 				       strlen(trans_pcie->rf_name));
 }
 
+static ssize_t iwl_dbgfs_reset_write(struct file *file,
+				     const char __user *user_buf,
+				     size_t count, loff_t *ppos)
+{
+	struct iwl_trans *trans = file->private_data;
+	static const char * const modes[] = {
+		[IWL_RESET_MODE_REMOVE_ONLY] = "remove",
+		[IWL_RESET_MODE_RESCAN] = "rescan",
+		[IWL_RESET_MODE_FUNC_RESET] = "function",
+		[IWL_RESET_MODE_PROD_RESET] = "product",
+	};
+	char buf[10] = {};
+	int mode;
+
+	if (count > sizeof(buf) - 1)
+		return -EINVAL;
+
+	if (copy_from_user(buf, user_buf, count))
+		return -EFAULT;
+
+	mode = sysfs_match_string(modes, buf);
+	if (mode < 0)
+		return mode;
+
+	iwl_trans_pcie_reset(trans, mode);
+
+	return count;
+}
+
 DEBUGFS_READ_WRITE_FILE_OPS(interrupt);
 DEBUGFS_READ_FILE_OPS(fh_reg);
 DEBUGFS_READ_FILE_OPS(rx_queue);
 DEBUGFS_WRITE_FILE_OPS(csr);
 DEBUGFS_READ_WRITE_FILE_OPS(rfkill);
 DEBUGFS_READ_FILE_OPS(rf);
+DEBUGFS_WRITE_FILE_OPS(reset);
 
 static const struct file_operations iwl_dbgfs_tx_queue_ops = {
 	.owner = THIS_MODULE,
@@ -3071,6 +3313,7 @@ void iwl_trans_pcie_dbgfs_register(struct iwl_trans *trans)
 	DEBUGFS_ADD_FILE(rfkill, dir, 0600);
 	DEBUGFS_ADD_FILE(monitor_data, dir, 0400);
 	DEBUGFS_ADD_FILE(rf, dir, 0400);
+	DEBUGFS_ADD_FILE(reset, dir, 0200);
 }
 
 void iwl_trans_pcie_debugfs_cleanup(struct iwl_trans *trans)
-- 
2.34.1


