Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FF8D73819B
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Jun 2023 13:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbjFUKOn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Jun 2023 06:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232444AbjFUKOD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Jun 2023 06:14:03 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B967170A
        for <linux-wireless@vger.kernel.org>; Wed, 21 Jun 2023 03:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687342434; x=1718878434;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3kguiE9pX8IzX/xHLNo3eAvbvRNyWTdqOZsJXGXfkj4=;
  b=AVTzLqsG/FipUxv380k5C8yUAFCNJ8I2OtFaswcpDcMYIctKoOOWpXJj
   //lO01ljc5s6DhX7v6Qr8mbQYAI2FaMHPikRPiScqMwula2c0GI9cjgAF
   Fcu5mTJiMDoXyqoZUihO8EBhPQboWEDddGNsX5iCet9vUsaka82THje6k
   qTRa3/amyG8/VG3q2rOosPzI6sDE23V7Zck4YfCsO1N4fh4MHAm25IVZY
   y2YDkSBz0dBK4xPTlCkyKqBJR7ZBNrCCDLxlSTcnX9rS1YV5lqdwUND53
   A7eO8Zzg5pFMcU5yhYsiXfwwDFlKhHNBsCSm+FxhY2naScyE/9ftSKXtQ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="446506528"
X-IronPort-AV: E=Sophos;i="6.00,260,1681196400"; 
   d="scan'208";a="446506528"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2023 03:13:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="664599325"
X-IronPort-AV: E=Sophos;i="6.00,260,1681196400"; 
   d="scan'208";a="664599325"
Received: from ggreenma-mobl2.jer.intel.com ([10.13.17.65])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2023 03:13:29 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Mukesh Sisodiya <mukesh.sisodiya@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 18/18] wifi: iwlwifi: remove support of A0 version of FM RF
Date:   Wed, 21 Jun 2023 13:12:22 +0300
Message-Id: <20230621130444.269d55ffbc8e.I4740f32c3d95d4474a82cc153891c92b9bc465db@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230621101222.218083-1-gregory.greenman@intel.com>
References: <20230621101222.218083-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Mukesh Sisodiya <mukesh.sisodiya@intel.com>

Remove the support for A0 step of latest wifi-7
FM RF as it is no longer supported.

Signed-off-by: Mukesh Sisodiya <mukesh.sisodiya@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 .../net/wireless/intel/iwlwifi/cfg/ax210.c    |  8 -----
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c   | 30 +------------------
 .../net/wireless/intel/iwlwifi/iwl-config.h   |  1 -
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c |  5 ----
 4 files changed, 1 insertion(+), 43 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c b/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c
index 73736f7372d2..8d5f9dce71d5 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c
@@ -36,12 +36,10 @@
 #define IWL_MA_A_GF_A_FW_PRE		"iwlwifi-ma-a0-gf-a0"
 #define IWL_MA_A_GF4_A_FW_PRE		"iwlwifi-ma-a0-gf4-a0"
 #define IWL_MA_A_MR_A_FW_PRE		"iwlwifi-ma-a0-mr-a0"
-#define IWL_MA_A_FM_A_FW_PRE		"iwlwifi-ma-a0-fm-a0"
 #define IWL_MA_B_HR_B_FW_PRE		"iwlwifi-ma-b0-hr-b0"
 #define IWL_MA_B_GF_A_FW_PRE		"iwlwifi-ma-b0-gf-a0"
 #define IWL_MA_B_GF4_A_FW_PRE		"iwlwifi-ma-b0-gf4-a0"
 #define IWL_MA_B_MR_A_FW_PRE		"iwlwifi-ma-b0-mr-a0"
-#define IWL_MA_B_FM_A_FW_PRE		"iwlwifi-ma-b0-fm-a0"
 
 #define IWL_SO_A_JF_B_MODULE_FIRMWARE(api) \
 	IWL_SO_A_JF_B_FW_PRE "-" __stringify(api) ".ucode"
@@ -59,8 +57,6 @@
 	IWL_MA_A_GF4_A_FW_PRE "-" __stringify(api) ".ucode"
 #define IWL_MA_A_MR_A_FW_MODULE_FIRMWARE(api) \
 	IWL_MA_A_MR_A_FW_PRE "-" __stringify(api) ".ucode"
-#define IWL_MA_A_FM_A_FW_MODULE_FIRMWARE(api)		\
-	IWL_MA_A_FM_A_FW_PRE "-" __stringify(api) ".ucode"
 #define IWL_MA_B_HR_B_FW_MODULE_FIRMWARE(api)		\
 	IWL_MA_B_HR_B_FW_PRE "-" __stringify(api) ".ucode"
 #define IWL_MA_B_GF_A_FW_MODULE_FIRMWARE(api)		\
@@ -69,8 +65,6 @@
 	IWL_MA_B_GF4_A_FW_PRE "-" __stringify(api) ".ucode"
 #define IWL_MA_B_MR_A_FW_MODULE_FIRMWARE(api) \
 	IWL_MA_B_MR_A_FW_PRE "-" __stringify(api) ".ucode"
-#define IWL_MA_B_FM_A_FW_MODULE_FIRMWARE(api)		\
-	IWL_MA_B_FM_A_FW_PRE "-" __stringify(api) ".ucode"
 
 static const struct iwl_base_params iwl_ax210_base_params = {
 	.eeprom_size = OTP_LOW_IMAGE_SIZE_32K,
@@ -301,9 +295,7 @@ MODULE_FIRMWARE(IWL_MA_A_HR_B_FW_MODULE_FIRMWARE(IWL_AX210_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_MA_A_GF_A_FW_MODULE_FIRMWARE(IWL_AX210_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_MA_A_GF4_A_FW_MODULE_FIRMWARE(IWL_AX210_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_MA_A_MR_A_FW_MODULE_FIRMWARE(IWL_AX210_UCODE_API_MAX));
-MODULE_FIRMWARE(IWL_MA_A_FM_A_FW_MODULE_FIRMWARE(IWL_AX210_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_MA_B_HR_B_FW_MODULE_FIRMWARE(IWL_AX210_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_MA_B_GF_A_FW_MODULE_FIRMWARE(IWL_AX210_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_MA_B_GF4_A_FW_MODULE_FIRMWARE(IWL_AX210_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_MA_B_MR_A_FW_MODULE_FIRMWARE(IWL_AX210_UCODE_API_MAX));
-MODULE_FIRMWARE(IWL_MA_B_FM_A_FW_MODULE_FIRMWARE(IWL_AX210_UCODE_API_MAX));
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
index c15dcd9bc323..b9893b22e41d 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
@@ -29,12 +29,9 @@
 #define IWL_BZ_A_HR_B_FW_PRE		"iwlwifi-bz-a0-hr-b0"
 #define IWL_BZ_A_GF_A_FW_PRE		"iwlwifi-bz-a0-gf-a0"
 #define IWL_BZ_A_GF4_A_FW_PRE		"iwlwifi-bz-a0-gf4-a0"
-#define IWL_BZ_A_FM_A_FW_PRE		"iwlwifi-bz-a0-fm-a0"
-#define IWL_BZ_A_FM4_A_FW_PRE		"iwlwifi-bz-a0-fm4-a0"
 #define IWL_BZ_A_FM_B_FW_PRE		"iwlwifi-bz-a0-fm-b0"
 #define IWL_BZ_A_FM_C_FW_PRE		"iwlwifi-bz-a0-fm-c0"
 #define IWL_BZ_A_FM4_B_FW_PRE		"iwlwifi-bz-a0-fm4-b0"
-#define IWL_GL_A_FM_A_FW_PRE		"iwlwifi-gl-a0-fm-a0"
 #define IWL_GL_B_FM_B_FW_PRE		"iwlwifi-gl-b0-fm-b0"
 #define IWL_GL_C_FM_C_FW_PRE		"iwlwifi-gl-c0-fm-c0"
 
@@ -44,18 +41,12 @@
 	IWL_BZ_A_GF_A_FW_PRE "-" __stringify(api) ".ucode"
 #define IWL_BZ_A_GF4_A_MODULE_FIRMWARE(api) \
 	IWL_BZ_A_GF4_A_FW_PRE "-" __stringify(api) ".ucode"
-#define IWL_BZ_A_FM_A_MODULE_FIRMWARE(api) \
-	IWL_BZ_A_FM_A_FW_PRE "-" __stringify(api) ".ucode"
-#define IWL_BZ_A_FM4_A_MODULE_FIRMWARE(api) \
-	IWL_BZ_A_FM4_A_FW_PRE "-" __stringify(api) ".ucode"
 #define IWL_BZ_A_FM_B_MODULE_FIRMWARE(api) \
 	IWL_BZ_A_FM_B_FW_PRE "-" __stringify(api) ".ucode"
 #define IWL_BZ_A_FM_C_MODULE_FIRMWARE(api) \
-		IWL_BZ_A_FM_C_FW_PRE "-" __stringify(api) ".ucode"
+	IWL_BZ_A_FM_C_FW_PRE "-" __stringify(api) ".ucode"
 #define IWL_BZ_A_FM4_B_MODULE_FIRMWARE(api) \
 	IWL_BZ_A_FM4_B_FW_PRE "-" __stringify(api) ".ucode"
-#define IWL_GL_A_FM_A_MODULE_FIRMWARE(api) \
-	IWL_GL_A_FM_A_FW_PRE "-" __stringify(api) ".ucode"
 #define IWL_GL_B_FM_B_MODULE_FIRMWARE(api) \
 	IWL_GL_B_FM_B_FW_PRE "-" __stringify(api) ".ucode"
 #define IWL_GL_C_FM_C_MODULE_FIRMWARE(api) \
@@ -73,13 +64,6 @@ static const struct iwl_base_params iwl_bz_base_params = {
 	.pcie_l1_allowed = true,
 };
 
-static const struct iwl_ht_params iwl_gl_a_ht_params = {
-	.stbc = false, /* we explicitly disable STBC for GL step A */
-	.ldpc = true,
-	.ht40_bands = BIT(NL80211_BAND_2GHZ) | BIT(NL80211_BAND_5GHZ) |
-		      BIT(NL80211_BAND_6GHZ),
-};
-
 #define IWL_DEVICE_BZ_COMMON						\
 	.ucode_api_max = IWL_BZ_UCODE_API_MAX,			\
 	.ucode_api_min = IWL_BZ_UCODE_API_MIN,			\
@@ -180,14 +164,6 @@ const struct iwl_cfg iwl_cfg_bz = {
 	.num_rbds = IWL_NUM_RBDS_BZ_HE,
 };
 
-const struct iwl_cfg iwl_cfg_gl_a0_fm_a0 = {
-	.fw_name_pre = IWL_GL_A_FM_A_FW_PRE,
-	.uhb_supported = true,
-	IWL_DEVICE_GL_A,
-	.features = IWL_TX_CSUM_NETIF_FLAGS | NETIF_F_RXCSUM,
-	.num_rbds = IWL_NUM_RBDS_BZ_HE,
-};
-
 const struct iwl_cfg iwl_cfg_gl = {
 	.fw_name_mac = "gl",
 	.uhb_supported = true,
@@ -200,12 +176,8 @@ const struct iwl_cfg iwl_cfg_gl = {
 MODULE_FIRMWARE(IWL_BZ_A_HR_B_MODULE_FIRMWARE(IWL_BZ_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_BZ_A_GF_A_MODULE_FIRMWARE(IWL_BZ_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_BZ_A_GF4_A_MODULE_FIRMWARE(IWL_BZ_UCODE_API_MAX));
-MODULE_FIRMWARE(IWL_BZ_A_FM_A_MODULE_FIRMWARE(IWL_BZ_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_BZ_A_FM_B_MODULE_FIRMWARE(IWL_BZ_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_BZ_A_FM_C_MODULE_FIRMWARE(IWL_BZ_UCODE_API_MAX));
-MODULE_FIRMWARE(IWL_BZ_A_FM4_A_MODULE_FIRMWARE(IWL_BZ_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_BZ_A_FM4_B_MODULE_FIRMWARE(IWL_BZ_UCODE_API_MAX));
-
-MODULE_FIRMWARE(IWL_GL_A_FM_A_MODULE_FIRMWARE(IWL_BZ_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_GL_B_FM_B_MODULE_FIRMWARE(IWL_BZ_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_GL_C_FM_C_MODULE_FIRMWARE(IWL_BZ_UCODE_API_MAX));
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index 1c0cfbb6c427..742096c5a36a 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -640,7 +640,6 @@ extern const struct iwl_cfg iwl_cfg_so_a0_ms_a0;
 extern const struct iwl_cfg iwl_cfg_quz_a0_hr_b0;
 
 extern const struct iwl_cfg iwl_cfg_bz;
-extern const struct iwl_cfg iwl_cfg_gl_a0_fm_a0;
 extern const struct iwl_cfg iwl_cfg_gl;
 
 extern const struct iwl_cfg iwl_cfg_sc;
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index d3e0ea6aeb41..f46cafb538db 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -1008,11 +1008,6 @@ static const struct iwl_dev_info iwl_dev_info_table[] = {
 		      IWL_CFG_RF_TYPE_FM, IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB,
 		      iwl_cfg_gl, iwl_bz_name),
-	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_MAC_TYPE_GL, SILICON_A_STEP,
-		      IWL_CFG_RF_TYPE_FM, IWL_CFG_ANY, SILICON_A_STEP,
-		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB,
-		      iwl_cfg_gl_a0_fm_a0, iwl_bz_name),
 
 /* SoF with JF2 */
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
-- 
2.38.1

