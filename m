Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B65695AEBB5
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Sep 2022 16:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240449AbiIFOFc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 6 Sep 2022 10:05:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240944AbiIFOC6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 6 Sep 2022 10:02:58 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D509F60
        for <linux-wireless@vger.kernel.org>; Tue,  6 Sep 2022 06:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662471864; x=1694007864;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tw6NVEHDYAGo0abkaSwnxvNQhQfiJL/krdoUGnD0sTk=;
  b=l1+Yl9V9lfhyeHdtEa90xws/AMk1TF3L1rtthw4Vao4YuktirHZ9Bx0x
   z0BH8WhoXebhuYysmxWtONPxxmlZ1NgsPoW6xImojySfZh/R2PK7koRTn
   KNWRtXR6hI2xZy4fqTQ0Mp4xoji1A1cj83XNmpM9qLFLcaSVIZVwwvPXH
   cgA6ce3vSP1B+JSE8zBEPsyhn8bAOxGvj2m7q3olpP1CBIYXclx5D8xbs
   sK+cC3tKgP7iJT+jg5bt3GT2q0zRLebqOVjmY0UKHmRVHZWtvi/D1kUgQ
   Yi7z++ScPspUoEU16kQta8CYoVTbrjmQnYya14IFFRxJvUNHvzb7JUHeS
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10462"; a="276332692"
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="276332692"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 06:43:21 -0700
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="942459621"
Received: from ygueta-mobl2.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.249.82.178])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 06:43:19 -0700
From:   gregory.greenman@intel.com
To:     kvalo@kernel.org, johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 03/15] wifi: iwlwifi: mvm: rxmq: refactor mac80211 rx_status setting
Date:   Tue,  6 Sep 2022 16:42:07 +0300
Message-Id: <20220906161827.a81580d5e769.I3ee7a1fe1adf8684c48713dbbdc2cbc60bd24cd1@changeid>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220906134219.365090-1-gregory.greenman@intel.com>
References: <20220906134219.365090-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

There's a bunch of duplicated code in the normal data RX and
the no-data RX paths, refactor that.

Note that we're evidently not implementing the 6 GHz band in
the no-data path correctly, need to fix that in firmware
first. Also, we were setting the NSS differently, keep doing
that, but just override the previous values.

Note also that we used to drop frames with bad rate data, to
simplify that just report rate 0 and continue.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c | 356 ++++++++----------
 1 file changed, 165 insertions(+), 191 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
index 2c43a9989783..c0a779867938 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2012-2014, 2018-2021 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2022 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2015-2017 Intel Deutschland GmbH
  */
@@ -1191,16 +1191,22 @@ struct iwl_mvm_rx_phy_data {
 	enum iwl_rx_phy_info_type info_type;
 	__le32 d0, d1, d2, d3;
 	__le16 d4;
+
+	u32 rate_n_flags;
+	u32 gp2_on_air_rise;
+	u16 phy_info;
+	u8 energy_a, energy_b;
+	u8 channel;
 };
 
 static void iwl_mvm_decode_he_mu_ext(struct iwl_mvm *mvm,
 				     struct iwl_mvm_rx_phy_data *phy_data,
-				     u32 rate_n_flags,
 				     struct ieee80211_radiotap_he_mu *he_mu)
 {
 	u32 phy_data2 = le32_to_cpu(phy_data->d2);
 	u32 phy_data3 = le32_to_cpu(phy_data->d3);
 	u16 phy_data4 = le16_to_cpu(phy_data->d4);
+	u32 rate_n_flags = phy_data->rate_n_flags;
 
 	if (FIELD_GET(IWL_RX_PHY_DATA4_HE_MU_EXT_CH1_CRC_OK, phy_data4)) {
 		he_mu->flags1 |=
@@ -1246,7 +1252,6 @@ static void iwl_mvm_decode_he_mu_ext(struct iwl_mvm *mvm,
 
 static void
 iwl_mvm_decode_he_phy_ru_alloc(struct iwl_mvm_rx_phy_data *phy_data,
-			       u32 rate_n_flags,
 			       struct ieee80211_radiotap_he *he,
 			       struct ieee80211_radiotap_he_mu *he_mu,
 			       struct ieee80211_rx_status *rx_status)
@@ -1260,6 +1265,7 @@ iwl_mvm_decode_he_phy_ru_alloc(struct iwl_mvm_rx_phy_data *phy_data,
 	 * the TSF/timers are not be transmitted in HE-MU.
 	 */
 	u8 ru = le32_get_bits(phy_data->d1, IWL_RX_PHY_DATA1_HE_RU_ALLOC_MASK);
+	u32 rate_n_flags = phy_data->rate_n_flags;
 	u32 he_type = rate_n_flags & RATE_MCS_HE_TYPE_MSK_V1;
 	u8 offs = 0;
 
@@ -1331,7 +1337,7 @@ static void iwl_mvm_decode_he_phy_data(struct iwl_mvm *mvm,
 				       struct ieee80211_radiotap_he *he,
 				       struct ieee80211_radiotap_he_mu *he_mu,
 				       struct ieee80211_rx_status *rx_status,
-				       u32 rate_n_flags, int queue)
+				       int queue)
 {
 	switch (phy_data->info_type) {
 	case IWL_RX_PHY_INFO_TYPE_NONE:
@@ -1430,7 +1436,7 @@ static void iwl_mvm_decode_he_phy_data(struct iwl_mvm *mvm,
 			le16_encode_bits(le16_get_bits(phy_data->d4,
 						       IWL_RX_PHY_DATA4_HE_MU_EXT_PREAMBLE_PUNC_TYPE_MASK),
 					 IEEE80211_RADIOTAP_HE_MU_FLAGS2_PUNC_FROM_SIG_A_BW);
-		iwl_mvm_decode_he_mu_ext(mvm, phy_data, rate_n_flags, he_mu);
+		iwl_mvm_decode_he_mu_ext(mvm, phy_data, he_mu);
 		fallthrough;
 	case IWL_RX_PHY_INFO_TYPE_HE_MU:
 		he_mu->flags2 |=
@@ -1444,8 +1450,7 @@ static void iwl_mvm_decode_he_phy_data(struct iwl_mvm *mvm,
 		fallthrough;
 	case IWL_RX_PHY_INFO_TYPE_HE_TB:
 	case IWL_RX_PHY_INFO_TYPE_HE_TB_EXT:
-		iwl_mvm_decode_he_phy_ru_alloc(phy_data, rate_n_flags,
-					       he, he_mu, rx_status);
+		iwl_mvm_decode_he_phy_ru_alloc(phy_data, he, he_mu, rx_status);
 		break;
 	case IWL_RX_PHY_INFO_TYPE_HE_SU:
 		he->data1 |= cpu_to_le16(IEEE80211_RADIOTAP_HE_DATA1_BEAM_CHANGE_KNOWN);
@@ -1461,11 +1466,12 @@ static void iwl_mvm_decode_he_phy_data(struct iwl_mvm *mvm,
 
 static void iwl_mvm_rx_he(struct iwl_mvm *mvm, struct sk_buff *skb,
 			  struct iwl_mvm_rx_phy_data *phy_data,
-			  u32 rate_n_flags, u16 phy_info, int queue)
+			  int queue)
 {
 	struct ieee80211_rx_status *rx_status = IEEE80211_SKB_RXCB(skb);
 	struct ieee80211_radiotap_he *he = NULL;
 	struct ieee80211_radiotap_he_mu *he_mu = NULL;
+	u32 rate_n_flags = phy_data->rate_n_flags;
 	u32 he_type = rate_n_flags & RATE_MCS_HE_TYPE_MSK;
 	u8 stbc, ltf;
 	static const struct ieee80211_radiotap_he known = {
@@ -1484,6 +1490,7 @@ static void iwl_mvm_rx_he(struct iwl_mvm *mvm, struct sk_buff *skb,
 		.flags2 = cpu_to_le16(IEEE80211_RADIOTAP_HE_MU_FLAGS2_PUNC_FROM_SIG_A_BW_KNOWN |
 				      IEEE80211_RADIOTAP_HE_MU_FLAGS2_BW_FROM_SIG_A_BW_KNOWN),
 	};
+	u16 phy_info = phy_data->phy_info;
 
 	he = skb_put_data(skb, &known, sizeof(known));
 	rx_status->flag |= RX_FLAG_RADIOTAP_HE;
@@ -1504,7 +1511,7 @@ static void iwl_mvm_rx_he(struct iwl_mvm *mvm, struct sk_buff *skb,
 
 	if (phy_info & IWL_RX_MPDU_PHY_TSF_OVERLOAD)
 		iwl_mvm_decode_he_phy_data(mvm, phy_data, he, he_mu, rx_status,
-					   rate_n_flags, queue);
+					   queue);
 
 	/* update aggregation data for monitor sake on default queue */
 	if (!queue && (phy_info & IWL_RX_MPDU_PHY_TSF_OVERLOAD) &&
@@ -1661,6 +1668,102 @@ static void iwl_mvm_rx_get_sta_block_tx(void *data, struct ieee80211_sta *sta)
 		rx_sta_csa->all_sta_unblocked = false;
 }
 
+/*
+ * Note: requires also rx_status->band to be prefilled, as well
+ * as phy_data (apart from phy_data->info_type)
+ */
+static void iwl_mvm_rx_fill_status(struct iwl_mvm *mvm,
+				   struct sk_buff *skb,
+				   struct iwl_mvm_rx_phy_data *phy_data,
+				   int queue)
+{
+	struct ieee80211_rx_status *rx_status = IEEE80211_SKB_RXCB(skb);
+	u32 rate_n_flags = phy_data->rate_n_flags;
+	u8 stbc = u32_get_bits(rate_n_flags, RATE_MCS_STBC_MSK);
+	u32 format = rate_n_flags & RATE_MCS_MOD_TYPE_MSK;
+	bool is_sgi;
+
+	phy_data->info_type = IWL_RX_PHY_INFO_TYPE_NONE;
+
+	if (phy_data->phy_info & IWL_RX_MPDU_PHY_TSF_OVERLOAD)
+		phy_data->info_type =
+			le32_get_bits(phy_data->d1,
+				      IWL_RX_PHY_DATA1_INFO_TYPE_MASK);
+
+	/* This may be overridden by iwl_mvm_rx_he() to HE_RU */
+	switch (rate_n_flags & RATE_MCS_CHAN_WIDTH_MSK) {
+	case RATE_MCS_CHAN_WIDTH_20:
+		break;
+	case RATE_MCS_CHAN_WIDTH_40:
+		rx_status->bw = RATE_INFO_BW_40;
+		break;
+	case RATE_MCS_CHAN_WIDTH_80:
+		rx_status->bw = RATE_INFO_BW_80;
+		break;
+	case RATE_MCS_CHAN_WIDTH_160:
+		rx_status->bw = RATE_INFO_BW_160;
+		break;
+	}
+
+	/* must be before L-SIG data */
+	if (format == RATE_MCS_HE_MSK)
+		iwl_mvm_rx_he(mvm, skb, phy_data, queue);
+
+	iwl_mvm_decode_lsig(skb, phy_data);
+
+	rx_status->device_timestamp = phy_data->gp2_on_air_rise;
+	rx_status->freq = ieee80211_channel_to_frequency(phy_data->channel,
+							 rx_status->band);
+	iwl_mvm_get_signal_strength(mvm, rx_status, rate_n_flags,
+				    phy_data->energy_a, phy_data->energy_b);
+
+	if (unlikely(mvm->monitor_on))
+		iwl_mvm_add_rtap_sniffer_config(mvm, skb);
+
+	is_sgi = format == RATE_MCS_HE_MSK ?
+		iwl_he_is_sgi(rate_n_flags) :
+		rate_n_flags & RATE_MCS_SGI_MSK;
+
+	if (!(format == RATE_MCS_CCK_MSK) && is_sgi)
+		rx_status->enc_flags |= RX_ENC_FLAG_SHORT_GI;
+
+	if (rate_n_flags & RATE_MCS_LDPC_MSK)
+		rx_status->enc_flags |= RX_ENC_FLAG_LDPC;
+
+	switch (format) {
+	case RATE_MCS_HT_MSK:
+		rx_status->encoding = RX_ENC_HT;
+		rx_status->rate_idx = RATE_HT_MCS_INDEX(rate_n_flags);
+		rx_status->enc_flags |= stbc << RX_ENC_FLAG_STBC_SHIFT;
+		break;
+	case RATE_MCS_VHT_MSK:
+		rx_status->nss =
+			((rate_n_flags & RATE_MCS_NSS_MSK) >>
+			RATE_MCS_NSS_POS) + 1;
+		rx_status->rate_idx = rate_n_flags & RATE_MCS_CODE_MSK;
+		rx_status->encoding = RX_ENC_VHT;
+		rx_status->enc_flags |= stbc << RX_ENC_FLAG_STBC_SHIFT;
+		if (rate_n_flags & RATE_MCS_BF_MSK)
+			rx_status->enc_flags |= RX_ENC_FLAG_BF;
+		break;
+	case RATE_MCS_HE_MSK:
+		/* handled above */
+		break;
+	default: {
+		int rate = iwl_mvm_legacy_hw_idx_to_mac80211_idx(rate_n_flags,
+								 rx_status->band);
+
+		rx_status->rate_idx = rate;
+
+		if (WARN_ONCE(rate < 0 || rate > 0xFF,
+			      "Invalid rate flags 0x%x, band %d,\n",
+			      rate_n_flags, rx_status->band))
+			rx_status->rate_idx = 0;
+		break;
+		}
+	}
+}
+
 void iwl_mvm_rx_mpdu_mq(struct iwl_mvm *mvm, struct napi_struct *napi,
 			struct iwl_rx_cmd_buffer *rxb, int queue)
 {
@@ -1670,17 +1773,12 @@ void iwl_mvm_rx_mpdu_mq(struct iwl_mvm *mvm, struct napi_struct *napi,
 	struct ieee80211_hdr *hdr;
 	u32 len;
 	u32 pkt_len = iwl_rx_packet_payload_len(pkt);
-	u32 rate_n_flags, gp2_on_air_rise;
-	u16 phy_info;
 	struct ieee80211_sta *sta = NULL;
 	struct sk_buff *skb;
-	u8 crypt_len = 0, channel, energy_a, energy_b;
+	u8 crypt_len = 0;
 	size_t desc_size;
-	struct iwl_mvm_rx_phy_data phy_data = {
-		.info_type = IWL_RX_PHY_INFO_TYPE_NONE,
-	};
+	struct iwl_mvm_rx_phy_data phy_data = {};
 	u32 format;
-	bool is_sgi;
 
 	if (unlikely(test_bit(IWL_MVM_STATUS_IN_HW_RESTART, &mvm->status)))
 		return;
@@ -1696,35 +1794,37 @@ void iwl_mvm_rx_mpdu_mq(struct iwl_mvm *mvm, struct napi_struct *napi,
 	}
 
 	if (mvm->trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_AX210) {
-		rate_n_flags = le32_to_cpu(desc->v3.rate_n_flags);
-		channel = desc->v3.channel;
-		gp2_on_air_rise = le32_to_cpu(desc->v3.gp2_on_air_rise);
-		energy_a = desc->v3.energy_a;
-		energy_b = desc->v3.energy_b;
+		phy_data.rate_n_flags = le32_to_cpu(desc->v3.rate_n_flags);
+		phy_data.channel = desc->v3.channel;
+		phy_data.gp2_on_air_rise = le32_to_cpu(desc->v3.gp2_on_air_rise);
+		phy_data.energy_a = desc->v3.energy_a;
+		phy_data.energy_b = desc->v3.energy_b;
 
 		phy_data.d0 = desc->v3.phy_data0;
 		phy_data.d1 = desc->v3.phy_data1;
 		phy_data.d2 = desc->v3.phy_data2;
 		phy_data.d3 = desc->v3.phy_data3;
 	} else {
-		rate_n_flags = le32_to_cpu(desc->v1.rate_n_flags);
-		channel = desc->v1.channel;
-		gp2_on_air_rise = le32_to_cpu(desc->v1.gp2_on_air_rise);
-		energy_a = desc->v1.energy_a;
-		energy_b = desc->v1.energy_b;
+		phy_data.rate_n_flags = le32_to_cpu(desc->v1.rate_n_flags);
+		phy_data.channel = desc->v1.channel;
+		phy_data.gp2_on_air_rise = le32_to_cpu(desc->v1.gp2_on_air_rise);
+		phy_data.energy_a = desc->v1.energy_a;
+		phy_data.energy_b = desc->v1.energy_b;
 
 		phy_data.d0 = desc->v1.phy_data0;
 		phy_data.d1 = desc->v1.phy_data1;
 		phy_data.d2 = desc->v1.phy_data2;
 		phy_data.d3 = desc->v1.phy_data3;
 	}
+
 	if (iwl_fw_lookup_notif_ver(mvm->fw, LEGACY_GROUP,
 				    REPLY_RX_MPDU_CMD, 0) < 4) {
-		rate_n_flags = iwl_new_rate_from_v1(rate_n_flags);
+		phy_data.rate_n_flags = iwl_new_rate_from_v1(phy_data.rate_n_flags);
 		IWL_DEBUG_DROP(mvm, "Got old format rate, converting. New rate: 0x%x\n",
-			       rate_n_flags);
+			       phy_data.rate_n_flags);
 	}
-	format = rate_n_flags & RATE_MCS_MOD_TYPE_MSK;
+
+	format = phy_data.rate_n_flags & RATE_MCS_MOD_TYPE_MSK;
 
 	len = le16_to_cpu(desc->mpdu_len);
 
@@ -1733,14 +1833,9 @@ void iwl_mvm_rx_mpdu_mq(struct iwl_mvm *mvm, struct napi_struct *napi,
 		return;
 	}
 
-	phy_info = le16_to_cpu(desc->phy_info);
+	phy_data.phy_info = le16_to_cpu(desc->phy_info);
 	phy_data.d4 = desc->phy_data4;
 
-	if (phy_info & IWL_RX_MPDU_PHY_TSF_OVERLOAD)
-		phy_data.info_type =
-			le32_get_bits(phy_data.d1,
-				      IWL_RX_PHY_DATA1_INFO_TYPE_MASK);
-
 	hdr = (void *)(pkt->data + desc_size);
 	/* Dont use dev_alloc_skb(), we'll have enough headroom once
 	 * ieee80211_hdr pulled.
@@ -1763,27 +1858,6 @@ void iwl_mvm_rx_mpdu_mq(struct iwl_mvm *mvm, struct napi_struct *napi,
 
 	rx_status = IEEE80211_SKB_RXCB(skb);
 
-	/* This may be overridden by iwl_mvm_rx_he() to HE_RU */
-	switch (rate_n_flags & RATE_MCS_CHAN_WIDTH_MSK) {
-	case RATE_MCS_CHAN_WIDTH_20:
-		break;
-	case RATE_MCS_CHAN_WIDTH_40:
-		rx_status->bw = RATE_INFO_BW_40;
-		break;
-	case RATE_MCS_CHAN_WIDTH_80:
-		rx_status->bw = RATE_INFO_BW_80;
-		break;
-	case RATE_MCS_CHAN_WIDTH_160:
-		rx_status->bw = RATE_INFO_BW_160;
-		break;
-	}
-
-	if (format == RATE_MCS_HE_MSK)
-		iwl_mvm_rx_he(mvm, skb, &phy_data, rate_n_flags,
-			      phy_info, queue);
-
-	iwl_mvm_decode_lsig(skb, &phy_data);
-
 	/*
 	 * Keep packets with CRC errors (and with overrun) for monitor mode
 	 * (otherwise the firmware discards them) but mark them as bad.
@@ -1794,12 +1868,13 @@ void iwl_mvm_rx_mpdu_mq(struct iwl_mvm *mvm, struct napi_struct *napi,
 			     le32_to_cpu(desc->status));
 		rx_status->flag |= RX_FLAG_FAILED_FCS_CRC;
 	}
+
 	/* set the preamble flag if appropriate */
 	if (format == RATE_MCS_CCK_MSK &&
-	    phy_info & IWL_RX_MPDU_PHY_SHORT_PREAMBLE)
+	    phy_data.phy_info & IWL_RX_MPDU_PHY_SHORT_PREAMBLE)
 		rx_status->enc_flags |= RX_ENC_FLAG_SHORTPRE;
 
-	if (likely(!(phy_info & IWL_RX_MPDU_PHY_TSF_OVERLOAD))) {
+	if (likely(!(phy_data.phy_info & IWL_RX_MPDU_PHY_TSF_OVERLOAD))) {
 		u64 tsf_on_air_rise;
 
 		if (mvm->trans->trans_cfg->device_family >=
@@ -1813,24 +1888,20 @@ void iwl_mvm_rx_mpdu_mq(struct iwl_mvm *mvm, struct napi_struct *napi,
 		rx_status->flag |= RX_FLAG_MACTIME_PLCP_START;
 	}
 
-	rx_status->device_timestamp = gp2_on_air_rise;
 	if (iwl_mvm_is_band_in_rx_supported(mvm)) {
 		u8 band = BAND_IN_RX_STATUS(desc->mac_phy_idx);
 
 		rx_status->band = iwl_mvm_nl80211_band_from_rx_msdu(band);
 	} else {
-		rx_status->band = channel > 14 ? NL80211_BAND_5GHZ :
+		rx_status->band = phy_data.channel > 14 ? NL80211_BAND_5GHZ :
 			NL80211_BAND_2GHZ;
 	}
-	rx_status->freq = ieee80211_channel_to_frequency(channel,
-							 rx_status->band);
-	iwl_mvm_get_signal_strength(mvm, rx_status, rate_n_flags, energy_a,
-				    energy_b);
 
 	/* update aggregation data for monitor sake on default queue */
-	if (!queue && (phy_info & IWL_RX_MPDU_PHY_AMPDU)) {
-		bool toggle_bit = phy_info & IWL_RX_MPDU_PHY_AMPDU_TOGGLE;
+	if (!queue && (phy_data.phy_info & IWL_RX_MPDU_PHY_AMPDU)) {
+		bool toggle_bit;
 
+		toggle_bit = phy_data.phy_info & IWL_RX_MPDU_PHY_AMPDU_TOGGLE;
 		rx_status->flag |= RX_FLAG_AMPDU_DETAILS;
 		/*
 		 * Toggle is switched whenever new aggregation starts. Make
@@ -1846,9 +1917,6 @@ void iwl_mvm_rx_mpdu_mq(struct iwl_mvm *mvm, struct napi_struct *napi,
 		rx_status->ampdu_reference = mvm->ampdu_ref;
 	}
 
-	if (unlikely(mvm->monitor_on))
-		iwl_mvm_add_rtap_sniffer_config(mvm, skb);
-
 	rcu_read_lock();
 
 	if (desc->status & cpu_to_le32(IWL_RX_MPDU_STATUS_SRC_STA_FOUND)) {
@@ -1867,13 +1935,15 @@ void iwl_mvm_rx_mpdu_mq(struct iwl_mvm *mvm, struct napi_struct *napi,
 		sta = ieee80211_find_sta_by_ifaddr(mvm->hw, hdr->addr2, NULL);
 	}
 
-	if (iwl_mvm_rx_crypto(mvm, sta, hdr, rx_status, phy_info, desc,
+	if (iwl_mvm_rx_crypto(mvm, sta, hdr, rx_status, phy_data.phy_info, desc,
 			      le32_to_cpu(pkt->len_n_flags), queue,
 			      &crypt_len)) {
 		kfree_skb(skb);
 		goto out;
 	}
 
+	iwl_mvm_rx_fill_status(mvm, skb, &phy_data, queue);
+
 	if (sta) {
 		struct iwl_mvm_sta *mvmsta = iwl_mvm_sta_from_mac80211(sta);
 		struct ieee80211_vif *tx_blocked_vif =
@@ -1971,43 +2041,6 @@ void iwl_mvm_rx_mpdu_mq(struct iwl_mvm *mvm, struct napi_struct *napi,
 		}
 	}
 
-	is_sgi = format == RATE_MCS_HE_MSK ?
-		iwl_he_is_sgi(rate_n_flags) :
-		rate_n_flags & RATE_MCS_SGI_MSK;
-
-	if (!(format == RATE_MCS_CCK_MSK) && is_sgi)
-		rx_status->enc_flags |= RX_ENC_FLAG_SHORT_GI;
-	if (rate_n_flags & RATE_MCS_LDPC_MSK)
-		rx_status->enc_flags |= RX_ENC_FLAG_LDPC;
-	if (format == RATE_MCS_HT_MSK) {
-		u8 stbc = (rate_n_flags & RATE_MCS_STBC_MSK) >>
-			RATE_MCS_STBC_POS;
-		rx_status->encoding = RX_ENC_HT;
-		rx_status->rate_idx = RATE_HT_MCS_INDEX(rate_n_flags);
-		rx_status->enc_flags |= stbc << RX_ENC_FLAG_STBC_SHIFT;
-	} else if (format == RATE_MCS_VHT_MSK) {
-		u8 stbc = (rate_n_flags & RATE_MCS_STBC_MSK) >>
-			RATE_MCS_STBC_POS;
-		rx_status->nss = ((rate_n_flags & RATE_MCS_NSS_MSK) >>
-			RATE_MCS_NSS_POS) + 1;
-		rx_status->rate_idx = rate_n_flags & RATE_MCS_CODE_MSK;
-		rx_status->encoding = RX_ENC_VHT;
-		rx_status->enc_flags |= stbc << RX_ENC_FLAG_STBC_SHIFT;
-		if (rate_n_flags & RATE_MCS_BF_MSK)
-			rx_status->enc_flags |= RX_ENC_FLAG_BF;
-	} else if (!(format == RATE_MCS_HE_MSK)) {
-		int rate = iwl_mvm_legacy_hw_idx_to_mac80211_idx(rate_n_flags,
-								 rx_status->band);
-
-		if (WARN(rate < 0 || rate > 0xFF,
-			 "Invalid rate flags 0x%x, band %d,\n",
-			 rate_n_flags, rx_status->band)) {
-			kfree_skb(skb);
-			goto out;
-		}
-		rx_status->rate_idx = rate;
-	}
-
 	/* management stuff on default queue */
 	if (!queue) {
 		if (unlikely((ieee80211_is_beacon(hdr->frame_control) ||
@@ -2039,32 +2072,32 @@ void iwl_mvm_rx_monitor_no_data(struct iwl_mvm *mvm, struct napi_struct *napi,
 	struct ieee80211_rx_status *rx_status;
 	struct iwl_rx_packet *pkt = rxb_addr(rxb);
 	struct iwl_rx_no_data *desc = (void *)pkt->data;
-	u32 rate_n_flags = le32_to_cpu(desc->rate);
-	u32 gp2_on_air_rise = le32_to_cpu(desc->on_air_rise_time);
 	u32 rssi = le32_to_cpu(desc->rssi);
 	u32 info_type = le32_to_cpu(desc->info) & RX_NO_DATA_INFO_TYPE_MSK;
-	u16 phy_info = IWL_RX_MPDU_PHY_TSF_OVERLOAD;
 	struct ieee80211_sta *sta = NULL;
 	struct sk_buff *skb;
-	u8 channel, energy_a, energy_b;
-	u32 format;
 	struct iwl_mvm_rx_phy_data phy_data = {
-		.info_type = le32_get_bits(desc->phy_info[1],
-					   IWL_RX_PHY_DATA1_INFO_TYPE_MASK),
 		.d0 = desc->phy_info[0],
 		.d1 = desc->phy_info[1],
+		.phy_info = IWL_RX_MPDU_PHY_TSF_OVERLOAD,
+		.gp2_on_air_rise = le32_to_cpu(desc->on_air_rise_time),
+		.rate_n_flags = le32_to_cpu(desc->rate),
+		.energy_a = u32_get_bits(rssi, RX_NO_DATA_CHAIN_A_MSK),
+		.energy_b = u32_get_bits(rssi, RX_NO_DATA_CHAIN_B_MSK),
+		.channel = u32_get_bits(rssi, RX_NO_DATA_CHANNEL_MSK),
 	};
-	bool is_sgi;
+	u32 format;
 
 	if (iwl_fw_lookup_notif_ver(mvm->fw, DATA_PATH_GROUP,
 				    RX_NO_DATA_NOTIF, 0) < 2) {
 		IWL_DEBUG_DROP(mvm, "Got an old rate format. Old rate: 0x%x\n",
-			       rate_n_flags);
-		rate_n_flags = iwl_new_rate_from_v1(rate_n_flags);
+			       phy_data.rate_n_flags);
+		phy_data.rate_n_flags = iwl_new_rate_from_v1(phy_data.rate_n_flags);
 		IWL_DEBUG_DROP(mvm, " Rate after conversion to the new format: 0x%x\n",
-			       rate_n_flags);
+			       phy_data.rate_n_flags);
 	}
-	format = rate_n_flags & RATE_MCS_MOD_TYPE_MSK;
+
+	format = phy_data.rate_n_flags & RATE_MCS_MOD_TYPE_MSK;
 
 	if (unlikely(iwl_rx_packet_payload_len(pkt) < sizeof(*desc)))
 		return;
@@ -2072,10 +2105,6 @@ void iwl_mvm_rx_monitor_no_data(struct iwl_mvm *mvm, struct napi_struct *napi,
 	if (unlikely(test_bit(IWL_MVM_STATUS_IN_HW_RESTART, &mvm->status)))
 		return;
 
-	energy_a = (rssi & RX_NO_DATA_CHAIN_A_MSK) >> RX_NO_DATA_CHAIN_A_POS;
-	energy_b = (rssi & RX_NO_DATA_CHAIN_B_MSK) >> RX_NO_DATA_CHAIN_B_POS;
-	channel = (rssi & RX_NO_DATA_CHANNEL_MSK) >> RX_NO_DATA_CHANNEL_POS;
-
 	/* Dont use dev_alloc_skb(), we'll have enough headroom once
 	 * ieee80211_hdr pulled.
 	 */
@@ -2106,86 +2135,31 @@ void iwl_mvm_rx_monitor_no_data(struct iwl_mvm *mvm, struct napi_struct *napi,
 		break;
 	}
 
-	/* This may be overridden by iwl_mvm_rx_he() to HE_RU */
-	switch (rate_n_flags & RATE_MCS_CHAN_WIDTH_MSK) {
-	case RATE_MCS_CHAN_WIDTH_20:
-		break;
-	case RATE_MCS_CHAN_WIDTH_40:
-		rx_status->bw = RATE_INFO_BW_40;
-		break;
-	case RATE_MCS_CHAN_WIDTH_80:
-		rx_status->bw = RATE_INFO_BW_80;
-		break;
-	case RATE_MCS_CHAN_WIDTH_160:
-		rx_status->bw = RATE_INFO_BW_160;
-		break;
-	}
-
-	if (format == RATE_MCS_HE_MSK)
-		iwl_mvm_rx_he(mvm, skb, &phy_data, rate_n_flags,
-			      phy_info, queue);
-
-	iwl_mvm_decode_lsig(skb, &phy_data);
-
-	rx_status->device_timestamp = gp2_on_air_rise;
-	rx_status->band = channel > 14 ? NL80211_BAND_5GHZ :
+	rx_status->band = phy_data.channel > 14 ? NL80211_BAND_5GHZ :
 		NL80211_BAND_2GHZ;
-	rx_status->freq = ieee80211_channel_to_frequency(channel,
-							 rx_status->band);
-	iwl_mvm_get_signal_strength(mvm, rx_status, rate_n_flags, energy_a,
-				    energy_b);
-
-	rcu_read_lock();
 
-	is_sgi = format == RATE_MCS_HE_MSK ?
-		iwl_he_is_sgi(rate_n_flags) :
-		rate_n_flags & RATE_MCS_SGI_MSK;
+	iwl_mvm_rx_fill_status(mvm, skb, &phy_data, queue);
 
-	if (!(format == RATE_MCS_CCK_MSK) && is_sgi)
-		rx_status->enc_flags |= RX_ENC_FLAG_SHORT_GI;
-	if (rate_n_flags & RATE_MCS_LDPC_MSK)
-		rx_status->enc_flags |= RX_ENC_FLAG_LDPC;
-	if (format == RATE_MCS_HT_MSK) {
-		u8 stbc = (rate_n_flags & RATE_MCS_STBC_MSK) >>
-				RATE_MCS_STBC_POS;
-		rx_status->encoding = RX_ENC_HT;
-		rx_status->rate_idx = RATE_HT_MCS_INDEX(rate_n_flags);
-		rx_status->enc_flags |= stbc << RX_ENC_FLAG_STBC_SHIFT;
-	} else if (format == RATE_MCS_VHT_MSK) {
-		u8 stbc = (rate_n_flags & RATE_MCS_STBC_MSK) >>
-				RATE_MCS_STBC_POS;
-		rx_status->rate_idx = rate_n_flags & RATE_MCS_CODE_MSK;
-		rx_status->encoding = RX_ENC_VHT;
-		rx_status->enc_flags |= stbc << RX_ENC_FLAG_STBC_SHIFT;
-		if (rate_n_flags & RATE_MCS_BF_MSK)
-			rx_status->enc_flags |= RX_ENC_FLAG_BF;
-		/*
-		 * take the nss from the rx_vec since the rate_n_flags has
-		 * only 2 bits for the nss which gives a max of 4 ss but
-		 * there may be up to 8 spatial streams
-		 */
+	/*
+	 * Override the nss from the rx_vec since the rate_n_flags has
+	 * only 2 bits for the nss which gives a max of 4 ss but there
+	 * may be up to 8 spatial streams.
+	 */
+	switch (format) {
+	case RATE_MCS_VHT_MSK:
 		rx_status->nss =
 			le32_get_bits(desc->rx_vec[0],
 				      RX_NO_DATA_RX_VEC0_VHT_NSTS_MSK) + 1;
-	} else if (format == RATE_MCS_HE_MSK) {
+		break;
+	case RATE_MCS_HE_MSK:
 		rx_status->nss =
 			le32_get_bits(desc->rx_vec[0],
 				      RX_NO_DATA_RX_VEC0_HE_NSTS_MSK) + 1;
-	} else {
-		int rate = iwl_mvm_legacy_hw_idx_to_mac80211_idx(rate_n_flags,
-							       rx_status->band);
-
-		if (WARN(rate < 0 || rate > 0xFF,
-			 "Invalid rate flags 0x%x, band %d,\n",
-			 rate_n_flags, rx_status->band)) {
-			kfree_skb(skb);
-			goto out;
-		}
-		rx_status->rate_idx = rate;
+		break;
 	}
 
+	rcu_read_lock();
 	ieee80211_rx_napi(mvm->hw, sta, skb, napi);
-out:
 	rcu_read_unlock();
 }
 
-- 
2.35.3

