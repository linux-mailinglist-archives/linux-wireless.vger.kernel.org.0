Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6E1E709DBD
	for <lists+linux-wireless@lfdr.de>; Fri, 19 May 2023 19:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbjESRUX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 19 May 2023 13:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjESRUW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 19 May 2023 13:20:22 -0400
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E22209E
        for <linux-wireless@vger.kernel.org>; Fri, 19 May 2023 10:20:20 -0700 (PDT)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 371DFC0066
        for <linux-wireless@vger.kernel.org>; Fri, 19 May 2023 17:20:19 +0000 (UTC)
Received: from ben-dt5.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id C854513C2B0;
        Fri, 19 May 2023 10:20:18 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com C854513C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1684516818;
        bh=VCwj91WrDIKyIfnCJBW5t8/DkLjgcVNM8C7PadneZdY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fltFwkcklWYQjWjchozrmc4+5w6SU29l1vn3UeSj/z5+2u2EhwU4UW5h+uVevsMWL
         EYb3HDODlFyKzn9dxrvAvqM+J86hZqU+2vv2BMjPqAsPMb0WLEJMvBc1XoDTo7wZ8h
         kall8QtqNxVFci1wvtx9Yl84Jvhz7UP425A4iwzc=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     Ben Greear <greearb@candelatech.com>
Subject: [PATCH v2 2/2] wifi: iwlwifi:  Add ethtool counters for tx path.
Date:   Fri, 19 May 2023 10:20:15 -0700
Message-Id: <20230519172015.1654252-2-greearb@candelatech.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230519172015.1654252-1-greearb@candelatech.com>
References: <20230519172015.1654252-1-greearb@candelatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1684516819-7cf5kf6BFgyZ
X-MDID-O: us5;ut7;1684516819;7cf5kf6BFgyZ;<greearb@candelatech.com>;f7146c1849a4b08a52804beb1c1cdf45
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>

Provides mcs, nss, he-type, mode, rx-errors and other
counters via ethtool api.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 71 ++++++++++++++++++-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  | 15 ++++
 drivers/net/wireless/intel/iwlwifi/mvm/rx.c   | 24 +++++++
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c | 36 +++++++++-
 4 files changed, 142 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index b7ed4285edd4..a925d3acb8ee 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -6562,6 +6562,50 @@ static const char iwl_mvm_gstrings_stats[][ETH_GSTRING_LEN] = {
 
 	"tx_nss_1",
 	"tx_nss_2",
+
+	/* rx stats */
+	"rx_crc_err",
+	"rx_fifo_underrun",
+	"rx_failed_decrypt",
+	"rx_dup",
+	"rx_bad_header_len",
+
+	"rx_mode_cck",
+	"rx_mode_ofdm",
+	"rx_mode_ht",
+	"rx_mode_vht",
+	"rx_mode_he",
+	"rx_mode_eht",
+
+	"rx_mode_he_su",
+	"rx_mode_he_ext_su",
+	"rx_mode_he_mu",
+	"rx_mode_he_trig",
+
+	"rx_bw_20",
+	"rx_bw_40",
+	"rx_bw_80",
+	"rx_bw_160",
+	"rx_bw_320",
+	"rx_bw_he_ru",
+
+	"rx_mcs_0",
+	"rx_mcs_1",
+	"rx_mcs_2",
+	"rx_mcs_3",
+	"rx_mcs_4",
+	"rx_mcs_5",
+	"rx_mcs_6",
+	"rx_mcs_7",
+	"rx_mcs_8",
+	"rx_mcs_9",
+	"rx_mcs_10",
+	"rx_mcs_11",
+	"rx_mcs_12",
+	"rx_mcs_13",
+
+	"rx_nss_1",
+	"rx_nss_2",
 };
 
 #define IWL_MVM_SSTATS_LEN ARRAY_SIZE(iwl_mvm_gstrings_stats)
@@ -6598,8 +6642,8 @@ void iwl_mvm_get_et_stats(struct ieee80211_hw *hw,
 
 	data[ei++] = mib->tx_status_counts[TX_STATUS_SUCCESS];
 	data[ei++] = mib->tx_bytes_nic;
-	data[ei++] = 0; /* mib->rx_pkts_nic; */
-	data[ei++] = 0; /* mib->rx_bytes_nic; */
+	data[ei++] = mib->rx_pkts;
+	data[ei++] = mib->rx_bytes_nic;
 
 	data[ei++] = mib->tx_mpdu_attempts;
 	data[ei++] = mib->tx_mpdu_fail;
@@ -6655,6 +6699,29 @@ void iwl_mvm_get_et_stats(struct ieee80211_hw *hw,
 	for (i = 0; i < ARRAY_SIZE(mib->tx_nss); i++)
 		data[ei++] = mib->tx_nss[i];
 
+	/* rx counters */
+	data[ei++] = mib->rx_crc_err;
+	data[ei++] = mib->rx_fifo_underrun;
+	data[ei++] = mib->rx_failed_decrypt;
+	data[ei++] = mib->rx_dup;
+	data[ei++] = mib->rx_bad_header_len;
+
+	for (i = 0; i < ARRAY_SIZE(mib->rx_mode); i++)
+		data[ei++] = mib->rx_mode[i];
+
+	for (i = 0; i < ARRAY_SIZE(mib->rx_he_type); i++)
+		data[ei++] = mib->rx_he_type[i];
+
+	for (i = 0; i < ARRAY_SIZE(mib->rx_bw); i++)
+		data[ei++] = mib->rx_bw[i];
+	data[ei++] = mib->rx_bw_he_ru;
+
+	for (i = 0; i < ARRAY_SIZE(mib->rx_mcs); i++)
+		data[ei++] = mib->rx_mcs[i];
+
+	for (i = 0; i < ARRAY_SIZE(mib->rx_nss); i++)
+		data[ei++] = mib->rx_nss[i];
+
 	if (ei != IWL_MVM_SSTATS_LEN)
 		pr_err("ERROR: iwlwifi ethtool stats bug: ei: %d size: %d",
 		       ei, (int)(IWL_MVM_SSTATS_LEN));
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 96ac2cedec50..463bcb852b58 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -597,6 +597,21 @@ struct iwl_mvm_ethtool_stats {
 	u64 tx_bw_106_tone;
 	u64 tx_mcs[14]; /* mcs 0 to mcs 13 */
 	u64 tx_nss[2]; /* tx nss histogram */
+
+	u64 rx_pkts; /* successful rx skb */
+	u64 rx_bytes_nic; /* successful tx bytes */
+	u64 rx_crc_err;
+	u64 rx_fifo_underrun;
+	u64 rx_failed_decrypt;
+	u64 rx_dup;
+	u64 rx_bad_header_len;
+
+	u64 rx_mode[6]; /* cck, ofdm, ht, vht, he, eht */
+	u64 rx_he_type[4]; /* su, ext_su, mu, trig */
+	u64 rx_bw[5]; /* 20, 40, 80, 160, 320 */
+	u64 rx_bw_he_ru;
+	u64 rx_mcs[14]; /* mcs 0 to mcs 13 */
+	u64 rx_nss[2]; /* rx nss histogram */
 };
 
 #define IWL_MVM_NUM_LAST_FRAMES_UCODE_RATES 8
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rx.c b/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
index 196c04701736..f81c7d664c6c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
@@ -300,6 +300,7 @@ void iwl_mvm_rx_rx_mpdu(struct iwl_mvm *mvm, struct napi_struct *napi,
 	u32 rate_n_flags;
 	u32 rx_pkt_status;
 	u8 crypt_len = 0;
+	bool bad_pkt = false;
 
 	if (unlikely(pkt_len < sizeof(*rx_res))) {
 		IWL_DEBUG_DROP(mvm, "Bad REPLY_RX_MPDU_CMD size\n");
@@ -338,6 +339,11 @@ void iwl_mvm_rx_rx_mpdu(struct iwl_mvm *mvm, struct napi_struct *napi,
 	    !(rx_pkt_status & RX_MPDU_RES_STATUS_OVERRUN_OK)) {
 		IWL_DEBUG_RX(mvm, "Bad CRC or FIFO: 0x%08X.\n", rx_pkt_status);
 		rx_status->flag |= RX_FLAG_FAILED_FCS_CRC;
+		if (!(rx_pkt_status & RX_MPDU_RES_STATUS_CRC_OK))
+			mvm->ethtool_stats.rx_crc_err++;
+		else
+			mvm->ethtool_stats.rx_fifo_underrun++;
+		bad_pkt = true;
 	}
 
 	/* This will be used in several places later */
@@ -406,6 +412,7 @@ void iwl_mvm_rx_rx_mpdu(struct iwl_mvm *mvm, struct napi_struct *napi,
 					 &crypt_len)) {
 		IWL_DEBUG_DROP(mvm, "Bad decryption results 0x%08x\n",
 			       rx_pkt_status);
+		mvm->ethtool_stats.rx_failed_decrypt++;
 		kfree_skb(skb);
 		rcu_read_unlock();
 		return;
@@ -495,6 +502,9 @@ void iwl_mvm_rx_rx_mpdu(struct iwl_mvm *mvm, struct napi_struct *napi,
 		rx_status->bw = RATE_INFO_BW_160;
 		break;
 	}
+	mvm->ethtool_stats.rx_bw[(rate_n_flags & RATE_MCS_CHAN_WIDTH_MSK_V1)
+				 >> RATE_MCS_CHAN_WIDTH_POS]++;
+
 	if (!(rate_n_flags & RATE_MCS_CCK_MSK_V1) &&
 	    rate_n_flags & RATE_MCS_SGI_MSK_V1)
 		rx_status->enc_flags |= RX_ENC_FLAG_SHORT_GI;
@@ -508,6 +518,9 @@ void iwl_mvm_rx_rx_mpdu(struct iwl_mvm *mvm, struct napi_struct *napi,
 		rx_status->encoding = RX_ENC_HT;
 		rx_status->rate_idx = rate_n_flags & RATE_HT_MCS_INDEX_MSK_V1;
 		rx_status->enc_flags |= stbc << RX_ENC_FLAG_STBC_SHIFT;
+		mvm->ethtool_stats.rx_mode[2]++;
+		mvm->ethtool_stats.rx_nss[(rx_status->rate_idx / 8)]++;
+		mvm->ethtool_stats.rx_mcs[rx_status->rate_idx % 8]++;
 	} else if (rate_n_flags & RATE_MCS_VHT_MSK_V1) {
 		u8 stbc = (rate_n_flags & RATE_MCS_STBC_MSK) >>
 				RATE_MCS_STBC_POS;
@@ -518,6 +531,9 @@ void iwl_mvm_rx_rx_mpdu(struct iwl_mvm *mvm, struct napi_struct *napi,
 		rx_status->enc_flags |= stbc << RX_ENC_FLAG_STBC_SHIFT;
 		if (rate_n_flags & RATE_MCS_BF_MSK)
 			rx_status->enc_flags |= RX_ENC_FLAG_BF;
+		mvm->ethtool_stats.rx_mode[3]++;
+		mvm->ethtool_stats.rx_nss[rx_status->nss - 1]++;
+		mvm->ethtool_stats.rx_mcs[rx_status->rate_idx]++;
 	} else {
 		int rate = iwl_mvm_legacy_rate_to_mac80211_idx(rate_n_flags,
 							       rx_status->band);
@@ -529,12 +545,20 @@ void iwl_mvm_rx_rx_mpdu(struct iwl_mvm *mvm, struct napi_struct *napi,
 			return;
 		}
 		rx_status->rate_idx = rate;
+		if (rate_n_flags & RATE_MCS_CCK_MSK_V1)
+			mvm->ethtool_stats.rx_mode[0]++;
+		else
+			mvm->ethtool_stats.rx_mode[1]++;
 	}
 
 #ifdef CONFIG_IWLWIFI_DEBUGFS
 	iwl_mvm_update_frame_stats(mvm, rate_n_flags,
 				   rx_status->flag & RX_FLAG_AMPDU_DETAILS);
 #endif
+	if (!bad_pkt) {
+		mvm->ethtool_stats.rx_pkts++;
+		mvm->ethtool_stats.rx_bytes_nic += len;
+	}
 
 	if (unlikely((ieee80211_is_beacon(hdr->frame_control) ||
 		      ieee80211_is_probe_resp(hdr->frame_control)) &&
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
index 8f7194c2bdea..643137380c1e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
@@ -135,8 +135,10 @@ static int iwl_mvm_create_skb(struct iwl_mvm *mvm, struct sk_buff *skb,
 	 */
 	hdrlen += crypt_len;
 
-	if (unlikely(headlen < hdrlen))
+	if (unlikely(headlen < hdrlen)) {
+		mvm->ethtool_stats.rx_bad_header_len++;
 		return -EINVAL;
+	}
 
 	/* Since data doesn't move data while putting data on skb and that is
 	 * the only way we use, data + len is the next place that hdr would be put
@@ -1916,6 +1918,8 @@ static void iwl_mvm_rx_eht(struct iwl_mvm *mvm, struct sk_buff *skb,
 
 	/* specific handling for 320MHz */
 	bw = FIELD_GET(RATE_MCS_CHAN_WIDTH_MSK, rate_n_flags);
+	mvm->ethtool_stats.rx_bw[bw]++;
+	mvm->ethtool_stats.rx_he_type[he_type >> RATE_MCS_HE_TYPE_POS]++;
 	if (bw == RATE_MCS_CHAN_WIDTH_320_VAL)
 		bw += FIELD_GET(IWL_RX_PHY_DATA0_EHT_BW320_SLOT,
 				le32_to_cpu(phy_data->d0));
@@ -2089,7 +2093,11 @@ static void iwl_mvm_rx_he(struct iwl_mvm *mvm, struct sk_buff *skb,
 	    rate_n_flags & RATE_MCS_HE_106T_MSK) {
 		rx_status->bw = RATE_INFO_BW_HE_RU;
 		rx_status->he_ru = NL80211_RATE_INFO_HE_RU_ALLOC_106;
+		mvm->ethtool_stats.rx_bw_he_ru++;
+	} else {
+		mvm->ethtool_stats.rx_bw[rx_status->bw]++;
 	}
+	mvm->ethtool_stats.rx_he_type[he_type >> RATE_MCS_HE_TYPE_POS]++;
 
 	/* actually data is filled in mac80211 */
 	if (he_type == RATE_MCS_HE_TYPE_SU ||
@@ -2348,6 +2356,13 @@ static void iwl_mvm_rx_fill_status(struct iwl_mvm *mvm,
 		break;
 		}
 	}
+
+	mvm->ethtool_stats.rx_mode[format >> RATE_MCS_MOD_TYPE_POS]++;
+	mvm->ethtool_stats.rx_nss[rx_status->nss - 1]++;
+	if (format == RATE_MCS_HT_MSK)
+		mvm->ethtool_stats.rx_mcs[rx_status->rate_idx % 8]++;
+	else
+		mvm->ethtool_stats.rx_mcs[rx_status->rate_idx]++;
 }
 
 /* On FPGA, AP sends beacons/probe resp on all channels causing the station
@@ -2378,6 +2393,7 @@ void iwl_mvm_rx_mpdu_mq(struct iwl_mvm *mvm, struct napi_struct *napi,
 	size_t desc_size;
 	struct iwl_mvm_rx_phy_data phy_data = {};
 	u32 format;
+	bool bad_pkt = false;
 
 	if (unlikely(test_bit(IWL_MVM_STATUS_IN_HW_RESTART, &mvm->status)))
 		return;
@@ -2469,6 +2485,11 @@ void iwl_mvm_rx_mpdu_mq(struct iwl_mvm *mvm, struct napi_struct *napi,
 		IWL_DEBUG_RX(mvm, "Bad CRC or FIFO: 0x%08X.\n",
 			     le32_to_cpu(desc->status));
 		rx_status->flag |= RX_FLAG_FAILED_FCS_CRC;
+		if (!(desc->status & cpu_to_le32(IWL_RX_MPDU_STATUS_CRC_OK)))
+			mvm->ethtool_stats.rx_crc_err++;
+		else
+			mvm->ethtool_stats.rx_fifo_underrun++;
+		bad_pkt = true;
 	}
 
 	/* set the preamble flag if appropriate */
@@ -2543,6 +2564,7 @@ void iwl_mvm_rx_mpdu_mq(struct iwl_mvm *mvm, struct napi_struct *napi,
 			      le32_to_cpu(pkt->len_n_flags), queue,
 			      &crypt_len)) {
 		kfree_skb(skb);
+		mvm->ethtool_stats.rx_failed_decrypt++;
 		goto out;
 	}
 
@@ -2623,6 +2645,7 @@ void iwl_mvm_rx_mpdu_mq(struct iwl_mvm *mvm, struct napi_struct *napi,
 
 		if (iwl_mvm_is_dup(sta, queue, rx_status, hdr, desc)) {
 			kfree_skb(skb);
+			mvm->ethtool_stats.rx_dup++;
 			goto out;
 		}
 
@@ -2671,12 +2694,21 @@ void iwl_mvm_rx_mpdu_mq(struct iwl_mvm *mvm, struct napi_struct *napi,
 		goto out;
 	}
 
+	/* NOTE:  These methods below must (and will) consume the skb if the 'else'
+	 * clause of the if statement will happen.  So should not leak mem
+	 * even though it looks problematic at first glance.
+	 */
 	if (!iwl_mvm_reorder(mvm, napi, queue, sta, skb, desc) &&
 	    (likely(!iwl_mvm_time_sync_frame(mvm, skb, hdr->addr2))) &&
 	    iwl_mvm_is_valid_packet_channel(rx_status, skb)
-	   )
+	   ) {
+		if (!bad_pkt) {
+			mvm->ethtool_stats.rx_pkts++;
+			mvm->ethtool_stats.rx_bytes_nic += len;
+		}
 		iwl_mvm_pass_packet_to_mac80211(mvm, napi, skb, queue, sta,
 						link_sta);
+	}
 out:
 	rcu_read_unlock();
 }
-- 
2.40.0

