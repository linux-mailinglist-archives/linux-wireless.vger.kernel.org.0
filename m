Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4C4921361C
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jul 2020 10:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbgGCIQr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 3 Jul 2020 04:16:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:46150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726834AbgGCIQq (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 3 Jul 2020 04:16:46 -0400
Received: from lore-desk.lan (unknown [151.48.138.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A03E5207DA;
        Fri,  3 Jul 2020 08:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593764206;
        bh=wKywMJcjNF6e2YAhradyZPmRGgNZ6TNJaJoCFUTvbt0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hOD0XSZcJ1gf7K13TMuuTXOch5PFSheEGpNLJTwasrDvFo2WRNoZiHVMb06g8IcXP
         oqiTTkH9jehQNmmDPu4rPImqPMAeuX16jWy+TzuV2FRGA/I2mNNRnR1TGQTyyYPv5Z
         cfBwQHIVA/zRT5BbGmJfgjMzJGI9x/Ih1dfufKIw=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        ryder.lee@mediatek.com, sean.wang@mediatek.com,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v2 14/22] mt76: mt7615: wake device before pulling packets from mac80211 queues
Date:   Fri,  3 Jul 2020 10:15:53 +0200
Message-Id: <8352fe8983d7308fd332cfc6579993e5d8054566.1593763584.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1593763584.git.lorenzo@kernel.org>
References: <cover.1593763584.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Make sure the device is in full-power before pulling frames from
mac80211 queues

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7615/mac.c   |  6 +++++-
 .../net/wireless/mediatek/mt76/mt7615/main.c  | 20 ++++++++++++++++++-
 2 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index f62e7de81bd5..e3dbbf957426 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -1841,9 +1841,13 @@ void mt7615_pm_wake_work(struct work_struct *work)
 						pm.wake_work);
 	mphy = dev->phy.mt76;
 
-	if (mt7615_driver_own(dev))
+	if (mt7615_driver_own(dev)) {
 		dev_err(mphy->dev->dev, "failed to wake device\n");
+		goto out;
+	}
 
+	tasklet_schedule(&dev->mt76.tx_tasklet);
+out:
 	complete_all(&dev->pm.wake_cmpl);
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index 47dca270150d..3ff387f31659 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -638,6 +638,24 @@ static void mt7615_sta_rate_tbl_update(struct ieee80211_hw *hw,
 	spin_unlock_bh(&dev->mt76.lock);
 }
 
+static void
+mt7615_wake_tx_queue(struct ieee80211_hw *hw, struct ieee80211_txq *txq)
+{
+	struct mt7615_dev *dev = mt7615_hw_dev(hw);
+	struct mt7615_phy *phy = mt7615_hw_phy(hw);
+	struct mt76_phy *mphy = phy->mt76;
+
+	if (!test_bit(MT76_STATE_RUNNING, &mphy->state))
+		return;
+
+	if (test_bit(MT76_STATE_PM, &mphy->state)) {
+		queue_work(dev->mt76.wq, &dev->pm.wake_work);
+		return;
+	}
+
+	tasklet_schedule(&dev->mt76.tx_tasklet);
+}
+
 static void mt7615_tx(struct ieee80211_hw *hw,
 		      struct ieee80211_tx_control *control,
 		      struct sk_buff *skb)
@@ -1134,7 +1152,7 @@ const struct ieee80211_ops mt7615_ops = {
 	.set_key = mt7615_set_key,
 	.ampdu_action = mt7615_ampdu_action,
 	.set_rts_threshold = mt7615_set_rts_threshold,
-	.wake_tx_queue = mt76_wake_tx_queue,
+	.wake_tx_queue = mt7615_wake_tx_queue,
 	.sta_rate_tbl_update = mt7615_sta_rate_tbl_update,
 	.sw_scan_start = mt76_sw_scan,
 	.sw_scan_complete = mt76_sw_scan_complete,
-- 
2.26.2

