Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 233C57187C9
	for <lists+linux-wireless@lfdr.de>; Wed, 31 May 2023 18:51:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbjEaQvP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 31 May 2023 12:51:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjEaQvL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 31 May 2023 12:51:11 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 561B812F
        for <linux-wireless@vger.kernel.org>; Wed, 31 May 2023 09:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685551870; x=1717087870;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hyldjS7sWQnIbP2BTKGCDDmiItcxG6vD/x8wVRC1GZM=;
  b=jc0o+sy+y/zXkunkoKcudhw1z1wuI1iyywxGdnVp/R1ENEZvN/ZtU+x3
   RLK4BpykwKupDUTjFt7QCVYdQDogLyVLxjZzKdMFJH/hfooP5SiEitRcu
   HINVEK67BpTCdg5le3TOyklhemxbE7chBKYuypL1f9ghTjet6UhDQnuDT
   2eCAq+hV5zLxgL74E7WPvNzCP9bzVtfaDGrn+n/sp06oLTVgZcQ9m7XfB
   oZrwNzke78R6ubh/EYkeIxEGAHxCFfdtDtmKKh9pHfLu+rIn8Kd5XWWCf
   D2x3IXcnbedwHAbn1RaZDR29wORXHVlOlf2zeA+94isDzkdaxqX7Elr3n
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10727"; a="339890385"
X-IronPort-AV: E=Sophos;i="6.00,207,1681196400"; 
   d="scan'208";a="339890385"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2023 09:50:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10727"; a="706987952"
X-IronPort-AV: E=Sophos;i="6.00,207,1681196400"; 
   d="scan'208";a="706987952"
Received: from amilman1-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.215.102])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2023 09:50:28 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 03/14] wifi: iwlwifi: mvm: support injection rate control
Date:   Wed, 31 May 2023 19:49:55 +0300
Message-Id: <20230531194629.85a662792649.I0847b47dec0dfb0290d7b15ebc6bc0a575eed7b5@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230531165006.273284-1-gregory.greenman@intel.com>
References: <20230531165006.273284-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Supporting controlling the frame rate during injection,
HT/VHT are supported in addition to legacy rates.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c | 62 ++++++++++++++++++++-
 1 file changed, 59 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
index 10d7178f1071..59c91cf54cc1 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
@@ -308,6 +308,54 @@ static u32 iwl_mvm_get_tx_ant(struct iwl_mvm *mvm,
 	return BIT(mvm->mgmt_last_antenna_idx) << RATE_MCS_ANT_POS;
 }
 
+static u32 iwl_mvm_get_inject_tx_rate(struct iwl_mvm *mvm,
+				      struct ieee80211_tx_info *info)
+{
+	struct ieee80211_tx_rate *rate = &info->control.rates[0];
+	u32 result;
+
+	/*
+	 * we only care about legacy/HT/VHT so far, so we can
+	 * build in v1 and use iwl_new_rate_from_v1()
+	 */
+
+	if (rate->flags & IEEE80211_TX_RC_VHT_MCS) {
+		u8 mcs = ieee80211_rate_get_vht_mcs(rate);
+		u8 nss = ieee80211_rate_get_vht_nss(rate);
+
+		result = RATE_MCS_VHT_MSK_V1;
+		result |= u32_encode_bits(mcs, RATE_VHT_MCS_RATE_CODE_MSK);
+		result |= u32_encode_bits(nss, RATE_MCS_NSS_MSK);
+		if (rate->flags & IEEE80211_TX_RC_SHORT_GI)
+			result |= RATE_MCS_SGI_MSK_V1;
+		if (rate->flags & IEEE80211_TX_RC_40_MHZ_WIDTH)
+			result |= u32_encode_bits(1, RATE_MCS_CHAN_WIDTH_MSK_V1);
+		else if (rate->flags & IEEE80211_TX_RC_80_MHZ_WIDTH)
+			result |= u32_encode_bits(2, RATE_MCS_CHAN_WIDTH_MSK_V1);
+		else if (rate->flags & IEEE80211_TX_RC_160_MHZ_WIDTH)
+			result |= u32_encode_bits(3, RATE_MCS_CHAN_WIDTH_MSK_V1);
+	} else if (rate->flags & IEEE80211_TX_RC_MCS) {
+		result = RATE_MCS_HT_MSK_V1;
+		result |= u32_encode_bits(rate->idx,
+					  RATE_HT_MCS_RATE_CODE_MSK_V1 |
+					  RATE_HT_MCS_NSS_MSK_V1);
+		if (rate->flags & IEEE80211_TX_RC_SHORT_GI)
+			result |= RATE_MCS_SGI_MSK_V1;
+		if (rate->flags & IEEE80211_TX_RC_40_MHZ_WIDTH)
+			result |= u32_encode_bits(1, RATE_MCS_CHAN_WIDTH_MSK_V1);
+		if (rate->flags & IEEE80211_TX_CTL_LDPC)
+			result |= RATE_MCS_LDPC_MSK_V1;
+		if (u32_get_bits(rate->flags, IEEE80211_TX_CTL_STBC))
+			result |= RATE_MCS_STBC_MSK;
+	} else {
+		return 0;
+	}
+
+	if (iwl_fw_lookup_notif_ver(mvm->fw, LONG_GROUP, TX_CMD, 0) > 6)
+		return iwl_new_rate_from_v1(result);
+	return result;
+}
+
 static u32 iwl_mvm_get_tx_rate(struct iwl_mvm *mvm,
 			       struct ieee80211_tx_info *info,
 			       struct ieee80211_sta *sta, __le16 fc)
@@ -317,8 +365,15 @@ static u32 iwl_mvm_get_tx_rate(struct iwl_mvm *mvm,
 	u32 rate_flags = 0;
 	bool is_cck;
 
-	/* info->control is only relevant for non HW rate control */
-	if (!ieee80211_hw_check(mvm->hw, HAS_RATE_CONTROL)) {
+	if (unlikely(info->control.flags & IEEE80211_TX_CTRL_RATE_INJECT)) {
+		u32 result = iwl_mvm_get_inject_tx_rate(mvm, info);
+
+		if (result)
+			return result;
+		rate_idx = info->control.rates[0].idx;
+	} else if (!ieee80211_hw_check(mvm->hw, HAS_RATE_CONTROL)) {
+		/* info->control is only relevant for non HW rate control */
+
 		/* HT rate doesn't make sense for a non data frame */
 		WARN_ONCE(info->control.rates[0].flags & IEEE80211_TX_RC_MCS &&
 			  !ieee80211_is_data(fc),
@@ -398,7 +453,8 @@ void iwl_mvm_set_tx_cmd_rate(struct iwl_mvm *mvm, struct iwl_tx_cmd *tx_cmd,
 	 * table is controlled by LINK_QUALITY commands
 	 */
 
-	if (ieee80211_is_data(fc) && sta) {
+	if (likely(ieee80211_is_data(fc) && sta &&
+		   !(info->control.flags & IEEE80211_TX_CTRL_RATE_INJECT))) {
 		struct iwl_mvm_sta *mvmsta = iwl_mvm_sta_from_mac80211(sta);
 
 		if (mvmsta->sta_state >= IEEE80211_STA_AUTHORIZED) {
-- 
2.38.1

