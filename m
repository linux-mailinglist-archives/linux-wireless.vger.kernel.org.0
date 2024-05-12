Return-Path: <linux-wireless+bounces-7547-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C9D98C367F
	for <lists+linux-wireless@lfdr.de>; Sun, 12 May 2024 14:26:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3815B1C2093E
	for <lists+linux-wireless@lfdr.de>; Sun, 12 May 2024 12:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A52745BFF;
	Sun, 12 May 2024 12:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Sg038QsC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C12941746
	for <linux-wireless@vger.kernel.org>; Sun, 12 May 2024 12:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715516734; cv=none; b=Z3lqX7Hq2GkpOmQK5cbnsemfVL3kQhZuInOAY2CfqW+eONlpa/NzHaYYHEKDj1NXjUgJTH9mUmy1HuuZRKhCR8OkQZCRPDQwfU0F+fwueajTzIMYVPA5Z5mXLz9z5Z2LjA4Er8BqIvPNI1Su7b4WhEMCPlOGOOAV7heTQo66JtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715516734; c=relaxed/simple;
	bh=p4NfDYBbHDoqx30r/8rMEjnayf9GONgYgrfHf1aMCc0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IufARU7qWGCmNJIR0rboZW3IvMXUJcHanRW60DFHSX/C3Ya7WA97z/Do4RMPje1AoHqT9ZEg0Adr/+G6ZHg7JBdTbzaOt/+B/K7K1ZpPIxFTFXYB+Ru+JHNs1HJU0b7uSh5ASlvGiPUqmRfjnfD3gvOhV3w/i3TjF6gZUG2x0oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Sg038QsC; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715516733; x=1747052733;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=p4NfDYBbHDoqx30r/8rMEjnayf9GONgYgrfHf1aMCc0=;
  b=Sg038QsC328yheyZEzsB+rXXPYV9KFl8mL4GfO3PpSyHJMNAxjGV3BPs
   Y7VDF7vieNz6H/8OhNCxwx2sWFpyypsFlazE1GtzdR6o9E4hPXm7e9lKt
   A2sBmKCMTYeTup85oHYO//XEIEFM0xnBia355DcZ9ccHc+zIJAHdyuePX
   oXOZKBdMbCYrjdDL72aPyKQD1s3fMRRrz4HRnSG/B7pkla28qH+UDoevD
   GamYJFSNsz8gVF3S/nUs0AI9zwAy4wKJW1N3HMIGh8zJMO/ieV2L1Fp7z
   hi6kvSZHn2XAFCy2mnvfqlNgAb2DmVtiROHXRSFfGoU3TUih/Km62PAmh
   A==;
X-CSE-ConnectionGUID: tWB1FPs0TjSca5MLIBD0pw==
X-CSE-MsgGUID: mOshSNLtRbWiMZv6zNrgjA==
X-IronPort-AV: E=McAfee;i="6600,9927,11071"; a="11397220"
X-IronPort-AV: E=Sophos;i="6.08,155,1712646000"; 
   d="scan'208";a="11397220"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2024 05:25:33 -0700
X-CSE-ConnectionGUID: zO9G9yQ5QkiWfn7lstY7rg==
X-CSE-MsgGUID: Kcm0Z26aSdSSLyfuEAsPwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,155,1712646000"; 
   d="scan'208";a="34761347"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2024 05:25:32 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Subject: [PATCH 12/14] wifi: iwlwifi: Add support for LARI_CONFIG_CHANGE_CMD v11
Date: Sun, 12 May 2024 15:25:05 +0300
Message-Id: <20240512152312.037613d03c87.I4e5ee63c0dbdd4bd6c48daee7b0c88462b702423@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240512122507.3812527-1-miriam.rachel.korenblit@intel.com>
References: <20240512122507.3812527-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>

Add support for enable/disable 11be for china and South Korea by
reading DSM function 12 from UEFI or ACPI and sending it to the FW.

Signed-off-by: Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c  |  1 +
 .../wireless/intel/iwlwifi/fw/api/nvm-reg.h   | 52 +++++++++++++++++--
 .../wireless/intel/iwlwifi/fw/regulatory.c    | 15 +++++-
 .../wireless/intel/iwlwifi/fw/regulatory.h    |  3 +-
 4 files changed, 65 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
index fa339791223b..79774c8c7ff4 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
@@ -27,6 +27,7 @@ static const size_t acpi_dsm_size[DSM_FUNC_NUM_FUNCS] = {
 	[DSM_FUNC_FORCE_DISABLE_CHANNELS] =	sizeof(u32),
 	[DSM_FUNC_ENERGY_DETECTION_THRESHOLD] =	sizeof(u32),
 	[DSM_FUNC_RFI_CONFIG] =			sizeof(u32),
+	[DSM_FUNC_ENABLE_11BE] =		sizeof(u32),
 };
 
 static int iwl_acpi_get_handle(struct device *dev, acpi_string method,
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h b/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h
index a08497a04733..644c8df780bc 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h
@@ -23,7 +23,8 @@ enum iwl_regulatory_and_nvm_subcmd_ids {
 	 *	&struct iwl_lari_config_change_cmd_v4,
 	 *	&struct iwl_lari_config_change_cmd_v5,
 	 *	&struct iwl_lari_config_change_cmd_v6,
-	 *	&struct iwl_lari_config_change_cmd_v7 or
+	 *	&struct iwl_lari_config_change_cmd_v7,
+	 *	&struct iwl_lari_config_change_cmd_v10 or
 	 *	&struct iwl_lari_config_change_cmd
 	 */
 	LARI_CONFIG_CHANGE = 0x1,
@@ -648,7 +649,7 @@ struct iwl_lari_config_change_cmd_v7 {
 /* LARI_CHANGE_CONF_CMD_S_VER_9 */
 
 /**
- * struct iwl_lari_config_change_cmd - change LARI configuration
+ * struct iwl_lari_config_change_cmd_v10 - change LARI configuration
  * @config_bitmap: Bitmap of the config commands. Each bit will trigger a
  *	different predefined FW config operation.
  * @oem_uhb_allow_bitmap: Bitmap of UHB enabled MCC sets.
@@ -674,7 +675,7 @@ struct iwl_lari_config_change_cmd_v7 {
  *	bit1: enable 320Mhz in South Korea.
  *	bit 2 - 31: reserved.
  */
-struct iwl_lari_config_change_cmd {
+struct iwl_lari_config_change_cmd_v10 {
 	__le32 config_bitmap;
 	__le32 oem_uhb_allow_bitmap;
 	__le32 oem_11ax_allow_bitmap;
@@ -686,6 +687,51 @@ struct iwl_lari_config_change_cmd {
 } __packed;
 /* LARI_CHANGE_CONF_CMD_S_VER_10 */
 
+/**
+ * struct iwl_lari_config_change_cmd - change LARI configuration
+ * @config_bitmap: Bitmap of the config commands. Each bit will trigger a
+ *	different predefined FW config operation.
+ * @oem_uhb_allow_bitmap: Bitmap of UHB enabled MCC sets.
+ * @oem_11ax_allow_bitmap: Bitmap of 11ax allowed MCCs. There are two bits
+ *	per country, one to indicate whether to override and the other to
+ *	indicate the value to use.
+ * @oem_unii4_allow_bitmap: Bitmap of unii4 allowed MCCs.There are two bits
+ *	per country, one to indicate whether to override and the other to
+ *	indicate allow/disallow unii4 channels.
+ *	For LARI cmd version 11 - bits 0:5 are supported.
+ * @chan_state_active_bitmap: Bitmap to enable different bands per country
+ *	or region.
+ *	Each bit represents a country or region, and a band to activate
+ *	according to the BIOS definitions.
+ *	For LARI cmd version 11 - bits 0:4 are supported.
+ * @force_disable_channels_bitmap: Bitmap of disabled bands/channels.
+ *	Each bit represents a set of channels in a specific band that should be
+ *	disabled
+ * @edt_bitmap: Bitmap of energy detection threshold table.
+ *	Disable/enable the EDT optimization method for different band.
+ * @oem_320mhz_allow_bitmap: 320Mhz bandwidth enablement bitmap per MCC.
+ *	bit0: enable 320Mhz in Japan.
+ *	bit1: enable 320Mhz in South Korea.
+ *	bit 2 - 31: reserved.
+ * @oem_11be_allow_bitmap: Bitmap of 11be allowed MCCs. No need to mask out the
+ *	unsupported bits
+ *	bit0: enable 11be in China(CB/CN).
+ *	bit1: enable 11be in South Korea.
+ *	bit 2 - 31: reserved.
+ */
+struct iwl_lari_config_change_cmd {
+	__le32 config_bitmap;
+	__le32 oem_uhb_allow_bitmap;
+	__le32 oem_11ax_allow_bitmap;
+	__le32 oem_unii4_allow_bitmap;
+	__le32 chan_state_active_bitmap;
+	__le32 force_disable_channels_bitmap;
+	__le32 edt_bitmap;
+	__le32 oem_320mhz_allow_bitmap;
+	__le32 oem_11be_allow_bitmap;
+} __packed;
+/* LARI_CHANGE_CONF_CMD_S_VER_11 */
+
 /* Activate UNII-1 (5.2GHz) for World Wide */
 #define ACTIVATE_5G2_IN_WW_MASK	BIT(4)
 
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c
index b9bb3636e88f..5228b837a9ef 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c
@@ -497,9 +497,12 @@ static size_t iwl_get_lari_config_cmd_size(u8 cmd_ver)
 	size_t cmd_size;
 
 	switch (cmd_ver) {
-	case 10:
+	case 11:
 		cmd_size = sizeof(struct iwl_lari_config_change_cmd);
 		break;
+	case 10:
+		cmd_size = sizeof(struct iwl_lari_config_change_cmd_v10);
+		break;
 	case 9:
 	case 8:
 	case 7:
@@ -580,6 +583,10 @@ int iwl_fill_lari_config(struct iwl_fw_runtime *fwrt,
 	if (!ret)
 		cmd->oem_320mhz_allow_bitmap = cpu_to_le32(value);
 
+	ret = iwl_bios_get_dsm(fwrt, DSM_FUNC_ENABLE_11BE, &value);
+	if (!ret)
+		cmd->oem_11be_allow_bitmap = cpu_to_le32(value);
+
 	if (cmd->config_bitmap ||
 	    cmd->oem_uhb_allow_bitmap ||
 	    cmd->oem_11ax_allow_bitmap ||
@@ -587,7 +594,8 @@ int iwl_fill_lari_config(struct iwl_fw_runtime *fwrt,
 	    cmd->chan_state_active_bitmap ||
 	    cmd->force_disable_channels_bitmap ||
 	    cmd->edt_bitmap ||
-	    cmd->oem_320mhz_allow_bitmap) {
+	    cmd->oem_320mhz_allow_bitmap ||
+	    cmd->oem_11be_allow_bitmap) {
 		IWL_DEBUG_RADIO(fwrt,
 				"sending LARI_CONFIG_CHANGE, config_bitmap=0x%x, oem_11ax_allow_bitmap=0x%x\n",
 				le32_to_cpu(cmd->config_bitmap),
@@ -605,6 +613,9 @@ int iwl_fill_lari_config(struct iwl_fw_runtime *fwrt,
 				"sending LARI_CONFIG_CHANGE, edt_bitmap=0x%x, oem_320mhz_allow_bitmap=0x%x\n",
 				le32_to_cpu(cmd->edt_bitmap),
 				le32_to_cpu(cmd->oem_320mhz_allow_bitmap));
+		IWL_DEBUG_RADIO(fwrt,
+				"sending LARI_CONFIG_CHANGE, oem_11be_allow_bitmap=0x%x\n",
+				le32_to_cpu(cmd->oem_11be_allow_bitmap));
 	} else {
 		return 1;
 	}
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h
index 633c9ad9af84..e2c056f483c1 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h
@@ -115,7 +115,8 @@ enum iwl_dsm_funcs {
 	DSM_FUNC_FORCE_DISABLE_CHANNELS = 9,
 	DSM_FUNC_ENERGY_DETECTION_THRESHOLD = 10,
 	DSM_FUNC_RFI_CONFIG = 11,
-	DSM_FUNC_NUM_FUNCS = 12,
+	DSM_FUNC_ENABLE_11BE = 12,
+	DSM_FUNC_NUM_FUNCS = 13,
 };
 
 enum iwl_dsm_values_srd {
-- 
2.34.1


