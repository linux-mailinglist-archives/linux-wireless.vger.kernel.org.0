Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 553821B8585
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Apr 2020 12:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726361AbgDYKFU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 25 Apr 2020 06:05:20 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:58268 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726343AbgDYKFS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 25 Apr 2020 06:05:18 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1jSHgR-000P3t-O6; Sat, 25 Apr 2020 13:05:16 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sat, 25 Apr 2020 13:04:57 +0300
Message-Id: <iwlwifi.20200425130140.dc86a4e9451a.Ice2e21b6427a4b57f953dba9ceb5b8b96b251a8c@changeid>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200425100459.2778317-1-luca@coelho.fi>
References: <20200425100459.2778317-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 09/11] iwlwifi: remove outdated copyright print/module statement
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Remove the outdated copyright, don't print it, and update the
module author to actually be Intel, not Intel's copyright.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/dvm/main.c | 2 +-
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c  | 3 +--
 drivers/net/wireless/intel/iwlwifi/iwl-drv.h  | 7 +++----
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  | 2 +-
 4 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/main.c b/drivers/net/wireless/intel/iwlwifi/dvm/main.c
index 99822744122f..b882705ff66d 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/main.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/main.c
@@ -52,7 +52,7 @@
 
 #define DRV_DESCRIPTION	"Intel(R) Wireless WiFi Link AGN driver for Linux"
 MODULE_DESCRIPTION(DRV_DESCRIPTION);
-MODULE_AUTHOR(DRV_COPYRIGHT " " DRV_AUTHOR);
+MODULE_AUTHOR(DRV_AUTHOR);
 MODULE_LICENSE("GPL");
 
 /* Please keep this array *SORTED* by hex value.
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
index 68dc1f046064..a8ec7cbde799 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
@@ -85,7 +85,7 @@
 
 #define DRV_DESCRIPTION	"Intel(R) Wireless WiFi driver for Linux"
 MODULE_DESCRIPTION(DRV_DESCRIPTION);
-MODULE_AUTHOR(DRV_COPYRIGHT " " DRV_AUTHOR);
+MODULE_AUTHOR(DRV_AUTHOR);
 MODULE_LICENSE("GPL");
 
 #ifdef CONFIG_IWLWIFI_DEBUGFS
@@ -1774,7 +1774,6 @@ static int __init iwl_drv_init(void)
 		INIT_LIST_HEAD(&iwlwifi_opmode_table[i].drv);
 
 	pr_info(DRV_DESCRIPTION "\n");
-	pr_info(DRV_COPYRIGHT "\n");
 
 #ifdef CONFIG_IWLWIFI_DEBUGFS
 	/* Create the root of iwlwifi debugfs subsystem. */
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-drv.h b/drivers/net/wireless/intel/iwlwifi/iwl-drv.h
index 2be30af7bdc3..8938a6467996 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-drv.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-drv.h
@@ -5,7 +5,7 @@
  *
  * GPL LICENSE SUMMARY
  *
- * Copyright(c) 2008 - 2014 Intel Corporation. All rights reserved.
+ * Copyright(c) 2008 - 2014, 2020 Intel Corporation. All rights reserved.
  * Copyright(c) 2013 - 2014 Intel Mobile Communications GmbH
  *
  * This program is free software; you can redistribute it and/or modify
@@ -26,7 +26,7 @@
  *
  * BSD LICENSE
  *
- * Copyright(c) 2005 - 2014 Intel Corporation. All rights reserved.
+ * Copyright(c) 2005 - 2014, 2020 Intel Corporation. All rights reserved.
  * Copyright(c) 2013 - 2014 Intel Mobile Communications GmbH
  * All rights reserved.
  *
@@ -63,8 +63,7 @@
 
 /* for all modules */
 #define DRV_NAME        "iwlwifi"
-#define DRV_COPYRIGHT	"Copyright(c) 2003- 2015 Intel Corporation"
-#define DRV_AUTHOR     "<linuxwifi@intel.com>"
+#define DRV_AUTHOR	"Intel Corporation <linuxwifi@intel.com>"
 
 /* radio config bits (actual values from NVM definition) */
 #define NVM_RF_CFG_DASH_MSK(x)   (x & 0x3)         /* bits 0-1   */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index bde1b9b5face..d095ff847be9 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -84,7 +84,7 @@
 
 #define DRV_DESCRIPTION	"The new Intel(R) wireless AGN driver for Linux"
 MODULE_DESCRIPTION(DRV_DESCRIPTION);
-MODULE_AUTHOR(DRV_COPYRIGHT " " DRV_AUTHOR);
+MODULE_AUTHOR(DRV_AUTHOR);
 MODULE_LICENSE("GPL");
 
 static const struct iwl_op_mode_ops iwl_mvm_ops;
-- 
2.26.2

