Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A69E2FB9A4
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Jan 2021 15:37:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390547AbhASOgm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 19 Jan 2021 09:36:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389637AbhASKGp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 19 Jan 2021 05:06:45 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A58B3C061575
        for <linux-wireless@vger.kernel.org>; Tue, 19 Jan 2021 02:06:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=gVdFiAdSMIYCT8DjPwNQK/+h0xKtd8CRFhx1qOws3j0=; b=DruICp/4XLbJWdtMUYTNEa04PK
        ThIf+7SuRR9FAsBYonoijDaT7hPFkhAfaemFxhrnT6aprGdARI6fPXsb2JhC737aNbzgvycw985jG
        T3O9GSgB3bY1lfkPKl0R2bjATA3NjLd8QwerWaiddfIEpbL7PLixwbSioRQe3KoU4YaI=;
Received: from p54ae91f2.dip0.t-ipconnect.de ([84.174.145.242] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1l1nti-0004Zi-Ff
        for linux-wireless@vger.kernel.org; Tue, 19 Jan 2021 11:06:02 +0100
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 2/2] mt76: mt7915: bring up the WA event rx queue for band1
Date:   Tue, 19 Jan 2021 11:06:00 +0100
Message-Id: <20210119100600.27949-2-nbd@nbd.name>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210119100600.27949-1-nbd@nbd.name>
References: <20210119100600.27949-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This is needed for DBDC cards to work correctly on both bands simultaneously

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt76.h          | 1 +
 drivers/net/wireless/mediatek/mt76/mt7915/dma.c    | 8 ++++++++
 drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h | 1 +
 drivers/net/wireless/mediatek/mt76/mt7915/pci.c    | 4 ++++
 drivers/net/wireless/mediatek/mt76/mt7915/regs.h   | 3 ++-
 5 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 7a7776f38f44..90fbdaec8b89 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -81,6 +81,7 @@ enum mt76_rxq_id {
 	MT_RXQ_MCU,
 	MT_RXQ_MCU_WA,
 	MT_RXQ_EXT,
+	MT_RXQ_EXT_WA,
 	__MT_RXQ_MAX
 };
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/dma.c b/drivers/net/wireless/mediatek/mt76/mt7915/dma.c
index 8c1f9c77b14f..d47d8f4376c6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/dma.c
@@ -286,6 +286,14 @@ int mt7915_dma_init(struct mt7915_dev *dev)
 				       rx_buf_size, MT_RX_DATA_RING_BASE);
 		if (ret)
 			return ret;
+
+		/* event from WA */
+		ret = mt76_queue_alloc(dev, &dev->mt76.q_rx[MT_RXQ_EXT_WA],
+				       MT7915_RXQ_MCU_WA_EXT,
+				       MT7915_RX_MCU_RING_SIZE,
+				       rx_buf_size, MT_RX_EVENT_RING_BASE);
+		if (ret)
+			return ret;
 	}
 
 	ret = mt76_init_queues(dev);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index f45e88bf2626..a5882faa62ce 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -61,6 +61,7 @@ enum mt7915_rxq_id {
 	MT7915_RXQ_BAND1,
 	MT7915_RXQ_MCU_WM = 0,
 	MT7915_RXQ_MCU_WA,
+	MT7915_RXQ_MCU_WA_EXT,
 };
 
 struct mt7915_sta_stats {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/pci.c b/drivers/net/wireless/mediatek/mt76/mt7915/pci.c
index aeb86fbea41c..99f11588601d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/pci.c
@@ -26,6 +26,7 @@ mt7915_rx_poll_complete(struct mt76_dev *mdev, enum mt76_rxq_id q)
 		[MT_RXQ_EXT] = MT_INT_RX_DONE_DATA1,
 		[MT_RXQ_MCU] = MT_INT_RX_DONE_WM,
 		[MT_RXQ_MCU_WA] = MT_INT_RX_DONE_WA,
+		[MT_RXQ_EXT_WA] = MT_INT_RX_DONE_WA_EXT,
 	};
 
 	mt7915_irq_enable(dev, rx_irq_mask[q]);
@@ -67,6 +68,9 @@ static irqreturn_t mt7915_irq_handler(int irq, void *dev_instance)
 	if (intr & MT_INT_RX_DONE_WA)
 		napi_schedule(&dev->mt76.napi[MT_RXQ_MCU_WA]);
 
+	if (intr & MT_INT_RX_DONE_WA_EXT)
+		napi_schedule(&dev->mt76.napi[MT_RXQ_EXT_WA]);
+
 	if (intr & MT_INT_MCU_CMD) {
 		u32 val = mt76_rr(dev, MT_MCU_CMD);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/regs.h b/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
index 6fb5cbab9c32..77402eb13b9c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
@@ -348,7 +348,8 @@
 #define MT_INT_RX_DONE_DATA1		BIT(17)
 #define MT_INT_RX_DONE_WM		BIT(0)
 #define MT_INT_RX_DONE_WA		BIT(1)
-#define MT_INT_RX_DONE_ALL		(BIT(0) | BIT(1) | GENMASK(17, 16))
+#define MT_INT_RX_DONE_WA_EXT		BIT(2)
+#define MT_INT_RX_DONE_ALL		(GENMASK(2, 0) | GENMASK(17, 16))
 #define MT_INT_TX_DONE_MCU_WA		BIT(15)
 #define MT_INT_TX_DONE_FWDL		BIT(26)
 #define MT_INT_TX_DONE_MCU_WM		BIT(27)
-- 
2.28.0

