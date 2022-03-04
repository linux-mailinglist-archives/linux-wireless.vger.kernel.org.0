Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1235C4CD343
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Mar 2022 12:21:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239287AbiCDLW1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 4 Mar 2022 06:22:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239279AbiCDLWZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 4 Mar 2022 06:22:25 -0500
Received: from farmhouse.coelho.fi (paleale.coelho.fi [176.9.41.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A006137776
        for <linux-wireless@vger.kernel.org>; Fri,  4 Mar 2022 03:21:37 -0800 (PST)
Received: from 91-156-4-241.elisa-laajakaista.fi ([91.156.4.241] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <luca@coelho.fi>)
        id 1nQ607-000QSW-B5;
        Fri, 04 Mar 2022 13:21:36 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@kernel.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Fri,  4 Mar 2022 13:21:19 +0200
Message-Id: <iwlwifi.20220304131517.4929e4b14956.I1bdffa4c37d4ee349aa0001978b716b96e38b090@changeid>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220304112129.219513-1-luca@coelho.fi>
References: <20220304112129.219513-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
Subject: [PATCH 03/13] iwlwifi: Configure FW debug preset via module param.
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ayala Barazani <ayala.barazani@intel.com>

The module param "enable_ini" is currently used to be enable/disable ini.
Add the option to configure the FW debug preset via this module param,
by change it type from boolean to an integer.

Signed-off-by: Ayala Barazani <ayala.barazani@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/iwl-dbg-tlv.h  |  4 +-
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c  | 41 +++++++++++++++++--
 .../wireless/intel/iwlwifi/iwl-modparams.h    |  5 ++-
 3 files changed, 43 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.h b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.h
index 79287708bd6e..128059ca77e6 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2018-2021 Intel Corporation
+ * Copyright (C) 2018-2022 Intel Corporation
  */
 #ifndef __iwl_dbg_tlv_h__
 #define __iwl_dbg_tlv_h__
@@ -10,6 +10,8 @@
 #include <fw/file.h>
 #include <fw/api/dbg-tlv.h>
 
+#define IWL_DBG_TLV_MAX_PRESET 15
+
 /**
  * struct iwl_dbg_tlv_node - debug TLV node
  * @list: list of &struct iwl_dbg_tlv_node
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
index ab52136cffb4..f92bcab5fdf6 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
@@ -1796,6 +1796,7 @@ void iwl_drv_stop(struct iwl_drv *drv)
 	kfree(drv);
 }
 
+#define ENABLE_INI	(IWL_DBG_TLV_MAX_PRESET + 1)
 
 /* shared module parameters */
 struct iwl_mod_params iwlwifi_mod_params = {
@@ -1803,7 +1804,7 @@ struct iwl_mod_params iwlwifi_mod_params = {
 	.bt_coex_active = true,
 	.power_level = IWL_POWER_INDEX_1,
 	.uapsd_disable = IWL_DISABLE_UAPSD_BSS | IWL_DISABLE_UAPSD_P2P_CLIENT,
-	.enable_ini = true,
+	.enable_ini = ENABLE_INI,
 	/* the rest are 0 by default */
 };
 IWL_EXPORT_SYMBOL(iwlwifi_mod_params);
@@ -1915,10 +1916,42 @@ MODULE_PARM_DESC(nvm_file, "NVM file name");
 module_param_named(uapsd_disable, iwlwifi_mod_params.uapsd_disable, uint, 0644);
 MODULE_PARM_DESC(uapsd_disable,
 		 "disable U-APSD functionality bitmap 1: BSS 2: P2P Client (default: 3)");
-module_param_named(enable_ini, iwlwifi_mod_params.enable_ini,
-		   bool, S_IRUGO | S_IWUSR);
+
+static int enable_ini_set(const char *arg, const struct kernel_param *kp)
+{
+	int ret = 0;
+	bool res;
+	__u32 new_enable_ini;
+
+	/* in case the argument type is a number */
+	ret = kstrtou32(arg, 0, &new_enable_ini);
+	if (!ret) {
+		if (new_enable_ini > ENABLE_INI) {
+			pr_err("enable_ini cannot be %d, in range 0-16\n", new_enable_ini);
+			return -EINVAL;
+		}
+		goto out;
+	}
+
+	/* in case the argument type is boolean */
+	ret = kstrtobool(arg, &res);
+	if (ret)
+		return ret;
+	new_enable_ini = (res ? ENABLE_INI : 0);
+
+out:
+	iwlwifi_mod_params.enable_ini = new_enable_ini;
+	return 0;
+}
+
+static const struct kernel_param_ops enable_ini_ops = {
+	.set = enable_ini_set
+};
+
+module_param_cb(enable_ini, &enable_ini_ops, &iwlwifi_mod_params.enable_ini, 0644);
 MODULE_PARM_DESC(enable_ini,
-		 "Enable debug INI TLV FW debug infrastructure (default: true");
+		 "0:disable, 1-15:FW_DBG_PRESET Values, 16:enabled without preset value defined,"
+		 "Debug INI TLV FW debug infrastructure (default: 16)");
 
 /*
  * set bt_coex_active to true, uCode will do kill/defer
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-modparams.h b/drivers/net/wireless/intel/iwlwifi/iwl-modparams.h
index 004ebdac4535..d0b4d02bdab9 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-modparams.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-modparams.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2005-2014, 2018-2020 Intel Corporation
+ * Copyright (C) 2005-2014, 2018-2022 Intel Corporation
  */
 #ifndef __iwl_modparams_h__
 #define __iwl_modparams_h__
@@ -83,7 +83,8 @@ struct iwl_mod_params {
 	 */
 	bool disable_11ax;
 	bool remove_when_gone;
-	bool enable_ini;
+	u32 enable_ini;
+	bool disable_11be;
 };
 
 static inline bool iwl_enable_rx_ampdu(void)
-- 
2.35.1

