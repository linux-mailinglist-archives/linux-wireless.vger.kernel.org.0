Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3DD821362B
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jul 2020 10:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbgGCIR4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 3 Jul 2020 04:17:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:47084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725786AbgGCIR4 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 3 Jul 2020 04:17:56 -0400
Received: from lore-desk.lan (unknown [151.48.138.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3DB3C206A1;
        Fri,  3 Jul 2020 08:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593764275;
        bh=I83+zEt9PNzwzVhZZPeJ02tG1GEPLO9/SyXaDTLKZh4=;
        h=From:To:Cc:Subject:Date:From;
        b=pq9HE1DSlz7cQsu0DJS/QDNnYXcBLd2iPoX2RdcqRX2Cmy17ASpeS/+u7zu4icuQF
         5cHf3qXkk9Ic/LWJViLkH94PWNGsCUtNGfG6QF57VHd3L9Lkj2BI3ScL4H4lyBsXKp
         5mVCAR/wku/yaP+2yoK+6FjEzr+AozBBh1iL3D0M=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        ryder.lee@mediatek.com, sean.wang@mediatek.com,
        linux-mediatek@lists.infradead.org
Subject: [PATCH] mt76: mt7663u: sync probe sampling with rate configuration
Date:   Fri,  3 Jul 2020 10:17:35 +0200
Message-Id: <b55eed7dee4a8f0b1814a4b253e0c21c0066f5ec.1593763616.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On usb device rate configuration for sampling is performed relying on a
workqueue since it is not possible to access the device in the interrupt
context. Move the configuration of the probe_rate flag in the workqueue
in order to keep probe sampling in sync with actual rate configuration

Fixes: eb99cc95c3b6 ("mt76: mt7615: introduce mt7663u support")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7615/mac.c   |  5 +++-
 .../net/wireless/mediatek/mt76/mt7615/main.c  |  4 +--
 .../wireless/mediatek/mt76/mt7615/pci_mac.c   |  1 -
 .../net/wireless/mediatek/mt76/mt7615/usb.c   | 28 +++++++++++--------
 4 files changed, 22 insertions(+), 16 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index fa7a4148ab07..ea9128b4ae09 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -917,6 +917,9 @@ mt7615_mac_queue_rate_update(struct mt7615_phy *phy, struct mt7615_sta *sta,
 	struct mt7615_dev *dev = phy->dev;
 	struct mt7615_wtbl_desc *wd;
 
+	if (work_pending(&dev->wtbl_work))
+		return -EBUSY;
+
 	wd = kzalloc(sizeof(*wd), GFP_ATOMIC);
 	if (!wd)
 		return -ENOMEM;
@@ -1023,6 +1026,7 @@ void mt7615_mac_set_rates(struct mt7615_phy *phy, struct mt7615_sta *sta,
 
 	sta->rate_count = 2 * MT7615_RATE_RETRY * n_rates;
 	sta->wcid.tx_info |= MT_WCID_TX_INFO_SET;
+	sta->rate_probe = !!probe_rate;
 }
 EXPORT_SYMBOL_GPL(mt7615_mac_set_rates);
 
@@ -1231,7 +1235,6 @@ static bool mt7615_fill_txs(struct mt7615_dev *dev, struct mt7615_sta *sta,
 				phy = dev->mt76.phy2->priv;
 
 			mt7615_mac_set_rates(phy, sta, NULL, sta->rates);
-			sta->rate_probe = false;
 		}
 		spin_unlock_bh(&dev->mt76.lock);
 	} else {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index b1cfae7c4b55..79453c890f20 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -683,10 +683,8 @@ static void mt7615_sta_rate_tbl_update(struct ieee80211_hw *hw,
 			break;
 	}
 	msta->n_rates = i;
-	if (!test_bit(MT76_STATE_PM, &phy->mt76->state)) {
+	if (!test_bit(MT76_STATE_PM, &phy->mt76->state))
 		mt7615_mac_set_rates(phy, msta, NULL, msta->rates);
-		msta->rate_probe = false;
-	}
 	spin_unlock_bh(&dev->mt76.lock);
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c
index 7ec91c0856f5..2d67f9a148cd 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c
@@ -155,7 +155,6 @@ int mt7615_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 		spin_lock_bh(&dev->mt76.lock);
 		mt7615_mac_set_rates(phy, msta, &info->control.rates[0],
 				     msta->rates);
-		msta->rate_probe = true;
 		spin_unlock_bh(&dev->mt76.lock);
 	}
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/usb.c b/drivers/net/wireless/mediatek/mt76/mt7615/usb.c
index a780127377bf..feda5d0c171e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/usb.c
@@ -140,6 +140,8 @@ __mt7663u_mac_set_rates(struct mt7615_dev *dev,
 
 	mt76_wr(dev, addr + 27 * 4, w27);
 
+	sta->rate_probe = sta->rateset[rate->rateset].probe_rate.idx != -1;
+
 	mt76_set(dev, MT_LPON_T0CR, MT_LPON_T0CR_MODE); /* TSF read */
 	val = mt76_rr(dev, MT_LPON_UTTR0);
 	sta->rate_set_tsf = (val & ~BIT(0)) | rate->rateset;
@@ -196,17 +198,21 @@ __mt7663u_mac_set_key(struct mt7615_dev *dev,
 void mt7663u_wtbl_work(struct work_struct *work)
 {
 	struct mt7615_wtbl_desc *wd, *wd_next;
+	struct list_head wd_list;
 	struct mt7615_dev *dev;
 
 	dev = (struct mt7615_dev *)container_of(work, struct mt7615_dev,
 						wtbl_work);
 
-	mt7615_mutex_acquire(dev);
+	INIT_LIST_HEAD(&wd_list);
+	spin_lock_bh(&dev->mt76.lock);
+	list_splice_init(&dev->wd_head, &wd_list);
+	spin_unlock_bh(&dev->mt76.lock);
 
-	list_for_each_entry_safe(wd, wd_next, &dev->wd_head, node) {
-		spin_lock_bh(&dev->mt76.lock);
+	list_for_each_entry_safe(wd, wd_next, &wd_list, node) {
 		list_del(&wd->node);
-		spin_unlock_bh(&dev->mt76.lock);
+
+		mt7615_mutex_acquire(dev);
 
 		switch (wd->type) {
 		case MT7615_WTBL_RATE_DESC:
@@ -216,10 +222,11 @@ void mt7663u_wtbl_work(struct work_struct *work)
 			__mt7663u_mac_set_key(dev, wd);
 			break;
 		}
+
+		mt7615_mutex_release(dev);
+
 		kfree(wd);
 	}
-
-	mt7615_mutex_release(dev);
 }
 
 static void
@@ -236,17 +243,16 @@ mt7663u_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 		       struct ieee80211_sta *sta,
 		       struct mt76_tx_info *tx_info)
 {
+	struct mt7615_sta *msta = container_of(wcid, struct mt7615_sta, wcid);
 	struct mt7615_dev *dev = container_of(mdev, struct mt7615_dev, mt76);
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(tx_info->skb);
 
-	if (info->flags & IEEE80211_TX_CTL_RATE_CTRL_PROBE) {
-		struct mt7615_sta *msta;
-
-		msta = container_of(wcid, struct mt7615_sta, wcid);
+	if ((info->flags & IEEE80211_TX_CTL_RATE_CTRL_PROBE) &&
+	    !msta->rate_probe) {
+		/* request to configure sampling rate */
 		spin_lock_bh(&dev->mt76.lock);
 		mt7615_mac_set_rates(&dev->phy, msta, &info->control.rates[0],
 				     msta->rates);
-		msta->rate_probe = true;
 		spin_unlock_bh(&dev->mt76.lock);
 	}
 	mt7663u_mac_write_txwi(dev, wcid, qid, sta, tx_info->skb);
-- 
2.26.2

