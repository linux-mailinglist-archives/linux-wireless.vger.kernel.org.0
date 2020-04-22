Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA27F1B3A7E
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Apr 2020 10:47:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbgDVIrs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 22 Apr 2020 04:47:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:52942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725786AbgDVIrr (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 22 Apr 2020 04:47:47 -0400
Received: from lore-desk-wlan.redhat.com (unknown [151.66.196.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4270920656;
        Wed, 22 Apr 2020 08:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587545267;
        bh=H+iCK6yRR6BYhkAGIf3uVrgrioSvnJIwKWkSrcWcVQg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=elpSWPNNMUARCovPL3c+iLT8kAeZq339Hi5i9ejLVyPA0bjuqxde5NLosPSnj5h6c
         UwlLi88Ipz9olNuqHv6w3S88OUziRshFao5B6c1mcLXAL/d+/Nt1Ggc5Q3q7UuSoL6
         BGEVHK821uftiu94x1PpWAMrth6qxPl1oTB9MMzs=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, linux-mediatek@lists.infradead.org
Subject: [PATCH 2/2] mt76: mt7663u: enable AirTimeFairness
Date:   Wed, 22 Apr 2020 10:47:24 +0200
Message-Id: <dd383b994e5f5ca64f924e12a4e250da40784853.1587545092.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.25.3
In-Reply-To: <cover.1587545092.git.lorenzo@kernel.org>
References: <cover.1587545092.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Initialize tx_status_data pointer in order to enable Air Time Fairness
for mt7663u chipset

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7615/usb.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/usb.c b/drivers/net/wireless/mediatek/mt76/mt7615/usb.c
index ad5219006987..eee6f820959f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/usb.c
@@ -249,6 +249,17 @@ mt7663u_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 	return mt76u_skb_dma_info(tx_info->skb, tx_info->skb->len);
 }
 
+static bool mt7663u_tx_status_data(struct mt76_dev *mdev, u8 *update)
+{
+	struct mt7615_dev *dev = container_of(mdev, struct mt7615_dev, mt76);
+
+	mutex_lock(&dev->mt76.mutex);
+	mt7615_mac_sta_poll(dev);
+	mutex_unlock(&dev->mt76.mutex);
+
+	return 0;
+}
+
 static int mt7663u_probe(struct usb_interface *usb_intf,
 			 const struct usb_device_id *id)
 {
@@ -257,6 +268,7 @@ static int mt7663u_probe(struct usb_interface *usb_intf,
 		.drv_flags = MT_DRV_RX_DMA_HDR,
 		.tx_prepare_skb = mt7663u_tx_prepare_skb,
 		.tx_complete_skb = mt7663u_tx_complete_skb,
+		.tx_status_data = mt7663u_tx_status_data,
 		.rx_skb = mt7615_queue_rx_skb,
 		.sta_ps = mt7615_sta_ps,
 		.sta_add = mt7615_mac_sta_add,
-- 
2.25.3

