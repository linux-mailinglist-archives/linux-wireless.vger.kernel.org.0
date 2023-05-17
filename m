Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A1CA707695
	for <lists+linux-wireless@lfdr.de>; Thu, 18 May 2023 01:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbjEQXtw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 17 May 2023 19:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjEQXtr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 17 May 2023 19:49:47 -0400
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0810749E8
        for <linux-wireless@vger.kernel.org>; Wed, 17 May 2023 16:49:43 -0700 (PDT)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 37FC180067
        for <linux-wireless@vger.kernel.org>; Wed, 17 May 2023 23:49:41 +0000 (UTC)
Received: from ben-dt5.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id AA14913C2B0;
        Wed, 17 May 2023 16:49:40 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com AA14913C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1684367380;
        bh=iYuo4P9w2SbIXHwXQCXYXMBYhYCP81XJ3n0VEMV8Qro=;
        h=From:To:Cc:Subject:Date:From;
        b=olJZ3+gxPoHrpQ1N+HJf/fIM0iRVqVmSA1pB4q/zrL3GatHjGmNKcPHFfvsc1rcxs
         jV67s5fGLrhDpGIzkDeXvSTf6rxlvgA0B2D1x/SFuEEvQLrJCrJazdS0fglfU2qEAd
         cvuUvcmG8fJidRGbRwqhpP1s9Y0ncIfA7bc7BLZ4=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     Ben Greear <greearb@candelatech.com>
Subject: [PATCH RFC] wifi: iwlwifi: add ethtool tx stats.
Date:   Wed, 17 May 2023 16:49:35 -0700
Message-Id: <20230517234935.1093920-1-greearb@candelatech.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1684367381-5x6TGy-8GUDi
X-MDID-O: us5;at1;1684367381;5x6TGy-8GUDi;<greearb@candelatech.com>;f7146c1849a4b08a52804beb1c1cdf45
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

Report tx error codes, nss, mcs, bandwidth, mode, he types.

To provide some clues about how transmit path is actually working.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---

This is against recent iwlwifi backports driver.
Only lightly tested at this point.

 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 162 ++++++++++++++++++
 .../wireless/intel/iwlwifi/mvm/mld-mac80211.c |   3 +
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  33 +++-
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c   |  63 ++++++-
 4 files changed, 253 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index bb11cd2c596b..4a287bb193ff 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -6475,12 +6475,174 @@ int iwl_mvm_set_hw_timestamp(struct ieee80211_hw *hw,
 	return ret;
 }
 
+static const char iwl_mvm_gstrings_stats[][ETH_GSTRING_LEN] = {
+	"tx_pkts_nic", /* from driver, phy tx-ok skb */
+	"tx_bytes_nic", /* from driver, phy tx-ok bytes */
+	"rx_pkts_nic", /* from driver, phy rx OK skb */
+	"rx_bytes_nic", /* from driver, phy rx OK bytes */
+
+	"tx_direct_done",
+	"tx_postpone_delay",
+	"tx_postpone_few_bytes",
+	"tx_postpone_bt_prio",
+	"tx_postpone_quiet_period",
+	"tx_postpone_calc_ttak",
+	"tx_fail_internal_x_retry",
+	"tx_fail_short_limit",
+	"tx_fail_long_limit",
+	"tx_fail_underrun",
+	"tx_fail_drain_flow",
+	"tx_fail_rfkill_flush",
+	"tx_fail_life_expire",
+	"tx_fail_dest_ps",
+	"tx_fail_host_aborted",
+	"tx_fail_bt_retry",
+	"tx_fail_sta_invalid",
+	"tx_fail_frag_dropped",
+	"tx_fail_tid_disable",
+	"tx_fail_fifo_flushed",
+	"tx_fail_small_cf_poll",
+	"tx_fail_fw_drop",
+	"tx_fail_color_mismatch",
+	"tx_fail_internal_abort",
+	"tx_fail_unknown_oor",
+
+	"tx_mode_cck",
+	"tx_mode_ofdm",
+	"tx_mode_ht",
+	"tx_mode_vht",
+	"tx_mode_he",
+	"tx_mode_eht",
+
+	"tx_mode_he_su",
+	"tx_mode_he_ext_su",
+	"tx_mode_he_mu",
+	"tx_mode_he_trig",
+
+	"tx_bw_20",
+	"tx_bw_40",
+	"tx_bw_80",
+	"tx_bw_160",
+	"tx_bw_320",
+	"tx_bw_106_tone",
+
+	"tx_mcs_0",
+	"tx_mcs_1",
+	"tx_mcs_2",
+	"tx_mcs_3",
+	"tx_mcs_4",
+	"tx_mcs_5",
+	"tx_mcs_6",
+	"tx_mcs_7",
+	"tx_mcs_8",
+	"tx_mcs_9",
+	"tx_mcs_10",
+	"tx_mcs_11",
+	"tx_mcs_12",
+	"tx_mcs_13",
+
+	"tx_nss_1",
+	"tx_nss_2",
+};
+
+#define IWL_MVM_SSTATS_LEN ARRAY_SIZE(iwl_mvm_gstrings_stats)
+
+void iwl_mvm_get_et_strings(struct ieee80211_hw *hw,
+			    struct ieee80211_vif *vif,
+			    u32 sset, u8 *data)
+{
+	if (sset != ETH_SS_STATS)
+		return;
+
+	memcpy(data, *iwl_mvm_gstrings_stats, sizeof(iwl_mvm_gstrings_stats));
+}
+
+int iwl_mvm_get_et_sset_count(struct ieee80211_hw *hw,
+			      struct ieee80211_vif *vif, int sset)
+{
+	if (sset != ETH_SS_STATS)
+		return 0;
+
+	return IWL_MVM_SSTATS_LEN;
+}
+
+void iwl_mvm_get_et_stats(struct ieee80211_hw *hw,
+			  struct ieee80211_vif *vif,
+			  struct ethtool_stats *stats, u64 *data)
+{
+	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
+
+	int i, ei = 0;
+
+	/* driver phy-wide stats */
+	struct iwl_mvm_ethtool_stats *mib = &mvm->ethtool_stats;
+
+	data[ei++] = mib->tx_status_counts[TX_STATUS_SUCCESS];
+	data[ei++] = mib->tx_bytes_nic;
+	data[ei++] = 0; /* mib->rx_pkts_nic; */
+	data[ei++] = 0; /* mib->rx_bytes_nic; */
+
+	data[ei++] = mib->tx_status_counts[TX_STATUS_DIRECT_DONE];
+	data[ei++] = mib->tx_status_counts[TX_STATUS_POSTPONE_DELAY];
+	data[ei++] = mib->tx_status_counts[TX_STATUS_POSTPONE_FEW_BYTES];
+	data[ei++] = mib->tx_status_counts[TX_STATUS_POSTPONE_BT_PRIO];
+	data[ei++] = mib->tx_status_counts[TX_STATUS_POSTPONE_QUIET_PERIOD];
+	data[ei++] = mib->tx_status_counts[TX_STATUS_POSTPONE_CALC_TTAK];
+	data[ei++] = mib->tx_status_counts[TX_STATUS_FAIL_INTERNAL_CROSSED_RETRY];
+	data[ei++] = mib->tx_status_counts[TX_STATUS_FAIL_SHORT_LIMIT];
+	data[ei++] = mib->tx_status_counts[TX_STATUS_FAIL_LONG_LIMIT];
+	data[ei++] = mib->tx_status_counts[TX_STATUS_FAIL_UNDERRUN];
+	data[ei++] = mib->tx_status_counts[TX_STATUS_FAIL_DRAIN_FLOW];
+	data[ei++] = mib->tx_status_counts[TX_STATUS_FAIL_RFKILL_FLUSH];
+	data[ei++] = mib->tx_status_counts[TX_STATUS_FAIL_LIFE_EXPIRE];
+	data[ei++] = mib->tx_status_counts[TX_STATUS_FAIL_DEST_PS];
+	data[ei++] = mib->tx_status_counts[TX_STATUS_FAIL_HOST_ABORTED];
+	data[ei++] = mib->tx_status_counts[TX_STATUS_FAIL_BT_RETRY];
+	data[ei++] = mib->tx_status_counts[TX_STATUS_FAIL_STA_INVALID];
+	data[ei++] = mib->tx_status_counts[TX_STATUS_FAIL_FRAG_DROPPED];
+	data[ei++] = mib->tx_status_counts[TX_STATUS_FAIL_TID_DISABLE];
+	data[ei++] = mib->tx_status_counts[TX_STATUS_FAIL_FIFO_FLUSHED];
+	data[ei++] = mib->tx_status_counts[TX_STATUS_FAIL_SMALL_CF_POLL];
+	data[ei++] = mib->tx_status_counts[TX_STATUS_FAIL_FW_DROP];
+	data[ei++] = mib->tx_status_counts[TX_STATUS_FAIL_STA_COLOR_MISMATCH];
+	data[ei++] = mib->tx_status_counts[TX_STATUS_INTERNAL_ABORT];
+	/* Failed out-of-range */
+	data[ei++] = mib->tx_status_counts[TX_STATUS_INTERNAL_ABORT + 1];
+
+	data[ei++] = mib->tx_cck;
+	data[ei++] = mib->tx_ofdm;
+	data[ei++] = mib->tx_ht;
+	data[ei++] = mib->tx_vht;
+	data[ei++] = mib->tx_he;
+	data[ei++] = mib->tx_eht;
+
+	for (i = 0; i < ARRAY_SIZE(mib->tx_he_type); i++)
+		data[ei++] = mib->tx_he_type[i];
+
+	for (i = 0; i < ARRAY_SIZE(mib->tx_bw); i++)
+		data[ei++] = mib->tx_bw[i];
+	data[ei++] = mib->tx_bw_106_tone;
+
+	for (i = 0; i < ARRAY_SIZE(mib->tx_mcs); i++)
+		data[ei++] = mib->tx_mcs[i];
+
+	for (i = 0; i < ARRAY_SIZE(mib->tx_nss); i++)
+		data[ei++] = mib->tx_nss[i];
+
+	if (ei != IWL_MVM_SSTATS_LEN)
+		pr_err("ERROR: iwlwifi ethtool stats bug: ei: %d size: %d",
+		       ei, (int)(IWL_MVM_SSTATS_LEN));
+}
+
 const struct ieee80211_ops iwl_mvm_hw_ops = {
 	.tx = iwl_mvm_mac_tx,
 	.wake_tx_queue = iwl_mvm_mac_wake_tx_queue,
 	.ampdu_action = iwl_mvm_mac_ampdu_action,
 	.get_antenna = iwl_mvm_op_get_antenna,
 	.set_antenna = iwl_mvm_op_set_antenna,
+	.get_et_sset_count = iwl_mvm_get_et_sset_count,
+	.get_et_stats = iwl_mvm_get_et_stats,
+	.get_et_strings = iwl_mvm_get_et_strings,
 	.start = iwl_mvm_mac_start,
 	.reconfig_complete = iwl_mvm_mac_reconfig_complete,
 	.stop = iwl_mvm_mac_stop,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
index 2c20f358b02c..3486fae6347b 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
@@ -1165,6 +1165,9 @@ const struct ieee80211_ops iwl_mvm_mld_hw_ops = {
 	.ampdu_action = iwl_mvm_mac_ampdu_action,
 	.get_antenna = iwl_mvm_op_get_antenna,
 	.set_antenna = iwl_mvm_op_set_antenna,
+	.get_et_sset_count = iwl_mvm_get_et_sset_count,
+	.get_et_stats = iwl_mvm_get_et_stats,
+	.get_et_strings = iwl_mvm_get_et_strings,
 	.start = iwl_mvm_mac_start,
 	.reconfig_complete = iwl_mvm_mac_reconfig_complete,
 	.stop = iwl_mvm_mac_stop,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 7a60f5eccaab..a39307a9ea05 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -572,6 +572,27 @@ struct iwl_mvm_cooling_device {
 };
 #endif
 
+struct iwl_mvm_ethtool_stats {
+	u64 tx_bytes_nic; /* successful tx bytes */
+	/* maps to iwl_tx_status enum
+	 * (TX_STATUS_INTERNAL_ABORT + 1) gathers all larger values.
+	 */
+	u64 tx_status_counts[TX_STATUS_INTERNAL_ABORT + 2];
+
+	u64 tx_cck;
+	u64 tx_ofdm;
+	u64 tx_ht;
+	u64 tx_vht;
+	u64 tx_he;
+	u64 tx_eht;
+
+	u64 tx_he_type[4]; /* su, ext_su, mu, trig */
+	u64 tx_bw[5]; /* 20, 40, 80, 160, 320 */
+	u64 tx_bw_106_tone;
+	u64 tx_mcs[14]; /* mcs 0 to mcs 13 */
+	u64 tx_nss[2]; /* tx nss histogram */
+};
+
 #define IWL_MVM_NUM_LAST_FRAMES_UCODE_RATES 8
 
 struct iwl_mvm_frame_stats {
@@ -904,6 +925,7 @@ struct iwl_mvm {
 		struct mvm_statistics_rx_v3 rx_stats_v3;
 		struct mvm_statistics_rx rx_stats;
 	};
+	struct iwl_mvm_ethtool_stats ethtool_stats;
 
 	struct {
 		u64 rx_time;
@@ -1670,7 +1692,8 @@ int iwl_mvm_legacy_hw_idx_to_mac80211_idx(u32 rate_n_flags,
 					  enum nl80211_band band);
 int iwl_mvm_legacy_rate_to_mac80211_idx(u32 rate_n_flags,
 					enum nl80211_band band);
-void iwl_mvm_hwrate_to_tx_rate(u32 rate_n_flags,
+void iwl_mvm_hwrate_to_tx_rate(struct iwl_mvm *mvm,
+			       u32 rate_n_flags,
 			       enum nl80211_band band,
 			       struct ieee80211_tx_rate *r);
 void iwl_mvm_hwrate_to_tx_rate_v1(u32 rate_n_flags,
@@ -2697,6 +2720,14 @@ int iwl_mvm_mac_ampdu_action(struct ieee80211_hw *hw,
 			     struct ieee80211_ampdu_params *params);
 int iwl_mvm_op_get_antenna(struct ieee80211_hw *hw, u32 *tx_ant, u32 *rx_ant);
 int iwl_mvm_op_set_antenna(struct ieee80211_hw *hw, u32 tx_ant, u32 rx_ant);
+int iwl_mvm_get_et_sset_count(struct ieee80211_hw *hw,
+			      struct ieee80211_vif *vif, int sset);
+void iwl_mvm_get_et_stats(struct ieee80211_hw *hw,
+			  struct ieee80211_vif *vif,
+			  struct ethtool_stats *stats, u64 *data);
+void iwl_mvm_get_et_strings(struct ieee80211_hw *hw,
+			    struct ieee80211_vif *vif,
+			    u32 sset, u8 *data);
 int iwl_mvm_mac_start(struct ieee80211_hw *hw);
 void iwl_mvm_mac_reconfig_complete(struct ieee80211_hw *hw,
 				   enum ieee80211_reconfig_type reconfig_type);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
index 1ade073f0ebe..7300221628c9 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
@@ -1490,7 +1490,8 @@ static int iwl_mvm_get_hwrate_chan_width(u32 chan_width)
 	}
 }
 
-void iwl_mvm_hwrate_to_tx_rate(u32 rate_n_flags,
+void iwl_mvm_hwrate_to_tx_rate(struct iwl_mvm *mvm,
+			       u32 rate_n_flags,
 			       enum nl80211_band band,
 			       struct ieee80211_tx_rate *r)
 {
@@ -1498,27 +1499,55 @@ void iwl_mvm_hwrate_to_tx_rate(u32 rate_n_flags,
 	u32 rate = format == RATE_MCS_HT_MSK ?
 		RATE_HT_MCS_INDEX(rate_n_flags) :
 		rate_n_flags & RATE_MCS_CODE_MSK;
+	int bwi = (rate_n_flags & RATE_MCS_CHAN_WIDTH_MSK) >> RATE_MCS_CHAN_WIDTH_POS;
 
 	r->flags |=
 		iwl_mvm_get_hwrate_chan_width(rate_n_flags &
 					      RATE_MCS_CHAN_WIDTH_MSK);
 
+	mvm->ethtool_stats.tx_bw[bwi];
+	if (rate_n_flags & RATE_MCS_HE_106T_MSK)
+		mvm->ethtool_stats.tx_bw_106_tone++;
+
 	if (rate_n_flags & RATE_MCS_SGI_MSK)
 		r->flags |= IEEE80211_TX_RC_SHORT_GI;
 	if (format ==  RATE_MCS_HT_MSK) {
 		r->flags |= IEEE80211_TX_RC_MCS;
 		r->idx = rate;
+		mvm->ethtool_stats.tx_mcs[rate % 8]++; /* treat mcs like we do for VHT */
+		mvm->ethtool_stats.tx_ht++;
 	} else if (format ==  RATE_MCS_VHT_MSK) {
 		ieee80211_rate_set_vht(r, rate,
 				       FIELD_GET(RATE_MCS_NSS_MSK, rate_n_flags) + 1);
 		r->flags |= IEEE80211_TX_RC_VHT_MCS;
+		mvm->ethtool_stats.tx_mcs[rate]++;
+		mvm->ethtool_stats.tx_vht++;
 	} else if (format == RATE_MCS_HE_MSK) {
 		/* mac80211 cannot do this without ieee80211_tx_status_ext()
-		 * but it only matters for radiotap */
+		 * but it only matters for radiotap
+		 */
+		r->idx = 0;
+		mvm->ethtool_stats.tx_mcs[rate]++;
+		mvm->ethtool_stats.tx_he++;
+		mvm->ethtool_stats.tx_he_type[(rate_n_flags >> RATE_MCS_HE_TYPE_POS) & 0x3]++;
+	} else if (format == RATE_MCS_EHT_MSK) {
+		/* mac80211 cannot do this without ieee80211_tx_status_ext()
+		 * but it only matters for radiotap
+		 */
 		r->idx = 0;
+		mvm->ethtool_stats.tx_mcs[rate & RATE_HT_MCS_CODE_MSK]++;
+		mvm->ethtool_stats.tx_eht++;
+		mvm->ethtool_stats.tx_he_type[(rate_n_flags >> RATE_MCS_HE_TYPE_POS) & 0x3]++;
+	} else if (format == RATE_MCS_LEGACY_OFDM_MSK) {
+		r->idx = iwl_mvm_legacy_hw_idx_to_mac80211_idx(rate_n_flags,
+							       band);
+		mvm->ethtool_stats.tx_mcs[rate & RATE_LEGACY_RATE_MSK]++;
+		mvm->ethtool_stats.tx_ofdm++;
 	} else {
 		r->idx = iwl_mvm_legacy_hw_idx_to_mac80211_idx(rate_n_flags,
 							       band);
+		mvm->ethtool_stats.tx_mcs[rate & RATE_LEGACY_RATE_MSK]++;
+		mvm->ethtool_stats.tx_cck++;
 	}
 }
 
@@ -1552,7 +1581,8 @@ void iwl_mvm_hwrate_to_tx_rate_v1(u32 rate_n_flags,
 /*
  * translate ucode response to mac80211 tx status control values
  */
-static void iwl_mvm_hwrate_to_tx_status(const struct iwl_fw *fw,
+static void iwl_mvm_hwrate_to_tx_status(struct iwl_mvm *mvm,
+					const struct iwl_fw *fw,
 					u32 rate_n_flags,
 					struct ieee80211_tx_info *info)
 {
@@ -1564,7 +1594,12 @@ static void iwl_mvm_hwrate_to_tx_status(const struct iwl_fw *fw,
 
 	info->status.antenna =
 		((rate_n_flags & RATE_MCS_ANT_AB_MSK) >> RATE_MCS_ANT_POS);
-	iwl_mvm_hwrate_to_tx_rate(rate_n_flags,
+	if (info->status.antenna == 0x3)
+		mvm->ethtool_stats.tx_nss[1]++;
+	else
+		mvm->ethtool_stats.tx_nss[0]++;
+
+	iwl_mvm_hwrate_to_tx_rate(mvm, rate_n_flags,
 				  info->band, r);
 }
 
@@ -1609,6 +1644,18 @@ static void iwl_mvm_tx_status_check_trigger(struct iwl_mvm *mvm,
 	}
 }
 
+static void iwl_mvm_update_tx_stats(struct iwl_mvm *mvm, struct sk_buff *skb, u32 status)
+{
+	u32 idx = status & TX_STATUS_MSK;
+
+	if (idx > TX_STATUS_INTERNAL_ABORT + 1)
+		idx = TX_STATUS_INTERNAL_ABORT + 1;
+
+	mvm->ethtool_stats.tx_status_counts[idx]++;
+	if (idx == TX_STATUS_SUCCESS)
+		mvm->ethtool_stats.tx_bytes_nic += skb->len;
+}
+
 /*
  * iwl_mvm_get_scd_ssn - returns the SSN of the SCD
  * @tx_resp: the Tx response from the fw (agg or non-agg)
@@ -1710,7 +1757,7 @@ static void iwl_mvm_rx_tx_cmd_single(struct iwl_mvm *mvm,
 
 		info->status.rates[0].count = tx_resp->failure_frame + 1;
 
-		iwl_mvm_hwrate_to_tx_status(mvm->fw,
+		iwl_mvm_hwrate_to_tx_status(mvm, mvm->fw,
 					    le32_to_cpu(tx_resp->initial_rate),
 					    info);
 
@@ -1757,6 +1804,8 @@ static void iwl_mvm_rx_tx_cmd_single(struct iwl_mvm *mvm,
 		info->status.status_driver_data[0] =
 			RS_DRV_DATA_PACK(lq_color, tx_resp->reduced_tpc);
 
+		iwl_mvm_update_tx_stats(mvm, skb, status);
+
 #ifdef CONFIG_IWLMVM_TDLS_PEER_CACHE
 		if (info->flags & IEEE80211_TX_STAT_ACK)
 			iwl_mvm_tdls_peer_cache_pkt(mvm, (void *)skb->data,
@@ -2088,7 +2137,7 @@ static void iwl_mvm_tx_reclaim(struct iwl_mvm *mvm, int sta_id, int tid,
 			info->flags |= IEEE80211_TX_STAT_AMPDU;
 			memcpy(&info->status, &tx_info->status,
 			       sizeof(tx_info->status));
-			iwl_mvm_hwrate_to_tx_status(mvm->fw, rate, info);
+			iwl_mvm_hwrate_to_tx_status(mvm, mvm->fw, rate, info);
 		}
 	}
 
@@ -2111,7 +2160,7 @@ static void iwl_mvm_tx_reclaim(struct iwl_mvm *mvm, int sta_id, int tid,
 			goto out;
 
 		tx_info->band = chanctx_conf->def.chan->band;
-		iwl_mvm_hwrate_to_tx_status(mvm->fw, rate, tx_info);
+		iwl_mvm_hwrate_to_tx_status(mvm, mvm->fw, rate, tx_info);
 
 		IWL_DEBUG_TX_REPLY(mvm, "No reclaim. Update rs directly\n");
 		iwl_mvm_rs_tx_status(mvm, sta, tid, tx_info, false);
-- 
2.40.0

