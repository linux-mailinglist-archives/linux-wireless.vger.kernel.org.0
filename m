Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A6524A3581
	for <lists+linux-wireless@lfdr.de>; Sun, 30 Jan 2022 10:53:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354528AbiA3JxP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 30 Jan 2022 04:53:15 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:37906 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1354534AbiA3JxO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 30 Jan 2022 04:53:14 -0500
Received: from 91-156-4-210.elisa-laajakaista.fi ([91.156.4.210] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <luca@coelho.fi>)
        id 1nE6tU-0003JO-1R;
        Sun, 30 Jan 2022 11:53:12 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@kernel.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sun, 30 Jan 2022 11:53:00 +0200
Message-Id: <iwlwifi.20220130115024.67eba0b9867d.I6291815892746956c36489081f24f4f95b5160e4@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220130095306.790573-1-luca@coelho.fi>
References: <20220130095306.790573-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 06/12] iwlwifi: move symbols into a separate namespace
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Nobody other than iwlwifi itself should be accessing the symbols
that it exports, so make that clear by moving them into a separate
new namespace ("IWLWIFI").

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/dvm/main.c | 1 +
 drivers/net/wireless/intel/iwlwifi/iwl-drv.h  | 2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  | 1 +
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/main.c b/drivers/net/wireless/intel/iwlwifi/dvm/main.c
index 90b9becd1673..caf452922dbd 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/main.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/main.c
@@ -48,6 +48,7 @@
 #define DRV_DESCRIPTION	"Intel(R) Wireless WiFi Link AGN driver for Linux"
 MODULE_DESCRIPTION(DRV_DESCRIPTION);
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(IWLWIFI);
 
 /* Please keep this array *SORTED* by hex value.
  * Access is done through binary search.
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-drv.h b/drivers/net/wireless/intel/iwlwifi/iwl-drv.h
index 0fd009e6d685..80073f973334 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-drv.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-drv.h
@@ -84,7 +84,7 @@ void iwl_drv_stop(struct iwl_drv *drv);
  * everything is built-in, then we can avoid that.
  */
 #ifdef CONFIG_IWLWIFI_OPMODE_MODULAR
-#define IWL_EXPORT_SYMBOL(sym)	EXPORT_SYMBOL_GPL(sym)
+#define IWL_EXPORT_SYMBOL(sym)	EXPORT_SYMBOL_NS_GPL(sym, IWLWIFI)
 #else
 #define IWL_EXPORT_SYMBOL(sym)
 #endif
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index 98326d06b3a9..fd866ab38e18 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -32,6 +32,7 @@
 #define DRV_DESCRIPTION	"The new Intel(R) wireless AGN driver for Linux"
 MODULE_DESCRIPTION(DRV_DESCRIPTION);
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(IWLWIFI);
 
 static const struct iwl_op_mode_ops iwl_mvm_ops;
 static const struct iwl_op_mode_ops iwl_mvm_ops_mq;
-- 
2.34.1

