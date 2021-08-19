Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4B3B3F1CFE
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Aug 2021 17:40:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240487AbhHSPlS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Aug 2021 11:41:18 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:56896 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S240526AbhHSPlR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Aug 2021 11:41:17 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1mGk9m-002Hje-8C; Thu, 19 Aug 2021 18:40:40 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Thu, 19 Aug 2021 18:40:26 +0300
Message-Id: <iwlwifi.20210819183728.01b12461a30b.I08d1f9154f26eca25c44616efdb5223bcc1935f3@changeid>
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
Subject: [PATCH 02/11] iwlwifi: acpi: fill in WGDS table with defaults
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

The tables we store are the larger of all the revisions, so we need to
fill in the values that we don't get from ACPI when using older
revisions.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c | 42 ++++++++++++++------
 1 file changed, 29 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
index de1e9271dcd2..37da836a8c08 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
@@ -745,20 +745,18 @@ int iwl_sar_get_wgds_table(struct iwl_fw_runtime *fwrt)
 read_table:
 	fwrt->geo_rev = tbl_rev;
 	for (i = 0; i < ACPI_NUM_GEO_PROFILES; i++) {
-		for (j = 0; j < num_bands; j++) {
+		for (j = 0; j < ACPI_GEO_NUM_BANDS_REV2; j++) {
 			union acpi_object *entry;
 
-			entry = &wifi_pkg->package.elements[idx++];
-			if (entry->type != ACPI_TYPE_INTEGER ||
-			    entry->integer.value > U8_MAX) {
-				ret = -EINVAL;
-				goto out_free;
-			}
-
-			fwrt->geo_profiles[i].bands[j].max =
-				entry->integer.value;
-
-			for (k = 0; k < ACPI_GEO_NUM_CHAINS; k++) {
+			/*
+			 * num_bands is either 2 or 3, if it's only 2 then
+			 * fill the third band (6 GHz) with the values from
+			 * 5 GHz (second band)
+			 */
+			if (j >= num_bands) {
+				fwrt->geo_profiles[i].bands[j].max =
+					fwrt->geo_profiles[i].bands[1].max;
+			} else {
 				entry = &wifi_pkg->package.elements[idx++];
 				if (entry->type != ACPI_TYPE_INTEGER ||
 				    entry->integer.value > U8_MAX) {
@@ -766,9 +764,27 @@ int iwl_sar_get_wgds_table(struct iwl_fw_runtime *fwrt)
 					goto out_free;
 				}
 
-				fwrt->geo_profiles[i].bands[j].chains[k] =
+				fwrt->geo_profiles[i].bands[j].max =
 					entry->integer.value;
 			}
+
+			for (k = 0; k < ACPI_GEO_NUM_CHAINS; k++) {
+				/* same here as above */
+				if (j >= num_bands) {
+					fwrt->geo_profiles[i].bands[j].chains[k] =
+						fwrt->geo_profiles[i].bands[1].chains[k];
+				} else {
+					entry = &wifi_pkg->package.elements[idx++];
+					if (entry->type != ACPI_TYPE_INTEGER ||
+					    entry->integer.value > U8_MAX) {
+						ret = -EINVAL;
+						goto out_free;
+					}
+
+					fwrt->geo_profiles[i].bands[j].chains[k] =
+						entry->integer.value;
+				}
+			}
 		}
 	}
 
-- 
2.33.0

