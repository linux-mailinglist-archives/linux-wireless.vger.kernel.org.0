Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53889CBB5E
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Oct 2019 15:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388304AbfJDNOX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 4 Oct 2019 09:14:23 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:46560 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388186AbfJDNOW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 4 Oct 2019 09:14:22 -0400
Received: from [91.156.6.193] (helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1iGNPY-0000l2-Ug; Fri, 04 Oct 2019 16:14:21 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Fri,  4 Oct 2019 16:14:08 +0300
Message-Id: <20191004131414.27372-3-luca@coelho.fi>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191004131414.27372-1-luca@coelho.fi>
References: <20191004131414.27372-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=ham autolearn_force=no version=3.4.2
Subject: [PATCH 2/8] iwlwifi: fix ACPI table revision checks
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

We can't check for the ACPI table revision validity in the same if
where we check if the package was read correctly, because we return
PTR_ERR(pkg) and if the table is not valid but the pointer is, we
would return a valid pointer as an error.  Fix that by moving the
table checks to a separate if and return -EINVAL if it's not valid.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c | 10 ++++----
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c  | 24 +++++++++++++++-----
 2 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
index 7573af2d88ce..c2db758b9d54 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
@@ -162,12 +162,13 @@ int iwl_acpi_get_mcc(struct device *dev, char *mcc)
 
 	wifi_pkg = iwl_acpi_get_wifi_pkg(dev, data, ACPI_WRDD_WIFI_DATA_SIZE,
 					 &tbl_rev);
-	if (IS_ERR(wifi_pkg) || tbl_rev != 0) {
+	if (IS_ERR(wifi_pkg)) {
 		ret = PTR_ERR(wifi_pkg);
 		goto out_free;
 	}
 
-	if (wifi_pkg->package.elements[1].type != ACPI_TYPE_INTEGER) {
+	if (wifi_pkg->package.elements[1].type != ACPI_TYPE_INTEGER ||
+	    tbl_rev != 0) {
 		ret = -EINVAL;
 		goto out_free;
 	}
@@ -224,12 +225,13 @@ int iwl_acpi_get_eckv(struct device *dev, u32 *extl_clk)
 
 	wifi_pkg = iwl_acpi_get_wifi_pkg(dev, data, ACPI_ECKV_WIFI_DATA_SIZE,
 					 &tbl_rev);
-	if (IS_ERR(wifi_pkg) || tbl_rev != 0) {
+	if (IS_ERR(wifi_pkg)) {
 		ret = PTR_ERR(wifi_pkg);
 		goto out_free;
 	}
 
-	if (wifi_pkg->package.elements[1].type != ACPI_TYPE_INTEGER) {
+	if (wifi_pkg->package.elements[1].type != ACPI_TYPE_INTEGER ||
+	    tbl_rev != 0) {
 		ret = -EINVAL;
 		goto out_free;
 	}
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 32a5e4e5461f..b2eb18eedf02 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -694,12 +694,13 @@ static int iwl_mvm_sar_get_wrds_table(struct iwl_mvm *mvm)
 
 	wifi_pkg = iwl_acpi_get_wifi_pkg(mvm->dev, data,
 					 ACPI_WRDS_WIFI_DATA_SIZE, &tbl_rev);
-	if (IS_ERR(wifi_pkg) || tbl_rev != 0) {
+	if (IS_ERR(wifi_pkg)) {
 		ret = PTR_ERR(wifi_pkg);
 		goto out_free;
 	}
 
-	if (wifi_pkg->package.elements[1].type != ACPI_TYPE_INTEGER) {
+	if (wifi_pkg->package.elements[1].type != ACPI_TYPE_INTEGER ||
+	    tbl_rev != 0) {
 		ret = -EINVAL;
 		goto out_free;
 	}
@@ -731,13 +732,14 @@ static int iwl_mvm_sar_get_ewrd_table(struct iwl_mvm *mvm)
 
 	wifi_pkg = iwl_acpi_get_wifi_pkg(mvm->dev, data,
 					 ACPI_EWRD_WIFI_DATA_SIZE, &tbl_rev);
-	if (IS_ERR(wifi_pkg) || tbl_rev != 0) {
+	if (IS_ERR(wifi_pkg)) {
 		ret = PTR_ERR(wifi_pkg);
 		goto out_free;
 	}
 
 	if ((wifi_pkg->package.elements[1].type != ACPI_TYPE_INTEGER) ||
-	    (wifi_pkg->package.elements[2].type != ACPI_TYPE_INTEGER)) {
+	    (wifi_pkg->package.elements[2].type != ACPI_TYPE_INTEGER) ||
+	    tbl_rev != 0) {
 		ret = -EINVAL;
 		goto out_free;
 	}
@@ -791,11 +793,16 @@ static int iwl_mvm_sar_get_wgds_table(struct iwl_mvm *mvm)
 
 	wifi_pkg = iwl_acpi_get_wifi_pkg(mvm->dev, data,
 					 ACPI_WGDS_WIFI_DATA_SIZE, &tbl_rev);
-	if (IS_ERR(wifi_pkg) || tbl_rev > 1) {
+	if (IS_ERR(wifi_pkg)) {
 		ret = PTR_ERR(wifi_pkg);
 		goto out_free;
 	}
 
+	if (tbl_rev != 0) {
+		ret = -EINVAL;
+		goto out_free;
+	}
+
 	mvm->geo_rev = tbl_rev;
 	for (i = 0; i < ACPI_NUM_GEO_PROFILES; i++) {
 		for (j = 0; j < ACPI_GEO_TABLE_SIZE; j++) {
@@ -1020,11 +1027,16 @@ static int iwl_mvm_get_ppag_table(struct iwl_mvm *mvm)
 	wifi_pkg = iwl_acpi_get_wifi_pkg(mvm->dev, data,
 					 ACPI_PPAG_WIFI_DATA_SIZE, &tbl_rev);
 
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
 	enabled = &wifi_pkg->package.elements[1];
 	if (enabled->type != ACPI_TYPE_INTEGER ||
 	    (enabled->integer.value != 0 && enabled->integer.value != 1)) {
-- 
2.23.0

