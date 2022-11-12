Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0207C626A50
	for <lists+linux-wireless@lfdr.de>; Sat, 12 Nov 2022 16:41:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235068AbiKLPl0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 12 Nov 2022 10:41:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235082AbiKLPlW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 12 Nov 2022 10:41:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 894741B783
        for <linux-wireless@vger.kernel.org>; Sat, 12 Nov 2022 07:41:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 17D1360919
        for <linux-wireless@vger.kernel.org>; Sat, 12 Nov 2022 15:41:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23004C433D6;
        Sat, 12 Nov 2022 15:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668267679;
        bh=zSdb0y9s4Qp6frRAj55RC180c2dBA0M94SQpmNF4Cc4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NL9DUx0F0OjsV62ZZ9McyS3lrdY9+UYKYMIIczQwINzVqDuc2cY9nrMV7aLWIDG6L
         ZiGWtAFSPkYj7PLJtgzV0ANckzLtVckmXOPOCziqcoDicg0Doy7Cr708k+T5WXQl2x
         7bkWnn24aI3fA7XAE8opFhGmOv+Tgg9s+1whEyzEETSoaSi7+3HiJUI04ffhxRpAee
         cJ2szaNcnyi5p3Z1bf/tZ4zGk7YfoNX+1f+M3W/7hHOSbrxysmUabX+iL7NCRmUuQh
         ZpwJ40JLQKTrYT6MsuKw9rHkg4EaqTqeaDVwkUh565HbRG5N8Nm+Psm4jkGf8AA01D
         F/81hty+7KtGg==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        Bo.Jiao@mediatek.com, sujuan.chen@mediatek.com,
        ryder.Lee@mediatek.com, evelyn.tsai@mediatek.com
Subject: [PATCH 4/8] wifi: mt76: add WED RX support to dma queue alloc
Date:   Sat, 12 Nov 2022 16:40:37 +0100
Message-Id: <42d29f1a9c34fbb4efa50c0b230e72412e9d0f90.1668267241.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1668267241.git.lorenzo@kernel.org>
References: <cover.1668267241.git.lorenzo@kernel.org>
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

Introduce the capability to allocate WED RX buffers in
mt76_dma_wed_setup routine.

Tested-by: Daniel Golle <daniel@makrotopia.org>
Co-developed-by: Sujuan Chen <sujuan.chen@mediatek.com>
Signed-off-by: Sujuan Chen <sujuan.chen@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/dma.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wireless/mediatek/mt76/dma.c
index cb6e3b358aca..58b41bda5eac 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/dma.c
@@ -647,6 +647,11 @@ mt76_dma_wed_setup(struct mt76_dev *dev, struct mt76_queue *q)
 		if (!ret)
 			q->wed_regs = wed->txfree_ring.reg_base;
 		break;
+	case MT76_WED_Q_RX:
+		ret = mtk_wed_device_rx_ring_setup(wed, ring, q->regs);
+		if (!ret)
+			q->wed_regs = wed->rx_ring[ring].reg_base;
+		break;
 	default:
 		ret = -EINVAL;
 	}
@@ -938,8 +943,11 @@ void mt76_dma_cleanup(struct mt76_dev *dev)
 		mt76_dma_tx_cleanup(dev, dev->q_mcu[i], true);
 
 	mt76_for_each_q_rx(dev, i) {
+		struct mt76_queue *q = &dev->q_rx[i];
+
 		netif_napi_del(&dev->napi[i]);
-		mt76_dma_rx_cleanup(dev, &dev->q_rx[i]);
+		if (FIELD_GET(MT_QFLAG_WED_TYPE, q->flags))
+			mt76_dma_rx_cleanup(dev, q);
 	}
 
 	mt76_free_pending_txwi(dev);
-- 
2.38.1

