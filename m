Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A80C3DDD61
	for <lists+linux-wireless@lfdr.de>; Sun, 20 Oct 2019 10:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbfJTI4A (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 20 Oct 2019 04:56:00 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:50784 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726115AbfJTI4A (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 20 Oct 2019 04:56:00 -0400
Received: from [91.156.6.193] (helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1iM70G-0003LY-QI; Sun, 20 Oct 2019 11:55:58 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sun, 20 Oct 2019 11:55:38 +0300
Message-Id: <20191020115138.d5f11b37e9bd.I4cd0754f2ed409702f99019d54721603f627b48e@changeid>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191020085545.16407-1-luca@coelho.fi>
References: <20191020085545.16407-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: [PATCH 05/12] iwlwifi: refactor the SAR tables from mvm to acpi
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ihab Zhaika <ihab.zhaika@intel.com>

Refactored the SAR related functions from iwlmvm to acpi
in order to make it shared between different opmodes
in addition to removing unused variable ppag_rev.

Signed-off-by: Ihab Zhaika <ihab.zhaika@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c  | 297 ++++++++++++++-
 drivers/net/wireless/intel/iwlwifi/fw/acpi.h  |  84 +++++
 .../net/wireless/intel/iwlwifi/fw/runtime.h   |  11 +
 .../net/wireless/intel/iwlwifi/mvm/debugfs.c  |   2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   | 356 +++---------------
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  21 +-
 6 files changed, 439 insertions(+), 332 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
index 7573af2d88ce..40fe2d667622 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
@@ -61,6 +61,7 @@
 #include "iwl-drv.h"
 #include "iwl-debug.h"
 #include "acpi.h"
+#include "fw/runtime.h"
 
 void *iwl_acpi_get_object(struct device *dev, acpi_string method)
 {
@@ -162,12 +163,13 @@ int iwl_acpi_get_mcc(struct device *dev, char *mcc)
 
 	wifi_pkg = iwl_acpi_get_wifi_pkg(dev, data, ACPI_WRDD_WIFI_DATA_SIZE,
 					 &tbl_rev);
-	if (IS_ERR(wifi_pkg) || tbl_rev != 0) {
+	if (IS_ERR(wifi_pkg)) {
 		ret = PTR_ERR(wifi_pkg);
 		goto out_free;
 	}
 
-	if (wifi_pkg->package.elements[1].type != ACPI_TYPE_INTEGER) {
+	if (wifi_pkg->package.elements[1].type != ACPI_TYPE_INTEGER ||
+	    tbl_rev != 0) {
 		ret = -EINVAL;
 		goto out_free;
 	}
@@ -224,12 +226,13 @@ int iwl_acpi_get_eckv(struct device *dev, u32 *extl_clk)
 
 	wifi_pkg = iwl_acpi_get_wifi_pkg(dev, data, ACPI_ECKV_WIFI_DATA_SIZE,
 					 &tbl_rev);
-	if (IS_ERR(wifi_pkg) || tbl_rev != 0) {
+	if (IS_ERR(wifi_pkg)) {
 		ret = PTR_ERR(wifi_pkg);
 		goto out_free;
 	}
 
-	if (wifi_pkg->package.elements[1].type != ACPI_TYPE_INTEGER) {
+	if (wifi_pkg->package.elements[1].type != ACPI_TYPE_INTEGER ||
+	    tbl_rev != 0) {
 		ret = -EINVAL;
 		goto out_free;
 	}
@@ -243,3 +246,289 @@ int iwl_acpi_get_eckv(struct device *dev, u32 *extl_clk)
 	return ret;
 }
 IWL_EXPORT_SYMBOL(iwl_acpi_get_eckv);
+
+int iwl_sar_set_profile(union acpi_object *table,
+			struct iwl_sar_profile *profile,
+			bool enabled)
+{
+	int i;
+
+	profile->enabled = enabled;
+
+	for (i = 0; i < ACPI_SAR_TABLE_SIZE; i++) {
+		if (table[i].type != ACPI_TYPE_INTEGER ||
+		    table[i].integer.value > U8_MAX)
+			return -EINVAL;
+
+		profile->table[i] = table[i].integer.value;
+	}
+
+	return 0;
+}
+IWL_EXPORT_SYMBOL(iwl_sar_set_profile);
+
+int iwl_sar_select_profile(struct iwl_fw_runtime *fwrt,
+			   __le16 per_chain_restriction[][IWL_NUM_SUB_BANDS],
+			   int prof_a, int prof_b)
+{
+	int i, j, idx;
+	int profs[ACPI_SAR_NUM_CHAIN_LIMITS] = { prof_a, prof_b };
+
+	BUILD_BUG_ON(ACPI_SAR_NUM_CHAIN_LIMITS < 2);
+	BUILD_BUG_ON(ACPI_SAR_NUM_CHAIN_LIMITS * ACPI_SAR_NUM_SUB_BANDS !=
+		     ACPI_SAR_TABLE_SIZE);
+
+	for (i = 0; i < ACPI_SAR_NUM_CHAIN_LIMITS; i++) {
+		struct iwl_sar_profile *prof;
+
+		/* don't allow SAR to be disabled (profile 0 means disable) */
+		if (profs[i] == 0)
+			return -EPERM;
+
+		/* we are off by one, so allow up to ACPI_SAR_PROFILE_NUM */
+		if (profs[i] > ACPI_SAR_PROFILE_NUM)
+			return -EINVAL;
+
+		/* profiles go from 1 to 4, so decrement to access the array */
+		prof = &fwrt->sar_profiles[profs[i] - 1];
+
+		/* if the profile is disabled, do nothing */
+		if (!prof->enabled) {
+			IWL_DEBUG_RADIO(fwrt, "SAR profile %d is disabled.\n",
+					profs[i]);
+			/* if one of the profiles is disabled, we fail all */
+			return -ENOENT;
+		}
+		IWL_DEBUG_INFO(fwrt,
+			       "SAR EWRD: chain %d profile index %d\n",
+			       i, profs[i]);
+		IWL_DEBUG_RADIO(fwrt, "  Chain[%d]:\n", i);
+		for (j = 0; j < ACPI_SAR_NUM_SUB_BANDS; j++) {
+			idx = (i * ACPI_SAR_NUM_SUB_BANDS) + j;
+			per_chain_restriction[i][j] =
+				cpu_to_le16(prof->table[idx]);
+			IWL_DEBUG_RADIO(fwrt, "    Band[%d] = %d * .125dBm\n",
+					j, prof->table[idx]);
+		}
+	}
+
+	return 0;
+}
+IWL_EXPORT_SYMBOL(iwl_sar_select_profile);
+
+int iwl_sar_get_wrds_table(struct iwl_fw_runtime *fwrt)
+{
+	union acpi_object *wifi_pkg, *table, *data;
+	bool enabled;
+	int ret, tbl_rev;
+
+	data = iwl_acpi_get_object(fwrt->dev, ACPI_WRDS_METHOD);
+	if (IS_ERR(data))
+		return PTR_ERR(data);
+
+	wifi_pkg = iwl_acpi_get_wifi_pkg(fwrt->dev, data,
+					 ACPI_WRDS_WIFI_DATA_SIZE, &tbl_rev);
+	if (IS_ERR(wifi_pkg) || tbl_rev != 0) {
+		ret = PTR_ERR(wifi_pkg);
+		goto out_free;
+	}
+
+	if (wifi_pkg->package.elements[1].type != ACPI_TYPE_INTEGER) {
+		ret = -EINVAL;
+		goto out_free;
+	}
+
+	enabled = !!(wifi_pkg->package.elements[1].integer.value);
+
+	/* position of the actual table */
+	table = &wifi_pkg->package.elements[2];
+
+	/* The profile from WRDS is officially profile 1, but goes
+	 * into sar_profiles[0] (because we don't have a profile 0).
+	 */
+	ret = iwl_sar_set_profile(table, &fwrt->sar_profiles[0], enabled);
+out_free:
+	kfree(data);
+	return ret;
+}
+IWL_EXPORT_SYMBOL(iwl_sar_get_wrds_table);
+
+int iwl_sar_get_ewrd_table(struct iwl_fw_runtime *fwrt)
+{
+	union acpi_object *wifi_pkg, *data;
+	bool enabled;
+	int i, n_profiles, tbl_rev;
+	int  ret = 0;
+
+	data = iwl_acpi_get_object(fwrt->dev, ACPI_EWRD_METHOD);
+	if (IS_ERR(data))
+		return PTR_ERR(data);
+
+	wifi_pkg = iwl_acpi_get_wifi_pkg(fwrt->dev, data,
+					 ACPI_EWRD_WIFI_DATA_SIZE, &tbl_rev);
+	if (IS_ERR(wifi_pkg) || tbl_rev != 0) {
+		ret = PTR_ERR(wifi_pkg);
+		goto out_free;
+	}
+
+	if (wifi_pkg->package.elements[1].type != ACPI_TYPE_INTEGER ||
+	    wifi_pkg->package.elements[2].type != ACPI_TYPE_INTEGER) {
+		ret = -EINVAL;
+		goto out_free;
+	}
+
+	enabled = !!(wifi_pkg->package.elements[1].integer.value);
+	n_profiles = wifi_pkg->package.elements[2].integer.value;
+
+	/*
+	 * Check the validity of n_profiles.  The EWRD profiles start
+	 * from index 1, so the maximum value allowed here is
+	 * ACPI_SAR_PROFILES_NUM - 1.
+	 */
+	if (n_profiles <= 0 || n_profiles >= ACPI_SAR_PROFILE_NUM) {
+		ret = -EINVAL;
+		goto out_free;
+	}
+
+	for (i = 0; i < n_profiles; i++) {
+		/* the tables start at element 3 */
+		int pos = 3;
+
+		/* The EWRD profiles officially go from 2 to 4, but we
+		 * save them in sar_profiles[1-3] (because we don't
+		 * have profile 0).  So in the array we start from 1.
+		 */
+		ret = iwl_sar_set_profile(&wifi_pkg->package.elements[pos],
+					  &fwrt->sar_profiles[i + 1],
+					  enabled);
+		if (ret < 0)
+			break;
+
+		/* go to the next table */
+		pos += ACPI_SAR_TABLE_SIZE;
+	}
+
+out_free:
+	kfree(data);
+	return ret;
+}
+IWL_EXPORT_SYMBOL(iwl_sar_get_ewrd_table);
+
+int iwl_sar_get_wgds_table(struct iwl_fw_runtime *fwrt)
+{
+	union acpi_object *wifi_pkg, *data;
+	int i, j, ret, tbl_rev;
+	int idx = 1;
+
+	data = iwl_acpi_get_object(fwrt->dev, ACPI_WGDS_METHOD);
+	if (IS_ERR(data))
+		return PTR_ERR(data);
+
+	wifi_pkg = iwl_acpi_get_wifi_pkg(fwrt->dev, data,
+					 ACPI_WGDS_WIFI_DATA_SIZE, &tbl_rev);
+	if (IS_ERR(wifi_pkg) || tbl_rev > 1) {
+		ret = PTR_ERR(wifi_pkg);
+		goto out_free;
+	}
+
+	fwrt->geo_rev = tbl_rev;
+	for (i = 0; i < ACPI_NUM_GEO_PROFILES; i++) {
+		for (j = 0; j < ACPI_GEO_TABLE_SIZE; j++) {
+			union acpi_object *entry;
+
+			entry = &wifi_pkg->package.elements[idx++];
+			if (entry->type != ACPI_TYPE_INTEGER ||
+			    entry->integer.value > U8_MAX) {
+				ret = -EINVAL;
+				goto out_free;
+			}
+
+			fwrt->geo_profiles[i].values[j] = entry->integer.value;
+		}
+	}
+	ret = 0;
+out_free:
+	kfree(data);
+	return ret;
+}
+IWL_EXPORT_SYMBOL(iwl_sar_get_wgds_table);
+
+bool iwl_sar_geo_support(struct iwl_fw_runtime *fwrt)
+{
+	/*
+	 * The GEO_TX_POWER_LIMIT command is not supported on earlier
+	 * firmware versions.  Unfortunately, we don't have a TLV API
+	 * flag to rely on, so rely on the major version which is in
+	 * the first byte of ucode_ver.  This was implemented
+	 * initially on version 38 and then backported to 17.  It was
+	 * also backported to 29, but only for 7265D devices.  The
+	 * intention was to have it in 36 as well, but not all 8000
+	 * family got this feature enabled.  The 8000 family is the
+	 * only one using version 36, so skip this version entirely.
+	 */
+	return IWL_UCODE_SERIAL(fwrt->fw->ucode_ver) >= 38 ||
+	       IWL_UCODE_SERIAL(fwrt->fw->ucode_ver) == 17 ||
+	       (IWL_UCODE_SERIAL(fwrt->fw->ucode_ver) == 29 &&
+		((fwrt->trans->hw_rev & CSR_HW_REV_TYPE_MSK) ==
+		 CSR_HW_REV_TYPE_7265D));
+}
+IWL_EXPORT_SYMBOL(iwl_sar_geo_support);
+
+int iwl_validate_sar_geo_profile(struct iwl_fw_runtime *fwrt,
+				 struct iwl_host_cmd *cmd)
+{
+	struct iwl_geo_tx_power_profiles_resp *resp;
+	int ret;
+
+	resp = (void *)cmd->resp_pkt->data;
+	ret = le32_to_cpu(resp->profile_idx);
+	if (WARN_ON(ret > ACPI_NUM_GEO_PROFILES)) {
+		ret = -EIO;
+		IWL_WARN(fwrt, "Invalid geographic profile idx (%d)\n", ret);
+	}
+
+	return ret;
+}
+IWL_EXPORT_SYMBOL(iwl_validate_sar_geo_profile);
+
+void iwl_sar_geo_init(struct iwl_fw_runtime *fwrt,
+		      struct iwl_per_chain_offset_group *table)
+{
+	int ret, i, j;
+
+	if (!iwl_sar_geo_support(fwrt))
+		return;
+
+	ret = iwl_sar_get_wgds_table(fwrt);
+	if (ret < 0) {
+		IWL_DEBUG_RADIO(fwrt,
+				"Geo SAR BIOS table invalid or unavailable. (%d)\n",
+				ret);
+		/* we don't fail if the table is not available */
+		return;
+	}
+
+	BUILD_BUG_ON(ACPI_NUM_GEO_PROFILES * ACPI_WGDS_NUM_BANDS *
+		     ACPI_WGDS_TABLE_SIZE + 1 !=  ACPI_WGDS_WIFI_DATA_SIZE);
+
+	BUILD_BUG_ON(ACPI_NUM_GEO_PROFILES > IWL_NUM_GEO_PROFILES);
+
+	for (i = 0; i < ACPI_NUM_GEO_PROFILES; i++) {
+		struct iwl_per_chain_offset *chain =
+			(struct iwl_per_chain_offset *)&table[i];
+
+		for (j = 0; j < ACPI_WGDS_NUM_BANDS; j++) {
+			u8 *value;
+
+			value = &fwrt->geo_profiles[i].values[j *
+				ACPI_GEO_PER_CHAIN_SIZE];
+			chain[j].max_tx_power = cpu_to_le16(value[0]);
+			chain[j].chain_a = value[1];
+			chain[j].chain_b = value[2];
+			IWL_DEBUG_RADIO(fwrt,
+					"SAR geographic profile[%d] Band[%d]: chain A = %d chain B = %d max_tx_power = %d\n",
+					i, j, value[1], value[2], value[0]);
+		}
+	}
+}
+IWL_EXPORT_SYMBOL(iwl_sar_geo_init);
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.h b/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
index 6cb2d1f5efea..4a6e8262974b 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
@@ -61,6 +61,12 @@
 #define __iwl_fw_acpi__
 
 #include <linux/acpi.h>
+#include "fw/api/commands.h"
+#include "fw/api/power.h"
+#include "fw/api/phy.h"
+#include "fw/img.h"
+#include "iwl-trans.h"
+
 
 #define ACPI_WRDS_METHOD	"WRDS"
 #define ACPI_EWRD_METHOD	"EWRD"
@@ -104,9 +110,21 @@
 #define ACPI_PPAG_MIN_HB -16
 #define ACPI_PPAG_MAX_HB 40
 
+struct iwl_sar_profile {
+	bool enabled;
+	u8 table[ACPI_SAR_TABLE_SIZE];
+};
+
+struct iwl_geo_profile {
+	u8 values[ACPI_GEO_TABLE_SIZE];
+};
+
 #ifdef CONFIG_ACPI
 
+struct iwl_fw_runtime;
+
 void *iwl_acpi_get_object(struct device *dev, acpi_string method);
+
 union acpi_object *iwl_acpi_get_wifi_pkg(struct device *dev,
 					 union acpi_object *data,
 					 int data_size, int *tbl_rev);
@@ -134,6 +152,27 @@ u64 iwl_acpi_get_pwr_limit(struct device *dev);
  */
 int iwl_acpi_get_eckv(struct device *dev, u32 *extl_clk);
 
+int iwl_sar_set_profile(union acpi_object *table,
+			struct iwl_sar_profile *profile,
+			bool enabled);
+
+int iwl_sar_select_profile(struct iwl_fw_runtime *fwrt,
+			   __le16 per_chain_restriction[][IWL_NUM_SUB_BANDS],
+			   int prof_a, int prof_b);
+
+int iwl_sar_get_wrds_table(struct iwl_fw_runtime *fwrt);
+
+int iwl_sar_get_ewrd_table(struct iwl_fw_runtime *fwrt);
+
+int iwl_sar_get_wgds_table(struct iwl_fw_runtime *fwrt);
+
+bool iwl_sar_geo_support(struct iwl_fw_runtime *fwrt);
+
+int iwl_validate_sar_geo_profile(struct iwl_fw_runtime *fwrt,
+				 struct iwl_host_cmd *cmd);
+
+void iwl_sar_geo_init(struct iwl_fw_runtime *fwrt,
+		      struct iwl_per_chain_offset_group *table);
 #else /* CONFIG_ACPI */
 
 static inline void *iwl_acpi_get_object(struct device *dev, acpi_string method)
@@ -164,5 +203,50 @@ static inline int iwl_acpi_get_eckv(struct device *dev, u32 *extl_clk)
 	return -ENOENT;
 }
 
+static inline int iwl_sar_set_profile(union acpi_object *table,
+				      struct iwl_sar_profile *profile,
+				      bool enabled)
+{
+	return -ENOENT;
+}
+
+static inline int iwl_sar_select_profile(struct iwl_fw_runtime *fwrt,
+			   __le16 per_chain_restriction[][IWL_NUM_SUB_BANDS],
+			   int prof_a, int prof_b)
+{
+	return -ENOENT;
+}
+
+static inline int iwl_sar_get_wrds_table(struct iwl_fw_runtime *fwrt)
+{
+	return -ENOENT;
+}
+
+static inline int iwl_sar_get_ewrd_table(struct iwl_fw_runtime *fwrt)
+{
+	return -ENOENT;
+}
+
+static inline int iwl_sar_get_wgds_table(struct iwl_fw_runtime *fwrt)
+{
+	return -ENOENT;
+}
+
+static inline bool iwl_sar_geo_support(struct iwl_fw_runtime *fwrt)
+{
+	return false;
+}
+
+static inline int iwl_validate_sar_geo_profile(struct iwl_fw_runtime *fwrt,
+					       struct iwl_host_cmd *cmd)
+{
+	return -ENOENT;
+}
+
+static inline void iwl_sar_geo_init(struct iwl_fw_runtime *fwrt,
+				    struct iwl_per_chain_offset_group *table)
+{
+}
+
 #endif /* CONFIG_ACPI */
 #endif /* __iwl_fw_acpi__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/runtime.h b/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
index ec2ab0281f18..c24575ff0e54 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
@@ -65,7 +65,9 @@
 #include "img.h"
 #include "fw/api/debug.h"
 #include "fw/api/paging.h"
+#include "fw/api/power.h"
 #include "iwl-eeprom-parse.h"
+#include "fw/acpi.h"
 
 #define IWL_FW_DBG_DOMAIN		IWL_FW_INI_DOMAIN_ALWAYS_ON
 
@@ -203,7 +205,16 @@ struct iwl_fw_runtime {
 		u32 delay;
 		u64 seq;
 	} timestamp;
+	bool tpc_enabled;
 #endif /* CONFIG_IWLWIFI_DEBUGFS */
+#ifdef CONFIG_ACPI
+	struct iwl_sar_profile sar_profiles[ACPI_SAR_PROFILE_NUM];
+	u8 sar_chain_a_profile;
+	u8 sar_chain_b_profile;
+	struct iwl_geo_profile geo_profiles[ACPI_NUM_GEO_PROFILES];
+	u32 geo_rev;
+	struct iwl_ppag_table_cmd ppag_table;
+#endif
 };
 
 void iwl_fw_runtime_init(struct iwl_fw_runtime *fwrt, struct iwl_trans *trans,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
index b6db1f8f40cc..754adc0146be 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
@@ -377,7 +377,7 @@ static ssize_t iwl_dbgfs_sar_geo_profile_read(struct file *file,
 		pos = scnprintf(buf, bufsz,
 				"SAR geographic profile disabled\n");
 	} else {
-		value = &mvm->geo_profiles[tbl_idx - 1].values[0];
+		value = &mvm->fwrt.geo_profiles[tbl_idx - 1].values[0];
 
 		pos += scnprintf(buf + pos, bufsz - pos,
 				 "Use geographic profile %d\n", tbl_idx);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index aa644b82e93c..e842133779f4 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -675,160 +675,6 @@ static int iwl_mvm_config_ltr(struct iwl_mvm *mvm)
 }
 
 #ifdef CONFIG_ACPI
-static inline int iwl_mvm_sar_set_profile(struct iwl_mvm *mvm,
-					  union acpi_object *table,
-					  struct iwl_mvm_sar_profile *profile,
-					  bool enabled)
-{
-	int i;
-
-	profile->enabled = enabled;
-
-	for (i = 0; i < ACPI_SAR_TABLE_SIZE; i++) {
-		if ((table[i].type != ACPI_TYPE_INTEGER) ||
-		    (table[i].integer.value > U8_MAX))
-			return -EINVAL;
-
-		profile->table[i] = table[i].integer.value;
-	}
-
-	return 0;
-}
-
-static int iwl_mvm_sar_get_wrds_table(struct iwl_mvm *mvm)
-{
-	union acpi_object *wifi_pkg, *table, *data;
-	bool enabled;
-	int ret, tbl_rev;
-
-	data = iwl_acpi_get_object(mvm->dev, ACPI_WRDS_METHOD);
-	if (IS_ERR(data))
-		return PTR_ERR(data);
-
-	wifi_pkg = iwl_acpi_get_wifi_pkg(mvm->dev, data,
-					 ACPI_WRDS_WIFI_DATA_SIZE, &tbl_rev);
-	if (IS_ERR(wifi_pkg) || tbl_rev != 0) {
-		ret = PTR_ERR(wifi_pkg);
-		goto out_free;
-	}
-
-	if (wifi_pkg->package.elements[1].type != ACPI_TYPE_INTEGER) {
-		ret = -EINVAL;
-		goto out_free;
-	}
-
-	enabled = !!(wifi_pkg->package.elements[1].integer.value);
-
-	/* position of the actual table */
-	table = &wifi_pkg->package.elements[2];
-
-	/* The profile from WRDS is officially profile 1, but goes
-	 * into sar_profiles[0] (because we don't have a profile 0).
-	 */
-	ret = iwl_mvm_sar_set_profile(mvm, table, &mvm->sar_profiles[0],
-				      enabled);
-out_free:
-	kfree(data);
-	return ret;
-}
-
-static int iwl_mvm_sar_get_ewrd_table(struct iwl_mvm *mvm)
-{
-	union acpi_object *wifi_pkg, *data;
-	bool enabled;
-	int i, n_profiles, ret, tbl_rev;
-
-	data = iwl_acpi_get_object(mvm->dev, ACPI_EWRD_METHOD);
-	if (IS_ERR(data))
-		return PTR_ERR(data);
-
-	wifi_pkg = iwl_acpi_get_wifi_pkg(mvm->dev, data,
-					 ACPI_EWRD_WIFI_DATA_SIZE, &tbl_rev);
-	if (IS_ERR(wifi_pkg) || tbl_rev != 0) {
-		ret = PTR_ERR(wifi_pkg);
-		goto out_free;
-	}
-
-	if ((wifi_pkg->package.elements[1].type != ACPI_TYPE_INTEGER) ||
-	    (wifi_pkg->package.elements[2].type != ACPI_TYPE_INTEGER)) {
-		ret = -EINVAL;
-		goto out_free;
-	}
-
-	enabled = !!(wifi_pkg->package.elements[1].integer.value);
-	n_profiles = wifi_pkg->package.elements[2].integer.value;
-
-	/*
-	 * Check the validity of n_profiles.  The EWRD profiles start
-	 * from index 1, so the maximum value allowed here is
-	 * ACPI_SAR_PROFILES_NUM - 1.
-	 */
-	if (n_profiles <= 0 || n_profiles >= ACPI_SAR_PROFILE_NUM) {
-		ret = -EINVAL;
-		goto out_free;
-	}
-
-	for (i = 0; i < n_profiles; i++) {
-		/* the tables start at element 3 */
-		int pos = 3;
-
-		/* The EWRD profiles officially go from 2 to 4, but we
-		 * save them in sar_profiles[1-3] (because we don't
-		 * have profile 0).  So in the array we start from 1.
-		 */
-		ret = iwl_mvm_sar_set_profile(mvm,
-					      &wifi_pkg->package.elements[pos],
-					      &mvm->sar_profiles[i + 1],
-					      enabled);
-		if (ret < 0)
-			break;
-
-		/* go to the next table */
-		pos += ACPI_SAR_TABLE_SIZE;
-	}
-
-out_free:
-	kfree(data);
-	return ret;
-}
-
-static int iwl_mvm_sar_get_wgds_table(struct iwl_mvm *mvm)
-{
-	union acpi_object *wifi_pkg, *data;
-	int i, j, ret, tbl_rev;
-	int idx = 1;
-
-	data = iwl_acpi_get_object(mvm->dev, ACPI_WGDS_METHOD);
-	if (IS_ERR(data))
-		return PTR_ERR(data);
-
-	wifi_pkg = iwl_acpi_get_wifi_pkg(mvm->dev, data,
-					 ACPI_WGDS_WIFI_DATA_SIZE, &tbl_rev);
-	if (IS_ERR(wifi_pkg) || tbl_rev > 1) {
-		ret = PTR_ERR(wifi_pkg);
-		goto out_free;
-	}
-
-	mvm->geo_rev = tbl_rev;
-	for (i = 0; i < ACPI_NUM_GEO_PROFILES; i++) {
-		for (j = 0; j < ACPI_GEO_TABLE_SIZE; j++) {
-			union acpi_object *entry;
-
-			entry = &wifi_pkg->package.elements[idx++];
-			if ((entry->type != ACPI_TYPE_INTEGER) ||
-			    (entry->integer.value > U8_MAX)) {
-				ret = -EINVAL;
-				goto out_free;
-			}
-
-			mvm->geo_profiles[i].values[j] = entry->integer.value;
-		}
-	}
-	ret = 0;
-out_free:
-	kfree(data);
-	return ret;
-}
 
 int iwl_mvm_sar_select_profile(struct iwl_mvm *mvm, int prof_a, int prof_b)
 {
@@ -836,13 +682,8 @@ int iwl_mvm_sar_select_profile(struct iwl_mvm *mvm, int prof_a, int prof_b)
 		struct iwl_dev_tx_power_cmd v5;
 		struct iwl_dev_tx_power_cmd_v4 v4;
 	} cmd;
-	int i, j, idx;
-	int profs[ACPI_SAR_NUM_CHAIN_LIMITS] = { prof_a, prof_b };
-	int len;
 
-	BUILD_BUG_ON(ACPI_SAR_NUM_CHAIN_LIMITS < 2);
-	BUILD_BUG_ON(ACPI_SAR_NUM_CHAIN_LIMITS * ACPI_SAR_NUM_SUB_BANDS !=
-		     ACPI_SAR_TABLE_SIZE);
+	u16 len = 0;
 
 	cmd.v5.v3.set_mode = cpu_to_le32(IWL_TX_POWER_MODE_SET_CHAINS);
 
@@ -851,172 +692,76 @@ int iwl_mvm_sar_select_profile(struct iwl_mvm *mvm, int prof_a, int prof_b)
 		len = sizeof(cmd.v5);
 	else if (fw_has_capa(&mvm->fw->ucode_capa,
 			     IWL_UCODE_TLV_CAPA_TX_POWER_ACK))
-		len = sizeof(cmd.v4);
+		len = sizeof(struct iwl_dev_tx_power_cmd_v4);
 	else
 		len = sizeof(cmd.v4.v3);
 
-	for (i = 0; i < ACPI_SAR_NUM_CHAIN_LIMITS; i++) {
-		struct iwl_mvm_sar_profile *prof;
-
-		/* don't allow SAR to be disabled (profile 0 means disable) */
-		if (profs[i] == 0)
-			return -EPERM;
-
-		/* we are off by one, so allow up to ACPI_SAR_PROFILE_NUM */
-		if (profs[i] > ACPI_SAR_PROFILE_NUM)
-			return -EINVAL;
-
-		/* profiles go from 1 to 4, so decrement to access the array */
-		prof = &mvm->sar_profiles[profs[i] - 1];
-
-		/* if the profile is disabled, do nothing */
-		if (!prof->enabled) {
-			IWL_DEBUG_RADIO(mvm, "SAR profile %d is disabled.\n",
-					profs[i]);
-			/* if one of the profiles is disabled, we fail all */
-			return -ENOENT;
-		}
-
-		IWL_DEBUG_INFO(mvm,
-			       "SAR EWRD: chain %d profile index %d\n",
-			       i, profs[i]);
-		IWL_DEBUG_RADIO(mvm, "  Chain[%d]:\n", i);
-		for (j = 0; j < ACPI_SAR_NUM_SUB_BANDS; j++) {
-			idx = (i * ACPI_SAR_NUM_SUB_BANDS) + j;
-			cmd.v5.v3.per_chain_restriction[i][j] =
-				cpu_to_le16(prof->table[idx]);
-			IWL_DEBUG_RADIO(mvm, "    Band[%d] = %d * .125dBm\n",
-					j, prof->table[idx]);
-		}
-	}
 
+	if (iwl_sar_select_profile(&mvm->fwrt, cmd.v5.v3.per_chain_restriction,
+				   prof_a, prof_b))
+		return -ENOENT;
 	IWL_DEBUG_RADIO(mvm, "Sending REDUCE_TX_POWER_CMD per chain\n");
-
 	return iwl_mvm_send_cmd_pdu(mvm, REDUCE_TX_POWER_CMD, 0, len, &cmd);
 }
 
-static bool iwl_mvm_sar_geo_support(struct iwl_mvm *mvm)
-{
-	/*
-	 * The GEO_TX_POWER_LIMIT command is not supported on earlier
-	 * firmware versions.  Unfortunately, we don't have a TLV API
-	 * flag to rely on, so rely on the major version which is in
-	 * the first byte of ucode_ver.  This was implemented
-	 * initially on version 38 and then backported to29 and 17.
-	 * The intention was to have it in 36 as well, but not all
-	 * 8000 family got this feature enabled.  The 8000 family is
-	 * the only one using version 36, so skip this version
-	 * entirely.
-	 */
-	return IWL_UCODE_SERIAL(mvm->fw->ucode_ver) >= 38 ||
-	       IWL_UCODE_SERIAL(mvm->fw->ucode_ver) == 29 ||
-	       IWL_UCODE_SERIAL(mvm->fw->ucode_ver) == 17;
-}
-
 int iwl_mvm_get_sar_geo_profile(struct iwl_mvm *mvm)
 {
-	struct iwl_geo_tx_power_profiles_resp *resp;
-	int ret;
+	union geo_tx_power_profiles_cmd geo_tx_cmd;
 	u16 len;
-	void *data;
-	struct iwl_geo_tx_power_profiles_cmd geo_cmd;
-	struct iwl_geo_tx_power_profiles_cmd_v1 geo_cmd_v1;
+	int ret;
 	struct iwl_host_cmd cmd;
 
-	if (fw_has_api(&mvm->fw->ucode_capa, IWL_UCODE_TLV_API_SAR_TABLE_VER)) {
-		geo_cmd.ops =
+	if (fw_has_api(&mvm->fwrt.fw->ucode_capa,
+		       IWL_UCODE_TLV_API_SAR_TABLE_VER)) {
+		geo_tx_cmd.geo_cmd.ops =
 			cpu_to_le32(IWL_PER_CHAIN_OFFSET_GET_CURRENT_TABLE);
-		len = sizeof(geo_cmd);
-		data = &geo_cmd;
+		len = sizeof(geo_tx_cmd.geo_cmd);
 	} else {
-		geo_cmd_v1.ops =
+		geo_tx_cmd.geo_cmd_v1.ops =
 			cpu_to_le32(IWL_PER_CHAIN_OFFSET_GET_CURRENT_TABLE);
-		len = sizeof(geo_cmd_v1);
-		data = &geo_cmd_v1;
+		len = sizeof(geo_tx_cmd.geo_cmd_v1);
 	}
 
+	if (!iwl_sar_geo_support(&mvm->fwrt))
+		return -EOPNOTSUPP;
+
 	cmd = (struct iwl_host_cmd){
 		.id =  WIDE_ID(PHY_OPS_GROUP, GEO_TX_POWER_LIMIT),
 		.len = { len, },
 		.flags = CMD_WANT_SKB,
-		.data = { data },
+		.data = { &geo_tx_cmd },
 	};
 
-	if (!iwl_mvm_sar_geo_support(mvm))
-		return -EOPNOTSUPP;
-
 	ret = iwl_mvm_send_cmd(mvm, &cmd);
 	if (ret) {
 		IWL_ERR(mvm, "Failed to get geographic profile info %d\n", ret);
 		return ret;
 	}
-
-	resp = (void *)cmd.resp_pkt->data;
-	ret = le32_to_cpu(resp->profile_idx);
-	if (WARN_ON(ret > ACPI_NUM_GEO_PROFILES)) {
-		ret = -EIO;
-		IWL_WARN(mvm, "Invalid geographic profile idx (%d)\n", ret);
-	}
-
+	ret = iwl_validate_sar_geo_profile(&mvm->fwrt, &cmd);
 	iwl_free_resp(&cmd);
 	return ret;
 }
 
 static int iwl_mvm_sar_geo_init(struct iwl_mvm *mvm)
 {
-	struct iwl_geo_tx_power_profiles_cmd cmd = {
-		.ops = cpu_to_le32(IWL_PER_CHAIN_OFFSET_SET_TABLES),
-	};
-	int ret, i, j;
 	u16 cmd_wide_id =  WIDE_ID(PHY_OPS_GROUP, GEO_TX_POWER_LIMIT);
+	union geo_tx_power_profiles_cmd cmd;
+	u16 len;
 
-	if (!iwl_mvm_sar_geo_support(mvm))
-		return 0;
-
-	ret = iwl_mvm_sar_get_wgds_table(mvm);
-	if (ret < 0) {
-		IWL_DEBUG_RADIO(mvm,
-				"Geo SAR BIOS table invalid or unavailable. (%d)\n",
-				ret);
-		/* we don't fail if the table is not available */
-		return 0;
-	}
-
-	IWL_DEBUG_RADIO(mvm, "Sending GEO_TX_POWER_LIMIT\n");
-
-	BUILD_BUG_ON(ACPI_NUM_GEO_PROFILES * ACPI_WGDS_NUM_BANDS *
-		     ACPI_WGDS_TABLE_SIZE + 1 !=  ACPI_WGDS_WIFI_DATA_SIZE);
-
-	BUILD_BUG_ON(ACPI_NUM_GEO_PROFILES > IWL_NUM_GEO_PROFILES);
-
-	for (i = 0; i < ACPI_NUM_GEO_PROFILES; i++) {
-		struct iwl_per_chain_offset *chain =
-			(struct iwl_per_chain_offset *)&cmd.table[i];
-
-		for (j = 0; j < ACPI_WGDS_NUM_BANDS; j++) {
-			u8 *value;
+	cmd.geo_cmd.ops = cpu_to_le32(IWL_PER_CHAIN_OFFSET_SET_TABLES);
 
-			value = &mvm->geo_profiles[i].values[j *
-				ACPI_GEO_PER_CHAIN_SIZE];
-			chain[j].max_tx_power = cpu_to_le16(value[0]);
-			chain[j].chain_a = value[1];
-			chain[j].chain_b = value[2];
-			IWL_DEBUG_RADIO(mvm,
-					"SAR geographic profile[%d] Band[%d]: chain A = %d chain B = %d max_tx_power = %d\n",
-					i, j, value[1], value[2], value[0]);
-		}
-	}
+	iwl_sar_geo_init(&mvm->fwrt, cmd.geo_cmd.table);
 
-	cmd.table_revision = cpu_to_le32(mvm->geo_rev);
+	cmd.geo_cmd.table_revision = cpu_to_le32(mvm->fwrt.geo_rev);
 
-	if (!fw_has_api(&mvm->fw->ucode_capa,
-		       IWL_UCODE_TLV_API_SAR_TABLE_VER)) {
-		return iwl_mvm_send_cmd_pdu(mvm, cmd_wide_id, 0,
-				sizeof(struct iwl_geo_tx_power_profiles_cmd_v1),
-				&cmd);
+	if (!fw_has_api(&mvm->fwrt.fw->ucode_capa,
+			IWL_UCODE_TLV_API_SAR_TABLE_VER)) {
+		len = sizeof(struct iwl_geo_tx_power_profiles_cmd_v1);
+	} else {
+		len =  sizeof(cmd.geo_cmd);
 	}
 
-	return iwl_mvm_send_cmd_pdu(mvm, cmd_wide_id, 0, sizeof(cmd), &cmd);
+	return iwl_mvm_send_cmd_pdu(mvm, cmd_wide_id, 0, len, &cmd);
 }
 
 static int iwl_mvm_get_ppag_table(struct iwl_mvm *mvm)
@@ -1025,7 +770,7 @@ static int iwl_mvm_get_ppag_table(struct iwl_mvm *mvm)
 	int i, j, ret, tbl_rev;
 	int idx = 2;
 
-	mvm->ppag_table.enabled = cpu_to_le32(0);
+	mvm->fwrt.ppag_table.enabled = cpu_to_le32(0);
 	data = iwl_acpi_get_object(mvm->dev, ACPI_PPAG_METHOD);
 	if (IS_ERR(data))
 		return PTR_ERR(data);
@@ -1045,8 +790,8 @@ static int iwl_mvm_get_ppag_table(struct iwl_mvm *mvm)
 		goto out_free;
 	}
 
-	mvm->ppag_table.enabled = cpu_to_le32(enabled->integer.value);
-	if (!mvm->ppag_table.enabled) {
+	mvm->fwrt.ppag_table.enabled = cpu_to_le32(enabled->integer.value);
+	if (!mvm->fwrt.ppag_table.enabled) {
 		ret = 0;
 		goto out_free;
 	}
@@ -1066,11 +811,11 @@ static int iwl_mvm_get_ppag_table(struct iwl_mvm *mvm)
 			    (j == 0 && ent->integer.value < ACPI_PPAG_MIN_LB) ||
 			    (j != 0 && ent->integer.value > ACPI_PPAG_MAX_HB) ||
 			    (j != 0 && ent->integer.value < ACPI_PPAG_MIN_HB)) {
-				mvm->ppag_table.enabled = cpu_to_le32(0);
+				mvm->fwrt.ppag_table.enabled = cpu_to_le32(0);
 				ret = -EINVAL;
 				goto out_free;
 			}
-			mvm->ppag_table.gain[i][j] = ent->integer.value;
+			mvm->fwrt.ppag_table.gain[i][j] = ent->integer.value;
 		}
 	}
 	ret = 0;
@@ -1091,20 +836,20 @@ int iwl_mvm_ppag_send_cmd(struct iwl_mvm *mvm)
 
 	IWL_DEBUG_RADIO(mvm, "Sending PER_PLATFORM_ANT_GAIN_CMD\n");
 	IWL_DEBUG_RADIO(mvm, "PPAG is %s\n",
-			mvm->ppag_table.enabled ? "enabled" : "disabled");
+			mvm->fwrt.ppag_table.enabled ? "enabled" : "disabled");
 
 	for (i = 0; i < ACPI_PPAG_NUM_CHAINS; i++) {
 		for (j = 0; j < ACPI_PPAG_NUM_SUB_BANDS; j++) {
 			IWL_DEBUG_RADIO(mvm,
 					"PPAG table: chain[%d] band[%d]: gain = %d\n",
-					i, j, mvm->ppag_table.gain[i][j]);
+					i, j, mvm->fwrt.ppag_table.gain[i][j]);
 		}
 	}
 
 	ret = iwl_mvm_send_cmd_pdu(mvm, WIDE_ID(PHY_OPS_GROUP,
 						PER_PLATFORM_ANT_GAIN_CMD),
-				   0, sizeof(mvm->ppag_table),
-				   &mvm->ppag_table);
+				   0, sizeof(mvm->fwrt.ppag_table),
+				   &mvm->fwrt.ppag_table);
 	if (ret < 0)
 		IWL_ERR(mvm, "failed to send PER_PLATFORM_ANT_GAIN_CMD (%d)\n",
 			ret);
@@ -1127,17 +872,14 @@ static int iwl_mvm_ppag_init(struct iwl_mvm *mvm)
 }
 
 #else /* CONFIG_ACPI */
-static int iwl_mvm_sar_get_wrds_table(struct iwl_mvm *mvm)
-{
-	return -ENOENT;
-}
 
-static int iwl_mvm_sar_get_ewrd_table(struct iwl_mvm *mvm)
+inline int iwl_mvm_sar_select_profile(struct iwl_mvm *mvm,
+				      int prof_a, int prof_b)
 {
 	return -ENOENT;
 }
 
-static int iwl_mvm_sar_get_wgds_table(struct iwl_mvm *mvm)
+inline int iwl_mvm_get_sar_geo_profile(struct iwl_mvm *mvm)
 {
 	return -ENOENT;
 }
@@ -1147,13 +889,7 @@ static int iwl_mvm_sar_geo_init(struct iwl_mvm *mvm)
 	return 0;
 }
 
-int iwl_mvm_sar_select_profile(struct iwl_mvm *mvm, int prof_a,
-			       int prof_b)
-{
-	return -ENOENT;
-}
-
-int iwl_mvm_get_sar_geo_profile(struct iwl_mvm *mvm)
+static int iwl_mvm_get_ppag_table(struct iwl_mvm *mvm)
 {
 	return -ENOENT;
 }
@@ -1224,7 +960,7 @@ static int iwl_mvm_sar_init(struct iwl_mvm *mvm)
 {
 	int ret;
 
-	ret = iwl_mvm_sar_get_wrds_table(mvm);
+	ret = iwl_sar_get_wrds_table(&mvm->fwrt);
 	if (ret < 0) {
 		IWL_DEBUG_RADIO(mvm,
 				"WRDS SAR BIOS table invalid or unavailable. (%d)\n",
@@ -1236,16 +972,14 @@ static int iwl_mvm_sar_init(struct iwl_mvm *mvm)
 		return 1;
 	}
 
-	ret = iwl_mvm_sar_get_ewrd_table(mvm);
+	ret = iwl_sar_get_ewrd_table(&mvm->fwrt);
 	/* if EWRD is not available, we can still use WRDS, so don't fail */
 	if (ret < 0)
 		IWL_DEBUG_RADIO(mvm,
 				"EWRD SAR BIOS table invalid or unavailable. (%d)\n",
 				ret);
 
-	/* choose profile 1 (WRDS) as default for both chains */
 	ret = iwl_mvm_sar_select_profile(mvm, 1, 1);
-
 	/*
 	 * If we don't have profile 0 from BIOS, just skip it.  This
 	 * means that SAR Geo will not be enabled either, even if we
@@ -1476,7 +1210,7 @@ int iwl_mvm_up(struct iwl_mvm *mvm)
 	ret = iwl_mvm_sar_init(mvm);
 	if (ret == 0) {
 		ret = iwl_mvm_sar_geo_init(mvm);
-	} else if (ret > 0 && !iwl_mvm_sar_get_wgds_table(mvm)) {
+	} else if (ret > 0 && !iwl_sar_get_wgds_table(&mvm->fwrt)) {
 		/*
 		 * If basic SAR is not available, we check for WGDS,
 		 * which should *not* be available either.  If it is
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index a25712cce4ab..288d44a162d7 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -188,6 +188,11 @@ enum iwl_power_scheme {
 	IWL_POWER_SCHEME_LP
 };
 
+union geo_tx_power_profiles_cmd {
+	struct iwl_geo_tx_power_profiles_cmd geo_cmd;
+	struct iwl_geo_tx_power_profiles_cmd_v1 geo_cmd_v1;
+};
+
 #define IWL_CONN_MAX_LISTEN_INTERVAL	10
 #define IWL_UAPSD_MAX_SP		IEEE80211_WMM_IE_STA_QOSINFO_SP_ALL
 
@@ -774,14 +779,6 @@ enum iwl_mvm_queue_status {
 
 #define IWL_MVM_NUM_CIPHERS             10
 
-struct iwl_mvm_sar_profile {
-	bool enabled;
-	u8 table[ACPI_SAR_TABLE_SIZE];
-};
-
-struct iwl_mvm_geo_profile {
-	u8 values[ACPI_GEO_TABLE_SIZE];
-};
 
 struct iwl_mvm_txq {
 	struct list_head list;
@@ -1144,14 +1141,6 @@ struct iwl_mvm {
 	/* sniffer data to include in radiotap */
 	__le16 cur_aid;
 	u8 cur_bssid[ETH_ALEN];
-
-#ifdef CONFIG_ACPI
-	struct iwl_mvm_sar_profile sar_profiles[ACPI_SAR_PROFILE_NUM];
-	struct iwl_mvm_geo_profile geo_profiles[ACPI_NUM_GEO_PROFILES];
-	u32 geo_rev;
-	struct iwl_ppag_table_cmd ppag_table;
-	u32 ppag_rev;
-#endif
 };
 
 /* Extract MVM priv from op_mode and _hw */
-- 
2.23.0

