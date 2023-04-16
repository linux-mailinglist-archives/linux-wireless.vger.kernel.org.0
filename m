Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 393906E3852
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Apr 2023 14:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbjDPMsG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 16 Apr 2023 08:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbjDPMsB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 16 Apr 2023 08:48:01 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69E551982
        for <linux-wireless@vger.kernel.org>; Sun, 16 Apr 2023 05:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681649279; x=1713185279;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=osJNv1XqJ0gGVhm13OAuQ8rgujHmjOlh8YrLkIbvA5E=;
  b=ecaFxFx9nunbRF+5m/VT7RjBQCfacGQkdQz5FY6yqGM0ZB9phJ/c+gnz
   nBUSnwx7bwiiW8a7bhbz7h7iiJCqPjwraNbIAoG3LIi7GQ1+GRHwwjmzp
   PgH9BBi28fGwFUM3yPIMuKkQKDnx+XDk+YPlyc+ikTmYt/OCq5+mVXoDt
   npcWwVp97s0WSe1ve43GZHF8fqFfJ6BXyJb5IAXVXrc2XNoeZkCACwj1v
   6s4tCbApSk+8mYuIfcdpyYnuwkIMrbY8/LU2p7v1afPioPVkf/mcG6bdT
   ngUc0Rf1a1A81e+XzSzOWVSXzFJHav1JUCtIr1ykB0L2fpI1jK1OlnSNI
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10682"; a="333520549"
X-IronPort-AV: E=Sophos;i="5.99,202,1677571200"; 
   d="scan'208";a="333520549"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2023 05:47:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10682"; a="640670418"
X-IronPort-AV: E=Sophos;i="5.99,202,1677571200"; 
   d="scan'208";a="640670418"
Received: from lavnon-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.215.99])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2023 05:47:57 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 03/15] wifi: iwlwifi: mvm: fix getting lowest TX rate for MLO
Date:   Sun, 16 Apr 2023 15:47:27 +0300
Message-Id: <20230416154301.d892f68d3bcd.I7d6927abeea5c3899db225391dbc6a5c77805e80@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230416124739.1260800-1-gregory.greenman@intel.com>
References: <20230416124739.1260800-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

In iwl_mvm_mac_ctxt_get_lowest_rate() we were still accessing
vif->bss_conf without any multi-link provisions, and also the
info->band, both of which isn't valid in MLO.

Fix the code to look at the correct link. In case of EAPOL
transmissions for the initial 4-way-HS, look up the correct
link here as well, and warn if multiple are active.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 .../net/wireless/intel/iwlwifi/mvm/mac-ctxt.c | 31 +++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
index 20db9fc2e61a..389eef453d17 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
@@ -874,13 +874,40 @@ u8 iwl_mvm_mac_ctxt_get_lowest_rate(struct iwl_mvm *mvm,
 				    struct ieee80211_tx_info *info,
 				    struct ieee80211_vif *vif)
 {
+	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 	struct ieee80211_supported_band *sband;
 	unsigned long basic = vif->bss_conf.basic_rates;
 	u16 lowest_cck = IWL_RATE_COUNT, lowest_ofdm = IWL_RATE_COUNT;
+	u32 link_id = u32_get_bits(info->control.flags,
+				   IEEE80211_TX_CTRL_MLO_LINK);
+	u8 band = info->band;
 	u8 rate;
 	u32 i;
 
-	sband = mvm->hw->wiphy->bands[info->band];
+	if (link_id == IEEE80211_LINK_UNSPECIFIED && vif->valid_links) {
+		for (i = 0; i < ARRAY_SIZE(mvmvif->link); i++) {
+			if (!mvmvif->link[i])
+				continue;
+			/* shouldn't do this when >1 link is active */
+			WARN_ON_ONCE(link_id != IEEE80211_LINK_UNSPECIFIED);
+			link_id = i;
+		}
+	}
+
+	if (link_id < IEEE80211_LINK_UNSPECIFIED) {
+		struct ieee80211_bss_conf *link_conf;
+
+		rcu_read_lock();
+		link_conf = rcu_dereference(vif->link_conf[link_id]);
+		if (link_conf) {
+			basic = link_conf->basic_rates;
+			if (link_conf->chandef.chan)
+				band = link_conf->chandef.chan->band;
+		}
+		rcu_read_unlock();
+	}
+
+	sband = mvm->hw->wiphy->bands[band];
 	for_each_set_bit(i, &basic, BITS_PER_LONG) {
 		u16 hw = sband->bitrates[i].hw_value;
 
@@ -892,7 +919,7 @@ u8 iwl_mvm_mac_ctxt_get_lowest_rate(struct iwl_mvm *mvm,
 		}
 	}
 
-	if (info->band == NL80211_BAND_2GHZ && !vif->p2p &&
+	if (band == NL80211_BAND_2GHZ && !vif->p2p &&
 	    vif->type != NL80211_IFTYPE_P2P_DEVICE &&
 	    !(info->flags & IEEE80211_TX_CTL_NO_CCK_RATE)) {
 		if (lowest_cck != IWL_RATE_COUNT)
-- 
2.38.1

