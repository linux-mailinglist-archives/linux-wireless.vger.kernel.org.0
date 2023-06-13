Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCCD172E37E
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jun 2023 14:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240555AbjFMM6H (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 13 Jun 2023 08:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240997AbjFMM6B (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 13 Jun 2023 08:58:01 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF6341BC7
        for <linux-wireless@vger.kernel.org>; Tue, 13 Jun 2023 05:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686661075; x=1718197075;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qILn5VB8xhimBR3cd0l5Y3IKau7YuXPOfKat5yd1+xs=;
  b=kxAX9mWeCLml9+PXHAZaR9OGxvGvM95Y81W+qG95T8UHnUD9gnlUPoI7
   prEHT6ndSv2ScwaPRe05U6Vl1iZ8HBJdwMLc3PjJRzblYrQS8v5UsVKVZ
   fCA8T6tsE5Xfk809Rihz8kVAAkPE1M+6fOSPh8KmGJwnsx/SoPQUdnY9d
   jev3WAfZNxi0rGs49TYV/a8ZoTOPh8AJV4DGV7N7mZU8c8NK+K4PWJGZQ
   HTv9grQ0zWxIQ7IUkq6SZtvmlD1cQtQvJZCVtMpcuYAuvU2ERqVgJMrbx
   vQvoLJYPhDvUHfllFIkm+vULpXyhCfGydd2V8tsLVU+1Lk2SzbV2Nqd5r
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="347973740"
X-IronPort-AV: E=Sophos;i="6.00,239,1681196400"; 
   d="scan'208";a="347973740"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 05:57:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="835880805"
X-IronPort-AV: E=Sophos;i="6.00,239,1681196400"; 
   d="scan'208";a="835880805"
Received: from slerer-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.249.90.17])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 05:57:53 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Mukesh Sisodiya <mukesh.sisodiya@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 07/14] wifi: iwlwifi: support version C0 of BZ and GL devices
Date:   Tue, 13 Jun 2023 15:57:20 +0300
Message-Id: <20230613155501.90ad8aab8a03.I86d1675095f0e4f5286d9b7c2b00a0220f524472@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230613125727.300445-1-gregory.greenman@intel.com>
References: <20230613125727.300445-1-gregory.greenman@intel.com>
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

From: Mukesh Sisodiya <mukesh.sisodiya@intel.com>

Add support for C0 version of MAC and RF for BZ and GL devices.

Signed-off-by: Mukesh Sisodiya <mukesh.sisodiya@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 .../net/wireless/intel/iwlwifi/cfg/22000.c    | 27 +++++++++++++++++++
 .../net/wireless/intel/iwlwifi/iwl-config.h   |  2 ++
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 14 ++++++++--
 3 files changed, 41 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
index fce4fcdc4dfb..29dded1531a0 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
@@ -65,9 +65,12 @@
 #define IWL_BZ_A_FM_A_FW_PRE		"iwlwifi-bz-a0-fm-a0-"
 #define IWL_BZ_A_FM4_A_FW_PRE		"iwlwifi-bz-a0-fm4-a0-"
 #define IWL_BZ_A_FM_B_FW_PRE		"iwlwifi-bz-a0-fm-b0-"
+#define IWL_BZ_A_FM_C_FW_PRE		"iwlwifi-bz-a0-fm-c0-"
 #define IWL_BZ_A_FM4_B_FW_PRE		"iwlwifi-bz-a0-fm4-b0-"
 #define IWL_GL_A_FM_A_FW_PRE		"iwlwifi-gl-a0-fm-a0-"
 #define IWL_GL_B_FM_B_FW_PRE		"iwlwifi-gl-b0-fm-b0-"
+#define IWL_GL_C_FM_C_FW_PRE		"iwlwifi-gl-c0-fm-c0-"
+
 #define IWL_BZ_Z_GF_A_FW_PRE		"iwlwifi-bz-z0-gf-a0-"
 #define IWL_BNJ_A_FM_A_FW_PRE		"iwlwifi-BzBnj-a0-fm-a0-"
 #define IWL_BNJ_A_FM4_A_FW_PRE		"iwlwifi-BzBnj-a0-fm4-a0-"
@@ -153,12 +156,16 @@
 	IWL_BZ_A_FM4_A_FW_PRE __stringify(api) ".ucode"
 #define IWL_BZ_A_FM_B_MODULE_FIRMWARE(api) \
 	IWL_BZ_A_FM_B_FW_PRE __stringify(api) ".ucode"
+#define IWL_BZ_A_FM_C_MODULE_FIRMWARE(api) \
+		IWL_BZ_A_FM_C_FW_PRE __stringify(api) ".ucode"
 #define IWL_BZ_A_FM4_B_MODULE_FIRMWARE(api) \
 	IWL_BZ_A_FM4_B_FW_PRE __stringify(api) ".ucode"
 #define IWL_GL_A_FM_A_MODULE_FIRMWARE(api) \
 	IWL_GL_A_FM_A_FW_PRE __stringify(api) ".ucode"
 #define IWL_GL_B_FM_B_MODULE_FIRMWARE(api) \
 	IWL_GL_B_FM_B_FW_PRE __stringify(api) ".ucode"
+#define IWL_GL_C_FM_C_MODULE_FIRMWARE(api) \
+	IWL_GL_C_FM_C_FW_PRE __stringify(api) ".ucode"
 #define IWL_BNJ_A_FM_A_MODULE_FIRMWARE(api) \
 	IWL_BNJ_A_FM_A_FW_PRE __stringify(api) ".ucode"
 #define IWL_BNJ_A_FM4_A_MODULE_FIRMWARE(api) \
@@ -173,6 +180,7 @@
 	IWL_BNJ_A_GF4_A_FW_PRE __stringify(api) ".ucode"
 #define IWL_BNJ_B_GF4_A_MODULE_FIRMWARE(api) \
 	IWL_BNJ_B_GF4_A_FW_PRE __stringify(api) ".ucode"
+
 #define IWL_BNJ_A_HR_A_MODULE_FIRMWARE(api) \
 	IWL_BNJ_A_HR_A_FW_PRE __stringify(api) ".ucode"
 #define IWL_BNJ_A_HR_B_MODULE_FIRMWARE(api) \
@@ -1053,6 +1061,14 @@ const struct iwl_cfg iwl_cfg_bz_a0_fm_b0 = {
 	.num_rbds = IWL_NUM_RBDS_AX210_HE,
 };
 
+const struct iwl_cfg iwl_cfg_bz_a0_fm_c0 = {
+	.fw_name_pre = IWL_BZ_A_FM_C_FW_PRE,
+	.uhb_supported = true,
+	IWL_DEVICE_BZ,
+	.features = IWL_TX_CSUM_NETIF_FLAGS_BZ | NETIF_F_RXCSUM,
+	.num_rbds = IWL_NUM_RBDS_AX210_HE,
+};
+
 const struct iwl_cfg iwl_cfg_bz_a0_fm4_b0 = {
 	.fw_name_pre = IWL_BZ_A_FM4_B_FW_PRE,
 	.uhb_supported = true,
@@ -1077,6 +1093,14 @@ const struct iwl_cfg iwl_cfg_gl_b0_fm_b0 = {
 	.num_rbds = IWL_NUM_RBDS_AX210_HE,
 };
 
+const struct iwl_cfg iwl_cfg_gl_c0_fm_c0 = {
+	.fw_name_pre = IWL_GL_C_FM_C_FW_PRE,
+	.uhb_supported = true,
+	IWL_DEVICE_BZ,
+	.features = IWL_TX_CSUM_NETIF_FLAGS_BZ | NETIF_F_RXCSUM,
+	.num_rbds = IWL_NUM_RBDS_AX210_HE,
+};
+
 const struct iwl_cfg iwl_cfg_bz_z0_gf_a0 = {
 	.fw_name_pre = IWL_BZ_Z_GF_A_FW_PRE,
 	.uhb_supported = true,
@@ -1180,6 +1204,7 @@ const struct iwl_cfg iwl_cfg_bnj_b0_fm_b0 = {
 	.features = IWL_TX_CSUM_NETIF_FLAGS_BZ | NETIF_F_RXCSUM,
 	.num_rbds = IWL_NUM_RBDS_AX210_HE,
 };
+
 MODULE_FIRMWARE(IWL_QU_B_HR_B_MODULE_FIRMWARE(IWL_22500_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_QNJ_B_HR_B_MODULE_FIRMWARE(IWL_22500_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_QU_C_HR_B_MODULE_FIRMWARE(IWL_22500_UCODE_API_MAX));
@@ -1214,6 +1239,7 @@ MODULE_FIRMWARE(IWL_BZ_A_GF4_A_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_BZ_A_MR_A_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_BZ_A_FM_A_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_BZ_A_FM_B_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
+MODULE_FIRMWARE(IWL_BZ_A_FM_C_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_GL_A_FM_A_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_BNJ_A_FM_A_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_BNJ_A_FM4_A_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
@@ -1228,4 +1254,5 @@ MODULE_FIRMWARE(IWL_BNJ_B_HR_B_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_BZ_A_FM4_A_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_BZ_A_FM4_B_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_GL_B_FM_B_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
+MODULE_FIRMWARE(IWL_GL_C_FM_C_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_BNJ_B_FM_B_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index 411b7d4fcc9a..17c357634455 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -658,9 +658,11 @@ extern const struct iwl_cfg iwl_cfg_bz_a0_mr_a0;
 extern const struct iwl_cfg iwl_cfg_bz_a0_fm_a0;
 extern const struct iwl_cfg iwl_cfg_bz_a0_fm4_a0;
 extern const struct iwl_cfg iwl_cfg_bz_a0_fm_b0;
+extern const struct iwl_cfg iwl_cfg_bz_a0_fm_c0;
 extern const struct iwl_cfg iwl_cfg_bz_a0_fm4_b0;
 extern const struct iwl_cfg iwl_cfg_gl_a0_fm_a0;
 extern const struct iwl_cfg iwl_cfg_gl_b0_fm_b0;
+extern const struct iwl_cfg iwl_cfg_gl_c0_fm_c0;
 extern const struct iwl_cfg iwl_cfg_bz_z0_gf_a0;
 extern const struct iwl_cfg iwl_cfg_bnj_a0_fm_a0;
 extern const struct iwl_cfg iwl_cfg_bnj_a0_fm4_a0;
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index dba112394838..fcc0f3319bcd 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -1198,12 +1198,17 @@ static const struct iwl_dev_info iwl_dev_info_table[] = {
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_BZ, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_FM, IWL_CFG_ANY, SILICON_B_STEP,
-		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB, IWL_CFG_IS_JACKET,
+		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB, IWL_CFG_NO_JACKET,
 		      iwl_cfg_bz_a0_fm_b0, iwl_bz_name),
+	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_MAC_TYPE_BZ, IWL_CFG_ANY,
+		      IWL_CFG_RF_TYPE_FM, IWL_CFG_ANY, SILICON_C_STEP,
+		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB, IWL_CFG_NO_JACKET,
+		      iwl_cfg_bz_a0_fm_c0, iwl_bz_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_BZ, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_FM, IWL_CFG_ANY, SILICON_B_STEP,
-		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_CDB, IWL_CFG_IS_JACKET,
+		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_CDB, IWL_CFG_NO_JACKET,
 		      iwl_cfg_bz_a0_fm4_b0, iwl_bz_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_GL, SILICON_A_STEP,
@@ -1215,6 +1220,11 @@ static const struct iwl_dev_info iwl_dev_info_table[] = {
 		      IWL_CFG_RF_TYPE_FM, IWL_CFG_ANY, SILICON_B_STEP,
 		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB, IWL_CFG_NO_JACKET,
 		      iwl_cfg_gl_b0_fm_b0, iwl_bz_name),
+	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_MAC_TYPE_GL, SILICON_C_STEP,
+		      IWL_CFG_RF_TYPE_FM, IWL_CFG_ANY, SILICON_C_STEP,
+		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB, IWL_CFG_NO_JACKET,
+		      iwl_cfg_gl_c0_fm_c0, iwl_bz_name),
 
 /* BZ Z step */
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
-- 
2.38.1

