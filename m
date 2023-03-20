Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EADF36C0F00
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Mar 2023 11:35:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbjCTKfn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Mar 2023 06:35:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231254AbjCTKfU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Mar 2023 06:35:20 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7928A25957
        for <linux-wireless@vger.kernel.org>; Mon, 20 Mar 2023 03:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679308484; x=1710844484;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sL0V8OzzmVJYcIUf2ujAT09JEzApA+uCDHZbtPoio9M=;
  b=gfWob9QMNUTHSK+98u/fcNX+q2KxDikZkwo1R1IGKRZg/s5DrswtZgWk
   eu9IzGiAKi/wkpy5ysePbUdOx5a7mcDQM40OIMGOQWcSbdmidMSCwlnUo
   KdcItrBuzzTPxLTvPJgA63X8SVKG9Y+Arrdrwe1QCWwBRbOuspLRST0t6
   DMVdTiNBDOd5CH43Gj4eHYbZ2gGZj5gZ7lVdjb/ITgOt2W9vYEezLO8Ka
   /iWiZjNV1NSnhqakk0psiTFRroX9OmylRuekBGuZRFPb7U5kJYgkDgq96
   yP/rNrv1hYACajQTvJfLp1uMeLXNZ1nuYH9zzGPPkeQpP2fAaMaRM7iDp
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10654"; a="326997924"
X-IronPort-AV: E=Sophos;i="5.98,274,1673942400"; 
   d="scan'208";a="326997924"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 03:33:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10654"; a="713523682"
X-IronPort-AV: E=Sophos;i="5.98,274,1673942400"; 
   d="scan'208";a="713523682"
Received: from ranikhou-mobl3.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.251.179.26])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 03:33:57 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Miri Korenblit <miriam.rachel.korenblit@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 11/18] wifi: iwlwifi: mvm: refactor iwl_mvm_cfg_he_sta()
Date:   Mon, 20 Mar 2023 12:33:12 +0200
Message-Id: <20230320122330.19b9b6c346ab.I0b8512eb64d8f03ff83879bafe9707f897d5b3c6@changeid>
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

This function sends the STA_HE_CTXT_CMD, which won't be used in the
new MLD API. Instead, a part of the fields of this command
will be in the new STA cmd. Put the parts that are common to both
commands in functions, which will later be used in sending the new
STA cmd.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 287 +++++++++---------
 1 file changed, 147 insertions(+), 140 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index d5708f9ebbe9..6e059027517f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -2023,9 +2023,9 @@ static void iwl_mvm_set_pkt_ext_from_he_ppe(struct iwl_mvm *mvm,
 			  inheritance);
 }
 
-static void iwl_mvm_set_pkt_ext_from_nominal_padding(struct iwl_he_pkt_ext_v2 *pkt_ext,
-						     u8 nominal_padding,
-						     u32 *flags)
+static int
+iwl_mvm_set_pkt_ext_from_nominal_padding(struct iwl_he_pkt_ext_v2 *pkt_ext,
+					 u8 nominal_padding)
 {
 	int low_th = -1;
 	int high_th = -1;
@@ -2048,21 +2048,22 @@ static void iwl_mvm_set_pkt_ext_from_nominal_padding(struct iwl_he_pkt_ext_v2 *p
 		break;
 	}
 
+	if (low_th < 0 || high_th < 0)
+		return -EINVAL;
+
 	/* Set the PPE thresholds accordingly */
-	if (low_th >= 0 && high_th >= 0) {
-		for (i = 0; i < MAX_HE_SUPP_NSS; i++) {
-			u8 bw;
+	for (i = 0; i < MAX_HE_SUPP_NSS; i++) {
+		u8 bw;
 
-			for (bw = 0;
-			     bw < ARRAY_SIZE(pkt_ext->pkt_ext_qam_th[i]);
-			     bw++) {
-				pkt_ext->pkt_ext_qam_th[i][bw][0] = low_th;
-				pkt_ext->pkt_ext_qam_th[i][bw][1] = high_th;
-			}
+		for (bw = 0;
+			bw < ARRAY_SIZE(pkt_ext->pkt_ext_qam_th[i]);
+			bw++) {
+			pkt_ext->pkt_ext_qam_th[i][bw][0] = low_th;
+			pkt_ext->pkt_ext_qam_th[i][bw][1] = high_th;
 		}
-
-		*flags |= STA_CTXT_HE_PACKET_EXT;
 	}
+
+	return 0;
 }
 
 static void iwl_mvm_get_optimal_ppe_info(struct iwl_he_pkt_ext_v2 *pkt_ext,
@@ -2090,6 +2091,103 @@ static void iwl_mvm_get_optimal_ppe_info(struct iwl_he_pkt_ext_v2 *pkt_ext,
 	}
 }
 
+/* Set the pkt_ext field according to PPE Thresholds element */
+static int iwl_mvm_set_sta_pkt_ext(struct iwl_mvm *mvm,
+				   struct ieee80211_sta *sta,
+				   struct iwl_he_pkt_ext_v2 *pkt_ext)
+{
+	u8 nominal_padding;
+	int i, ret = 0;
+
+	/* Initialize the PPE thresholds to "None" (7), as described in Table
+	 * 9-262ac of 80211.ax/D3.0.
+	 */
+	memset(pkt_ext, IWL_HE_PKT_EXT_NONE,
+	       sizeof(struct iwl_he_pkt_ext_v2));
+
+	if (sta->deflink.eht_cap.has_eht) {
+		nominal_padding =
+			u8_get_bits(sta->deflink.eht_cap.eht_cap_elem.phy_cap_info[5],
+				    IEEE80211_EHT_PHY_CAP5_COMMON_NOMINAL_PKT_PAD_MASK);
+
+		/* If PPE Thresholds exists, parse them into a FW-familiar
+		 * format.
+		 */
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
+			iwl_mvm_parse_ppe(mvm, pkt_ext, nss, ru_index_bitmap,
+					  ppe, ppe_pos_bit, true);
+		/* EHT PPE Thresholds doesn't exist - set the API according
+		 * to HE PPE Tresholds
+		 */
+		} else if (sta->deflink.he_cap.he_cap_elem.phy_cap_info[6] &
+			   IEEE80211_HE_PHY_CAP6_PPE_THRESHOLD_PRESENT) {
+			/* Even though HE Capabilities IE doesn't contain PPE
+			 * Thresholds for BW 320Mhz, thresholds for this BW will
+			 * be filled in with the same values as 160Mhz, due to
+			 * the inheritance, as required.
+			 */
+			iwl_mvm_set_pkt_ext_from_he_ppe(mvm, sta, pkt_ext,
+							true);
+
+			/* According to the requirements, for MCSs 12-13 the
+			 * maximum value between HE PPE Threshold and Common
+			 * Nominal Packet Padding needs to be taken
+			 */
+			iwl_mvm_get_optimal_ppe_info(pkt_ext, nominal_padding);
+
+		/* if PPE Thresholds doesn't present in both EHT IE and HE IE -
+		 * take the Thresholds from Common Nominal Packet Padding field
+		 */
+		} else {
+			ret = iwl_mvm_set_pkt_ext_from_nominal_padding(pkt_ext,
+								       nominal_padding);
+		}
+	} else if (sta->deflink.he_cap.has_he) {
+		/* If PPE Thresholds exist, parse them into a FW-familiar format. */
+		if (sta->deflink.he_cap.he_cap_elem.phy_cap_info[6] &
+			IEEE80211_HE_PHY_CAP6_PPE_THRESHOLD_PRESENT) {
+			iwl_mvm_set_pkt_ext_from_he_ppe(mvm, sta, pkt_ext,
+							false);
+		/* PPE Thresholds doesn't exist - set the API PPE values
+		 * according to Common Nominal Packet Padding field.
+		 */
+		} else {
+			nominal_padding =
+				u8_get_bits(sta->deflink.he_cap.he_cap_elem.phy_cap_info[9],
+					    IEEE80211_HE_PHY_CAP9_NOMINAL_PKT_PADDING_MASK);
+			if (nominal_padding != IEEE80211_HE_PHY_CAP9_NOMINAL_PKT_PADDING_RESERVED)
+				ret = iwl_mvm_set_pkt_ext_from_nominal_padding(pkt_ext,
+									       nominal_padding);
+		}
+	}
+
+	for (i = 0; i < MAX_HE_SUPP_NSS; i++) {
+		int bw;
+
+		for (bw = 0;
+		     bw < ARRAY_SIZE(*pkt_ext->pkt_ext_qam_th[i]);
+		     bw++) {
+			u8 *qam_th =
+				&pkt_ext->pkt_ext_qam_th[i][bw][0];
+
+			IWL_DEBUG_HT(mvm,
+				     "PPE table: nss[%d] bw[%d] PPET8 = %d, PPET16 = %d\n",
+				     i, bw, qam_th[0], qam_th[1]);
+		}
+	}
+	return ret;
+}
+
 /*
  * This function sets the MU EDCA parameters ans returns whether MU EDCA
  * is enabled or not
@@ -2141,6 +2239,37 @@ bool iwl_mvm_is_nic_ack_enabled(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 			       IEEE80211_HE_MAC_CAP2_ACK_EN));
 }
 
+static __le32 iwl_mvm_get_sta_htc_flags(struct ieee80211_sta *sta)
+{
+	u8 *mac_cap_info = &sta->deflink.he_cap.he_cap_elem.mac_cap_info[0];
+	__le32 htc_flags = 0;
+
+	if (mac_cap_info[0] & IEEE80211_HE_MAC_CAP0_HTC_HE)
+		htc_flags |= cpu_to_le32(IWL_HE_HTC_SUPPORT);
+	if ((mac_cap_info[1] & IEEE80211_HE_MAC_CAP1_LINK_ADAPTATION) ||
+	    (mac_cap_info[2] & IEEE80211_HE_MAC_CAP2_LINK_ADAPTATION)) {
+		u8 link_adap =
+			((mac_cap_info[2] &
+			  IEEE80211_HE_MAC_CAP2_LINK_ADAPTATION) << 1) +
+			 (mac_cap_info[1] &
+			  IEEE80211_HE_MAC_CAP1_LINK_ADAPTATION);
+
+		if (link_adap == 2)
+			htc_flags |=
+				cpu_to_le32(IWL_HE_HTC_LINK_ADAP_UNSOLICITED);
+		else if (link_adap == 3)
+			htc_flags |= cpu_to_le32(IWL_HE_HTC_LINK_ADAP_BOTH);
+	}
+	if (mac_cap_info[2] & IEEE80211_HE_MAC_CAP2_BSR)
+		htc_flags |= cpu_to_le32(IWL_HE_HTC_BSR_SUPP);
+	if (mac_cap_info[3] & IEEE80211_HE_MAC_CAP3_OMI_CONTROL)
+		htc_flags |= cpu_to_le32(IWL_HE_HTC_OMI_SUPP);
+	if (mac_cap_info[4] & IEEE80211_HE_MAC_CAP4_BQR)
+		htc_flags |= cpu_to_le32(IWL_HE_HTC_BQR_SUPP);
+
+	return htc_flags;
+}
+
 static void iwl_mvm_cfg_he_sta(struct iwl_mvm *mvm,
 			       struct ieee80211_vif *vif, u8 sta_id)
 {
@@ -2161,7 +2290,6 @@ static void iwl_mvm_cfg_he_sta(struct iwl_mvm *mvm,
 	u32 flags;
 	int i;
 	void *cmd;
-	u8 nominal_padding;
 
 	if (!fw_has_api(&mvm->fw->ucode_capa, IWL_UCODE_TLV_API_MBSSID_HE))
 		ver = 1;
@@ -2206,132 +2334,11 @@ static void iwl_mvm_cfg_he_sta(struct iwl_mvm *mvm,
 		flags |= STA_CTXT_HE_RU_2MHZ_BLOCK;
 
 	/* HTC flags */
-	if (sta->deflink.he_cap.he_cap_elem.mac_cap_info[0] &
-	    IEEE80211_HE_MAC_CAP0_HTC_HE)
-		sta_ctxt_cmd.htc_flags |= cpu_to_le32(IWL_HE_HTC_SUPPORT);
-	if ((sta->deflink.he_cap.he_cap_elem.mac_cap_info[1] &
-	      IEEE80211_HE_MAC_CAP1_LINK_ADAPTATION) ||
-	    (sta->deflink.he_cap.he_cap_elem.mac_cap_info[2] &
-	      IEEE80211_HE_MAC_CAP2_LINK_ADAPTATION)) {
-		u8 link_adap =
-			((sta->deflink.he_cap.he_cap_elem.mac_cap_info[2] &
-			  IEEE80211_HE_MAC_CAP2_LINK_ADAPTATION) << 1) +
-			 (sta->deflink.he_cap.he_cap_elem.mac_cap_info[1] &
-			  IEEE80211_HE_MAC_CAP1_LINK_ADAPTATION);
-
-		if (link_adap == 2)
-			sta_ctxt_cmd.htc_flags |=
-				cpu_to_le32(IWL_HE_HTC_LINK_ADAP_UNSOLICITED);
-		else if (link_adap == 3)
-			sta_ctxt_cmd.htc_flags |=
-				cpu_to_le32(IWL_HE_HTC_LINK_ADAP_BOTH);
-	}
-	if (sta->deflink.he_cap.he_cap_elem.mac_cap_info[2] & IEEE80211_HE_MAC_CAP2_BSR)
-		sta_ctxt_cmd.htc_flags |= cpu_to_le32(IWL_HE_HTC_BSR_SUPP);
-	if (sta->deflink.he_cap.he_cap_elem.mac_cap_info[3] &
-	    IEEE80211_HE_MAC_CAP3_OMI_CONTROL)
-		sta_ctxt_cmd.htc_flags |= cpu_to_le32(IWL_HE_HTC_OMI_SUPP);
-	if (sta->deflink.he_cap.he_cap_elem.mac_cap_info[4] & IEEE80211_HE_MAC_CAP4_BQR)
-		sta_ctxt_cmd.htc_flags |= cpu_to_le32(IWL_HE_HTC_BQR_SUPP);
+	sta_ctxt_cmd.htc_flags = iwl_mvm_get_sta_htc_flags(sta);
 
-	/*
-	 * Initialize the PPE thresholds to "None" (7), as described in Table
-	 * 9-262ac of 80211.ax/D3.0.
-	 */
-	memset(&sta_ctxt_cmd.pkt_ext, IWL_HE_PKT_EXT_NONE,
-	       sizeof(sta_ctxt_cmd.pkt_ext));
-
-	if (sta->deflink.eht_cap.has_eht) {
-		nominal_padding =
-			u8_get_bits(sta->deflink.eht_cap.eht_cap_elem.phy_cap_info[5],
-				    IEEE80211_EHT_PHY_CAP5_COMMON_NOMINAL_PKT_PAD_MASK);
-
-		/* If PPE Thresholds exists, parse them into a FW-familiar format. */
-		if (sta->deflink.eht_cap.eht_cap_elem.phy_cap_info[5] &
-		    IEEE80211_EHT_PHY_CAP5_PPE_THRESHOLD_PRESENT) {
-			u8 nss = (sta->deflink.eht_cap.eht_ppe_thres[0] &
-				IEEE80211_EHT_PPE_THRES_NSS_MASK) + 1;
-			u8 *ppe = &sta->deflink.eht_cap.eht_ppe_thres[0];
-			u8 ru_index_bitmap =
-				u16_get_bits(*ppe,
-					     IEEE80211_EHT_PPE_THRES_RU_INDEX_BITMASK_MASK);
-			 /* Starting after PPE header */
-			u8 ppe_pos_bit = IEEE80211_EHT_PPE_THRES_INFO_HEADER_SIZE;
-
-			iwl_mvm_parse_ppe(mvm,
-					  &sta_ctxt_cmd.pkt_ext,
-					  nss, ru_index_bitmap, ppe,
-					  ppe_pos_bit, true);
-			flags |= STA_CTXT_HE_PACKET_EXT;
-		/* EHT PPE Thresholds doesn't exist - set the API according to HE PPE Tresholds*/
-		} else if (sta->deflink.he_cap.he_cap_elem.phy_cap_info[6] &
-			   IEEE80211_HE_PHY_CAP6_PPE_THRESHOLD_PRESENT) {
-			struct iwl_he_pkt_ext_v2 *pkt_ext =
-				&sta_ctxt_cmd.pkt_ext;
-
-			/*
-			* Even though HE Capabilities IE doesn't contain PPE
-			* Thresholds for BW 320Mhz, thresholds for this BW will
-			* be filled in with the same values as 160Mhz, due to
-			* the inheritance, as required.
-			*/
-			iwl_mvm_set_pkt_ext_from_he_ppe(mvm, sta, pkt_ext,
-							true);
-
-			/*
-			* According to the requirements, for MCSs 12-13 the maximum value between
-			* HE PPE Threshold and Common Nominal Packet Padding needs to be taken
-			*/
-			iwl_mvm_get_optimal_ppe_info(pkt_ext, nominal_padding);
-
-			flags |= STA_CTXT_HE_PACKET_EXT;
-
-		/*
-		* if PPE Thresholds doesn't present in both EHT IE and HE IE -
-		* take the Thresholds from Common Nominal Packet Padding field
-		*/
-		} else {
-			iwl_mvm_set_pkt_ext_from_nominal_padding(&sta_ctxt_cmd.pkt_ext,
-								 nominal_padding,
-								 &flags);
-		}
-	} else if (sta->deflink.he_cap.has_he) {
-		/* If PPE Thresholds exist, parse them into a FW-familiar format. */
-		if (sta->deflink.he_cap.he_cap_elem.phy_cap_info[6] &
-			IEEE80211_HE_PHY_CAP6_PPE_THRESHOLD_PRESENT) {
-			iwl_mvm_set_pkt_ext_from_he_ppe(mvm, sta,
-							&sta_ctxt_cmd.pkt_ext,
-							false);
-			flags |= STA_CTXT_HE_PACKET_EXT;
-		/*
-		* PPE Thresholds doesn't exist - set the API PPE values
-		* according to Common Nominal Packet Padding field.
-		*/
-		} else {
-			nominal_padding =
-				u8_get_bits(sta->deflink.he_cap.he_cap_elem.phy_cap_info[9],
-					    IEEE80211_HE_PHY_CAP9_NOMINAL_PKT_PADDING_MASK);
-			if (nominal_padding != IEEE80211_HE_PHY_CAP9_NOMINAL_PKT_PADDING_RESERVED)
-				iwl_mvm_set_pkt_ext_from_nominal_padding(&sta_ctxt_cmd.pkt_ext,
-									 nominal_padding,
-									 &flags);
-		}
-	}
-
-	for (i = 0; i < MAX_HE_SUPP_NSS; i++) {
-		int bw;
-
-		for (bw = 0;
-		     bw < ARRAY_SIZE(sta_ctxt_cmd.pkt_ext.pkt_ext_qam_th[i]);
-		     bw++) {
-			u8 *qam_th =
-				&sta_ctxt_cmd.pkt_ext.pkt_ext_qam_th[i][bw][0];
-
-			IWL_DEBUG_HT(mvm,
-				     "PPE table: nss[%d] bw[%d] PPET8 = %d, PPET16 = %d\n",
-				     i, bw, qam_th[0], qam_th[1]);
-		}
-	}
+	/* PPE Thresholds */
+	if (!iwl_mvm_set_sta_pkt_ext(mvm, sta, &sta_ctxt_cmd.pkt_ext))
+		flags |= STA_CTXT_HE_PACKET_EXT;
 
 	if (sta->deflink.he_cap.he_cap_elem.mac_cap_info[2] &
 	    IEEE80211_HE_MAC_CAP2_32BIT_BA_BITMAP)
-- 
2.38.1

