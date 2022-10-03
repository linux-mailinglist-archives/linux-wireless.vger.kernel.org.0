Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02C585F2E61
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Oct 2022 11:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbiJCJqR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 3 Oct 2022 05:46:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbiJCJpz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 3 Oct 2022 05:45:55 -0400
Received: from nbd.name (nbd.name [46.4.11.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D19BE52820
        for <linux-wireless@vger.kernel.org>; Mon,  3 Oct 2022 02:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
        s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=s0uRK9re9MEqKxFEzmqpwuLwIGA3bf7xCrXNAQx29PA=; b=F9fcRPaIHyXewg1SpHOQGQhJ2R
        qumIWgVJUcTDzG+dbYw5gYAxw7Pt1JuXQqIeXxlfvq2KAmnC4psvYkBXlNeFnHYnraDzXvJBY5tNL
        XLHT85TeLDaiJyMmkLb5Qzxur7n0NjfE4FMdMSPZP3jdwJhHI2VAEKJgXJIqWBNNB6t4=;
Received: from p200300daa7301d00d4086823c46c59c0.dip0.t-ipconnect.de ([2003:da:a730:1d00:d408:6823:c46c:59c0] helo=Maecks.lan)
        by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
        (Exim 4.94.2)
        (envelope-from <nbd@nbd.name>)
        id 1ofHnz-009qu9-6J
        for linux-wireless@vger.kernel.org; Mon, 03 Oct 2022 11:32:07 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 2/4] wifi: mt76: dma: add support for mapping skb fragments
Date:   Mon,  3 Oct 2022 11:32:04 +0200
Message-Id: <20221003093206.86323-2-nbd@nbd.name>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221003093206.86323-1-nbd@nbd.name>
References: <20221003093206.86323-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Only supported for skbs without frag_list. This is needed to support
scatter/gather for packets on WLAN devices with A-MSDU offload

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/dma.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wireless/mediatek/mt76/dma.c
index 4901aa02b4fb..ceb63b3aaced 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/dma.c
@@ -359,12 +359,17 @@ mt76_dma_tx_queue_skb(struct mt76_dev *dev, struct mt76_queue *q,
 		.skb = skb,
 	};
 	struct ieee80211_hw *hw;
-	int len, n = 0, ret = -ENOMEM;
+	int len, i, n = 0, ret = -ENOMEM;
 	struct mt76_txwi_cache *t;
 	struct sk_buff *iter;
 	dma_addr_t addr;
 	u8 *txwi;
 
+	if (skb_shinfo(skb)->nr_frags &&
+	    skb_shinfo(skb)->nr_frags + 1 > dev->hw->max_tx_fragments &&
+	    skb_linearize(skb))
+		goto free_skb;
+
 	t = mt76_get_txwi(dev);
 	if (!t)
 		goto free_skb;
@@ -385,6 +390,22 @@ mt76_dma_tx_queue_skb(struct mt76_dev *dev, struct mt76_queue *q,
 	tx_info.buf[n].addr = addr;
 	tx_info.buf[n++].len = len;
 
+	for (i = 0; i < skb_shinfo(skb)->nr_frags; i++) {
+		skb_frag_t *frag = &skb_shinfo(skb)->frags[i];
+
+		if (n == ARRAY_SIZE(tx_info.buf))
+			goto unmap;
+
+		len = skb_frag_size(frag);
+		addr = skb_frag_dma_map(dev->dma_dev, frag, 0, len,
+					DMA_TO_DEVICE);
+		if (unlikely(dma_mapping_error(dev->dma_dev, addr)))
+			goto unmap;
+
+		tx_info.buf[n].addr = addr;
+		tx_info.buf[n++].len = len;
+	}
+
 	skb_walk_frags(skb, iter) {
 		if (n == ARRAY_SIZE(tx_info.buf))
 			goto unmap;
-- 
2.36.1

