Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D66A26B9D99
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Mar 2023 18:54:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbjCNRye (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Mar 2023 13:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbjCNRyc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Mar 2023 13:54:32 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B143F1CBF5
        for <linux-wireless@vger.kernel.org>; Tue, 14 Mar 2023 10:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678816461; x=1710352461;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wn1um4dCHNMRftBdRc1BnTT+NoUxkQaQTsPhBC1iTRc=;
  b=E9VcJg/fF7pRrvFZDw/xpMtNrfpiqAHmpkjvR7xmXsGQvWRch3e4RMGt
   uXappj5sO3eB3QWCvBP+iB2tGJPgGty4VKW3fYIzYwb51GcVHGoXGgVkK
   BWakDHKplFzZpiUL5pu7tpOb/f2nwDYQPyDgi986HAdAsiIA3cLup1SFI
   R1yOUFw7WSYzRghcdd105qv/gborq1gSE29A0jY4/YAcKxiW08QI7JBUH
   jPu0s3VaoI8mTcRi7JnOtsVHQLyz5TsgTMuA+BTsv1JRqro6BjfxUiEFK
   0bsNifIENdQ8AaK1FKSq2GzGiVaJJSHVMjh8ze6L/P4rw1DnSTiwt9nfS
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="317149745"
X-IronPort-AV: E=Sophos;i="5.98,260,1673942400"; 
   d="scan'208";a="317149745"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2023 10:50:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="768200598"
X-IronPort-AV: E=Sophos;i="5.98,260,1673942400"; 
   d="scan'208";a="768200598"
Received: from litalcoh-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.192.4])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2023 10:50:36 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Mukesh Sisodiya <mukesh.sisodiya@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 21/22] wifi: iwlwifi: Update configurations for Bnj and Bz devices
Date:   Tue, 14 Mar 2023 19:49:33 +0200
Message-Id: <20230314194113.14c373dcfe15.I96b96a8b149ac181e962f4b82e0d15b172823d0f@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230314174934.893149-1-gregory.greenman@intel.com>
References: <20230314174934.893149-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Mukesh Sisodiya <mukesh.sisodiya@intel.com>

Add missing rf support for Bz device and B-Step for BnJ device

Signed-off-by: Mukesh Sisodiya <mukesh.sisodiya@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 .../net/wireless/intel/iwlwifi/cfg/22000.c    | 36 +++++++++++++++++++
 .../net/wireless/intel/iwlwifi/iwl-config.h   |  3 ++
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 15 ++++++++
 3 files changed, 54 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
index 43fb5cf85f05..bc33d19ca08d 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
@@ -57,6 +57,8 @@
 #define IWL_BZ_A_MR_A_FW_PRE		"iwlwifi-bz-a0-mr-a0-"
 #define IWL_BZ_A_FM_A_FW_PRE		"iwlwifi-bz-a0-fm-a0-"
 #define IWL_BZ_A_FM4_A_FW_PRE		"iwlwifi-bz-a0-fm4-a0-"
+#define IWL_BZ_A_FM_B_FW_PRE		"iwlwifi-bz-a0-fm-b0-"
+#define IWL_BZ_A_FM4_B_FW_PRE		"iwlwifi-bz-a0-fm4-b0-"
 #define IWL_GL_A_FM_A_FW_PRE		"iwlwifi-gl-a0-fm-a0-"
 #define IWL_GL_B_FM_B_FW_PRE		"iwlwifi-gl-b0-fm-b0-"
 #define IWL_BZ_Z_GF_A_FW_PRE		"iwlwifi-bz-z0-gf-a0-"
@@ -64,6 +66,7 @@
 #define IWL_BNJ_A_FM4_A_FW_PRE		"iwlwifi-BzBnj-a0-fm4-a0-"
 #define IWL_BNJ_B_FM4_B_FW_PRE		"iwlwifi-BzBnj-b0-fm4-b0-"
 #define IWL_BNJ_A_GF_A_FW_PRE		"iwlwifi-BzBnj-a0-gf-a0-"
+#define IWL_BNJ_B_GF_A_FW_PRE		"iwlwifi-BzBnj-b0-gf-a0-"
 #define IWL_BNJ_A_GF4_A_FW_PRE		"iwlwifi-BzBnj-a0-gf4-a0-"
 #define IWL_BNJ_A_HR_B_FW_PRE		"iwlwifi-BzBnj-a0-hr-b0-"
 #define IWL_BNJ_B_FM_B_FW_PRE		"iwlwifi-BzBnj-b0-fm-b0-"
@@ -125,6 +128,10 @@
 		IWL_BZ_A_FM_A_FW_PRE __stringify(api) ".ucode"
 #define IWL_BZ_A_FM4_A_MODULE_FIRMWARE(api) \
 		IWL_BZ_A_FM4_A_FW_PRE __stringify(api) ".ucode"
+#define IWL_BZ_A_FM_B_MODULE_FIRMWARE(api) \
+		IWL_BZ_A_FM_B_FW_PRE __stringify(api) ".ucode"
+#define IWL_BZ_A_FM4_B_MODULE_FIRMWARE(api) \
+		IWL_BZ_A_FM4_B_FW_PRE __stringify(api) ".ucode"
 #define IWL_GL_A_FM_A_MODULE_FIRMWARE(api) \
 		IWL_GL_A_FM_A_FW_PRE __stringify(api) ".ucode"
 #define IWL_GL_B_FM_B_MODULE_FIRMWARE(api) \
@@ -137,6 +144,8 @@
 	IWL_BNJ_B_FM4_B_FW_PRE __stringify(api) ".ucode"
 #define IWL_BNJ_A_GF_A_MODULE_FIRMWARE(api) \
 	IWL_BNJ_A_GF_A_FW_PRE __stringify(api) ".ucode"
+#define IWL_BNJ_B_GF_A_MODULE_FIRMWARE(api) \
+	IWL_BNJ_B_GF_A_FW_PRE __stringify(api) ".ucode"
 #define IWL_BNJ_A_GF4_A_MODULE_FIRMWARE(api) \
 	IWL_BNJ_A_GF4_A_FW_PRE __stringify(api) ".ucode"
 #define IWL_BNJ_A_HR_B_MODULE_FIRMWARE(api) \
@@ -961,6 +970,22 @@ const struct iwl_cfg iwl_cfg_bz_a0_fm4_a0 = {
 	.num_rbds = IWL_NUM_RBDS_AX210_HE,
 };
 
+const struct iwl_cfg iwl_cfg_bz_a0_fm_b0 = {
+	.fw_name_pre = IWL_BZ_A_FM_B_FW_PRE,
+	.uhb_supported = true,
+	IWL_DEVICE_BZ,
+	.features = IWL_TX_CSUM_NETIF_FLAGS_BZ | NETIF_F_RXCSUM,
+	.num_rbds = IWL_NUM_RBDS_AX210_HE,
+};
+
+const struct iwl_cfg iwl_cfg_bz_a0_fm4_b0 = {
+	.fw_name_pre = IWL_BZ_A_FM4_B_FW_PRE,
+	.uhb_supported = true,
+	IWL_DEVICE_BZ,
+	.features = IWL_TX_CSUM_NETIF_FLAGS_BZ | NETIF_F_RXCSUM,
+	.num_rbds = IWL_NUM_RBDS_AX210_HE,
+};
+
 const struct iwl_cfg iwl_cfg_gl_a0_fm_a0 = {
 	.fw_name_pre = IWL_GL_A_FM_A_FW_PRE,
 	.uhb_supported = true,
@@ -1017,6 +1042,14 @@ const struct iwl_cfg iwl_cfg_bnj_a0_gf_a0 = {
 	.num_rbds = IWL_NUM_RBDS_AX210_HE,
 };
 
+const struct iwl_cfg iwl_cfg_bnj_b0_gf_a0 = {
+	.fw_name_pre = IWL_BNJ_B_GF_A_FW_PRE,
+	.uhb_supported = true,
+	IWL_DEVICE_BZ,
+	.features = IWL_TX_CSUM_NETIF_FLAGS | NETIF_F_RXCSUM,
+	.num_rbds = IWL_NUM_RBDS_AX210_HE,
+};
+
 const struct iwl_cfg iwl_cfg_bnj_a0_gf4_a0 = {
 	.fw_name_pre = IWL_BNJ_A_GF4_A_FW_PRE,
 	.uhb_supported = true,
@@ -1067,13 +1100,16 @@ MODULE_FIRMWARE(IWL_BZ_A_GF_A_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_BZ_A_GF4_A_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_BZ_A_MR_A_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_BZ_A_FM_A_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
+MODULE_FIRMWARE(IWL_BZ_A_FM_B_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_GL_A_FM_A_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_BNJ_A_FM_A_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_BNJ_A_FM4_A_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_BNJ_B_FM4_B_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_BNJ_A_GF_A_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
+MODULE_FIRMWARE(IWL_BNJ_B_GF_A_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_BNJ_A_GF4_A_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_BNJ_A_HR_B_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_BZ_A_FM4_A_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
+MODULE_FIRMWARE(IWL_BZ_A_FM4_B_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_GL_B_FM_B_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_BNJ_B_FM_B_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index eaa0ff2736c5..a4c7fd929cc2 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -650,12 +650,15 @@ extern const struct iwl_cfg iwl_cfg_bz_a0_gf4_a0;
 extern const struct iwl_cfg iwl_cfg_bz_a0_mr_a0;
 extern const struct iwl_cfg iwl_cfg_bz_a0_fm_a0;
 extern const struct iwl_cfg iwl_cfg_bz_a0_fm4_a0;
+extern const struct iwl_cfg iwl_cfg_bz_a0_fm_b0;
+extern const struct iwl_cfg iwl_cfg_bz_a0_fm4_b0;
 extern const struct iwl_cfg iwl_cfg_gl_a0_fm_a0;
 extern const struct iwl_cfg iwl_cfg_gl_b0_fm_b0;
 extern const struct iwl_cfg iwl_cfg_bz_z0_gf_a0;
 extern const struct iwl_cfg iwl_cfg_bnj_a0_fm_a0;
 extern const struct iwl_cfg iwl_cfg_bnj_a0_fm4_a0;
 extern const struct iwl_cfg iwl_cfg_bnj_a0_gf_a0;
+extern const struct iwl_cfg iwl_cfg_bnj_b0_gf_a0;
 extern const struct iwl_cfg iwl_cfg_bnj_a0_gf4_a0;
 extern const struct iwl_cfg iwl_cfg_bnj_a0_hr_b0;
 extern const struct iwl_cfg iwl_cfg_bnj_b0_fm_b0;
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 8aa8a678475c..077983913acd 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -1159,6 +1159,16 @@ static const struct iwl_dev_info iwl_dev_info_table[] = {
 		      IWL_CFG_RF_TYPE_FM, IWL_CFG_ANY,
 		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_CDB, IWL_CFG_NO_JACKET,
 		      iwl_cfg_bz_a0_fm4_a0, iwl_bz_name),
+	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_MAC_TYPE_BZ, IWL_CFG_ANY,
+		      IWL_CFG_RF_TYPE_FM, IWL_CFG_ANY,
+		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB, IWL_CFG_IS_JACKET,
+		      iwl_cfg_bz_a0_fm_b0, iwl_bz_name),
+	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_MAC_TYPE_BZ, IWL_CFG_ANY,
+		      IWL_CFG_RF_TYPE_FM, IWL_CFG_ANY,
+		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_CDB, IWL_CFG_IS_JACKET,
+		      iwl_cfg_bz_a0_fm4_b0, iwl_bz_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_GL, SILICON_A_STEP,
 		      IWL_CFG_RF_TYPE_FM, IWL_CFG_ANY,
@@ -1203,6 +1213,11 @@ static const struct iwl_dev_info iwl_dev_info_table[] = {
 		      IWL_CFG_RF_TYPE_GF, IWL_CFG_ANY,
 		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB, IWL_CFG_IS_JACKET,
 		      iwl_cfg_bnj_a0_gf_a0, iwl_bz_name),
+	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_MAC_TYPE_GL, SILICON_B_STEP,
+		      IWL_CFG_RF_TYPE_GF, IWL_CFG_ANY,
+		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB, IWL_CFG_IS_JACKET,
+		      iwl_cfg_bnj_b0_gf_a0, iwl_bz_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_GL, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_GF, IWL_CFG_ANY,
-- 
2.38.1

