Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA11670FCE6
	for <lists+linux-wireless@lfdr.de>; Wed, 24 May 2023 19:44:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232371AbjEXRou (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 24 May 2023 13:44:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232979AbjEXRos (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 24 May 2023 13:44:48 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88604E6C
        for <linux-wireless@vger.kernel.org>; Wed, 24 May 2023 10:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684950252; x=1716486252;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3HR9iU1MkmYkU53VchVCVYL12k+S29JmdbffxNkpQzU=;
  b=Lqtxy0hYSMAVm1Zxfr8bGrwjEZtoWXCa40INT0jU65qHkoRnJRNRR0LV
   +Tcn2QM1QDjTcIZo8M6zM+lsQqm3IMANnkX7CnMff1XPsA4Xwl7fo68I5
   fq9zYUzogeb7hXesp5UOjGLiGnl7LxDA9UpicCsZCgdNcKYe3zkza8Qgd
   VlaCPxrJmjb9e0oJG5JCbVV8SOEWx3GshHgA/SLqlOGmRSTRaUSm07Bvr
   nxqZHPeqOjDEJ2RJhUZIuiOWQ6/QigxQGpdCh0xa0VAgF+T0w0w9JUuq/
   Ne8vIpKNvceTnOOqAzQV4QEmfz7sWt2k6LfQgFK2DnliCxKYh6O2smLwv
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10720"; a="440000323"
X-IronPort-AV: E=Sophos;i="6.00,189,1681196400"; 
   d="scan'208";a="440000323"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2023 10:42:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10720"; a="769547871"
X-IronPort-AV: E=Sophos;i="6.00,189,1681196400"; 
   d="scan'208";a="769547871"
Received: from hmozes-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.249.89.195])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2023 10:42:34 -0700
From:   gregory.greenman@intel.com
To:     kvalo@kernel.org, johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Golan Ben Ami <golan.ben.ami@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 01/14] wifi: iwlwifi: cfg: freeze 22500 devices FW API
Date:   Wed, 24 May 2023 20:41:58 +0300
Message-Id: <20230524203151.8a25ebf9134c.I3f1454498322ce28cb687d28c091c7ee092cefca@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230524174211.1482360-1-gregory.greenman@intel.com>
References: <20230524174211.1482360-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Golan Ben Ami <golan.ben.ami@intel.com>

FW version is now frozen for 22500 devices. Don't
allow newer versions in the driver.

Signed-off-by: Golan Ben Ami <golan.ben.ami@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 .../net/wireless/intel/iwlwifi/cfg/22000.c    | 20 ++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
index b6f82510e980..2cf3af284680 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
@@ -11,6 +11,7 @@
 
 /* Highest firmware API version supported */
 #define IWL_22000_UCODE_API_MAX	78
+#define IWL_22500_UCODE_API_MAX	77
 
 /* Lowest firmware API version supported */
 #define IWL_22000_UCODE_API_MIN	39
@@ -222,7 +223,6 @@ static const struct iwl_ht_params iwl_gl_a_ht_params = {
 };
 
 #define IWL_DEVICE_22000_COMMON						\
-	.ucode_api_max = IWL_22000_UCODE_API_MAX,			\
 	.ucode_api_min = IWL_22000_UCODE_API_MIN,			\
 	.led_mode = IWL_LED_RF_STATE,					\
 	.nvm_hw_section_num = 10,					\
@@ -261,6 +261,7 @@ static const struct iwl_ht_params iwl_gl_a_ht_params = {
 
 #define IWL_DEVICE_22500						\
 	IWL_DEVICE_22000_COMMON,					\
+	.ucode_api_max = IWL_22500_UCODE_API_MAX,			\
 	.trans.device_family = IWL_DEVICE_FAMILY_22000,			\
 	.trans.base_params = &iwl_22000_base_params,			\
 	.gp2_reg_addr = 0xa02c68,					\
@@ -277,6 +278,7 @@ static const struct iwl_ht_params iwl_gl_a_ht_params = {
 
 #define IWL_DEVICE_AX210						\
 	IWL_DEVICE_22000_COMMON,					\
+	.ucode_api_max = IWL_22000_UCODE_API_MAX,			\
 	.trans.umac_prph_offset = 0x300000,				\
 	.trans.device_family = IWL_DEVICE_FAMILY_AX210,			\
 	.trans.base_params = &iwl_ax210_base_params,			\
@@ -1178,14 +1180,14 @@ const struct iwl_cfg iwl_cfg_bnj_b0_fm_b0 = {
 	.features = IWL_TX_CSUM_NETIF_FLAGS_BZ | NETIF_F_RXCSUM,
 	.num_rbds = IWL_NUM_RBDS_AX210_HE,
 };
-MODULE_FIRMWARE(IWL_QU_B_HR_B_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
-MODULE_FIRMWARE(IWL_QNJ_B_HR_B_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
-MODULE_FIRMWARE(IWL_QU_C_HR_B_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
-MODULE_FIRMWARE(IWL_QU_B_JF_B_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
-MODULE_FIRMWARE(IWL_QUZ_A_HR_B_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
-MODULE_FIRMWARE(IWL_QUZ_A_JF_B_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
-MODULE_FIRMWARE(IWL_QNJ_B_JF_B_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
-MODULE_FIRMWARE(IWL_CC_A_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
+MODULE_FIRMWARE(IWL_QU_B_HR_B_MODULE_FIRMWARE(IWL_22500_UCODE_API_MAX));
+MODULE_FIRMWARE(IWL_QNJ_B_HR_B_MODULE_FIRMWARE(IWL_22500_UCODE_API_MAX));
+MODULE_FIRMWARE(IWL_QU_C_HR_B_MODULE_FIRMWARE(IWL_22500_UCODE_API_MAX));
+MODULE_FIRMWARE(IWL_QU_B_JF_B_MODULE_FIRMWARE(IWL_22500_UCODE_API_MAX));
+MODULE_FIRMWARE(IWL_QUZ_A_HR_B_MODULE_FIRMWARE(IWL_22500_UCODE_API_MAX));
+MODULE_FIRMWARE(IWL_QUZ_A_JF_B_MODULE_FIRMWARE(IWL_22500_UCODE_API_MAX));
+MODULE_FIRMWARE(IWL_QNJ_B_JF_B_MODULE_FIRMWARE(IWL_22500_UCODE_API_MAX));
+MODULE_FIRMWARE(IWL_CC_A_MODULE_FIRMWARE(IWL_22500_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_SO_A_JF_B_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_SO_A_HR_B_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_SO_A_GF_A_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
-- 
2.38.1

