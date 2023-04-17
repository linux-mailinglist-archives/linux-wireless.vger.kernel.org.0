Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F7BC6E42CB
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Apr 2023 10:42:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbjDQImQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 17 Apr 2023 04:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbjDQImL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 17 Apr 2023 04:42:11 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06F3D10E4
        for <linux-wireless@vger.kernel.org>; Mon, 17 Apr 2023 01:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681720929; x=1713256929;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zRdwB9YZfeUdZTSK9enP5lbNgWwvqlVrJQX2VM3tSTY=;
  b=nLuS4SwQsJPF3FNQijNPYfM3WTDzqJR+Ti0nBvrNMv8MXQcPGprtpERv
   Bvokg1D62rTw1RsvMyjLEA44qZqXwilQGmNZNq1I4hr4HBY6CEMgTXvVD
   fSCWz/qYyF17zoIyVPD3c4/iXY//++Lr28n0gLuLz18gxBv0xJHjPkK/L
   SWttwGDKgGnLo5k4hJTBTla3I0PVOroF6TqkeLTaBcVkh6UnVkFQJamYS
   ANNP8Fg4d+5UUlgbEe2yoVwEXytN1Fg/q4cIymskRSlT4VKfWF03OIaSx
   Co0wK7A79eqJFkA08jDTCvDxINV0Eyg6f3dlf7nqKJgr0+Glo60GvwRDZ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10682"; a="333634365"
X-IronPort-AV: E=Sophos;i="5.99,203,1677571200"; 
   d="scan'208";a="333634365"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2023 01:42:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10682"; a="693173846"
X-IronPort-AV: E=Sophos;i="5.99,203,1677571200"; 
   d="scan'208";a="693173846"
Received: from odotan1x-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.202.32])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2023 01:42:05 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 07/15] wifi: iwlwifi: mvm: only clients can be 20MHz-only
Date:   Mon, 17 Apr 2023 11:41:26 +0300
Message-Id: <20230417113648.a3a4c931e4a3.I693a07f4d88044c889eee04793883a83bc5ee362@changeid>
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

Since only clients to an AP can be 20MHz-only STAs, adjust the
code to not make the use of EHT capabilities depend on only the
bandwidth, but also the type of interface.

Fixes: 701404f1091d ("wifi: iwlwifi: rs: add support for parsing max MCS per NSS/BW in 11be")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c   |  2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c  | 17 +++++++++++------
 drivers/net/wireless/intel/iwlwifi/mvm/rs.c     |  9 ++++++---
 drivers/net/wireless/intel/iwlwifi/mvm/rs.h     |  8 ++++++--
 4 files changed, 24 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 9d5d2c6625a9..8808bb3983a4 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -3592,7 +3592,7 @@ static void iwl_mvm_rs_rate_init_all_links(struct iwl_mvm *mvm,
 		if (!conf || !link_sta || !mvmvif->link[link_id]->phy_ctxt)
 			continue;
 
-		iwl_mvm_rs_rate_init(mvm, sta, conf, link_sta,
+		iwl_mvm_rs_rate_init(mvm, vif, sta, conf, link_sta,
 				     mvmvif->link[link_id]->phy_ctxt->channel->band,
 				     update);
 	}
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
index c8ba2fe3e4a2..43d26a09cfce 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
@@ -283,7 +283,8 @@ rs_fw_rs_mcs2eht_mcs(enum IWL_TLC_MCS_PER_BW bw,
 }
 
 static void
-rs_fw_eht_set_enabled_rates(const struct ieee80211_link_sta *link_sta,
+rs_fw_eht_set_enabled_rates(struct ieee80211_vif *vif,
+			    const struct ieee80211_link_sta *link_sta,
 			    struct ieee80211_supported_band *sband,
 			    struct iwl_tlc_config_cmd_v4 *cmd)
 {
@@ -299,7 +300,8 @@ rs_fw_eht_set_enabled_rates(const struct ieee80211_link_sta *link_sta,
 	struct ieee80211_eht_mcs_nss_supp_20mhz_only mcs_tx_20;
 
 	/* peer is 20Mhz only */
-	if (!(link_sta->he_cap.he_cap_elem.phy_cap_info[0] &
+	if (vif->type == NL80211_IFTYPE_AP &&
+	    !(link_sta->he_cap.he_cap_elem.phy_cap_info[0] &
 	      IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_MASK_ALL)) {
 		mcs_rx_20 = eht_rx_mcs->only_20mhz;
 	} else {
@@ -361,7 +363,8 @@ rs_fw_eht_set_enabled_rates(const struct ieee80211_link_sta *link_sta,
 		       sizeof(cmd->ht_rates[IWL_TLC_NSS_2]));
 }
 
-static void rs_fw_set_supp_rates(struct ieee80211_link_sta *link_sta,
+static void rs_fw_set_supp_rates(struct ieee80211_vif *vif,
+				 struct ieee80211_link_sta *link_sta,
 				 struct ieee80211_supported_band *sband,
 				 struct iwl_tlc_config_cmd_v4 *cmd)
 {
@@ -383,7 +386,7 @@ static void rs_fw_set_supp_rates(struct ieee80211_link_sta *link_sta,
 	/* HT/VHT rates */
 	if (link_sta->eht_cap.has_eht) {
 		cmd->mode = IWL_TLC_MNG_MODE_EHT;
-		rs_fw_eht_set_enabled_rates(link_sta, sband, cmd);
+		rs_fw_eht_set_enabled_rates(vif, link_sta, sband, cmd);
 	} else if (he_cap->has_he) {
 		cmd->mode = IWL_TLC_MNG_MODE_HE;
 		rs_fw_he_set_enabled_rates(link_sta, sband, cmd);
@@ -557,7 +560,9 @@ u16 rs_fw_get_max_amsdu_len(struct ieee80211_sta *sta,
 	return 0;
 }
 
-void rs_fw_rate_init(struct iwl_mvm *mvm, struct ieee80211_sta *sta,
+void rs_fw_rate_init(struct iwl_mvm *mvm,
+		     struct ieee80211_vif *vif,
+		     struct ieee80211_sta *sta,
 		     struct ieee80211_bss_conf *link_conf,
 		     struct ieee80211_link_sta *link_sta,
 		     enum nl80211_band band, bool update)
@@ -601,7 +606,7 @@ void rs_fw_rate_init(struct iwl_mvm *mvm, struct ieee80211_sta *sta,
 #ifdef CONFIG_IWLWIFI_DEBUGFS
 	iwl_mvm_reset_frame_stats(mvm);
 #endif
-	rs_fw_set_supp_rates(link_sta, sband, &cfg_cmd);
+	rs_fw_set_supp_rates(vif, link_sta, sband, &cfg_cmd);
 
 	/*
 	 * since TLC offload works with one mode we can assume
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rs.c b/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
index ab82965bc0f4..020de09b13f2 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
@@ -3015,7 +3015,7 @@ static void rs_drv_rate_update(void *mvm_r,
 	for (tid = 0; tid < IWL_MAX_TID_COUNT; tid++)
 		ieee80211_stop_tx_ba_session(sta, tid);
 
-	iwl_mvm_rs_rate_init(mvm, sta,
+	iwl_mvm_rs_rate_init(mvm, mvmsta->vif, sta,
 			     &mvmsta->vif->bss_conf, &sta->deflink,
 			     sband->band, true);
 }
@@ -4101,13 +4101,16 @@ static const struct rate_control_ops rs_mvm_ops_drv = {
 	.capa = RATE_CTRL_CAPA_VHT_EXT_NSS_BW,
 };
 
-void iwl_mvm_rs_rate_init(struct iwl_mvm *mvm, struct ieee80211_sta *sta,
+void iwl_mvm_rs_rate_init(struct iwl_mvm *mvm,
+			  struct ieee80211_vif *vif,
+			  struct ieee80211_sta *sta,
 			  struct ieee80211_bss_conf *link_conf,
 			  struct ieee80211_link_sta *link_sta,
 			  enum nl80211_band band, bool update)
 {
 	if (iwl_mvm_has_tlc_offload(mvm)) {
-		rs_fw_rate_init(mvm, sta, link_conf, link_sta, band, update);
+		rs_fw_rate_init(mvm, vif, sta, link_conf,
+				link_sta, band, update);
 	} else {
 		struct iwl_mvm_sta *mvmsta = iwl_mvm_sta_from_mac80211(sta);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rs.h b/drivers/net/wireless/intel/iwlwifi/mvm/rs.h
index f99603b0f693..bbc05c3f13bf 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rs.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rs.h
@@ -394,7 +394,9 @@ struct iwl_lq_sta {
 				   ((_c) << RS_DRV_DATA_LQ_COLOR_POS)))
 
 /* Initialize station's rate scaling information after adding station */
-void iwl_mvm_rs_rate_init(struct iwl_mvm *mvm, struct ieee80211_sta *sta,
+void iwl_mvm_rs_rate_init(struct iwl_mvm *mvm,
+			  struct ieee80211_vif *vif,
+			  struct ieee80211_sta *sta,
 			  struct ieee80211_bss_conf *link_conf,
 			  struct ieee80211_link_sta *link_sta,
 			  enum nl80211_band band, bool update);
@@ -433,7 +435,9 @@ void iwl_mvm_reset_frame_stats(struct iwl_mvm *mvm);
 #endif
 
 void iwl_mvm_rs_add_sta(struct iwl_mvm *mvm, struct iwl_mvm_sta *mvmsta);
-void rs_fw_rate_init(struct iwl_mvm *mvm, struct ieee80211_sta *sta,
+void rs_fw_rate_init(struct iwl_mvm *mvm,
+		     struct ieee80211_vif *vif,
+		     struct ieee80211_sta *sta,
 		     struct ieee80211_bss_conf *link_conf,
 		     struct ieee80211_link_sta *link_sta,
 		     enum nl80211_band band, bool update);
-- 
2.38.1

