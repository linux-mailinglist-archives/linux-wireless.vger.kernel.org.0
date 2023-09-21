Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1A007A9BCA
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Sep 2023 21:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231254AbjIUTEa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 21 Sep 2023 15:04:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjIUTEG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 21 Sep 2023 15:04:06 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76A24325CA
        for <linux-wireless@vger.kernel.org>; Thu, 21 Sep 2023 10:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695318633; x=1726854633;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vmoprl1oKJOloO5ZP5YHnozZWXz3ptS69tuc1kG9yC0=;
  b=LZpciN4HBVXC4pNvJPD/Vaw/NdHvZf9HqAdD8CsCUiUguRcP+NSGSb1L
   H6q/PO+nJSVzszvoKgz55X81AGW8xhUUt++r17+tPnTTAtstcl4aajkrZ
   WOvzhygBW1mWo0RB59S140BWLwKEmcrqtfPJv1Vax2WRkYGluWUzGNBG4
   6rZWhzSGYABYmc0+ej52AdOcJZNG576sT3z+ClUopkNxPoln2Ml1DBp2p
   qAdjgVPdTOxvaadSb2A404ZCECeQjXVYJXYUnImdDUQhUESN15/4uzZdu
   nK9RNVW+UO6dnnDwxm+zSdzsdAqZkuQjeSbdEqhhAwamFnGZI1vKHJ/F5
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="384305407"
X-IronPort-AV: E=Sophos;i="6.03,165,1694761200"; 
   d="scan'208";a="384305407"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2023 01:59:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="740545614"
X-IronPort-AV: E=Sophos;i="6.03,165,1694761200"; 
   d="scan'208";a="740545614"
Received: from rchuwer-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.229.163])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2023 01:59:02 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 09/12] wifi: iwlwifi: mvm: refactor TX rate handling
Date:   Thu, 21 Sep 2023 11:58:07 +0300
Message-Id: <20230921110727.dc920357bad0.I5ee8512fb63f0423c1da35b59fea8811d60c1ad3@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230921085810.693048-1-gregory.greenman@intel.com>
References: <20230921085810.693048-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Refactor the injection and other frame TX rate handling
to always return the injection rate directly, by factoring
the legay rate portion out into a new function called in
the two relevant places (injection and non-injection).

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c | 78 ++++++++++++---------
 1 file changed, 45 insertions(+), 33 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
index 6e2e52936761..c398e04b597c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
@@ -262,6 +262,38 @@ static u32 iwl_mvm_get_tx_ant(struct iwl_mvm *mvm,
 	return BIT(mvm->mgmt_last_antenna_idx) << RATE_MCS_ANT_POS;
 }
 
+static u32 iwl_mvm_convert_rate_idx(struct iwl_mvm *mvm,
+				    struct ieee80211_tx_info *info,
+				    int rate_idx)
+{
+	u32 rate_flags = 0;
+	u8 rate_plcp;
+	bool is_cck;
+
+	/* if the rate isn't a well known legacy rate, take the lowest one */
+	if (rate_idx < 0 || rate_idx >= IWL_RATE_COUNT_LEGACY)
+		rate_idx = iwl_mvm_mac_ctxt_get_lowest_rate(mvm,
+							    info,
+							    info->control.vif);
+
+	/* Get PLCP rate for tx_cmd->rate_n_flags */
+	rate_plcp = iwl_mvm_mac80211_idx_to_hwrate(mvm->fw, rate_idx);
+	is_cck = (rate_idx >= IWL_FIRST_CCK_RATE) &&
+		 (rate_idx <= IWL_LAST_CCK_RATE);
+
+	/* Set CCK or OFDM flag */
+	if (iwl_fw_lookup_cmd_ver(mvm->fw, TX_CMD, 0) > 8) {
+		if (!is_cck)
+			rate_flags |= RATE_MCS_LEGACY_OFDM_MSK;
+		else
+			rate_flags |= RATE_MCS_CCK_MSK;
+	} else if (is_cck) {
+		rate_flags |= RATE_MCS_CCK_MSK_V1;
+	}
+
+	return (u32)rate_plcp | rate_flags;
+}
+
 static u32 iwl_mvm_get_inject_tx_rate(struct iwl_mvm *mvm,
 				      struct ieee80211_tx_info *info)
 {
@@ -288,6 +320,9 @@ static u32 iwl_mvm_get_inject_tx_rate(struct iwl_mvm *mvm,
 			result |= u32_encode_bits(2, RATE_MCS_CHAN_WIDTH_MSK_V1);
 		else if (rate->flags & IEEE80211_TX_RC_160_MHZ_WIDTH)
 			result |= u32_encode_bits(3, RATE_MCS_CHAN_WIDTH_MSK_V1);
+
+		if (iwl_fw_lookup_notif_ver(mvm->fw, LONG_GROUP, TX_CMD, 0) > 6)
+			result = iwl_new_rate_from_v1(result);
 	} else if (rate->flags & IEEE80211_TX_RC_MCS) {
 		result = RATE_MCS_HT_MSK_V1;
 		result |= u32_encode_bits(rate->idx,
@@ -301,12 +336,15 @@ static u32 iwl_mvm_get_inject_tx_rate(struct iwl_mvm *mvm,
 			result |= RATE_MCS_LDPC_MSK_V1;
 		if (u32_get_bits(info->flags, IEEE80211_TX_CTL_STBC))
 			result |= RATE_MCS_STBC_MSK;
+
+		if (iwl_fw_lookup_notif_ver(mvm->fw, LONG_GROUP, TX_CMD, 0) > 6)
+			result = iwl_new_rate_from_v1(result);
 	} else {
-		return 0;
+		int rate_idx = info->control.rates[0].idx;
+
+		result = iwl_mvm_convert_rate_idx(mvm, info, rate_idx);
 	}
 
-	if (iwl_fw_lookup_notif_ver(mvm->fw, LONG_GROUP, TX_CMD, 0) > 6)
-		return iwl_new_rate_from_v1(result);
 	return result;
 }
 
@@ -315,17 +353,11 @@ static u32 iwl_mvm_get_tx_rate(struct iwl_mvm *mvm,
 			       struct ieee80211_sta *sta, __le16 fc)
 {
 	int rate_idx = -1;
-	u8 rate_plcp;
-	u32 rate_flags = 0;
-	bool is_cck;
 
-	if (unlikely(info->control.flags & IEEE80211_TX_CTRL_RATE_INJECT)) {
-		u32 result = iwl_mvm_get_inject_tx_rate(mvm, info);
+	if (unlikely(info->control.flags & IEEE80211_TX_CTRL_RATE_INJECT))
+		return iwl_mvm_get_inject_tx_rate(mvm, info);
 
-		if (result)
-			return result;
-		rate_idx = info->control.rates[0].idx;
-	} else if (!ieee80211_hw_check(mvm->hw, HAS_RATE_CONTROL)) {
+	if (!ieee80211_hw_check(mvm->hw, HAS_RATE_CONTROL)) {
 		/* info->control is only relevant for non HW rate control */
 
 		/* HT rate doesn't make sense for a non data frame */
@@ -350,27 +382,7 @@ static u32 iwl_mvm_get_tx_rate(struct iwl_mvm *mvm,
 		BUILD_BUG_ON(IWL_FIRST_CCK_RATE != 0);
 	}
 
-	/* if the rate isn't a well known legacy rate, take the lowest one */
-	if (rate_idx < 0 || rate_idx >= IWL_RATE_COUNT_LEGACY)
-		rate_idx = iwl_mvm_mac_ctxt_get_lowest_rate(mvm,
-							    info,
-							    info->control.vif);
-
-	/* Get PLCP rate for tx_cmd->rate_n_flags */
-	rate_plcp = iwl_mvm_mac80211_idx_to_hwrate(mvm->fw, rate_idx);
-	is_cck = (rate_idx >= IWL_FIRST_CCK_RATE) && (rate_idx <= IWL_LAST_CCK_RATE);
-
-	/* Set CCK or OFDM flag */
-	if (iwl_fw_lookup_cmd_ver(mvm->fw, TX_CMD, 0) > 8) {
-		if (!is_cck)
-			rate_flags |= RATE_MCS_LEGACY_OFDM_MSK;
-		else
-			rate_flags |= RATE_MCS_CCK_MSK;
-	} else if (is_cck) {
-		rate_flags |= RATE_MCS_CCK_MSK_V1;
-	}
-
-	return (u32)rate_plcp | rate_flags;
+	return iwl_mvm_convert_rate_idx(mvm, info, rate_idx);
 }
 
 static u32 iwl_mvm_get_tx_rate_n_flags(struct iwl_mvm *mvm,
-- 
2.38.1

