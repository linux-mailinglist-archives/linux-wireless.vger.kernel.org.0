Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4968843334A
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Oct 2021 12:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235172AbhJSKPY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 19 Oct 2021 06:15:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:58748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235166AbhJSKPY (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 19 Oct 2021 06:15:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2F0826137D;
        Tue, 19 Oct 2021 10:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634638391;
        bh=Cca1+UTn1Fdnb4g8mxWs84xLigH5uC2PSD0uGDb4lug=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ov44X2Fi76Udz7lY3NAp7U9MRY6ir3dytasljWWcmLjRSiXpP5fYgR3zTVmtPbQyh
         kaXeVGPIB9mbNPTuJ9OheP9z/3P3pgdqxdBuSr4anhIftwL8jrpJWWZLCeAiJiPdw3
         WNjN6yoV3sLO5K7ig2MjdBGaqYRhANfaf3HCwMsd17rLuOXnRqjsKRpLiAAgWKXFPY
         1i/87uy/esbYpbr2pznBlHdipZbfdMWNR5pUs+EWLW2arWxNxAnIeidooLGYB9za5N
         5V5l4kEIhZoobv8ns+JqnWO0gMJHl72kN6N94W9dbA45YLHIuCQ3K2Fz9KwXu7n4z3
         VoGHs0r6/hsnw==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, greearb@candelatech.com,
        ryder.lee@mediatek.com
Subject: [PATCH v2 04/10] mt76: mt7915: move tx amsdu stats in mib_stats
Date:   Tue, 19 Oct 2021 12:12:26 +0200
Message-Id: <ef711ca64dc1d7197137edd2a620495d47b8f531.1634637742.git.lorenzo@kernel.org>
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
 .../wireless/mediatek/mt76/mt7915/debugfs.c   | 19 ++++++++-----------
 .../net/wireless/mediatek/mt76/mt7915/mac.c   |  6 ++++++
 .../net/wireless/mediatek/mt76/mt7915/main.c  |  4 ++--
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |  3 +++
 4 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
index a265069c4d4d..4b7f38fcbe64 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
@@ -199,7 +199,8 @@ mt7915_tx_stats_show(struct seq_file *file, void *data)
 {
 	struct mt7915_phy *phy = file->private;
 	struct mt7915_dev *dev = phy->dev;
-	int stat[8], i, n;
+	struct mib_stats *mib = &phy->mib;
+	int i;
 
 	mutex_lock(&dev->mt76.mutex);
 
@@ -209,16 +210,12 @@ mt7915_tx_stats_show(struct seq_file *file, void *data)
 
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
index 1159059f705a..15daacabed75 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -1260,8 +1260,8 @@ void mt7915_get_et_stats(struct ieee80211_hw *hw,
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

