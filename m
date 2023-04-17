Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A35766E42CD
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Apr 2023 10:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbjDQImT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 17 Apr 2023 04:42:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbjDQImO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 17 Apr 2023 04:42:14 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CFA04EE6
        for <linux-wireless@vger.kernel.org>; Mon, 17 Apr 2023 01:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681720933; x=1713256933;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dpzVyuWBO2TMiPxMK7O0jPHGXMYtaA9aANkCbfo8Q/g=;
  b=iGQ0svPDxHdXFm39GzEBG1mrggwXIZ6fmR3v7CzabzRUFDWVNDw4qK9u
   m3hpe6MVQ558pOI12wVuYHLyBqnFX9feNFvQD2p4eEU9knvZIKpERLUrG
   hdiKzerymvk7WPejbz1AJJb4GjI2I6Lm116JeADmyroWmzoDlxII64DEI
   QRaN4N7+948VKYA/REg2MDqsCSZKvH3Cizt3wxOI+qS9x/rh4XPAwnssw
   BEUSGptXQhMOh827ewMawJJEpBp4N9d+9b9ryn7y7nn6J06ht/s2ddzKw
   p2f7+JUq88t5ppgqXi9y2zOntTL/IB74fx1fXZt2Cltz0soSO+5DSoF/j
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10682"; a="333634415"
X-IronPort-AV: E=Sophos;i="5.99,203,1677571200"; 
   d="scan'208";a="333634415"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2023 01:42:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10682"; a="693173874"
X-IronPort-AV: E=Sophos;i="5.99,203,1677571200"; 
   d="scan'208";a="693173874"
Received: from odotan1x-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.202.32])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2023 01:42:11 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 10/15] wifi: iwlwifi: mvm: remove RS rate init update argument
Date:   Mon, 17 Apr 2023 11:41:29 +0300
Message-Id: <20230417113648.92bd8d36e311.I1877a109104d5ffeaaad6a623e89f0c44decc38e@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230417084134.1338976-1-gregory.greenman@intel.com>
References: <20230417084134.1338976-1-gregory.greenman@intel.com>
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

From: Johannes Berg <johannes.berg@intel.com>

Track instead whether or not the station was authorized, that's
clearer than trying to indicate in the code whether or not the
full bandwidth should be used via an 'update' argument.

While at it, give rs_fw_rate_init() the iwl_mvm_ prefix.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 19 +++++++++++--------
 .../net/wireless/intel/iwlwifi/mvm/rs-fw.c    | 14 +++++++-------
 drivers/net/wireless/intel/iwlwifi/mvm/rs.c   |  8 ++++----
 drivers/net/wireless/intel/iwlwifi/mvm/rs.h   | 14 +++++++-------
 drivers/net/wireless/intel/iwlwifi/mvm/sta.h  |  2 ++
 5 files changed, 31 insertions(+), 26 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 8808bb3983a4..ac63af549416 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -3577,8 +3577,7 @@ static int iwl_mvm_mac_sta_state(struct ieee80211_hw *hw,
  */
 static void iwl_mvm_rs_rate_init_all_links(struct iwl_mvm *mvm,
 					   struct ieee80211_vif *vif,
-					   struct ieee80211_sta *sta,
-					   bool update)
+					   struct ieee80211_sta *sta)
 {
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 	unsigned int link_id;
@@ -3593,8 +3592,7 @@ static void iwl_mvm_rs_rate_init_all_links(struct iwl_mvm *mvm,
 			continue;
 
 		iwl_mvm_rs_rate_init(mvm, vif, sta, conf, link_sta,
-				     mvmvif->link[link_id]->phy_ctxt->channel->band,
-				     update);
+				     mvmvif->link[link_id]->phy_ctxt->channel->band);
 	}
 }
 
@@ -3766,7 +3764,7 @@ iwl_mvm_sta_state_auth_to_assoc(struct ieee80211_hw *hw,
 	}
 
 out:
-	iwl_mvm_rs_rate_init_all_links(mvm, vif, sta, false);
+	iwl_mvm_rs_rate_init_all_links(mvm, vif, sta);
 
 	return callbacks->update_sta(mvm, vif, sta);
 }
@@ -3799,7 +3797,9 @@ iwl_mvm_sta_state_assoc_to_authorized(struct iwl_mvm *mvm,
 		iwl_mvm_mei_host_associated(mvm, vif, mvm_sta);
 	}
 
-	iwl_mvm_rs_rate_init_all_links(mvm, vif, sta, true);
+	mvm_sta->authorized = true;
+
+	iwl_mvm_rs_rate_init_all_links(mvm, vif, sta);
 
 	return 0;
 }
@@ -3811,14 +3811,17 @@ iwl_mvm_sta_state_authorized_to_assoc(struct iwl_mvm *mvm,
 				      struct iwl_mvm_sta_state_ops *callbacks)
 {
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
+	struct iwl_mvm_sta *mvmsta = iwl_mvm_sta_from_mac80211(sta);
 	int ret;
 
 	lockdep_assert_held(&mvm->mutex);
 
+	mvmsta->authorized = false;
+
 	/* once we move into assoc state, need to update rate scale to
 	 * disable using wide bandwidth
 	 */
-	iwl_mvm_rs_rate_init_all_links(mvm, vif, sta, false);
+	iwl_mvm_rs_rate_init_all_links(mvm, vif, sta);
 
 	if (!sta->tdls) {
 		/* Set this but don't call iwl_mvm_mac_ctxt_changed()
@@ -3987,7 +3990,7 @@ void iwl_mvm_sta_rc_update(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	if (changed & (IEEE80211_RC_BW_CHANGED |
 		       IEEE80211_RC_SUPP_RATES_CHANGED |
 		       IEEE80211_RC_NSS_CHANGED))
-		iwl_mvm_rs_rate_init_all_links(mvm, vif, sta, true);
+		iwl_mvm_rs_rate_init_all_links(mvm, vif, sta);
 
 	if (vif->type == NL80211_IFTYPE_STATION &&
 	    changed & IEEE80211_RC_NSS_CHANGED)
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
index 9a6e5684b10c..c3a00bfbeef2 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
@@ -564,12 +564,12 @@ u16 rs_fw_get_max_amsdu_len(struct ieee80211_sta *sta,
 	return 0;
 }
 
-void rs_fw_rate_init(struct iwl_mvm *mvm,
-		     struct ieee80211_vif *vif,
-		     struct ieee80211_sta *sta,
-		     struct ieee80211_bss_conf *link_conf,
-		     struct ieee80211_link_sta *link_sta,
-		     enum nl80211_band band, bool update)
+void iwl_mvm_rs_fw_rate_init(struct iwl_mvm *mvm,
+			     struct ieee80211_vif *vif,
+			     struct ieee80211_sta *sta,
+			     struct ieee80211_bss_conf *link_conf,
+			     struct ieee80211_link_sta *link_sta,
+			     enum nl80211_band band)
 {
 	struct ieee80211_hw *hw = mvm->hw;
 	struct iwl_mvm_sta *mvmsta = iwl_mvm_sta_from_mac80211(sta);
@@ -579,7 +579,7 @@ void rs_fw_rate_init(struct iwl_mvm *mvm,
 	struct iwl_mvm_link_sta *mvm_link_sta;
 	struct iwl_lq_sta_rs_fw *lq_sta;
 	struct iwl_tlc_config_cmd_v4 cfg_cmd = {
-		.max_ch_width = update ?
+		.max_ch_width = mvmsta->authorized ?
 			rs_fw_bw_from_sta_bw(link_sta) : IWL_TLC_MNG_CH_WIDTH_20MHZ,
 		.flags = cpu_to_le16(rs_fw_get_config_flags(mvm, vif, link_sta,
 							    sband)),
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rs.c b/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
index 020de09b13f2..a4c1e3bf4ff1 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
@@ -3017,7 +3017,7 @@ static void rs_drv_rate_update(void *mvm_r,
 
 	iwl_mvm_rs_rate_init(mvm, mvmsta->vif, sta,
 			     &mvmsta->vif->bss_conf, &sta->deflink,
-			     sband->band, true);
+			     sband->band);
 }
 
 static void __iwl_mvm_rs_tx_status(struct iwl_mvm *mvm,
@@ -4106,11 +4106,11 @@ void iwl_mvm_rs_rate_init(struct iwl_mvm *mvm,
 			  struct ieee80211_sta *sta,
 			  struct ieee80211_bss_conf *link_conf,
 			  struct ieee80211_link_sta *link_sta,
-			  enum nl80211_band band, bool update)
+			  enum nl80211_band band)
 {
 	if (iwl_mvm_has_tlc_offload(mvm)) {
-		rs_fw_rate_init(mvm, vif, sta, link_conf,
-				link_sta, band, update);
+		iwl_mvm_rs_fw_rate_init(mvm, vif, sta, link_conf,
+					link_sta, band);
 	} else {
 		struct iwl_mvm_sta *mvmsta = iwl_mvm_sta_from_mac80211(sta);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rs.h b/drivers/net/wireless/intel/iwlwifi/mvm/rs.h
index c08271a5e3a9..1ca375a5cf6b 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rs.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rs.h
@@ -399,7 +399,7 @@ void iwl_mvm_rs_rate_init(struct iwl_mvm *mvm,
 			  struct ieee80211_sta *sta,
 			  struct ieee80211_bss_conf *link_conf,
 			  struct ieee80211_link_sta *link_sta,
-			  enum nl80211_band band, bool update);
+			  enum nl80211_band band);
 
 /* Notify RS about Tx status */
 void iwl_mvm_rs_tx_status(struct iwl_mvm *mvm, struct ieee80211_sta *sta,
@@ -440,12 +440,12 @@ void iwl_mvm_rs_add_sta(struct iwl_mvm *mvm, struct iwl_mvm_sta *mvmsta);
 void iwl_mvm_rs_add_sta_link(struct iwl_mvm *mvm,
 			     struct iwl_mvm_link_sta *link_sta);
 
-void rs_fw_rate_init(struct iwl_mvm *mvm,
-		     struct ieee80211_vif *vif,
-		     struct ieee80211_sta *sta,
-		     struct ieee80211_bss_conf *link_conf,
-		     struct ieee80211_link_sta *link_sta,
-		     enum nl80211_band band, bool update);
+void iwl_mvm_rs_fw_rate_init(struct iwl_mvm *mvm,
+			     struct ieee80211_vif *vif,
+			     struct ieee80211_sta *sta,
+			     struct ieee80211_bss_conf *link_conf,
+			     struct ieee80211_link_sta *link_sta,
+			     enum nl80211_band band);
 int rs_fw_tx_protection(struct iwl_mvm *mvm, struct iwl_mvm_sta *mvmsta,
 			bool enable);
 void iwl_mvm_tlc_update_notif(struct iwl_mvm *mvm,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.h b/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
index 698b9c014cd3..a61d4f88125f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
@@ -356,6 +356,7 @@ struct iwl_mvm_link_sta {
  * @tid_disable_agg: bitmap: if bit(tid) is set, the fw won't send ampdus for
  *	tid.
  * @sta_type: station type
+ * @authorized: indicates station is authorized
  * @sta_state: station state according to enum %ieee80211_sta_state
  * @bt_reduced_txpower: is reduced tx power enabled for this station
  * @next_status_eosp: the next reclaimed packet is a PS-Poll response and
@@ -409,6 +410,7 @@ struct iwl_mvm_sta {
 	enum ieee80211_sta_state sta_state;
 	bool bt_reduced_txpower;
 	bool next_status_eosp;
+	bool authorized;
 	spinlock_t lock;
 	struct iwl_mvm_tid_data tid_data[IWL_MAX_TID_COUNT + 1];
 	u8 tid_to_baid[IWL_MAX_TID_COUNT];
-- 
2.38.1

