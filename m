Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5C91B3A7D
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Apr 2020 10:47:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbgDVIrp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 22 Apr 2020 04:47:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:52922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725786AbgDVIrp (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 22 Apr 2020 04:47:45 -0400
Received: from lore-desk-wlan.redhat.com (unknown [151.66.196.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C25CF206E9;
        Wed, 22 Apr 2020 08:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587545264;
        bh=VD/d7xnxoigicRP8uPAQVI4GjINnObaSoIi01c0lugM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uYz+bT9xgyZAle/c0iUTrWPa7wUEh9Ki+9uaftmlrM3rM6acqdjlko72JjkVglf1X
         6cNxqcYhl1dC3tynwPTM/fHnBAbppj7/syoVC/2FJ6WER0Zm/oz53Vf4+3SZ4M3XCM
         BklYbHmlb9rzD2RlhtEW5+XercFiMskqLvRJBX3c=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, linux-mediatek@lists.infradead.org
Subject: [PATCH 1/2] mt76: mt7615: rework mt7615_mac_sta_poll for usb code
Date:   Wed, 22 Apr 2020 10:47:23 +0200
Message-Id: <0b853a4e075d4308fc4e0cf6193a7c6c7fae4c3c.1587545092.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.25.3
In-Reply-To: <cover.1587545092.git.lorenzo@kernel.org>
References: <cover.1587545092.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Since usb code can't access device registers in interrupt context, move
rcu_read_lock/rcu_read_unlock in mt7615_poll_tx routine. Moreover loop
over a local msta list in mt7615_mac_sta_poll since mt7663u driver will
not be able to complete the inner while loop before sta_poll_list list
is refilled by mt7615_mac_add_txs/mt7615_mac_fill_rx

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7615/dma.c   |  2 ++
 .../net/wireless/mediatek/mt76/mt7615/mac.c   | 20 ++++++++-----------
 2 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/dma.c b/drivers/net/wireless/mediatek/mt76/mt7615/dma.c
index b0ba0e7807bf..5cdbe3747901 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/dma.c
@@ -121,7 +121,9 @@ static int mt7615_poll_tx(struct napi_struct *napi, int budget)
 
 	mt7615_tx_cleanup(dev);
 
+	rcu_read_lock();
 	mt7615_mac_sta_poll(dev);
+	rcu_read_unlock();
 
 	tasklet_schedule(&dev->mt76.tx_tasklet);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index 3dab07d3eb1d..396f11e1bbf6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -724,22 +724,20 @@ void mt7615_mac_sta_poll(struct mt7615_dev *dev)
 	struct ieee80211_sta *sta;
 	struct mt7615_sta *msta;
 	u32 addr, tx_time[4], rx_time[4];
+	struct list_head sta_poll_list;
 	int i;
 
-	rcu_read_lock();
+	INIT_LIST_HEAD(&sta_poll_list);
+	spin_lock_bh(&dev->sta_poll_lock);
+	list_splice_init(&dev->sta_poll_list, &sta_poll_list);
+	spin_unlock_bh(&dev->sta_poll_lock);
 
-	while (true) {
+	while (!list_empty(&sta_poll_list)) {
 		bool clear = false;
 
-		spin_lock_bh(&dev->sta_poll_lock);
-		if (list_empty(&dev->sta_poll_list)) {
-			spin_unlock_bh(&dev->sta_poll_lock);
-			break;
-		}
-		msta = list_first_entry(&dev->sta_poll_list,
-					struct mt7615_sta, poll_list);
+		msta = list_first_entry(&sta_poll_list, struct mt7615_sta,
+					poll_list);
 		list_del_init(&msta->poll_list);
-		spin_unlock_bh(&dev->sta_poll_lock);
 
 		addr = mt7615_mac_wtbl_addr(dev, msta->wcid.idx) + 19 * 4;
 
@@ -779,8 +777,6 @@ void mt7615_mac_sta_poll(struct mt7615_dev *dev)
 						       rx_cur);
 		}
 	}
-
-	rcu_read_unlock();
 }
 EXPORT_SYMBOL_GPL(mt7615_mac_sta_poll);
 
-- 
2.25.3

