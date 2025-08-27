Return-Path: <linux-wireless+bounces-26671-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55893B37894
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Aug 2025 05:34:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92B047A53F4
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Aug 2025 03:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 766711FF1A1;
	Wed, 27 Aug 2025 03:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B+7MNcaA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8796A17597
	for <linux-wireless@vger.kernel.org>; Wed, 27 Aug 2025 03:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756265671; cv=none; b=UAtJ64I/Ui3ZqcoAgniFKx6TsLwbxANqhRyrZl0BKWYpW3b+GfQjG6bcXA7tp4RKcm/cP9dB/Bw+32GK/ALHRCQmzxqmEOEMXfwhNehVezUJDEN4auRuMiIAf/Xhye56pIUftbHtW6ZBR7/fmht76XmRK2WWylBc904Bf2UCzhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756265671; c=relaxed/simple;
	bh=Bxi3dnRR0Fkm3/1UFZNkqjMgEnGmakX2qhJhvn1XTSQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QvXWiNlsM2gIWwXSRuKbfYyFKuMMSMZgvVSamaubL9yE8kLX+blQXw5H5FaJo6z/PrpK/TK/I49s8KKbvBtg3uLubFso+LmvpZVw2YfQjwMBuxMlH5p8P3G49M9qxbqjxEojUbbXDfO085sP+Spoj2cPS+l9rwNaDx/BPH1kEKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B+7MNcaA; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756265669; x=1787801669;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Bxi3dnRR0Fkm3/1UFZNkqjMgEnGmakX2qhJhvn1XTSQ=;
  b=B+7MNcaAAxEQyAPGMKQHtN7g9Jor1zyfrF8VjQPVkgtbWBOBuuosrP+q
   jgT49JSWeyG6I9eGIeV7zzlNDVAnyOJOND9Czl0MOOvAykUMyhHgRxTXp
   /7ZyL6DAQt25GfnyS43iDRrwiwJjTf9QFQr6WYys966fGPCU0TSf92Va0
   ZJCUbgr2vjbgSCXFX4/Hi+AyV5wt9eChI1uFYy4k8xqHP16KI8Dr0W41S
   HKzceYKnZbF4Dlx89ATjz9InlEQkdO1+GyPSlMmAElM0cYD5k3IBSg6gy
   HvUVeZ7XqyL53m1BEeg9+MR0ZmAcBqKutIY7vcuh25g1uKoxbtTqSox1g
   g==;
X-CSE-ConnectionGUID: iWCUg4ksTveql74aY4NxfQ==
X-CSE-MsgGUID: EdOC3rYIRi6AlvK9B5pgQw==
X-IronPort-AV: E=McAfee;i="6800,10657,11534"; a="69229548"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="69229548"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 20:34:29 -0700
X-CSE-ConnectionGUID: D/AjR/q/SpqNTSYRaHcDfg==
X-CSE-MsgGUID: M/filxMyQW6L+c+U/lqG3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="200631387"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 20:34:28 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-fixes 2/4] wifi: iwlwifi: acpi: check DSM func validity
Date: Wed, 27 Aug 2025 06:33:59 +0300
Message-Id: <20250827063332.881e17ff8f6a.Ic6d92997d9d5fad127919d6e1b830cd3fe944468@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250827063332.0f203e559242.I59eff718cb5fda575db41081a1a389f7af488717@changeid>
References: <20250827063332.0f203e559242.I59eff718cb5fda575db41081a1a389f7af488717@changeid>
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


