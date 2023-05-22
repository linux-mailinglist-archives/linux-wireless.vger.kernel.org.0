Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4633870CF8C
	for <lists+linux-wireless@lfdr.de>; Tue, 23 May 2023 02:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235018AbjEWAkL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 22 May 2023 20:40:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235036AbjEWAKw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 22 May 2023 20:10:52 -0400
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC2DE199D
        for <linux-wireless@vger.kernel.org>; Mon, 22 May 2023 16:37:53 -0700 (PDT)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id BAE1D340071
        for <linux-wireless@vger.kernel.org>; Mon, 22 May 2023 23:37:51 +0000 (UTC)
Received: from ben-dt5.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id 38A3813C2B0;
        Mon, 22 May 2023 16:37:51 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 38A3813C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1684798671;
        bh=JC5xDeIboIITqp6iFEjfGo934uM9U9tjDk+EFA831XU=;
        h=From:To:Cc:Subject:Date:From;
        b=ipb490+Z+XQeumW//UIqK0hutjtSG9855SF+UrivYMHSgO+iOq9RV4YALLMTUYi01
         KIRHeyJtV73gmA0dSb9pIhGHAYiYio143aY5vGnx8g7Gq0DlRpcbRfXVMnkmILKapk
         KAmG1HcAWh6d4brkEyU/Y0N6GvJxniZw9rV/R0Io=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     Ben Greear <greearb@candelatech.com>
Subject: [PATCH v3] wifi: iwlwifi: add ethtool tx and rx stats.
Date:   Mon, 22 May 2023 16:37:43 -0700
Message-Id: <20230522233743.3058844-1-greearb@candelatech.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1684798672-VGc9ZjBPPyg6
X-MDID-O: us5;ut7;1684798672;VGc9ZjBPPyg6;<greearb@candelatech.com>;f7146c1849a4b08a52804beb1c1cdf45
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>

Report tx/rx error codes, nss, mcs, bandwidth, mode, he types,
tx ampdu length histogram.

To provide some clues about how transmit and receive path is
actually working.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---

v3:  Combine tx and rx ethtool patches into single patch.
Fix some stats calculations, especially the path that consumes
tx frames based on block-ack receipt.

Comparing the stats with expected values now matches better, but
hard to verify everything exactly.

 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 255 ++++++++++++++++++
 .../wireless/intel/iwlwifi/mvm/mld-mac80211.c |   3 +
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  54 +++-
 drivers/net/wireless/intel/iwlwifi/mvm/rx.c   |  24 ++
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c |  37 ++-
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c   | 126 ++++++++-
 6 files changed, 488 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index bb11cd2c596b..b5703687d990 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -6475,12 +6475,267 @@ int iwl_mvm_set_hw_timestamp(struct ieee80211_hw *hw,
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
+	"tx_ampdu_len:224-247", /* and higher */
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
+	data[ei++] = mib->rx_pkts;
+	data[ei++] = mib->rx_bytes_nic;
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
index 7a60f5eccaab..463bcb852b58 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -572,6 +572,48 @@ struct iwl_mvm_cooling_device {
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
+};
+
 #define IWL_MVM_NUM_LAST_FRAMES_UCODE_RATES 8
 
 struct iwl_mvm_frame_stats {
@@ -904,6 +946,7 @@ struct iwl_mvm {
 		struct mvm_statistics_rx_v3 rx_stats_v3;
 		struct mvm_statistics_rx rx_stats;
 	};
+	struct iwl_mvm_ethtool_stats ethtool_stats;
 
 	struct {
 		u64 rx_time;
@@ -1670,7 +1713,8 @@ int iwl_mvm_legacy_hw_idx_to_mac80211_idx(u32 rate_n_flags,
 					  enum nl80211_band band);
 int iwl_mvm_legacy_rate_to_mac80211_idx(u32 rate_n_flags,
 					enum nl80211_band band);
-void iwl_mvm_hwrate_to_tx_rate(u32 rate_n_flags,
+void iwl_mvm_hwrate_to_tx_rate(struct iwl_mvm *mvm,
+			       u32 rate_n_flags,
 			       enum nl80211_band band,
 			       struct ieee80211_tx_rate *r);
 void iwl_mvm_hwrate_to_tx_rate_v1(u32 rate_n_flags,
@@ -2697,6 +2741,14 @@ int iwl_mvm_mac_ampdu_action(struct ieee80211_hw *hw,
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
index 8f7194c2bdea..756642bd3a09 100644
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
@@ -2305,6 +2313,7 @@ static void iwl_mvm_rx_fill_status(struct iwl_mvm *mvm,
 	switch (format) {
 	case RATE_MCS_VHT_MSK:
 		rx_status->encoding = RX_ENC_VHT;
+		mvm->ethtool_stats.rx_bw[rx_status->bw]++;
 		break;
 	case RATE_MCS_HE_MSK:
 		rx_status->encoding = RX_ENC_HE;
@@ -2322,6 +2331,7 @@ static void iwl_mvm_rx_fill_status(struct iwl_mvm *mvm,
 		rx_status->rate_idx = RATE_HT_MCS_INDEX(rate_n_flags);
 		rx_status->nss = rx_status->rate_idx / 8 + 1;
 		rx_status->enc_flags |= stbc << RX_ENC_FLAG_STBC_SHIFT;
+		mvm->ethtool_stats.rx_bw[rx_status->bw]++;
 		break;
 	case RATE_MCS_VHT_MSK:
 	case RATE_MCS_HE_MSK:
@@ -2345,9 +2355,17 @@ static void iwl_mvm_rx_fill_status(struct iwl_mvm *mvm,
 		}
 
 		rx_status->nss = 1;
+		mvm->ethtool_stats.rx_bw[0]++;
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
@@ -2378,6 +2396,7 @@ void iwl_mvm_rx_mpdu_mq(struct iwl_mvm *mvm, struct napi_struct *napi,
 	size_t desc_size;
 	struct iwl_mvm_rx_phy_data phy_data = {};
 	u32 format;
+	bool bad_pkt = false;
 
 	if (unlikely(test_bit(IWL_MVM_STATUS_IN_HW_RESTART, &mvm->status)))
 		return;
@@ -2469,6 +2488,11 @@ void iwl_mvm_rx_mpdu_mq(struct iwl_mvm *mvm, struct napi_struct *napi,
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
@@ -2543,6 +2567,7 @@ void iwl_mvm_rx_mpdu_mq(struct iwl_mvm *mvm, struct napi_struct *napi,
 			      le32_to_cpu(pkt->len_n_flags), queue,
 			      &crypt_len)) {
 		kfree_skb(skb);
+		mvm->ethtool_stats.rx_failed_decrypt++;
 		goto out;
 	}
 
@@ -2623,6 +2648,7 @@ void iwl_mvm_rx_mpdu_mq(struct iwl_mvm *mvm, struct napi_struct *napi,
 
 		if (iwl_mvm_is_dup(sta, queue, rx_status, hdr, desc)) {
 			kfree_skb(skb);
+			mvm->ethtool_stats.rx_dup++;
 			goto out;
 		}
 
@@ -2671,6 +2697,15 @@ void iwl_mvm_rx_mpdu_mq(struct iwl_mvm *mvm, struct napi_struct *napi,
 		goto out;
 	}
 
+	if (!bad_pkt) {
+		mvm->ethtool_stats.rx_pkts++;
+		mvm->ethtool_stats.rx_bytes_nic += len;
+	}
+
+	/* NOTE:  These methods below must (and will) consume the skb if the 'else'
+	 * clause of the if statement will happen.  So should not leak mem
+	 * even though it looks problematic at first glance.
+	 */
 	if (!iwl_mvm_reorder(mvm, napi, queue, sta, skb, desc) &&
 	    (likely(!iwl_mvm_time_sync_frame(mvm, skb, hdr->addr2))) &&
 	    iwl_mvm_is_valid_packet_channel(rx_status, skb)
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
index 1ade073f0ebe..2e7ea9f192ef 100644
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
@@ -1629,6 +1678,41 @@ static inline u32 iwl_mvm_get_scd_ssn(struct iwl_mvm *mvm,
 			    tx_resp->frame_count) & 0xfff;
 }
 
+static void iwl_mvm_update_tx_ampdu_histogram(struct iwl_mvm *mvm, int freed)
+{
+	/* tx-ampdu-len histogram, buckets match what mtk7915 supports. */
+	if (freed <= 1)
+		mvm->ethtool_stats.tx_ampdu_len[0]++;
+	else if (freed <= 10)
+		mvm->ethtool_stats.tx_ampdu_len[1]++;
+	else if (freed <= 19)
+		mvm->ethtool_stats.tx_ampdu_len[2]++;
+	else if (freed <= 28)
+		mvm->ethtool_stats.tx_ampdu_len[3]++;
+	else if (freed <= 37)
+		mvm->ethtool_stats.tx_ampdu_len[4]++;
+	else if (freed <= 46)
+		mvm->ethtool_stats.tx_ampdu_len[5]++;
+	else if (freed <= 55)
+		mvm->ethtool_stats.tx_ampdu_len[6]++;
+	else if (freed <= 79)
+		mvm->ethtool_stats.tx_ampdu_len[7]++;
+	else if (freed <= 103)
+		mvm->ethtool_stats.tx_ampdu_len[8]++;
+	else if (freed <= 127)
+		mvm->ethtool_stats.tx_ampdu_len[9]++;
+	else if (freed <= 151)
+		mvm->ethtool_stats.tx_ampdu_len[10]++;
+	else if (freed <= 175)
+		mvm->ethtool_stats.tx_ampdu_len[11]++;
+	else if (freed <= 199)
+		mvm->ethtool_stats.tx_ampdu_len[12]++;
+	else if (freed <= 223)
+		mvm->ethtool_stats.tx_ampdu_len[13]++;
+	else
+		mvm->ethtool_stats.tx_ampdu_len[14]++;
+}
+
 static void iwl_mvm_rx_tx_cmd_single(struct iwl_mvm *mvm,
 				     struct iwl_rx_packet *pkt)
 {
@@ -1659,6 +1743,8 @@ static void iwl_mvm_rx_tx_cmd_single(struct iwl_mvm *mvm,
 	/* we can free until ssn % q.n_bd not inclusive */
 	iwl_trans_reclaim(mvm->trans, txq_id, ssn, &skbs);
 
+	iwl_mvm_update_tx_ampdu_histogram(mvm, tx_resp->frame_count);
+
 	while (!skb_queue_empty(&skbs)) {
 		struct sk_buff *skb = __skb_dequeue(&skbs);
 		struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
@@ -1710,7 +1796,10 @@ static void iwl_mvm_rx_tx_cmd_single(struct iwl_mvm *mvm,
 
 		info->status.rates[0].count = tx_resp->failure_frame + 1;
 
-		iwl_mvm_hwrate_to_tx_status(mvm->fw,
+		mvm->ethtool_stats.tx_mpdu_attempts += info->status.rates[0].count;
+		mvm->ethtool_stats.tx_mpdu_retry += tx_resp->failure_frame;
+
+		iwl_mvm_hwrate_to_tx_status(mvm, mvm->fw,
 					    le32_to_cpu(tx_resp->initial_rate),
 					    info);
 
@@ -1757,6 +1846,8 @@ static void iwl_mvm_rx_tx_cmd_single(struct iwl_mvm *mvm,
 		info->status.status_driver_data[0] =
 			RS_DRV_DATA_PACK(lq_color, tx_resp->reduced_tpc);
 
+		iwl_mvm_update_tx_stats(mvm, skb, status);
+
 #ifdef CONFIG_IWLMVM_TDLS_PEER_CACHE
 		if (info->flags & IEEE80211_TX_STAT_ACK)
 			iwl_mvm_tdls_peer_cache_pkt(mvm, (void *)skb->data,
@@ -1975,6 +2066,9 @@ void iwl_mvm_rx_tx_cmd(struct iwl_mvm *mvm, struct iwl_rx_cmd_buffer *rxb)
 	struct iwl_rx_packet *pkt = rxb_addr(rxb);
 	struct iwl_mvm_tx_resp *tx_resp = (void *)pkt->data;
 
+	/* tx-ampdu-len histogram, buckets match what mtk7915 supports. */
+	iwl_mvm_update_tx_ampdu_histogram(mvm, tx_resp->frame_count);
+
 	if (tx_resp->frame_count == 1)
 		iwl_mvm_rx_tx_cmd_single(mvm, pkt);
 	else
@@ -2070,12 +2164,19 @@ static void iwl_mvm_tx_reclaim(struct iwl_mvm *mvm, int sta_id, int tid,
 	skb_queue_walk(&reclaimed_skbs, skb) {
 		struct ieee80211_hdr *hdr = (void *)skb->data;
 		struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
+		bool do_status = false;
 
 		if (!is_flush) {
-			if (ieee80211_is_data_qos(hdr->frame_control))
+			if (ieee80211_is_data_qos(hdr->frame_control)) {
 				freed++;
-			else
+				do_status = true;
+			} else {
 				WARN_ON_ONCE(tid != IWL_MAX_TID_COUNT);
+			}
+
+			mvm->ethtool_stats.tx_status_counts[TX_STATUS_SUCCESS]++;
+			mvm->ethtool_stats.tx_mpdu_attempts++;
+			mvm->ethtool_stats.tx_bytes_nic += skb->len;
 		}
 
 #ifdef CONFIG_IWLMVM_TDLS_PEER_CACHE
@@ -2088,10 +2189,17 @@ static void iwl_mvm_tx_reclaim(struct iwl_mvm *mvm, int sta_id, int tid,
 			info->flags |= IEEE80211_TX_STAT_AMPDU;
 			memcpy(&info->status, &tx_info->status,
 			       sizeof(tx_info->status));
-			iwl_mvm_hwrate_to_tx_status(mvm->fw, rate, info);
 		}
+
+		/* Call this for all non-flushed data frames, not just the
+		 * first freed one, in order to get proper tx ethtool stats.
+		 */
+		if (do_status)
+			iwl_mvm_hwrate_to_tx_status(mvm, mvm->fw, rate, info);
 	}
 
+	iwl_mvm_update_tx_ampdu_histogram(mvm, freed);
+
 	spin_unlock_bh(&mvmsta->lock);
 
 	/* We got a BA notif with 0 acked or scd_ssn didn't progress which is
@@ -2111,7 +2219,7 @@ static void iwl_mvm_tx_reclaim(struct iwl_mvm *mvm, int sta_id, int tid,
 			goto out;
 
 		tx_info->band = chanctx_conf->def.chan->band;
-		iwl_mvm_hwrate_to_tx_status(mvm->fw, rate, tx_info);
+		iwl_mvm_hwrate_to_tx_status(mvm, mvm->fw, rate, tx_info);
 
 		IWL_DEBUG_TX_REPLY(mvm, "No reclaim. Update rs directly\n");
 		iwl_mvm_rs_tx_status(mvm, sta, tid, tx_info, false);
-- 
2.40.0

