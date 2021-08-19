Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28BD13F1CFF
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Aug 2021 17:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240508AbhHSPlT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Aug 2021 11:41:19 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:56902 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S240533AbhHSPlS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Aug 2021 11:41:18 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1mGk9n-002Hje-Jz; Thu, 19 Aug 2021 18:40:41 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Thu, 19 Aug 2021 18:40:27 +0300
Message-Id: <iwlwifi.20210819183728.7fb9716db7ba.I75541846e0720f80695186ba39398133c8758280@changeid>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210819154035.72584-1-luca@coelho.fi>
References: <20210819154035.72584-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: [PATCH 03/11] iwlwifi: acpi: fill in SAR tables with defaults
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

If the tables we get in the iwl_sar_set_profile() is smaller than the
revision we support, we need to fill the values with 0.  Make sure
that's the case.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c | 21 ++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
index 37da836a8c08..1efac0b2a94d 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
@@ -420,16 +420,21 @@ static int iwl_sar_set_profile(union acpi_object *table,
 	 * The table from ACPI is flat, but we store it in a
 	 * structured array.
 	 */
-	for (i = 0; i < num_chains; i++) {
-		for (j = 0; j < num_sub_bands; j++) {
-			if (table[idx].type != ACPI_TYPE_INTEGER ||
-			    table[idx].integer.value > U8_MAX)
-				return -EINVAL;
+	for (i = 0; i < ACPI_SAR_NUM_CHAINS_REV2; i++) {
+		for (j = 0; j < ACPI_SAR_NUM_SUB_BANDS_REV2; j++) {
+			/* if we don't have the values, use the default */
+			if (i >= num_chains || j >= num_sub_bands) {
+				profile->chains[i].subbands[j] = 0;
+			} else {
+				if (table[idx].type != ACPI_TYPE_INTEGER ||
+				    table[idx].integer.value > U8_MAX)
+					return -EINVAL;
 
-			profile->chains[i].subbands[j] =
-				table[idx].integer.value;
+				profile->chains[i].subbands[j] =
+					table[idx].integer.value;
 
-			idx++;
+				idx++;
+			}
 		}
 	}
 
-- 
2.33.0

