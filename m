Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34E49631555
	for <lists+linux-wireless@lfdr.de>; Sun, 20 Nov 2022 18:01:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbiKTRBr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 20 Nov 2022 12:01:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbiKTRBl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 20 Nov 2022 12:01:41 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FA722B27E
        for <linux-wireless@vger.kernel.org>; Sun, 20 Nov 2022 09:01:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668963699; x=1700499699;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wlJedpnhcSF11vEoHFYCg+Ie7FnQHSs+L/w3xOLPG3o=;
  b=lQ8OrRH76jH9m/pkR2E4/IcLafhvJLrbm/SZCR9vpaRFp4j9L0+O9W0+
   qDjlKC2BKOGLvWKjojL6ouoh8ovpqQEPq8ECc3x4btq0jprFLDbz+bV0r
   HIisWRI/vZHH7QBUP04BHTnQTRLqtpCQL+sRtGjmrru5NJy1iLUaYAHOL
   wslMHCI/I9ppO7sOHljSq53L0qLSjirywf+iXAC6Y8j0MJ73IvlG6KMbG
   yzt0GvE3nfgQ/6j6LR1tygjLIpHmgOBhT9A+OCNaopb8I+XNbdwxYs5pj
   48q4e8ihIKMXmWuZXSUUjPhjL2HqbW8LOP2+wI5pizNH2IGL0bnV38PFg
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10537"; a="315234883"
X-IronPort-AV: E=Sophos;i="5.96,179,1665471600"; 
   d="scan'208";a="315234883"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2022 09:01:39 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10537"; a="765719499"
X-IronPort-AV: E=Sophos;i="5.96,179,1665471600"; 
   d="scan'208";a="765719499"
Received: from dwiener-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.249.87.2])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2022 09:01:37 -0800
From:   gregory.greenman@intel.com
To:     kvalo@kernel.org, johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Miri Korenblit <miriam.rachel.korenblit@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 5/9] wifi: iwlwifi: mvm: support PPE Thresholds for EHT
Date:   Sun, 20 Nov 2022 19:00:35 +0200
Message-Id: <20221120185147.465ec02ccd1c.I0bcd5ee35f4d987a49f15501985f90e0d3ce7590@changeid>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221120170039.1788067-1-gregory.greenman@intel.com>
References: <20221120170039.1788067-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Miri Korenblit <miriam.rachel.korenblit@intel.com>

In an EHT connection fill in the HE context command
with PPE Thresholds field from EHT Capabilities IE.
If PPE Thresholds field presents only in HE Capabilities IE,
take the thresholds from there.
If it's not present in both - set the Common Nominal Packet Padding
field from EHT Capabilities IE.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 .../net/wireless/intel/iwlwifi/fw/api/mac.h   |   6 +-
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 177 +++++++++++++++---
 2 files changed, 153 insertions(+), 30 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/mac.h b/drivers/net/wireless/intel/iwlwifi/fw/api/mac.h
index 9b7caf968346..e3eda251c728 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/mac.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/mac.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2012-2014, 2018-2021 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2022 Intel Corporation
  * Copyright (C) 2017 Intel Deutschland GmbH
  */
 #ifndef __iwl_fw_api_mac_h__
@@ -398,7 +398,7 @@ struct iwl_he_backoff_conf {
  * @IWL_HE_PKT_EXT_64QAM: 64-QAM
  * @IWL_HE_PKT_EXT_256QAM: 256-QAM
  * @IWL_HE_PKT_EXT_1024QAM: 1024-QAM
- * @IWL_HE_PKT_EXT_RESERVED: reserved value
+ * @IWL_HE_PKT_EXT_4096QAM: 4096-QAM, for EHT only
  * @IWL_HE_PKT_EXT_NONE: not defined
  */
 enum iwl_he_pkt_ext_constellations {
@@ -408,7 +408,7 @@ enum iwl_he_pkt_ext_constellations {
 	IWL_HE_PKT_EXT_64QAM,
 	IWL_HE_PKT_EXT_256QAM,
 	IWL_HE_PKT_EXT_1024QAM,
-	IWL_HE_PKT_EXT_RESERVED,
+	IWL_HE_PKT_EXT_4096QAM,
 	IWL_HE_PKT_EXT_NONE,
 };
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 57aa10466637..3fba69554f83 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -1825,7 +1825,8 @@ static u8 iwl_mvm_he_get_ppe_val(u8 *ppe, u8 ppe_pos_bit)
 
 static void iwl_mvm_parse_ppe(struct iwl_mvm *mvm,
 			      struct iwl_he_pkt_ext_v2 *pkt_ext, u8 nss,
-			      u8 ru_index_bitmap, u8 *ppe, u8 ppe_pos_bit)
+			      u8 ru_index_bitmap, u8 *ppe, u8 ppe_pos_bit,
+			      bool inheritance)
 {
 	int i;
 
@@ -1851,14 +1852,25 @@ static void iwl_mvm_parse_ppe(struct iwl_mvm *mvm,
 		     bw++) {
 			ru_index_tmp >>= 1;
 
-			if (!(ru_index_tmp & 1))
-				continue;
+			/*
+			* According to the 11be spec, if for a specific BW the PPE Thresholds
+			* isn't present - it should inherit the thresholds from the last
+			* BW for which we had PPE Thresholds. In 11ax though, we don't have
+			* this inheritance - continue in this case
+			*/
+			if (!(ru_index_tmp & 1)) {
+				if (inheritance)
+					goto set_thresholds;
+				else
+					continue;
+			}
 
 			high_th = iwl_mvm_he_get_ppe_val(ppe, ppe_pos_bit);
 			ppe_pos_bit += IEEE80211_PPE_THRES_INFO_PPET_SIZE;
 			low_th = iwl_mvm_he_get_ppe_val(ppe, ppe_pos_bit);
 			ppe_pos_bit += IEEE80211_PPE_THRES_INFO_PPET_SIZE;
 
+set_thresholds:
 			pkt_ext->pkt_ext_qam_th[i][bw][0] = low_th;
 			pkt_ext->pkt_ext_qam_th[i][bw][1] = high_th;
 		}
@@ -1867,7 +1879,8 @@ static void iwl_mvm_parse_ppe(struct iwl_mvm *mvm,
 
 static void iwl_mvm_set_pkt_ext_from_he_ppe(struct iwl_mvm *mvm,
 					    struct ieee80211_sta *sta,
-					    struct iwl_he_pkt_ext_v2 *pkt_ext)
+					    struct iwl_he_pkt_ext_v2 *pkt_ext,
+					    bool inheritance)
 {
 	u8 nss = (sta->deflink.he_cap.ppe_thres[0] & IEEE80211_PPE_THRES_NSS_MASK) + 1;
 	u8 *ppe = &sta->deflink.he_cap.ppe_thres[0];
@@ -1877,7 +1890,8 @@ static void iwl_mvm_set_pkt_ext_from_he_ppe(struct iwl_mvm *mvm,
 	/* Starting after PPE header */
 	u8 ppe_pos_bit = IEEE80211_HE_PPE_THRES_INFO_HEADER_SIZE;
 
-	iwl_mvm_parse_ppe(mvm, pkt_ext, nss, ru_index_bitmap, ppe, ppe_pos_bit);
+	iwl_mvm_parse_ppe(mvm, pkt_ext, nss, ru_index_bitmap, ppe, ppe_pos_bit,
+			  inheritance);
 }
 
 static void iwl_mvm_set_pkt_ext_from_nominal_padding(struct iwl_he_pkt_ext_v2 *pkt_ext,
@@ -1888,16 +1902,18 @@ static void iwl_mvm_set_pkt_ext_from_nominal_padding(struct iwl_he_pkt_ext_v2 *p
 	int high_th = -1;
 	int i;
 
+	/* all the macros are the same for EHT and HE */
 	switch (nominal_padding) {
-	case IEEE80211_HE_PHY_CAP9_NOMINAL_PKT_PADDING_0US:
+	case IEEE80211_EHT_PHY_CAP5_COMMON_NOMINAL_PKT_PAD_0US:
 		low_th = IWL_HE_PKT_EXT_NONE;
 		high_th = IWL_HE_PKT_EXT_NONE;
 		break;
-	case IEEE80211_HE_PHY_CAP9_NOMINAL_PKT_PADDING_8US:
+	case IEEE80211_EHT_PHY_CAP5_COMMON_NOMINAL_PKT_PAD_8US:
 		low_th = IWL_HE_PKT_EXT_BPSK;
 		high_th = IWL_HE_PKT_EXT_NONE;
 		break;
-	case IEEE80211_HE_PHY_CAP9_NOMINAL_PKT_PADDING_16US:
+	case IEEE80211_EHT_PHY_CAP5_COMMON_NOMINAL_PKT_PAD_16US:
+	case IEEE80211_EHT_PHY_CAP5_COMMON_NOMINAL_PKT_PAD_20US:
 		low_th = IWL_HE_PKT_EXT_NONE;
 		high_th = IWL_HE_PKT_EXT_BPSK;
 		break;
@@ -1920,6 +1936,31 @@ static void iwl_mvm_set_pkt_ext_from_nominal_padding(struct iwl_he_pkt_ext_v2 *p
 	}
 }
 
+static void iwl_mvm_get_optimal_ppe_info(struct iwl_he_pkt_ext_v2 *pkt_ext,
+					 u8 nominal_padding)
+{
+	int i;
+
+	for (i = 0; i < MAX_HE_SUPP_NSS; i++) {
+		u8 bw;
+
+		for (bw = 0; bw < ARRAY_SIZE(pkt_ext->pkt_ext_qam_th[i]);
+		     bw++) {
+			u8 *qam_th = &pkt_ext->pkt_ext_qam_th[i][bw][0];
+
+			if (nominal_padding >
+			    IEEE80211_EHT_PHY_CAP5_COMMON_NOMINAL_PKT_PAD_8US &&
+			    qam_th[1] == IWL_HE_PKT_EXT_NONE)
+				qam_th[1] = IWL_HE_PKT_EXT_4096QAM;
+			else if (nominal_padding ==
+				 IEEE80211_EHT_PHY_CAP5_COMMON_NOMINAL_PKT_PAD_8US &&
+				 qam_th[0] == IWL_HE_PKT_EXT_NONE &&
+				 qam_th[1] == IWL_HE_PKT_EXT_NONE)
+				qam_th[0] = IWL_HE_PKT_EXT_4096QAM;
+		}
+	}
+}
+
 static void iwl_mvm_cfg_he_sta(struct iwl_mvm *mvm,
 			       struct ieee80211_vif *vif, u8 sta_id)
 {
@@ -1943,6 +1984,7 @@ static void iwl_mvm_cfg_he_sta(struct iwl_mvm *mvm,
 	struct ieee80211_chanctx_conf *chanctx_conf;
 	const struct ieee80211_supported_band *sband;
 	void *cmd;
+	u8 nominal_padding;
 
 	if (!fw_has_api(&mvm->fw->ucode_capa, IWL_UCODE_TLV_API_MBSSID_HE))
 		ver = 1;
@@ -2032,22 +2074,96 @@ static void iwl_mvm_cfg_he_sta(struct iwl_mvm *mvm,
 	memset(&sta_ctxt_cmd.pkt_ext, IWL_HE_PKT_EXT_NONE,
 	       sizeof(sta_ctxt_cmd.pkt_ext));
 
-	/* If PPE Thresholds exist, parse them into a FW-familiar format. */
-	if (sta->deflink.he_cap.he_cap_elem.phy_cap_info[6] &
-		IEEE80211_HE_PHY_CAP6_PPE_THRESHOLD_PRESENT) {
-		iwl_mvm_set_pkt_ext_from_he_ppe(mvm, sta,
-						&sta_ctxt_cmd.pkt_ext);
-		flags |= STA_CTXT_HE_PACKET_EXT;
-	/* PPE Thresholds doesn't exist - set the API PPE values
-	* according to Common Nominal Packet Padding fiels. */
-	} else {
-		u8 nominal_padding =
-			u8_get_bits(sta->deflink.he_cap.he_cap_elem.phy_cap_info[9],
-				    IEEE80211_HE_PHY_CAP9_NOMINAL_PKT_PADDING_MASK);
-		if (nominal_padding != IEEE80211_HE_PHY_CAP9_NOMINAL_PKT_PADDING_RESERVED)
+	if (sta->deflink.eht_cap.has_eht) {
+		nominal_padding =
+			u8_get_bits(sta->deflink.eht_cap.eht_cap_elem.phy_cap_info[5],
+				    IEEE80211_EHT_PHY_CAP5_COMMON_NOMINAL_PKT_PAD_MASK);
+
+		/* If PPE Thresholds exists, parse them into a FW-familiar format. */
+		if (sta->deflink.eht_cap.eht_cap_elem.phy_cap_info[5] &
+		    IEEE80211_EHT_PHY_CAP5_PPE_THRESHOLD_PRESENT) {
+			u8 nss = (sta->deflink.eht_cap.eht_ppe_thres[0] &
+				IEEE80211_EHT_PPE_THRES_NSS_MASK) + 1;
+			u8 *ppe = &sta->deflink.eht_cap.eht_ppe_thres[0];
+			u8 ru_index_bitmap =
+				u16_get_bits(*ppe,
+					     IEEE80211_EHT_PPE_THRES_RU_INDEX_BITMASK_MASK);
+			 /* Starting after PPE header */
+			u8 ppe_pos_bit = IEEE80211_EHT_PPE_THRES_INFO_HEADER_SIZE;
+
+			iwl_mvm_parse_ppe(mvm,
+					  &sta_ctxt_cmd.pkt_ext,
+					  nss, ru_index_bitmap, ppe,
+					  ppe_pos_bit, true);
+			flags |= STA_CTXT_HE_PACKET_EXT;
+		/* EHT PPE Thresholds doesn't exist - set the API according to HE PPE Tresholds*/
+		} else if (sta->deflink.he_cap.he_cap_elem.phy_cap_info[6] &
+			   IEEE80211_HE_PHY_CAP6_PPE_THRESHOLD_PRESENT) {
+			struct iwl_he_pkt_ext_v2 *pkt_ext =
+				&sta_ctxt_cmd.pkt_ext;
+
+			/*
+			* Even though HE Capabilities IE doesn't contain PPE
+			* Thresholds for BW 320Mhz, thresholds for this BW will
+			* be filled in with the same values as 160Mhz, due to
+			* the inheritance, as required.
+			*/
+			iwl_mvm_set_pkt_ext_from_he_ppe(mvm, sta, pkt_ext,
+							true);
+
+			/*
+			* According to the requirements, for MCSs 12-13 the maximum value between
+			* HE PPE Threshold and Common Nominal Packet Padding needs to be taken
+			*/
+			iwl_mvm_get_optimal_ppe_info(pkt_ext, nominal_padding);
+
+			flags |= STA_CTXT_HE_PACKET_EXT;
+
+		/*
+		* if PPE Thresholds doesn't present in both EHT IE and HE IE -
+		* take the Thresholds from Common Nominal Packet Padding field
+		*/
+		} else {
 			iwl_mvm_set_pkt_ext_from_nominal_padding(&sta_ctxt_cmd.pkt_ext,
 								 nominal_padding,
 								 &flags);
+		}
+	} else if (sta->deflink.he_cap.has_he) {
+		/* If PPE Thresholds exist, parse them into a FW-familiar format. */
+		if (sta->deflink.he_cap.he_cap_elem.phy_cap_info[6] &
+			IEEE80211_HE_PHY_CAP6_PPE_THRESHOLD_PRESENT) {
+			iwl_mvm_set_pkt_ext_from_he_ppe(mvm, sta,
+							&sta_ctxt_cmd.pkt_ext,
+							false);
+			flags |= STA_CTXT_HE_PACKET_EXT;
+		/*
+		* PPE Thresholds doesn't exist - set the API PPE values
+		* according to Common Nominal Packet Padding field.
+		*/
+		} else {
+			nominal_padding =
+				u8_get_bits(sta->deflink.he_cap.he_cap_elem.phy_cap_info[9],
+					    IEEE80211_HE_PHY_CAP9_NOMINAL_PKT_PADDING_MASK);
+			if (nominal_padding != IEEE80211_HE_PHY_CAP9_NOMINAL_PKT_PADDING_RESERVED)
+				iwl_mvm_set_pkt_ext_from_nominal_padding(&sta_ctxt_cmd.pkt_ext,
+									 nominal_padding,
+									 &flags);
+		}
+	}
+
+	for (i = 0; i < MAX_HE_SUPP_NSS; i++) {
+		int bw;
+
+		for (bw = 0;
+		     bw < ARRAY_SIZE(sta_ctxt_cmd.pkt_ext.pkt_ext_qam_th[i]);
+		     bw++) {
+			u8 *qam_th =
+				&sta_ctxt_cmd.pkt_ext.pkt_ext_qam_th[i][bw][0];
+
+			IWL_DEBUG_HT(mvm,
+				     "PPE table: nss[%d] bw[%d] PPET8 = %d, PPET16 = %d\n",
+				     i, bw, qam_th[0], qam_th[1]);
+		}
 	}
 
 	if (sta->deflink.he_cap.he_cap_elem.mac_cap_info[2] &
@@ -2195,8 +2311,10 @@ static void iwl_mvm_bss_info_changed_station(struct iwl_mvm *mvm,
 	 * interface was added.
 	 */
 	if (changes & BSS_CHANGED_ASSOC && vif->cfg.assoc) {
-		if (vif->bss_conf.he_support &&
-		    !iwlwifi_mod_params.disable_11ax)
+		if ((vif->bss_conf.he_support &&
+		     !iwlwifi_mod_params.disable_11ax) ||
+		    (vif->bss_conf.eht_support &&
+		     !iwlwifi_mod_params.disable_11be))
 			iwl_mvm_cfg_he_sta(mvm, vif, mvmvif->ap_sta_id);
 
 		iwl_mvm_mac_ctxt_recalc_tsf_id(mvm, vif);
@@ -2204,8 +2322,11 @@ static void iwl_mvm_bss_info_changed_station(struct iwl_mvm *mvm,
 
 	/* Update MU EDCA params */
 	if (changes & BSS_CHANGED_QOS && mvmvif->associated &&
-	    vif->cfg.assoc && vif->bss_conf.he_support &&
-	    !iwlwifi_mod_params.disable_11ax)
+	    vif->cfg.assoc &&
+	    ((vif->bss_conf.he_support &&
+	      !iwlwifi_mod_params.disable_11ax) ||
+	     (vif->bss_conf.eht_support &&
+	      !iwlwifi_mod_params.disable_11be)))
 		iwl_mvm_cfg_he_sta(mvm, vif, mvmvif->ap_sta_id);
 
 	/*
@@ -3218,8 +3339,10 @@ static int iwl_mvm_mac_sta_state(struct ieee80211_hw *hw,
 			vif->bss_conf.he_support = sta->deflink.he_cap.has_he;
 			mvmvif->ap_assoc_sta_count++;
 			iwl_mvm_mac_ctxt_changed(mvm, vif, false, NULL);
-			if (vif->bss_conf.he_support &&
-			    !iwlwifi_mod_params.disable_11ax)
+			if ((vif->bss_conf.he_support &&
+			     !iwlwifi_mod_params.disable_11ax) ||
+			    (vif->bss_conf.eht_support &&
+			     !iwlwifi_mod_params.disable_11be))
 				iwl_mvm_cfg_he_sta(mvm, vif, mvm_sta->sta_id);
 		} else if (vif->type == NL80211_IFTYPE_STATION) {
 			vif->bss_conf.he_support = sta->deflink.he_cap.has_he;
-- 
2.35.3

