Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 018886E42CA
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Apr 2023 10:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbjDQImP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 17 Apr 2023 04:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbjDQImL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 17 Apr 2023 04:42:11 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE4CA10F9
        for <linux-wireless@vger.kernel.org>; Mon, 17 Apr 2023 01:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681720929; x=1713256929;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yF+dUamz96CeauRfgyApZOtXw7aBhHrwoXBAqGyeI2Q=;
  b=DtiMnDm1VU4utOux9Af2/o6kWYXjWyEe9J1pfkHaNv1Ocd1jMViBwjUH
   qeGGqiHaU/yIl6t1dWu7wrsOil7l9LCqDn2rmugtCPR9d60wJu1nNbNOY
   EH2TzhqKeSaErNJvzV1uoKRKQLPDu+z8O3ILp7Rjac9tonfOKLauvwbzn
   REOZWO7jn+EAJS3EXefxy7i3Vp+8Ioc9cof8eqQQfUCu7WZv+65ISI0Is
   5aKpbTfVpgUoDJA3matlGIe4z09ocdWx1KEC7BzswZ+gM224W8vmx7dKK
   6bLsdrDKpCTJXspZDsrN8xHJc/5oGl2vyd6+X38MTzEGeg05jJ3FTl9R2
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10682"; a="333634383"
X-IronPort-AV: E=Sophos;i="5.99,203,1677571200"; 
   d="scan'208";a="333634383"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2023 01:42:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10682"; a="693173857"
X-IronPort-AV: E=Sophos;i="5.99,203,1677571200"; 
   d="scan'208";a="693173857"
Received: from odotan1x-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.202.32])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2023 01:42:07 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 08/15] wifi: iwlwifi: mvm: rs-fw: properly access sband->iftype_data
Date:   Mon, 17 Apr 2023 11:41:27 +0300
Message-Id: <20230417113648.1fd54368a02c.Ie4db5e8ae224d9a4a63b528da5d63e1b957b9cef@changeid>
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

We need to look up the correct version of this struct depending
on the interface type, rather than just checking if the pointer
is non-NULL. Fix that.

Fixes: befebbb30af0 ("iwlwifi: rs: consider LDPC capability in case of HE")
Fixes: b009cf71a982 ("iwlwifi: mvm: only enable HE DCM if we also support TX")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 .../net/wireless/intel/iwlwifi/mvm/rs-fw.c    | 21 +++++++++++--------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
index 43d26a09cfce..2b52d3aa82ed 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
@@ -61,12 +61,14 @@ static u8 rs_fw_sgi_cw_support(struct ieee80211_link_sta *link_sta)
 }
 
 static u16 rs_fw_get_config_flags(struct iwl_mvm *mvm,
+				  struct ieee80211_vif *vif,
 				  struct ieee80211_link_sta *link_sta,
 				  struct ieee80211_supported_band *sband)
 {
 	struct ieee80211_sta_ht_cap *ht_cap = &link_sta->ht_cap;
 	struct ieee80211_sta_vht_cap *vht_cap = &link_sta->vht_cap;
 	struct ieee80211_sta_he_cap *he_cap = &link_sta->he_cap;
+	const struct ieee80211_sta_he_cap *sband_he_cap;
 	bool vht_ena = vht_cap->vht_supported;
 	u16 flags = 0;
 
@@ -92,17 +94,19 @@ static u16 rs_fw_get_config_flags(struct iwl_mvm *mvm,
 	    IEEE80211_HE_PHY_CAP1_LDPC_CODING_IN_PAYLOAD))
 		flags |= IWL_TLC_MNG_CFG_FLAGS_LDPC_MSK;
 
-	if (sband->iftype_data && sband->iftype_data->he_cap.has_he &&
-	    !(sband->iftype_data->he_cap.he_cap_elem.phy_cap_info[1] &
-	     IEEE80211_HE_PHY_CAP1_LDPC_CODING_IN_PAYLOAD))
+	sband_he_cap = ieee80211_get_he_iftype_cap(sband,
+						   ieee80211_vif_type_p2p(vif));
+	if (sband_he_cap &&
+	    !(sband_he_cap->he_cap_elem.phy_cap_info[1] &
+			IEEE80211_HE_PHY_CAP1_LDPC_CODING_IN_PAYLOAD))
 		flags &= ~IWL_TLC_MNG_CFG_FLAGS_LDPC_MSK;
 
 	if (he_cap->has_he &&
 	    (he_cap->he_cap_elem.phy_cap_info[3] &
 	     IEEE80211_HE_PHY_CAP3_DCM_MAX_CONST_RX_MASK &&
-	     sband->iftype_data &&
-	     sband->iftype_data->he_cap.he_cap_elem.phy_cap_info[3] &
-	     IEEE80211_HE_PHY_CAP3_DCM_MAX_CONST_TX_MASK))
+	     sband_he_cap &&
+	     sband_he_cap->he_cap_elem.phy_cap_info[3] &
+			IEEE80211_HE_PHY_CAP3_DCM_MAX_CONST_TX_MASK))
 		flags |= IWL_TLC_MNG_CFG_FLAGS_HE_DCM_NSS_1_MSK;
 
 	return flags;
@@ -576,9 +580,8 @@ void rs_fw_rate_init(struct iwl_mvm *mvm,
 	struct iwl_lq_sta_rs_fw *lq_sta;
 	struct iwl_tlc_config_cmd_v4 cfg_cmd = {
 		.max_ch_width = update ?
-			rs_fw_bw_from_sta_bw(link_sta) :
-			IWL_TLC_MNG_CH_WIDTH_20MHZ,
-		.flags = cpu_to_le16(rs_fw_get_config_flags(mvm, link_sta,
+			rs_fw_bw_from_sta_bw(link_sta) : IWL_TLC_MNG_CH_WIDTH_20MHZ,
+		.flags = cpu_to_le16(rs_fw_get_config_flags(mvm, vif, link_sta,
 							    sband)),
 		.chains = rs_fw_set_active_chains(iwl_mvm_get_valid_tx_ant(mvm)),
 		.sgi_ch_width_supp = rs_fw_sgi_cw_support(link_sta),
-- 
2.38.1

