Return-Path: <linux-wireless+bounces-21763-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5F2BA9474D
	for <lists+linux-wireless@lfdr.de>; Sun, 20 Apr 2025 11:02:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FA1A1893FE5
	for <lists+linux-wireless@lfdr.de>; Sun, 20 Apr 2025 09:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66738155A30;
	Sun, 20 Apr 2025 09:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m0tJwnnJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30CF31DEFFC
	for <linux-wireless@vger.kernel.org>; Sun, 20 Apr 2025 09:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745139730; cv=none; b=EHyVz+vfeBJBJBJly+sYVEzgkhhLVgiPUq3b8MgJVAgZPauxIz6NvAyXbmIW6qlCd64S58QQdcmiayExGax+O98JaLCB3V+dq9OzGsgHIOXgZmTtG8KPci8aDUEaialD2ORN2P4Mf5AIFUwtTmmkhia3PYi22qvQJIR1KznI7h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745139730; c=relaxed/simple;
	bh=3SEj3GT8TMLJroWW8TyShBaeWZRqoFNsv1NZ6Vo88GI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qJYMZ9+IqyGIfAAX9vkwwD+PfQhyRVvy0vCvm6hWWPQqME64Kdru4Y5PZ/I4HH1wOkUyaRY/3M42AeWIZgo+lzIcwV6Fh/6JPCTpaczD9pF1n98bLUMLuWr7BKkveLTtPdW97YXTKY3UbNZ+nSka/pTcyKqxMWoJlLVSd4MvXjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m0tJwnnJ; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745139727; x=1776675727;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3SEj3GT8TMLJroWW8TyShBaeWZRqoFNsv1NZ6Vo88GI=;
  b=m0tJwnnJzOTXFgAQHCpxH6j0LVCGDw4kY9IQvWMjjyOskrsiz7oSxefu
   XBG8yCICiWqNyhBz9A1hm/Yl35q7v4GNV8LkUdz4f+TdTlHClYeilddHp
   CuFE4W9lGMEYlWh4xezVmFG+SUMakzYlvagpbUQ9DHXoJDTB6it8qpbE2
   YhFKlZWQH9r41eDJt2sLfuysb2L2SWZIIb6oEukWDBf83/MF1x2OBcwgB
   3l/vPec19o8OBR1L0KQBz7EoRAQIBV7Y93001cP1XT4goPFp85Vd51NNm
   te9W54ArhSSfsAN38iUb2rCi2mETErrPfKWz1QE7ZKQi4dOFQy8uIx215
   Q==;
X-CSE-ConnectionGUID: JqVy6S8TRN6HDc3sImcLmg==
X-CSE-MsgGUID: PXK1+CR8R6egpJidFlm0qA==
X-IronPort-AV: E=McAfee;i="6700,10204,11408"; a="56880474"
X-IronPort-AV: E=Sophos;i="6.15,225,1739865600"; 
   d="scan'208";a="56880474"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2025 02:02:07 -0700
X-CSE-ConnectionGUID: oUFuUdc0RzGTXQjVW6rSEA==
X-CSE-MsgGUID: lKhnkCyQS62UiLCShwsHdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,225,1739865600"; 
   d="scan'208";a="136632855"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2025 02:02:05 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Todd Brandt <todd.e.brandt@intel.com>
Subject: [PATCH wireless 2/2] Revert "wifi: iwlwifi: make no_160 more generic"
Date: Sun, 20 Apr 2025 12:01:50 +0300
Message-Id: <20250420115541.36dd3007151e.I66b6b78db09bfea12ae84dd85603cf1583271474@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250420090150.3508273-1-miriam.rachel.korenblit@intel.com>
References: <20250420090150.3508273-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

This reverts commit 75a3313f52b7e08e7e73746f69a68c2b7c28bb2b.

The indication of the BW limitation in the sub-device ID is not applicable
for Killer devices. For those devices, bw_limit will hold a random value,
so a matching dev_info might not be found, which leads to a probe
failure.
Until it is properly fixed, revert this.

Reported-by: Todd Brandt <todd.e.brandt@intel.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220029
Fixes: 75a3313f52b7 ("wifi: iwlwifi: make no_160 more generic")
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/iwl-config.h   |  15 +-
 .../wireless/intel/iwlwifi/iwl-nvm-parse.c    |   4 +-
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |   7 +-
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 206 +++++++++---------
 .../wireless/intel/iwlwifi/tests/devinfo.c    |  15 +-
 5 files changed, 118 insertions(+), 129 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index 7e4864c00780..acafee538b8a 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -2,7 +2,7 @@
 /*
  * Copyright (C) 2005-2014, 2018-2021 Intel Corporation
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
- * Copyright (C) 2018-2025 Intel Corporation
+ * Copyright (C) 2018-2024 Intel Corporation
  */
 #ifndef __IWL_CONFIG_H__
 #define __IWL_CONFIG_H__
@@ -451,8 +451,11 @@ struct iwl_cfg {
 #define IWL_CFG_RF_ID_HR		0x7
 #define IWL_CFG_RF_ID_HR1		0x4
 
-#define IWL_CFG_BW_NO_LIM		(U16_MAX - 1)
-#define IWL_CFG_BW_ANY			U16_MAX
+#define IWL_CFG_NO_160			0x1
+#define IWL_CFG_160			0x0
+
+#define IWL_CFG_NO_320			0x1
+#define IWL_CFG_320			0x0
 
 #define IWL_CFG_CORES_BT		0x0
 #define IWL_CFG_CORES_BT_GNSS		0x5
@@ -464,7 +467,7 @@ struct iwl_cfg {
 #define IWL_CFG_IS_JACKET		0x1
 
 #define IWL_SUBDEVICE_RF_ID(subdevice)	((u16)((subdevice) & 0x00F0) >> 4)
-#define IWL_SUBDEVICE_BW_LIM(subdevice)	((u16)((subdevice) & 0x0200) >> 9)
+#define IWL_SUBDEVICE_NO_160(subdevice)	((u16)((subdevice) & 0x0200) >> 9)
 #define IWL_SUBDEVICE_CORES(subdevice)	((u16)((subdevice) & 0x1C00) >> 10)
 
 struct iwl_dev_info {
@@ -472,10 +475,10 @@ struct iwl_dev_info {
 	u16 subdevice;
 	u16 mac_type;
 	u16 rf_type;
-	u16 bw_limit;
 	u8 mac_step;
 	u8 rf_step;
 	u8 rf_id;
+	u8 no_160;
 	u8 cores;
 	u8 cdb;
 	u8 jacket;
@@ -489,7 +492,7 @@ extern const unsigned int iwl_dev_info_table_size;
 const struct iwl_dev_info *
 iwl_pci_find_dev_info(u16 device, u16 subsystem_device,
 		      u16 mac_type, u8 mac_step, u16 rf_type, u8 cdb,
-		      u8 jacket, u8 rf_id, u8 bw_limit, u8 cores, u8 rf_step);
+		      u8 jacket, u8 rf_id, u8 no_160, u8 cores, u8 rf_step);
 extern const struct pci_device_id iwl_hw_card_ids[];
 #endif
 
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
index 08269168b2fa..c381511e9ec6 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2005-2014, 2018-2023, 2025 Intel Corporation
+ * Copyright (C) 2005-2014, 2018-2023 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -1094,7 +1094,7 @@ iwl_nvm_fixup_sband_iftd(struct iwl_trans *trans,
 		iftype_data->eht_cap.eht_mcs_nss_supp.bw._320.rx_tx_mcs13_max_nss = 0;
 	}
 
-	if (trans->bw_limit < 160)
+	if (trans->no_160)
 		iftype_data->he_cap.he_cap_elem.phy_cap_info[0] &=
 			~IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_160MHZ_IN_5G;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index 2b341bad7102..ce4954b0d524 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2005-2014, 2018-2023, 2025 Intel Corporation
+ * Copyright (C) 2005-2014, 2018-2023 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -876,7 +876,7 @@ struct iwl_txq {
  *	only valid for discrete (not integrated) NICs
  * @invalid_tx_cmd: invalid TX command buffer
  * @reduced_cap_sku: reduced capability supported SKU
- * @bw_limit: the max bandwidth
+ * @no_160: device not supporting 160 MHz
  * @step_urm: STEP is in URM, no support for MCS>9 in 320 MHz
  * @restart: restart worker data
  * @restart.wk: restart worker
@@ -911,8 +911,7 @@ struct iwl_trans {
 	char hw_id_str[52];
 	u32 sku_id[3];
 	bool reduced_cap_sku;
-	u16 bw_limit;
-	bool step_urm;
+	u8 no_160:1, step_urm:1;
 
 	u8 dsbr_urm_fw_dependent:1,
 	   dsbr_urm_permanent:1;
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index bbdfa51d1645..debeea2b3ae5 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2005-2014, 2018-2025 Intel Corporation
+ * Copyright (C) 2005-2014, 2018-2024 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -552,17 +552,16 @@ MODULE_DEVICE_TABLE(pci, iwl_hw_card_ids);
 EXPORT_SYMBOL_IF_IWLWIFI_KUNIT(iwl_hw_card_ids);
 
 #define _IWL_DEV_INFO(_device, _subdevice, _mac_type, _mac_step, _rf_type, \
-		      _rf_id, _rf_step, _bw_limit, _cores, _cdb, _cfg, _name) \
+		      _rf_id, _rf_step, _no_160, _cores, _cdb, _cfg, _name) \
 	{ .device = (_device), .subdevice = (_subdevice), .cfg = &(_cfg), \
 	  .name = _name, .mac_type = _mac_type, .rf_type = _rf_type, .rf_step = _rf_step, \
-	  .bw_limit = _bw_limit, .cores = _cores, .rf_id = _rf_id, \
+	  .no_160 = _no_160, .cores = _cores, .rf_id = _rf_id, \
 	  .mac_step = _mac_step, .cdb = _cdb, .jacket = IWL_CFG_ANY }
 
 #define IWL_DEV_INFO(_device, _subdevice, _cfg, _name) \
 	_IWL_DEV_INFO(_device, _subdevice, IWL_CFG_ANY, IWL_CFG_ANY,   \
-		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_ANY, \
-		      IWL_CFG_BW_NO_LIM, IWL_CFG_ANY, IWL_CFG_ANY, \
-		      _cfg, _name)
+		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_ANY,  \
+		      IWL_CFG_ANY, _cfg, _name)
 
 VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 #if IS_ENABLED(CONFIG_IWLMVM)
@@ -725,66 +724,66 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_PU, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1, IWL_CFG_ANY,
-		      IWL_CFG_BW_NO_LIM, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
+		      IWL_CFG_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
 		      iwl9560_2ac_cfg_soc, iwl9461_160_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_PU, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1, IWL_CFG_ANY,
-		      80, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
+		      IWL_CFG_NO_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
 		      iwl9560_2ac_cfg_soc, iwl9461_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_PU, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1_DIV, IWL_CFG_ANY,
-		      IWL_CFG_BW_NO_LIM, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
+		      IWL_CFG_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
 		      iwl9560_2ac_cfg_soc, iwl9462_160_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_PU, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1_DIV, IWL_CFG_ANY,
-		      80, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
+		      IWL_CFG_NO_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
 		      iwl9560_2ac_cfg_soc, iwl9462_name),
 
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_PU, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_JF2, IWL_CFG_RF_ID_JF, IWL_CFG_ANY,
-		      IWL_CFG_BW_NO_LIM, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
+		      IWL_CFG_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
 		      iwl9560_2ac_cfg_soc, iwl9560_160_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_PU, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_JF2, IWL_CFG_RF_ID_JF, IWL_CFG_ANY,
-		      80, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
+		      IWL_CFG_NO_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
 		      iwl9560_2ac_cfg_soc, iwl9560_name),
 
 	_IWL_DEV_INFO(0x2526, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_TH, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_TH, IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_BW_NO_LIM, IWL_CFG_CORES_BT_GNSS, IWL_CFG_NO_CDB,
+		      IWL_CFG_160, IWL_CFG_CORES_BT_GNSS, IWL_CFG_NO_CDB,
 		      iwl9260_2ac_cfg, iwl9270_160_name),
 	_IWL_DEV_INFO(0x2526, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_TH, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_TH, IWL_CFG_ANY, IWL_CFG_ANY,
-		      80, IWL_CFG_CORES_BT_GNSS, IWL_CFG_NO_CDB,
+		      IWL_CFG_NO_160, IWL_CFG_CORES_BT_GNSS, IWL_CFG_NO_CDB,
 		      iwl9260_2ac_cfg, iwl9270_name),
 
 	_IWL_DEV_INFO(0x271B, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_TH, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_TH1, IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_BW_NO_LIM, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
+		      IWL_CFG_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
 		      iwl9260_2ac_cfg, iwl9162_160_name),
 	_IWL_DEV_INFO(0x271B, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_TH, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_TH1, IWL_CFG_ANY, IWL_CFG_ANY,
-		      80, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
+		      IWL_CFG_NO_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
 		      iwl9260_2ac_cfg, iwl9162_name),
 
 	_IWL_DEV_INFO(0x2526, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_TH, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_TH, IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_BW_NO_LIM, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
+		      IWL_CFG_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
 		      iwl9260_2ac_cfg, iwl9260_160_name),
 	_IWL_DEV_INFO(0x2526, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_TH, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_TH, IWL_CFG_ANY, IWL_CFG_ANY,
-		      80, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
+		      IWL_CFG_NO_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
 		      iwl9260_2ac_cfg, iwl9260_name),
 
 /* Qu with Jf */
@@ -792,132 +791,132 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_QU, SILICON_B_STEP,
 		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1, IWL_CFG_ANY,
-		      IWL_CFG_BW_NO_LIM, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
+		      IWL_CFG_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
 		      iwl9560_qu_b0_jf_b0_cfg, iwl9461_160_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_QU, SILICON_B_STEP,
 		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1, IWL_CFG_ANY,
-		      80, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
+		      IWL_CFG_NO_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
 		      iwl9560_qu_b0_jf_b0_cfg, iwl9461_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_QU, SILICON_B_STEP,
 		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1_DIV, IWL_CFG_ANY,
-		      IWL_CFG_BW_NO_LIM, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
+		      IWL_CFG_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
 		      iwl9560_qu_b0_jf_b0_cfg, iwl9462_160_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_QU, SILICON_B_STEP,
 		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1_DIV, IWL_CFG_ANY,
-		      80, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
+		      IWL_CFG_NO_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
 		      iwl9560_qu_b0_jf_b0_cfg, iwl9462_name),
 
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_QU, SILICON_B_STEP,
 		      IWL_CFG_RF_TYPE_JF2, IWL_CFG_RF_ID_JF, IWL_CFG_ANY,
-		      IWL_CFG_BW_NO_LIM, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
+		      IWL_CFG_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
 		      iwl9560_qu_b0_jf_b0_cfg, iwl9560_160_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_QU, SILICON_B_STEP,
 		      IWL_CFG_RF_TYPE_JF2, IWL_CFG_RF_ID_JF, IWL_CFG_ANY,
-		      80, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
+		      IWL_CFG_NO_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
 		      iwl9560_qu_b0_jf_b0_cfg, iwl9560_name),
 
 	_IWL_DEV_INFO(IWL_CFG_ANY, 0x1551,
 		      IWL_CFG_MAC_TYPE_QU, SILICON_B_STEP,
 		      IWL_CFG_RF_TYPE_JF2, IWL_CFG_RF_ID_JF, IWL_CFG_ANY,
-		      80, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
+		      IWL_CFG_NO_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
 		      iwl9560_qu_b0_jf_b0_cfg, iwl9560_killer_1550s_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, 0x1552,
 		      IWL_CFG_MAC_TYPE_QU, SILICON_B_STEP,
 		      IWL_CFG_RF_TYPE_JF2, IWL_CFG_RF_ID_JF, IWL_CFG_ANY,
-		      80, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
+		      IWL_CFG_NO_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
 		      iwl9560_qu_b0_jf_b0_cfg, iwl9560_killer_1550i_name),
 
 	/* Qu C step */
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_QU, SILICON_C_STEP,
 		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1, IWL_CFG_ANY,
-		      IWL_CFG_BW_NO_LIM, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
+		      IWL_CFG_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
 		      iwl9560_qu_c0_jf_b0_cfg, iwl9461_160_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_QU, SILICON_C_STEP,
 		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1, IWL_CFG_ANY,
-		      80, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
+		      IWL_CFG_NO_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
 		      iwl9560_qu_c0_jf_b0_cfg, iwl9461_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_QU, SILICON_C_STEP,
 		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1_DIV, IWL_CFG_ANY,
-		      IWL_CFG_BW_NO_LIM, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
+		      IWL_CFG_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
 		      iwl9560_qu_c0_jf_b0_cfg, iwl9462_160_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_QU, SILICON_C_STEP,
 		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1_DIV, IWL_CFG_ANY,
-		      80, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
+		      IWL_CFG_NO_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
 		      iwl9560_qu_c0_jf_b0_cfg, iwl9462_name),
 
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_QU, SILICON_C_STEP,
 		      IWL_CFG_RF_TYPE_JF2, IWL_CFG_RF_ID_JF, IWL_CFG_ANY,
-		      IWL_CFG_BW_NO_LIM, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
+		      IWL_CFG_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
 		      iwl9560_qu_c0_jf_b0_cfg, iwl9560_160_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_QU, SILICON_C_STEP,
 		      IWL_CFG_RF_TYPE_JF2, IWL_CFG_RF_ID_JF, IWL_CFG_ANY,
-		      80, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
+		      IWL_CFG_NO_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
 		      iwl9560_qu_c0_jf_b0_cfg, iwl9560_name),
 
 	_IWL_DEV_INFO(IWL_CFG_ANY, 0x1551,
 		      IWL_CFG_MAC_TYPE_QU, SILICON_C_STEP,
 		      IWL_CFG_RF_TYPE_JF2, IWL_CFG_RF_ID_JF, IWL_CFG_ANY,
-		      IWL_CFG_BW_NO_LIM, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
+		      IWL_CFG_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
 		      iwl9560_qu_c0_jf_b0_cfg, iwl9560_killer_1550s_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, 0x1552,
 		      IWL_CFG_MAC_TYPE_QU, SILICON_C_STEP,
 		      IWL_CFG_RF_TYPE_JF2, IWL_CFG_RF_ID_JF, IWL_CFG_ANY,
-		      80, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
+		      IWL_CFG_NO_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
 		      iwl9560_qu_c0_jf_b0_cfg, iwl9560_killer_1550i_name),
 
 	/* QuZ */
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_QUZ, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1, IWL_CFG_ANY,
-		      IWL_CFG_BW_NO_LIM, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
+		      IWL_CFG_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
 		      iwl9560_quz_a0_jf_b0_cfg, iwl9461_160_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_QUZ, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1, IWL_CFG_ANY,
-		      80, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
+		      IWL_CFG_NO_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
 		      iwl9560_quz_a0_jf_b0_cfg, iwl9461_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_QUZ, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1_DIV, IWL_CFG_ANY,
-		      IWL_CFG_BW_NO_LIM, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
+		      IWL_CFG_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
 		      iwl9560_quz_a0_jf_b0_cfg, iwl9462_160_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_QUZ, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1_DIV, IWL_CFG_ANY,
-		      80, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
+		      IWL_CFG_NO_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
 		      iwl9560_quz_a0_jf_b0_cfg, iwl9462_name),
 
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_QUZ, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_JF2, IWL_CFG_RF_ID_JF, IWL_CFG_ANY,
-		      IWL_CFG_BW_NO_LIM, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
+		      IWL_CFG_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
 		      iwl9560_quz_a0_jf_b0_cfg, iwl9560_160_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_QUZ, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_JF2, IWL_CFG_RF_ID_JF, IWL_CFG_ANY,
-		      80, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
+		      IWL_CFG_NO_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
 		      iwl9560_quz_a0_jf_b0_cfg, iwl9560_name),
 
 	_IWL_DEV_INFO(IWL_CFG_ANY, 0x1551,
 		      IWL_CFG_MAC_TYPE_QUZ, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_JF2, IWL_CFG_RF_ID_JF, IWL_CFG_ANY,
-		      IWL_CFG_BW_NO_LIM, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
+		      IWL_CFG_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
 		      iwl9560_quz_a0_jf_b0_cfg, iwl9560_killer_1550s_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, 0x1552,
 		      IWL_CFG_MAC_TYPE_QUZ, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_JF2, IWL_CFG_RF_ID_JF, IWL_CFG_ANY,
-		      80, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
+		      IWL_CFG_NO_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
 		      iwl9560_quz_a0_jf_b0_cfg, iwl9560_killer_1550i_name),
 
 /* Qu with Hr */
@@ -925,189 +924,189 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_QU, SILICON_B_STEP,
 		      IWL_CFG_RF_TYPE_HR1, IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_BW_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB,
+		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB,
 		      iwl_qu_b0_hr1_b0, iwl_ax101_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_QU, SILICON_B_STEP,
 		      IWL_CFG_RF_TYPE_HR2, IWL_CFG_ANY, IWL_CFG_ANY,
-		      80, IWL_CFG_ANY, IWL_CFG_NO_CDB,
+		      IWL_CFG_NO_160, IWL_CFG_ANY, IWL_CFG_NO_CDB,
 		      iwl_qu_b0_hr_b0, iwl_ax203_name),
 
 	/* Qu C step */
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_QU, SILICON_C_STEP,
 		      IWL_CFG_RF_TYPE_HR1, IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_BW_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB,
+		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB,
 		      iwl_qu_c0_hr1_b0, iwl_ax101_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_QU, SILICON_C_STEP,
 		      IWL_CFG_RF_TYPE_HR2, IWL_CFG_ANY, IWL_CFG_ANY,
-		      80, IWL_CFG_ANY, IWL_CFG_NO_CDB,
+		      IWL_CFG_NO_160, IWL_CFG_ANY, IWL_CFG_NO_CDB,
 		      iwl_qu_c0_hr_b0, iwl_ax203_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_QU, SILICON_C_STEP,
 		      IWL_CFG_RF_TYPE_HR2, IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_BW_NO_LIM, IWL_CFG_ANY, IWL_CFG_NO_CDB,
+		      IWL_CFG_160, IWL_CFG_ANY, IWL_CFG_NO_CDB,
 		      iwl_qu_c0_hr_b0, iwl_ax201_name),
 
 	/* QuZ */
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_QUZ, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_HR1, IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_BW_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB,
+		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB,
 		      iwl_quz_a0_hr1_b0, iwl_ax101_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_QUZ, SILICON_B_STEP,
 		      IWL_CFG_RF_TYPE_HR2, IWL_CFG_ANY, IWL_CFG_ANY,
-		      80, IWL_CFG_ANY, IWL_CFG_NO_CDB,
+		      IWL_CFG_NO_160, IWL_CFG_ANY, IWL_CFG_NO_CDB,
 		      iwl_cfg_quz_a0_hr_b0, iwl_ax203_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_QUZ, SILICON_B_STEP,
 		      IWL_CFG_RF_TYPE_HR2, IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_BW_NO_LIM, IWL_CFG_ANY, IWL_CFG_NO_CDB,
+		      IWL_CFG_160, IWL_CFG_ANY, IWL_CFG_NO_CDB,
 		      iwl_cfg_quz_a0_hr_b0, iwl_ax201_name),
 
 /* Ma */
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_MA, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_HR2, IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_BW_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB,
+		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB,
 		      iwl_cfg_ma, iwl_ax201_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_MA, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_GF, IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_BW_ANY, IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_ANY,
 		      iwl_cfg_ma, iwl_ax211_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_MA, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_FM, IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_BW_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB,
+		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB,
 		      iwl_cfg_ma, iwl_ax231_name),
 
 /* So with Hr */
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_SO, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_HR2, IWL_CFG_ANY, IWL_CFG_ANY,
-		      80, IWL_CFG_ANY, IWL_CFG_NO_CDB,
+		      IWL_CFG_NO_160, IWL_CFG_ANY, IWL_CFG_NO_CDB,
 		      iwl_cfg_so_a0_hr_a0, iwl_ax203_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_SO, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_HR1, IWL_CFG_ANY, IWL_CFG_ANY,
-		      80, IWL_CFG_ANY, IWL_CFG_NO_CDB,
+		      IWL_CFG_NO_160, IWL_CFG_ANY, IWL_CFG_NO_CDB,
 		      iwl_cfg_so_a0_hr_a0, iwl_ax101_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_SO, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_HR2, IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_BW_NO_LIM, IWL_CFG_ANY, IWL_CFG_NO_CDB,
+		      IWL_CFG_160, IWL_CFG_ANY, IWL_CFG_NO_CDB,
 		      iwl_cfg_so_a0_hr_a0, iwl_ax201_name),
 
 /* So-F with Hr */
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_SOF, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_HR2, IWL_CFG_ANY, IWL_CFG_ANY,
-		      80, IWL_CFG_ANY, IWL_CFG_NO_CDB,
+		      IWL_CFG_NO_160, IWL_CFG_ANY, IWL_CFG_NO_CDB,
 		      iwl_cfg_so_a0_hr_a0, iwl_ax203_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_SOF, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_HR1, IWL_CFG_ANY, IWL_CFG_ANY,
-		      80, IWL_CFG_ANY, IWL_CFG_NO_CDB,
+		      IWL_CFG_NO_160, IWL_CFG_ANY, IWL_CFG_NO_CDB,
 		      iwl_cfg_so_a0_hr_a0, iwl_ax101_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_SOF, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_HR2, IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_BW_NO_LIM, IWL_CFG_ANY, IWL_CFG_NO_CDB,
+		      IWL_CFG_160, IWL_CFG_ANY, IWL_CFG_NO_CDB,
 		      iwl_cfg_so_a0_hr_a0, iwl_ax201_name),
 
 /* So-F with Gf */
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_SOF, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_GF, IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_BW_NO_LIM, IWL_CFG_ANY, IWL_CFG_NO_CDB,
+		      IWL_CFG_160, IWL_CFG_ANY, IWL_CFG_NO_CDB,
 		      iwlax211_2ax_cfg_so_gf_a0, iwl_ax211_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_SOF, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_GF, IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_BW_NO_LIM, IWL_CFG_ANY, IWL_CFG_CDB,
+		      IWL_CFG_160, IWL_CFG_ANY, IWL_CFG_CDB,
 		      iwlax411_2ax_cfg_so_gf4_a0, iwl_ax411_name),
 
 /* SoF with JF2 */
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_SOF, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_JF2, IWL_CFG_RF_ID_JF, IWL_CFG_ANY,
-		      IWL_CFG_BW_NO_LIM, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
+		      IWL_CFG_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
 		      iwlax210_2ax_cfg_so_jf_b0, iwl9560_160_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_SOF, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_JF2, IWL_CFG_RF_ID_JF, IWL_CFG_ANY,
-		      80, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
+		      IWL_CFG_NO_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
 		      iwlax210_2ax_cfg_so_jf_b0, iwl9560_name),
 
 /* SoF with JF */
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_SOF, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1, IWL_CFG_ANY,
-		      IWL_CFG_BW_NO_LIM, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
+		      IWL_CFG_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
 		      iwlax210_2ax_cfg_so_jf_b0, iwl9461_160_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_SOF, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1_DIV, IWL_CFG_ANY,
-		      IWL_CFG_BW_NO_LIM, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
+		      IWL_CFG_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
 		      iwlax210_2ax_cfg_so_jf_b0, iwl9462_160_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_SOF, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1, IWL_CFG_ANY,
-		      80, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
+		      IWL_CFG_NO_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
 		      iwlax210_2ax_cfg_so_jf_b0, iwl9461_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_SOF, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1_DIV, IWL_CFG_ANY,
-		      80, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
+		      IWL_CFG_NO_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
 		      iwlax210_2ax_cfg_so_jf_b0, iwl9462_name),
 
 /* So with GF */
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_SO, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_GF, IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_BW_NO_LIM, IWL_CFG_ANY, IWL_CFG_NO_CDB,
+		      IWL_CFG_160, IWL_CFG_ANY, IWL_CFG_NO_CDB,
 		      iwlax211_2ax_cfg_so_gf_a0, iwl_ax211_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_SO, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_GF, IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_BW_NO_LIM, IWL_CFG_ANY, IWL_CFG_CDB,
+		      IWL_CFG_160, IWL_CFG_ANY, IWL_CFG_CDB,
 		      iwlax411_2ax_cfg_so_gf4_a0, iwl_ax411_name),
 
 /* So with JF2 */
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_SO, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_JF2, IWL_CFG_RF_ID_JF, IWL_CFG_ANY,
-		      IWL_CFG_BW_NO_LIM, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
+		      IWL_CFG_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
 		      iwlax210_2ax_cfg_so_jf_b0, iwl9560_160_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_SO, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_JF2, IWL_CFG_RF_ID_JF, IWL_CFG_ANY,
-		      80, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
+		      IWL_CFG_NO_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
 		      iwlax210_2ax_cfg_so_jf_b0, iwl9560_name),
 
 /* So with JF */
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_SO, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1, IWL_CFG_ANY,
-		      IWL_CFG_BW_NO_LIM, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
+		      IWL_CFG_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
 		      iwlax210_2ax_cfg_so_jf_b0, iwl9461_160_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_SO, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1_DIV, IWL_CFG_ANY,
-		      IWL_CFG_BW_NO_LIM, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
+		      IWL_CFG_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
 		      iwlax210_2ax_cfg_so_jf_b0, iwl9462_160_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_SO, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1, IWL_CFG_ANY,
-		      80, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
+		      IWL_CFG_NO_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
 		      iwlax210_2ax_cfg_so_jf_b0, iwl9461_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_SO, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1_DIV, IWL_CFG_ANY,
-		      80, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
+		      IWL_CFG_NO_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
 		      iwlax210_2ax_cfg_so_jf_b0, iwl9462_name),
 
 #endif /* CONFIG_IWLMVM */
@@ -1116,13 +1115,13 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_BZ, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_HR2, IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_BW_ANY, IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_ANY,
 		      iwl_cfg_bz, iwl_ax201_name),
 
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_BZ, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_GF, IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_BW_ANY, IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_ANY,
 		      iwl_cfg_bz, iwl_ax211_name),
 
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
@@ -1134,104 +1133,104 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_BZ, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_WH, IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_BW_ANY, IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_ANY,
 		      iwl_cfg_bz, iwl_wh_name),
 
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_BZ_W, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_HR2, IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_BW_ANY, IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_ANY,
 		      iwl_cfg_bz, iwl_ax201_name),
 
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_BZ_W, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_GF, IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_BW_ANY, IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_ANY,
 		      iwl_cfg_bz, iwl_ax211_name),
 
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_BZ_W, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_FM, IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_BW_ANY, IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_ANY,
 		      iwl_cfg_bz, iwl_fm_name),
 
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_BZ_W, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_WH, IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_BW_ANY, IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_ANY,
 		      iwl_cfg_bz, iwl_wh_name),
 
 /* Ga (Gl) */
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_GL, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_FM, IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_BW_NO_LIM, IWL_CFG_ANY, IWL_CFG_NO_CDB,
+		      IWL_CFG_320, IWL_CFG_ANY, IWL_CFG_NO_CDB,
 		      iwl_cfg_gl, iwl_gl_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_GL, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_FM, IWL_CFG_ANY, IWL_CFG_ANY,
-		      160, IWL_CFG_ANY, IWL_CFG_NO_CDB,
+		      IWL_CFG_NO_320, IWL_CFG_ANY, IWL_CFG_NO_CDB,
 		      iwl_cfg_gl, iwl_mtp_name),
 
 /* Sc */
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_SC, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_GF, IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_BW_ANY, IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_ANY,
 		      iwl_cfg_sc, iwl_ax211_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_SC, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_FM, IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_BW_ANY, IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_ANY,
 		      iwl_cfg_sc, iwl_fm_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_SC, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_WH, IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_BW_ANY, IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_ANY,
 		      iwl_cfg_sc, iwl_wh_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_SC2, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_GF, IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_BW_ANY, IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_ANY,
 		      iwl_cfg_sc2, iwl_ax211_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_SC2, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_FM, IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_BW_ANY, IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_ANY,
 		      iwl_cfg_sc2, iwl_fm_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_SC2, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_WH, IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_BW_ANY, IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_ANY,
 		      iwl_cfg_sc2, iwl_wh_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_SC2F, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_GF, IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_BW_ANY, IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_ANY,
 		      iwl_cfg_sc2f, iwl_ax211_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_SC2F, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_FM, IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_BW_ANY, IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_ANY,
 		      iwl_cfg_sc2f, iwl_fm_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_SC2F, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_WH, IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_BW_ANY, IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_ANY,
 		      iwl_cfg_sc2f, iwl_wh_name),
 
 /* Dr */
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_DR, IWL_CFG_ANY,
 		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_BW_ANY, IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_ANY,
 		      iwl_cfg_dr, iwl_dr_name),
 
 /* Br */
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_BR, IWL_CFG_ANY,
 		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_BW_ANY, IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_ANY,
 		      iwl_cfg_br, iwl_br_name),
 #endif /* CONFIG_IWLMLD */
 };
@@ -1383,7 +1382,7 @@ static int map_crf_id(struct iwl_trans *iwl_trans)
 VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info *
 iwl_pci_find_dev_info(u16 device, u16 subsystem_device,
 		      u16 mac_type, u8 mac_step, u16 rf_type, u8 cdb,
-		      u8 jacket, u8 rf_id, u8 bw_limit, u8 cores, u8 rf_step)
+		      u8 jacket, u8 rf_id, u8 no_160, u8 cores, u8 rf_step)
 {
 	int num_devices = ARRAY_SIZE(iwl_dev_info_table);
 	int i;
@@ -1426,15 +1425,8 @@ iwl_pci_find_dev_info(u16 device, u16 subsystem_device,
 		    dev_info->rf_id != rf_id)
 			continue;
 
-		/*
-		 * Check that bw_limit have the same "boolean" value since
-		 * IWL_SUBDEVICE_BW_LIM can only return a boolean value and
-		 * dev_info->bw_limit encodes a non-boolean value.
-		 * dev_info->bw_limit == IWL_CFG_BW_NO_LIM must be equal to
-		 * !bw_limit to have a match.
-		 */
-		if (dev_info->bw_limit != IWL_CFG_BW_ANY &&
-		    (dev_info->bw_limit == IWL_CFG_BW_NO_LIM) == !!bw_limit)
+		if (dev_info->no_160 != (u8)IWL_CFG_ANY &&
+		    dev_info->no_160 != no_160)
 			continue;
 
 		if (dev_info->cores != (u8)IWL_CFG_ANY &&
@@ -1572,13 +1564,13 @@ static int iwl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 					 CSR_HW_RFID_IS_CDB(iwl_trans->hw_rf_id),
 					 CSR_HW_RFID_IS_JACKET(iwl_trans->hw_rf_id),
 					 IWL_SUBDEVICE_RF_ID(pdev->subsystem_device),
-					 IWL_SUBDEVICE_BW_LIM(pdev->subsystem_device),
+					 IWL_SUBDEVICE_NO_160(pdev->subsystem_device),
 					 IWL_SUBDEVICE_CORES(pdev->subsystem_device),
 					 CSR_HW_RFID_STEP(iwl_trans->hw_rf_id));
 	if (dev_info) {
 		iwl_trans->cfg = dev_info->cfg;
 		iwl_trans->name = dev_info->name;
-		iwl_trans->bw_limit = dev_info->bw_limit;
+		iwl_trans->no_160 = dev_info->no_160 == IWL_CFG_NO_160;
 	}
 
 #if IS_ENABLED(CONFIG_IWLMVM)
diff --git a/drivers/net/wireless/intel/iwlwifi/tests/devinfo.c b/drivers/net/wireless/intel/iwlwifi/tests/devinfo.c
index 7ef5e89c6af2..d0bda23c628a 100644
--- a/drivers/net/wireless/intel/iwlwifi/tests/devinfo.c
+++ b/drivers/net/wireless/intel/iwlwifi/tests/devinfo.c
@@ -2,7 +2,7 @@
 /*
  * KUnit tests for the iwlwifi device info table
  *
- * Copyright (C) 2023-2025 Intel Corporation
+ * Copyright (C) 2023-2024 Intel Corporation
  */
 #include <kunit/test.h>
 #include <linux/pci.h>
@@ -13,9 +13,9 @@ MODULE_IMPORT_NS("EXPORTED_FOR_KUNIT_TESTING");
 
 static void iwl_pci_print_dev_info(const char *pfx, const struct iwl_dev_info *di)
 {
-	printk(KERN_DEBUG "%sdev=%.4x,subdev=%.4x,mac_type=%.4x,mac_step=%.4x,rf_type=%.4x,cdb=%d,jacket=%d,rf_id=%.2x,bw_limit=%d,cores=%.2x\n",
+	printk(KERN_DEBUG "%sdev=%.4x,subdev=%.4x,mac_type=%.4x,mac_step=%.4x,rf_type=%.4x,cdb=%d,jacket=%d,rf_id=%.2x,no_160=%d,cores=%.2x\n",
 	       pfx, di->device, di->subdevice, di->mac_type, di->mac_step,
-	       di->rf_type, di->cdb, di->jacket, di->rf_id, di->bw_limit,
+	       di->rf_type, di->cdb, di->jacket, di->rf_id, di->no_160,
 	       di->cores);
 }
 
@@ -31,13 +31,8 @@ static void devinfo_table_order(struct kunit *test)
 					    di->mac_type, di->mac_step,
 					    di->rf_type, di->cdb,
 					    di->jacket, di->rf_id,
-					    di->bw_limit != IWL_CFG_BW_NO_LIM,
-					    di->cores, di->rf_step);
-		if (!ret) {
-			iwl_pci_print_dev_info("No entry found for: ", di);
-			KUNIT_FAIL(test,
-				   "No entry found for entry at index %d\n", idx);
-		} else if (ret != di) {
+					    di->no_160, di->cores, di->rf_step);
+		if (ret != di) {
 			iwl_pci_print_dev_info("searched: ", di);
 			iwl_pci_print_dev_info("found:    ", ret);
 			KUNIT_FAIL(test,
-- 
2.34.1


