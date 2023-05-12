Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFC1470122F
	for <lists+linux-wireless@lfdr.de>; Sat, 13 May 2023 00:30:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239882AbjELWab (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 12 May 2023 18:30:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239815AbjELWaa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 12 May 2023 18:30:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D927359CA
        for <linux-wireless@vger.kernel.org>; Fri, 12 May 2023 15:30:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 634126401D
        for <linux-wireless@vger.kernel.org>; Fri, 12 May 2023 22:30:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72F57C433EF;
        Fri, 12 May 2023 22:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683930627;
        bh=TRGzTOBO3Z7c3IYL2nQr7qT4zs9FzDTeC5OTXHkff9c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BCQ3p+aivQuAmGOmGsOc+QMgfAq2CJx/Fb7+gXQjzazH5LK04WOCzXz5Klo41fmcS
         lMXnUsPLsB2Nl1paCTSvFLm/cAZ1q5Elq8AvvcAaZMPZwX8di91X87cL3BSoOru4RO
         2Ttn3VVFM486KEU3nIxnmNyKRJdekupakLDsFQAHgdzDJh9Ua+LtbeG6t45v32ycAl
         0ZHslVzMvpY2/XBhITcu/xz3jqhQb9raY03KHoc815+P4lcAHl78JJaOu9g3q89C9v
         X6tmsCjWMt/9Nty2+TjMEks97DVqALMmnwO7EEfyhMTnoynqCGakbUpMSRzCKSouWS
         +6K7v0pOjPPbg==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org
Subject: [PATCH 3/3] wifi: mt76: mt7921: rely on mib_stats shared definition
Date:   Sat, 13 May 2023 00:29:55 +0200
Message-Id: <09e74469a8c47138a2c20b700f8cd1193bc0bbae.1683930236.git.lorenzo@kernel.org>
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

Get rid of private copy of mib_stats structure.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../wireless/mediatek/mt76/mt7921/debugfs.c   |  2 +-
 .../net/wireless/mediatek/mt76/mt7921/mac.c   |  2 +-
 .../net/wireless/mediatek/mt76/mt7921/main.c  |  4 +--
 .../wireless/mediatek/mt76/mt7921/mt7921.h    | 31 +------------------
 4 files changed, 5 insertions(+), 34 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c
index d6b6edba2fec..d6c66e775536 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c
@@ -95,7 +95,7 @@ mt7921_tx_stats_show(struct seq_file *file, void *data)
 {
 	struct mt7921_dev *dev = file->private;
 	struct mt7921_phy *phy = &dev->phy;
-	struct mib_stats *mib = &phy->mib;
+	struct mt76_mib_stats *mib = &phy->mib;
 	int i;
 
 	mt7921_mutex_acquire(dev);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index 1675bf520481..c2f6035fa96a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -952,8 +952,8 @@ EXPORT_SYMBOL_GPL(mt7921_reset);
 
 void mt7921_mac_update_mib_stats(struct mt7921_phy *phy)
 {
+	struct mt76_mib_stats *mib = &phy->mib;
 	struct mt7921_dev *dev = phy->dev;
-	struct mib_stats *mib = &phy->mib;
 	int i, aggr0 = 0, aggr1;
 	u32 val;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index 0c9a472bc81a..ce09ba05de82 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -996,7 +996,7 @@ mt7921_get_stats(struct ieee80211_hw *hw,
 		 struct ieee80211_low_level_stats *stats)
 {
 	struct mt7921_phy *phy = mt7921_hw_phy(hw);
-	struct mib_stats *mib = &phy->mib;
+	struct mt76_mib_stats *mib = &phy->mib;
 
 	mt7921_mutex_acquire(phy->dev);
 
@@ -1134,7 +1134,7 @@ void mt7921_get_et_stats(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	int stats_size = ARRAY_SIZE(mt7921_gstrings_stats);
 	struct mt7921_phy *phy = mt7921_hw_phy(hw);
 	struct mt7921_dev *dev = phy->dev;
-	struct mib_stats *mib = &phy->mib;
+	struct mt76_mib_stats *mib = &phy->mib;
 	struct mt76_ethtool_worker_info wi = {
 		.data = data,
 		.idx = mvif->mt76.idx,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index 149acb1662d5..76dc2538b915 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -179,35 +179,6 @@ struct mt7921_vif {
 	struct ieee80211_chanctx_conf *ctx;
 };
 
-struct mib_stats {
-	u32 ack_fail_cnt;
-	u32 fcs_err_cnt;
-	u32 rts_cnt;
-	u32 rts_retries_cnt;
-	u32 ba_miss_cnt;
-
-	u32 tx_bf_ibf_ppdu_cnt;
-	u32 tx_bf_ebf_ppdu_cnt;
-	u32 tx_bf_rx_fb_all_cnt;
-	u32 tx_bf_rx_fb_he_cnt;
-	u32 tx_bf_rx_fb_vht_cnt;
-	u32 tx_bf_rx_fb_ht_cnt;
-
-	u32 tx_ampdu_cnt;
-	u32 tx_mpdu_attempts_cnt;
-	u32 tx_mpdu_success_cnt;
-	u32 tx_pkt_ebf_cnt;
-	u32 tx_pkt_ibf_cnt;
-
-	u32 rx_mpdu_cnt;
-	u32 rx_ampdu_cnt;
-	u32 rx_ampdu_bytes_cnt;
-	u32 rx_ba_cnt;
-
-	u32 tx_amsdu[8];
-	u32 tx_amsdu_cnt;
-};
-
 enum {
 	MT7921_CLC_POWER,
 	MT7921_CLC_CHAN,
@@ -247,7 +218,7 @@ struct mt7921_phy {
 	u32 rx_ampdu_ts;
 	u32 ampdu_ref;
 
-	struct mib_stats mib;
+	struct mt76_mib_stats mib;
 
 	u8 sta_work_count;
 
-- 
2.40.1

