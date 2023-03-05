Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53E676AAF6B
	for <lists+linux-wireless@lfdr.de>; Sun,  5 Mar 2023 13:17:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbjCEMRm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 5 Mar 2023 07:17:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbjCEMRj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 5 Mar 2023 07:17:39 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB98A126D4
        for <linux-wireless@vger.kernel.org>; Sun,  5 Mar 2023 04:17:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678018651; x=1709554651;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VjB3C7Zb0JNwES2lP1+NBi1Sv7fPo98pcCag/BhHXhQ=;
  b=E4HShWQVGHp/Ry1LN1SqG3vaSC5ErZ98t+lBEMHFT+8ssYqzSlBnjsVR
   vi3cJMGjXNSo1ae7vfI5G7Lm/65i+PyiwEGjEyBzQwEaqV+UccGansGT6
   nbZDG8DzlTVquNZqm1MKd+4hFH8fhid8/zgTumWcJCWUVsQQWKrUfjsFr
   II/dlvtBDLUsxYhzXVCpVRDgwVX7vah/z753g+tcxqa50+C3mYzXF9g1N
   fUHLIDcFlSOWRhpd1LaZ+XM1gejGEpMSuFVPDEllP8qTXCXb6lgikO8WT
   PsSkHnyxyNzli2x40i4yJjV+BJW46iLJR6neRRg5AbS9XDaTW+wgUUgNX
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10639"; a="400193264"
X-IronPort-AV: E=Sophos;i="5.98,235,1673942400"; 
   d="scan'208";a="400193264"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2023 04:17:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10639"; a="708355181"
X-IronPort-AV: E=Sophos;i="5.98,235,1673942400"; 
   d="scan'208";a="708355181"
Received: from hsaid-mobl2.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.249.80.12])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2023 04:17:29 -0800
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Golan Ben Ami <golan.ben.ami@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 15/21] wifi: iwlwifi: Add support for B step of BnJ-Fm4
Date:   Sun,  5 Mar 2023 14:16:29 +0200
Message-Id: <20230305124407.bb0591c59898.If04d7a45707ba008981f8c8ea7f7f107880f146c@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230305121635.301451-1-gregory.greenman@intel.com>
References: <20230305121635.301451-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Golan Ben Ami <golan.ben.ami@intel.com>

Support new HW step of BnJ-Fm4 device

Signed-off-by: Golan Ben Ami <golan.ben.ami@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/cfg/22000.c  | 12 ++++++++++++
 drivers/net/wireless/intel/iwlwifi/iwl-config.h |  1 +
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c   |  5 +++++
 3 files changed, 18 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
index 3bdd6774716d..05720352e49f 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
@@ -62,6 +62,7 @@
 #define IWL_BZ_Z_GF_A_FW_PRE		"iwlwifi-bz-z0-gf-a0-"
 #define IWL_BNJ_A_FM_A_FW_PRE		"iwlwifi-BzBnj-a0-fm-a0-"
 #define IWL_BNJ_A_FM4_A_FW_PRE		"iwlwifi-BzBnj-a0-fm4-a0-"
+#define IWL_BNJ_B_FM4_B_FW_PRE		"iwlwifi-BzBnj-b0-fm4-b0-"
 #define IWL_BNJ_A_GF_A_FW_PRE		"iwlwifi-BzBnj-a0-gf-a0-"
 #define IWL_BNJ_A_GF4_A_FW_PRE		"iwlwifi-BzBnj-a0-gf4-a0-"
 #define IWL_BNJ_A_HR_B_FW_PRE		"iwlwifi-BzBnj-a0-hr-b0-"
@@ -132,6 +133,8 @@
 	IWL_BNJ_A_FM_A_FW_PRE __stringify(api) ".ucode"
 #define IWL_BNJ_A_FM4_A_MODULE_FIRMWARE(api) \
 	IWL_BNJ_A_FM4_A_FW_PRE __stringify(api) ".ucode"
+#define IWL_BNJ_B_FM4_B_MODULE_FIRMWARE(api) \
+	IWL_BNJ_B_FM4_B_FW_PRE __stringify(api) ".ucode"
 #define IWL_BNJ_A_GF_A_MODULE_FIRMWARE(api) \
 	IWL_BNJ_A_GF_A_FW_PRE __stringify(api) ".ucode"
 #define IWL_BNJ_A_GF4_A_MODULE_FIRMWARE(api) \
@@ -998,6 +1001,14 @@ const struct iwl_cfg iwl_cfg_bnj_a0_fm4_a0 = {
 	.num_rbds = IWL_NUM_RBDS_AX210_HE,
 };
 
+const struct iwl_cfg iwl_cfg_bnj_b0_fm4_b0 = {
+	.fw_name_pre = IWL_BNJ_B_FM4_B_FW_PRE,
+	.uhb_supported = true,
+	IWL_DEVICE_BZ,
+	.features = IWL_TX_CSUM_NETIF_FLAGS | NETIF_F_RXCSUM,
+	.num_rbds = IWL_NUM_RBDS_AX210_HE,
+};
+
 const struct iwl_cfg iwl_cfg_bnj_a0_gf_a0 = {
 	.fw_name_pre = IWL_BNJ_A_GF_A_FW_PRE,
 	.uhb_supported = true,
@@ -1059,6 +1070,7 @@ MODULE_FIRMWARE(IWL_BZ_A_FM_A_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_GL_A_FM_A_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_BNJ_A_FM_A_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_BNJ_A_FM4_A_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
+MODULE_FIRMWARE(IWL_BNJ_B_FM4_B_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_BNJ_A_GF_A_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_BNJ_A_GF4_A_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_BNJ_A_HR_B_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index cfa5e1b3c3f6..eaa0ff2736c5 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -659,6 +659,7 @@ extern const struct iwl_cfg iwl_cfg_bnj_a0_gf_a0;
 extern const struct iwl_cfg iwl_cfg_bnj_a0_gf4_a0;
 extern const struct iwl_cfg iwl_cfg_bnj_a0_hr_b0;
 extern const struct iwl_cfg iwl_cfg_bnj_b0_fm_b0;
+extern const struct iwl_cfg iwl_cfg_bnj_b0_fm4_b0;
 #endif /* CONFIG_IWLMVM */
 
 #endif /* __IWL_CONFIG_H__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 99768d6a6032..8aa8a678475c 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -1193,6 +1193,11 @@ static const struct iwl_dev_info iwl_dev_info_table[] = {
 		      IWL_CFG_RF_TYPE_FM, IWL_CFG_ANY,
 		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_CDB, IWL_CFG_IS_JACKET,
 		      iwl_cfg_bnj_a0_fm4_a0, iwl_bz_name),
+	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_MAC_TYPE_GL, SILICON_B_STEP,
+		      IWL_CFG_RF_TYPE_FM, IWL_CFG_ANY,
+		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_CDB, IWL_CFG_IS_JACKET,
+		      iwl_cfg_bnj_b0_fm4_b0, iwl_bz_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_GL, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_GF, IWL_CFG_ANY,
-- 
2.38.1

