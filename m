Return-Path: <linux-wireless+bounces-18531-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97DAFA28B0A
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Feb 2025 13:57:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26BE83A3650
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Feb 2025 12:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 851E04C76;
	Wed,  5 Feb 2025 12:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z1G9wpBm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74B47BAEC
	for <linux-wireless@vger.kernel.org>; Wed,  5 Feb 2025 12:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738760190; cv=none; b=hKZGurvACcUGukrvakLsRGfpOGOfK0kHLp9AEvQyU/qXyKE8ABj5VB8k3OLM/qfs0rWjuU6h0Rd7FBvgH27FdR6a9VXliZ2JeU2oYGz21/5ufZo0eWQQ/PaI3UgVqxuyXrtvfyxQ/c06Ch5pLImUgrdNtI1tr9B2Gkv9Or87Efs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738760190; c=relaxed/simple;
	bh=IgaubOUcxshOi67mujPs0Xck1QkheoRGnMel8wcUMa8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fsQcJjrBu5bYbfFo7E/wKvazY7dJcCM0XJhCrc6yWtNoojbK2Fb0Tru+euuxvg4zSYWPWD+OlKtNd1fLf/kxOOR7WOOnbJb1kH9SrpIyFBSww5FU1jfPmOL+eaeApgkJuDg5XZizAQGhfmiLM2+ld94JoHGCKvfAFveH5EKhhWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z1G9wpBm; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738760188; x=1770296188;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IgaubOUcxshOi67mujPs0Xck1QkheoRGnMel8wcUMa8=;
  b=Z1G9wpBmN0hsf0/hf3T2X2hPy7QIEE07Tj8Jj/Q9FdKjG7+ENamqy/M4
   7sgw1HloZp+1iiRYSgKeOU5EFqqPHLRx5uLRw7iFlYJrxtNRLF0N91l3E
   Iwgi6hD4ERQTT/BcTBZ8gvokNrehLaFrJlOwjTyd1UcfGF+VKUdH28+MB
   CxyWFADPxkdRboN6sq2XgnJQ6fA/7z4fQXYjC6GphZyoABE88Y26lwrS/
   UlTD88WOAzdgT8Xb8Yi13bdRlcVDoDxofVlrKRy9U6j8BpvoB7nOaQ0F+
   65jBp6zZ7JSQQcSm3PXdcESqccTjdlWTGhgOuZd+8Gy8Vovtbcttx3ho2
   A==;
X-CSE-ConnectionGUID: C73ZuWS9T+u1+Tuv12pEpw==
X-CSE-MsgGUID: pQIRIah0R1m79e5f57k3Tw==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="42159211"
X-IronPort-AV: E=Sophos;i="6.13,261,1732608000"; 
   d="scan'208";a="42159211"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 04:56:28 -0800
X-CSE-ConnectionGUID: rnKDNpIfQYm+9xIc3jxEEw==
X-CSE-MsgGUID: GF8bPQaNTWiXLK2iL4YwOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="110745488"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 04:56:26 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 13/19] wifi: iwlwifi: make no_160 more generic
Date: Wed,  5 Feb 2025 14:55:42 +0200
Message-Id: <20250205145347.1ba406c538a5.I6e24123f60a764aedfeaaac8768c26e136c320cf@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250205125548.1963070-1-miriam.rachel.korenblit@intel.com>
References: <20250205125548.1963070-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

We'll have devices that are EHT capable but don't support 320 MHz and
those devices look like the 320 MHz capable devices, but have distinct
subsystem ID.
We already had the same type of differentiation for HE devices that
support 160 MHz or not.
Enhance that mechanism and now the _IWL_DEV_INFO macro gets an
indication whether the bandwidth should be limited for that specific
device.
The subsystem ID gives a binary answer about the bandwidth limitation
and iwl_pci_find_dev_info() compares this to the list of _IWL_DEV_INFO
entries.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/iwl-config.h   |  15 +-
 .../wireless/intel/iwlwifi/iwl-nvm-parse.c    |   4 +-
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |   7 +-
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 194 +++++++++---------
 .../wireless/intel/iwlwifi/tests/devinfo.c    |  15 +-
 5 files changed, 123 insertions(+), 112 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index 758f8e70050a..8fe5129224b0 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -2,7 +2,7 @@
 /*
  * Copyright (C) 2005-2014, 2018-2021 Intel Corporation
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
- * Copyright (C) 2018-2024 Intel Corporation
+ * Copyright (C) 2018-2025 Intel Corporation
  */
 #ifndef __IWL_CONFIG_H__
 #define __IWL_CONFIG_H__
@@ -451,11 +451,8 @@ struct iwl_cfg {
 #define IWL_CFG_RF_ID_HR		0x7
 #define IWL_CFG_RF_ID_HR1		0x4
 
-#define IWL_CFG_NO_160			0x1
-#define IWL_CFG_160			0x0
-
-#define IWL_CFG_NO_320			0x1
-#define IWL_CFG_320			0x0
+#define IWL_CFG_BW_NO_LIM		(U16_MAX - 1)
+#define IWL_CFG_BW_ANY			U16_MAX
 
 #define IWL_CFG_CORES_BT		0x0
 #define IWL_CFG_CORES_BT_GNSS		0x5
@@ -467,7 +464,7 @@ struct iwl_cfg {
 #define IWL_CFG_IS_JACKET		0x1
 
 #define IWL_SUBDEVICE_RF_ID(subdevice)	((u16)((subdevice) & 0x00F0) >> 4)
-#define IWL_SUBDEVICE_NO_160(subdevice)	((u16)((subdevice) & 0x0200) >> 9)
+#define IWL_SUBDEVICE_BW_LIM(subdevice)	((u16)((subdevice) & 0x0200) >> 9)
 #define IWL_SUBDEVICE_CORES(subdevice)	((u16)((subdevice) & 0x1C00) >> 10)
 
 struct iwl_dev_info {
@@ -475,10 +472,10 @@ struct iwl_dev_info {
 	u16 subdevice;
 	u16 mac_type;
 	u16 rf_type;
+	u16 bw_limit;
 	u8 mac_step;
 	u8 rf_step;
 	u8 rf_id;
-	u8 no_160;
 	u8 cores;
 	u8 cdb;
 	u8 jacket;
@@ -492,7 +489,7 @@ extern const unsigned int iwl_dev_info_table_size;
 const struct iwl_dev_info *
 iwl_pci_find_dev_info(u16 device, u16 subsystem_device,
 		      u16 mac_type, u8 mac_step, u16 rf_type, u8 cdb,
-		      u8 jacket, u8 rf_id, u8 no_160, u8 cores, u8 rf_step);
+		      u8 jacket, u8 rf_id, u8 bw_limit, u8 cores, u8 rf_step);
 extern const struct pci_device_id iwl_hw_card_ids[];
 #endif
 
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
index c381511e9ec6..08269168b2fa 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2005-2014, 2018-2023 Intel Corporation
+ * Copyright (C) 2005-2014, 2018-2023, 2025 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -1094,7 +1094,7 @@ iwl_nvm_fixup_sband_iftd(struct iwl_trans *trans,
 		iftype_data->eht_cap.eht_mcs_nss_supp.bw._320.rx_tx_mcs13_max_nss = 0;
 	}
 
-	if (trans->no_160)
+	if (trans->bw_limit < 160)
 		iftype_data->he_cap.he_cap_elem.phy_cap_info[0] &=
 			~IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_160MHZ_IN_5G;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index f6234065dbdd..3561ff8483f2 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2005-2014, 2018-2023 Intel Corporation
+ * Copyright (C) 2005-2014, 2018-2023, 2025 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -876,7 +876,7 @@ struct iwl_txq {
  *	only valid for discrete (not integrated) NICs
  * @invalid_tx_cmd: invalid TX command buffer
  * @reduced_cap_sku: reduced capability supported SKU
- * @no_160: device not supporting 160 MHz
+ * @bw_limit: the max bandwidth
  * @step_urm: STEP is in URM, no support for MCS>9 in 320 MHz
  * @restart: restart worker data
  * @restart.wk: restart worker
@@ -910,7 +910,8 @@ struct iwl_trans {
 	char hw_id_str[52];
 	u32 sku_id[3];
 	bool reduced_cap_sku;
-	u8 no_160:1, step_urm:1;
+	u16 bw_limit;
+	bool step_urm;
 
 	u8 dsbr_urm_fw_dependent:1,
 	   dsbr_urm_permanent:1;
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index e0b657b2f74b..346a5c178dc2 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2005-2014, 2018-2024 Intel Corporation
+ * Copyright (C) 2005-2014, 2018-2025 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -551,16 +551,17 @@ MODULE_DEVICE_TABLE(pci, iwl_hw_card_ids);
 EXPORT_SYMBOL_IF_IWLWIFI_KUNIT(iwl_hw_card_ids);
 
 #define _IWL_DEV_INFO(_device, _subdevice, _mac_type, _mac_step, _rf_type, \
-		      _rf_id, _rf_step, _no_160, _cores, _cdb, _cfg, _name) \
+		      _rf_id, _rf_step, _bw_limit, _cores, _cdb, _cfg, _name) \
 	{ .device = (_device), .subdevice = (_subdevice), .cfg = &(_cfg), \
 	  .name = _name, .mac_type = _mac_type, .rf_type = _rf_type, .rf_step = _rf_step, \
-	  .no_160 = _no_160, .cores = _cores, .rf_id = _rf_id, \
+	  .bw_limit = _bw_limit, .cores = _cores, .rf_id = _rf_id, \
 	  .mac_step = _mac_step, .cdb = _cdb, .jacket = IWL_CFG_ANY }
 
 #define IWL_DEV_INFO(_device, _subdevice, _cfg, _name) \
 	_IWL_DEV_INFO(_device, _subdevice, IWL_CFG_ANY, IWL_CFG_ANY,   \
-		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_ANY,  \
-		      IWL_CFG_ANY, _cfg, _name)
+		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_ANY, \
+		      IWL_CFG_BW_NO_LIM, IWL_CFG_ANY, IWL_CFG_ANY, \
+		      _cfg, _name)
 
 VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 #if IS_ENABLED(CONFIG_IWLMVM)
@@ -723,66 +724,66 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_PU, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1, IWL_CFG_ANY,
-		      IWL_CFG_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
+		      IWL_CFG_BW_NO_LIM, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
 		      iwl9560_2ac_cfg_soc, iwl9461_160_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_PU, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1, IWL_CFG_ANY,
-		      IWL_CFG_NO_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
+		      80, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
 		      iwl9560_2ac_cfg_soc, iwl9461_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_PU, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1_DIV, IWL_CFG_ANY,
-		      IWL_CFG_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
+		      IWL_CFG_BW_NO_LIM, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
 		      iwl9560_2ac_cfg_soc, iwl9462_160_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_PU, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1_DIV, IWL_CFG_ANY,
-		      IWL_CFG_NO_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
+		      80, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
 		      iwl9560_2ac_cfg_soc, iwl9462_name),
 
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_PU, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_JF2, IWL_CFG_RF_ID_JF, IWL_CFG_ANY,
-		      IWL_CFG_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
+		      IWL_CFG_BW_NO_LIM, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
 		      iwl9560_2ac_cfg_soc, iwl9560_160_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_PU, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_JF2, IWL_CFG_RF_ID_JF, IWL_CFG_ANY,
-		      IWL_CFG_NO_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
+		      80, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
 		      iwl9560_2ac_cfg_soc, iwl9560_name),
 
 	_IWL_DEV_INFO(0x2526, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_TH, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_TH, IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_160, IWL_CFG_CORES_BT_GNSS, IWL_CFG_NO_CDB,
+		      IWL_CFG_BW_NO_LIM, IWL_CFG_CORES_BT_GNSS, IWL_CFG_NO_CDB,
 		      iwl9260_2ac_cfg, iwl9270_160_name),
 	_IWL_DEV_INFO(0x2526, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_TH, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_TH, IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_NO_160, IWL_CFG_CORES_BT_GNSS, IWL_CFG_NO_CDB,
+		      80, IWL_CFG_CORES_BT_GNSS, IWL_CFG_NO_CDB,
 		      iwl9260_2ac_cfg, iwl9270_name),
 
 	_IWL_DEV_INFO(0x271B, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_TH, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_TH1, IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
+		      IWL_CFG_BW_NO_LIM, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
 		      iwl9260_2ac_cfg, iwl9162_160_name),
 	_IWL_DEV_INFO(0x271B, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_TH, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_TH1, IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_NO_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
+		      80, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
 		      iwl9260_2ac_cfg, iwl9162_name),
 
 	_IWL_DEV_INFO(0x2526, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_TH, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_TH, IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
+		      IWL_CFG_BW_NO_LIM, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
 		      iwl9260_2ac_cfg, iwl9260_160_name),
 	_IWL_DEV_INFO(0x2526, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_TH, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_TH, IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_NO_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
+		      80, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
 		      iwl9260_2ac_cfg, iwl9260_name),
 
 /* Qu with Jf */
@@ -790,132 +791,132 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_QU, SILICON_B_STEP,
 		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1, IWL_CFG_ANY,
-		      IWL_CFG_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
+		      IWL_CFG_BW_NO_LIM, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
 		      iwl9560_qu_b0_jf_b0_cfg, iwl9461_160_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_QU, SILICON_B_STEP,
 		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1, IWL_CFG_ANY,
-		      IWL_CFG_NO_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
+		      80, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
 		      iwl9560_qu_b0_jf_b0_cfg, iwl9461_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_QU, SILICON_B_STEP,
 		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1_DIV, IWL_CFG_ANY,
-		      IWL_CFG_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
+		      IWL_CFG_BW_NO_LIM, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
 		      iwl9560_qu_b0_jf_b0_cfg, iwl9462_160_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_QU, SILICON_B_STEP,
 		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1_DIV, IWL_CFG_ANY,
-		      IWL_CFG_NO_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
+		      80, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
 		      iwl9560_qu_b0_jf_b0_cfg, iwl9462_name),
 
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_QU, SILICON_B_STEP,
 		      IWL_CFG_RF_TYPE_JF2, IWL_CFG_RF_ID_JF, IWL_CFG_ANY,
-		      IWL_CFG_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
+		      IWL_CFG_BW_NO_LIM, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
 		      iwl9560_qu_b0_jf_b0_cfg, iwl9560_160_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_QU, SILICON_B_STEP,
 		      IWL_CFG_RF_TYPE_JF2, IWL_CFG_RF_ID_JF, IWL_CFG_ANY,
-		      IWL_CFG_NO_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
+		      80, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
 		      iwl9560_qu_b0_jf_b0_cfg, iwl9560_name),
 
 	_IWL_DEV_INFO(IWL_CFG_ANY, 0x1551,
 		      IWL_CFG_MAC_TYPE_QU, SILICON_B_STEP,
 		      IWL_CFG_RF_TYPE_JF2, IWL_CFG_RF_ID_JF, IWL_CFG_ANY,
-		      IWL_CFG_NO_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
+		      80, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
 		      iwl9560_qu_b0_jf_b0_cfg, iwl9560_killer_1550s_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, 0x1552,
 		      IWL_CFG_MAC_TYPE_QU, SILICON_B_STEP,
 		      IWL_CFG_RF_TYPE_JF2, IWL_CFG_RF_ID_JF, IWL_CFG_ANY,
-		      IWL_CFG_NO_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
+		      80, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
 		      iwl9560_qu_b0_jf_b0_cfg, iwl9560_killer_1550i_name),
 
 	/* Qu C step */
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_QU, SILICON_C_STEP,
 		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1, IWL_CFG_ANY,
-		      IWL_CFG_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
+		      IWL_CFG_BW_NO_LIM, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
 		      iwl9560_qu_c0_jf_b0_cfg, iwl9461_160_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_QU, SILICON_C_STEP,
 		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1, IWL_CFG_ANY,
-		      IWL_CFG_NO_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
+		      80, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
 		      iwl9560_qu_c0_jf_b0_cfg, iwl9461_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_QU, SILICON_C_STEP,
 		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1_DIV, IWL_CFG_ANY,
-		      IWL_CFG_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
+		      IWL_CFG_BW_NO_LIM, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
 		      iwl9560_qu_c0_jf_b0_cfg, iwl9462_160_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_QU, SILICON_C_STEP,
 		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1_DIV, IWL_CFG_ANY,
-		      IWL_CFG_NO_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
+		      80, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
 		      iwl9560_qu_c0_jf_b0_cfg, iwl9462_name),
 
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_QU, SILICON_C_STEP,
 		      IWL_CFG_RF_TYPE_JF2, IWL_CFG_RF_ID_JF, IWL_CFG_ANY,
-		      IWL_CFG_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
+		      IWL_CFG_BW_NO_LIM, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
 		      iwl9560_qu_c0_jf_b0_cfg, iwl9560_160_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_QU, SILICON_C_STEP,
 		      IWL_CFG_RF_TYPE_JF2, IWL_CFG_RF_ID_JF, IWL_CFG_ANY,
-		      IWL_CFG_NO_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
+		      80, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
 		      iwl9560_qu_c0_jf_b0_cfg, iwl9560_name),
 
 	_IWL_DEV_INFO(IWL_CFG_ANY, 0x1551,
 		      IWL_CFG_MAC_TYPE_QU, SILICON_C_STEP,
 		      IWL_CFG_RF_TYPE_JF2, IWL_CFG_RF_ID_JF, IWL_CFG_ANY,
-		      IWL_CFG_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
+		      IWL_CFG_BW_NO_LIM, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
 		      iwl9560_qu_c0_jf_b0_cfg, iwl9560_killer_1550s_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, 0x1552,
 		      IWL_CFG_MAC_TYPE_QU, SILICON_C_STEP,
 		      IWL_CFG_RF_TYPE_JF2, IWL_CFG_RF_ID_JF, IWL_CFG_ANY,
-		      IWL_CFG_NO_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
+		      80, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
 		      iwl9560_qu_c0_jf_b0_cfg, iwl9560_killer_1550i_name),
 
 	/* QuZ */
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_QUZ, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1, IWL_CFG_ANY,
-		      IWL_CFG_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
+		      IWL_CFG_BW_NO_LIM, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
 		      iwl9560_quz_a0_jf_b0_cfg, iwl9461_160_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_QUZ, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1, IWL_CFG_ANY,
-		      IWL_CFG_NO_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
+		      80, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
 		      iwl9560_quz_a0_jf_b0_cfg, iwl9461_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_QUZ, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1_DIV, IWL_CFG_ANY,
-		      IWL_CFG_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
+		      IWL_CFG_BW_NO_LIM, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
 		      iwl9560_quz_a0_jf_b0_cfg, iwl9462_160_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_QUZ, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1_DIV, IWL_CFG_ANY,
-		      IWL_CFG_NO_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
+		      80, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
 		      iwl9560_quz_a0_jf_b0_cfg, iwl9462_name),
 
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_QUZ, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_JF2, IWL_CFG_RF_ID_JF, IWL_CFG_ANY,
-		      IWL_CFG_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
+		      IWL_CFG_BW_NO_LIM, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
 		      iwl9560_quz_a0_jf_b0_cfg, iwl9560_160_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_QUZ, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_JF2, IWL_CFG_RF_ID_JF, IWL_CFG_ANY,
-		      IWL_CFG_NO_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
+		      80, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
 		      iwl9560_quz_a0_jf_b0_cfg, iwl9560_name),
 
 	_IWL_DEV_INFO(IWL_CFG_ANY, 0x1551,
 		      IWL_CFG_MAC_TYPE_QUZ, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_JF2, IWL_CFG_RF_ID_JF, IWL_CFG_ANY,
-		      IWL_CFG_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
+		      IWL_CFG_BW_NO_LIM, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
 		      iwl9560_quz_a0_jf_b0_cfg, iwl9560_killer_1550s_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, 0x1552,
 		      IWL_CFG_MAC_TYPE_QUZ, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_JF2, IWL_CFG_RF_ID_JF, IWL_CFG_ANY,
-		      IWL_CFG_NO_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
+		      80, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
 		      iwl9560_quz_a0_jf_b0_cfg, iwl9560_killer_1550i_name),
 
 /* Qu with Hr */
@@ -923,202 +924,202 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_QU, SILICON_B_STEP,
 		      IWL_CFG_RF_TYPE_HR1, IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB,
+		      IWL_CFG_BW_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB,
 		      iwl_qu_b0_hr1_b0, iwl_ax101_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_QU, SILICON_B_STEP,
 		      IWL_CFG_RF_TYPE_HR2, IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_NO_160, IWL_CFG_ANY, IWL_CFG_NO_CDB,
+		      80, IWL_CFG_ANY, IWL_CFG_NO_CDB,
 		      iwl_qu_b0_hr_b0, iwl_ax203_name),
 
 	/* Qu C step */
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_QU, SILICON_C_STEP,
 		      IWL_CFG_RF_TYPE_HR1, IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB,
+		      IWL_CFG_BW_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB,
 		      iwl_qu_c0_hr1_b0, iwl_ax101_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_QU, SILICON_C_STEP,
 		      IWL_CFG_RF_TYPE_HR2, IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_NO_160, IWL_CFG_ANY, IWL_CFG_NO_CDB,
+		      80, IWL_CFG_ANY, IWL_CFG_NO_CDB,
 		      iwl_qu_c0_hr_b0, iwl_ax203_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_QU, SILICON_C_STEP,
 		      IWL_CFG_RF_TYPE_HR2, IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_160, IWL_CFG_ANY, IWL_CFG_NO_CDB,
+		      IWL_CFG_BW_NO_LIM, IWL_CFG_ANY, IWL_CFG_NO_CDB,
 		      iwl_qu_c0_hr_b0, iwl_ax201_name),
 
 	/* QuZ */
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_QUZ, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_HR1, IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB,
+		      IWL_CFG_BW_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB,
 		      iwl_quz_a0_hr1_b0, iwl_ax101_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_QUZ, SILICON_B_STEP,
 		      IWL_CFG_RF_TYPE_HR2, IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_NO_160, IWL_CFG_ANY, IWL_CFG_NO_CDB,
+		      80, IWL_CFG_ANY, IWL_CFG_NO_CDB,
 		      iwl_cfg_quz_a0_hr_b0, iwl_ax203_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_QUZ, SILICON_B_STEP,
 		      IWL_CFG_RF_TYPE_HR2, IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_160, IWL_CFG_ANY, IWL_CFG_NO_CDB,
+		      IWL_CFG_BW_NO_LIM, IWL_CFG_ANY, IWL_CFG_NO_CDB,
 		      iwl_cfg_quz_a0_hr_b0, iwl_ax201_name),
 
 /* Ma */
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_MA, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_HR2, IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB,
+		      IWL_CFG_BW_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB,
 		      iwl_cfg_ma, iwl_ax201_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_MA, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_GF, IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_BW_ANY, IWL_CFG_ANY, IWL_CFG_ANY,
 		      iwl_cfg_ma, iwl_ax211_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_MA, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_FM, IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB,
+		      IWL_CFG_BW_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB,
 		      iwl_cfg_ma, iwl_ax231_name),
 
 /* So with Hr */
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_SO, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_HR2, IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_NO_160, IWL_CFG_ANY, IWL_CFG_NO_CDB,
+		      80, IWL_CFG_ANY, IWL_CFG_NO_CDB,
 		      iwl_cfg_so_a0_hr_a0, iwl_ax203_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_SO, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_HR1, IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_NO_160, IWL_CFG_ANY, IWL_CFG_NO_CDB,
+		      80, IWL_CFG_ANY, IWL_CFG_NO_CDB,
 		      iwl_cfg_so_a0_hr_a0, iwl_ax101_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_SO, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_HR2, IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_160, IWL_CFG_ANY, IWL_CFG_NO_CDB,
+		      IWL_CFG_BW_NO_LIM, IWL_CFG_ANY, IWL_CFG_NO_CDB,
 		      iwl_cfg_so_a0_hr_a0, iwl_ax201_name),
 
 /* So-F with Hr */
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_SOF, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_HR2, IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_NO_160, IWL_CFG_ANY, IWL_CFG_NO_CDB,
+		      80, IWL_CFG_ANY, IWL_CFG_NO_CDB,
 		      iwl_cfg_so_a0_hr_a0, iwl_ax203_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_SOF, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_HR1, IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_NO_160, IWL_CFG_ANY, IWL_CFG_NO_CDB,
+		      80, IWL_CFG_ANY, IWL_CFG_NO_CDB,
 		      iwl_cfg_so_a0_hr_a0, iwl_ax101_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_SOF, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_HR2, IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_160, IWL_CFG_ANY, IWL_CFG_NO_CDB,
+		      IWL_CFG_BW_NO_LIM, IWL_CFG_ANY, IWL_CFG_NO_CDB,
 		      iwl_cfg_so_a0_hr_a0, iwl_ax201_name),
 
 /* So-F with Gf */
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_SOF, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_GF, IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_160, IWL_CFG_ANY, IWL_CFG_NO_CDB,
+		      IWL_CFG_BW_NO_LIM, IWL_CFG_ANY, IWL_CFG_NO_CDB,
 		      iwlax211_2ax_cfg_so_gf_a0, iwl_ax211_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_SOF, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_GF, IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_160, IWL_CFG_ANY, IWL_CFG_CDB,
+		      IWL_CFG_BW_NO_LIM, IWL_CFG_ANY, IWL_CFG_CDB,
 		      iwlax411_2ax_cfg_so_gf4_a0, iwl_ax411_name),
 
 /* SoF with JF2 */
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_SOF, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_JF2, IWL_CFG_RF_ID_JF, IWL_CFG_ANY,
-		      IWL_CFG_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
+		      IWL_CFG_BW_NO_LIM, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
 		      iwlax210_2ax_cfg_so_jf_b0, iwl9560_160_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_SOF, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_JF2, IWL_CFG_RF_ID_JF, IWL_CFG_ANY,
-		      IWL_CFG_NO_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
+		      80, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
 		      iwlax210_2ax_cfg_so_jf_b0, iwl9560_name),
 
 /* SoF with JF */
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_SOF, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1, IWL_CFG_ANY,
-		      IWL_CFG_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
+		      IWL_CFG_BW_NO_LIM, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
 		      iwlax210_2ax_cfg_so_jf_b0, iwl9461_160_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_SOF, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1_DIV, IWL_CFG_ANY,
-		      IWL_CFG_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
+		      IWL_CFG_BW_NO_LIM, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
 		      iwlax210_2ax_cfg_so_jf_b0, iwl9462_160_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_SOF, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1, IWL_CFG_ANY,
-		      IWL_CFG_NO_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
+		      80, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
 		      iwlax210_2ax_cfg_so_jf_b0, iwl9461_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_SOF, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1_DIV, IWL_CFG_ANY,
-		      IWL_CFG_NO_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
+		      80, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
 		      iwlax210_2ax_cfg_so_jf_b0, iwl9462_name),
 
 /* So with GF */
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_SO, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_GF, IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_160, IWL_CFG_ANY, IWL_CFG_NO_CDB,
+		      IWL_CFG_BW_NO_LIM, IWL_CFG_ANY, IWL_CFG_NO_CDB,
 		      iwlax211_2ax_cfg_so_gf_a0, iwl_ax211_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_SO, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_GF, IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_160, IWL_CFG_ANY, IWL_CFG_CDB,
+		      IWL_CFG_BW_NO_LIM, IWL_CFG_ANY, IWL_CFG_CDB,
 		      iwlax411_2ax_cfg_so_gf4_a0, iwl_ax411_name),
 
 /* So with JF2 */
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_SO, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_JF2, IWL_CFG_RF_ID_JF, IWL_CFG_ANY,
-		      IWL_CFG_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
+		      IWL_CFG_BW_NO_LIM, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
 		      iwlax210_2ax_cfg_so_jf_b0, iwl9560_160_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_SO, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_JF2, IWL_CFG_RF_ID_JF, IWL_CFG_ANY,
-		      IWL_CFG_NO_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
+		      80, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
 		      iwlax210_2ax_cfg_so_jf_b0, iwl9560_name),
 
 /* So with JF */
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_SO, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1, IWL_CFG_ANY,
-		      IWL_CFG_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
+		      IWL_CFG_BW_NO_LIM, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
 		      iwlax210_2ax_cfg_so_jf_b0, iwl9461_160_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_SO, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1_DIV, IWL_CFG_ANY,
-		      IWL_CFG_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
+		      IWL_CFG_BW_NO_LIM, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
 		      iwlax210_2ax_cfg_so_jf_b0, iwl9462_160_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_SO, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1, IWL_CFG_ANY,
-		      IWL_CFG_NO_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
+		      80, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
 		      iwlax210_2ax_cfg_so_jf_b0, iwl9461_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_SO, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1_DIV, IWL_CFG_ANY,
-		      IWL_CFG_NO_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
+		      80, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
 		      iwlax210_2ax_cfg_so_jf_b0, iwl9462_name),
 
 /* Bz */
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_BZ, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_HR2, IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_BW_ANY, IWL_CFG_ANY, IWL_CFG_ANY,
 		      iwl_cfg_bz, iwl_ax201_name),
 
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_BZ, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_GF, IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_BW_ANY, IWL_CFG_ANY, IWL_CFG_ANY,
 		      iwl_cfg_bz, iwl_ax211_name),
 
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
@@ -1130,73 +1131,73 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_BZ, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_WH, IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_BW_ANY, IWL_CFG_ANY, IWL_CFG_ANY,
 		      iwl_cfg_bz, iwl_wh_name),
 
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_BZ_W, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_HR2, IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_BW_ANY, IWL_CFG_ANY, IWL_CFG_ANY,
 		      iwl_cfg_bz, iwl_ax201_name),
 
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_BZ_W, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_GF, IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_BW_ANY, IWL_CFG_ANY, IWL_CFG_ANY,
 		      iwl_cfg_bz, iwl_ax211_name),
 
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_BZ_W, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_FM, IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_BW_ANY, IWL_CFG_ANY, IWL_CFG_ANY,
 		      iwl_cfg_bz, iwl_fm_name),
 
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_BZ_W, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_WH, IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_BW_ANY, IWL_CFG_ANY, IWL_CFG_ANY,
 		      iwl_cfg_bz, iwl_wh_name),
 
 /* Ga (Gl) */
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_GL, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_FM, IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_320, IWL_CFG_ANY, IWL_CFG_NO_CDB,
+		      IWL_CFG_BW_NO_LIM, IWL_CFG_ANY, IWL_CFG_NO_CDB,
 		      iwl_cfg_gl, iwl_gl_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_GL, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_FM, IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_NO_320, IWL_CFG_ANY, IWL_CFG_NO_CDB,
+		      160, IWL_CFG_ANY, IWL_CFG_NO_CDB,
 		      iwl_cfg_gl, iwl_mtp_name),
 
 /* Sc */
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_SC, IWL_CFG_ANY,
 		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_BW_ANY, IWL_CFG_ANY, IWL_CFG_ANY,
 		      iwl_cfg_sc, iwl_sc_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_SC2, IWL_CFG_ANY,
 		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_BW_ANY, IWL_CFG_ANY, IWL_CFG_ANY,
 		      iwl_cfg_sc2, iwl_sc2_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_SC2F, IWL_CFG_ANY,
 		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_BW_ANY, IWL_CFG_ANY, IWL_CFG_ANY,
 		      iwl_cfg_sc2f, iwl_sc2f_name),
 /* Dr */
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_DR, IWL_CFG_ANY,
 		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_BW_ANY, IWL_CFG_ANY, IWL_CFG_ANY,
 		      iwl_cfg_dr, iwl_dr_name),
 
 /* Br */
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_BR, IWL_CFG_ANY,
 		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_BW_ANY, IWL_CFG_ANY, IWL_CFG_ANY,
 		      iwl_cfg_br, iwl_br_name),
 #endif /* CONFIG_IWLMVM */
 };
@@ -1348,7 +1349,7 @@ static int map_crf_id(struct iwl_trans *iwl_trans)
 VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info *
 iwl_pci_find_dev_info(u16 device, u16 subsystem_device,
 		      u16 mac_type, u8 mac_step, u16 rf_type, u8 cdb,
-		      u8 jacket, u8 rf_id, u8 no_160, u8 cores, u8 rf_step)
+		      u8 jacket, u8 rf_id, u8 bw_limit, u8 cores, u8 rf_step)
 {
 	int num_devices = ARRAY_SIZE(iwl_dev_info_table);
 	int i;
@@ -1391,8 +1392,15 @@ iwl_pci_find_dev_info(u16 device, u16 subsystem_device,
 		    dev_info->rf_id != rf_id)
 			continue;
 
-		if (dev_info->no_160 != (u8)IWL_CFG_ANY &&
-		    dev_info->no_160 != no_160)
+		/*
+		 * Check that bw_limit have the same "boolean" value since
+		 * IWL_SUBDEVICE_BW_LIM can only return a boolean value and
+		 * dev_info->bw_limit encodes a non-boolean value.
+		 * dev_info->bw_limit == IWL_CFG_BW_NO_LIM must be equal to
+		 * !bw_limit to have a match.
+		 */
+		if (dev_info->bw_limit != IWL_CFG_BW_ANY &&
+		    (dev_info->bw_limit == IWL_CFG_BW_NO_LIM) == !!bw_limit)
 			continue;
 
 		if (dev_info->cores != (u8)IWL_CFG_ANY &&
@@ -1530,13 +1538,13 @@ static int iwl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 					 CSR_HW_RFID_IS_CDB(iwl_trans->hw_rf_id),
 					 CSR_HW_RFID_IS_JACKET(iwl_trans->hw_rf_id),
 					 IWL_SUBDEVICE_RF_ID(pdev->subsystem_device),
-					 IWL_SUBDEVICE_NO_160(pdev->subsystem_device),
+					 IWL_SUBDEVICE_BW_LIM(pdev->subsystem_device),
 					 IWL_SUBDEVICE_CORES(pdev->subsystem_device),
 					 CSR_HW_RFID_STEP(iwl_trans->hw_rf_id));
 	if (dev_info) {
 		iwl_trans->cfg = dev_info->cfg;
 		iwl_trans->name = dev_info->name;
-		iwl_trans->no_160 = dev_info->no_160 == IWL_CFG_NO_160;
+		iwl_trans->bw_limit = dev_info->bw_limit;
 	}
 
 #if IS_ENABLED(CONFIG_IWLMVM)
diff --git a/drivers/net/wireless/intel/iwlwifi/tests/devinfo.c b/drivers/net/wireless/intel/iwlwifi/tests/devinfo.c
index d0bda23c628a..7ef5e89c6af2 100644
--- a/drivers/net/wireless/intel/iwlwifi/tests/devinfo.c
+++ b/drivers/net/wireless/intel/iwlwifi/tests/devinfo.c
@@ -2,7 +2,7 @@
 /*
  * KUnit tests for the iwlwifi device info table
  *
- * Copyright (C) 2023-2024 Intel Corporation
+ * Copyright (C) 2023-2025 Intel Corporation
  */
 #include <kunit/test.h>
 #include <linux/pci.h>
@@ -13,9 +13,9 @@ MODULE_IMPORT_NS("EXPORTED_FOR_KUNIT_TESTING");
 
 static void iwl_pci_print_dev_info(const char *pfx, const struct iwl_dev_info *di)
 {
-	printk(KERN_DEBUG "%sdev=%.4x,subdev=%.4x,mac_type=%.4x,mac_step=%.4x,rf_type=%.4x,cdb=%d,jacket=%d,rf_id=%.2x,no_160=%d,cores=%.2x\n",
+	printk(KERN_DEBUG "%sdev=%.4x,subdev=%.4x,mac_type=%.4x,mac_step=%.4x,rf_type=%.4x,cdb=%d,jacket=%d,rf_id=%.2x,bw_limit=%d,cores=%.2x\n",
 	       pfx, di->device, di->subdevice, di->mac_type, di->mac_step,
-	       di->rf_type, di->cdb, di->jacket, di->rf_id, di->no_160,
+	       di->rf_type, di->cdb, di->jacket, di->rf_id, di->bw_limit,
 	       di->cores);
 }
 
@@ -31,8 +31,13 @@ static void devinfo_table_order(struct kunit *test)
 					    di->mac_type, di->mac_step,
 					    di->rf_type, di->cdb,
 					    di->jacket, di->rf_id,
-					    di->no_160, di->cores, di->rf_step);
-		if (ret != di) {
+					    di->bw_limit != IWL_CFG_BW_NO_LIM,
+					    di->cores, di->rf_step);
+		if (!ret) {
+			iwl_pci_print_dev_info("No entry found for: ", di);
+			KUNIT_FAIL(test,
+				   "No entry found for entry at index %d\n", idx);
+		} else if (ret != di) {
 			iwl_pci_print_dev_info("searched: ", di);
 			iwl_pci_print_dev_info("found:    ", ret);
 			KUNIT_FAIL(test,
-- 
2.34.1


