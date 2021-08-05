Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3681D3E13C1
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Aug 2021 13:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241013AbhHELWT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 Aug 2021 07:22:19 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:51290 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S241004AbhHELWT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 Aug 2021 07:22:19 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1mBbRq-00243p-Kj; Thu, 05 Aug 2021 14:22:04 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Thu,  5 Aug 2021 14:21:49 +0300
Message-Id: <iwlwifi.20210805141826.2d5494de683c.Ia024b1368873d488906a639e29454cbbdc788d03@changeid>
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
Subject: [PATCH 03/12] iwlwifi: support reading and storing EWRD revisions 1 and 2
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

As an extension to the WRDS support for revisions 1 and 2, do the same
for the EWRD tables.  These tables have a very similar format to the
WRDS table, so most of the code is similar.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c | 60 ++++++++++++++++----
 drivers/net/wireless/intel/iwlwifi/fw/acpi.h |  8 ++-
 2 files changed, 57 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
index d4e7e303b190..c31c212996fa 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
@@ -596,23 +596,64 @@ int iwl_sar_get_ewrd_table(struct iwl_fw_runtime *fwrt)
 	bool enabled;
 	int i, n_profiles, tbl_rev, pos;
 	int ret = 0;
+	u8 num_chains, num_sub_bands;
 
 	data = iwl_acpi_get_object(fwrt->dev, ACPI_EWRD_METHOD);
 	if (IS_ERR(data))
 		return PTR_ERR(data);
 
+	/* start by trying to read revision 2 */
 	wifi_pkg = iwl_acpi_get_wifi_pkg(fwrt->dev, data,
-					 ACPI_EWRD_WIFI_DATA_SIZE, &tbl_rev);
-	if (IS_ERR(wifi_pkg)) {
-		ret = PTR_ERR(wifi_pkg);
-		goto out_free;
+					 ACPI_EWRD_WIFI_DATA_SIZE_REV2,
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
+					 ACPI_EWRD_WIFI_DATA_SIZE_REV1,
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
+					 ACPI_EWRD_WIFI_DATA_SIZE_REV0,
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
 	if (wifi_pkg->package.elements[1].type != ACPI_TYPE_INTEGER ||
 	    wifi_pkg->package.elements[2].type != ACPI_TYPE_INTEGER) {
 		ret = -EINVAL;
@@ -642,13 +683,12 @@ int iwl_sar_get_ewrd_table(struct iwl_fw_runtime *fwrt)
 		 */
 		ret = iwl_sar_set_profile(&wifi_pkg->package.elements[pos],
 					  &fwrt->sar_profiles[i + 1], enabled,
-					  ACPI_SAR_NUM_CHAINS_REV0,
-					  ACPI_SAR_NUM_SUB_BANDS_REV0);
+					  num_chains, num_sub_bands);
 		if (ret < 0)
 			break;
 
 		/* go to the next table */
-		pos += ACPI_SAR_NUM_CHAINS_REV0 * ACPI_SAR_NUM_SUB_BANDS_REV0;
+		pos += num_chains * num_sub_bands;
 	}
 
 out_free:
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.h b/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
index e49aec8e3946..2d98f7e903e7 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
@@ -45,9 +45,15 @@
 					 ACPI_SAR_NUM_SUB_BANDS_REV1 + 2)
 #define ACPI_WRDS_WIFI_DATA_SIZE_REV2	(ACPI_SAR_NUM_CHAINS_REV2 * \
 					 ACPI_SAR_NUM_SUB_BANDS_REV2 + 2)
-#define ACPI_EWRD_WIFI_DATA_SIZE	((ACPI_SAR_PROFILE_NUM - 1) * \
+#define ACPI_EWRD_WIFI_DATA_SIZE_REV0	((ACPI_SAR_PROFILE_NUM - 1) * \
 					 ACPI_SAR_NUM_CHAINS_REV0 * \
 					 ACPI_SAR_NUM_SUB_BANDS_REV0 + 3)
+#define ACPI_EWRD_WIFI_DATA_SIZE_REV1	((ACPI_SAR_PROFILE_NUM - 1) * \
+					 ACPI_SAR_NUM_CHAINS_REV1 * \
+					 ACPI_SAR_NUM_SUB_BANDS_REV1 + 3)
+#define ACPI_EWRD_WIFI_DATA_SIZE_REV2	((ACPI_SAR_PROFILE_NUM - 1) * \
+					 ACPI_SAR_NUM_CHAINS_REV2 * \
+					 ACPI_SAR_NUM_SUB_BANDS_REV2 + 3)
 #define ACPI_WGDS_WIFI_DATA_SIZE	19
 #define ACPI_WRDD_WIFI_DATA_SIZE	2
 #define ACPI_SPLC_WIFI_DATA_SIZE	2
-- 
2.32.0

