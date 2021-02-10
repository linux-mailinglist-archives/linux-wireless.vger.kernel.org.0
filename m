Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DB043169DE
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Feb 2021 16:16:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231629AbhBJPQJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 10 Feb 2021 10:16:09 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:45238 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231193AbhBJPQF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 10 Feb 2021 10:16:05 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1l9rD3-0049kS-50; Wed, 10 Feb 2021 17:15:17 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Wed, 10 Feb 2021 17:15:04 +0200
Message-Id: <iwlwifi.20210210171218.242bfe368981.Iaccce1e2fa3986b174d0b08942aa4fbf8bb94a95@changeid>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210210151514.416221-1-luca@coelho.fi>
References: <20210210151514.416221-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 02/12] iwlwifi: acpi: add support for DSM RFI
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Gregory Greenman <gregory.greenman@intel.com>

BIOS provides RFI feature enable/disable state via WiFi DSM ACPI
object. By default the feature should be disabled.
The GUID for this feature is different from the one driver currently
uses, so need to provide a set of new definitions.

Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c | 28 ++++++++-----
 drivers/net/wireless/intel/iwlwifi/fw/acpi.h | 20 ++++++++--
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c  | 41 +++++++++++++++++++-
 3 files changed, 75 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
index 6aa0dbfa3b6c..82a4f7e8ba54 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
@@ -9,9 +9,15 @@
 #include "acpi.h"
 #include "fw/runtime.h"
 
-static const guid_t intel_wifi_guid = GUID_INIT(0xF21202BF, 0x8F78, 0x4DC6,
-						0xA5, 0xB3, 0x1F, 0x73,
-						0x8E, 0x28, 0x5A, 0xDE);
+const guid_t iwl_guid = GUID_INIT(0xF21202BF, 0x8F78, 0x4DC6,
+				  0xA5, 0xB3, 0x1F, 0x73,
+				  0x8E, 0x28, 0x5A, 0xDE);
+IWL_EXPORT_SYMBOL(iwl_guid);
+
+const guid_t iwl_rfi_guid = GUID_INIT(0x7266172C, 0x220B, 0x4B29,
+				      0x81, 0x4F, 0x75, 0xE4,
+				      0xDD, 0x26, 0xB5, 0xFD);
+IWL_EXPORT_SYMBOL(iwl_rfi_guid);
 
 static int iwl_acpi_get_handle(struct device *dev, acpi_string method,
 			       acpi_handle *ret_handle)
@@ -64,11 +70,12 @@ IWL_EXPORT_SYMBOL(iwl_acpi_get_object);
  * function.
  */
 static void *iwl_acpi_get_dsm_object(struct device *dev, int rev, int func,
-				     union acpi_object *args)
+				     union acpi_object *args,
+				     const guid_t *guid)
 {
 	union acpi_object *obj;
 
-	obj = acpi_evaluate_dsm(ACPI_HANDLE(dev), &intel_wifi_guid, rev, func,
+	obj = acpi_evaluate_dsm(ACPI_HANDLE(dev), guid, rev, func,
 				args);
 	if (!obj) {
 		IWL_DEBUG_DEV_RADIO(dev,
@@ -87,12 +94,13 @@ static void *iwl_acpi_get_dsm_object(struct device *dev, int rev, int func,
  * return 0 in success and the appropriate errno otherwise.
  */
 static int iwl_acpi_get_dsm_integer(struct device *dev, int rev, int func,
-				    u64 *value, size_t expected_size)
+				    const guid_t *guid, u64 *value,
+				    size_t expected_size)
 {
 	union acpi_object *obj;
 	int ret = 0;
 
-	obj = iwl_acpi_get_dsm_object(dev, rev, func, NULL);
+	obj = iwl_acpi_get_dsm_object(dev, rev, func, NULL, guid);
 	if (IS_ERR(obj)) {
 		IWL_DEBUG_DEV_RADIO(dev,
 				    "Failed to get  DSM object. func= %d\n",
@@ -137,12 +145,14 @@ static int iwl_acpi_get_dsm_integer(struct device *dev, int rev, int func,
 /*
  * Evaluate a DSM with no arguments and a u8 return value,
  */
-int iwl_acpi_get_dsm_u8(struct device *dev, int rev, int func, u8 *value)
+int iwl_acpi_get_dsm_u8(struct device *dev, int rev, int func,
+			const guid_t *guid, u8 *value)
 {
 	int ret;
 	u64 val;
 
-	ret = iwl_acpi_get_dsm_integer(dev, rev, func, &val, sizeof(u8));
+	ret = iwl_acpi_get_dsm_integer(dev, rev, func,
+				       guid, &val, sizeof(u8));
 
 	if (ret < 0)
 		return ret;
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.h b/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
index 62665dfee3cb..030c50082568 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
@@ -93,13 +93,27 @@ enum iwl_dsm_values_indonesia {
 	DSM_VALUE_INDONESIA_MAX
 };
 
+/* DSM RFI uses a different GUID, so need separate definitions */
+
+#define DSM_RFI_FUNC_ENABLE 3
+
+enum iwl_dsm_values_rfi {
+	DSM_VALUE_RFI_ENABLE,
+	DSM_VALUE_RFI_DISABLE,
+	DSM_VALUE_RFI_MAX
+};
+
 #ifdef CONFIG_ACPI
 
 struct iwl_fw_runtime;
 
+extern const guid_t iwl_guid;
+extern const guid_t iwl_rfi_guid;
+
 void *iwl_acpi_get_object(struct device *dev, acpi_string method);
 
-int iwl_acpi_get_dsm_u8(struct device *dev, int rev, int func, u8 *value);
+int iwl_acpi_get_dsm_u8(struct device *dev, int rev, int func,
+			const guid_t *guid, u8 *value);
 
 union acpi_object *iwl_acpi_get_wifi_pkg(struct device *dev,
 					 union acpi_object *data,
@@ -159,8 +173,8 @@ static inline void *iwl_acpi_get_dsm_object(struct device *dev, int rev,
 	return ERR_PTR(-ENOENT);
 }
 
-static inline
-int iwl_acpi_get_dsm_u8(struct device *dev, int rev, int func, u8 *value)
+static inline int iwl_acpi_get_dsm_u8(struct device *dev, int rev, int func,
+				      const guid_t *guid, u8 *value)
 {
 	return -ENOENT;
 }
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 20e93a9aff02..4d5def7e2d8c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -1141,7 +1141,8 @@ static u8 iwl_mvm_eval_dsm_indonesia_5g2(struct iwl_mvm *mvm)
 	u8 value;
 
 	int ret = iwl_acpi_get_dsm_u8((&mvm->fwrt)->dev, 0,
-				      DSM_FUNC_ENABLE_INDONESIA_5G2, &value);
+				      DSM_FUNC_ENABLE_INDONESIA_5G2,
+				      &iwl_guid, &value);
 
 	if (ret < 0)
 		IWL_DEBUG_RADIO(mvm,
@@ -1162,11 +1163,36 @@ static u8 iwl_mvm_eval_dsm_indonesia_5g2(struct iwl_mvm *mvm)
 	return DSM_VALUE_INDONESIA_DISABLE;
 }
 
+static u8 iwl_mvm_eval_dsm_rfi(struct iwl_mvm *mvm)
+{
+	u8 value;
+	int ret = iwl_acpi_get_dsm_u8((&mvm->fwrt)->dev, 0, DSM_RFI_FUNC_ENABLE,
+				      &iwl_rfi_guid, &value);
+
+	if (ret < 0) {
+		IWL_DEBUG_RADIO(mvm, "Failed to get DSM RFI, ret=%d\n", ret);
+
+	} else if (value >= DSM_VALUE_RFI_MAX) {
+		IWL_DEBUG_RADIO(mvm, "DSM RFI got invalid value, ret=%d\n",
+				value);
+
+	} else if (value == DSM_VALUE_RFI_ENABLE) {
+		IWL_DEBUG_RADIO(mvm, "DSM RFI is evaluated to enable\n");
+		return DSM_VALUE_RFI_ENABLE;
+	}
+
+	IWL_DEBUG_RADIO(mvm, "DSM RFI is disabled\n");
+
+	/* default behaviour is disabled */
+	return DSM_VALUE_RFI_DISABLE;
+}
+
 static u8 iwl_mvm_eval_dsm_disable_srd(struct iwl_mvm *mvm)
 {
 	u8 value;
 	int ret = iwl_acpi_get_dsm_u8((&mvm->fwrt)->dev, 0,
-				      DSM_FUNC_DISABLE_SRD, &value);
+				      DSM_FUNC_DISABLE_SRD,
+				      &iwl_guid, &value);
 
 	if (ret < 0)
 		IWL_DEBUG_RADIO(mvm,
@@ -1267,6 +1293,11 @@ static void iwl_mvm_tas_init(struct iwl_mvm *mvm)
 static void iwl_mvm_lari_cfg(struct iwl_mvm *mvm)
 {
 }
+
+static u8 iwl_mvm_eval_dsm_rfi(struct iwl_mvm *mvm)
+{
+	return DSM_VALUE_RFI_DISABLE;
+}
 #endif /* CONFIG_ACPI */
 
 void iwl_mvm_send_recovery_cmd(struct iwl_mvm *mvm, u32 flags)
@@ -1603,6 +1634,12 @@ int iwl_mvm_up(struct iwl_mvm *mvm)
 
 	iwl_mvm_ftm_initiator_smooth_config(mvm);
 
+	if (fw_has_capa(&mvm->fw->ucode_capa,
+			IWL_UCODE_TLV_CAPA_RFIM_SUPPORT)) {
+		if (iwl_mvm_eval_dsm_rfi(mvm) == DSM_VALUE_RFI_ENABLE)
+			iwl_rfi_send_config_cmd(mvm, NULL);
+	}
+
 	IWL_DEBUG_INFO(mvm, "RT uCode started.\n");
 	return 0;
  error:
-- 
2.30.0

