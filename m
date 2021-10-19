Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10CAB433350
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Oct 2021 12:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235187AbhJSKPc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 19 Oct 2021 06:15:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:58842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235194AbhJSKPb (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 19 Oct 2021 06:15:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ECB546137D;
        Tue, 19 Oct 2021 10:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634638399;
        bh=DYrTMRvv0qJQvCgwqGkO5m54zGqLGootLTWmqAvNVG4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dM1MgSPQvfEU+8O3yTv8utrt9vmA6fI39T3r2/GNDdow5QoipRjQqUWMx9gXJpNna
         i/Xkzp8Ue/JX6lF1fxtu6rBR9FqfZG3yNUKGHDzWCnSEgEde66euS6A8eMg9tcSZrn
         ih2JVh+l/K2yV0TN67rpOMaMfBfNNs8FAAEyjqAERkLH/zioebZkdi7wImpA6kzRZf
         HqhK2MznOLfZSqeLtvfrGATFp10jaAnIYCYLbC/MwdZ52aD2fd1V/hY5KDF7o13kJu
         zyC1ZBGn1EZ+ugMJMM2n/VJF0VLVlvJU+UhotxISVQhhjGwER+lCNg+AHF1LVmTzDP
         Vi0r4hTPBSFAQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, greearb@candelatech.com,
        ryder.lee@mediatek.com
Subject: [PATCH v2 09/10] mt76: mt7921: move tx amsdu stats in mib_stats
Date:   Tue, 19 Oct 2021 12:12:31 +0200
Message-Id: <7cb3453341a155b0d5e1f12dee945516f1fe8af1.1634637742.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1634637742.git.lorenzo@kernel.org>
References: <cover.1634637742.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Move tx_amsdu histogram stats in mib_stats structure since registers are
clear-on-read

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../wireless/mediatek/mt76/mt7921/debugfs.c   | 27 +++++++++----------
 .../net/wireless/mediatek/mt76/mt7921/mac.c   |  6 +++++
 .../net/wireless/mediatek/mt76/mt7921/main.c  |  4 +--
 .../wireless/mediatek/mt76/mt7921/mt7921.h    |  3 +++
 4 files changed, 23 insertions(+), 17 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c
index 68f393c07a31..7cdfdf83529f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c
@@ -95,30 +95,27 @@ static int
 mt7921_tx_stats_show(struct seq_file *file, void *data)
 {
 	struct mt7921_dev *dev = file->private;
-	int stat[8], i, n;
+	struct mt7921_phy *phy = &dev->phy;
+	struct mib_stats *mib = &phy->mib;
+	int i;
 
 	mt7921_mutex_acquire(dev);
 
-	mt7921_ampdu_stat_read_phy(&dev->phy, file);
+	mt7921_ampdu_stat_read_phy(phy, file);
 
-	/* Tx amsdu info */
 	seq_puts(file, "Tx MSDU stat:\n");
-	for (i = 0, n = 0; i < ARRAY_SIZE(stat); i++) {
-		stat[i] = mt76_rr(dev,  MT_PLE_AMSDU_PACK_MSDU_CNT(i));
-		n += stat[i];
-	}
-
-	mt7921_mutex_release(dev);
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
 
+	mt7921_mutex_release(dev);
+
 	return 0;
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index d45c54f92b9e..db3302b1576a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -1375,6 +1375,12 @@ void mt7921_mac_update_mib_stats(struct mt7921_phy *phy)
 	mib->rx_ampdu_bytes_cnt += mt76_rr(dev, MT_MIB_SDR23(0));
 	mib->rx_ba_cnt += mt76_rr(dev, MT_MIB_SDR31(0));
 
+	for (i = 0; i < ARRAY_SIZE(mib->tx_amsdu); i++) {
+		val = mt76_rr(dev, MT_PLE_AMSDU_PACK_MSDU_CNT(i));
+		mib->tx_amsdu[i] += val;
+		mib->tx_amsdu_cnt += val;
+	}
+
 	for (i = 0, aggr1 = aggr0 + 4; i < 4; i++) {
 		u32 val2;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index bd49cfd59617..575f23d9ec52 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -958,8 +958,8 @@ void mt7921_get_et_stats(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	data[ei++] = mib->tx_bf_rx_fb_ht_cnt;
 
 	/* Tx amsdu info (pack-count histogram) */
-	for (i = 0; i < 8; i++)
-		data[ei++] = mt76_rr(dev,  MT_PLE_AMSDU_PACK_MSDU_CNT(i));
+	for (i = 0; i < ARRAY_SIZE(mib->tx_amsdu); i++)
+		data[ei++] = mib->tx_amsdu[i];
 
 	/* rx counters */
 	data[ei++] = mib->rx_mpdu_cnt;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index 9347859a291c..e9c7c3a19507 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -148,6 +148,9 @@ struct mib_stats {
 	u32 rx_ampdu_cnt;
 	u32 rx_ampdu_bytes_cnt;
 	u32 rx_ba_cnt;
+
+	u32 tx_amsdu[8];
+	u32 tx_amsdu_cnt;
 };
 
 struct mt7921_phy {
-- 
2.31.1

