Return-Path: <linux-wireless+bounces-36376-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YFnFOusUBGqDDQIAu9opvQ
	(envelope-from <linux-wireless+bounces-36376-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 13 May 2026 08:06:35 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8412352DEE6
	for <lists+linux-wireless@lfdr.de>; Wed, 13 May 2026 08:06:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D24A63083A03
	for <lists+linux-wireless@lfdr.de>; Wed, 13 May 2026 06:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E7F83D3326;
	Wed, 13 May 2026 06:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TejMABEi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48BC63D3334;
	Wed, 13 May 2026 06:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778652344; cv=none; b=NBeSgrXJqky4By5of3Vkoj9OQgWNWmvRw27mU7CNX4UlaBqpVlAcMdu9FcL7BpdwRwLM8ZPXK7nEJClwz4AOdOFT2hLpGBH40nTc/MEAP4f+rmdfduHXHffpIMQB4Osw7WWS2tD58nypXeR9pgBmBcKhHkLKruTGxpKvatLkWoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778652344; c=relaxed/simple;
	bh=fXv+4EiCVA/KJO0BsPrdEclpsjmgzJ7xpOenbwrD/So=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QzHWjNOeSsNok0z71WSaBTydX1MNyjPGXgdjvIOQmS7mUpa5kNjgz3TOjfy8iPod5l5ZvggQAZ4rmFoYGshzlKvDsYN2eSfZO3ABSmuMpS9qJh0KtpMjzlybsPPrZ68d4295TAGrbxPi91uww6Y1xZRjrstJUipxDR5CLmBRumE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TejMABEi; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778652342; x=1810188342;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fXv+4EiCVA/KJO0BsPrdEclpsjmgzJ7xpOenbwrD/So=;
  b=TejMABEi0KXRyl2msBMkuOLseU1Q45HAry5OOVFFvolhBvPjJd6JMOE9
   3EZK0KhPA1TnBvx3AsKIbwk6jWcwbGcru6i/eNoZOLreFFkJ8zSdnWKit
   xU1NmmCYIkILtcWQXlN33vtoHFsheJiV2YiblKzsPHmr3bTFARgPxAsxn
   L6KAKbJ3z6ENKBkXf62NK1jnGRCUk7AGPdfLCtlaE1HLZtsR7zYq3a3vT
   J1RNeYpzDqMYXbAL/Doi2j8gXS9MYdoXp6hyyZmnm7jWDxiqhMp78ohNh
   9xnQ36nTxBuIGKh778guDD7Ve3TzdN8RaA98qbODQO9arg7hBo27cXFbm
   Q==;
X-CSE-ConnectionGUID: Ip4MI67DSXe/MyLBa21Wng==
X-CSE-MsgGUID: fj2afdRDScOMxmSDEPuyEQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="90954403"
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="90954403"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 23:05:42 -0700
X-CSE-ConnectionGUID: DaOQexrtRrmAeX1ikZi9Vg==
X-CSE-MsgGUID: SxVsI1+YRvOs/w6uYWZoRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="233712400"
Received: from iapp347.iil.intel.com (HELO localhost) ([10.167.28.6])
  by fmviesa010.fm.intel.com with ESMTP; 12 May 2026 23:05:39 -0700
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
	emmanuel.grumbach@intel.com
Subject: [PATCH v3 2/3] wifi: iwlwifi: dt: add Device Tree BIOS configuration infrastructure
Date: Wed, 13 May 2026 09:05:30 +0300
Message-Id: <20260513060531.8130-3-avinash.bhatt@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260513060531.8130-1-avinash.bhatt@intel.com>
References: <20260513060531.8130-1-avinash.bhatt@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8412352DEE6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[avinash.bhatt@intel.com,linux-wireless@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-36376-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	RCVD_COUNT_FIVE(0.00)[5];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:mid,intel.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

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
 drivers/net/wireless/intel/iwlwifi/fw/dt.c    | 332 ++++++++++++++++++
 drivers/net/wireless/intel/iwlwifi/fw/dt.h    | 161 +++++++++
 drivers/net/wireless/intel/iwlwifi/fw/init.c  |   4 +-
 .../wireless/intel/iwlwifi/fw/regulatory.h    |   3 +-
 .../net/wireless/intel/iwlwifi/fw/runtime.h   |   6 +-
 intc-scripts/publishable-files                |   2 +
 9 files changed, 510 insertions(+), 8 deletions(-)
 create mode 100644 drivers/net/wireless/intel/iwlwifi/fw/dt.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/fw/dt.h

diff --git a/drivers/net/wireless/intel/iwlwifi/Makefile b/drivers/net/wireless/intel/iwlwifi/Makefile
index 060604fa6c..c7a2d5ee66 100644
--- a/drivers/net/wireless/intel/iwlwifi/Makefile
+++ b/drivers/net/wireless/intel/iwlwifi/Makefile
@@ -18,6 +18,7 @@ iwlwifi-$(CPTCFG_IWLMVM) += fw/paging.o fw/smem.o fw/init.o
 iwlwifi-$(CPTCFG_IWLMLD) += fw/smem.o fw/init.o
 iwlwifi-$(CONFIG_ACPI) += fw/acpi.o
 iwlwifi-$(CONFIG_EFI)	+= fw/uefi.o
+iwlwifi-$(CONFIG_OF)	+= fw/dt.o
 
 iwlwifi-$(CPTCFG_IWLXVT)	+= fw/paging.o fw/smem.o
 iwlwifi-$(CPTCFG_IWLPROD)	+= fw/init.o
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.h b/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
index a1f89ced15..2356365db2 100644
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
@@ -115,9 +115,6 @@
 #define ACPI_PPAG_WIFI_DATA_SIZE_V3	((ACPI_PPAG_NUM_CHAINS * \
 					  ACPI_PPAG_NUM_BANDS_V3) + 2)
 
-#define IWL_SAR_ENABLE_MSK		BIT(0)
-#define IWL_REDUCE_POWER_FLAGS_POS	1
-
 /* The Inidcator whether UEFI WIFI GUID tables are locked is read from ACPI */
 #define UEFI_WIFI_GUID_UNLOCKED		0
 
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h b/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h
index 2bec56937c..4b3b97f137 100644
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
@@ -527,11 +527,13 @@ struct iwl_tas_config_cmd_v2_v4 {
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
index 0000000000..5fd7628ec1
--- /dev/null
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dt.c
@@ -0,0 +1,332 @@
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
+/* PCI compatible strings for supported hardware */
+static const char * const iwl_dt_compatible[] = {
+	"pci8086,272b",	/* Intel Wi-Fi 7 BE200 */
+	NULL
+};
+
+void iwl_dt_init(struct iwl_fw_runtime *fwrt)
+{
+	struct device_node *node = dev_of_node(fwrt->dev);
+	const char * const *compat;
+
+	if (!node)
+		return;
+
+	for (compat = iwl_dt_compatible; *compat; compat++) {
+		if (of_device_is_compatible(node, *compat)) {
+			fwrt->dt_compatible = true;
+			return;
+		}
+	}
+
+	IWL_ERR(fwrt,
+		"DT node compatible does not match any supported hardware - ignoring DT\n");
+}
+IWL_EXPORT_SYMBOL(iwl_dt_init);
+
+/* intel,wcpe - channel puncturing enable bits */
+#define IWL_DT_WCPE_USA_EN		BIT(0)	/* USA */
+#define IWL_DT_WCPE_CANADA_EN		BIT(1)	/* Canada */
+#define IWL_DT_WCPE_MASK \
+	(IWL_DT_WCPE_USA_EN | IWL_DT_WCPE_CANADA_EN)
+
+/* SAR layout for "intel,wrds": 4 chains x 12 subbands */
+#define IWL_DT_WRDS_NUM_CHAINS		4
+#define IWL_DT_WRDS_NUM_SUBBANDS	12
+/* Total cell count: 1-cell mode header + SAR data */
+#define IWL_DT_WRDS_MAX_CELLS \
+	(1 + IWL_DT_WRDS_NUM_CHAINS * IWL_DT_WRDS_NUM_SUBBANDS)
+
+int iwl_dt_get_wrds_table(struct iwl_fw_runtime *fwrt)
+{
+	struct device_node *node = dev_of_node(fwrt->dev);
+	u32 buf[IWL_DT_WRDS_MAX_CELLS];
+	int ret;
+
+	if (!node)
+		return -ENOENT;
+
+	ret = of_property_read_u32_array(node, "intel,wrds", buf,
+					 IWL_DT_WRDS_MAX_CELLS);
+	if (ret) {
+		IWL_DEBUG_RADIO(fwrt, "DT: intel,wrds read failed (%d)\n", ret);
+		return ret;
+	}
+
+	IWL_DEBUG_RADIO(fwrt,
+			"DT: reading intel,wrds (%u chains, %u subbands)\n",
+			IWL_DT_WRDS_NUM_CHAINS, IWL_DT_WRDS_NUM_SUBBANDS);
+
+	/* buf[0]: mode; bit 0 (IWL_SAR_ENABLE_MSK) enables SAR */
+
+	BUILD_BUG_ON(IWL_DT_WRDS_NUM_CHAINS > BIOS_SAR_MAX_CHAINS_PER_PROFILE);
+	BUILD_BUG_ON(IWL_DT_WRDS_NUM_SUBBANDS > BIOS_SAR_MAX_SUB_BANDS_NUM);
+
+	/* buf[1..]: chains[0..N-1] x subbands[0..M-1] in row-major order */
+	for (int i = 0; i < IWL_DT_WRDS_NUM_CHAINS; i++) {
+		for (int j = 0; j < IWL_DT_WRDS_NUM_SUBBANDS; j++) {
+			u32 val = buf[1 + i * IWL_DT_WRDS_NUM_SUBBANDS + j];
+
+			if (val > U8_MAX) {
+				IWL_DEBUG_RADIO(fwrt,
+						"DT: intel,wrds OOB [%u][%u]=%u\n",
+						i, j, val);
+				return -EINVAL;
+			}
+			fwrt->sar_profiles[0].chains[i].subbands[j] = (u8)val;
+		}
+	}
+
+	if (buf[0] & IWL_SAR_ENABLE_MSK)
+		fwrt->sar_profiles[0].enabled = true;
+
+	return 0;
+}
+
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
+	prop_data = of_get_property(node, "intel,uats", &len);
+	if (!prop_data)
+		return;
+
+	if (len != (int)map_size) {
+		IWL_DEBUG_FW(fwrt,
+			     "DT: intel,uats bad length %d (expected %zu)\n",
+			     len, map_size);
+		return;
+	}
+
+	IWL_DEBUG_FW(fwrt, "DT: reading intel,uats\n");
+	memcpy(fwrt->ap_type_cmd.mcc_to_ap_type_map, prop_data, map_size);
+	fwrt->ap_type_cmd_valid = true;
+}
+IWL_EXPORT_SYMBOL(iwl_dt_get_uats_table);
+
+int iwl_dt_get_srd(struct iwl_fw_runtime *fwrt, u32 *value)
+{
+	struct device_node *node = dev_of_node(fwrt->dev);
+	const char *str;
+	int ret;
+
+	if (!node)
+		return -ENOENT;
+
+	ret = of_property_read_string(node, "intel,srd", &str);
+	if (ret)
+		return ret;
+
+	if (!strcmp(str, "active-scan"))
+		*value = 0;
+	else if (!strcmp(str, "passive-scan"))
+		*value = 1;
+	else if (!strcmp(str, "disabled"))
+		*value = 2;
+	else
+		return -EINVAL;
+
+	if (fwrt->dsm_source == BIOS_SOURCE_NONE) {
+		fwrt->dsm_source = BIOS_SOURCE_DT;
+		fwrt->dsm_revision = 0;
+	}
+
+	IWL_DEBUG_RADIO(fwrt, "DT: intel,srd = %s (%u)\n", str, *value);
+	return 0;
+}
+
+int iwl_dt_get_6e_uhb(struct iwl_fw_runtime *fwrt, u32 *value)
+{
+	struct device_node *node = dev_of_node(fwrt->dev);
+	int ret;
+
+	if (!node)
+		return -ENOENT;
+
+	ret = of_property_read_u32(node, "intel,6e-uhb", value);
+	if (ret)
+		return ret;
+
+	if (fwrt->dsm_source == BIOS_SOURCE_NONE) {
+		fwrt->dsm_source = BIOS_SOURCE_DT;
+		fwrt->dsm_revision = 0;
+	}
+
+	IWL_DEBUG_RADIO(fwrt, "DT: intel,6e-uhb = 0x%x\n", *value);
+	return 0;
+}
+
+int iwl_dt_get_regulatory_special(struct iwl_fw_runtime *fwrt, u32 *value)
+{
+	struct device_node *node = dev_of_node(fwrt->dev);
+	int ret;
+
+	if (!node)
+		return -ENOENT;
+
+	ret = of_property_read_u32(node, "intel,regulatory-special", value);
+	if (ret)
+		return ret;
+
+	if (fwrt->dsm_source == BIOS_SOURCE_NONE) {
+		fwrt->dsm_source = BIOS_SOURCE_DT;
+		fwrt->dsm_revision = 0;
+	}
+
+	IWL_DEBUG_RADIO(fwrt, "DT: intel,regulatory-special = 0x%x\n", *value);
+	return 0;
+}
+
+int iwl_dt_get_activate_channel(struct iwl_fw_runtime *fwrt, u32 *value)
+{
+	struct device_node *node = dev_of_node(fwrt->dev);
+	int ret;
+
+	if (!node)
+		return -ENOENT;
+
+	ret = of_property_read_u32(node, "intel,activate-channel", value);
+	if (ret)
+		return ret;
+
+	if (fwrt->dsm_source == BIOS_SOURCE_NONE) {
+		fwrt->dsm_source = BIOS_SOURCE_DT;
+		fwrt->dsm_revision = 0;
+	}
+
+	IWL_DEBUG_RADIO(fwrt, "DT: intel,activate-channel = 0x%x\n", *value);
+	return 0;
+}
+
+int iwl_dt_get_force_disable_channels(struct iwl_fw_runtime *fwrt, u32 *value)
+{
+	struct device_node *node = dev_of_node(fwrt->dev);
+	int ret;
+
+	if (!node)
+		return -ENOENT;
+
+	ret = of_property_read_u32(node, "intel,force-disable-channels", value);
+	if (ret)
+		return ret;
+
+	if (fwrt->dsm_source == BIOS_SOURCE_NONE) {
+		fwrt->dsm_source = BIOS_SOURCE_DT;
+		fwrt->dsm_revision = 0;
+	}
+
+	IWL_DEBUG_RADIO(fwrt, "DT: intel,force-disable-channels = 0x%x\n",
+			*value);
+	return 0;
+}
+
+int iwl_dt_get_11be(struct iwl_fw_runtime *fwrt, u32 *value)
+{
+	struct device_node *node = dev_of_node(fwrt->dev);
+	int ret;
+
+	if (!node)
+		return -ENOENT;
+
+	ret = of_property_read_u32(node, "intel,11be", value);
+	if (ret)
+		return ret;
+
+	if (fwrt->dsm_source == BIOS_SOURCE_NONE) {
+		fwrt->dsm_source = BIOS_SOURCE_DT;
+		fwrt->dsm_revision = 0;
+	}
+
+	IWL_DEBUG_RADIO(fwrt, "DT: intel,11be = 0x%x\n", *value);
+	return 0;
+}
+
+int iwl_dt_get_dsm(struct iwl_fw_runtime *fwrt, enum iwl_dsm_funcs func,
+		   u32 *value)
+{
+	switch (func) {
+	case DSM_FUNC_DISABLE_SRD:
+		return iwl_dt_get_srd(fwrt, value);
+	case DSM_FUNC_ENABLE_6E:
+		return iwl_dt_get_6e_uhb(fwrt, value);
+	case DSM_FUNC_REGULATORY_CONFIG:
+		return iwl_dt_get_regulatory_special(fwrt, value);
+	case DSM_FUNC_ACTIVATE_CHANNEL:
+		return iwl_dt_get_activate_channel(fwrt, value);
+	case DSM_FUNC_FORCE_DISABLE_CHANNELS:
+		return iwl_dt_get_force_disable_channels(fwrt, value);
+	case DSM_FUNC_ENABLE_11BE:
+		return iwl_dt_get_11be(fwrt, value);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+int iwl_dt_get_pwr_limit(struct iwl_fw_runtime *fwrt, u64 *data)
+{
+	struct device_node *node = dev_of_node(fwrt->dev);
+	u32 val;
+	int ret;
+
+	if (!node)
+		return -ENOENT;
+
+	ret = of_property_read_u32(node, "intel,splc", &val);
+	if (ret)
+		return ret;
+
+	*data = val;
+	IWL_DEBUG_RADIO(fwrt, "DT: intel,splc = %u mW\n", val);
+	return 0;
+}
+
+int iwl_dt_get_wbem(struct iwl_fw_runtime *fwrt, u32 *data)
+{
+	struct device_node *node = dev_of_node(fwrt->dev);
+	int ret;
+
+	if (!node)
+		return -ENOENT;
+
+	ret = of_property_read_u32(node, "intel,wbem", data);
+	if (ret)
+		return ret;
+
+	IWL_DEBUG_RADIO(fwrt, "DT: intel,wbem = 0x%x\n", *data);
+	return 0;
+}
+
+int iwl_dt_get_puncturing(struct iwl_fw_runtime *fwrt)
+{
+	struct device_node *node = dev_of_node(fwrt->dev);
+	u32 val;
+	int ret;
+
+	if (!node)
+		return 0;
+
+	ret = of_property_read_u32(node, "intel,wcpe", &val);
+	if (ret)
+		return 0;
+
+	IWL_DEBUG_RADIO(fwrt, "DT: intel,wcpe = 0x%x\n", val);
+	return val & IWL_DT_WCPE_MASK;
+}
+IWL_EXPORT_SYMBOL(iwl_dt_get_puncturing);
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dt.h b/drivers/net/wireless/intel/iwlwifi/fw/dt.h
new file mode 100644
index 0000000000..70ab6f309b
--- /dev/null
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dt.h
@@ -0,0 +1,161 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/*
+ * Copyright (C) 2026 Intel Corporation
+ */
+#ifndef __iwl_fw_dt_h__
+#define __iwl_fw_dt_h__
+
+#include "fw/runtime.h"
+
+/*
+ * Device Tree property parsing for Intel Wi-Fi 7 BE200 PCIe adapters.
+ *
+ * On platforms without UEFI variables or ACPI methods, regulatory and
+ * power configuration can be supplied via Device Tree properties in the
+ * Wi-Fi PCIe device node.
+ *
+ * DT is the lowest-priority source: UEFI variables take precedence, then
+ * ACPI methods, and finally these DT properties.
+ */
+
+#if IS_ENABLED(CONFIG_OF)
+
+/* Functions implemented in fw/dt.c */
+void iwl_dt_init(struct iwl_fw_runtime *fwrt);
+
+static inline bool iwl_dt_is_compatible(struct iwl_fw_runtime *fwrt)
+{
+	return fwrt->dt_compatible;
+}
+
+int iwl_dt_get_wrds_table(struct iwl_fw_runtime *fwrt);
+void iwl_dt_get_uats_table(struct iwl_fw_runtime *fwrt);
+int iwl_dt_get_srd(struct iwl_fw_runtime *fwrt, u32 *value);
+int iwl_dt_get_6e_uhb(struct iwl_fw_runtime *fwrt, u32 *value);
+int iwl_dt_get_regulatory_special(struct iwl_fw_runtime *fwrt, u32 *value);
+int iwl_dt_get_activate_channel(struct iwl_fw_runtime *fwrt, u32 *value);
+int iwl_dt_get_force_disable_channels(struct iwl_fw_runtime *fwrt, u32 *value);
+int iwl_dt_get_11be(struct iwl_fw_runtime *fwrt, u32 *value);
+int iwl_dt_get_dsm(struct iwl_fw_runtime *fwrt, enum iwl_dsm_funcs func,
+		   u32 *value);
+int iwl_dt_get_pwr_limit(struct iwl_fw_runtime *fwrt, u64 *data);
+int iwl_dt_get_wbem(struct iwl_fw_runtime *fwrt, u32 *data);
+int iwl_dt_get_puncturing(struct iwl_fw_runtime *fwrt);
+#else /* !CONFIG_OF */
+
+static inline void iwl_dt_init(struct iwl_fw_runtime *fwrt) {}
+
+static inline bool iwl_dt_is_compatible(struct iwl_fw_runtime *fwrt)
+{
+	return false;
+}
+
+static inline int iwl_dt_get_wrds_table(struct iwl_fw_runtime *fwrt)
+{
+	return -ENOENT;
+}
+
+static inline void iwl_dt_get_uats_table(struct iwl_fw_runtime *fwrt) {}
+
+static inline int iwl_dt_get_srd(struct iwl_fw_runtime *fwrt, u32 *value)
+{
+	return -ENOENT;
+}
+
+static inline int iwl_dt_get_6e_uhb(struct iwl_fw_runtime *fwrt, u32 *value)
+{
+	return -ENOENT;
+}
+
+static inline int iwl_dt_get_regulatory_special(struct iwl_fw_runtime *fwrt,
+						u32 *value)
+{
+	return -ENOENT;
+}
+
+static inline int iwl_dt_get_activate_channel(struct iwl_fw_runtime *fwrt,
+					      u32 *value)
+{
+	return -ENOENT;
+}
+
+static inline int iwl_dt_get_force_disable_channels(struct iwl_fw_runtime *fwrt,
+						    u32 *value)
+{
+	return -ENOENT;
+}
+
+static inline int iwl_dt_get_11be(struct iwl_fw_runtime *fwrt, u32 *value)
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
+static inline int iwl_dt_get_dsm(struct iwl_fw_runtime *fwrt,
+				 enum iwl_dsm_funcs func, u32 *value)
+{
+	return -ENOENT;
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
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/init.c b/drivers/net/wireless/intel/iwlwifi/fw/init.c
index d1d8058ad2..7d365947b3 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/init.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/init.c
@@ -1,12 +1,13 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
  * Copyright (C) 2017 Intel Deutschland GmbH
- * Copyright (C) 2019-2021, 2024-2025 Intel Corporation
+ * Copyright (C) 2019-2021, 2024-2026 Intel Corporation
  */
 #include "iwl-drv.h"
 #include "runtime.h"
 #include "dbg.h"
 #include "debugfs.h"
+#include "dt.h"
 
 #include "fw/api/system.h"
 #include "fw/api/commands.h"
@@ -36,6 +37,7 @@ void iwl_fw_runtime_init(struct iwl_fw_runtime *fwrt, struct iwl_trans *trans,
 		INIT_DELAYED_WORK(&fwrt->dump.wks[i].wk, iwl_fw_error_dump_wk);
 	}
 	iwl_fwrt_dbgfs_register(fwrt, dbgfs_dir);
+	iwl_dt_init(fwrt);
 }
 IWL_EXPORT_SYMBOL(iwl_fw_runtime_init);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h
index 0f6bc61142..a6add973ba 100644
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
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/runtime.h b/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
index cc976195b1..28161da63c 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
  * Copyright (C) 2017 Intel Deutschland GmbH
- * Copyright (C) 2018-2025 Intel Corporation
+ * Copyright (C) 2018-2026 Intel Corporation
  */
 #ifndef __iwl_fw_runtime_h__
 #define __iwl_fw_runtime_h__
@@ -108,6 +108,7 @@ struct iwl_txf_iter_data {
  * @dump: debug dump data
  * @ap_type_cmd: AP type tables (for enablement on 6 GHz)
  * @ap_type_cmd_valid: if &ap_type_cmd is valid
+ * @dt_compatible: true if the DT node compatible matches a supported device
  * @uefi_tables_lock_status: The status of the WIFI GUID UEFI variables lock:
  *	0: Unlocked, 1 and 2: Locked.
  *	Only read the UEFI variables if locked.
@@ -217,6 +218,9 @@ struct iwl_fw_runtime {
 	bool sgom_enabled;
 	struct iwl_mcc_allowed_ap_type_cmd ap_type_cmd;
 	bool ap_type_cmd_valid;
+#if IS_ENABLED(CONFIG_OF)
+	bool dt_compatible;
+#endif
 	u8 uefi_tables_lock_status;
 	struct iwl_phy_specific_cfg phy_filters;
 	enum bios_source dsm_source;
diff --git a/intc-scripts/publishable-files b/intc-scripts/publishable-files
index 81871178ba..91fc3f4d15 100644
--- a/intc-scripts/publishable-files
+++ b/intc-scripts/publishable-files
@@ -76,6 +76,8 @@ drivers/net/wireless/intel/iwlwifi/fw/dbg.h
 drivers/net/wireless/intel/iwlwifi/fw/debugfs.c
 drivers/net/wireless/intel/iwlwifi/fw/debugfs.h
 drivers/net/wireless/intel/iwlwifi/fw/dhc-utils.h
+drivers/net/wireless/intel/iwlwifi/fw/dt.c
+drivers/net/wireless/intel/iwlwifi/fw/dt.h
 drivers/net/wireless/intel/iwlwifi/fw/dump.c
 drivers/net/wireless/intel/iwlwifi/fw/error-dump.h
 drivers/net/wireless/intel/iwlwifi/fw/file.h
-- 
2.34.1


