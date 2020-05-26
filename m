Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8913A1AEAB3
	for <lists+linux-wireless@lfdr.de>; Sat, 18 Apr 2020 10:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726055AbgDRIJV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 18 Apr 2020 04:09:21 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:56764 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725983AbgDRIJU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 18 Apr 2020 04:09:20 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1jPiXN-000L3r-6T; Sat, 18 Apr 2020 11:09:17 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sat, 18 Apr 2020 11:08:50 +0300
Message-Id: <iwlwifi.20200418110539.40a327d32cfd.I7203f3afc8186cca34c48a1a116baac1df5eff4e@changeid>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200418080857.2232093-1-luca@coelho.fi>
References: <20200418080857.2232093-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 05/12] iwlwifi: acpi: read TAS table from ACPI and send it to the FW
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Mordechay Goodstein <mordechay.goodstein@intel.com>

Read the Time Averaged SAR (TAS) table from ACPI and if TAS
feature is enabled in the FW send the black list countries
which TAS is disabled in to the FW

Signed-off-by: Mordechay Goodstein <mordechay.goodstein@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c  | 76 +++++++++++++++++++
 drivers/net/wireless/intel/iwlwifi/fw/acpi.h  | 17 +++++
 .../wireless/intel/iwlwifi/fw/api/nvm-reg.h   | 15 ++++
 drivers/net/wireless/intel/iwlwifi/fw/file.h  |  1 +
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   | 39 ++++++++++
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |  1 +
 6 files changed, 149 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
index ba2aff3af0fe..344eba82a902 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
@@ -151,6 +151,82 @@ union acpi_object *iwl_acpi_get_wifi_pkg(struct device *dev,
 }
 IWL_EXPORT_SYMBOL(iwl_acpi_get_wifi_pkg);
 
+int iwl_acpi_get_tas(struct iwl_fw_runtime *fwrt,
+		     __le32 *black_list_array,
+		     int *black_list_size)
+{
+	union acpi_object *wifi_pkg, *data;
+	int ret, tbl_rev, i;
+	bool enabled;
+
+	data = iwl_acpi_get_object(fwrt->dev, ACPI_WTAS_METHOD);
+	if (IS_ERR(data))
+		return PTR_ERR(data);
+
+	wifi_pkg = iwl_acpi_get_wifi_pkg(fwrt->dev, data,
+					 ACPI_WTAS_WIFI_DATA_SIZE,
+					 &tbl_rev);
+	if (IS_ERR(wifi_pkg)) {
+		ret = PTR_ERR(wifi_pkg);
+		goto out_free;
+	}
+
+	if (wifi_pkg->package.elements[0].type != ACPI_TYPE_INTEGER ||
+	    tbl_rev != 0) {
+		ret = -EINVAL;
+		goto out_free;
+	}
+
+	enabled = !!wifi_pkg->package.elements[0].integer.value;
+
+	if (!enabled) {
+		*black_list_size = -1;
+		IWL_DEBUG_RADIO(fwrt, "TAS not enabled\n");
+		ret = 0;
+		goto out_free;
+	}
+
+	if (wifi_pkg->package.elements[1].type != ACPI_TYPE_INTEGER ||
+	    wifi_pkg->package.elements[1].integer.value >
+	    APCI_WTAS_BLACK_LIST_MAX) {
+		IWL_DEBUG_RADIO(fwrt, "TAS invalid array size %llu\n",
+				wifi_pkg->package.elements[1].integer.value);
+		ret = -EINVAL;
+		goto out_free;
+	}
+	*black_list_size = wifi_pkg->package.elements[1].integer.value;
+
+	IWL_DEBUG_RADIO(fwrt, "TAS array size %d\n", *black_list_size);
+	if (*black_list_size > APCI_WTAS_BLACK_LIST_MAX) {
+		IWL_DEBUG_RADIO(fwrt, "TAS invalid array size value %u\n",
+				*black_list_size);
+		ret = -EINVAL;
+		goto out_free;
+	}
+
+	for (i = 0; i < *black_list_size; i++) {
+		u32 country;
+
+		if (wifi_pkg->package.elements[2 + i].type !=
+		    ACPI_TYPE_INTEGER) {
+			IWL_DEBUG_RADIO(fwrt,
+					"TAS invalid array elem %d\n", 2 + i);
+			ret = -EINVAL;
+			goto out_free;
+		}
+
+		country = wifi_pkg->package.elements[2 + i].integer.value;
+		black_list_array[i] = cpu_to_le32(country);
+		IWL_DEBUG_RADIO(fwrt, "TAS black list country %d\n", country);
+	}
+
+	ret = 0;
+out_free:
+	kfree(data);
+	return ret;
+}
+IWL_EXPORT_SYMBOL(iwl_acpi_get_tas);
+
 int iwl_acpi_get_mcc(struct device *dev, char *mcc)
 {
 	union acpi_object *wifi_pkg, *data;
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.h b/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
index 5590e5cc8fbb..6a646dc524e1 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
@@ -64,6 +64,7 @@
 #include "fw/api/commands.h"
 #include "fw/api/power.h"
 #include "fw/api/phy.h"
+#include "fw/api/nvm-reg.h"
 #include "fw/img.h"
 #include "iwl-trans.h"
 
@@ -75,6 +76,7 @@
 #define ACPI_SPLC_METHOD	"SPLC"
 #define ACPI_ECKV_METHOD	"ECKV"
 #define ACPI_PPAG_METHOD	"PPAG"
+#define ACPI_WTAS_METHOD	"WTAS"
 
 #define ACPI_WIFI_DOMAIN	(0x07)
 
@@ -96,6 +98,12 @@
 #define ACPI_SPLC_WIFI_DATA_SIZE	2
 #define ACPI_ECKV_WIFI_DATA_SIZE	2
 
+/*
+ * 1 type, 1 enabled, 1 black list size, 16 black list array
+ */
+#define APCI_WTAS_BLACK_LIST_MAX	16
+#define ACPI_WTAS_WIFI_DATA_SIZE	(3 + APCI_WTAS_BLACK_LIST_MAX)
+
 #define ACPI_WGDS_NUM_BANDS		2
 #define ACPI_WGDS_TABLE_SIZE		3
 
@@ -174,6 +182,9 @@ int iwl_validate_sar_geo_profile(struct iwl_fw_runtime *fwrt,
 int iwl_sar_geo_init(struct iwl_fw_runtime *fwrt,
 		     struct iwl_per_chain_offset_group *table);
 
+int iwl_acpi_get_tas(struct iwl_fw_runtime *fwrt, __le32 *black_list_array,
+		     int *black_list_size);
+
 #else /* CONFIG_ACPI */
 
 static inline void *iwl_acpi_get_object(struct device *dev, acpi_string method)
@@ -250,5 +261,11 @@ static inline int iwl_sar_geo_init(struct iwl_fw_runtime *fwrt,
 	return -ENOENT;
 }
 
+static inline int iwl_acpi_get_tas(struct iwl_fw_runtime *fwrt,
+				   __le32 *black_list_array,
+				   int *black_list_size)
+{
+	return -ENOENT;
+}
 #endif /* CONFIG_ACPI */
 #endif /* __iwl_fw_acpi__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h b/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h
index 97b49843e318..2d230a7893c2 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h
@@ -80,6 +80,11 @@ enum iwl_regulatory_and_nvm_subcmd_ids {
 	 * response is &struct iwl_nvm_get_info_rsp
 	 */
 	NVM_GET_INFO = 0x2,
+
+	/**
+	 * @TAS_CONFIG: &struct iwl_tas_config_cmd
+	 */
+	TAS_CONFIG = 0x3,
 };
 
 /**
@@ -431,4 +436,14 @@ enum iwl_mcc_source {
 	MCC_SOURCE_GETTING_MCC_TEST_MODE = 0x11,
 };
 
+#define IWL_TAS_BLACK_LIST_MAX 16
+/**
+ * struct iwl_tas_config_cmd - configures the TAS
+ * @black_list_size: size of relevant field in black_list_array
+ * @black_list_array: black list countries (without TAS)
+ */
+struct iwl_tas_config_cmd {
+	__le32 black_list_size;
+	__le32 black_list_array[IWL_TAS_BLACK_LIST_MAX];
+} __packed; /* TAS_CONFIG_CMD_API_S_VER_2 */
 #endif /* __iwl_fw_api_nvm_reg_h__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/file.h b/drivers/net/wireless/intel/iwlwifi/fw/file.h
index 35f42e529a6d..1fb45fd30ffa 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/file.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/file.h
@@ -449,6 +449,7 @@ enum iwl_ucode_tlv_capa {
 	IWL_UCODE_TLV_CAPA_CS_MODIFY			= (__force iwl_ucode_tlv_capa_t)49,
 	IWL_UCODE_TLV_CAPA_SET_LTR_GEN2			= (__force iwl_ucode_tlv_capa_t)50,
 	IWL_UCODE_TLV_CAPA_SET_PPAG			= (__force iwl_ucode_tlv_capa_t)52,
+	IWL_UCODE_TLV_CAPA_TAS_CFG			= (__force iwl_ucode_tlv_capa_t)53,
 	IWL_UCODE_TLV_CAPA_SESSION_PROT_CMD		= (__force iwl_ucode_tlv_capa_t)54,
 
 	/* set 2 */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 2bc15ef13bb5..bf3eaadfb343 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -979,6 +979,40 @@ static int iwl_mvm_ppag_init(struct iwl_mvm *mvm)
 	return iwl_mvm_ppag_send_cmd(mvm);
 }
 
+static void iwl_mvm_tas_init(struct iwl_mvm *mvm)
+{
+	int ret;
+	struct iwl_tas_config_cmd cmd = {};
+	int list_size;
+
+	BUILD_BUG_ON(ARRAY_SIZE(cmd.black_list_array) <
+		     APCI_WTAS_BLACK_LIST_MAX);
+
+	if (!fw_has_capa(&mvm->fw->ucode_capa, IWL_UCODE_TLV_CAPA_TAS_CFG)) {
+		IWL_DEBUG_RADIO(mvm, "TAS not enabled in FW\n");
+		return;
+	}
+
+	ret = iwl_acpi_get_tas(&mvm->fwrt, cmd.black_list_array, &list_size);
+	if (ret < 0) {
+		IWL_DEBUG_RADIO(mvm,
+				"TAS table invalid or unavailable. (%d)\n",
+				ret);
+		return;
+	}
+
+	if (list_size < 0)
+		return;
+
+	/* list size if TAS enabled can only be non-negative */
+	cmd.black_list_size = cpu_to_le32((u32)list_size);
+
+	ret = iwl_mvm_send_cmd_pdu(mvm, WIDE_ID(REGULATORY_AND_NVM_GROUP,
+						TAS_CONFIG),
+				   0, sizeof(cmd), &cmd);
+	if (ret < 0)
+		IWL_DEBUG_RADIO(mvm, "failed to send TAS_CONFIG (%d)\n", ret);
+}
 #else /* CONFIG_ACPI */
 
 inline int iwl_mvm_sar_select_profile(struct iwl_mvm *mvm,
@@ -1006,6 +1040,10 @@ static int iwl_mvm_ppag_init(struct iwl_mvm *mvm)
 {
 	return 0;
 }
+
+static void iwl_mvm_tas_init(struct iwl_mvm *mvm)
+{
+}
 #endif /* CONFIG_ACPI */
 
 void iwl_mvm_send_recovery_cmd(struct iwl_mvm *mvm, u32 flags)
@@ -1333,6 +1371,7 @@ int iwl_mvm_up(struct iwl_mvm *mvm)
 	if (ret < 0)
 		goto error;
 
+	iwl_mvm_tas_init(mvm);
 	iwl_mvm_leds_sync(mvm);
 
 	IWL_DEBUG_INFO(mvm, "RT uCode started.\n");
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index b00f4a8b8424..d0afc806706d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -505,6 +505,7 @@ static const struct iwl_hcmd_names iwl_mvm_prot_offload_names[] = {
 static const struct iwl_hcmd_names iwl_mvm_regulatory_and_nvm_names[] = {
 	HCMD_NAME(NVM_ACCESS_COMPLETE),
 	HCMD_NAME(NVM_GET_INFO),
+	HCMD_NAME(TAS_CONFIG),
 };
 
 static const struct iwl_hcmd_arr iwl_mvm_groups[] = {
-- 
2.25.1

