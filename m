Return-Path: <linux-wireless+bounces-25202-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05943B0095F
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jul 2025 18:56:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FF2A3B7F12
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jul 2025 16:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAC482F19AA;
	Thu, 10 Jul 2025 16:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BRdZGHAl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261BC2F19A4
	for <linux-wireless@vger.kernel.org>; Thu, 10 Jul 2025 16:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752166529; cv=none; b=bUGGFAh44ufKCG8OSVKpmab1euBdDkN6WAsvhFsOVmd7NPyiHrWRYt5dmba7oMVTCtiM3+dnzPvC8YGROn0PP7W6N0noKvuQYwVejeYtzRpKoYGoNhR65fiBJVeI0FMA6mIsJMyyzHqwEhDJb6ZrO1VQZqNAWEz8cqDjVcwybBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752166529; c=relaxed/simple;
	bh=mYRfp6487bb7laxQQYZRlmLCxwV2G7YQBJ3QdiCg46E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KRFt0XOAqxCjQGoGJHxVjmoQ+UHE0fGdqqgI0h6Ac7RfMXekMS1ixofWNBX+/vq4KIwLJFkexRSPUXxCEp+Su66OpdrUNe1QschX2mfXOTXpsS9k41cyzvbOEZfzjnGfb2aOBMz++kO3/nbVKFdgX2AYVxmKXIFVxt7WsXrnUW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BRdZGHAl; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752166528; x=1783702528;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mYRfp6487bb7laxQQYZRlmLCxwV2G7YQBJ3QdiCg46E=;
  b=BRdZGHAlyX7xAdZR4ikZ3KcPs99pGRiwK3mXH8HyacmGHKZZ+Hj2G4ZI
   dHnx3alXrSMqmUPKq9RZLhIM52Sw9y6u+S8shOcw6JEMkZHIxKieYqFHa
   bBQSsWg3RNNxO+ECtPMcZRZSNgrnLcef3P9LY4PVTBp/ibE0x1nTft6v1
   yFepppOR4kCiLgYgGRuwBWSEI43kx6JGjRfPXhUGwrGJwqGSirLB/7JF1
   EQivOcPc8C+Q1dM330Leqs4H0GixvUEChG263GMglsrGHIDQUAEPut7C7
   Dl27E+yFRAaYcN0TgJ5GGHS8RgEs5/5pBbNXzHfmqShunoK7B7FoO8Kc4
   g==;
X-CSE-ConnectionGUID: EHJGvwVwRzaDz6t9CzckFg==
X-CSE-MsgGUID: imdqYOXBSHGgqpMtOaWmAQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="54610029"
X-IronPort-AV: E=Sophos;i="6.16,301,1744095600"; 
   d="scan'208";a="54610029"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 09:55:28 -0700
X-CSE-ConnectionGUID: O++qPNv6QmqisJ1RdvWrHg==
X-CSE-MsgGUID: 7lpt/ZbEQHa0jdTY2Mli/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,301,1744095600"; 
   d="scan'208";a="156277132"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 09:55:27 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Subject: [PATCH wireless-next 15/15] wifi: iwlwifi: add support for accepting raw DSM tables by firmware
Date: Thu, 10 Jul 2025 19:54:48 +0300
Message-Id: <20250710195219.eee871df03c9.I2be2eaa16437e84aa1be0c6c95ec334034ce7e50@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250710165448.2553296-1-miriam.rachel.korenblit@intel.com>
References: <20250710165448.2553296-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>

Firmware would assert on undefined bits in DSM-originated DWs.
With this change, Firmware introduces a fail-safe mechanism
and removes the assert behavior. This ensures robustness when
handling raw DSM table data.

Signed-off-by: Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../wireless/intel/iwlwifi/fw/api/nvm-reg.h   |  1 +
 .../net/wireless/intel/iwlwifi/fw/debugfs.c   |  6 ++++
 drivers/net/wireless/intel/iwlwifi/fw/file.h  |  3 ++
 .../wireless/intel/iwlwifi/fw/regulatory.c    | 35 ++++++++++++++-----
 .../wireless/intel/iwlwifi/fw/regulatory.h    |  4 +++
 .../wireless/intel/iwlwifi/mld/regulatory.c   | 30 ++++++++++++----
 6 files changed, 63 insertions(+), 16 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h b/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h
index 5cdc09d465d4..28ccac7d2142 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h
@@ -787,6 +787,7 @@ struct iwl_lari_config_change_cmd {
 /* Activate UNII-1 (5.2GHz) for World Wide */
 #define ACTIVATE_5G2_IN_WW_MASK			BIT(4)
 #define CHAN_STATE_ACTIVE_BITMAP_CMD_V11	0x1F
+#define CHAN_STATE_ACTIVE_BITMAP_CMD_V12	0x7F
 
 /**
  * struct iwl_pnvm_init_complete_ntfy - PNVM initialization complete
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/debugfs.c b/drivers/net/wireless/intel/iwlwifi/fw/debugfs.c
index 803ba35e7501..3b0e8c43ba4a 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/debugfs.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/debugfs.c
@@ -389,6 +389,12 @@ static int iwl_dbgfs_fw_info_seq_show(struct seq_file *seq, void *v)
 			   "    %d: %d\n",
 			   IWL_UCODE_TLV_CAPA_CHINA_22_REG_SUPPORT,
 			   has_capa);
+		has_capa = fw_has_capa(&fw->ucode_capa,
+				       IWL_UCODE_TLV_CAPA_FW_ACCEPTS_RAW_DSM_TABLE) ? 1 : 0;
+		seq_printf(seq,
+			   "    %d: %d\n",
+			   IWL_UCODE_TLV_CAPA_FW_ACCEPTS_RAW_DSM_TABLE,
+			   has_capa);
 		seq_puts(seq, "fw_api_ver:\n");
 	}
 
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/file.h b/drivers/net/wireless/intel/iwlwifi/fw/file.h
index dc1db563c5eb..b7c1ab7a3006 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/file.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/file.h
@@ -407,6 +407,8 @@ typedef unsigned int __bitwise iwl_ucode_tlv_capa_t;
  *	for CA from BIOS.
  * @IWL_UCODE_TLV_CAPA_UHB_CANADA_TAS_SUPPORT: supports %TAS_UHB_ALLOWED_CANADA
  * @IWL_UCODE_TLV_CAPA_EXT_FSEQ_IMAGE_SUPPORT: external FSEQ image support
+ * @IWL_UCODE_TLV_CAPA_FW_ACCEPTS_RAW_DSM_TABLE: Firmware has capability of
+ *	handling raw DSM table data.
  *
  * @NUM_IWL_UCODE_TLV_CAPA: number of bits used
  */
@@ -517,6 +519,7 @@ enum iwl_ucode_tlv_capa {
 	 *	during assert handling even if the dump isn't split
 	 */
 	IWL_UCODE_TLV_CAPA_RESET_DURING_ASSERT		= (__force iwl_ucode_tlv_capa_t)(4 * 32 +  0),
+	IWL_UCODE_TLV_CAPA_FW_ACCEPTS_RAW_DSM_TABLE 	= (__force iwl_ucode_tlv_capa_t)(4 * 32 + 1),
 	NUM_IWL_UCODE_TLV_CAPA
 /*
  * This construction make both sparse (which cannot increment the previous
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c
index 74b90bd92c48..3d6d1a85bb51 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c
@@ -579,6 +579,8 @@ int iwl_fill_lari_config(struct iwl_fw_runtime *fwrt,
 {
 	int ret;
 	u32 value;
+	bool has_raw_dsm_capa = fw_has_capa(&fwrt->fw->ucode_capa,
+					    IWL_UCODE_TLV_CAPA_FW_ACCEPTS_RAW_DSM_TABLE);
 	u8 cmd_ver = iwl_fw_lookup_cmd_ver(fwrt->fw,
 					   WIDE_ID(REGULATORY_AND_NVM_GROUP,
 						   LARI_CONFIG_CHANGE), 1);
@@ -593,17 +595,22 @@ int iwl_fill_lari_config(struct iwl_fw_runtime *fwrt,
 	cmd->config_bitmap = iwl_get_lari_config_bitmap(fwrt);
 
 	ret = iwl_bios_get_dsm(fwrt, DSM_FUNC_11AX_ENABLEMENT, &value);
-	if (!ret)
+	if (!ret) {
+		if (!has_raw_dsm_capa)
+			value &= DSM_11AX_ALLOW_BITMAP;
 		cmd->oem_11ax_allow_bitmap = cpu_to_le32(value);
+	}
 
 	ret = iwl_bios_get_dsm(fwrt, DSM_FUNC_ENABLE_UNII4_CHAN, &value);
 	if (!ret) {
-		value &= DSM_UNII4_ALLOW_BITMAP;
+		if (!has_raw_dsm_capa)
+			value &= DSM_UNII4_ALLOW_BITMAP;
 
 		/* Since version 9, bits 4 and 5 are supported
-		 * regardless of this capability.
+		 * regardless of this capability, By pass this masking
+		 * if firmware has capability of accepting raw DSM table.
 		 */
-		if (cmd_ver < 9 &&
+		if (!has_raw_dsm_capa && cmd_ver < 9 &&
 		    !fw_has_capa(&fwrt->fw->ucode_capa,
 				 IWL_UCODE_TLV_CAPA_BIOS_OVERRIDE_5G9_FOR_CA))
 			value &= ~(DSM_VALUE_UNII4_CANADA_OVERRIDE_MSK |
@@ -614,13 +621,17 @@ int iwl_fill_lari_config(struct iwl_fw_runtime *fwrt,
 
 	ret = iwl_bios_get_dsm(fwrt, DSM_FUNC_ACTIVATE_CHANNEL, &value);
 	if (!ret) {
-		if (cmd_ver < 8)
+		if (!has_raw_dsm_capa)
+			value &= CHAN_STATE_ACTIVE_BITMAP_CMD_V12;
+
+		if (!has_raw_dsm_capa && cmd_ver < 8)
 			value &= ~ACTIVATE_5G2_IN_WW_MASK;
 
 		/* Since version 12, bits 5 and 6 are supported
-		 * regardless of this capability.
+		 * regardless of this capability, By pass this masking
+		 * if firmware has capability of accepting raw DSM table.
 		 */
-		if (cmd_ver < 12 &&
+		if (!has_raw_dsm_capa && cmd_ver < 12 &&
 		    !fw_has_capa(&fwrt->fw->ucode_capa,
 				 IWL_UCODE_TLV_CAPA_BIOS_OVERRIDE_UNII4_US_CA))
 			value &= CHAN_STATE_ACTIVE_BITMAP_CMD_V11;
@@ -633,13 +644,19 @@ int iwl_fill_lari_config(struct iwl_fw_runtime *fwrt,
 		cmd->oem_uhb_allow_bitmap = cpu_to_le32(value);
 
 	ret = iwl_bios_get_dsm(fwrt, DSM_FUNC_FORCE_DISABLE_CHANNELS, &value);
-	if (!ret)
+	if (!ret) {
+		if (!has_raw_dsm_capa)
+			value &= DSM_FORCE_DISABLE_CHANNELS_ALLOWED_BITMAP;
 		cmd->force_disable_channels_bitmap = cpu_to_le32(value);
+	}
 
 	ret = iwl_bios_get_dsm(fwrt, DSM_FUNC_ENERGY_DETECTION_THRESHOLD,
 			       &value);
-	if (!ret)
+	if (!ret) {
+		if (!has_raw_dsm_capa)
+			value &= DSM_EDT_ALLOWED_BITMAP;
 		cmd->edt_bitmap = cpu_to_le32(value);
+	}
 
 	ret = iwl_bios_get_wbem(fwrt, &value);
 	if (!ret)
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h
index 9bed3d573b1e..a07c512b6ed4 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h
@@ -159,6 +159,10 @@ enum iwl_dsm_unii4_bitmap {
 				DSM_VALUE_UNII4_CANADA_OVERRIDE_MSK	|\
 				DSM_VALUE_UNII4_CANADA_EN_MSK)
 
+#define DSM_11AX_ALLOW_BITMAP				0xF
+#define DSM_EDT_ALLOWED_BITMAP				0x7ffff0
+#define DSM_FORCE_DISABLE_CHANNELS_ALLOWED_BITMAP	0x7FF
+
 enum iwl_dsm_values_rfi {
 	DSM_VALUE_RFI_DLVR_DISABLE	= BIT(0),
 	DSM_VALUE_RFI_DDR_DISABLE	= BIT(1),
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/regulatory.c b/drivers/net/wireless/intel/iwlwifi/mld/regulatory.c
index 326c300470ea..887f1fb2f926 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/regulatory.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/regulatory.c
@@ -238,34 +238,50 @@ void iwl_mld_configure_lari(struct iwl_mld *mld)
 	struct iwl_lari_config_change_cmd cmd = {
 		.config_bitmap = iwl_get_lari_config_bitmap(fwrt),
 	};
+	bool has_raw_dsm_capa = fw_has_capa(&fwrt->fw->ucode_capa,
+					    IWL_UCODE_TLV_CAPA_FW_ACCEPTS_RAW_DSM_TABLE);
 	int ret;
 	u32 value;
 
 	ret = iwl_bios_get_dsm(fwrt, DSM_FUNC_11AX_ENABLEMENT, &value);
-	if (!ret)
+	if (!ret) {
+		if (!has_raw_dsm_capa)
+			value &= DSM_11AX_ALLOW_BITMAP;
 		cmd.oem_11ax_allow_bitmap = cpu_to_le32(value);
+	}
 
 	ret = iwl_bios_get_dsm(fwrt, DSM_FUNC_ENABLE_UNII4_CHAN, &value);
-	if (!ret)
-		cmd.oem_unii4_allow_bitmap =
-			cpu_to_le32(value &= DSM_UNII4_ALLOW_BITMAP);
+	if (!ret) {
+		if (!has_raw_dsm_capa)
+			value &= DSM_UNII4_ALLOW_BITMAP;
+		cmd.oem_unii4_allow_bitmap = cpu_to_le32(value);
+	}
 
 	ret = iwl_bios_get_dsm(fwrt, DSM_FUNC_ACTIVATE_CHANNEL, &value);
-	if (!ret)
+	if (!ret) {
+		if (!has_raw_dsm_capa)
+			value &= CHAN_STATE_ACTIVE_BITMAP_CMD_V12;
 		cmd.chan_state_active_bitmap = cpu_to_le32(value);
+	}
 
 	ret = iwl_bios_get_dsm(fwrt, DSM_FUNC_ENABLE_6E, &value);
 	if (!ret)
 		cmd.oem_uhb_allow_bitmap = cpu_to_le32(value);
 
 	ret = iwl_bios_get_dsm(fwrt, DSM_FUNC_FORCE_DISABLE_CHANNELS, &value);
-	if (!ret)
+	if (!ret) {
+		if (!has_raw_dsm_capa)
+			value &= DSM_FORCE_DISABLE_CHANNELS_ALLOWED_BITMAP;
 		cmd.force_disable_channels_bitmap = cpu_to_le32(value);
+	}
 
 	ret = iwl_bios_get_dsm(fwrt, DSM_FUNC_ENERGY_DETECTION_THRESHOLD,
 			       &value);
-	if (!ret)
+	if (!ret) {
+		if (!has_raw_dsm_capa)
+			value &= DSM_EDT_ALLOWED_BITMAP;
 		cmd.edt_bitmap = cpu_to_le32(value);
+	}
 
 	ret = iwl_bios_get_wbem(fwrt, &value);
 	if (!ret)
-- 
2.34.1


