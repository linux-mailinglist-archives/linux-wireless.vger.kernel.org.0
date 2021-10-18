Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01B604318A9
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Oct 2021 14:14:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231655AbhJRMQj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 Oct 2021 08:16:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:32938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231648AbhJRMQi (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 Oct 2021 08:16:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9B5156128B;
        Mon, 18 Oct 2021 12:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634559267;
        bh=7QJDuUot3POHKIjINDNsnbEklzQKHSMUq/08vlGIJ7M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lbOicU1gFAgi6FYx+gwjHvJkgSmIhyg4J+dppYK4ZroipmUShep6CZ1yXTjxNYtWU
         CklIkOfGRHjObspLrcU4BrWooni+r8S1+wVjffZ1U8CvkqgFzEB4BG77wKF0XTlsfm
         fdXSF5sHPBL7uimEPhNjig/pgD10Ik+A/xO3xtpOsrty/rvShNpFSWyOOK04ZRuVrX
         ow7JdXQ9HmyNqGRmLegjAitsgizAB+6orOOTpMzFKqEycM14Abp+Q2Z8tuX5Kl5mpd
         x/SaLYuZWkP/cQCkt2UqSUUo/kcFfcgziwdiM88hPpyQI83nB/HS8s1BtF1T7UxQ8H
         F0TJUN5FBL89A==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, greearb@candelatech.com
Subject: [PATCH 08/10] mt76: mt7915: run mt7915_get_et_stats holding mt76 mutex
Date:   Mon, 18 Oct 2021 14:14:07 +0200
Message-Id: <37148069daf8df7910a3e88dab12731f6fbe5f4a.1634558817.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1634558817.git.lorenzo@kernel.org>
References: <cover.1634558817.git.lorenzo@kernel.org>
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
index 86c681dd7a62..a0edcc78f66d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
@@ -209,7 +209,10 @@ mt7915_tx_stats_show(struct seq_file *file, void *data)
 	struct mt7915_dev *dev = phy->dev;
 	int stat[8], i, n;
 
+	mutex_lock(&dev->mt76.mutex);
+
 	mt7915_ampdu_stat_read_phy(phy, file);
+	mt7915_mac_update_stats(phy);
 	mt7915_txbf_stat_read_phy(phy, file);
 
 	/* Tx amsdu info */
@@ -228,6 +231,8 @@ mt7915_tx_stats_show(struct seq_file *file, void *data)
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
index 4d5009f6954b..13ef56205c98 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -1219,6 +1219,10 @@ void mt7915_get_et_stats(struct ieee80211_hw *hw,
 	if (!phy)
 		return;
 
+	mutex_lock(&dev->mt76.mutex);
+
+	mt7915_mac_update_stats(phy);
+
 	data[ei++] = mib->tx_ampdu_cnt;
 	data[ei++] = mib->tx_stop_q_empty_cnt;
 	data[ei++] = mib->tx_mpdu_attempts_cnt;
@@ -1282,6 +1286,8 @@ void mt7915_get_et_stats(struct ieee80211_hw *hw,
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

