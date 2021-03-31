Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF7A634FC60
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Mar 2021 11:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234676AbhCaJPm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 31 Mar 2021 05:15:42 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:43788 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S234646AbhCaJPL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 31 Mar 2021 05:15:11 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1lRWwH-00087q-Kj; Wed, 31 Mar 2021 12:15:03 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Wed, 31 Mar 2021 12:14:50 +0300
Message-Id: <iwlwifi.20210331121101.055654e7707e.If7eaf9839cd5d59729a235df07e31668b408e740@changeid>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210331091452.543321-1-luca@coelho.fi>
References: <20210331091452.543321-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: [PATCH 10/12] iwlwifi: mvm: support BIOS enable/disable for 11ax in Ukraine
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Miri Korenblit <miriam.rachel.korenblit@intel.com>

Read the new BIOS DSM and Pass to FW if to disable\enable
11ax for Ukraine according to the BIOS key. this is
needed to enable OEMs to control enable/disable 11ax in Ukraine

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c  | 29 +++++++++++++++++++
 drivers/net/wireless/intel/iwlwifi/fw/acpi.h  |  9 ++++++
 .../wireless/intel/iwlwifi/fw/api/nvm-reg.h   |  3 ++
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   |  4 +++
 4 files changed, 45 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
index 56c4d05c9cc2..874cc110d97f 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
@@ -695,3 +695,32 @@ int iwl_sar_geo_init(struct iwl_fw_runtime *fwrt,
 	return 0;
 }
 IWL_EXPORT_SYMBOL(iwl_sar_geo_init);
+
+u32 iwl_acpi_eval_dsm_11ax_enablement(struct device *dev)
+{
+	union acpi_object *obj;
+	u32 ret;
+
+	obj = iwl_acpi_get_dsm_object(dev, 0,
+				      DSM_FUNC_11AX_ENABLEMENT, NULL,
+				      &iwl_guid);
+	if (IS_ERR(obj))
+		return 0;
+
+	if (obj->type != ACPI_TYPE_INTEGER) {
+		IWL_DEBUG_DEV_RADIO(dev,
+				    "ACPI: DSM method did not return a valid object, type=%d\n",
+				    obj->type);
+		ret = 0;
+		goto out;
+	}
+
+	ret = obj->integer.value;
+	IWL_DEBUG_DEV_RADIO(dev,
+			    "ACPI: DSM method evaluated: func=DSM_FUNC_11AX_ENABLEMENT, ret=%d\n",
+			    ret);
+out:
+	ACPI_FREE(obj);
+	return ret;
+}
+IWL_EXPORT_SYMBOL(iwl_acpi_eval_dsm_11ax_enablement);
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.h b/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
index f8ea588e4fbb..b7389f41a009 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
@@ -77,6 +77,7 @@ enum iwl_dsm_funcs_rev_0 {
 	DSM_FUNC_QUERY = 0,
 	DSM_FUNC_DISABLE_SRD = 1,
 	DSM_FUNC_ENABLE_INDONESIA_5G2 = 2,
+	DSM_FUNC_11AX_ENABLEMENT = 6,
 };
 
 enum iwl_dsm_values_srd {
@@ -160,6 +161,8 @@ int iwl_sar_geo_init(struct iwl_fw_runtime *fwrt,
 int iwl_acpi_get_tas(struct iwl_fw_runtime *fwrt, __le32 *block_list_array,
 		     int *block_list_size);
 
+u32 iwl_acpi_eval_dsm_11ax_enablement(struct device *dev);
+
 #else /* CONFIG_ACPI */
 
 static inline void *iwl_acpi_get_object(struct device *dev, acpi_string method)
@@ -235,5 +238,11 @@ static inline int iwl_acpi_get_tas(struct iwl_fw_runtime *fwrt,
 {
 	return -ENOENT;
 }
+
+static inline u32 iwl_acpi_eval_dsm_11ax_enablement(struct device *dev)
+{
+	return 0;
+}
+
 #endif /* CONFIG_ACPI */
 #endif /* __iwl_fw_acpi__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h b/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h
index fbca9dd872e7..3a358bbdde8e 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h
@@ -414,6 +414,9 @@ enum iwl_lari_config_masks {
 	LARI_CONFIG_ENABLE_5G2_IN_INDONESIA_MSK		= BIT(3),
 };
 
+#define IWL_11AX_UKRAINE_MASK 3
+#define IWL_11AX_UKRAINE_SHIFT 8
+
 /**
  * struct iwl_lari_config_change_cmd_v1 - change LARI configuration
  * @config_bitmap: bit map of the config commands. each bit will trigger a
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index b8a25943a57d..ff3967f7c66b 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -1213,6 +1213,10 @@ static void iwl_mvm_lari_cfg(struct iwl_mvm *mvm)
 		cmd.config_bitmap |=
 			cpu_to_le32(LARI_CONFIG_CHANGE_ETSI_TO_DISABLED_MSK);
 
+	ret = iwl_acpi_eval_dsm_11ax_enablement((&mvm->fwrt)->dev);
+	cmd.config_bitmap |=
+		cpu_to_le32((ret &= IWL_11AX_UKRAINE_MASK) << IWL_11AX_UKRAINE_SHIFT);
+
 	/* apply more config masks here */
 
 	if (cmd.config_bitmap) {
-- 
2.31.0

