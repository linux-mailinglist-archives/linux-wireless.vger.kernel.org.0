Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9011072F9A6
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Jun 2023 11:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244203AbjFNJpi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 14 Jun 2023 05:45:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244221AbjFNJoc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 14 Jun 2023 05:44:32 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9FEC26B8
        for <linux-wireless@vger.kernel.org>; Wed, 14 Jun 2023 02:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686735782; x=1718271782;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Jkk+GssInuZUr1FJvjokxzrT+u0/1qGBthobuOJqzUM=;
  b=hJNjHiwSuvyw1Gf6LHH5KFIp8tf2qnXnTzKMA6QybwTtuCGhGBalEns5
   QNOkfu9nepTs3yxscARy2hrNNp7Q16SPQxJLCoQIpRosbp5h6LBipB+sl
   opkSsgXXFl5awMmqGsmtH8YnXHbIU7C9OjeTfVkAdzbK2YMxGgd4D1vu5
   kpj+7gJVEzbHi9hPfDqAnBYXf099x/qsKfY0wYxIAU63l30hcc3PO+K7s
   SqQnoBmZdZ6BEhQHo8XvnqndjFBnORub56aFe+N75ks5lbWRTN8d2BZ07
   5c7w/I2Oa6AGzmDB90uC4ukpRF/qRisq2lYalRGKLnjBpSoEdwTCTWjLI
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="361049798"
X-IronPort-AV: E=Sophos;i="6.00,242,1681196400"; 
   d="scan'208";a="361049798"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 02:41:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="711989774"
X-IronPort-AV: E=Sophos;i="6.00,242,1681196400"; 
   d="scan'208";a="711989774"
Received: from basharil-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.203.45])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 02:41:55 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 01/20] wifi: iwlwifi: mvm: correctly access HE/EHT sband capa
Date:   Wed, 14 Jun 2023 12:41:18 +0300
Message-Id: <20230614123446.a1f2b17ee39b.I8808120be744be8804815ce9e3e24ce6d2b424e3@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230614094137.379897-1-gregory.greenman@intel.com>
References: <20230614094137.379897-1-gregory.greenman@intel.com>
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

We can't just dereference the sband->iftype_data pointer,
that's an array so we need to access the right entry. Use
the previously introduced helper functions to do that.

There are also cases, e.g. when loading with disable_11ax=1,
where the pointer might be NULL but we still attempt to use
it, causing a crash.

Fixes: 529281bdf0fc ("iwlwifi: mvm: limit TLC according to our HE capabilities")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 .../net/wireless/intel/iwlwifi/mvm/rs-fw.c    | 46 +++++++++++--------
 1 file changed, 26 insertions(+), 20 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
index 782d53d15a1b..8f06ea015043 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
@@ -63,12 +63,11 @@ static u8 rs_fw_sgi_cw_support(struct ieee80211_link_sta *link_sta)
 static u16 rs_fw_get_config_flags(struct iwl_mvm *mvm,
 				  struct ieee80211_vif *vif,
 				  struct ieee80211_link_sta *link_sta,
-				  struct ieee80211_supported_band *sband)
+				  const struct ieee80211_sta_he_cap *sband_he_cap)
 {
 	struct ieee80211_sta_ht_cap *ht_cap = &link_sta->ht_cap;
 	struct ieee80211_sta_vht_cap *vht_cap = &link_sta->vht_cap;
 	struct ieee80211_sta_he_cap *he_cap = &link_sta->he_cap;
-	const struct ieee80211_sta_he_cap *sband_he_cap;
 	bool vht_ena = vht_cap->vht_supported;
 	u16 flags = 0;
 
@@ -94,7 +93,6 @@ static u16 rs_fw_get_config_flags(struct iwl_mvm *mvm,
 	    IEEE80211_HE_PHY_CAP1_LDPC_CODING_IN_PAYLOAD))
 		flags |= IWL_TLC_MNG_CFG_FLAGS_LDPC_MSK;
 
-	sband_he_cap = ieee80211_get_he_iftype_cap_vif(sband, vif);
 	if (sband_he_cap &&
 	    !(sband_he_cap->he_cap_elem.phy_cap_info[1] &
 			IEEE80211_HE_PHY_CAP1_LDPC_CODING_IN_PAYLOAD))
@@ -196,16 +194,14 @@ static u16 rs_fw_he_ieee80211_mcs_to_rs_mcs(u16 mcs)
 
 static void
 rs_fw_he_set_enabled_rates(const struct ieee80211_link_sta *link_sta,
-			   struct ieee80211_supported_band *sband,
+			   const struct ieee80211_sta_he_cap *sband_he_cap,
 			   struct iwl_tlc_config_cmd_v4 *cmd)
 {
 	const struct ieee80211_sta_he_cap *he_cap = &link_sta->he_cap;
 	u16 mcs_160 = le16_to_cpu(he_cap->he_mcs_nss_supp.rx_mcs_160);
 	u16 mcs_80 = le16_to_cpu(he_cap->he_mcs_nss_supp.rx_mcs_80);
-	u16 tx_mcs_80 =
-		le16_to_cpu(sband->iftype_data->he_cap.he_mcs_nss_supp.tx_mcs_80);
-	u16 tx_mcs_160 =
-		le16_to_cpu(sband->iftype_data->he_cap.he_mcs_nss_supp.tx_mcs_160);
+	u16 tx_mcs_80 = le16_to_cpu(sband_he_cap->he_mcs_nss_supp.tx_mcs_80);
+	u16 tx_mcs_160 = le16_to_cpu(sband_he_cap->he_mcs_nss_supp.tx_mcs_160);
 	int i;
 	u8 nss = link_sta->rx_nss;
 
@@ -288,7 +284,8 @@ rs_fw_rs_mcs2eht_mcs(enum IWL_TLC_MCS_PER_BW bw,
 static void
 rs_fw_eht_set_enabled_rates(struct ieee80211_vif *vif,
 			    const struct ieee80211_link_sta *link_sta,
-			    struct ieee80211_supported_band *sband,
+			    const struct ieee80211_sta_he_cap *sband_he_cap,
+			    const struct ieee80211_sta_eht_cap *sband_eht_cap,
 			    struct iwl_tlc_config_cmd_v4 *cmd)
 {
 	/* peer RX mcs capa */
@@ -296,7 +293,7 @@ rs_fw_eht_set_enabled_rates(struct ieee80211_vif *vif,
 		&link_sta->eht_cap.eht_mcs_nss_supp;
 	/* our TX mcs capa */
 	const struct ieee80211_eht_mcs_nss_supp *eht_tx_mcs =
-		&sband->iftype_data->eht_cap.eht_mcs_nss_supp;
+		&sband_eht_cap->eht_mcs_nss_supp;
 
 	enum IWL_TLC_MCS_PER_BW bw;
 	struct ieee80211_eht_mcs_nss_supp_20mhz_only mcs_rx_20;
@@ -315,7 +312,7 @@ rs_fw_eht_set_enabled_rates(struct ieee80211_vif *vif,
 	}
 
 	/* nic is 20Mhz only */
-	if (!(sband->iftype_data->he_cap.he_cap_elem.phy_cap_info[0] &
+	if (!(sband_he_cap->he_cap_elem.phy_cap_info[0] &
 	      IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_MASK_ALL)) {
 		mcs_tx_20 = eht_tx_mcs->only_20mhz;
 	} else {
@@ -369,6 +366,8 @@ rs_fw_eht_set_enabled_rates(struct ieee80211_vif *vif,
 static void rs_fw_set_supp_rates(struct ieee80211_vif *vif,
 				 struct ieee80211_link_sta *link_sta,
 				 struct ieee80211_supported_band *sband,
+				 const struct ieee80211_sta_he_cap *sband_he_cap,
+				 const struct ieee80211_sta_eht_cap *sband_eht_cap,
 				 struct iwl_tlc_config_cmd_v4 *cmd)
 {
 	int i;
@@ -387,12 +386,13 @@ static void rs_fw_set_supp_rates(struct ieee80211_vif *vif,
 	cmd->mode = IWL_TLC_MNG_MODE_NON_HT;
 
 	/* HT/VHT rates */
-	if (link_sta->eht_cap.has_eht) {
+	if (link_sta->eht_cap.has_eht && sband_he_cap && sband_eht_cap) {
 		cmd->mode = IWL_TLC_MNG_MODE_EHT;
-		rs_fw_eht_set_enabled_rates(vif, link_sta, sband, cmd);
-	} else if (he_cap->has_he) {
+		rs_fw_eht_set_enabled_rates(vif, link_sta, sband_he_cap,
+					    sband_eht_cap, cmd);
+	} else if (he_cap->has_he && sband_he_cap) {
 		cmd->mode = IWL_TLC_MNG_MODE_HE;
-		rs_fw_he_set_enabled_rates(link_sta, sband, cmd);
+		rs_fw_he_set_enabled_rates(link_sta, sband_he_cap, cmd);
 	} else if (vht_cap->vht_supported) {
 		cmd->mode = IWL_TLC_MNG_MODE_VHT;
 		rs_fw_vht_set_enabled_rates(link_sta, vht_cap, cmd);
@@ -575,13 +575,17 @@ void iwl_mvm_rs_fw_rate_init(struct iwl_mvm *mvm,
 	u32 cmd_id = WIDE_ID(DATA_PATH_GROUP, TLC_MNG_CONFIG_CMD);
 	struct ieee80211_supported_band *sband = hw->wiphy->bands[band];
 	u16 max_amsdu_len = rs_fw_get_max_amsdu_len(sta, link_conf, link_sta);
+	const struct ieee80211_sta_he_cap *sband_he_cap =
+		ieee80211_get_he_iftype_cap_vif(sband, vif);
+	const struct ieee80211_sta_eht_cap *sband_eht_cap =
+		ieee80211_get_eht_iftype_cap_vif(sband, vif);
 	struct iwl_mvm_link_sta *mvm_link_sta;
 	struct iwl_lq_sta_rs_fw *lq_sta;
 	struct iwl_tlc_config_cmd_v4 cfg_cmd = {
 		.max_ch_width = mvmsta->authorized ?
 			rs_fw_bw_from_sta_bw(link_sta) : IWL_TLC_MNG_CH_WIDTH_20MHZ,
 		.flags = cpu_to_le16(rs_fw_get_config_flags(mvm, vif, link_sta,
-							    sband)),
+							    sband_he_cap)),
 		.chains = rs_fw_set_active_chains(iwl_mvm_get_valid_tx_ant(mvm)),
 		.sgi_ch_width_supp = rs_fw_sgi_cw_support(link_sta),
 		.max_mpdu_len = iwl_mvm_is_csum_supported(mvm) ?
@@ -596,9 +600,9 @@ void iwl_mvm_rs_fw_rate_init(struct iwl_mvm *mvm,
 	 * mutual support by AP and client
 	 */
 	if (CSR_HW_REV_TYPE(mvm->trans->hw_rev) == IWL_CFG_MAC_TYPE_GL &&
-	    sband->iftype_data->eht_cap.has_eht &&
-	    sband->iftype_data->eht_cap.eht_cap_elem.phy_cap_info[5] &
-	    IEEE80211_EHT_PHY_CAP5_SUPP_EXTRA_EHT_LTF &&
+	    sband_eht_cap &&
+	    sband_eht_cap->eht_cap_elem.phy_cap_info[5] &
+		IEEE80211_EHT_PHY_CAP5_SUPP_EXTRA_EHT_LTF &&
 	    link_sta->eht_cap.has_eht &&
 	    link_sta->eht_cap.eht_cap_elem.phy_cap_info[5] &
 	    IEEE80211_EHT_PHY_CAP5_SUPP_EXTRA_EHT_LTF) {
@@ -624,7 +628,9 @@ void iwl_mvm_rs_fw_rate_init(struct iwl_mvm *mvm,
 #ifdef CONFIG_IWLWIFI_DEBUGFS
 	iwl_mvm_reset_frame_stats(mvm);
 #endif
-	rs_fw_set_supp_rates(vif, link_sta, sband, &cfg_cmd);
+	rs_fw_set_supp_rates(vif, link_sta, sband,
+			     sband_he_cap, sband_eht_cap,
+			     &cfg_cmd);
 
 	/*
 	 * since TLC offload works with one mode we can assume
-- 
2.38.1

