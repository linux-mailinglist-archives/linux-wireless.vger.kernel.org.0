Return-Path: <linux-wireless+bounces-30655-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A6AED0F868
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Jan 2026 18:40:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 90384306C579
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Jan 2026 17:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B76C21ABBB;
	Sun, 11 Jan 2026 17:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KFmNT5Ui"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D8734C155
	for <linux-wireless@vger.kernel.org>; Sun, 11 Jan 2026 17:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768153186; cv=none; b=JRVLc9vpkSQHDC8r47GmUmxm0OIujViKjUfZGTpWbiLKXVZ6AT3P+BqpQ//beRi5eSa/vJ3UBLzpKaXEXLsodV9rGoj4Y5iC8uJ60ffqn+XO5X8iw8HTaxdkNmDh1nmM4LiHdu5aEf+DCzdtwpkQlHOENKwlZRH6fYs5CG4ovoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768153186; c=relaxed/simple;
	bh=wIE3hqJ/DwBletgfLJ51tixWekIwvFKAcW3WXaikDrY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=L+EZ8o2kg0jKa92sFa5a0he/OmBHVmRugS0vpVMADAbOKw4U1YzNxVVYKB5/aMYW6AFRrX5bUQabsKyPIoH07o8ohk73sVzlzIPyX96zgZZgSKeeI0vIIXyEz7qZuGnC1l+K7zEqlOxWteohFUZ5DkUafqyl2afbwdXo44U8G2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KFmNT5Ui; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768153183; x=1799689183;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wIE3hqJ/DwBletgfLJ51tixWekIwvFKAcW3WXaikDrY=;
  b=KFmNT5UiK/v8K0CKTP5akcYBt7qZmkjrXD5J0u2Nr1GoQE7egOev9+3Y
   1iT6hJcyd6eMj4JhVM+WXMyKjs9BVIqlWVJns/K6dJVhlYhXAYGom4Gwk
   7OXZ6HqJOBucO7ZgiqD9NbpXWze/Oiso+sqSLGBobDrZy+sqrV1c+/ngp
   D9m6/6A8IE1Lg/pSCTKCi8M69jIt6+F/eDvTpIlveXmVW2kwschioL9HG
   9j6CfdbLdrxAhChXUgRESFjURvKdEPQDLuyOo+e+ARlUH7gr8RsNvuggQ
   jkETZGepiCL8uwVOdERvQpeF6ZUaOkrGhtXj1lytEfWe/4CbfBNjCdmkY
   A==;
X-CSE-ConnectionGUID: 3wB9P4NgSs2O4GbCEwprCw==
X-CSE-MsgGUID: eQONUmPpTji3hzVfDhzpIw==
X-IronPort-AV: E=McAfee;i="6800,10657,11668"; a="69521088"
X-IronPort-AV: E=Sophos;i="6.21,219,1763452800"; 
   d="scan'208";a="69521088"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2026 09:39:43 -0800
X-CSE-ConnectionGUID: GlkPVcmmSluOEoYYa7OwLg==
X-CSE-MsgGUID: aXPYZnbvSbiwPPY2ro3Xiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,219,1763452800"; 
   d="scan'208";a="208393793"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2026 09:39:42 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH iwlwifi-next 06/15] wifi: iwlwifi: move lari helper functions to the op_mode
Date: Sun, 11 Jan 2026 19:39:17 +0200
Message-Id: <20260111193638.4bb241e436cb.I3d80796d4722376ce24a847419d34723083baaa8@changeid>
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

iwlmvm is the only op_mode that uses the lari helper functions. iwlmld
has its own version to avoid introducing regressions.
Move all those functions to iwlmvm, as they are more related to the
op_mode.
iwl_get_lari_config_bitmap will move in the next patch.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../wireless/intel/iwlwifi/fw/regulatory.c    | 151 ------------------
 .../wireless/intel/iwlwifi/fw/regulatory.h    |   3 -
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   | 148 ++++++++++++++++-
 3 files changed, 147 insertions(+), 155 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c
index d2ad169ae880..7e7af2b81181 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c
@@ -537,157 +537,6 @@ __le32 iwl_get_lari_config_bitmap(struct iwl_fw_runtime *fwrt)
 }
 IWL_EXPORT_SYMBOL(iwl_get_lari_config_bitmap);
 
-static size_t iwl_get_lari_config_cmd_size(u8 cmd_ver)
-{
-	size_t cmd_size;
-
-	switch (cmd_ver) {
-	case 12:
-		cmd_size = sizeof(struct iwl_lari_config_change_cmd);
-		break;
-	case 8:
-		cmd_size = sizeof(struct iwl_lari_config_change_cmd_v8);
-		break;
-	case 6:
-		cmd_size = sizeof(struct iwl_lari_config_change_cmd_v6);
-		break;
-	default:
-		cmd_size = sizeof(struct iwl_lari_config_change_cmd_v1);
-		break;
-	}
-	return cmd_size;
-}
-
-int iwl_fill_lari_config(struct iwl_fw_runtime *fwrt,
-			 struct iwl_lari_config_change_cmd *cmd,
-			 size_t *cmd_size)
-{
-	int ret;
-	u32 value;
-	bool has_raw_dsm_capa = fw_has_capa(&fwrt->fw->ucode_capa,
-					    IWL_UCODE_TLV_CAPA_FW_ACCEPTS_RAW_DSM_TABLE);
-	u8 cmd_ver = iwl_fw_lookup_cmd_ver(fwrt->fw,
-					   WIDE_ID(REGULATORY_AND_NVM_GROUP,
-						   LARI_CONFIG_CHANGE), 1);
-
-	if (WARN_ONCE(cmd_ver > 12,
-		      "Don't add newer versions to this function\n"))
-		return -EINVAL;
-
-	memset(cmd, 0, sizeof(*cmd));
-	*cmd_size = iwl_get_lari_config_cmd_size(cmd_ver);
-
-	cmd->config_bitmap = iwl_get_lari_config_bitmap(fwrt);
-
-	ret = iwl_bios_get_dsm(fwrt, DSM_FUNC_11AX_ENABLEMENT, &value);
-	if (!ret) {
-		if (!has_raw_dsm_capa)
-			value &= DSM_11AX_ALLOW_BITMAP;
-		cmd->oem_11ax_allow_bitmap = cpu_to_le32(value);
-	}
-
-	ret = iwl_bios_get_dsm(fwrt, DSM_FUNC_ENABLE_UNII4_CHAN, &value);
-	if (!ret) {
-		if (!has_raw_dsm_capa)
-			value &= DSM_UNII4_ALLOW_BITMAP;
-
-		/* Since version 12, bits 4 and 5 are supported
-		 * regardless of this capability, By pass this masking
-		 * if firmware has capability of accepting raw DSM table.
-		 */
-		if (!has_raw_dsm_capa && cmd_ver < 12 &&
-		    !fw_has_capa(&fwrt->fw->ucode_capa,
-				 IWL_UCODE_TLV_CAPA_BIOS_OVERRIDE_5G9_FOR_CA))
-			value &= ~(DSM_VALUE_UNII4_CANADA_OVERRIDE_MSK |
-				   DSM_VALUE_UNII4_CANADA_EN_MSK);
-
-		cmd->oem_unii4_allow_bitmap = cpu_to_le32(value);
-	}
-
-	ret = iwl_bios_get_dsm(fwrt, DSM_FUNC_ACTIVATE_CHANNEL, &value);
-	if (!ret) {
-		if (!has_raw_dsm_capa)
-			value &= CHAN_STATE_ACTIVE_BITMAP_CMD_V12;
-
-		if (!has_raw_dsm_capa && cmd_ver < 8)
-			value &= ~ACTIVATE_5G2_IN_WW_MASK;
-
-		/* Since version 12, bits 5 and 6 are supported
-		 * regardless of this capability, By pass this masking
-		 * if firmware has capability of accepting raw DSM table.
-		 */
-		if (!has_raw_dsm_capa && cmd_ver < 12 &&
-		    !fw_has_capa(&fwrt->fw->ucode_capa,
-				 IWL_UCODE_TLV_CAPA_BIOS_OVERRIDE_UNII4_US_CA))
-			value &= CHAN_STATE_ACTIVE_BITMAP_CMD_V8;
-
-		cmd->chan_state_active_bitmap = cpu_to_le32(value);
-	}
-
-	ret = iwl_bios_get_dsm(fwrt, DSM_FUNC_ENABLE_6E, &value);
-	if (!ret)
-		cmd->oem_uhb_allow_bitmap = cpu_to_le32(value);
-
-	ret = iwl_bios_get_dsm(fwrt, DSM_FUNC_FORCE_DISABLE_CHANNELS, &value);
-	if (!ret) {
-		if (!has_raw_dsm_capa)
-			value &= DSM_FORCE_DISABLE_CHANNELS_ALLOWED_BITMAP;
-		cmd->force_disable_channels_bitmap = cpu_to_le32(value);
-	}
-
-	ret = iwl_bios_get_dsm(fwrt, DSM_FUNC_ENERGY_DETECTION_THRESHOLD,
-			       &value);
-	if (!ret) {
-		if (!has_raw_dsm_capa)
-			value &= DSM_EDT_ALLOWED_BITMAP;
-		cmd->edt_bitmap = cpu_to_le32(value);
-	}
-
-	ret = iwl_bios_get_wbem(fwrt, &value);
-	if (!ret)
-		cmd->oem_320mhz_allow_bitmap = cpu_to_le32(value);
-
-	ret = iwl_bios_get_dsm(fwrt, DSM_FUNC_ENABLE_11BE, &value);
-	if (!ret)
-		cmd->oem_11be_allow_bitmap = cpu_to_le32(value);
-
-	if (cmd->config_bitmap ||
-	    cmd->oem_uhb_allow_bitmap ||
-	    cmd->oem_11ax_allow_bitmap ||
-	    cmd->oem_unii4_allow_bitmap ||
-	    cmd->chan_state_active_bitmap ||
-	    cmd->force_disable_channels_bitmap ||
-	    cmd->edt_bitmap ||
-	    cmd->oem_320mhz_allow_bitmap ||
-	    cmd->oem_11be_allow_bitmap) {
-		IWL_DEBUG_RADIO(fwrt,
-				"sending LARI_CONFIG_CHANGE, config_bitmap=0x%x, oem_11ax_allow_bitmap=0x%x\n",
-				le32_to_cpu(cmd->config_bitmap),
-				le32_to_cpu(cmd->oem_11ax_allow_bitmap));
-		IWL_DEBUG_RADIO(fwrt,
-				"sending LARI_CONFIG_CHANGE, oem_unii4_allow_bitmap=0x%x, chan_state_active_bitmap=0x%x, cmd_ver=%d\n",
-				le32_to_cpu(cmd->oem_unii4_allow_bitmap),
-				le32_to_cpu(cmd->chan_state_active_bitmap),
-				cmd_ver);
-		IWL_DEBUG_RADIO(fwrt,
-				"sending LARI_CONFIG_CHANGE, oem_uhb_allow_bitmap=0x%x, force_disable_channels_bitmap=0x%x\n",
-				le32_to_cpu(cmd->oem_uhb_allow_bitmap),
-				le32_to_cpu(cmd->force_disable_channels_bitmap));
-		IWL_DEBUG_RADIO(fwrt,
-				"sending LARI_CONFIG_CHANGE, edt_bitmap=0x%x, oem_320mhz_allow_bitmap=0x%x\n",
-				le32_to_cpu(cmd->edt_bitmap),
-				le32_to_cpu(cmd->oem_320mhz_allow_bitmap));
-		IWL_DEBUG_RADIO(fwrt,
-				"sending LARI_CONFIG_CHANGE, oem_11be_allow_bitmap=0x%x\n",
-				le32_to_cpu(cmd->oem_11be_allow_bitmap));
-	} else {
-		return 1;
-	}
-
-	return 0;
-}
-IWL_EXPORT_SYMBOL(iwl_fill_lari_config);
-
 int iwl_bios_get_dsm(struct iwl_fw_runtime *fwrt, enum iwl_dsm_funcs func,
 		     u32 *value)
 {
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h
index 735482e7adf5..859cb303f813 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h
@@ -219,9 +219,6 @@ int iwl_bios_get_eckv(struct iwl_fw_runtime *fwrt, u32 *ext_clk);
 int iwl_bios_get_wbem(struct iwl_fw_runtime *fwrt, u32 *value);
 
 __le32 iwl_get_lari_config_bitmap(struct iwl_fw_runtime *fwrt);
-int iwl_fill_lari_config(struct iwl_fw_runtime *fwrt,
-			 struct iwl_lari_config_change_cmd *cmd,
-			 size_t *cmd_size);
 
 int iwl_bios_get_dsm(struct iwl_fw_runtime *fwrt, enum iwl_dsm_funcs func,
 		     u32 *value);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index edae13755ee6..d04f5d408ec3 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -1165,13 +1165,159 @@ static void iwl_mvm_tas_init(struct iwl_mvm *mvm)
 		IWL_DEBUG_RADIO(mvm, "failed to send TAS_CONFIG (%d)\n", ret);
 }
 
+static size_t iwl_mvm_get_lari_config_cmd_size(u8 cmd_ver)
+{
+	size_t cmd_size;
+
+	switch (cmd_ver) {
+	case 12:
+		cmd_size = sizeof(struct iwl_lari_config_change_cmd);
+		break;
+	case 8:
+		cmd_size = sizeof(struct iwl_lari_config_change_cmd_v8);
+		break;
+	case 6:
+		cmd_size = sizeof(struct iwl_lari_config_change_cmd_v6);
+		break;
+	default:
+		cmd_size = sizeof(struct iwl_lari_config_change_cmd_v1);
+		break;
+	}
+	return cmd_size;
+}
+
+static int iwl_mvm_fill_lari_config(struct iwl_fw_runtime *fwrt,
+				    struct iwl_lari_config_change_cmd *cmd,
+				    size_t *cmd_size)
+{
+	int ret;
+	u32 value;
+	bool has_raw_dsm_capa = fw_has_capa(&fwrt->fw->ucode_capa,
+					    IWL_UCODE_TLV_CAPA_FW_ACCEPTS_RAW_DSM_TABLE);
+	u8 cmd_ver = iwl_fw_lookup_cmd_ver(fwrt->fw,
+					   WIDE_ID(REGULATORY_AND_NVM_GROUP,
+						   LARI_CONFIG_CHANGE), 1);
+
+	memset(cmd, 0, sizeof(*cmd));
+	*cmd_size = iwl_mvm_get_lari_config_cmd_size(cmd_ver);
+
+	cmd->config_bitmap = iwl_get_lari_config_bitmap(fwrt);
+
+	ret = iwl_bios_get_dsm(fwrt, DSM_FUNC_11AX_ENABLEMENT, &value);
+	if (!ret) {
+		if (!has_raw_dsm_capa)
+			value &= DSM_11AX_ALLOW_BITMAP;
+		cmd->oem_11ax_allow_bitmap = cpu_to_le32(value);
+	}
+
+	ret = iwl_bios_get_dsm(fwrt, DSM_FUNC_ENABLE_UNII4_CHAN, &value);
+	if (!ret) {
+		if (!has_raw_dsm_capa)
+			value &= DSM_UNII4_ALLOW_BITMAP;
+
+		/* Since version 12, bits 4 and 5 are supported
+		 * regardless of this capability, By pass this masking
+		 * if firmware has capability of accepting raw DSM table.
+		 */
+		if (!has_raw_dsm_capa && cmd_ver < 12 &&
+		    !fw_has_capa(&fwrt->fw->ucode_capa,
+				 IWL_UCODE_TLV_CAPA_BIOS_OVERRIDE_5G9_FOR_CA))
+			value &= ~(DSM_VALUE_UNII4_CANADA_OVERRIDE_MSK |
+				   DSM_VALUE_UNII4_CANADA_EN_MSK);
+
+		cmd->oem_unii4_allow_bitmap = cpu_to_le32(value);
+	}
+
+	ret = iwl_bios_get_dsm(fwrt, DSM_FUNC_ACTIVATE_CHANNEL, &value);
+	if (!ret) {
+		if (!has_raw_dsm_capa)
+			value &= CHAN_STATE_ACTIVE_BITMAP_CMD_V12;
+
+		if (!has_raw_dsm_capa && cmd_ver < 8)
+			value &= ~ACTIVATE_5G2_IN_WW_MASK;
+
+		/* Since version 12, bits 5 and 6 are supported
+		 * regardless of this capability, By pass this masking
+		 * if firmware has capability of accepting raw DSM table.
+		 */
+		if (!has_raw_dsm_capa && cmd_ver < 12 &&
+		    !fw_has_capa(&fwrt->fw->ucode_capa,
+				 IWL_UCODE_TLV_CAPA_BIOS_OVERRIDE_UNII4_US_CA))
+			value &= CHAN_STATE_ACTIVE_BITMAP_CMD_V8;
+
+		cmd->chan_state_active_bitmap = cpu_to_le32(value);
+	}
+
+	ret = iwl_bios_get_dsm(fwrt, DSM_FUNC_ENABLE_6E, &value);
+	if (!ret)
+		cmd->oem_uhb_allow_bitmap = cpu_to_le32(value);
+
+	ret = iwl_bios_get_dsm(fwrt, DSM_FUNC_FORCE_DISABLE_CHANNELS, &value);
+	if (!ret) {
+		if (!has_raw_dsm_capa)
+			value &= DSM_FORCE_DISABLE_CHANNELS_ALLOWED_BITMAP;
+		cmd->force_disable_channels_bitmap = cpu_to_le32(value);
+	}
+
+	ret = iwl_bios_get_dsm(fwrt, DSM_FUNC_ENERGY_DETECTION_THRESHOLD,
+			       &value);
+	if (!ret) {
+		if (!has_raw_dsm_capa)
+			value &= DSM_EDT_ALLOWED_BITMAP;
+		cmd->edt_bitmap = cpu_to_le32(value);
+	}
+
+	ret = iwl_bios_get_wbem(fwrt, &value);
+	if (!ret)
+		cmd->oem_320mhz_allow_bitmap = cpu_to_le32(value);
+
+	ret = iwl_bios_get_dsm(fwrt, DSM_FUNC_ENABLE_11BE, &value);
+	if (!ret)
+		cmd->oem_11be_allow_bitmap = cpu_to_le32(value);
+
+	if (cmd->config_bitmap ||
+	    cmd->oem_uhb_allow_bitmap ||
+	    cmd->oem_11ax_allow_bitmap ||
+	    cmd->oem_unii4_allow_bitmap ||
+	    cmd->chan_state_active_bitmap ||
+	    cmd->force_disable_channels_bitmap ||
+	    cmd->edt_bitmap ||
+	    cmd->oem_320mhz_allow_bitmap ||
+	    cmd->oem_11be_allow_bitmap) {
+		IWL_DEBUG_RADIO(fwrt,
+				"sending LARI_CONFIG_CHANGE, config_bitmap=0x%x, oem_11ax_allow_bitmap=0x%x\n",
+				le32_to_cpu(cmd->config_bitmap),
+				le32_to_cpu(cmd->oem_11ax_allow_bitmap));
+		IWL_DEBUG_RADIO(fwrt,
+				"sending LARI_CONFIG_CHANGE, oem_unii4_allow_bitmap=0x%x, chan_state_active_bitmap=0x%x, cmd_ver=%d\n",
+				le32_to_cpu(cmd->oem_unii4_allow_bitmap),
+				le32_to_cpu(cmd->chan_state_active_bitmap),
+				cmd_ver);
+		IWL_DEBUG_RADIO(fwrt,
+				"sending LARI_CONFIG_CHANGE, oem_uhb_allow_bitmap=0x%x, force_disable_channels_bitmap=0x%x\n",
+				le32_to_cpu(cmd->oem_uhb_allow_bitmap),
+				le32_to_cpu(cmd->force_disable_channels_bitmap));
+		IWL_DEBUG_RADIO(fwrt,
+				"sending LARI_CONFIG_CHANGE, edt_bitmap=0x%x, oem_320mhz_allow_bitmap=0x%x\n",
+				le32_to_cpu(cmd->edt_bitmap),
+				le32_to_cpu(cmd->oem_320mhz_allow_bitmap));
+		IWL_DEBUG_RADIO(fwrt,
+				"sending LARI_CONFIG_CHANGE, oem_11be_allow_bitmap=0x%x\n",
+				le32_to_cpu(cmd->oem_11be_allow_bitmap));
+	} else {
+		return 1;
+	}
+
+	return 0;
+}
+
 static void iwl_mvm_lari_cfg(struct iwl_mvm *mvm)
 {
 	struct iwl_lari_config_change_cmd cmd;
 	size_t cmd_size;
 	int ret;
 
-	ret = iwl_fill_lari_config(&mvm->fwrt, &cmd, &cmd_size);
+	ret = iwl_mvm_fill_lari_config(&mvm->fwrt, &cmd, &cmd_size);
 	if (!ret) {
 		ret = iwl_mvm_send_cmd_pdu(mvm,
 					   WIDE_ID(REGULATORY_AND_NVM_GROUP,
-- 
2.34.1


