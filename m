Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 985D53132BE
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Feb 2021 13:51:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbhBHMun (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 8 Feb 2021 07:50:43 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:44486 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230170AbhBHMuA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 8 Feb 2021 07:50:00 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1l95yH-0047PC-MU; Mon, 08 Feb 2021 14:48:54 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Mon,  8 Feb 2021 14:48:42 +0200
Message-Id: <iwlwifi.20210208144305.6c9fc281428c.I147373f6fd364606b0282af8d402c722eb917225@changeid>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210208124847.1934441-1-luca@coelho.fi>
References: <20210208124847.1934441-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 07/12] iwlwifi: acpi: don't return valid pointer as an ERR_PTR
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Haim Dreyfuss <haim.dreyfuss@intel.com>

iwl_acpi_get_wifi_pkg() may return a valid pointer (meaning success),
while `tbl_rev` is invalid (equel to 1).
In this case, we will treat that as an error.
Subsequent "users" of this "error code" may either check for nonzero
(good; pointers are never zero) or negative
(bad; pointers may be "positive") fix that by splitting the if statement.
First check if IS_ERR(wifi_pkg) and then if tbl_rev != 0.

Signed-off-by: Haim Dreyfuss <haim.dreyfuss@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c | 22 +++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
index 15248b064380..c2a287433036 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
@@ -443,11 +443,16 @@ int iwl_sar_get_wrds_table(struct iwl_fw_runtime *fwrt)
 
 	wifi_pkg = iwl_acpi_get_wifi_pkg(fwrt->dev, data,
 					 ACPI_WRDS_WIFI_DATA_SIZE, &tbl_rev);
-	if (IS_ERR(wifi_pkg) || tbl_rev != 0) {
+	if (IS_ERR(wifi_pkg)) {
 		ret = PTR_ERR(wifi_pkg);
 		goto out_free;
 	}
 
+	if (tbl_rev != 0) {
+		ret = -EINVAL;
+		goto out_free;
+	}
+
 	if (wifi_pkg->package.elements[1].type != ACPI_TYPE_INTEGER) {
 		ret = -EINVAL;
 		goto out_free;
@@ -481,11 +486,16 @@ int iwl_sar_get_ewrd_table(struct iwl_fw_runtime *fwrt)
 
 	wifi_pkg = iwl_acpi_get_wifi_pkg(fwrt->dev, data,
 					 ACPI_EWRD_WIFI_DATA_SIZE, &tbl_rev);
-	if (IS_ERR(wifi_pkg) || tbl_rev != 0) {
+	if (IS_ERR(wifi_pkg)) {
 		ret = PTR_ERR(wifi_pkg);
 		goto out_free;
 	}
 
+	if (tbl_rev != 0) {
+		ret = -EINVAL;
+		goto out_free;
+	}
+
 	if (wifi_pkg->package.elements[1].type != ACPI_TYPE_INTEGER ||
 	    wifi_pkg->package.elements[2].type != ACPI_TYPE_INTEGER) {
 		ret = -EINVAL;
@@ -541,11 +551,17 @@ int iwl_sar_get_wgds_table(struct iwl_fw_runtime *fwrt)
 
 	wifi_pkg = iwl_acpi_get_wifi_pkg(fwrt->dev, data,
 					 ACPI_WGDS_WIFI_DATA_SIZE, &tbl_rev);
-	if (IS_ERR(wifi_pkg) || tbl_rev > 1) {
+
+	if (IS_ERR(wifi_pkg)) {
 		ret = PTR_ERR(wifi_pkg);
 		goto out_free;
 	}
 
+	if (tbl_rev > 1) {
+		ret = -EINVAL;
+		goto out_free;
+	}
+
 	fwrt->geo_rev = tbl_rev;
 	for (i = 0; i < ACPI_NUM_GEO_PROFILES; i++) {
 		for (j = 0; j < ACPI_GEO_TABLE_SIZE; j++) {
-- 
2.30.0

