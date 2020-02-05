Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25065153C20
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Feb 2020 00:53:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727521AbgBEXx2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 5 Feb 2020 18:53:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:46190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727170AbgBEXx1 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 5 Feb 2020 18:53:27 -0500
Received: from localhost.lan (unknown [151.48.147.3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C5EE3218AC;
        Wed,  5 Feb 2020 23:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580946807;
        bh=0bFc170M6P3iYZ3kVOBvCwrZ6odkxMnEEvlXobrVet0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Hp9NuADSmKv2xFtEzshrjTJyGtialCQF5YRiMFlaHOZqGHVE6Wdf5gRKr+EoUea9Z
         MEF0ugZpvWTuWtfyWB319SArmfctdI7qobJWYBAFk5dyAspoBagaxJNNvy/CuaZuZb
         xUvGoyzdRXGKDOftOkljcYQjkMx3QFnuZUWLBm9w=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org
Subject: [PATCH 2/3] mt76: generalize mt76_mcu_rx_event routine
Date:   Thu,  6 Feb 2020 00:53:09 +0100
Message-Id: <0b2e476900157cd99417328e661e71a6ffedcb6a.1580945999.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <cover.1580945999.git.lorenzo@kernel.org>
References: <cover.1580945999.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Rely on mt76_mcu in mt76_mcu_rx_event signature in order to reuse
it in usb code

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mcu.c          | 8 +++++---
 drivers/net/wireless/mediatek/mt76/mt76.h         | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7603/dma.c   | 4 ++--
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.c   | 2 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_txrx.c | 3 +--
 5 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mcu.c b/drivers/net/wireless/mediatek/mt76/mcu.c
index b0fb0830c9e1..a2936f8de915 100644
--- a/drivers/net/wireless/mediatek/mt76/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mcu.c
@@ -42,9 +42,11 @@ struct sk_buff *mt76_mcu_get_response(struct mt76_dev *dev,
 }
 EXPORT_SYMBOL_GPL(mt76_mcu_get_response);
 
-void mt76_mcu_rx_event(struct mt76_dev *dev, struct sk_buff *skb)
+void mt76_mcu_rx_event(void *data, struct sk_buff *skb)
 {
-	skb_queue_tail(&dev->mmio.mcu.res_q, skb);
-	wake_up(&dev->mmio.mcu.wait);
+	struct mt76_mcu *mcu = (struct mt76_mcu *)data;
+
+	skb_queue_tail(&mcu->res_q, skb);
+	wake_up(&mcu->wait);
 }
 EXPORT_SYMBOL_GPL(mt76_mcu_rx_event);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index c09f929c2d31..48d6101dc4ee 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -903,7 +903,7 @@ void mt76u_queues_deinit(struct mt76_dev *dev);
 struct sk_buff *
 mt76_mcu_msg_alloc(const void *data, int head_len,
 		   int data_len, int tail_len);
-void mt76_mcu_rx_event(struct mt76_dev *dev, struct sk_buff *skb);
+void mt76_mcu_rx_event(void *data, struct sk_buff *skb);
 struct sk_buff *mt76_mcu_get_response(struct mt76_dev *dev,
 				      unsigned long expires);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/dma.c b/drivers/net/wireless/mediatek/mt76/mt7603/dma.c
index a08b85281170..a5e23b349999 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/dma.c
@@ -103,7 +103,7 @@ void mt7603_queue_rx_skb(struct mt76_dev *mdev, enum mt76_rxq_id q,
 
 	if (q == MT_RXQ_MCU) {
 		if (type == PKT_TYPE_RX_EVENT)
-			mt76_mcu_rx_event(&dev->mt76, skb);
+			mt76_mcu_rx_event(&dev->mt76.mcu, skb);
 		else
 			mt7603_rx_loopback_skb(dev, skb);
 		return;
@@ -116,7 +116,7 @@ void mt7603_queue_rx_skb(struct mt76_dev *mdev, enum mt76_rxq_id q,
 		dev_kfree_skb(skb);
 		break;
 	case PKT_TYPE_RX_EVENT:
-		mt76_mcu_rx_event(&dev->mt76, skb);
+		mt76_mcu_rx_event(&dev->mt76.mcu, skb);
 		return;
 	case PKT_TYPE_NORMAL:
 		if (mt7603_mac_fill_rx(dev, skb) == 0) {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index c93a22110cf9..60cfa7366ea7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -301,7 +301,7 @@ void mt7615_mcu_rx_event(struct mt7615_dev *dev, struct sk_buff *skb)
 	    !rxd->seq)
 		mt7615_mcu_rx_unsolicited_event(dev, skb);
 	else
-		mt76_mcu_rx_event(&dev->mt76, skb);
+		mt76_mcu_rx_event(&dev->mt76.mcu, skb);
 }
 
 static int mt7615_mcu_init_download(struct mt7615_dev *dev, u32 addr,
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_txrx.c b/drivers/net/wireless/mediatek/mt76/mt76x02_txrx.c
index 039f96877787..d1aec50bccae 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_txrx.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_txrx.c
@@ -39,8 +39,7 @@ void mt76x02_queue_rx_skb(struct mt76_dev *mdev, enum mt76_rxq_id q,
 	void *rxwi = skb->data;
 
 	if (q == MT_RXQ_MCU) {
-		/* this is used just by mmio code */
-		mt76_mcu_rx_event(&dev->mt76, skb);
+		mt76_mcu_rx_event(&mdev->mcu, skb);
 		return;
 	}
 
-- 
2.21.1

