Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2177A6CD28C
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Mar 2023 09:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbjC2HHQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 29 Mar 2023 03:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbjC2HHM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 29 Mar 2023 03:07:12 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 015C640D3
        for <linux-wireless@vger.kernel.org>; Wed, 29 Mar 2023 00:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680073623; x=1711609623;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yfD6AbRCRk02VBHSaGFoboCA7d23EAzDujiWLsMcvNQ=;
  b=dG/ZyWTz0lLZW9CpOwVRqK0Pbc/rPPgli5LQ/1rdODf2m0Y89sQ5m+oh
   0IHBK1tYei6e35ZRo0J0LMGdEHCGRTAA6sup04Q7QtyEjQk0qq8n+AbZD
   a/eLMWj6cbT17QwWOXW3ksRF+mRSCQKsDJ4rHYCg8ARyIVpfWUikHGNf4
   kLo7boV114yxlVJKLjKNZs0LbNH93R1Gjl1N3GexpjiU6TdFJwsLsWbbw
   ll8usn+k6NFMGM2UnrxI2EiPpUysAarBDOx1fQjVOCztpKlLMHqSXtKjc
   IL65hhsyAeN7PtkjltkO5DzkSYcEFJdtZZlQC9OiV5yY5x+2ev1/I3LAU
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="320450788"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="320450788"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 00:06:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="795111287"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="795111287"
Received: from sfrank1-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.228.42])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 00:06:12 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 10/34] wifi: iwlwifi: mvm: adjust rs init to MLO
Date:   Wed, 29 Mar 2023 10:05:16 +0300
Message-Id: <20230329100039.e2f458198844.I98bf3ea807dd8ae8d703915ce9c01e7b7d5ccb42@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230329070540.2739372-1-gregory.greenman@intel.com>
References: <20230329070540.2739372-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Gregory Greenman <gregory.greenman@intel.com>

Rate scale initialization needs some parameters stored
separately for each link. Pass link_conf and link_sta
pointers and adjust the relevant code accordingly.

Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 36 +++++++++++++------
 .../net/wireless/intel/iwlwifi/mvm/rs-fw.c    | 36 +++++++++++++------
 drivers/net/wireless/intel/iwlwifi/mvm/rs.c   | 17 ++++++---
 drivers/net/wireless/intel/iwlwifi/mvm/rs.h   | 10 ++++--
 4 files changed, 71 insertions(+), 28 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 44542b00fa14..92567ab34b88 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -3557,15 +3557,28 @@ static int iwl_mvm_mac_sta_state(struct ieee80211_hw *hw,
  *	(2) if a link is valid in sta then it's valid in vif (can
  *	use same index in the link array)
  */
+static void iwl_mvm_rs_rate_init_all_links(struct iwl_mvm *mvm,
+					   struct ieee80211_vif *vif,
+					   struct ieee80211_sta *sta,
+					   bool update)
+{
+	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
+	unsigned int link_id;
 
-#define iwl_mvm_rs_rate_init_all_links(mvm, mvmvif, sta, update) do {		\
-	typeof(mvmvif) _mvmvif = mvmvif;					\
-	unsigned int _i;							\
-	for_each_mvm_vif_valid_link(_mvmvif, _i)				\
-		iwl_mvm_rs_rate_init((mvm), (sta),				\
-				     _mvmvif->link[_i]->phy_ctxt->channel->band,\
-				     (update));					\
-} while (0)
+	for_each_mvm_vif_valid_link(mvmvif, link_id) {
+		struct ieee80211_bss_conf *conf =
+			rcu_dereference_protected(vif->link_conf[link_id], 1);
+		struct ieee80211_link_sta *link_sta =
+			rcu_dereference_protected(sta->link[link_id], 1);
+
+		if (!conf || !link_sta || !mvmvif->link[link_id]->phy_ctxt)
+			continue;
+
+		iwl_mvm_rs_rate_init(mvm, sta, conf, link_sta,
+				     mvmvif->link[link_id]->phy_ctxt->channel->band,
+				     update);
+	}
+}
 
 #define IWL_MVM_MIN_BEACON_INTERVAL_TU 16
 
@@ -3729,7 +3742,7 @@ iwl_mvm_sta_state_auth_to_assoc(struct ieee80211_hw *hw,
 	}
 
 out:
-	iwl_mvm_rs_rate_init_all_links(mvm, mvmvif, sta, false);
+	iwl_mvm_rs_rate_init_all_links(mvm, vif, sta, false);
 
 	return callbacks->update_sta(mvm, vif, sta);
 }
@@ -3762,7 +3775,7 @@ iwl_mvm_sta_state_assoc_to_authorized(struct iwl_mvm *mvm,
 		iwl_mvm_mei_host_associated(mvm, vif, mvm_sta);
 	}
 
-	iwl_mvm_rs_rate_init_all_links(mvm, mvmvif, sta, true);
+	iwl_mvm_rs_rate_init_all_links(mvm, vif, sta, true);
 
 	return 0;
 }
@@ -3781,7 +3794,7 @@ iwl_mvm_sta_state_authorized_to_assoc(struct iwl_mvm *mvm,
 	/* once we move into assoc state, need to update rate scale to
 	 * disable using wide bandwidth
 	 */
-	iwl_mvm_rs_rate_init_all_links(mvm, mvmvif, sta, false);
+	iwl_mvm_rs_rate_init_all_links(mvm, vif, sta, false);
 
 	if (!sta->tdls) {
 		/* Set this but don't call iwl_mvm_mac_ctxt_changed()
@@ -3950,6 +3963,7 @@ void iwl_mvm_sta_rc_update(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		       IEEE80211_RC_SUPP_RATES_CHANGED |
 		       IEEE80211_RC_NSS_CHANGED))
 		iwl_mvm_rs_rate_init(mvm, sta,
+				     &vif->bss_conf, &sta->deflink,
 				     mvmvif->deflink.phy_ctxt->channel->band,
 				     true);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
index ed4200d9bd04..d1a308a451cc 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
@@ -500,16 +500,17 @@ void iwl_mvm_tlc_update_notif(struct iwl_mvm *mvm,
 	rcu_read_unlock();
 }
 
-u16 rs_fw_get_max_amsdu_len(struct ieee80211_sta *sta)
+u16 rs_fw_get_max_amsdu_len(struct ieee80211_sta *sta,
+			    struct ieee80211_bss_conf *link_conf,
+			    struct ieee80211_link_sta *link_sta)
 {
-	struct iwl_mvm_sta *mvmsta = iwl_mvm_sta_from_mac80211(sta);
-	const struct ieee80211_sta_vht_cap *vht_cap = &sta->deflink.vht_cap;
-	const struct ieee80211_sta_ht_cap *ht_cap = &sta->deflink.ht_cap;
+	const struct ieee80211_sta_vht_cap *vht_cap = &link_sta->vht_cap;
+	const struct ieee80211_sta_ht_cap *ht_cap = &link_sta->ht_cap;
 
-	if (WARN_ON_ONCE(!mvmsta->vif->bss_conf.chandef.chan))
+	if (WARN_ON_ONCE(!link_conf->chandef.chan))
 		return IEEE80211_MAX_MPDU_LEN_VHT_3895;
 
-	if (mvmsta->vif->bss_conf.chandef.chan->band == NL80211_BAND_6GHZ) {
+	if (link_conf->chandef.chan->band == NL80211_BAND_6GHZ) {
 		switch (le16_get_bits(sta->deflink.he_6ghz_capa.capa,
 				      IEEE80211_HE_6GHZ_CAP_MAX_MPDU_LEN)) {
 		case IEEE80211_VHT_CAP_MAX_MPDU_LENGTH_11454:
@@ -546,16 +547,18 @@ u16 rs_fw_get_max_amsdu_len(struct ieee80211_sta *sta)
 }
 
 void rs_fw_rate_init(struct iwl_mvm *mvm, struct ieee80211_sta *sta,
+		     struct ieee80211_bss_conf *link_conf,
+		     struct ieee80211_link_sta *link_sta,
 		     enum nl80211_band band, bool update)
 {
 	struct ieee80211_hw *hw = mvm->hw;
 	struct iwl_mvm_sta *mvmsta = iwl_mvm_sta_from_mac80211(sta);
-	struct iwl_lq_sta_rs_fw *lq_sta = &mvmsta->deflink.lq_sta.rs_fw;
 	u32 cmd_id = WIDE_ID(DATA_PATH_GROUP, TLC_MNG_CONFIG_CMD);
 	struct ieee80211_supported_band *sband = hw->wiphy->bands[band];
-	u16 max_amsdu_len = rs_fw_get_max_amsdu_len(sta);
+	u16 max_amsdu_len = rs_fw_get_max_amsdu_len(sta, link_conf, link_sta);
+	struct iwl_mvm_link_sta *mvm_link_sta;
+	struct iwl_lq_sta_rs_fw *lq_sta;
 	struct iwl_tlc_config_cmd_v4 cfg_cmd = {
-		.sta_id = mvmsta->deflink.sta_id,
 		.max_ch_width = update ?
 			rs_fw_bw_from_sta_bw(sta) : IWL_TLC_MNG_CH_WIDTH_20MHZ,
 		.flags = cpu_to_le16(rs_fw_get_config_flags(mvm, sta, sband)),
@@ -564,11 +567,24 @@ void rs_fw_rate_init(struct iwl_mvm *mvm, struct ieee80211_sta *sta,
 		.max_mpdu_len = iwl_mvm_is_csum_supported(mvm) ?
 				cpu_to_le16(max_amsdu_len) : 0,
 	};
-	int ret;
+	unsigned int link_id = link_conf->link_id;
 	int cmd_ver;
+	int ret;
 
+	rcu_read_lock();
+	mvm_link_sta = rcu_dereference(mvmsta->link[link_id]);
+	if (WARN_ON_ONCE(!mvm_link_sta)) {
+		rcu_read_unlock();
+		return;
+	}
+
+	cfg_cmd.sta_id = mvm_link_sta->sta_id;
+
+	lq_sta = &mvm_link_sta->lq_sta.rs_fw;
 	memset(lq_sta, 0, offsetof(typeof(*lq_sta), pers));
 
+	rcu_read_unlock();
+
 #ifdef CONFIG_IWLWIFI_DEBUGFS
 	iwl_mvm_reset_frame_stats(mvm);
 #endif
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rs.c b/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
index 1b0e99377156..161a32929848 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
@@ -1487,9 +1487,11 @@ static void rs_set_amsdu_len(struct iwl_mvm *mvm, struct ieee80211_sta *sta,
 			     enum rs_action scale_action)
 {
 	struct iwl_mvm_sta *mvmsta = iwl_mvm_sta_from_mac80211(sta);
+	struct ieee80211_bss_conf *bss_conf = &mvmsta->vif->bss_conf;
 	int i;
 
-	sta->deflink.agg.max_amsdu_len = rs_fw_get_max_amsdu_len(sta);
+	sta->deflink.agg.max_amsdu_len =
+		rs_fw_get_max_amsdu_len(sta, bss_conf, &sta->deflink);
 
 	/*
 	 * In case TLC offload is not active amsdu_enabled is either 0xFFFF
@@ -1502,7 +1504,7 @@ static void rs_set_amsdu_len(struct iwl_mvm *mvm, struct ieee80211_sta *sta,
 	else
 		mvmsta->amsdu_enabled = 0xFFFF;
 
-	if (mvmsta->vif->bss_conf.he_support &&
+	if (bss_conf->he_support &&
 	    !iwlwifi_mod_params.disable_11ax)
 		mvmsta->max_amsdu_len = sta->deflink.agg.max_amsdu_len;
 	else
@@ -3002,17 +3004,20 @@ static void rs_drv_rate_update(void *mvm_r,
 			       void *priv_sta, u32 changed)
 {
 	struct iwl_op_mode *op_mode = mvm_r;
+	struct iwl_mvm_sta *mvmsta = iwl_mvm_sta_from_mac80211(sta);
 	struct iwl_mvm *mvm __maybe_unused = IWL_OP_MODE_GET_MVM(op_mode);
 	u8 tid;
 
-	if (!iwl_mvm_sta_from_mac80211(sta)->vif)
+	if (!mvmsta->vif)
 		return;
 
 	/* Stop any ongoing aggregations as rs starts off assuming no agg */
 	for (tid = 0; tid < IWL_MAX_TID_COUNT; tid++)
 		ieee80211_stop_tx_ba_session(sta, tid);
 
-	iwl_mvm_rs_rate_init(mvm, sta, sband->band, true);
+	iwl_mvm_rs_rate_init(mvm, sta,
+			     &mvmsta->vif->bss_conf, &sta->deflink,
+			     sband->band, true);
 }
 
 static void __iwl_mvm_rs_tx_status(struct iwl_mvm *mvm,
@@ -4097,10 +4102,12 @@ static const struct rate_control_ops rs_mvm_ops_drv = {
 };
 
 void iwl_mvm_rs_rate_init(struct iwl_mvm *mvm, struct ieee80211_sta *sta,
+			  struct ieee80211_bss_conf *link_conf,
+			  struct ieee80211_link_sta *link_sta,
 			  enum nl80211_band band, bool update)
 {
 	if (iwl_mvm_has_tlc_offload(mvm)) {
-		rs_fw_rate_init(mvm, sta, band, update);
+		rs_fw_rate_init(mvm, sta, link_conf, link_sta, band, update);
 	} else {
 		struct iwl_mvm_sta *mvmsta = iwl_mvm_sta_from_mac80211(sta);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rs.h b/drivers/net/wireless/intel/iwlwifi/mvm/rs.h
index b7bc8c1b2dda..c3145cb8f354 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rs.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rs.h
@@ -393,7 +393,9 @@ struct iwl_lq_sta {
 
 /* Initialize station's rate scaling information after adding station */
 void iwl_mvm_rs_rate_init(struct iwl_mvm *mvm, struct ieee80211_sta *sta,
-			  enum nl80211_band band, bool init);
+			  struct ieee80211_bss_conf *link_conf,
+			  struct ieee80211_link_sta *link_sta,
+			  enum nl80211_band band, bool update);
 
 /* Notify RS about Tx status */
 void iwl_mvm_rs_tx_status(struct iwl_mvm *mvm, struct ieee80211_sta *sta,
@@ -430,11 +432,15 @@ void iwl_mvm_reset_frame_stats(struct iwl_mvm *mvm);
 
 void iwl_mvm_rs_add_sta(struct iwl_mvm *mvm, struct iwl_mvm_sta *mvmsta);
 void rs_fw_rate_init(struct iwl_mvm *mvm, struct ieee80211_sta *sta,
+		     struct ieee80211_bss_conf *link_conf,
+		     struct ieee80211_link_sta *link_sta,
 		     enum nl80211_band band, bool update);
 int rs_fw_tx_protection(struct iwl_mvm *mvm, struct iwl_mvm_sta *mvmsta,
 			bool enable);
 void iwl_mvm_tlc_update_notif(struct iwl_mvm *mvm,
 			      struct iwl_rx_cmd_buffer *rxb);
 
-u16 rs_fw_get_max_amsdu_len(struct ieee80211_sta *sta);
+u16 rs_fw_get_max_amsdu_len(struct ieee80211_sta *sta,
+			    struct ieee80211_bss_conf *link_conf,
+			    struct ieee80211_link_sta *link_sta);
 #endif /* __rs__ */
-- 
2.38.1

