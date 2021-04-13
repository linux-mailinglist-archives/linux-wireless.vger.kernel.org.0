Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5698635E6E9
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Apr 2021 21:06:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231210AbhDMTHH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 13 Apr 2021 15:07:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbhDMTHG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 13 Apr 2021 15:07:06 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 748D8C061574
        for <linux-wireless@vger.kernel.org>; Tue, 13 Apr 2021 12:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=3Ek1Or5gYq6auk/n55uXL3TA8UKIpfxVBA3Yj9gk6w8=; b=AsgNogS2ThUjoZUoVzn850Kzfs
        Rc8pAFmR5lXTfWC/RyaEEgAkbp8ndYXxjAjD/OglBrhs2am90zAcMyOytVSEyi/YjSPsHnKY+fd5e
        +yeuwL9+SRuSRll1wptR68J1thW0sFf+KfaOFc7PtfjEq0ULp9uxsUIPv3becbkLoOks=;
Received: from p4ff13c8d.dip0.t-ipconnect.de ([79.241.60.141] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1lWON2-0005m3-B9
        for linux-wireless@vger.kernel.org; Tue, 13 Apr 2021 21:06:44 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH] mt76: flush tx status queue on DMA reset
Date:   Tue, 13 Apr 2021 21:06:41 +0200
Message-Id: <20210413190641.88320-1-nbd@nbd.name>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

After DMA reset, tx status information for queued frames will never arrive.
Flush the queue to free skbs immediately instead of waiting for a timeout

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt7603/mac.c     | 2 ++
 drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c | 2 ++
 drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c   | 2 ++
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c     | 2 ++
 drivers/net/wireless/mediatek/mt76/mt7921/mac.c     | 2 ++
 5 files changed, 10 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
index e3a9dd6fbd87..fbceb07c5f37 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
@@ -1445,6 +1445,8 @@ static void mt7603_mac_watchdog_reset(struct mt7603_dev *dev)
 		mt76_queue_rx_reset(dev, i);
 	}
 
+	mt76_tx_status_check(&dev->mt76, NULL, true);
+
 	mt7603_dma_sched_reset(dev);
 
 	mt7603_mac_dma_start(dev);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c
index 9ac4bdabc0ef..8cd79e849045 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c
@@ -201,6 +201,8 @@ void mt7615_dma_reset(struct mt7615_dev *dev)
 	mt76_for_each_q_rx(&dev->mt76, i)
 		mt76_queue_rx_reset(dev, i);
 
+	mt76_tx_status_check(&dev->mt76, NULL, true);
+
 	mt7615_dma_start(dev);
 }
 EXPORT_SYMBOL_GPL(mt7615_dma_reset);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c b/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
index fc12824ab74e..ce1e9ad23fec 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
@@ -472,6 +472,8 @@ static void mt76x02_watchdog_reset(struct mt76x02_dev *dev)
 		mt76_queue_rx_reset(dev, i);
 	}
 
+	mt76_tx_status_check(&dev->mt76, NULL, true);
+
 	mt76x02_mac_start(dev);
 
 	if (dev->ed_monitor)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 35ab4bf011eb..6a4b57509751 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -1564,6 +1564,8 @@ mt7915_dma_reset(struct mt7915_dev *dev)
 	mt76_for_each_q_rx(&dev->mt76, i)
 		mt76_queue_rx_reset(dev, i);
 
+	mt76_tx_status_check(&dev->mt76, NULL, true);
+
 	/* re-init prefetch settings after reset */
 	mt7915_dma_prefetch(dev);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index b507f3917830..572bab82315a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -1254,6 +1254,8 @@ mt7921_dma_reset(struct mt7921_dev *dev)
 	mt76_for_each_q_rx(&dev->mt76, i)
 		mt76_queue_reset(dev, &dev->mt76.q_rx[i]);
 
+	mt76_tx_status_check(&dev->mt76, NULL, true);
+
 	/* configure perfetch settings */
 	mt7921_dma_prefetch(dev);
 
-- 
2.30.1

