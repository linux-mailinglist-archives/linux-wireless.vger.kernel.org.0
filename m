Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A9CF2403B4
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Aug 2020 10:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbgHJI6h (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 10 Aug 2020 04:58:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726361AbgHJI6h (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 10 Aug 2020 04:58:37 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 216DEC061787
        for <linux-wireless@vger.kernel.org>; Mon, 10 Aug 2020 01:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=y15zYyjb32mL9O4yGieTCe16WcECo8zNt2dc7TLY9xQ=; b=JwjPpJlr8NTEdmOI5zKTbKdIKq
        MCSv3aqtYimBhvQziYIA6GCrxUG6eU8o7RSRawtWPJahBQc4xQAFDruqPLdsweS7ZPKezStQCrUAm
        I0iir2Z5fROfeyUWSugCKTYQhxLc5xRkwBN1bFCZ03USuMmQ1fkddqY/cnKH7wExysXs=;
Received: from p54ae996c.dip0.t-ipconnect.de ([84.174.153.108] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1k53da-0003XJ-2W
        for linux-wireless@vger.kernel.org; Mon, 10 Aug 2020 10:58:34 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 2/6] mt76: mt7915: clean up and fix interrupt masking in the irq handler
Date:   Mon, 10 Aug 2020 10:58:28 +0200
Message-Id: <20200810085832.65662-2-nbd@nbd.name>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200810085832.65662-1-nbd@nbd.name>
References: <20200810085832.65662-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Only clear unmasked interrupts. If an interrupt is temporarily masked,
its pending events need to be processed later, even if another interrupt
happened in the mean time.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 .../net/wireless/mediatek/mt76/mt7915/pci.c   | 25 ++++++++-----------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/pci.c b/drivers/net/wireless/mediatek/mt76/mt7915/pci.c
index 59034d480543..520dea15c449 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/pci.c
@@ -29,9 +29,10 @@ mt7915_rx_poll_complete(struct mt76_dev *mdev, enum mt76_rxq_id q)
 static irqreturn_t mt7915_irq_handler(int irq, void *dev_instance)
 {
 	struct mt7915_dev *dev = dev_instance;
-	u32 intr;
+	u32 intr, mask;
 
 	intr = mt76_rr(dev, MT_INT_SOURCE_CSR);
+	intr &= dev->mt76.mmio.irqmask;
 	mt76_wr(dev, MT_INT_SOURCE_CSR, intr);
 
 	if (!test_bit(MT76_STATE_INITIALIZED, &dev->mphy.state))
@@ -39,27 +40,23 @@ static irqreturn_t mt7915_irq_handler(int irq, void *dev_instance)
 
 	trace_dev_irq(&dev->mt76, intr, dev->mt76.mmio.irqmask);
 
-	intr &= dev->mt76.mmio.irqmask;
+	mask = intr & MT_INT_RX_DONE_ALL;
+	if (intr & MT_INT_TX_DONE_ALL)
+		mask |= MT_INT_TX_DONE_ALL;
 
-	if (intr & MT_INT_TX_DONE_ALL) {
-		mt7915_irq_disable(dev, MT_INT_TX_DONE_ALL);
+	mt7915_irq_disable(dev, mask);
+
+	if (intr & MT_INT_TX_DONE_ALL)
 		napi_schedule(&dev->mt76.tx_napi);
-	}
 
-	if (intr & MT_INT_RX_DONE_DATA) {
-		mt7915_irq_disable(dev, MT_INT_RX_DONE_DATA);
+	if (intr & MT_INT_RX_DONE_DATA)
 		napi_schedule(&dev->mt76.napi[0]);
-	}
 
-	if (intr & MT_INT_RX_DONE_WM) {
-		mt7915_irq_disable(dev, MT_INT_RX_DONE_WM);
+	if (intr & MT_INT_RX_DONE_WM)
 		napi_schedule(&dev->mt76.napi[1]);
-	}
 
-	if (intr & MT_INT_RX_DONE_WA) {
-		mt7915_irq_disable(dev, MT_INT_RX_DONE_WA);
+	if (intr & MT_INT_RX_DONE_WA)
 		napi_schedule(&dev->mt76.napi[2]);
-	}
 
 	if (intr & MT_INT_MCU_CMD) {
 		u32 val = mt76_rr(dev, MT_MCU_CMD);
-- 
2.28.0

