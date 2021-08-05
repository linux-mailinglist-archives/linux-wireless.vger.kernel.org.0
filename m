Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED25B3E13C3
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Aug 2021 13:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241019AbhHELWV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 Aug 2021 07:22:21 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:51302 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S241014AbhHELWV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 Aug 2021 07:22:21 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1mBbRs-00243p-AS; Thu, 05 Aug 2021 14:22:05 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Thu,  5 Aug 2021 14:21:51 +0300
Message-Id: <iwlwifi.20210805141826.56f3506411a2.I600ed3708d19f2263a5a8d143f6711d08499bbb0@changeid>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210805112158.460799-1-luca@coelho.fi>
References: <20210805112158.460799-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: [PATCH 05/12] iwlwifi: convert flat GEO profile table to a struct version
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

The GEO profiles have been stored in single-dimension arrays and the
access has been done via a single index.  We will soon need to support
different revisions of this table, which will make the flat array even
harder to handle.  To prepare for that, convert the single-dimension
array to a struct with substructures.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c  | 48 +++++++++++--------
 drivers/net/wireless/intel/iwlwifi/fw/acpi.h  | 14 +++++-
 .../net/wireless/intel/iwlwifi/mvm/debugfs.c  | 11 +++--
 3 files changed, 45 insertions(+), 28 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
index c31c212996fa..3d2962260665 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
@@ -700,8 +700,8 @@ IWL_EXPORT_SYMBOL(iwl_sar_get_ewrd_table);
 int iwl_sar_get_wgds_table(struct iwl_fw_runtime *fwrt)
 {
 	union acpi_object *wifi_pkg, *data;
-	int i, j, ret, tbl_rev;
-	int idx = 1;
+	int i, j, k, ret, tbl_rev;
+	int idx = 1; /* start from one to skip the domain */
 
 	data = iwl_acpi_get_object(fwrt->dev, ACPI_WGDS_METHOD);
 	if (IS_ERR(data))
@@ -722,7 +722,7 @@ int iwl_sar_get_wgds_table(struct iwl_fw_runtime *fwrt)
 
 	fwrt->geo_rev = tbl_rev;
 	for (i = 0; i < ACPI_NUM_GEO_PROFILES; i++) {
-		for (j = 0; j < ACPI_GEO_TABLE_SIZE; j++) {
+		for (j = 0; j < ACPI_GEO_NUM_BANDS_REV0; j++) {
 			union acpi_object *entry;
 
 			entry = &wifi_pkg->package.elements[idx++];
@@ -732,9 +732,23 @@ int iwl_sar_get_wgds_table(struct iwl_fw_runtime *fwrt)
 				goto out_free;
 			}
 
-			fwrt->geo_profiles[i].values[j] = entry->integer.value;
+			fwrt->geo_profiles[i].bands[j].max =
+				entry->integer.value;
+
+			for (k = 0; k < ACPI_GEO_NUM_CHAINS; k++) {
+				entry = &wifi_pkg->package.elements[idx++];
+				if (entry->type != ACPI_TYPE_INTEGER ||
+				    entry->integer.value > U8_MAX) {
+					ret = -EINVAL;
+					goto out_free;
+				}
+
+				fwrt->geo_profiles[i].bands[j].chains[k] =
+					entry->integer.value;
+			}
 		}
 	}
+
 	ret = 0;
 out_free:
 	kfree(data);
@@ -784,25 +798,17 @@ int iwl_sar_geo_init(struct iwl_fw_runtime *fwrt,
 		for (j = 0; j < n_bands; j++) {
 			struct iwl_per_chain_offset *chain =
 				&table[i * n_bands + j];
-			u8 *value;
-
-			if (j * ACPI_GEO_PER_CHAIN_SIZE >=
-			    ARRAY_SIZE(fwrt->geo_profiles[0].values))
-				/*
-				 * Currently we only store lb an hb values, and
-				 * don't have any special ones for uhb. So leave
-				 * those empty for the time being
-				 */
-				break;
-
-			value = &fwrt->geo_profiles[i].values[j *
-				ACPI_GEO_PER_CHAIN_SIZE];
-			chain->max_tx_power = cpu_to_le16(value[0]);
-			chain->chain_a = value[1];
-			chain->chain_b = value[2];
+
+			chain->max_tx_power =
+				cpu_to_le16(fwrt->geo_profiles[i].bands[j].max);
+			chain->chain_a = fwrt->geo_profiles[i].bands[j].chains[0];
+			chain->chain_b = fwrt->geo_profiles[i].bands[j].chains[1];
 			IWL_DEBUG_RADIO(fwrt,
 					"SAR geographic profile[%d] Band[%d]: chain A = %d chain B = %d max_tx_power = %d\n",
-					i, j, value[1], value[2], value[0]);
+					i, j,
+					fwrt->geo_profiles[i].bands[j].chains[0],
+					fwrt->geo_profiles[i].bands[j].chains[1],
+					fwrt->geo_profiles[i].bands[j].max);
 		}
 	}
 
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.h b/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
index 85cf4cb1336e..030ea3efcc87 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
@@ -28,7 +28,6 @@
 
 #define ACPI_SAR_PROFILE_NUM		4
 
-#define ACPI_GEO_TABLE_SIZE		6
 #define ACPI_NUM_GEO_PROFILES		3
 #define ACPI_GEO_PER_CHAIN_SIZE		3
 
@@ -39,6 +38,11 @@
 #define ACPI_SAR_NUM_SUB_BANDS_REV1	11
 #define ACPI_SAR_NUM_SUB_BANDS_REV2	11
 
+#define ACPI_GEO_NUM_CHAINS		2
+#define ACPI_GEO_NUM_BANDS_REV0		2
+#define ACPI_GEO_NUM_BANDS_REV1		2
+#define ACPI_GEO_NUM_BANDS_REV2		3
+
 #define ACPI_WRDS_WIFI_DATA_SIZE_REV0	(ACPI_SAR_NUM_CHAINS_REV0 * \
 					 ACPI_SAR_NUM_SUB_BANDS_REV0 + 2)
 #define ACPI_WRDS_WIFI_DATA_SIZE_REV1	(ACPI_SAR_NUM_CHAINS_REV1 * \
@@ -90,8 +94,14 @@ struct iwl_sar_profile {
 	struct iwl_sar_profile_chain chains[ACPI_SAR_NUM_CHAINS_REV2];
 };
 
+/* Same thing as with SAR, all revisions fit in revision 2 */
+struct iwl_geo_profile_band {
+	u8 max;
+	u8 chains[ACPI_GEO_NUM_CHAINS];
+};
+
 struct iwl_geo_profile {
-	u8 values[ACPI_GEO_TABLE_SIZE];
+	struct iwl_geo_profile_band bands[ACPI_GEO_NUM_BANDS_REV2];
 };
 
 enum iwl_dsm_funcs_rev_0 {
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
index 95f883aba148..5dc39fbb74d6 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
@@ -305,7 +305,6 @@ static ssize_t iwl_dbgfs_sar_geo_profile_read(struct file *file,
 	int pos = 0;
 	int bufsz = sizeof(buf);
 	int tbl_idx;
-	u8 *value;
 
 	if (!iwl_mvm_firmware_running(mvm))
 		return -EIO;
@@ -321,16 +320,18 @@ static ssize_t iwl_dbgfs_sar_geo_profile_read(struct file *file,
 		pos = scnprintf(buf, bufsz,
 				"SAR geographic profile disabled\n");
 	} else {
-		value = &mvm->fwrt.geo_profiles[tbl_idx - 1].values[0];
-
 		pos += scnprintf(buf + pos, bufsz - pos,
 				 "Use geographic profile %d\n", tbl_idx);
 		pos += scnprintf(buf + pos, bufsz - pos,
 				 "2.4GHz:\n\tChain A offset: %hhu dBm\n\tChain B offset: %hhu dBm\n\tmax tx power: %hhu dBm\n",
-				 value[1], value[2], value[0]);
+				 mvm->fwrt.geo_profiles[tbl_idx - 1].bands[0].chains[0],
+				 mvm->fwrt.geo_profiles[tbl_idx - 1].bands[0].chains[1],
+				 mvm->fwrt.geo_profiles[tbl_idx - 1].bands[0].max);
 		pos += scnprintf(buf + pos, bufsz - pos,
 				 "5.2GHz:\n\tChain A offset: %hhu dBm\n\tChain B offset: %hhu dBm\n\tmax tx power: %hhu dBm\n",
-				 value[4], value[5], value[3]);
+				 mvm->fwrt.geo_profiles[tbl_idx - 1].bands[1].chains[0],
+				 mvm->fwrt.geo_profiles[tbl_idx - 1].bands[1].chains[1],
+				 mvm->fwrt.geo_profiles[tbl_idx - 1].bands[1].max);
 	}
 	mutex_unlock(&mvm->mutex);
 
-- 
2.32.0

