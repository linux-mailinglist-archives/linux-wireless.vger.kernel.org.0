Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3F4B43895A
	for <lists+linux-wireless@lfdr.de>; Sun, 24 Oct 2021 15:55:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231733AbhJXN5n (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 24 Oct 2021 09:57:43 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:58554 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231730AbhJXN5m (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 24 Oct 2021 09:57:42 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1medy3-000cvJ-0h; Sun, 24 Oct 2021 16:55:20 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sun, 24 Oct 2021 16:55:04 +0300
Message-Id: <iwlwifi.20211024165252.2f9b8e304f25.If88d2d1309270e659d4845c5b5c22d5e8d8e2caf@changeid>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211024135506.285102-1-luca@coelho.fi>
References: <20211024135506.285102-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 09/11] iwlwifi: ACPI: support revision 3 WGDS tables
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ayala Barazani <ayala.barazani@intel.com>

There's a new revision of the WGDS table with more data,
and corresponding firmware API to pass it through. Add
support for both.

Since we now support 4 different versions, make a table
to load them instead of hard-coding it all.

Signed-off-by: Ayala Barazani <ayala.barazani@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c  | 142 +++++++++++++-----
 drivers/net/wireless/intel/iwlwifi/fw/acpi.h  |  39 +++--
 .../net/wireless/intel/iwlwifi/fw/api/power.h |  35 ++++-
 .../net/wireless/intel/iwlwifi/fw/runtime.h   |   2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   |  44 +++++-
 5 files changed, 193 insertions(+), 69 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
index 1efac0b2a94d..4602e74d176d 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
@@ -184,9 +184,11 @@ int iwl_acpi_get_dsm_u32(struct device *dev, int rev, int func,
 }
 IWL_EXPORT_SYMBOL(iwl_acpi_get_dsm_u32);
 
-union acpi_object *iwl_acpi_get_wifi_pkg(struct device *dev,
-					 union acpi_object *data,
-					 int data_size, int *tbl_rev)
+union acpi_object *iwl_acpi_get_wifi_pkg_range(struct device *dev,
+					       union acpi_object *data,
+					       int min_data_size,
+					       int max_data_size,
+					       int *tbl_rev)
 {
 	int i;
 	union acpi_object *wifi_pkg;
@@ -196,7 +198,7 @@ union acpi_object *iwl_acpi_get_wifi_pkg(struct device *dev,
 	 * describes the domain, and one more entry, otherwise there's
 	 * no point in reading it.
 	 */
-	if (WARN_ON_ONCE(data_size < 2))
+	if (WARN_ON_ONCE(min_data_size < 2 || min_data_size > max_data_size))
 		return ERR_PTR(-EINVAL);
 
 	/*
@@ -222,7 +224,8 @@ union acpi_object *iwl_acpi_get_wifi_pkg(struct device *dev,
 
 		/* skip entries that are not a package with the right size */
 		if (wifi_pkg->type != ACPI_TYPE_PACKAGE ||
-		    wifi_pkg->package.count != data_size)
+		    wifi_pkg->package.count < min_data_size ||
+		    wifi_pkg->package.count > max_data_size)
 			continue;
 
 		domain = &wifi_pkg->package.elements[0];
@@ -236,7 +239,7 @@ union acpi_object *iwl_acpi_get_wifi_pkg(struct device *dev,
 found:
 	return wifi_pkg;
 }
-IWL_EXPORT_SYMBOL(iwl_acpi_get_wifi_pkg);
+IWL_EXPORT_SYMBOL(iwl_acpi_get_wifi_pkg_range);
 
 int iwl_acpi_get_tas(struct iwl_fw_runtime *fwrt,
 		     __le32 *block_list_array,
@@ -707,49 +710,103 @@ int iwl_sar_get_wgds_table(struct iwl_fw_runtime *fwrt)
 {
 	union acpi_object *wifi_pkg, *data;
 	int i, j, k, ret, tbl_rev;
-	int idx = 1; /* start from one to skip the domain */
-	u8 num_bands;
+	u8 num_bands, num_profiles;
+	static const struct {
+		u8 revisions;
+		u8 bands;
+		u8 profiles;
+		u8 min_profiles;
+	} rev_data[] = {
+		{
+			.revisions = BIT(3),
+			.bands = ACPI_GEO_NUM_BANDS_REV2,
+			.profiles = ACPI_NUM_GEO_PROFILES_REV3,
+			.min_profiles = 3,
+		},
+		{
+			.revisions = BIT(2),
+			.bands = ACPI_GEO_NUM_BANDS_REV2,
+			.profiles = ACPI_NUM_GEO_PROFILES,
+		},
+		{
+			.revisions = BIT(0) | BIT(1),
+			.bands = ACPI_GEO_NUM_BANDS_REV0,
+			.profiles = ACPI_NUM_GEO_PROFILES,
+		},
+	};
+	int idx;
+	/* start from one to skip the domain */
+	int entry_idx = 1;
+
+	BUILD_BUG_ON(ACPI_NUM_GEO_PROFILES_REV3 != IWL_NUM_GEO_PROFILES_V3);
+	BUILD_BUG_ON(ACPI_NUM_GEO_PROFILES != IWL_NUM_GEO_PROFILES);
 
 	data = iwl_acpi_get_object(fwrt->dev, ACPI_WGDS_METHOD);
 	if (IS_ERR(data))
 		return PTR_ERR(data);
 
-	/* start by trying to read revision 2 */
-	wifi_pkg = iwl_acpi_get_wifi_pkg(fwrt->dev, data,
-					 ACPI_WGDS_WIFI_DATA_SIZE_REV2,
-					 &tbl_rev);
-	if (!IS_ERR(wifi_pkg)) {
-		if (tbl_rev != 2) {
-			ret = PTR_ERR(wifi_pkg);
-			goto out_free;
-		}
-
-		num_bands = ACPI_GEO_NUM_BANDS_REV2;
-
-		goto read_table;
-	}
-
-	/* then try revision 0 (which is the same as 1) */
-	wifi_pkg = iwl_acpi_get_wifi_pkg(fwrt->dev, data,
-					 ACPI_WGDS_WIFI_DATA_SIZE_REV0,
-					 &tbl_rev);
-	if (!IS_ERR(wifi_pkg)) {
-		if (tbl_rev != 0 && tbl_rev != 1) {
-			ret = PTR_ERR(wifi_pkg);
-			goto out_free;
+	/* read the highest revision we understand first */
+	for (idx = 0; idx < ARRAY_SIZE(rev_data); idx++) {
+		/* min_profiles != 0 requires num_profiles header */
+		u32 hdr_size = 1 + !!rev_data[idx].min_profiles;
+		u32 profile_size = ACPI_GEO_PER_CHAIN_SIZE *
+				   rev_data[idx].bands;
+		u32 max_size = hdr_size + profile_size * rev_data[idx].profiles;
+		u32 min_size;
+
+		if (!rev_data[idx].min_profiles)
+			min_size = max_size;
+		else
+			min_size = hdr_size +
+				   profile_size * rev_data[idx].min_profiles;
+
+		wifi_pkg = iwl_acpi_get_wifi_pkg_range(fwrt->dev, data,
+						       min_size, max_size,
+						       &tbl_rev);
+		if (!IS_ERR(wifi_pkg)) {
+			if (!(BIT(tbl_rev) & rev_data[idx].revisions))
+				continue;
+
+			num_bands = rev_data[idx].bands;
+			num_profiles = rev_data[idx].profiles;
+
+			if (rev_data[idx].min_profiles) {
+				/* read header that says # of profiles */
+				union acpi_object *entry;
+
+				entry = &wifi_pkg->package.elements[entry_idx];
+				entry_idx++;
+				if (entry->type != ACPI_TYPE_INTEGER ||
+				    entry->integer.value > num_profiles) {
+					ret = -EINVAL;
+					goto out_free;
+				}
+				num_profiles = entry->integer.value;
+
+				/*
+				 * this also validates >= min_profiles since we
+				 * otherwise wouldn't have gotten the data when
+				 * looking up in ACPI
+				 */
+				if (wifi_pkg->package.count !=
+				    min_size + profile_size * num_profiles) {
+					ret = -EINVAL;
+					goto out_free;
+				}
+			}
+			goto read_table;
 		}
-
-		num_bands = ACPI_GEO_NUM_BANDS_REV0;
-
-		goto read_table;
 	}
 
-	ret = PTR_ERR(wifi_pkg);
+	if (idx < ARRAY_SIZE(rev_data))
+		ret = PTR_ERR(wifi_pkg);
+	else
+		ret = -ENOENT;
 	goto out_free;
 
 read_table:
 	fwrt->geo_rev = tbl_rev;
-	for (i = 0; i < ACPI_NUM_GEO_PROFILES; i++) {
+	for (i = 0; i < num_profiles; i++) {
 		for (j = 0; j < ACPI_GEO_NUM_BANDS_REV2; j++) {
 			union acpi_object *entry;
 
@@ -762,7 +819,8 @@ int iwl_sar_get_wgds_table(struct iwl_fw_runtime *fwrt)
 				fwrt->geo_profiles[i].bands[j].max =
 					fwrt->geo_profiles[i].bands[1].max;
 			} else {
-				entry = &wifi_pkg->package.elements[idx++];
+				entry = &wifi_pkg->package.elements[entry_idx];
+				entry_idx++;
 				if (entry->type != ACPI_TYPE_INTEGER ||
 				    entry->integer.value > U8_MAX) {
 					ret = -EINVAL;
@@ -779,7 +837,8 @@ int iwl_sar_get_wgds_table(struct iwl_fw_runtime *fwrt)
 					fwrt->geo_profiles[i].bands[j].chains[k] =
 						fwrt->geo_profiles[i].bands[1].chains[k];
 				} else {
-					entry = &wifi_pkg->package.elements[idx++];
+					entry = &wifi_pkg->package.elements[entry_idx];
+					entry_idx++;
 					if (entry->type != ACPI_TYPE_INTEGER ||
 					    entry->integer.value > U8_MAX) {
 						ret = -EINVAL;
@@ -822,14 +881,15 @@ bool iwl_sar_geo_support(struct iwl_fw_runtime *fwrt)
 IWL_EXPORT_SYMBOL(iwl_sar_geo_support);
 
 int iwl_sar_geo_init(struct iwl_fw_runtime *fwrt,
-		     struct iwl_per_chain_offset *table, u32 n_bands)
+		     struct iwl_per_chain_offset *table,
+		     u32 n_bands, u32 n_profiles)
 {
 	int i, j;
 
 	if (!iwl_sar_geo_support(fwrt))
 		return -EOPNOTSUPP;
 
-	for (i = 0; i < ACPI_NUM_GEO_PROFILES; i++) {
+	for (i = 0; i < n_profiles; i++) {
 		for (j = 0; j < n_bands; j++) {
 			struct iwl_per_chain_offset *chain =
 				&table[i * n_bands + j];
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.h b/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
index 0822c6b15c43..a30b95a01144 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
@@ -29,6 +29,7 @@
 #define ACPI_SAR_PROFILE_NUM		4
 
 #define ACPI_NUM_GEO_PROFILES		3
+#define ACPI_NUM_GEO_PROFILES_REV3	8
 #define ACPI_GEO_PER_CHAIN_SIZE		3
 
 #define ACPI_SAR_NUM_CHAINS_REV0	2
@@ -59,13 +60,6 @@
 #define ACPI_GEO_NUM_BANDS_REV2		3
 #define ACPI_GEO_NUM_CHAINS		2
 
-#define ACPI_WGDS_WIFI_DATA_SIZE_REV0	(ACPI_NUM_GEO_PROFILES *   \
-					 ACPI_GEO_NUM_BANDS_REV0 * \
-					 ACPI_GEO_PER_CHAIN_SIZE + 1)
-#define ACPI_WGDS_WIFI_DATA_SIZE_REV2	(ACPI_NUM_GEO_PROFILES *   \
-					 ACPI_GEO_NUM_BANDS_REV2 * \
-					 ACPI_GEO_PER_CHAIN_SIZE + 1)
-
 #define ACPI_WRDD_WIFI_DATA_SIZE	2
 #define ACPI_SPLC_WIFI_DATA_SIZE	2
 #define ACPI_ECKV_WIFI_DATA_SIZE	2
@@ -159,10 +153,11 @@ int iwl_acpi_get_dsm_u8(struct device *dev, int rev, int func,
 int iwl_acpi_get_dsm_u32(struct device *dev, int rev, int func,
 			 const guid_t *guid, u32 *value);
 
-union acpi_object *iwl_acpi_get_wifi_pkg(struct device *dev,
-					 union acpi_object *data,
-					 int data_size, int *tbl_rev);
-
+union acpi_object *iwl_acpi_get_wifi_pkg_range(struct device *dev,
+					       union acpi_object *data,
+					       int min_data_size,
+					       int max_data_size,
+					       int *tbl_rev);
 /**
  * iwl_acpi_get_mcc - read MCC from ACPI, if available
  *
@@ -199,7 +194,8 @@ int iwl_sar_get_wgds_table(struct iwl_fw_runtime *fwrt);
 bool iwl_sar_geo_support(struct iwl_fw_runtime *fwrt);
 
 int iwl_sar_geo_init(struct iwl_fw_runtime *fwrt,
-		     struct iwl_per_chain_offset *table, u32 n_bands);
+		     struct iwl_per_chain_offset *table,
+		     u32 n_bands, u32 n_profiles);
 
 int iwl_acpi_get_tas(struct iwl_fw_runtime *fwrt, __le32 *block_list_array,
 		     int *block_list_size);
@@ -231,10 +227,11 @@ static inline int iwl_acpi_get_dsm_u32(struct device *dev, int rev, int func,
 	return -ENOENT;
 }
 
-static inline union acpi_object *iwl_acpi_get_wifi_pkg(struct device *dev,
-						       union acpi_object *data,
-						       int data_size,
-						       int *tbl_rev)
+static inline union acpi_object *
+iwl_acpi_get_wifi_pkg_range(struct device *dev,
+			    union acpi_object *data,
+			    int min_data_size, int max_data_size,
+			    int *tbl_rev)
 {
 	return ERR_PTR(-ENOENT);
 }
@@ -294,4 +291,14 @@ static inline __le32 iwl_acpi_get_lari_config_bitmap(struct iwl_fw_runtime *fwrt
 }
 
 #endif /* CONFIG_ACPI */
+
+static inline union acpi_object *
+iwl_acpi_get_wifi_pkg(struct device *dev,
+		      union acpi_object *data,
+		      int data_size, int *tbl_rev)
+{
+	return iwl_acpi_get_wifi_pkg_range(dev, data, data_size, data_size,
+					   tbl_rev);
+}
+
 #endif /* __iwl_fw_acpi__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/power.h b/drivers/net/wireless/intel/iwlwifi/fw/api/power.h
index 86445385f072..44dd64e78a2c 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/power.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/power.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2012-2014, 2018-2020 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2021 Intel Corporation
  * Copyright (C) 2013-2014 Intel Mobile Communications GmbH
  * Copyright (C) 2015-2017 Intel Deutschland GmbH
  */
@@ -378,9 +378,10 @@ struct iwl_dev_tx_power_cmd {
 	};
 };
 
-#define IWL_NUM_GEO_PROFILES   3
-#define IWL_NUM_BANDS_PER_CHAIN_V1 2
-#define IWL_NUM_BANDS_PER_CHAIN_V2 3
+#define IWL_NUM_GEO_PROFILES		3
+#define IWL_NUM_GEO_PROFILES_V3		8
+#define IWL_NUM_BANDS_PER_CHAIN_V1	2
+#define IWL_NUM_BANDS_PER_CHAIN_V2	3
 
 /**
  * enum iwl_geo_per_chain_offset_operation - type of operation
@@ -438,10 +439,36 @@ struct iwl_geo_tx_power_profiles_cmd_v3 {
 	__le32 table_revision;
 } __packed; /* GEO_TX_POWER_LIMIT_VER_3 */
 
+/**
+ * struct iwl_geo_tx_power_profile_cmd_v4 - struct for GEO_TX_POWER_LIMIT cmd.
+ * @ops: operations, value from &enum iwl_geo_per_chain_offset_operation
+ * @table: offset profile per band.
+ * @table_revision: BIOS table revision.
+ */
+struct iwl_geo_tx_power_profiles_cmd_v4 {
+	__le32 ops;
+	struct iwl_per_chain_offset table[IWL_NUM_GEO_PROFILES_V3][IWL_NUM_BANDS_PER_CHAIN_V1];
+	__le32 table_revision;
+} __packed; /* GEO_TX_POWER_LIMIT_VER_4 */
+
+/**
+ * struct iwl_geo_tx_power_profile_cmd_v5 - struct for GEO_TX_POWER_LIMIT cmd.
+ * @ops: operations, value from &enum iwl_geo_per_chain_offset_operation
+ * @table: offset profile per band.
+ * @table_revision: BIOS table revision.
+ */
+struct iwl_geo_tx_power_profiles_cmd_v5 {
+	__le32 ops;
+	struct iwl_per_chain_offset table[IWL_NUM_GEO_PROFILES_V3][IWL_NUM_BANDS_PER_CHAIN_V2];
+	__le32 table_revision;
+} __packed; /* GEO_TX_POWER_LIMIT_VER_5 */
+
 union iwl_geo_tx_power_profiles_cmd {
 	struct iwl_geo_tx_power_profiles_cmd_v1 v1;
 	struct iwl_geo_tx_power_profiles_cmd_v2 v2;
 	struct iwl_geo_tx_power_profiles_cmd_v3 v3;
+	struct iwl_geo_tx_power_profiles_cmd_v4 v4;
+	struct iwl_geo_tx_power_profiles_cmd_v5 v5;
 };
 
 /**
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/runtime.h b/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
index a569ce3c5e96..69799f1ed2c4 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
@@ -154,7 +154,7 @@ struct iwl_fw_runtime {
 	struct iwl_sar_profile sar_profiles[ACPI_SAR_PROFILE_NUM];
 	u8 sar_chain_a_profile;
 	u8 sar_chain_b_profile;
-	struct iwl_geo_profile geo_profiles[ACPI_NUM_GEO_PROFILES];
+	struct iwl_geo_profile geo_profiles[ACPI_NUM_GEO_PROFILES_REV3];
 	u32 geo_rev;
 	union iwl_ppag_table_cmd ppag_table;
 	u32 ppag_ver;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 410a8d20d56e..e64b6468d1a1 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -776,7 +776,11 @@ int iwl_mvm_get_sar_geo_profile(struct iwl_mvm *mvm)
 	geo_tx_cmd.v1.ops =
 		cpu_to_le32(IWL_PER_CHAIN_OFFSET_GET_CURRENT_TABLE);
 
-	if (cmd_ver == 3)
+	if (cmd_ver == 5)
+		len = sizeof(geo_tx_cmd.v5);
+	else if (cmd_ver == 4)
+		len = sizeof(geo_tx_cmd.v4);
+	else if (cmd_ver == 3)
 		len = sizeof(geo_tx_cmd.v3);
 	else if (fw_has_api(&mvm->fwrt.fw->ucode_capa,
 			    IWL_UCODE_TLV_API_SAR_TABLE_VER))
@@ -803,7 +807,7 @@ int iwl_mvm_get_sar_geo_profile(struct iwl_mvm *mvm)
 	resp = (void *)cmd.resp_pkt->data;
 	ret = le32_to_cpu(resp->profile_idx);
 
-	if (WARN_ON(ret > ACPI_NUM_GEO_PROFILES))
+	if (WARN_ON(ret > ACPI_NUM_GEO_PROFILES_REV3))
 		ret = -EIO;
 
 	iwl_free_resp(&cmd);
@@ -815,6 +819,7 @@ static int iwl_mvm_sar_geo_init(struct iwl_mvm *mvm)
 	union iwl_geo_tx_power_profiles_cmd cmd;
 	u16 len;
 	u32 n_bands;
+	u32 n_profiles;
 	int ret;
 	u8 cmd_ver = iwl_fw_lookup_cmd_ver(mvm->fw, PHY_OPS_GROUP,
 					   GEO_TX_POWER_LIMIT,
@@ -823,28 +828,49 @@ static int iwl_mvm_sar_geo_init(struct iwl_mvm *mvm)
 	BUILD_BUG_ON(offsetof(struct iwl_geo_tx_power_profiles_cmd_v1, ops) !=
 		     offsetof(struct iwl_geo_tx_power_profiles_cmd_v2, ops) ||
 		     offsetof(struct iwl_geo_tx_power_profiles_cmd_v2, ops) !=
-		     offsetof(struct iwl_geo_tx_power_profiles_cmd_v3, ops));
+		     offsetof(struct iwl_geo_tx_power_profiles_cmd_v3, ops) ||
+		     offsetof(struct iwl_geo_tx_power_profiles_cmd_v3, ops) !=
+		     offsetof(struct iwl_geo_tx_power_profiles_cmd_v4, ops) ||
+		     offsetof(struct iwl_geo_tx_power_profiles_cmd_v4, ops) !=
+		     offsetof(struct iwl_geo_tx_power_profiles_cmd_v5, ops));
+
 	/* the ops field is at the same spot for all versions, so set in v1 */
 	cmd.v1.ops = cpu_to_le32(IWL_PER_CHAIN_OFFSET_SET_TABLES);
 
-	if (cmd_ver == 3) {
+	if (cmd_ver == 5) {
+		len = sizeof(cmd.v5);
+		n_bands = ARRAY_SIZE(cmd.v5.table[0]);
+		n_profiles = ACPI_NUM_GEO_PROFILES_REV3;
+	} else if (cmd_ver == 4) {
+		len = sizeof(cmd.v4);
+		n_bands = ARRAY_SIZE(cmd.v4.table[0]);
+		n_profiles = ACPI_NUM_GEO_PROFILES_REV3;
+	} else if (cmd_ver == 3) {
 		len = sizeof(cmd.v3);
 		n_bands = ARRAY_SIZE(cmd.v3.table[0]);
+		n_profiles = ACPI_NUM_GEO_PROFILES;
 	} else if (fw_has_api(&mvm->fwrt.fw->ucode_capa,
 			      IWL_UCODE_TLV_API_SAR_TABLE_VER)) {
 		len = sizeof(cmd.v2);
 		n_bands = ARRAY_SIZE(cmd.v2.table[0]);
+		n_profiles = ACPI_NUM_GEO_PROFILES;
 	} else {
 		len = sizeof(cmd.v1);
 		n_bands = ARRAY_SIZE(cmd.v1.table[0]);
+		n_profiles = ACPI_NUM_GEO_PROFILES;
 	}
 
 	BUILD_BUG_ON(offsetof(struct iwl_geo_tx_power_profiles_cmd_v1, table) !=
 		     offsetof(struct iwl_geo_tx_power_profiles_cmd_v2, table) ||
 		     offsetof(struct iwl_geo_tx_power_profiles_cmd_v2, table) !=
-		     offsetof(struct iwl_geo_tx_power_profiles_cmd_v3, table));
+		     offsetof(struct iwl_geo_tx_power_profiles_cmd_v3, table) ||
+		     offsetof(struct iwl_geo_tx_power_profiles_cmd_v3, table) !=
+		     offsetof(struct iwl_geo_tx_power_profiles_cmd_v4, table) ||
+		     offsetof(struct iwl_geo_tx_power_profiles_cmd_v4, table) !=
+		     offsetof(struct iwl_geo_tx_power_profiles_cmd_v5, table));
 	/* the table is at the same position for all versions, so set use v1 */
-	ret = iwl_sar_geo_init(&mvm->fwrt, &cmd.v1.table[0][0], n_bands);
+	ret = iwl_sar_geo_init(&mvm->fwrt, &cmd.v1.table[0][0],
+			       n_bands, n_profiles);
 
 	/*
 	 * It is a valid scenario to not support SAR, or miss wgds table,
@@ -857,7 +883,11 @@ static int iwl_mvm_sar_geo_init(struct iwl_mvm *mvm)
 	 * Set the revision on versions that contain it.
 	 * This must be done after calling iwl_sar_geo_init().
 	 */
-	if (cmd_ver == 3)
+	if (cmd_ver == 5)
+		cmd.v5.table_revision = cpu_to_le32(mvm->fwrt.geo_rev);
+	else if (cmd_ver == 4)
+		cmd.v4.table_revision = cpu_to_le32(mvm->fwrt.geo_rev);
+	else if (cmd_ver == 3)
 		cmd.v3.table_revision = cpu_to_le32(mvm->fwrt.geo_rev);
 	else if (fw_has_api(&mvm->fwrt.fw->ucode_capa,
 			    IWL_UCODE_TLV_API_SAR_TABLE_VER))
-- 
2.33.0

