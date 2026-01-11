Return-Path: <linux-wireless+bounces-30662-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 440ACD0F87D
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Jan 2026 18:41:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B263130963F8
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Jan 2026 17:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CC8A29AAF8;
	Sun, 11 Jan 2026 17:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SULgVpaX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B250434C155
	for <linux-wireless@vger.kernel.org>; Sun, 11 Jan 2026 17:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768153193; cv=none; b=El1wDZjmsVImQhrlauQiiyotOwH0DizHl2hmx65rKpH8xGu9P9D/q4UqkUspM0xYF8kWB3bS3Z8Uz+uhNFKQOJxy20RolId/w1pIiG+3+b2V1/1f375H2wim1lJ0Q6yR/VOKLIDFJBnpMTuax81bYAdsdKaFWqRQ2FMooEZ8gEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768153193; c=relaxed/simple;
	bh=XnJrhF+EXKvjCs2mKJ4Hcltxqei8AlpCgLMOTYFS5Us=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SrQK3MOT/5dgbgADTxyOp5zzflfoj9C4GRSSYsx3r6hRJqyIgbPqrQZDYUtZU78L+kJ5GWOBdFZzvTUvPQ2SJ5imRTGCe0Zr90cid6RMlqtfgk3t3btdSzdv1HOL/EM4diAMWeCEU/T7xpqYCUOvTD4DqYZ/+yeDcqtx4JGM6No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SULgVpaX; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768153191; x=1799689191;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XnJrhF+EXKvjCs2mKJ4Hcltxqei8AlpCgLMOTYFS5Us=;
  b=SULgVpaX7ijlJFQ69ishyx/otMvwDRDmj79rEcY9wAyok7uXCExuMktj
   2mIg1gKUn28MGqSYlEA7XJqgHY0e6m3rqwQN2RzaXMFkw3BLxX3T1r+vo
   l9XqvfK2ljgWGWsCBhr3NRdzmjoHthmp6CRz9KJ9uPpVDiG4p67NQBjRe
   tf9ku8wc+eE6N4a+DsnE4j6fLkINaWocZPRJUR8iL+BLtf0pTjAa4G+gB
   fWukKGSkqBzIlT+Z1uktNjUftd8ehhakhqEOa6adHq6KxMWbFFGVTq7JV
   dmnzlH884wl4f3Q5iDDoFNdmAgo+DRctS4GEB2M9E3G2t7ojtEnRJ5TPn
   Q==;
X-CSE-ConnectionGUID: YVROHv37SmODpOsDtIr5+Q==
X-CSE-MsgGUID: Uak+jjtoRj2MIOoWOxnyBg==
X-IronPort-AV: E=McAfee;i="6800,10657,11668"; a="69521097"
X-IronPort-AV: E=Sophos;i="6.21,219,1763452800"; 
   d="scan'208";a="69521097"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2026 09:39:50 -0800
X-CSE-ConnectionGUID: /hFt3b/dRBqhvW0gfL58og==
X-CSE-MsgGUID: pdG/57LaRK2YSg/hakryxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,219,1763452800"; 
   d="scan'208";a="208393812"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2026 09:39:49 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH iwlwifi-next 12/15] wifi: iwlwifi: support V13 of iwl_lari_config_change_cmd
Date: Sun, 11 Jan 2026 19:39:23 +0200
Message-Id: <20260111193638.9577f0cade21.I82b26f082f152a83eb9990dddf68d7dcc549f227@changeid>
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

This command is getting a new field for UNII-9 and ieee80211bn
enablement.
We must read the relevant DSM values and pass them to the firmware,
Remember whether we have ACPI or UEFI available in the firmware runtime
object and remember the DSM function revision.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c  |  5 +++
 .../wireless/intel/iwlwifi/fw/api/nvm-reg.h   | 14 ++++++-
 .../wireless/intel/iwlwifi/fw/regulatory.h    |  4 +-
 .../net/wireless/intel/iwlwifi/fw/runtime.h   |  4 ++
 drivers/net/wireless/intel/iwlwifi/fw/uefi.c  |  2 +
 .../wireless/intel/iwlwifi/mld/regulatory.c   | 40 +++++++++++++++++--
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   |  3 +-
 7 files changed, 65 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
index 4d37ca984c41..66846451d3a5 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
@@ -28,6 +28,8 @@ static const size_t acpi_dsm_size[DSM_FUNC_NUM_FUNCS] = {
 	[DSM_FUNC_ENERGY_DETECTION_THRESHOLD] =	sizeof(u32),
 	[DSM_FUNC_RFI_CONFIG] =			sizeof(u32),
 	[DSM_FUNC_ENABLE_11BE] =		sizeof(u32),
+	[DSM_FUNC_ENABLE_UNII_9] =		sizeof(u32),
+	[DSM_FUNC_ENABLE_11BN] =		sizeof(u32),
 };
 
 static int iwl_acpi_get_handle(struct device *dev, acpi_string method,
@@ -177,6 +179,9 @@ static int iwl_acpi_load_dsm_values(struct iwl_fw_runtime *fwrt)
 		return ret;
 	}
 
+	fwrt->dsm_revision = ACPI_DSM_REV;
+	fwrt->dsm_source = BIOS_SOURCE_ACPI;
+
 	IWL_DEBUG_RADIO(fwrt, "ACPI DSM validity bitmap 0x%x\n",
 			(u32)query_func_val);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h b/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h
index 48f407baed39..f6b59e009036 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h
@@ -658,6 +658,10 @@ struct iwl_lari_config_change_cmd_v8 {
  *	bit0: enable 11be in China(CB/CN).
  *	bit1: enable 11be in South Korea.
  *	bit 2 - 31: reserved.
+ * @oem_11bn_allow_bitmap: Bitmap of 11bn allowed MCCs. The firmware expects to
+ *	get the data from the BIOS.
+ * @oem_unii9_enable: UNII-9 enablement as read from the BIOS
+ * @bios_hdr: bios config header
  */
 struct iwl_lari_config_change_cmd {
 	__le32 config_bitmap;
@@ -669,8 +673,16 @@ struct iwl_lari_config_change_cmd {
 	__le32 edt_bitmap;
 	__le32 oem_320mhz_allow_bitmap;
 	__le32 oem_11be_allow_bitmap;
+	/* since version 13 */
+	__le32 oem_11bn_allow_bitmap;
+	/* since version 13 */
+	__le32 oem_unii9_enable;
+	/* since version 13 */
+	struct iwl_bios_config_hdr bios_hdr;
 } __packed;
-/* LARI_CHANGE_CONF_CMD_S_VER_12 */
+/* LARI_CHANGE_CONF_CMD_S_VER_12
+ * LARI_CHANGE_CONF_CMD_S_VER_13
+ */
 
 /* Activate UNII-1 (5.2GHz) for World Wide */
 #define ACTIVATE_5G2_IN_WW_MASK			BIT(4)
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h
index 26c1d3fad4df..1489031687b7 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h
@@ -125,7 +125,9 @@ enum iwl_dsm_funcs {
 	DSM_FUNC_ENERGY_DETECTION_THRESHOLD = 10,
 	DSM_FUNC_RFI_CONFIG = 11,
 	DSM_FUNC_ENABLE_11BE = 12,
-	DSM_FUNC_NUM_FUNCS = 13,
+	DSM_FUNC_ENABLE_11BN = 13,
+	DSM_FUNC_ENABLE_UNII_9 = 14,
+	DSM_FUNC_NUM_FUNCS,
 };
 
 enum iwl_dsm_values_srd {
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/runtime.h b/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
index 54fca80d3301..e694637f5373 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
@@ -141,6 +141,8 @@ struct iwl_txf_iter_data {
  * @timestamp.seq: timestamp marking sequence
  * @timestamp.delay: timestamp marking worker delay
  * @tpc_enabled: TPC enabled
+ * @dsm_source: one of &enum bios_source. UEFI, ACPI or NONE
+ * @dsm_revision: the revision of the DSM table
  */
 struct iwl_fw_runtime {
 	struct iwl_trans *trans;
@@ -215,6 +217,8 @@ struct iwl_fw_runtime {
 	bool uats_valid;
 	u8 uefi_tables_lock_status;
 	struct iwl_phy_specific_cfg phy_filters;
+	enum bios_source dsm_source;
+	u8 dsm_revision;
 
 #if defined(CONFIG_ACPI) || defined (CONFIG_EFI)
 	u32 dsm_funcs_valid;
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/uefi.c b/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
index acccb22a833c..b7532494d4e0 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
@@ -738,6 +738,8 @@ static int iwl_uefi_load_dsm_values(struct iwl_fw_runtime *fwrt)
 				data->revision);
 		goto out;
 	}
+	fwrt->dsm_revision = data->revision;
+	fwrt->dsm_source = BIOS_SOURCE_UEFI;
 
 	fwrt->dsm_funcs_valid = data->functions[DSM_FUNC_QUERY];
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/regulatory.c b/drivers/net/wireless/intel/iwlwifi/mld/regulatory.c
index 7d11036f9e04..6ab5a3410353 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/regulatory.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/regulatory.c
@@ -281,6 +281,14 @@ void iwl_mld_configure_lari(struct iwl_mld *mld)
 	if (!ret)
 		cmd.oem_11be_allow_bitmap = cpu_to_le32(value);
 
+	ret = iwl_bios_get_dsm(fwrt, DSM_FUNC_ENABLE_11BN, &value);
+	if (!ret)
+		cmd.oem_11bn_allow_bitmap = cpu_to_le32(value);
+
+	ret = iwl_bios_get_dsm(fwrt, DSM_FUNC_ENABLE_UNII_9, &value);
+	if (!ret)
+		cmd.oem_unii9_enable = cpu_to_le32(value);
+
 	if (!cmd.config_bitmap &&
 	    !cmd.oem_uhb_allow_bitmap &&
 	    !cmd.oem_11ax_allow_bitmap &&
@@ -289,9 +297,14 @@ void iwl_mld_configure_lari(struct iwl_mld *mld)
 	    !cmd.force_disable_channels_bitmap &&
 	    !cmd.edt_bitmap &&
 	    !cmd.oem_320mhz_allow_bitmap &&
-	    !cmd.oem_11be_allow_bitmap)
+	    !cmd.oem_11be_allow_bitmap &&
+	    !cmd.oem_11bn_allow_bitmap &&
+	    !cmd.oem_unii9_enable)
 		return;
 
+	cmd.bios_hdr.table_source = fwrt->dsm_source;
+	cmd.bios_hdr.table_revision = fwrt->dsm_revision;
+
 	IWL_DEBUG_RADIO(mld,
 			"sending LARI_CONFIG_CHANGE, config_bitmap=0x%x, oem_11ax_allow_bitmap=0x%x\n",
 			le32_to_cpu(cmd.config_bitmap),
@@ -311,9 +324,28 @@ void iwl_mld_configure_lari(struct iwl_mld *mld)
 	IWL_DEBUG_RADIO(mld,
 			"sending LARI_CONFIG_CHANGE, oem_11be_allow_bitmap=0x%x\n",
 			le32_to_cpu(cmd.oem_11be_allow_bitmap));
-
-	ret = iwl_mld_send_cmd_pdu(mld, WIDE_ID(REGULATORY_AND_NVM_GROUP,
-						LARI_CONFIG_CHANGE), &cmd);
+	IWL_DEBUG_RADIO(mld,
+			"sending LARI_CONFIG_CHANGE, oem_11bn_allow_bitmap=0x%x\n",
+			le32_to_cpu(cmd.oem_11bn_allow_bitmap));
+	IWL_DEBUG_RADIO(mld,
+			"sending LARI_CONFIG_CHANGE, oem_unii9_enable=0x%x\n",
+			le32_to_cpu(cmd.oem_unii9_enable));
+
+	if (iwl_fw_lookup_cmd_ver(mld->fw,
+				  WIDE_ID(REGULATORY_AND_NVM_GROUP,
+					  LARI_CONFIG_CHANGE), 12) == 12) {
+		int cmd_size = offsetof(typeof(cmd), oem_11bn_allow_bitmap);
+
+		ret = iwl_mld_send_cmd_pdu(mld,
+					   WIDE_ID(REGULATORY_AND_NVM_GROUP,
+						   LARI_CONFIG_CHANGE),
+					   &cmd, cmd_size);
+	} else {
+		ret = iwl_mld_send_cmd_pdu(mld,
+					   WIDE_ID(REGULATORY_AND_NVM_GROUP,
+						   LARI_CONFIG_CHANGE),
+					   &cmd);
+	}
 	if (ret)
 		IWL_DEBUG_RADIO(mld,
 				"Failed to send LARI_CONFIG_CHANGE (%d)\n",
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index a34ca8073ca8..43cf94c9a36b 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -1220,7 +1220,8 @@ static size_t iwl_mvm_get_lari_config_cmd_size(u8 cmd_ver)
 
 	switch (cmd_ver) {
 	case 12:
-		cmd_size = sizeof(struct iwl_lari_config_change_cmd);
+		cmd_size = offsetof(struct iwl_lari_config_change_cmd,
+				    oem_11bn_allow_bitmap);
 		break;
 	case 8:
 		cmd_size = sizeof(struct iwl_lari_config_change_cmd_v8);
-- 
2.34.1


