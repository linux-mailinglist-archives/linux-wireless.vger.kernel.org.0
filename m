Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A68597A9D76
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Sep 2023 21:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbjIUThr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 21 Sep 2023 15:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbjIUTha (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 21 Sep 2023 15:37:30 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FF5110D3
        for <linux-wireless@vger.kernel.org>; Thu, 21 Sep 2023 10:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695318642; x=1726854642;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6pQJBwS7YDRUEM/WBJc/y2A6E6oKH3jyv8+KInJ9NRo=;
  b=YRKiTu7mxyTkElb+jk+AN9PYY51oDP3Pwcn35GPBdCvunip6nUeNsA8M
   6tJjZY4QqlN6gpXm522tkDsHnfzKJUWWEn7pecoqp4ACXMgNW4LhMysHL
   Z2mq/OWHkV0rAGlgq26bBqKX0lG+uvBcnzHKZFWW95RrYueGCjOdGJ600
   16eMmlh+k3NprgF573aKZ9/1/AGMbjpwLBw30Oujirmh3ch4z29Yyf0aZ
   qkS9IGAFtT3ZygiT4d7ZGpn9hd/PCR5xzSh7m5Ud6PWtRqxakCws7YH2E
   ar5e0EK4I81PZ/1RsZUbxTdPmcTXvbx3ZhseQ8sENaTc4/S4iP8Aa7QEu
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="384305431"
X-IronPort-AV: E=Sophos;i="6.03,165,1694761200"; 
   d="scan'208";a="384305431"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2023 01:59:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="740545627"
X-IronPort-AV: E=Sophos;i="6.03,165,1694761200"; 
   d="scan'208";a="740545627"
Received: from rchuwer-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.229.163])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2023 01:59:04 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 10/12] wifi: iwlwifi: mvm: support injection antenna control
Date:   Thu, 21 Sep 2023 11:58:08 +0300
Message-Id: <20230921110727.12ab7634dbbc.I5aa16c99864ecd7375011a8996de2564fd01fc30@changeid>
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

Pull up the injection rate control one layer, and let it
control the antenna settings as well. Since mac80211 has
already checked that enough antennas are configured, and
we only have two bits, it's enough to just copy the data
over.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
index c398e04b597c..ec18e348553d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
@@ -295,7 +295,9 @@ static u32 iwl_mvm_convert_rate_idx(struct iwl_mvm *mvm,
 }
 
 static u32 iwl_mvm_get_inject_tx_rate(struct iwl_mvm *mvm,
-				      struct ieee80211_tx_info *info)
+				      struct ieee80211_tx_info *info,
+				      struct ieee80211_sta *sta,
+				      __le16 fc)
 {
 	struct ieee80211_tx_rate *rate = &info->control.rates[0];
 	u32 result;
@@ -345,6 +347,12 @@ static u32 iwl_mvm_get_inject_tx_rate(struct iwl_mvm *mvm,
 		result = iwl_mvm_convert_rate_idx(mvm, info, rate_idx);
 	}
 
+	if (info->control.antennas)
+		result |= u32_encode_bits(info->control.antennas,
+					  RATE_MCS_ANT_AB_MSK);
+	else
+		result |= iwl_mvm_get_tx_ant(mvm, info, sta, fc);
+
 	return result;
 }
 
@@ -354,9 +362,6 @@ static u32 iwl_mvm_get_tx_rate(struct iwl_mvm *mvm,
 {
 	int rate_idx = -1;
 
-	if (unlikely(info->control.flags & IEEE80211_TX_CTRL_RATE_INJECT))
-		return iwl_mvm_get_inject_tx_rate(mvm, info);
-
 	if (!ieee80211_hw_check(mvm->hw, HAS_RATE_CONTROL)) {
 		/* info->control is only relevant for non HW rate control */
 
@@ -389,6 +394,9 @@ static u32 iwl_mvm_get_tx_rate_n_flags(struct iwl_mvm *mvm,
 				       struct ieee80211_tx_info *info,
 				       struct ieee80211_sta *sta, __le16 fc)
 {
+	if (unlikely(info->control.flags & IEEE80211_TX_CTRL_RATE_INJECT))
+		return iwl_mvm_get_inject_tx_rate(mvm, info, sta, fc);
+
 	return iwl_mvm_get_tx_rate(mvm, info, sta, fc) |
 		iwl_mvm_get_tx_ant(mvm, info, sta, fc);
 }
-- 
2.38.1

