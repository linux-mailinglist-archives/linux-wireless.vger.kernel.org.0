Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16293433349
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Oct 2021 12:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235167AbhJSKPX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 19 Oct 2021 06:15:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:58720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235166AbhJSKPW (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 19 Oct 2021 06:15:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9B3B16137C;
        Tue, 19 Oct 2021 10:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634638389;
        bh=3tXRKb0n/fmzj+r29whG0hZdvaiqCsxyEu2emfzd+1w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EPDJVQZ9BkW1w5lUV+d1ApUXqERcE+FsMm2oz1rNwhD5+n8CHxKXMB90PwIcRD43k
         dXolnwCppE3H6D8BkYCXm+MnIvu+sBUoz9A9XWe+25SOWDuMHsGurcMyBGCD+Q6CIE
         U0vi4q6IB8hSJIrXDeRqsOL5B3TK6nBv5zAhcWIMG0vrU0JQBmOzYG3vZ3Xo6qxzbc
         31+MQsCYEOsKTNvHCYk/uFTV7YzTs3ytH6BhSL0fpCJCyw7KL3YhFdkbHNsZJknKIJ
         nNPc9pt9CLrPPOta8IHuxkyGy1W2xmIItuZjCGWawOw6/wcK5uHEeTWC9XU9XlDe9g
         /VimQybuXdSHg==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, greearb@candelatech.com,
        ryder.lee@mediatek.com
Subject: [PATCH v2 03/10] mt76: mt7915: run mt7915_get_et_stats holding mt76 mutex
Date:   Tue, 19 Oct 2021 12:12:25 +0200
Message-Id: <44d66f15f3cb34939812fd665fa52cf443a8d73a.1634637742.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1634637742.git.lorenzo@kernel.org>
References: <cover.1634637742.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Since it can run in parallel with mac_work, hold mutex lock in
mt7915_get_et_stats. Moreover update mib counters running
mt7915_get_et_stats.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c | 5 +++++
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c     | 3 +--
 drivers/net/wireless/mediatek/mt76/mt7915/main.c    | 6 ++++++
 drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h  | 1 +
 4 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
index 6efa3d7e39be..a265069c4d4d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
@@ -201,7 +201,10 @@ mt7915_tx_stats_show(struct seq_file *file, void *data)
 	struct mt7915_dev *dev = phy->dev;
 	int stat[8], i, n;
 
+	mutex_lock(&dev->mt76.mutex);
+
 	mt7915_ampdu_stat_read_phy(phy, file);
+	mt7915_mac_update_stats(phy);
 	mt7915_txbf_stat_read_phy(phy, file);
 
 	/* Tx amsdu info */
@@ -220,6 +223,8 @@ mt7915_tx_stats_show(struct seq_file *file, void *data)
 			seq_puts(file, "\n");
 	}
 
+	mutex_unlock(&dev->mt76.mutex);
+
 	return 0;
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index edf62e0a7ff0..1fb0420276a1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -1918,8 +1918,7 @@ void mt7915_mac_reset_work(struct work_struct *work)
 					     MT7915_WATCHDOG_TIME);
 }
 
-static void
-mt7915_mac_update_stats(struct mt7915_phy *phy)
+void mt7915_mac_update_stats(struct mt7915_phy *phy)
 {
 	struct mt7915_dev *dev = phy->dev;
 	struct mib_stats *mib = &phy->mib;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index f0fe4ee30e79..1159059f705a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -1215,6 +1215,10 @@ void mt7915_get_et_stats(struct ieee80211_hw *hw,
 	bool ext_phy = phy != &dev->phy;
 	int i, n, ei = 0;
 
+	mutex_lock(&dev->mt76.mutex);
+
+	mt7915_mac_update_stats(phy);
+
 	data[ei++] = mib->tx_ampdu_cnt;
 	data[ei++] = mib->tx_stop_q_empty_cnt;
 	data[ei++] = mib->tx_mpdu_attempts_cnt;
@@ -1278,6 +1282,8 @@ void mt7915_get_et_stats(struct ieee80211_hw *hw,
 	wi.initial_stat_idx = ei;
 	ieee80211_iterate_stations_atomic(hw, mt7915_ethtool_worker, &wi);
 
+	mutex_unlock(&dev->mt76.mutex);
+
 	if (wi.sta_count == 0)
 		return;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index 2acede0d5bf2..0a2dd2f18fe5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -481,6 +481,7 @@ void mt7915_mac_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 void mt7915_mac_work(struct work_struct *work);
 void mt7915_mac_reset_work(struct work_struct *work);
 void mt7915_mac_sta_rc_work(struct work_struct *work);
+void mt7915_mac_update_stats(struct mt7915_phy *phy);
 int mt7915_mmio_init(struct mt76_dev *mdev, void __iomem *mem_base, int irq);
 void mt7915_mac_twt_teardown_flow(struct mt7915_dev *dev,
 				  struct mt7915_sta *msta,
-- 
2.31.1

