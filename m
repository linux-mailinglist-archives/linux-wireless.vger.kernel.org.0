Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 420F3468608
	for <lists+linux-wireless@lfdr.de>; Sat,  4 Dec 2021 16:49:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347153AbhLDPxR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 4 Dec 2021 10:53:17 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:50460 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1346914AbhLDPxQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 4 Dec 2021 10:53:16 -0500
Received: from 91-156-5-105.elisa-laajakaista.fi ([91.156.5.105] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1mtXIL-0017qB-44; Sat, 04 Dec 2021 17:49:49 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sat,  4 Dec 2021 17:49:34 +0200
Message-Id: <iwlwifi.20211204174545.94a120687887.I79acffcf0793ea9e4ddec24b06420961bfb4fe94@changeid>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211204154944.914175-1-luca@coelho.fi>
References: <20211204154944.914175-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 02/12] iwlwifi: mvm/api: define system control command
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

The firmware is exposing a new system features control command,
define the necessary data structures etc. Rename "soc.h" to
"system.h" since the SoC command is also in the system group
and adding another file for just one more struct seemed like a
waste of files.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/fw/api/commands.h |  5 +++++
 .../intel/iwlwifi/fw/api/{soc.h => system.h}     | 16 ++++++++++++----
 drivers/net/wireless/intel/iwlwifi/fw/init.c     |  2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/fw-api.h  |  2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c     |  1 +
 5 files changed, 20 insertions(+), 6 deletions(-)
 rename drivers/net/wireless/intel/iwlwifi/fw/api/{soc.h => system.h} (70%)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/commands.h b/drivers/net/wireless/intel/iwlwifi/fw/api/commands.h
index 2792fd5d9c9b..dab02a6a2622 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/commands.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/commands.h
@@ -614,6 +614,11 @@ enum iwl_system_subcmd_ids {
 	 * @RFI_GET_FREQ_TABLE_CMD: &struct iwl_rfi_config_cmd
 	 */
 	RFI_GET_FREQ_TABLE_CMD = 0xc,
+
+	/**
+	 * @SYSTEM_FEATURES_CONTROL_CMD: &struct iwl_system_features_control_cmd
+	 */
+	SYSTEM_FEATURES_CONTROL_CMD = 0xd,
 };
 
 #endif /* __iwl_fw_api_commands_h__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/soc.h b/drivers/net/wireless/intel/iwlwifi/fw/api/system.h
similarity index 70%
rename from drivers/net/wireless/intel/iwlwifi/fw/api/soc.h
rename to drivers/net/wireless/intel/iwlwifi/fw/api/system.h
index c5df1171462b..acf5d4b9a214 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/soc.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/system.h
@@ -1,11 +1,11 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2012-2014, 2019-2020 Intel Corporation
+ * Copyright (C) 2012-2014, 2019-2021 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
-#ifndef __iwl_fw_api_soc_h__
-#define __iwl_fw_api_soc_h__
+#ifndef __iwl_fw_api_system_h__
+#define __iwl_fw_api_system_h__
 
 #define SOC_CONFIG_CMD_FLAGS_DISCRETE		BIT(0)
 #define SOC_CONFIG_CMD_FLAGS_LOW_LATENCY	BIT(1)
@@ -32,4 +32,12 @@ struct iwl_soc_configuration_cmd {
 	     * SOC_CONFIGURATION_CMD_S_VER_2
 	     */
 
-#endif /* __iwl_fw_api_soc_h__ */
+/**
+ * struct iwl_system_features_control_cmd - system features control command
+ * @features: bitmap of features to disable
+ */
+struct iwl_system_features_control_cmd {
+	__le32 features[4];
+} __packed; /* SYSTEM_FEATURES_CONTROL_CMD_API_S_VER_1 */
+
+#endif /* __iwl_fw_api_system_h__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/init.c b/drivers/net/wireless/intel/iwlwifi/fw/init.c
index 566957ac4539..139ece879fab 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/init.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/init.c
@@ -8,7 +8,7 @@
 #include "dbg.h"
 #include "debugfs.h"
 
-#include "fw/api/soc.h"
+#include "fw/api/system.h"
 #include "fw/api/commands.h"
 #include "fw/api/rx.h"
 #include "fw/api/datapath.h"
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw-api.h b/drivers/net/wireless/intel/iwlwifi/mvm/fw-api.h
index 73a82f07dc59..083f86fa5017 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw-api.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw-api.h
@@ -15,7 +15,7 @@
 #include "fw/api/datapath.h"
 #include "fw/api/phy.h"
 #include "fw/api/config.h"
-#include "fw/api/soc.h"
+#include "fw/api/system.h"
 #include "fw/api/alive.h"
 #include "fw/api/binding.h"
 #include "fw/api/cmdhdr.h"
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index 9e53769b800a..8056018600ad 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -500,6 +500,7 @@ static const struct iwl_hcmd_names iwl_mvm_system_names[] = {
 	HCMD_NAME(FW_ERROR_RECOVERY_CMD),
 	HCMD_NAME(RFI_CONFIG_CMD),
 	HCMD_NAME(RFI_GET_FREQ_TABLE_CMD),
+	HCMD_NAME(SYSTEM_FEATURES_CONTROL_CMD),
 };
 
 /* Please keep this array *SORTED* by hex value.
-- 
2.33.1

