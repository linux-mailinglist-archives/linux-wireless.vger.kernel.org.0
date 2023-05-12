Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35A2A70122D
	for <lists+linux-wireless@lfdr.de>; Sat, 13 May 2023 00:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239577AbjELWaY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 12 May 2023 18:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjELWaW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 12 May 2023 18:30:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FE6959FC
        for <linux-wireless@vger.kernel.org>; Fri, 12 May 2023 15:30:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A90A2619F6
        for <linux-wireless@vger.kernel.org>; Fri, 12 May 2023 22:30:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B867CC433EF;
        Fri, 12 May 2023 22:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683930620;
        bh=UVq57cBDkcmdM2S7Kzh4XuzGimlqUAjJeaHUhedy6Qg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CrdJOkso3Rv+ipZ8MWbmTyrBz4SWSJxc+cB+olehn1JxC3oSNiPUYMPvEfNrlhFZ8
         WEDmnPYqmDfh/3HJQ5sW7/xg0adM/DPPUU9GVLXL38CP7yAPQ5Ds9GO/AO9iljY0vv
         XOu/ut3jkEf1dh3E/5DIS49p9tbX0ucBsjWXhkw1NZfPAtz+TjL490iJkvQXskwlhY
         pUunHrPq5GdFe4dC4svAuhQL0A8j97iZspxQsclJNi7VEWvpG5YALGQw8yt2Sl80ej
         fxq/dAjNqg7PgA6Jcbdsazu3lIEZ4MTUYCqhf5aujm6By/zMt7wYdBAunIqPO7E1BF
         TRv/DYYWaphiQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org
Subject: [PATCH 1/3] wifi: mt76: mt7915: move mib_stats structure in mt76.h
Date:   Sat, 13 May 2023 00:29:53 +0200
Message-Id: <d7f29306df3495e183304825cd3159bf1ccb1d87.1683930235.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1683930235.git.lorenzo@kernel.org>
References: <cover.1683930235.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

mib_stats structure is shared by mostly all chipsets. Move it to shared
code.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76.h     | 63 +++++++++++++++++++
 .../wireless/mediatek/mt76/mt7915/debugfs.c   |  4 +-
 .../net/wireless/mediatek/mt76/mt7915/mac.c   |  2 +-
 .../net/wireless/mediatek/mt76/mt7915/main.c  |  4 +-
 .../wireless/mediatek/mt76/mt7915/mt7915.h    | 63 +------------------
 5 files changed, 69 insertions(+), 67 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 75b5c2c56a92..45bf1022a051 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -857,6 +857,69 @@ struct mt76_dev {
 	};
 };
 
+/* per-phy stats.  */
+struct mt76_mib_stats {
+	u32 ack_fail_cnt;
+	u32 fcs_err_cnt;
+	u32 rts_cnt;
+	u32 rts_retries_cnt;
+	u32 ba_miss_cnt;
+	u32 tx_bf_cnt;
+	u32 tx_mu_bf_cnt;
+	u32 tx_mu_mpdu_cnt;
+	u32 tx_mu_acked_mpdu_cnt;
+	u32 tx_su_acked_mpdu_cnt;
+	u32 tx_bf_ibf_ppdu_cnt;
+	u32 tx_bf_ebf_ppdu_cnt;
+
+	u32 tx_bf_rx_fb_all_cnt;
+	u32 tx_bf_rx_fb_eht_cnt;
+	u32 tx_bf_rx_fb_he_cnt;
+	u32 tx_bf_rx_fb_vht_cnt;
+	u32 tx_bf_rx_fb_ht_cnt;
+
+	u32 tx_bf_rx_fb_bw; /* value of last sample, not cumulative */
+	u32 tx_bf_rx_fb_nc_cnt;
+	u32 tx_bf_rx_fb_nr_cnt;
+	u32 tx_bf_fb_cpl_cnt;
+	u32 tx_bf_fb_trig_cnt;
+
+	u32 tx_ampdu_cnt;
+	u32 tx_stop_q_empty_cnt;
+	u32 tx_mpdu_attempts_cnt;
+	u32 tx_mpdu_success_cnt;
+	u32 tx_pkt_ebf_cnt;
+	u32 tx_pkt_ibf_cnt;
+
+	u32 tx_rwp_fail_cnt;
+	u32 tx_rwp_need_cnt;
+
+	/* rx stats */
+	u32 rx_fifo_full_cnt;
+	u32 channel_idle_cnt;
+	u32 primary_cca_busy_time;
+	u32 secondary_cca_busy_time;
+	u32 primary_energy_detect_time;
+	u32 cck_mdrdy_time;
+	u32 ofdm_mdrdy_time;
+	u32 green_mdrdy_time;
+	u32 rx_vector_mismatch_cnt;
+	u32 rx_delimiter_fail_cnt;
+	u32 rx_mrdy_cnt;
+	u32 rx_len_mismatch_cnt;
+	u32 rx_mpdu_cnt;
+	u32 rx_ampdu_cnt;
+	u32 rx_ampdu_bytes_cnt;
+	u32 rx_ampdu_valid_subframe_cnt;
+	u32 rx_ampdu_valid_subframe_bytes_cnt;
+	u32 rx_pfdrop_cnt;
+	u32 rx_vec_queue_overflow_drop_cnt;
+	u32 rx_ba_cnt;
+
+	u32 tx_amsdu[8];
+	u32 tx_amsdu_cnt;
+};
+
 struct mt76_power_limits {
 	s8 cck[4];
 	s8 ofdm[8];
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
index 879884ead660..dd5c494efa5f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
@@ -719,10 +719,10 @@ mt7915_ampdu_stat_read_phy(struct mt7915_phy *phy,
 static void
 mt7915_txbf_stat_read_phy(struct mt7915_phy *phy, struct seq_file *s)
 {
+	struct mt76_mib_stats *mib = &phy->mib;
 	static const char * const bw[] = {
 		"BW20", "BW40", "BW80", "BW160"
 	};
-	struct mib_stats *mib = &phy->mib;
 
 	/* Tx Beamformer monitor */
 	seq_puts(s, "\nTx Beamformer applied PPDU counts: ");
@@ -768,7 +768,7 @@ mt7915_tx_stats_show(struct seq_file *file, void *data)
 {
 	struct mt7915_phy *phy = file->private;
 	struct mt7915_dev *dev = phy->dev;
-	struct mib_stats *mib = &phy->mib;
+	struct mt76_mib_stats *mib = &phy->mib;
 	int i;
 
 	mutex_lock(&dev->mt76.mutex);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 7df8d95fc3fb..9f5f15e219ac 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -1747,8 +1747,8 @@ void mt7915_reset(struct mt7915_dev *dev)
 
 void mt7915_mac_update_stats(struct mt7915_phy *phy)
 {
+	struct mt76_mib_stats *mib = &phy->mib;
 	struct mt7915_dev *dev = phy->dev;
-	struct mib_stats *mib = &phy->mib;
 	int i, aggr0 = 0, aggr1, cnt;
 	u8 band = phy->mt76->band_idx;
 	u32 val;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index 2ada2806de66..19973e7c639f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -843,7 +843,7 @@ mt7915_get_stats(struct ieee80211_hw *hw,
 {
 	struct mt7915_phy *phy = mt7915_hw_phy(hw);
 	struct mt7915_dev *dev = mt7915_hw_dev(hw);
-	struct mib_stats *mib = &phy->mib;
+	struct mt76_mib_stats *mib = &phy->mib;
 
 	mutex_lock(&dev->mt76.mutex);
 
@@ -1327,11 +1327,11 @@ void mt7915_get_et_stats(struct ieee80211_hw *hw,
 	struct mt7915_dev *dev = mt7915_hw_dev(hw);
 	struct mt7915_phy *phy = mt7915_hw_phy(hw);
 	struct mt7915_vif *mvif = (struct mt7915_vif *)vif->drv_priv;
+	struct mt76_mib_stats *mib = &phy->mib;
 	struct mt76_ethtool_worker_info wi = {
 		.data = data,
 		.idx = mvif->mt76.idx,
 	};
-	struct mib_stats *mib = &phy->mib;
 	/* See mt7915_ampdu_stat_read_phy, etc */
 	int i, ei = 0, stats_size;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index b3ead3530740..50ddf6d3c60a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -157,67 +157,6 @@ struct mt7915_vif {
 	struct cfg80211_bitrate_mask bitrate_mask;
 };
 
-/* per-phy stats.  */
-struct mib_stats {
-	u32 ack_fail_cnt;
-	u32 fcs_err_cnt;
-	u32 rts_cnt;
-	u32 rts_retries_cnt;
-	u32 ba_miss_cnt;
-	u32 tx_bf_cnt;
-	u32 tx_mu_mpdu_cnt;
-	u32 tx_mu_acked_mpdu_cnt;
-	u32 tx_su_acked_mpdu_cnt;
-	u32 tx_bf_ibf_ppdu_cnt;
-	u32 tx_bf_ebf_ppdu_cnt;
-
-	u32 tx_bf_rx_fb_all_cnt;
-	u32 tx_bf_rx_fb_he_cnt;
-	u32 tx_bf_rx_fb_vht_cnt;
-	u32 tx_bf_rx_fb_ht_cnt;
-
-	u32 tx_bf_rx_fb_bw; /* value of last sample, not cumulative */
-	u32 tx_bf_rx_fb_nc_cnt;
-	u32 tx_bf_rx_fb_nr_cnt;
-	u32 tx_bf_fb_cpl_cnt;
-	u32 tx_bf_fb_trig_cnt;
-
-	u32 tx_ampdu_cnt;
-	u32 tx_stop_q_empty_cnt;
-	u32 tx_mpdu_attempts_cnt;
-	u32 tx_mpdu_success_cnt;
-	u32 tx_pkt_ebf_cnt;
-	u32 tx_pkt_ibf_cnt;
-
-	u32 tx_rwp_fail_cnt;
-	u32 tx_rwp_need_cnt;
-
-	/* rx stats */
-	u32 rx_fifo_full_cnt;
-	u32 channel_idle_cnt;
-	u32 primary_cca_busy_time;
-	u32 secondary_cca_busy_time;
-	u32 primary_energy_detect_time;
-	u32 cck_mdrdy_time;
-	u32 ofdm_mdrdy_time;
-	u32 green_mdrdy_time;
-	u32 rx_vector_mismatch_cnt;
-	u32 rx_delimiter_fail_cnt;
-	u32 rx_mrdy_cnt;
-	u32 rx_len_mismatch_cnt;
-	u32 rx_mpdu_cnt;
-	u32 rx_ampdu_cnt;
-	u32 rx_ampdu_bytes_cnt;
-	u32 rx_ampdu_valid_subframe_cnt;
-	u32 rx_ampdu_valid_subframe_bytes_cnt;
-	u32 rx_pfdrop_cnt;
-	u32 rx_vec_queue_overflow_drop_cnt;
-	u32 rx_ba_cnt;
-
-	u32 tx_amsdu[8];
-	u32 tx_amsdu_cnt;
-};
-
 /* crash-dump */
 struct mt7915_crash_data {
 	guid_t guid;
@@ -263,7 +202,7 @@ struct mt7915_phy {
 	u32 rx_ampdu_ts;
 	u32 ampdu_ref;
 
-	struct mib_stats mib;
+	struct mt76_mib_stats mib;
 	struct mt76_channel_state state_ts;
 
 #ifdef CONFIG_NL80211_TESTMODE
-- 
2.40.1

