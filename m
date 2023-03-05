Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4568C6AAF71
	for <lists+linux-wireless@lfdr.de>; Sun,  5 Mar 2023 13:17:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbjCEMR6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 5 Mar 2023 07:17:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbjCEMR4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 5 Mar 2023 07:17:56 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B9B5126EE
        for <linux-wireless@vger.kernel.org>; Sun,  5 Mar 2023 04:17:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678018668; x=1709554668;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DJpAClW1RlsXuMVOHVwcj2HITo+bygw3GURPt38jX88=;
  b=G0SDfPFHLfkjI1qPP2rDL66f6TCmisnYcilwID0sBWOL2QB7Y277X0dU
   LYu/hdPmw9ZhbgRuob2qNv1pOCVRRMk/Y7Ket6TTK6wz+2nMhbHliW34o
   CE0Ees4rLDPGrJSQLaW6M/BQCT0o0oX5y4IdcIMuyYzgHTXb4mPw4rYKz
   0/zDw8erQKqBI9mDxWKNvC9LOrP10yP0AX89+K591URvf2S0SvCf85a3v
   ByAgA4RuEBcPV3rm8XtzXMinabYaP0SmTnipyOjLuR5lM3Dyx8uGoFXjM
   MfAXn2KPGrznhbE5aILFZcej0T85QfLKRBfWY4zLLJnIY/9rEXm4ql1aJ
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10639"; a="400193304"
X-IronPort-AV: E=Sophos;i="5.98,235,1673942400"; 
   d="scan'208";a="400193304"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2023 04:17:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10639"; a="708355246"
X-IronPort-AV: E=Sophos;i="5.98,235,1673942400"; 
   d="scan'208";a="708355246"
Received: from hsaid-mobl2.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.249.80.12])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2023 04:17:45 -0800
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Greenman@vger.kernel.org, Gregory <gregory.greenman@intel.com>
Subject: [PATCH 21/21] wifi: iwlwifi: mvm: fix EOF bit reporting
Date:   Sun,  5 Mar 2023 14:16:35 +0200
Message-Id: <20230305124407.e273aa0d3fdc.I77db4cc247898eae8a98b80659386d6737052b95@changeid>
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

From: Johannes Berg <johannes.berg@intel.com>

In monitor mode, we try to report the EOF bit on the
first MPDU of an A-MPDU (hardware duplicates this bit
over all MPDUs, so it's only trustable on the first).

However, due to reshuffling in an ealier commit, the
toggle_bit != mvm->ampdu_toggle logic can no longer
work since mvm->ampdu_toggle is now set before this
code runs.

Fix this by tracking the first_subframe status in the
phy data struct and using that instead of checking.

Fixes: d7cb2d8f4683 ("iwlwifi: mvm: rxmq: refactor mac80211 rx_status setting")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Greenman, Gregory <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c | 28 +++++++------------
 1 file changed, 10 insertions(+), 18 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
index d8dda72a5a5d..d54e3bed44b3 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
@@ -1179,6 +1179,7 @@ struct iwl_mvm_rx_phy_data {
 	__le32 d0, d1, d2, d3, eht_d4, d5;
 	__le16 d4;
 	bool with_data;
+	bool first_subframe;
 	__le32 rx_vec[4];
 
 	u32 rate_n_flags;
@@ -1878,15 +1879,10 @@ static void iwl_mvm_rx_eht(struct iwl_mvm *mvm, struct sk_buff *skb,
 
 	/* update aggregation data for monitor sake on default queue */
 	if (!queue && (phy_info & IWL_RX_MPDU_PHY_TSF_OVERLOAD) &&
-	    (phy_info & IWL_RX_MPDU_PHY_AMPDU)) {
-		bool toggle_bit = phy_info & IWL_RX_MPDU_PHY_AMPDU_TOGGLE;
-
-		/* toggle is switched whenever new aggregation starts */
-		if (toggle_bit != mvm->ampdu_toggle) {
-			rx_status->flag |= RX_FLAG_AMPDU_EOF_BIT_KNOWN;
-			if (phy_data->d0 & cpu_to_le32(IWL_RX_PHY_DATA0_EHT_DELIM_EOF))
-				rx_status->flag |= RX_FLAG_AMPDU_EOF_BIT;
-		}
+	    (phy_info & IWL_RX_MPDU_PHY_AMPDU) && phy_data->first_subframe) {
+		rx_status->flag |= RX_FLAG_AMPDU_EOF_BIT_KNOWN;
+		if (phy_data->d0 & cpu_to_le32(IWL_RX_PHY_DATA0_EHT_DELIM_EOF))
+			rx_status->flag |= RX_FLAG_AMPDU_EOF_BIT;
 	}
 
 	if (phy_info & IWL_RX_MPDU_PHY_TSF_OVERLOAD)
@@ -2028,15 +2024,10 @@ static void iwl_mvm_rx_he(struct iwl_mvm *mvm, struct sk_buff *skb,
 
 	/* update aggregation data for monitor sake on default queue */
 	if (!queue && (phy_info & IWL_RX_MPDU_PHY_TSF_OVERLOAD) &&
-	    (phy_info & IWL_RX_MPDU_PHY_AMPDU)) {
-		bool toggle_bit = phy_info & IWL_RX_MPDU_PHY_AMPDU_TOGGLE;
-
-		/* toggle is switched whenever new aggregation starts */
-		if (toggle_bit != mvm->ampdu_toggle) {
-			rx_status->flag |= RX_FLAG_AMPDU_EOF_BIT_KNOWN;
-			if (phy_data->d0 & cpu_to_le32(IWL_RX_PHY_DATA0_HE_DELIM_EOF))
-				rx_status->flag |= RX_FLAG_AMPDU_EOF_BIT;
-		}
+	    (phy_info & IWL_RX_MPDU_PHY_AMPDU) && phy_data->first_subframe) {
+		rx_status->flag |= RX_FLAG_AMPDU_EOF_BIT_KNOWN;
+		if (phy_data->d0 & cpu_to_le32(IWL_RX_PHY_DATA0_EHT_DELIM_EOF))
+			rx_status->flag |= RX_FLAG_AMPDU_EOF_BIT;
 	}
 
 	if (he_type == RATE_MCS_HE_TYPE_EXT_SU &&
@@ -2439,6 +2430,7 @@ void iwl_mvm_rx_mpdu_mq(struct iwl_mvm *mvm, struct napi_struct *napi,
 			if (mvm->ampdu_ref == 0)
 				mvm->ampdu_ref++;
 			mvm->ampdu_toggle = toggle_bit;
+			phy_data.first_subframe = true;
 		}
 		rx_status->ampdu_reference = mvm->ampdu_ref;
 	}
-- 
2.38.1

