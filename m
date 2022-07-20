Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7548D57BC23
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Jul 2022 18:56:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236036AbiGTQ4z (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 Jul 2022 12:56:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236137AbiGTQ4x (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 Jul 2022 12:56:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C0506717C
        for <linux-wireless@vger.kernel.org>; Wed, 20 Jul 2022 09:56:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 27D8461DD4
        for <linux-wireless@vger.kernel.org>; Wed, 20 Jul 2022 16:56:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32FE5C341CA;
        Wed, 20 Jul 2022 16:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658336211;
        bh=we89arXV3oUBu00b8/7gRcvUv23ZKOiNSUByhXyMw+w=;
        h=From:To:Cc:Subject:Date:From;
        b=jbd2dHlW1mstWIShdjfwjkV/EvZnHQwbtwH4Blxv3/1fKIvemoMVF8LdQYaWzyF+4
         5gwGPVwMSSUUeNR7XKAyMd8pNsPJL8tmhqAlv2gtO/8f63k6Il7OHsRjyuGlBlhpaU
         yX7G1iBOVpAPcDvSit3YxROeJzSzYudEWkOKkjvhu92avtbbqI6Qq104AJYZtO17He
         f87ZL8rDnH+kR9XWpwEQ4RlwJ/RNUkVWAAoBsmEVHa3JXzNGywV+pNgdaDFZs+YSZ6
         pwTvBamlLcIl1EM+eJx/e0wnx28fHcU8Wv4nfA66WYV78Hm8AR2qnMQ7DdWIDDb6NU
         YKuV5YY1yA01Q==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org
Subject: [PATCH] mt76: add rx_check callback for usb devices
Date:   Wed, 20 Jul 2022 18:56:37 +0200
Message-Id: <1ce2555483783c2f62bb8fecc575ceca1aad8583.1658335993.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce rx_check callback support for mt7663u and mt7921u drivers.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7615/usb.c   |  1 +
 .../net/wireless/mediatek/mt76/mt7921/mac.c   | 20 +++++++++++++++++++
 .../wireless/mediatek/mt76/mt7921/mt7921.h    |  1 +
 .../net/wireless/mediatek/mt76/mt7921/usb.c   |  1 +
 drivers/net/wireless/mediatek/mt76/usb.c      |  5 +++++
 5 files changed, 28 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/usb.c b/drivers/net/wireless/mediatek/mt76/mt7615/usb.c
index 967641aebf5f..f2d651d7adff 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/usb.c
@@ -119,6 +119,7 @@ static int mt7663u_probe(struct usb_interface *usb_intf,
 		.tx_complete_skb = mt7663_usb_sdio_tx_complete_skb,
 		.tx_status_data = mt7663_usb_sdio_tx_status_data,
 		.rx_skb = mt7615_queue_rx_skb,
+		.rx_check = mt7615_rx_check,
 		.sta_ps = mt7615_sta_ps,
 		.sta_add = mt7615_mac_sta_add,
 		.sta_remove = mt7615_mac_sta_remove,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index 47f0aa81ab02..b00fb463b4f1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -554,6 +554,26 @@ void mt7921_mac_add_txs(struct mt7921_dev *dev, void *data)
 }
 EXPORT_SYMBOL_GPL(mt7921_mac_add_txs);
 
+bool mt7921_rx_check(struct mt76_dev *mdev, void *data, int len)
+{
+	struct mt7921_dev *dev = container_of(mdev, struct mt7921_dev, mt76);
+	__le32 *rxd = (__le32 *)data;
+	__le32 *end = (__le32 *)&rxd[len / 4];
+	enum rx_pkt_type type;
+
+	type = le32_get_bits(rxd[0], MT_RXD0_PKT_TYPE);
+
+	switch (type) {
+	case PKT_TYPE_TXS:
+		for (rxd += 2; rxd + 8 <= end; rxd += 8)
+			mt7921_mac_add_txs(dev, rxd);
+		return false;
+	default:
+		return true;
+	}
+}
+EXPORT_SYMBOL_GPL(mt7921_rx_check);
+
 void mt7921_queue_rx_skb(struct mt76_dev *mdev, enum mt76_rxq_id q,
 			 struct sk_buff *skb)
 {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index c161031ac62a..12c145a30c60 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -380,6 +380,7 @@ int mt7921e_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 
 void mt7921_tx_worker(struct mt76_worker *w);
 void mt7921_tx_token_put(struct mt7921_dev *dev);
+bool mt7921_rx_check(struct mt76_dev *mdev, void *data, int len);
 void mt7921_queue_rx_skb(struct mt76_dev *mdev, enum mt76_rxq_id q,
 			 struct sk_buff *skb);
 void mt7921_sta_ps(struct mt76_dev *mdev, struct ieee80211_sta *sta, bool ps);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/usb.c b/drivers/net/wireless/mediatek/mt76/mt7921/usb.c
index dd3b8884e162..29fc7698f75d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/usb.c
@@ -183,6 +183,7 @@ static int mt7921u_probe(struct usb_interface *usb_intf,
 		.tx_complete_skb = mt7921_usb_sdio_tx_complete_skb,
 		.tx_status_data = mt7921_usb_sdio_tx_status_data,
 		.rx_skb = mt7921_queue_rx_skb,
+		.rx_check = mt7921_rx_check,
 		.sta_ps = mt7921_sta_ps,
 		.sta_add = mt7921_mac_sta_add,
 		.sta_assoc = mt7921_mac_sta_assoc,
diff --git a/drivers/net/wireless/mediatek/mt76/usb.c b/drivers/net/wireless/mediatek/mt76/usb.c
index 6b8964c19f50..4c4033bb1bb3 100644
--- a/drivers/net/wireless/mediatek/mt76/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/usb.c
@@ -528,6 +528,11 @@ mt76u_process_rx_entry(struct mt76_dev *dev, struct urb *urb,
 
 	head_room = drv_flags & MT_DRV_RX_DMA_HDR ? 0 : MT_DMA_HDR_LEN;
 	data_len = min_t(int, len, data_len - head_room);
+
+	if (len == data_len &&
+	    dev->drv->rx_check && !dev->drv->rx_check(dev, data, data_len))
+		return 0;
+
 	skb = mt76u_build_rx_skb(dev, data, data_len, buf_size);
 	if (!skb)
 		return 0;
-- 
2.36.1

