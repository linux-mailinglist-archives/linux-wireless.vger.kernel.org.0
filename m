Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BAAB3980DF
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Jun 2021 08:03:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbhFBGEn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 2 Jun 2021 02:04:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbhFBGEn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 2 Jun 2021 02:04:43 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA85AC061574
        for <linux-wireless@vger.kernel.org>; Tue,  1 Jun 2021 23:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=LaZX2NC8ZzxMgqnKeRkilUSVHYgfejMm/ae30HFkKhw=; b=Uq1itFPnZgL2QpZeI1xXdcQMRY
        hnj7U4eYAUM+RhdofAYLchmA2lB2r4X/QQCz/6GDdNiIP76Dg2WJvq8hWI7iUuHme1W8A39boz0hM
        0tsiZgIrss77fyj+PNd8hpzdx+uxTauIsgegnqIQ6YWPAEasc5KRb6CFCs8F+/KiFjVQ=;
Received: from p54ae9ff2.dip0.t-ipconnect.de ([84.174.159.242] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1loJxz-0002zg-2I
        for linux-wireless@vger.kernel.org; Wed, 02 Jun 2021 08:02:59 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH] mt76: mt7915: improve error recovery reliability
Date:   Wed,  2 Jun 2021 08:02:57 +0200
Message-Id: <20210602060257.16978-1-nbd@nbd.name>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

- Remove no-op code for queue lock/unlock, which is no longer needed
- Set a missing DMA flag
- Wait for full completion of error recovery before restarting tx
- Schedule IRQ tasklet to ensure that IRQ mask gets written

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 .../net/wireless/mediatek/mt76/mt7915/mac.c   | 29 ++++++++++---------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 642a11e72bef..ecd00dfa68ff 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -1608,14 +1608,18 @@ mt7915_dma_reset(struct mt7915_dev *dev)
 	mt76_set(dev, MT_WFDMA0_GLO_CFG,
 		 MT_WFDMA0_GLO_CFG_TX_DMA_EN | MT_WFDMA0_GLO_CFG_RX_DMA_EN);
 	mt76_set(dev, MT_WFDMA1_GLO_CFG,
-		 MT_WFDMA1_GLO_CFG_TX_DMA_EN | MT_WFDMA1_GLO_CFG_RX_DMA_EN);
+		 MT_WFDMA1_GLO_CFG_TX_DMA_EN | MT_WFDMA1_GLO_CFG_RX_DMA_EN |
+		 MT_WFDMA1_GLO_CFG_OMIT_TX_INFO |
+		 MT_WFDMA1_GLO_CFG_OMIT_RX_INFO);
 	if (dev->hif2) {
 		mt76_set(dev, MT_WFDMA0_GLO_CFG + hif1_ofs,
 			(MT_WFDMA0_GLO_CFG_TX_DMA_EN |
 			 MT_WFDMA0_GLO_CFG_RX_DMA_EN));
 		mt76_set(dev, MT_WFDMA1_GLO_CFG + hif1_ofs,
 			(MT_WFDMA1_GLO_CFG_TX_DMA_EN |
-			 MT_WFDMA1_GLO_CFG_RX_DMA_EN));
+			 MT_WFDMA1_GLO_CFG_RX_DMA_EN |
+			 MT_WFDMA1_GLO_CFG_OMIT_TX_INFO |
+			 MT_WFDMA1_GLO_CFG_OMIT_RX_INFO));
 	}
 }
 
@@ -1659,11 +1663,6 @@ void mt7915_mac_reset_work(struct work_struct *work)
 		set_bit(MT76_RESET, &phy2->mt76->state);
 		cancel_delayed_work_sync(&phy2->mt76->mac_work);
 	}
-	/* lock/unlock all queues to ensure that no tx is pending */
-	mt76_txq_schedule_all(&dev->mphy);
-	if (ext_phy)
-		mt76_txq_schedule_all(ext_phy);
-
 	mt76_worker_disable(&dev->mt76.tx_worker);
 	napi_disable(&dev->mt76.napi[0]);
 	napi_disable(&dev->mt76.napi[1]);
@@ -1689,10 +1688,6 @@ void mt7915_mac_reset_work(struct work_struct *work)
 	if (phy2)
 		clear_bit(MT76_RESET, &phy2->mt76->state);
 
-	mt76_worker_enable(&dev->mt76.tx_worker);
-	napi_enable(&dev->mt76.tx_napi);
-	napi_schedule(&dev->mt76.tx_napi);
-
 	napi_enable(&dev->mt76.napi[0]);
 	napi_schedule(&dev->mt76.napi[0]);
 
@@ -1701,14 +1696,20 @@ void mt7915_mac_reset_work(struct work_struct *work)
 
 	napi_enable(&dev->mt76.napi[2]);
 	napi_schedule(&dev->mt76.napi[2]);
+	tasklet_schedule(&dev->irq_tasklet);
+
+	mt76_wr(dev, MT_MCU_INT_EVENT, MT_MCU_INT_EVENT_RESET_DONE);
+	mt7915_wait_reset_state(dev, MT_MCU_CMD_NORMAL_STATE);
+
+	mt76_worker_enable(&dev->mt76.tx_worker);
+
+	napi_enable(&dev->mt76.tx_napi);
+	napi_schedule(&dev->mt76.tx_napi);
 
 	ieee80211_wake_queues(mt76_hw(dev));
 	if (ext_phy)
 		ieee80211_wake_queues(ext_phy->hw);
 
-	mt76_wr(dev, MT_MCU_INT_EVENT, MT_MCU_INT_EVENT_RESET_DONE);
-	mt7915_wait_reset_state(dev, MT_MCU_CMD_NORMAL_STATE);
-
 	mutex_unlock(&dev->mt76.mutex);
 
 	mt7915_update_beacons(dev);
-- 
2.30.1

