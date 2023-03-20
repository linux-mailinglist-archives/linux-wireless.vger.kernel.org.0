Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11DD76C0F0C
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Mar 2023 11:36:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbjCTKgg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Mar 2023 06:36:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230346AbjCTKgK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Mar 2023 06:36:10 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1932A24BD5
        for <linux-wireless@vger.kernel.org>; Mon, 20 Mar 2023 03:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679308530; x=1710844530;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3omas1Sw2x/b8jdCLkk6+4jhJ/V+zt2gERcTECAnN2Y=;
  b=lpuNbKgdHy/3d9p3sDfIpVbSRsrBDleAWpw3gQf3SgQ0JpZ7zqbzDNAe
   jyTJ4qgdjVwnLLFyWCATxB90Hvpwtqjo2Rm06LKOyUx2or+fQoJsdTq8r
   H2GMnQO88Eo3IQzw5N8OVrCd8ybXfIU2cOvMYdNF0vvHvBYC3ZQuKF7wq
   BJe7H00rBmRG3hC/qJXDUgfHKxgM5uM+tWZOxVTzfKqVxnQUtH7oW7VKm
   zSZmzxyFEPUBXFdbBHffUMCzMSoHHUVRVhEKwE2Pmib9DiL9rLRB9qEUl
   7ifLu7QTeNBY1iTBst6RLM+ADWPTmi/Sv883qcFm7U1K77RLaGA+W4j/Z
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10654"; a="326997956"
X-IronPort-AV: E=Sophos;i="5.98,274,1673942400"; 
   d="scan'208";a="326997956"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 03:34:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10654"; a="713523701"
X-IronPort-AV: E=Sophos;i="5.98,274,1673942400"; 
   d="scan'208";a="713523701"
Received: from ranikhou-mobl3.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.251.179.26])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 03:34:10 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Mukesh Sisodiya <mukesh.sisodiya@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 16/18] wifi: iwlwifi: Update configurations for Bnj device
Date:   Mon, 20 Mar 2023 12:33:17 +0200
Message-Id: <20230320122330.eeb7ebb9ed87.I30c3938221aeb6f6ba2c84b1a77eea54c9dd3ba1@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230320103319.1309442-1-gregory.greenman@intel.com>
References: <20230320103319.1309442-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Mukesh Sisodiya <mukesh.sisodiya@intel.com>

Add missing rf support for spacific rf for BnJ device

Signed-off-by: Mukesh Sisodiya <mukesh.sisodiya@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 .../net/wireless/intel/iwlwifi/cfg/22000.c    | 24 +++++++++++++++++++
 .../net/wireless/intel/iwlwifi/iwl-config.h   |  2 ++
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 14 +++++++++--
 3 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
index bc33d19ca08d..e649daaf842c 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
@@ -68,7 +68,9 @@
 #define IWL_BNJ_A_GF_A_FW_PRE		"iwlwifi-BzBnj-a0-gf-a0-"
 #define IWL_BNJ_B_GF_A_FW_PRE		"iwlwifi-BzBnj-b0-gf-a0-"
 #define IWL_BNJ_A_GF4_A_FW_PRE		"iwlwifi-BzBnj-a0-gf4-a0-"
+#define IWL_BNJ_B_GF4_A_FW_PRE		"iwlwifi-BzBnj-b0-gf4-a0-"
 #define IWL_BNJ_A_HR_B_FW_PRE		"iwlwifi-BzBnj-a0-hr-b0-"
+#define IWL_BNJ_B_HR_B_FW_PRE		"iwlwifi-BzBnj-b0-hr-b0-"
 #define IWL_BNJ_B_FM_B_FW_PRE		"iwlwifi-BzBnj-b0-fm-b0-"
 
 
@@ -148,8 +150,12 @@
 	IWL_BNJ_B_GF_A_FW_PRE __stringify(api) ".ucode"
 #define IWL_BNJ_A_GF4_A_MODULE_FIRMWARE(api) \
 	IWL_BNJ_A_GF4_A_FW_PRE __stringify(api) ".ucode"
+#define IWL_BNJ_B_GF4_A_MODULE_FIRMWARE(api) \
+	IWL_BNJ_B_GF4_A_FW_PRE __stringify(api) ".ucode"
 #define IWL_BNJ_A_HR_B_MODULE_FIRMWARE(api) \
 	IWL_BNJ_A_HR_B_FW_PRE __stringify(api) ".ucode"
+#define IWL_BNJ_B_HR_B_MODULE_FIRMWARE(api) \
+	IWL_BNJ_B_HR_B_FW_PRE __stringify(api) ".ucode"
 #define IWL_BNJ_B_FM_B_MODULE_FIRMWARE(api) \
 	IWL_BNJ_B_FM_B_FW_PRE __stringify(api) ".ucode"
 
@@ -1058,6 +1064,14 @@ const struct iwl_cfg iwl_cfg_bnj_a0_gf4_a0 = {
 	.num_rbds = IWL_NUM_RBDS_AX210_HE,
 };
 
+const struct iwl_cfg iwl_cfg_bnj_b0_gf4_a0 = {
+	.fw_name_pre = IWL_BNJ_B_GF4_A_FW_PRE,
+	.uhb_supported = true,
+	IWL_DEVICE_BZ,
+	.features = IWL_TX_CSUM_NETIF_FLAGS | NETIF_F_RXCSUM,
+	.num_rbds = IWL_NUM_RBDS_AX210_HE,
+};
+
 const struct iwl_cfg iwl_cfg_bnj_a0_hr_b0 = {
 	.fw_name_pre = IWL_BNJ_A_HR_B_FW_PRE,
 	.uhb_supported = true,
@@ -1066,6 +1080,14 @@ const struct iwl_cfg iwl_cfg_bnj_a0_hr_b0 = {
 	.num_rbds = IWL_NUM_RBDS_AX210_HE,
 };
 
+const struct iwl_cfg iwl_cfg_bnj_b0_hr_b0 = {
+	.fw_name_pre = IWL_BNJ_B_HR_B_FW_PRE,
+	.uhb_supported = true,
+	IWL_DEVICE_BZ,
+	.features = IWL_TX_CSUM_NETIF_FLAGS | NETIF_F_RXCSUM,
+	.num_rbds = IWL_NUM_RBDS_AX210_HE,
+};
+
 const struct iwl_cfg iwl_cfg_bnj_b0_fm_b0 = {
 	.fw_name_pre = IWL_BNJ_B_FM_B_FW_PRE,
 	.uhb_supported = true,
@@ -1108,7 +1130,9 @@ MODULE_FIRMWARE(IWL_BNJ_B_FM4_B_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_BNJ_A_GF_A_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_BNJ_B_GF_A_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_BNJ_A_GF4_A_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
+MODULE_FIRMWARE(IWL_BNJ_B_GF4_A_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_BNJ_A_HR_B_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
+MODULE_FIRMWARE(IWL_BNJ_B_HR_B_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_BZ_A_FM4_A_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_BZ_A_FM4_B_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_GL_B_FM_B_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index a4c7fd929cc2..9b7b6fca2b1b 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -660,7 +660,9 @@ extern const struct iwl_cfg iwl_cfg_bnj_a0_fm4_a0;
 extern const struct iwl_cfg iwl_cfg_bnj_a0_gf_a0;
 extern const struct iwl_cfg iwl_cfg_bnj_b0_gf_a0;
 extern const struct iwl_cfg iwl_cfg_bnj_a0_gf4_a0;
+extern const struct iwl_cfg iwl_cfg_bnj_b0_gf4_a0;
 extern const struct iwl_cfg iwl_cfg_bnj_a0_hr_b0;
+extern const struct iwl_cfg iwl_cfg_bnj_b0_hr_b0;
 extern const struct iwl_cfg iwl_cfg_bnj_b0_fm_b0;
 extern const struct iwl_cfg iwl_cfg_bnj_b0_fm4_b0;
 #endif /* CONFIG_IWLMVM */
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 077983913acd..6c935d73943a 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -1219,15 +1219,25 @@ static const struct iwl_dev_info iwl_dev_info_table[] = {
 		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB, IWL_CFG_IS_JACKET,
 		      iwl_cfg_bnj_b0_gf_a0, iwl_bz_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_MAC_TYPE_GL, IWL_CFG_ANY,
+		      IWL_CFG_MAC_TYPE_GL, SILICON_A_STEP,
 		      IWL_CFG_RF_TYPE_GF, IWL_CFG_ANY,
 		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_CDB, IWL_CFG_IS_JACKET,
 		      iwl_cfg_bnj_a0_gf4_a0, iwl_bz_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_MAC_TYPE_GL, IWL_CFG_ANY,
+		      IWL_CFG_MAC_TYPE_GL, SILICON_B_STEP,
+		      IWL_CFG_RF_TYPE_GF, IWL_CFG_ANY,
+		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_CDB, IWL_CFG_IS_JACKET,
+		      iwl_cfg_bnj_b0_gf4_a0, iwl_bz_name),
+	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_MAC_TYPE_GL, SILICON_A_STEP,
 		      IWL_CFG_RF_TYPE_HR1, IWL_CFG_ANY,
 		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB, IWL_CFG_IS_JACKET,
 		      iwl_cfg_bnj_a0_hr_b0, iwl_bz_name),
+	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_MAC_TYPE_GL, SILICON_B_STEP,
+		      IWL_CFG_RF_TYPE_HR1, IWL_CFG_ANY,
+		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB, IWL_CFG_NO_JACKET,
+		      iwl_cfg_bnj_b0_hr_b0, iwl_bz_name),
 
 /* SoF with JF2 */
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
-- 
2.38.1

