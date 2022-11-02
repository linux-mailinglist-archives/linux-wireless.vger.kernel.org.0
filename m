Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6CCB616575
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Nov 2022 16:00:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbiKBPAt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 2 Nov 2022 11:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiKBPAr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 2 Nov 2022 11:00:47 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61AE76572
        for <linux-wireless@vger.kernel.org>; Wed,  2 Nov 2022 08:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667401246; x=1698937246;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AzZXdXt0WvIt8nCyTXtw971F+APvNwF4yzfzfBBYdL0=;
  b=gDkSCrbNQWCRugRwe3i8KzWLal3rRAE+cC9zT8wMKMRIbXMEFpRYrQCz
   Ux2eCTGciJ/W/xzleGDj3uG/z1PpCBrOiZYCIq0p4gRiE25bNiJvGw1XI
   KGFoyfmImX4gRmrx/IxKV2BcLi91PeXJp5CYpn8V7t6XOkVG9yhwyjfBY
   //KqzSOoJQ4xIFLevnbwDRCkt4TUTVel6xKZlTtHXefYr8fhEXpZlnnXf
   omvcHOMPxe4KdLFtjX0qXmMVH7OpIDkk2Rf+4oMY1OT8/2yOND827d/K2
   P7eaoimB2OmOdDyDJTBV6lTdZV7LNzNZ1dPyT50BVRoSa8CNOzwHQ9Ojc
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10519"; a="371523382"
X-IronPort-AV: E=Sophos;i="5.95,234,1661842800"; 
   d="scan'208";a="371523382"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2022 08:00:30 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10519"; a="636810395"
X-IronPort-AV: E=Sophos;i="5.95,234,1661842800"; 
   d="scan'208";a="636810395"
Received: from apetrush-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.251.180.25])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2022 08:00:28 -0700
From:   gregory.greenman@intel.com
To:     kvalo@kernel.org, johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 01/11] wifi: iwlwifi: mvm: use old checksum for Bz A-step
Date:   Wed,  2 Nov 2022 16:59:48 +0200
Message-Id: <20221102165239.6bc379f1b0b1.I204223f1b1c2fe26f414aea6679ef7fce681c33a@changeid>
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

From: Johannes Berg <johannes.berg@intel.com>

For Bz A-step hardware, the checksum offload is broken and
we need to use the old way, which is still there. Do that,
which requires taking the checksum capability bits out of
the IWL_DEVICE_BZ macro and listing them individually.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/cfg/22000.c | 16 +++++++++++++++-
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c    |  7 +++++--
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
index 110fda65bd21..b46f65b6d595 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
@@ -261,7 +261,6 @@ static const struct iwl_ht_params iwl_22000_ht_params = {
 	.dccm2_len = IWL_22000_DCCM2_LEN,				\
 	.smem_offset = IWL_22000_SMEM_OFFSET,				\
 	.smem_len = IWL_22000_SMEM_LEN,					\
-	.features = IWL_TX_CSUM_NETIF_FLAGS_BZ | NETIF_F_RXCSUM,	\
 	.apmg_not_supported = true,					\
 	.trans.mq_rx_supported = true,					\
 	.vht_mu_mimo_supported = true,					\
@@ -901,6 +900,7 @@ const struct iwl_cfg iwl_cfg_bz_a0_hr_b0 = {
 	.fw_name_pre = IWL_BZ_A_HR_B_FW_PRE,
 	.uhb_supported = true,
 	IWL_DEVICE_BZ,
+	.features = IWL_TX_CSUM_NETIF_FLAGS_BZ | NETIF_F_RXCSUM,
 	.num_rbds = IWL_NUM_RBDS_AX210_HE,
 };
 
@@ -908,6 +908,7 @@ const struct iwl_cfg iwl_cfg_bz_a0_gf_a0 = {
 	.fw_name_pre = IWL_BZ_A_GF_A_FW_PRE,
 	.uhb_supported = true,
 	IWL_DEVICE_BZ,
+	.features = IWL_TX_CSUM_NETIF_FLAGS_BZ | NETIF_F_RXCSUM,
 	.num_rbds = IWL_NUM_RBDS_AX210_HE,
 };
 
@@ -915,6 +916,7 @@ const struct iwl_cfg iwl_cfg_bz_a0_gf4_a0 = {
 	.fw_name_pre = IWL_BZ_A_GF4_A_FW_PRE,
 	.uhb_supported = true,
 	IWL_DEVICE_BZ,
+	.features = IWL_TX_CSUM_NETIF_FLAGS_BZ | NETIF_F_RXCSUM,
 	.num_rbds = IWL_NUM_RBDS_AX210_HE,
 };
 
@@ -922,6 +924,7 @@ const struct iwl_cfg iwl_cfg_bz_a0_mr_a0 = {
 	.fw_name_pre = IWL_BZ_A_MR_A_FW_PRE,
 	.uhb_supported = true,
 	IWL_DEVICE_BZ,
+	.features = IWL_TX_CSUM_NETIF_FLAGS_BZ | NETIF_F_RXCSUM,
 	.num_rbds = IWL_NUM_RBDS_AX210_HE,
 };
 
@@ -929,6 +932,7 @@ const struct iwl_cfg iwl_cfg_bz_a0_fm_a0 = {
 	.fw_name_pre = IWL_BZ_A_FM_A_FW_PRE,
 	.uhb_supported = true,
 	IWL_DEVICE_BZ,
+	.features = IWL_TX_CSUM_NETIF_FLAGS_BZ | NETIF_F_RXCSUM,
 	.num_rbds = IWL_NUM_RBDS_AX210_HE,
 };
 
@@ -936,6 +940,7 @@ const struct iwl_cfg iwl_cfg_bz_a0_fm4_a0 = {
 	.fw_name_pre = IWL_BZ_A_FM4_A_FW_PRE,
 	.uhb_supported = true,
 	IWL_DEVICE_BZ,
+	.features = IWL_TX_CSUM_NETIF_FLAGS_BZ | NETIF_F_RXCSUM,
 	.num_rbds = IWL_NUM_RBDS_AX210_HE,
 };
 
@@ -943,6 +948,7 @@ const struct iwl_cfg iwl_cfg_gl_a0_fm_a0 = {
 	.fw_name_pre = IWL_GL_A_FM_A_FW_PRE,
 	.uhb_supported = true,
 	IWL_DEVICE_BZ,
+	.features = IWL_TX_CSUM_NETIF_FLAGS | NETIF_F_RXCSUM,
 	.num_rbds = IWL_NUM_RBDS_AX210_HE,
 };
 
@@ -950,6 +956,7 @@ const struct iwl_cfg iwl_cfg_gl_b0_fm_b0 = {
 	.fw_name_pre = IWL_GL_B_FM_B_FW_PRE,
 	.uhb_supported = true,
 	IWL_DEVICE_BZ,
+	.features = IWL_TX_CSUM_NETIF_FLAGS_BZ | NETIF_F_RXCSUM,
 	.num_rbds = IWL_NUM_RBDS_AX210_HE,
 };
 
@@ -957,6 +964,7 @@ const struct iwl_cfg iwl_cfg_bz_z0_gf_a0 = {
 	.fw_name_pre = IWL_BZ_Z_GF_A_FW_PRE,
 	.uhb_supported = true,
 	IWL_DEVICE_BZ,
+	.features = IWL_TX_CSUM_NETIF_FLAGS_BZ | NETIF_F_RXCSUM,
 	.num_rbds = IWL_NUM_RBDS_AX210_HE,
 };
 
@@ -964,6 +972,7 @@ const struct iwl_cfg iwl_cfg_bnj_a0_fm_a0 = {
 	.fw_name_pre = IWL_BNJ_A_FM_A_FW_PRE,
 	.uhb_supported = true,
 	IWL_DEVICE_BZ,
+	.features = IWL_TX_CSUM_NETIF_FLAGS | NETIF_F_RXCSUM,
 	.num_rbds = IWL_NUM_RBDS_AX210_HE,
 };
 
@@ -971,6 +980,7 @@ const struct iwl_cfg iwl_cfg_bnj_a0_fm4_a0 = {
 	.fw_name_pre = IWL_BNJ_A_FM4_A_FW_PRE,
 	.uhb_supported = true,
 	IWL_DEVICE_BZ,
+	.features = IWL_TX_CSUM_NETIF_FLAGS | NETIF_F_RXCSUM,
 	.num_rbds = IWL_NUM_RBDS_AX210_HE,
 };
 
@@ -978,6 +988,7 @@ const struct iwl_cfg iwl_cfg_bnj_a0_gf_a0 = {
 	.fw_name_pre = IWL_BNJ_A_GF_A_FW_PRE,
 	.uhb_supported = true,
 	IWL_DEVICE_BZ,
+	.features = IWL_TX_CSUM_NETIF_FLAGS | NETIF_F_RXCSUM,
 	.num_rbds = IWL_NUM_RBDS_AX210_HE,
 };
 
@@ -985,6 +996,7 @@ const struct iwl_cfg iwl_cfg_bnj_a0_gf4_a0 = {
 	.fw_name_pre = IWL_BNJ_A_GF4_A_FW_PRE,
 	.uhb_supported = true,
 	IWL_DEVICE_BZ,
+	.features = IWL_TX_CSUM_NETIF_FLAGS | NETIF_F_RXCSUM,
 	.num_rbds = IWL_NUM_RBDS_AX210_HE,
 };
 
@@ -992,6 +1004,7 @@ const struct iwl_cfg iwl_cfg_bnj_a0_hr_b0 = {
 	.fw_name_pre = IWL_BNJ_A_HR_B_FW_PRE,
 	.uhb_supported = true,
 	IWL_DEVICE_BZ,
+	.features = IWL_TX_CSUM_NETIF_FLAGS | NETIF_F_RXCSUM,
 	.num_rbds = IWL_NUM_RBDS_AX210_HE,
 };
 
@@ -999,6 +1012,7 @@ const struct iwl_cfg iwl_cfg_bnj_b0_fm_b0 = {
 	.fw_name_pre = IWL_BNJ_B_FM_B_FW_PRE,
 	.uhb_supported = true,
 	IWL_DEVICE_BZ,
+	.features = IWL_TX_CSUM_NETIF_FLAGS_BZ | NETIF_F_RXCSUM,
 	.num_rbds = IWL_NUM_RBDS_AX210_HE,
 };
 MODULE_FIRMWARE(IWL_QU_B_HR_B_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
index ba335f57771c..f460332333a7 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2012-2014, 2018-2021 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2022 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -183,7 +183,10 @@ static u32 iwl_mvm_tx_csum(struct iwl_mvm *mvm, struct sk_buff *skb,
 			   struct ieee80211_tx_info *info,
 			   bool amsdu)
 {
-	if (mvm->trans->trans_cfg->device_family < IWL_DEVICE_FAMILY_BZ)
+	if (mvm->trans->trans_cfg->device_family < IWL_DEVICE_FAMILY_BZ ||
+	    (mvm->trans->trans_cfg->device_family == IWL_DEVICE_FAMILY_BZ &&
+	     CSR_HW_REV_TYPE(mvm->trans->hw_rev) == IWL_CFG_MAC_TYPE_GL &&
+	     mvm->trans->hw_rev_step == SILICON_A_STEP))
 		return iwl_mvm_tx_csum_pre_bz(mvm, skb, info, amsdu);
 	return iwl_mvm_tx_csum_bz(mvm, skb, amsdu);
 }
-- 
2.35.3

