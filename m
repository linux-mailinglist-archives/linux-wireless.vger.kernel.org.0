Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 518F570122E
	for <lists+linux-wireless@lfdr.de>; Sat, 13 May 2023 00:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239728AbjELWa1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 12 May 2023 18:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239706AbjELWa0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 12 May 2023 18:30:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E28552136
        for <linux-wireless@vger.kernel.org>; Fri, 12 May 2023 15:30:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 68717658CC
        for <linux-wireless@vger.kernel.org>; Fri, 12 May 2023 22:30:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 766A9C433D2;
        Fri, 12 May 2023 22:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683930623;
        bh=OLRjo63ZA05grPrVd0ql9x2pbMi3QAgvK9SHehk9To8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LC6unhvG68czYw/7ipATU+Q+oPRHubxDfzbNMkAg087ZLZqhEn5q/uqvPyjQMDMQH
         848Ept+p/9kAtDNGb731JKcRZKKR8/bPeiHjCkIaJ0gVogK4rYex3rMeECPNHHdG7+
         Ml7ylU7A+38XgKu/+MDmGBA/BhPf+q1rqMh0LXmFf+bySl5qpay3idCBNH0WL9tAkY
         CWBa2Xush+TVLdpAC127YawfOtkwqc/k1L/h82PKBD/1y4Ic9eAVDqMU6iOGOp3o+/
         7JuIJx38ystOTR6ML3kYjgP/HQf7HdRMMhRVqi9BNckDxcJJjkL2w5x5bBC6db2HVk
         GI4PNV7OYdKGA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org
Subject: [PATCH 2/3] wifi: mt76: mt7996: rely on mib_stats shared definition
Date:   Sat, 13 May 2023 00:29:54 +0200
Message-Id: <5e3b29165f2f431621edce1e7fd4e8c913ef6345.1683930235.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1683930235.git.lorenzo@kernel.org>
References: <cover.1683930235.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Get rid of private copy of mib_stats structure.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../wireless/mediatek/mt76/mt7996/debugfs.c   |  4 +-
 .../net/wireless/mediatek/mt76/mt7996/mac.c   |  2 +-
 .../net/wireless/mediatek/mt76/mt7996/main.c  |  4 +-
 .../wireless/mediatek/mt76/mt7996/mt7996.h    | 56 +------------------
 4 files changed, 6 insertions(+), 60 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7996/debugfs.c
index 513ab4ba41c9..4d40ec7ff57f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/debugfs.c
@@ -474,10 +474,10 @@ mt7996_ampdu_stat_read_phy(struct mt7996_phy *phy, struct seq_file *file)
 static void
 mt7996_txbf_stat_read_phy(struct mt7996_phy *phy, struct seq_file *s)
 {
+	struct mt76_mib_stats *mib = &phy->mib;
 	static const char * const bw[] = {
 		"BW20", "BW40", "BW80", "BW160"
 	};
-	struct mib_stats *mib = &phy->mib;
 
 	/* Tx Beamformer monitor */
 	seq_puts(s, "\nTx Beamformer applied PPDU counts: ");
@@ -523,7 +523,7 @@ mt7996_tx_stats_show(struct seq_file *file, void *data)
 {
 	struct mt7996_phy *phy = file->private;
 	struct mt7996_dev *dev = phy->dev;
-	struct mib_stats *mib = &phy->mib;
+	struct mt76_mib_stats *mib = &phy->mib;
 	int i;
 	u32 attempts, success, per;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index 130eb7b4fd91..7905070afc2c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -2186,8 +2186,8 @@ void mt7996_reset(struct mt7996_dev *dev)
 
 void mt7996_mac_update_stats(struct mt7996_phy *phy)
 {
+	struct mt76_mib_stats *mib = &phy->mib;
 	struct mt7996_dev *dev = phy->dev;
-	struct mib_stats *mib = &phy->mib;
 	u8 band_idx = phy->mt76->band_idx;
 	u32 cnt;
 	int i;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index 0975774fe244..0773293a0121 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -793,7 +793,7 @@ mt7996_get_stats(struct ieee80211_hw *hw,
 {
 	struct mt7996_phy *phy = mt7996_hw_phy(hw);
 	struct mt7996_dev *dev = mt7996_hw_dev(hw);
-	struct mib_stats *mib = &phy->mib;
+	struct mt76_mib_stats *mib = &phy->mib;
 
 	mutex_lock(&dev->mt76.mutex);
 
@@ -1198,11 +1198,11 @@ void mt7996_get_et_stats(struct ieee80211_hw *hw,
 	struct mt7996_dev *dev = mt7996_hw_dev(hw);
 	struct mt7996_phy *phy = mt7996_hw_phy(hw);
 	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
+	struct mt76_mib_stats *mib = &phy->mib;
 	struct mt76_ethtool_worker_info wi = {
 		.data = data,
 		.idx = mvif->mt76.idx,
 	};
-	struct mib_stats *mib = &phy->mib;
 	/* See mt7996_ampdu_stat_read_phy, etc */
 	int i, ei = 0;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
index 4d7dcb95a620..348d3ad3f9e7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
@@ -130,60 +130,6 @@ struct mt7996_vif {
 	u8 beacon_rates_idx;
 };
 
-/* per-phy stats.  */
-struct mib_stats {
-	u32 ack_fail_cnt;
-	u32 fcs_err_cnt;
-	u32 rts_cnt;
-	u32 rts_retries_cnt;
-	u32 ba_miss_cnt;
-	u32 tx_mu_bf_cnt;
-	u32 tx_mu_mpdu_cnt;
-	u32 tx_mu_acked_mpdu_cnt;
-	u32 tx_su_acked_mpdu_cnt;
-	u32 tx_bf_ibf_ppdu_cnt;
-	u32 tx_bf_ebf_ppdu_cnt;
-
-	u32 tx_bf_rx_fb_all_cnt;
-	u32 tx_bf_rx_fb_eht_cnt;
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
-	/* BF counter is PPDU-based, so remove MPDU-based BF counter */
-
-	u32 tx_rwp_fail_cnt;
-	u32 tx_rwp_need_cnt;
-
-	/* rx stats */
-	u32 rx_fifo_full_cnt;
-	u32 channel_idle_cnt;
-	u32 rx_vector_mismatch_cnt;
-	u32 rx_delimiter_fail_cnt;
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
 struct mt7996_crash_data {
 	guid_t guid;
@@ -222,7 +168,7 @@ struct mt7996_phy {
 	u32 rx_ampdu_ts;
 	u32 ampdu_ref;
 
-	struct mib_stats mib;
+	struct mt76_mib_stats mib;
 	struct mt76_channel_state state_ts;
 };
 
-- 
2.40.1

