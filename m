Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2E5C7368CA
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jun 2023 12:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231745AbjFTKF3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Jun 2023 06:05:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231723AbjFTKFI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Jun 2023 06:05:08 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A25E1130
        for <linux-wireless@vger.kernel.org>; Tue, 20 Jun 2023 03:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687255505; x=1718791505;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=G/C5Un0Zjg6CO8LNNOdgyM9tEgfreHuFBsU5Az+adwc=;
  b=hkf07SXGxgYqaVGL2kPKNbmwZOx9OmqKrUUKt7GXmq73A+RtlKYpQ8nS
   ibZ2xsIVcyJvUc3KcNhm+gX1oGt0Brs2CZHdL8Yo2p4phDpRcWXss+VYN
   ZKegNP4V4akA6iMOkSS0XIH/OfpBAPYMt3f61f2NW7q/5gTcs7o65xfdL
   PSNzeA9LX7Y9VE1GAW5xTYPOyRR8wo9dQWN6MmN+5XQdbFJhzzmKA0Xwq
   891f0Ds+mVXQiaIxCnMOuFfA0sO8H+Vo62Ddr13numJICAMvFT6RfTiJu
   bhJYMtlKQktYa3bJtEL4xcIJ0iMIyg9pFIfYrvtvAxqw8bqysfhBrMLRK
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="359819677"
X-IronPort-AV: E=Sophos;i="6.00,256,1681196400"; 
   d="scan'208";a="359819677"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 03:05:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="838143629"
X-IronPort-AV: E=Sophos;i="6.00,256,1681196400"; 
   d="scan'208";a="838143629"
Received: from rafist-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.208.68])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 03:05:03 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, Ilan Peer <ilan.peer@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 19/19] wifi: iwlwifi: mvm: Add support for scan version 17
Date:   Tue, 20 Jun 2023 13:04:05 +0300
Message-Id: <20230620125813.0a41c847d450.I0c9b45cc3eb39d44c75d3bdca84f0a91fdad1fa1@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230620100405.45117-1-gregory.greenman@intel.com>
References: <20230620100405.45117-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ilan Peer <ilan.peer@intel.com>

Add support for scan request command version 17, which supports
specifying the maximal EIRP PSD value that can be used for
probe request transmission on a given channel.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 .../net/wireless/intel/iwlwifi/fw/api/scan.h  |  28 +++--
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c | 113 +++++++++++++-----
 2 files changed, 99 insertions(+), 42 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/scan.h b/drivers/net/wireless/intel/iwlwifi/fw/api/scan.h
index 9cbeef16cfe5..93078f8cc08c 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/scan.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/scan.h
@@ -727,8 +727,10 @@ enum iwl_umac_scan_general_params_flags2 {
  * @iter_interval:	interval between two scan iterations on one channel.
  */
 struct  iwl_scan_channel_cfg_umac {
+#define IWL_CHAN_CFG_FLAGS_BAND_POS 30
 	__le32 flags;
-	/* Both versions are of the same size, so use a union without adjusting
+
+	/* All versions are of the same size, so use a union without adjusting
 	 * the command size later
 	 */
 	union {
@@ -746,6 +748,12 @@ struct  iwl_scan_channel_cfg_umac {
 			* SCAN_CHANNEL_CONFIG_API_S_VER_3
 			* SCAN_CHANNEL_CONFIG_API_S_VER_4
 			*/
+		struct {
+			u8 channel_num;
+			u8 psd_20;
+			u8 iter_count;
+			u8 iter_interval;
+		} v5;  /* SCAN_CHANNEL_CONFIG_API_S_VER_5 */
 	};
 } __packed;
 
@@ -982,7 +990,7 @@ struct iwl_scan_channel_params_v4 {
 	       SCAN_CHANNEL_PARAMS_API_S_VER_5 */
 
 /**
- * struct iwl_scan_channel_params_v6
+ * struct iwl_scan_channel_params_v7
  * @flags: channel flags &enum iwl_scan_channel_flags
  * @count: num of channels in scan request
  * @n_aps_override: override the number of APs the FW uses to calculate dwell
@@ -992,7 +1000,7 @@ struct iwl_scan_channel_params_v4 {
  * @channel_config: array of explicit channel configurations
  *                  for 2.4Ghz and 5.2Ghz bands
  */
-struct iwl_scan_channel_params_v6 {
+struct iwl_scan_channel_params_v7 {
 	u8 flags;
 	u8 count;
 	u8 n_aps_override[2];
@@ -1070,16 +1078,16 @@ struct iwl_scan_req_params_v12 {
 /**
  * struct iwl_scan_req_params_v16
  * @general_params: &struct iwl_scan_general_params_v11
- * @channel_params: &struct iwl_scan_channel_params_v6
+ * @channel_params: &struct iwl_scan_channel_params_v7
  * @periodic_params: &struct iwl_scan_periodic_parms_v1
  * @probe_params: &struct iwl_scan_probe_params_v4
  */
-struct iwl_scan_req_params_v16 {
+struct iwl_scan_req_params_v17 {
 	struct iwl_scan_general_params_v11 general_params;
-	struct iwl_scan_channel_params_v6 channel_params;
+	struct iwl_scan_channel_params_v7 channel_params;
 	struct iwl_scan_periodic_parms_v1 periodic_params;
 	struct iwl_scan_probe_params_v4 probe_params;
-} __packed; /* SCAN_REQUEST_PARAMS_API_S_VER_16, *_VER_15 and *_VER_14 */
+} __packed; /* SCAN_REQUEST_PARAMS_API_S_VER_17 - 14 */
 
 /**
  * struct iwl_scan_req_umac_v12
@@ -1099,11 +1107,11 @@ struct iwl_scan_req_umac_v12 {
  * @ooc_priority: out of channel priority - &enum iwl_scan_priority
  * @scan_params: scan parameters
  */
-struct iwl_scan_req_umac_v16 {
+struct iwl_scan_req_umac_v17 {
 	__le32 uid;
 	__le32 ooc_priority;
-	struct iwl_scan_req_params_v16 scan_params;
-} __packed; /* SCAN_REQUEST_CMD_UMAC_API_S_VER_16, *_VER_15 and *_VER_14 */
+	struct iwl_scan_req_params_v17 scan_params;
+} __packed; /* SCAN_REQUEST_CMD_UMAC_API_S_VER_17 - 14 */
 
 /**
  * struct iwl_umac_scan_abort
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
index b2154e9fcf01..c1d9ce753468 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
@@ -1627,11 +1627,11 @@ iwl_mvm_umac_scan_cfg_channels_v4(struct iwl_mvm *mvm,
 }
 
 static void
-iwl_mvm_umac_scan_cfg_channels_v6(struct iwl_mvm *mvm,
+iwl_mvm_umac_scan_cfg_channels_v7(struct iwl_mvm *mvm,
 				  struct ieee80211_channel **channels,
-				  struct iwl_scan_channel_params_v6 *cp,
+				  struct iwl_scan_channel_params_v7 *cp,
 				  int n_channels, u32 flags,
-				  enum nl80211_iftype vif_type)
+				  enum nl80211_iftype vif_type, u32 version)
 {
 	int i;
 
@@ -1641,14 +1641,19 @@ iwl_mvm_umac_scan_cfg_channels_v6(struct iwl_mvm *mvm,
 		u32 n_aps_flag =
 			iwl_mvm_scan_ch_n_aps_flag(vif_type,
 						   channels[i]->hw_value);
+		u8 iwl_band = iwl_mvm_phy_band_from_nl80211(band);
 
 		cfg->flags = cpu_to_le32(flags | n_aps_flag);
 		cfg->v2.channel_num = channels[i]->hw_value;
-		cfg->v2.band = iwl_mvm_phy_band_from_nl80211(band);
 		if (cfg80211_channel_is_psc(channels[i]))
 			cfg->flags = 0;
 		cfg->v2.iter_count = 1;
 		cfg->v2.iter_interval = 0;
+		if (version < 17)
+			cfg->v2.band = iwl_band;
+		else
+			cfg->flags |= cpu_to_le32((iwl_band <<
+						   IWL_CHAN_CFG_FLAGS_BAND_POS));
 	}
 }
 
@@ -1723,14 +1728,15 @@ iwl_mvm_umac_scan_fill_6g_chan_list(struct iwl_mvm *mvm,
 	pp->bssid_num = idex_b;
 }
 
-/* TODO: this function can be merged with iwl_mvm_scan_umac_fill_ch_p_v6 */
+/* TODO: this function can be merged with iwl_mvm_scan_umac_fill_ch_p_v7 */
 static u32
-iwl_mvm_umac_scan_cfg_channels_v6_6g(struct iwl_mvm *mvm,
+iwl_mvm_umac_scan_cfg_channels_v7_6g(struct iwl_mvm *mvm,
 				     struct iwl_mvm_scan_params *params,
 				     u32 n_channels,
 				     struct iwl_scan_probe_params_v4 *pp,
-				     struct iwl_scan_channel_params_v6 *cp,
-				     enum nl80211_iftype vif_type)
+				     struct iwl_scan_channel_params_v7 *cp,
+				     enum nl80211_iftype vif_type,
+				     u32 version)
 {
 	int i;
 	struct cfg80211_scan_6ghz_params *scan_6ghz_params =
@@ -1745,6 +1751,7 @@ iwl_mvm_umac_scan_cfg_channels_v6_6g(struct iwl_mvm *mvm,
 		u8 j, k, s_max = 0, b_max = 0, n_used_bssid_entries;
 		bool force_passive, found = false, allow_passive = true,
 		     unsolicited_probe_on_chan = false, psc_no_listen = false;
+		s8 psd_20 = IEEE80211_RNR_TBTT_PARAMS_PSD_RESERVED;
 
 		/*
 		 * Avoid performing passive scan on non PSC channels unless the
@@ -1756,9 +1763,14 @@ iwl_mvm_umac_scan_cfg_channels_v6_6g(struct iwl_mvm *mvm,
 			continue;
 
 		cfg->v1.channel_num = params->channels[i]->hw_value;
-		cfg->v2.band = 2;
-		cfg->v2.iter_count = 1;
-		cfg->v2.iter_interval = 0;
+		if (version < 17)
+			cfg->v2.band = PHY_BAND_6;
+		else
+			cfg->flags |= cpu_to_le32(PHY_BAND_6 <<
+						  IWL_CHAN_CFG_FLAGS_BAND_POS);
+
+		cfg->v5.iter_count = 1;
+		cfg->v5.iter_interval = 0;
 
 		/*
 		 * The optimize the scan time, i.e., reduce the scan dwell time
@@ -1769,9 +1781,22 @@ iwl_mvm_umac_scan_cfg_channels_v6_6g(struct iwl_mvm *mvm,
 		 */
 		n_used_bssid_entries = 3;
 		for (j = 0; j < params->n_6ghz_params; j++) {
+			s8 tmp_psd_20;
+
 			if (!(scan_6ghz_params[j].channel_idx == i))
 				continue;
 
+			/* Use the highest PSD value allowed as advertised by
+			 * APs for this channel
+			 */
+			tmp_psd_20 = scan_6ghz_params[j].psd_20;
+			if (tmp_psd_20 !=
+			    IEEE80211_RNR_TBTT_PARAMS_PSD_RESERVED &&
+			    (psd_20 ==
+			     IEEE80211_RNR_TBTT_PARAMS_PSD_RESERVED ||
+			     psd_20 < tmp_psd_20))
+				psd_20 = tmp_psd_20;
+
 			found = false;
 			unsolicited_probe_on_chan |=
 				scan_6ghz_params[j].unsolicited_probe;
@@ -1875,6 +1900,9 @@ iwl_mvm_umac_scan_cfg_channels_v6_6g(struct iwl_mvm *mvm,
 			flags |= bssid_bitmap | (s_ssid_bitmap << 16);
 
 		cfg->flags |= cpu_to_le32(flags);
+		if (version >= 17)
+			cfg->v5.psd_20 = psd_20;
+
 		ch_cnt++;
 	}
 
@@ -2369,21 +2397,22 @@ iwl_mvm_scan_umac_fill_ch_p_v4(struct iwl_mvm *mvm,
 }
 
 static void
-iwl_mvm_scan_umac_fill_ch_p_v6(struct iwl_mvm *mvm,
+iwl_mvm_scan_umac_fill_ch_p_v7(struct iwl_mvm *mvm,
 			       struct iwl_mvm_scan_params *params,
 			       struct ieee80211_vif *vif,
-			       struct iwl_scan_channel_params_v6 *cp,
-			       u32 channel_cfg_flags)
+			       struct iwl_scan_channel_params_v7 *cp,
+			       u32 channel_cfg_flags,
+			       u32 version)
 {
 	cp->flags = iwl_mvm_scan_umac_chan_flags_v2(mvm, params, vif);
 	cp->count = params->n_channels;
 	cp->n_aps_override[0] = IWL_SCAN_ADWELL_N_APS_GO_FRIENDLY;
 	cp->n_aps_override[1] = IWL_SCAN_ADWELL_N_APS_SOCIAL_CHS;
 
-	iwl_mvm_umac_scan_cfg_channels_v6(mvm, params->channels, cp,
+	iwl_mvm_umac_scan_cfg_channels_v7(mvm, params->channels, cp,
 					  params->n_channels,
 					  channel_cfg_flags,
-					  vif->type);
+					  vif->type, version);
 
 	if (params->enable_6ghz_passive) {
 		struct ieee80211_supported_band *sband =
@@ -2400,11 +2429,19 @@ iwl_mvm_scan_umac_fill_ch_p_v6(struct iwl_mvm *mvm,
 			if (!cfg80211_channel_is_psc(channel))
 				continue;
 
-			cfg->flags = 0;
-			cfg->v2.channel_num = channel->hw_value;
-			cfg->v2.band = PHY_BAND_6;
-			cfg->v2.iter_count = 1;
-			cfg->v2.iter_interval = 0;
+			cfg->v5.channel_num = channel->hw_value;
+			cfg->v5.iter_count = 1;
+			cfg->v5.iter_interval = 0;
+
+			if (version < 17) {
+				cfg->flags = 0;
+				cfg->v2.band = PHY_BAND_6;
+			} else {
+				cfg->flags = cpu_to_le32(PHY_BAND_6 <<
+							 IWL_CHAN_CFG_FLAGS_BAND_POS);
+				cfg->v5.psd_20 =
+					IEEE80211_RNR_TBTT_PARAMS_PSD_RESERVED;
+			}
 			cp->count++;
 		}
 	}
@@ -2447,9 +2484,9 @@ static int iwl_mvm_scan_umac_v14_and_above(struct iwl_mvm *mvm,
 					   struct iwl_mvm_scan_params *params,
 					   int type, int uid, u32 version)
 {
-	struct iwl_scan_req_umac_v16 *cmd = mvm->scan_cmd;
-	struct iwl_scan_req_params_v16 *scan_p = &cmd->scan_params;
-	struct iwl_scan_channel_params_v6 *cp = &scan_p->channel_params;
+	struct iwl_scan_req_umac_v17 *cmd = mvm->scan_cmd;
+	struct iwl_scan_req_params_v17 *scan_p = &cmd->scan_params;
+	struct iwl_scan_channel_params_v7 *cp = &scan_p->channel_params;
 	struct iwl_scan_probe_params_v4 *pb = &scan_p->probe_params;
 	int ret;
 	u16 gen_flags;
@@ -2479,11 +2516,13 @@ static int iwl_mvm_scan_umac_v14_and_above(struct iwl_mvm *mvm,
 		return ret;
 
 	if (!params->scan_6ghz) {
-		iwl_mvm_scan_umac_fill_probe_p_v4(params, &scan_p->probe_params,
-					  &bitmap_ssid);
-		iwl_mvm_scan_umac_fill_ch_p_v6(mvm, params, vif,
-				       &scan_p->channel_params, bitmap_ssid);
-
+		iwl_mvm_scan_umac_fill_probe_p_v4(params,
+						  &scan_p->probe_params,
+						  &bitmap_ssid);
+		iwl_mvm_scan_umac_fill_ch_p_v7(mvm, params, vif,
+					       &scan_p->channel_params,
+					       bitmap_ssid,
+					       version);
 		return 0;
 	} else {
 		pb->preq = params->preq;
@@ -2495,9 +2534,10 @@ static int iwl_mvm_scan_umac_v14_and_above(struct iwl_mvm *mvm,
 
 	iwl_mvm_umac_scan_fill_6g_chan_list(mvm, params, pb);
 
-	cp->count = iwl_mvm_umac_scan_cfg_channels_v6_6g(mvm, params,
+	cp->count = iwl_mvm_umac_scan_cfg_channels_v7_6g(mvm, params,
 							 params->n_channels,
-							 pb, cp, vif->type);
+							 pb, cp, vif->type,
+							 version);
 	if (!cp->count) {
 		mvm->scan_uid_status[uid] = 0;
 		return -EINVAL;
@@ -2531,6 +2571,13 @@ static int iwl_mvm_scan_umac_v16(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	return iwl_mvm_scan_umac_v14_and_above(mvm, vif, params, type, uid, 16);
 }
 
+static int iwl_mvm_scan_umac_v17(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
+				 struct iwl_mvm_scan_params *params, int type,
+				 int uid)
+{
+	return iwl_mvm_scan_umac_v14_and_above(mvm, vif, params, type, uid, 17);
+}
+
 static int iwl_mvm_num_scans(struct iwl_mvm *mvm)
 {
 	return hweight32(mvm->scan_status & IWL_MVM_SCAN_MASK);
@@ -2646,6 +2693,7 @@ struct iwl_scan_umac_handler {
 
 static const struct iwl_scan_umac_handler iwl_scan_umac_handlers[] = {
 	/* set the newest version first to shorten the list traverse time */
+	IWL_SCAN_UMAC_HANDLER(17),
 	IWL_SCAN_UMAC_HANDLER(16),
 	IWL_SCAN_UMAC_HANDLER(15),
 	IWL_SCAN_UMAC_HANDLER(14),
@@ -3236,7 +3284,8 @@ static size_t iwl_scan_req_umac_get_size(u8 scan_ver)
 	case 14:
 	case 15:
 	case 16:
-		return sizeof(struct iwl_scan_req_umac_v16);
+	case 17:
+		return sizeof(struct iwl_scan_req_umac_v17);
 	}
 
 	return 0;
-- 
2.38.1

