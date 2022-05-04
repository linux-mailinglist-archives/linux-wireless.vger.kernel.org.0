Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C43851A598
	for <lists+linux-wireless@lfdr.de>; Wed,  4 May 2022 18:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353485AbiEDQhC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 May 2022 12:37:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353484AbiEDQg6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 May 2022 12:36:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A490546674
        for <linux-wireless@vger.kernel.org>; Wed,  4 May 2022 09:33:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 33A5D6173F
        for <linux-wireless@vger.kernel.org>; Wed,  4 May 2022 16:33:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20801C385B1;
        Wed,  4 May 2022 16:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651682000;
        bh=1b32rzGazO9pHfwZeTeTHbpy2Na8Yj3Jvnfqlt+8Gg8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kdO3jEW4iB7+/+PyYMLFe0n8xrFtanyrlOs/35RgmBgqsnVL5NZz28A3vM45uxZ9E
         XuZTsVI2UaWfhwz3KsPhRrV+cPwqc8MwPs5X4YbPgBkbnrd8FrifrC7n2bKwOCWRUm
         InRtsrf9JsumWh33aALOQOywoDCrisgBJGUD9gwxEfbqFKhXXPiX7Q/PIvR8MA6lG/
         7bgNPDKOvvPuJGUls4OSNXAe3vpyCw9kKehOYL59eOBc9Lp+DbNWJ7SOFIfz/kgE/A
         4n/fkqVzKLffyN650LJ/tYs5Z4w2CB4EiozgzhVGTsCLmCsKtVnhs2sx2httXlBm8q
         nq/CNUrEBR3Vg==
From:   Jakub Kicinski <kuba@kernel.org>
To:     kvalo@kernel.org
Cc:     linux-wireless@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
        nbd@nbd.name, lorenzo@kernel.org, ryder.lee@mediatek.com,
        shayne.chen@mediatek.com, sean.wang@mediatek.com,
        matthias.bgg@gmail.com, Bo.Jiao@mediatek.com,
        sujuan.chen@mediatek.com, linux-mediatek@lists.infradead.org
Subject: [PATCH wireless-next 2/3] wifi: mt76: switch to netif_napi_add_tx()
Date:   Wed,  4 May 2022 09:33:15 -0700
Message-Id: <20220504163316.549648-3-kuba@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220504163316.549648-1-kuba@kernel.org>
References: <20220504163316.549648-1-kuba@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Switch to the new API not requiring passing in NAPI_POLL_WEIGHT.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: nbd@nbd.name
CC: lorenzo@kernel.org
CC: ryder.lee@mediatek.com
CC: shayne.chen@mediatek.com
CC: sean.wang@mediatek.com
CC: kvalo@kernel.org
CC: matthias.bgg@gmail.com
CC: Bo.Jiao@mediatek.com
CC: sujuan.chen@mediatek.com
CC: linux-wireless@vger.kernel.org
CC: linux-mediatek@lists.infradead.org
---
 drivers/net/wireless/mediatek/mt76/mt7603/dma.c   | 4 ++--
 drivers/net/wireless/mediatek/mt76/mt7615/dma.c   | 4 ++--
 drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c | 4 ++--
 drivers/net/wireless/mediatek/mt76/mt7915/dma.c   | 4 ++--
 drivers/net/wireless/mediatek/mt76/mt7921/dma.c   | 4 ++--
 5 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/dma.c b/drivers/net/wireless/mediatek/mt76/mt7603/dma.c
index 37b092e3ea51..2c1c79dc7fda 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/dma.c
@@ -223,8 +223,8 @@ int mt7603_dma_init(struct mt7603_dev *dev)
 	if (ret)
 		return ret;
 
-	netif_tx_napi_add(&dev->mt76.tx_napi_dev, &dev->mt76.tx_napi,
-			  mt7603_poll_tx, NAPI_POLL_WEIGHT);
+	netif_napi_add_tx(&dev->mt76.tx_napi_dev, &dev->mt76.tx_napi,
+			  mt7603_poll_tx);
 	napi_enable(&dev->mt76.tx_napi);
 
 	return 0;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/dma.c b/drivers/net/wireless/mediatek/mt76/mt7615/dma.c
index 00aefea1bf61..95dbb413678a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/dma.c
@@ -284,8 +284,8 @@ int mt7615_dma_init(struct mt7615_dev *dev)
 	if (ret < 0)
 		return ret;
 
-	netif_tx_napi_add(&dev->mt76.tx_napi_dev, &dev->mt76.tx_napi,
-			  mt7615_poll_tx, NAPI_POLL_WEIGHT);
+	netif_napi_add_tx(&dev->mt76.tx_napi_dev, &dev->mt76.tx_napi,
+			  mt7615_poll_tx);
 	napi_enable(&dev->mt76.tx_napi);
 
 	mt76_poll(dev, MT_WPDMA_GLO_CFG,
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c b/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
index 8bcd8afa0d3a..23d2864d37fb 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
@@ -230,8 +230,8 @@ int mt76x02_dma_init(struct mt76x02_dev *dev)
 	if (ret)
 		return ret;
 
-	netif_tx_napi_add(&dev->mt76.tx_napi_dev, &dev->mt76.tx_napi,
-			  mt76x02_poll_tx, NAPI_POLL_WEIGHT);
+	netif_napi_add_tx(&dev->mt76.tx_napi_dev, &dev->mt76.tx_napi,
+			  mt76x02_poll_tx);
 	napi_enable(&dev->mt76.tx_napi);
 
 	return 0;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/dma.c b/drivers/net/wireless/mediatek/mt76/mt7915/dma.c
index 49b4d8ade16b..75678aabff32 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/dma.c
@@ -434,8 +434,8 @@ int mt7915_dma_init(struct mt7915_dev *dev)
 	if (ret < 0)
 		return ret;
 
-	netif_tx_napi_add(&dev->mt76.tx_napi_dev, &dev->mt76.tx_napi,
-			  mt7915_poll_tx, NAPI_POLL_WEIGHT);
+	netif_napi_add_tx(&dev->mt76.tx_napi_dev, &dev->mt76.tx_napi,
+			  mt7915_poll_tx);
 	napi_enable(&dev->mt76.tx_napi);
 
 	mt7915_dma_enable(dev);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/dma.c b/drivers/net/wireless/mediatek/mt76/mt7921/dma.c
index ca7e20fb5fc0..34b3effe14f3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/dma.c
@@ -296,8 +296,8 @@ int mt7921_dma_init(struct mt7921_dev *dev)
 	if (ret < 0)
 		return ret;
 
-	netif_tx_napi_add(&dev->mt76.tx_napi_dev, &dev->mt76.tx_napi,
-			  mt7921_poll_tx, NAPI_POLL_WEIGHT);
+	netif_napi_add_tx(&dev->mt76.tx_napi_dev, &dev->mt76.tx_napi,
+			  mt7921_poll_tx);
 	napi_enable(&dev->mt76.tx_napi);
 
 	return mt7921_dma_enable(dev);
-- 
2.34.1

