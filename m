Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCDA66C0F0F
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Mar 2023 11:37:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbjCTKhA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Mar 2023 06:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbjCTKgf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Mar 2023 06:36:35 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB81625E10
        for <linux-wireless@vger.kernel.org>; Mon, 20 Mar 2023 03:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679308553; x=1710844553;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DwY5FKol3zVbv0kaLBIiPqBDdPTFoxmrCCC0gbPkn/U=;
  b=KVFeVNcFSoE1wGNLvx+r+Q63xHhBTg7WZYXnmDZbD01ZgjztwdIk7xRa
   EFldQ6kx/oxDjyCJY2cSUe4CD52UQj/9YLbGNkp5Wy1s9h+V0rZzdhvUu
   zxHJDimobU7LITtHwZ+BNQAhT0HUme2QtZmuZtzze83pe+ozeghHrgyWb
   t7s3ykmpbimCFlkmwol2EbOAnT2jam/99KrMVcbACuk+1NyM7qno/TSaz
   O44CT19CT4cjzUpzB88ZV92zAtTbtcFn5ArVV3X4r/O7awsPbqo/vQRx7
   9tKuMYNcJSPRr8ePken9kDR5QozUJIjWp+JsezRQxcymp24WTeD7jZZ0s
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10654"; a="326997965"
X-IronPort-AV: E=Sophos;i="5.98,274,1673942400"; 
   d="scan'208";a="326997965"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 03:34:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10654"; a="713523712"
X-IronPort-AV: E=Sophos;i="5.98,274,1673942400"; 
   d="scan'208";a="713523712"
Received: from ranikhou-mobl3.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.251.179.26])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 03:34:15 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Abhishek Naik <abhishek.naik@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 18/18] iwlwifi: mvm: Add debugfs to get TAS status
Date:   Mon, 20 Mar 2023 12:33:19 +0200
Message-Id: <20230320122330.8efc8c41efae.I94e1a6efb9c33e2cdbcf4bf3ed2384005397dee9@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230320103319.1309442-1-gregory.greenman@intel.com>
References: <20230320103319.1309442-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Abhishek Naik <abhishek.naik@intel.com>

Add debugfs file in mvm to retrieve TAS status per LMAC,
TAS block list, current mcc, OEM name and OEM allowed list.

Signed-off-by: Abhishek Naik <abhishek.naik@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 .../net/wireless/intel/iwlwifi/fw/api/debug.h |  96 +++++++++
 .../net/wireless/intel/iwlwifi/mvm/debugfs.c  | 190 +++++++++++++++++-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   |  10 +
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |   2 +-
 4 files changed, 296 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/debug.h b/drivers/net/wireless/intel/iwlwifi/fw/api/debug.h
index 0c555089e05f..8fef38139bf6 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/debug.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/debug.h
@@ -42,6 +42,12 @@ enum iwl_debug_cmds {
 	 * &struct iwl_buf_alloc_cmd
 	 */
 	BUFFER_ALLOCATION = 0x8,
+	/**
+	 * @GET_TAS_STATUS:
+	 * sends command to fw to get TAS status
+	 * the response is &struct iwl_mvm_tas_status_resp
+	 */
+	GET_TAS_STATUS = 0xA,
 	/**
 	 * @FW_DUMP_COMPLETE_CMD:
 	 * sends command to fw once dump collection completed
@@ -421,4 +427,94 @@ struct iwl_dbg_dump_complete_cmd {
 	__le32 tp_data;
 } __packed; /* FW_DUMP_COMPLETE_CMD_API_S_VER_1 */
 
+#define TAS_LMAC_BAND_HB       0
+#define TAS_LMAC_BAND_LB       1
+#define TAS_LMAC_BAND_UHB      2
+#define TAS_LMAC_BAND_INVALID  3
+
+/**
+ * struct iwl_mvm_tas_status_per_mac - tas status per lmac
+ * @static_status: tas statically enabled or disabled per lmac - TRUE/FALSE
+ * @static_dis_reason: TAS static disable reason, uses
+ *	&enum iwl_mvm_tas_statically_disabled_reason
+ * @dynamic_status: Current TAS  status. uses
+ *	&enum iwl_mvm_tas_dyna_status
+ * @near_disconnection: is TAS currently near disconnection per lmac? - TRUE/FALSE
+ * @max_reg_pwr_limit: Regulatory power limits in dBm
+ * @sar_limit: SAR limits per lmac in dBm
+ * @band: Band per lmac
+ * @reserved: reserved
+ */
+struct iwl_mvm_tas_status_per_mac {
+	u8 static_status;
+	u8 static_dis_reason;
+	u8 dynamic_status;
+	u8 near_disconnection;
+	__le16 max_reg_pwr_limit;
+	__le16 sar_limit;
+	u8 band;
+	u8 reserved[3];
+} __packed; /*DEBUG_GET_TAS_STATUS_PER_MAC_S_VER_1*/
+
+/**
+ * struct iwl_mvm_tas_status_resp - Response to GET_TAS_STATUS
+ * @tas_fw_version: TAS FW version
+ * @is_uhb_for_usa_enable: is UHB enabled in USA? - TRUE/FALSE
+ * @curr_mcc: current mcc
+ * @block_list: country block list
+ * @tas_status_mac: TAS status per lmac, uses
+ *	&struct iwl_mvm_tas_status_per_mac
+ * @in_dual_radio: is TAS in dual radio? - TRUE/FALSE
+ * @reserved: reserved
+ */
+struct iwl_mvm_tas_status_resp {
+	u8 tas_fw_version;
+	u8 is_uhb_for_usa_enable;
+	__le16 curr_mcc;
+	__le16 block_list[16];
+	struct iwl_mvm_tas_status_per_mac tas_status_mac[2];
+	u8 in_dual_radio;
+	u8 reserved[3];
+} __packed; /*DEBUG_GET_TAS_STATUS_RSP_API_S_VER_3*/
+
+/**
+ * enum iwl_mvm_tas_dyna_status - TAS current running status
+ * @TAS_DYNA_INACTIVE: TAS status is inactive
+ * @TAS_DYNA_INACTIVE_MVM_MODE: TAS is disabled due because FW is in MVM mode
+ *	or is in softap mode.
+ * @TAS_DYNA_INACTIVE_TRIGGER_MODE: TAS is disabled because FW is in
+ *	multi user trigger mode
+ * @TAS_DYNA_INACTIVE_BLOCK_LISTED: TAS is disabled because  current mcc
+ *	is blocklisted mcc
+ * @TAS_DYNA_INACTIVE_UHB_NON_US: TAS is disabled because current band is UHB
+ *	and current mcc is USA
+ * @TAS_DYNA_ACTIVE: TAS is currently active
+ * @TAS_DYNA_STATUS_MAX: TAS status max value
+ */
+enum iwl_mvm_tas_dyna_status {
+	TAS_DYNA_INACTIVE,
+	TAS_DYNA_INACTIVE_MVM_MODE,
+	TAS_DYNA_INACTIVE_TRIGGER_MODE,
+	TAS_DYNA_INACTIVE_BLOCK_LISTED,
+	TAS_DYNA_INACTIVE_UHB_NON_US,
+	TAS_DYNA_ACTIVE,
+
+	TAS_DYNA_STATUS_MAX,
+}; /*_TAS_DYNA_STATUS_E*/
+
+/**
+ * enum iwl_mvm_tas_statically_disabled_reason - TAS statically disabled reason
+ * @TAS_DISABLED_DUE_TO_BIOS: TAS is disabled because TAS is disabled in BIOS
+ * @TAS_DISABLED_DUE_TO_SAR_6DBM: TAS is disabled because SAR limit is less than 6 Dbm
+ * @TAS_DISABLED_REASON_INVALID: TAS disable reason is invalid
+ * @TAS_DISABLED_REASON_MAX: TAS disable reason max value
+ */
+enum iwl_mvm_tas_statically_disabled_reason {
+	TAS_DISABLED_DUE_TO_BIOS,
+	TAS_DISABLED_DUE_TO_SAR_6DBM,
+	TAS_DISABLED_REASON_INVALID,
+
+	TAS_DISABLED_REASON_MAX,
+}; /*_TAS_STATICALLY_DISABLED_REASON_E*/
+
 #endif /* __iwl_fw_api_debug_h__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
index 5790435dc69e..2a6f42f07c9e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2012-2014, 2018-2022 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2023 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -8,6 +8,7 @@
 #include <linux/err.h>
 #include <linux/ieee80211.h>
 #include <linux/netdevice.h>
+#include <linux/dmi.h>
 
 #include "mvm.h"
 #include "sta.h"
@@ -15,6 +16,7 @@
 #include "debugfs.h"
 #include "iwl-modparams.h"
 #include "fw/error-dump.h"
+#include "fw/api/phy-ctxt.h"
 
 static ssize_t iwl_dbgfs_ctdp_budget_read(struct file *file,
 					  char __user *user_buf,
@@ -714,6 +716,190 @@ static ssize_t iwl_dbgfs_fw_ver_read(struct file *file, char __user *user_buf,
 	return ret;
 }
 
+static ssize_t iwl_dbgfs_tas_get_status_read(struct file *file,
+					     char __user *user_buf,
+					     size_t count, loff_t *ppos)
+{
+	struct iwl_mvm *mvm = file->private_data;
+	struct iwl_mvm_tas_status_resp tas_rsp;
+	struct iwl_mvm_tas_status_resp *rsp = &tas_rsp;
+	static const size_t bufsz = 1024;
+	char *buff, *pos, *endpos;
+	const char * const tas_dis_reason[TAS_DISABLED_REASON_MAX] = {
+		[TAS_DISABLED_DUE_TO_BIOS] =
+			"Due To BIOS",
+		[TAS_DISABLED_DUE_TO_SAR_6DBM] =
+			"Due To SAR Limit Less Than 6 dBm",
+		[TAS_DISABLED_REASON_INVALID] =
+			"N/A",
+	};
+	const char * const tas_current_status[TAS_DYNA_STATUS_MAX] = {
+		[TAS_DYNA_INACTIVE] = "INACTIVE",
+		[TAS_DYNA_INACTIVE_MVM_MODE] =
+			"inactive due to mvm mode",
+		[TAS_DYNA_INACTIVE_TRIGGER_MODE] =
+			"inactive due to trigger mode",
+		[TAS_DYNA_INACTIVE_BLOCK_LISTED] =
+			"inactive due to block listed",
+		[TAS_DYNA_INACTIVE_UHB_NON_US] =
+			"inactive due to uhb non US",
+		[TAS_DYNA_ACTIVE] = "ACTIVE",
+	};
+	struct iwl_host_cmd hcmd = {
+		.id = WIDE_ID(DEBUG_GROUP, GET_TAS_STATUS),
+		.flags = CMD_WANT_SKB,
+		.len = { 0, },
+		.data = { NULL, },
+	};
+	int ret, i, tmp;
+	bool tas_enabled = false;
+	unsigned long dyn_status;
+
+	if (!iwl_mvm_firmware_running(mvm))
+		return -ENODEV;
+
+	mutex_lock(&mvm->mutex);
+	ret = iwl_mvm_send_cmd(mvm, &hcmd);
+	mutex_unlock(&mvm->mutex);
+	if (ret < 0)
+		return ret;
+
+	buff = kzalloc(bufsz, GFP_KERNEL);
+	if (!buff)
+		return -ENOMEM;
+	pos = buff;
+	endpos = pos + bufsz;
+
+	rsp = (void *)hcmd.resp_pkt->data;
+
+	pos += scnprintf(pos, endpos - pos, "TAS Conclusion:\n");
+	for (i = 0; i < rsp->in_dual_radio + 1; i++) {
+		if (rsp->tas_status_mac[i].band != TAS_LMAC_BAND_INVALID &&
+		    rsp->tas_status_mac[i].dynamic_status & BIT(TAS_DYNA_ACTIVE)) {
+			pos += scnprintf(pos, endpos - pos, "\tON for ");
+			switch (rsp->tas_status_mac[i].band) {
+			case TAS_LMAC_BAND_HB:
+				pos += scnprintf(pos, endpos - pos, "HB\n");
+				break;
+			case TAS_LMAC_BAND_LB:
+				pos += scnprintf(pos, endpos - pos, "LB\n");
+				break;
+			case TAS_LMAC_BAND_UHB:
+				pos += scnprintf(pos, endpos - pos, "UHB\n");
+				break;
+			case TAS_LMAC_BAND_INVALID:
+				pos += scnprintf(pos, endpos - pos,
+						 "INVALID BAND\n");
+				break;
+			default:
+				pos += scnprintf(pos, endpos - pos,
+						 "Unsupported band (%d)\n",
+						 rsp->tas_status_mac[i].band);
+				goto out;
+			}
+			tas_enabled = true;
+		}
+	}
+	if (!tas_enabled)
+		pos += scnprintf(pos, endpos - pos, "\tOFF\n");
+
+	pos += scnprintf(pos, endpos - pos, "TAS Report\n");
+	pos += scnprintf(pos, endpos - pos, "TAS FW version: %d\n",
+			 rsp->tas_fw_version);
+	pos += scnprintf(pos, endpos - pos, "Is UHB enabled for USA?: %s\n",
+			 rsp->is_uhb_for_usa_enable ? "True" : "False");
+	pos += scnprintf(pos, endpos - pos, "Current MCC: 0x%x\n",
+			 le16_to_cpu(rsp->curr_mcc));
+
+	pos += scnprintf(pos, endpos - pos, "Block list entries:");
+	for (i = 0; i < APCI_WTAS_BLACK_LIST_MAX; i++)
+		pos += scnprintf(pos, endpos - pos, " 0x%x",
+				 le16_to_cpu(rsp->block_list[i]));
+
+	pos += scnprintf(pos, endpos - pos, "\nOEM name: %s\n",
+			 dmi_get_system_info(DMI_SYS_VENDOR));
+	pos += scnprintf(pos, endpos - pos, "\tVendor In Approved List: %s\n",
+			 iwl_mvm_is_vendor_in_approved_list() ? "YES" : "NO");
+	pos += scnprintf(pos, endpos - pos,
+			 "\tDo TAS Support Dual Radio?: %s\n",
+			 rsp->in_dual_radio ? "TRUE" : "FALSE");
+
+	for (i = 0; i < rsp->in_dual_radio + 1; i++) {
+		if (rsp->tas_status_mac[i].static_status == 0) {
+			pos += scnprintf(pos, endpos - pos,
+					 "Static status: disabled\n");
+			pos += scnprintf(pos, endpos - pos,
+					 "Static disabled reason: %s (0)\n",
+					 tas_dis_reason[0]);
+			goto out;
+		}
+
+		pos += scnprintf(pos, endpos - pos, "TAS status for ");
+		switch (rsp->tas_status_mac[i].band) {
+		case TAS_LMAC_BAND_HB:
+			pos += scnprintf(pos, endpos - pos, "High band\n");
+			break;
+		case TAS_LMAC_BAND_LB:
+			pos += scnprintf(pos, endpos - pos, "Low band\n");
+			break;
+		case TAS_LMAC_BAND_UHB:
+			pos += scnprintf(pos, endpos - pos,
+					 "Ultra high band\n");
+			break;
+		case TAS_LMAC_BAND_INVALID:
+			pos += scnprintf(pos, endpos - pos,
+					 "INVALID band\n");
+			break;
+		default:
+			pos += scnprintf(pos, endpos - pos,
+					 "Unsupported band (%d)\n",
+					 rsp->tas_status_mac[i].band);
+			goto out;
+		}
+		pos += scnprintf(pos, endpos - pos, "Static status: %sabled\n",
+				 rsp->tas_status_mac[i].static_status ?
+				 "En" : "Dis");
+		pos += scnprintf(pos, endpos - pos,
+				 "\tStatic Disabled Reason: ");
+		if (rsp->tas_status_mac[i].static_dis_reason < TAS_DISABLED_REASON_MAX)
+			pos += scnprintf(pos, endpos - pos, "%s (%d)\n",
+					 tas_dis_reason[rsp->tas_status_mac[i].static_dis_reason],
+					 rsp->tas_status_mac[i].static_dis_reason);
+		else
+			pos += scnprintf(pos, endpos - pos,
+					 "unsupported value (%d)\n",
+					 rsp->tas_status_mac[i].static_dis_reason);
+
+		pos += scnprintf(pos, endpos - pos, "Dynamic status:\n");
+		dyn_status = (rsp->tas_status_mac[i].dynamic_status);
+		for_each_set_bit(tmp, &dyn_status, sizeof(dyn_status)) {
+			if (tmp >= 0 && tmp < TAS_DYNA_STATUS_MAX)
+				pos += scnprintf(pos, endpos - pos,
+						 "\t%s (%d)\n",
+						 tas_current_status[tmp], tmp);
+		}
+
+		pos += scnprintf(pos, endpos - pos,
+				 "Is near disconnection?: %s\n",
+				 rsp->tas_status_mac[i].near_disconnection ?
+				 "True" : "False");
+		tmp = le16_to_cpu(rsp->tas_status_mac[i].max_reg_pwr_limit);
+		pos += scnprintf(pos, endpos - pos,
+				 "Max. regulatory pwr limit (dBm): %d.%03d\n",
+				 tmp / 8, 125 * (tmp % 8));
+		tmp = le16_to_cpu(rsp->tas_status_mac[i].sar_limit);
+		pos += scnprintf(pos, endpos - pos,
+				 "SAR limit (dBm): %d.%03d\n",
+				 tmp / 8, 125 * (tmp % 8));
+	}
+
+out:
+	ret = simple_read_from_buffer(user_buf, count, ppos, buff, pos - buff);
+	kfree(buff);
+	iwl_free_resp(&hcmd);
+	return ret;
+}
+
 static ssize_t iwl_dbgfs_phy_integration_ver_read(struct file *file,
 						  char __user *user_buf,
 						  size_t count, loff_t *ppos)
@@ -1685,6 +1871,7 @@ MVM_DEBUGFS_READ_FILE_OPS(fw_rx_stats);
 MVM_DEBUGFS_READ_FILE_OPS(drv_rx_stats);
 MVM_DEBUGFS_READ_FILE_OPS(fw_ver);
 MVM_DEBUGFS_READ_FILE_OPS(phy_integration_ver);
+MVM_DEBUGFS_READ_FILE_OPS(tas_get_status);
 MVM_DEBUGFS_WRITE_FILE_OPS(fw_restart, 10);
 MVM_DEBUGFS_WRITE_FILE_OPS(fw_nmi, 10);
 MVM_DEBUGFS_WRITE_FILE_OPS(bt_tx_prio, 10);
@@ -1894,6 +2081,7 @@ void iwl_mvm_dbgfs_register(struct iwl_mvm *mvm)
 
 	if (mvm->fw->phy_integration_ver)
 		MVM_DEBUGFS_ADD_FILE(phy_integration_ver, mvm->debugfs_dir, 0400);
+	MVM_DEBUGFS_ADD_FILE(tas_get_status, mvm->debugfs_dir, 0400);
 #ifdef CONFIG_ACPI
 	MVM_DEBUGFS_ADD_FILE(sar_geo_profile, mvm->debugfs_dir, 0400);
 #endif
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 05236b09bcdd..6d6fa35c2b21 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -1092,6 +1092,11 @@ static const struct dmi_system_id dmi_tas_approved_list[] = {
 	{}
 };
 
+bool iwl_mvm_is_vendor_in_approved_list(void)
+{
+	return dmi_check_system(dmi_tas_approved_list);
+}
+
 static bool iwl_mvm_add_to_tas_block_list(__le32 *list, __le32 *le_size, unsigned int mcc)
 {
 	int i;
@@ -1371,6 +1376,11 @@ static void iwl_mvm_lari_cfg(struct iwl_mvm *mvm)
 {
 }
 
+bool iwl_mvm_is_vendor_in_approved_list(void)
+{
+	return false;
+}
+
 static u8 iwl_mvm_eval_dsm_rfi(struct iwl_mvm *mvm)
 {
 	return DSM_VALUE_RFI_DISABLE;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index a03c2e5bbc25..cea94250d197 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -2343,5 +2343,5 @@ static inline void iwl_mvm_mei_set_sw_rfkill_state(struct iwl_mvm *mvm)
 void iwl_mvm_send_roaming_forbidden_event(struct iwl_mvm *mvm,
 					  struct ieee80211_vif *vif,
 					  bool forbidden);
-
+bool iwl_mvm_is_vendor_in_approved_list(void);
 #endif /* __IWL_MVM_H__ */
-- 
2.38.1

