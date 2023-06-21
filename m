Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2574173814E
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Jun 2023 13:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232383AbjFUKOa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Jun 2023 06:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232088AbjFUKOB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Jun 2023 06:14:01 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A667F1FD0
        for <linux-wireless@vger.kernel.org>; Wed, 21 Jun 2023 03:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687342431; x=1718878431;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YIXfUm3+9YvEYJRuinJCV3WiWxPLmUan4LebmcGb3ss=;
  b=LLIOOL9qUF6dPJL2myWbynQWKcfFIwd9g0iwsWcH/nB0DNBn2VB0zqhP
   CLa7Q4bfiWGonSdXEkhAo+UA9xY+GUwTC34Gyt6V4l9nlg4zw7o963KQZ
   H0mXQfkqyoKO98m9gQOTGPTxM5nILTkDu4R8QgjNwwzE8pXoXmcQMERgc
   Sctj4Xfgxs2TDmWEaOgmK2nCsBEmU1tQyBsP8ob25y6ABezzw5L+aLLTq
   OizZhhqaWvuAb75FnZQO+l/+ZvrTYRAnkP10UY8/QDBeKrefparoYEUQ/
   yadhxwwWDUOOpdH2E6ZZB60uBAs3E+Wvge3m+Eb+RG6X99mvgJZJwyova
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="446506468"
X-IronPort-AV: E=Sophos;i="6.00,260,1681196400"; 
   d="scan'208";a="446506468"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2023 03:13:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="664599257"
X-IronPort-AV: E=Sophos;i="6.00,260,1681196400"; 
   d="scan'208";a="664599257"
Received: from ggreenma-mobl2.jer.intel.com ([10.13.17.65])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2023 03:13:13 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 12/18] wifi: iwlwifi: also unify Sc device configurations
Date:   Wed, 21 Jun 2023 13:12:16 +0300
Message-Id: <20230621130443.3bc1191f883f.If1e6f73a164b0794ac65372b72673ce8ddf9e571@changeid>
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
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c   | 52 +------------------
 .../net/wireless/intel/iwlwifi/iwl-config.h   |  8 +--
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 38 ++------------
 3 files changed, 7 insertions(+), 91 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/sc.c b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
index 53b2a5969db6..679cb53ae18a 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
@@ -149,56 +149,8 @@ const struct iwl_cfg_trans_params iwl_sc_trans_cfg = {
 
 const char iwl_sc_name[] = "Intel(R) TBD Sc device";
 
-const struct iwl_cfg iwl_cfg_sc_a0_fm_b0 = {
-	.fw_name_pre = IWL_SC_A_FM_B_FW_PRE,
-	.uhb_supported = true,
-	IWL_DEVICE_SC,
-	.features = IWL_TX_CSUM_NETIF_FLAGS_BZ | NETIF_F_RXCSUM,
-	.num_rbds = IWL_NUM_RBDS_SC_HE,
-};
-
-const struct iwl_cfg iwl_cfg_sc_a0_fm_c0 = {
-	.fw_name_pre = IWL_SC_A_FM_C_FW_PRE,
-	.uhb_supported = true,
-	IWL_DEVICE_SC,
-	.features = IWL_TX_CSUM_NETIF_FLAGS_BZ | NETIF_F_RXCSUM,
-	.num_rbds = IWL_NUM_RBDS_SC_HE,
-};
-
-const struct iwl_cfg iwl_cfg_sc_a0_hr_a0 = {
-	.fw_name_pre = IWL_SC_A_HR_A_FW_PRE,
-	.uhb_supported = true,
-	IWL_DEVICE_SC,
-	.features = IWL_TX_CSUM_NETIF_FLAGS_BZ | NETIF_F_RXCSUM,
-	.num_rbds = IWL_NUM_RBDS_SC_HE,
-};
-
-const struct iwl_cfg iwl_cfg_sc_a0_hr_b0 = {
-	.fw_name_pre = IWL_SC_A_HR_B_FW_PRE,
-	.uhb_supported = true,
-	IWL_DEVICE_SC,
-	.features = IWL_TX_CSUM_NETIF_FLAGS_BZ | NETIF_F_RXCSUM,
-	.num_rbds = IWL_NUM_RBDS_SC_HE,
-};
-
-const struct iwl_cfg iwl_cfg_sc_a0_gf_a0 = {
-	.fw_name_pre = IWL_SC_A_GF_A_FW_PRE,
-	.uhb_supported = true,
-	IWL_DEVICE_SC,
-	.features = IWL_TX_CSUM_NETIF_FLAGS_BZ | NETIF_F_RXCSUM,
-	.num_rbds = IWL_NUM_RBDS_SC_HE,
-};
-
-const struct iwl_cfg iwl_cfg_sc_a0_gf4_a0 = {
-	.fw_name_pre = IWL_SC_A_GF4_A_FW_PRE,
-	.uhb_supported = true,
-	IWL_DEVICE_SC,
-	.features = IWL_TX_CSUM_NETIF_FLAGS_BZ | NETIF_F_RXCSUM,
-	.num_rbds = IWL_NUM_RBDS_SC_HE,
-};
-
-const struct iwl_cfg iwl_cfg_sc_a0_wh_a0 = {
-	.fw_name_pre = IWL_SC_A_WH_A_FW_PRE,
+const struct iwl_cfg iwl_cfg_sc = {
+	.fw_name_mac = "sc",
 	.uhb_supported = true,
 	IWL_DEVICE_SC,
 	.features = IWL_TX_CSUM_NETIF_FLAGS_BZ | NETIF_F_RXCSUM,
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index 47e164beda29..49a66951c5bc 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -651,13 +651,7 @@ extern const struct iwl_cfg iwl_cfg_bz;
 extern const struct iwl_cfg iwl_cfg_gl_a0_fm_a0;
 extern const struct iwl_cfg iwl_cfg_gl;
 
-extern const struct iwl_cfg iwl_cfg_sc_a0_fm_b0;
-extern const struct iwl_cfg iwl_cfg_sc_a0_fm_c0;
-extern const struct iwl_cfg iwl_cfg_sc_a0_hr_a0;
-extern const struct iwl_cfg iwl_cfg_sc_a0_hr_b0;
-extern const struct iwl_cfg iwl_cfg_sc_a0_gf_a0;
-extern const struct iwl_cfg iwl_cfg_sc_a0_gf4_a0;
-extern const struct iwl_cfg iwl_cfg_sc_a0_wh_a0;
+extern const struct iwl_cfg iwl_cfg_sc;
 #endif /* CONFIG_IWLMVM */
 
 #endif /* __IWL_CONFIG_H__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 33827441803b..1944e621dbef 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -1142,40 +1142,10 @@ static const struct iwl_dev_info iwl_dev_info_table[] = {
 
 /* Sc */
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_MAC_TYPE_SC, SILICON_A_STEP,
-		      IWL_CFG_RF_TYPE_FM, IWL_CFG_ANY, SILICON_B_STEP,
-		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB,
-		      iwl_cfg_sc_a0_fm_b0, iwl_sc_name),
-	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_MAC_TYPE_SC, SILICON_A_STEP,
-		      IWL_CFG_RF_TYPE_FM, IWL_CFG_ANY, SILICON_C_STEP,
-		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB,
-		      iwl_cfg_sc_a0_fm_c0, iwl_sc_name),
-	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_MAC_TYPE_SC, SILICON_A_STEP,
-		      IWL_CFG_RF_TYPE_HR1, IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB,
-		      iwl_cfg_sc_a0_hr_a0, iwl_sc_name),
-	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_MAC_TYPE_SC, SILICON_A_STEP,
-		      IWL_CFG_RF_TYPE_HR2, IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB,
-		      iwl_cfg_sc_a0_hr_b0, iwl_sc_name),
-	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_MAC_TYPE_SC, SILICON_A_STEP,
-		      IWL_CFG_RF_TYPE_GF, IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB,
-		      iwl_cfg_sc_a0_gf_a0, iwl_sc_name),
-	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_MAC_TYPE_SC, SILICON_A_STEP,
-		      IWL_CFG_RF_TYPE_GF, IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_CDB,
-		      iwl_cfg_sc_a0_gf4_a0, iwl_sc_name),
-	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_MAC_TYPE_SC, SILICON_A_STEP,
-		      IWL_CFG_RF_TYPE_WH, IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB,
-		      iwl_cfg_sc_a0_wh_a0, iwl_sc_name),
+		      IWL_CFG_MAC_TYPE_SC, IWL_CFG_ANY,
+		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_ANY,
+		      iwl_cfg_sc, iwl_sc_name),
 #endif /* CONFIG_IWLMVM */
 };
 
-- 
2.38.1

