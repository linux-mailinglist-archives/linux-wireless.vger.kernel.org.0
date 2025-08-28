Return-Path: <linux-wireless+bounces-26722-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 403C7B39464
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Aug 2025 08:56:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08EB3205B66
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Aug 2025 06:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 848F42C11DC;
	Thu, 28 Aug 2025 06:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JWhtNyC7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09FC427A448
	for <linux-wireless@vger.kernel.org>; Thu, 28 Aug 2025 06:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756364161; cv=none; b=f7iNqz+j65/CB8MVIlojMC+L19S+eLMsWtJwg2OhZT8ZK7gEJh15KSPSllz9TpoMSRUDLoVqx8z4NNAvjqhV15O9dDvckgPYOOBzdkYjYsLAaq+pkqCRI7NXLhFWNnHUojrAKD/3QD3azgEKr0VoYShPFjeEpp7FF0zhB0vOR3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756364161; c=relaxed/simple;
	bh=Bxi3dnRR0Fkm3/1UFZNkqjMgEnGmakX2qhJhvn1XTSQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Frwd2AiQevyRIw2uy93lPWyf+ahODxS/AgUe5N8yc4LY2Ef17vsWmN16JPJj22sv5I8S1gtafDPx+VxSXtis5gCuEyw5g2/R2Q5B3RTW/VcQruEvzGlD3PYw0XfBPKasBhS9CRbbyOc4bTxu+2aI9ZK2bpVta1Fd1YGRwbD19pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JWhtNyC7; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756364160; x=1787900160;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Bxi3dnRR0Fkm3/1UFZNkqjMgEnGmakX2qhJhvn1XTSQ=;
  b=JWhtNyC7K4zPHlHyXDVuWfDpoip0vURQrMVaYwXHVp9zhFcylJxtkG/j
   cks/q0OsfZ687FDuCc/EfA5bYKBJI3MaV6zVd4viGzMcnrn1Ksaozolpl
   wIyBh3aKXtlIPy36szts/Ve24YYjh0kdTo5C+DLIkv+NcHdQoJVuEU/rt
   +8NwBhv3CVC9tnuWStfxUnPlvcK6K/WEPRwQLF6s4MyeOuSHLe4Yiv6Pa
   DqjTEGaaq3irOaRIKWjg7+R/jjK9X2PN7EBGx8ybNOtjXc3EL7YhuIWjt
   giBQVzZreiqSthpZ330ZCd76iIv5lRamwIOMHhBXK6grKeyVDzv9dgsXn
   g==;
X-CSE-ConnectionGUID: DRph1k/lS5GxvA7ggKXRgA==
X-CSE-MsgGUID: 5kpSit+lS5OE7NhEMx8dPQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11535"; a="58723684"
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="58723684"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2025 23:55:59 -0700
X-CSE-ConnectionGUID: LgAe9bt4SCaI8iNK3cswpg==
X-CSE-MsgGUID: +amBJAEYS8G5J6v3X8Yhaw==
X-ExtLoop1: 1
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2025 23:55:58 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-fixes 2/6] wifi: iwlwifi: acpi: check DSM func validity
Date: Thu, 28 Aug 2025 09:55:27 +0300
Message-Id: <20250828095500.881e17ff8f6a.Ic6d92997d9d5fad127919d6e1b830cd3fe944468@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250828095500.0f203e559242.I59eff718cb5fda575db41081a1a389f7af488717@changeid>
References: <20250828095500.0f203e559242.I59eff718cb5fda575db41081a1a389f7af488717@changeid>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

The DSM func 0 (DSM_FUNC_QUERY) returns a bitmap of which
other functions contain valid data, query and check it
before returning other functions data.

Fixes: 9db93491f29e ("iwlwifi: acpi: support device specific method (DSM)")
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220085
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c  | 25 ++++++++++++++++++-
 .../net/wireless/intel/iwlwifi/fw/runtime.h   |  8 ++++++
 2 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
index bee7d92293b8..7ec22738b5d6 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
@@ -169,7 +169,7 @@ int iwl_acpi_get_dsm(struct iwl_fw_runtime *fwrt,
 
 	BUILD_BUG_ON(ARRAY_SIZE(acpi_dsm_size) != DSM_FUNC_NUM_FUNCS);
 
-	if (WARN_ON(func >= ARRAY_SIZE(acpi_dsm_size)))
+	if (WARN_ON(func >= ARRAY_SIZE(acpi_dsm_size) || !func))
 		return -EINVAL;
 
 	expected_size = acpi_dsm_size[func];
@@ -178,6 +178,29 @@ int iwl_acpi_get_dsm(struct iwl_fw_runtime *fwrt,
 	if (expected_size != sizeof(u8) && expected_size != sizeof(u32))
 		return -EOPNOTSUPP;
 
+	if (!fwrt->acpi_dsm_funcs_valid) {
+		ret = iwl_acpi_get_dsm_integer(fwrt->dev, ACPI_DSM_REV,
+					       DSM_FUNC_QUERY,
+					       &iwl_guid, &tmp,
+					       acpi_dsm_size[DSM_FUNC_QUERY]);
+		if (ret) {
+			/* always indicate BIT(0) to avoid re-reading */
+			fwrt->acpi_dsm_funcs_valid = BIT(0);
+			return ret;
+		}
+
+		IWL_DEBUG_RADIO(fwrt, "ACPI DSM validity bitmap 0x%x\n",
+				(u32)tmp);
+		/* always indicate BIT(0) to avoid re-reading */
+		fwrt->acpi_dsm_funcs_valid = tmp | BIT(0);
+	}
+
+	if (!(fwrt->acpi_dsm_funcs_valid & BIT(func))) {
+		IWL_DEBUG_RADIO(fwrt, "ACPI DSM %d not indicated as valid\n",
+				func);
+		return -ENODATA;
+	}
+
 	ret = iwl_acpi_get_dsm_integer(fwrt->dev, ACPI_DSM_REV, func,
 				       &iwl_guid, &tmp, expected_size);
 	if (ret)
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/runtime.h b/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
index 0444a736c2b2..bd3bc2846cfa 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
@@ -113,6 +113,10 @@ struct iwl_txf_iter_data {
  * @phy_filters: specific phy filters as read from WPFC BIOS table
  * @ppag_bios_rev: PPAG BIOS revision
  * @ppag_bios_source: see &enum bios_source
+ * @acpi_dsm_funcs_valid: bitmap indicating which DSM values are valid,
+ *	zero (default initialization) means it hasn't been read yet,
+ *	and BIT(0) is set when it has since function 0 also has this
+ *	bitmap and is always supported
  */
 struct iwl_fw_runtime {
 	struct iwl_trans *trans;
@@ -189,6 +193,10 @@ struct iwl_fw_runtime {
 	bool uats_valid;
 	u8 uefi_tables_lock_status;
 	struct iwl_phy_specific_cfg phy_filters;
+
+#ifdef CONFIG_ACPI
+	u32 acpi_dsm_funcs_valid;
+#endif
 };
 
 void iwl_fw_runtime_init(struct iwl_fw_runtime *fwrt, struct iwl_trans *trans,
-- 
2.34.1


