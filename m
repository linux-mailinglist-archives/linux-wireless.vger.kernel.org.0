Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20EC33E129D
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Aug 2021 12:26:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240299AbhHEK0S (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 Aug 2021 06:26:18 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:51266 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S240339AbhHEK0R (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 Aug 2021 06:26:17 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1mBaTZ-00240Q-J8; Thu, 05 Aug 2021 13:19:47 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Thu,  5 Aug 2021 13:19:33 +0300
Message-Id: <iwlwifi.20210805130823.01530088097f.I903c236a574c7e4c0fc4db101fc39c0f5415ca43@changeid>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210805101934.431479-1-luca@coelho.fi>
References: <20210805101934.431479-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: [PATCH 11/12] iwlwifi: convert flat SAR profile table to a struct version
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

The SAR profiles have been stored in single-dimension arrays and the
access has been done via a single index.  We will soon need to support
different revisions of this table, which will make the flat array even
harder to handle.  To prepare for that, convert the single-dimension
array to a struct with substructures.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c | 30 +++++++++++++-------
 drivers/net/wireless/intel/iwlwifi/fw/acpi.h | 13 ++++++---
 2 files changed, 28 insertions(+), 15 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
index dff792653a24..f20f0150f407 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
@@ -414,16 +414,25 @@ static int iwl_sar_set_profile(union acpi_object *table,
 			       struct iwl_sar_profile *profile,
 			       bool enabled)
 {
-	int i;
+	int i, j, idx = 0;
 
 	profile->enabled = enabled;
 
-	for (i = 0; i < ACPI_SAR_TABLE_SIZE; i++) {
-		if (table[i].type != ACPI_TYPE_INTEGER ||
-		    table[i].integer.value > U8_MAX)
-			return -EINVAL;
+	/*
+	 * The table from ACPI is flat, but we store it in a
+	 * structured array.
+	 */
+	for (i = 0; i < ACPI_SAR_NUM_CHAINS; i++) {
+		for (j = 0; j < ACPI_SAR_NUM_SUB_BANDS; j++) {
+			if (table[idx].type != ACPI_TYPE_INTEGER ||
+			    table[idx].integer.value > U8_MAX)
+				return -EINVAL;
+
+			profile->chains[i].subbands[j] =
+				table[idx].integer.value;
 
-		profile->table[i] = table[i].integer.value;
+			idx++;
+		}
 	}
 
 	return 0;
@@ -434,7 +443,7 @@ static int iwl_sar_fill_table(struct iwl_fw_runtime *fwrt,
 			      int prof_a, int prof_b)
 {
 	int profs[ACPI_SAR_NUM_CHAINS] = { prof_a, prof_b };
-	int i, j, idx;
+	int i, j;
 
 	for (i = 0; i < ACPI_SAR_NUM_CHAINS; i++) {
 		struct iwl_sar_profile *prof;
@@ -467,11 +476,10 @@ static int iwl_sar_fill_table(struct iwl_fw_runtime *fwrt,
 			       i, profs[i]);
 		IWL_DEBUG_RADIO(fwrt, "  Chain[%d]:\n", i);
 		for (j = 0; j < n_subbands; j++) {
-			idx = i * ACPI_SAR_NUM_SUB_BANDS + j;
 			per_chain[i * n_subbands + j] =
-				cpu_to_le16(prof->table[idx]);
+				cpu_to_le16(prof->chains[i].subbands[j]);
 			IWL_DEBUG_RADIO(fwrt, "    Band[%d] = %d * .125dBm\n",
-					j, prof->table[idx]);
+					j, prof->chains[i].subbands[j]);
 		}
 	}
 
@@ -595,7 +603,7 @@ int iwl_sar_get_ewrd_table(struct iwl_fw_runtime *fwrt)
 			break;
 
 		/* go to the next table */
-		pos += ACPI_SAR_TABLE_SIZE;
+		pos += ACPI_SAR_NUM_CHAINS * ACPI_SAR_NUM_SUB_BANDS;
 	}
 
 out_free:
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.h b/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
index 24e94430e5d9..cd26a155baf7 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
@@ -26,7 +26,6 @@
 
 #define ACPI_WIFI_DOMAIN	(0x07)
 
-#define ACPI_SAR_TABLE_SIZE		10
 #define ACPI_SAR_PROFILE_NUM		4
 
 #define ACPI_GEO_TABLE_SIZE		6
@@ -37,9 +36,11 @@
 #define ACPI_SAR_NUM_SUB_BANDS		5
 #define ACPI_SAR_NUM_TABLES		1
 
-#define ACPI_WRDS_WIFI_DATA_SIZE	(ACPI_SAR_TABLE_SIZE + 2)
+#define ACPI_WRDS_WIFI_DATA_SIZE	(ACPI_SAR_NUM_CHAINS * \
+					 ACPI_SAR_NUM_SUB_BANDS + 2)
 #define ACPI_EWRD_WIFI_DATA_SIZE	((ACPI_SAR_PROFILE_NUM - 1) * \
-					 ACPI_SAR_TABLE_SIZE + 3)
+					 ACPI_SAR_NUM_CHAINS * \
+					 ACPI_SAR_NUM_SUB_BANDS + 3)
 #define ACPI_WGDS_WIFI_DATA_SIZE	19
 #define ACPI_WRDD_WIFI_DATA_SIZE	2
 #define ACPI_SPLC_WIFI_DATA_SIZE	2
@@ -64,9 +65,13 @@
 #define ACPI_PPAG_MIN_HB -16
 #define ACPI_PPAG_MAX_HB 40
 
+struct iwl_sar_profile_chain {
+	u8 subbands[ACPI_SAR_NUM_SUB_BANDS];
+};
+
 struct iwl_sar_profile {
 	bool enabled;
-	u8 table[ACPI_SAR_TABLE_SIZE];
+	struct iwl_sar_profile_chain chains[ACPI_SAR_NUM_CHAINS];
 };
 
 struct iwl_geo_profile {
-- 
2.32.0

