Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01FEE6AAF6D
	for <lists+linux-wireless@lfdr.de>; Sun,  5 Mar 2023 13:17:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbjCEMRs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 5 Mar 2023 07:17:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjCEMRq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 5 Mar 2023 07:17:46 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B81C31258A
        for <linux-wireless@vger.kernel.org>; Sun,  5 Mar 2023 04:17:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678018656; x=1709554656;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MA/ZStxhgULNoir6FDdjygJ8j8dtexJF5zYVZkLwSy8=;
  b=cDCgRlp1p+avfJbC4EV7xpDZ9eZ3RPWcH3V7Kr5J81kJaUXHHYRa4v7m
   eKtMi14st3y8AL3t6F55OSbK1yT6QhiSRP9VJz+hGhKdGzXI6YnizKNMa
   6F7ffk+NIe75oQ2aS6voOtOk+xU3JRtyXRJfbxkO+wy+nkyvZTvPvz56D
   Hg8CtsqBtjMqF/D+HNCjWLB++zWxCPr/nLVQz1ucsOCoMyumEmdL5L3tG
   OeKmbgtmqfN5vMZpdOhLCoL53RWHovyHhnzMAZzyvEItdzPEQSA+daJpL
   Zr3koMTtMEvmkpaI+fII1LwkQPPeX5prVmup1/0Q5yx+oSJr5ZrGLJkFt
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10639"; a="400193276"
X-IronPort-AV: E=Sophos;i="5.98,235,1673942400"; 
   d="scan'208";a="400193276"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2023 04:17:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10639"; a="708355205"
X-IronPort-AV: E=Sophos;i="5.98,235,1673942400"; 
   d="scan'208";a="708355205"
Received: from hsaid-mobl2.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.249.80.12])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2023 04:17:34 -0800
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Mordechay Goodstein <mordechay.goodstein@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 17/21] wifi: iwlwifi: mvm: cleanup duplicated defines
Date:   Sun,  5 Mar 2023 14:16:31 +0200
Message-Id: <20230305124407.167ed9477aa8.Ibd8e71d31896e8d8f067ce4e3a6e9a0e86c78f3f@changeid>
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

From: Mordechay Goodstein <mordechay.goodstein@intel.com>

Rates VHT,HE,EHT use the same bits for NSS so no need for multiple
defines per VHT and other.

Also use spatch to replace bit manipulation with FIELD_GET
@@
identifier rate;
@@
-((rate & RATE_MCS_NSS_MSK) >> RATE_MCS_NSS_POS)
+FIELD_GET(RATE_MCS_NSS_MSK, rate)

Signed-off-by: Mordechay Goodstein <mordechay.goodstein@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/api/rs.h |  3 ---
 drivers/net/wireless/intel/iwlwifi/fw/rs.c     |  4 ++--
 drivers/net/wireless/intel/iwlwifi/mvm/rs.c    | 17 ++++++-----------
 drivers/net/wireless/intel/iwlwifi/mvm/rx.c    |  6 ++----
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c    |  6 ++----
 5 files changed, 12 insertions(+), 24 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/rs.h b/drivers/net/wireless/intel/iwlwifi/fw/api/rs.h
index 1d372a09ebb4..c9a48fc5fac8 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/rs.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/rs.h
@@ -373,9 +373,6 @@ enum {
 
 /* Bit 4-5: (0) SISO, (1) MIMO2 (2) MIMO3 */
 #define RATE_VHT_MCS_RATE_CODE_MSK	0xf
-#define RATE_VHT_MCS_NSS_POS		4
-#define RATE_VHT_MCS_NSS_MSK		(3 << RATE_VHT_MCS_NSS_POS)
-#define RATE_VHT_MCS_MIMO2_MSK		BIT(RATE_VHT_MCS_NSS_POS)
 
 /*
  * Legacy OFDM rate format for bits 7:0
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/rs.c b/drivers/net/wireless/intel/iwlwifi/fw/rs.c
index e128d2e07f38..b09e68dbf5a9 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/rs.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/rs.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2021 Intel Corporation
+ * Copyright (C) 2021-2022 Intel Corporation
  */
 
 #include <net/mac80211.h>
@@ -126,7 +126,7 @@ u32 iwl_new_rate_from_v1(u32 rate_v1)
 		   rate_v1 & RATE_MCS_HE_MSK_V1) {
 		rate_v2 |= rate_v1 & RATE_VHT_MCS_RATE_CODE_MSK;
 
-		rate_v2 |= rate_v1 & RATE_VHT_MCS_MIMO2_MSK;
+		rate_v2 |= rate_v1 & RATE_MCS_NSS_MSK;
 
 		if (rate_v1 & RATE_MCS_HE_MSK_V1) {
 			u32 he_type_bits = rate_v1 & RATE_MCS_HE_TYPE_MSK_V1;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rs.c b/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
index 0b50b816684a..1f81dff71bc4 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /******************************************************************************
  *
- * Copyright(c) 2005 - 2014, 2018 - 2021 Intel Corporation. All rights reserved.
+ * Copyright(c) 2005 - 2014, 2018 - 2022 Intel Corporation. All rights reserved.
  * Copyright(c) 2013 - 2015 Intel Mobile Communications GmbH
  * Copyright(c) 2016 - 2017 Intel Deutschland GmbH
  *****************************************************************************/
@@ -895,8 +895,7 @@ static int rs_rate_from_ucode_rate(const u32 ucode_rate,
 			WARN_ON_ONCE(1);
 		}
 	} else if (ucode_rate & RATE_MCS_VHT_MSK_V1) {
-		nss = ((ucode_rate & RATE_VHT_MCS_NSS_MSK) >>
-		       RATE_VHT_MCS_NSS_POS) + 1;
+		nss = FIELD_GET(RATE_MCS_NSS_MSK, ucode_rate) + 1;
 
 		if (nss == 1) {
 			rate->type = LQ_VHT_SISO;
@@ -910,8 +909,7 @@ static int rs_rate_from_ucode_rate(const u32 ucode_rate,
 			WARN_ON_ONCE(1);
 		}
 	} else if (ucode_rate & RATE_MCS_HE_MSK_V1) {
-		nss = ((ucode_rate & RATE_VHT_MCS_NSS_MSK) >>
-		      RATE_VHT_MCS_NSS_POS) + 1;
+		nss = FIELD_GET(RATE_MCS_NSS_MSK, ucode_rate) + 1;
 
 		if (nss == 1) {
 			rate->type = LQ_HE_SISO;
@@ -2885,8 +2883,7 @@ void iwl_mvm_update_frame_stats(struct iwl_mvm *mvm, u32 rate, bool agg)
 		nss = ((rate & RATE_HT_MCS_NSS_MSK_V1) >> RATE_HT_MCS_NSS_POS_V1) + 1;
 	} else if (rate & RATE_MCS_VHT_MSK_V1) {
 		mvm->drv_rx_stats.vht_frames++;
-		nss = ((rate & RATE_VHT_MCS_NSS_MSK) >>
-		       RATE_VHT_MCS_NSS_POS) + 1;
+		nss = FIELD_GET(RATE_MCS_NSS_MSK, rate) + 1;
 	} else {
 		mvm->drv_rx_stats.legacy_frames++;
 	}
@@ -3665,8 +3662,7 @@ int rs_pretty_print_rate_v1(char *buf, int bufsz, const u32 rate)
 	if (rate & RATE_MCS_VHT_MSK_V1) {
 		type = "VHT";
 		mcs = rate & RATE_VHT_MCS_RATE_CODE_MSK;
-		nss = ((rate & RATE_VHT_MCS_NSS_MSK)
-		       >> RATE_VHT_MCS_NSS_POS) + 1;
+		nss = FIELD_GET(RATE_MCS_NSS_MSK, rate) + 1;
 	} else if (rate & RATE_MCS_HT_MSK_V1) {
 		type = "HT";
 		mcs = rate & RATE_HT_MCS_INDEX_MSK_V1;
@@ -3675,8 +3671,7 @@ int rs_pretty_print_rate_v1(char *buf, int bufsz, const u32 rate)
 	} else if (rate & RATE_MCS_HE_MSK_V1) {
 		type = "HE";
 		mcs = rate & RATE_VHT_MCS_RATE_CODE_MSK;
-		nss = ((rate & RATE_VHT_MCS_NSS_MSK)
-		       >> RATE_VHT_MCS_NSS_POS) + 1;
+		nss = FIELD_GET(RATE_MCS_NSS_MSK, rate) + 1;
 	} else {
 		type = "Unknown"; /* shouldn't happen */
 	}
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rx.c b/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
index ab9a51375c8a..d2ce414879aa 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
@@ -253,8 +253,7 @@ static void iwl_mvm_rx_handle_tcm(struct iwl_mvm *mvm,
 				ARRAY_SIZE(thresh_tpt)))
 			return;
 		thr = thresh_tpt[rate_n_flags & RATE_VHT_MCS_RATE_CODE_MSK];
-		thr *= 1 + ((rate_n_flags & RATE_VHT_MCS_NSS_MSK) >>
-					RATE_VHT_MCS_NSS_POS);
+		thr *= 1 + FIELD_GET(RATE_MCS_NSS_MSK, rate_n_flags);
 	}
 
 	thr <<= ((rate_n_flags & RATE_MCS_CHAN_WIDTH_MSK_V1) >>
@@ -500,8 +499,7 @@ void iwl_mvm_rx_rx_mpdu(struct iwl_mvm *mvm, struct napi_struct *napi,
 		u8 stbc = (rate_n_flags & RATE_MCS_STBC_MSK) >>
 				RATE_MCS_STBC_POS;
 		rx_status->nss =
-			((rate_n_flags & RATE_VHT_MCS_NSS_MSK) >>
-						RATE_VHT_MCS_NSS_POS) + 1;
+			FIELD_GET(RATE_MCS_NSS_MSK, rate_n_flags) + 1;
 		rx_status->rate_idx = rate_n_flags & RATE_VHT_MCS_RATE_CODE_MSK;
 		rx_status->encoding = RX_ENC_VHT;
 		rx_status->enc_flags |= stbc << RX_ENC_FLAG_STBC_SHIFT;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
index 9813d7fa1800..8aa304bec38a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
@@ -1396,8 +1396,7 @@ void iwl_mvm_hwrate_to_tx_rate(u32 rate_n_flags,
 		r->idx = rate;
 	} else if (format ==  RATE_MCS_VHT_MSK) {
 		ieee80211_rate_set_vht(r, rate,
-				       ((rate_n_flags & RATE_MCS_NSS_MSK) >>
-					RATE_MCS_NSS_POS) + 1);
+				       FIELD_GET(RATE_MCS_NSS_MSK, rate_n_flags) + 1);
 		r->flags |= IEEE80211_TX_RC_VHT_MCS;
 	} else if (format == RATE_MCS_HE_MSK) {
 		/* mac80211 cannot do this without ieee80211_tx_status_ext()
@@ -1428,8 +1427,7 @@ void iwl_mvm_hwrate_to_tx_rate_v1(u32 rate_n_flags,
 	} else if (rate_n_flags & RATE_MCS_VHT_MSK_V1) {
 		ieee80211_rate_set_vht(
 			r, rate_n_flags & RATE_VHT_MCS_RATE_CODE_MSK,
-			((rate_n_flags & RATE_VHT_MCS_NSS_MSK) >>
-						RATE_VHT_MCS_NSS_POS) + 1);
+			FIELD_GET(RATE_MCS_NSS_MSK, rate_n_flags) + 1);
 		r->flags |= IEEE80211_TX_RC_VHT_MCS;
 	} else {
 		r->idx = iwl_mvm_legacy_rate_to_mac80211_idx(rate_n_flags,
-- 
2.38.1

