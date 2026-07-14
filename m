Return-Path: <linux-wireless+bounces-39054-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id aTnCCIYeVmq9zQAAu9opvQ
	(envelope-from <linux-wireless+bounces-39054-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 13:33:26 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BD665753EEA
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 13:33:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=XlYJyLRZ;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-39054-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-wireless+bounces-39054-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3821A30099A2
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 11:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEF4634750D;
	Tue, 14 Jul 2026 11:33:23 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011EE35BDC7
	for <linux-wireless@vger.kernel.org>; Tue, 14 Jul 2026 11:33:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784028803; cv=none; b=fy4ovLODYzcioflZCYI5jzpxJRzA5dwb5uMnaovtW251lqSbJRHLCK7kVbMLcedB+Jhzmoba+wK4lP0Oj1SCJTx+gurUWuvOyiJ0ygN9MLSONQndCOo6KKE75t/8DdkGlqX+jUko4mNaXcB17hBxbV+Ly1B8JDrzGDa09gH7oMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784028803; c=relaxed/simple;
	bh=qZ+e8JH/4dYMFns7Kk4u62WW51GSv7rgxwQGKlGTY1o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Tb3S0FltqpBcDZSwnRQSmoe+XanbsxWzIOICnWoHs4QOUGfsbWU776TIC9VIIMIdQanHyELP09iL3NWR+dkZkkP6rV0fTnaRDWk68ln33ENc600UifI7P8ka9Rm21vmljfPPGq/+p5WjDpyEpLg08XV8yCpXXvnWQqH+R+rHdD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XlYJyLRZ; arc=none smtp.client-ip=192.198.163.12
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784028802; x=1815564802;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qZ+e8JH/4dYMFns7Kk4u62WW51GSv7rgxwQGKlGTY1o=;
  b=XlYJyLRZKvdsfcRihbFCV7bb+Ap2b8xYm9TCb7N0oS5Lfp+lYm2SgXL0
   O5EAgifZtVuZ3K9QMdWCFKE30veA/R/8iZzowgO42hZCtXq0/cnihb82j
   iQMa2CHyuae3kSh7DSyL4NwFIWJkygHUUM+J2aZ1moaESUGfORuDuzpFI
   5+jSHm0jyJEiYdJ2PxxfY37lczoT+gqkPuMkvxycpuMgwbLsFUXAPelvd
   pr70LEGiqMXvAoINb+Ttg/TOehKY/qa1hejbfKrsIaUQxk5gYwJAzaKcj
   MxAF6Od6XamzHLAbVLXRbb81dAPD2qcY7J/VVxwRGhjclbbMZBjsgB8x0
   g==;
X-CSE-ConnectionGUID: 7cacStjLQnCdKBf4Dhysww==
X-CSE-MsgGUID: BAb8iRStRBWX0BCOXEEygg==
X-IronPort-AV: E=McAfee;i="6800,10657,11846"; a="88469608"
X-IronPort-AV: E=Sophos;i="6.25,163,1779174000"; 
   d="scan'208";a="88469608"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 04:33:22 -0700
X-CSE-ConnectionGUID: lwVjklweTammPobJQxJHXA==
X-CSE-MsgGUID: rm/NPDVfSOK6bn2rjxTQww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,163,1779174000"; 
   d="scan'208";a="255882981"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 04:33:20 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Subject: [PATCH iwlwifi-next 12/15] wifi: iwlwifi: regulatory: add LARI_CONFIG_CHANGE command v14 support
Date: Tue, 14 Jul 2026 14:32:38 +0300
Message-Id: <20260714143119.c73d2fbebbfe.I93af7c456f04ef10d03646a43aaeb1858ecdc36d@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260714143119.a549b9499e3e.Id1a95bbbf92b5862862becaf57419bb9fe1385e5@changeid>
References: <20260714143119.a549b9499e3e.Id1a95bbbf92b5862862becaf57419bb9fe1385e5@changeid>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-39054-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:linux-wireless@vger.kernel.org,m:pagadala.yesu.anjaneyulu@intel.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[changeid:mid,intel.com:from_mime,intel.com:email,intel.com:dkim,vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BD665753EEA

From: Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>

Add support for LARI_CONFIG_CHANGE version 14 and populate
the newly added BIOS-related fields in the command payload.

Extend the version 14 command layout with UHB extension, puncturing and
WBEM metadata fields, update command-size handling for version negotiation,
and wire the new data into the LARI configuration flow. Track WBEM and
puncturing source/revision in fw runtime, set them when loading ACPI or
UEFI tables, and pass the headers to firmware. Update send conditions,
debug traces, and related documentation/comments to match the new format.

Signed-off-by: Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c  |  4 +-
 .../wireless/intel/iwlwifi/fw/api/nvm-reg.h   | 15 ++++-
 .../net/wireless/intel/iwlwifi/fw/runtime.h   | 13 +++-
 drivers/net/wireless/intel/iwlwifi/fw/uefi.c  | 20 ++++---
 drivers/net/wireless/intel/iwlwifi/fw/uefi.h  |  4 +-
 drivers/net/wireless/intel/iwlwifi/mld/mcc.c  |  2 +-
 drivers/net/wireless/intel/iwlwifi/mld/mld.c  |  2 +-
 drivers/net/wireless/intel/iwlwifi/mld/mld.h  |  2 -
 .../wireless/intel/iwlwifi/mld/regulatory.c   | 60 ++++++++++++++-----
 9 files changed, 88 insertions(+), 34 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
index bf0f851a9075..9f2f4a6af1ca 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
  * Copyright (C) 2017 Intel Deutschland GmbH
- * Copyright (C) 2019-2025 Intel Corporation
+ * Copyright (C) 2019-2026 Intel Corporation
  */
 #include <linux/uuid.h>
 #include "iwl-drv.h"
@@ -1188,6 +1188,8 @@ int iwl_acpi_get_wbem(struct iwl_fw_runtime *fwrt, u32 *value)
 
 	*value = wifi_pkg->package.elements[1].integer.value &
 		 IWL_ACPI_WBEM_REV0_MASK;
+	fwrt->wbem_source = BIOS_SOURCE_ACPI;
+	fwrt->wbem_revision = tbl_rev;
 	IWL_DEBUG_RADIO(fwrt, "Loaded WBEM config from ACPI\n");
 	ret = 0;
 out_free:
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h b/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h
index 443a9a416325..d8ec9934a9b6 100644
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
@@ -662,6 +662,12 @@ struct iwl_lari_config_change_cmd_v8 {
  *	get the data from the BIOS.
  * @oem_unii9_enable: UNII-9 enablement as read from the BIOS
  * @bios_hdr: bios config header
+ * @oem_uhb_allow_extension_bitmap: DSM Function 4 data as an extension of UHB
+ *	enabled MCC sets
+ * @bios_wcpe_hdr: puncturing config header
+ * @wcpe_bitmap: bitmap of puncturing enablement per MCC
+ * @bios_wbem_hdr: 320 MHz per-MCC WBEM config header
+ * @reserved: reserved
  */
 struct iwl_lari_config_change_cmd {
 	__le32 config_bitmap;
@@ -679,9 +685,16 @@ struct iwl_lari_config_change_cmd {
 	__le32 oem_unii9_enable;
 	/* since version 13 */
 	struct iwl_bios_config_hdr bios_hdr;
+	/* All the below are since version 14 */
+	__le32 oem_uhb_allow_extension_bitmap;
+	struct iwl_bios_config_hdr bios_wcpe_hdr;
+	__le32 wcpe_bitmap;
+	struct iwl_bios_config_hdr bios_wbem_hdr;
+	__le32 reserved[10];
 } __packed;
 /* LARI_CHANGE_CONF_CMD_S_VER_12
  * LARI_CHANGE_CONF_CMD_S_VER_13
+ * LARI_CHANGE_CONF_CMD_S_VER_14
  */
 
 /* Activate UNII-1 (5.2GHz) for World Wide */
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/runtime.h b/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
index d80ae610e56c..ac01ac0092ee 100644
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
@@ -144,6 +144,11 @@ struct iwl_txf_iter_data {
  * @tpc_enabled: TPC enabled
  * @dsm_source: one of &enum bios_source. UEFI, ACPI or NONE
  * @dsm_revision: the revision of the DSM table
+ * @wbem_source: one of &enum bios_source for the WBEM table
+ * @wbem_revision: the revision of the WBEM table
+ * @puncturing_source: one of &enum bios_source for the puncturing table
+ * @puncturing_revision: the revision of the puncturing table
+ * @bios_puncturing: per-country puncturing enablement bitmap from BIOS
  */
 struct iwl_fw_runtime {
 	struct iwl_trans *trans;
@@ -226,6 +231,12 @@ struct iwl_fw_runtime {
 	u32 dsm_funcs_valid;
 	u32 dsm_values[DSM_FUNC_NUM_FUNCS];
 #endif
+
+	enum bios_source wbem_source;
+	u8 wbem_revision;
+	enum bios_source puncturing_source;
+	u8 puncturing_revision;
+	u32 bios_puncturing;
 };
 
 void iwl_fw_runtime_init(struct iwl_fw_runtime *fwrt, struct iwl_trans *trans,
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/uefi.c b/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
index 2ef0a7a920ad..1046d4fecb72 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright(c) 2021-2025 Intel Corporation
+ * Copyright(c) 2021-2026 Intel Corporation
  */
 
 #include "iwl-drv.h"
@@ -884,6 +884,8 @@ int iwl_uefi_get_wbem(struct iwl_fw_runtime *fwrt, u32 *value)
 		goto out;
 	}
 	*value = data->wbem_320mhz_per_mcc & IWL_UEFI_WBEM_REV0_MASK;
+	fwrt->wbem_source = BIOS_SOURCE_UEFI;
+	fwrt->wbem_revision = data->revision;
 	IWL_DEBUG_RADIO(fwrt, "Loaded WBEM config from UEFI\n");
 out:
 	kfree(data);
@@ -970,29 +972,29 @@ int iwl_uefi_get_dsm(struct iwl_fw_runtime *fwrt, enum iwl_dsm_funcs func,
 int iwl_uefi_get_puncturing(struct iwl_fw_runtime *fwrt)
 {
 	struct uefi_cnv_var_puncturing_data *data;
-	/* default value is not enabled if there is any issue in reading
-	 * uefi variable or revision is not supported
-	 */
-	int puncturing = 0;
+	int ret = 0;
 
 	data = iwl_uefi_get_verified_variable(fwrt->trans,
 					      IWL_UEFI_PUNCTURING_NAME,
 					      "UefiCnvWlanPuncturing",
 					      sizeof(*data), NULL);
 	if (IS_ERR(data))
-		return puncturing;
+		return -EINVAL;
 
 	if (data->revision != IWL_UEFI_PUNCTURING_REVISION) {
 		IWL_DEBUG_RADIO(fwrt, "Unsupported UEFI PUNCTURING rev:%d\n",
 				data->revision);
+		ret = -EINVAL;
 	} else {
-		puncturing = data->puncturing & IWL_UEFI_PUNCTURING_REV0_MASK;
+		fwrt->puncturing_source = BIOS_SOURCE_UEFI;
+		fwrt->puncturing_revision = data->revision;
+		fwrt->bios_puncturing = data->puncturing;
 		IWL_DEBUG_RADIO(fwrt, "Loaded puncturing bits from UEFI: %d\n",
-				puncturing);
+				fwrt->bios_puncturing);
 	}
 
 	kfree(data);
-	return puncturing;
+	return ret;
 }
 IWL_EXPORT_SYMBOL(iwl_uefi_get_puncturing);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/uefi.h b/drivers/net/wireless/intel/iwlwifi/fw/uefi.h
index 474f06db4d43..386ca3744408 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/uefi.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/uefi.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright(c) 2021-2025 Intel Corporation
+ * Copyright(c) 2021-2026 Intel Corporation
  */
 #ifndef __iwl_fw_uefi__
 #define __iwl_fw_uefi__
@@ -275,8 +275,6 @@ enum iwl_uefi_cnv_puncturing_flags {
 	IWL_UEFI_CNV_PUNCTURING_CANADA_EN_MSK	= BIT(1),
 };
 
-#define IWL_UEFI_PUNCTURING_REV0_MASK (IWL_UEFI_CNV_PUNCTURING_USA_EN_MSK | \
-				       IWL_UEFI_CNV_PUNCTURING_CANADA_EN_MSK)
 /**
  * struct uefi_cnv_var_puncturing_data - controlling channel
  *	puncturing for few countries.
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mcc.c b/drivers/net/wireless/intel/iwlwifi/mld/mcc.c
index 8502129abe49..7649ae794dfd 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mcc.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mcc.c
@@ -131,7 +131,7 @@ iwl_mld_get_regdomain(struct iwl_mld *mld,
 
 	/* FM follows BIOS/MCC policy, WH disallows puncturing only in US/CA. */
 	if (CSR_HW_RFID_TYPE(mld->trans->info.hw_rf_id) == IWL_CFG_RF_TYPE_FM) {
-		if (!iwl_puncturing_is_allowed_in_bios(mld->bios_enable_puncturing,
+		if (!iwl_puncturing_is_allowed_in_bios(mld->fwrt.bios_puncturing,
 						       le16_to_cpu(resp->mcc)))
 			ieee80211_hw_set(mld->hw, DISALLOW_PUNCTURING);
 		else
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mld.c b/drivers/net/wireless/intel/iwlwifi/mld/mld.c
index 5a6c9ab20fd6..99506f354bfa 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mld.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mld.c
@@ -419,7 +419,7 @@ iwl_op_mode_mld_start(struct iwl_trans *trans, const struct iwl_rf_cfg *cfg,
 
 	iwl_mld_get_bios_tables(mld);
 	iwl_uefi_get_sgom_table(trans, &mld->fwrt);
-	mld->bios_enable_puncturing = iwl_uefi_get_puncturing(&mld->fwrt);
+	iwl_uefi_get_puncturing(&mld->fwrt);
 
 	iwl_mld_hw_set_regulatory(mld);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mld.h b/drivers/net/wireless/intel/iwlwifi/mld/mld.h
index 922aa3dbff54..37f41b504b54 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mld.h
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mld.h
@@ -172,7 +172,6 @@
  * @debug_max_sleep: maximum sleep time in D3 (for debug purposes)
  * @led: the led device
  * @mcc_src: the source id of the MCC, comes from the firmware
- * @bios_enable_puncturing: is puncturing enabled by bios
  * @fw_id_to_ba: maps a fw (BA) id to a corresponding Block Ack session data.
  * @num_rx_ba_sessions: tracks the number of active Rx Block Ack (BA) sessions.
  *	the driver ensures that new BA sessions are blocked once the maximum
@@ -279,7 +278,6 @@ struct iwl_mld {
 	struct led_classdev led;
 #endif
 	enum iwl_mcc_source mcc_src;
-	bool bios_enable_puncturing;
 
 	struct iwl_mld_baid_data __rcu *fw_id_to_ba[IWL_MAX_BAID];
 	u8 num_rx_ba_sessions;
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/regulatory.c b/drivers/net/wireless/intel/iwlwifi/mld/regulatory.c
index 858635607f5d..4a93ccbef495 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/regulatory.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/regulatory.c
@@ -13,6 +13,23 @@
 #include "mld.h"
 #include "hcmd.h"
 
+static ssize_t iwl_mld_get_lari_config_cmd_size(u8 cmd_ver)
+{
+	switch (cmd_ver) {
+	case 14:
+		return sizeof(struct iwl_lari_config_change_cmd);
+	case 13:
+		return offsetof(struct iwl_lari_config_change_cmd,
+				oem_uhb_allow_extension_bitmap);
+	case 12:
+		return offsetof(struct iwl_lari_config_change_cmd,
+				oem_11bn_allow_bitmap);
+	default:
+		WARN(true, "unsupported version: %d", cmd_ver);
+		return -EINVAL;
+	}
+}
+
 void iwl_mld_get_bios_tables(struct iwl_mld *mld)
 {
 	int ret;
@@ -335,9 +352,13 @@ void iwl_mld_configure_lari(struct iwl_mld *mld)
 	bool has_raw_dsm_capa = cmd_ver >= 13 ||
 		fw_has_capa(&fwrt->fw->ucode_capa,
 			    IWL_UCODE_TLV_CAPA_FW_ACCEPTS_RAW_DSM_TABLE);
+	ssize_t cmd_len = iwl_mld_get_lari_config_cmd_size(cmd_ver);
 	int ret;
 	u32 value;
 
+	if (cmd_len < 0)
+		return;
+
 	ret = iwl_bios_get_dsm(fwrt, DSM_FUNC_11AX_ENABLEMENT, &value);
 	if (!ret) {
 		if (!has_raw_dsm_capa)
@@ -379,8 +400,11 @@ void iwl_mld_configure_lari(struct iwl_mld *mld)
 	}
 
 	ret = iwl_bios_get_wbem(fwrt, &value);
-	if (!ret)
+	if (!ret) {
 		cmd.oem_320mhz_allow_bitmap = cpu_to_le32(value);
+		cmd.bios_wbem_hdr.table_source = fwrt->wbem_source;
+		cmd.bios_wbem_hdr.table_revision = fwrt->wbem_revision;
+	}
 
 	ret = iwl_bios_get_dsm(fwrt, DSM_FUNC_ENABLE_11BE, &value);
 	if (!ret)
@@ -394,8 +418,17 @@ void iwl_mld_configure_lari(struct iwl_mld *mld)
 	if (!ret)
 		cmd.oem_unii9_enable = cpu_to_le32(value);
 
+	ret = iwl_bios_get_dsm(fwrt, DSM_FUNC_REGULATORY_CONFIG, &value);
+	if (!ret)
+		cmd.oem_uhb_allow_extension_bitmap = cpu_to_le32(value);
+
+	cmd.bios_wcpe_hdr.table_source = fwrt->puncturing_source;
+	cmd.bios_wcpe_hdr.table_revision = fwrt->puncturing_revision;
+	cmd.wcpe_bitmap = cpu_to_le32(fwrt->bios_puncturing);
+
 	if (!cmd.config_bitmap &&
 	    !cmd.oem_uhb_allow_bitmap &&
+	    !cmd.oem_uhb_allow_extension_bitmap &&
 	    !cmd.oem_11ax_allow_bitmap &&
 	    !cmd.oem_unii4_allow_bitmap &&
 	    !cmd.chan_state_active_bitmap &&
@@ -404,7 +437,8 @@ void iwl_mld_configure_lari(struct iwl_mld *mld)
 	    !cmd.oem_320mhz_allow_bitmap &&
 	    !cmd.oem_11be_allow_bitmap &&
 	    !cmd.oem_11bn_allow_bitmap &&
-	    !cmd.oem_unii9_enable)
+	    !cmd.oem_unii9_enable &&
+	    !cmd.wcpe_bitmap)
 		return;
 
 	cmd.bios_hdr.table_source = fwrt->dsm_source;
@@ -422,6 +456,9 @@ void iwl_mld_configure_lari(struct iwl_mld *mld)
 			"sending LARI_CONFIG_CHANGE, oem_uhb_allow_bitmap=0x%x, force_disable_channels_bitmap=0x%x\n",
 			le32_to_cpu(cmd.oem_uhb_allow_bitmap),
 			le32_to_cpu(cmd.force_disable_channels_bitmap));
+	IWL_DEBUG_RADIO(mld,
+			"sending LARI_CONFIG_CHANGE, oem_uhb_allow_extension_bitmap=0x%x\n",
+			le32_to_cpu(cmd.oem_uhb_allow_extension_bitmap));
 	IWL_DEBUG_RADIO(mld,
 			"sending LARI_CONFIG_CHANGE, edt_bitmap=0x%x, oem_320mhz_allow_bitmap=0x%x\n",
 			le32_to_cpu(cmd.edt_bitmap),
@@ -435,20 +472,13 @@ void iwl_mld_configure_lari(struct iwl_mld *mld)
 	IWL_DEBUG_RADIO(mld,
 			"sending LARI_CONFIG_CHANGE, oem_unii9_enable=0x%x\n",
 			le32_to_cpu(cmd.oem_unii9_enable));
+	IWL_DEBUG_RADIO(mld,
+			"sending LARI_CONFIG_CHANGE, wcpe_bitmap=0x%x\n",
+			le32_to_cpu(cmd.wcpe_bitmap));
 
-	if (cmd_ver == 12) {
-		int cmd_size = offsetof(typeof(cmd), oem_11bn_allow_bitmap);
-
-		ret = iwl_mld_send_cmd_pdu(mld,
-					   WIDE_ID(REGULATORY_AND_NVM_GROUP,
-						   LARI_CONFIG_CHANGE),
-					   &cmd, cmd_size);
-	} else {
-		ret = iwl_mld_send_cmd_pdu(mld,
-					   WIDE_ID(REGULATORY_AND_NVM_GROUP,
-						   LARI_CONFIG_CHANGE),
-					   &cmd);
-	}
+	ret = iwl_mld_send_cmd_pdu(mld,
+				   WIDE_ID(REGULATORY_AND_NVM_GROUP,
+					   LARI_CONFIG_CHANGE), &cmd, cmd_len);
 	if (ret)
 		IWL_DEBUG_RADIO(mld,
 				"Failed to send LARI_CONFIG_CHANGE (%d)\n",
-- 
2.34.1


