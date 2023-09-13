Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3BC979E756
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Sep 2023 13:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240586AbjIML5c (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Sep 2023 07:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240569AbjIML5b (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Sep 2023 07:57:31 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A66C1996
        for <linux-wireless@vger.kernel.org>; Wed, 13 Sep 2023 04:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694606247; x=1726142247;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TNJkuB4Gzu+/EDrY/P2yFm3LeG8VbW95ZBtAAcEjF7s=;
  b=mSy+3/en9Oeze9H1LAHXg2/BPMm9v2qLJzXoJ6R7qFb/Gha3VnVY1+HD
   5eN2rJqBkawihgmQjf4usdtxqV5E6nSPNwVqBmRBhhyGbQAj5JE4/twdx
   QaoWToEMQ66kVl7FumCmHLK5PJNTKTAxMdnwoxZD9xeiSca344oGOeX0T
   TOtA2qYZtMuTaklB8i4SOCT9/zEcQh2cjbM0/CI8hR5bNiRTX1Pd5JUMX
   eIQDYPFkmP/cX4jLpC8OExesintUGRwfaJcvtJWFDdMPyYsn67RNGpe0h
   wSFgm9FjgDPKxT1uyCsLW7Cffx2FMkY5iB2DbvjUnOu629xKPERB1qzMo
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="368903064"
X-IronPort-AV: E=Sophos;i="6.02,143,1688454000"; 
   d="scan'208";a="368903064"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 04:57:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="737470957"
X-IronPort-AV: E=Sophos;i="6.02,143,1688454000"; 
   d="scan'208";a="737470957"
Received: from ggreenma-mobl2.jer.intel.com ([10.13.17.40])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 04:57:25 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Shaul Triebitz <shaul.triebitz@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 08/15] wifi: iwlwifi: mvm: enable FILS DF Tx on non-PSC channel
Date:   Wed, 13 Sep 2023 14:56:44 +0300
Message-Id: <20230913145231.83b9a76fc6c4.I6703111cc6befcd0e9cd9adf3cb127a648dbb7b1@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230913115651.190558-1-gregory.greenman@intel.com>
References: <20230913115651.190558-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Shaul Triebitz <shaul.triebitz@intel.com>

If the channel bandwidth is greater or equal than 80MHz,
enable FILS DF transmittion, even if the control channel is non-PSC.
That's because that in 80MHz there must be a sub 20MHz PSC
channel, and since the FILS DF is duplicated on all sub 20MHz
channels, within the 80MHz (hence it will be sent on a PSC channel).

Also, if FILS DF Tx is enabled, always configure the firmware
with the actual channel bandwidth, even before there is a connected
client (rather than the minimum bandwidth e.g. 20MHz), since FILS
DF transmission on a PSC channel take presedent over power
consumption.

Signed-off-by: Shaul Triebitz <shaul.triebitz@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 .../net/wireless/intel/iwlwifi/mvm/mac-ctxt.c    | 16 ++++++++++++++--
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c    | 10 ++++++----
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h     |  2 ++
 3 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
index b97b805d3486..06bbd6212df0 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
@@ -1083,6 +1083,19 @@ static int iwl_mvm_mac_ctxt_send_beacon_v7(struct iwl_mvm *mvm,
 						sizeof(beacon_cmd));
 }
 
+bool iwl_mvm_enable_fils(struct iwl_mvm *mvm,
+			 struct ieee80211_chanctx_conf *ctx)
+{
+	if (IWL_MVM_DISABLE_AP_FILS)
+		return false;
+
+	if (cfg80211_channel_is_psc(ctx->def.chan))
+		return true;
+
+	return (ctx->def.chan->band == NL80211_BAND_6GHZ &&
+		ctx->def.width >= NL80211_CHAN_WIDTH_80);
+}
+
 static int iwl_mvm_mac_ctxt_send_beacon_v9(struct iwl_mvm *mvm,
 					   struct ieee80211_vif *vif,
 					   struct sk_buff *beacon,
@@ -1102,8 +1115,7 @@ static int iwl_mvm_mac_ctxt_send_beacon_v9(struct iwl_mvm *mvm,
 	ctx = rcu_dereference(link_conf->chanctx_conf);
 	channel = ieee80211_frequency_to_channel(ctx->def.chan->center_freq);
 	WARN_ON(channel == 0);
-	if (cfg80211_channel_is_psc(ctx->def.chan) &&
-	    !IWL_MVM_DISABLE_AP_FILS) {
+	if (iwl_mvm_enable_fils(mvm, ctx)) {
 		flags |= iwl_fw_lookup_cmd_ver(mvm->fw, BEACON_TEMPLATE_CMD,
 					       0) > 10 ?
 			IWL_MAC_BEACON_FILS :
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 93223f8c07b4..2fb5fb41f508 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -4736,8 +4736,9 @@ static int __iwl_mvm_add_chanctx(struct iwl_mvm *mvm,
 {
 	u16 *phy_ctxt_id = (u16 *)ctx->drv_priv;
 	struct iwl_mvm_phy_ctxt *phy_ctxt;
-	bool responder = iwl_mvm_is_ftm_responder_chanctx(mvm, ctx);
-	struct cfg80211_chan_def *def = responder ? &ctx->def : &ctx->min_def;
+	bool use_def = iwl_mvm_is_ftm_responder_chanctx(mvm, ctx) ||
+		iwl_mvm_enable_fils(mvm, ctx);
+	struct cfg80211_chan_def *def = use_def ? &ctx->def : &ctx->min_def;
 	int ret;
 
 	lockdep_assert_held(&mvm->mutex);
@@ -4804,8 +4805,9 @@ void iwl_mvm_change_chanctx(struct ieee80211_hw *hw,
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
 	u16 *phy_ctxt_id = (u16 *)ctx->drv_priv;
 	struct iwl_mvm_phy_ctxt *phy_ctxt = &mvm->phy_ctxts[*phy_ctxt_id];
-	bool responder = iwl_mvm_is_ftm_responder_chanctx(mvm, ctx);
-	struct cfg80211_chan_def *def = responder ? &ctx->def : &ctx->min_def;
+	bool use_def = iwl_mvm_is_ftm_responder_chanctx(mvm, ctx) ||
+		iwl_mvm_enable_fils(mvm, ctx);
+	struct cfg80211_chan_def *def = use_def ? &ctx->def : &ctx->min_def;
 
 	if (WARN_ONCE((phy_ctxt->ref > 1) &&
 		      (changed & ~(IEEE80211_CHANCTX_CHANGE_WIDTH |
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index bbc552170c9f..afb6584daefe 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -2740,4 +2740,6 @@ int iwl_mvm_set_hw_timestamp(struct ieee80211_hw *hw,
 			     struct ieee80211_vif *vif,
 			     struct cfg80211_set_hw_timestamp *hwts);
 int iwl_mvm_update_mu_groups(struct iwl_mvm *mvm, struct ieee80211_vif *vif);
+bool iwl_mvm_enable_fils(struct iwl_mvm *mvm,
+			 struct ieee80211_chanctx_conf *ctx);
 #endif /* __IWL_MVM_H__ */
-- 
2.38.1

