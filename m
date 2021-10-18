Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D40164318AC
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Oct 2021 14:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231676AbhJRMQr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 Oct 2021 08:16:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:32982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231310AbhJRMQl (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 Oct 2021 08:16:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6D3B861077;
        Mon, 18 Oct 2021 12:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634559270;
        bh=0UBFJji7GBQklDq8DXVF1V1mMl7G4nVBfICOU09jtoQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tn5g1gAEC6IdMZy8yMhQAXvwegMT1yAuNVzSXhb5ZyC2Of5fPScYCR4ekVkyrDiQ2
         PfUQnF/viM17n+olukrK4dARHwkFFAC6aZ2S7eE61fkIXZTQo015ShM3kRaamt6STr
         RbRCLbpEHABxSXi6kpBU64DDo1Vkgm0iFJe1K8yZHMscl6MI9Lowdmum4ERf6oapPz
         NmINtc0Fri8tY1JpbxJC59gNvT2Gf+hY1rq551fdckCP3OWjv4U4wuzGmTwNKkt+lg
         Hh6ABNR+HWyz85TSAyQIeFKeCrJPLJBUWidaDUnBHUXJs8UzBwmuw/42tPySm8ek7x
         sgeUs1UZaoucQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, greearb@candelatech.com
Subject: [PATCH 10/10] mt76: mt7915: move tx amsdu stats in mib_stats
Date:   Mon, 18 Oct 2021 14:14:09 +0200
Message-Id: <fede91851f804679521b8cbea1892b75a064bc56.1634558817.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1634558817.git.lorenzo@kernel.org>
References: <cover.1634558817.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Move tx_amsdu histogram stats in mib_stats structure since registers are
clear-on-read

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../wireless/mediatek/mt76/mt7915/debugfs.c   | 19 ++++++++-----------
 .../net/wireless/mediatek/mt76/mt7915/mac.c   |  6 ++++++
 .../net/wireless/mediatek/mt76/mt7915/main.c  |  4 ++--
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |  3 +++
 4 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
index a0edcc78f66d..08a80b81a6c5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
@@ -207,7 +207,8 @@ mt7915_tx_stats_show(struct seq_file *file, void *data)
 {
 	struct mt7915_phy *phy = file->private;
 	struct mt7915_dev *dev = phy->dev;
-	int stat[8], i, n;
+	struct mib_stats *mib = &phy->mib;
+	int i;
 
 	mutex_lock(&dev->mt76.mutex);
 
@@ -217,16 +218,12 @@ mt7915_tx_stats_show(struct seq_file *file, void *data)
 
 	/* Tx amsdu info */
 	seq_puts(file, "Tx MSDU statistics:\n");
-	for (i = 0, n = 0; i < ARRAY_SIZE(stat); i++) {
-		stat[i] = mt76_rr(dev,  MT_PLE_AMSDU_PACK_MSDU_CNT(i));
-		n += stat[i];
-	}
-
-	for (i = 0; i < ARRAY_SIZE(stat); i++) {
-		seq_printf(file, "AMSDU pack count of %d MSDU in TXD: 0x%x ",
-			   i + 1, stat[i]);
-		if (n != 0)
-			seq_printf(file, "(%d%%)\n", stat[i] * 100 / n);
+	for (i = 0; i < ARRAY_SIZE(mib->tx_amsdu); i++) {
+		seq_printf(file, "AMSDU pack count of %d MSDU in TXD: %8d ",
+			   i + 1, mib->tx_amsdu[i]);
+		if (mib->tx_amsdu_cnt)
+			seq_printf(file, "(%3d%%)\n",
+				   mib->tx_amsdu[i] * 100 / mib->tx_amsdu_cnt);
 		else
 			seq_puts(file, "\n");
 	}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 1fb0420276a1..f6267b77ca97 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -2023,6 +2023,12 @@ void mt7915_mac_update_stats(struct mt7915_phy *phy)
 	mib->tx_bf_fb_cpl_cnt += FIELD_GET(MT_ETBF_TX_FB_CPL, cnt);
 	mib->tx_bf_fb_trig_cnt += FIELD_GET(MT_ETBF_TX_FB_TRI, cnt);
 
+	for (i = 0; i < ARRAY_SIZE(mib->tx_amsdu); i++) {
+		cnt = mt76_rr(dev, MT_PLE_AMSDU_PACK_MSDU_CNT(i));
+		mib->tx_amsdu[i] += cnt;
+		mib->tx_amsdu_cnt += cnt;
+	}
+
 	aggr0 = ext_phy ? ARRAY_SIZE(dev->mt76.aggr_stats) / 2 : 0;
 	for (i = 0, aggr1 = aggr0 + 4; i < 4; i++) {
 		u32 val;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index b5b23c824233..7210a1db2050 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -1264,8 +1264,8 @@ void mt7915_get_et_stats(struct ieee80211_hw *hw,
 	data[ei++] = mib->tx_su_acked_mpdu_cnt;
 
 	/* Tx amsdu info (pack-count histogram) */
-	for (i = 0; i < 8; i++)
-		data[ei++] = mt76_rr(dev,  MT_PLE_AMSDU_PACK_MSDU_CNT(i));
+	for (i = 0; i < ARRAY_SIZE(mib->tx_amsdu); i++)
+		data[ei++] = mib->tx_amsdu[i];
 
 	/* rx counters */
 	data[ei++] = mib->rx_fifo_full_cnt;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index 0a2dd2f18fe5..207114e2019d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -171,6 +171,9 @@ struct mib_stats {
 	u32 rx_pfdrop_cnt;
 	u32 rx_vec_queue_overflow_drop_cnt;
 	u32 rx_ba_cnt;
+
+	u32 tx_amsdu[8];
+	u32 tx_amsdu_cnt;
 };
 
 struct mt7915_hif {
-- 
2.31.1

