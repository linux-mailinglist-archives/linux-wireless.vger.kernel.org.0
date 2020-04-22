Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 258F81B4986
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Apr 2020 18:05:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbgDVQEz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 22 Apr 2020 12:04:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726830AbgDVQEm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 22 Apr 2020 12:04:42 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3320EC03C1AD
        for <linux-wireless@vger.kernel.org>; Wed, 22 Apr 2020 09:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=YIbw83ORCQfPY6FIY9As4bbOIcssYyINA+O/YcaD3Ac=; b=Zwctzw7a3wk9lV8A9xebLXNImb
        kzFzbnavYzEHpoD9Oqz8FOK+S1UKTbBfKQqYVmK/Hz8yeUQDnt5TKRJYGlz02FFac5urK1ZoteZdZ
        iXssFg/J7wTinLW79ZnmfQB3x+LKtw60elq7ccIuhHudH7lpRGbQfCr23SOJDCXAKviM=;
Received: from p54ae965b.dip0.t-ipconnect.de ([84.174.150.91] helo=maeck.lan)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1jRHrb-000559-Vf
        for linux-wireless@vger.kernel.org; Wed, 22 Apr 2020 18:04:40 +0200
Received: by maeck.lan (Postfix, from userid 501)
        id A0AC38419631; Wed, 22 Apr 2020 18:04:38 +0200 (CEST)
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 3/9] mt76: mt7615: use larger rx buffers if VHT is supported
Date:   Wed, 22 Apr 2020 18:04:31 +0200
Message-Id: <20200422160437.99466-3-nbd@nbd.name>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200422160437.99466-1-nbd@nbd.name>
References: <20200422160437.99466-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In VHT mode we can receive larger MPDUs. Increasing the buffer size reduces
fragmentation here, which should improve performance.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt7615/dma.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/dma.c b/drivers/net/wireless/mediatek/mt76/mt7615/dma.c
index 5cdbe3747901..0b1fbddd1c3f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/dma.c
@@ -192,8 +192,13 @@ static void mt7663_dma_sched_init(struct mt7615_dev *dev)
 int mt7615_dma_init(struct mt7615_dev *dev)
 {
 	int rx_ring_size = MT7615_RX_RING_SIZE;
+	int rx_buf_size = MT_RX_BUF_SIZE;
 	int ret;
 
+	/* Increase buffer size to receive large VHT MPDUs */
+	if (dev->mt76.cap.has_5ghz)
+		rx_buf_size *= 2;
+
 	mt76_dma_attach(&dev->mt76);
 
 	mt76_wr(dev, MT_WPDMA_GLO_CFG,
@@ -234,7 +239,7 @@ int mt7615_dma_init(struct mt7615_dev *dev)
 
 	/* init rx queues */
 	ret = mt76_queue_alloc(dev, &dev->mt76.q_rx[MT_RXQ_MCU], 1,
-			       MT7615_RX_MCU_RING_SIZE, MT_RX_BUF_SIZE,
+			       MT7615_RX_MCU_RING_SIZE, rx_buf_size,
 			       MT_RX_RING_BASE);
 	if (ret)
 		return ret;
@@ -243,7 +248,7 @@ int mt7615_dma_init(struct mt7615_dev *dev)
 	    rx_ring_size /= 2;
 
 	ret = mt76_queue_alloc(dev, &dev->mt76.q_rx[MT_RXQ_MAIN], 0,
-			       rx_ring_size, MT_RX_BUF_SIZE, MT_RX_RING_BASE);
+			       rx_ring_size, rx_buf_size, MT_RX_RING_BASE);
 	if (ret)
 		return ret;
 
-- 
2.24.0

