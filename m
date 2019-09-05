Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7360AA3FC
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Sep 2019 15:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388396AbfIENNB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 Sep 2019 09:13:01 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:40990 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731633AbfIENNB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 Sep 2019 09:13:01 -0400
Received: from [91.156.6.193] (helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1i5rZG-0005yI-Kb; Thu, 05 Sep 2019 16:12:55 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Thu,  5 Sep 2019 16:12:33 +0300
Message-Id: <20190905131241.23487-11-luca@coelho.fi>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190905131241.23487-1-luca@coelho.fi>
References: <20190905131241.23487-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: [PATCH v2 10/18] iwlwifi: remove the d0i3 related module parameters
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

Those are now effectless.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c       | 8 --------
 drivers/net/wireless/intel/iwlwifi/iwl-modparams.h | 9 ++-------
 2 files changed, 2 insertions(+), 15 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
index 38672dd5aae9..7afc6e43502a 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
@@ -1704,8 +1704,6 @@ struct iwl_mod_params iwlwifi_mod_params = {
 	.fw_restart = true,
 	.bt_coex_active = true,
 	.power_level = IWL_POWER_INDEX_1,
-	.d0i3_disable = true,
-	.d0i3_timeout = 1000,
 	.uapsd_disable = IWL_DISABLE_UAPSD_BSS | IWL_DISABLE_UAPSD_P2P_CLIENT,
 	/* the rest are 0 by default */
 };
@@ -1823,9 +1821,6 @@ MODULE_PARM_DESC(antenna_coupling,
 module_param_named(nvm_file, iwlwifi_mod_params.nvm_file, charp, 0444);
 MODULE_PARM_DESC(nvm_file, "NVM file name");
 
-module_param_named(d0i3_disable, iwlwifi_mod_params.d0i3_disable, bool, 0444);
-MODULE_PARM_DESC(d0i3_disable, "disable d0i3 functionality (default: Y)");
-
 module_param_named(lar_disable, iwlwifi_mod_params.lar_disable, bool, 0444);
 MODULE_PARM_DESC(lar_disable, "disable LAR functionality (default: N)");
 
@@ -1873,9 +1868,6 @@ module_param_named(fw_monitor, iwlwifi_mod_params.fw_monitor, bool, 0444);
 MODULE_PARM_DESC(fw_monitor,
 		 "firmware monitor - to debug FW (default: false - needs lots of memory)");
 
-module_param_named(d0i3_timeout, iwlwifi_mod_params.d0i3_timeout, uint, 0444);
-MODULE_PARM_DESC(d0i3_timeout, "Timeout to D0i3 entry when idle (ms)");
-
 module_param_named(disable_11ac, iwlwifi_mod_params.disable_11ac, bool, 0444);
 MODULE_PARM_DESC(disable_11ac, "Disable VHT capabilities (default: false)");
 
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-modparams.h b/drivers/net/wireless/intel/iwlwifi/iwl-modparams.h
index 0cae2ef9b9df..ebea3f308b5d 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-modparams.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-modparams.h
@@ -6,7 +6,7 @@
  * GPL LICENSE SUMMARY
  *
  * Copyright(c) 2007 - 2014 Intel Corporation. All rights reserved.
- * Copyright(c) 2018 Intel Corporation
+ * Copyright(c) 2018 - 2019 Intel Corporation
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of version 2 of the GNU General Public License as
@@ -27,7 +27,7 @@
  * BSD LICENSE
  *
  * Copyright(c) 2005 - 2014 Intel Corporation. All rights reserved.
- * Copyright(c) 2018 Intel Corporation
+ * Copyright(c) 2018 - 2019 Intel Corporation
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
@@ -115,9 +115,6 @@ enum iwl_uapsd_disable {
  * @nvm_file: specifies a external NVM file
  * @uapsd_disable: disable U-APSD, see &enum iwl_uapsd_disable, default =
  *	IWL_DISABLE_UAPSD_BSS | IWL_DISABLE_UAPSD_P2P_CLIENT
- * @d0i3_disable: disable d0i3, default = 1,
- * @d0i3_timeout: time to wait after no refs are taken before
- *	entering D0i3 (in msecs)
  * @lar_disable: disable LAR (regulatory), default = 0
  * @fw_monitor: allow to use firmware monitor
  * @disable_11ac: disable VHT capabilities, default = false.
@@ -139,8 +136,6 @@ struct iwl_mod_params {
 	int antenna_coupling;
 	char *nvm_file;
 	u32 uapsd_disable;
-	bool d0i3_disable;
-	unsigned int d0i3_timeout;
 	bool lar_disable;
 	bool fw_monitor;
 	bool disable_11ac;
-- 
2.23.0.rc1

