Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 346E057DB4F
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Jul 2022 09:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234151AbiGVHdI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 22 Jul 2022 03:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiGVHdG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 22 Jul 2022 03:33:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF12832EF6
        for <linux-wireless@vger.kernel.org>; Fri, 22 Jul 2022 00:33:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 74C7BB8279F
        for <linux-wireless@vger.kernel.org>; Fri, 22 Jul 2022 07:33:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99AE4C341C6;
        Fri, 22 Jul 2022 07:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658475183;
        bh=/0toe8ULUQgO5N6x+CJDnbE4kXXf4O2D8BXqp7E3lZY=;
        h=From:To:Cc:Subject:Date:From;
        b=g7ufAdf7Zoa3phG+1w9pp473pIiyg3u6TAd2aIKNqxBY0WWcWb8Nv3jI9szRDqpiK
         KOS8OqCW/+wArf4Hgj3t6D8HsSb2SJU7VAbXAkcjuHzxEH54A3KACnxyiSoBxXRlis
         XAEkY1epJoqf9TDgS+akemgLMya1wRCb2SD0+HmMExe3UIPyPRq46ETshfhNvMUyT9
         qGpKFHziONF9s4FFtMjIR2XxRGrxueEs7N6yAohUvAGcu9U3tmoLWaLmsNa/ioF3Kc
         gzBHIkbArU0iEb2skSgaWMv3L4nOrnZ4giglf2xR5U1vOrZFl1XLmnT6FU+XcOeFiA
         nLoh1ipCdDgnw==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com
Subject: [PATCH] mt76: sdio: add rx_check callback for sdio devices
Date:   Fri, 22 Jul 2022 09:32:36 +0200
Message-Id: <2902205ffea3f07349db8c1466e81a8a5f24dc86.1658474979.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce rx_check callback support for mt7921s driver.

Tested-by: Sean Wang <sean.wang@mediatek.com>
Co-developed-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
This patch is based on: "mt76: add rx_check callback for usb devices"
https://patchwork.kernel.org/project/linux-wireless/patch/1ce2555483783c2f62bb8fecc575ceca1aad8583.1658335993.git.lorenzo@kernel.org/
---
 .../net/wireless/mediatek/mt76/mt7921/sdio.c  |  1 +
 .../net/wireless/mediatek/mt76/sdio_txrx.c    | 23 +++++++++++++------
 2 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c b/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c
index 487acd6e2be8..0c1b6e70e756 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c
@@ -96,6 +96,7 @@ static int mt7921s_probe(struct sdio_func *func,
 		.tx_complete_skb = mt7921_usb_sdio_tx_complete_skb,
 		.tx_status_data = mt7921_usb_sdio_tx_status_data,
 		.rx_skb = mt7921_queue_rx_skb,
+		.rx_check = mt7921_rx_check,
 		.sta_ps = mt7921_sta_ps,
 		.sta_add = mt7921_mac_sta_add,
 		.sta_assoc = mt7921_mac_sta_assoc,
diff --git a/drivers/net/wireless/mediatek/mt76/sdio_txrx.c b/drivers/net/wireless/mediatek/mt76/sdio_txrx.c
index a2601aa9e7b1..bfc4de50a4d2 100644
--- a/drivers/net/wireless/mediatek/mt76/sdio_txrx.c
+++ b/drivers/net/wireless/mediatek/mt76/sdio_txrx.c
@@ -85,7 +85,7 @@ mt76s_rx_run_queue(struct mt76_dev *dev, enum mt76_rxq_id qid,
 	struct mt76_sdio *sdio = &dev->sdio;
 	int len = 0, err, i;
 	struct page *page;
-	u8 *buf;
+	u8 *buf, *end;
 
 	for (i = 0; i < intr->rx.num[qid]; i++)
 		len += round_up(intr->rx.len[qid][i] + 4, 4);
@@ -112,20 +112,29 @@ mt76s_rx_run_queue(struct mt76_dev *dev, enum mt76_rxq_id qid,
 		return err;
 	}
 
-	for (i = 0; i < intr->rx.num[qid]; i++) {
+	end = buf + len;
+	i = 0;
+
+	while (i < intr->rx.num[qid] && buf < end) {
 		int index = (q->head + i) % q->ndesc;
 		struct mt76_queue_entry *e = &q->entry[index];
 		__le32 *rxd = (__le32 *)buf;
 
 		/* parse rxd to get the actual packet length */
 		len = le32_get_bits(rxd[0], GENMASK(15, 0));
-		e->skb = mt76s_build_rx_skb(buf, len, round_up(len + 4, 4));
-		if (!e->skb)
-			break;
 
+		/* Optimized path for TXS */
+		if (!dev->drv->rx_check || dev->drv->rx_check(dev, buf, len)) {
+			e->skb = mt76s_build_rx_skb(buf, len,
+						    round_up(len + 4, 4));
+			if (!e->skb)
+				break;
+
+			if (q->queued + i + 1 == q->ndesc)
+				break;
+			i++;
+		}
 		buf += round_up(len + 4, 4);
-		if (q->queued + i + 1 == q->ndesc)
-			break;
 	}
 	put_page(page);
 
-- 
2.36.1

