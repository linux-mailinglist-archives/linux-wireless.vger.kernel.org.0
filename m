Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E797E78D9A2
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Aug 2023 20:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232245AbjH3Sdi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 30 Aug 2023 14:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242433AbjH3Ibe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 30 Aug 2023 04:31:34 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A8B51A4
        for <linux-wireless@vger.kernel.org>; Wed, 30 Aug 2023 01:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693384291; x=1724920291;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YdZiydv0mp4Nz/tg5kbwX3er+EuJiFsBY8tYCwq6i9k=;
  b=ctiB9zOSYAauE5MmrDGLdUTyAkKxYrceZO8nuvkKXi/rQL3zwyLRJIH7
   g46zPbBm3geQ8nniM6NvdUJJWLZoDQq7wA6JiG8u6TdcHaaW772Xfl57J
   ekrLX85Xh1iUNjgTrcC9Ik5u48mVkMlXEVVm/IbLNjbqQNkHlNrkUdIIq
   Inf1kWIAx6FDRzoGmFHLqB0Hq8v1J6vEAYuK0dPvu+1QU23bPS7AHhQv1
   8IYk1NoiBcqikSxQYpoPqEfKBDW10+vjPU1/3sPmurjPHMuYyuZ4B3rUh
   20IE8x1u80G4YFMWUavGD9GkZZQ/lOU2c1gSVRc/V6RvdWI9OneYmwnST
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="461958892"
X-IronPort-AV: E=Sophos;i="6.02,213,1688454000"; 
   d="scan'208";a="461958892"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 01:31:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="829152029"
X-IronPort-AV: E=Sophos;i="6.02,213,1688454000"; 
   d="scan'208";a="829152029"
Received: from oweil1-mobl3.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.210.69])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 01:31:28 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 04/16] wifi: iwlwifi: honor the enable_ini value
Date:   Wed, 30 Aug 2023 11:30:52 +0300
Message-Id: <20230830112059.5734e0f374bb.I6698eda8ed2112378dd47ac5d62866ebe7a94f77@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230830083104.546619-1-gregory.greenman@intel.com>
References: <20230830083104.546619-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

In case the user sets the enable_ini to some preset, we want to honor
the value.

Remove the ops to set the value of the module parameter is runtime, we
don't want to allow to modify the value in runtime since we configure
the firmware once at the beginning on its life.

Fixes: b49c2b252b58 ("iwlwifi: Configure FW debug preset via module param.")
Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 .../wireless/intel/iwlwifi/fw/api/dbg-tlv.h   |  1 +
 .../net/wireless/intel/iwlwifi/iwl-dbg-tlv.h  |  5 +-
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c  | 51 +++++++------------
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |  4 ++
 4 files changed, 25 insertions(+), 36 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h b/drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h
index ba538d70985f..39bee9c00e07 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h
@@ -13,6 +13,7 @@
 #define IWL_FW_INI_DOMAIN_ALWAYS_ON		0
 #define IWL_FW_INI_REGION_ID_MASK		GENMASK(15, 0)
 #define IWL_FW_INI_REGION_DUMP_POLICY_MASK	GENMASK(31, 16)
+#define IWL_FW_INI_PRESET_DISABLE		0xff
 
 /**
  * struct iwl_fw_ini_hcmd
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.h b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.h
index 128059ca77e6..06fb7d665390 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2018-2022 Intel Corporation
+ * Copyright (C) 2018-2023 Intel Corporation
  */
 #ifndef __iwl_dbg_tlv_h__
 #define __iwl_dbg_tlv_h__
@@ -10,7 +10,8 @@
 #include <fw/file.h>
 #include <fw/api/dbg-tlv.h>
 
-#define IWL_DBG_TLV_MAX_PRESET 15
+#define IWL_DBG_TLV_MAX_PRESET	15
+#define ENABLE_INI		(IWL_DBG_TLV_MAX_PRESET + 1)
 
 /**
  * struct iwl_dbg_tlv_node - debug TLV node
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
index 3d87d26845e7..fb5e254757e7 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
@@ -1795,6 +1795,22 @@ struct iwl_drv *iwl_drv_start(struct iwl_trans *trans)
 #endif
 
 	drv->trans->dbg.domains_bitmap = IWL_TRANS_FW_DBG_DOMAIN(drv->trans);
+	if (iwlwifi_mod_params.enable_ini != ENABLE_INI) {
+		/* We have a non-default value in the module parameter,
+		 * take its value
+		 */
+		drv->trans->dbg.domains_bitmap &= 0xffff;
+		if (iwlwifi_mod_params.enable_ini != IWL_FW_INI_PRESET_DISABLE) {
+			if (iwlwifi_mod_params.enable_ini > ENABLE_INI) {
+				IWL_ERR(trans,
+					"invalid enable_ini module parameter value: max = %d, using 0 instead\n",
+					ENABLE_INI);
+				iwlwifi_mod_params.enable_ini = 0;
+			}
+			drv->trans->dbg.domains_bitmap =
+				BIT(IWL_FW_DBG_DOMAIN_POS + iwlwifi_mod_params.enable_ini);
+		}
+	}
 
 	ret = iwl_request_firmware(drv, true);
 	if (ret) {
@@ -1843,8 +1859,6 @@ void iwl_drv_stop(struct iwl_drv *drv)
 	kfree(drv);
 }
 
-#define ENABLE_INI	(IWL_DBG_TLV_MAX_PRESET + 1)
-
 /* shared module parameters */
 struct iwl_mod_params iwlwifi_mod_params = {
 	.fw_restart = true,
@@ -1964,38 +1978,7 @@ module_param_named(uapsd_disable, iwlwifi_mod_params.uapsd_disable, uint, 0644);
 MODULE_PARM_DESC(uapsd_disable,
 		 "disable U-APSD functionality bitmap 1: BSS 2: P2P Client (default: 3)");
 
-static int enable_ini_set(const char *arg, const struct kernel_param *kp)
-{
-	int ret = 0;
-	bool res;
-	__u32 new_enable_ini;
-
-	/* in case the argument type is a number */
-	ret = kstrtou32(arg, 0, &new_enable_ini);
-	if (!ret) {
-		if (new_enable_ini > ENABLE_INI) {
-			pr_err("enable_ini cannot be %d, in range 0-16\n", new_enable_ini);
-			return -EINVAL;
-		}
-		goto out;
-	}
-
-	/* in case the argument type is boolean */
-	ret = kstrtobool(arg, &res);
-	if (ret)
-		return ret;
-	new_enable_ini = (res ? ENABLE_INI : 0);
-
-out:
-	iwlwifi_mod_params.enable_ini = new_enable_ini;
-	return 0;
-}
-
-static const struct kernel_param_ops enable_ini_ops = {
-	.set = enable_ini_set
-};
-
-module_param_cb(enable_ini, &enable_ini_ops, &iwlwifi_mod_params.enable_ini, 0644);
+module_param_named(enable_ini, iwlwifi_mod_params.enable_ini, uint, 0444);
 MODULE_PARM_DESC(enable_ini,
 		 "0:disable, 1-15:FW_DBG_PRESET Values, 16:enabled without preset value defined,"
 		 "Debug INI TLV FW debug infrastructure (default: 16)");
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index 3b6b0e03037f..1b3c976d19fe 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -56,6 +56,10 @@
  *	6) Eventually, the free function will be called.
  */
 
+/* default preset 0 (start from bit 16)*/
+#define IWL_FW_DBG_DOMAIN_POS	16
+#define IWL_FW_DBG_DOMAIN	BIT(IWL_FW_DBG_DOMAIN_POS)
+
 #define IWL_TRANS_FW_DBG_DOMAIN(trans)	IWL_FW_INI_DOMAIN_ALWAYS_ON
 
 #define FH_RSCSR_FRAME_SIZE_MSK		0x00003FFF	/* bits 0-13 */
-- 
2.38.1

