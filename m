Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28FE17381DE
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Jun 2023 13:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbjFUKOh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Jun 2023 06:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231356AbjFUKOD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Jun 2023 06:14:03 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B86EC1FD5
        for <linux-wireless@vger.kernel.org>; Wed, 21 Jun 2023 03:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687342431; x=1718878431;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gVHf49t3VFtwBw2pVERz6tO/pMdXvYEf59OSZGa1jTw=;
  b=TdC+IpUK1OBSOzgBXXcS2bM5/UI98Zq1cbgFNxzo0xmd9D2SxIQGZ0U9
   hW1P4XW2Qn7zxldza7vkrhCL8mxpoJC0ZdWqGvYLjdbujb4KxU+uIzMK2
   C7oZ8fL2K6xINrIq2KMtlpqt0kibFeGRGeSKeP7Ziz7XKUTgojrHA37ob
   bsgwoFRcddGxuNAo1uW+UPAPpe87E8A82s6cnF265tqLSuUUQ0yqNAofy
   Ro/+H8TAa7vv7jjIx/lsoPiI4cRB2VSBxZj79TkLtQnIhlCFBq0Phgkmu
   r6rWfCZH/oJLnTrdPxfAjWk2uqOd/ZIo2hwhqqWwhphv8sKQYFdCx3Udi
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="446506480"
X-IronPort-AV: E=Sophos;i="6.00,260,1681196400"; 
   d="scan'208";a="446506480"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2023 03:13:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="664599273"
X-IronPort-AV: E=Sophos;i="6.00,260,1681196400"; 
   d="scan'208";a="664599273"
Received: from ggreenma-mobl2.jer.intel.com ([10.13.17.65])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2023 03:13:16 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 13/18] wifi: iwlwifi: also unify Ma device configurations
Date:   Wed, 21 Jun 2023 13:12:17 +0300
Message-Id: <20230621130443.676887cc8180.I29994dec43bfb29aad5e4ab0126c06a9ea4670cb@changeid>
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

From: Johannes Berg <johannes.berg@intel.com>

Again, they're all the same except for the radio and
steps, so use the new logic to unify them.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 .../net/wireless/intel/iwlwifi/cfg/ax210.c    | 74 +------------------
 .../net/wireless/intel/iwlwifi/iwl-config.h   | 14 +---
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 58 ++++-----------
 3 files changed, 19 insertions(+), 127 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c b/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c
index e1c3afb97941..a484cae3f784 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c
@@ -273,76 +273,6 @@ const struct iwl_cfg iwlax411_2ax_cfg_so_gf4_a0_long = {
 	.trans.low_latency_xtal = true,
 };
 
-const struct iwl_cfg iwl_cfg_ma_a0_hr_b0 = {
-	.fw_name_pre = IWL_MA_A_HR_B_FW_PRE,
-	.uhb_supported = true,
-	IWL_DEVICE_AX210,
-	.num_rbds = IWL_NUM_RBDS_AX210_HE,
-};
-
-const struct iwl_cfg iwl_cfg_ma_a0_gf_a0 = {
-	.fw_name_pre = IWL_MA_A_GF_A_FW_PRE,
-	.uhb_supported = true,
-	IWL_DEVICE_AX210,
-	.num_rbds = IWL_NUM_RBDS_AX210_HE,
-};
-
-const struct iwl_cfg iwl_cfg_ma_a0_gf4_a0 = {
-	.fw_name_pre = IWL_MA_A_GF4_A_FW_PRE,
-	.uhb_supported = true,
-	IWL_DEVICE_AX210,
-	.num_rbds = IWL_NUM_RBDS_AX210_HE,
-};
-
-const struct iwl_cfg iwl_cfg_ma_a0_mr_a0 = {
-	.fw_name_pre = IWL_MA_A_MR_A_FW_PRE,
-	.uhb_supported = true,
-	IWL_DEVICE_AX210,
-	.num_rbds = IWL_NUM_RBDS_AX210_HE,
-};
-
-const struct iwl_cfg iwl_cfg_ma_a0_ms_a0 = {
-	.fw_name_pre = IWL_MA_A_MR_A_FW_PRE,
-	.uhb_supported = false,
-	IWL_DEVICE_AX210,
-	.num_rbds = IWL_NUM_RBDS_AX210_HE,
-};
-
-const struct iwl_cfg iwl_cfg_ma_b0_fm_a0 = {
-	.fw_name_pre = IWL_MA_B_FM_A_FW_PRE,
-	.uhb_supported = true,
-	IWL_DEVICE_AX210,
-	.num_rbds = IWL_NUM_RBDS_AX210_HE,
-};
-
-const struct iwl_cfg iwl_cfg_ma_b0_hr_b0 = {
-	.fw_name_pre = IWL_MA_B_HR_B_FW_PRE,
-	.uhb_supported = true,
-	IWL_DEVICE_AX210,
-	.num_rbds = IWL_NUM_RBDS_AX210_HE,
-};
-
-const struct iwl_cfg iwl_cfg_ma_b0_gf_a0 = {
-	.fw_name_pre = IWL_MA_B_GF_A_FW_PRE,
-	.uhb_supported = true,
-	IWL_DEVICE_AX210,
-	.num_rbds = IWL_NUM_RBDS_AX210_HE,
-};
-
-const struct iwl_cfg iwl_cfg_ma_b0_gf4_a0 = {
-	.fw_name_pre = IWL_MA_B_GF4_A_FW_PRE,
-	.uhb_supported = true,
-	IWL_DEVICE_AX210,
-	.num_rbds = IWL_NUM_RBDS_AX210_HE,
-};
-
-const struct iwl_cfg iwl_cfg_ma_b0_mr_a0 = {
-	.fw_name_pre = IWL_MA_B_MR_A_FW_PRE,
-	.uhb_supported = true,
-	IWL_DEVICE_AX210,
-	.num_rbds = IWL_NUM_RBDS_AX210_HE,
-};
-
 const struct iwl_cfg iwl_cfg_so_a0_ms_a0 = {
 	.fw_name_pre = IWL_SO_A_MR_A_FW_PRE,
 	.uhb_supported = false,
@@ -350,8 +280,8 @@ const struct iwl_cfg iwl_cfg_so_a0_ms_a0 = {
 	.num_rbds = IWL_NUM_RBDS_AX210_HE,
 };
 
-const struct iwl_cfg iwl_cfg_ma_a0_fm_a0 = {
-	.fw_name_pre = IWL_MA_A_FM_A_FW_PRE,
+const struct iwl_cfg iwl_cfg_ma = {
+	.fw_name_mac = "ma",
 	.uhb_supported = true,
 	IWL_DEVICE_AX210,
 	.num_rbds = IWL_NUM_RBDS_AX210_HE,
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index 49a66951c5bc..4cc0285f287e 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -632,17 +632,9 @@ extern const struct iwl_cfg iwlax211_2ax_cfg_so_gf_a0_long;
 extern const struct iwl_cfg iwlax210_2ax_cfg_ty_gf_a0;
 extern const struct iwl_cfg iwlax411_2ax_cfg_so_gf4_a0;
 extern const struct iwl_cfg iwlax411_2ax_cfg_so_gf4_a0_long;
-extern const struct iwl_cfg iwl_cfg_ma_a0_hr_b0;
-extern const struct iwl_cfg iwl_cfg_ma_a0_gf_a0;
-extern const struct iwl_cfg iwl_cfg_ma_a0_gf4_a0;
-extern const struct iwl_cfg iwl_cfg_ma_a0_mr_a0;
-extern const struct iwl_cfg iwl_cfg_ma_a0_ms_a0;
-extern const struct iwl_cfg iwl_cfg_ma_a0_fm_a0;
-extern const struct iwl_cfg iwl_cfg_ma_b0_hr_b0;
-extern const struct iwl_cfg iwl_cfg_ma_b0_gf_a0;
-extern const struct iwl_cfg iwl_cfg_ma_b0_gf4_a0;
-extern const struct iwl_cfg iwl_cfg_ma_b0_mr_a0;
-extern const struct iwl_cfg iwl_cfg_ma_b0_fm_a0;
+
+extern const struct iwl_cfg iwl_cfg_ma;
+
 extern const struct iwl_cfg iwl_cfg_so_a0_hr_a0;
 extern const struct iwl_cfg iwl_cfg_so_a0_ms_a0;
 extern const struct iwl_cfg iwl_cfg_quz_a0_hr_b0;
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 1944e621dbef..41dbb9da8203 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -551,8 +551,8 @@ static const struct iwl_dev_info iwl_dev_info_table[] = {
 	IWL_DEV_INFO(0x7A70, 0x1692, iwlax411_2ax_cfg_so_gf4_a0, iwl_ax411_killer_1690i_name),
 
 	IWL_DEV_INFO(0x271C, 0x0214, iwl9260_2ac_cfg, iwl9260_1_name),
-	IWL_DEV_INFO(0x7E40, 0x1691, iwl_cfg_ma_a0_gf4_a0, iwl_ax411_killer_1690s_name),
-	IWL_DEV_INFO(0x7E40, 0x1692, iwl_cfg_ma_a0_gf4_a0, iwl_ax411_killer_1690i_name),
+	IWL_DEV_INFO(0x7E40, 0x1691, iwl_cfg_ma, iwl_ax411_killer_1690s_name),
+	IWL_DEV_INFO(0x7E40, 0x1692, iwl_cfg_ma, iwl_ax411_killer_1690i_name),
 
 /* AX200 */
 	IWL_DEV_INFO(0x2723, IWL_CFG_ANY, iwl_ax200_cfg_cc, iwl_ax200_name),
@@ -677,8 +677,8 @@ static const struct iwl_dev_info iwl_dev_info_table[] = {
 	IWL_DEV_INFO(0x7F70, 0x1672, iwlax211_2ax_cfg_so_gf_a0, iwl_ax211_killer_1675i_name),
 
 	/* MA with GF2 */
-	IWL_DEV_INFO(0x7E40, 0x1671, iwl_cfg_ma_a0_gf_a0, iwl_ax211_killer_1675s_name),
-	IWL_DEV_INFO(0x7E40, 0x1672, iwl_cfg_ma_a0_gf_a0, iwl_ax211_killer_1675i_name),
+	IWL_DEV_INFO(0x7E40, 0x1671, iwl_cfg_ma, iwl_ax211_killer_1675s_name),
+	IWL_DEV_INFO(0x7E40, 0x1672, iwl_cfg_ma, iwl_ax211_killer_1675i_name),
 
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_PU, IWL_CFG_ANY,
@@ -927,55 +927,25 @@ static const struct iwl_dev_info iwl_dev_info_table[] = {
 
 /* Ma */
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_MAC_TYPE_MA, SILICON_A_STEP,
-		      IWL_CFG_RF_TYPE_HR2, IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB,
-		      iwl_cfg_ma_a0_hr_b0, iwl_ax201_name),
-	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_MAC_TYPE_MA, SILICON_A_STEP,
-		      IWL_CFG_RF_TYPE_GF, IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB,
-		      iwl_cfg_ma_a0_gf_a0, iwl_ax211_name),
-	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_MAC_TYPE_MA, SILICON_A_STEP,
-		      IWL_CFG_RF_TYPE_GF, IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_CDB,
-		      iwl_cfg_ma_a0_gf4_a0, iwl_ax211_name),
-	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_MAC_TYPE_MA, SILICON_A_STEP,
-		      IWL_CFG_RF_TYPE_MR, IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB,
-		      iwl_cfg_ma_a0_mr_a0, iwl_ax221_name),
-	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_MAC_TYPE_MA, SILICON_A_STEP,
-		      IWL_CFG_RF_TYPE_FM, IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB,
-		      iwl_cfg_ma_a0_fm_a0, iwl_ax231_name),
-	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_MAC_TYPE_MA, SILICON_B_STEP,
+		      IWL_CFG_MAC_TYPE_MA, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_HR2, IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB,
-		      iwl_cfg_ma_b0_hr_b0, iwl_ax201_name),
+		      iwl_cfg_ma, iwl_ax201_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_MAC_TYPE_MA, SILICON_B_STEP,
-		      IWL_CFG_RF_TYPE_GF, IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB,
-		      iwl_cfg_ma_b0_gf_a0, iwl_ax211_name),
-	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_MAC_TYPE_MA, SILICON_B_STEP,
+		      IWL_CFG_MAC_TYPE_MA, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_GF, IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_CDB,
-		      iwl_cfg_ma_b0_gf4_a0, iwl_ax211_name),
+		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_ANY,
+		      iwl_cfg_ma, iwl_ax211_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_MAC_TYPE_MA, SILICON_B_STEP,
+		      IWL_CFG_MAC_TYPE_MA, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_MR, IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB,
-		      iwl_cfg_ma_b0_mr_a0, iwl_ax221_name),
+		      iwl_cfg_ma, iwl_ax221_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_MAC_TYPE_MA, SILICON_B_STEP,
+		      IWL_CFG_MAC_TYPE_MA, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_FM, IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB,
-		      iwl_cfg_ma_b0_fm_a0, iwl_ax231_name),
+		      iwl_cfg_ma, iwl_ax231_name),
 
 /* So with Hr */
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
@@ -1138,7 +1108,7 @@ static const struct iwl_dev_info iwl_dev_info_table[] = {
 		      IWL_CFG_MAC_TYPE_MA, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_MS, IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_160, IWL_CFG_ANY, IWL_CFG_NO_CDB,
-		      iwl_cfg_ma_a0_ms_a0, iwl_ax204_name),
+		      iwl_cfg_ma, iwl_ax204_name),
 
 /* Sc */
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
-- 
2.38.1

