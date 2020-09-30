Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63B1027E87D
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Sep 2020 14:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729762AbgI3MYr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 30 Sep 2020 08:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729516AbgI3MYp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 30 Sep 2020 08:24:45 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CDE3C0613D3
        for <linux-wireless@vger.kernel.org>; Wed, 30 Sep 2020 05:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=wEe36iBMMSUwWWmFM87gMGBEPvt2z5Mr3oI+ov7pykI=; b=oe+okQhjkzXtO5g5iCjp/EsAer
        G5FRQDPFKU4VnUto1TMMeeNyNZU7JIKqd7dNiOjL7azO6hrWKsFMRmOZmUWwXGQ6i2FMxh/2wZ8vK
        IrBIyljFjv/GIxzhDsA4DK4JkE8FTt/Vd3wcgx6Aov2CHZv1Xz+FnDKNu6WTztaT+RDc=;
Received: from p4ff134da.dip0.t-ipconnect.de ([79.241.52.218] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1kNbA3-0005MT-PU
        for linux-wireless@vger.kernel.org; Wed, 30 Sep 2020 14:24:43 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 05/10] mt76: move waiting and locking out of mcu_ops->mcu_skb_send_msg
Date:   Wed, 30 Sep 2020 14:24:36 +0200
Message-Id: <20200930122441.64523-5-nbd@nbd.name>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200930122441.64523-1-nbd@nbd.name>
References: <20200930122441.64523-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This removes some code duplication and prepares the code for making
the MCU API more flexible

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mcu.c      |  32 ++++
 drivers/net/wireless/mediatek/mt76/mt76.h     |   6 +-
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   |  57 ++-----
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |   1 -
 .../wireless/mediatek/mt76/mt7615/sdio_mcu.c  |  15 +-
 .../wireless/mediatek/mt76/mt7615/usb_mcu.c   |  14 +-
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 159 +++++++-----------
 7 files changed, 116 insertions(+), 168 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mcu.c b/drivers/net/wireless/mediatek/mt76/mcu.c
index ade61a5334c6..118272cabe16 100644
--- a/drivers/net/wireless/mediatek/mt76/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mcu.c
@@ -50,3 +50,35 @@ void mt76_mcu_rx_event(struct mt76_dev *dev, struct sk_buff *skb)
 	wake_up(&dev->mcu.wait);
 }
 EXPORT_SYMBOL_GPL(mt76_mcu_rx_event);
+
+int mt76_mcu_skb_send_msg(struct mt76_dev *dev, struct sk_buff *skb,
+			  int cmd, bool wait_resp)
+{
+	unsigned long expires;
+	int ret, seq;
+
+	mutex_lock(&dev->mcu.mutex);
+
+	ret = dev->mcu_ops->mcu_skb_send_msg(dev, skb, cmd, &seq);
+	if (ret < 0)
+		goto out;
+
+	if (!wait_resp) {
+		ret = 0;
+		goto out;
+	}
+
+	expires = jiffies + dev->mcu.timeout;
+
+	do {
+		skb = mt76_mcu_get_response(dev, expires);
+		ret = dev->mcu_ops->mcu_parse_response(dev, cmd, skb, seq);
+		dev_kfree_skb(skb);
+	} while (ret == -EAGAIN);
+
+out:
+	mutex_unlock(&dev->mcu.mutex);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(mt76_mcu_skb_send_msg);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 2856cb1d1cf6..82e333622c81 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -147,7 +147,7 @@ struct mt76_mcu_ops {
 	int (*mcu_send_msg)(struct mt76_dev *dev, int cmd, const void *data,
 			    int len, bool wait_resp);
 	int (*mcu_skb_send_msg)(struct mt76_dev *dev, struct sk_buff *skb,
-				int cmd, bool wait_resp);
+				int cmd, int *seq);
 	int (*mcu_parse_response)(struct mt76_dev *dev, int cmd,
 				  struct sk_buff *skb, int seq);
 	u32 (*mcu_rr)(struct mt76_dev *dev, u32 offset);
@@ -414,6 +414,7 @@ enum mt76u_out_ep {
 struct mt76_mcu {
 	struct mutex mutex;
 	u32 msg_seq;
+	int timeout;
 
 	struct sk_buff_head res_q;
 	wait_queue_head_t wait;
@@ -689,7 +690,6 @@ enum mt76_phy_type {
 
 
 #define mt76_mcu_send_msg(dev, ...)	(dev)->mcu_ops->mcu_send_msg((dev), __VA_ARGS__)
-#define mt76_mcu_skb_send_msg(dev, ...)	(dev)->mcu_ops->mcu_skb_send_msg((dev), __VA_ARGS__)
 #define mt76_mcu_restart(dev, ...)	(dev)->mt76.mcu_ops->mcu_restart(&((dev)->mt76))
 #define __mt76_mcu_restart(dev, ...)	(dev)->mcu_ops->mcu_restart((dev))
 
@@ -1068,6 +1068,8 @@ mt76_mcu_msg_alloc(struct mt76_dev *dev, const void *data,
 void mt76_mcu_rx_event(struct mt76_dev *dev, struct sk_buff *skb);
 struct sk_buff *mt76_mcu_get_response(struct mt76_dev *dev,
 				      unsigned long expires);
+int mt76_mcu_skb_send_msg(struct mt76_dev *dev, struct sk_buff *skb,
+			  int cmd, bool wait_resp);
 
 void mt76_set_irq_mask(struct mt76_dev *dev, u32 addr, u32 clear, u32 set);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index fb0dce401b9a..0008d82d07f6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -94,6 +94,9 @@ void mt7615_mcu_fill_msg(struct mt7615_dev *dev, struct sk_buff *skb,
 	__le32 *txd;
 	u32 val;
 
+	/* TODO: make dynamic based on msg type */
+	dev->mt76.mcu.timeout = 20 * HZ;
+
 	seq = ++dev->mt76.mcu.msg_seq & 0xf;
 	if (!seq)
 		seq = ++dev->mt76.mcu.msg_seq & 0xf;
@@ -165,20 +168,6 @@ void mt7615_mcu_fill_msg(struct mt7615_dev *dev, struct sk_buff *skb,
 }
 EXPORT_SYMBOL_GPL(mt7615_mcu_fill_msg);
 
-static int __mt7615_mcu_msg_send(struct mt7615_dev *dev, struct sk_buff *skb,
-				 int cmd, int *wait_seq)
-{
-	enum mt76_txq_id qid;
-
-	mt7615_mcu_fill_msg(dev, skb, cmd, wait_seq);
-	if (test_bit(MT76_STATE_MCU_RUNNING, &dev->mphy.state))
-		qid = MT_TXQ_MCU;
-	else
-		qid = MT_TXQ_FWDL;
-
-	return mt76_tx_queue_skb_raw(dev, qid, skb, 0);
-}
-
 int mt7615_mcu_parse_response(struct mt76_dev *mdev, int cmd,
 			      struct sk_buff *skb, int seq)
 {
@@ -237,44 +226,20 @@ int mt7615_mcu_parse_response(struct mt76_dev *mdev, int cmd,
 }
 EXPORT_SYMBOL_GPL(mt7615_mcu_parse_response);
 
-int mt7615_mcu_wait_response(struct mt7615_dev *dev, int cmd, int seq)
-{
-	unsigned long expires = jiffies + 20 * HZ;
-	struct sk_buff *skb;
-	int ret = 0;
-
-	while (true) {
-		skb = mt76_mcu_get_response(&dev->mt76, expires);
-		ret = mt7615_mcu_parse_response(&dev->mt76, cmd, skb, seq);
-		dev_kfree_skb(skb);
-		if (ret != -EAGAIN)
-			break;
-	}
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(mt7615_mcu_wait_response);
-
 static int
 mt7615_mcu_send_message(struct mt76_dev *mdev, struct sk_buff *skb,
-			int cmd, bool wait_resp)
+			int cmd, int *seq)
 {
 	struct mt7615_dev *dev = container_of(mdev, struct mt7615_dev, mt76);
-	int ret, seq;
-
-	mutex_lock(&mdev->mcu.mutex);
-
-	ret = __mt7615_mcu_msg_send(dev, skb, cmd, &seq);
-	if (ret)
-		goto out;
-
-	if (wait_resp)
-		ret = mt7615_mcu_wait_response(dev, cmd, seq);
+	enum mt76_txq_id qid;
 
-out:
-	mutex_unlock(&mdev->mcu.mutex);
+	mt7615_mcu_fill_msg(dev, skb, cmd, seq);
+	if (test_bit(MT76_STATE_MCU_RUNNING, &dev->mphy.state))
+		qid = MT_TXQ_MCU;
+	else
+		qid = MT_TXQ_FWDL;
 
-	return ret;
+	return mt76_tx_queue_skb_raw(dev, qid, skb, 0);
 }
 
 int mt7615_mcu_msg_send(struct mt76_dev *mdev, int cmd, const void *data,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index 66356ed42f73..e0102627c848 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -589,7 +589,6 @@ int mt7615_mac_wtbl_update_key(struct mt7615_dev *dev,
 void mt7615_mac_reset_work(struct work_struct *work);
 u32 mt7615_mac_get_sta_tid_sn(struct mt7615_dev *dev, int wcid, u8 tid);
 
-int mt7615_mcu_wait_response(struct mt7615_dev *dev, int cmd, int seq);
 int mt7615_mcu_msg_send(struct mt76_dev *mdev, int cmd, const void *data,
 			int len, bool wait_resp);
 int mt7615_mcu_parse_response(struct mt76_dev *mdev, int cmd,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/sdio_mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/sdio_mcu.c
index 263f3a65878f..e48169395077 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/sdio_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/sdio_mcu.c
@@ -41,24 +41,17 @@ static int mt7663s_mcu_init_sched(struct mt7615_dev *dev)
 
 static int
 mt7663s_mcu_send_message(struct mt76_dev *mdev, struct sk_buff *skb,
-			 int cmd, bool wait_resp)
+			 int cmd, int *seq)
 {
 	struct mt7615_dev *dev = container_of(mdev, struct mt7615_dev, mt76);
-	int ret, seq;
-
-	mutex_lock(&mdev->mcu.mutex);
+	int ret;
 
-	mt7615_mcu_fill_msg(dev, skb, cmd, &seq);
+	mt7615_mcu_fill_msg(dev, skb, cmd, seq);
 	ret = mt76_tx_queue_skb_raw(dev, MT_TXQ_MCU, skb, 0);
 	if (ret)
-		goto out;
+		return ret;
 
 	mt76_queue_kick(dev, mdev->q_tx[MT_TXQ_MCU]);
-	if (wait_resp)
-		ret = mt7615_mcu_wait_response(dev, cmd, seq);
-
-out:
-	mutex_unlock(&mdev->mcu.mutex);
 
 	return ret;
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/usb_mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/usb_mcu.c
index 4bac8fda4714..6356d3d00c3b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/usb_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/usb_mcu.c
@@ -15,14 +15,12 @@
 
 static int
 mt7663u_mcu_send_message(struct mt76_dev *mdev, struct sk_buff *skb,
-			 int cmd, bool wait_resp)
+			 int cmd, int *seq)
 {
 	struct mt7615_dev *dev = container_of(mdev, struct mt7615_dev, mt76);
-	int ret, seq, ep, len, pad;
+	int ret, ep, len, pad;
 
-	mutex_lock(&mdev->mcu.mutex);
-
-	mt7615_mcu_fill_msg(dev, skb, cmd, &seq);
+	mt7615_mcu_fill_msg(dev, skb, cmd, seq);
 	if (cmd != MCU_CMD_FW_SCATTER)
 		ep = MT_EP_OUT_INBAND_CMD;
 	else
@@ -37,14 +35,8 @@ mt7663u_mcu_send_message(struct mt76_dev *mdev, struct sk_buff *skb,
 
 	ret = mt76u_bulk_msg(&dev->mt76, skb->data, skb->len, NULL,
 			     1000, ep);
-	if (ret < 0)
-		goto out;
-
-	if (wait_resp)
-		ret = mt7615_mcu_wait_response(dev, cmd, seq);
 
 out:
-	mutex_unlock(&mdev->mcu.mutex);
 	dev_kfree_skb(skb);
 
 	return ret;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index e89fb44f8d75..d278743d948e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -215,15 +215,75 @@ mt7915_mcu_get_sta_nss(u16 mcs_map)
 	return nss - 1;
 }
 
-static int __mt7915_mcu_msg_send(struct mt7915_dev *dev, struct sk_buff *skb,
-				 int cmd, int *wait_seq)
+static int
+mt7915_mcu_parse_eeprom(struct mt7915_dev *dev, struct sk_buff *skb)
+{
+	struct mt7915_mcu_eeprom_info *res;
+	u8 *buf;
+
+	if (!skb)
+		return -EINVAL;
+
+	skb_pull(skb, sizeof(struct mt7915_mcu_rxd));
+
+	res = (struct mt7915_mcu_eeprom_info *)skb->data;
+	buf = dev->mt76.eeprom.data + le32_to_cpu(res->addr);
+	memcpy(buf, res->data, 16);
+
+	return 0;
+}
+
+static int
+mt7915_mcu_parse_response(struct mt76_dev *mdev, int cmd,
+			  struct sk_buff *skb, int seq)
 {
+	struct mt7915_dev *dev = container_of(mdev, struct mt7915_dev, mt76);
+	struct mt7915_mcu_rxd *rxd;
+	int ret = 0;
+
+	if (!skb) {
+		dev_err(mdev->dev, "Message %d (seq %d) timeout\n",
+			cmd, seq);
+		return -ETIMEDOUT;
+	}
+
+	rxd = (struct mt7915_mcu_rxd *)skb->data;
+	if (seq != rxd->seq)
+		return -EAGAIN;
+
+	switch (cmd) {
+	case -MCU_CMD_PATCH_SEM_CONTROL:
+		skb_pull(skb, sizeof(*rxd) - 4);
+		ret = *skb->data;
+		break;
+	case MCU_EXT_CMD_THERMAL_CTRL:
+		skb_pull(skb, sizeof(*rxd) + 4);
+		ret = le32_to_cpu(*(__le32 *)skb->data);
+		break;
+	case MCU_EXT_CMD_EFUSE_ACCESS:
+		ret = mt7915_mcu_parse_eeprom(dev, skb);
+		break;
+	default:
+		break;
+	}
+
+	return ret;
+}
+
+static int
+mt7915_mcu_send_message(struct mt76_dev *mdev, struct sk_buff *skb,
+			int cmd, int *wait_seq)
+{
+	struct mt7915_dev *dev = container_of(mdev, struct mt7915_dev, mt76);
 	struct mt7915_mcu_txd *mcu_txd;
 	u8 seq, pkt_fmt, qidx;
 	enum mt76_txq_id txq;
 	__le32 *txd;
 	u32 val;
 
+	/* TODO: make dynamic based on msg type */
+	mdev->mcu.timeout = 20 * HZ;
+
 	seq = ++dev->mt76.mcu.msg_seq & 0xf;
 	if (!seq)
 		seq = ++dev->mt76.mcu.msg_seq & 0xf;
@@ -290,101 +350,6 @@ static int __mt7915_mcu_msg_send(struct mt7915_dev *dev, struct sk_buff *skb,
 	return mt76_tx_queue_skb_raw(dev, txq, skb, 0);
 }
 
-static int
-mt7915_mcu_parse_eeprom(struct mt7915_dev *dev, struct sk_buff *skb)
-{
-	struct mt7915_mcu_eeprom_info *res;
-	u8 *buf;
-
-	if (!skb)
-		return -EINVAL;
-
-	skb_pull(skb, sizeof(struct mt7915_mcu_rxd));
-
-	res = (struct mt7915_mcu_eeprom_info *)skb->data;
-	buf = dev->mt76.eeprom.data + le32_to_cpu(res->addr);
-	memcpy(buf, res->data, 16);
-
-	return 0;
-}
-
-static int
-mt7915_mcu_parse_response(struct mt76_dev *mdev, int cmd,
-			  struct sk_buff *skb, int seq)
-{
-	struct mt7915_dev *dev = container_of(mdev, struct mt7915_dev, mt76);
-	struct mt7915_mcu_rxd *rxd;
-	int ret = 0;
-
-	if (!skb) {
-		dev_err(mdev->dev, "Message %d (seq %d) timeout\n",
-			cmd, seq);
-		return -ETIMEDOUT;
-	}
-
-	rxd = (struct mt7915_mcu_rxd *)skb->data;
-	if (seq != rxd->seq)
-		return -EAGAIN;
-
-	switch (cmd) {
-	case -MCU_CMD_PATCH_SEM_CONTROL:
-		skb_pull(skb, sizeof(*rxd) - 4);
-		ret = *skb->data;
-		break;
-	case MCU_EXT_CMD_THERMAL_CTRL:
-		skb_pull(skb, sizeof(*rxd) + 4);
-		ret = le32_to_cpu(*(__le32 *)skb->data);
-		break;
-	case MCU_EXT_CMD_EFUSE_ACCESS:
-		ret = mt7915_mcu_parse_eeprom(dev, skb);
-		break;
-	default:
-		break;
-	}
-
-	return ret;
-}
-
-static int
-mt7915_mcu_wait_response(struct mt7915_dev *dev, int cmd, int seq)
-{
-	unsigned long expires = jiffies + 20 * HZ;
-	struct sk_buff *skb;
-	int ret = 0;
-
-	while (true) {
-		skb = mt76_mcu_get_response(&dev->mt76, expires);
-		ret = mt7915_mcu_parse_response(&dev->mt76, cmd, skb, seq);
-		dev_kfree_skb(skb);
-		if (ret != -EAGAIN)
-			break;
-	}
-
-	return ret;
-}
-
-static int
-mt7915_mcu_send_message(struct mt76_dev *mdev, struct sk_buff *skb,
-			int cmd, bool wait_resp)
-{
-	struct mt7915_dev *dev = container_of(mdev, struct mt7915_dev, mt76);
-	int ret, seq;
-
-	mutex_lock(&mdev->mcu.mutex);
-
-	ret = __mt7915_mcu_msg_send(dev, skb, cmd, &seq);
-	if (ret)
-		goto out;
-
-	if (wait_resp)
-		ret = mt7915_mcu_wait_response(dev, cmd, seq);
-
-out:
-	mutex_unlock(&mdev->mcu.mutex);
-
-	return ret;
-}
-
 static int
 mt7915_mcu_msg_send(struct mt76_dev *mdev, int cmd, const void *data,
 		    int len, bool wait_resp)
-- 
2.28.0

