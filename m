Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31C68709DBE
	for <lists+linux-wireless@lfdr.de>; Fri, 19 May 2023 19:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbjESRU2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 19 May 2023 13:20:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjESRUZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 19 May 2023 13:20:25 -0400
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A0B79E
        for <linux-wireless@vger.kernel.org>; Fri, 19 May 2023 10:20:23 -0700 (PDT)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 2CF60A80064
        for <linux-wireless@vger.kernel.org>; Fri, 19 May 2023 17:20:18 +0000 (UTC)
Received: from ben-dt5.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id B315D13C2B0;
        Fri, 19 May 2023 10:20:17 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com B315D13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1684516817;
        bh=4LtDRw5YSA6XDb+v11mZvjM/yefSbQ6Gf6zYTB1TCcI=;
        h=From:To:Cc:Subject:Date:From;
        b=Aw8Z1fmaDPdlVG/yjw31kKjOhsrtEfhlSs2mVphn9y/BQUmhydAj0+5YjD2xm4Yay
         ogn6pLIbIa4U0r1tZcHw7DU66Lf/4vu6hvQnNc6JyDfEBo8dXebnSXTaP8CWUJD8kU
         bMPPW85JfhIlnUnU/iLPhIr7581sdP7bNTmDXDGM=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     Ben Greear <greearb@candelatech.com>
Subject: [PATCH v2 1/2] wifi: iwlwifi: add ethtool tx stats.
Date:   Fri, 19 May 2023 10:20:14 -0700
Message-Id: <20230519172015.1654252-1-greearb@candelatech.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1684516818-Vr8myWnhCaEQ
X-MDID-O: us5;ut7;1684516818;Vr8myWnhCaEQ;<greearb@candelatech.com>;f7146c1849a4b08a52804beb1c1cdf45
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

Report tx error codes, nss, mcs, bandwidth, mode, he types,
ampdu length histogram.

To provide some clues about how transmit path is actually working.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---

v2:  Fix a few small buglets, add in tx ampdu histogram.
     And add second patch to deal with rx stats.

 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 188 ++++++++++++++++++
 .../wireless/intel/iwlwifi/mvm/mld-mac80211.c |   3 +
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  39 +++-
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c   | 100 +++++++++-
 4 files changed, 322 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index bb11cd2c596b..b7ed4285edd4 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -6475,12 +6475,200 @@ int iwl_mvm_set_hw_timestamp(struct ieee80211_hw *hw,
 	return ret;
 }
 
+static const char iwl_mvm_gstrings_stats[][ETH_GSTRING_LEN] = {
+	"tx_pkts_nic", /* from driver, phy tx-ok skb */
+	"tx_bytes_nic", /* from driver, phy tx-ok bytes */
+	"rx_pkts_nic", /* from driver, phy rx OK skb */
+	"rx_bytes_nic", /* from driver, phy rx OK bytes */
+
+	"tx_mpdu_attempts", /* counting any retries */
+	"tx_mpdu_fail",  /* frames that failed even after retry */
+	"tx_mpdu_retry", /* number of times frames were retried */
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
+	"tx_mode_he_su",
+	"tx_mode_he_ext_su",
+	"tx_mode_he_mu",
+	"tx_mode_he_trig",
+
+	"tx_ampdu_len:0-1",
+	"tx_ampdu_len:2-10",
+	"tx_ampdu_len:11-19",
+	"tx_ampdu_len:20-28",
+	"tx_ampdu_len:29-37",
+	"tx_ampdu_len:38-46",
+	"tx_ampdu_len:47-55",
+	"tx_ampdu_len:56-79",
+	"tx_ampdu_len:80-103",
+	"tx_ampdu_len:104-127",
+	"tx_ampdu_len:128-151",
+	"tx_ampdu_len:152-175",
+	"tx_ampdu_len:176-199",
+	"tx_ampdu_len:200-223",
+	"tx_ampdu_len:224-247",
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
+	data[ei++] = mib->tx_mpdu_attempts;
+	data[ei++] = mib->tx_mpdu_fail;
+	data[ei++] = mib->tx_mpdu_retry;
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
+	for (i = 0; i < ARRAY_SIZE(mib->tx_ampdu_len); i++)
+		data[ei++] = mib->tx_ampdu_len[i];
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
index 7a60f5eccaab..96ac2cedec50 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -572,6 +572,33 @@ struct iwl_mvm_cooling_device {
 };
 #endif
 
+struct iwl_mvm_ethtool_stats {
+	u64 tx_bytes_nic; /* successful tx bytes */
+
+	u64 tx_mpdu_attempts; /* counting any retries */
+	u64 tx_mpdu_fail; /* Failed even after retry */
+	u64 tx_mpdu_retry; /* Number of times frames were retried */
+
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
+	u64 tx_ampdu_len[15];
+	u64 tx_bw[5]; /* 20, 40, 80, 160, 320 */
+	u64 tx_bw_106_tone;
+	u64 tx_mcs[14]; /* mcs 0 to mcs 13 */
+	u64 tx_nss[2]; /* tx nss histogram */
+};
+
 #define IWL_MVM_NUM_LAST_FRAMES_UCODE_RATES 8
 
 struct iwl_mvm_frame_stats {
@@ -904,6 +931,7 @@ struct iwl_mvm {
 		struct mvm_statistics_rx_v3 rx_stats_v3;
 		struct mvm_statistics_rx rx_stats;
 	};
+	struct iwl_mvm_ethtool_stats ethtool_stats;
 
 	struct {
 		u64 rx_time;
@@ -1670,7 +1698,8 @@ int iwl_mvm_legacy_hw_idx_to_mac80211_idx(u32 rate_n_flags,
 					  enum nl80211_band band);
 int iwl_mvm_legacy_rate_to_mac80211_idx(u32 rate_n_flags,
 					enum nl80211_band band);
-void iwl_mvm_hwrate_to_tx_rate(u32 rate_n_flags,
+void iwl_mvm_hwrate_to_tx_rate(struct iwl_mvm *mvm,
+			       u32 rate_n_flags,
 			       enum nl80211_band band,
 			       struct ieee80211_tx_rate *r);
 void iwl_mvm_hwrate_to_tx_rate_v1(u32 rate_n_flags,
@@ -2697,6 +2726,14 @@ int iwl_mvm_mac_ampdu_action(struct ieee80211_hw *hw,
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
index 1ade073f0ebe..a9d5abac46ec 100644
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
 
+	mvm->ethtool_stats.tx_bw[bwi]++;
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
+		mvm->ethtool_stats.tx_mcs[rate]++;
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
 
@@ -1609,6 +1644,20 @@ static void iwl_mvm_tx_status_check_trigger(struct iwl_mvm *mvm,
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
+	else
+		mvm->ethtool_stats.tx_mpdu_fail++;
+}
+
 /*
  * iwl_mvm_get_scd_ssn - returns the SSN of the SCD
  * @tx_resp: the Tx response from the fw (agg or non-agg)
@@ -1659,6 +1708,38 @@ static void iwl_mvm_rx_tx_cmd_single(struct iwl_mvm *mvm,
 	/* we can free until ssn % q.n_bd not inclusive */
 	iwl_trans_reclaim(mvm->trans, txq_id, ssn, &skbs);
 
+	/* tx-ampdu-len histogram, buckets match what mtk7915 supports. */
+	if (tx_resp->frame_count <= 1)
+		mvm->ethtool_stats.tx_ampdu_len[0]++;
+	else if (tx_resp->frame_count <= 10)
+		mvm->ethtool_stats.tx_ampdu_len[1]++;
+	else if (tx_resp->frame_count <= 19)
+		mvm->ethtool_stats.tx_ampdu_len[2]++;
+	else if (tx_resp->frame_count <= 28)
+		mvm->ethtool_stats.tx_ampdu_len[3]++;
+	else if (tx_resp->frame_count <= 37)
+		mvm->ethtool_stats.tx_ampdu_len[4]++;
+	else if (tx_resp->frame_count <= 46)
+		mvm->ethtool_stats.tx_ampdu_len[5]++;
+	else if (tx_resp->frame_count <= 55)
+		mvm->ethtool_stats.tx_ampdu_len[6]++;
+	else if (tx_resp->frame_count <= 79)
+		mvm->ethtool_stats.tx_ampdu_len[7]++;
+	else if (tx_resp->frame_count <= 103)
+		mvm->ethtool_stats.tx_ampdu_len[8]++;
+	else if (tx_resp->frame_count <= 127)
+		mvm->ethtool_stats.tx_ampdu_len[9]++;
+	else if (tx_resp->frame_count <= 151)
+		mvm->ethtool_stats.tx_ampdu_len[10]++;
+	else if (tx_resp->frame_count <= 175)
+		mvm->ethtool_stats.tx_ampdu_len[11]++;
+	else if (tx_resp->frame_count <= 199)
+		mvm->ethtool_stats.tx_ampdu_len[12]++;
+	else if (tx_resp->frame_count <= 223)
+		mvm->ethtool_stats.tx_ampdu_len[13]++;
+	else
+		mvm->ethtool_stats.tx_ampdu_len[14]++;
+
 	while (!skb_queue_empty(&skbs)) {
 		struct sk_buff *skb = __skb_dequeue(&skbs);
 		struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
@@ -1710,7 +1791,10 @@ static void iwl_mvm_rx_tx_cmd_single(struct iwl_mvm *mvm,
 
 		info->status.rates[0].count = tx_resp->failure_frame + 1;
 
-		iwl_mvm_hwrate_to_tx_status(mvm->fw,
+		mvm->ethtool_stats.tx_mpdu_attempts += info->status.rates[0].count;
+		mvm->ethtool_stats.tx_mpdu_retry += tx_resp->failure_frame;
+
+		iwl_mvm_hwrate_to_tx_status(mvm, mvm->fw,
 					    le32_to_cpu(tx_resp->initial_rate),
 					    info);
 
@@ -1757,6 +1841,8 @@ static void iwl_mvm_rx_tx_cmd_single(struct iwl_mvm *mvm,
 		info->status.status_driver_data[0] =
 			RS_DRV_DATA_PACK(lq_color, tx_resp->reduced_tpc);
 
+		iwl_mvm_update_tx_stats(mvm, skb, status);
+
 #ifdef CONFIG_IWLMVM_TDLS_PEER_CACHE
 		if (info->flags & IEEE80211_TX_STAT_ACK)
 			iwl_mvm_tdls_peer_cache_pkt(mvm, (void *)skb->data,
@@ -2088,7 +2174,7 @@ static void iwl_mvm_tx_reclaim(struct iwl_mvm *mvm, int sta_id, int tid,
 			info->flags |= IEEE80211_TX_STAT_AMPDU;
 			memcpy(&info->status, &tx_info->status,
 			       sizeof(tx_info->status));
-			iwl_mvm_hwrate_to_tx_status(mvm->fw, rate, info);
+			iwl_mvm_hwrate_to_tx_status(mvm, mvm->fw, rate, info);
 		}
 	}
 
@@ -2111,7 +2197,7 @@ static void iwl_mvm_tx_reclaim(struct iwl_mvm *mvm, int sta_id, int tid,
 			goto out;
 
 		tx_info->band = chanctx_conf->def.chan->band;
-		iwl_mvm_hwrate_to_tx_status(mvm->fw, rate, tx_info);
+		iwl_mvm_hwrate_to_tx_status(mvm, mvm->fw, rate, tx_info);
 
 		IWL_DEBUG_TX_REPLY(mvm, "No reclaim. Update rs directly\n");
 		iwl_mvm_rs_tx_status(mvm, sta, tid, tx_info, false);
-- 
2.40.0

