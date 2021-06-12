Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4442B3A4E59
	for <lists+linux-wireless@lfdr.de>; Sat, 12 Jun 2021 13:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231195AbhFLLes (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 12 Jun 2021 07:34:48 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:47540 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231187AbhFLLes (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 12 Jun 2021 07:34:48 -0400
Received: from [192.130.48.226] (helo=kveik.superpark.guest)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1ls1sb-001V8i-RW; Sat, 12 Jun 2021 14:32:47 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sat, 12 Jun 2021 14:32:34 +0300
Message-Id: <iwlwifi.20210612142637.a705f7cedff8.I580f1021cabcc37e88f5ec5e9a6bbf00aae514b6@changeid>
X-Mailer: git-send-email 2.32.0.rc2
In-Reply-To: <20210612113245.691117-1-luca@coelho.fi>
References: <20210612113245.691117-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: [PATCH 01/12] iwlwifi: mvm: support BIOS enable/disable for 11ax in Russia
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Miri Korenblit <miriam.rachel.korenblit@intel.com>

Read the new BIOS DSM and Pass to FW if to disable\enable
11ax for Russia according to the BIOS key. This is
needed to enable OEMs to control enable/disable 11ax in Russia.
Also add support for future "enable 11ax in country X" features.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c | 50 +++++++++++++++-----
 drivers/net/wireless/intel/iwlwifi/fw/acpi.h |  9 ++++
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c  | 26 ++++++----
 3 files changed, 63 insertions(+), 22 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
index e31bba836c6f..8cf7bc3aa09a 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
@@ -163,6 +163,27 @@ int iwl_acpi_get_dsm_u8(struct device *dev, int rev, int func,
 }
 IWL_EXPORT_SYMBOL(iwl_acpi_get_dsm_u8);
 
+/*
+ * Evaluate a DSM with no arguments and a u32 return value,
+ */
+int iwl_acpi_get_dsm_u32(struct device *dev, int rev, int func,
+			 const guid_t *guid, u32 *value)
+{
+	int ret;
+	u64 val;
+
+	ret = iwl_acpi_get_dsm_integer(dev, rev, func,
+				       guid, &val, sizeof(u32));
+
+	if (ret < 0)
+		return ret;
+
+	/* cast val (u64) to be u32 */
+	*value = (u32)val;
+	return 0;
+}
+IWL_EXPORT_SYMBOL(iwl_acpi_get_dsm_u32);
+
 union acpi_object *iwl_acpi_get_wifi_pkg(struct device *dev,
 					 union acpi_object *data,
 					 int data_size, int *tbl_rev)
@@ -734,30 +755,35 @@ static u32 iwl_acpi_eval_dsm_func(struct device *dev, enum iwl_dsm_funcs_rev_0 e
 
 __le32 iwl_acpi_get_lari_config_bitmap(struct iwl_fw_runtime *fwrt)
 {
-	u32 ret;
+	int ret;
+	u8 value;
 	__le32 config_bitmap = 0;
 
 	/*
 	 ** Evaluate func 'DSM_FUNC_ENABLE_INDONESIA_5G2'
 	 */
-	ret = iwl_acpi_eval_dsm_func(fwrt->dev, DSM_FUNC_ENABLE_INDONESIA_5G2);
+	ret = iwl_acpi_get_dsm_u8(fwrt->dev, 0,
+				  DSM_FUNC_ENABLE_INDONESIA_5G2,
+				  &iwl_guid, &value);
 
-	if (ret == DSM_VALUE_INDONESIA_ENABLE)
+	if (!ret && value == DSM_VALUE_INDONESIA_ENABLE)
 		config_bitmap |=
 			cpu_to_le32(LARI_CONFIG_ENABLE_5G2_IN_INDONESIA_MSK);
 
 	/*
 	 ** Evaluate func 'DSM_FUNC_DISABLE_SRD'
 	 */
-	ret = iwl_acpi_eval_dsm_func(fwrt->dev, DSM_FUNC_DISABLE_SRD);
-
-	if (ret == DSM_VALUE_SRD_PASSIVE)
-		config_bitmap |=
-			cpu_to_le32(LARI_CONFIG_CHANGE_ETSI_TO_PASSIVE_MSK);
-
-	else if (ret == DSM_VALUE_SRD_DISABLE)
-		config_bitmap |=
-			cpu_to_le32(LARI_CONFIG_CHANGE_ETSI_TO_DISABLED_MSK);
+	ret = iwl_acpi_get_dsm_u8(fwrt->dev, 0,
+				  DSM_FUNC_DISABLE_SRD,
+				  &iwl_guid, &value);
+	if (!ret) {
+		if (value == DSM_VALUE_SRD_PASSIVE)
+			config_bitmap |=
+				cpu_to_le32(LARI_CONFIG_CHANGE_ETSI_TO_PASSIVE_MSK);
+		else if (value == DSM_VALUE_SRD_DISABLE)
+			config_bitmap |=
+				cpu_to_le32(LARI_CONFIG_CHANGE_ETSI_TO_DISABLED_MSK);
+	}
 
 	return config_bitmap;
 }
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.h b/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
index d16e6ec08c9f..9fe64476083d 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
@@ -116,6 +116,9 @@ void *iwl_acpi_get_object(struct device *dev, acpi_string method);
 int iwl_acpi_get_dsm_u8(struct device *dev, int rev, int func,
 			const guid_t *guid, u8 *value);
 
+int iwl_acpi_get_dsm_u32(struct device *dev, int rev, int func,
+			 const guid_t *guid, u32 *value);
+
 union acpi_object *iwl_acpi_get_wifi_pkg(struct device *dev,
 					 union acpi_object *data,
 					 int data_size, int *tbl_rev);
@@ -182,6 +185,12 @@ static inline int iwl_acpi_get_dsm_u8(struct device *dev, int rev, int func,
 	return -ENOENT;
 }
 
+static inline int iwl_acpi_get_dsm_u32(struct device *dev, int rev, int func,
+				       const guid_t *guid, u32 *value)
+{
+	return -ENOENT;
+}
+
 static inline union acpi_object *iwl_acpi_get_wifi_pkg(struct device *dev,
 						       union acpi_object *data,
 						       int data_size,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index d46172c2e7b8..8af24e446634 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -1141,14 +1141,19 @@ static u8 iwl_mvm_eval_dsm_rfi(struct iwl_mvm *mvm)
 
 static void iwl_mvm_lari_cfg(struct iwl_mvm *mvm)
 {
-	int cmd_ret;
+	int ret;
+	u32 value;
 	struct iwl_lari_config_change_cmd_v3 cmd = {};
 
 	cmd.config_bitmap = iwl_acpi_get_lari_config_bitmap(&mvm->fwrt);
 
+	ret = iwl_acpi_get_dsm_u32((&mvm->fwrt)->dev, 0, DSM_FUNC_11AX_ENABLEMENT,
+				   &iwl_guid, &value);
+	if (!ret)
+		cmd.oem_11ax_allow_bitmap = cpu_to_le32(value);
 	/* apply more config masks here */
 
-	if (cmd.config_bitmap) {
+	if (cmd.config_bitmap || cmd.oem_11ax_allow_bitmap) {
 		size_t cmd_size;
 		u8 cmd_ver = iwl_fw_lookup_cmd_ver(mvm->fw,
 						   REGULATORY_AND_NVM_GROUP,
@@ -1161,16 +1166,17 @@ static void iwl_mvm_lari_cfg(struct iwl_mvm *mvm)
 			cmd_size = sizeof(struct iwl_lari_config_change_cmd_v1);
 
 		IWL_DEBUG_RADIO(mvm,
-				"sending LARI_CONFIG_CHANGE, config_bitmap=0x%x\n",
-				le32_to_cpu(cmd.config_bitmap));
-		cmd_ret = iwl_mvm_send_cmd_pdu(mvm,
-					       WIDE_ID(REGULATORY_AND_NVM_GROUP,
-						       LARI_CONFIG_CHANGE),
-					       0, cmd_size, &cmd);
-		if (cmd_ret < 0)
+				"sending LARI_CONFIG_CHANGE, config_bitmap=0x%x, oem_11ax_allow_bitmap=0x%x\n",
+				le32_to_cpu(cmd.config_bitmap),
+				le32_to_cpu(cmd.oem_11ax_allow_bitmap));
+		ret = iwl_mvm_send_cmd_pdu(mvm,
+					   WIDE_ID(REGULATORY_AND_NVM_GROUP,
+						   LARI_CONFIG_CHANGE),
+					   0, cmd_size, &cmd);
+		if (ret < 0)
 			IWL_DEBUG_RADIO(mvm,
 					"Failed to send LARI_CONFIG_CHANGE (%d)\n",
-					cmd_ret);
+					ret);
 	}
 }
 #else /* CONFIG_ACPI */
-- 
2.32.0.rc2

