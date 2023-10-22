Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BCE97D236E
	for <lists+linux-wireless@lfdr.de>; Sun, 22 Oct 2023 16:56:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232084AbjJVO4W (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 22 Oct 2023 10:56:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232071AbjJVO4W (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 22 Oct 2023 10:56:22 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0359EF4
        for <linux-wireless@vger.kernel.org>; Sun, 22 Oct 2023 07:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697986578; x=1729522578;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ktwr4D5B8lGuYmHB99spEadCba8OkACKY3mYq63lSMM=;
  b=n1It9upG9tS4XLgdHJfv+5l9xt7t7alf5+q50u4QJVc4E8HnyAwU2Dje
   ZG9AFijzY9+5hEVeEODNIM+FF0bvMTALHejPgQfpD3eG/l7TVXKVzjz8N
   lFprj4LcoozYCkS6R1JyFtW43nhkVa1ERGb1uy91aR2qmjzBXFohBrCs4
   1KTymujOanDmRu58bNpexChSuvd81sHhn5HamyhsfanF+Dakbw4xuBnyf
   zOncttmhmnqHrS7AO6WTROjGMyQTVnPniC1rZrJUua0sOuBYeSDG6u5/5
   wu3qqHGTrDzBwRtWWEhMh5fn6xjqOk0VZ1mEo6VTMSOaRZm/faOwUCdEV
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10870"; a="472925852"
X-IronPort-AV: E=Sophos;i="6.03,242,1694761200"; 
   d="scan'208";a="472925852"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2023 07:56:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,242,1694761200"; 
   d="scan'208";a="5556200"
Received: from umark-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.231.87])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2023 07:55:02 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Mukesh Sisodiya <mukesh.sisodiya@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 04/10] wifi: iwlwifi: fw: Add support for UATS table in UHB
Date:   Sun, 22 Oct 2023 17:55:50 +0300
Message-Id: <20231022173519.eb6cf7be17b2.I8977a660564412056d9fd383d57b236cd4b22d00@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20231022145556.244202-1-gregory.greenman@intel.com>
References: <20231022145556.244202-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Mukesh Sisodiya <mukesh.sisodiya@intel.com>

Driver need to provide details of VLP, AFC
AP type supported for the specific MCC to firmware.
Driver will read the UATS (UHB AP type support) table
from BIOS and sent to firmware using UATS_TABLE_CMD.

Add the support for the same in the driver.

Signed-off-by: Mukesh Sisodiya <mukesh.sisodiya@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 .../wireless/intel/iwlwifi/fw/api/nvm-reg.h   | 18 ++++++
 .../net/wireless/intel/iwlwifi/fw/runtime.h   |  4 ++
 drivers/net/wireless/intel/iwlwifi/fw/uefi.c  | 50 ++++++++++++++++
 drivers/net/wireless/intel/iwlwifi/fw/uefi.h  | 17 ++++++
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   | 59 +++++++++++++++++++
 5 files changed, 148 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h b/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h
index 0fa88ee76477..dfe0bebabc81 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h
@@ -44,6 +44,11 @@ enum iwl_regulatory_and_nvm_subcmd_ids {
 	 */
 	SAR_OFFSET_MAPPING_TABLE_CMD = 0x4,
 
+	/**
+	 * @UATS_TABLE_CMD: &struct iwl_uats_table_cmd
+	 */
+	UATS_TABLE_CMD = 0x5,
+
 	/**
 	 * @PNVM_INIT_COMPLETE_NTFY: &struct iwl_pnvm_init_complete_ntfy
 	 */
@@ -650,4 +655,17 @@ struct iwl_pnvm_init_complete_ntfy {
 	__le32 status;
 } __packed; /* PNVM_INIT_COMPLETE_NTFY_S_VER_1 */
 
+#define UATS_TABLE_ROW_SIZE	26
+#define UATS_TABLE_COL_SIZE	13
+
+/**
+ * struct iwl_uats_table_cmd - struct for UATS_TABLE_CMD
+ * @offset_map: mapping a mcc to UHB AP type support (UATS) allowed
+ * @reserved: reserved
+ */
+struct iwl_uats_table_cmd {
+	u8 offset_map[UATS_TABLE_ROW_SIZE][UATS_TABLE_COL_SIZE];
+	__le16 reserved;
+} __packed; /* UATS_TABLE_CMD_S_VER_1 */
+
 #endif /* __iwl_fw_api_nvm_reg_h__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/runtime.h b/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
index 702586945533..357727774db9 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
@@ -98,6 +98,8 @@ struct iwl_txf_iter_data {
  * @cur_fw_img: current firmware image, must be maintained by
  *	the driver by calling &iwl_fw_set_current_image()
  * @dump: debug dump data
+ * @uats_enabled: VLP or AFC AP is enabled
+ * @uats_table: AP type table
  */
 struct iwl_fw_runtime {
 	struct iwl_trans *trans;
@@ -171,6 +173,8 @@ struct iwl_fw_runtime {
 	struct iwl_sar_offset_mapping_cmd sgom_table;
 	bool sgom_enabled;
 	u8 reduced_power_flags;
+	bool uats_enabled;
+	struct iwl_uats_table_cmd uats_table;
 #endif
 };
 
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/uefi.c b/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
index 9877988db0d2..2964c5fb11e9 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
@@ -388,4 +388,54 @@ void iwl_uefi_get_sgom_table(struct iwl_trans *trans,
 	kfree(data);
 }
 IWL_EXPORT_SYMBOL(iwl_uefi_get_sgom_table);
+
+static int iwl_uefi_uats_parse(struct uefi_cnv_wlan_uats_data *uats_data,
+			       struct iwl_fw_runtime *fwrt)
+{
+	if (uats_data->revision != 1)
+		return -EINVAL;
+
+	memcpy(fwrt->uats_table.offset_map, uats_data->offset_map,
+	       sizeof(fwrt->uats_table.offset_map));
+	return 0;
+}
+
+int iwl_uefi_get_uats_table(struct iwl_trans *trans,
+			    struct iwl_fw_runtime *fwrt)
+{
+	struct uefi_cnv_wlan_uats_data *data;
+	unsigned long package_size;
+	int ret;
+
+	data = iwl_uefi_get_variable(IWL_UEFI_UATS_NAME, &IWL_EFI_VAR_GUID,
+				     &package_size);
+	if (IS_ERR(data)) {
+		IWL_DEBUG_FW(trans,
+			     "UATS UEFI variable not found 0x%lx\n",
+			     PTR_ERR(data));
+		return -EINVAL;
+	}
+
+	if (package_size < sizeof(*data)) {
+		IWL_DEBUG_FW(trans,
+			     "Invalid UATS table UEFI variable len (%lu)\n",
+			     package_size);
+		kfree(data);
+		return -EINVAL;
+	}
+
+	IWL_DEBUG_FW(trans, "Read UATS from UEFI with size %lu\n",
+		     package_size);
+
+	ret = iwl_uefi_uats_parse(data, fwrt);
+	if (ret < 0) {
+		IWL_DEBUG_FW(trans, "Cannot read UATS table. rev is invalid\n");
+		kfree(data);
+		return ret;
+	}
+
+	kfree(data);
+	return 0;
+}
+IWL_EXPORT_SYMBOL(iwl_uefi_get_uats_table);
 #endif /* CONFIG_ACPI */
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/uefi.h b/drivers/net/wireless/intel/iwlwifi/fw/uefi.h
index 1369cc4855c3..bf61a8df1225 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/uefi.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/uefi.h
@@ -9,8 +9,10 @@
 #define IWL_UEFI_REDUCED_POWER_NAME	L"UefiCnvWlanReducedPower"
 #define IWL_UEFI_SGOM_NAME		L"UefiCnvWlanSarGeoOffsetMapping"
 #define IWL_UEFI_STEP_NAME		L"UefiCnvCommonSTEP"
+#define IWL_UEFI_UATS_NAME		L"CnvUefiWlanUATS"
 
 #define IWL_SGOM_MAP_SIZE		339
+#define IWL_UATS_MAP_SIZE		339
 
 struct pnvm_sku_package {
 	u8 rev;
@@ -25,6 +27,11 @@ struct uefi_cnv_wlan_sgom_data {
 	u8 offset_map[IWL_SGOM_MAP_SIZE - 1];
 } __packed;
 
+struct uefi_cnv_wlan_uats_data {
+	u8 revision;
+	u8 offset_map[IWL_UATS_MAP_SIZE - 1];
+} __packed;
+
 struct uefi_cnv_common_step_data {
 	u8 revision;
 	u8 step_mode;
@@ -82,10 +89,20 @@ iwl_uefi_handle_tlv_mem_desc(struct iwl_trans *trans, const u8 *data,
 
 #if defined(CONFIG_EFI) && defined(CONFIG_ACPI)
 void iwl_uefi_get_sgom_table(struct iwl_trans *trans, struct iwl_fw_runtime *fwrt);
+int iwl_uefi_get_uats_table(struct iwl_trans *trans,
+			    struct iwl_fw_runtime *fwrt);
 #else
 static inline
 void iwl_uefi_get_sgom_table(struct iwl_trans *trans, struct iwl_fw_runtime *fwrt)
 {
 }
+
+static inline
+int iwl_uefi_get_uats_table(struct iwl_trans *trans,
+			    struct iwl_fw_runtime *fwrt)
+{
+	return 0;
+}
+
 #endif
 #endif /* __iwl_fw_uefi__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 103233c0f38f..403bd17b8b7a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -15,6 +15,7 @@
 #include "iwl-prph.h"
 #include "fw/acpi.h"
 #include "fw/pnvm.h"
+#include "fw/uefi.h"
 
 #include "mvm.h"
 #include "fw/dbg.h"
@@ -29,6 +30,9 @@
 #define IWL_TAS_US_MCC 0x5553
 #define IWL_TAS_CANADA_MCC 0x4341
 
+#define IWL_UATS_VLP_AP_SUPPORTED BIT(29)
+#define IWL_UATS_AFC_AP_SUPPORTED BIT(30)
+
 struct iwl_mvm_alive_data {
 	bool valid;
 	u32 scd_base_addr;
@@ -487,6 +491,52 @@ static void iwl_mvm_phy_filter_init(struct iwl_mvm *mvm,
 }
 
 #if defined(CONFIG_ACPI) && defined(CONFIG_EFI)
+static void iwl_mvm_uats_init(struct iwl_mvm *mvm)
+{
+	u8 cmd_ver;
+	int ret;
+	struct iwl_host_cmd cmd = {
+		.id = WIDE_ID(REGULATORY_AND_NVM_GROUP,
+			      UATS_TABLE_CMD),
+		.flags = 0,
+		.data[0] = &mvm->fwrt.uats_table,
+		.len[0] =  sizeof(mvm->fwrt.uats_table),
+		.dataflags[0] = IWL_HCMD_DFL_NOCOPY,
+	};
+
+	if (!(mvm->trans->trans_cfg->device_family >=
+	      IWL_DEVICE_FAMILY_AX210)) {
+		IWL_DEBUG_RADIO(mvm, "UATS feature is not supported\n");
+		return;
+	}
+
+	if (!mvm->fwrt.uats_enabled) {
+		IWL_DEBUG_RADIO(mvm, "UATS feature is disabled\n");
+		return;
+	}
+
+	cmd_ver = iwl_fw_lookup_cmd_ver(mvm->fw, cmd.id,
+					IWL_FW_CMD_VER_UNKNOWN);
+	if (cmd_ver != 1) {
+		IWL_DEBUG_RADIO(mvm,
+				"UATS_TABLE_CMD ver %d not supported\n",
+				cmd_ver);
+		return;
+	}
+
+	ret = iwl_uefi_get_uats_table(mvm->trans, &mvm->fwrt);
+	if (ret < 0) {
+		IWL_ERR(mvm, "failed to read UATS table (%d)\n", ret);
+		return;
+	}
+
+	ret = iwl_mvm_send_cmd(mvm, &cmd);
+	if (ret < 0)
+		IWL_ERR(mvm, "failed to send UATS_TABLE_CMD (%d)\n", ret);
+	else
+		IWL_DEBUG_RADIO(mvm, "UATS_TABLE_CMD sent to FW\n");
+}
+
 static int iwl_mvm_sgom_init(struct iwl_mvm *mvm)
 {
 	u8 cmd_ver;
@@ -526,6 +576,10 @@ static int iwl_mvm_sgom_init(struct iwl_mvm *mvm)
 {
 	return 0;
 }
+
+static void iwl_mvm_uats_init(struct iwl_mvm *mvm)
+{
+}
 #endif
 
 static int iwl_send_phy_cfg_cmd(struct iwl_mvm *mvm)
@@ -1336,6 +1390,10 @@ static void iwl_mvm_lari_cfg(struct iwl_mvm *mvm)
 					"Failed to send LARI_CONFIG_CHANGE (%d)\n",
 					ret);
 	}
+
+	if (le32_to_cpu(cmd.oem_uhb_allow_bitmap) & IWL_UATS_VLP_AP_SUPPORTED ||
+	    le32_to_cpu(cmd.oem_uhb_allow_bitmap) & IWL_UATS_AFC_AP_SUPPORTED)
+		mvm->fwrt.uats_enabled = TRUE;
 }
 
 void iwl_mvm_get_acpi_tables(struct iwl_mvm *mvm)
@@ -1745,6 +1803,7 @@ int iwl_mvm_up(struct iwl_mvm *mvm)
 
 	iwl_mvm_tas_init(mvm);
 	iwl_mvm_leds_sync(mvm);
+	iwl_mvm_uats_init(mvm);
 
 	if (iwl_rfi_supported(mvm)) {
 		if (iwl_mvm_eval_dsm_rfi(mvm) == DSM_VALUE_RFI_ENABLE)
-- 
2.38.1

