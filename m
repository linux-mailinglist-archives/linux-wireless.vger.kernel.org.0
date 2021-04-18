Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5111A3636C5
	for <lists+linux-wireless@lfdr.de>; Sun, 18 Apr 2021 18:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232211AbhDRQqj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 18 Apr 2021 12:46:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:49838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232212AbhDRQqi (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 18 Apr 2021 12:46:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 93B866135B;
        Sun, 18 Apr 2021 16:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618764370;
        bh=PVh0zXcYllRpd7ThgXv1XDRx11dBGkt+zrLWlYoYFBw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XWoR2gw5BxnEBBvV3/mOVQb0NHRmwKcexp10ZB154ZCivk6YT8md+yb4J/j/FFSqs
         N4krdCLc7C0U9tMt2DXUxE1ksH/gWmHv11R9m/B/3Ve1zxIC6+RaTKqiHUu3cc9k9P
         UzFpHYX+ADAg9KVePHKF5TZpGNig5VeGC2V0BySe61PDo0G2M3Bg9R3kRYPCR/RZPb
         5seGrBWkviIWm5tHe39pPmhMXt6al8BRLxgRX9Sqt+7hc2ZUMhAoVp8BC8QF1ifxa0
         eUb+KhMY25aOhOMEOtuJmzoG160kym9Ds8qVyNqlHzvuN/rMobIzL4imtMoc2NDGIf
         4cdY6vCVtpWtw==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com
Subject: [PATCH 11/19] mt76: connac: remove MT76_STATE_PM in mac_tx_free
Date:   Sun, 18 Apr 2021 18:45:37 +0200
Message-Id: <3c4a48970ca9984468d927b9504a3c97ff91de4c.1618763001.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1618763000.git.lorenzo@kernel.org>
References: <cover.1618763000.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Get rid of MT76_STATE_PM chec in mt7615_mac_tx_free and
mt7921_mac_tx_free since we already rely on mt76_connac_pm_unref in the
NAPI callback.
Remove mt76_connac_power_save_sched calls in mt7615_mac_tx_free and
mt7921_mac_tx_free

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7615/mac.c | 4 ----
 drivers/net/wireless/mediatek/mt76/mt7921/mac.c | 6 ------
 2 files changed, 10 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index e81c7d322811..ad1e236727cb 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -1514,14 +1514,10 @@ static void mt7615_mac_tx_free(struct mt7615_dev *dev, struct sk_buff *skb)
 
 	dev_kfree_skb(skb);
 
-	if (test_bit(MT76_STATE_PM, &dev->phy.mt76->state))
-		return;
-
 	rcu_read_lock();
 	mt7615_mac_sta_poll(dev);
 	rcu_read_unlock();
 
-	mt76_connac_power_save_sched(&dev->mphy, &dev->pm);
 	mt76_worker_schedule(&dev->mt76.tx_worker);
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index def00b255495..a8247a6d5bc7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -1043,13 +1043,7 @@ void mt7921_mac_tx_free(struct mt7921_dev *dev, struct sk_buff *skb)
 		napi_consume_skb(skb, 1);
 	}
 
-	if (test_bit(MT76_STATE_PM, &dev->phy.mt76->state))
-		return;
-
 	mt7921_mac_sta_poll(dev);
-
-	mt76_connac_power_save_sched(&dev->mphy, &dev->pm);
-
 	mt76_worker_schedule(&dev->mt76.tx_worker);
 }
 
-- 
2.30.2

