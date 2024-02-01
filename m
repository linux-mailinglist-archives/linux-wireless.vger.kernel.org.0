Return-Path: <linux-wireless+bounces-2959-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 486C98459FF
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Feb 2024 15:20:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 533ADB29893
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Feb 2024 14:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7750A5D484;
	Thu,  1 Feb 2024 14:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fl6Om6aB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C535D473
	for <linux-wireless@vger.kernel.org>; Thu,  1 Feb 2024 14:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706797217; cv=none; b=lqRp/gqjymjCF1TKRxwg/gulWawEavDNwxxpr6HcyiDpBpWEn4UN91+9bv8l4+NFY21Yp/4cUrwfQNBN70mzVHDvah0/GsmZuLTdgjP9mp2fnOtUel5dVbVy9U4uAotQz2TEaFrvwj6U+dxCG8MnCK2sGBDXBFf2w6VIF7VP2NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706797217; c=relaxed/simple;
	bh=Zjqk2TorxAvemhP31lfJCqVINQ5d5rEzkRKLme7LSus=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YtVum9LeVK6hhcN4Xlbf13QwbscgX/fO2KvyVGXxIBOHzrzXwo5I7Bz2jtoKvpuKJqqc8xiJALu8ZHykOgzOpoiP0TTBJ/Ls5+JtDI4C1U+IWp2XCitJmNdtz0geoFyVYxE1JidO/S+GFJQlmCaEOhd0TshQRnyTwNHXsVgSZUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fl6Om6aB; arc=none smtp.client-ip=192.55.52.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706797215; x=1738333215;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Zjqk2TorxAvemhP31lfJCqVINQ5d5rEzkRKLme7LSus=;
  b=Fl6Om6aBMkPa0V6Kh2Ku0vMwCr9REU7loEJ+zCh35djx5FWuedbDaQpG
   lLAH9HT0oq489xUtHRWFEy0DOj95OmRIcMGhF+DqyZnOuCaur0PMJw6wF
   maWv6104NS6YZ4dTUmNzFLHzi0rjDqpMWhKz0UCF6Alx6VgctP7LSrkWM
   IPpQrVlaX9AYhjDFxusNQ5yXANBzffxW7won5iK6oNUpCJWGcO+JUxt8h
   hR2DZIv9QX+P5IFDN5gDCEjAah99qq8CM7gAfZ+ZXJeTOd30Dv+ptsleh
   3BqS6RX7NVXTS3F8MxrRzzdqQveaHDUEGI+bAb7EHNZiSBT4p3D/Uqs74
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="435062937"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="435062937"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 06:20:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="94269"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 06:20:03 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 11/17] wifi: iwlwifi: simplify getting DSM from ACPI
Date: Thu,  1 Feb 2024 16:17:35 +0200
Message-Id: <20240201155157.1bcd7072a7a5.I344ee0a11abbc27da0c693187d1b8bee653aaeef@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240201141741.2569180-1-miriam.rachel.korenblit@intel.com>
References: <20240201141741.2569180-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

As DSMs are going to be read from UEFI too, we need a unified API
to get DSMs for both ACPI and UEFI.

The difference in getting DSM in each one of these methods (ACPI, UEFI)
is in the GUID, revision (0 for ACPI, 4 for UEFI), and size of the DSM
values (8 or 32 for ACPI, 32 for UEFI).

Therefore, change the iwl_acpi_get_dsm_x() to iwl_acpi_get_dsm() which
determines the GUID, revision (these two are the same for all WiFi DSMs),
and size (based on a func-to-size mapping) internally.

While at it, fix DSM_FUNC_RFI_CONFIG to expect a 32-bit value
(as defined in Intel BIOS spec) and not a 8-bit one.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c  | 89 ++++++++++---------
 drivers/net/wireless/intel/iwlwifi/fw/acpi.h  | 33 +++----
 .../net/wireless/intel/iwlwifi/mvm/debugfs.c  |  4 +-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   | 32 +++----
 4 files changed, 73 insertions(+), 85 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
index 6f9ead79978a..22b21bbc294f 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
@@ -12,7 +12,22 @@
 const guid_t iwl_guid = GUID_INIT(0xF21202BF, 0x8F78, 0x4DC6,
 				  0xA5, 0xB3, 0x1F, 0x73,
 				  0x8E, 0x28, 0x5A, 0xDE);
-IWL_EXPORT_SYMBOL(iwl_guid);
+
+static const size_t acpi_dsm_size[DSM_FUNC_NUM_FUNCS] = {
+	[DSM_FUNC_QUERY] =			sizeof(u32),
+	[DSM_FUNC_DISABLE_SRD] =		sizeof(u8),
+	[DSM_FUNC_ENABLE_INDONESIA_5G2] =	sizeof(u8),
+	[DSM_FUNC_ENABLE_6E] =			sizeof(u32),
+	[DSM_FUNC_REGULATORY_CONFIG] =		sizeof(u32),
+	/* Not supported in driver */
+	[5] =					(size_t)0,
+	[DSM_FUNC_11AX_ENABLEMENT] =		sizeof(u32),
+	[DSM_FUNC_ENABLE_UNII4_CHAN] =		sizeof(u32),
+	[DSM_FUNC_ACTIVATE_CHANNEL] =		sizeof(u32),
+	[DSM_FUNC_FORCE_DISABLE_CHANNELS] =	sizeof(u32),
+	[DSM_FUNC_ENERGY_DETECTION_THRESHOLD] =	sizeof(u32),
+	[DSM_FUNC_RFI_CONFIG] =			sizeof(u32),
+};
 
 static int iwl_acpi_get_handle(struct device *dev, acpi_string method,
 			       acpi_handle *ret_handle)
@@ -137,46 +152,42 @@ static int iwl_acpi_get_dsm_integer(struct device *dev, int rev, int func,
 }
 
 /*
- * Evaluate a DSM with no arguments and a u8 return value,
+ * This function receives a DSM function number, calculates its expected size
+ * according to Intel BIOS spec, and fills in the value in a 32-bit field.
+ * In case the expected size is smaller than 32-bit, padding will be added.
  */
-int iwl_acpi_get_dsm_u8(struct device *dev, int rev, int func,
-			const guid_t *guid, u8 *value)
+int iwl_acpi_get_dsm(struct iwl_fw_runtime *fwrt,
+		     enum iwl_dsm_funcs_rev_0 func, u32 *value)
 {
+	size_t expected_size;
+	u64 tmp;
 	int ret;
-	u64 val;
 
-	ret = iwl_acpi_get_dsm_integer(dev, rev, func,
-				       guid, &val, sizeof(u8));
+	BUILD_BUG_ON(ARRAY_SIZE(acpi_dsm_size) != DSM_FUNC_NUM_FUNCS);
 
-	if (ret < 0)
-		return ret;
+	if (WARN_ON(func >= ARRAY_SIZE(acpi_dsm_size)))
+		return -EINVAL;
 
-	/* cast val (u64) to be u8 */
-	*value = (u8)val;
-	return 0;
-}
-IWL_EXPORT_SYMBOL(iwl_acpi_get_dsm_u8);
+	expected_size = acpi_dsm_size[func];
 
-/*
- * Evaluate a DSM with no arguments and a u32 return value,
- */
-int iwl_acpi_get_dsm_u32(struct device *dev, int rev, int func,
-			 const guid_t *guid, u32 *value)
-{
-	int ret;
-	u64 val;
-
-	ret = iwl_acpi_get_dsm_integer(dev, rev, func,
-				       guid, &val, sizeof(u32));
+	/* Currently all ACPI DSMs are either 8-bit or 32-bit */
+	if (expected_size != sizeof(u8) && expected_size != sizeof(u32))
+		return -EOPNOTSUPP;
 
-	if (ret < 0)
+	ret = iwl_acpi_get_dsm_integer(fwrt->dev, ACPI_DSM_REV, func,
+				       &iwl_guid, &tmp, expected_size);
+	if (ret)
 		return ret;
 
-	/* cast val (u64) to be u32 */
-	*value = (u32)val;
+	if ((expected_size == sizeof(u8) && tmp != (u8)tmp) ||
+	    (expected_size == sizeof(u32) && tmp != (u32)tmp))
+		IWL_DEBUG_RADIO(fwrt,
+				"DSM value overflows the expected size, truncating\n");
+	*value = (u32)tmp;
+
 	return 0;
 }
-IWL_EXPORT_SYMBOL(iwl_acpi_get_dsm_u32);
+IWL_EXPORT_SYMBOL(iwl_acpi_get_dsm);
 
 static union acpi_object *
 iwl_acpi_get_wifi_pkg_range(struct device *dev,
@@ -800,7 +811,6 @@ int iwl_acpi_get_wgds_table(struct iwl_fw_runtime *fwrt)
 __le32 iwl_acpi_get_lari_config_bitmap(struct iwl_fw_runtime *fwrt)
 {
 	int ret;
-	u8 value;
 	u32 val;
 	__le32 config_bitmap = 0;
 
@@ -813,11 +823,10 @@ __le32 iwl_acpi_get_lari_config_bitmap(struct iwl_fw_runtime *fwrt)
 	case IWL_CFG_RF_TYPE_HR2:
 	case IWL_CFG_RF_TYPE_JF1:
 	case IWL_CFG_RF_TYPE_JF2:
-		ret = iwl_acpi_get_dsm_u8(fwrt->dev, 0,
-					  DSM_FUNC_ENABLE_INDONESIA_5G2,
-					  &iwl_guid, &value);
+		ret = iwl_acpi_get_dsm(fwrt, DSM_FUNC_ENABLE_INDONESIA_5G2,
+				       &val);
 
-		if (!ret && value == DSM_VALUE_INDONESIA_ENABLE)
+		if (!ret && val == DSM_VALUE_INDONESIA_ENABLE)
 			config_bitmap |=
 			    cpu_to_le32(LARI_CONFIG_ENABLE_5G2_IN_INDONESIA_MSK);
 		break;
@@ -828,14 +837,12 @@ __le32 iwl_acpi_get_lari_config_bitmap(struct iwl_fw_runtime *fwrt)
 	/*
 	 ** Evaluate func 'DSM_FUNC_DISABLE_SRD'
 	 */
-	ret = iwl_acpi_get_dsm_u8(fwrt->dev, 0,
-				  DSM_FUNC_DISABLE_SRD,
-				  &iwl_guid, &value);
+	ret = iwl_acpi_get_dsm(fwrt, DSM_FUNC_DISABLE_SRD, &val);
 	if (!ret) {
-		if (value == DSM_VALUE_SRD_PASSIVE)
+		if (val == DSM_VALUE_SRD_PASSIVE)
 			config_bitmap |=
 				cpu_to_le32(LARI_CONFIG_CHANGE_ETSI_TO_PASSIVE_MSK);
-		else if (value == DSM_VALUE_SRD_DISABLE)
+		else if (val == DSM_VALUE_SRD_DISABLE)
 			config_bitmap |=
 				cpu_to_le32(LARI_CONFIG_CHANGE_ETSI_TO_DISABLED_MSK);
 	}
@@ -845,9 +852,7 @@ __le32 iwl_acpi_get_lari_config_bitmap(struct iwl_fw_runtime *fwrt)
 		/*
 		 ** Evaluate func 'DSM_FUNC_REGULATORY_CONFIG'
 		 */
-		ret = iwl_acpi_get_dsm_u32(fwrt->dev, 0,
-					   DSM_FUNC_REGULATORY_CONFIG,
-					   &iwl_guid, &val);
+		ret = iwl_acpi_get_dsm(fwrt, DSM_FUNC_REGULATORY_CONFIG, &val);
 		/*
 		 * China 2022 enable if the BIOS object does not exist or
 		 * if it is enabled in BIOS.
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.h b/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
index 8b64888052ad..d84952f90444 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
@@ -92,6 +92,8 @@
 /* The Inidcator whether UEFI WIFI GUID tables are locked is read from ACPI */
 #define UEFI_WIFI_GUID_UNLOCKED		0
 
+#define ACPI_DSM_REV 0
+
 enum iwl_dsm_funcs_rev_0 {
 	DSM_FUNC_QUERY = 0,
 	DSM_FUNC_DISABLE_SRD = 1,
@@ -103,7 +105,8 @@ enum iwl_dsm_funcs_rev_0 {
 	DSM_FUNC_ACTIVATE_CHANNEL = 8,
 	DSM_FUNC_FORCE_DISABLE_CHANNELS = 9,
 	DSM_FUNC_ENERGY_DETECTION_THRESHOLD = 10,
-	DSM_FUNC_RFI_CONFIG = 11
+	DSM_FUNC_RFI_CONFIG = 11,
+	DSM_FUNC_NUM_FUNCS = 12,
 };
 
 enum iwl_dsm_values_srd {
@@ -138,12 +141,6 @@ struct iwl_fw_runtime;
 
 extern const guid_t iwl_guid;
 
-int iwl_acpi_get_dsm_u8(struct device *dev, int rev, int func,
-			const guid_t *guid, u8 *value);
-
-int iwl_acpi_get_dsm_u32(struct device *dev, int rev, int func,
-			 const guid_t *guid, u32 *value);
-
 /**
  * iwl_acpi_get_mcc - read MCC from ACPI, if available
  *
@@ -185,6 +182,9 @@ void iwl_acpi_get_phy_filters(struct iwl_fw_runtime *fwrt,
 
 void iwl_acpi_get_guid_lock_status(struct iwl_fw_runtime *fwrt);
 
+int iwl_acpi_get_dsm(struct iwl_fw_runtime *fwrt,
+		     enum iwl_dsm_funcs_rev_0 func, u32 *value);
+
 #else /* CONFIG_ACPI */
 
 static inline void *iwl_acpi_get_dsm_object(struct device *dev, int rev,
@@ -193,18 +193,6 @@ static inline void *iwl_acpi_get_dsm_object(struct device *dev, int rev,
 	return ERR_PTR(-ENOENT);
 }
 
-static inline int iwl_acpi_get_dsm_u8(struct device *dev, int rev, int func,
-				      const guid_t *guid, u8 *value)
-{
-	return -ENOENT;
-}
-
-static inline int iwl_acpi_get_dsm_u32(struct device *dev, int rev, int func,
-				       const guid_t *guid, u32 *value)
-{
-	return -ENOENT;
-}
-
 static inline int iwl_acpi_get_mcc(struct iwl_fw_runtime *fwrt, char *mcc)
 {
 	return -ENOENT;
@@ -256,6 +244,13 @@ static inline void iwl_acpi_get_phy_filters(struct iwl_fw_runtime *fwrt,
 static inline void iwl_acpi_get_guid_lock_status(struct iwl_fw_runtime *fwrt)
 {
 }
+
+static inline int iwl_acpi_get_dsm(struct iwl_fw_runtime *fwrt,
+				   enum iwl_dsm_funcs_rev_0 func,
+				   u32 *value)
+{
+	return -ENOENT;
+}
 #endif /* CONFIG_ACPI */
 
 #endif /* __iwl_fw_acpi__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
index d67986e157a2..6f33f791648e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
@@ -391,9 +391,7 @@ static ssize_t iwl_dbgfs_wifi_6e_enable_read(struct file *file,
 	char buf[12];
 	u32 value;
 
-	err = iwl_acpi_get_dsm_u32(mvm->fwrt.dev, 0,
-				   DSM_FUNC_ENABLE_6E,
-				   &iwl_guid, &value);
+	err = iwl_acpi_get_dsm(&mvm->fwrt, DSM_FUNC_ENABLE_6E, &value);
 	if (err)
 		return err;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 77464620eafc..f8d7f23741bf 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -1203,12 +1203,11 @@ static void iwl_mvm_tas_init(struct iwl_mvm *mvm)
 
 static bool iwl_mvm_eval_dsm_rfi(struct iwl_mvm *mvm)
 {
-	u8 value = 0;
+	u32 value = 0;
 	/* default behaviour is disabled */
 	bool bios_enable_rfi = false;
-	int ret  = iwl_acpi_get_dsm_u8(mvm->fwrt.dev, 0,
-				       DSM_FUNC_RFI_CONFIG, &iwl_guid,
-				       &value);
+	int ret = iwl_acpi_get_dsm(&mvm->fwrt, DSM_FUNC_RFI_CONFIG, &value);
+
 
 	if (ret < 0) {
 		IWL_DEBUG_RADIO(mvm, "Failed to get DSM RFI, ret=%d\n", ret);
@@ -1245,41 +1244,32 @@ static void iwl_mvm_lari_cfg(struct iwl_mvm *mvm)
 
 	cmd.config_bitmap = iwl_acpi_get_lari_config_bitmap(&mvm->fwrt);
 
-	ret = iwl_acpi_get_dsm_u32(mvm->fwrt.dev, 0, DSM_FUNC_11AX_ENABLEMENT,
-				   &iwl_guid, &value);
+	ret = iwl_acpi_get_dsm(&mvm->fwrt, DSM_FUNC_11AX_ENABLEMENT, &value);
 	if (!ret)
 		cmd.oem_11ax_allow_bitmap = cpu_to_le32(value);
 
-	ret = iwl_acpi_get_dsm_u32(mvm->fwrt.dev, 0,
-				   DSM_FUNC_ENABLE_UNII4_CHAN,
-				   &iwl_guid, &value);
+	ret = iwl_acpi_get_dsm(&mvm->fwrt, DSM_FUNC_ENABLE_UNII4_CHAN, &value);
 	if (!ret)
 		cmd.oem_unii4_allow_bitmap = cpu_to_le32(value);
 
-	ret = iwl_acpi_get_dsm_u32(mvm->fwrt.dev, 0,
-				   DSM_FUNC_ACTIVATE_CHANNEL,
-				   &iwl_guid, &value);
+	ret = iwl_acpi_get_dsm(&mvm->fwrt, DSM_FUNC_ACTIVATE_CHANNEL, &value);
 	if (!ret) {
 		if (cmd_ver < 8)
 			value &= ~ACTIVATE_5G2_IN_WW_MASK;
 		cmd.chan_state_active_bitmap = cpu_to_le32(value);
 	}
 
-	ret = iwl_acpi_get_dsm_u32(mvm->fwrt.dev, 0,
-				   DSM_FUNC_ENABLE_6E,
-				   &iwl_guid, &value);
+	ret = iwl_acpi_get_dsm(&mvm->fwrt, DSM_FUNC_ENABLE_6E, &value);
 	if (!ret)
 		cmd.oem_uhb_allow_bitmap = cpu_to_le32(value);
 
-	ret = iwl_acpi_get_dsm_u32(mvm->fwrt.dev, 0,
-				   DSM_FUNC_FORCE_DISABLE_CHANNELS,
-				   &iwl_guid, &value);
+	ret = iwl_acpi_get_dsm(&mvm->fwrt, DSM_FUNC_FORCE_DISABLE_CHANNELS,
+			       &value);
 	if (!ret)
 		cmd.force_disable_channels_bitmap = cpu_to_le32(value);
 
-	ret = iwl_acpi_get_dsm_u32(mvm->fwrt.dev, 0,
-				   DSM_FUNC_ENERGY_DETECTION_THRESHOLD,
-				   &iwl_guid, &value);
+	ret = iwl_acpi_get_dsm(&mvm->fwrt, DSM_FUNC_ENERGY_DETECTION_THRESHOLD,
+			       &value);
 	if (!ret)
 		cmd.edt_bitmap = cpu_to_le32(value);
 
-- 
2.34.1


