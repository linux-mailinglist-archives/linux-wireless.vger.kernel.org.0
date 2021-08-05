Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C4BB3E13C5
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Aug 2021 13:22:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241026AbhHELWX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 Aug 2021 07:22:23 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:51312 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S241021AbhHELWW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 Aug 2021 07:22:22 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1mBbRt-00243p-V8; Thu, 05 Aug 2021 14:22:07 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Thu,  5 Aug 2021 14:21:53 +0300
Message-Id: <iwlwifi.20210805141826.ff8148197b15.I70636c04e37b2b57a5df3ce611511f62203d27a7@changeid>
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
Subject: [PATCH 07/12] iwlwifi: skip first element in the WTAS ACPI table
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Abhishek Naik <abhishek.naik@intel.com>

By mistake we were considering the first element of the WTAS wifi
package as part of the data we want to rid, but that element is the wifi
package signature (always 0x07), so it should be skipped.

Change the code to read the data starting from element 1 instead.

Signed-off-by: Abhishek Naik <abhishek.naik@intel.com>
Fixes: 28dd7ccdc56f ("iwlwifi: acpi: read TAS table from ACPI and send it to the FW")
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
index 3d2962260665..78f0f2032c59 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
@@ -264,7 +264,7 @@ int iwl_acpi_get_tas(struct iwl_fw_runtime *fwrt,
 		goto out_free;
 	}
 
-	enabled = !!wifi_pkg->package.elements[0].integer.value;
+	enabled = !!wifi_pkg->package.elements[1].integer.value;
 
 	if (!enabled) {
 		*block_list_size = -1;
@@ -273,15 +273,15 @@ int iwl_acpi_get_tas(struct iwl_fw_runtime *fwrt,
 		goto out_free;
 	}
 
-	if (wifi_pkg->package.elements[1].type != ACPI_TYPE_INTEGER ||
-	    wifi_pkg->package.elements[1].integer.value >
+	if (wifi_pkg->package.elements[2].type != ACPI_TYPE_INTEGER ||
+	    wifi_pkg->package.elements[2].integer.value >
 	    APCI_WTAS_BLACK_LIST_MAX) {
 		IWL_DEBUG_RADIO(fwrt, "TAS invalid array size %llu\n",
 				wifi_pkg->package.elements[1].integer.value);
 		ret = -EINVAL;
 		goto out_free;
 	}
-	*block_list_size = wifi_pkg->package.elements[1].integer.value;
+	*block_list_size = wifi_pkg->package.elements[2].integer.value;
 
 	IWL_DEBUG_RADIO(fwrt, "TAS array size %d\n", *block_list_size);
 	if (*block_list_size > APCI_WTAS_BLACK_LIST_MAX) {
@@ -294,15 +294,15 @@ int iwl_acpi_get_tas(struct iwl_fw_runtime *fwrt,
 	for (i = 0; i < *block_list_size; i++) {
 		u32 country;
 
-		if (wifi_pkg->package.elements[2 + i].type !=
+		if (wifi_pkg->package.elements[3 + i].type !=
 		    ACPI_TYPE_INTEGER) {
 			IWL_DEBUG_RADIO(fwrt,
-					"TAS invalid array elem %d\n", 2 + i);
+					"TAS invalid array elem %d\n", 3 + i);
 			ret = -EINVAL;
 			goto out_free;
 		}
 
-		country = wifi_pkg->package.elements[2 + i].integer.value;
+		country = wifi_pkg->package.elements[3 + i].integer.value;
 		block_list_array[i] = cpu_to_le32(country);
 		IWL_DEBUG_RADIO(fwrt, "TAS block list country %d\n", country);
 	}
-- 
2.32.0

