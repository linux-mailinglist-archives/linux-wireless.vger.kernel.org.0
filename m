Return-Path: <linux-wireless+bounces-2876-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 600A78438EF
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jan 2024 09:26:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 844C61C27204
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jan 2024 08:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B71F612D8;
	Wed, 31 Jan 2024 08:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kRdmZOe3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C421667E6C
	for <linux-wireless@vger.kernel.org>; Wed, 31 Jan 2024 08:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706689523; cv=none; b=ZaoMvsW0ivorWTM5F2OiYNYMRLselB7p+ZMowM2osYOWTpPfcT0U6a1/Jhs/whUnp6MvCkRskr9saSNJsZh1pAvQZgHOF4nsAToyeM5ZbQWxeMCAWc30OOwuH+uhDJO2fxCK7ZSUmvYpmBz9ajV+SrPNX6YdVQxJNEz5G0LqtN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706689523; c=relaxed/simple;
	bh=ZekcijRNhNjeIJYMSydj0epRfRA+AcwP3mVZYvMXZjs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RXsSvfHtW2YLbb/Ex1XMP5dkRNloqv1LcKxp0vQi1GsPYVJCzTc7sDh+DYsrPhPOvIhaXL8PSBabsombjLZnZ2gQt3to5KduH7mS+xQ/LAzPD9ggXA9yrz01T3fQr2KFmbpqWhq3+1NGl73hVj7J608yAe+kDhkNjcy03j5Yn+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kRdmZOe3; arc=none smtp.client-ip=134.134.136.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706689521; x=1738225521;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZekcijRNhNjeIJYMSydj0epRfRA+AcwP3mVZYvMXZjs=;
  b=kRdmZOe3jbHLRH5UBWM+zKc3ilM9qQaXoEbEEZVLfsRSj38TFtTn6SoD
   gHrYliM4enjK+/YfytXVZYximtwd/NE5/h1weY/8FFpaadAXMXBQ4IExz
   yoMYevP+ioSS6VG2a02UEmgMiuUS+aTqYtfCjGleThARFR0x2bU0Q/nTE
   5qOPFFrkaLmNMtEho8CZzt45FmwDGlVqP+UdbODws1E0WM0n+WKSeT45I
   CkG0nj7cRa4WO5czWxcHGtWnVMoFEVcWFJ24S4+g44ZMcHLgLLwBH4rdV
   m5itpO+jJ9CyLRLDXb1+b5bju1ORkPTXt5+vd8lKW5IYk/MOf7tUgQo1b
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="407249954"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="407249954"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 00:25:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="3968926"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 00:25:19 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 09/14] wifi: iwlwifi: validate PPAG table when sent to FW
Date: Wed, 31 Jan 2024 10:24:42 +0200
Message-Id: <20240131091413.7043b4087dda.I5a189f9a349556b84a79597fe1e46ffa93664df9@changeid>
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

We used to check enablement/validity of the PPAG table while reading
it from BIOS.
For newer FWs this checks were offloaded, and the driver needs
to send the PPAG table anyway.
The desicion whether the table needs to be validated before sending it
is FW related and shouln't be in 'read-from-bios' flow.
Move it to 'send-to-fw' flow instead.
This will also help to avoid code duplication of checking validity in
both ACPI and UEFI caes.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c  | 28 ----------------
 .../wireless/intel/iwlwifi/fw/regulatory.c    | 32 +++++++++++++++++--
 .../net/wireless/intel/iwlwifi/fw/runtime.h   |  1 -
 3 files changed, 29 insertions(+), 32 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
index 9b0ecfc087ab..b029e88501a1 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
@@ -896,9 +896,6 @@ int iwl_acpi_get_ppag_table(struct iwl_fw_runtime *fwrt)
 	union acpi_object *wifi_pkg, *data, *flags;
 	int i, j, ret, tbl_rev, num_sub_bands = 0;
 	int idx = 2;
-	u8 cmd_ver;
-
-	fwrt->ppag_table_valid = false;
 
 	data = iwl_acpi_get_object(fwrt->dev, ACPI_PPAG_METHOD);
 	if (IS_ERR(data))
@@ -945,18 +942,6 @@ int iwl_acpi_get_ppag_table(struct iwl_fw_runtime *fwrt)
 	}
 
 	fwrt->ppag_flags = flags->integer.value & IWL_PPAG_ETSI_CHINA_MASK;
-	cmd_ver = iwl_fw_lookup_cmd_ver(fwrt->fw,
-					WIDE_ID(PHY_OPS_GROUP,
-						PER_PLATFORM_ANT_GAIN_CMD),
-					IWL_FW_CMD_VER_UNKNOWN);
-	if (cmd_ver == IWL_FW_CMD_VER_UNKNOWN) {
-		ret = -EINVAL;
-		goto out_free;
-	}
-	if (!fwrt->ppag_flags && cmd_ver <= 3) {
-		ret = 0;
-		goto out_free;
-	}
 
 	/*
 	 * read, verify gain values and save them into the PPAG table.
@@ -974,22 +959,9 @@ int iwl_acpi_get_ppag_table(struct iwl_fw_runtime *fwrt)
 			}
 
 			fwrt->ppag_chains[i].subbands[j] = ent->integer.value;
-			/* from ver 4 the fw deals with out of range values */
-			if (cmd_ver >= 4)
-				continue;
-			if ((j == 0 &&
-				(fwrt->ppag_chains[i].subbands[j] > IWL_PPAG_MAX_LB ||
-				 fwrt->ppag_chains[i].subbands[j] < IWL_PPAG_MIN_LB)) ||
-				(j != 0 &&
-				(fwrt->ppag_chains[i].subbands[j] > IWL_PPAG_MAX_HB ||
-				fwrt->ppag_chains[i].subbands[j] < IWL_PPAG_MIN_HB))) {
-					ret = -EINVAL;
-					goto out_free;
-				}
 		}
 	}
 
-	fwrt->ppag_table_valid = true;
 	ret = 0;
 
 out_free:
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c
index 2393c8a8e288..3d42ea1ec5fd 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c
@@ -206,12 +206,28 @@ int iwl_sar_fill_profile(struct iwl_fw_runtime *fwrt,
 }
 IWL_EXPORT_SYMBOL(iwl_sar_fill_profile);
 
+static bool iwl_ppag_value_valid(struct iwl_fw_runtime *fwrt, int chain,
+				 int subband)
+{
+	s8 ppag_val = fwrt->ppag_chains[chain].subbands[subband];
+
+	if ((subband == 0 &&
+	     (ppag_val > IWL_PPAG_MAX_LB || ppag_val < IWL_PPAG_MIN_LB)) ||
+	    (subband != 0 &&
+	     (ppag_val > IWL_PPAG_MAX_HB || ppag_val < IWL_PPAG_MIN_HB))) {
+		IWL_DEBUG_RADIO(fwrt, "Invalid PPAG value: %d\n", ppag_val);
+		return false;
+	}
+	return true;
+}
+
 int iwl_fill_ppag_table(struct iwl_fw_runtime *fwrt,
 			union iwl_ppag_table_cmd *cmd, int *cmd_size)
 {
 	u8 cmd_ver;
 	int i, j, num_sub_bands;
 	s8 *gain;
+	bool send_ppag_always;
 
 	/* many firmware images for JF lie about this */
 	if (CSR_HW_RFID_TYPE(fwrt->trans->hw_rf_id) ==
@@ -226,9 +242,15 @@ int iwl_fill_ppag_table(struct iwl_fw_runtime *fwrt,
 
 	cmd_ver = iwl_fw_lookup_cmd_ver(fwrt->fw,
 					WIDE_ID(PHY_OPS_GROUP,
-						PER_PLATFORM_ANT_GAIN_CMD),
-					IWL_FW_CMD_VER_UNKNOWN);
-	if (!fwrt->ppag_table_valid || (cmd_ver <= 3 && !fwrt->ppag_flags)) {
+						PER_PLATFORM_ANT_GAIN_CMD), 1);
+	/*
+	 * Starting from ver 4, driver needs to send the PPAG CMD regradless
+	 * if PPAG is enabled/disabled or valid/invalid.
+	 */
+	send_ppag_always = cmd_ver > 3;
+
+	/* Don't send PPAG if it is disabled */
+	if (!send_ppag_always && !fwrt->ppag_flags) {
 		IWL_DEBUG_RADIO(fwrt, "PPAG not enabled, command not sent.\n");
 		return -EINVAL;
 	}
@@ -283,6 +305,10 @@ int iwl_fill_ppag_table(struct iwl_fw_runtime *fwrt,
 
 	for (i = 0; i < IWL_NUM_CHAIN_LIMITS; i++) {
 		for (j = 0; j < num_sub_bands; j++) {
+			if (!send_ppag_always &&
+			    !iwl_ppag_value_valid(fwrt, i, j))
+				return -EINVAL;
+
 			gain[i * num_sub_bands + j] =
 				fwrt->ppag_chains[i].subbands[j];
 			IWL_DEBUG_RADIO(fwrt,
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/runtime.h b/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
index e55248b6b4c2..d129782f2be4 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
@@ -176,7 +176,6 @@ struct iwl_fw_runtime {
 	struct iwl_ppag_chain ppag_chains[IWL_NUM_CHAIN_LIMITS];
 	u32 ppag_flags;
 	u32 ppag_ver;
-	bool ppag_table_valid;
 	struct iwl_sar_offset_mapping_cmd sgom_table;
 	bool sgom_enabled;
 	struct iwl_uats_table_cmd uats_table;
-- 
2.34.1


