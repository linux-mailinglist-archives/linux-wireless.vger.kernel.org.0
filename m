Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1BAC65A9D9
	for <lists+linux-wireless@lfdr.de>; Sun,  1 Jan 2023 12:50:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbjAALuP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 1 Jan 2023 06:50:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbjAALuO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 1 Jan 2023 06:50:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F39D1D93
        for <linux-wireless@vger.kernel.org>; Sun,  1 Jan 2023 03:50:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8A7FF60DBA
        for <linux-wireless@vger.kernel.org>; Sun,  1 Jan 2023 11:50:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83CC1C433F0;
        Sun,  1 Jan 2023 11:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672573811;
        bh=8UC8iyDQY9BzRcBi8GaBAVdB42QVP5SDlPxXmj0/CwM=;
        h=From:To:Cc:Subject:Date:From;
        b=PBvfgsBGG8Hfd4J4DnKNOXDjUJaT4NuMIvccMfNtRlyB6Zqhr0XGOCuIJ5FFuFA9l
         KUv8Jbn2hzt+EpnqJdljtxvbP3HJZspx1Y1v/RGlwTF3o5z6d9gxkwSzgVKVn411Fw
         EEBlXLubnj+EMZiNi6cZkObr3ZfpWOar7BykxorSN7r8WM9UR+FIiAPhGKAtfyMEge
         1lyiSxlu/GrCIrzxNj1ZRqwVTcJo+mhHxQH+rChGKAoZMJ4FFFKMz2UbNIziX9zBGV
         Y3ZWozWJbLfHx//lXXNv/xKQVd6m651QoHGUkSFit64UrQRCYVwh/pJQpe1grpGu0M
         Z7ck4/gMr8eQw==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org
Subject: [PATCH] wifi: mt76: dma: fix memory leak running mt76_dma_tx_cleanup
Date:   Sun,  1 Jan 2023 12:50:05 +0100
Message-Id: <26733e02e6edbe9b771a4b3bf862594905b08bbb.1672573736.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.38.1
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

Fix device unregister memory leak and alway cleanup all configured
rx queues in mt76_dma_tx_cleanup routine.

Fixes: 52546e27787e ("wifi: mt76: add WED RX support to dma queue alloc")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/dma.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wireless/mediatek/mt76/dma.c
index f1cb45c44a72..4fba8059d463 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/dma.c
@@ -962,8 +962,7 @@ void mt76_dma_cleanup(struct mt76_dev *dev)
 		struct mt76_queue *q = &dev->q_rx[i];
 
 		netif_napi_del(&dev->napi[i]);
-		if (FIELD_GET(MT_QFLAG_WED_TYPE, q->flags))
-			mt76_dma_rx_cleanup(dev, q);
+		mt76_dma_rx_cleanup(dev, q);
 	}
 
 	mt76_free_pending_txwi(dev);
-- 
2.38.1

