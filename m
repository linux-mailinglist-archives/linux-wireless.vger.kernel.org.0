Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EC3F279393
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Sep 2020 23:31:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbgIYVbH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 25 Sep 2020 17:31:07 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:52344 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728949AbgIYVbF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 25 Sep 2020 17:31:05 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kLvJ1-002J1P-Kp; Sat, 26 Sep 2020 00:31:04 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sat, 26 Sep 2020 00:30:47 +0300
Message-Id: <iwlwifi.20200926002540.6449efabcb8b.I030fa71253260f34b588951d78170551b633c046@changeid>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200925213053.454459-1-luca@coelho.fi>
References: <20200925213053.454459-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 09/15] iwlwifi: don't export acpi functions unnecessarily
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

A couple of functions were exported from the acpi.c file
unnecessarily, since they are only used internally in that file.  Make
them static.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c | 11 +++++------
 drivers/net/wireless/intel/iwlwifi/fw/acpi.h |  7 -------
 2 files changed, 5 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
index dc769b580431..b14260e303b7 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
@@ -118,8 +118,8 @@ IWL_EXPORT_SYMBOL(iwl_acpi_get_object);
 * method (DSM) interface. The returned acpi object must be freed by calling
 * function.
 */
-void *iwl_acpi_get_dsm_object(struct device *dev, int rev, int func,
-			      union acpi_object *args)
+static void *iwl_acpi_get_dsm_object(struct device *dev, int rev, int func,
+				     union acpi_object *args)
 {
 	union acpi_object *obj;
 
@@ -400,9 +400,9 @@ int iwl_acpi_get_eckv(struct device *dev, u32 *extl_clk)
 }
 IWL_EXPORT_SYMBOL(iwl_acpi_get_eckv);
 
-int iwl_sar_set_profile(union acpi_object *table,
-			struct iwl_sar_profile *profile,
-			bool enabled)
+static int iwl_sar_set_profile(union acpi_object *table,
+			       struct iwl_sar_profile *profile,
+			       bool enabled)
 {
 	int i;
 
@@ -418,7 +418,6 @@ int iwl_sar_set_profile(union acpi_object *table,
 
 	return 0;
 }
-IWL_EXPORT_SYMBOL(iwl_sar_set_profile);
 
 int iwl_sar_select_profile(struct iwl_fw_runtime *fwrt,
 			   __le16 per_chain_restriction[][IWL_NUM_SUB_BANDS],
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.h b/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
index c01b79736d7c..39e6be21158d 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
@@ -153,9 +153,6 @@ struct iwl_fw_runtime;
 
 void *iwl_acpi_get_object(struct device *dev, acpi_string method);
 
-void *iwl_acpi_get_dsm_object(struct device *dev, int rev, int func,
-			      union acpi_object *args);
-
 int iwl_acpi_get_dsm_u8(struct device *dev, int rev, int func);
 
 union acpi_object *iwl_acpi_get_wifi_pkg(struct device *dev,
@@ -185,10 +182,6 @@ u64 iwl_acpi_get_pwr_limit(struct device *dev);
  */
 int iwl_acpi_get_eckv(struct device *dev, u32 *extl_clk);
 
-int iwl_sar_set_profile(union acpi_object *table,
-			struct iwl_sar_profile *profile,
-			bool enabled);
-
 int iwl_sar_select_profile(struct iwl_fw_runtime *fwrt,
 			   __le16 per_chain_restriction[][IWL_NUM_SUB_BANDS],
 			   int prof_a, int prof_b);
-- 
2.28.0

