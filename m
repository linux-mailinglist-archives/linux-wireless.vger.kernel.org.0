Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 264EC2AAA8A
	for <lists+linux-wireless@lfdr.de>; Sun,  8 Nov 2020 11:29:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727570AbgKHK1u (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 8 Nov 2020 05:27:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:45750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726115AbgKHK1u (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 8 Nov 2020 05:27:50 -0500
Received: from localhost.localdomain (unknown [151.66.8.153])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8EA3D206ED;
        Sun,  8 Nov 2020 10:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604831269;
        bh=6sztFWg0chHTeK9/wSMLhenK2B2WzBJwoIo1GTD4IK4=;
        h=From:To:Cc:Subject:Date:From;
        b=06UfAjWmBvidURWesAsUKdNfeP65n0L3z9jqSPgtWg7IJTzDjncIxDB+FnV+IkW+E
         SwmDyynquQ6sWLRa8gKSlIzofqoTuSm0nBKkEk0dw1ee/KXUZjTwPnHHMcfsV6fEiT
         Ygs7nnjsuNXFM53mNLrPiXplP3ktuZaIHF/ZBawI=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org
Subject: [PATCH] mt76: mt7615: refactor usb/sdio rate code
Date:   Sun,  8 Nov 2020 11:27:45 +0100
Message-Id: <874065f46c83a2665891cda6458d938518681b8e.1604831067.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Since wtbl workqueue is used only for rate handling, refactor code to
make it more clear

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
This patch is based on "mt76: mt7615: run key configuration in mt7615_set_key
for usb/sdio devices"
---
 .../net/wireless/mediatek/mt76/mt7615/mac.c   | 18 ++++-----
 .../wireless/mediatek/mt76/mt7615/mt7615.h    | 17 ++------
 .../wireless/mediatek/mt76/mt7615/usb_sdio.c  | 40 ++++++++-----------
 3 files changed, 28 insertions(+), 47 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index 9df28608d6bb..1585d4dfdbbe 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -915,22 +915,20 @@ mt7615_mac_queue_rate_update(struct mt7615_phy *phy, struct mt7615_sta *sta,
 			     struct ieee80211_tx_rate *rates)
 {
 	struct mt7615_dev *dev = phy->dev;
-	struct mt7615_wtbl_desc *wd;
+	struct mt7615_wtbl_rate_desc *wrd;
 
-	if (work_pending(&dev->wtbl_work))
+	if (work_pending(&dev->rate_work))
 		return -EBUSY;
 
-	wd = kzalloc(sizeof(*wd), GFP_ATOMIC);
-	if (!wd)
+	wrd = kzalloc(sizeof(*wrd), GFP_ATOMIC);
+	if (!wrd)
 		return -ENOMEM;
 
-	wd->type = MT7615_WTBL_RATE_DESC;
-	wd->sta = sta;
-
+	wrd->sta = sta;
 	mt7615_mac_update_rate_desc(phy, sta, probe_rate, rates,
-				    &wd->rate);
-	list_add_tail(&wd->node, &dev->wd_head);
-	queue_work(dev->mt76.wq, &dev->wtbl_work);
+				    &wrd->rate);
+	list_add_tail(&wrd->node, &dev->wrd_head);
+	queue_work(dev->mt76.wq, &dev->rate_work);
 
 	return 0;
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index 73000d7f0d84..f86e83d4702e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -106,19 +106,11 @@ struct mt7615_rate_desc {
 	u8 bw;
 };
 
-enum mt7615_wtbl_desc_type {
-	MT7615_WTBL_RATE_DESC,
-};
-
-struct mt7615_wtbl_desc {
+struct mt7615_wtbl_rate_desc {
 	struct list_head node;
 
-	enum mt7615_wtbl_desc_type type;
+	struct mt7615_rate_desc rate;
 	struct mt7615_sta *sta;
-
-	union {
-		struct mt7615_rate_desc rate;
-	};
 };
 
 struct mt7615_sta {
@@ -281,8 +273,8 @@ struct mt7615_dev {
 
 	u8 fw_ver;
 
-	struct work_struct wtbl_work;
-	struct list_head wd_head;
+	struct work_struct rate_work;
+	struct list_head wrd_head;
 
 	u32 debugfs_rf_wf;
 	u32 debugfs_rf_reg;
@@ -660,7 +652,6 @@ int mt7663_usb_sdio_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 bool mt7663_usb_sdio_tx_status_data(struct mt76_dev *mdev, u8 *update);
 void mt7663_usb_sdio_tx_complete_skb(struct mt76_dev *mdev,
 				     struct mt76_queue_entry *e);
-void mt7663_usb_sdio_wtbl_work(struct work_struct *work);
 int mt7663_usb_sdio_register_device(struct mt7615_dev *dev);
 int mt7663u_mcu_init(struct mt7615_dev *dev);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/usb_sdio.c b/drivers/net/wireless/mediatek/mt76/mt7615/usb_sdio.c
index eb3a14cb6cc1..203256862dfd 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/usb_sdio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/usb_sdio.c
@@ -61,12 +61,11 @@ mt7663_usb_sdio_write_txwi(struct mt7615_dev *dev, struct mt76_wcid *wcid,
 	skb_push(skb, MT_USB_TXD_SIZE);
 }
 
-static int
-mt7663_usb_sdio_set_rates(struct mt7615_dev *dev,
-			  struct mt7615_wtbl_desc *wd)
+static int mt7663_usb_sdio_set_rates(struct mt7615_dev *dev,
+				     struct mt7615_wtbl_rate_desc *wrd)
 {
-	struct mt7615_rate_desc *rate = &wd->rate;
-	struct mt7615_sta *sta = wd->sta;
+	struct mt7615_rate_desc *rate = &wrd->rate;
+	struct mt7615_sta *sta = wrd->sta;
 	u32 w5, w27, addr, val;
 
 	lockdep_assert_held(&dev->mt76.mutex);
@@ -132,37 +131,30 @@ mt7663_usb_sdio_set_rates(struct mt7615_dev *dev,
 	return 0;
 }
 
-void mt7663_usb_sdio_wtbl_work(struct work_struct *work)
+static void mt7663_usb_sdio_rate_work(struct work_struct *work)
 {
-	struct mt7615_wtbl_desc *wd, *wd_next;
-	struct list_head wd_list;
+	struct mt7615_wtbl_rate_desc *wrd, *wrd_next;
+	struct list_head wrd_list;
 	struct mt7615_dev *dev;
 
 	dev = (struct mt7615_dev *)container_of(work, struct mt7615_dev,
-						wtbl_work);
+						rate_work);
 
-	INIT_LIST_HEAD(&wd_list);
+	INIT_LIST_HEAD(&wrd_list);
 	spin_lock_bh(&dev->mt76.lock);
-	list_splice_init(&dev->wd_head, &wd_list);
+	list_splice_init(&dev->wrd_head, &wrd_list);
 	spin_unlock_bh(&dev->mt76.lock);
 
-	list_for_each_entry_safe(wd, wd_next, &wd_list, node) {
-		list_del(&wd->node);
+	list_for_each_entry_safe(wrd, wrd_next, &wrd_list, node) {
+		list_del(&wrd->node);
 
 		mt7615_mutex_acquire(dev);
-
-		switch (wd->type) {
-		case MT7615_WTBL_RATE_DESC:
-			mt7663_usb_sdio_set_rates(dev, wd);
-			break;
-		}
-
+		mt7663_usb_sdio_set_rates(dev, wrd);
 		mt7615_mutex_release(dev);
 
-		kfree(wd);
+		kfree(wrd);
 	}
 }
-EXPORT_SYMBOL_GPL(mt7663_usb_sdio_wtbl_work);
 
 bool mt7663_usb_sdio_tx_status_data(struct mt76_dev *mdev, u8 *update)
 {
@@ -308,8 +300,8 @@ int mt7663_usb_sdio_register_device(struct mt7615_dev *dev)
 	struct ieee80211_hw *hw = mt76_hw(dev);
 	int err;
 
-	INIT_WORK(&dev->wtbl_work, mt7663_usb_sdio_wtbl_work);
-	INIT_LIST_HEAD(&dev->wd_head);
+	INIT_WORK(&dev->rate_work, mt7663_usb_sdio_rate_work);
+	INIT_LIST_HEAD(&dev->wrd_head);
 	mt7615_init_device(dev);
 
 	err = mt7663_usb_sdio_init_hardware(dev);
-- 
2.26.2

