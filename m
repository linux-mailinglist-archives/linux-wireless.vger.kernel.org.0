Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E189D3E13C0
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Aug 2021 13:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241008AbhHELWS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 Aug 2021 07:22:18 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:51284 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S240955AbhHELWS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 Aug 2021 07:22:18 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1mBbRp-00243p-DC; Thu, 05 Aug 2021 14:22:03 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Thu,  5 Aug 2021 14:21:48 +0300
Message-Id: <iwlwifi.20210805141826.2edad09415c8.I36297aef90a9ec6a3ea1bf1a151a62f272826d59@changeid>
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
Subject: [PATCH 02/12] iwlwifi: acpi: support reading and storing WRDS revision 1 and 2
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

Change the SAR profile tables storage to revision 2 regardless of the
revision we read from ACPI.  Revision 2 is a superset of revision 1,
which is in turn a superset of revision 0, so they can all be stored
inside revision 2.

Add support for reading and storing also revisions 1 and 2, whose only
difference is the number of chains and number of sub-bands.  So most
of the code revolves around passing different chain and sub-band
sizes.

With this patch we still pass only revision 0 to the firmware, but
that will be changed in a separate patch.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c | 74 +++++++++++++++-----
 drivers/net/wireless/intel/iwlwifi/fw/acpi.h | 31 +++++---
 2 files changed, 80 insertions(+), 25 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
index 9175f53806bf..d4e7e303b190 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
@@ -442,10 +442,10 @@ static int iwl_sar_fill_table(struct iwl_fw_runtime *fwrt,
 			      __le16 *per_chain, u32 n_subbands,
 			      int prof_a, int prof_b)
 {
-	int profs[ACPI_SAR_NUM_CHAINS] = { prof_a, prof_b };
+	int profs[ACPI_SAR_NUM_CHAINS_REV0] = { prof_a, prof_b };
 	int i, j;
 
-	for (i = 0; i < ACPI_SAR_NUM_CHAINS; i++) {
+	for (i = 0; i < ACPI_SAR_NUM_CHAINS_REV0; i++) {
 		struct iwl_sar_profile *prof;
 
 		/* don't allow SAR to be disabled (profile 0 means disable) */
@@ -494,7 +494,7 @@ int iwl_sar_select_profile(struct iwl_fw_runtime *fwrt,
 
 	for (i = 0; i < n_tables; i++) {
 		ret = iwl_sar_fill_table(fwrt,
-			 &per_chain[i * n_subbands * ACPI_SAR_NUM_CHAINS],
+			 &per_chain[i * n_subbands * ACPI_SAR_NUM_CHAINS_REV0],
 			 n_subbands, prof_a, prof_b);
 		if (ret)
 			break;
@@ -509,28 +509,71 @@ int iwl_sar_get_wrds_table(struct iwl_fw_runtime *fwrt)
 	union acpi_object *wifi_pkg, *table, *data;
 	bool enabled;
 	int ret, tbl_rev;
+	u8 num_chains, num_sub_bands;
 
 	data = iwl_acpi_get_object(fwrt->dev, ACPI_WRDS_METHOD);
 	if (IS_ERR(data))
 		return PTR_ERR(data);
 
+	/* start by trying to read revision 2 */
 	wifi_pkg = iwl_acpi_get_wifi_pkg(fwrt->dev, data,
-					 ACPI_WRDS_WIFI_DATA_SIZE, &tbl_rev);
-	if (IS_ERR(wifi_pkg)) {
-		ret = PTR_ERR(wifi_pkg);
-		goto out_free;
+					 ACPI_WRDS_WIFI_DATA_SIZE_REV2,
+					 &tbl_rev);
+	if (!IS_ERR(wifi_pkg)) {
+		if (tbl_rev != 2) {
+			ret = PTR_ERR(wifi_pkg);
+			goto out_free;
+		}
+
+		num_chains = ACPI_SAR_NUM_CHAINS_REV2;
+		num_sub_bands = ACPI_SAR_NUM_SUB_BANDS_REV2;
+
+		goto read_table;
 	}
 
-	if (tbl_rev != 0) {
-		ret = -EINVAL;
-		goto out_free;
+	/* then try revision 1 */
+	wifi_pkg = iwl_acpi_get_wifi_pkg(fwrt->dev, data,
+					 ACPI_WRDS_WIFI_DATA_SIZE_REV1,
+					 &tbl_rev);
+	if (!IS_ERR(wifi_pkg)) {
+		if (tbl_rev != 1) {
+			ret = PTR_ERR(wifi_pkg);
+			goto out_free;
+		}
+
+		num_chains = ACPI_SAR_NUM_CHAINS_REV1;
+		num_sub_bands = ACPI_SAR_NUM_SUB_BANDS_REV1;
+
+		goto read_table;
 	}
 
+	/* then finally revision 0 */
+	wifi_pkg = iwl_acpi_get_wifi_pkg(fwrt->dev, data,
+					 ACPI_WRDS_WIFI_DATA_SIZE_REV0,
+					 &tbl_rev);
+	if (!IS_ERR(wifi_pkg)) {
+		if (tbl_rev != 0) {
+			ret = PTR_ERR(wifi_pkg);
+			goto out_free;
+		}
+
+		num_chains = ACPI_SAR_NUM_CHAINS_REV0;
+		num_sub_bands = ACPI_SAR_NUM_SUB_BANDS_REV0;
+
+		goto read_table;
+	}
+
+	ret = PTR_ERR(wifi_pkg);
+	goto out_free;
+
+read_table:
 	if (wifi_pkg->package.elements[1].type != ACPI_TYPE_INTEGER) {
 		ret = -EINVAL;
 		goto out_free;
 	}
 
+	IWL_DEBUG_RADIO(fwrt, "Reading WRDS tbl_rev=%d\n", tbl_rev);
+
 	enabled = !!(wifi_pkg->package.elements[1].integer.value);
 
 	/* position of the actual table */
@@ -540,7 +583,7 @@ int iwl_sar_get_wrds_table(struct iwl_fw_runtime *fwrt)
 	 * into sar_profiles[0] (because we don't have a profile 0).
 	 */
 	ret = iwl_sar_set_profile(table, &fwrt->sar_profiles[0], enabled,
-				  ACPI_SAR_NUM_CHAINS, ACPI_SAR_NUM_SUB_BANDS);
+				  num_chains, num_sub_bands);
 out_free:
 	kfree(data);
 	return ret;
@@ -598,15 +641,14 @@ int iwl_sar_get_ewrd_table(struct iwl_fw_runtime *fwrt)
 		 * have profile 0).  So in the array we start from 1.
 		 */
 		ret = iwl_sar_set_profile(&wifi_pkg->package.elements[pos],
-					  &fwrt->sar_profiles[i + 1],
-					  enabled,
-					  ACPI_SAR_NUM_CHAINS,
-					  ACPI_SAR_NUM_SUB_BANDS);
+					  &fwrt->sar_profiles[i + 1], enabled,
+					  ACPI_SAR_NUM_CHAINS_REV0,
+					  ACPI_SAR_NUM_SUB_BANDS_REV0);
 		if (ret < 0)
 			break;
 
 		/* go to the next table */
-		pos += ACPI_SAR_NUM_CHAINS * ACPI_SAR_NUM_SUB_BANDS;
+		pos += ACPI_SAR_NUM_CHAINS_REV0 * ACPI_SAR_NUM_SUB_BANDS_REV0;
 	}
 
 out_free:
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.h b/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
index 245f0646c8f8..e49aec8e3946 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
@@ -32,14 +32,22 @@
 #define ACPI_NUM_GEO_PROFILES		3
 #define ACPI_GEO_PER_CHAIN_SIZE		3
 
-#define ACPI_SAR_NUM_CHAINS		2
-#define ACPI_SAR_NUM_SUB_BANDS		5
-
-#define ACPI_WRDS_WIFI_DATA_SIZE	(ACPI_SAR_NUM_CHAINS * \
-					 ACPI_SAR_NUM_SUB_BANDS + 2)
+#define ACPI_SAR_NUM_CHAINS_REV0	2
+#define ACPI_SAR_NUM_CHAINS_REV1	2
+#define ACPI_SAR_NUM_CHAINS_REV2	4
+#define ACPI_SAR_NUM_SUB_BANDS_REV0	5
+#define ACPI_SAR_NUM_SUB_BANDS_REV1	11
+#define ACPI_SAR_NUM_SUB_BANDS_REV2	11
+
+#define ACPI_WRDS_WIFI_DATA_SIZE_REV0	(ACPI_SAR_NUM_CHAINS_REV0 * \
+					 ACPI_SAR_NUM_SUB_BANDS_REV0 + 2)
+#define ACPI_WRDS_WIFI_DATA_SIZE_REV1	(ACPI_SAR_NUM_CHAINS_REV1 * \
+					 ACPI_SAR_NUM_SUB_BANDS_REV1 + 2)
+#define ACPI_WRDS_WIFI_DATA_SIZE_REV2	(ACPI_SAR_NUM_CHAINS_REV2 * \
+					 ACPI_SAR_NUM_SUB_BANDS_REV2 + 2)
 #define ACPI_EWRD_WIFI_DATA_SIZE	((ACPI_SAR_PROFILE_NUM - 1) * \
-					 ACPI_SAR_NUM_CHAINS * \
-					 ACPI_SAR_NUM_SUB_BANDS + 3)
+					 ACPI_SAR_NUM_CHAINS_REV0 * \
+					 ACPI_SAR_NUM_SUB_BANDS_REV0 + 3)
 #define ACPI_WGDS_WIFI_DATA_SIZE	19
 #define ACPI_WRDD_WIFI_DATA_SIZE	2
 #define ACPI_SPLC_WIFI_DATA_SIZE	2
@@ -64,13 +72,18 @@
 #define ACPI_PPAG_MIN_HB -16
 #define ACPI_PPAG_MAX_HB 40
 
+/*
+ * The profile for revision 2 is a superset of revision 1, which is in
+ * turn a superset of revision 0.  So we can store all revisions
+ * inside revision 2, which is what we represent here.
+ */
 struct iwl_sar_profile_chain {
-	u8 subbands[ACPI_SAR_NUM_SUB_BANDS];
+	u8 subbands[ACPI_SAR_NUM_SUB_BANDS_REV2];
 };
 
 struct iwl_sar_profile {
 	bool enabled;
-	struct iwl_sar_profile_chain chains[ACPI_SAR_NUM_CHAINS];
+	struct iwl_sar_profile_chain chains[ACPI_SAR_NUM_CHAINS_REV2];
 };
 
 struct iwl_geo_profile {
-- 
2.32.0

