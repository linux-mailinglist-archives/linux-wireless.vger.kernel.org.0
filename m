Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BD6C3E13BF
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Aug 2021 13:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241000AbhHELWR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 Aug 2021 07:22:17 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:51278 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S240955AbhHELWR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 Aug 2021 07:22:17 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1mBbRo-00243p-Gw; Thu, 05 Aug 2021 14:22:02 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Thu,  5 Aug 2021 14:21:47 +0300
Message-Id: <iwlwifi.20210805141826.905b54c398f8.I9bac8c3bc3b1b6bbe813de53746daee33e53fc86@changeid>
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
Subject: [PATCH 01/12] iwlwifi: pass number of chains and sub-bands to iwl_sar_set_profile()
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

The number of chains and sub-bands read from the ACPI tables varies
depending on the revision.  Pass these numbers to the
iwl_sar_set_profile() function in order to make using different
revisions easier.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
index f20f0150f407..9175f53806bf 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
@@ -412,7 +412,7 @@ IWL_EXPORT_SYMBOL(iwl_acpi_get_eckv);
 
 static int iwl_sar_set_profile(union acpi_object *table,
 			       struct iwl_sar_profile *profile,
-			       bool enabled)
+			       bool enabled, u8 num_chains, u8 num_sub_bands)
 {
 	int i, j, idx = 0;
 
@@ -422,8 +422,8 @@ static int iwl_sar_set_profile(union acpi_object *table,
 	 * The table from ACPI is flat, but we store it in a
 	 * structured array.
 	 */
-	for (i = 0; i < ACPI_SAR_NUM_CHAINS; i++) {
-		for (j = 0; j < ACPI_SAR_NUM_SUB_BANDS; j++) {
+	for (i = 0; i < num_chains; i++) {
+		for (j = 0; j < num_sub_bands; j++) {
 			if (table[idx].type != ACPI_TYPE_INTEGER ||
 			    table[idx].integer.value > U8_MAX)
 				return -EINVAL;
@@ -539,7 +539,8 @@ int iwl_sar_get_wrds_table(struct iwl_fw_runtime *fwrt)
 	/* The profile from WRDS is officially profile 1, but goes
 	 * into sar_profiles[0] (because we don't have a profile 0).
 	 */
-	ret = iwl_sar_set_profile(table, &fwrt->sar_profiles[0], enabled);
+	ret = iwl_sar_set_profile(table, &fwrt->sar_profiles[0], enabled,
+				  ACPI_SAR_NUM_CHAINS, ACPI_SAR_NUM_SUB_BANDS);
 out_free:
 	kfree(data);
 	return ret;
@@ -598,7 +599,9 @@ int iwl_sar_get_ewrd_table(struct iwl_fw_runtime *fwrt)
 		 */
 		ret = iwl_sar_set_profile(&wifi_pkg->package.elements[pos],
 					  &fwrt->sar_profiles[i + 1],
-					  enabled);
+					  enabled,
+					  ACPI_SAR_NUM_CHAINS,
+					  ACPI_SAR_NUM_SUB_BANDS);
 		if (ret < 0)
 			break;
 
-- 
2.32.0

