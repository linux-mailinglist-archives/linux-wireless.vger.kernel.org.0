Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AD6543074E
	for <lists+linux-wireless@lfdr.de>; Sun, 17 Oct 2021 10:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245131AbhJQIqP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 17 Oct 2021 04:46:15 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:53598 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S245111AbhJQIqJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 17 Oct 2021 04:46:09 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1mc1lu-000YRM-Bb; Sun, 17 Oct 2021 11:43:58 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sun, 17 Oct 2021 11:43:47 +0300
Message-Id: <iwlwifi.20211017113927.32109514aad0.I91a7d745f4ab50ee8ef918ece00dda8251541595@changeid>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211017084348.401570-1-luca@coelho.fi>
References: <20211017084348.401570-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 09/10] iwlwifi: remove MODULE_AUTHOR() statements
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Consensus seems to be emerging that corporations or groups
shouldn't be listed as module authors, and we will not
maintain this email address any longer. Just remove it.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/dvm/main.c | 1 -
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c  | 1 -
 drivers/net/wireless/intel/iwlwifi/iwl-drv.h  | 3 +--
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  | 1 -
 4 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/main.c b/drivers/net/wireless/intel/iwlwifi/dvm/main.c
index 69d1aae96bbb..50d4e9481790 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/main.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/main.c
@@ -52,7 +52,6 @@
 
 #define DRV_DESCRIPTION	"Intel(R) Wireless WiFi Link AGN driver for Linux"
 MODULE_DESCRIPTION(DRV_DESCRIPTION);
-MODULE_AUTHOR(DRV_AUTHOR);
 MODULE_LICENSE("GPL");
 
 /* Please keep this array *SORTED* by hex value.
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
index 77124b8b235e..6712ff6772e7 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
@@ -31,7 +31,6 @@
 
 #define DRV_DESCRIPTION	"Intel(R) Wireless WiFi driver for Linux"
 MODULE_DESCRIPTION(DRV_DESCRIPTION);
-MODULE_AUTHOR(DRV_AUTHOR);
 MODULE_LICENSE("GPL");
 
 #ifdef CONFIG_IWLWIFI_DEBUGFS
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-drv.h b/drivers/net/wireless/intel/iwlwifi/iwl-drv.h
index b6442df0c643..2e2d60a58692 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-drv.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-drv.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2005-2014, 2020 Intel Corporation
+ * Copyright (C) 2005-2014, 2020-2021 Intel Corporation
  * Copyright (C) 2013-2014 Intel Mobile Communications GmbH
  */
 #ifndef __iwl_drv_h__
@@ -9,7 +9,6 @@
 
 /* for all modules */
 #define DRV_NAME        "iwlwifi"
-#define DRV_AUTHOR	"Intel Corporation <linuxwifi@intel.com>"
 
 /* radio config bits (actual values from NVM definition) */
 #define NVM_RF_CFG_DASH_MSK(x)   (x & 0x3)         /* bits 0-1   */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index 77ea2d0a3091..c7ae284ae96d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -29,7 +29,6 @@
 
 #define DRV_DESCRIPTION	"The new Intel(R) wireless AGN driver for Linux"
 MODULE_DESCRIPTION(DRV_DESCRIPTION);
-MODULE_AUTHOR(DRV_AUTHOR);
 MODULE_LICENSE("GPL");
 
 static const struct iwl_op_mode_ops iwl_mvm_ops;
-- 
2.33.0

