Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA2C1232F8D
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Jul 2020 11:35:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729399AbgG3Jev (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Jul 2020 05:34:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:49716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729391AbgG3Jeu (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Jul 2020 05:34:50 -0400
Received: from lore-desk.redhat.com (unknown [151.48.137.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1971020809;
        Thu, 30 Jul 2020 09:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596101690;
        bh=bT7EdanZURXAbwI1Zq35GiBO4tuHjbACa4VTmy3PHJk=;
        h=From:To:Cc:Subject:Date:From;
        b=0jb0X2wWBNo5lINYgoZORy0UHrl5MYhl3Ggld+Fn2KOyzl1z7hgV5GCe+OijX5m1r
         sKAz6oBVtLoh+UxHDcpjmADzmhIEj1M4ZcbzF8N51SFLdeyD7pxdJoO2RObyQ9Orng
         2cPxuAXrqn2qJHK/KtRgtVUf+Xxl1zVzKCs5X1iM=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, sean.wang@mediatek.com,
        linux-wireless@vger.kernel.org
Subject: [PATCH] mt76: mt7615: reschedule runtime-pm receiving a tx interrupt
Date:   Thu, 30 Jul 2020 11:34:43 +0200
Message-Id: <d7fe74ccae0ba7be7418a36a6ebe6ab949835e28.1596101569.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Reschedule runtime-pm after receiving a tx interrupt.
Update runtime-pm last activity before injecting packets

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7615/dma.c  | 1 +
 drivers/net/wireless/mediatek/mt76/mt7615/mac.c  | 4 ++++
 drivers/net/wireless/mediatek/mt76/mt7615/main.c | 2 ++
 3 files changed, 7 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/dma.c b/drivers/net/wireless/mediatek/mt76/mt7615/dma.c
index 1231a5ddf9ea..c876eb1e1681 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/dma.c
@@ -122,6 +122,7 @@ static int mt7615_poll_tx(struct napi_struct *napi, int budget)
 
 	mt7615_tx_cleanup(dev);
 
+	mt7615_pm_power_save_sched(dev);
 	tasklet_schedule(&dev->mt76.tx_tasklet);
 
 	return 0;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index 3dd8dd28690e..28f7d26a7ca2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -1439,10 +1439,14 @@ static void mt7615_mac_tx_free(struct mt7615_dev *dev, struct sk_buff *skb)
 
 	dev_kfree_skb(skb);
 
+	if (test_bit(MT76_STATE_PM, &dev->phy.mt76->state))
+		return;
+
 	rcu_read_lock();
 	mt7615_mac_sta_poll(dev);
 	rcu_read_unlock();
 
+	mt7615_pm_power_save_sched(dev);
 	tasklet_schedule(&dev->mt76.tx_tasklet);
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index bafe2bdeb5eb..9972853f4a29 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -706,6 +706,7 @@ mt7615_wake_tx_queue(struct ieee80211_hw *hw, struct ieee80211_txq *txq)
 		return;
 	}
 
+	dev->pm.last_activity = jiffies;
 	tasklet_schedule(&dev->mt76.tx_tasklet);
 }
 
@@ -735,6 +736,7 @@ static void mt7615_tx(struct ieee80211_hw *hw,
 	}
 
 	if (!test_bit(MT76_STATE_PM, &mphy->state)) {
+		dev->pm.last_activity = jiffies;
 		mt76_tx(mphy, control->sta, wcid, skb);
 		return;
 	}
-- 
2.26.2

