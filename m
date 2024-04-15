Return-Path: <linux-wireless+bounces-6315-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C6968A4AF1
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Apr 2024 10:55:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CB781F20F46
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Apr 2024 08:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8A814CB38;
	Mon, 15 Apr 2024 08:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jhgOGUXf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453AC4CB37
	for <linux-wireless@vger.kernel.org>; Mon, 15 Apr 2024 08:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713171309; cv=none; b=T/ErgEtHylVG6JtcsiRq0P1EzGIqj6yfz0qp2ry8oLuDMgd7DPxWTLk9zMI+Uk83EEhmh4ON4fXiPpAV0Cayj0dU1tmtP0fQLHDl20XxiA0tO2fWqQXf0zIwuPR22vJFG6rKaklEEKPKgtgU1it22TmcIE/F6/TxzmuegWnFbM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713171309; c=relaxed/simple;
	bh=AnvidV1Km/9VNFSLOaxDDluMe00DWMluiJFhdEGlmg4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EGhCUGqFyiJda2k/mG6+CDV2XIZ0WoA1IyIfitMHTny08T7Eh9qLaPEy+zL02hwWdaA3/6PGzXJEWF4e7LXKeP5SZA2C4U5lHOlaD6a1BGTd4qbl82tsHYyapXNNm7WYWJMAAkPEl57t1ETFUgsf43CUU4xeYsvn/EnWSS317lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jhgOGUXf; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713171308; x=1744707308;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AnvidV1Km/9VNFSLOaxDDluMe00DWMluiJFhdEGlmg4=;
  b=jhgOGUXfqgJzj8RVGsBaGOYP/oQOP6UfXEM0c5Hxyp684LTDgCo8NIkH
   AWavWuHGodCW+Mh7f0QgJ/GjtZy3bPyt/k/RvDUbaZVsWuqfxRsAP2T+D
   x89b6sLaK2I+hi/CXwB4bH1mmeyTDHlHOK7GLFkN/Vub0jsrTQNydfw7A
   lYj/IAocfY/1IK7L3yRv0E9iKeCzzdcBQIYM5Qas9REbA6BFZ3JNlA+6g
   gsV6RXMkMsZEY0PVP3b7NM4S7liCp0s6i7Qn7lwJ/vguWJqiRXcPcuQeG
   LUIicVOzNrugPt+m2dvrliwdERkjBFNvYkutxZgXTnY4qypcifPqsCIZJ
   A==;
X-CSE-ConnectionGUID: aDNB0StpSIS3u9o2RICJpw==
X-CSE-MsgGUID: pWYcfTzHQKSp7pRkDMfH2Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11044"; a="9100599"
X-IronPort-AV: E=Sophos;i="6.07,202,1708416000"; 
   d="scan'208";a="9100599"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 01:55:08 -0700
X-CSE-ConnectionGUID: tAVLvbtCSFOnw0BmQ4OUIg==
X-CSE-MsgGUID: wezG59QjRaa/eRVlw4DvbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,202,1708416000"; 
   d="scan'208";a="21768034"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 01:55:07 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Subject: [PATCH 07/11] wifi: iwlwifi: move lari_config handlig to regulatory
Date: Mon, 15 Apr 2024 11:54:40 +0300
Message-Id: <20240415114847.02bfcd27b333.If149c3038bdfe57e254b26857209e8c7ab709779@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240415085444.3840884-1-miriam.rachel.korenblit@intel.com>
References: <20240415085444.3840884-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>

moved lari_config handling to common place to avoid code duplication.

Signed-off-by: Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../wireless/intel/iwlwifi/fw/regulatory.c    | 115 +++++++++++++++++-
 .../wireless/intel/iwlwifi/fw/regulatory.h    |   4 +-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   |  95 +--------------
 3 files changed, 119 insertions(+), 95 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c
index 36d506463e0e..a3bf16b8b5fd 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c
@@ -443,7 +443,7 @@ int iwl_parse_tas_selection(struct iwl_fw_runtime *fwrt,
 	return enabled;
 }
 
-__le32 iwl_get_lari_config_bitmap(struct iwl_fw_runtime *fwrt)
+static __le32 iwl_get_lari_config_bitmap(struct iwl_fw_runtime *fwrt)
 {
 	int ret;
 	u32 val;
@@ -490,7 +490,118 @@ __le32 iwl_get_lari_config_bitmap(struct iwl_fw_runtime *fwrt)
 
 	return config_bitmap;
 }
-IWL_EXPORT_SYMBOL(iwl_get_lari_config_bitmap);
+
+static size_t iwl_get_lari_config_cmd_size(u8 cmd_ver)
+{
+	size_t cmd_size;
+
+	switch (cmd_ver) {
+	case 9:
+	case 8:
+	case 7:
+		cmd_size = sizeof(struct iwl_lari_config_change_cmd_v7);
+		break;
+	case 6:
+		cmd_size = sizeof(struct iwl_lari_config_change_cmd_v6);
+		break;
+	case 5:
+		cmd_size = sizeof(struct iwl_lari_config_change_cmd_v5);
+		break;
+	case 4:
+		cmd_size = sizeof(struct iwl_lari_config_change_cmd_v4);
+		break;
+	case 3:
+		cmd_size = sizeof(struct iwl_lari_config_change_cmd_v3);
+		break;
+	case 2:
+		cmd_size = sizeof(struct iwl_lari_config_change_cmd_v2);
+		break;
+	default:
+		cmd_size = sizeof(struct iwl_lari_config_change_cmd_v1);
+		break;
+	}
+	return cmd_size;
+}
+
+int iwl_fill_lari_config(struct iwl_fw_runtime *fwrt,
+			 struct iwl_lari_config_change_cmd_v7 *cmd,
+			 size_t *cmd_size)
+{
+	int ret;
+	u32 value;
+	u8 cmd_ver = iwl_fw_lookup_cmd_ver(fwrt->fw,
+					   WIDE_ID(REGULATORY_AND_NVM_GROUP,
+						   LARI_CONFIG_CHANGE), 1);
+
+	memset(cmd, 0, sizeof(*cmd));
+	*cmd_size = iwl_get_lari_config_cmd_size(cmd_ver);
+
+	cmd->config_bitmap = iwl_get_lari_config_bitmap(fwrt);
+
+	ret = iwl_bios_get_dsm(fwrt, DSM_FUNC_11AX_ENABLEMENT, &value);
+	if (!ret)
+		cmd->oem_11ax_allow_bitmap = cpu_to_le32(value);
+
+	ret = iwl_bios_get_dsm(fwrt, DSM_FUNC_ENABLE_UNII4_CHAN, &value);
+	if (!ret) {
+		if (cmd_ver < 9)
+			value &= DSM_UNII4_ALLOW_BITMAP_CMD_V8;
+		else
+			value &= DSM_UNII4_ALLOW_BITMAP;
+
+		cmd->oem_unii4_allow_bitmap = cpu_to_le32(value);
+	}
+
+	ret = iwl_bios_get_dsm(fwrt, DSM_FUNC_ACTIVATE_CHANNEL, &value);
+	if (!ret) {
+		if (cmd_ver < 8)
+			value &= ~ACTIVATE_5G2_IN_WW_MASK;
+		cmd->chan_state_active_bitmap = cpu_to_le32(value);
+	}
+
+	ret = iwl_bios_get_dsm(fwrt, DSM_FUNC_ENABLE_6E, &value);
+	if (!ret)
+		cmd->oem_uhb_allow_bitmap = cpu_to_le32(value);
+
+	ret = iwl_bios_get_dsm(fwrt, DSM_FUNC_FORCE_DISABLE_CHANNELS, &value);
+	if (!ret)
+		cmd->force_disable_channels_bitmap = cpu_to_le32(value);
+
+	ret = iwl_bios_get_dsm(fwrt, DSM_FUNC_ENERGY_DETECTION_THRESHOLD,
+			       &value);
+	if (!ret)
+		cmd->edt_bitmap = cpu_to_le32(value);
+
+	if (cmd->config_bitmap ||
+	    cmd->oem_uhb_allow_bitmap ||
+	    cmd->oem_11ax_allow_bitmap ||
+	    cmd->oem_unii4_allow_bitmap ||
+	    cmd->chan_state_active_bitmap ||
+	    cmd->force_disable_channels_bitmap ||
+	    cmd->edt_bitmap) {
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
+				"sending LARI_CONFIG_CHANGE, edt_bitmap=0x%x\n",
+				le32_to_cpu(cmd->edt_bitmap));
+	} else {
+		return 1;
+	}
+
+	return 0;
+}
+IWL_EXPORT_SYMBOL(iwl_fill_lari_config);
 
 int iwl_bios_get_dsm(struct iwl_fw_runtime *fwrt, enum iwl_dsm_funcs func,
 		     u32 *value)
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h
index c9fbd84e0436..eea04d2934ab 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h
@@ -202,7 +202,9 @@ int iwl_bios_get_pwr_limit(struct iwl_fw_runtime *fwrt,
 int iwl_bios_get_mcc(struct iwl_fw_runtime *fwrt, char *mcc);
 int iwl_bios_get_eckv(struct iwl_fw_runtime *fwrt, u32 *ext_clk);
 
-__le32 iwl_get_lari_config_bitmap(struct iwl_fw_runtime *fwrt);
+int iwl_fill_lari_config(struct iwl_fw_runtime *fwrt,
+			 struct iwl_lari_config_change_cmd_v7 *cmd,
+			 size_t *cmd_size);
 
 int iwl_bios_get_dsm(struct iwl_fw_runtime *fwrt, enum iwl_dsm_funcs func,
 		     u32 *value);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 5958e48d812b..243eeccc7ef6 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -1226,100 +1226,11 @@ static bool iwl_mvm_eval_dsm_rfi(struct iwl_mvm *mvm)
 static void iwl_mvm_lari_cfg(struct iwl_mvm *mvm)
 {
 	int ret;
-	u32 value;
-	struct iwl_lari_config_change_cmd_v7 cmd = {};
-	u8 cmd_ver = iwl_fw_lookup_cmd_ver(mvm->fw,
-					   WIDE_ID(REGULATORY_AND_NVM_GROUP,
-						   LARI_CONFIG_CHANGE), 1);
-
-	cmd.config_bitmap = iwl_get_lari_config_bitmap(&mvm->fwrt);
-
-	ret = iwl_bios_get_dsm(&mvm->fwrt, DSM_FUNC_11AX_ENABLEMENT, &value);
-	if (!ret)
-		cmd.oem_11ax_allow_bitmap = cpu_to_le32(value);
-
-	ret = iwl_bios_get_dsm(&mvm->fwrt, DSM_FUNC_ENABLE_UNII4_CHAN, &value);
-	if (!ret) {
-		if (cmd_ver < 9)
-			value &= DSM_UNII4_ALLOW_BITMAP_CMD_V8;
-		else
-			value &= DSM_UNII4_ALLOW_BITMAP;
-
-		cmd.oem_unii4_allow_bitmap = cpu_to_le32(value);
-	}
+	size_t cmd_size;
+	struct iwl_lari_config_change_cmd_v7 cmd;
 
-	ret = iwl_bios_get_dsm(&mvm->fwrt, DSM_FUNC_ACTIVATE_CHANNEL, &value);
+	ret = iwl_fill_lari_config(&mvm->fwrt, &cmd, &cmd_size);
 	if (!ret) {
-		if (cmd_ver < 8)
-			value &= ~ACTIVATE_5G2_IN_WW_MASK;
-		cmd.chan_state_active_bitmap = cpu_to_le32(value);
-	}
-
-	ret = iwl_bios_get_dsm(&mvm->fwrt, DSM_FUNC_ENABLE_6E, &value);
-	if (!ret)
-		cmd.oem_uhb_allow_bitmap = cpu_to_le32(value);
-
-	ret = iwl_bios_get_dsm(&mvm->fwrt, DSM_FUNC_FORCE_DISABLE_CHANNELS,
-			       &value);
-	if (!ret)
-		cmd.force_disable_channels_bitmap = cpu_to_le32(value);
-
-	ret = iwl_bios_get_dsm(&mvm->fwrt, DSM_FUNC_ENERGY_DETECTION_THRESHOLD,
-			       &value);
-	if (!ret)
-		cmd.edt_bitmap = cpu_to_le32(value);
-
-	if (cmd.config_bitmap ||
-	    cmd.oem_uhb_allow_bitmap ||
-	    cmd.oem_11ax_allow_bitmap ||
-	    cmd.oem_unii4_allow_bitmap ||
-	    cmd.chan_state_active_bitmap ||
-	    cmd.force_disable_channels_bitmap ||
-	    cmd.edt_bitmap) {
-		size_t cmd_size;
-
-		switch (cmd_ver) {
-		case 9:
-		case 8:
-		case 7:
-			cmd_size = sizeof(struct iwl_lari_config_change_cmd_v7);
-			break;
-		case 6:
-			cmd_size = sizeof(struct iwl_lari_config_change_cmd_v6);
-			break;
-		case 5:
-			cmd_size = sizeof(struct iwl_lari_config_change_cmd_v5);
-			break;
-		case 4:
-			cmd_size = sizeof(struct iwl_lari_config_change_cmd_v4);
-			break;
-		case 3:
-			cmd_size = sizeof(struct iwl_lari_config_change_cmd_v3);
-			break;
-		case 2:
-			cmd_size = sizeof(struct iwl_lari_config_change_cmd_v2);
-			break;
-		default:
-			cmd_size = sizeof(struct iwl_lari_config_change_cmd_v1);
-			break;
-		}
-
-		IWL_DEBUG_RADIO(mvm,
-				"sending LARI_CONFIG_CHANGE, config_bitmap=0x%x, oem_11ax_allow_bitmap=0x%x\n",
-				le32_to_cpu(cmd.config_bitmap),
-				le32_to_cpu(cmd.oem_11ax_allow_bitmap));
-		IWL_DEBUG_RADIO(mvm,
-				"sending LARI_CONFIG_CHANGE, oem_unii4_allow_bitmap=0x%x, chan_state_active_bitmap=0x%x, cmd_ver=%d\n",
-				le32_to_cpu(cmd.oem_unii4_allow_bitmap),
-				le32_to_cpu(cmd.chan_state_active_bitmap),
-				cmd_ver);
-		IWL_DEBUG_RADIO(mvm,
-				"sending LARI_CONFIG_CHANGE, oem_uhb_allow_bitmap=0x%x, force_disable_channels_bitmap=0x%x\n",
-				le32_to_cpu(cmd.oem_uhb_allow_bitmap),
-				le32_to_cpu(cmd.force_disable_channels_bitmap));
-		IWL_DEBUG_RADIO(mvm,
-				"sending LARI_CONFIG_CHANGE, edt_bitmap=0x%x\n",
-				le32_to_cpu(cmd.edt_bitmap));
 		ret = iwl_mvm_send_cmd_pdu(mvm,
 					   WIDE_ID(REGULATORY_AND_NVM_GROUP,
 						   LARI_CONFIG_CHANGE),
-- 
2.34.1


