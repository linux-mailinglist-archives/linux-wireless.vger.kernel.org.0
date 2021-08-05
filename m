Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AE363E13CA
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Aug 2021 13:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240992AbhHELWb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 Aug 2021 07:22:31 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:51344 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S241044AbhHELWa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 Aug 2021 07:22:30 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1mBbRy-00243p-8X; Thu, 05 Aug 2021 14:22:11 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Thu,  5 Aug 2021 14:21:58 +0300
Message-Id: <iwlwifi.20210805141826.78e441b16f9c.I2d79492f05624ddd02c533c673811a36eaf8a396@changeid>
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
Subject: [PATCH 12/12] iwlwifi: acpi: support reading and storing WGDS revision 2
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

Revisions 0 and 1 are identical, so we were already supporting that.
But revision 2 has a different size, so we have to try to read them
separately.

Add support for this new revision.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c | 38 +++++++++++++++-----
 drivers/net/wireless/intel/iwlwifi/fw/acpi.h | 19 ++++++----
 2 files changed, 43 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
index 1802a451c450..de1e9271dcd2 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
@@ -703,27 +703,49 @@ int iwl_sar_get_wgds_table(struct iwl_fw_runtime *fwrt)
 	union acpi_object *wifi_pkg, *data;
 	int i, j, k, ret, tbl_rev;
 	int idx = 1; /* start from one to skip the domain */
+	u8 num_bands;
 
 	data = iwl_acpi_get_object(fwrt->dev, ACPI_WGDS_METHOD);
 	if (IS_ERR(data))
 		return PTR_ERR(data);
 
+	/* start by trying to read revision 2 */
 	wifi_pkg = iwl_acpi_get_wifi_pkg(fwrt->dev, data,
-					 ACPI_WGDS_WIFI_DATA_SIZE, &tbl_rev);
+					 ACPI_WGDS_WIFI_DATA_SIZE_REV2,
+					 &tbl_rev);
+	if (!IS_ERR(wifi_pkg)) {
+		if (tbl_rev != 2) {
+			ret = PTR_ERR(wifi_pkg);
+			goto out_free;
+		}
 
-	if (IS_ERR(wifi_pkg)) {
-		ret = PTR_ERR(wifi_pkg);
-		goto out_free;
+		num_bands = ACPI_GEO_NUM_BANDS_REV2;
+
+		goto read_table;
 	}
 
-	if (tbl_rev > 1) {
-		ret = -EINVAL;
-		goto out_free;
+	/* then try revision 0 (which is the same as 1) */
+	wifi_pkg = iwl_acpi_get_wifi_pkg(fwrt->dev, data,
+					 ACPI_WGDS_WIFI_DATA_SIZE_REV0,
+					 &tbl_rev);
+	if (!IS_ERR(wifi_pkg)) {
+		if (tbl_rev != 0 && tbl_rev != 1) {
+			ret = PTR_ERR(wifi_pkg);
+			goto out_free;
+		}
+
+		num_bands = ACPI_GEO_NUM_BANDS_REV0;
+
+		goto read_table;
 	}
 
+	ret = PTR_ERR(wifi_pkg);
+	goto out_free;
+
+read_table:
 	fwrt->geo_rev = tbl_rev;
 	for (i = 0; i < ACPI_NUM_GEO_PROFILES; i++) {
-		for (j = 0; j < ACPI_GEO_NUM_BANDS_REV0; j++) {
+		for (j = 0; j < num_bands; j++) {
 			union acpi_object *entry;
 
 			entry = &wifi_pkg->package.elements[idx++];
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.h b/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
index a424186af3c8..16ed0995b51e 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
@@ -38,11 +38,6 @@
 #define ACPI_SAR_NUM_SUB_BANDS_REV1	11
 #define ACPI_SAR_NUM_SUB_BANDS_REV2	11
 
-#define ACPI_GEO_NUM_CHAINS		2
-#define ACPI_GEO_NUM_BANDS_REV0		2
-#define ACPI_GEO_NUM_BANDS_REV1		2
-#define ACPI_GEO_NUM_BANDS_REV2		3
-
 #define ACPI_WRDS_WIFI_DATA_SIZE_REV0	(ACPI_SAR_NUM_CHAINS_REV0 * \
 					 ACPI_SAR_NUM_SUB_BANDS_REV0 + 2)
 #define ACPI_WRDS_WIFI_DATA_SIZE_REV1	(ACPI_SAR_NUM_CHAINS_REV1 * \
@@ -58,7 +53,19 @@
 #define ACPI_EWRD_WIFI_DATA_SIZE_REV2	((ACPI_SAR_PROFILE_NUM - 1) * \
 					 ACPI_SAR_NUM_CHAINS_REV2 * \
 					 ACPI_SAR_NUM_SUB_BANDS_REV2 + 3)
-#define ACPI_WGDS_WIFI_DATA_SIZE	19
+
+/* revision 0 and 1 are identical, except for the semantics in the FW */
+#define ACPI_GEO_NUM_BANDS_REV0		2
+#define ACPI_GEO_NUM_BANDS_REV2		3
+#define ACPI_GEO_NUM_CHAINS		2
+
+#define ACPI_WGDS_WIFI_DATA_SIZE_REV0	(ACPI_NUM_GEO_PROFILES *   \
+					 ACPI_GEO_NUM_BANDS_REV0 * \
+					 ACPI_GEO_PER_CHAIN_SIZE + 1)
+#define ACPI_WGDS_WIFI_DATA_SIZE_REV2	(ACPI_NUM_GEO_PROFILES *   \
+					 ACPI_GEO_NUM_BANDS_REV2 * \
+					 ACPI_GEO_PER_CHAIN_SIZE + 1)
+
 #define ACPI_WRDD_WIFI_DATA_SIZE	2
 #define ACPI_SPLC_WIFI_DATA_SIZE	2
 #define ACPI_ECKV_WIFI_DATA_SIZE	2
-- 
2.32.0

