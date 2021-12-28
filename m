Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D2F5480A02
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Dec 2021 15:34:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbhL1OeJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 Dec 2021 09:34:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbhL1OeJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 Dec 2021 09:34:09 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ACB3C061574
        for <linux-wireless@vger.kernel.org>; Tue, 28 Dec 2021 06:34:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A7C6161206
        for <linux-wireless@vger.kernel.org>; Tue, 28 Dec 2021 14:34:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2855DC36AE8;
        Tue, 28 Dec 2021 14:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640702048;
        bh=tctkp2xPAbz3U+bEQ5CFcCWbV/37SD3FtCOANXB3s5Y=;
        h=From:To:Cc:Subject:Date:From;
        b=CSA4WWID48W9GT0u/MjYPkIDUeKdB4/JOjAQbkkfmUS2YYuZ676d7WqGt+oBHp0n8
         40h6eD+uJYNpkQKx6fS0rnY2uNi/dL7rc4M/stUcsTpzaI8FJ1MBrayzNDA0Ux1GHI
         n6AVEXI2eDpCOBhBffq2ipALAv8JFuSj/IMGPIu2ZPwETna9rwfUxH+meiiOl631j4
         N3FYNMCKkg+Spr1SgpPAQMVQOK0UxcRJwU0Wx2eONORalQadqABG4JAriWDMVSz8yg
         MxptwhLTqz1gVfCe5BgJkfNarzJl0dGQ+dH4FVrM5JM/RSIMyPkXg1EktPxLk1FS4s
         SK9nDlW+MfkCA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org
Subject: [RFT] mt76: mt7615e: process txfree and txstatus without allocating skbs
Date:   Tue, 28 Dec 2021 15:33:57 +0100
Message-Id: <ef5df272b8b2068fc5f84039b381fbf32befe297.1640701977.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Similar to mt7915 driver, process txfree and txstatus without allocating
skbs in order to reduce pressure on the memory allocator

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7615/mac.c   | 38 ++++++++++++++++---
 .../net/wireless/mediatek/mt76/mt7615/mmio.c  |  1 +
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |  1 +
 3 files changed, 35 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index 8f8a7bc0169b..2d81cbf2600c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -1642,9 +1642,10 @@ mt7615_mac_tx_free_token(struct mt7615_dev *dev, u16 token)
 	mt7615_txwi_free(dev, txwi);
 }
 
-static void mt7615_mac_tx_free(struct mt7615_dev *dev, struct sk_buff *skb)
+static void mt7615_mac_tx_free(struct mt7615_dev *dev, void *data, int len)
 {
-	struct mt7615_tx_free *free = (struct mt7615_tx_free *)skb->data;
+	struct mt7615_tx_free *free = (struct mt7615_tx_free *)data;
+	void *end = data + len;
 	u8 i, count;
 
 	mt76_queue_tx_cleanup(dev, dev->mphy.q_tx[MT_TXQ_PSD], false);
@@ -1659,17 +1660,21 @@ static void mt7615_mac_tx_free(struct mt7615_dev *dev, struct sk_buff *skb)
 	if (is_mt7615(&dev->mt76)) {
 		__le16 *token = &free->token[0];
 
+		if (WARN_ON_ONCE((void *)&token[count] > end))
+			return;
+
 		for (i = 0; i < count; i++)
 			mt7615_mac_tx_free_token(dev, le16_to_cpu(token[i]));
 	} else {
 		__le32 *token = (__le32 *)&free->token[0];
 
+		if (WARN_ON_ONCE((void *)&token[count] > end))
+			return;
+
 		for (i = 0; i < count; i++)
 			mt7615_mac_tx_free_token(dev, le32_to_cpu(token[i]));
 	}
 
-	dev_kfree_skb(skb);
-
 	rcu_read_lock();
 	mt7615_mac_sta_poll(dev);
 	rcu_read_unlock();
@@ -1677,6 +1682,28 @@ static void mt7615_mac_tx_free(struct mt7615_dev *dev, struct sk_buff *skb)
 	mt76_worker_schedule(&dev->mt76.tx_worker);
 }
 
+bool mt7615_rx_check(struct mt76_dev *mdev, void *data, int len)
+{
+	struct mt7615_dev *dev = container_of(mdev, struct mt7615_dev, mt76);
+	__le32 *rxd = (__le32 *)data;
+	__le32 *end = (__le32 *)&rxd[len / 4];
+	enum rx_pkt_type type;
+
+	type = FIELD_GET(MT_RXD0_PKT_TYPE, le32_to_cpu(rxd[0]));
+	switch (type) {
+	case PKT_TYPE_TXRX_NOTIFY:
+		mt7615_mac_tx_free(dev, data, len);
+		return false;
+	case PKT_TYPE_TXS:
+		for (rxd++; rxd + 7 <= end; rxd += 7)
+			mt7615_mac_add_txs(dev, rxd);
+		return false;
+	default:
+		return true;
+	}
+}
+EXPORT_SYMBOL_GPL(mt7615_rx_check);
+
 void mt7615_queue_rx_skb(struct mt76_dev *mdev, enum mt76_rxq_id q,
 			 struct sk_buff *skb)
 {
@@ -1698,7 +1725,8 @@ void mt7615_queue_rx_skb(struct mt76_dev *mdev, enum mt76_rxq_id q,
 		dev_kfree_skb(skb);
 		break;
 	case PKT_TYPE_TXRX_NOTIFY:
-		mt7615_mac_tx_free(dev, skb);
+		mt7615_mac_tx_free(dev, skb->data, skb->len);
+		dev_kfree_skb(skb);
 		break;
 	case PKT_TYPE_RX_EVENT:
 		mt7615_mcu_rx_event(dev, skb);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mmio.c b/drivers/net/wireless/mediatek/mt76/mt7615/mmio.c
index 33f72f3657d0..ce45c3bfc443 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mmio.c
@@ -194,6 +194,7 @@ int mt7615_mmio_probe(struct device *pdev, void __iomem *mem_base,
 		.token_size = MT7615_TOKEN_SIZE,
 		.tx_prepare_skb = mt7615_tx_prepare_skb,
 		.tx_complete_skb = mt7615_tx_complete_skb,
+		.rx_check = mt7615_rx_check,
 		.rx_skb = mt7615_queue_rx_skb,
 		.rx_poll_complete = mt7615_rx_poll_complete,
 		.sta_ps = mt7615_sta_ps,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index 3b66aa749a21..600fa2be4da0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -509,6 +509,7 @@ int mt7615_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 void mt7615_tx_worker(struct mt76_worker *w);
 void mt7615_tx_complete_skb(struct mt76_dev *mdev, struct mt76_queue_entry *e);
 void mt7615_tx_token_put(struct mt7615_dev *dev);
+bool mt7615_rx_check(struct mt76_dev *mdev, void *data, int len);
 void mt7615_queue_rx_skb(struct mt76_dev *mdev, enum mt76_rxq_id q,
 			 struct sk_buff *skb);
 void mt7615_sta_ps(struct mt76_dev *mdev, struct ieee80211_sta *sta, bool ps);
-- 
2.33.1

