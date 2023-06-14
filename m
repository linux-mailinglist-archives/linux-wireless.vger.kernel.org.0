Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AF6972F992
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Jun 2023 11:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235565AbjFNJpY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 14 Jun 2023 05:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244244AbjFNJoe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 14 Jun 2023 05:44:34 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 109012965
        for <linux-wireless@vger.kernel.org>; Wed, 14 Jun 2023 02:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686735789; x=1718271789;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SUI7/KtRSJP6voRCBrV7EyKXHvTae1UT/7ojTYqsjz4=;
  b=k09UTly1Pey0Egqbm63vXny9kO2GHPJ7+2JCgdv6glo8SgRpbGbRgKdo
   jCs73gtIO4sXjXnbJa58kIvciNhf09NMl4DrHZnabKBdHtEifoCpEFmiS
   L+HHAYWckmg8Z4ncLIVqm2XSOjnDIayuauxR6EJ1nglzjtkOGcB9YQuiM
   Hf3coZS1VnRpDj2qnVtZIfvoiBx00Pn/4OTyAzl15EHFzGtSMkely4Ecw
   4LX0Ix3fmOnhQEyj4BoHyatIXM+4ojhWdqfVYglsUdf3xmQcLJ91k0t7G
   TpeLJjURGDA95bDiAWe3MfCpBcC3xCjMSBp0MbM8XZ5+X2NofXTJiDNIh
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="361049812"
X-IronPort-AV: E=Sophos;i="6.00,242,1681196400"; 
   d="scan'208";a="361049812"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 02:42:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="711989786"
X-IronPort-AV: E=Sophos;i="6.00,242,1681196400"; 
   d="scan'208";a="711989786"
Received: from basharil-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.203.45])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 02:41:59 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 03/20] wifi: iwlwifi: fw: make some ACPI functions static
Date:   Wed, 14 Jun 2023 12:41:20 +0300
Message-Id: <20230614123446.e866032e4106.Ifede7f7c25b17a8215b154ce01da513b75384325@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230614094137.379897-1-gregory.greenman@intel.com>
References: <20230614094137.379897-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

iwl_acpi_get_wifi_pkg_range(), iwl_acpi_get_wifi_pkg() and
iwl_acpi_get_object() need not be exported etc., they're used
only within the same file. Make them static.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c | 27 +++++++++++------
 drivers/net/wireless/intel/iwlwifi/fw/acpi.h | 32 +-------------------
 2 files changed, 19 insertions(+), 40 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
index 4e4048310f0f..6345ac454e80 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
  * Copyright (C) 2017 Intel Deutschland GmbH
- * Copyright (C) 2019-2022 Intel Corporation
+ * Copyright (C) 2019-2023 Intel Corporation
  */
 #include <linux/uuid.h>
 #include <linux/dmi.h>
@@ -94,7 +94,7 @@ static int iwl_acpi_get_handle(struct device *dev, acpi_string method,
 	return 0;
 }
 
-void *iwl_acpi_get_object(struct device *dev, acpi_string method)
+static void *iwl_acpi_get_object(struct device *dev, acpi_string method)
 {
 	struct acpi_buffer buf = {ACPI_ALLOCATE_BUFFER, NULL};
 	acpi_handle handle;
@@ -115,7 +115,6 @@ void *iwl_acpi_get_object(struct device *dev, acpi_string method)
 	}
 	return buf.pointer;
 }
-IWL_EXPORT_SYMBOL(iwl_acpi_get_object);
 
 /*
  * Generic function for evaluating a method defined in the device specific
@@ -237,11 +236,12 @@ int iwl_acpi_get_dsm_u32(struct device *dev, int rev, int func,
 }
 IWL_EXPORT_SYMBOL(iwl_acpi_get_dsm_u32);
 
-union acpi_object *iwl_acpi_get_wifi_pkg_range(struct device *dev,
-					       union acpi_object *data,
-					       int min_data_size,
-					       int max_data_size,
-					       int *tbl_rev)
+static union acpi_object *
+iwl_acpi_get_wifi_pkg_range(struct device *dev,
+			    union acpi_object *data,
+			    int min_data_size,
+			    int max_data_size,
+			    int *tbl_rev)
 {
 	int i;
 	union acpi_object *wifi_pkg;
@@ -292,7 +292,16 @@ union acpi_object *iwl_acpi_get_wifi_pkg_range(struct device *dev,
 found:
 	return wifi_pkg;
 }
-IWL_EXPORT_SYMBOL(iwl_acpi_get_wifi_pkg_range);
+
+static union acpi_object *
+iwl_acpi_get_wifi_pkg(struct device *dev,
+		      union acpi_object *data,
+		      int data_size, int *tbl_rev)
+{
+	return iwl_acpi_get_wifi_pkg_range(dev, data, data_size, data_size,
+					   tbl_rev);
+}
+
 
 int iwl_acpi_get_tas(struct iwl_fw_runtime *fwrt,
 		     union iwl_tas_config_cmd *cmd, int fw_ver)
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.h b/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
index 6f361c59106f..e9c533cf7f93 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
  * Copyright (C) 2017 Intel Deutschland GmbH
- * Copyright (C) 2018-2022 Intel Corporation
+ * Copyright (C) 2018-2023 Intel Corporation
  */
 #ifndef __iwl_fw_acpi__
 #define __iwl_fw_acpi__
@@ -168,19 +168,12 @@ struct iwl_fw_runtime;
 extern const guid_t iwl_guid;
 extern const guid_t iwl_rfi_guid;
 
-void *iwl_acpi_get_object(struct device *dev, acpi_string method);
-
 int iwl_acpi_get_dsm_u8(struct device *dev, int rev, int func,
 			const guid_t *guid, u8 *value);
 
 int iwl_acpi_get_dsm_u32(struct device *dev, int rev, int func,
 			 const guid_t *guid, u32 *value);
 
-union acpi_object *iwl_acpi_get_wifi_pkg_range(struct device *dev,
-					       union acpi_object *data,
-					       int min_data_size,
-					       int max_data_size,
-					       int *tbl_rev);
 /**
  * iwl_acpi_get_mcc - read MCC from ACPI, if available
  *
@@ -234,11 +227,6 @@ bool iwl_acpi_is_ppag_approved(struct iwl_fw_runtime *fwrt);
 
 #else /* CONFIG_ACPI */
 
-static inline void *iwl_acpi_get_object(struct device *dev, acpi_string method)
-{
-	return ERR_PTR(-ENOENT);
-}
-
 static inline void *iwl_acpi_get_dsm_object(struct device *dev, int rev,
 					    int func, union acpi_object *args)
 {
@@ -257,15 +245,6 @@ static inline int iwl_acpi_get_dsm_u32(struct device *dev, int rev, int func,
 	return -ENOENT;
 }
 
-static inline union acpi_object *
-iwl_acpi_get_wifi_pkg_range(struct device *dev,
-			    union acpi_object *data,
-			    int min_data_size, int max_data_size,
-			    int *tbl_rev)
-{
-	return ERR_PTR(-ENOENT);
-}
-
 static inline int iwl_acpi_get_mcc(struct device *dev, char *mcc)
 {
 	return -ENOENT;
@@ -337,13 +316,4 @@ static inline bool iwl_acpi_is_ppag_approved(struct iwl_fw_runtime *fwrt)
 
 #endif /* CONFIG_ACPI */
 
-static inline union acpi_object *
-iwl_acpi_get_wifi_pkg(struct device *dev,
-		      union acpi_object *data,
-		      int data_size, int *tbl_rev)
-{
-	return iwl_acpi_get_wifi_pkg_range(dev, data, data_size, data_size,
-					   tbl_rev);
-}
-
 #endif /* __iwl_fw_acpi__ */
-- 
2.38.1

