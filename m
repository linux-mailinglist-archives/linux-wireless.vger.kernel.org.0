Return-Path: <linux-wireless+bounces-35828-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aN/tJLNs+GnPuQIAu9opvQ
	(envelope-from <linux-wireless+bounces-35828-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 04 May 2026 11:53:55 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EE9DD4BB470
	for <lists+linux-wireless@lfdr.de>; Mon, 04 May 2026 11:53:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7D1BD3018C23
	for <lists+linux-wireless@lfdr.de>; Mon,  4 May 2026 09:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34E5B388E77;
	Mon,  4 May 2026 09:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aMf3nUhU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF14389110;
	Mon,  4 May 2026 09:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777888421; cv=none; b=BpqMcwNUV2ZGbOzKItnkTkvF5541uWJLJkKmBYu69TqgAy2ln8qQoNV0dAk8r5vR+OTfYSxJPfNeiZS02UtsAN+QKYfca0KxCysthDnpXL1DDO7Dku8F1Y9aBnZurTvOpBFjT/mdR39Ck9OZ6aU69qTMq4MIjo1eA6jjvecWMKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777888421; c=relaxed/simple;
	bh=rDLLDyJGWbnHEZy87mTvRW2xYvYUiNHLwcFssU6xVa0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FF89230F2LDe5RfWGeXlYqKtrbpi6YNCYv9akT9rLO1mOeWkyig4y8v0qew+BBgODSgekSmngfcUuj0/kLgI20qEwU0xfj0ZFrVkZm/bzOI1kBpkLOayMA22gd2IRnxsTajC5qhd9RLn6bumuWQxL5AL+WIo4Ll+UFuTIlus3MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aMf3nUhU; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777888419; x=1809424419;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rDLLDyJGWbnHEZy87mTvRW2xYvYUiNHLwcFssU6xVa0=;
  b=aMf3nUhUcDPo/QIRzjtrGhC1gVJsTkCZwHxshDY6itfB8nava6oFdaJZ
   d7zOyplI+Y8nSKeGVqyoOBTM1Hg50zVLEuP9pXufi02+OJqaXq4o5hnH/
   UAGdwRs+VUItdfzBChm5hWiMRjXF2WUZKSuZAFz/bKvr4isdSzfikQMzO
   KOstWstbkQrWmkL+o2QTWpmJQ9rPyLsNaWZKqrCcg1ewdZwoGIypdHAKW
   3FX0fkfuZpuFcwej+3CHf7vtPo1kanUEXwJ0KZOmZwIfVawRPSQWWf7b1
   7FfHcn2NkqawDr1c86cwRgxxeBUoXHvunQ3A9GTPziT+3Q/YcTzwQogph
   w==;
X-CSE-ConnectionGUID: S6dyjytgTkabL1iyq3zjJA==
X-CSE-MsgGUID: KwB46sPWTImpOxZqs7YIBQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11775"; a="78767571"
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="78767571"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 02:53:39 -0700
X-CSE-ConnectionGUID: bF3toE6PTl2EpcK2BJ+nPg==
X-CSE-MsgGUID: dPXZnDVdT16h9Krg1nHPMw==
X-ExtLoop1: 1
Received: from iapp347.iil.intel.com (HELO localhost) ([10.167.28.6])
  by fmviesa003.fm.intel.com with ESMTP; 04 May 2026 02:53:36 -0700
From: Avinash Bhatt <avinash.bhatt@intel.com>
To: devicetree@vger.kernel.org,
	linux-wireless@vger.kernel.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	johannes@sipsolutions.net,
	miriam.rachel.korenblit@intel.com,
	linux-kernel@vger.kernel.org,
	kobi.guetta@intel.com,
	emmanuel.grumbach@intel.com,
	avinash.bhatt@intel.com
Subject: [PATCH v2 2/3] wifi: iwlwifi: dt: add Device Tree BIOS configuration infrastructure
Date: Mon,  4 May 2026 12:53:26 +0300
Message-Id: <20260504095327.30892-3-avinash.bhatt@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260504095327.30892-1-avinash.bhatt@intel.com>
References: <20260504095327.30892-1-avinash.bhatt@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: EE9DD4BB470
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[avinash.bhatt@intel.com,linux-wireless@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-35828-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	RCVD_COUNT_FIVE(0.00)[5];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

On platforms that use Device Tree and do not provide UEFI variables or
ACPI methods, discrete Intel Wi-Fi adapters have no way to receive BIOS
configuration. Add Device Tree as a supported configuration source for
SAR limits and 6 GHz AP type support, with stub hooks for TAS and
per-platform antenna gain tables.

DT support is gated on CONFIG_OF and is a no-op on x86. BIOS_SOURCE_DT
is added to enum bios_source to track the configuration origin.

Signed-off-by: Avinash Bhatt <avinash.bhatt@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/Makefile   |   1 +
 drivers/net/wireless/intel/iwlwifi/fw/acpi.h  |   5 +-
 .../wireless/intel/iwlwifi/fw/api/nvm-reg.h   |   4 +-
 drivers/net/wireless/intel/iwlwifi/fw/dt.c    | 321 ++++++++++++++++++
 drivers/net/wireless/intel/iwlwifi/fw/dt.h    | 123 +++++++
 .../wireless/intel/iwlwifi/fw/regulatory.h    |   3 +-
 6 files changed, 451 insertions(+), 6 deletions(-)
 create mode 100644 drivers/net/wireless/intel/iwlwifi/fw/dt.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/fw/dt.h

diff --git a/drivers/net/wireless/intel/iwlwifi/Makefile b/drivers/net/wireless/intel/iwlwifi/Makefile
index 941257b811b4..445c8a26b6bd 100644
--- a/drivers/net/wireless/intel/iwlwifi/Makefile
+++ b/drivers/net/wireless/intel/iwlwifi/Makefile
@@ -38,6 +38,7 @@ iwlwifi-$(CONFIG_IWLMVM) += fw/paging.o fw/smem.o fw/init.o
 iwlwifi-$(CONFIG_IWLMLD) += fw/smem.o fw/init.o
 iwlwifi-$(CONFIG_ACPI) += fw/acpi.o
 iwlwifi-$(CONFIG_EFI)	+= fw/uefi.o
+iwlwifi-$(CONFIG_OF)	+= fw/dt.o
 iwlwifi-$(CONFIG_IWLWIFI_DEBUGFS) += fw/debugfs.o
 
 iwlwifi-objs += $(iwlwifi-m)
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.h b/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
index 51a57e57de7a..45eb35ffb637 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
  * Copyright (C) 2017 Intel Deutschland GmbH
- * Copyright (C) 2018-2023, 2025 Intel Corporation
+ * Copyright (C) 2018-2023, 2025-2026 Intel Corporation
  */
 #ifndef __iwl_fw_acpi__
 #define __iwl_fw_acpi__
@@ -111,9 +111,6 @@
 #define ACPI_PPAG_WIFI_DATA_SIZE_V3	((ACPI_PPAG_NUM_CHAINS * \
 					  ACPI_PPAG_NUM_BANDS_V3) + 2)
 
-#define IWL_SAR_ENABLE_MSK		BIT(0)
-#define IWL_REDUCE_POWER_FLAGS_POS	1
-
 /* The Inidcator whether UEFI WIFI GUID tables are locked is read from ACPI */
 #define UEFI_WIFI_GUID_UNLOCKED		0
 
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h b/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h
index 443a9a416325..39289bf3a193 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2012-2014, 2018-2025 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2026 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -495,11 +495,13 @@ struct iwl_tas_config_cmd_v2_v4 {
  * @BIOS_SOURCE_NONE: BIOS source is not defined
  * @BIOS_SOURCE_ACPI: BIOS source is ACPI
  * @BIOS_SOURCE_UEFI: BIOS source is UEFI
+ * @BIOS_SOURCE_DT: BIOS source is Device Tree
  */
 enum bios_source {
 	BIOS_SOURCE_NONE,
 	BIOS_SOURCE_ACPI,
 	BIOS_SOURCE_UEFI,
+	BIOS_SOURCE_DT,
 };
 
 /**
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dt.c b/drivers/net/wireless/intel/iwlwifi/fw/dt.c
new file mode 100644
index 000000000000..4f3d098204f0
--- /dev/null
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dt.c
@@ -0,0 +1,321 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/*
+ * Copyright (C) 2026 Intel Corporation
+ */
+#include <linux/of.h>
+#include "iwl-drv.h"
+#include "iwl-debug.h"
+#include "fw/runtime.h"
+#include "fw/regulatory.h"
+#include "dt.h"
+
+/* DT property names */
+#define IWL_DT_PROP_WRDS			"intel,wrds"
+#define IWL_DT_PROP_UATS			"intel,uats"
+#define IWL_DT_PROP_SPLC			"intel,splc"
+#define IWL_DT_PROP_WBEM			"intel,wbem"
+#define IWL_DT_PROP_WCPE			"intel,wcpe"
+#define IWL_DT_WCPE_USA_EN			BIT(0)
+#define IWL_DT_WCPE_CANADA_EN			BIT(1)
+#define IWL_DT_WCPE_MASK (IWL_DT_WCPE_USA_EN | \
+			  IWL_DT_WCPE_CANADA_EN)
+#define IWL_DT_PROP_SRD				"intel,srd"
+#define IWL_DT_PROP_6E_UHB			"intel,6e-uhb"
+#define IWL_DT_PROP_REG_SPECIAL			"intel,regulatory-special"
+#define IWL_DT_PROP_ACTIVATE_CH			"intel,activate-channel"
+#define IWL_DT_PROP_FORCE_DISABLE_CH		"intel,force-disable-channels"
+#define IWL_DT_PROP_11BE			"intel,11be"
+
+/* Supported revision values for each DT property */
+#define IWL_DT_WRDS_REVISION		3
+#define IWL_DT_UATS_REVISION		1
+
+/* SAR layout for "intel,wrds" revision 3 (mirrors ACPI_SAR_NUM_CHAINS_REV2
+ * and UEFI_SAR_SUB_BANDS_NUM_REV3): 4 chains x 12 subbands
+ */
+#define IWL_DT_WRDS_NUM_CHAINS		4
+#define IWL_DT_WRDS_NUM_SUBBANDS	12
+/* Total cell count for "intel,wrds" property: 2-cell header + SAR data */
+#define IWL_DT_WRDS_MAX_CELLS \
+	(2 + IWL_DT_WRDS_NUM_CHAINS * IWL_DT_WRDS_NUM_SUBBANDS)
+
+/**
+ * iwl_dt_get_wrds_table - read SAR power limits from DT "intel,wrds" property
+ * @fwrt: firmware runtime context
+ *
+ * Reads per-chain, per-subband SAR power limits from the "intel,wrds"
+ * Device Tree property and populates the SAR profile.
+ *
+ * Return: 0 on success, -ENOENT if the property or DT node is absent,
+ * or a negative error code for malformed data.
+ */
+int iwl_dt_get_wrds_table(struct iwl_fw_runtime *fwrt)
+{
+	struct device_node *node = dev_of_node(fwrt->dev);
+	u32 buf[IWL_DT_WRDS_MAX_CELLS];
+	u8 num_chains, num_subbands;
+	int ret;
+
+	if (!node)
+		return -ENOENT;
+
+	ret = of_property_read_u32_array(node, IWL_DT_PROP_WRDS, buf,
+					 IWL_DT_WRDS_MAX_CELLS);
+	if (ret) {
+		IWL_DEBUG_RADIO(fwrt, "WRDS DT: read failed (%d)\n", ret);
+		return ret;
+	}
+
+	if (buf[0] != IWL_DT_WRDS_REVISION) {
+		IWL_DEBUG_RADIO(fwrt,
+				"WRDS DT: revision %u not supported (only %u)\n",
+				buf[0], IWL_DT_WRDS_REVISION);
+		return -EINVAL;
+	}
+
+	num_chains   = IWL_DT_WRDS_NUM_CHAINS;
+	num_subbands = IWL_DT_WRDS_NUM_SUBBANDS;
+
+	IWL_DEBUG_RADIO(fwrt,
+			"Reading WRDS from Device Tree (revision %u, %u chains, %u subbands)\n",
+			buf[0], num_chains, num_subbands);
+
+	/* buf[1] bit 0 (IWL_SAR_ENABLE_MSK): enable SAR */
+
+	BUILD_BUG_ON(IWL_DT_WRDS_NUM_CHAINS > BIOS_SAR_MAX_CHAINS_PER_PROFILE);
+	BUILD_BUG_ON(IWL_DT_WRDS_NUM_SUBBANDS > BIOS_SAR_MAX_SUB_BANDS_NUM);
+
+	/* buf[2..]: chains[0..N-1] x subbands[0..M-1] in row-major order */
+	for (int i = 0; i < num_chains; i++) {
+		for (int j = 0; j < num_subbands; j++) {
+			u32 val = buf[2 + i * num_subbands + j];
+
+			if (val > U8_MAX) {
+				IWL_DEBUG_RADIO(fwrt,
+						"DT: WRDS OOB [%u][%u]=%u\n",
+						i, j, val);
+				return -EINVAL;
+			}
+			fwrt->sar_profiles[0].chains[i].subbands[j] = (u8)val;
+		}
+	}
+
+	if (buf[1] & IWL_SAR_ENABLE_MSK)
+		fwrt->sar_profiles[0].enabled = true;
+
+	return 0;
+}
+
+/**
+ * iwl_dt_get_uats_table - read UHB AP type support table from DT "intel,uats"
+ * @fwrt: firmware runtime context
+ *
+ * Reads the UHB AP type support table from the "intel,uats" Device Tree
+ * property and stores the MCC-to-AP-type map for use by the firmware command.
+ */
+void iwl_dt_get_uats_table(struct iwl_fw_runtime *fwrt)
+{
+	size_t map_size = sizeof(fwrt->ap_type_cmd.mcc_to_ap_type_map);
+	struct device_node *node = dev_of_node(fwrt->dev);
+	const u8 *prop_data;
+	int len;
+
+	if (!node)
+		return;
+
+	prop_data = of_get_property(node, IWL_DT_PROP_UATS, &len);
+	if (!prop_data) {
+		IWL_DEBUG_FW(fwrt, "UATS DT: property absent\n");
+		return;
+	}
+
+	if (len != (int)(1 + map_size)) {
+		IWL_DEBUG_FW(fwrt, "UATS DT: bad length %d (expected %zu)\n",
+			     len, 1 + map_size);
+		return;
+	}
+
+	if (prop_data[0] != IWL_DT_UATS_REVISION) {
+		IWL_DEBUG_FW(fwrt,
+			     "UATS DT: revision %u not supported (expected %u)\n",
+			     prop_data[0], IWL_DT_UATS_REVISION);
+		return;
+	}
+
+	IWL_DEBUG_FW(fwrt, "Reading UATS table from Device Tree\n");
+
+	/* prop_data[0]=revision, prop_data[1+]=26x13 MCC to AP type map */
+	memcpy(fwrt->ap_type_cmd.mcc_to_ap_type_map, prop_data + 1, map_size);
+	fwrt->ap_type_cmd_valid = true;
+}
+IWL_EXPORT_SYMBOL(iwl_dt_get_uats_table);
+
+/*
+ * Mapping from DSM function index to Device Tree property name.
+ * Returns the DT property name for a given DSM function, or NULL if the
+ * function has no Device Tree representation.
+ */
+static const char *dsm_func_to_prop_name(enum iwl_dsm_funcs func)
+{
+	switch (func) {
+	case DSM_FUNC_DISABLE_SRD:          return IWL_DT_PROP_SRD;
+	case DSM_FUNC_ENABLE_6E:            return IWL_DT_PROP_6E_UHB;
+	case DSM_FUNC_REGULATORY_CONFIG:    return IWL_DT_PROP_REG_SPECIAL;
+	case DSM_FUNC_ACTIVATE_CHANNEL:     return IWL_DT_PROP_ACTIVATE_CH;
+	case DSM_FUNC_FORCE_DISABLE_CHANNELS:
+		return IWL_DT_PROP_FORCE_DISABLE_CH;
+	case DSM_FUNC_ENABLE_11BE:          return IWL_DT_PROP_11BE;
+	default:                            return NULL;
+	}
+}
+
+/**
+ * iwl_dt_get_dsm - read one OEM DSM function value from Device Tree
+ * @fwrt: firmware runtime context
+ * @func: DSM function index (enum iwl_dsm_funcs)
+ * @value: output value
+ *
+ * Reads the DT property for @func on every call without caching.
+ * Unlike the ACPI/UEFI paths, the shared dsm_funcs_valid/dsm_values[]
+ * fields are not used here.
+ *
+ * Return: 0 on success, -ENOENT if no DT node, -EOPNOTSUPP if the function
+ * has no DT representation, -ENODATA if the property is absent,
+ * -EINVAL if the property revision is unsupported.
+ */
+int iwl_dt_get_dsm(struct iwl_fw_runtime *fwrt, enum iwl_dsm_funcs func,
+		   u32 *value)
+{
+	struct device_node *node = dev_of_node(fwrt->dev);
+	const char *prop;
+	u32 buf[2];
+
+	if (!node)
+		return -ENOENT;
+
+	if (func >= DSM_FUNC_NUM_FUNCS)
+		return -EOPNOTSUPP;
+
+	prop = dsm_func_to_prop_name(func);
+	if (!prop)
+		return -EOPNOTSUPP;
+
+	if (of_property_read_u32_array(node, prop, buf, ARRAY_SIZE(buf)))
+		return -ENODATA;
+
+	if (buf[0] != 0) {
+		IWL_DEBUG_RADIO(fwrt,
+				"DT: DSM func %d (%s) unsupported revision %u\n",
+				func, prop, buf[0]);
+		return -EINVAL;
+	}
+
+	if (fwrt->dsm_source == BIOS_SOURCE_NONE) {
+		fwrt->dsm_source = BIOS_SOURCE_DT;
+		fwrt->dsm_revision = 0;
+	}
+
+	*value = buf[1];
+	IWL_DEBUG_RADIO(fwrt, "DT: DSM func=%d (%s) val=%u\n",
+			func, prop, *value);
+	return 0;
+}
+
+/**
+ * iwl_dt_get_pwr_limit - read static platform power limit from DT "intel,splc"
+ * @fwrt: firmware runtime context
+ * @data: output power limit in mW
+ *
+ * Reads the 2-cell "intel,splc" DT property: [revision, power_limit_mw].
+ * Return: 0 on success, -ENOENT if absent, -EINVAL for unsupported revision.
+ */
+int iwl_dt_get_pwr_limit(struct iwl_fw_runtime *fwrt, u64 *data)
+{
+	struct device_node *node = dev_of_node(fwrt->dev);
+	u32 buf[2];
+	int ret;
+
+	if (!node)
+		return -ENOENT;
+
+	ret = of_property_read_u32_array(node, IWL_DT_PROP_SPLC,
+					 buf, ARRAY_SIZE(buf));
+	if (ret)
+		return ret;
+
+	if (buf[0] != 0) {
+		IWL_DEBUG_RADIO(fwrt, "DT: splc unsupported revision %u\n",
+				buf[0]);
+		return -EINVAL;
+	}
+
+	*data = buf[1];
+	IWL_DEBUG_RADIO(fwrt, "DT: Read SPLC power limit %llu mW\n", *data);
+	return 0;
+}
+
+/**
+ * iwl_dt_get_wbem - read 320 MHz per-MCC enablement from DT "intel,wbem"
+ * @fwrt: firmware runtime context
+ * @data: output bitmask (bit 0 = Japan, bit 1 = South Korea)
+ *
+ * Reads the 2-cell "intel,wbem" DT property: [revision, wifi320mhz_mcc].
+ * Return: 0 on success, -ENOENT if absent, -EINVAL for unsupported revision.
+ */
+int iwl_dt_get_wbem(struct iwl_fw_runtime *fwrt, u32 *data)
+{
+	struct device_node *node = dev_of_node(fwrt->dev);
+	u32 buf[2];
+	int ret;
+
+	if (!node)
+		return -ENOENT;
+
+	ret = of_property_read_u32_array(node, IWL_DT_PROP_WBEM,
+					 buf, ARRAY_SIZE(buf));
+	if (ret)
+		return ret;
+
+	if (buf[0] != 0) {
+		IWL_DEBUG_RADIO(fwrt, "DT: wbem unsupported revision %u\n",
+				buf[0]);
+		return -EINVAL;
+	}
+
+	*data = buf[1];
+	IWL_DEBUG_RADIO(fwrt, "DT: Read WBEM config 0x%x\n", *data);
+	return 0;
+}
+
+/**
+ * iwl_dt_get_puncturing - read channel puncturing config from DT "intel,wcpe"
+ * @fwrt: firmware runtime context
+ *
+ * Reads the 2-cell "intel,wcpe" DT property: [revision, puncturing_bitmap].
+ * Return: the bitmask (bit 0 = USA, bit 1 = Canada), or 0 if absent
+ * or revision unsupported.
+ */
+int iwl_dt_get_puncturing(struct iwl_fw_runtime *fwrt)
+{
+	struct device_node *node = dev_of_node(fwrt->dev);
+	u32 buf[2];
+	int ret;
+
+	if (!node)
+		return 0;
+
+	ret = of_property_read_u32_array(node, IWL_DT_PROP_WCPE,
+					 buf, ARRAY_SIZE(buf));
+	if (ret)
+		return 0;
+
+	if (buf[0] != 0) {
+		IWL_DEBUG_RADIO(fwrt, "DT: wcpe unsupported revision %u\n",
+				buf[0]);
+		return 0;
+	}
+
+	IWL_DEBUG_RADIO(fwrt, "DT: Read WCPE puncturing config 0x%x\n", buf[1]);
+	return buf[1] & IWL_DT_WCPE_MASK;
+}
+IWL_EXPORT_SYMBOL(iwl_dt_get_puncturing);
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dt.h b/drivers/net/wireless/intel/iwlwifi/fw/dt.h
new file mode 100644
index 000000000000..01d8eef2babc
--- /dev/null
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dt.h
@@ -0,0 +1,123 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/*
+ * Copyright (C) 2026 Intel Corporation
+ */
+#ifndef __iwl_fw_dt_h__
+#define __iwl_fw_dt_h__
+
+#include "fw/regulatory.h"
+
+/*
+ * Device Tree property parsing for Intel iwlwifi discrete Wi-Fi devices.
+ *
+ * On platforms without UEFI variables or ACPI methods, regulatory and
+ * power configuration can be supplied via Device Tree properties in the
+ * Wi-Fi PCIe device node. The following properties are supported:
+ *
+ *   intel,wrds                 - SAR power limits (WRDS, revision 3)
+ *   intel,uats                 - UHB AP type support table (UATS, revision 1)
+ *   intel,splc                 - static platform power limit
+ *   intel,wbem                 - 320 MHz per-MCC enablement
+ *   intel,wcpe                 - channel puncturing enablement
+ *   intel,srd                  - ETSI SRD channel configuration
+ *   intel,6e-uhb               - 6 GHz UHB country enable bitmask
+ *   intel,regulatory-special   - regulatory special configuration
+ *   intel,activate-channel     - indoor channel activation bitmask
+ *   intel,force-disable-channels - band force-disable bitmask
+ *   intel,11be                 - 802.11be per-country enable bitmask
+ *
+ * DT is the lowest-priority source: UEFI variables take precedence, then
+ * ACPI methods, and finally these DT properties.
+ */
+
+struct iwl_fw_runtime;
+
+#if IS_ENABLED(CONFIG_OF)
+
+/* Functions implemented in fw/dt.c */
+int iwl_dt_get_wrds_table(struct iwl_fw_runtime *fwrt);
+void iwl_dt_get_uats_table(struct iwl_fw_runtime *fwrt);
+int iwl_dt_get_dsm(struct iwl_fw_runtime *fwrt, enum iwl_dsm_funcs func,
+		   u32 *value);
+int iwl_dt_get_pwr_limit(struct iwl_fw_runtime *fwrt, u64 *data);
+int iwl_dt_get_wbem(struct iwl_fw_runtime *fwrt, u32 *data);
+int iwl_dt_get_puncturing(struct iwl_fw_runtime *fwrt);
+
+#else /* !CONFIG_OF */
+
+static inline int iwl_dt_get_wrds_table(struct iwl_fw_runtime *fwrt)
+{
+	return -ENOENT;
+}
+
+static inline void iwl_dt_get_uats_table(struct iwl_fw_runtime *fwrt) {}
+
+static inline int iwl_dt_get_dsm(struct iwl_fw_runtime *fwrt,
+				 enum iwl_dsm_funcs func, u32 *value)
+{
+	return -ENOENT;
+}
+
+static inline int iwl_dt_get_pwr_limit(struct iwl_fw_runtime *fwrt, u64 *data)
+{
+	return -ENOENT;
+}
+
+static inline int iwl_dt_get_wbem(struct iwl_fw_runtime *fwrt, u32 *data)
+{
+	return -ENOENT;
+}
+
+static inline int iwl_dt_get_puncturing(struct iwl_fw_runtime *fwrt)
+{
+	return 0;
+}
+
+#endif /* CONFIG_OF */
+
+/*
+ * The following tables have no Device Tree implementation regardless of
+ * CONFIG_OF. Callers fall back gracefully when these return -ENOENT.
+ */
+static inline int iwl_dt_get_ppag_table(struct iwl_fw_runtime *fwrt)
+{
+	return -ENOENT;
+}
+
+static inline int iwl_dt_get_tas_table(struct iwl_fw_runtime *fwrt,
+				       struct iwl_tas_data *data)
+{
+	return -ENOENT;
+}
+
+static inline int iwl_dt_get_ewrd_table(struct iwl_fw_runtime *fwrt)
+{
+	return -ENOENT;
+}
+
+static inline int iwl_dt_get_wgds_table(struct iwl_fw_runtime *fwrt)
+{
+	return -ENOENT;
+}
+
+static inline int iwl_dt_get_phy_filters(struct iwl_fw_runtime *fwrt)
+{
+	return -ENOENT;
+}
+
+static inline int iwl_dt_get_mcc(struct iwl_fw_runtime *fwrt, char *data)
+{
+	return -ENOENT;
+}
+
+static inline int iwl_dt_get_eckv(struct iwl_fw_runtime *fwrt, u32 *data)
+{
+	return -ENOENT;
+}
+
+static inline int iwl_dt_get_dsbr(struct iwl_fw_runtime *fwrt, u32 *data)
+{
+	return -ENOENT;
+}
+
+#endif /* __iwl_fw_dt_h__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h
index 6fffc032efd3..22c97c75b83c 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2023-2025 Intel Corporation
+ * Copyright (C) 2023-2026 Intel Corporation
  */
 
 #ifndef __fw_regulatory_h__
@@ -30,6 +30,7 @@
 #define BIOS_GEO_MIN_PROFILE_NUM	3
 
 #define IWL_SAR_ENABLE_MSK		BIT(0)
+#define IWL_REDUCE_POWER_FLAGS_POS	1
 
 /* PPAG gain value bounds in 1/8 dBm */
 #define IWL_PPAG_MIN_LB	-16
-- 
2.34.1


