Return-Path: <linux-wireless+bounces-2871-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7E498438E9
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jan 2024 09:25:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB5771C26EA2
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jan 2024 08:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F74D63504;
	Wed, 31 Jan 2024 08:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qn6AZSrM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802D360ECB
	for <linux-wireless@vger.kernel.org>; Wed, 31 Jan 2024 08:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706689511; cv=none; b=KY6col8zXZwPdZ0LSZEaBfeP3f3vmONOGfR8hS03PoT2j0WYW+frBgSAYJcxoMum2riurGmX9UR9/lySZnfOlW+84gKQ0wkS6pQ61lBhcIgXymrv7s7wi7+NK0aJqGJQNW3mcig6a6JJUG06gO4iIxXEXYP3aOyg/lJ7aoisuHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706689511; c=relaxed/simple;
	bh=6d3TKEYX7rVqcIq/Be1TvyssOePKz3Tl4aE9X/NEAMk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o5lsKyzwNJrENwCi3h+hyHy5qLWapuR4/JLBRodXG2kZj03+uU2fWDXH6dYtXYaIjhzAVTKAGh8ftgjWvYxv8ZWmQ2I+KZruBy/nyw4DBvvRzCaGWKff2An/25a/T2mXkAQZ5DaEUtaRN4CcorPXB+KXuVlFfWmRwdVh3OprfOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qn6AZSrM; arc=none smtp.client-ip=134.134.136.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706689508; x=1738225508;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6d3TKEYX7rVqcIq/Be1TvyssOePKz3Tl4aE9X/NEAMk=;
  b=Qn6AZSrMPrZTkTsT4WqNlOqySZvSjklnS6ThBETsuxYwlrB5gsJ/DNYY
   KQBJmJ0JqhKlqqP6pCIXKyxHt6FrtRcQCigPBegIuu3bYQA90wX3yBJlQ
   sEhk/MpKv9eI8nR5m0XThVkVX5bMzpFuhL4o8tqV9W6Ol6dretzQ6D3FT
   Sc5IKswfVo5lVZgbgwiPF/jDikUS1eDQ7RYudsRJVoPR0Tk8Ug4kLHGxG
   UzN7VRks4JzD5q43CeFf+lK6yvQl+gJfIHt+YAuo10ETwP2T2Uwv2hhoM
   d1dmu7omqAo4s2srJ6AVV2lxeFUQR7qhw6tX7a5GY7cto0WnlsTH45IKp
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="407249914"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="407249914"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 00:25:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="3968870"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 00:25:06 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 04/14] wifi: iwlwifi: prepare for reading SAR tables from UEFI
Date: Wed, 31 Jan 2024 10:24:37 +0200
Message-Id: <20240131091413.429a9baff34a.I040460348aa1b43609be3a317b86722d6be71c28@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240131082447.1372353-1-miriam.rachel.korenblit@intel.com>
References: <20240131082447.1372353-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

The driver will support reading BIOS tables from UEFI
too. Refactor the SAR tables (WRDS, EWRD, WGDS) flows:

1. Move all the SAR logic/definitions that is common to both
   UEFI and ACPI to a new file - regulatory.h/c.
2. Rename the relevant functions/definitions
   so it will be clear which is ACPI specific and which is
   for both ACPI and UEFI
3. Rename the function that copies the stored tables into the different
   commands structures, so will be clear what these functions do.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/Makefile   |   1 +
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c  | 165 +++---------------
 drivers/net/wireless/intel/iwlwifi/fw/acpi.h  |  55 +-----
 .../wireless/intel/iwlwifi/fw/regulatory.c    | 132 ++++++++++++++
 .../wireless/intel/iwlwifi/fw/regulatory.h    |  90 ++++++++++
 .../net/wireless/intel/iwlwifi/fw/runtime.h   |   7 +-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   |  32 ++--
 7 files changed, 273 insertions(+), 209 deletions(-)
 create mode 100644 drivers/net/wireless/intel/iwlwifi/fw/regulatory.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/fw/regulatory.h

diff --git a/drivers/net/wireless/intel/iwlwifi/Makefile b/drivers/net/wireless/intel/iwlwifi/Makefile
index 3a2a25333d36..8bb94a4c12cd 100644
--- a/drivers/net/wireless/intel/iwlwifi/Makefile
+++ b/drivers/net/wireless/intel/iwlwifi/Makefile
@@ -18,6 +18,7 @@ iwlwifi-objs		+= queue/tx.o
 
 iwlwifi-objs		+= fw/img.o fw/notif-wait.o fw/rs.o
 iwlwifi-objs		+= fw/dbg.o fw/pnvm.o fw/dump.o
+iwlwifi-objs		+= fw/regulatory.o
 iwlwifi-$(CONFIG_IWLMVM) += fw/paging.o fw/smem.o fw/init.o
 iwlwifi-$(CONFIG_ACPI) += fw/acpi.o
 iwlwifi-$(CONFIG_EFI)	+= fw/uefi.o
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
index 9be91e6a9882..401aca31704c 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
@@ -501,9 +501,10 @@ int iwl_acpi_get_eckv(struct device *dev, u32 *extl_clk)
 }
 IWL_EXPORT_SYMBOL(iwl_acpi_get_eckv);
 
-static int iwl_sar_set_profile(union acpi_object *table,
-			       struct iwl_sar_profile *profile,
-			       bool enabled, u8 num_chains, u8 num_sub_bands)
+static int iwl_acpi_sar_set_profile(union acpi_object *table,
+				    struct iwl_sar_profile *profile,
+				    bool enabled, u8 num_chains,
+				    u8 num_sub_bands)
 {
 	int i, j, idx = 0;
 
@@ -511,8 +512,8 @@ static int iwl_sar_set_profile(union acpi_object *table,
 	 * The table from ACPI is flat, but we store it in a
 	 * structured array.
 	 */
-	for (i = 0; i < ACPI_SAR_NUM_CHAINS_REV2; i++) {
-		for (j = 0; j < ACPI_SAR_NUM_SUB_BANDS_REV2; j++) {
+	for (i = 0; i < BIOS_SAR_MAX_CHAINS_PER_PROFILE; i++) {
+		for (j = 0; j < BIOS_SAR_MAX_SUB_BANDS_NUM; j++) {
 			/* if we don't have the values, use the default */
 			if (i >= num_chains || j >= num_sub_bands) {
 				profile->chains[i].subbands[j] = 0;
@@ -535,73 +536,7 @@ static int iwl_sar_set_profile(union acpi_object *table,
 	return 0;
 }
 
-static int iwl_sar_fill_table(struct iwl_fw_runtime *fwrt,
-			      __le16 *per_chain, u32 n_subbands,
-			      int prof_a, int prof_b)
-{
-	int profs[ACPI_SAR_NUM_CHAINS_REV0] = { prof_a, prof_b };
-	int i, j;
-
-	for (i = 0; i < ACPI_SAR_NUM_CHAINS_REV0; i++) {
-		struct iwl_sar_profile *prof;
-
-		/* don't allow SAR to be disabled (profile 0 means disable) */
-		if (profs[i] == 0)
-			return -EPERM;
-
-		/* we are off by one, so allow up to ACPI_SAR_PROFILE_NUM */
-		if (profs[i] > ACPI_SAR_PROFILE_NUM)
-			return -EINVAL;
-
-		/* profiles go from 1 to 4, so decrement to access the array */
-		prof = &fwrt->sar_profiles[profs[i] - 1];
-
-		/* if the profile is disabled, do nothing */
-		if (!prof->enabled) {
-			IWL_DEBUG_RADIO(fwrt, "SAR profile %d is disabled.\n",
-					profs[i]);
-			/*
-			 * if one of the profiles is disabled, we
-			 * ignore all of them and return 1 to
-			 * differentiate disabled from other failures.
-			 */
-			return 1;
-		}
-
-		IWL_DEBUG_INFO(fwrt,
-			       "SAR EWRD: chain %d profile index %d\n",
-			       i, profs[i]);
-		IWL_DEBUG_RADIO(fwrt, "  Chain[%d]:\n", i);
-		for (j = 0; j < n_subbands; j++) {
-			per_chain[i * n_subbands + j] =
-				cpu_to_le16(prof->chains[i].subbands[j]);
-			IWL_DEBUG_RADIO(fwrt, "    Band[%d] = %d * .125dBm\n",
-					j, prof->chains[i].subbands[j]);
-		}
-	}
-
-	return 0;
-}
-
-int iwl_sar_select_profile(struct iwl_fw_runtime *fwrt,
-			   __le16 *per_chain, u32 n_tables, u32 n_subbands,
-			   int prof_a, int prof_b)
-{
-	int i, ret = 0;
-
-	for (i = 0; i < n_tables; i++) {
-		ret = iwl_sar_fill_table(fwrt,
-			 &per_chain[i * n_subbands * ACPI_SAR_NUM_CHAINS_REV0],
-			 n_subbands, prof_a, prof_b);
-		if (ret)
-			break;
-	}
-
-	return ret;
-}
-IWL_EXPORT_SYMBOL(iwl_sar_select_profile);
-
-int iwl_sar_get_wrds_table(struct iwl_fw_runtime *fwrt)
+int iwl_acpi_get_wrds_table(struct iwl_fw_runtime *fwrt)
 {
 	union acpi_object *wifi_pkg, *table, *data;
 	int ret, tbl_rev;
@@ -680,16 +615,16 @@ int iwl_sar_get_wrds_table(struct iwl_fw_runtime *fwrt)
 	/* The profile from WRDS is officially profile 1, but goes
 	 * into sar_profiles[0] (because we don't have a profile 0).
 	 */
-	ret = iwl_sar_set_profile(table, &fwrt->sar_profiles[0],
-				  flags & IWL_SAR_ENABLE_MSK,
-				  num_chains, num_sub_bands);
+	ret = iwl_acpi_sar_set_profile(table, &fwrt->sar_profiles[0],
+				       flags & IWL_SAR_ENABLE_MSK,
+				       num_chains, num_sub_bands);
 out_free:
 	kfree(data);
 	return ret;
 }
-IWL_EXPORT_SYMBOL(iwl_sar_get_wrds_table);
+IWL_EXPORT_SYMBOL(iwl_acpi_get_wrds_table);
 
-int iwl_sar_get_ewrd_table(struct iwl_fw_runtime *fwrt)
+int iwl_acpi_get_ewrd_table(struct iwl_fw_runtime *fwrt)
 {
 	union acpi_object *wifi_pkg, *data;
 	bool enabled;
@@ -767,7 +702,7 @@ int iwl_sar_get_ewrd_table(struct iwl_fw_runtime *fwrt)
 	 * from index 1, so the maximum value allowed here is
 	 * ACPI_SAR_PROFILES_NUM - 1.
 	 */
-	if (n_profiles >= ACPI_SAR_PROFILE_NUM) {
+	if (n_profiles >= BIOS_SAR_MAX_PROFILE_NUM) {
 		ret = -EINVAL;
 		goto out_free;
 	}
@@ -776,13 +711,15 @@ int iwl_sar_get_ewrd_table(struct iwl_fw_runtime *fwrt)
 	pos = 3;
 
 	for (i = 0; i < n_profiles; i++) {
+		union acpi_object *table = &wifi_pkg->package.elements[pos];
 		/* The EWRD profiles officially go from 2 to 4, but we
 		 * save them in sar_profiles[1-3] (because we don't
 		 * have profile 0).  So in the array we start from 1.
 		 */
-		ret = iwl_sar_set_profile(&wifi_pkg->package.elements[pos],
-					  &fwrt->sar_profiles[i + 1], enabled,
-					  num_chains, num_sub_bands);
+		ret = iwl_acpi_sar_set_profile(table,
+					       &fwrt->sar_profiles[i + 1],
+					       enabled, num_chains,
+					       num_sub_bands);
 		if (ret < 0)
 			break;
 
@@ -794,9 +731,9 @@ int iwl_sar_get_ewrd_table(struct iwl_fw_runtime *fwrt)
 	kfree(data);
 	return ret;
 }
-IWL_EXPORT_SYMBOL(iwl_sar_get_ewrd_table);
+IWL_EXPORT_SYMBOL(iwl_acpi_get_ewrd_table);
 
-int iwl_sar_get_wgds_table(struct iwl_fw_runtime *fwrt)
+int iwl_acpi_get_wgds_table(struct iwl_fw_runtime *fwrt)
 {
 	union acpi_object *wifi_pkg, *data;
 	int i, j, k, ret, tbl_rev;
@@ -897,7 +834,7 @@ int iwl_sar_get_wgds_table(struct iwl_fw_runtime *fwrt)
 read_table:
 	fwrt->geo_rev = tbl_rev;
 	for (i = 0; i < num_profiles; i++) {
-		for (j = 0; j < ACPI_GEO_NUM_BANDS_REV2; j++) {
+		for (j = 0; j < BIOS_GEO_MAX_NUM_BANDS; j++) {
 			union acpi_object *entry;
 
 			/*
@@ -921,7 +858,7 @@ int iwl_sar_get_wgds_table(struct iwl_fw_runtime *fwrt)
 					entry->integer.value;
 			}
 
-			for (k = 0; k < ACPI_GEO_NUM_CHAINS; k++) {
+			for (k = 0; k < BIOS_GEO_NUM_CHAINS; k++) {
 				/* same here as above */
 				if (j >= num_bands) {
 					fwrt->geo_profiles[i].bands[j].chains[k] =
@@ -949,63 +886,7 @@ int iwl_sar_get_wgds_table(struct iwl_fw_runtime *fwrt)
 	kfree(data);
 	return ret;
 }
-IWL_EXPORT_SYMBOL(iwl_sar_get_wgds_table);
-
-bool iwl_sar_geo_support(struct iwl_fw_runtime *fwrt)
-{
-	/*
-	 * The PER_CHAIN_LIMIT_OFFSET_CMD command is not supported on
-	 * earlier firmware versions.  Unfortunately, we don't have a
-	 * TLV API flag to rely on, so rely on the major version which
-	 * is in the first byte of ucode_ver.  This was implemented
-	 * initially on version 38 and then backported to 17.  It was
-	 * also backported to 29, but only for 7265D devices.  The
-	 * intention was to have it in 36 as well, but not all 8000
-	 * family got this feature enabled.  The 8000 family is the
-	 * only one using version 36, so skip this version entirely.
-	 */
-	return IWL_UCODE_SERIAL(fwrt->fw->ucode_ver) >= 38 ||
-		(IWL_UCODE_SERIAL(fwrt->fw->ucode_ver) == 17 &&
-		 fwrt->trans->hw_rev != CSR_HW_REV_TYPE_3160) ||
-		(IWL_UCODE_SERIAL(fwrt->fw->ucode_ver) == 29 &&
-		 ((fwrt->trans->hw_rev & CSR_HW_REV_TYPE_MSK) ==
-		  CSR_HW_REV_TYPE_7265D));
-}
-IWL_EXPORT_SYMBOL(iwl_sar_geo_support);
-
-int iwl_sar_geo_init(struct iwl_fw_runtime *fwrt,
-		     struct iwl_per_chain_offset *table,
-		     u32 n_bands, u32 n_profiles)
-{
-	int i, j;
-
-	if (!fwrt->geo_enabled)
-		return -ENODATA;
-
-	if (!iwl_sar_geo_support(fwrt))
-		return -EOPNOTSUPP;
-
-	for (i = 0; i < n_profiles; i++) {
-		for (j = 0; j < n_bands; j++) {
-			struct iwl_per_chain_offset *chain =
-				&table[i * n_bands + j];
-
-			chain->max_tx_power =
-				cpu_to_le16(fwrt->geo_profiles[i].bands[j].max);
-			chain->chain_a = fwrt->geo_profiles[i].bands[j].chains[0];
-			chain->chain_b = fwrt->geo_profiles[i].bands[j].chains[1];
-			IWL_DEBUG_RADIO(fwrt,
-					"SAR geographic profile[%d] Band[%d]: chain A = %d chain B = %d max_tx_power = %d\n",
-					i, j,
-					fwrt->geo_profiles[i].bands[j].chains[0],
-					fwrt->geo_profiles[i].bands[j].chains[1],
-					fwrt->geo_profiles[i].bands[j].max);
-		}
-	}
-
-	return 0;
-}
-IWL_EXPORT_SYMBOL(iwl_sar_geo_init);
+IWL_EXPORT_SYMBOL(iwl_acpi_get_wgds_table);
 
 __le32 iwl_acpi_get_lari_config_bitmap(struct iwl_fw_runtime *fwrt)
 {
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.h b/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
index 7b3c6fca7591..ba7626543b70 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
@@ -62,7 +62,6 @@
 /* revision 0 and 1 are identical, except for the semantics in the FW */
 #define ACPI_GEO_NUM_BANDS_REV0		2
 #define ACPI_GEO_NUM_BANDS_REV2		3
-#define ACPI_GEO_NUM_CHAINS		2
 
 #define ACPI_WRDD_WIFI_DATA_SIZE	2
 #define ACPI_SPLC_WIFI_DATA_SIZE	2
@@ -111,26 +110,6 @@
  * turn a superset of revision 0.  So we can store all revisions
  * inside revision 2, which is what we represent here.
  */
-struct iwl_sar_profile_chain {
-	u8 subbands[ACPI_SAR_NUM_SUB_BANDS_REV2];
-};
-
-struct iwl_sar_profile {
-	bool enabled;
-	struct iwl_sar_profile_chain chains[ACPI_SAR_NUM_CHAINS_REV2];
-};
-
-/* Same thing as with SAR, all revisions fit in revision 2 */
-struct iwl_geo_profile_band {
-	u8 max;
-	u8 chains[ACPI_GEO_NUM_CHAINS];
-};
-
-struct iwl_geo_profile {
-	struct iwl_geo_profile_band bands[ACPI_GEO_NUM_BANDS_REV2];
-};
-
-/* Same thing as with SAR, all revisions fit in revision 2 */
 struct iwl_ppag_chain {
 	s8 subbands[ACPI_SAR_NUM_SUB_BANDS_REV2];
 };
@@ -212,21 +191,11 @@ u64 iwl_acpi_get_pwr_limit(struct device *dev);
  */
 int iwl_acpi_get_eckv(struct device *dev, u32 *extl_clk);
 
-int iwl_sar_select_profile(struct iwl_fw_runtime *fwrt,
-			   __le16 *per_chain, u32 n_tables, u32 n_subbands,
-			   int prof_a, int prof_b);
-
-int iwl_sar_get_wrds_table(struct iwl_fw_runtime *fwrt);
-
-int iwl_sar_get_ewrd_table(struct iwl_fw_runtime *fwrt);
+int iwl_acpi_get_wrds_table(struct iwl_fw_runtime *fwrt);
 
-int iwl_sar_get_wgds_table(struct iwl_fw_runtime *fwrt);
+int iwl_acpi_get_ewrd_table(struct iwl_fw_runtime *fwrt);
 
-bool iwl_sar_geo_support(struct iwl_fw_runtime *fwrt);
-
-int iwl_sar_geo_init(struct iwl_fw_runtime *fwrt,
-		     struct iwl_per_chain_offset *table,
-		     u32 n_bands, u32 n_profiles);
+int iwl_acpi_get_wgds_table(struct iwl_fw_runtime *fwrt);
 
 int iwl_acpi_get_tas(struct iwl_fw_runtime *fwrt,
 		     union iwl_tas_config_cmd *cmd, int fw_ver);
@@ -280,33 +249,21 @@ static inline int iwl_acpi_get_eckv(struct device *dev, u32 *extl_clk)
 	return -ENOENT;
 }
 
-static inline int iwl_sar_select_profile(struct iwl_fw_runtime *fwrt,
-			   __le16 *per_chain, u32 n_tables, u32 n_subbands,
-			   int prof_a, int prof_b)
-{
-	return -ENOENT;
-}
-
-static inline int iwl_sar_get_wrds_table(struct iwl_fw_runtime *fwrt)
+static inline int iwl_acpi_get_wrds_table(struct iwl_fw_runtime *fwrt)
 {
 	return -ENOENT;
 }
 
-static inline int iwl_sar_get_ewrd_table(struct iwl_fw_runtime *fwrt)
+static inline int iwl_acpi_get_ewrd_table(struct iwl_fw_runtime *fwrt)
 {
 	return -ENOENT;
 }
 
-static inline int iwl_sar_get_wgds_table(struct iwl_fw_runtime *fwrt)
+static inline int iwl_acpi_get_wgds_table(struct iwl_fw_runtime *fwrt)
 {
 	return 1;
 }
 
-static inline bool iwl_sar_geo_support(struct iwl_fw_runtime *fwrt)
-{
-	return false;
-}
-
 static inline int iwl_acpi_get_tas(struct iwl_fw_runtime *fwrt,
 				   union iwl_tas_config_cmd *cmd, int fw_ver)
 {
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c
new file mode 100644
index 000000000000..58290bf64f42
--- /dev/null
+++ b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c
@@ -0,0 +1,132 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/*
+ * Copyright (C) 2023 Intel Corporation
+ */
+#include "iwl-drv.h"
+#include "iwl-debug.h"
+#include "regulatory.h"
+#include "fw/runtime.h"
+
+bool iwl_sar_geo_support(struct iwl_fw_runtime *fwrt)
+{
+	/*
+	 * The PER_CHAIN_LIMIT_OFFSET_CMD command is not supported on
+	 * earlier firmware versions.  Unfortunately, we don't have a
+	 * TLV API flag to rely on, so rely on the major version which
+	 * is in the first byte of ucode_ver.  This was implemented
+	 * initially on version 38 and then backported to 17.  It was
+	 * also backported to 29, but only for 7265D devices.  The
+	 * intention was to have it in 36 as well, but not all 8000
+	 * family got this feature enabled.  The 8000 family is the
+	 * only one using version 36, so skip this version entirely.
+	 */
+	return IWL_UCODE_SERIAL(fwrt->fw->ucode_ver) >= 38 ||
+		(IWL_UCODE_SERIAL(fwrt->fw->ucode_ver) == 17 &&
+		 fwrt->trans->hw_rev != CSR_HW_REV_TYPE_3160) ||
+		(IWL_UCODE_SERIAL(fwrt->fw->ucode_ver) == 29 &&
+		 ((fwrt->trans->hw_rev & CSR_HW_REV_TYPE_MSK) ==
+		  CSR_HW_REV_TYPE_7265D));
+}
+IWL_EXPORT_SYMBOL(iwl_sar_geo_support);
+
+int iwl_sar_geo_fill_table(struct iwl_fw_runtime *fwrt,
+			   struct iwl_per_chain_offset *table,
+			   u32 n_bands, u32 n_profiles)
+{
+	int i, j;
+
+	if (!fwrt->geo_enabled)
+		return -ENODATA;
+
+	if (!iwl_sar_geo_support(fwrt))
+		return -EOPNOTSUPP;
+
+	for (i = 0; i < n_profiles; i++) {
+		for (j = 0; j < n_bands; j++) {
+			struct iwl_per_chain_offset *chain =
+				&table[i * n_bands + j];
+
+			chain->max_tx_power =
+				cpu_to_le16(fwrt->geo_profiles[i].bands[j].max);
+			chain->chain_a =
+				fwrt->geo_profiles[i].bands[j].chains[0];
+			chain->chain_b =
+				fwrt->geo_profiles[i].bands[j].chains[1];
+			IWL_DEBUG_RADIO(fwrt,
+					"SAR geographic profile[%d] Band[%d]: chain A = %d chain B = %d max_tx_power = %d\n",
+					i, j,
+					fwrt->geo_profiles[i].bands[j].chains[0],
+					fwrt->geo_profiles[i].bands[j].chains[1],
+					fwrt->geo_profiles[i].bands[j].max);
+		}
+	}
+
+	return 0;
+}
+IWL_EXPORT_SYMBOL(iwl_sar_geo_fill_table);
+
+static int iwl_sar_fill_table(struct iwl_fw_runtime *fwrt,
+			      __le16 *per_chain, u32 n_subbands,
+			      int prof_a, int prof_b)
+{
+	int profs[BIOS_SAR_NUM_CHAINS] = { prof_a, prof_b };
+	int i, j;
+
+	for (i = 0; i < BIOS_SAR_NUM_CHAINS; i++) {
+		struct iwl_sar_profile *prof;
+
+		/* don't allow SAR to be disabled (profile 0 means disable) */
+		if (profs[i] == 0)
+			return -EPERM;
+
+		/* we are off by one, so allow up to BIOS_SAR_MAX_PROFILE_NUM */
+		if (profs[i] > BIOS_SAR_MAX_PROFILE_NUM)
+			return -EINVAL;
+
+		/* profiles go from 1 to 4, so decrement to access the array */
+		prof = &fwrt->sar_profiles[profs[i] - 1];
+
+		/* if the profile is disabled, do nothing */
+		if (!prof->enabled) {
+			IWL_DEBUG_RADIO(fwrt, "SAR profile %d is disabled.\n",
+					profs[i]);
+			/*
+			 * if one of the profiles is disabled, we
+			 * ignore all of them and return 1 to
+			 * differentiate disabled from other failures.
+			 */
+			return 1;
+		}
+
+		IWL_DEBUG_INFO(fwrt,
+			       "SAR EWRD: chain %d profile index %d\n",
+			       i, profs[i]);
+		IWL_DEBUG_RADIO(fwrt, "  Chain[%d]:\n", i);
+		for (j = 0; j < n_subbands; j++) {
+			per_chain[i * n_subbands + j] =
+				cpu_to_le16(prof->chains[i].subbands[j]);
+			IWL_DEBUG_RADIO(fwrt, "    Band[%d] = %d * .125dBm\n",
+					j, prof->chains[i].subbands[j]);
+		}
+	}
+
+	return 0;
+}
+
+int iwl_sar_fill_profile(struct iwl_fw_runtime *fwrt,
+			 __le16 *per_chain, u32 n_tables, u32 n_subbands,
+			 int prof_a, int prof_b)
+{
+	int i, ret = 0;
+
+	for (i = 0; i < n_tables; i++) {
+		ret = iwl_sar_fill_table(fwrt,
+			&per_chain[i * n_subbands * BIOS_SAR_NUM_CHAINS],
+			n_subbands, prof_a, prof_b);
+		if (ret)
+			break;
+	}
+
+	return ret;
+}
+IWL_EXPORT_SYMBOL(iwl_sar_fill_profile);
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h
new file mode 100644
index 000000000000..650430f21510
--- /dev/null
+++ b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h
@@ -0,0 +1,90 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/*
+ * Copyright (C) 2023 Intel Corporation
+ */
+
+#ifndef __fw_regulatory_h__
+#define __fw_regulatory_h__
+
+#include "fw/img.h"
+#include "fw/api/commands.h"
+#include "fw/api/power.h"
+#include "fw/api/phy.h"
+#include "fw/api/nvm-reg.h"
+#include "fw/api/config.h"
+#include "fw/img.h"
+#include "iwl-trans.h"
+
+#define BIOS_SAR_MAX_PROFILE_NUM	4
+/*
+ * Each SAR profile has (up to, depends on the table revision) 4 chains:
+ * chain A, chain B, chain A when in CDB, chain B when in CDB
+ */
+#define BIOS_SAR_MAX_CHAINS_PER_PROFILE 4
+#define BIOS_SAR_NUM_CHAINS             2
+#define BIOS_SAR_MAX_SUB_BANDS_NUM      11
+
+#define BIOS_GEO_NUM_CHAINS		2
+#define BIOS_GEO_MAX_NUM_BANDS		3
+#define BIOS_GEO_MAX_PROFILE_NUM	8
+#define BIOS_GEO_MIN_PROFILE_NUM	3
+
+#define IWL_SAR_ENABLE_MSK		BIT(0)
+
+/*
+ * The profile for revision 2 is a superset of revision 1, which is in
+ * turn a superset of revision 0.  So we can store all revisions
+ * inside revision 2, which is what we represent here.
+ */
+
+/*
+ * struct iwl_sar_profile_chain - per-chain values of a SAR profile
+ * @subbands: the SAR value for each subband
+ */
+struct iwl_sar_profile_chain {
+	u8 subbands[BIOS_SAR_MAX_SUB_BANDS_NUM];
+};
+
+/*
+ * struct iwl_sar_profile - SAR profile from SAR tables
+ * @enabled: whether the profile is enabled or not
+ * @chains: per-chain SAR values
+ */
+struct iwl_sar_profile {
+	bool enabled;
+	struct iwl_sar_profile_chain chains[BIOS_SAR_MAX_CHAINS_PER_PROFILE];
+};
+
+/* Same thing as with SAR, all revisions fit in revision 2 */
+
+/*
+ * struct iwl_geo_profile_band - per-band geo SAR offsets
+ * @max: the max tx power allowed for the band
+ * @chains: SAR offsets values for each chain
+ */
+struct iwl_geo_profile_band {
+	u8 max;
+	u8 chains[BIOS_GEO_NUM_CHAINS];
+};
+
+/*
+ * struct iwl_geo_profile - geo profile
+ * @bands: per-band table of the SAR offsets
+ */
+struct iwl_geo_profile {
+	struct iwl_geo_profile_band bands[BIOS_GEO_MAX_NUM_BANDS];
+};
+
+struct iwl_fw_runtime;
+
+bool iwl_sar_geo_support(struct iwl_fw_runtime *fwrt);
+
+int iwl_sar_geo_fill_table(struct iwl_fw_runtime *fwrt,
+			   struct iwl_per_chain_offset *table,
+			   u32 n_bands, u32 n_profiles);
+
+int iwl_sar_fill_profile(struct iwl_fw_runtime *fwrt,
+			 __le16 *per_chain, u32 n_tables, u32 n_subbands,
+			 int prof_a, int prof_b);
+
+#endif /* __fw_regulatory_h__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/runtime.h b/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
index 048830bb09f2..08734f48443e 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
@@ -14,6 +14,7 @@
 #include "fw/api/power.h"
 #include "iwl-eeprom-parse.h"
 #include "fw/acpi.h"
+#include "fw/regulatory.h"
 
 struct iwl_fw_runtime_ops {
 	void (*dump_start)(void *ctx);
@@ -103,6 +104,8 @@ struct iwl_txf_iter_data {
  * @uefi_tables_lock_status: The status of the WIFI GUID UEFI variables lock:
  *	0: Unlocked, 1 and 2: Locked.
  *	Only read the UEFI variables if locked.
+ * @sar_profiles: sar profiles as read from WRDS/EWRD BIOS tables
+ * @geo_profiles: geographic profiles as read from WGDS BIOS table
  */
 struct iwl_fw_runtime {
 	struct iwl_trans *trans;
@@ -162,10 +165,10 @@ struct iwl_fw_runtime {
 	bool tpc_enabled;
 #endif /* CONFIG_IWLWIFI_DEBUGFS */
 #ifdef CONFIG_ACPI
-	struct iwl_sar_profile sar_profiles[ACPI_SAR_PROFILE_NUM];
+	struct iwl_sar_profile sar_profiles[BIOS_SAR_MAX_PROFILE_NUM];
 	u8 sar_chain_a_profile;
 	u8 sar_chain_b_profile;
-	struct iwl_geo_profile geo_profiles[ACPI_NUM_GEO_PROFILES_REV3];
+	struct iwl_geo_profile geo_profiles[BIOS_GEO_MAX_PROFILE_NUM];
 	u32 geo_rev;
 	u32 geo_num_profiles;
 	bool geo_enabled;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index a6db290923cd..f8ab31f9d109 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -936,9 +936,9 @@ int iwl_mvm_sar_select_profile(struct iwl_mvm *mvm, int prof_a, int prof_b)
 	/* all structs have the same common part, add it */
 	len += sizeof(cmd.common);
 
-	ret = iwl_sar_select_profile(&mvm->fwrt, per_chain,
-				     IWL_NUM_CHAIN_TABLES,
-				     n_subbands, prof_a, prof_b);
+	ret = iwl_sar_fill_profile(&mvm->fwrt, per_chain,
+				   IWL_NUM_CHAIN_TABLES,
+				   n_subbands, prof_a, prof_b);
 
 	/* return on error or if the profile is disabled (positive number) */
 	if (ret)
@@ -994,7 +994,7 @@ int iwl_mvm_get_sar_geo_profile(struct iwl_mvm *mvm)
 	resp = (void *)cmd.resp_pkt->data;
 	ret = le32_to_cpu(resp->profile_idx);
 
-	if (WARN_ON(ret > ACPI_NUM_GEO_PROFILES_REV3))
+	if (WARN_ON(ret > BIOS_GEO_MAX_PROFILE_NUM))
 		ret = -EIO;
 
 	iwl_free_resp(&cmd);
@@ -1028,24 +1028,24 @@ static int iwl_mvm_sar_geo_init(struct iwl_mvm *mvm)
 	if (cmd_ver == 5) {
 		len = sizeof(cmd.v5);
 		n_bands = ARRAY_SIZE(cmd.v5.table[0]);
-		n_profiles = ACPI_NUM_GEO_PROFILES_REV3;
+		n_profiles = BIOS_GEO_MAX_PROFILE_NUM;
 	} else if (cmd_ver == 4) {
 		len = sizeof(cmd.v4);
 		n_bands = ARRAY_SIZE(cmd.v4.table[0]);
-		n_profiles = ACPI_NUM_GEO_PROFILES_REV3;
+		n_profiles = BIOS_GEO_MAX_PROFILE_NUM;
 	} else if (cmd_ver == 3) {
 		len = sizeof(cmd.v3);
 		n_bands = ARRAY_SIZE(cmd.v3.table[0]);
-		n_profiles = ACPI_NUM_GEO_PROFILES;
+		n_profiles = BIOS_GEO_MIN_PROFILE_NUM;
 	} else if (fw_has_api(&mvm->fwrt.fw->ucode_capa,
 			      IWL_UCODE_TLV_API_SAR_TABLE_VER)) {
 		len = sizeof(cmd.v2);
 		n_bands = ARRAY_SIZE(cmd.v2.table[0]);
-		n_profiles = ACPI_NUM_GEO_PROFILES;
+		n_profiles = BIOS_GEO_MIN_PROFILE_NUM;
 	} else {
 		len = sizeof(cmd.v1);
 		n_bands = ARRAY_SIZE(cmd.v1.table[0]);
-		n_profiles = ACPI_NUM_GEO_PROFILES;
+		n_profiles = BIOS_GEO_MIN_PROFILE_NUM;
 	}
 
 	BUILD_BUG_ON(offsetof(struct iwl_geo_tx_power_profiles_cmd_v1, table) !=
@@ -1057,8 +1057,8 @@ static int iwl_mvm_sar_geo_init(struct iwl_mvm *mvm)
 		     offsetof(struct iwl_geo_tx_power_profiles_cmd_v4, table) !=
 		     offsetof(struct iwl_geo_tx_power_profiles_cmd_v5, table));
 	/* the table is at the same position for all versions, so set use v1 */
-	ret = iwl_sar_geo_init(&mvm->fwrt, &cmd.v1.table[0][0],
-			       n_bands, n_profiles);
+	ret = iwl_sar_geo_fill_table(&mvm->fwrt, &cmd.v1.table[0][0],
+				     n_bands, n_profiles);
 
 	/*
 	 * It is a valid scenario to not support SAR, or miss wgds table,
@@ -1076,7 +1076,7 @@ static int iwl_mvm_sar_geo_init(struct iwl_mvm *mvm)
 	 * element name is misleading, as it doesn't contain the table
 	 * revision number, but whether the South Korea variation
 	 * should be used.
-	 * This must be done after calling iwl_sar_geo_init().
+	 * This must be done after calling iwl_sar_geo_fill_table().
 	 */
 	if (cmd_ver == 5)
 		cmd.v5.table_revision = cpu_to_le32(sk);
@@ -1413,7 +1413,7 @@ void iwl_mvm_get_acpi_tables(struct iwl_mvm *mvm)
 	}
 
 	/* read SAR tables */
-	ret = iwl_sar_get_wrds_table(&mvm->fwrt);
+	ret = iwl_acpi_get_wrds_table(&mvm->fwrt);
 	if (ret < 0) {
 		IWL_DEBUG_RADIO(mvm,
 				"WRDS SAR BIOS table invalid or unavailable. (%d)\n",
@@ -1422,7 +1422,7 @@ void iwl_mvm_get_acpi_tables(struct iwl_mvm *mvm)
 		 * If not available, don't fail and don't bother with EWRD and
 		 * WGDS */
 
-		if (!iwl_sar_get_wgds_table(&mvm->fwrt)) {
+		if (!iwl_acpi_get_wgds_table(&mvm->fwrt)) {
 			/*
 			 * If basic SAR is not available, we check for WGDS,
 			 * which should *not* be available either.  If it is
@@ -1433,7 +1433,7 @@ void iwl_mvm_get_acpi_tables(struct iwl_mvm *mvm)
 		}
 
 	} else {
-		ret = iwl_sar_get_ewrd_table(&mvm->fwrt);
+		ret = iwl_acpi_get_ewrd_table(&mvm->fwrt);
 		/* if EWRD is not available, we can still use
 		* WRDS, so don't fail */
 		if (ret < 0)
@@ -1443,7 +1443,7 @@ void iwl_mvm_get_acpi_tables(struct iwl_mvm *mvm)
 
 		/* read geo SAR table */
 		if (iwl_sar_geo_support(&mvm->fwrt)) {
-			ret = iwl_sar_get_wgds_table(&mvm->fwrt);
+			ret = iwl_acpi_get_wgds_table(&mvm->fwrt);
 			if (ret < 0)
 				IWL_DEBUG_RADIO(mvm,
 						"Geo SAR BIOS table invalid or unavailable. (%d)\n",
-- 
2.34.1


