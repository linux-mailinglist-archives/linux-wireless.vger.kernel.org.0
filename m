Return-Path: <linux-wireless+bounces-18993-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D164EA37389
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Feb 2025 10:45:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B869188BB1D
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Feb 2025 09:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D54E18DB35;
	Sun, 16 Feb 2025 09:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RfEmMowt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43CBA191F68
	for <linux-wireless@vger.kernel.org>; Sun, 16 Feb 2025 09:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739699047; cv=none; b=COmVMGh7KlPmC+yjPZghpvjlX7Tig1vrXoG8D8tY1OEZH8c2JTAvKhrhXXepiH8/Bqu1RBNlMR6dZSYWT1+i4BbtM4DXQowqFs26ylG6m/yPJ5WhwuLg4RViJXBCvMIOJrylS0I5uuTmyYJkFbB1uqwoX7/n5t5EUynSBFbSZUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739699047; c=relaxed/simple;
	bh=2IeUS1/YZBq72tD5CVavcHB5Klhf4pWrwnDrVoZKMNc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uXyvWfmxP+3U+rkmodcrUAIafTW0VZaRHlj7lTDGPCjtbx/K8S3V4zcrNyAoARVKNeQ5lvll3DQLkKGpedko6OcSidT9sZ+6M1xHXcDpDu93U2LlyqQIGLpszzL6JqHm5PFRcpFxt2Rq7vld0qMG3oaXEmhKouMhhPqRUFIGZks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RfEmMowt; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739699045; x=1771235045;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2IeUS1/YZBq72tD5CVavcHB5Klhf4pWrwnDrVoZKMNc=;
  b=RfEmMowtEqsdu87mx1qx0nPpd7P4OtiuJxbkqb9y+19uwNUQlfveGbpf
   Ukczfb/773DhDCvTGK+mEhBjnTAVv0qKapw4pD2zP9uMIdUnrrqworZN5
   K0Cn/mrD/f63S3S5aekKVwhEOKYmIfgWDz9qMZGaBZRbjYl71advOzN4F
   vX6MJR/pgWls4oqP0gP+7Gm271M6A3+gl6FK5qtdA/nZUdw2cyyhfGA9B
   kkfcFZ2EG13UE+25wnEUzgKTTPWTBIidfMISaocKGwUfNhuyLk8pCjfJl
   W9U+jjKCnw6cFX+q7os+dZ/FI804YLPTH0Ahdjas9OQRMWS8bn3ctsphm
   Q==;
X-CSE-ConnectionGUID: sqzcW9SwQ0mnzspaWxAyNg==
X-CSE-MsgGUID: zgL6K1IrTnOl4XQ72wcu0A==
X-IronPort-AV: E=McAfee;i="6700,10204,11346"; a="40323402"
X-IronPort-AV: E=Sophos;i="6.13,290,1732608000"; 
   d="scan'208";a="40323402"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2025 01:44:05 -0800
X-CSE-ConnectionGUID: uH07R/mDSdGQhoZHlPpQrw==
X-CSE-MsgGUID: BO+eSGRpT62814A1EqEErQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="118785255"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2025 01:44:04 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 23/42] wifi: iwlwifi: mld: add file regulatory.h/c
Date: Sun, 16 Feb 2025 11:43:02 +0200
Message-Id: <20250216111648.c4ac14af4cda.I262136e63f3802a3be704d1e70cc87ed7572b043@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250216094321.537988-1-miriam.rachel.korenblit@intel.com>
References: <20250216094321.537988-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

these files are handling regulatory aspects

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../wireless/intel/iwlwifi/mld/regulatory.c   | 393 ++++++++++++++++++
 .../wireless/intel/iwlwifi/mld/regulatory.h   |  23 +
 2 files changed, 416 insertions(+)
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/regulatory.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/regulatory.h

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/regulatory.c b/drivers/net/wireless/intel/iwlwifi/mld/regulatory.c
new file mode 100644
index 000000000000..a75af8c1e8ab
--- /dev/null
+++ b/drivers/net/wireless/intel/iwlwifi/mld/regulatory.c
@@ -0,0 +1,393 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/*
+ * Copyright (C) 2024-2025 Intel Corporation
+ */
+
+#include <linux/dmi.h>
+
+#include "fw/regulatory.h"
+#include "fw/acpi.h"
+#include "fw/uefi.h"
+
+#include "regulatory.h"
+#include "mld.h"
+#include "hcmd.h"
+
+void iwl_mld_get_bios_tables(struct iwl_mld *mld)
+{
+	int ret;
+
+	iwl_acpi_get_guid_lock_status(&mld->fwrt);
+
+	ret = iwl_bios_get_ppag_table(&mld->fwrt);
+	if (ret < 0) {
+		IWL_DEBUG_RADIO(mld,
+				"PPAG BIOS table invalid or unavailable. (%d)\n",
+				ret);
+	}
+
+	ret = iwl_bios_get_wrds_table(&mld->fwrt);
+	if (ret < 0) {
+		IWL_DEBUG_RADIO(mld,
+				"WRDS SAR BIOS table invalid or unavailable. (%d)\n",
+				ret);
+
+		/* If not available, don't fail and don't bother with EWRD and
+		 * WGDS
+		 */
+
+		if (!iwl_bios_get_wgds_table(&mld->fwrt)) {
+			/* If basic SAR is not available, we check for WGDS,
+			 * which should *not* be available either. If it is
+			 * available, issue an error, because we can't use SAR
+			 * Geo without basic SAR.
+			 */
+			IWL_ERR(mld, "BIOS contains WGDS but no WRDS\n");
+		}
+
+	} else {
+		ret = iwl_bios_get_ewrd_table(&mld->fwrt);
+		/* If EWRD is not available, we can still use
+		 * WRDS, so don't fail.
+		 */
+		if (ret < 0)
+			IWL_DEBUG_RADIO(mld,
+					"EWRD SAR BIOS table invalid or unavailable. (%d)\n",
+					ret);
+
+		ret = iwl_bios_get_wgds_table(&mld->fwrt);
+		if (ret < 0)
+			IWL_DEBUG_RADIO(mld,
+					"Geo SAR BIOS table invalid or unavailable. (%d)\n",
+					ret);
+		/* we don't fail if the table is not available */
+	}
+
+	ret = iwl_uefi_get_uats_table(mld->trans, &mld->fwrt);
+	if (ret)
+		IWL_DEBUG_RADIO(mld, "failed to read UATS table (%d)\n", ret);
+}
+
+static int iwl_mld_geo_sar_init(struct iwl_mld *mld)
+{
+	u32 cmd_id = WIDE_ID(PHY_OPS_GROUP, PER_CHAIN_LIMIT_OFFSET_CMD);
+	union iwl_geo_tx_power_profiles_cmd cmd;
+	u16 len;
+	u32 n_bands;
+	__le32 sk = cpu_to_le32(0);
+	int ret;
+	u8 cmd_ver = iwl_fw_lookup_cmd_ver(mld->fw, cmd_id,
+					   IWL_FW_CMD_VER_UNKNOWN);
+
+	BUILD_BUG_ON(offsetof(struct iwl_geo_tx_power_profiles_cmd_v4, ops) !=
+		     offsetof(struct iwl_geo_tx_power_profiles_cmd_v5, ops));
+
+	cmd.v4.ops = cpu_to_le32(IWL_PER_CHAIN_OFFSET_SET_TABLES);
+
+	/* Only set to South Korea if the table revision is 1 */
+	if (mld->fwrt.geo_rev == 1)
+		sk = cpu_to_le32(1);
+
+	if (cmd_ver == 5) {
+		len = sizeof(cmd.v5);
+		n_bands = ARRAY_SIZE(cmd.v5.table[0]);
+		cmd.v5.table_revision = sk;
+	} else if (cmd_ver == 4) {
+		len = sizeof(cmd.v4);
+		n_bands = ARRAY_SIZE(cmd.v4.table[0]);
+		cmd.v4.table_revision = sk;
+	} else {
+		return -EOPNOTSUPP;
+	}
+
+	BUILD_BUG_ON(offsetof(struct iwl_geo_tx_power_profiles_cmd_v4, table) !=
+		     offsetof(struct iwl_geo_tx_power_profiles_cmd_v5, table));
+	/* the table is at the same position for all versions, so set use v4 */
+	ret = iwl_sar_geo_fill_table(&mld->fwrt, &cmd.v4.table[0][0],
+				     n_bands, BIOS_GEO_MAX_PROFILE_NUM);
+
+	/* It is a valid scenario to not support SAR, or miss wgds table,
+	 * but in that case there is no need to send the command.
+	 */
+	if (ret)
+		return 0;
+
+	return iwl_mld_send_cmd_pdu(mld, cmd_id, &cmd, len);
+}
+
+int iwl_mld_config_sar_profile(struct iwl_mld *mld, int prof_a, int prof_b)
+{
+	u32 cmd_id = REDUCE_TX_POWER_CMD;
+	struct iwl_dev_tx_power_cmd cmd = {
+		.common.set_mode = cpu_to_le32(IWL_TX_POWER_MODE_SET_CHAINS),
+	};
+	__le16 *per_chain;
+	int ret;
+	u16 len = sizeof(cmd.common);
+	u32 n_subbands;
+	u8 cmd_ver = iwl_fw_lookup_cmd_ver(mld->fw, cmd_id,
+					   IWL_FW_CMD_VER_UNKNOWN);
+
+	if (cmd_ver == 10) {
+		len += sizeof(cmd.v10);
+		n_subbands = IWL_NUM_SUB_BANDS_V2;
+		per_chain = &cmd.v10.per_chain[0][0][0];
+		cmd.v10.flags =
+			cpu_to_le32(mld->fwrt.reduced_power_flags);
+	} else if (cmd_ver == 9) {
+		len += sizeof(cmd.v9);
+		n_subbands = IWL_NUM_SUB_BANDS_V1;
+		per_chain = &cmd.v9.per_chain[0][0];
+	} else {
+		return -EOPNOTSUPP;
+	}
+
+	/* TODO: CDB - support IWL_NUM_CHAIN_TABLES_V2 */
+	ret = iwl_sar_fill_profile(&mld->fwrt, per_chain,
+				   IWL_NUM_CHAIN_TABLES,
+				   n_subbands, prof_a, prof_b);
+	/* return on error or if the profile is disabled (positive number) */
+	if (ret)
+		return ret;
+
+	return iwl_mld_send_cmd_pdu(mld, cmd_id, &cmd, len);
+}
+
+int iwl_mld_init_sar(struct iwl_mld *mld)
+{
+	int chain_a_prof = 1;
+	int chain_b_prof = 1;
+	int ret;
+
+	/* If no profile was chosen by the user yet, choose profile 1 (WRDS) as
+	 * default for both chains
+	 */
+	if (mld->fwrt.sar_chain_a_profile && mld->fwrt.sar_chain_b_profile) {
+		chain_a_prof = mld->fwrt.sar_chain_a_profile;
+		chain_b_prof = mld->fwrt.sar_chain_b_profile;
+	}
+
+	ret = iwl_mld_config_sar_profile(mld, chain_a_prof, chain_b_prof);
+	if (ret < 0)
+		return ret;
+
+	if (ret)
+		return 0;
+
+	return iwl_mld_geo_sar_init(mld);
+}
+
+int iwl_mld_init_sgom(struct iwl_mld *mld)
+{
+	int ret;
+	struct iwl_host_cmd cmd = {
+		.id = WIDE_ID(REGULATORY_AND_NVM_GROUP,
+			      SAR_OFFSET_MAPPING_TABLE_CMD),
+		.data[0] = &mld->fwrt.sgom_table,
+		.len[0] =  sizeof(mld->fwrt.sgom_table),
+		.dataflags[0] = IWL_HCMD_DFL_NOCOPY,
+	};
+
+	if (!mld->fwrt.sgom_enabled) {
+		IWL_DEBUG_RADIO(mld, "SGOM table is disabled\n");
+		return 0;
+	}
+
+	ret = iwl_mld_send_cmd(mld, &cmd);
+	if (ret)
+		IWL_ERR(mld,
+			"failed to send SAR_OFFSET_MAPPING_CMD (%d)\n", ret);
+
+	return ret;
+}
+
+static int iwl_mld_ppag_send_cmd(struct iwl_mld *mld)
+{
+	union iwl_ppag_table_cmd cmd = {};
+	int ret, len;
+
+	ret = iwl_fill_ppag_table(&mld->fwrt, &cmd, &len);
+	/* Not supporting PPAG table is a valid scenario */
+	if (ret < 0)
+		return 0;
+
+	IWL_DEBUG_RADIO(mld, "Sending PER_PLATFORM_ANT_GAIN_CMD\n");
+	ret = iwl_mld_send_cmd_pdu(mld, WIDE_ID(PHY_OPS_GROUP,
+						PER_PLATFORM_ANT_GAIN_CMD),
+				   &cmd, len);
+	if (ret < 0)
+		IWL_ERR(mld, "failed to send PER_PLATFORM_ANT_GAIN_CMD (%d)\n",
+			ret);
+
+	return ret;
+}
+
+int iwl_mld_init_ppag(struct iwl_mld *mld)
+{
+	/* no need to read the table, done in INIT stage */
+
+	if (!(iwl_is_ppag_approved(&mld->fwrt)))
+		return 0;
+
+	return iwl_mld_ppag_send_cmd(mld);
+}
+
+void iwl_mld_configure_lari(struct iwl_mld *mld)
+{
+	struct iwl_fw_runtime *fwrt = &mld->fwrt;
+	struct iwl_lari_config_change_cmd cmd = {
+		.config_bitmap = iwl_get_lari_config_bitmap(fwrt),
+	};
+	int ret;
+	u32 value;
+
+	ret = iwl_bios_get_dsm(fwrt, DSM_FUNC_11AX_ENABLEMENT, &value);
+	if (!ret)
+		cmd.oem_11ax_allow_bitmap = cpu_to_le32(value);
+
+	ret = iwl_bios_get_dsm(fwrt, DSM_FUNC_ENABLE_UNII4_CHAN, &value);
+	if (!ret)
+		cmd.oem_unii4_allow_bitmap =
+			cpu_to_le32(value &= DSM_UNII4_ALLOW_BITMAP);
+
+	ret = iwl_bios_get_dsm(fwrt, DSM_FUNC_ACTIVATE_CHANNEL, &value);
+	if (!ret)
+		cmd.chan_state_active_bitmap = cpu_to_le32(value);
+
+	ret = iwl_bios_get_dsm(fwrt, DSM_FUNC_ENABLE_6E, &value);
+	if (!ret)
+		cmd.oem_uhb_allow_bitmap = cpu_to_le32(value);
+
+	ret = iwl_bios_get_dsm(fwrt, DSM_FUNC_FORCE_DISABLE_CHANNELS, &value);
+	if (!ret)
+		cmd.force_disable_channels_bitmap = cpu_to_le32(value);
+
+	ret = iwl_bios_get_dsm(fwrt, DSM_FUNC_ENERGY_DETECTION_THRESHOLD,
+			       &value);
+	if (!ret)
+		cmd.edt_bitmap = cpu_to_le32(value);
+
+	ret = iwl_bios_get_wbem(fwrt, &value);
+	if (!ret)
+		cmd.oem_320mhz_allow_bitmap = cpu_to_le32(value);
+
+	ret = iwl_bios_get_dsm(fwrt, DSM_FUNC_ENABLE_11BE, &value);
+	if (!ret)
+		cmd.oem_11be_allow_bitmap = cpu_to_le32(value);
+
+	if (!cmd.config_bitmap &&
+	    !cmd.oem_uhb_allow_bitmap &&
+	    !cmd.oem_11ax_allow_bitmap &&
+	    !cmd.oem_unii4_allow_bitmap &&
+	    !cmd.chan_state_active_bitmap &&
+	    !cmd.force_disable_channels_bitmap &&
+	    !cmd.edt_bitmap &&
+	    !cmd.oem_320mhz_allow_bitmap &&
+	    !cmd.oem_11be_allow_bitmap)
+		return;
+
+	IWL_DEBUG_RADIO(mld,
+			"sending LARI_CONFIG_CHANGE, config_bitmap=0x%x, oem_11ax_allow_bitmap=0x%x\n",
+			le32_to_cpu(cmd.config_bitmap),
+			le32_to_cpu(cmd.oem_11ax_allow_bitmap));
+	IWL_DEBUG_RADIO(mld,
+			"sending LARI_CONFIG_CHANGE, oem_unii4_allow_bitmap=0x%x, chan_state_active_bitmap=0x%x\n",
+			le32_to_cpu(cmd.oem_unii4_allow_bitmap),
+			le32_to_cpu(cmd.chan_state_active_bitmap));
+	IWL_DEBUG_RADIO(mld,
+			"sending LARI_CONFIG_CHANGE, oem_uhb_allow_bitmap=0x%x, force_disable_channels_bitmap=0x%x\n",
+			le32_to_cpu(cmd.oem_uhb_allow_bitmap),
+			le32_to_cpu(cmd.force_disable_channels_bitmap));
+	IWL_DEBUG_RADIO(mld,
+			"sending LARI_CONFIG_CHANGE, edt_bitmap=0x%x, oem_320mhz_allow_bitmap=0x%x\n",
+			le32_to_cpu(cmd.edt_bitmap),
+			le32_to_cpu(cmd.oem_320mhz_allow_bitmap));
+	IWL_DEBUG_RADIO(mld,
+			"sending LARI_CONFIG_CHANGE, oem_11be_allow_bitmap=0x%x\n",
+			le32_to_cpu(cmd.oem_11be_allow_bitmap));
+
+	ret = iwl_mld_send_cmd_pdu(mld, WIDE_ID(REGULATORY_AND_NVM_GROUP,
+						LARI_CONFIG_CHANGE), &cmd);
+	if (ret)
+		IWL_DEBUG_RADIO(mld,
+				"Failed to send LARI_CONFIG_CHANGE (%d)\n",
+				ret);
+}
+
+void iwl_mld_init_uats(struct iwl_mld *mld)
+{
+	int ret;
+	struct iwl_host_cmd cmd = {
+		.id = WIDE_ID(REGULATORY_AND_NVM_GROUP,
+			      MCC_ALLOWED_AP_TYPE_CMD),
+		.data[0] = &mld->fwrt.uats_table,
+		.len[0] =  sizeof(mld->fwrt.uats_table),
+		.dataflags[0] = IWL_HCMD_DFL_NOCOPY,
+	};
+
+	if (!mld->fwrt.uats_valid)
+		return;
+
+	ret = iwl_mld_send_cmd(mld, &cmd);
+	if (ret)
+		IWL_ERR(mld, "failed to send MCC_ALLOWED_AP_TYPE_CMD (%d)\n",
+			ret);
+}
+
+void iwl_mld_init_tas(struct iwl_mld *mld)
+{
+	int ret;
+	struct iwl_tas_data data = {};
+	struct iwl_tas_config_cmd cmd = {};
+	u32 cmd_id = WIDE_ID(REGULATORY_AND_NVM_GROUP, TAS_CONFIG);
+
+	BUILD_BUG_ON(ARRAY_SIZE(data.block_list_array) !=
+		     IWL_WTAS_BLACK_LIST_MAX);
+	BUILD_BUG_ON(ARRAY_SIZE(cmd.block_list_array) !=
+		     IWL_WTAS_BLACK_LIST_MAX);
+
+	if (!fw_has_capa(&mld->fw->ucode_capa, IWL_UCODE_TLV_CAPA_TAS_CFG)) {
+		IWL_DEBUG_RADIO(mld, "TAS not enabled in FW\n");
+		return;
+	}
+
+	ret = iwl_bios_get_tas_table(&mld->fwrt, &data);
+	if (ret < 0) {
+		IWL_DEBUG_RADIO(mld,
+				"TAS table invalid or unavailable. (%d)\n",
+				ret);
+		return;
+	}
+
+	if (!iwl_is_tas_approved()) {
+		IWL_DEBUG_RADIO(mld,
+				"System vendor '%s' is not in the approved list, disabling TAS in US and Canada.\n",
+				dmi_get_system_info(DMI_SYS_VENDOR) ?: "<unknown>");
+		if ((!iwl_add_mcc_to_tas_block_list(data.block_list_array,
+						    &data.block_list_size,
+						    IWL_MCC_US)) ||
+		    (!iwl_add_mcc_to_tas_block_list(data.block_list_array,
+						    &data.block_list_size,
+						    IWL_MCC_CANADA))) {
+			IWL_DEBUG_RADIO(mld,
+					"Unable to add US/Canada to TAS block list, disabling TAS\n");
+			return;
+		}
+	} else {
+		IWL_DEBUG_RADIO(mld,
+				"System vendor '%s' is in the approved list.\n",
+				dmi_get_system_info(DMI_SYS_VENDOR) ?: "<unknown>");
+	}
+
+	cmd.block_list_size = cpu_to_le16(data.block_list_size);
+	for (u8 i = 0; i < data.block_list_size; i++)
+		cmd.block_list_array[i] =
+			cpu_to_le16(data.block_list_array[i]);
+	cmd.tas_config_info.table_source = data.table_source;
+	cmd.tas_config_info.table_revision = data.table_revision;
+	cmd.tas_config_info.value = cpu_to_le32(data.tas_selection);
+
+	ret = iwl_mld_send_cmd_pdu(mld, cmd_id, &cmd);
+	if (ret)
+		IWL_DEBUG_RADIO(mld, "failed to send TAS_CONFIG (%d)\n", ret);
+}
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/regulatory.h b/drivers/net/wireless/intel/iwlwifi/mld/regulatory.h
new file mode 100644
index 000000000000..3b01c645adda
--- /dev/null
+++ b/drivers/net/wireless/intel/iwlwifi/mld/regulatory.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/*
+ * Copyright (C) 2024-2025 Intel Corporation
+ */
+#ifndef __iwl_mld_regulatory_h__
+#define __iwl_mld_regulatory_h__
+
+#include "mld.h"
+
+void iwl_mld_get_bios_tables(struct iwl_mld *mld);
+void iwl_mld_configure_lari(struct iwl_mld *mld);
+void iwl_mld_init_uats(struct iwl_mld *mld);
+void iwl_mld_init_tas(struct iwl_mld *mld);
+
+int iwl_mld_init_ppag(struct iwl_mld *mld);
+
+int iwl_mld_init_sgom(struct iwl_mld *mld);
+
+int iwl_mld_init_sar(struct iwl_mld *mld);
+
+int iwl_mld_config_sar_profile(struct iwl_mld *mld, int prof_a, int prof_b);
+
+#endif /* __iwl_mld_regulatory_h__ */
-- 
2.34.1


