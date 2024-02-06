Return-Path: <linux-wireless+bounces-3236-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6840384BA86
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Feb 2024 17:02:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FBD22907D2
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Feb 2024 16:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE07A134CCB;
	Tue,  6 Feb 2024 16:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Uvfck+dc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFECF13475E
	for <linux-wireless@vger.kernel.org>; Tue,  6 Feb 2024 16:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707235357; cv=none; b=qybskM8E2oiimejQKYqca1z/UIA3GD3Q5vpvB3RO3ZC3sVC7Bu7+f0FZH8JUhXE3vI52XBPPP3y7Jdc7aqfGh+REiBLOcJq4Kox09RKVEyMlkxZAlbWflJSjkOuXOTr+8ydXXvBkudcG2lPLB+XpThy3B+lM8Vnkz2KRFd/g4zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707235357; c=relaxed/simple;
	bh=4IAr+Xn1CEXtHr4g3uYzxA1kidu4eJ8Ww9teT8ZXiOY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CcloHsW62BQr8B1OjtADrYj8GSN3J3KxHVaKpQAjOnqFiYzkzBU5aLbx1FSutpWZTf45WBp08gPgBm6XUPmeF8EkcZatd5+/HvCRDKbkUORI7U5ZrdbKXzZmmZIkUonn4Sa6yCxHTnrEMFIbH3VDHIxJmJZVhJsuYszy+SzxebE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Uvfck+dc; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707235356; x=1738771356;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4IAr+Xn1CEXtHr4g3uYzxA1kidu4eJ8Ww9teT8ZXiOY=;
  b=Uvfck+dcF6XhY4grAeDBChBuI3xvkM8o4bHlPsv5YV9Nx++uf+kpo2gz
   8unQsmsL23qs9UsQ6toNpXPZTvIBIlc7vxYwv6f2LCM1QJeyENoe8Nupx
   6xfcIVJSpqeOPMVchy0L//aYCWetp2R4ngBVYALSiUyGk+N66094K27KU
   LF3Esjy3pez85Spe1sLzw/6sYW35M2UGhBocGNdSfNFX1IJ4qJ2z/wh0p
   oUf2GozQgweS3UrsPY5CxKWc5V2cmfZdry3VIIKjyFsPCuiyHkVTE+icr
   5oaxOZhG9oxW/XvH2LA4olSbOvkXNtS3zJrDYxuP9hUXiXWeWgqVvdm96
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10976"; a="23252323"
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="23252323"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 08:02:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="1349832"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 08:02:34 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Mukesh Sisodiya <mukesh.sisodiya@intel.com>
Subject: [PATCH 05/11] wifi: iwlwifi: pcie: Add new PCI device id and CNVI
Date: Tue,  6 Feb 2024 18:02:08 +0200
Message-Id: <20240206175739.506db9b4a664.Ia2e3a77b880c449ac0e8d20b8cea25e6f07f1b81@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240206160214.3260547-1-miriam.rachel.korenblit@intel.com>
References: <20240206160214.3260547-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Mukesh Sisodiya <mukesh.sisodiya@intel.com>

Add the support for a new PCIE device-id 0x272E and a new CNVI
type.

Signed-off-by: Mukesh Sisodiya <mukesh.sisodiya@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c   | 38 +++++++++++++++++--
 .../net/wireless/intel/iwlwifi/iwl-config.h   |  8 +++-
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 15 +++++++-
 3 files changed, 55 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/sc.c b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
index e0679093ed8e..be98a174a311 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
  * Copyright (C) 2015-2017 Intel Deutschland GmbH
- * Copyright (C) 2018-2023 Intel Corporation
+ * Copyright (C) 2018-2024 Intel Corporation
  */
 #include <linux/module.h>
 #include <linux/stringify.h>
@@ -33,6 +33,10 @@
 #define IWL_SC_A_GF_A_FW_PRE		"iwlwifi-sc-a0-gf-a0"
 #define IWL_SC_A_GF4_A_FW_PRE		"iwlwifi-sc-a0-gf4-a0"
 #define IWL_SC_A_WH_A_FW_PRE		"iwlwifi-sc-a0-wh-a0"
+#define IWL_SC2_A_FM_C_FW_PRE		"iwlwifi-sc2-a0-fm-c0"
+#define IWL_SC2_A_WH_A_FW_PRE		"iwlwifi-sc2-a0-wh-a0"
+#define IWL_SC2F_A_FM_C_FW_PRE		"iwlwifi-sc2f-a0-fm-c0"
+#define IWL_SC2F_A_WH_A_FW_PRE		"iwlwifi-sc2f-a0-wh-a0"
 
 #define IWL_SC_A_FM_B_FW_MODULE_FIRMWARE(api) \
 	IWL_SC_A_FM_B_FW_PRE "-" __stringify(api) ".ucode"
@@ -48,6 +52,14 @@
 	IWL_SC_A_GF4_A_FW_PRE "-" __stringify(api) ".ucode"
 #define IWL_SC_A_WH_A_FW_MODULE_FIRMWARE(api) \
 	IWL_SC_A_WH_A_FW_PRE "-" __stringify(api) ".ucode"
+#define IWL_SC2_A_FM_C_FW_MODULE_FIRMWARE(api) \
+	IWL_SC2_A_FM_C_FW_PRE "-" __stringify(api) ".ucode"
+#define IWL_SC2_A_WH_A_FW_MODULE_FIRMWARE(api) \
+	IWL_SC2_A_WH_A_FW_PRE "-" __stringify(api) ".ucode"
+#define IWL_SC2F_A_FM_C_FW_MODULE_FIRMWARE(api) \
+	IWL_SC2F_A_FM_C_FW_PRE "-" __stringify(api) ".ucode"
+#define IWL_SC2F_A_WH_A_FW_MODULE_FIRMWARE(api) \
+	IWL_SC2F_A_WH_A_FW_PRE "-" __stringify(api) ".ucode"
 
 static const struct iwl_base_params iwl_sc_base_params = {
 	.eeprom_size = OTP_LOW_IMAGE_SIZE_32K,
@@ -124,6 +136,9 @@ static const struct iwl_base_params iwl_sc_base_params = {
 
 #define IWL_DEVICE_SC							\
 	IWL_DEVICE_BZ_COMMON,						\
+	.uhb_supported = true,						\
+	.features = IWL_TX_CSUM_NETIF_FLAGS | NETIF_F_RXCSUM,		\
+	.num_rbds = IWL_NUM_RBDS_SC_EHT,				\
 	.ht_params = &iwl_22000_ht_params
 
 /*
@@ -149,10 +164,21 @@ const char iwl_sc_name[] = "Intel(R) TBD Sc device";
 
 const struct iwl_cfg iwl_cfg_sc = {
 	.fw_name_mac = "sc",
-	.uhb_supported = true,
 	IWL_DEVICE_SC,
-	.features = IWL_TX_CSUM_NETIF_FLAGS | NETIF_F_RXCSUM,
-	.num_rbds = IWL_NUM_RBDS_SC_EHT,
+};
+
+const char iwl_sc2_name[] = "Intel(R) TBD Sc2 device";
+
+const struct iwl_cfg iwl_cfg_sc2 = {
+	.fw_name_mac = "sc2",
+	IWL_DEVICE_SC,
+};
+
+const char iwl_sc2f_name[] = "Intel(R) TBD Sc2f device";
+
+const struct iwl_cfg iwl_cfg_sc2f = {
+	.fw_name_mac = "sc2f",
+	IWL_DEVICE_SC,
 };
 
 MODULE_FIRMWARE(IWL_SC_A_FM_B_FW_MODULE_FIRMWARE(IWL_SC_UCODE_API_MAX));
@@ -162,3 +188,7 @@ MODULE_FIRMWARE(IWL_SC_A_HR_B_FW_MODULE_FIRMWARE(IWL_SC_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_SC_A_GF_A_FW_MODULE_FIRMWARE(IWL_SC_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_SC_A_GF4_A_FW_MODULE_FIRMWARE(IWL_SC_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_SC_A_WH_A_FW_MODULE_FIRMWARE(IWL_SC_UCODE_API_MAX));
+MODULE_FIRMWARE(IWL_SC2_A_FM_C_FW_MODULE_FIRMWARE(IWL_SC_UCODE_API_MAX));
+MODULE_FIRMWARE(IWL_SC2_A_WH_A_FW_MODULE_FIRMWARE(IWL_SC_UCODE_API_MAX));
+MODULE_FIRMWARE(IWL_SC2F_A_FM_C_FW_MODULE_FIRMWARE(IWL_SC_UCODE_API_MAX));
+MODULE_FIRMWARE(IWL_SC2F_A_WH_A_FW_MODULE_FIRMWARE(IWL_SC_UCODE_API_MAX));
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index 97e73443316a..6aa4f7f9c708 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -2,7 +2,7 @@
 /*
  * Copyright (C) 2005-2014, 2018-2021 Intel Corporation
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
- * Copyright (C) 2018-2023 Intel Corporation
+ * Copyright (C) 2018-2024 Intel Corporation
  */
 #ifndef __IWL_CONFIG_H__
 #define __IWL_CONFIG_H__
@@ -419,6 +419,8 @@ struct iwl_cfg {
 #define IWL_CFG_MAC_TYPE_BZ		0x46
 #define IWL_CFG_MAC_TYPE_GL		0x47
 #define IWL_CFG_MAC_TYPE_SC		0x48
+#define IWL_CFG_MAC_TYPE_SC2		0x49
+#define IWL_CFG_MAC_TYPE_SC2F		0x4A
 
 #define IWL_CFG_RF_TYPE_TH		0x105
 #define IWL_CFG_RF_TYPE_TH1		0x108
@@ -541,6 +543,8 @@ extern const char iwl_ax411_name[];
 extern const char iwl_bz_name[];
 extern const char iwl_mtp_name[];
 extern const char iwl_sc_name[];
+extern const char iwl_sc2_name[];
+extern const char iwl_sc2f_name[];
 #if IS_ENABLED(CONFIG_IWLDVM)
 extern const struct iwl_cfg iwl5300_agn_cfg;
 extern const struct iwl_cfg iwl5100_agn_cfg;
@@ -646,6 +650,8 @@ extern const struct iwl_cfg iwl_cfg_bz;
 extern const struct iwl_cfg iwl_cfg_gl;
 
 extern const struct iwl_cfg iwl_cfg_sc;
+extern const struct iwl_cfg iwl_cfg_sc2;
+extern const struct iwl_cfg iwl_cfg_sc2f;
 #endif /* CONFIG_IWLMVM */
 
 #endif /* __IWL_CONFIG_H__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 1ed67b76b516..4a657036b9d6 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2005-2014, 2018-2023 Intel Corporation
+ * Copyright (C) 2005-2014, 2018-2024 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -509,6 +509,9 @@ static const struct pci_device_id iwl_hw_card_ids[] = {
 
 /* Sc devices */
 	{IWL_PCI_DEVICE(0xE440, PCI_ANY_ID, iwl_sc_trans_cfg)},
+	{IWL_PCI_DEVICE(0xE340, PCI_ANY_ID, iwl_sc_trans_cfg)},
+	{IWL_PCI_DEVICE(0xD340, PCI_ANY_ID, iwl_sc_trans_cfg)},
+	{IWL_PCI_DEVICE(0x6E70, PCI_ANY_ID, iwl_sc_trans_cfg)},
 #endif /* CONFIG_IWLMVM */
 
 	{0}
@@ -1121,6 +1124,16 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_ANY,
 		      iwl_cfg_sc, iwl_sc_name),
+	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_MAC_TYPE_SC2, IWL_CFG_ANY,
+		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_ANY,
+		      iwl_cfg_sc2, iwl_sc2_name),
+	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_MAC_TYPE_SC2F, IWL_CFG_ANY,
+		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_ANY,
+		      iwl_cfg_sc2f, iwl_sc2f_name),
 #endif /* CONFIG_IWLMVM */
 };
 EXPORT_SYMBOL_IF_IWLWIFI_KUNIT(iwl_dev_info_table);
-- 
2.34.1


