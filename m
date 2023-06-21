Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1016738185
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Jun 2023 13:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231942AbjFUKOe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Jun 2023 06:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbjFUKOB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Jun 2023 06:14:01 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31DE11FCD
        for <linux-wireless@vger.kernel.org>; Wed, 21 Jun 2023 03:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687342431; x=1718878431;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LgkEyWxuCC0VukDtSpQbSoxA2JirWDnVOgvguwsDmWc=;
  b=hZ7UPxcSKvDBK7DOFsSKh6pqv7ryhf0mu/SMxKvdWqGKu0ps1Z+meFoN
   l6uz2eBggc/cM5MAmrzfJh4/nfU+AD94eq8tg1yfso7nmqUH52xuPYCon
   G2CHTYuCjfY/Dr1K4hxmkCPC0pCtuQAUZzXIMQMj+U+R3Tm/Rr8NQydAI
   e3hUJZTdHsjVwu0Wa6NOEH12ptzKrz4O7HUhwOrVF5h/ILXV/SmdSKP3u
   Nvj3vCpii82NaKKZaGCSmj9CisXM2gJdq9SaUv0XRmDmNW9qw7J0Yis2P
   uhg5Zj4VRmaTcI6SZmDlvtKPyUOwoVaH4fAWq36estWfxtIQMwStnI2/y
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="446506415"
X-IronPort-AV: E=Sophos;i="6.00,260,1681196400"; 
   d="scan'208";a="446506415"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2023 03:13:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="664599177"
X-IronPort-AV: E=Sophos;i="6.00,260,1681196400"; 
   d="scan'208";a="664599177"
Received: from ggreenma-mobl2.jer.intel.com ([10.13.17.65])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2023 03:13:00 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 09/18] wifi: iwlwifi: remove support for *nJ devices
Date:   Wed, 21 Jun 2023 13:12:13 +0300
Message-Id: <20230621130443.d9f4e0356ae4.If9eccc22eb500dfff8973a70a649d94af7a60841@changeid>
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

These are test chips that will never reach anyone
outside of Intel, so remove support for them.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 .../net/wireless/intel/iwlwifi/cfg/22000.c    |  41 ----
 .../net/wireless/intel/iwlwifi/cfg/ax210.c    |  73 ------
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c   | 172 --------------
 .../net/wireless/intel/iwlwifi/iwl-config.h   |  25 --
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 218 ------------------
 5 files changed, 529 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
index c496d0d19de4..8acbbed6eb1f 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
@@ -27,19 +27,15 @@
 #define IWL_22000_SMEM_LEN		0xD0000
 
 #define IWL_QU_B_HR_B_FW_PRE		"iwlwifi-Qu-b0-hr-b0-"
-#define IWL_QNJ_B_HR_B_FW_PRE		"iwlwifi-QuQnj-b0-hr-b0-"
 #define IWL_QU_C_HR_B_FW_PRE		"iwlwifi-Qu-c0-hr-b0-"
 #define IWL_QU_B_JF_B_FW_PRE		"iwlwifi-Qu-b0-jf-b0-"
 #define IWL_QU_C_JF_B_FW_PRE		"iwlwifi-Qu-c0-jf-b0-"
 #define IWL_QUZ_A_HR_B_FW_PRE		"iwlwifi-QuZ-a0-hr-b0-"
 #define IWL_QUZ_A_JF_B_FW_PRE		"iwlwifi-QuZ-a0-jf-b0-"
-#define IWL_QNJ_B_JF_B_FW_PRE		"iwlwifi-QuQnj-b0-jf-b0-"
 #define IWL_CC_A_FW_PRE			"iwlwifi-cc-a0-"
 
 #define IWL_QU_B_HR_B_MODULE_FIRMWARE(api) \
 	IWL_QU_B_HR_B_FW_PRE __stringify(api) ".ucode"
-#define IWL_QNJ_B_HR_B_MODULE_FIRMWARE(api)	\
-	IWL_QNJ_B_HR_B_FW_PRE __stringify(api) ".ucode"
 #define IWL_QUZ_A_HR_B_MODULE_FIRMWARE(api) \
 	IWL_QUZ_A_HR_B_FW_PRE __stringify(api) ".ucode"
 #define IWL_QUZ_A_JF_B_MODULE_FIRMWARE(api) \
@@ -48,8 +44,6 @@
 	IWL_QU_C_HR_B_FW_PRE __stringify(api) ".ucode"
 #define IWL_QU_B_JF_B_MODULE_FIRMWARE(api) \
 	IWL_QU_B_JF_B_FW_PRE __stringify(api) ".ucode"
-#define IWL_QNJ_B_JF_B_MODULE_FIRMWARE(api)		\
-	IWL_QNJ_B_JF_B_FW_PRE __stringify(api) ".ucode"
 #define IWL_CC_A_MODULE_FIRMWARE(api)			\
 	IWL_CC_A_FW_PRE __stringify(api) ".ucode"
 
@@ -126,15 +120,6 @@ const struct iwl_ht_params iwl_22000_ht_params = {
 		},							\
 	}
 
-const struct iwl_cfg_trans_params iwl_qnj_trans_cfg = {
-	.mq_rx_supported = true,
-	.use_tfh = true,
-	.rf_id = true,
-	.gen2 = true,
-	.device_family = IWL_DEVICE_FAMILY_22000,
-	.base_params = &iwl_22000_base_params,
-};
-
 const struct iwl_cfg_trans_params iwl_qu_trans_cfg = {
 	.mq_rx_supported = true,
 	.use_tfh = true,
@@ -211,18 +196,6 @@ const struct iwl_cfg iwl9560_quz_a0_jf_b0_cfg = {
 	.num_rbds = IWL_NUM_RBDS_NON_HE,
 };
 
-const struct iwl_cfg iwl9560_qnj_b0_jf_b0_cfg = {
-	.fw_name_pre = IWL_QNJ_B_JF_B_FW_PRE,
-	IWL_DEVICE_22500,
-	/*
-	 * This device doesn't support receiving BlockAck with a large bitmap
-	 * so we need to restrict the size of transmitted aggregation to the
-	 * HT size; mac80211 would otherwise pick the HE max (256) by default.
-	 */
-	.max_tx_agg_size = IEEE80211_MAX_AMPDU_BUF_HT,
-	.num_rbds = IWL_NUM_RBDS_NON_HE,
-};
-
 const struct iwl_cfg_trans_params iwl_ax200_trans_cfg = {
 	.device_family = IWL_DEVICE_FAMILY_22000,
 	.base_params = &iwl_22000_base_params,
@@ -440,18 +413,6 @@ const struct iwl_cfg killer1650i_2ax_cfg_qu_c0_hr_b0 = {
 	.num_rbds = IWL_NUM_RBDS_22000_HE,
 };
 
-const struct iwl_cfg iwl_qnj_b0_hr_b0_cfg = {
-	.fw_name_pre = IWL_QNJ_B_HR_B_FW_PRE,
-	IWL_DEVICE_22500,
-	/*
-	 * This device doesn't support receiving BlockAck with a large bitmap
-	 * so we need to restrict the size of transmitted aggregation to the
-	 * HT size; mac80211 would otherwise pick the HE max (256) by default.
-	 */
-	.max_tx_agg_size = IEEE80211_MAX_AMPDU_BUF_HT,
-	.num_rbds = IWL_NUM_RBDS_22000_HE,
-};
-
 const struct iwl_cfg iwl_cfg_quz_a0_hr_b0 = {
 	.fw_name_pre = IWL_QUZ_A_HR_B_FW_PRE,
 	IWL_DEVICE_22500,
@@ -465,10 +426,8 @@ const struct iwl_cfg iwl_cfg_quz_a0_hr_b0 = {
 };
 
 MODULE_FIRMWARE(IWL_QU_B_HR_B_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
-MODULE_FIRMWARE(IWL_QNJ_B_HR_B_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_QU_C_HR_B_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_QU_B_JF_B_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_QUZ_A_HR_B_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_QUZ_A_JF_B_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
-MODULE_FIRMWARE(IWL_QNJ_B_JF_B_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_CC_A_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c b/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c
index 1159c0e551b0..e1c3afb97941 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c
@@ -32,10 +32,6 @@
 #define IWL_TY_A_GF_A_FW_PRE		"iwlwifi-ty-a0-gf-a0-"
 #define IWL_SO_A_GF4_A_FW_PRE		"iwlwifi-so-a0-gf4-a0-"
 #define IWL_SO_A_MR_A_FW_PRE		"iwlwifi-so-a0-mr-a0-"
-#define IWL_SNJ_A_GF4_A_FW_PRE		"iwlwifi-SoSnj-a0-gf4-a0-"
-#define IWL_SNJ_A_GF_A_FW_PRE		"iwlwifi-SoSnj-a0-gf-a0-"
-#define IWL_SNJ_A_HR_B_FW_PRE		"iwlwifi-SoSnj-a0-hr-b0-"
-#define IWL_SNJ_A_JF_B_FW_PRE		"iwlwifi-SoSnj-a0-jf-b0-"
 #define IWL_MA_A_HR_B_FW_PRE		"iwlwifi-ma-a0-hr-b0-"
 #define IWL_MA_A_GF_A_FW_PRE		"iwlwifi-ma-a0-gf-a0-"
 #define IWL_MA_A_GF4_A_FW_PRE		"iwlwifi-ma-a0-gf4-a0-"
@@ -46,7 +42,6 @@
 #define IWL_MA_B_GF4_A_FW_PRE		"iwlwifi-ma-b0-gf4-a0-"
 #define IWL_MA_B_MR_A_FW_PRE		"iwlwifi-ma-b0-mr-a0-"
 #define IWL_MA_B_FM_A_FW_PRE		"iwlwifi-ma-b0-fm-a0-"
-#define IWL_SNJ_A_MR_A_FW_PRE		"iwlwifi-SoSnj-a0-mr-a0-"
 
 #define IWL_SO_A_JF_B_MODULE_FIRMWARE(api) \
 	IWL_SO_A_JF_B_FW_PRE __stringify(api) ".ucode"
@@ -56,14 +51,6 @@
 	IWL_SO_A_GF_A_FW_PRE __stringify(api) ".ucode"
 #define IWL_TY_A_GF_A_MODULE_FIRMWARE(api) \
 	IWL_TY_A_GF_A_FW_PRE __stringify(api) ".ucode"
-#define IWL_SNJ_A_GF4_A_MODULE_FIRMWARE(api) \
-	IWL_SNJ_A_GF4_A_FW_PRE __stringify(api) ".ucode"
-#define IWL_SNJ_A_GF_A_MODULE_FIRMWARE(api) \
-	IWL_SNJ_A_GF_A_FW_PRE __stringify(api) ".ucode"
-#define IWL_SNJ_A_HR_B_MODULE_FIRMWARE(api) \
-	IWL_SNJ_A_HR_B_FW_PRE __stringify(api) ".ucode"
-#define IWL_SNJ_A_JF_B_MODULE_FIRMWARE(api) \
-	IWL_SNJ_A_JF_B_FW_PRE __stringify(api) ".ucode"
 #define IWL_MA_A_HR_B_FW_MODULE_FIRMWARE(api)		\
 	IWL_MA_A_HR_B_FW_PRE __stringify(api) ".ucode"
 #define IWL_MA_A_GF_A_FW_MODULE_FIRMWARE(api)		\
@@ -84,8 +71,6 @@
 	IWL_MA_B_MR_A_FW_PRE __stringify(api) ".ucode"
 #define IWL_MA_B_FM_A_FW_MODULE_FIRMWARE(api)		\
 	IWL_MA_B_FM_A_FW_PRE __stringify(api) ".ucode"
-#define IWL_SNJ_A_MR_A_MODULE_FIRMWARE(api) \
-	IWL_SNJ_A_MR_A_FW_PRE __stringify(api) ".ucode"
 
 static const struct iwl_base_params iwl_ax210_base_params = {
 	.eeprom_size = OTP_LOW_IMAGE_SIZE_32K,
@@ -159,15 +144,6 @@ static const struct iwl_base_params iwl_ax210_base_params = {
 		},							\
 	}
 
-const struct iwl_cfg_trans_params iwl_snj_trans_cfg = {
-	.mq_rx_supported = true,
-	.rf_id = true,
-	.gen2 = true,
-	.device_family = IWL_DEVICE_FAMILY_AX210,
-	.base_params = &iwl_ax210_base_params,
-	.umac_prph_offset = 0x300000,
-};
-
 const struct iwl_cfg_trans_params iwl_so_trans_cfg = {
 	.mq_rx_supported = true,
 	.rf_id = true,
@@ -297,36 +273,6 @@ const struct iwl_cfg iwlax411_2ax_cfg_so_gf4_a0_long = {
 	.trans.low_latency_xtal = true,
 };
 
-const struct iwl_cfg iwlax411_2ax_cfg_sosnj_gf4_a0 = {
-	.name = iwl_ax411_name,
-	.fw_name_pre = IWL_SNJ_A_GF4_A_FW_PRE,
-	.uhb_supported = true,
-	IWL_DEVICE_AX210,
-	.num_rbds = IWL_NUM_RBDS_AX210_HE,
-};
-
-const struct iwl_cfg iwlax211_cfg_snj_gf_a0 = {
-	.name = iwl_ax211_name,
-	.fw_name_pre = IWL_SNJ_A_GF_A_FW_PRE,
-	.uhb_supported = true,
-	IWL_DEVICE_AX210,
-	.num_rbds = IWL_NUM_RBDS_AX210_HE,
-};
-
-const struct iwl_cfg iwl_cfg_snj_hr_b0 = {
-	.fw_name_pre = IWL_SNJ_A_HR_B_FW_PRE,
-	.uhb_supported = true,
-	IWL_DEVICE_AX210,
-	.num_rbds = IWL_NUM_RBDS_AX210_HE,
-};
-
-const struct iwl_cfg iwl_cfg_snj_a0_jf_b0 = {
-	.fw_name_pre = IWL_SNJ_A_JF_B_FW_PRE,
-	.uhb_supported = true,
-	IWL_DEVICE_AX210,
-	.num_rbds = IWL_NUM_RBDS_AX210_HE,
-};
-
 const struct iwl_cfg iwl_cfg_ma_a0_hr_b0 = {
 	.fw_name_pre = IWL_MA_A_HR_B_FW_PRE,
 	.uhb_supported = true,
@@ -411,20 +357,6 @@ const struct iwl_cfg iwl_cfg_ma_a0_fm_a0 = {
 	.num_rbds = IWL_NUM_RBDS_AX210_HE,
 };
 
-const struct iwl_cfg iwl_cfg_snj_a0_mr_a0 = {
-	.fw_name_pre = IWL_SNJ_A_MR_A_FW_PRE,
-	.uhb_supported = true,
-	IWL_DEVICE_AX210,
-	.num_rbds = IWL_NUM_RBDS_AX210_HE,
-};
-
-const struct iwl_cfg iwl_cfg_snj_a0_ms_a0 = {
-	.fw_name_pre = IWL_SNJ_A_MR_A_FW_PRE,
-	.uhb_supported = false,
-	IWL_DEVICE_AX210,
-	.num_rbds = IWL_NUM_RBDS_AX210_HE,
-};
-
 const struct iwl_cfg iwl_cfg_so_a0_hr_a0 = {
 	.fw_name_pre = IWL_SO_A_HR_B_FW_PRE,
 	IWL_DEVICE_AX210,
@@ -435,10 +367,6 @@ MODULE_FIRMWARE(IWL_SO_A_JF_B_MODULE_FIRMWARE(IWL_AX210_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_SO_A_HR_B_MODULE_FIRMWARE(IWL_AX210_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_SO_A_GF_A_MODULE_FIRMWARE(IWL_AX210_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_TY_A_GF_A_MODULE_FIRMWARE(IWL_AX210_UCODE_API_MAX));
-MODULE_FIRMWARE(IWL_SNJ_A_GF4_A_MODULE_FIRMWARE(IWL_AX210_UCODE_API_MAX));
-MODULE_FIRMWARE(IWL_SNJ_A_GF_A_MODULE_FIRMWARE(IWL_AX210_UCODE_API_MAX));
-MODULE_FIRMWARE(IWL_SNJ_A_HR_B_MODULE_FIRMWARE(IWL_AX210_UCODE_API_MAX));
-MODULE_FIRMWARE(IWL_SNJ_A_JF_B_MODULE_FIRMWARE(IWL_AX210_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_MA_A_HR_B_FW_MODULE_FIRMWARE(IWL_AX210_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_MA_A_GF_A_FW_MODULE_FIRMWARE(IWL_AX210_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_MA_A_GF4_A_FW_MODULE_FIRMWARE(IWL_AX210_UCODE_API_MAX));
@@ -449,4 +377,3 @@ MODULE_FIRMWARE(IWL_MA_B_GF_A_FW_MODULE_FIRMWARE(IWL_AX210_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_MA_B_GF4_A_FW_MODULE_FIRMWARE(IWL_AX210_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_MA_B_MR_A_FW_MODULE_FIRMWARE(IWL_AX210_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_MA_B_FM_A_FW_MODULE_FIRMWARE(IWL_AX210_UCODE_API_MAX));
-MODULE_FIRMWARE(IWL_SNJ_A_MR_A_MODULE_FIRMWARE(IWL_AX210_UCODE_API_MAX));
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
index b6795e08bd40..eb737e906df2 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
@@ -44,25 +44,6 @@
 #define IWL_GL_B_FM_B_FW_PRE		"iwlwifi-gl-b0-fm-b0-"
 #define IWL_GL_C_FM_C_FW_PRE		"iwlwifi-gl-c0-fm-c0-"
 #define IWL_BZ_Z_GF_A_FW_PRE		"iwlwifi-bz-z0-gf-a0-"
-#define IWL_BNJ_A_FM_A_FW_PRE		"iwlwifi-BzBnj-a0-fm-a0-"
-#define IWL_BNJ_A_FM4_A_FW_PRE		"iwlwifi-BzBnj-a0-fm4-a0-"
-#define IWL_BNJ_B_FM4_B_FW_PRE		"iwlwifi-BzBnj-b0-fm4-b0-"
-#define IWL_BNJ_A_GF_A_FW_PRE		"iwlwifi-BzBnj-a0-gf-a0-"
-#define IWL_BNJ_B_GF_A_FW_PRE		"iwlwifi-BzBnj-b0-gf-a0-"
-#define IWL_BNJ_C_GF_A_FW_PRE		"iwlwifi-BzBnj-c0-gf-a0-"
-#define IWL_BNJ_A_GF4_A_FW_PRE		"iwlwifi-BzBnj-a0-gf4-a0-"
-#define IWL_BNJ_B_GF4_A_FW_PRE		"iwlwifi-BzBnj-b0-gf4-a0-"
-#define IWL_BNJ_C_GF4_A_FW_PRE		"iwlwifi-BzBnj-c0-gf4-a0-"
-#define IWL_BNJ_A_HR_A_FW_PRE		"iwlwifi-BzBnj-a0-hr-b0-"
-#define IWL_BNJ_A_HR_B_FW_PRE		"iwlwifi-BzBnj-a0-hr-b0-"
-#define IWL_BNJ_B_HR_A_FW_PRE		"iwlwifi-BzBnj-b0-hr-b0-"
-#define IWL_BNJ_B_HR_B_FW_PRE		"iwlwifi-BzBnj-b0-hr-b0-"
-#define IWL_BNJ_C_HR_B_FW_PRE		"iwlwifi-BzBnj-c0-hr-b0-"
-#define IWL_BNJ_B_FM_B_FW_PRE		"iwlwifi-BzBnj-b0-fm-b0-"
-#define IWL_BNJ_C_FM_C_FW_PRE		"iwlwifi-BzBnj-c0-fm-c0-"
-#define IWL_BNJ_A_WH_A_FW_PRE		"iwlwifi-BzBnj-a0-wh-a0-"
-#define IWL_BNJ_B_WH_A_FW_PRE		"iwlwifi-BzBnj-b0-wh-a0-"
-#define IWL_BNJ_C_WH_A_FW_PRE		"iwlwifi-BzBnj-c0-wh-a0-"
 
 #define IWL_BZ_A_HR_A_MODULE_FIRMWARE(api) \
 	IWL_BZ_A_HR_A_FW_PRE __stringify(api) ".ucode"
@@ -98,45 +79,6 @@
 	IWL_GL_B_FM_B_FW_PRE __stringify(api) ".ucode"
 #define IWL_GL_C_FM_C_MODULE_FIRMWARE(api) \
 	IWL_GL_C_FM_C_FW_PRE __stringify(api) ".ucode"
-#define IWL_BNJ_A_FM_A_MODULE_FIRMWARE(api) \
-	IWL_BNJ_A_FM_A_FW_PRE __stringify(api) ".ucode"
-#define IWL_BNJ_A_FM4_A_MODULE_FIRMWARE(api) \
-	IWL_BNJ_A_FM4_A_FW_PRE __stringify(api) ".ucode"
-#define IWL_BNJ_B_FM4_B_MODULE_FIRMWARE(api) \
-	IWL_BNJ_B_FM4_B_FW_PRE __stringify(api) ".ucode"
-#define IWL_BNJ_A_GF_A_MODULE_FIRMWARE(api) \
-	IWL_BNJ_A_GF_A_FW_PRE __stringify(api) ".ucode"
-#define IWL_BNJ_B_GF_A_MODULE_FIRMWARE(api) \
-	IWL_BNJ_B_GF_A_FW_PRE __stringify(api) ".ucode"
-#define IWL_BNJ_C_GF_A_MODULE_FIRMWARE(api) \
-		IWL_BNJ_C_GF_A_FW_PRE __stringify(api) ".ucode"
-#define IWL_BNJ_A_GF4_A_MODULE_FIRMWARE(api) \
-	IWL_BNJ_A_GF4_A_FW_PRE __stringify(api) ".ucode"
-#define IWL_BNJ_B_GF4_A_MODULE_FIRMWARE(api) \
-	IWL_BNJ_B_GF4_A_FW_PRE __stringify(api) ".ucode"
-#define IWL_BNJ_C_GF4_A_MODULE_FIRMWARE(api) \
-		IWL_BNJ_C_GF4_A_FW_PRE __stringify(api) ".ucode"
-
-#define IWL_BNJ_A_HR_A_MODULE_FIRMWARE(api) \
-	IWL_BNJ_A_HR_A_FW_PRE __stringify(api) ".ucode"
-#define IWL_BNJ_A_HR_B_MODULE_FIRMWARE(api) \
-	IWL_BNJ_A_HR_B_FW_PRE __stringify(api) ".ucode"
-#define IWL_BNJ_B_HR_A_MODULE_FIRMWARE(api) \
-	IWL_BNJ_B_HR_A_FW_PRE __stringify(api) ".ucode"
-#define IWL_BNJ_B_HR_B_MODULE_FIRMWARE(api) \
-	IWL_BNJ_B_HR_B_FW_PRE __stringify(api) ".ucode"
-#define IWL_BNJ_C_HR_B_MODULE_FIRMWARE(api) \
-	IWL_BNJ_B_HR_B_FW_PRE __stringify(api) ".ucode"
-#define IWL_BNJ_B_FM_B_MODULE_FIRMWARE(api) \
-	IWL_BNJ_B_FM_B_FW_PRE __stringify(api) ".ucode"
-#define IWL_BNJ_C_FM_C_MODULE_FIRMWARE(api) \
-	IWL_BNJ_C_FM_C_FW_PRE __stringify(api) ".ucode"
-#define IWL_BNJ_A_WH_A_MODULE_FIRMWARE(api) \
-	IWL_BNJ_A_WH_A_FW_PRE __stringify(api) ".ucode"
-#define IWL_BNJ_B_WH_A_MODULE_FIRMWARE(api) \
-	IWL_BNJ_B_WH_A_FW_PRE __stringify(api) ".ucode"
-#define IWL_BNJ_C_WH_A_MODULE_FIRMWARE(api) \
-	IWL_BNJ_C_WH_A_FW_PRE __stringify(api) ".ucode"
 
 static const struct iwl_base_params iwl_bz_base_params = {
 	.eeprom_size = OTP_LOW_IMAGE_SIZE_32K,
@@ -393,102 +335,6 @@ const struct iwl_cfg iwl_cfg_bz_z0_gf_a0 = {
 	.num_rbds = IWL_NUM_RBDS_BZ_HE,
 };
 
-const struct iwl_cfg iwl_cfg_bnj_a0_fm_a0 = {
-	.fw_name_pre = IWL_BNJ_A_FM_A_FW_PRE,
-	.uhb_supported = true,
-	IWL_DEVICE_BZ,
-	.features = IWL_TX_CSUM_NETIF_FLAGS | NETIF_F_RXCSUM,
-	.num_rbds = IWL_NUM_RBDS_BZ_HE,
-};
-
-const struct iwl_cfg iwl_cfg_bnj_a0_fm4_a0 = {
-	.fw_name_pre = IWL_BNJ_A_FM4_A_FW_PRE,
-	.uhb_supported = true,
-	IWL_DEVICE_BZ,
-	.features = IWL_TX_CSUM_NETIF_FLAGS | NETIF_F_RXCSUM,
-	.num_rbds = IWL_NUM_RBDS_BZ_HE,
-};
-
-const struct iwl_cfg iwl_cfg_bnj_b0_fm4_b0 = {
-	.fw_name_pre = IWL_BNJ_B_FM4_B_FW_PRE,
-	.uhb_supported = true,
-	IWL_DEVICE_BZ,
-	.features = IWL_TX_CSUM_NETIF_FLAGS | NETIF_F_RXCSUM,
-	.num_rbds = IWL_NUM_RBDS_BZ_HE,
-};
-
-const struct iwl_cfg iwl_cfg_bnj_a0_gf_a0 = {
-	.fw_name_pre = IWL_BNJ_A_GF_A_FW_PRE,
-	.uhb_supported = true,
-	IWL_DEVICE_BZ,
-	.features = IWL_TX_CSUM_NETIF_FLAGS | NETIF_F_RXCSUM,
-	.num_rbds = IWL_NUM_RBDS_BZ_HE,
-};
-
-const struct iwl_cfg iwl_cfg_bnj_b0_gf_a0 = {
-	.fw_name_pre = IWL_BNJ_B_GF_A_FW_PRE,
-	.uhb_supported = true,
-	IWL_DEVICE_BZ,
-	.features = IWL_TX_CSUM_NETIF_FLAGS | NETIF_F_RXCSUM,
-	.num_rbds = IWL_NUM_RBDS_BZ_HE,
-};
-
-const struct iwl_cfg iwl_cfg_bnj_a0_gf4_a0 = {
-	.fw_name_pre = IWL_BNJ_A_GF4_A_FW_PRE,
-	.uhb_supported = true,
-	IWL_DEVICE_BZ,
-	.features = IWL_TX_CSUM_NETIF_FLAGS | NETIF_F_RXCSUM,
-	.num_rbds = IWL_NUM_RBDS_BZ_HE,
-};
-
-const struct iwl_cfg iwl_cfg_bnj_b0_gf4_a0 = {
-	.fw_name_pre = IWL_BNJ_B_GF4_A_FW_PRE,
-	.uhb_supported = true,
-	IWL_DEVICE_BZ,
-	.features = IWL_TX_CSUM_NETIF_FLAGS | NETIF_F_RXCSUM,
-	.num_rbds = IWL_NUM_RBDS_BZ_HE,
-};
-
-const struct iwl_cfg iwl_cfg_bnj_a0_hr_a0 = {
-	.fw_name_pre = IWL_BNJ_A_HR_A_FW_PRE,
-	.uhb_supported = true,
-	IWL_DEVICE_BZ,
-	.features = IWL_TX_CSUM_NETIF_FLAGS | NETIF_F_RXCSUM,
-	.num_rbds = IWL_NUM_RBDS_BZ_HE,
-};
-
-const struct iwl_cfg iwl_cfg_bnj_a0_hr_b0 = {
-	.fw_name_pre = IWL_BNJ_A_HR_B_FW_PRE,
-	.uhb_supported = true,
-	IWL_DEVICE_BZ,
-	.features = IWL_TX_CSUM_NETIF_FLAGS | NETIF_F_RXCSUM,
-	.num_rbds = IWL_NUM_RBDS_BZ_HE,
-};
-
-const struct iwl_cfg iwl_cfg_bnj_b0_hr_a0 = {
-	.fw_name_pre = IWL_BNJ_B_HR_A_FW_PRE,
-	.uhb_supported = true,
-	IWL_DEVICE_BZ,
-	.features = IWL_TX_CSUM_NETIF_FLAGS | NETIF_F_RXCSUM,
-	.num_rbds = IWL_NUM_RBDS_BZ_HE,
-};
-
-const struct iwl_cfg iwl_cfg_bnj_b0_hr_b0 = {
-	.fw_name_pre = IWL_BNJ_B_HR_B_FW_PRE,
-	.uhb_supported = true,
-	IWL_DEVICE_BZ,
-	.features = IWL_TX_CSUM_NETIF_FLAGS | NETIF_F_RXCSUM,
-	.num_rbds = IWL_NUM_RBDS_BZ_HE,
-};
-
-const struct iwl_cfg iwl_cfg_bnj_b0_fm_b0 = {
-	.fw_name_pre = IWL_BNJ_B_FM_B_FW_PRE,
-	.uhb_supported = true,
-	IWL_DEVICE_BZ,
-	.features = IWL_TX_CSUM_NETIF_FLAGS_BZ | NETIF_F_RXCSUM,
-	.num_rbds = IWL_NUM_RBDS_BZ_HE,
-};
-
 
 MODULE_FIRMWARE(IWL_BZ_A_HR_A_MODULE_FIRMWARE(IWL_BZ_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_BZ_A_HR_B_MODULE_FIRMWARE(IWL_BZ_UCODE_API_MAX));
@@ -499,25 +345,7 @@ MODULE_FIRMWARE(IWL_BZ_A_FM_A_MODULE_FIRMWARE(IWL_BZ_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_BZ_A_FM_B_MODULE_FIRMWARE(IWL_BZ_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_BZ_A_FM_C_MODULE_FIRMWARE(IWL_BZ_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_GL_A_FM_A_MODULE_FIRMWARE(IWL_BZ_UCODE_API_MAX));
-MODULE_FIRMWARE(IWL_BNJ_A_FM_A_MODULE_FIRMWARE(IWL_BZ_UCODE_API_MAX));
-MODULE_FIRMWARE(IWL_BNJ_A_FM4_A_MODULE_FIRMWARE(IWL_BZ_UCODE_API_MAX));
-MODULE_FIRMWARE(IWL_BNJ_B_FM4_B_MODULE_FIRMWARE(IWL_BZ_UCODE_API_MAX));
-MODULE_FIRMWARE(IWL_BNJ_A_GF_A_MODULE_FIRMWARE(IWL_BZ_UCODE_API_MAX));
-MODULE_FIRMWARE(IWL_BNJ_B_GF_A_MODULE_FIRMWARE(IWL_BZ_UCODE_API_MAX));
-MODULE_FIRMWARE(IWL_BNJ_C_GF_A_MODULE_FIRMWARE(IWL_BZ_UCODE_API_MAX));
-MODULE_FIRMWARE(IWL_BNJ_A_GF4_A_MODULE_FIRMWARE(IWL_BZ_UCODE_API_MAX));
-MODULE_FIRMWARE(IWL_BNJ_B_GF4_A_MODULE_FIRMWARE(IWL_BZ_UCODE_API_MAX));
-MODULE_FIRMWARE(IWL_BNJ_C_GF4_A_MODULE_FIRMWARE(IWL_BZ_UCODE_API_MAX));
-MODULE_FIRMWARE(IWL_BNJ_A_HR_B_MODULE_FIRMWARE(IWL_BZ_UCODE_API_MAX));
-MODULE_FIRMWARE(IWL_BNJ_B_HR_A_MODULE_FIRMWARE(IWL_BZ_UCODE_API_MAX));
-MODULE_FIRMWARE(IWL_BNJ_B_HR_B_MODULE_FIRMWARE(IWL_BZ_UCODE_API_MAX));
-MODULE_FIRMWARE(IWL_BNJ_C_HR_B_MODULE_FIRMWARE(IWL_BZ_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_BZ_A_FM4_A_MODULE_FIRMWARE(IWL_BZ_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_BZ_A_FM4_B_MODULE_FIRMWARE(IWL_BZ_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_GL_B_FM_B_MODULE_FIRMWARE(IWL_BZ_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_GL_C_FM_C_MODULE_FIRMWARE(IWL_BZ_UCODE_API_MAX));
-MODULE_FIRMWARE(IWL_BNJ_B_FM_B_MODULE_FIRMWARE(IWL_BZ_UCODE_API_MAX));
-MODULE_FIRMWARE(IWL_BNJ_C_FM_C_MODULE_FIRMWARE(IWL_BZ_UCODE_API_MAX));
-MODULE_FIRMWARE(IWL_BNJ_A_WH_A_MODULE_FIRMWARE(IWL_BZ_UCODE_API_MAX));
-MODULE_FIRMWARE(IWL_BNJ_B_WH_A_MODULE_FIRMWARE(IWL_BZ_UCODE_API_MAX));
-MODULE_FIRMWARE(IWL_BNJ_C_WH_A_MODULE_FIRMWARE(IWL_BZ_UCODE_API_MAX));
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index ef5154cf114b..a18cbe75646f 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -417,13 +417,10 @@ struct iwl_cfg {
 #define IWL_CFG_ANY (~0)
 
 #define IWL_CFG_MAC_TYPE_PU		0x31
-#define IWL_CFG_MAC_TYPE_PNJ		0x32
 #define IWL_CFG_MAC_TYPE_TH		0x32
 #define IWL_CFG_MAC_TYPE_QU		0x33
 #define IWL_CFG_MAC_TYPE_QUZ		0x35
-#define IWL_CFG_MAC_TYPE_QNJ		0x36
 #define IWL_CFG_MAC_TYPE_SO		0x37
-#define IWL_CFG_MAC_TYPE_SNJ		0x42
 #define IWL_CFG_MAC_TYPE_SOF		0x43
 #define IWL_CFG_MAC_TYPE_MA		0x44
 #define IWL_CFG_MAC_TYPE_BZ		0x46
@@ -489,12 +486,10 @@ extern const struct iwl_cfg_trans_params iwl9000_trans_cfg;
 extern const struct iwl_cfg_trans_params iwl9560_trans_cfg;
 extern const struct iwl_cfg_trans_params iwl9560_long_latency_trans_cfg;
 extern const struct iwl_cfg_trans_params iwl9560_shared_clk_trans_cfg;
-extern const struct iwl_cfg_trans_params iwl_qnj_trans_cfg;
 extern const struct iwl_cfg_trans_params iwl_qu_trans_cfg;
 extern const struct iwl_cfg_trans_params iwl_qu_medium_latency_trans_cfg;
 extern const struct iwl_cfg_trans_params iwl_qu_long_latency_trans_cfg;
 extern const struct iwl_cfg_trans_params iwl_ax200_trans_cfg;
-extern const struct iwl_cfg_trans_params iwl_snj_trans_cfg;
 extern const struct iwl_cfg_trans_params iwl_so_trans_cfg;
 extern const struct iwl_cfg_trans_params iwl_so_long_latency_trans_cfg;
 extern const struct iwl_cfg_trans_params iwl_so_long_latency_imr_trans_cfg;
@@ -610,7 +605,6 @@ extern const struct iwl_cfg iwl9260_2ac_cfg;
 extern const struct iwl_cfg iwl9560_qu_b0_jf_b0_cfg;
 extern const struct iwl_cfg iwl9560_qu_c0_jf_b0_cfg;
 extern const struct iwl_cfg iwl9560_quz_a0_jf_b0_cfg;
-extern const struct iwl_cfg iwl9560_qnj_b0_jf_b0_cfg;
 extern const struct iwl_cfg iwl9560_2ac_cfg_soc;
 extern const struct iwl_cfg iwl_qu_b0_hr1_b0;
 extern const struct iwl_cfg iwl_qu_c0_hr1_b0;
@@ -629,17 +623,12 @@ extern const struct iwl_cfg killer1650s_2ax_cfg_qu_c0_hr_b0;
 extern const struct iwl_cfg killer1650i_2ax_cfg_qu_c0_hr_b0;
 extern const struct iwl_cfg killer1650x_2ax_cfg;
 extern const struct iwl_cfg killer1650w_2ax_cfg;
-extern const struct iwl_cfg iwl_qnj_b0_hr_b0_cfg;
 extern const struct iwl_cfg iwlax210_2ax_cfg_so_jf_b0;
 extern const struct iwl_cfg iwlax211_2ax_cfg_so_gf_a0;
 extern const struct iwl_cfg iwlax211_2ax_cfg_so_gf_a0_long;
 extern const struct iwl_cfg iwlax210_2ax_cfg_ty_gf_a0;
 extern const struct iwl_cfg iwlax411_2ax_cfg_so_gf4_a0;
 extern const struct iwl_cfg iwlax411_2ax_cfg_so_gf4_a0_long;
-extern const struct iwl_cfg iwlax411_2ax_cfg_sosnj_gf4_a0;
-extern const struct iwl_cfg iwlax211_cfg_snj_gf_a0;
-extern const struct iwl_cfg iwl_cfg_snj_hr_b0;
-extern const struct iwl_cfg iwl_cfg_snj_a0_jf_b0;
 extern const struct iwl_cfg iwl_cfg_ma_a0_hr_b0;
 extern const struct iwl_cfg iwl_cfg_ma_a0_gf_a0;
 extern const struct iwl_cfg iwl_cfg_ma_a0_gf4_a0;
@@ -651,8 +640,6 @@ extern const struct iwl_cfg iwl_cfg_ma_b0_gf_a0;
 extern const struct iwl_cfg iwl_cfg_ma_b0_gf4_a0;
 extern const struct iwl_cfg iwl_cfg_ma_b0_mr_a0;
 extern const struct iwl_cfg iwl_cfg_ma_b0_fm_a0;
-extern const struct iwl_cfg iwl_cfg_snj_a0_mr_a0;
-extern const struct iwl_cfg iwl_cfg_snj_a0_ms_a0;
 extern const struct iwl_cfg iwl_cfg_so_a0_hr_a0;
 extern const struct iwl_cfg iwl_cfg_so_a0_ms_a0;
 extern const struct iwl_cfg iwl_cfg_quz_a0_hr_b0;
@@ -674,18 +661,6 @@ extern const struct iwl_cfg iwl_cfg_gl_a0_fm_a0;
 extern const struct iwl_cfg iwl_cfg_gl_b0_fm_b0;
 extern const struct iwl_cfg iwl_cfg_gl_c0_fm_c0;
 extern const struct iwl_cfg iwl_cfg_bz_z0_gf_a0;
-extern const struct iwl_cfg iwl_cfg_bnj_a0_fm_a0;
-extern const struct iwl_cfg iwl_cfg_bnj_a0_fm4_a0;
-extern const struct iwl_cfg iwl_cfg_bnj_a0_gf_a0;
-extern const struct iwl_cfg iwl_cfg_bnj_b0_gf_a0;
-extern const struct iwl_cfg iwl_cfg_bnj_a0_gf4_a0;
-extern const struct iwl_cfg iwl_cfg_bnj_b0_gf4_a0;
-extern const struct iwl_cfg iwl_cfg_bnj_a0_hr_a0;
-extern const struct iwl_cfg iwl_cfg_bnj_a0_hr_b0;
-extern const struct iwl_cfg iwl_cfg_bnj_b0_hr_a0;
-extern const struct iwl_cfg iwl_cfg_bnj_b0_hr_b0;
-extern const struct iwl_cfg iwl_cfg_bnj_b0_fm_b0;
-extern const struct iwl_cfg iwl_cfg_bnj_b0_fm4_b0;
 extern const struct iwl_cfg iwl_cfg_sc_a0_fm_b0;
 extern const struct iwl_cfg iwl_cfg_sc_a0_fm_c0;
 extern const struct iwl_cfg iwl_cfg_sc_a0_hr_a0;
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 2b342e832f22..49b396bf4f49 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -484,13 +484,10 @@ static const struct pci_device_id iwl_hw_card_ids[] = {
 	{IWL_PCI_DEVICE(0x43F0, PCI_ANY_ID, iwl_qu_long_latency_trans_cfg)},
 	{IWL_PCI_DEVICE(0xA0F0, PCI_ANY_ID, iwl_qu_long_latency_trans_cfg)},
 
-	{IWL_PCI_DEVICE(0x2720, PCI_ANY_ID, iwl_qnj_trans_cfg)},
-
 	{IWL_PCI_DEVICE(0x2723, PCI_ANY_ID, iwl_ax200_trans_cfg)},
 
 /* So devices */
 	{IWL_PCI_DEVICE(0x2725, PCI_ANY_ID, iwl_so_trans_cfg)},
-	{IWL_PCI_DEVICE(0x2726, PCI_ANY_ID, iwl_snj_trans_cfg)},
 	{IWL_PCI_DEVICE(0x7A70, PCI_ANY_ID, iwl_so_long_latency_imr_trans_cfg)},
 	{IWL_PCI_DEVICE(0x7AF0, PCI_ANY_ID, iwl_so_trans_cfg)},
 	{IWL_PCI_DEVICE(0x51F0, PCI_ANY_ID, iwl_so_long_latency_trans_cfg)},
@@ -666,20 +663,6 @@ static const struct iwl_dev_info iwl_dev_info_table[] = {
 	IWL_DEV_INFO(0x7AF0, 0x1551, iwl9560_2ac_cfg_soc, iwl9560_killer_1550s_160_name),
 	IWL_DEV_INFO(0x7AF0, 0x1552, iwl9560_2ac_cfg_soc, iwl9560_killer_1550i_160_name),
 
-	/* SnJ with HR */
-	IWL_DEV_INFO(0x2725, 0x00B0, iwlax411_2ax_cfg_sosnj_gf4_a0, NULL),
-	IWL_DEV_INFO(0x2726, 0x0090, iwlax211_cfg_snj_gf_a0, NULL),
-	IWL_DEV_INFO(0x2726, 0x0098, iwlax211_cfg_snj_gf_a0, NULL),
-	IWL_DEV_INFO(0x2726, 0x00B0, iwlax411_2ax_cfg_sosnj_gf4_a0, NULL),
-	IWL_DEV_INFO(0x2726, 0x00B4, iwlax411_2ax_cfg_sosnj_gf4_a0, NULL),
-	IWL_DEV_INFO(0x2726, 0x0510, iwlax211_cfg_snj_gf_a0, NULL),
-	IWL_DEV_INFO(0x2726, 0x1651, iwl_cfg_snj_hr_b0, iwl_ax201_killer_1650s_name),
-	IWL_DEV_INFO(0x2726, 0x1652, iwl_cfg_snj_hr_b0, iwl_ax201_killer_1650i_name),
-	IWL_DEV_INFO(0x2726, 0x1691, iwlax411_2ax_cfg_sosnj_gf4_a0, iwl_ax411_killer_1690s_name),
-	IWL_DEV_INFO(0x2726, 0x1692, iwlax411_2ax_cfg_sosnj_gf4_a0, iwl_ax411_killer_1690i_name),
-	IWL_DEV_INFO(0x7F70, 0x1691, iwlax411_2ax_cfg_so_gf4_a0, iwl_ax411_killer_1690s_name),
-	IWL_DEV_INFO(0x7F70, 0x1692, iwlax411_2ax_cfg_so_gf4_a0, iwl_ax411_killer_1690i_name),
-
 	/* SO with GF2 */
 	IWL_DEV_INFO(0x2726, 0x1671, iwlax211_2ax_cfg_so_gf_a0, iwl_ax211_killer_1675s_name),
 	IWL_DEV_INFO(0x2726, 0x1672, iwlax211_2ax_cfg_so_gf_a0, iwl_ax211_killer_1675i_name),
@@ -730,27 +713,6 @@ static const struct iwl_dev_info iwl_dev_info_table[] = {
 		      IWL_CFG_NO_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB, IWL_CFG_ANY,
 		      iwl9560_2ac_cfg_soc, iwl9560_name),
 
-	_IWL_DEV_INFO(0x2526, IWL_CFG_ANY,
-		      IWL_CFG_MAC_TYPE_PNJ, IWL_CFG_ANY,
-		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1, IWL_CFG_ANY,
-		      IWL_CFG_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB, IWL_CFG_ANY,
-		      iwl9260_2ac_cfg, iwl9461_160_name),
-	_IWL_DEV_INFO(0x2526, IWL_CFG_ANY,
-		      IWL_CFG_MAC_TYPE_PNJ, IWL_CFG_ANY,
-		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1, IWL_CFG_ANY,
-		      IWL_CFG_NO_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB, IWL_CFG_ANY,
-		      iwl9260_2ac_cfg, iwl9461_name),
-	_IWL_DEV_INFO(0x2526, IWL_CFG_ANY,
-		      IWL_CFG_MAC_TYPE_PNJ, IWL_CFG_ANY,
-		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1_DIV, IWL_CFG_ANY,
-		      IWL_CFG_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB, IWL_CFG_ANY,
-		      iwl9260_2ac_cfg, iwl9462_160_name),
-	_IWL_DEV_INFO(0x2526, IWL_CFG_ANY,
-		      IWL_CFG_MAC_TYPE_PNJ, IWL_CFG_ANY,
-		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1_DIV, IWL_CFG_ANY,
-		      IWL_CFG_NO_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB, IWL_CFG_ANY,
-		      iwl9260_2ac_cfg, iwl9462_name),
-
 	_IWL_DEV_INFO(0x2526, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_TH, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_TH, IWL_CFG_ANY, IWL_CFG_ANY,
@@ -917,50 +879,6 @@ static const struct iwl_dev_info iwl_dev_info_table[] = {
 		      IWL_CFG_NO_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB, IWL_CFG_ANY,
 		      iwl9560_quz_a0_jf_b0_cfg, iwl9560_killer_1550i_name),
 
-	/* QnJ */
-	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_MAC_TYPE_QNJ, IWL_CFG_ANY,
-		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1, IWL_CFG_ANY,
-		      IWL_CFG_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB, IWL_CFG_ANY,
-		      iwl9560_qnj_b0_jf_b0_cfg, iwl9461_160_name),
-	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_MAC_TYPE_QNJ, IWL_CFG_ANY,
-		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1, IWL_CFG_ANY,
-		      IWL_CFG_NO_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB, IWL_CFG_ANY,
-		      iwl9560_qnj_b0_jf_b0_cfg, iwl9461_name),
-	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_MAC_TYPE_QNJ, IWL_CFG_ANY,
-		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1_DIV, IWL_CFG_ANY,
-		      IWL_CFG_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB, IWL_CFG_ANY,
-		      iwl9560_qnj_b0_jf_b0_cfg, iwl9462_160_name),
-	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_MAC_TYPE_QNJ, IWL_CFG_ANY,
-		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1_DIV, IWL_CFG_ANY,
-		      IWL_CFG_NO_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB, IWL_CFG_ANY,
-		      iwl9560_qnj_b0_jf_b0_cfg, iwl9462_name),
-
-	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_MAC_TYPE_QNJ, IWL_CFG_ANY,
-		      IWL_CFG_RF_TYPE_JF2, IWL_CFG_RF_ID_JF, IWL_CFG_ANY,
-		      IWL_CFG_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB, IWL_CFG_ANY,
-		      iwl9560_qnj_b0_jf_b0_cfg, iwl9560_160_name),
-	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_MAC_TYPE_QNJ, IWL_CFG_ANY,
-		      IWL_CFG_RF_TYPE_JF2, IWL_CFG_RF_ID_JF, IWL_CFG_ANY,
-		      IWL_CFG_NO_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB, IWL_CFG_ANY,
-		      iwl9560_qnj_b0_jf_b0_cfg, iwl9560_name),
-
-	_IWL_DEV_INFO(IWL_CFG_ANY, 0x1551,
-		      IWL_CFG_MAC_TYPE_QNJ, IWL_CFG_ANY,
-		      IWL_CFG_RF_TYPE_JF2, IWL_CFG_RF_ID_JF, IWL_CFG_ANY,
-		      IWL_CFG_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB, IWL_CFG_ANY,
-		      iwl9560_qnj_b0_jf_b0_cfg, iwl9560_killer_1550s_name),
-	_IWL_DEV_INFO(IWL_CFG_ANY, 0x1552,
-		      IWL_CFG_MAC_TYPE_QNJ, IWL_CFG_ANY,
-		      IWL_CFG_RF_TYPE_JF2, IWL_CFG_RF_ID_JF, IWL_CFG_ANY,
-		      IWL_CFG_NO_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB, IWL_CFG_ANY,
-		      iwl9560_qnj_b0_jf_b0_cfg, iwl9560_killer_1550i_name),
-
 /* Qu with Hr */
 	/* Qu B step */
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
@@ -1008,59 +926,6 @@ static const struct iwl_dev_info iwl_dev_info_table[] = {
 		      IWL_CFG_160, IWL_CFG_ANY, IWL_CFG_NO_CDB, IWL_CFG_ANY,
 		      iwl_cfg_quz_a0_hr_b0, iwl_ax201_name),
 
-/* QnJ with Hr */
-	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_MAC_TYPE_QNJ, IWL_CFG_ANY,
-		      IWL_CFG_RF_TYPE_HR2, IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB, IWL_CFG_ANY,
-		      iwl_qnj_b0_hr_b0_cfg, iwl_ax201_name),
-
-/* SnJ with Jf */
-	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_MAC_TYPE_SNJ, IWL_CFG_ANY,
-		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1, IWL_CFG_ANY,
-		      IWL_CFG_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB, IWL_CFG_ANY,
-		      iwl_cfg_snj_a0_jf_b0, iwl9461_160_name),
-	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_MAC_TYPE_SNJ, IWL_CFG_ANY,
-		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1, IWL_CFG_ANY,
-		      IWL_CFG_NO_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB, IWL_CFG_ANY,
-		      iwl_cfg_snj_a0_jf_b0, iwl9461_name),
-	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_MAC_TYPE_SNJ, IWL_CFG_ANY,
-		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1_DIV, IWL_CFG_ANY,
-		      IWL_CFG_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB, IWL_CFG_ANY,
-		      iwl_cfg_snj_a0_jf_b0, iwl9462_160_name),
-	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_MAC_TYPE_SNJ, IWL_CFG_ANY,
-		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1_DIV, IWL_CFG_ANY,
-		      IWL_CFG_NO_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB, IWL_CFG_ANY,
-		      iwl_cfg_snj_a0_jf_b0, iwl9462_name),
-
-	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_MAC_TYPE_SNJ, IWL_CFG_ANY,
-		      IWL_CFG_RF_TYPE_JF2, IWL_CFG_RF_ID_JF, IWL_CFG_ANY,
-		      IWL_CFG_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB, IWL_CFG_ANY,
-		      iwl_cfg_snj_a0_jf_b0, iwl9560_160_name),
-	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_MAC_TYPE_SNJ, IWL_CFG_ANY,
-		      IWL_CFG_RF_TYPE_JF2, IWL_CFG_RF_ID_JF, IWL_CFG_ANY,
-		      IWL_CFG_NO_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB, IWL_CFG_ANY,
-		      iwl_cfg_snj_a0_jf_b0, iwl9560_name),
-
-/* SnJ with Hr */
-	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_MAC_TYPE_SNJ, IWL_CFG_ANY,
-		      IWL_CFG_RF_TYPE_HR1, IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB, IWL_CFG_ANY,
-		      iwl_cfg_snj_hr_b0, iwl_ax101_name),
-
-	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_MAC_TYPE_SNJ, IWL_CFG_ANY,
-		      IWL_CFG_RF_TYPE_HR2, IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB, IWL_CFG_ANY,
-		      iwl_cfg_snj_hr_b0, iwl_ax201_name),
-
 /* Ma */
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_MA, SILICON_A_STEP,
@@ -1087,11 +952,6 @@ static const struct iwl_dev_info iwl_dev_info_table[] = {
 		      IWL_CFG_RF_TYPE_FM, IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB, IWL_CFG_ANY,
 		      iwl_cfg_ma_a0_fm_a0, iwl_ax231_name),
-	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_MAC_TYPE_SNJ, IWL_CFG_ANY,
-		      IWL_CFG_RF_TYPE_MR, IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB, IWL_CFG_ANY,
-		      iwl_cfg_snj_a0_mr_a0, iwl_ax221_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_MA, SILICON_B_STEP,
 		      IWL_CFG_RF_TYPE_HR2, IWL_CFG_ANY, IWL_CFG_ANY,
@@ -1259,68 +1119,6 @@ static const struct iwl_dev_info iwl_dev_info_table[] = {
 		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB, IWL_CFG_ANY,
 		      iwl_cfg_bz_z0_gf_a0, iwl_bz_name),
 
-/* BNJ */
-	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_MAC_TYPE_GL, SILICON_A_STEP,
-		      IWL_CFG_RF_TYPE_FM, IWL_CFG_ANY, SILICON_A_STEP,
-		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB, IWL_CFG_IS_JACKET,
-		      iwl_cfg_bnj_a0_fm_a0, iwl_bz_name),
-	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_MAC_TYPE_GL, SILICON_B_STEP,
-		      IWL_CFG_RF_TYPE_FM, IWL_CFG_ANY, SILICON_B_STEP,
-		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB, IWL_CFG_IS_JACKET,
-		      iwl_cfg_bnj_b0_fm_b0, iwl_bz_name),
-	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_MAC_TYPE_GL, SILICON_A_STEP,
-		      IWL_CFG_RF_TYPE_FM, IWL_CFG_ANY, SILICON_A_STEP,
-		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_CDB, IWL_CFG_IS_JACKET,
-		      iwl_cfg_bnj_a0_fm4_a0, iwl_bz_name),
-	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_MAC_TYPE_GL, SILICON_B_STEP,
-		      IWL_CFG_RF_TYPE_FM, IWL_CFG_ANY, SILICON_B_STEP,
-		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_CDB, IWL_CFG_IS_JACKET,
-		      iwl_cfg_bnj_b0_fm4_b0, iwl_bz_name),
-	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_MAC_TYPE_GL, IWL_CFG_ANY,
-		      IWL_CFG_RF_TYPE_GF, IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB, IWL_CFG_IS_JACKET,
-		      iwl_cfg_bnj_a0_gf_a0, iwl_bz_name),
-	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_MAC_TYPE_GL, SILICON_B_STEP,
-		      IWL_CFG_RF_TYPE_GF, IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB, IWL_CFG_IS_JACKET,
-		      iwl_cfg_bnj_b0_gf_a0, iwl_bz_name),
-	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_MAC_TYPE_GL, SILICON_A_STEP,
-		      IWL_CFG_RF_TYPE_GF, IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_CDB, IWL_CFG_IS_JACKET,
-		      iwl_cfg_bnj_a0_gf4_a0, iwl_bz_name),
-	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_MAC_TYPE_GL, SILICON_B_STEP,
-		      IWL_CFG_RF_TYPE_GF, IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_CDB, IWL_CFG_IS_JACKET,
-		      iwl_cfg_bnj_b0_gf4_a0, iwl_bz_name),
-	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_MAC_TYPE_GL, SILICON_A_STEP,
-		      IWL_CFG_RF_TYPE_HR1, IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB, IWL_CFG_ANY,
-		      iwl_cfg_bnj_a0_hr_a0, iwl_bz_name),
-	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_MAC_TYPE_GL, SILICON_A_STEP,
-		      IWL_CFG_RF_TYPE_HR2, IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB, IWL_CFG_ANY,
-		      iwl_cfg_bnj_a0_hr_b0, iwl_bz_name),
-	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_MAC_TYPE_GL, SILICON_B_STEP,
-		      IWL_CFG_RF_TYPE_HR1, IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB, IWL_CFG_ANY,
-		      iwl_cfg_bnj_b0_hr_a0, iwl_bz_name),
-	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_MAC_TYPE_GL, SILICON_B_STEP,
-		      IWL_CFG_RF_TYPE_HR2, IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB, IWL_CFG_ANY,
-		      iwl_cfg_bnj_b0_hr_b0, iwl_bz_name),
-
 /* SoF with JF2 */
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_SOF, IWL_CFG_ANY,
@@ -1418,11 +1216,6 @@ static const struct iwl_dev_info iwl_dev_info_table[] = {
 		      IWL_CFG_RF_TYPE_MS, IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_160, IWL_CFG_ANY, IWL_CFG_NO_CDB, IWL_CFG_ANY,
 		      iwl_cfg_ma_a0_ms_a0, iwl_ax204_name),
-	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_MAC_TYPE_SNJ, IWL_CFG_ANY,
-		      IWL_CFG_RF_TYPE_MS, IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_160, IWL_CFG_ANY, IWL_CFG_NO_CDB, IWL_CFG_ANY,
-		      iwl_cfg_snj_a0_ms_a0, iwl_ax204_name),
 
 /* Sc */
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
@@ -1739,17 +1532,6 @@ static int iwl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	}
 
 #if IS_ENABLED(CONFIG_IWLMVM)
-
-	/*
-	 * Workaround for problematic SnJ device: sometimes when
-	 * certain RF modules are connected to SnJ, the device ID
-	 * changes to QnJ's ID.  So we are using QnJ's trans_cfg until
-	 * here.  But if we detect that the MAC type is actually SnJ,
-	 * we should switch to it here to avoid problems later.
-	 */
-	if (CSR_HW_REV_TYPE(iwl_trans->hw_rev) == IWL_CFG_MAC_TYPE_SNJ)
-		iwl_trans->trans_cfg = &iwl_so_trans_cfg;
-
 	/*
 	 * special-case 7265D, it has the same PCI IDs.
 	 *
-- 
2.38.1

