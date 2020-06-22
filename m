Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4175C2041AF
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jun 2020 22:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728735AbgFVUNl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 22 Jun 2020 16:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728414AbgFVUNk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 22 Jun 2020 16:13:40 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62E91C061795
        for <linux-wireless@vger.kernel.org>; Mon, 22 Jun 2020 13:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=unpmBz2h+G5i2VYH8BHgbNnK+shxEmXWCisN/Qi7dFA=; b=dmoRPFhkvS/kpIPhcqctgt2jNa
        6QlMMkbb84kTVwixOZO31Vc5EVgg2xv7AzMVBOnGIRi2BQp0OpMOePJCkYsi0HKkzcVa8mYn+3/gJ
        fFY/1kx2WV5vurVRUi314FR6xG9K/jw4R/MvAi+ECLHCViof236PVIRlcj4x0Vi0kJxc=;
Received: from p54ae948c.dip0.t-ipconnect.de ([84.174.148.140] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1jnSoz-0000qE-Kv
        for linux-wireless@vger.kernel.org; Mon, 22 Jun 2020 22:13:37 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 1/7] mt76: mt7615: schedule tx tasklet and sta poll on mac tx free
Date:   Mon, 22 Jun 2020 22:13:21 +0200
Message-Id: <20200622201327.94414-1-nbd@nbd.name>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Unlike on earlier chips, DMA completion on MT7615 does not imply actually
having sent out any packets.
Since AQL will prevent filling the hardware queues and will only allow more
packets to be passed to the driver after tx completion, it makes much more
sense to schedule the tx tasklet there.
This is also needed for scheduling tx in testmode support

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt7615/dma.c | 4 ----
 drivers/net/wireless/mediatek/mt76/mt7615/mac.c | 6 ++++++
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/dma.c b/drivers/net/wireless/mediatek/mt76/mt7615/dma.c
index e5a965df899a..1231a5ddf9ea 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/dma.c
@@ -122,10 +122,6 @@ static int mt7615_poll_tx(struct napi_struct *napi, int budget)
 
 	mt7615_tx_cleanup(dev);
 
-	rcu_read_lock();
-	mt7615_mac_sta_poll(dev);
-	rcu_read_unlock();
-
 	tasklet_schedule(&dev->mt76.tx_tasklet);
 
 	return 0;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index d150fac50c00..1dc291e8b766 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -1399,6 +1399,12 @@ static void mt7615_mac_tx_free(struct mt7615_dev *dev, struct sk_buff *skb)
 	}
 
 	dev_kfree_skb(skb);
+
+	rcu_read_lock();
+	mt7615_mac_sta_poll(dev);
+	rcu_read_unlock();
+
+	tasklet_schedule(&dev->mt76.tx_tasklet);
 }
 
 void mt7615_queue_rx_skb(struct mt76_dev *mdev, enum mt76_rxq_id q,
-- 
2.24.0

