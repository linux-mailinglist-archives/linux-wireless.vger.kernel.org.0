Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E1AF6CB8F6
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Mar 2023 10:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232709AbjC1IAq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 Mar 2023 04:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbjC1IAb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 Mar 2023 04:00:31 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40FB74480
        for <linux-wireless@vger.kernel.org>; Tue, 28 Mar 2023 01:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679990427; x=1711526427;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Xxn9zyXwehSmZkDy6barIsVpmIPKy+Ck+azfZmj/RKQ=;
  b=Zc0LVcXrZY6cg3m4oI0ODzV9ySbvONNsusOLMrKYI0IzJcI/4SyggpwT
   u3oxo6n/IbszzlWXK10XnoWEJy32YQUGyEmlmV1RJQl0z0Zcqn3p25QmI
   A/71rQAWZA7DpwqzfJrpRJBGtQuGXlIjhcSgWYvGJ+6RrTpe/wCLkm93c
   cNxe6sjO5G74n5OvWrr9ZW0/0AiZYK2ofHFdxWXEtEcrGGB7iLMlpJ7az
   uQ6+U/bGGTlqP8cGhefXwrrRT+etfaSsfOkeOIbUGvyB7YW7C2s6Kznsi
   dD1DaZHhwOysN4oI7TCRMDw8sn0OTuJXBIS5P7rTKjoMP1k6635TBnUZr
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="328958313"
X-IronPort-AV: E=Sophos;i="5.98,296,1673942400"; 
   d="scan'208";a="328958313"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 01:00:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="773045351"
X-IronPort-AV: E=Sophos;i="5.98,296,1673942400"; 
   d="scan'208";a="773045351"
Received: from gershonr-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.194.136])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 01:00:24 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 29/31] wifi: iwlwifi: mvm: refactor iwl_mvm_mac_sta_state_common()
Date:   Tue, 28 Mar 2023 10:59:09 +0300
Message-Id: <20230328104949.5a3f8a849723.I0670d20436858a1cd3c055e03c7528db81292811@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230328075911.2370108-1-gregory.greenman@intel.com>
References: <20230328075911.2370108-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Gregory Greenman <gregory.greenman@intel.com>

Move code handling specific state transitions into separate handlers
and adjust them for MLO. Adjust relevant callbacks as well.

Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 430 ++++++++++++------
 .../net/wireless/intel/iwlwifi/mvm/mld-sta.c  | 309 ++++++++++---
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  10 +-
 .../net/wireless/intel/iwlwifi/mvm/rs-fw.c    |  28 +-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c  | 137 ++++--
 drivers/net/wireless/intel/iwlwifi/mvm/sta.h  |   3 +-
 6 files changed, 671 insertions(+), 246 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 82e7a66c5828..f778ac69c671 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -2013,12 +2013,13 @@ static void iwl_mvm_parse_ppe(struct iwl_mvm *mvm,
 }
 
 static void iwl_mvm_set_pkt_ext_from_he_ppe(struct iwl_mvm *mvm,
-					    struct ieee80211_sta *sta,
+					    struct ieee80211_link_sta *link_sta,
 					    struct iwl_he_pkt_ext_v2 *pkt_ext,
 					    bool inheritance)
 {
-	u8 nss = (sta->deflink.he_cap.ppe_thres[0] & IEEE80211_PPE_THRES_NSS_MASK) + 1;
-	u8 *ppe = &sta->deflink.he_cap.ppe_thres[0];
+	u8 nss = (link_sta->he_cap.ppe_thres[0] &
+		  IEEE80211_PPE_THRES_NSS_MASK) + 1;
+	u8 *ppe = &link_sta->he_cap.ppe_thres[0];
 	u8 ru_index_bitmap =
 		u8_get_bits(*ppe,
 			    IEEE80211_PPE_THRES_RU_INDEX_BITMASK_MASK);
@@ -2098,31 +2099,35 @@ static void iwl_mvm_get_optimal_ppe_info(struct iwl_he_pkt_ext_v2 *pkt_ext,
 }
 
 /* Set the pkt_ext field according to PPE Thresholds element */
-int iwl_mvm_set_sta_pkt_ext(struct iwl_mvm *mvm, struct ieee80211_sta *sta,
+int iwl_mvm_set_sta_pkt_ext(struct iwl_mvm *mvm,
+			    struct ieee80211_link_sta *link_sta,
 			    struct iwl_he_pkt_ext_v2 *pkt_ext)
 {
 	u8 nominal_padding;
 	int i, ret = 0;
 
+	if (WARN_ON(!link_sta))
+		return -EINVAL;
+
 	/* Initialize the PPE thresholds to "None" (7), as described in Table
 	 * 9-262ac of 80211.ax/D3.0.
 	 */
 	memset(pkt_ext, IWL_HE_PKT_EXT_NONE,
 	       sizeof(struct iwl_he_pkt_ext_v2));
 
-	if (sta->deflink.eht_cap.has_eht) {
+	if (link_sta->eht_cap.has_eht) {
 		nominal_padding =
-			u8_get_bits(sta->deflink.eht_cap.eht_cap_elem.phy_cap_info[5],
+			u8_get_bits(link_sta->eht_cap.eht_cap_elem.phy_cap_info[5],
 				    IEEE80211_EHT_PHY_CAP5_COMMON_NOMINAL_PKT_PAD_MASK);
 
 		/* If PPE Thresholds exists, parse them into a FW-familiar
 		 * format.
 		 */
-		if (sta->deflink.eht_cap.eht_cap_elem.phy_cap_info[5] &
+		if (link_sta->eht_cap.eht_cap_elem.phy_cap_info[5] &
 		    IEEE80211_EHT_PHY_CAP5_PPE_THRESHOLD_PRESENT) {
-			u8 nss = (sta->deflink.eht_cap.eht_ppe_thres[0] &
+			u8 nss = (link_sta->eht_cap.eht_ppe_thres[0] &
 				IEEE80211_EHT_PPE_THRES_NSS_MASK) + 1;
-			u8 *ppe = &sta->deflink.eht_cap.eht_ppe_thres[0];
+			u8 *ppe = &link_sta->eht_cap.eht_ppe_thres[0];
 			u8 ru_index_bitmap =
 				u16_get_bits(*ppe,
 					     IEEE80211_EHT_PPE_THRES_RU_INDEX_BITMASK_MASK);
@@ -2131,17 +2136,17 @@ int iwl_mvm_set_sta_pkt_ext(struct iwl_mvm *mvm, struct ieee80211_sta *sta,
 
 			iwl_mvm_parse_ppe(mvm, pkt_ext, nss, ru_index_bitmap,
 					  ppe, ppe_pos_bit, true);
-		/* EHT PPE Thresholds doesn't exist - set the API according
-		 * to HE PPE Tresholds
+		/* EHT PPE Thresholds doesn't exist - set the API according to
+		 * HE PPE Tresholds
 		 */
-		} else if (sta->deflink.he_cap.he_cap_elem.phy_cap_info[6] &
+		} else if (link_sta->he_cap.he_cap_elem.phy_cap_info[6] &
 			   IEEE80211_HE_PHY_CAP6_PPE_THRESHOLD_PRESENT) {
 			/* Even though HE Capabilities IE doesn't contain PPE
 			 * Thresholds for BW 320Mhz, thresholds for this BW will
 			 * be filled in with the same values as 160Mhz, due to
 			 * the inheritance, as required.
 			 */
-			iwl_mvm_set_pkt_ext_from_he_ppe(mvm, sta, pkt_ext,
+			iwl_mvm_set_pkt_ext_from_he_ppe(mvm, link_sta, pkt_ext,
 							true);
 
 			/* According to the requirements, for MCSs 12-13 the
@@ -2157,18 +2162,18 @@ int iwl_mvm_set_sta_pkt_ext(struct iwl_mvm *mvm, struct ieee80211_sta *sta,
 			ret = iwl_mvm_set_pkt_ext_from_nominal_padding(pkt_ext,
 								       nominal_padding);
 		}
-	} else if (sta->deflink.he_cap.has_he) {
+	} else if (link_sta->he_cap.has_he) {
 		/* If PPE Thresholds exist, parse them into a FW-familiar format. */
-		if (sta->deflink.he_cap.he_cap_elem.phy_cap_info[6] &
+		if (link_sta->he_cap.he_cap_elem.phy_cap_info[6] &
 			IEEE80211_HE_PHY_CAP6_PPE_THRESHOLD_PRESENT) {
-			iwl_mvm_set_pkt_ext_from_he_ppe(mvm, sta, pkt_ext,
+			iwl_mvm_set_pkt_ext_from_he_ppe(mvm, link_sta, pkt_ext,
 							false);
 		/* PPE Thresholds doesn't exist - set the API PPE values
 		 * according to Common Nominal Packet Padding field.
 		 */
 		} else {
 			nominal_padding =
-				u8_get_bits(sta->deflink.he_cap.he_cap_elem.phy_cap_info[9],
+				u8_get_bits(link_sta->he_cap.he_cap_elem.phy_cap_info[9],
 					    IEEE80211_HE_PHY_CAP9_NOMINAL_PKT_PADDING_MASK);
 			if (nominal_padding != IEEE80211_HE_PHY_CAP9_NOMINAL_PKT_PADDING_RESERVED)
 				ret = iwl_mvm_set_pkt_ext_from_nominal_padding(pkt_ext,
@@ -2244,9 +2249,11 @@ bool iwl_mvm_is_nic_ack_enabled(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 			       IEEE80211_HE_MAC_CAP2_ACK_EN));
 }
 
-__le32 iwl_mvm_get_sta_htc_flags(struct ieee80211_sta *sta)
+__le32 iwl_mvm_get_sta_htc_flags(struct ieee80211_sta *sta,
+				 struct ieee80211_link_sta *link_sta)
 {
-	u8 *mac_cap_info = &sta->deflink.he_cap.he_cap_elem.mac_cap_info[0];
+	u8 *mac_cap_info =
+		&link_sta->he_cap.he_cap_elem.mac_cap_info[0];
 	__le32 htc_flags = 0;
 
 	if (mac_cap_info[0] & IEEE80211_HE_MAC_CAP0_HTC_HE)
@@ -2339,10 +2346,10 @@ static void iwl_mvm_cfg_he_sta(struct iwl_mvm *mvm,
 		flags |= STA_CTXT_HE_RU_2MHZ_BLOCK;
 
 	/* HTC flags */
-	sta_ctxt_cmd.htc_flags = iwl_mvm_get_sta_htc_flags(sta);
+	sta_ctxt_cmd.htc_flags = iwl_mvm_get_sta_htc_flags(sta, &sta->deflink);
 
 	/* PPE Thresholds */
-	if (!iwl_mvm_set_sta_pkt_ext(mvm, sta, &sta_ctxt_cmd.pkt_ext))
+	if (!iwl_mvm_set_sta_pkt_ext(mvm, &sta->deflink, &sta_ctxt_cmd.pkt_ext))
 		flags |= STA_CTXT_HE_PACKET_EXT;
 
 	if (sta->deflink.he_cap.he_cap_elem.mac_cap_info[2] &
@@ -3497,6 +3504,253 @@ static int iwl_mvm_mac_sta_state(struct ieee80211_hw *hw,
 					    &callbacks);
 }
 
+/* FIXME: temporary making two assumptions in all sta handling functions:
+ *	(1) when setting sta state, the link exists and protected
+ *	(2) if a link is valid in sta then it's valid in vif (can
+ *	use same index in the link array)
+ */
+
+#define iwl_mvm_rs_rate_init_all_links(mvm, mvmvif, sta, update) do {		\
+	typeof(mvmvif) _mvmvif = mvmvif;					\
+	unsigned int _i;							\
+	for_each_mvm_vif_valid_link(_mvmvif, _i)				\
+		iwl_mvm_rs_rate_init((mvm), (sta),				\
+				     _mvmvif->link[_i]->phy_ctxt->channel->band,\
+				     (update));					\
+} while (0)
+
+#define IWL_MVM_MIN_BEACON_INTERVAL_TU 16
+
+static bool iwl_mvm_vif_conf_from_sta(struct iwl_mvm *mvm,
+				      struct ieee80211_vif *vif,
+				      struct ieee80211_sta *sta)
+{
+	unsigned int i;
+
+	/* Beacon interval check - firmware will crash if the beacon
+	 * interval is less than 16. We can't avoid connecting at all,
+	 * so refuse the station state change, this will cause mac80211
+	 * to abandon attempts to connect to this AP, and eventually
+	 * wpa_s will blocklist the AP...
+	 */
+
+	for_each_set_bit(i, (unsigned long *)&sta->valid_links,
+			 IEEE80211_MLD_MAX_NUM_LINKS) {
+		struct ieee80211_link_sta *link_sta =
+			rcu_dereference_protected(sta->link[i], 1);
+		struct ieee80211_bss_conf *link_conf =
+			rcu_dereference_protected(vif->link_conf[i], 1);
+
+		if (!link_conf || !link_sta)
+			continue;
+
+		if (link_conf->beacon_int < IWL_MVM_MIN_BEACON_INTERVAL_TU) {
+			IWL_ERR(mvm,
+				"Beacon interval %d for AP %pM is too small\n",
+				link_conf->beacon_int, link_sta->addr);
+			return false;
+		}
+
+		link_conf->he_support = link_sta->he_cap.has_he;
+	}
+
+	return true;
+}
+
+static void iwl_mvm_vif_set_he_support(struct ieee80211_hw *hw,
+				       struct ieee80211_vif *vif,
+				       struct ieee80211_sta *sta,
+				       bool is_sta)
+{
+	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
+	unsigned int i;
+
+	for_each_set_bit(i, (unsigned long *)&sta->valid_links,
+			 IEEE80211_MLD_MAX_NUM_LINKS) {
+		struct ieee80211_link_sta *link_sta =
+			rcu_dereference_protected(sta->link[i], 1);
+		struct ieee80211_bss_conf *link_conf =
+			rcu_dereference_protected(vif->link_conf[i], 1);
+
+		if (!link_conf || !link_sta)
+			continue;
+
+		link_conf->he_support = link_sta->he_cap.has_he;
+
+		if (is_sta) {
+			mvmvif->link[i]->he_ru_2mhz_block = false;
+			if (link_sta->he_cap.has_he)
+				iwl_mvm_check_he_obss_narrow_bw_ru(hw, vif);
+		}
+	}
+}
+
+static int
+iwl_mvm_sta_state_notexist_to_none(struct iwl_mvm *mvm,
+				   struct ieee80211_vif *vif,
+				   struct ieee80211_sta *sta,
+				   struct iwl_mvm_sta_state_ops *callbacks)
+{
+	unsigned int i;
+	int ret;
+
+	lockdep_assert_held(&mvm->mutex);
+
+	if (vif->type == NL80211_IFTYPE_STATION &&
+	    !iwl_mvm_vif_conf_from_sta(mvm, vif, sta))
+		return -EINVAL;
+
+	if (sta->tdls &&
+	    (vif->p2p ||
+	     iwl_mvm_tdls_sta_count(mvm, NULL) == IWL_MVM_TDLS_STA_COUNT ||
+	     iwl_mvm_phy_ctx_count(mvm) > 1)) {
+		IWL_DEBUG_MAC80211(mvm, "refusing TDLS sta\n");
+		return -EBUSY;
+	}
+
+	ret = callbacks->add_sta(mvm, vif, sta);
+	if (sta->tdls && ret == 0) {
+		iwl_mvm_recalc_tdls_state(mvm, vif, true);
+		iwl_mvm_tdls_check_trigger(mvm, vif, sta->addr,
+					   NL80211_TDLS_SETUP);
+	}
+
+	for (i = 0; i < ARRAY_SIZE(sta->link); i++) {
+		struct ieee80211_link_sta *link_sta;
+
+		link_sta = link_sta_dereference_protected(sta, i);
+		if (!link_sta)
+			continue;
+
+		link_sta->agg.max_rc_amsdu_len = 1;
+	}
+	ieee80211_sta_recalc_aggregates(sta);
+
+	return 0;
+}
+
+static int
+iwl_mvm_sta_state_auth_to_assoc(struct ieee80211_hw *hw,
+				struct iwl_mvm *mvm,
+				struct ieee80211_vif *vif,
+				struct ieee80211_sta *sta,
+				struct iwl_mvm_sta_state_ops *callbacks)
+{
+	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
+	struct iwl_mvm_sta *mvm_sta = iwl_mvm_sta_from_mac80211(sta);
+	unsigned int i;
+
+	lockdep_assert_held(&mvm->mutex);
+
+	if (vif->type == NL80211_IFTYPE_AP) {
+		iwl_mvm_vif_set_he_support(hw, vif, sta, false);
+		mvmvif->ap_assoc_sta_count++;
+		callbacks->mac_ctxt_changed(mvm, vif, false);
+
+		/* since the below is not for MLD API, it's ok to use
+		 * the default bss_conf
+		 */
+		if (!mvm->mld_api_is_used &&
+		    ((vif->bss_conf.he_support &&
+		      !iwlwifi_mod_params.disable_11ax) ||
+		    (vif->bss_conf.eht_support &&
+		     !iwlwifi_mod_params.disable_11be)))
+			iwl_mvm_cfg_he_sta(mvm, vif, mvm_sta->deflink.sta_id);
+	} else if (vif->type == NL80211_IFTYPE_STATION) {
+		iwl_mvm_vif_set_he_support(hw, vif, sta, true);
+
+		callbacks->mac_ctxt_changed(mvm, vif, false);
+
+		if (!mvm->mld_api_is_used)
+			goto out;
+
+		for_each_set_bit(i, (unsigned long *)&sta->valid_links,
+				 IEEE80211_MLD_MAX_NUM_LINKS) {
+			struct ieee80211_bss_conf *link_conf =
+				rcu_dereference_protected(vif->link_conf[i], 1);
+
+			if (WARN_ON(!link_conf))
+				return -EINVAL;
+
+			iwl_mvm_link_changed(mvm, vif, link_conf,
+					     LINK_CONTEXT_MODIFY_ALL &
+					     ~LINK_CONTEXT_MODIFY_ACTIVE,
+					     true);
+		}
+	}
+
+out:
+	iwl_mvm_rs_rate_init_all_links(mvm, mvmvif, sta, false);
+
+	return callbacks->update_sta(mvm, vif, sta);
+}
+
+static int
+iwl_mvm_sta_state_assoc_to_authorized(struct iwl_mvm *mvm,
+				      struct ieee80211_vif *vif,
+				      struct ieee80211_sta *sta,
+				      struct iwl_mvm_sta_state_ops *callbacks)
+{
+	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
+	struct iwl_mvm_sta *mvm_sta = iwl_mvm_sta_from_mac80211(sta);
+
+	lockdep_assert_held(&mvm->mutex);
+
+	/* we don't support TDLS during DCM */
+	if (iwl_mvm_phy_ctx_count(mvm) > 1)
+		iwl_mvm_teardown_tdls_peers(mvm);
+
+	if (sta->tdls) {
+		iwl_mvm_tdls_check_trigger(mvm, vif, sta->addr,
+					   NL80211_TDLS_ENABLE_LINK);
+	} else {
+		/* enable beacon filtering */
+		WARN_ON(iwl_mvm_enable_beacon_filter(mvm, vif, 0));
+
+		mvmvif->authorized = 1;
+
+		callbacks->mac_ctxt_changed(mvm, vif, false);
+		iwl_mvm_mei_host_associated(mvm, vif, mvm_sta);
+	}
+
+	iwl_mvm_rs_rate_init_all_links(mvm, mvmvif, sta, true);
+
+	return 0;
+}
+
+static int
+iwl_mvm_sta_state_authorized_to_assoc(struct iwl_mvm *mvm,
+				      struct ieee80211_vif *vif,
+				      struct ieee80211_sta *sta,
+				      struct iwl_mvm_sta_state_ops *callbacks)
+{
+	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
+	int ret;
+
+	lockdep_assert_held(&mvm->mutex);
+
+	/* once we move into assoc state, need to update rate scale to
+	 * disable using wide bandwidth
+	 */
+	iwl_mvm_rs_rate_init_all_links(mvm, mvmvif, sta, false);
+
+	if (!sta->tdls) {
+		/* Set this but don't call iwl_mvm_mac_ctxt_changed()
+		 * yet to avoid sending high prio again for a little
+		 * time.
+		 */
+		mvmvif->authorized = 0;
+
+		/* disable beacon filtering */
+		ret = iwl_mvm_disable_beacon_filter(mvm, vif, 0);
+		WARN_ON(ret &&
+			!test_bit(IWL_MVM_STATUS_HW_RESTART_REQUESTED,
+				  &mvm->status));
+	}
+
+	return 0;
+}
+
 /* Common part for MLD and non-MLD modes */
 int iwl_mvm_mac_sta_state_common(struct ieee80211_hw *hw,
 				 struct ieee80211_vif *vif,
@@ -3508,15 +3762,12 @@ int iwl_mvm_mac_sta_state_common(struct ieee80211_hw *hw,
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 	struct iwl_mvm_sta *mvm_sta = iwl_mvm_sta_from_mac80211(sta);
+	unsigned int link_id;
 	int ret;
 
 	IWL_DEBUG_MAC80211(mvm, "station %pM state change %d->%d\n",
 			   sta->addr, old_state, new_state);
 
-	/* this would be a mac80211 bug ... but don't crash */
-	if (WARN_ON_ONCE(!mvmvif->deflink.phy_ctxt))
-		return test_bit(IWL_MVM_STATUS_HW_RESTART_REQUESTED, &mvm->status) ? 0 : -EINVAL;
-
 	/*
 	 * If we are in a STA removal flow and in DQA mode:
 	 *
@@ -3547,48 +3798,25 @@ int iwl_mvm_mac_sta_state_common(struct ieee80211_hw *hw,
 	}
 
 	mutex_lock(&mvm->mutex);
+
+	/* this would be a mac80211 bug ... but don't crash */
+	for_each_mvm_vif_valid_link(mvmvif, link_id) {
+		if (WARN_ON_ONCE(!mvmvif->link[link_id]->phy_ctxt)) {
+			mutex_unlock(&mvm->mutex);
+			return test_bit(IWL_MVM_STATUS_HW_RESTART_REQUESTED,
+					&mvm->status) ? 0 : -EINVAL;
+		}
+	}
+
 	/* track whether or not the station is associated */
 	mvm_sta->sta_state = new_state;
 
 	if (old_state == IEEE80211_STA_NOTEXIST &&
 	    new_state == IEEE80211_STA_NONE) {
-		/*
-		 * Firmware bug - it'll crash if the beacon interval is less
-		 * than 16. We can't avoid connecting at all, so refuse the
-		 * station state change, this will cause mac80211 to abandon
-		 * attempts to connect to this AP, and eventually wpa_s will
-		 * blocklist the AP...
-		 */
-		if (vif->type == NL80211_IFTYPE_STATION &&
-		    vif->bss_conf.beacon_int < 16) {
-			IWL_ERR(mvm,
-				"AP %pM beacon interval is %d, refusing due to firmware bug!\n",
-				sta->addr, vif->bss_conf.beacon_int);
-			ret = -EINVAL;
+		ret = iwl_mvm_sta_state_notexist_to_none(mvm, vif, sta,
+							 callbacks);
+		if (ret < 0)
 			goto out_unlock;
-		}
-
-		if (vif->type == NL80211_IFTYPE_STATION)
-			vif->bss_conf.he_support = sta->deflink.he_cap.has_he;
-
-		if (sta->tdls &&
-		    (vif->p2p ||
-		     iwl_mvm_tdls_sta_count(mvm, NULL) ==
-						IWL_MVM_TDLS_STA_COUNT ||
-		     iwl_mvm_phy_ctx_count(mvm) > 1)) {
-			IWL_DEBUG_MAC80211(mvm, "refusing TDLS sta\n");
-			ret = -EBUSY;
-			goto out_unlock;
-		}
-
-		ret = callbacks->add_sta(mvm, vif, sta);
-		if (sta->tdls && ret == 0) {
-			iwl_mvm_recalc_tdls_state(mvm, vif, true);
-			iwl_mvm_tdls_check_trigger(mvm, vif, sta->addr,
-						   NL80211_TDLS_SETUP);
-		}
-
-		sta->deflink.agg.max_rc_amsdu_len = 1;
 	} else if (old_state == IEEE80211_STA_NONE &&
 		   new_state == IEEE80211_STA_AUTH) {
 		/*
@@ -3600,84 +3828,16 @@ int iwl_mvm_mac_sta_state_common(struct ieee80211_hw *hw,
 		ret = 0;
 	} else if (old_state == IEEE80211_STA_AUTH &&
 		   new_state == IEEE80211_STA_ASSOC) {
-		if (vif->type == NL80211_IFTYPE_AP) {
-			vif->bss_conf.he_support = sta->deflink.he_cap.has_he;
-			mvmvif->ap_assoc_sta_count++;
-			callbacks->mac_ctxt_changed(mvm, vif, false);
-			if (!mvm->mld_api_is_used &&
-			    ((vif->bss_conf.he_support &&
-			     !iwlwifi_mod_params.disable_11ax) ||
-			    (vif->bss_conf.eht_support &&
-			     !iwlwifi_mod_params.disable_11be)))
-				iwl_mvm_cfg_he_sta(mvm, vif,
-						   mvm_sta->deflink.sta_id);
-		} else if (vif->type == NL80211_IFTYPE_STATION) {
-			vif->bss_conf.he_support = sta->deflink.he_cap.has_he;
-
-			mvmvif->deflink.he_ru_2mhz_block = false;
-			if (sta->deflink.he_cap.has_he)
-				iwl_mvm_check_he_obss_narrow_bw_ru(hw, vif);
-
-			callbacks->mac_ctxt_changed(mvm, vif, false);
-
-			if (mvm->mld_api_is_used)
-				iwl_mvm_link_changed(mvm, vif, &vif->bss_conf,
-						     LINK_CONTEXT_MODIFY_ALL &
-						     ~LINK_CONTEXT_MODIFY_ACTIVE,
-						     true);
-		}
-
-		iwl_mvm_rs_rate_init(mvm, sta,
-				     mvmvif->deflink.phy_ctxt->channel->band,
-				     false);
-		ret = callbacks->update_sta(mvm, vif, sta);
+		ret = iwl_mvm_sta_state_auth_to_assoc(hw, mvm, vif, sta,
+						      callbacks);
 	} else if (old_state == IEEE80211_STA_ASSOC &&
 		   new_state == IEEE80211_STA_AUTHORIZED) {
-		ret = 0;
-
-		/* we don't support TDLS during DCM */
-		if (iwl_mvm_phy_ctx_count(mvm) > 1)
-			iwl_mvm_teardown_tdls_peers(mvm);
-
-		if (sta->tdls) {
-			iwl_mvm_tdls_check_trigger(mvm, vif, sta->addr,
-						   NL80211_TDLS_ENABLE_LINK);
-		} else {
-			/* enable beacon filtering */
-			WARN_ON(iwl_mvm_enable_beacon_filter(mvm, vif, 0));
-
-			mvmvif->authorized = 1;
-
-			callbacks->mac_ctxt_changed(mvm, vif, false);
-			iwl_mvm_mei_host_associated(mvm, vif, mvm_sta);
-		}
-
-		iwl_mvm_rs_rate_init(mvm, sta,
-				     mvmvif->deflink.phy_ctxt->channel->band,
-				     true);
+		ret = iwl_mvm_sta_state_assoc_to_authorized(mvm, vif, sta,
+							    callbacks);
 	} else if (old_state == IEEE80211_STA_AUTHORIZED &&
 		   new_state == IEEE80211_STA_ASSOC) {
-		/* once we move into assoc state, need to update rate scale to
-		 * disable using wide bandwidth
-		 */
-		iwl_mvm_rs_rate_init(mvm, sta,
-				     mvmvif->deflink.phy_ctxt->channel->band,
-				     false);
-		if (!sta->tdls) {
-			/*
-			 * Set this but don't call iwl_mvm_mac_ctxt_changed()
-			 * yet to avoid sending high prio again for a little
-			 * time.
-			 */
-			mvmvif->authorized = 0;
-
-			/* disable beacon filtering */
-			ret = iwl_mvm_disable_beacon_filter(mvm, vif, 0);
-			WARN_ON(ret &&
-				!test_bit(IWL_MVM_STATUS_HW_RESTART_REQUESTED,
-					  &mvm->status));
-		}
-		ret = 0;
+		ret = iwl_mvm_sta_state_authorized_to_assoc(mvm, vif, sta,
+							    callbacks);
 	} else if (old_state == IEEE80211_STA_ASSOC &&
 		   new_state == IEEE80211_STA_AUTH) {
 		if (vif->type == NL80211_IFTYPE_AP) {
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
index 3791f37afa78..7a01295949fa 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
@@ -50,18 +50,14 @@ static int iwl_mvm_mld_add_int_sta_to_fw(struct iwl_mvm *mvm,
  */
 static int iwl_mvm_mld_rm_sta_from_fw(struct iwl_mvm *mvm, u32 sta_id)
 {
-	struct ieee80211_sta *sta;
 	struct iwl_mvm_remove_sta_cmd rm_sta_cmd = {
 		.sta_id = cpu_to_le32(sta_id),
 	};
 	int ret;
 
-	sta = rcu_dereference_protected(mvm->fw_id_to_mac_id[sta_id],
-					lockdep_is_held(&mvm->mutex));
-
 	/* Note: internal stations are marked as error values */
-	if (!sta) {
-		IWL_ERR(mvm, "Invalid station id\n");
+	if (!rcu_access_pointer(mvm->fw_id_to_mac_id[sta_id])) {
+		IWL_ERR(mvm, "Invalid station id %d\n", sta_id);
 		return -EINVAL;
 	}
 
@@ -380,18 +376,20 @@ int iwl_mvm_mld_rm_aux_sta(struct iwl_mvm *mvm)
 
 /* send a cfg sta command to add/update a sta in firmware */
 static int iwl_mvm_mld_cfg_sta(struct iwl_mvm *mvm, struct ieee80211_sta *sta,
-			       struct ieee80211_vif *vif)
+			       struct ieee80211_vif *vif,
+			       struct ieee80211_link_sta *link_sta,
+			       struct ieee80211_bss_conf *link_conf,
+			       struct iwl_mvm_link_sta *mvm_link_sta)
 {
 	struct iwl_mvm_sta *mvm_sta = iwl_mvm_sta_from_mac80211(sta);
 	struct iwl_mvm_vif *mvm_vif = iwl_mvm_vif_from_mac80211(vif);
+	struct iwl_mvm_vif_link_info *link_info =
+					mvm_vif->link[link_conf->link_id];
 	struct iwl_mvm_sta_cfg_cmd cmd = {
-		.sta_id = cpu_to_le32(mvm_sta->deflink.sta_id),
+		.sta_id = cpu_to_le32(mvm_link_sta->sta_id),
 		.station_type = cpu_to_le32(mvm_sta->sta_type),
 		.mfp = cpu_to_le32(sta->mfp),
 	};
-	/* FIXME: use proper link_id */
-	unsigned int link_id = 0;
-	struct iwl_mvm_vif_link_info *link_info = mvm_vif->link[link_id];
 	u32 agg_size = 0, mpdu_dens = 0;
 
 	/* when adding sta, link should exist in FW */
@@ -407,7 +405,7 @@ static int iwl_mvm_mld_cfg_sta(struct iwl_mvm *mvm, struct ieee80211_sta *sta,
 	if (mvm_sta->sta_state >= IEEE80211_STA_ASSOC)
 		cmd.assoc_id = cpu_to_le32(sta->aid);
 
-	switch (sta->deflink.rx_nss) {
+	switch (link_sta->rx_nss) {
 	case 1:
 		cmd.mimo = cpu_to_le32(0);
 		break;
@@ -433,7 +431,7 @@ static int iwl_mvm_mld_cfg_sta(struct iwl_mvm *mvm, struct ieee80211_sta *sta,
 		break;
 	}
 
-	mpdu_dens = iwl_mvm_get_sta_ampdu_dens(sta, &agg_size);
+	mpdu_dens = iwl_mvm_get_sta_ampdu_dens(link_sta, link_conf, &agg_size);
 	cmd.tx_ampdu_spacing = cpu_to_le32(mpdu_dens);
 	cmd.tx_ampdu_max_size = cpu_to_le32(agg_size);
 
@@ -443,17 +441,17 @@ static int iwl_mvm_mld_cfg_sta(struct iwl_mvm *mvm, struct ieee80211_sta *sta,
 		cmd.uapsd_acs = cpu_to_le32(iwl_mvm_get_sta_uapsd_acs(sta));
 	}
 
-	if (sta->deflink.he_cap.has_he) {
+	if (link_sta->he_cap.has_he) {
 		cmd.trig_rnd_alloc =
-			cpu_to_le32(vif->bss_conf.uora_exists ? 1 : 0);
+			cpu_to_le32(link_conf->uora_exists ? 1 : 0);
 
 		/* PPE Thresholds */
-		iwl_mvm_set_sta_pkt_ext(mvm, sta, &cmd.pkt_ext);
+		iwl_mvm_set_sta_pkt_ext(mvm, link_sta, &cmd.pkt_ext);
 
 		/* HTC flags */
-		cmd.htc_flags = iwl_mvm_get_sta_htc_flags(sta);
+		cmd.htc_flags = iwl_mvm_get_sta_htc_flags(sta, link_sta);
 
-		if (sta->deflink.he_cap.he_cap_elem.mac_cap_info[2] &
+		if (link_sta->he_cap.he_cap_elem.mac_cap_info[2] &
 		    IEEE80211_HE_MAC_CAP2_ACK_EN)
 			cmd.ack_enabled = cpu_to_le32(1);
 	}
@@ -461,72 +459,243 @@ static int iwl_mvm_mld_cfg_sta(struct iwl_mvm *mvm, struct ieee80211_sta *sta,
 	return iwl_mvm_mld_send_sta_cmd(mvm, &cmd);
 }
 
-int iwl_mvm_mld_add_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
-			struct ieee80211_sta *sta)
+static void iwl_mvm_mld_sta_rm_all_sta_links(struct iwl_mvm *mvm,
+					     struct iwl_mvm_sta *mvm_sta)
+{
+	unsigned int link_id;
+
+	for (link_id = 0; link_id < ARRAY_SIZE(mvm_sta->link); link_id++) {
+		struct iwl_mvm_link_sta *link =
+			rcu_dereference_protected(mvm_sta->link[link_id],
+						  lockdep_is_held(&mvm->mutex));
+
+		if (!link)
+			continue;
+
+		RCU_INIT_POINTER(mvm->fw_id_to_mac_id[link->sta_id], NULL);
+		RCU_INIT_POINTER(mvm_sta->link[link_id], NULL);
+
+		if (link != &mvm_sta->deflink)
+			kfree_rcu(link, rcu_head);
+	}
+}
+
+/* allocate all the links of a sta, called when the station is first added */
+static int iwl_mvm_mld_alloc_sta_links(struct iwl_mvm *mvm,
+				       struct ieee80211_vif *vif,
+				       struct ieee80211_sta *sta)
 {
-	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 	struct iwl_mvm_sta *mvm_sta = iwl_mvm_sta_from_mac80211(sta);
-	int sta_id, ret = 0;
+	struct iwl_mvm_link_sta *link;
+	unsigned int link_id;
+	u32 sta_id;
+	int ret;
 
 	lockdep_assert_held(&mvm->mutex);
 
-	if (!test_bit(IWL_MVM_STATUS_IN_HW_RESTART, &mvm->status))
+	for (link_id = 0; link_id < ARRAY_SIZE(sta->link); link_id++) {
+		if (!rcu_access_pointer(sta->link[link_id]) ||
+		    mvm_sta->link[link_id])
+			continue;
+
 		sta_id = iwl_mvm_find_free_sta_id(mvm,
 						  ieee80211_vif_type_p2p(vif));
-	else
-		sta_id = mvm_sta->deflink.sta_id;
 
-	if (sta_id == IWL_MVM_INVALID_STA)
-		return -ENOSPC;
+		if (sta_id == IWL_MVM_INVALID_STA) {
+			ret = -ENOSPC;
+			goto err;
+		}
 
-	spin_lock_init(&mvm_sta->lock);
+		if (rcu_access_pointer(sta->link[link_id]) == &sta->deflink) {
+			link = &mvm_sta->deflink;
+		} else {
+			link = kzalloc(sizeof(*link), GFP_KERNEL);
+			if (!link) {
+				ret = -ENOMEM;
+				goto err;
+			}
+		}
 
-	/* if this is a HW restart re-alloc existing queues */
-	if (test_bit(IWL_MVM_STATUS_IN_HW_RESTART, &mvm->status)) {
-		struct iwl_mvm_int_sta tmp_sta = {
-			.sta_id = sta_id,
-			.type = mvm_sta->sta_type,
-		};
+		link->sta_id = sta_id;
+		rcu_assign_pointer(mvm_sta->link[link_id], link);
+		rcu_assign_pointer(mvm->fw_id_to_mac_id[link->sta_id], sta);
+	}
 
-		/* First add an empty station since allocating
-		 * a queue requires a valid station
-		 */
+	return 0;
+
+err:
+	iwl_mvm_mld_sta_rm_all_sta_links(mvm, mvm_sta);
+	return ret;
+}
+
+static void iwl_mvm_mld_set_ap_sta_id(struct ieee80211_sta *sta,
+				      struct iwl_mvm_vif_link_info *vif_link,
+				      struct iwl_mvm_link_sta *sta_link)
+{
+	if (!sta->tdls) {
+		WARN_ON(vif_link->ap_sta_id != IWL_MVM_INVALID_STA);
+		vif_link->ap_sta_id = sta_link->sta_id;
+	} else {
+		WARN_ON(vif_link->ap_sta_id == IWL_MVM_INVALID_STA);
+	}
+}
+
+/* FIXME: consider waiting for mac80211 to add the STA instead of allocating
+ * queues here
+ */
+static int iwl_mvm_alloc_sta_after_restart(struct iwl_mvm *mvm,
+					   struct ieee80211_vif *vif,
+					   struct ieee80211_sta *sta)
+{
+	struct iwl_mvm_sta *mvm_sta = iwl_mvm_sta_from_mac80211(sta);
+	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
+	struct ieee80211_link_sta *link_sta;
+	unsigned int link_id;
+	struct iwl_mvm_int_sta tmp_sta = {
+		.type = mvm_sta->sta_type,
+	};
+	int sta_id, ret;
+
+	/* First add an empty station since allocating a queue requires
+	 * a valid station. Since we need a link_id to allocate a station,
+	 * pick up the first valid one.
+	 */
+	for_each_sta_active_link(vif, sta, link_sta, link_id) {
+		struct iwl_mvm_vif_link_info *mvm_link;
+		struct ieee80211_bss_conf *link_conf =
+			link_conf_dereference_protected(vif, link_id);
+		struct iwl_mvm_link_sta *mvm_link_sta =
+			rcu_dereference_protected(mvm_sta->link[link_id],
+						  lockdep_is_held(&mvm->mutex));
+
+		if (!link_conf)
+			continue;
+
+		mvm_link = mvmvif->link[link_conf->link_id];
+
+		if (!mvm_link || !mvm_link_sta)
+			continue;
+
+		sta_id = mvm_link_sta->sta_id;
+		tmp_sta.sta_id = sta_id;
 		ret = iwl_mvm_mld_add_int_sta_to_fw(mvm, &tmp_sta,
 						    vif->bss_conf.bssid,
-						    mvmvif->id);
+						    mvm_link->fw_link_id);
 		if (ret)
 			return ret;
 
+		rcu_assign_pointer(mvm->fw_id_to_mac_id[sta_id], sta);
 		iwl_mvm_realloc_queues_after_restart(mvm, sta);
-	} else {
-		ret = iwl_mvm_sta_init(mvm, vif, sta, sta_id,
-				       STATION_TYPE_PEER);
+
+		/* since we need only one station, no need to continue */
+		return 0;
 	}
 
-	ret = iwl_mvm_mld_cfg_sta(mvm, sta, vif);
-	if (ret)
-		return ret;
+	/* no active link found */
+	return -EINVAL;
+}
 
-	if (vif->type == NL80211_IFTYPE_STATION) {
-		if (!sta->tdls) {
-			WARN_ON(mvmvif->deflink.ap_sta_id != IWL_MVM_INVALID_STA);
-			mvmvif->deflink.ap_sta_id = sta_id;
-		} else {
-			WARN_ON(mvmvif->deflink.ap_sta_id == IWL_MVM_INVALID_STA);
-		}
+int iwl_mvm_mld_add_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
+			struct ieee80211_sta *sta)
+{
+	struct iwl_mvm_vif *mvm_vif = iwl_mvm_vif_from_mac80211(vif);
+	struct iwl_mvm_sta *mvm_sta = iwl_mvm_sta_from_mac80211(sta);
+	unsigned long link_sta_added_to_fw = 0;
+	struct ieee80211_link_sta *link_sta;
+	int ret = 0;
+	unsigned int link_id;
+
+	lockdep_assert_held(&mvm->mutex);
+
+	if (!test_bit(IWL_MVM_STATUS_IN_HW_RESTART, &mvm->status)) {
+		ret = iwl_mvm_mld_alloc_sta_links(mvm, vif, sta);
+		if (ret)
+			return ret;
 	}
 
-	rcu_assign_pointer(mvm->fw_id_to_mac_id[sta_id], sta);
+	spin_lock_init(&mvm_sta->lock);
+
+	if (test_bit(IWL_MVM_STATUS_IN_HW_RESTART, &mvm->status))
+		ret = iwl_mvm_alloc_sta_after_restart(mvm, vif, sta);
+	else
+		ret = iwl_mvm_sta_init(mvm, vif, sta, IWL_MVM_INVALID_STA,
+				       STATION_TYPE_PEER);
+	if (ret)
+		goto err;
+
+	/* at this stage sta link pointers are already allocated */
+	ret = iwl_mvm_mld_update_sta(mvm, vif, sta);
+
+	for_each_sta_active_link(vif, sta, link_sta, link_id) {
+		struct ieee80211_bss_conf *link_conf =
+			rcu_dereference_protected(vif->link_conf[link_id], 1);
+		struct iwl_mvm_link_sta *mvm_link_sta =
+			rcu_dereference_protected(mvm_sta->link[link_id],
+						  lockdep_is_held(&mvm->mutex));
+
+		if (WARN_ON(!link_conf || !mvm_link_sta))
+			goto err;
+
+		ret = iwl_mvm_mld_cfg_sta(mvm, sta, vif, link_sta, link_conf,
+					  mvm_link_sta);
+		if (ret)
+			goto err;
+
+		link_sta_added_to_fw |= BIT(link_id);
+
+		if (vif->type == NL80211_IFTYPE_STATION)
+			iwl_mvm_mld_set_ap_sta_id(sta, mvm_vif->link[link_id],
+						  mvm_link_sta);
+	}
 
 	return 0;
+
+err:
+	/* remove all already allocated stations in FW */
+	for_each_set_bit(link_id, &link_sta_added_to_fw,
+			 IEEE80211_MLD_MAX_NUM_LINKS) {
+		struct iwl_mvm_link_sta *mvm_link_sta =
+			rcu_dereference_protected(mvm_sta->link[link_id],
+						  lockdep_is_held(&mvm->mutex));
+
+		iwl_mvm_mld_rm_sta_from_fw(mvm, mvm_link_sta->sta_id);
+	}
+
+	/* free all sta resources in the driver */
+	iwl_mvm_mld_sta_rm_all_sta_links(mvm, mvm_sta);
+	return ret;
 }
 
 int iwl_mvm_mld_update_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 			   struct ieee80211_sta *sta)
 {
+	struct iwl_mvm_sta *mvm_sta = iwl_mvm_sta_from_mac80211(sta);
+	struct ieee80211_link_sta *link_sta;
+	unsigned int link_id;
+	int ret = 0;
+
 	lockdep_assert_held(&mvm->mutex);
 
-	return iwl_mvm_mld_cfg_sta(mvm, sta, vif);
+	for_each_sta_active_link(vif, sta, link_sta, link_id) {
+		struct ieee80211_bss_conf *link_conf =
+			rcu_dereference_protected(vif->link_conf[link_id], 1);
+		struct iwl_mvm_link_sta *mvm_link_sta =
+			rcu_dereference_protected(mvm_sta->link[link_id],
+						  lockdep_is_held(&mvm->mutex));
+
+		if (WARN_ON(!link_conf || !mvm_link_sta))
+			return -EINVAL;
+
+		ret = iwl_mvm_mld_cfg_sta(mvm, sta, vif, link_sta, link_conf,
+					  mvm_link_sta);
+
+		if (ret) {
+			IWL_ERR(mvm, "Failed to update sta link %d\n", link_id);
+			break;
+		}
+	}
+
+	return ret;
 }
 
 static void iwl_mvm_mld_disable_sta_queues(struct iwl_mvm *mvm,
@@ -559,6 +728,8 @@ int iwl_mvm_mld_rm_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 		       struct ieee80211_sta *sta)
 {
 	struct iwl_mvm_sta *mvm_sta = iwl_mvm_sta_from_mac80211(sta);
+	struct ieee80211_link_sta *link_sta;
+	unsigned int link_id;
 	int ret;
 
 	lockdep_assert_held(&mvm->mutex);
@@ -566,20 +737,38 @@ int iwl_mvm_mld_rm_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	kfree(mvm_sta->dup_data);
 
 	/* flush its queues here since we are freeing mvm_sta */
-	ret = iwl_mvm_flush_sta(mvm, mvm_sta, false);
-	if (ret)
-		return ret;
+	for_each_sta_active_link(vif, sta, link_sta, link_id) {
+		struct iwl_mvm_link_sta *mvm_link_sta =
+			rcu_dereference_protected(mvm_sta->link[link_id],
+						  lockdep_is_held(&mvm->mutex));
+
+		if (WARN_ON(!mvm_link_sta))
+			return -EINVAL;
+
+		ret = iwl_mvm_flush_sta_tids(mvm, mvm_link_sta->sta_id,
+					     0xffff);
+		if (ret)
+			return ret;
+	}
+
 	ret = iwl_mvm_wait_sta_queues_empty(mvm, mvm_sta);
 	if (ret)
 		return ret;
 
 	iwl_mvm_mld_disable_sta_queues(mvm, vif, sta);
 
-	if (iwl_mvm_sta_del(mvm, vif, sta, &ret))
-		return ret;
+	for_each_sta_active_link(vif, sta, link_sta, link_id) {
+		struct iwl_mvm_link_sta *mvm_link_sta =
+			rcu_dereference_protected(mvm_sta->link[link_id],
+						  lockdep_is_held(&mvm->mutex));
+
+		if (iwl_mvm_sta_del(mvm, vif, sta, mvm_link_sta, &ret))
+			return ret;
+
+		ret = iwl_mvm_mld_rm_sta_from_fw(mvm, mvm_link_sta->sta_id);
+	}
 
-	ret = iwl_mvm_mld_rm_sta_from_fw(mvm, mvm_sta->deflink.sta_id);
-	RCU_INIT_POINTER(mvm->fw_id_to_mac_id[mvm_sta->deflink.sta_id], NULL);
+	iwl_mvm_mld_sta_rm_all_sta_links(mvm, mvm_sta);
 
 	return ret;
 }
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 811647c8aa71..3a9ece67aff7 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1606,10 +1606,14 @@ int iwl_mvm_flush_sta(struct iwl_mvm *mvm, void *sta, bool internal);
 int iwl_mvm_flush_sta_tids(struct iwl_mvm *mvm, u32 sta_id, u16 tids);
 
 /* Utils to extract sta related data */
-__le32 iwl_mvm_get_sta_htc_flags(struct ieee80211_sta *sta);
+__le32 iwl_mvm_get_sta_htc_flags(struct ieee80211_sta *sta,
+				 struct ieee80211_link_sta *link_sta);
 u8 iwl_mvm_get_sta_uapsd_acs(struct ieee80211_sta *sta);
-u32 iwl_mvm_get_sta_ampdu_dens(struct ieee80211_sta *sta, u32 *_agg_size);
-int iwl_mvm_set_sta_pkt_ext(struct iwl_mvm *mvm, struct ieee80211_sta *sta,
+u32 iwl_mvm_get_sta_ampdu_dens(struct ieee80211_link_sta *link_sta,
+			       struct ieee80211_bss_conf *link_conf,
+			       u32 *_agg_size);
+int iwl_mvm_set_sta_pkt_ext(struct iwl_mvm *mvm,
+			    struct ieee80211_link_sta *link_sta,
 			    struct iwl_he_pkt_ext_v2 *pkt_ext);
 
 void iwl_mvm_async_handlers_purge(struct iwl_mvm *mvm);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
index a33673c6ae7d..778c9237fe87 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
@@ -641,18 +641,30 @@ int rs_fw_tx_protection(struct iwl_mvm *mvm, struct iwl_mvm_sta *mvmsta,
 
 void iwl_mvm_rs_add_sta(struct iwl_mvm *mvm, struct iwl_mvm_sta *mvmsta)
 {
-	struct iwl_lq_sta_rs_fw *lq_sta = &mvmsta->deflink.lq_sta.rs_fw;
+	unsigned int link_id;
 
 	IWL_DEBUG_RATE(mvm, "create station rate scale window\n");
 
-	lq_sta->pers.drv = mvm;
-	lq_sta->pers.sta_id = mvmsta->deflink.sta_id;
-	lq_sta->pers.chains = 0;
-	memset(lq_sta->pers.chain_signal, 0, sizeof(lq_sta->pers.chain_signal));
-	lq_sta->pers.last_rssi = S8_MIN;
-	lq_sta->last_rate_n_flags = 0;
+	for (link_id = 0; link_id < ARRAY_SIZE(mvmsta->link); link_id++) {
+		struct iwl_lq_sta_rs_fw *lq_sta;
+		struct iwl_mvm_link_sta *link =
+			rcu_dereference_protected(mvmsta->link[link_id],
+						  lockdep_is_held(&mvm->mutex));
+		if (!link)
+			continue;
+
+		lq_sta = &link->lq_sta.rs_fw;
+
+		lq_sta->pers.drv = mvm;
+		lq_sta->pers.sta_id = link->sta_id;
+		lq_sta->pers.chains = 0;
+		memset(lq_sta->pers.chain_signal, 0,
+		       sizeof(lq_sta->pers.chain_signal));
+		lq_sta->pers.last_rssi = S8_MIN;
+		lq_sta->last_rate_n_flags = 0;
 
 #ifdef CONFIG_MAC80211_DEBUGFS
-	lq_sta->pers.dbg_fixed_rate = 0;
+		lq_sta->pers.dbg_fixed_rate = 0;
 #endif
+	}
 }
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
index 54ef749be488..eb57acaef96a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
@@ -51,26 +51,31 @@ int iwl_mvm_find_free_sta_id(struct iwl_mvm *mvm, enum nl80211_iftype iftype)
 }
 
 /* Calculate the ampdu density and max size */
-u32 iwl_mvm_get_sta_ampdu_dens(struct ieee80211_sta *sta, u32 *_agg_size)
+u32 iwl_mvm_get_sta_ampdu_dens(struct ieee80211_link_sta *link_sta,
+			       struct ieee80211_bss_conf *link_conf,
+			       u32 *_agg_size)
 {
-	struct iwl_mvm_sta *mvm_sta = iwl_mvm_sta_from_mac80211(sta);
 	u32 agg_size = 0, mpdu_dens = 0;
 
-	if (sta->deflink.ht_cap.ht_supported)
-		mpdu_dens = sta->deflink.ht_cap.ampdu_density;
+	if (WARN_ON(!link_sta))
+		return 0;
+
+	if (link_sta->ht_cap.ht_supported)
+		mpdu_dens = link_sta->ht_cap.ampdu_density;
 
-	if (mvm_sta->vif->bss_conf.chandef.chan->band == NL80211_BAND_6GHZ) {
-		mpdu_dens = le16_get_bits(sta->deflink.he_6ghz_capa.capa,
+	if (link_conf->chandef.chan->band ==
+	    NL80211_BAND_6GHZ) {
+		mpdu_dens = le16_get_bits(link_sta->he_6ghz_capa.capa,
 					  IEEE80211_HE_6GHZ_CAP_MIN_MPDU_START);
-		agg_size = le16_get_bits(sta->deflink.he_6ghz_capa.capa,
+		agg_size = le16_get_bits(link_sta->he_6ghz_capa.capa,
 					 IEEE80211_HE_6GHZ_CAP_MAX_AMPDU_LEN_EXP);
-	} else if (sta->deflink.vht_cap.vht_supported) {
-		agg_size = sta->deflink.vht_cap.cap &
+	} else if (link_sta->vht_cap.vht_supported) {
+		agg_size = link_sta->vht_cap.cap &
 			IEEE80211_VHT_CAP_MAX_A_MPDU_LENGTH_EXPONENT_MASK;
 		agg_size >>=
 			IEEE80211_VHT_CAP_MAX_A_MPDU_LENGTH_EXPONENT_SHIFT;
-	} else if (sta->deflink.ht_cap.ht_supported) {
-		agg_size = sta->deflink.ht_cap.ampdu_factor;
+	} else if (link_sta->ht_cap.ht_supported) {
+		agg_size = link_sta->ht_cap.ampdu_factor;
 	}
 
 	/* D6.0 10.12.2 A-MPDU length limit rules
@@ -81,10 +86,10 @@ u32 iwl_mvm_get_sta_ampdu_dens(struct ieee80211_sta *sta, u32 *_agg_size)
 	 * Maximum AMPDU Length Exponent Extension field in its HE
 	 * Capabilities element
 	 */
-	if (sta->deflink.he_cap.has_he)
+	if (link_sta->he_cap.has_he)
 		agg_size +=
-		    u8_get_bits(sta->deflink.he_cap.he_cap_elem.mac_cap_info[3],
-				IEEE80211_HE_MAC_CAP3_MAX_AMPDU_LEN_EXP_MASK);
+			u8_get_bits(link_sta->he_cap.he_cap_elem.mac_cap_info[3],
+				    IEEE80211_HE_MAC_CAP3_MAX_AMPDU_LEN_EXP_MASK);
 
 	/* Limit to max A-MPDU supported by FW */
 	if (agg_size > (STA_FLG_MAX_AGG_SIZE_4M >> STA_FLG_MAX_AGG_SIZE_SHIFT))
@@ -200,7 +205,9 @@ int iwl_mvm_sta_send_to_fw(struct iwl_mvm *mvm, struct ieee80211_sta *sta,
 			cpu_to_le32(STA_FLG_MAX_AGG_SIZE_MSK |
 				    STA_FLG_AGG_MPDU_DENS_MSK);
 
-	mpdu_dens = iwl_mvm_get_sta_ampdu_dens(sta, &agg_size);
+	mpdu_dens = iwl_mvm_get_sta_ampdu_dens(&sta->deflink,
+					       &mvm_sta->vif->bss_conf,
+					       &agg_size);
 	add_sta_cmd.station_flags |=
 		cpu_to_le32(agg_size << STA_FLG_MAX_AGG_SIZE_SHIFT);
 	add_sta_cmd.station_flags |=
@@ -784,19 +791,35 @@ static int iwl_mvm_find_free_queue(struct iwl_mvm *mvm, u8 sta_id,
 
 static int iwl_mvm_get_queue_size(struct ieee80211_sta *sta)
 {
+	int max_size = IWL_DEFAULT_QUEUE_SIZE;
+	unsigned int link_id;
+
 	/* this queue isn't used for traffic (cab_queue) */
 	if (!sta)
 		return IWL_MGMT_QUEUE_SIZE;
 
-	/* support for 1k ba size */
-	if (sta->deflink.eht_cap.has_eht)
-		return IWL_DEFAULT_QUEUE_SIZE_EHT;
+	rcu_read_lock();
 
-	/* support for 256 ba size */
-	if (sta->deflink.he_cap.has_he)
-		return IWL_DEFAULT_QUEUE_SIZE_HE;
+	for (link_id = 0; link_id < ARRAY_SIZE(sta->link); link_id++) {
+		struct ieee80211_link_sta *link =
+			rcu_dereference(sta->link[link_id]);
 
-	return IWL_DEFAULT_QUEUE_SIZE;
+		if (!link)
+			continue;
+
+		/* support for 1k ba size */
+		if (link->eht_cap.has_eht &&
+		    max_size < IWL_DEFAULT_QUEUE_SIZE_EHT)
+			max_size = IWL_DEFAULT_QUEUE_SIZE_EHT;
+
+		/* support for 256 ba size */
+		if (link->he_cap.has_he &&
+		    max_size < IWL_DEFAULT_QUEUE_SIZE_HE)
+			max_size = IWL_DEFAULT_QUEUE_SIZE_HE;
+	}
+
+	rcu_read_unlock();
+	return max_size;
 }
 
 int iwl_mvm_tvqm_enable_txq(struct iwl_mvm *mvm,
@@ -804,6 +827,7 @@ int iwl_mvm_tvqm_enable_txq(struct iwl_mvm *mvm,
 			    u8 sta_id, u8 tid, unsigned int timeout)
 {
 	int queue, size;
+	u32 sta_mask = 0;
 
 	if (tid == IWL_MAX_TID_COUNT) {
 		tid = IWL_MGMT_TID;
@@ -819,22 +843,45 @@ int iwl_mvm_tvqm_enable_txq(struct iwl_mvm *mvm,
 	/* size needs to be power of 2 values for calculating read/write pointers */
 	size = rounddown_pow_of_two(size);
 
+	if (sta) {
+		struct iwl_mvm_sta *mvmsta = iwl_mvm_sta_from_mac80211(sta);
+		unsigned int link_id;
+
+		for (link_id = 0;
+		     link_id < ARRAY_SIZE(mvmsta->link);
+		     link_id++) {
+			struct iwl_mvm_link_sta *link =
+				rcu_dereference_protected(mvmsta->link[link_id],
+							  lockdep_is_held(&mvm->mutex));
+
+			if (!link)
+				continue;
+
+			sta_mask |= BIT(link->sta_id);
+		}
+	} else {
+		sta_mask |= BIT(sta_id);
+	}
+
+	if (!sta_mask)
+		return -EINVAL;
+
 	do {
-		queue = iwl_trans_txq_alloc(mvm->trans, 0, BIT(sta_id),
+		queue = iwl_trans_txq_alloc(mvm->trans, 0, sta_mask,
 					    tid, size, timeout);
 
 		if (queue < 0)
 			IWL_DEBUG_TX_QUEUES(mvm,
-					    "Failed allocating TXQ of size %d for sta %d tid %d, ret: %d\n",
-					    size, sta_id, tid, queue);
+					    "Failed allocating TXQ of size %d for sta mask %x tid %d, ret: %d\n",
+					    size, sta_mask, tid, queue);
 		size /= 2;
 	} while (queue < 0 && size >= 16);
 
 	if (queue < 0)
 		return queue;
 
-	IWL_DEBUG_TX_QUEUES(mvm, "Enabling TXQ #%d for sta %d tid %d\n",
-			    queue, sta_id, tid);
+	IWL_DEBUG_TX_QUEUES(mvm, "Enabling TXQ #%d for sta mask 0x%x tid %d\n",
+			    queue, sta_mask, tid);
 
 	return queue;
 }
@@ -1657,16 +1704,28 @@ int iwl_mvm_sta_init(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 
 	lockdep_assert_held(&mvm->mutex);
 
-	mvm_sta->deflink.sta_id = sta_id;
-	rcu_assign_pointer(mvm_sta->link[0], &mvm_sta->deflink);
-
 	mvm_sta->mac_id_n_color = FW_CMD_ID_AND_COLOR(mvmvif->id,
 						      mvmvif->color);
 	mvm_sta->vif = vif;
-	if (!mvm->trans->trans_cfg->gen2)
-		mvm_sta->max_agg_bufsize = LINK_QUAL_AGG_FRAME_LIMIT_DEF;
-	else
-		mvm_sta->max_agg_bufsize = LINK_QUAL_AGG_FRAME_LIMIT_GEN2_DEF;
+
+	/* for MLD sta_id(s) should be allocated for each link before calling
+	 * this function
+	 */
+	if (!mvm->mld_api_is_used) {
+		if (WARN_ON(sta_id == IWL_MVM_INVALID_STA))
+			return -EINVAL;
+
+		mvm_sta->deflink.sta_id = sta_id;
+		rcu_assign_pointer(mvm_sta->link[0], &mvm_sta->deflink);
+
+		if (!mvm->trans->trans_cfg->gen2)
+			mvm_sta->max_agg_bufsize =
+				LINK_QUAL_AGG_FRAME_LIMIT_DEF;
+		else
+			mvm_sta->max_agg_bufsize =
+				LINK_QUAL_AGG_FRAME_LIMIT_GEN2_DEF;
+	}
+
 	mvm_sta->tt_tx_protection = false;
 	mvm_sta->sta_type = sta_type;
 
@@ -1926,11 +1985,12 @@ int iwl_mvm_wait_sta_queues_empty(struct iwl_mvm *mvm,
  * with error or success
  */
 bool iwl_mvm_sta_del(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
-		     struct ieee80211_sta *sta, int *ret)
+		     struct ieee80211_sta *sta,
+		     struct iwl_mvm_link_sta *mvm_link_sta, int *ret)
 {
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 	struct iwl_mvm_sta *mvm_sta = iwl_mvm_sta_from_mac80211(sta);
-	u8 sta_id = mvm_sta->deflink.sta_id;
+	u8 sta_id = mvm_link_sta->sta_id;
 
 	lockdep_assert_held(&mvm->mutex);
 
@@ -1956,8 +2016,7 @@ bool iwl_mvm_sta_del(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 		*status = IWL_MVM_QUEUE_FREE;
 	}
 
-	if (vif->type == NL80211_IFTYPE_STATION &&
-	    mvmvif->deflink.ap_sta_id == sta_id) {
+	if (vif->type == NL80211_IFTYPE_STATION) {
 		/* if associated - we can't remove the AP STA now */
 		if (vif->cfg.assoc)
 			return true;
@@ -2023,7 +2082,7 @@ int iwl_mvm_rm_sta(struct iwl_mvm *mvm,
 
 	iwl_mvm_disable_sta_queues(mvm, vif, sta);
 
-	if (iwl_mvm_sta_del(mvm, vif, sta, &ret))
+	if (iwl_mvm_sta_del(mvm, vif, sta, &mvm_sta->deflink, &ret))
 		return ret;
 
 	ret = iwl_mvm_rm_sta_common(mvm, mvm_sta->deflink.sta_id);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.h b/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
index 7148263dddf8..6d4db666368b 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
@@ -490,7 +490,8 @@ void iwl_mvm_realloc_queues_after_restart(struct iwl_mvm *mvm,
 int iwl_mvm_wait_sta_queues_empty(struct iwl_mvm *mvm,
 				  struct iwl_mvm_sta *mvm_sta);
 bool iwl_mvm_sta_del(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
-		     struct ieee80211_sta *sta, int *ret);
+		     struct ieee80211_sta *sta,
+		     struct iwl_mvm_link_sta *mvm_link_sta, int *ret);
 int iwl_mvm_rm_sta(struct iwl_mvm *mvm,
 		   struct ieee80211_vif *vif,
 		   struct ieee80211_sta *sta);
-- 
2.38.1

