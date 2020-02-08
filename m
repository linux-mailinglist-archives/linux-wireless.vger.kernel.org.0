Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DBFD4156441
	for <lists+linux-wireless@lfdr.de>; Sat,  8 Feb 2020 13:45:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727130AbgBHMow (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 8 Feb 2020 07:44:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:60172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727118AbgBHMow (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 8 Feb 2020 07:44:52 -0500
Received: from lore-desk-wlan.lan (unknown [151.48.137.85])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C985D2082E;
        Sat,  8 Feb 2020 12:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581165891;
        bh=Mhe7cu8TExGD4xwZSl8/fjhpSQWVm1KIhd/SjML04io=;
        h=From:To:Cc:Subject:Date:From;
        b=dotv2ySHPlfAPq8kdNj4SEsN7+YJxwpp7KhywlSNMzAbcAnSQb/MpyCrx5D1+wcMw
         ANUqA+nOt6/KNqWeqrZf4ReptOsXxIo5jbDcYCvPTj8QAtI7eii3dSrTi0dBoX5WwP
         17uykkc54bk+0wPymSdbj8s4qb0VXa6Zf7nixBoQ=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org
Subject: [PATCH v2] mt76: Introduce mt76_mcu data structure
Date:   Sat,  8 Feb 2020 13:44:28 +0100
Message-Id: <22fdd9d341e590a291546887d50af881de826b1c.1581161382.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce mt76_mcu data structure to contain common fields between
mt76u_mcu and mt76e_mcu.
Initialize mcu common fields in mt76_alloc_device().
Rely on mt76_mcu in mt76_mcu_rx_event and in mt76_mcu_get_response
in order to reuse them in usb code

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
Changes since v1:
- squash patch 2/3 and 3/3 with 1/3
- move mt76_mcu in mt76_dev
- initialize mt76_mcu in mt76_alloc_device
---
 drivers/net/wireless/mediatek/mt76/mac80211.c |  4 ++++
 drivers/net/wireless/mediatek/mt76/mcu.c      | 11 ++++-----
 drivers/net/wireless/mediatek/mt76/mmio.c     |  3 ---
 drivers/net/wireless/mediatek/mt76/mt76.h     | 21 ++++++++---------
 .../net/wireless/mediatek/mt76/mt7603/mcu.c   | 10 ++++----
 .../net/wireless/mediatek/mt76/mt7615/mac.c   |  2 +-
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   | 10 ++++----
 .../net/wireless/mediatek/mt76/mt76x02_mcu.c  | 10 ++++----
 .../net/wireless/mediatek/mt76/mt76x02_mmio.c |  4 ++--
 .../net/wireless/mediatek/mt76/mt76x02_txrx.c |  1 -
 .../wireless/mediatek/mt76/mt76x02_usb_mcu.c  | 23 ++++++++-----------
 drivers/net/wireless/mediatek/mt76/usb.c      |  3 +--
 12 files changed, 48 insertions(+), 54 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index 2a85e0cb5793..8555d61db762 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -421,6 +421,10 @@ mt76_alloc_device(struct device *pdev, unsigned int size,
 	init_waitqueue_head(&dev->tx_wait);
 	skb_queue_head_init(&dev->status_list);
 
+	skb_queue_head_init(&dev->mcu.res_q);
+	init_waitqueue_head(&dev->mcu.wait);
+	mutex_init(&dev->mcu.mutex);
+
 	INIT_LIST_HEAD(&dev->txwi_cache);
 
 	for (i = 0; i < ARRAY_SIZE(dev->q_rx); i++)
diff --git a/drivers/net/wireless/mediatek/mt76/mcu.c b/drivers/net/wireless/mediatek/mt76/mcu.c
index b0fb0830c9e1..633ad948c21d 100644
--- a/drivers/net/wireless/mediatek/mt76/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mcu.c
@@ -24,7 +24,6 @@ mt76_mcu_msg_alloc(const void *data, int head_len,
 }
 EXPORT_SYMBOL_GPL(mt76_mcu_msg_alloc);
 
-/* mmio */
 struct sk_buff *mt76_mcu_get_response(struct mt76_dev *dev,
 				      unsigned long expires)
 {
@@ -34,17 +33,17 @@ struct sk_buff *mt76_mcu_get_response(struct mt76_dev *dev,
 		return NULL;
 
 	timeout = expires - jiffies;
-	wait_event_timeout(dev->mmio.mcu.wait,
-			   (!skb_queue_empty(&dev->mmio.mcu.res_q) ||
+	wait_event_timeout(dev->mcu.wait,
+			   (!skb_queue_empty(&dev->mcu.res_q) ||
 			    test_bit(MT76_MCU_RESET, &dev->phy.state)),
 			   timeout);
-	return skb_dequeue(&dev->mmio.mcu.res_q);
+	return skb_dequeue(&dev->mcu.res_q);
 }
 EXPORT_SYMBOL_GPL(mt76_mcu_get_response);
 
 void mt76_mcu_rx_event(struct mt76_dev *dev, struct sk_buff *skb)
 {
-	skb_queue_tail(&dev->mmio.mcu.res_q, skb);
-	wake_up(&dev->mmio.mcu.wait);
+	skb_queue_tail(&dev->mcu.res_q, skb);
+	wake_up(&dev->mcu.wait);
 }
 EXPORT_SYMBOL_GPL(mt76_mcu_rx_event);
diff --git a/drivers/net/wireless/mediatek/mt76/mmio.c b/drivers/net/wireless/mediatek/mt76/mmio.c
index 1c974df1fe25..7ead6620bb8b 100644
--- a/drivers/net/wireless/mediatek/mt76/mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mmio.c
@@ -94,9 +94,6 @@ void mt76_mmio_init(struct mt76_dev *dev, void __iomem *regs)
 	dev->bus = &mt76_mmio_ops;
 	dev->mmio.regs = regs;
 
-	skb_queue_head_init(&dev->mmio.mcu.res_q);
-	init_waitqueue_head(&dev->mmio.mcu.wait);
 	spin_lock_init(&dev->mmio.irq_lock);
-	mutex_init(&dev->mmio.mcu.mutex);
 }
 EXPORT_SYMBOL_GPL(mt76_mmio_init);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 0956785ad6f8..73a941a11429 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -388,6 +388,14 @@ enum mt76u_out_ep {
 	__MT_EP_OUT_MAX,
 };
 
+struct mt76_mcu {
+	struct mutex mutex;
+	u32 msg_seq;
+
+	struct sk_buff_head res_q;
+	wait_queue_head_t wait;
+};
+
 #define MT_TX_SG_MAX_SIZE	8
 #define MT_RX_SG_MAX_SIZE	1
 #define MT_NUM_TX_ENTRIES	256
@@ -408,10 +416,7 @@ struct mt76_usb {
 	bool sg_en;
 
 	struct mt76u_mcu {
-		struct mutex mutex;
 		u8 *data;
-		u32 msg_seq;
-
 		/* multiple reads */
 		struct mt76_reg_pair *rp;
 		int rp_len;
@@ -421,14 +426,6 @@ struct mt76_usb {
 };
 
 struct mt76_mmio {
-	struct mt76e_mcu {
-		struct mutex mutex;
-
-		wait_queue_head_t wait;
-		struct sk_buff_head res_q;
-
-		u32 msg_seq;
-	} mcu;
 	void __iomem *regs;
 	spinlock_t irq_lock;
 	u32 irqmask;
@@ -506,6 +503,8 @@ struct mt76_dev {
 	const struct mt76_mcu_ops *mcu_ops;
 	struct device *dev;
 
+	struct mt76_mcu mcu;
+
 	struct net_device napi_dev;
 	spinlock_t rx_lock;
 	struct napi_struct napi[__MT_RXQ_MAX];
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7603/mcu.c
index bec58f567010..b466b3ab8a2c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/mcu.c
@@ -22,9 +22,9 @@ __mt7603_mcu_msg_send(struct mt7603_dev *dev, struct sk_buff *skb,
 	struct mt7603_mcu_txd *txd;
 	u8 seq;
 
-	seq = ++mdev->mmio.mcu.msg_seq & 0xf;
+	seq = ++mdev->mcu.msg_seq & 0xf;
 	if (!seq)
-		seq = ++mdev->mmio.mcu.msg_seq & 0xf;
+		seq = ++mdev->mcu.msg_seq & 0xf;
 
 	txd = (struct mt7603_mcu_txd *)skb_push(skb, hdrlen);
 	memset(txd, 0, hdrlen);
@@ -67,7 +67,7 @@ mt7603_mcu_msg_send(struct mt76_dev *mdev, int cmd, const void *data,
 	if (!skb)
 		return -ENOMEM;
 
-	mutex_lock(&mdev->mmio.mcu.mutex);
+	mutex_lock(&mdev->mcu.mutex);
 
 	ret = __mt7603_mcu_msg_send(dev, skb, cmd, &seq);
 	if (ret)
@@ -97,7 +97,7 @@ mt7603_mcu_msg_send(struct mt76_dev *mdev, int cmd, const void *data,
 	}
 
 out:
-	mutex_unlock(&mdev->mmio.mcu.mutex);
+	mutex_unlock(&mdev->mcu.mutex);
 
 	return ret;
 }
@@ -277,7 +277,7 @@ int mt7603_mcu_init(struct mt7603_dev *dev)
 void mt7603_mcu_exit(struct mt7603_dev *dev)
 {
 	__mt76_mcu_restart(&dev->mt76);
-	skb_queue_purge(&dev->mt76.mmio.mcu.res_q);
+	skb_queue_purge(&dev->mt76.mcu.res_q);
 }
 
 int mt7603_mcu_set_eeprom(struct mt7603_dev *dev)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index 17fed8da5bee..eaf8fc25dc75 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -1862,7 +1862,7 @@ void mt7615_mac_reset_work(struct work_struct *work)
 
 	set_bit(MT76_RESET, &dev->mphy.state);
 	set_bit(MT76_MCU_RESET, &dev->mphy.state);
-	wake_up(&dev->mt76.mmio.mcu.wait);
+	wake_up(&dev->mt76.mcu.wait);
 	cancel_delayed_work_sync(&dev->mt76.mac_work);
 
 	/* lock/unlock all queues to ensure that no tx is pending */
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index c93a22110cf9..189fc6401b53 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -88,9 +88,9 @@ static int __mt7615_mcu_msg_send(struct mt7615_dev *dev, struct sk_buff *skb,
 	u32 val;
 	__le32 *txd;
 
-	seq = ++dev->mt76.mmio.mcu.msg_seq & 0xf;
+	seq = ++dev->mt76.mcu.msg_seq & 0xf;
 	if (!seq)
-		seq = ++dev->mt76.mmio.mcu.msg_seq & 0xf;
+		seq = ++dev->mt76.mcu.msg_seq & 0xf;
 
 	mcu_txd = (struct mt7615_mcu_txd *)skb_push(skb,
 		   sizeof(struct mt7615_mcu_txd));
@@ -183,7 +183,7 @@ mt7615_mcu_msg_send(struct mt76_dev *mdev, int cmd, const void *data,
 	if (!skb)
 		return -ENOMEM;
 
-	mutex_lock(&mdev->mmio.mcu.mutex);
+	mutex_lock(&mdev->mcu.mutex);
 
 	ret = __mt7615_mcu_msg_send(dev, skb, cmd, &seq);
 	if (ret)
@@ -204,7 +204,7 @@ mt7615_mcu_msg_send(struct mt76_dev *mdev, int cmd, const void *data,
 	}
 
 out:
-	mutex_unlock(&mdev->mmio.mcu.mutex);
+	mutex_unlock(&mdev->mcu.mutex);
 
 	return ret;
 }
@@ -874,7 +874,7 @@ void mt7615_mcu_exit(struct mt7615_dev *dev)
 {
 	__mt76_mcu_restart(&dev->mt76);
 	mt7615_firmware_own(dev);
-	skb_queue_purge(&dev->mt76.mmio.mcu.res_q);
+	skb_queue_purge(&dev->mt76.mcu.res_q);
 }
 
 int mt7615_mcu_set_eeprom(struct mt7615_dev *dev)
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76x02_mcu.c
index 6274b6a24b07..5664749ad6c1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_mcu.c
@@ -24,11 +24,11 @@ int mt76x02_mcu_msg_send(struct mt76_dev *mdev, int cmd, const void *data,
 	if (!skb)
 		return -ENOMEM;
 
-	mutex_lock(&mdev->mmio.mcu.mutex);
+	mutex_lock(&mdev->mcu.mutex);
 
-	seq = ++mdev->mmio.mcu.msg_seq & 0xf;
+	seq = ++mdev->mcu.msg_seq & 0xf;
 	if (!seq)
-		seq = ++mdev->mmio.mcu.msg_seq & 0xf;
+		seq = ++mdev->mcu.msg_seq & 0xf;
 
 	tx_info = MT_MCU_MSG_TYPE_CMD |
 		  FIELD_PREP(MT_MCU_MSG_CMD_TYPE, cmd) |
@@ -65,7 +65,7 @@ int mt76x02_mcu_msg_send(struct mt76_dev *mdev, int cmd, const void *data,
 	}
 
 out:
-	mutex_unlock(&mdev->mmio.mcu.mutex);
+	mutex_unlock(&mdev->mcu.mutex);
 
 	return ret;
 }
@@ -141,7 +141,7 @@ int mt76x02_mcu_cleanup(struct mt76x02_dev *dev)
 	mt76_wr(dev, MT_MCU_INT_LEVEL, 1);
 	usleep_range(20000, 30000);
 
-	while ((skb = skb_dequeue(&dev->mt76.mmio.mcu.res_q)) != NULL)
+	while ((skb = skb_dequeue(&dev->mt76.mcu.res_q)) != NULL)
 		dev_kfree_skb(skb);
 
 	return 0;
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c b/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
index 93d56d7ce5db..9e0c5e03e1f6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
@@ -542,9 +542,9 @@ static void mt76x02_check_tx_hang(struct mt76x02_dev *dev)
 restart:
 	mt76x02_watchdog_reset(dev);
 
-	mutex_lock(&dev->mt76.mmio.mcu.mutex);
+	mutex_lock(&dev->mt76.mcu.mutex);
 	dev->mcu_timeout = 0;
-	mutex_unlock(&dev->mt76.mmio.mcu.mutex);
+	mutex_unlock(&dev->mt76.mcu.mutex);
 
 	dev->tx_hang_reset++;
 	dev->tx_hang_check = 0;
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_txrx.c b/drivers/net/wireless/mediatek/mt76/mt76x02_txrx.c
index 039f96877787..96fdf423a348 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_txrx.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_txrx.c
@@ -39,7 +39,6 @@ void mt76x02_queue_rx_skb(struct mt76_dev *mdev, enum mt76_rxq_id q,
 	void *rxwi = skb->data;
 
 	if (q == MT_RXQ_MCU) {
-		/* this is used just by mmio code */
 		mt76_mcu_rx_event(&dev->mt76, skb);
 		return;
 	}
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_usb_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76x02_usb_mcu.c
index c58282baee46..843b86560ed4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_usb_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_usb_mcu.c
@@ -83,18 +83,17 @@ static int
 __mt76x02u_mcu_send_msg(struct mt76_dev *dev, struct sk_buff *skb,
 			int cmd, bool wait_resp)
 {
-	struct mt76_usb *usb = &dev->usb;
-	int ret;
 	u8 seq = 0;
 	u32 info;
+	int ret;
 
 	if (test_bit(MT76_REMOVED, &dev->phy.state))
 		return 0;
 
 	if (wait_resp) {
-		seq = ++usb->mcu.msg_seq & 0xf;
+		seq = ++dev->mcu.msg_seq & 0xf;
 		if (!seq)
-			seq = ++usb->mcu.msg_seq & 0xf;
+			seq = ++dev->mcu.msg_seq & 0xf;
 	}
 
 	info = FIELD_PREP(MT_MCU_MSG_CMD_SEQ, seq) |
@@ -121,7 +120,6 @@ static int
 mt76x02u_mcu_send_msg(struct mt76_dev *dev, int cmd, const void *data,
 		      int len, bool wait_resp)
 {
-	struct mt76_usb *usb = &dev->usb;
 	struct sk_buff *skb;
 	int err;
 
@@ -129,9 +127,9 @@ mt76x02u_mcu_send_msg(struct mt76_dev *dev, int cmd, const void *data,
 	if (!skb)
 		return -ENOMEM;
 
-	mutex_lock(&usb->mcu.mutex);
+	mutex_lock(&dev->mcu.mutex);
 	err = __mt76x02u_mcu_send_msg(dev, skb, cmd, wait_resp);
-	mutex_unlock(&usb->mcu.mutex);
+	mutex_unlock(&dev->mcu.mutex);
 
 	return err;
 }
@@ -145,9 +143,8 @@ static int
 mt76x02u_mcu_wr_rp(struct mt76_dev *dev, u32 base,
 		   const struct mt76_reg_pair *data, int n)
 {
-	const int CMD_RANDOM_WRITE = 12;
 	const int max_vals_per_cmd = MT_INBAND_PACKET_MAX_LEN / 8;
-	struct mt76_usb *usb = &dev->usb;
+	const int CMD_RANDOM_WRITE = 12;
 	struct sk_buff *skb;
 	int cnt, i, ret;
 
@@ -166,9 +163,9 @@ mt76x02u_mcu_wr_rp(struct mt76_dev *dev, u32 base,
 		skb_put_le32(skb, data[i].value);
 	}
 
-	mutex_lock(&usb->mcu.mutex);
+	mutex_lock(&dev->mcu.mutex);
 	ret = __mt76x02u_mcu_send_msg(dev, skb, CMD_RANDOM_WRITE, cnt == n);
-	mutex_unlock(&usb->mcu.mutex);
+	mutex_unlock(&dev->mcu.mutex);
 	if (ret)
 		return ret;
 
@@ -202,7 +199,7 @@ mt76x02u_mcu_rd_rp(struct mt76_dev *dev, u32 base,
 		skb_put_le32(skb, data[i].value);
 	}
 
-	mutex_lock(&usb->mcu.mutex);
+	mutex_lock(&dev->mcu.mutex);
 
 	usb->mcu.rp = data;
 	usb->mcu.rp_len = n;
@@ -213,7 +210,7 @@ mt76x02u_mcu_rd_rp(struct mt76_dev *dev, u32 base,
 
 	usb->mcu.rp = NULL;
 
-	mutex_unlock(&usb->mcu.mutex);
+	mutex_unlock(&dev->mcu.mutex);
 
 	return ret;
 }
diff --git a/drivers/net/wireless/mediatek/mt76/usb.c b/drivers/net/wireless/mediatek/mt76/usb.c
index 981d8a985557..90b55ffacf68 100644
--- a/drivers/net/wireless/mediatek/mt76/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/usb.c
@@ -1167,14 +1167,13 @@ int mt76u_init(struct mt76_dev *dev,
 	usb->data_len = usb_maxpacket(udev, usb_sndctrlpipe(udev, 0), 1);
 	if (usb->data_len < 32)
 		usb->data_len = 32;
+
 	usb->data = devm_kmalloc(dev->dev, usb->data_len, GFP_KERNEL);
 	if (!usb->data) {
 		mt76u_deinit(dev);
 		return -ENOMEM;
 	}
 
-	mutex_init(&usb->mcu.mutex);
-
 	mutex_init(&usb->usb_ctrl_mtx);
 	dev->bus = &mt76u_ops;
 	dev->queue_ops = &usb_queue_ops;
-- 
2.24.1

