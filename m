Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 980DD6C0F05
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Mar 2023 11:36:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbjCTKgG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Mar 2023 06:36:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230306AbjCTKfg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Mar 2023 06:35:36 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CA0312F14
        for <linux-wireless@vger.kernel.org>; Mon, 20 Mar 2023 03:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679308502; x=1710844502;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yP39z8eL87m7ad6htXLlBpkyW5OUk2kLWSglSumH+lc=;
  b=oEj0N3isPbkAc9E/4BlLFOHgKa+XhOd1beCu6LOT9v81YSccVQxadSQJ
   hW5dJaxb9+BWK9CC+eQ3YJ9hSTGa0N0ny4KcsfoabM2cMUkyYysuRpNkC
   NBmzVAASzJas9ssGiqkQU0Ra5IwDtpHXGo2RenDxgJS/JgSlXoGxjAjby
   InM5YbnjO71ds1KQe2Py8STpyUve4OrJJLTq8bPtKfvcSkNpR0Q0AkxtQ
   wTdQSR9I7OAmYwm46c0qiXt7pvy7JpMwXpZ7iVPA75O+WiIBdzHarzNSz
   V42VLZg3Xg+3MIQZAaQRIU0z+vdB6nWCom/dIrmQXaeNVVBqlc/ZEb7Ww
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10654"; a="326997936"
X-IronPort-AV: E=Sophos;i="5.98,274,1673942400"; 
   d="scan'208";a="326997936"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 03:34:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10654"; a="713523692"
X-IronPort-AV: E=Sophos;i="5.98,274,1673942400"; 
   d="scan'208";a="713523692"
Received: from ranikhou-mobl3.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.251.179.26])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 03:34:02 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Miri Korenblit <miriam.rachel.korenblit@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 13/18] wifi: iwlwifi: mvm: refactor iwl_mvm_sta_send_to_fw()
Date:   Mon, 20 Mar 2023 12:33:14 +0200
Message-Id: <20230320122330.4da940bd7384.I3a66990fbffe9611b5e41f3686c2aff37ba2eb56@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230320103319.1309442-1-gregory.greenman@intel.com>
References: <20230320103319.1309442-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Miri Korenblit <miriam.rachel.korenblit@intel.com>

We have a new STA cmd as part of the new MLD API. There are some
parts of sending the STA cmd which are common to both the old and
the new one. Put this parts in functions which will later be used
to send the new STA cmd.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c | 116 +++++++++++--------
 1 file changed, 67 insertions(+), 49 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
index 1594221abdba..a40182e87f55 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
@@ -52,6 +52,68 @@ static int iwl_mvm_find_free_sta_id(struct iwl_mvm *mvm,
 	return IWL_MVM_INVALID_STA;
 }
 
+/* Calculate the ampdu density and max size */
+static u32 iwl_mvm_get_sta_ampdu_dens(struct ieee80211_sta *sta,
+				      u32 *_agg_size)
+{
+	struct iwl_mvm_sta *mvm_sta = iwl_mvm_sta_from_mac80211(sta);
+	u32 agg_size = 0, mpdu_dens = 0;
+
+	if (sta->deflink.ht_cap.ht_supported)
+		mpdu_dens = sta->deflink.ht_cap.ampdu_density;
+
+	if (mvm_sta->vif->bss_conf.chandef.chan->band == NL80211_BAND_6GHZ) {
+		mpdu_dens = le16_get_bits(sta->deflink.he_6ghz_capa.capa,
+					  IEEE80211_HE_6GHZ_CAP_MIN_MPDU_START);
+		agg_size = le16_get_bits(sta->deflink.he_6ghz_capa.capa,
+					 IEEE80211_HE_6GHZ_CAP_MAX_AMPDU_LEN_EXP);
+	} else if (sta->deflink.vht_cap.vht_supported) {
+		agg_size = sta->deflink.vht_cap.cap &
+			IEEE80211_VHT_CAP_MAX_A_MPDU_LENGTH_EXPONENT_MASK;
+		agg_size >>=
+			IEEE80211_VHT_CAP_MAX_A_MPDU_LENGTH_EXPONENT_SHIFT;
+	} else if (sta->deflink.ht_cap.ht_supported) {
+		agg_size = sta->deflink.ht_cap.ampdu_factor;
+	}
+
+	/* D6.0 10.12.2 A-MPDU length limit rules
+	 * A STA indicates the maximum length of the A-MPDU preEOF padding
+	 * that it can receive in an HE PPDU in the Maximum A-MPDU Length
+	 * Exponent field in its HT Capabilities, VHT Capabilities,
+	 * and HE 6 GHz Band Capabilities elements (if present) and the
+	 * Maximum AMPDU Length Exponent Extension field in its HE
+	 * Capabilities element
+	 */
+	if (sta->deflink.he_cap.has_he)
+		agg_size +=
+		    u8_get_bits(sta->deflink.he_cap.he_cap_elem.mac_cap_info[3],
+				IEEE80211_HE_MAC_CAP3_MAX_AMPDU_LEN_EXP_MASK);
+
+	/* Limit to max A-MPDU supported by FW */
+	if (agg_size > (STA_FLG_MAX_AGG_SIZE_4M >> STA_FLG_MAX_AGG_SIZE_SHIFT))
+		agg_size = (STA_FLG_MAX_AGG_SIZE_4M >>
+			    STA_FLG_MAX_AGG_SIZE_SHIFT);
+
+	*_agg_size = agg_size;
+	return mpdu_dens;
+}
+
+static u8 iwl_mvm_get_sta_uapsd_acs(struct ieee80211_sta *sta)
+{
+	u8 uapsd_acs = 0;
+
+	if (sta->uapsd_queues & IEEE80211_WMM_IE_STA_QOSINFO_AC_BK)
+		uapsd_acs |= BIT(AC_BK);
+	if (sta->uapsd_queues & IEEE80211_WMM_IE_STA_QOSINFO_AC_BE)
+		uapsd_acs |= BIT(AC_BE);
+	if (sta->uapsd_queues & IEEE80211_WMM_IE_STA_QOSINFO_AC_VI)
+		uapsd_acs |= BIT(AC_VI);
+	if (sta->uapsd_queues & IEEE80211_WMM_IE_STA_QOSINFO_AC_VO)
+		uapsd_acs |= BIT(AC_VO);
+
+	return uapsd_acs | uapsd_acs << 4;
+}
+
 /* send station add/update command to firmware */
 int iwl_mvm_sta_send_to_fw(struct iwl_mvm *mvm, struct ieee80211_sta *sta,
 			   bool update, unsigned int flags)
@@ -135,68 +197,24 @@ int iwl_mvm_sta_send_to_fw(struct iwl_mvm *mvm, struct ieee80211_sta *sta,
 		break;
 	}
 
-	if (sta->deflink.ht_cap.ht_supported) {
-		add_sta_cmd.station_flags_msk |=
-			cpu_to_le32(STA_FLG_MAX_AGG_SIZE_MSK |
-				    STA_FLG_AGG_MPDU_DENS_MSK);
-
-		mpdu_dens = sta->deflink.ht_cap.ampdu_density;
-	}
-
-	if (mvm_sta->vif->bss_conf.chandef.chan->band == NL80211_BAND_6GHZ) {
+	if (sta->deflink.ht_cap.ht_supported ||
+	    mvm_sta->vif->bss_conf.chandef.chan->band == NL80211_BAND_6GHZ)
 		add_sta_cmd.station_flags_msk |=
 			cpu_to_le32(STA_FLG_MAX_AGG_SIZE_MSK |
 				    STA_FLG_AGG_MPDU_DENS_MSK);
 
-		mpdu_dens = le16_get_bits(sta->deflink.he_6ghz_capa.capa,
-					  IEEE80211_HE_6GHZ_CAP_MIN_MPDU_START);
-		agg_size = le16_get_bits(sta->deflink.he_6ghz_capa.capa,
-					 IEEE80211_HE_6GHZ_CAP_MAX_AMPDU_LEN_EXP);
-	} else if (sta->deflink.vht_cap.vht_supported) {
-		agg_size = sta->deflink.vht_cap.cap &
-			IEEE80211_VHT_CAP_MAX_A_MPDU_LENGTH_EXPONENT_MASK;
-		agg_size >>=
-			IEEE80211_VHT_CAP_MAX_A_MPDU_LENGTH_EXPONENT_SHIFT;
-	} else if (sta->deflink.ht_cap.ht_supported) {
-		agg_size = sta->deflink.ht_cap.ampdu_factor;
-	}
-
-	/* D6.0 10.12.2 A-MPDU length limit rules
-	 * A STA indicates the maximum length of the A-MPDU preEOF padding
-	 * that it can receive in an HE PPDU in the Maximum A-MPDU Length
-	 * Exponent field in its HT Capabilities, VHT Capabilities,
-	 * and HE 6 GHz Band Capabilities elements (if present) and the
-	 * Maximum AMPDU Length Exponent Extension field in its HE
-	 * Capabilities element
-	 */
-	if (sta->deflink.he_cap.has_he)
-		agg_size += u8_get_bits(sta->deflink.he_cap.he_cap_elem.mac_cap_info[3],
-					IEEE80211_HE_MAC_CAP3_MAX_AMPDU_LEN_EXP_MASK);
-
-	/* Limit to max A-MPDU supported by FW */
-	if (agg_size > (STA_FLG_MAX_AGG_SIZE_4M >> STA_FLG_MAX_AGG_SIZE_SHIFT))
-		agg_size = (STA_FLG_MAX_AGG_SIZE_4M >>
-			    STA_FLG_MAX_AGG_SIZE_SHIFT);
-
+	mpdu_dens = iwl_mvm_get_sta_ampdu_dens(sta, &agg_size);
 	add_sta_cmd.station_flags |=
 		cpu_to_le32(agg_size << STA_FLG_MAX_AGG_SIZE_SHIFT);
 	add_sta_cmd.station_flags |=
 		cpu_to_le32(mpdu_dens << STA_FLG_AGG_MPDU_DENS_SHIFT);
+
 	if (mvm_sta->sta_state >= IEEE80211_STA_ASSOC)
 		add_sta_cmd.assoc_id = cpu_to_le16(sta->aid);
 
 	if (sta->wme) {
 		add_sta_cmd.modify_mask |= STA_MODIFY_UAPSD_ACS;
-
-		if (sta->uapsd_queues & IEEE80211_WMM_IE_STA_QOSINFO_AC_BK)
-			add_sta_cmd.uapsd_acs |= BIT(AC_BK);
-		if (sta->uapsd_queues & IEEE80211_WMM_IE_STA_QOSINFO_AC_BE)
-			add_sta_cmd.uapsd_acs |= BIT(AC_BE);
-		if (sta->uapsd_queues & IEEE80211_WMM_IE_STA_QOSINFO_AC_VI)
-			add_sta_cmd.uapsd_acs |= BIT(AC_VI);
-		if (sta->uapsd_queues & IEEE80211_WMM_IE_STA_QOSINFO_AC_VO)
-			add_sta_cmd.uapsd_acs |= BIT(AC_VO);
-		add_sta_cmd.uapsd_acs |= add_sta_cmd.uapsd_acs << 4;
+		add_sta_cmd.uapsd_acs = iwl_mvm_get_sta_uapsd_acs(sta);
 		add_sta_cmd.sp_length = sta->max_sp ? sta->max_sp * 2 : 128;
 	}
 
-- 
2.38.1

