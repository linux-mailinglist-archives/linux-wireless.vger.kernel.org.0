Return-Path: <linux-wireless+bounces-33568-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wPDwCKwBvWkO5gIAu9opvQ
	(envelope-from <linux-wireless+bounces-33568-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 09:13:32 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D1DD32D6FFC
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 09:13:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 96122304892B
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 08:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26AF037A4B5;
	Fri, 20 Mar 2026 08:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iVMPDble"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12C537B3F5
	for <linux-wireless@vger.kernel.org>; Fri, 20 Mar 2026 08:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773994182; cv=none; b=OJpnQPe8KgkYUT0Dk82BroZ4slFL7EbjbL+kBN/kS79m5vDxh28icb14Valw5f/PSzRY+oO6y9M3GlF5rGzZLneZl4rE/g3/8AQZYAGLB/4+NB3Q0sUUK6t+36DdW2dRaDD/xxaw6PD8iOKRnamqg32nbDd5TFn6SL7kYtEOtm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773994182; c=relaxed/simple;
	bh=vPTXA+eDP5jEgdmHA5H8E+tAj6TSSLNVj8IH6MXu0dE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IuwtDmUZiOC1AywDtddM5Xg947qlDabxEosM9I1ACC4LJPWcHo75Mq/3gY1mB8G1fk3IFTNrEXeoC7JNgp7QDb113JksX4YVc1ffniM1MgF+b4iRz41gL5EwoO3hLvoNo22+VHr4WXwq0nrk1qyzJgL5r0G1B0V9Ed0MMkdJCZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iVMPDble; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773994180; x=1805530180;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vPTXA+eDP5jEgdmHA5H8E+tAj6TSSLNVj8IH6MXu0dE=;
  b=iVMPDblecpY9Je3ZWM4zDU2/TC8otL9fXEWgHqxT83sGImcrHjiSYYaF
   zZxijjHYCHkvoj5+RBCaKQb7tKxDKm8ik41bGLk3QhAwOwW4vqUb83kVy
   ggh2rPxHXvCz4ESTr5Zoo8fnFwmfDi0KJ1wmclSMQocoZBCt5NRQql1M5
   Fhjo0amz0eAcA4Wh+o52UvBYqnNJy/pZI4Ml57clzHVVT5gK5O/Kwjjj0
   OjkMsZj9BdJrDUSpWqD5+a5jRSthd2KRnOJzqd5xZgH/4WEsO7WDljbrk
   4WxxzoqJ7hiHWdCnwyTuSD7WEYyAJ7sRjrwkpfxPtNYRHdfKorjVfb1Jg
   g==;
X-CSE-ConnectionGUID: BVD07OovRu2xEtcwVwl2JQ==
X-CSE-MsgGUID: +YSu5RRFTpaoXK4hjYY69Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="86154126"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="86154126"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 01:09:40 -0700
X-CSE-ConnectionGUID: NelIHSeyR+2IWMffYJMaPw==
X-CSE-MsgGUID: iIAfvybDRE2xzw/id4x/8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="227692576"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 01:09:39 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 07/15] wifi: iwlwifi: fw: Add TLV support for BIOS revision of command
Date: Fri, 20 Mar 2026 10:09:10 +0200
Message-Id: <20260320100746.76c8a9589ea0.I7f9157115de702e07511f2c3ed5fcb9ae4c667aa@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260320080918.2567780-1-miriam.rachel.korenblit@intel.com>
References: <20260320080918.2567780-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33568-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: D1DD32D6FFC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>

Add support for newer firmware API versions that support
multiple BIOS revisions. Use the new TLV provided by
firmware to determine which BIOS revision it supports.

Future patches will use this information to either
drop commands when the BIOS revision is higher than
supported or convert commands based on the command
specific implementation.

Signed-off-by: Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/file.h | 15 +++++++++
 drivers/net/wireless/intel/iwlwifi/fw/img.c  | 32 +++++++++++++++++++-
 drivers/net/wireless/intel/iwlwifi/fw/img.h  |  8 +++++
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c | 21 +++++++++++++
 4 files changed, 75 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/file.h b/drivers/net/wireless/intel/iwlwifi/fw/file.h
index 378788de1d74..f7a6f21267e9 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/file.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/file.h
@@ -103,6 +103,7 @@ enum iwl_ucode_tlv_type {
 	IWL_UCODE_TLV_D3_KEK_KCK_ADDR		= 67,
 	IWL_UCODE_TLV_CURRENT_PC		= 68,
 	IWL_UCODE_TLV_FSEQ_BIN_VERSION		= 72,
+	IWL_UCODE_TLV_CMD_BIOS_TABLE		= 73,
 
 	/* contains sub-sections like PNVM file does (did) */
 	IWL_UCODE_TLV_PNVM_DATA			= 74,
@@ -1040,6 +1041,20 @@ struct iwl_fw_cmd_version {
 	u8 notif_ver;
 } __packed;
 
+/**
+ * struct iwl_fw_cmd_bios_table - firmware command BIOS revision entry
+ * @cmd: command ID
+ * @group: group ID
+ * @max_acpi_revision: max supported ACPI revision of command.
+ * @max_uefi_revision: max supported UEFI revision of command.
+ */
+struct iwl_fw_cmd_bios_table {
+	u8 cmd;
+	u8 group;
+	u8 max_acpi_revision;
+	u8 max_uefi_revision;
+} __packed;
+
 struct iwl_fw_tcm_error_addr {
 	__le32 addr;
 }; /* FW_TLV_TCM_ERROR_INFO_ADDRS_S */
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/img.c b/drivers/net/wireless/intel/iwlwifi/fw/img.c
index c2f4fc83a22c..3cc1e3ae0858 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/img.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/img.c
@@ -1,11 +1,41 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
  * Copyright(c) 2019 - 2021 Intel Corporation
- * Copyright(c) 2024 Intel Corporation
+ * Copyright(c) 2024 - 2025 Intel Corporation
  */
 #include <fw/api/commands.h>
 #include "img.h"
 
+u8 iwl_fw_lookup_cmd_bios_supported_revision(const struct iwl_fw *fw,
+					     enum bios_source table_source,
+					     u32 cmd_id, u8 def)
+{
+	const struct iwl_fw_cmd_bios_table *entry;
+	/* prior to LONG_GROUP, we never used this CMD version API */
+	u8 grp = iwl_cmd_groupid(cmd_id) ?: LONG_GROUP;
+	u8 cmd = iwl_cmd_opcode(cmd_id);
+
+	if (table_source != BIOS_SOURCE_ACPI &&
+	    table_source != BIOS_SOURCE_UEFI)
+		return def;
+
+	if (!fw->ucode_capa.cmd_bios_tables ||
+	    !fw->ucode_capa.n_cmd_bios_tables)
+		return def;
+
+	entry = fw->ucode_capa.cmd_bios_tables;
+	for (int i = 0; i < fw->ucode_capa.n_cmd_bios_tables; i++, entry++) {
+		if (entry->group == grp && entry->cmd == cmd) {
+			if (table_source == BIOS_SOURCE_ACPI)
+				return entry->max_acpi_revision;
+			return entry->max_uefi_revision;
+		}
+	}
+
+	return def;
+}
+EXPORT_SYMBOL_GPL(iwl_fw_lookup_cmd_bios_supported_revision);
+
 u8 iwl_fw_lookup_cmd_ver(const struct iwl_fw *fw, u32 cmd_id, u8 def)
 {
 	const struct iwl_fw_cmd_version *entry;
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/img.h b/drivers/net/wireless/intel/iwlwifi/fw/img.h
index 045a3e009429..94113d1db8e1 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/img.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/img.h
@@ -9,6 +9,7 @@
 #include <linux/types.h>
 
 #include "api/dbg-tlv.h"
+#include "api/nvm-reg.h"
 
 #include "file.h"
 #include "error-dump.h"
@@ -57,6 +58,9 @@ struct iwl_ucode_capabilities {
 
 	const struct iwl_fw_cmd_version *cmd_versions;
 	u32 n_cmd_versions;
+
+	const struct iwl_fw_cmd_bios_table *cmd_bios_tables;
+	u32 n_cmd_bios_tables;
 };
 
 static inline bool
@@ -274,6 +278,10 @@ iwl_get_ucode_image(const struct iwl_fw *fw, enum iwl_ucode_type ucode_type)
 	return &fw->img[ucode_type];
 }
 
+u8 iwl_fw_lookup_cmd_bios_supported_revision(const struct iwl_fw *fw,
+					     enum bios_source table_source,
+					     u32 cmd_id, u8 def);
+
 u8 iwl_fw_lookup_cmd_ver(const struct iwl_fw *fw, u32 cmd_id, u8 def);
 
 u8 iwl_fw_lookup_notif_ver(const struct iwl_fw *fw, u8 grp, u8 cmd, u8 def);
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
index 475b3e417efa..4cdd0fe1b788 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
@@ -133,6 +133,7 @@ static void iwl_dealloc_ucode(struct iwl_drv *drv)
 	kfree(drv->fw.dbg.mem_tlv);
 	kfree(drv->fw.iml);
 	kfree(drv->fw.ucode_capa.cmd_versions);
+	kfree(drv->fw.ucode_capa.cmd_bios_tables);
 	kfree(drv->fw.phy_integration_ver);
 	kfree(drv->trans->dbg.pc_data);
 	drv->trans->dbg.pc_data = NULL;
@@ -1426,6 +1427,26 @@ static int iwl_parse_tlv_firmware(struct iwl_drv *drv,
 				return -ENOMEM;
 			drv->fw.pnvm_size = tlv_len;
 			break;
+		case IWL_UCODE_TLV_CMD_BIOS_TABLE:
+			if (tlv_len % sizeof(struct iwl_fw_cmd_bios_table)) {
+				IWL_ERR(drv,
+					"Invalid length for command bios table: %u\n",
+					tlv_len);
+				return -EINVAL;
+			}
+
+			if (capa->cmd_bios_tables) {
+				IWL_ERR(drv, "Duplicate TLV type 0x%02X detected\n",
+					tlv_type);
+				return -EINVAL;
+			}
+			capa->cmd_bios_tables = kmemdup(tlv_data, tlv_len,
+							GFP_KERNEL);
+			if (!capa->cmd_bios_tables)
+				return -ENOMEM;
+			capa->n_cmd_bios_tables =
+				tlv_len / sizeof(struct iwl_fw_cmd_bios_table);
+			break;
 		default:
 			IWL_DEBUG_INFO(drv, "unknown TLV: %d\n", tlv_type);
 			break;
-- 
2.34.1


