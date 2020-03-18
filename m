Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9DAB189595
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Mar 2020 07:13:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbgCRGNE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Mar 2020 02:13:04 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:34612 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726553AbgCRGNE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Mar 2020 02:13:04 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=localhost.localdomain)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.2)
        (envelope-from <luca@coelho.fi>)
        id 1jERwr-0003wu-It; Wed, 18 Mar 2020 08:13:02 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, lenb@kernel.org, noodles@earth.li
Date:   Wed, 18 Mar 2020 08:12:54 +0200
Message-Id: <iwlwifi.20200318081237.46db40617cc6.Id5cf852ec8c5dbf20ba86bad7b165a0c828f8b2e@changeid>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.2
Subject: [PATCH v5.6] iwlwifi: don't send GEO_TX_POWER_LIMIT if no wgds table
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Golan Ben Ami <golan.ben.ami@intel.com>

The GEO_TX_POWER_LIMIT command was sent although
there is no wgds table, so the fw got wrong SAR values
from the driver.

Fix this by avoiding sending the command if no wgds
tables are available.

Signed-off-by: Golan Ben Ami <golan.ben.ami@intel.com>
Fixes: 39c1a9728f93 ("iwlwifi: refactor the SAR tables from mvm to acpi")
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c | 14 ++++++++------
 drivers/net/wireless/intel/iwlwifi/fw/acpi.h | 14 ++++++++------
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c  |  9 ++++++++-
 3 files changed, 24 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
index 48d375a86d86..ba2aff3af0fe 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
@@ -6,7 +6,7 @@
  * GPL LICENSE SUMMARY
  *
  * Copyright(c) 2017        Intel Deutschland GmbH
- * Copyright (C) 2019 Intel Corporation
+ * Copyright (C) 2019 - 2020 Intel Corporation
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of version 2 of the GNU General Public License as
@@ -27,7 +27,7 @@
  * BSD LICENSE
  *
  * Copyright(c) 2017        Intel Deutschland GmbH
- * Copyright (C) 2019 Intel Corporation
+ * Copyright (C) 2019 - 2020 Intel Corporation
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
@@ -491,13 +491,13 @@ int iwl_validate_sar_geo_profile(struct iwl_fw_runtime *fwrt,
 }
 IWL_EXPORT_SYMBOL(iwl_validate_sar_geo_profile);
 
-void iwl_sar_geo_init(struct iwl_fw_runtime *fwrt,
-		      struct iwl_per_chain_offset_group *table)
+int iwl_sar_geo_init(struct iwl_fw_runtime *fwrt,
+		     struct iwl_per_chain_offset_group *table)
 {
 	int ret, i, j;
 
 	if (!iwl_sar_geo_support(fwrt))
-		return;
+		return -EOPNOTSUPP;
 
 	ret = iwl_sar_get_wgds_table(fwrt);
 	if (ret < 0) {
@@ -505,7 +505,7 @@ void iwl_sar_geo_init(struct iwl_fw_runtime *fwrt,
 				"Geo SAR BIOS table invalid or unavailable. (%d)\n",
 				ret);
 		/* we don't fail if the table is not available */
-		return;
+		return -ENOENT;
 	}
 
 	BUILD_BUG_ON(ACPI_NUM_GEO_PROFILES * ACPI_WGDS_NUM_BANDS *
@@ -530,5 +530,7 @@ void iwl_sar_geo_init(struct iwl_fw_runtime *fwrt,
 					i, j, value[1], value[2], value[0]);
 		}
 	}
+
+	return 0;
 }
 IWL_EXPORT_SYMBOL(iwl_sar_geo_init);
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.h b/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
index 4a6e8262974b..5590e5cc8fbb 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
@@ -6,7 +6,7 @@
  * GPL LICENSE SUMMARY
  *
  * Copyright(c) 2017        Intel Deutschland GmbH
- * Copyright(c) 2018 - 2019        Intel Corporation
+ * Copyright(c) 2018 - 2020        Intel Corporation
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of version 2 of the GNU General Public License as
@@ -27,7 +27,7 @@
  * BSD LICENSE
  *
  * Copyright(c) 2017        Intel Deutschland GmbH
- * Copyright(c) 2018 - 2019       Intel Corporation
+ * Copyright(c) 2018 - 2020       Intel Corporation
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
@@ -171,8 +171,9 @@ bool iwl_sar_geo_support(struct iwl_fw_runtime *fwrt);
 int iwl_validate_sar_geo_profile(struct iwl_fw_runtime *fwrt,
 				 struct iwl_host_cmd *cmd);
 
-void iwl_sar_geo_init(struct iwl_fw_runtime *fwrt,
-		      struct iwl_per_chain_offset_group *table);
+int iwl_sar_geo_init(struct iwl_fw_runtime *fwrt,
+		     struct iwl_per_chain_offset_group *table);
+
 #else /* CONFIG_ACPI */
 
 static inline void *iwl_acpi_get_object(struct device *dev, acpi_string method)
@@ -243,9 +244,10 @@ static inline int iwl_validate_sar_geo_profile(struct iwl_fw_runtime *fwrt,
 	return -ENOENT;
 }
 
-static inline void iwl_sar_geo_init(struct iwl_fw_runtime *fwrt,
-				    struct iwl_per_chain_offset_group *table)
+static inline int iwl_sar_geo_init(struct iwl_fw_runtime *fwrt,
+				   struct iwl_per_chain_offset_group *table)
 {
+	return -ENOENT;
 }
 
 #endif /* CONFIG_ACPI */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 54c094e88474..98263cd37944 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -762,10 +762,17 @@ static int iwl_mvm_sar_geo_init(struct iwl_mvm *mvm)
 	u16 cmd_wide_id =  WIDE_ID(PHY_OPS_GROUP, GEO_TX_POWER_LIMIT);
 	union geo_tx_power_profiles_cmd cmd;
 	u16 len;
+	int ret;
 
 	cmd.geo_cmd.ops = cpu_to_le32(IWL_PER_CHAIN_OFFSET_SET_TABLES);
 
-	iwl_sar_geo_init(&mvm->fwrt, cmd.geo_cmd.table);
+	ret = iwl_sar_geo_init(&mvm->fwrt, cmd.geo_cmd.table);
+	/*
+	 * It is a valid scenario to not support SAR, or miss wgds table,
+	 * but in that case there is no need to send the command.
+	 */
+	if (ret)
+		return 0;
 
 	cmd.geo_cmd.table_revision = cpu_to_le32(mvm->fwrt.geo_rev);
 
-- 
2.25.1

