Return-Path: <linux-wireless+bounces-30660-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 74F36D0F877
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Jan 2026 18:40:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7D79D308559A
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Jan 2026 17:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21AAB34CFB4;
	Sun, 11 Jan 2026 17:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AKVrTtMl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2991929AAF8
	for <linux-wireless@vger.kernel.org>; Sun, 11 Jan 2026 17:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768153191; cv=none; b=SNev6+FqEKxy4dYYXSN7SSc9f+YWAcwu1umj1m2uVzMnKG81PkjoJ+8j4tbdJIr4YSWXdH3iq7Z1dl3qWzTOkzDv6iX1SrLqzHoqqLeHVLYOgjmtdbHbd2BG8dKQ5ajlO5aPMNDN4sOtvmbiZwFu/N8+44EVzkkpt56WNqPoFFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768153191; c=relaxed/simple;
	bh=zlkGPmU2N8eElR4ajajAPXoU1/zsJ9st+u748ANyVEg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jRetdTMtV2pZNvzaFPegY1AXZcmkAhw680ZROCJuD6EAygueh3czP41kN48XMaYV4L7YbO7XkAaGnybBX8Ne9aoIN76gDpFElWdSRG/gKwyEQ/9r6MjlW0UBR31sk9XehhjsYTzjhmKoEHYbRQVEWKz/DH3wVcBVbNK1pc5UMck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AKVrTtMl; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768153188; x=1799689188;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zlkGPmU2N8eElR4ajajAPXoU1/zsJ9st+u748ANyVEg=;
  b=AKVrTtMlhZnPuo10YWrk15jcviGAd0JyTL6Y6Iuzo5ptx3II/YZ84zMW
   pSG0l0BC196QCjfwWvAHp4IuUDPJbQqqXGtmL8PzrXSZmPZRlz5lUXPDA
   IKuuVqa25FyQXH8aEnYWSHoSXua13fZsikQw3AFcxdVzbDUP9jFPBtll4
   o38nPb02pnwwIpiT8AxepX23U3EZQP8seIsVyoIt3tKhbxzCPvdBKqkx9
   BldmpPIHURvQc1ncsKijzoOBu9zpI4VeZ3r0W/sRnaho3FL64dQYiwS/A
   RZQkFnbPR7Vc7wMyroA+M/zsFJ0ftOh3Lmr42PKodVvW+ut4LH6nG4sAX
   Q==;
X-CSE-ConnectionGUID: RZqMNK+pToqSZdeSDqpABQ==
X-CSE-MsgGUID: mWObt8JiR1G4d8CMKn+xKQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11668"; a="69521093"
X-IronPort-AV: E=Sophos;i="6.21,219,1763452800"; 
   d="scan'208";a="69521093"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2026 09:39:48 -0800
X-CSE-ConnectionGUID: bJTRHnFtRuq3Pz9w6owX9Q==
X-CSE-MsgGUID: Tw+zVzdBRpWHka2C+QGZdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,219,1763452800"; 
   d="scan'208";a="208393805"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2026 09:39:47 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH iwlwifi-next 10/15] wifi: iwlwifi: uefi: cache the DSM functions
Date: Sun, 11 Jan 2026 19:39:21 +0200
Message-Id: <20260111193638.15871db3cfab.Ib39db197646cc303d60bb12448794d20f6ccbd15@changeid>
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

Just like we did for ACPI, cache the UEFI values to avoid reading the
tables over and over again.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/fw/runtime.h   |  2 +-
 drivers/net/wireless/intel/iwlwifi/fw/uefi.c  | 65 ++++++++++++++-----
 2 files changed, 51 insertions(+), 16 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/runtime.h b/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
index b9e5f8ea8f94..54fca80d3301 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
@@ -216,7 +216,7 @@ struct iwl_fw_runtime {
 	u8 uefi_tables_lock_status;
 	struct iwl_phy_specific_cfg phy_filters;
 
-#ifdef CONFIG_ACPI
+#if defined(CONFIG_ACPI) || defined (CONFIG_EFI)
 	u32 dsm_funcs_valid;
 	u32 dsm_values[DSM_FUNC_NUM_FUNCS];
 #endif
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/uefi.c b/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
index 4ae4d215e633..acccb22a833c 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
@@ -721,17 +721,12 @@ int iwl_uefi_get_wbem(struct iwl_fw_runtime *fwrt, u32 *value)
 	return ret;
 }
 
-int iwl_uefi_get_dsm(struct iwl_fw_runtime *fwrt, enum iwl_dsm_funcs func,
-		     u32 *value)
+static int iwl_uefi_load_dsm_values(struct iwl_fw_runtime *fwrt)
 {
 	struct uefi_cnv_var_general_cfg *data;
 	int ret = -EINVAL;
 
-	BUILD_BUG_ON(ARRAY_SIZE(data->functions) < DSM_FUNC_NUM_FUNCS);
-
-	/* Not supported function index */
-	if (func >= DSM_FUNC_NUM_FUNCS || func == 5)
-		return -EOPNOTSUPP;
+	BUILD_BUG_ON(ARRAY_SIZE(data->functions) < ARRAY_SIZE(fwrt->dsm_values));
 
 	data = iwl_uefi_get_verified_variable(fwrt->trans, IWL_UEFI_DSM_NAME,
 					      "DSM", sizeof(*data), NULL);
@@ -744,23 +739,63 @@ int iwl_uefi_get_dsm(struct iwl_fw_runtime *fwrt, enum iwl_dsm_funcs func,
 		goto out;
 	}
 
-	if (!(data->functions[DSM_FUNC_QUERY] & BIT(func))) {
-		IWL_DEBUG_RADIO(fwrt, "DSM func %d not in 0x%x\n",
-				func, data->functions[DSM_FUNC_QUERY]);
-		goto out;
-	}
+	fwrt->dsm_funcs_valid = data->functions[DSM_FUNC_QUERY];
 
-	*value = data->functions[func];
+	/*
+	 * Make sure we don't load the DSM values twice. Set this only after we
+	 * validated the DSM table so that if the table in UEFI is not valid,
+	 * we will fallback to ACPI.
+	 */
+	fwrt->dsm_funcs_valid |= BIT(DSM_FUNC_QUERY);
 
-	IWL_DEBUG_RADIO(fwrt,
-			"UEFI: DSM func=%d: value=%d\n", func, *value);
+	for (int func = 1; func < ARRAY_SIZE(fwrt->dsm_values); func++) {
+		if (!(fwrt->dsm_funcs_valid & BIT(func))) {
+			IWL_DEBUG_RADIO(fwrt, "DSM func %d not in 0x%x\n",
+					func, fwrt->dsm_funcs_valid);
+			continue;
+		}
 
+		fwrt->dsm_values[func] = data->functions[func];
+
+		IWL_DEBUG_RADIO(fwrt,
+				"UEFI: DSM func=%d: value=%d\n", func,
+				fwrt->dsm_values[func]);
+	}
 	ret = 0;
+
 out:
 	kfree(data);
 	return ret;
 }
 
+int iwl_uefi_get_dsm(struct iwl_fw_runtime *fwrt, enum iwl_dsm_funcs func,
+		     u32 *value)
+{
+	/* Not supported function index */
+	if (func >= DSM_FUNC_NUM_FUNCS || func == 5)
+		return -EOPNOTSUPP;
+
+	if (!fwrt->dsm_funcs_valid) {
+		int ret = iwl_uefi_load_dsm_values(fwrt);
+
+		if (ret)
+			return ret;
+	}
+
+	if (!(fwrt->dsm_funcs_valid & BIT(func))) {
+		IWL_DEBUG_RADIO(fwrt, "DSM func %d not in 0x%x\n",
+				func, fwrt->dsm_funcs_valid);
+		return -EINVAL;
+	}
+
+	*value = fwrt->dsm_values[func];
+
+	IWL_DEBUG_RADIO(fwrt,
+			"UEFI: DSM func=%d: value=%d\n", func, *value);
+
+	return 0;
+}
+
 int iwl_uefi_get_puncturing(struct iwl_fw_runtime *fwrt)
 {
 	struct uefi_cnv_var_puncturing_data *data;
-- 
2.34.1


