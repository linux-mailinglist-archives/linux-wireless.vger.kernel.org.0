Return-Path: <linux-wireless+bounces-30657-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 503A5D0F859
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Jan 2026 18:39:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D185B3018434
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Jan 2026 17:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80A0F34CFD9;
	Sun, 11 Jan 2026 17:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jPqfnE5s"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19F7349B17
	for <linux-wireless@vger.kernel.org>; Sun, 11 Jan 2026 17:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768153188; cv=none; b=JXo4neGj90Y8A86H+qZ/KmX/aU/R/alhEhiRGRV/i5Bo8/0uYLEDoR9Of6+gpnEOtjBXzoOD/UJN7SeC/LACg8ejR4IIbrqcgZM8+AVMvSPdoUgx7nriWuNKpo3JzanCpHhGu7E8TfQPAkzdF0po6ojN8WEa/q+x6WRO0ggvXd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768153188; c=relaxed/simple;
	bh=ov650yVa98HKgE+WLZcso6PfgZfgjYDNYjqOVP0/sdk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J+oG6cncSTA9TonMWtThNvmXmBDCKS4c4CUkjixS7J6REgTBNeJJO7bJlGoeNWg4Mj0qi4FSr+Pu82Qu35AkJnUmaC2MEL8Cjf6O2fEeu7JFYqsvJ1HXONjnCPbuDYDtQjY0FHOVukEwRThCAfLRAxZyb+d8TxTfaF5eGNIZXxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jPqfnE5s; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768153187; x=1799689187;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ov650yVa98HKgE+WLZcso6PfgZfgjYDNYjqOVP0/sdk=;
  b=jPqfnE5sOQq5pEwCwI4WAve5Zt+7dcvQfiVVCoYVNw/tmOI6SU1wESNS
   h30XIkaDUaoNEoEWyTO6m+p9xVbTDCYYKw5HU6ecqJ4HxuGs+nKN6BYsD
   Yw8/CdEE5w/IIZwDlk8CPihDa7SEj/r5uBgf0f6S4NgduoQVvrDeWC0LH
   cAZCqAdEEciuKooZ9cy3BNyq9c/m1iUvtwJCbJGhDw2KIfHbt/ZGontcS
   dCZiLV0oh0KHTbdz5oi76tbVmEMQcpi/c1H1ueEnygGUQGSfsnDYCGX/8
   umFcQN4I1z0l8uejH2ZSqHIY2+Tokid2WDVj7XE9TJPMwtX1L+5hyZL1C
   w==;
X-CSE-ConnectionGUID: 79RdxpfuQWS5rT3xZNcYJw==
X-CSE-MsgGUID: JgxbxzCtRASj0w4BzhgiAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11668"; a="69521092"
X-IronPort-AV: E=Sophos;i="6.21,219,1763452800"; 
   d="scan'208";a="69521092"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2026 09:39:47 -0800
X-CSE-ConnectionGUID: 0/vRQbBoQiygPTipP/4byw==
X-CSE-MsgGUID: +FwpTU0LTC+ZoyuCd2mdbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,219,1763452800"; 
   d="scan'208";a="208393802"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2026 09:39:46 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH iwlwifi-next 09/15] wifi: iwlwifi: acpi: cache the DSM functions
Date: Sun, 11 Jan 2026 19:39:20 +0200
Message-Id: <20260111193638.732ff6856796.Iff844bfbb0fea3c3d9654a53254a5b14dbaec8c1@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260111173926.2216629-1-miriam.rachel.korenblit@intel.com>
References: <20260111173926.2216629-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

Instead of reading the DSM functions on demand, just read them all
when the first DSM function is called and cache the values for all
the other DSM functions. This simplifies the flow.
Since the same will be done for UEFI in the next patch, remove the
ifdef CONFIG_ACPI around the relevant variables.

Once UEFI's cache will be implemented, we'll be able to change
iwl_bios_get_dsm to access the cache directly.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c  | 112 ++++++++++++------
 .../net/wireless/intel/iwlwifi/fw/runtime.h   |  11 +-
 2 files changed, 84 insertions(+), 39 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
index 52edc19d8cdd..4d37ca984c41 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
@@ -156,61 +156,101 @@ static int iwl_acpi_get_dsm_integer(struct device *dev, int rev, int func,
 }
 
 /*
- * This function receives a DSM function number, calculates its expected size
- * according to Intel BIOS spec, and fills in the value in a 32-bit field.
+ * This function loads all the DSM functions, it checks the size and populates
+ * the cache with the values in a 32-bit field.
  * In case the expected size is smaller than 32-bit, padding will be added.
  */
-int iwl_acpi_get_dsm(struct iwl_fw_runtime *fwrt,
-		     enum iwl_dsm_funcs func, u32 *value)
+static int iwl_acpi_load_dsm_values(struct iwl_fw_runtime *fwrt)
 {
-	size_t expected_size;
-	u64 tmp;
+	u64 query_func_val;
 	int ret;
 
 	BUILD_BUG_ON(ARRAY_SIZE(acpi_dsm_size) != DSM_FUNC_NUM_FUNCS);
 
-	if (WARN_ON(func >= ARRAY_SIZE(acpi_dsm_size) || !func))
-		return -EINVAL;
+	ret = iwl_acpi_get_dsm_integer(fwrt->dev, ACPI_DSM_REV,
+				       DSM_FUNC_QUERY,
+				       &iwl_guid, &query_func_val,
+				       acpi_dsm_size[DSM_FUNC_QUERY]);
 
-	expected_size = acpi_dsm_size[func];
+	if (ret) {
+		IWL_DEBUG_RADIO(fwrt, "ACPI QUERY FUNC not valid: %d\n", ret);
+		return ret;
+	}
 
-	/* Currently all ACPI DSMs are either 8-bit or 32-bit */
-	if (expected_size != sizeof(u8) && expected_size != sizeof(u32))
-		return -EOPNOTSUPP;
+	IWL_DEBUG_RADIO(fwrt, "ACPI DSM validity bitmap 0x%x\n",
+			(u32)query_func_val);
 
-	if (!fwrt->acpi_dsm_funcs_valid) {
-		ret = iwl_acpi_get_dsm_integer(fwrt->dev, ACPI_DSM_REV,
-					       DSM_FUNC_QUERY,
-					       &iwl_guid, &tmp,
-					       acpi_dsm_size[DSM_FUNC_QUERY]);
-		if (ret) {
-			/* always indicate BIT(0) to avoid re-reading */
-			fwrt->acpi_dsm_funcs_valid = BIT(0);
-			return ret;
+	/* DSM_FUNC_QUERY is 0, start from 1 */
+	for (int func = 1; func < ARRAY_SIZE(fwrt->dsm_values); func++) {
+		size_t expected_size = acpi_dsm_size[func];
+		u64 tmp;
+
+		if (!(query_func_val & BIT(func))) {
+			IWL_DEBUG_RADIO(fwrt,
+					"ACPI DSM %d not indicated as valid\n",
+					func);
+			continue;
 		}
 
-		IWL_DEBUG_RADIO(fwrt, "ACPI DSM validity bitmap 0x%x\n",
-				(u32)tmp);
-		/* always indicate BIT(0) to avoid re-reading */
-		fwrt->acpi_dsm_funcs_valid = tmp | BIT(0);
+		/* This is an invalid function (5 for example) */
+		if (!expected_size)
+			continue;
+
+		/* Currently all ACPI DSMs are either 8-bit or 32-bit */
+		if (expected_size != sizeof(u8) && expected_size != sizeof(u32))
+			continue;
+
+		ret = iwl_acpi_get_dsm_integer(fwrt->dev, ACPI_DSM_REV, func,
+					       &iwl_guid, &tmp, expected_size);
+		if (ret)
+			continue;
+
+		if ((expected_size == sizeof(u8) && tmp != (u8)tmp) ||
+		    (expected_size == sizeof(u32) && tmp != (u32)tmp))
+			IWL_DEBUG_RADIO(fwrt,
+					"DSM value overflows the expected size, truncating\n");
+		fwrt->dsm_values[func] = (u32)tmp;
+		fwrt->dsm_funcs_valid |= BIT(func);
 	}
 
-	if (!(fwrt->acpi_dsm_funcs_valid & BIT(func))) {
+	return 0;
+}
+
+/*
+ * This function receives a DSM function number, calculates its expected size
+ * according to Intel BIOS spec, and fills in the value in a 32-bit field.
+ * In case the expected size is smaller than 32-bit, padding will be added.
+ */
+int iwl_acpi_get_dsm(struct iwl_fw_runtime *fwrt,
+		     enum iwl_dsm_funcs func, u32 *value)
+{
+	if (!fwrt->dsm_funcs_valid) {
+		int ret = iwl_acpi_load_dsm_values(fwrt);
+
+		/*
+		 * Always set the valid bit for DSM_FUNC_QUERY so that even if
+		 * DSM_FUNC_QUERY returns 0 (no DSM function is valid), we will
+		 * still consider the cache as valid.
+		 */
+		fwrt->dsm_funcs_valid |= BIT(DSM_FUNC_QUERY);
+
+		if (ret)
+			return ret;
+	}
+
+	BUILD_BUG_ON(ARRAY_SIZE(fwrt->dsm_values) != DSM_FUNC_NUM_FUNCS);
+	BUILD_BUG_ON(DSM_FUNC_NUM_FUNCS > BITS_PER_TYPE(fwrt->dsm_funcs_valid));
+
+	if (WARN_ON(func >= ARRAY_SIZE(fwrt->dsm_values) || !func))
+		return -EINVAL;
+
+	if (!(fwrt->dsm_funcs_valid & BIT(func))) {
 		IWL_DEBUG_RADIO(fwrt, "ACPI DSM %d not indicated as valid\n",
 				func);
 		return -ENODATA;
 	}
 
-	ret = iwl_acpi_get_dsm_integer(fwrt->dev, ACPI_DSM_REV, func,
-				       &iwl_guid, &tmp, expected_size);
-	if (ret)
-		return ret;
-
-	if ((expected_size == sizeof(u8) && tmp != (u8)tmp) ||
-	    (expected_size == sizeof(u32) && tmp != (u32)tmp))
-		IWL_DEBUG_RADIO(fwrt,
-				"DSM value overflows the expected size, truncating\n");
-	*value = (u32)tmp;
+	*value = fwrt->dsm_values[func];
 
 	return 0;
 }
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/runtime.h b/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
index 57570ff15622..b9e5f8ea8f94 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
@@ -116,10 +116,14 @@ struct iwl_txf_iter_data {
  * @phy_filters: specific phy filters as read from WPFC BIOS table
  * @ppag_bios_rev: PPAG BIOS revision
  * @ppag_bios_source: see &enum bios_source
- * @acpi_dsm_funcs_valid: bitmap indicating which DSM values are valid,
+ * @dsm_funcs_valid: bitmap indicating which DSM values are valid,
  *	zero (default initialization) means it hasn't been read yet,
  *	and BIT(0) is set when it has since function 0 also has this
- *	bitmap and is always supported
+ *	bitmap and is always supported.
+ *	If the bit is set for a specific function, then the corresponding
+ *	entry in &dsm_values is valid.
+ * @dsm_values: cache of the DSM values. The validity of each entry is
+ *	determined by &dsm_funcs_valid.
  * @geo_enabled: WGDS table is present
  * @geo_num_profiles: number of geo profiles
  * @geo_rev: geo profiles table revision
@@ -213,7 +217,8 @@ struct iwl_fw_runtime {
 	struct iwl_phy_specific_cfg phy_filters;
 
 #ifdef CONFIG_ACPI
-	u32 acpi_dsm_funcs_valid;
+	u32 dsm_funcs_valid;
+	u32 dsm_values[DSM_FUNC_NUM_FUNCS];
 #endif
 };
 
-- 
2.34.1


