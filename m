Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 680804AA7D9
	for <lists+linux-wireless@lfdr.de>; Sat,  5 Feb 2022 10:21:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346371AbiBEJVx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 5 Feb 2022 04:21:53 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:37998 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1347508AbiBEJVw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 5 Feb 2022 04:21:52 -0500
Received: from 91-156-4-210.elisa-laajakaista.fi ([91.156.4.210] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <luca@coelho.fi>)
        id 1nGHGQ-0006b7-H6;
        Sat, 05 Feb 2022 11:21:51 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@kernel.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sat,  5 Feb 2022 11:21:36 +0200
Message-Id: <iwlwifi.20220205112029.48a508dfffef.If392e44d88f96ebed7fadf827e327194d4bd97b1@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220205092140.751171-1-luca@coelho.fi>
References: <20220205092140.751171-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
Subject: [PATCH 08/12] iwlwifi: mvm: refactor setting PPE thresholds in STA_HE_CTXT_CMD
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Miri Korenblit <miriam.rachel.korenblit@intel.com>

We are setting the PPE Thresholds in STA_HE_CTXT_CMD according
to HE PHY Capabilities IE. As EHT is introduced, we will have to
set this thresholds according to EHT PHY Capabilities IE if we're
in an EHT connection. Some parts of the code can be used for both
HE and EHT. Put this parts in functions which will be used in the
patch which adds support for EHT PPE.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 204 ++++++++++--------
 include/linux/ieee80211.h                     |   3 +-
 2 files changed, 115 insertions(+), 92 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 1d74e8b3576a..8b0124a40ee9 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2012-2014, 2018-2021 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2022 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -2086,6 +2086,103 @@ static u8 iwl_mvm_he_get_ppe_val(u8 *ppe, u8 ppe_pos_bit)
 	return res;
 }
 
+static void iwl_mvm_parse_ppe(struct iwl_mvm *mvm,
+			      struct iwl_he_pkt_ext_v2 *pkt_ext, u8 nss,
+			      u8 ru_index_bitmap, u8 *ppe, u8 ppe_pos_bit)
+{
+	int i;
+
+	/*
+	* FW currently supports only nss == MAX_HE_SUPP_NSS
+	*
+	* If nss > MAX: we can ignore values we don't support
+	* If nss < MAX: we can set zeros in other streams
+	*/
+	if (nss > MAX_HE_SUPP_NSS) {
+		IWL_INFO(mvm, "Got NSS = %d - trimming to %d\n", nss,
+			 MAX_HE_SUPP_NSS);
+		nss = MAX_HE_SUPP_NSS;
+	}
+
+	for (i = 0; i < nss; i++) {
+		u8 ru_index_tmp = ru_index_bitmap << 1;
+		u8 low_th = IWL_HE_PKT_EXT_NONE, high_th = IWL_HE_PKT_EXT_NONE;
+		u8 bw;
+
+		for (bw = 0;
+		     bw < ARRAY_SIZE(pkt_ext->pkt_ext_qam_th[i]);
+		     bw++) {
+			ru_index_tmp >>= 1;
+
+			if (!(ru_index_tmp & 1))
+				continue;
+
+			high_th = iwl_mvm_he_get_ppe_val(ppe, ppe_pos_bit);
+			ppe_pos_bit += IEEE80211_PPE_THRES_INFO_PPET_SIZE;
+			low_th = iwl_mvm_he_get_ppe_val(ppe, ppe_pos_bit);
+			ppe_pos_bit += IEEE80211_PPE_THRES_INFO_PPET_SIZE;
+
+			pkt_ext->pkt_ext_qam_th[i][bw][0] = low_th;
+			pkt_ext->pkt_ext_qam_th[i][bw][1] = high_th;
+		}
+	}
+}
+
+static void iwl_mvm_set_pkt_ext_from_he_ppe(struct iwl_mvm *mvm,
+					    struct ieee80211_sta *sta,
+					    struct iwl_he_pkt_ext_v2 *pkt_ext)
+{
+	u8 nss = (sta->he_cap.ppe_thres[0] & IEEE80211_PPE_THRES_NSS_MASK) + 1;
+	u8 *ppe = &sta->he_cap.ppe_thres[0];
+	u8 ru_index_bitmap =
+		u8_get_bits(*ppe,
+			    IEEE80211_PPE_THRES_RU_INDEX_BITMASK_MASK);
+	/* Starting after PPE header */
+	u8 ppe_pos_bit = IEEE80211_HE_PPE_THRES_INFO_HEADER_SIZE;
+
+	iwl_mvm_parse_ppe(mvm, pkt_ext, nss, ru_index_bitmap, ppe, ppe_pos_bit);
+}
+
+static void iwl_mvm_set_pkt_ext_from_nominal_padding(struct iwl_he_pkt_ext_v2 *pkt_ext,
+						     u8 nominal_padding,
+						     u32 *flags)
+{
+	int low_th = -1;
+	int high_th = -1;
+	int i;
+
+	switch (nominal_padding) {
+	case IEEE80211_HE_PHY_CAP9_NOMINAL_PKT_PADDING_0US:
+		low_th = IWL_HE_PKT_EXT_NONE;
+		high_th = IWL_HE_PKT_EXT_NONE;
+		break;
+	case IEEE80211_HE_PHY_CAP9_NOMINAL_PKT_PADDING_8US:
+		low_th = IWL_HE_PKT_EXT_BPSK;
+		high_th = IWL_HE_PKT_EXT_NONE;
+		break;
+	case IEEE80211_HE_PHY_CAP9_NOMINAL_PKT_PADDING_16US:
+		low_th = IWL_HE_PKT_EXT_NONE;
+		high_th = IWL_HE_PKT_EXT_BPSK;
+		break;
+	}
+
+	/* Set the PPE thresholds accordingly */
+	if (low_th >= 0 && high_th >= 0) {
+		for (i = 0; i < MAX_HE_SUPP_NSS; i++) {
+			u8 bw;
+
+			for (bw = 0;
+			     bw < ARRAY_SIZE(pkt_ext->pkt_ext_qam_th[i]);
+			     bw++) {
+				pkt_ext->pkt_ext_qam_th[i][bw][0] = low_th;
+				pkt_ext->pkt_ext_qam_th[i][bw][1] = high_th;
+			}
+		}
+
+		*flags |= STA_CTXT_HE_PACKET_EXT;
+	}
+}
+
 static void iwl_mvm_cfg_he_sta(struct iwl_mvm *mvm,
 			       struct ieee80211_vif *vif, u8 sta_id)
 {
@@ -2195,100 +2292,25 @@ static void iwl_mvm_cfg_he_sta(struct iwl_mvm *mvm,
 	 * Initialize the PPE thresholds to "None" (7), as described in Table
 	 * 9-262ac of 80211.ax/D3.0.
 	 */
-	memset(&sta_ctxt_cmd.pkt_ext, 7, sizeof(sta_ctxt_cmd.pkt_ext));
+	memset(&sta_ctxt_cmd.pkt_ext, IWL_HE_PKT_EXT_NONE,
+	       sizeof(sta_ctxt_cmd.pkt_ext));
 
 	/* If PPE Thresholds exist, parse them into a FW-familiar format. */
 	if (sta->he_cap.he_cap_elem.phy_cap_info[6] &
-	    IEEE80211_HE_PHY_CAP6_PPE_THRESHOLD_PRESENT) {
-		u8 nss = (sta->he_cap.ppe_thres[0] &
-			  IEEE80211_PPE_THRES_NSS_MASK) + 1;
-		u8 ru_index_bitmap =
-			(sta->he_cap.ppe_thres[0] &
-			 IEEE80211_PPE_THRES_RU_INDEX_BITMASK_MASK) >>
-			IEEE80211_PPE_THRES_RU_INDEX_BITMASK_POS;
-		u8 *ppe = &sta->he_cap.ppe_thres[0];
-		u8 ppe_pos_bit = 7; /* Starting after PPE header */
-
-		/*
-		 * FW currently supports only nss == MAX_HE_SUPP_NSS
-		 *
-		 * If nss > MAX: we can ignore values we don't support
-		 * If nss < MAX: we can set zeros in other streams
-		 */
-		if (nss > MAX_HE_SUPP_NSS) {
-			IWL_INFO(mvm, "Got NSS = %d - trimming to %d\n", nss,
-				 MAX_HE_SUPP_NSS);
-			nss = MAX_HE_SUPP_NSS;
-		}
-
-		for (i = 0; i < nss; i++) {
-			u8 ru_index_tmp = ru_index_bitmap << 1;
-			u8 bw;
-
-			for (bw = 0;
-			     bw < ARRAY_SIZE(sta_ctxt_cmd.pkt_ext.pkt_ext_qam_th[i]);
-			     bw++) {
-				ru_index_tmp >>= 1;
-				if (!(ru_index_tmp & 1))
-					continue;
-
-				sta_ctxt_cmd.pkt_ext.pkt_ext_qam_th[i][bw][1] =
-					iwl_mvm_he_get_ppe_val(ppe,
-							       ppe_pos_bit);
-				ppe_pos_bit +=
-					IEEE80211_PPE_THRES_INFO_PPET_SIZE;
-				sta_ctxt_cmd.pkt_ext.pkt_ext_qam_th[i][bw][0] =
-					iwl_mvm_he_get_ppe_val(ppe,
-							       ppe_pos_bit);
-				ppe_pos_bit +=
-					IEEE80211_PPE_THRES_INFO_PPET_SIZE;
-			}
-		}
-
+		IEEE80211_HE_PHY_CAP6_PPE_THRESHOLD_PRESENT) {
+		iwl_mvm_set_pkt_ext_from_he_ppe(mvm, sta,
+						&sta_ctxt_cmd.pkt_ext);
 		flags |= STA_CTXT_HE_PACKET_EXT;
-	} else if (u8_get_bits(sta->he_cap.he_cap_elem.phy_cap_info[9],
-			       IEEE80211_HE_PHY_CAP9_NOMINAL_PKT_PADDING_MASK)
-		   != IEEE80211_HE_PHY_CAP9_NOMINAL_PKT_PADDING_RESERVED) {
-		int low_th = -1;
-		int high_th = -1;
-
-		/* Take the PPE thresholds from the nominal padding info */
-		switch (u8_get_bits(sta->he_cap.he_cap_elem.phy_cap_info[9],
-				    IEEE80211_HE_PHY_CAP9_NOMINAL_PKT_PADDING_MASK)) {
-		case IEEE80211_HE_PHY_CAP9_NOMINAL_PKT_PADDING_0US:
-			low_th = IWL_HE_PKT_EXT_NONE;
-			high_th = IWL_HE_PKT_EXT_NONE;
-			break;
-		case IEEE80211_HE_PHY_CAP9_NOMINAL_PKT_PADDING_8US:
-			low_th = IWL_HE_PKT_EXT_BPSK;
-			high_th = IWL_HE_PKT_EXT_NONE;
-			break;
-		case IEEE80211_HE_PHY_CAP9_NOMINAL_PKT_PADDING_16US:
-			low_th = IWL_HE_PKT_EXT_NONE;
-			high_th = IWL_HE_PKT_EXT_BPSK;
-			break;
-		}
-
-		/* Set the PPE thresholds accordingly */
-		if (low_th >= 0 && high_th >= 0) {
-			struct iwl_he_pkt_ext_v2 *pkt_ext =
-				&sta_ctxt_cmd.pkt_ext;
-
-			for (i = 0; i < MAX_HE_SUPP_NSS; i++) {
-				u8 bw;
-
-				for (bw = 0;
-				     bw < ARRAY_SIZE(pkt_ext->pkt_ext_qam_th[i]);
-				     bw++) {
-					pkt_ext->pkt_ext_qam_th[i][bw][0] =
-						low_th;
-					pkt_ext->pkt_ext_qam_th[i][bw][1] =
-						high_th;
-				}
-			}
-
-			flags |= STA_CTXT_HE_PACKET_EXT;
-		}
+	/* PPE Thresholds doesn't exist - set the API PPE values
+	* according to Common Nominal Packet Padding fiels. */
+	} else {
+		u8 nominal_padding =
+			u8_get_bits(sta->he_cap.he_cap_elem.phy_cap_info[9],
+				    IEEE80211_HE_PHY_CAP9_NOMINAL_PKT_PADDING_MASK);
+		if (nominal_padding != IEEE80211_HE_PHY_CAP9_NOMINAL_PKT_PADDING_RESERVED)
+			iwl_mvm_set_pkt_ext_from_nominal_padding(&sta_ctxt_cmd.pkt_ext,
+								 nominal_padding,
+								 &flags);
 	}
 
 	if (sta->he_cap.he_cap_elem.mac_cap_info[2] &
diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index 60ee7b3f58e7..338c9635b304 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -9,7 +9,7 @@
  * Copyright (c) 2006, Michael Wu <flamingice@sourmilk.net>
  * Copyright (c) 2013 - 2014 Intel Mobile Communications GmbH
  * Copyright (c) 2016 - 2017 Intel Deutschland GmbH
- * Copyright (c) 2018 - 2021 Intel Corporation
+ * Copyright (c) 2018 - 2022 Intel Corporation
  */
 
 #ifndef LINUX_IEEE80211_H
@@ -2309,6 +2309,7 @@ ieee80211_he_mcs_nss_size(const struct ieee80211_he_cap_elem *he_cap)
 #define IEEE80211_PPE_THRES_RU_INDEX_BITMASK_MASK		0x78
 #define IEEE80211_PPE_THRES_RU_INDEX_BITMASK_POS		(3)
 #define IEEE80211_PPE_THRES_INFO_PPET_SIZE			(3)
+#define IEEE80211_HE_PPE_THRES_INFO_HEADER_SIZE			(7)
 
 /*
  * Calculate 802.11ax HE capabilities IE PPE field size
-- 
2.34.1

