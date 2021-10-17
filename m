Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C90B430955
	for <lists+linux-wireless@lfdr.de>; Sun, 17 Oct 2021 15:26:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343711AbhJQN2Y (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 17 Oct 2021 09:28:24 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:53870 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1343704AbhJQN2W (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 17 Oct 2021 09:28:22 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1mc6B0-000YdS-OK; Sun, 17 Oct 2021 16:26:11 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sun, 17 Oct 2021 16:25:58 +0300
Message-Id: <iwlwifi.20211017162352.7eb6240b8079.I1e804e70a8ebd23840a9431fc5d2a56ad8d5d1a2@changeid>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211017132604.480251-1-luca@coelho.fi>
References: <20211017132604.480251-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 06/12] iwlwifi: mvm: Support new rate_n_flags for REPLY_RX_MPDU_CMD and RX_NO_DATA_NOTIF
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

As part of the new rate_n_flags this two APIs
may use the new rate. Add support for the new rate.
These two APIs were updated in one patch because both of them
are using the same functions which were changed.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/fw/api/rx.h    |  12 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c | 132 +++++++++++-------
 2 files changed, 86 insertions(+), 58 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/rx.h b/drivers/net/wireless/intel/iwlwifi/fw/api/rx.h
index aa43ef67a2b5..1989b270862b 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/rx.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/rx.h
@@ -445,7 +445,7 @@ struct iwl_rx_mpdu_desc_v1 {
 			__le32 phy_data1;
 		};
 	};
-} __packed;
+} __packed; /* RX_MPDU_RES_START_API_S_VER_4 */
 
 /**
  * struct iwl_rx_mpdu_desc_v3 - RX MPDU descriptor
@@ -545,7 +545,8 @@ struct iwl_rx_mpdu_desc_v3 {
 	 * @reserved: reserved
 	 */
 	__le32 reserved[2];
-} __packed; /* RX_MPDU_RES_START_API_S_VER_3 */
+} __packed; /* RX_MPDU_RES_START_API_S_VER_3,
+	       RX_MPDU_RES_START_API_S_VER_5 */
 
 /**
  * struct iwl_rx_mpdu_desc - RX MPDU descriptor
@@ -610,7 +611,9 @@ struct iwl_rx_mpdu_desc {
 		struct iwl_rx_mpdu_desc_v1 v1;
 		struct iwl_rx_mpdu_desc_v3 v3;
 	};
-} __packed; /* RX_MPDU_RES_START_API_S_VER_3 */
+} __packed; /* RX_MPDU_RES_START_API_S_VER_3,
+	       RX_MPDU_RES_START_API_S_VER_4,
+	       RX_MPDU_RES_START_API_S_VER_5 */
 
 #define IWL_RX_DESC_SIZE_V1 offsetofend(struct iwl_rx_mpdu_desc, v1)
 
@@ -664,7 +667,8 @@ struct iwl_rx_no_data {
 	__le32 rate;
 	__le32 phy_info[2];
 	__le32 rx_vec[2];
-} __packed; /* RX_NO_DATA_NTFY_API_S_VER_1 */
+} __packed; /* RX_NO_DATA_NTFY_API_S_VER_1,
+	       TX_NO_DATA_NTFY_API_S_VER_2 */
 
 struct iwl_frame_release {
 	u8 baid;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
index 8cfec733756b..0f2ff94d5dfb 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
@@ -1440,7 +1440,7 @@ static void iwl_mvm_rx_he(struct iwl_mvm *mvm, struct sk_buff *skb,
 	struct ieee80211_rx_status *rx_status = IEEE80211_SKB_RXCB(skb);
 	struct ieee80211_radiotap_he *he = NULL;
 	struct ieee80211_radiotap_he_mu *he_mu = NULL;
-	u32 he_type = rate_n_flags & RATE_MCS_HE_TYPE_MSK_V1;
+	u32 he_type = rate_n_flags & RATE_MCS_HE_TYPE_MSK;
 	u8 stbc, ltf;
 	static const struct ieee80211_radiotap_he known = {
 		.data1 = cpu_to_le16(IEEE80211_RADIOTAP_HE_DATA1_DATA_MCS_KNOWN |
@@ -1493,23 +1493,23 @@ static void iwl_mvm_rx_he(struct iwl_mvm *mvm, struct sk_buff *skb,
 		}
 	}
 
-	if (he_type == RATE_MCS_HE_TYPE_EXT_SU_V1 &&
-	    rate_n_flags & RATE_MCS_HE_106T_MSK_V1) {
+	if (he_type == RATE_MCS_HE_TYPE_EXT_SU &&
+	    rate_n_flags & RATE_MCS_HE_106T_MSK) {
 		rx_status->bw = RATE_INFO_BW_HE_RU;
 		rx_status->he_ru = NL80211_RATE_INFO_HE_RU_ALLOC_106;
 	}
 
 	/* actually data is filled in mac80211 */
-	if (he_type == RATE_MCS_HE_TYPE_SU_V1 ||
-	    he_type == RATE_MCS_HE_TYPE_EXT_SU_V1)
+	if (he_type == RATE_MCS_HE_TYPE_SU ||
+	    he_type == RATE_MCS_HE_TYPE_EXT_SU)
 		he->data1 |=
 			cpu_to_le16(IEEE80211_RADIOTAP_HE_DATA1_BW_RU_ALLOC_KNOWN);
 
 	stbc = (rate_n_flags & RATE_MCS_STBC_MSK) >> RATE_MCS_STBC_POS;
 	rx_status->nss =
-		((rate_n_flags & RATE_VHT_MCS_NSS_MSK) >>
-					RATE_VHT_MCS_NSS_POS) + 1;
-	rx_status->rate_idx = rate_n_flags & RATE_VHT_MCS_RATE_CODE_MSK;
+		((rate_n_flags & RATE_MCS_NSS_MSK) >>
+		 RATE_MCS_NSS_POS) + 1;
+	rx_status->rate_idx = rate_n_flags & RATE_MCS_CODE_MSK;
 	rx_status->encoding = RX_ENC_HE;
 	rx_status->enc_flags |= stbc << RX_ENC_FLAG_STBC_SHIFT;
 	if (rate_n_flags & RATE_MCS_BF_MSK)
@@ -1520,39 +1520,39 @@ static void iwl_mvm_rx_he(struct iwl_mvm *mvm, struct sk_buff *skb,
 
 #define CHECK_TYPE(F)							\
 	BUILD_BUG_ON(IEEE80211_RADIOTAP_HE_DATA1_FORMAT_ ## F !=	\
-		     (RATE_MCS_HE_TYPE_ ## F ##_V1 >> RATE_MCS_HE_TYPE_POS_V1))
+		     (RATE_MCS_HE_TYPE_ ## F >> RATE_MCS_HE_TYPE_POS))
 
 	CHECK_TYPE(SU);
 	CHECK_TYPE(EXT_SU);
 	CHECK_TYPE(MU);
 	CHECK_TYPE(TRIG);
 
-	he->data1 |= cpu_to_le16(he_type >> RATE_MCS_HE_TYPE_POS_V1);
+	he->data1 |= cpu_to_le16(he_type >> RATE_MCS_HE_TYPE_POS);
 
 	if (rate_n_flags & RATE_MCS_BF_MSK)
 		he->data5 |= cpu_to_le16(IEEE80211_RADIOTAP_HE_DATA5_TXBF);
 
-	switch ((rate_n_flags & RATE_MCS_HE_GI_LTF_MSK_V1) >>
+	switch ((rate_n_flags & RATE_MCS_HE_GI_LTF_MSK) >>
 		RATE_MCS_HE_GI_LTF_POS) {
 	case 0:
-		if (he_type == RATE_MCS_HE_TYPE_TRIG_V1)
+		if (he_type == RATE_MCS_HE_TYPE_TRIG)
 			rx_status->he_gi = NL80211_RATE_INFO_HE_GI_1_6;
 		else
 			rx_status->he_gi = NL80211_RATE_INFO_HE_GI_0_8;
-		if (he_type == RATE_MCS_HE_TYPE_MU_V1)
+		if (he_type == RATE_MCS_HE_TYPE_MU)
 			ltf = IEEE80211_RADIOTAP_HE_DATA5_LTF_SIZE_4X;
 		else
 			ltf = IEEE80211_RADIOTAP_HE_DATA5_LTF_SIZE_1X;
 		break;
 	case 1:
-		if (he_type == RATE_MCS_HE_TYPE_TRIG_V1)
+		if (he_type == RATE_MCS_HE_TYPE_TRIG)
 			rx_status->he_gi = NL80211_RATE_INFO_HE_GI_1_6;
 		else
 			rx_status->he_gi = NL80211_RATE_INFO_HE_GI_0_8;
 		ltf = IEEE80211_RADIOTAP_HE_DATA5_LTF_SIZE_2X;
 		break;
 	case 2:
-		if (he_type == RATE_MCS_HE_TYPE_TRIG_V1) {
+		if (he_type == RATE_MCS_HE_TYPE_TRIG) {
 			rx_status->he_gi = NL80211_RATE_INFO_HE_GI_3_2;
 			ltf = IEEE80211_RADIOTAP_HE_DATA5_LTF_SIZE_4X;
 		} else {
@@ -1561,14 +1561,15 @@ static void iwl_mvm_rx_he(struct iwl_mvm *mvm, struct sk_buff *skb,
 		}
 		break;
 	case 3:
-		if ((he_type == RATE_MCS_HE_TYPE_SU_V1 ||
-		     he_type == RATE_MCS_HE_TYPE_EXT_SU_V1) &&
-		    rate_n_flags & RATE_MCS_SGI_MSK_V1)
-			rx_status->he_gi = NL80211_RATE_INFO_HE_GI_0_8;
-		else
-			rx_status->he_gi = NL80211_RATE_INFO_HE_GI_3_2;
+		rx_status->he_gi = NL80211_RATE_INFO_HE_GI_3_2;
 		ltf = IEEE80211_RADIOTAP_HE_DATA5_LTF_SIZE_4X;
 		break;
+	case 4:
+		rx_status->he_gi = NL80211_RATE_INFO_HE_GI_0_8;
+		ltf = IEEE80211_RADIOTAP_HE_DATA5_LTF_SIZE_4X;
+		break;
+	default:
+		ltf = IEEE80211_RADIOTAP_HE_DATA5_LTF_SIZE_UNKNOWN;
 	}
 
 	he->data5 |= le16_encode_bits(ltf,
@@ -1653,6 +1654,8 @@ void iwl_mvm_rx_mpdu_mq(struct iwl_mvm *mvm, struct napi_struct *napi,
 		.info_type = IWL_RX_PHY_INFO_TYPE_NONE,
 	};
 	bool csi = false;
+	u32 format;
+	bool is_sgi;
 
 	if (unlikely(test_bit(IWL_MVM_STATUS_IN_HW_RESTART, &mvm->status)))
 		return;
@@ -1690,6 +1693,13 @@ void iwl_mvm_rx_mpdu_mq(struct iwl_mvm *mvm, struct napi_struct *napi,
 		phy_data.d2 = desc->v1.phy_data2;
 		phy_data.d3 = desc->v1.phy_data3;
 	}
+	if (iwl_fw_lookup_notif_ver(mvm->fw, LEGACY_GROUP,
+				    REPLY_RX_MPDU_CMD, 0) < 4) {
+		rate_n_flags = iwl_new_rate_from_v1(rate_n_flags);
+		IWL_DEBUG_DROP(mvm, "Got old format rate, converting. New rate: 0x%x\n",
+			       rate_n_flags);
+	}
+	format = rate_n_flags & RATE_MCS_MOD_TYPE_MSK;
 
 	len = le16_to_cpu(desc->mpdu_len);
 
@@ -1729,7 +1739,7 @@ void iwl_mvm_rx_mpdu_mq(struct iwl_mvm *mvm, struct napi_struct *napi,
 	rx_status = IEEE80211_SKB_RXCB(skb);
 
 	/* This may be overridden by iwl_mvm_rx_he() to HE_RU */
-	switch (rate_n_flags & RATE_MCS_CHAN_WIDTH_MSK_V1) {
+	switch (rate_n_flags & RATE_MCS_CHAN_WIDTH_MSK) {
 	case RATE_MCS_CHAN_WIDTH_20:
 		break;
 	case RATE_MCS_CHAN_WIDTH_40:
@@ -1743,7 +1753,7 @@ void iwl_mvm_rx_mpdu_mq(struct iwl_mvm *mvm, struct napi_struct *napi,
 		break;
 	}
 
-	if (rate_n_flags & RATE_MCS_HE_MSK_V1)
+	if (format == RATE_MCS_HE_MSK)
 		iwl_mvm_rx_he(mvm, skb, &phy_data, rate_n_flags,
 			      phy_info, queue);
 
@@ -1760,7 +1770,7 @@ void iwl_mvm_rx_mpdu_mq(struct iwl_mvm *mvm, struct napi_struct *napi,
 		rx_status->flag |= RX_FLAG_FAILED_FCS_CRC;
 	}
 	/* set the preamble flag if appropriate */
-	if (rate_n_flags & RATE_MCS_CCK_MSK_V1 &&
+	if (format == RATE_MCS_CCK_MSK &&
 	    phy_info & IWL_RX_MPDU_PHY_SHORT_PREAMBLE)
 		rx_status->enc_flags |= RX_ENC_FLAG_SHORTPRE;
 
@@ -1936,33 +1946,34 @@ void iwl_mvm_rx_mpdu_mq(struct iwl_mvm *mvm, struct napi_struct *napi,
 		}
 	}
 
-	if (!(rate_n_flags & RATE_MCS_CCK_MSK_V1) &&
-	    rate_n_flags & RATE_MCS_SGI_MSK_V1)
+	is_sgi = format == RATE_MCS_HE_MSK ?
+		iwl_he_is_sgi(rate_n_flags) :
+		rate_n_flags & RATE_MCS_SGI_MSK;
+
+	if (!(format == RATE_MCS_CCK_MSK) && is_sgi)
 		rx_status->enc_flags |= RX_ENC_FLAG_SHORT_GI;
-	if (rate_n_flags & RATE_HT_MCS_GF_MSK)
-		rx_status->enc_flags |= RX_ENC_FLAG_HT_GF;
-	if (rate_n_flags & RATE_MCS_LDPC_MSK_V1)
+	if (rate_n_flags & RATE_MCS_LDPC_MSK)
 		rx_status->enc_flags |= RX_ENC_FLAG_LDPC;
-	if (rate_n_flags & RATE_MCS_HT_MSK_V1) {
+	if (format == RATE_MCS_HT_MSK) {
 		u8 stbc = (rate_n_flags & RATE_MCS_STBC_MSK) >>
-				RATE_MCS_STBC_POS;
+			RATE_MCS_STBC_POS;
 		rx_status->encoding = RX_ENC_HT;
-		rx_status->rate_idx = rate_n_flags & RATE_HT_MCS_INDEX_MSK_V1;
+		rx_status->rate_idx = RATE_HT_MCS_INDEX(rate_n_flags);
 		rx_status->enc_flags |= stbc << RX_ENC_FLAG_STBC_SHIFT;
-	} else if (rate_n_flags & RATE_MCS_VHT_MSK_V1) {
+	} else if (format == RATE_MCS_VHT_MSK) {
 		u8 stbc = (rate_n_flags & RATE_MCS_STBC_MSK) >>
-				RATE_MCS_STBC_POS;
-		rx_status->nss =
-			((rate_n_flags & RATE_VHT_MCS_NSS_MSK) >>
-						RATE_VHT_MCS_NSS_POS) + 1;
-		rx_status->rate_idx = rate_n_flags & RATE_VHT_MCS_RATE_CODE_MSK;
+			RATE_MCS_STBC_POS;
+			rx_status->nss =
+			((rate_n_flags & RATE_MCS_NSS_MSK) >>
+			RATE_MCS_NSS_POS) + 1;
+		rx_status->rate_idx = rate_n_flags & RATE_MCS_CODE_MSK;
 		rx_status->encoding = RX_ENC_VHT;
 		rx_status->enc_flags |= stbc << RX_ENC_FLAG_STBC_SHIFT;
 		if (rate_n_flags & RATE_MCS_BF_MSK)
 			rx_status->enc_flags |= RX_ENC_FLAG_BF;
-	} else if (!(rate_n_flags & RATE_MCS_HE_MSK_V1)) {
-		int rate = iwl_mvm_legacy_rate_to_mac80211_idx(rate_n_flags,
-							       rx_status->band);
+	} else if (!(format == RATE_MCS_HE_MSK)) {
+		int rate = iwl_mvm_legacy_hw_idx_to_mac80211_idx(rate_n_flags,
+								 rx_status->band);
 
 		if (WARN(rate < 0 || rate > 0xFF,
 			 "Invalid rate flags 0x%x, band %d,\n",
@@ -2012,12 +2023,24 @@ void iwl_mvm_rx_monitor_no_data(struct iwl_mvm *mvm, struct napi_struct *napi,
 	struct ieee80211_sta *sta = NULL;
 	struct sk_buff *skb;
 	u8 channel, energy_a, energy_b;
+	u32 format;
 	struct iwl_mvm_rx_phy_data phy_data = {
 		.info_type = le32_get_bits(desc->phy_info[1],
 					   IWL_RX_PHY_DATA1_INFO_TYPE_MASK),
 		.d0 = desc->phy_info[0],
 		.d1 = desc->phy_info[1],
 	};
+	bool is_sgi;
+
+	if (iwl_fw_lookup_notif_ver(mvm->fw, DATA_PATH_GROUP,
+				    RX_NO_DATA_NOTIF, 0) < 2) {
+		IWL_DEBUG_DROP(mvm, "Got an old rate format. Old rate: 0x%x\n",
+			       rate_n_flags);
+		rate_n_flags = iwl_new_rate_from_v1(rate_n_flags);
+		IWL_DEBUG_DROP(mvm, " Rate after conversion to the new format: 0x%x\n",
+			       rate_n_flags);
+	}
+	format = rate_n_flags & RATE_MCS_MOD_TYPE_MSK;
 
 	if (unlikely(iwl_rx_packet_payload_len(pkt) < sizeof(*desc)))
 		return;
@@ -2060,7 +2083,7 @@ void iwl_mvm_rx_monitor_no_data(struct iwl_mvm *mvm, struct napi_struct *napi,
 	}
 
 	/* This may be overridden by iwl_mvm_rx_he() to HE_RU */
-	switch (rate_n_flags & RATE_MCS_CHAN_WIDTH_MSK_V1) {
+	switch (rate_n_flags & RATE_MCS_CHAN_WIDTH_MSK) {
 	case RATE_MCS_CHAN_WIDTH_20:
 		break;
 	case RATE_MCS_CHAN_WIDTH_40:
@@ -2074,7 +2097,7 @@ void iwl_mvm_rx_monitor_no_data(struct iwl_mvm *mvm, struct napi_struct *napi,
 		break;
 	}
 
-	if (rate_n_flags & RATE_MCS_HE_MSK_V1)
+	if (format == RATE_MCS_HE_MSK)
 		iwl_mvm_rx_he(mvm, skb, &phy_data, rate_n_flags,
 			      phy_info, queue);
 
@@ -2090,23 +2113,24 @@ void iwl_mvm_rx_monitor_no_data(struct iwl_mvm *mvm, struct napi_struct *napi,
 
 	rcu_read_lock();
 
-	if (!(rate_n_flags & RATE_MCS_CCK_MSK_V1) &&
-	    rate_n_flags & RATE_MCS_SGI_MSK_V1)
+	is_sgi = format == RATE_MCS_HE_MSK ?
+		iwl_he_is_sgi(rate_n_flags) :
+		rate_n_flags & RATE_MCS_SGI_MSK;
+
+	if (!(format == RATE_MCS_CCK_MSK) && is_sgi)
 		rx_status->enc_flags |= RX_ENC_FLAG_SHORT_GI;
-	if (rate_n_flags & RATE_HT_MCS_GF_MSK)
-		rx_status->enc_flags |= RX_ENC_FLAG_HT_GF;
-	if (rate_n_flags & RATE_MCS_LDPC_MSK_V1)
+	if (rate_n_flags & RATE_MCS_LDPC_MSK)
 		rx_status->enc_flags |= RX_ENC_FLAG_LDPC;
-	if (rate_n_flags & RATE_MCS_HT_MSK_V1) {
+	if (format == RATE_MCS_HT_MSK) {
 		u8 stbc = (rate_n_flags & RATE_MCS_STBC_MSK) >>
 				RATE_MCS_STBC_POS;
 		rx_status->encoding = RX_ENC_HT;
-		rx_status->rate_idx = rate_n_flags & RATE_HT_MCS_INDEX_MSK_V1;
+		rx_status->rate_idx = RATE_HT_MCS_INDEX(rate_n_flags);
 		rx_status->enc_flags |= stbc << RX_ENC_FLAG_STBC_SHIFT;
-	} else if (rate_n_flags & RATE_MCS_VHT_MSK_V1) {
+	} else if (format == RATE_MCS_VHT_MSK) {
 		u8 stbc = (rate_n_flags & RATE_MCS_STBC_MSK) >>
 				RATE_MCS_STBC_POS;
-		rx_status->rate_idx = rate_n_flags & RATE_VHT_MCS_RATE_CODE_MSK;
+		rx_status->rate_idx = rate_n_flags & RATE_MCS_CODE_MSK;
 		rx_status->encoding = RX_ENC_VHT;
 		rx_status->enc_flags |= stbc << RX_ENC_FLAG_STBC_SHIFT;
 		if (rate_n_flags & RATE_MCS_BF_MSK)
@@ -2119,12 +2143,12 @@ void iwl_mvm_rx_monitor_no_data(struct iwl_mvm *mvm, struct napi_struct *napi,
 		rx_status->nss =
 			le32_get_bits(desc->rx_vec[0],
 				      RX_NO_DATA_RX_VEC0_VHT_NSTS_MSK) + 1;
-	} else if (rate_n_flags & RATE_MCS_HE_MSK_V1) {
+	} else if (format == RATE_MCS_HE_MSK) {
 		rx_status->nss =
 			le32_get_bits(desc->rx_vec[0],
 				      RX_NO_DATA_RX_VEC0_HE_NSTS_MSK) + 1;
 	} else {
-		int rate = iwl_mvm_legacy_rate_to_mac80211_idx(rate_n_flags,
+		int rate = iwl_mvm_legacy_hw_idx_to_mac80211_idx(rate_n_flags,
 							       rx_status->band);
 
 		if (WARN(rate < 0 || rate > 0xFF,
-- 
2.33.0

