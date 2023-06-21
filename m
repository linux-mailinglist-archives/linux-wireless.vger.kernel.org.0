Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 454997380D3
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Jun 2023 13:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232210AbjFUKOR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Jun 2023 06:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232394AbjFUKN7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Jun 2023 06:13:59 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA9E21FC4
        for <linux-wireless@vger.kernel.org>; Wed, 21 Jun 2023 03:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687342427; x=1718878427;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TL9XNu4VY9neaacLCfDnHl0Kof/hKBRgaUEe4Gi278o=;
  b=SuQabzo8DGBhqyOqNFVNEZAD7Nj4CHMpR+4e5BMs7nXNO9KCMkCcrJwL
   xWtqWyazbK77peLWYu4PXVv06z6KHNTX8GBGcx4e+RNT8cgv4/rQgp7Ny
   iwj/hR/jGQ7xfwtW+HbdblP7cCy9uIr9EWY6TnjAqoN47oBCHr7koVYFX
   e2dW74wNf+OMkwytDKRS1+J6yDa0AFl1RlXh0fUGCgnTcMHGW7SF/+8e7
   4j5y7FLQ42wCBDB0VEzYTWP9SlexxW37GJJnbEmhNIma7Lyqwg57mM7JY
   FjuY5ue/HdnCIpsJKGTdFp886xb6BYZPKWPBHzo/3xfsr5Sf9nkuaxuFQ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="446506321"
X-IronPort-AV: E=Sophos;i="6.00,260,1681196400"; 
   d="scan'208";a="446506321"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2023 03:12:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="664599051"
X-IronPort-AV: E=Sophos;i="6.00,260,1681196400"; 
   d="scan'208";a="664599051"
Received: from ggreenma-mobl2.jer.intel.com ([10.13.17.65])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2023 03:12:37 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Mukesh Sisodiya <mukesh.sisodiya@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 01/18] wifi: iwlwifi: Add support for new Bz version
Date:   Wed, 21 Jun 2023 13:12:05 +0300
Message-Id: <20230621130443.82d436d5f346.I0154c202c5d895cb002a2b7c827b9536e81a84b5@changeid>
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

Add support for the new version of the Bz CNVI device.

Signed-off-by: Mukesh Sisodiya <mukesh.sisodiya@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 .../net/wireless/intel/iwlwifi/cfg/22000.c    | 44 +++++++++++++++++++
 .../net/wireless/intel/iwlwifi/iwl-config.h   |  4 ++
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 33 +++++++++++---
 3 files changed, 75 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
index 5ac9416331de..fbd73fa24230 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
@@ -67,6 +67,10 @@
 #define IWL_BZ_A_FM_B_FW_PRE		"iwlwifi-bz-a0-fm-b0-"
 #define IWL_BZ_A_FM_C_FW_PRE		"iwlwifi-bz-a0-fm-c0-"
 #define IWL_BZ_A_FM4_B_FW_PRE		"iwlwifi-bz-a0-fm4-b0-"
+#define IWL_BZ_B_GF_A_FW_PRE		"iwlwifi-bz-b0-gf-a0-"
+#define IWL_BZ_B_GF4_A_FW_PRE		"iwlwifi-bz-b0-gf4-a0-"
+#define IWL_BZ_B_FM_B_FW_PRE		"iwlwifi-bz-b0-fm-b0-"
+#define IWL_BZ_B_FM4_B_FW_PRE		"iwlwifi-bz-b0-fm4-b0-"
 #define IWL_GL_A_FM_A_FW_PRE		"iwlwifi-gl-a0-fm-a0-"
 #define IWL_GL_B_FM_B_FW_PRE		"iwlwifi-gl-b0-fm-b0-"
 #define IWL_GL_C_FM_C_FW_PRE		"iwlwifi-gl-c0-fm-c0-"
@@ -160,6 +164,14 @@
 		IWL_BZ_A_FM_C_FW_PRE __stringify(api) ".ucode"
 #define IWL_BZ_A_FM4_B_MODULE_FIRMWARE(api) \
 	IWL_BZ_A_FM4_B_FW_PRE __stringify(api) ".ucode"
+#define IWL_BZ_B_GF_A_MODULE_FIRMWARE(api) \
+	IWL_BZ_B_GF_A_FW_PRE __stringify(api) ".ucode"
+#define IWL_BZ_B_GF4_A_MODULE_FIRMWARE(api) \
+	IWL_BZ_B_GF4_A_FW_PRE __stringify(api) ".ucode"
+#define IWL_BZ_B_FM_B_MODULE_FIRMWARE(api) \
+	IWL_BZ_B_FM_B_FW_PRE __stringify(api) ".ucode"
+#define IWL_BZ_B_FM4_B_MODULE_FIRMWARE(api) \
+	IWL_BZ_B_FM4_B_FW_PRE __stringify(api) ".ucode"
 #define IWL_GL_A_FM_A_MODULE_FIRMWARE(api) \
 	IWL_GL_A_FM_A_FW_PRE __stringify(api) ".ucode"
 #define IWL_GL_B_FM_B_MODULE_FIRMWARE(api) \
@@ -1029,6 +1041,22 @@ const struct iwl_cfg iwl_cfg_bz_a0_gf4_a0 = {
 	.num_rbds = IWL_NUM_RBDS_AX210_HE,
 };
 
+const struct iwl_cfg iwl_cfg_bz_b0_gf_a0 = {
+	.fw_name_pre = IWL_BZ_B_GF_A_FW_PRE,
+	.uhb_supported = true,
+	IWL_DEVICE_BZ,
+	.features = IWL_TX_CSUM_NETIF_FLAGS_BZ | NETIF_F_RXCSUM,
+	.num_rbds = IWL_NUM_RBDS_AX210_HE,
+};
+
+const struct iwl_cfg iwl_cfg_bz_b0_gf4_a0 = {
+	.fw_name_pre = IWL_BZ_B_GF4_A_FW_PRE,
+	.uhb_supported = true,
+	IWL_DEVICE_BZ,
+	.features = IWL_TX_CSUM_NETIF_FLAGS_BZ | NETIF_F_RXCSUM,
+	.num_rbds = IWL_NUM_RBDS_AX210_HE,
+};
+
 const struct iwl_cfg iwl_cfg_bz_a0_mr_a0 = {
 	.fw_name_pre = IWL_BZ_A_MR_A_FW_PRE,
 	.uhb_supported = true,
@@ -1077,6 +1105,22 @@ const struct iwl_cfg iwl_cfg_bz_a0_fm4_b0 = {
 	.num_rbds = IWL_NUM_RBDS_AX210_HE,
 };
 
+const struct iwl_cfg iwl_cfg_bz_b0_fm_b0 = {
+	.fw_name_pre = IWL_BZ_B_FM_B_FW_PRE,
+	.uhb_supported = true,
+	IWL_DEVICE_BZ,
+	.features = IWL_TX_CSUM_NETIF_FLAGS_BZ | NETIF_F_RXCSUM,
+	.num_rbds = IWL_NUM_RBDS_AX210_HE,
+};
+
+const struct iwl_cfg iwl_cfg_bz_b0_fm4_b0 = {
+	.fw_name_pre = IWL_BZ_B_FM4_B_FW_PRE,
+	.uhb_supported = true,
+	IWL_DEVICE_BZ,
+	.features = IWL_TX_CSUM_NETIF_FLAGS_BZ | NETIF_F_RXCSUM,
+	.num_rbds = IWL_NUM_RBDS_AX210_HE,
+};
+
 const struct iwl_cfg iwl_cfg_gl_a0_fm_a0 = {
 	.fw_name_pre = IWL_GL_A_FM_A_FW_PRE,
 	.uhb_supported = true,
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index 115ea8d9198a..6d7f15f277bb 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -653,12 +653,16 @@ extern const struct iwl_cfg iwl_cfg_bz_a0_hr_a0;
 extern const struct iwl_cfg iwl_cfg_bz_a0_hr_b0;
 extern const struct iwl_cfg iwl_cfg_bz_a0_gf_a0;
 extern const struct iwl_cfg iwl_cfg_bz_a0_gf4_a0;
+extern const struct iwl_cfg iwl_cfg_bz_b0_gf_a0;
+extern const struct iwl_cfg iwl_cfg_bz_b0_gf4_a0;
 extern const struct iwl_cfg iwl_cfg_bz_a0_mr_a0;
 extern const struct iwl_cfg iwl_cfg_bz_a0_fm_a0;
 extern const struct iwl_cfg iwl_cfg_bz_a0_fm4_a0;
 extern const struct iwl_cfg iwl_cfg_bz_a0_fm_b0;
 extern const struct iwl_cfg iwl_cfg_bz_a0_fm_c0;
 extern const struct iwl_cfg iwl_cfg_bz_a0_fm4_b0;
+extern const struct iwl_cfg iwl_cfg_bz_b0_fm_b0;
+extern const struct iwl_cfg iwl_cfg_bz_b0_fm4_b0;
 extern const struct iwl_cfg iwl_cfg_gl_a0_fm_a0;
 extern const struct iwl_cfg iwl_cfg_gl_b0_fm_b0;
 extern const struct iwl_cfg iwl_cfg_gl_c0_fm_c0;
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 4ba4dd881c2e..6c691121ad4c 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -1173,15 +1173,25 @@ static const struct iwl_dev_info iwl_dev_info_table[] = {
 		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB, IWL_CFG_ANY,
 		      iwl_cfg_bz_a0_hr_b0, iwl_bz_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_MAC_TYPE_BZ, IWL_CFG_ANY,
+		      IWL_CFG_MAC_TYPE_BZ, SILICON_A_STEP,
 		      IWL_CFG_RF_TYPE_GF, IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB, IWL_CFG_ANY,
 		      iwl_cfg_bz_a0_gf_a0, iwl_bz_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_MAC_TYPE_BZ, IWL_CFG_ANY,
+		      IWL_CFG_MAC_TYPE_BZ, SILICON_A_STEP,
 		      IWL_CFG_RF_TYPE_GF, IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_CDB, IWL_CFG_ANY,
 		      iwl_cfg_bz_a0_gf4_a0, iwl_bz_name),
+	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_MAC_TYPE_BZ, SILICON_B_STEP,
+		      IWL_CFG_RF_TYPE_GF, IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB, IWL_CFG_ANY,
+		      iwl_cfg_bz_b0_gf_a0, iwl_bz_name),
+	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_MAC_TYPE_BZ, SILICON_B_STEP,
+		      IWL_CFG_RF_TYPE_GF, IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_CDB, IWL_CFG_ANY,
+		      iwl_cfg_bz_b0_gf4_a0, iwl_bz_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_BZ, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_MR, IWL_CFG_ANY, IWL_CFG_ANY,
@@ -1193,25 +1203,36 @@ static const struct iwl_dev_info iwl_dev_info_table[] = {
 		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB, IWL_CFG_ANY,
 		      iwl_cfg_bz_a0_fm_a0, iwl_bz_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_MAC_TYPE_BZ, IWL_CFG_ANY,
+		      IWL_CFG_MAC_TYPE_BZ, SILICON_A_STEP,
 		      IWL_CFG_RF_TYPE_FM, IWL_CFG_ANY, SILICON_A_STEP,
 		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_CDB, IWL_CFG_NO_JACKET,
 		      iwl_cfg_bz_a0_fm4_a0, iwl_bz_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_MAC_TYPE_BZ, IWL_CFG_ANY,
+		      IWL_CFG_MAC_TYPE_BZ, SILICON_A_STEP,
 		      IWL_CFG_RF_TYPE_FM, IWL_CFG_ANY, SILICON_B_STEP,
 		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB, IWL_CFG_NO_JACKET,
 		      iwl_cfg_bz_a0_fm_b0, iwl_bz_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_MAC_TYPE_BZ, IWL_CFG_ANY,
+		      IWL_CFG_MAC_TYPE_BZ, SILICON_A_STEP,
 		      IWL_CFG_RF_TYPE_FM, IWL_CFG_ANY, SILICON_C_STEP,
 		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB, IWL_CFG_NO_JACKET,
 		      iwl_cfg_bz_a0_fm_c0, iwl_bz_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_MAC_TYPE_BZ, IWL_CFG_ANY,
+		      IWL_CFG_MAC_TYPE_BZ, SILICON_A_STEP,
 		      IWL_CFG_RF_TYPE_FM, IWL_CFG_ANY, SILICON_B_STEP,
 		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_CDB, IWL_CFG_NO_JACKET,
 		      iwl_cfg_bz_a0_fm4_b0, iwl_bz_name),
+	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_MAC_TYPE_BZ, SILICON_B_STEP,
+		      IWL_CFG_RF_TYPE_FM, IWL_CFG_ANY, SILICON_B_STEP,
+		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB, IWL_CFG_NO_JACKET,
+		      iwl_cfg_bz_b0_fm_b0, iwl_bz_name),
+	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_MAC_TYPE_BZ, SILICON_B_STEP,
+		      IWL_CFG_RF_TYPE_FM, IWL_CFG_ANY, SILICON_B_STEP,
+		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_CDB, IWL_CFG_NO_JACKET,
+		      iwl_cfg_bz_b0_fm4_b0, iwl_bz_name),
+/* Ga (Gl) */
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_GL, SILICON_A_STEP,
 		      IWL_CFG_RF_TYPE_FM, IWL_CFG_ANY, SILICON_A_STEP,
-- 
2.38.1

