Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 415A969EEC3
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Feb 2023 07:29:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbjBVG3y (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 22 Feb 2023 01:29:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjBVG3x (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 22 Feb 2023 01:29:53 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 693A43431A
        for <linux-wireless@vger.kernel.org>; Tue, 21 Feb 2023 22:29:51 -0800 (PST)
X-UUID: 4d6a3bb4b27a11eda06fc9ecc4dadd91-20230222
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=SMReaCXxwMWlPjCtDmlgPy2UA7uur7WDWXn4/VwP9i0=;
        b=GpCmRVLPrRkftEaP17p41K/zY07iPwpfdgAPMfb0jEiCPPKlmHaaGz+LpR4JNgZRzOQ/8MLRuw7XKKJv35qoeeKxFDBJF5yLVT1msyEC2OfdoQSvzAojVaeEirdEXSRmCM7cFU+IdicUiBpOdZjEIzbweYsBOjPD1vQ3P6HmzRw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.20,REQID:a675ce8f-b0ad-4146-a4ba-9a1d7b0d9f92,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-25
X-CID-META: VersionHash:25b5999,CLOUDID:fc8d35b1-beed-4dfc-bd9c-e1b22fa6ccc4,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-UUID: 4d6a3bb4b27a11eda06fc9ecc4dadd91-20230222
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <sujuan.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1283284976; Wed, 22 Feb 2023 14:29:47 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Wed, 22 Feb 2023 14:29:45 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Wed, 22 Feb 2023 14:29:45 +0800
From:   Sujuan Chen <sujuan.chen@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Bo Jiao <bo.jiao@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Sujuan Chen <sujuan.chen@mediatek.com>
Subject: [PATCH] wifi: mt76: mt7915: add dev->hif2 support for mt7916 WED device
Date:   Wed, 22 Feb 2023 14:29:36 +0800
Message-ID: <5dcd2b1b74b7c46ba4245f96eaf3a4e2f84b37e7.1677039727.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Enable two PCIe interfaces (dev->hif2) support for mt7916 when WED is enabled.

Signed-off-by: Sujuan Chen <sujuan.chen@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7915/dma.c  | 10 ++++++++--
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c  |  3 ++-
 drivers/net/wireless/mediatek/mt76/mt7915/mmio.c | 10 +++++-----
 3 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/dma.c b/drivers/net/wireless/mediatek/mt76/mt7915/dma.c
index abe17dac9996..43a5456d4b97 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/dma.c
@@ -87,8 +87,14 @@ static void mt7915_dma_config(struct mt7915_dev *dev)
 				   MT7916_RXQ_BAND0);
 			RXQ_CONFIG(MT_RXQ_MCU_WA, WFDMA0, MT_INT_WED_RX_DONE_WA_MT7916,
 				   MT7916_RXQ_MCU_WA);
-			RXQ_CONFIG(MT_RXQ_BAND1, WFDMA0, MT_INT_WED_RX_DONE_BAND1_MT7916,
-				   MT7916_RXQ_BAND1);
+			if (dev->hif2)
+				RXQ_CONFIG(MT_RXQ_BAND1, WFDMA0,
+					   MT_INT_RX_DONE_BAND1_MT7916,
+					   MT7916_RXQ_BAND1);
+			else
+				RXQ_CONFIG(MT_RXQ_BAND1, WFDMA0,
+					   MT_INT_WED_RX_DONE_BAND1_MT7916,
+					   MT7916_RXQ_BAND1);
 			RXQ_CONFIG(MT_RXQ_MAIN_WA, WFDMA0, MT_INT_WED_RX_DONE_WA_MAIN_MT7916,
 				   MT7916_RXQ_MCU_WA_MAIN);
 			TXQ_CONFIG(0, WFDMA0, MT_INT_WED_TX_DONE_BAND0,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 5545a8bdf1d0..cd440aaa969e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -2370,7 +2370,8 @@ int mt7915_mcu_init_firmware(struct mt7915_dev *dev)
 	if (ret)
 		return ret;
 
-	if (mtk_wed_device_active(&dev->mt76.mmio.wed) && is_mt7915(&dev->mt76))
+	if (mtk_wed_device_active(&dev->mt76.mmio.wed) &&
+	    is_mt7915(&dev->mt76) || !mtk_wed_get_rx_capa(&dev->mt76.mmio.wed))
 		mt7915_mcu_wa_cmd(dev, MCU_WA_PARAM_CMD(CAPABILITY), 0, 0, 0);
 
 	ret = mt7915_mcu_set_mwds(dev, 1);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
index 225a19604d3e..6f0c0e2ae045 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
@@ -989,13 +989,13 @@ irqreturn_t mt7915_irq_handler(int irq, void *dev_instance)
 	struct mt7915_dev *dev = dev_instance;
 	struct mtk_wed_device *wed = &dev->mt76.mmio.wed;
 
-	if (mtk_wed_device_active(wed)) {
+	if (mtk_wed_device_active(wed))
 		mtk_wed_device_irq_set_mask(wed, 0);
-	} else {
+	else
 		mt76_wr(dev, MT_INT_MASK_CSR, 0);
-		if (dev->hif2)
-			mt76_wr(dev, MT_INT1_MASK_CSR, 0);
-	}
+
+	if (dev->hif2)
+		mt76_wr(dev, MT_INT1_MASK_CSR, 0);
 
 	if (!test_bit(MT76_STATE_INITIALIZED, &dev->mphy.state))
 		return IRQ_NONE;
-- 
2.18.0

