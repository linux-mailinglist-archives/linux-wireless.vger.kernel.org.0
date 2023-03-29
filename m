Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87C5E6CD298
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Mar 2023 09:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbjC2HIK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 29 Mar 2023 03:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjC2HII (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 29 Mar 2023 03:08:08 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BBE330F1
        for <linux-wireless@vger.kernel.org>; Wed, 29 Mar 2023 00:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680073670; x=1711609670;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qmKGELNy5Tj0glkrxNMNgOC2K+7zPgmZEibrJNMDlUE=;
  b=X9tTYRiAKv4V0yXgREoFbHj+xJdBr78NxiRcu7Uu80KKrtDf6o0sLds/
   b7vnk89m+Sq97GmvYFOxFRk03tiLHtqSiLlXEhGRS8LOOxFdnF23TmjWF
   4THh0ArQPepQUGwAaYHwPVCSmX9Rv99NQ8rIC9suIJD6/wGvdfndi9Mol
   6du5OPyHYbmEDpXJK636pEDoXNTcLebn9Sc2O7jT5ywKkkvrSKI1ZeCDG
   DI18w2UD1S/r/BGqq0LQk77WbG7Ia3v6WjDKtMU9D+jTzauhkBoNftLEJ
   vkGK+3CN88Trm+QZM2fBfo1PjPAukzdVSSvYmKSiKx5kgiAByf7k7Zl3R
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="320450892"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="320450892"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 00:06:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="795111378"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="795111378"
Received: from sfrank1-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.228.42])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 00:06:36 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Benjamin Berg <benjamin.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 22/34] wifi: iwlwifi: mvm: use appropriate link for rate selection
Date:   Wed, 29 Mar 2023 10:05:28 +0300
Message-Id: <20230329100039.fa1025502fb4.Iaba0c64740fdcf04a521e2f213bd3f3e27862472@changeid>
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

From: Benjamin Berg <benjamin.berg@intel.com>

We were still using the deflink in most cases, update the code to use
the appropriate link.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 .../net/wireless/intel/iwlwifi/mvm/rs-fw.c    | 109 ++++++++++--------
 1 file changed, 61 insertions(+), 48 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
index d1a308a451cc..c8ba2fe3e4a2 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
@@ -9,9 +9,9 @@
 #include "iwl-op-mode.h"
 #include "mvm.h"
 
-static u8 rs_fw_bw_from_sta_bw(const struct ieee80211_sta *sta)
+static u8 rs_fw_bw_from_sta_bw(const struct ieee80211_link_sta *link_sta)
 {
-	switch (sta->deflink.bandwidth) {
+	switch (link_sta->bandwidth) {
 	case IEEE80211_STA_RX_BW_320:
 		return IWL_TLC_MNG_CH_WIDTH_320MHZ;
 	case IEEE80211_STA_RX_BW_160:
@@ -38,11 +38,11 @@ static u8 rs_fw_set_active_chains(u8 chains)
 	return fw_chains;
 }
 
-static u8 rs_fw_sgi_cw_support(struct ieee80211_sta *sta)
+static u8 rs_fw_sgi_cw_support(struct ieee80211_link_sta *link_sta)
 {
-	struct ieee80211_sta_ht_cap *ht_cap = &sta->deflink.ht_cap;
-	struct ieee80211_sta_vht_cap *vht_cap = &sta->deflink.vht_cap;
-	struct ieee80211_sta_he_cap *he_cap = &sta->deflink.he_cap;
+	struct ieee80211_sta_ht_cap *ht_cap = &link_sta->ht_cap;
+	struct ieee80211_sta_vht_cap *vht_cap = &link_sta->vht_cap;
+	struct ieee80211_sta_he_cap *he_cap = &link_sta->he_cap;
 	u8 supp = 0;
 
 	if (he_cap->has_he)
@@ -61,12 +61,12 @@ static u8 rs_fw_sgi_cw_support(struct ieee80211_sta *sta)
 }
 
 static u16 rs_fw_get_config_flags(struct iwl_mvm *mvm,
-				  struct ieee80211_sta *sta,
+				  struct ieee80211_link_sta *link_sta,
 				  struct ieee80211_supported_band *sband)
 {
-	struct ieee80211_sta_ht_cap *ht_cap = &sta->deflink.ht_cap;
-	struct ieee80211_sta_vht_cap *vht_cap = &sta->deflink.vht_cap;
-	struct ieee80211_sta_he_cap *he_cap = &sta->deflink.he_cap;
+	struct ieee80211_sta_ht_cap *ht_cap = &link_sta->ht_cap;
+	struct ieee80211_sta_vht_cap *vht_cap = &link_sta->vht_cap;
+	struct ieee80211_sta_he_cap *he_cap = &link_sta->he_cap;
 	bool vht_ena = vht_cap->vht_supported;
 	u16 flags = 0;
 
@@ -132,20 +132,20 @@ int rs_fw_vht_highest_rx_mcs_index(const struct ieee80211_sta_vht_cap *vht_cap,
 }
 
 static void
-rs_fw_vht_set_enabled_rates(const struct ieee80211_sta *sta,
+rs_fw_vht_set_enabled_rates(const struct ieee80211_link_sta *link_sta,
 			    const struct ieee80211_sta_vht_cap *vht_cap,
 			    struct iwl_tlc_config_cmd_v4 *cmd)
 {
 	u16 supp;
 	int i, highest_mcs;
-	u8 max_nss = sta->deflink.rx_nss;
+	u8 max_nss = link_sta->rx_nss;
 	struct ieee80211_vht_cap ieee_vht_cap = {
 		.vht_cap_info = cpu_to_le32(vht_cap->cap),
 		.supp_mcs = vht_cap->vht_mcs,
 	};
 
 	/* the station support only a single receive chain */
-	if (sta->deflink.smps_mode == IEEE80211_SMPS_STATIC)
+	if (link_sta->smps_mode == IEEE80211_SMPS_STATIC)
 		max_nss = 1;
 
 	for (i = 0; i < max_nss && i < IWL_TLC_NSS_MAX; i++) {
@@ -156,7 +156,7 @@ rs_fw_vht_set_enabled_rates(const struct ieee80211_sta *sta,
 			continue;
 
 		supp = BIT(highest_mcs + 1) - 1;
-		if (sta->deflink.bandwidth == IEEE80211_STA_RX_BW_20)
+		if (link_sta->bandwidth == IEEE80211_STA_RX_BW_20)
 			supp &= ~BIT(IWL_TLC_MNG_HT_RATE_MCS9);
 
 		cmd->ht_rates[i][IWL_TLC_MCS_PER_BW_80] = cpu_to_le16(supp);
@@ -165,7 +165,7 @@ rs_fw_vht_set_enabled_rates(const struct ieee80211_sta *sta,
 		 * configuration is supported - only for MCS 0 since we already
 		 * decoded the MCS bits anyway ourselves.
 		 */
-		if (sta->deflink.bandwidth == IEEE80211_STA_RX_BW_160 &&
+		if (link_sta->bandwidth == IEEE80211_STA_RX_BW_160 &&
 		    ieee80211_get_vht_max_nss(&ieee_vht_cap,
 					      IEEE80211_VHT_CHANWIDTH_160MHZ,
 					      0, true, nss) >= nss)
@@ -192,11 +192,11 @@ static u16 rs_fw_he_ieee80211_mcs_to_rs_mcs(u16 mcs)
 }
 
 static void
-rs_fw_he_set_enabled_rates(const struct ieee80211_sta *sta,
+rs_fw_he_set_enabled_rates(const struct ieee80211_link_sta *link_sta,
 			   struct ieee80211_supported_band *sband,
 			   struct iwl_tlc_config_cmd_v4 *cmd)
 {
-	const struct ieee80211_sta_he_cap *he_cap = &sta->deflink.he_cap;
+	const struct ieee80211_sta_he_cap *he_cap = &link_sta->he_cap;
 	u16 mcs_160 = le16_to_cpu(he_cap->he_mcs_nss_supp.rx_mcs_160);
 	u16 mcs_80 = le16_to_cpu(he_cap->he_mcs_nss_supp.rx_mcs_80);
 	u16 tx_mcs_80 =
@@ -204,10 +204,10 @@ rs_fw_he_set_enabled_rates(const struct ieee80211_sta *sta,
 	u16 tx_mcs_160 =
 		le16_to_cpu(sband->iftype_data->he_cap.he_mcs_nss_supp.tx_mcs_160);
 	int i;
-	u8 nss = sta->deflink.rx_nss;
+	u8 nss = link_sta->rx_nss;
 
 	/* the station support only a single receive chain */
-	if (sta->deflink.smps_mode == IEEE80211_SMPS_STATIC)
+	if (link_sta->smps_mode == IEEE80211_SMPS_STATIC)
 		nss = 1;
 
 	for (i = 0; i < nss && i < IWL_TLC_NSS_MAX; i++) {
@@ -282,13 +282,14 @@ rs_fw_rs_mcs2eht_mcs(enum IWL_TLC_MCS_PER_BW bw,
 	}
 }
 
-static void rs_fw_eht_set_enabled_rates(const struct ieee80211_sta *sta,
-					struct ieee80211_supported_band *sband,
-					struct iwl_tlc_config_cmd_v4 *cmd)
+static void
+rs_fw_eht_set_enabled_rates(const struct ieee80211_link_sta *link_sta,
+			    struct ieee80211_supported_band *sband,
+			    struct iwl_tlc_config_cmd_v4 *cmd)
 {
 	/* peer RX mcs capa */
 	const struct ieee80211_eht_mcs_nss_supp *eht_rx_mcs =
-		&sta->deflink.eht_cap.eht_mcs_nss_supp;
+		&link_sta->eht_cap.eht_mcs_nss_supp;
 	/* our TX mcs capa */
 	const struct ieee80211_eht_mcs_nss_supp *eht_tx_mcs =
 		&sband->iftype_data->eht_cap.eht_mcs_nss_supp;
@@ -298,7 +299,7 @@ static void rs_fw_eht_set_enabled_rates(const struct ieee80211_sta *sta,
 	struct ieee80211_eht_mcs_nss_supp_20mhz_only mcs_tx_20;
 
 	/* peer is 20Mhz only */
-	if (!(sta->deflink.he_cap.he_cap_elem.phy_cap_info[0] &
+	if (!(link_sta->he_cap.he_cap_elem.phy_cap_info[0] &
 	      IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_MASK_ALL)) {
 		mcs_rx_20 = eht_rx_mcs->only_20mhz;
 	} else {
@@ -354,25 +355,25 @@ static void rs_fw_eht_set_enabled_rates(const struct ieee80211_sta *sta,
 	}
 
 	/* the station support only a single receive chain */
-	if (sta->deflink.smps_mode == IEEE80211_SMPS_STATIC ||
-	    sta->deflink.rx_nss < 2)
+	if (link_sta->smps_mode == IEEE80211_SMPS_STATIC ||
+	    link_sta->rx_nss < 2)
 		memset(cmd->ht_rates[IWL_TLC_NSS_2], 0,
 		       sizeof(cmd->ht_rates[IWL_TLC_NSS_2]));
 }
 
-static void rs_fw_set_supp_rates(struct ieee80211_sta *sta,
+static void rs_fw_set_supp_rates(struct ieee80211_link_sta *link_sta,
 				 struct ieee80211_supported_band *sband,
 				 struct iwl_tlc_config_cmd_v4 *cmd)
 {
 	int i;
 	u16 supp = 0;
 	unsigned long tmp; /* must be unsigned long for for_each_set_bit */
-	const struct ieee80211_sta_ht_cap *ht_cap = &sta->deflink.ht_cap;
-	const struct ieee80211_sta_vht_cap *vht_cap = &sta->deflink.vht_cap;
-	const struct ieee80211_sta_he_cap *he_cap = &sta->deflink.he_cap;
+	const struct ieee80211_sta_ht_cap *ht_cap = &link_sta->ht_cap;
+	const struct ieee80211_sta_vht_cap *vht_cap = &link_sta->vht_cap;
+	const struct ieee80211_sta_he_cap *he_cap = &link_sta->he_cap;
 
 	/* non HT rates */
-	tmp = sta->deflink.supp_rates[sband->band];
+	tmp = link_sta->supp_rates[sband->band];
 	for_each_set_bit(i, &tmp, BITS_PER_LONG)
 		supp |= BIT(sband->bitrates[i].hw_value);
 
@@ -380,22 +381,22 @@ static void rs_fw_set_supp_rates(struct ieee80211_sta *sta,
 	cmd->mode = IWL_TLC_MNG_MODE_NON_HT;
 
 	/* HT/VHT rates */
-	if (sta->deflink.eht_cap.has_eht) {
+	if (link_sta->eht_cap.has_eht) {
 		cmd->mode = IWL_TLC_MNG_MODE_EHT;
-		rs_fw_eht_set_enabled_rates(sta, sband, cmd);
+		rs_fw_eht_set_enabled_rates(link_sta, sband, cmd);
 	} else if (he_cap->has_he) {
 		cmd->mode = IWL_TLC_MNG_MODE_HE;
-		rs_fw_he_set_enabled_rates(sta, sband, cmd);
+		rs_fw_he_set_enabled_rates(link_sta, sband, cmd);
 	} else if (vht_cap->vht_supported) {
 		cmd->mode = IWL_TLC_MNG_MODE_VHT;
-		rs_fw_vht_set_enabled_rates(sta, vht_cap, cmd);
+		rs_fw_vht_set_enabled_rates(link_sta, vht_cap, cmd);
 	} else if (ht_cap->ht_supported) {
 		cmd->mode = IWL_TLC_MNG_MODE_HT;
 		cmd->ht_rates[IWL_TLC_NSS_1][IWL_TLC_MCS_PER_BW_80] =
 			cpu_to_le16(ht_cap->mcs.rx_mask[0]);
 
 		/* the station support only a single receive chain */
-		if (sta->deflink.smps_mode == IEEE80211_SMPS_STATIC)
+		if (link_sta->smps_mode == IEEE80211_SMPS_STATIC)
 			cmd->ht_rates[IWL_TLC_NSS_2][IWL_TLC_MCS_PER_BW_80] =
 				0;
 		else
@@ -410,15 +411,18 @@ void iwl_mvm_tlc_update_notif(struct iwl_mvm *mvm,
 	struct iwl_rx_packet *pkt = rxb_addr(rxb);
 	struct iwl_tlc_update_notif *notif;
 	struct ieee80211_sta *sta;
+	struct ieee80211_link_sta *link_sta;
 	struct iwl_mvm_sta *mvmsta;
+	struct iwl_mvm_link_sta *mvm_link_sta;
 	struct iwl_lq_sta_rs_fw *lq_sta;
 	u32 flags;
 
 	rcu_read_lock();
 
 	notif = (void *)pkt->data;
+	link_sta = rcu_dereference(mvm->fw_id_to_link_sta[notif->sta_id]);
 	sta = rcu_dereference(mvm->fw_id_to_mac_id[notif->sta_id]);
-	if (IS_ERR_OR_NULL(sta)) {
+	if (IS_ERR_OR_NULL(sta) || !link_sta) {
 		/* can happen in remove station flow where mvm removed internally
 		 * the station before removing from FW
 		 */
@@ -438,7 +442,14 @@ void iwl_mvm_tlc_update_notif(struct iwl_mvm *mvm,
 
 	flags = le32_to_cpu(notif->flags);
 
-	lq_sta = &mvmsta->deflink.lq_sta.rs_fw;
+	mvm_link_sta = rcu_dereference(mvmsta->link[link_sta->link_id]);
+	if (!mvm_link_sta) {
+		IWL_DEBUG_RATE(mvm,
+			       "Invalid mvmsta RCU pointer for link (%d) of  sta id (%d) in TLC notification\n",
+			       link_sta->link_id, notif->sta_id);
+		goto out;
+	}
+	lq_sta = &mvm_link_sta->lq_sta.rs_fw;
 
 	if (flags & IWL_TLC_NOTIF_FLAG_RATE) {
 		char pretty_rate[100];
@@ -465,9 +476,9 @@ void iwl_mvm_tlc_update_notif(struct iwl_mvm *mvm,
 		u16 size = le32_to_cpu(notif->amsdu_size);
 		int i;
 
-		if (sta->deflink.agg.max_amsdu_len < size) {
+		if (link_sta->agg.max_amsdu_len < size) {
 			/*
-			 * In debug sta->deflink.agg.max_amsdu_len < size
+			 * In debug link_sta->agg.max_amsdu_len < size
 			 * so also check with orig_amsdu_len which holds the
 			 * original data before debugfs changed the value
 			 */
@@ -477,18 +488,18 @@ void iwl_mvm_tlc_update_notif(struct iwl_mvm *mvm,
 
 		mvmsta->amsdu_enabled = le32_to_cpu(notif->amsdu_enabled);
 		mvmsta->max_amsdu_len = size;
-		sta->deflink.agg.max_rc_amsdu_len = mvmsta->max_amsdu_len;
+		link_sta->agg.max_rc_amsdu_len = mvmsta->max_amsdu_len;
 
 		for (i = 0; i < IWL_MAX_TID_COUNT; i++) {
 			if (mvmsta->amsdu_enabled & BIT(i))
-				sta->deflink.agg.max_tid_amsdu_len[i] =
+				link_sta->agg.max_tid_amsdu_len[i] =
 					iwl_mvm_max_amsdu_size(mvm, sta, i);
 			else
 				/*
 				 * Not so elegant, but this will effectively
 				 * prevent AMSDU on this TID
 				 */
-				sta->deflink.agg.max_tid_amsdu_len[i] = 1;
+				link_sta->agg.max_tid_amsdu_len[i] = 1;
 		}
 
 		IWL_DEBUG_RATE(mvm,
@@ -511,7 +522,7 @@ u16 rs_fw_get_max_amsdu_len(struct ieee80211_sta *sta,
 		return IEEE80211_MAX_MPDU_LEN_VHT_3895;
 
 	if (link_conf->chandef.chan->band == NL80211_BAND_6GHZ) {
-		switch (le16_get_bits(sta->deflink.he_6ghz_capa.capa,
+		switch (le16_get_bits(link_sta->he_6ghz_capa.capa,
 				      IEEE80211_HE_6GHZ_CAP_MAX_MPDU_LEN)) {
 		case IEEE80211_VHT_CAP_MAX_MPDU_LENGTH_11454:
 			return IEEE80211_MAX_MPDU_LEN_VHT_11454;
@@ -560,10 +571,12 @@ void rs_fw_rate_init(struct iwl_mvm *mvm, struct ieee80211_sta *sta,
 	struct iwl_lq_sta_rs_fw *lq_sta;
 	struct iwl_tlc_config_cmd_v4 cfg_cmd = {
 		.max_ch_width = update ?
-			rs_fw_bw_from_sta_bw(sta) : IWL_TLC_MNG_CH_WIDTH_20MHZ,
-		.flags = cpu_to_le16(rs_fw_get_config_flags(mvm, sta, sband)),
+			rs_fw_bw_from_sta_bw(link_sta) :
+			IWL_TLC_MNG_CH_WIDTH_20MHZ,
+		.flags = cpu_to_le16(rs_fw_get_config_flags(mvm, link_sta,
+							    sband)),
 		.chains = rs_fw_set_active_chains(iwl_mvm_get_valid_tx_ant(mvm)),
-		.sgi_ch_width_supp = rs_fw_sgi_cw_support(sta),
+		.sgi_ch_width_supp = rs_fw_sgi_cw_support(link_sta),
 		.max_mpdu_len = iwl_mvm_is_csum_supported(mvm) ?
 				cpu_to_le16(max_amsdu_len) : 0,
 	};
@@ -588,7 +601,7 @@ void rs_fw_rate_init(struct iwl_mvm *mvm, struct ieee80211_sta *sta,
 #ifdef CONFIG_IWLWIFI_DEBUGFS
 	iwl_mvm_reset_frame_stats(mvm);
 #endif
-	rs_fw_set_supp_rates(sta, sband, &cfg_cmd);
+	rs_fw_set_supp_rates(link_sta, sband, &cfg_cmd);
 
 	/*
 	 * since TLC offload works with one mode we can assume
-- 
2.38.1

