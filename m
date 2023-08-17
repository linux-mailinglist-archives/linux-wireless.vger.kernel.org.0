Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B04977FB39
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Aug 2023 17:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353364AbjHQPx0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Aug 2023 11:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353349AbjHQPxH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Aug 2023 11:53:07 -0400
Received: from nbd.name (nbd.name [46.4.11.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C4B1FE
        for <linux-wireless@vger.kernel.org>; Thu, 17 Aug 2023 08:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
        s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=cNhxQn7AZUkzFiPqdRKQU1fgE61UHPHbS8E/a7TtUrc=; b=jVCU6fs2jmKRcj6x7yYYk+Aml/
        Pajh5OVC1me/fR3gN3iKhUlZCTwa//BcwFcm1PrEq4eAr90ZUyw039z9lqKcKkzVGt4NeQ0XXUkvl
        2DyeqC3CYrkZEuV9+PVB/XygEAEkubgSnun+6bR+7i+eWMJBcYxVJImcLV4tKxLZCKfA=;
Received: from 134.101.185.184.dynamic-pppoe.dt.ipv4.wtnet.de ([134.101.185.184] helo=Maecks.fritz.box)
        by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
        (Exim 4.94.2)
        (envelope-from <nbd@nbd.name>)
        id 1qWfJ2-00AmKH-08
        for linux-wireless@vger.kernel.org; Thu, 17 Aug 2023 17:53:04 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 2/5] wifi: mt76: mt7603: improve watchdog reset reliablity
Date:   Thu, 17 Aug 2023 17:52:55 +0200
Message-ID: <20230817155258.62636-2-nbd@nbd.name>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230817155258.62636-1-nbd@nbd.name>
References: <20230817155258.62636-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Only trigger PSE reset if PSE was stuck, otherwise it can cause DMA issues.
Trigger the PSE reset while DMA is fully stopped in order to improve
reliabilty.

Fixes: c8846e101502 ("mt76: add driver for MT7603E and MT7628/7688")
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 .../net/wireless/mediatek/mt76/mt7603/mac.c   | 29 ++++++++-----------
 1 file changed, 12 insertions(+), 17 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
index 7a506a0c46e2..cf21d06257e5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
@@ -1441,15 +1441,6 @@ static void mt7603_mac_watchdog_reset(struct mt7603_dev *dev)
 
 	mt7603_beacon_set_timer(dev, -1, 0);
 
-	if (dev->reset_cause[RESET_CAUSE_RESET_FAILED] ||
-	    dev->cur_reset_cause == RESET_CAUSE_RX_PSE_BUSY ||
-	    dev->cur_reset_cause == RESET_CAUSE_BEACON_STUCK ||
-	    dev->cur_reset_cause == RESET_CAUSE_TX_HANG)
-		mt7603_pse_reset(dev);
-
-	if (dev->reset_cause[RESET_CAUSE_RESET_FAILED])
-		goto skip_dma_reset;
-
 	mt7603_mac_stop(dev);
 
 	mt76_clear(dev, MT_WPDMA_GLO_CFG,
@@ -1459,28 +1450,32 @@ static void mt7603_mac_watchdog_reset(struct mt7603_dev *dev)
 
 	mt7603_irq_disable(dev, mask);
 
-	mt76_set(dev, MT_WPDMA_GLO_CFG, MT_WPDMA_GLO_CFG_FORCE_TX_EOF);
-
 	mt7603_pse_client_reset(dev);
 
 	mt76_queue_tx_cleanup(dev, dev->mt76.q_mcu[MT_MCUQ_WM], true);
 	for (i = 0; i < __MT_TXQ_MAX; i++)
 		mt76_queue_tx_cleanup(dev, dev->mphy.q_tx[i], true);
 
+	mt7603_dma_sched_reset(dev);
+
+	mt76_tx_status_check(&dev->mt76, true);
+
 	mt76_for_each_q_rx(&dev->mt76, i) {
 		mt76_queue_rx_reset(dev, i);
 	}
 
-	mt76_tx_status_check(&dev->mt76, true);
+	if (dev->reset_cause[RESET_CAUSE_RESET_FAILED] ||
+	    dev->cur_reset_cause == RESET_CAUSE_RX_PSE_BUSY)
+		mt7603_pse_reset(dev);
 
-	mt7603_dma_sched_reset(dev);
+	if (!dev->reset_cause[RESET_CAUSE_RESET_FAILED]) {
+		mt7603_mac_dma_start(dev);
 
-	mt7603_mac_dma_start(dev);
+		mt7603_irq_enable(dev, mask);
 
-	mt7603_irq_enable(dev, mask);
+		clear_bit(MT76_RESET, &dev->mphy.state);
+	}
 
-skip_dma_reset:
-	clear_bit(MT76_RESET, &dev->mphy.state);
 	mutex_unlock(&dev->mt76.mutex);
 
 	mt76_worker_enable(&dev->mt76.tx_worker);
-- 
2.41.0

