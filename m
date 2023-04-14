Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B37A6E2084
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Apr 2023 12:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbjDNKP4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Apr 2023 06:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbjDNKPz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Apr 2023 06:15:55 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16F1F1FC8
        for <linux-wireless@vger.kernel.org>; Fri, 14 Apr 2023 03:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681467346; x=1713003346;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=p82OLvRfpqwvqSOhI7tVEiN1UuPXnGNNQ1BIcqliosY=;
  b=hyMJXn1NUM8+x4NkxctKGJm681rrfJMzCb6JqJm4E+DVYJ2vjqzXJ46s
   d1PEhBzVZ/taNX9xWQFFqebtqBHweGBfoCaWQdTZYd3fSNhrEyep/kbLw
   JH5KqEVizWrZe+1ehuYBhH7VXwb64rNqcXXQK87Xu3Wl+TUGV9897CU6+
   qwlJKYsL4FBOAqu6IzgK126VD4YjpuFcRapavCqsHYRZnh9vXLkxgQY3l
   we5dCf6LaERFXlT14ZrnIZHG93Jxr0YdJn2NM6Lz1MubRH6VsmjjBpCV6
   xMQa++HK08dtagrCOOALCG1XYT71Eb3IrdKsTG+m7MJqLW7+1v4v1LoPL
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="346263693"
X-IronPort-AV: E=Sophos;i="5.99,195,1677571200"; 
   d="scan'208";a="346263693"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2023 03:12:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="692351828"
X-IronPort-AV: E=Sophos;i="5.99,195,1677571200"; 
   d="scan'208";a="692351828"
Received: from yalankry-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.233.156])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2023 03:12:46 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, Ilan Peer <ilan.peer@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 14/15] wifi: iwlwifi: mvm: Fix setting the rate for non station cases
Date:   Fri, 14 Apr 2023 13:12:05 +0300
Message-Id: <20230414130637.fa0e4d42205d.Iab4784560c77b965fec070d4d0a1ec84171d94ff@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230414101206.1170180-1-gregory.greenman@intel.com>
References: <20230414101206.1170180-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ilan Peer <ilan.peer@intel.com>

The setting of the rate used for non station cases did not take into
consideration the interface type etc., thus when probe responses
are transmitted on P2P Device interface etc. CCK rates were used
which is not allowed.

Modify the code so the non station case would consider the
interface type etc. For HWs/FWs that do not support rate control,
preserve the previous behavior, i.e., take the rate from the
skb metadata and adjust as needed.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 .../net/wireless/intel/iwlwifi/mvm/mac-ctxt.c | 10 ++++---
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  3 +++
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c   | 26 +++++++++----------
 3 files changed, 22 insertions(+), 17 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
index 962d8c286fd8..20db9fc2e61a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
@@ -870,9 +870,9 @@ static u32 iwl_mvm_find_ie_offset(u8 *beacon, u8 eid, u32 frame_size)
 	return ie - beacon;
 }
 
-static u8 iwl_mvm_mac_ctxt_get_lowest_rate(struct iwl_mvm *mvm,
-					   struct ieee80211_tx_info *info,
-					   struct ieee80211_vif *vif)
+u8 iwl_mvm_mac_ctxt_get_lowest_rate(struct iwl_mvm *mvm,
+				    struct ieee80211_tx_info *info,
+				    struct ieee80211_vif *vif)
 {
 	struct ieee80211_supported_band *sband;
 	unsigned long basic = vif->bss_conf.basic_rates;
@@ -892,7 +892,9 @@ static u8 iwl_mvm_mac_ctxt_get_lowest_rate(struct iwl_mvm *mvm,
 		}
 	}
 
-	if (info->band == NL80211_BAND_2GHZ && !vif->p2p) {
+	if (info->band == NL80211_BAND_2GHZ && !vif->p2p &&
+	    vif->type != NL80211_IFTYPE_P2P_DEVICE &&
+	    !(info->flags & IEEE80211_TX_CTL_NO_CCK_RATE)) {
 		if (lowest_cck != IWL_RATE_COUNT)
 			rate = lowest_cck;
 		else if (lowest_ofdm != IWL_RATE_COUNT)
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index a4f8b5a04c64..7a8b4be8dcf2 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1786,6 +1786,9 @@ int iwl_mvm_mac_ctxt_send_beacon_cmd(struct iwl_mvm *mvm,
 u8 iwl_mvm_mac_ctxt_get_beacon_rate(struct iwl_mvm *mvm,
 				    struct ieee80211_tx_info *info,
 				    struct ieee80211_vif *vif);
+u8 iwl_mvm_mac_ctxt_get_lowest_rate(struct iwl_mvm *mvm,
+				    struct ieee80211_tx_info *info,
+				    struct ieee80211_vif *vif);
 u16 iwl_mvm_mac_ctxt_get_beacon_flags(const struct iwl_fw *fw,
 				      u8 rate_idx);
 void iwl_mvm_mac_ctxt_set_tim(struct iwl_mvm *mvm,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
index 478442e16d43..ab448ff6a740 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
@@ -329,23 +329,23 @@ static u32 iwl_mvm_get_tx_rate(struct iwl_mvm *mvm,
 			  sta ? iwl_mvm_sta_from_mac80211(sta)->sta_state : -1);
 
 		rate_idx = info->control.rates[0].idx;
+
+		/* For non 2 GHZ band, remap mac80211 rate ndices into driver
+		 * indices.
+		 */
+		if (info->band != NL80211_BAND_2GHZ ||
+		    (info->flags & IEEE80211_TX_CTL_NO_CCK_RATE))
+			rate_idx += IWL_FIRST_OFDM_RATE;
+
+		/* For 2.4 GHZ band, check that there is no need to remap */
+		BUILD_BUG_ON(IWL_FIRST_CCK_RATE != 0);
 	}
 
 	/* if the rate isn't a well known legacy rate, take the lowest one */
 	if (rate_idx < 0 || rate_idx >= IWL_RATE_COUNT_LEGACY)
-		rate_idx = rate_lowest_index(
-				&mvm->nvm_data->bands[info->band], sta);
-
-	/*
-	 * For non 2 GHZ band, remap mac80211 rate
-	 * indices into driver indices
-	 */
-	if (info->band != NL80211_BAND_2GHZ ||
-	    (info->flags & IEEE80211_TX_CTL_NO_CCK_RATE))
-		rate_idx += IWL_FIRST_OFDM_RATE;
-
-	/* For 2.4 GHZ band, check that there is no need to remap */
-	BUILD_BUG_ON(IWL_FIRST_CCK_RATE != 0);
+		rate_idx = iwl_mvm_mac_ctxt_get_lowest_rate(mvm,
+							    info,
+							    info->control.vif);
 
 	/* Get PLCP rate for tx_cmd->rate_n_flags */
 	rate_plcp = iwl_mvm_mac80211_idx_to_hwrate(mvm->fw, rate_idx);
-- 
2.38.1

