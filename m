Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29671616577
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Nov 2022 16:00:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbiKBPAx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 2 Nov 2022 11:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbiKBPAv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 2 Nov 2022 11:00:51 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D56DE6572
        for <linux-wireless@vger.kernel.org>; Wed,  2 Nov 2022 08:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667401249; x=1698937249;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FGP6Ugmo4+uAUz7JWJ3PnSNkq1HeAIAZAVJehR44NWY=;
  b=SNGWBmf8OOxV9acJdCaLBC+XcGi+uW7hAlPdqSx4zrMqXNZkF4vOxs4u
   676QtPHIWLoa4+a+LWbQw3gdJQTVASLA2rXm91VCqZJVv1aEReHMTyQXK
   utDNF3xj0rWRTwl6Xbit/n6krZbmScMghK8WmKE87NvRIZMkqUxkefmOK
   av9ao0SK9LfLWmEu5gx7tuvDpbFW7jq5JdGGAYRkdIwktahOOqX9lOAWE
   FWgOEpawvE+kV+rmeigM0eDvF38m/xiTfa/4lzYwZHG/MpAGBgVD7H+vX
   3e3yoKz7wfxFEm/fyoVUmFUwh9t7nL3fwdUKo5cuI6v67ExPvMqOdA668
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10519"; a="371523433"
X-IronPort-AV: E=Sophos;i="5.95,234,1661842800"; 
   d="scan'208";a="371523433"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2022 08:00:38 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10519"; a="636810454"
X-IronPort-AV: E=Sophos;i="5.95,234,1661842800"; 
   d="scan'208";a="636810454"
Received: from apetrush-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.251.180.25])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2022 08:00:36 -0700
From:   gregory.greenman@intel.com
To:     kvalo@kernel.org, johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Luca Coelho <luciano.coelho@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 03/11] wifi: iwlwifi: cfg: disable STBC for BL step A devices
Date:   Wed,  2 Nov 2022 16:59:50 +0200
Message-Id: <20221102165239.806dbfa53f40.I4b14a8be30795bdcd73686bd1f9222e7ab93b505@changeid>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221102145958.342864-1-gregory.greenman@intel.com>
References: <20221102145958.342864-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

The A step of BL devices doesn't support STBC, so we need to disable
it.

Create new HT params and a macro to use specifically with BL A-step
devices where STBC is disabled.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 .../net/wireless/intel/iwlwifi/cfg/22000.c    | 20 ++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
index b46f65b6d595..ec6198f1b38c 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
@@ -172,6 +172,13 @@ static const struct iwl_ht_params iwl_22000_ht_params = {
 		      BIT(NL80211_BAND_6GHZ),
 };
 
+static const struct iwl_ht_params iwl_gl_a_ht_params = {
+	.stbc = false, /* we explicitly disable STBC for GL step A */
+	.ldpc = true,
+	.ht40_bands = BIT(NL80211_BAND_2GHZ) | BIT(NL80211_BAND_5GHZ) |
+		      BIT(NL80211_BAND_6GHZ),
+};
+
 #define IWL_DEVICE_22000_COMMON						\
 	.ucode_api_max = IWL_22000_UCODE_API_MAX,			\
 	.ucode_api_min = IWL_22000_UCODE_API_MIN,			\
@@ -249,7 +256,7 @@ static const struct iwl_ht_params iwl_22000_ht_params = {
 		},							\
 	}
 
-#define IWL_DEVICE_BZ							\
+#define IWL_DEVICE_BZ_COMMON						\
 	.ucode_api_max = IWL_22000_UCODE_API_MAX,			\
 	.ucode_api_min = IWL_22000_UCODE_API_MIN,			\
 	.led_mode = IWL_LED_RF_STATE,					\
@@ -265,7 +272,6 @@ static const struct iwl_ht_params iwl_22000_ht_params = {
 	.trans.mq_rx_supported = true,					\
 	.vht_mu_mimo_supported = true,					\
 	.mac_addr_from_csr = 0x30,					\
-	.ht_params = &iwl_22000_ht_params,				\
 	.nvm_ver = IWL_22000_NVM_VERSION,				\
 	.trans.use_tfh = true,						\
 	.trans.rf_id = true,						\
@@ -312,6 +318,14 @@ static const struct iwl_ht_params iwl_22000_ht_params = {
 		},							\
 	}
 
+#define IWL_DEVICE_BZ							\
+	IWL_DEVICE_BZ_COMMON,						\
+	.ht_params = &iwl_22000_ht_params
+
+#define IWL_DEVICE_GL_A							\
+	IWL_DEVICE_BZ_COMMON,						\
+	.ht_params = &iwl_gl_a_ht_params
+
 const struct iwl_cfg_trans_params iwl_qnj_trans_cfg = {
 	.mq_rx_supported = true,
 	.use_tfh = true,
@@ -947,7 +961,7 @@ const struct iwl_cfg iwl_cfg_bz_a0_fm4_a0 = {
 const struct iwl_cfg iwl_cfg_gl_a0_fm_a0 = {
 	.fw_name_pre = IWL_GL_A_FM_A_FW_PRE,
 	.uhb_supported = true,
-	IWL_DEVICE_BZ,
+	IWL_DEVICE_GL_A,
 	.features = IWL_TX_CSUM_NETIF_FLAGS | NETIF_F_RXCSUM,
 	.num_rbds = IWL_NUM_RBDS_AX210_HE,
 };
-- 
2.35.3

