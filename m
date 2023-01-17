Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 687D566DFD2
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Jan 2023 15:03:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbjAQODN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Jan 2023 09:03:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230448AbjAQODK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Jan 2023 09:03:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4842338E87
        for <linux-wireless@vger.kernel.org>; Tue, 17 Jan 2023 06:03:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D912461462
        for <linux-wireless@vger.kernel.org>; Tue, 17 Jan 2023 14:03:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAD3AC433D2;
        Tue, 17 Jan 2023 14:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673964189;
        bh=0P6rK3Vzvxp2hpgnHM7yHTUWvNy5DAupIdqSG+eXd6w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sxJvhz0Et4/ZLAGMmwgk8oB2JZY1DfNrxg96p3rpr9UWj8JW3xDCXBvDZ31FhEPCd
         w/DyWleuMbnvmJlHE1x78BI5j4j+uiTqqfO/iIjKs9h3TtUfWY4U+HmPGk0M4I33YM
         dI9lfG06XsyXMz1LNBqCi2o93JnkCht6UaHUMJwRCFGkiquh9Qb5FaD3z5P5bIg2kV
         5gfyRXX04cVw1zXLlg/tELnELyel4xM11iHjorblD4hNTG60e0Lswe3IeYF7hoBcGI
         VP3bOq+fuHVvLVgYCUvuDAUAevO8ywApJTIUQIh7FflynUcl729vFDWjrzm1jIV6Hk
         lf2mQY9tQARlQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sujuan.chen@mediatek.com
Subject: [PATCH v2 1/4] wifi: mt76: dma: add reset to mt76_dma_wed_setup signature
Date:   Tue, 17 Jan 2023 15:02:53 +0100
Message-Id: <0f78ea3a6d8e69c9529c4c67d49506fd139ed45f.1673963962.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <cover.1673963962.git.lorenzo@kernel.org>
References: <cover.1673963962.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sujuan Chen <sujuan.chen@mediatek.com>

Export mt76_dma_wed_setup routine. This is a preliminary patch to
introduce proper wed reset support.

Tested-by: Daniel Golle <daniel@makrotopia.org>
Co-developed-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Sujuan Chen <sujuan.chen@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/dma.c | 16 ++++++++++------
 drivers/net/wireless/mediatek/mt76/dma.h |  1 +
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wireless/mediatek/mt76/dma.c
index 33e47ea0368e..5629b949fac0 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/dma.c
@@ -634,14 +634,17 @@ mt76_dma_rx_fill(struct mt76_dev *dev, struct mt76_queue *q,
 	return frames;
 }
 
-static int
-mt76_dma_wed_setup(struct mt76_dev *dev, struct mt76_queue *q)
+int mt76_dma_wed_setup(struct mt76_dev *dev, struct mt76_queue *q, bool reset)
 {
 #ifdef CONFIG_NET_MEDIATEK_SOC_WED
 	struct mtk_wed_device *wed = &dev->mmio.wed;
 	int ret, type, ring;
-	u8 flags = q->flags;
+	u8 flags;
+
+	if (!q || !q->ndesc)
+		return -EINVAL;
 
+	flags = q->flags;
 	if (!mtk_wed_device_active(wed))
 		q->flags &= ~MT_QFLAG_WED;
 
@@ -653,7 +656,7 @@ mt76_dma_wed_setup(struct mt76_dev *dev, struct mt76_queue *q)
 
 	switch (type) {
 	case MT76_WED_Q_TX:
-		ret = mtk_wed_device_tx_ring_setup(wed, ring, q->regs, false);
+		ret = mtk_wed_device_tx_ring_setup(wed, ring, q->regs, reset);
 		if (!ret)
 			q->wed_regs = wed->tx_ring[ring].reg_base;
 		break;
@@ -669,7 +672,7 @@ mt76_dma_wed_setup(struct mt76_dev *dev, struct mt76_queue *q)
 			q->wed_regs = wed->txfree_ring.reg_base;
 		break;
 	case MT76_WED_Q_RX:
-		ret = mtk_wed_device_rx_ring_setup(wed, ring, q->regs, false);
+		ret = mtk_wed_device_rx_ring_setup(wed, ring, q->regs, reset);
 		if (!ret)
 			q->wed_regs = wed->rx_ring[ring].reg_base;
 		break;
@@ -682,6 +685,7 @@ mt76_dma_wed_setup(struct mt76_dev *dev, struct mt76_queue *q)
 	return 0;
 #endif
 }
+EXPORT_SYMBOL_GPL(mt76_dma_wed_setup);
 
 static int
 mt76_dma_alloc_queue(struct mt76_dev *dev, struct mt76_queue *q,
@@ -712,7 +716,7 @@ mt76_dma_alloc_queue(struct mt76_dev *dev, struct mt76_queue *q,
 	if (ret)
 		return ret;
 
-	ret = mt76_dma_wed_setup(dev, q);
+	ret = mt76_dma_wed_setup(dev, q, false);
 	if (ret)
 		return ret;
 
diff --git a/drivers/net/wireless/mediatek/mt76/dma.h b/drivers/net/wireless/mediatek/mt76/dma.h
index 53c6ce2528b2..4b9bc7f462b8 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.h
+++ b/drivers/net/wireless/mediatek/mt76/dma.h
@@ -56,5 +56,6 @@ enum mt76_mcu_evt_type {
 int mt76_dma_rx_poll(struct napi_struct *napi, int budget);
 void mt76_dma_attach(struct mt76_dev *dev);
 void mt76_dma_cleanup(struct mt76_dev *dev);
+int mt76_dma_wed_setup(struct mt76_dev *dev, struct mt76_queue *q, bool reset);
 
 #endif
-- 
2.39.0

