Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6513565F2B3
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Jan 2023 18:30:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234822AbjAERa6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 Jan 2023 12:30:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234360AbjAERa5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 Jan 2023 12:30:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8226012AC0
        for <linux-wireless@vger.kernel.org>; Thu,  5 Jan 2023 09:30:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1BE9761BB9
        for <linux-wireless@vger.kernel.org>; Thu,  5 Jan 2023 17:30:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DC40C433D2;
        Thu,  5 Jan 2023 17:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672939855;
        bh=6LlaLFbcaL5n7Zyj6ZzafyXC+04ZIaEJXvb8J9x+9mk=;
        h=From:To:Cc:Subject:Date:From;
        b=UTqJJfZvSSu5m2HqB5jgCos4xwooB12qVIlj23J4TCEu31lUBdEUVXMVf6deQfFV4
         7jEsVjKRQIEpgr7l0nBGefdS5FSsfQiESt0scELt5oEamfOJ3/E24qbPW/A0lGdQwu
         go173PyYCf5mj7TzyfN7WxMvkSWAWQmhmT4oEHNDDpqLlm4EUnheYfyRR0BvwfrBMy
         8Z1Csk4oeHj8hnL/g5o4e0oZup0vBk0di4iDCPHuDV5fFxaESm+tW/MAnKRLEC9SA3
         fWAcmF/zB5+0ERCUq8SwByriAmm8KyP6IvQu3tGCE5TgA/31d6ZUAqm/xqJHpBqYvt
         I/0Cqa1oIpkCA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        Sujuan Chen <sujuan.chen@mediatek.com>
Subject: [PATCH] wifi: mt76: mt7915: release rxwi in mt7915_wed_release_rx_buf
Date:   Thu,  5 Jan 2023 18:30:49 +0100
Message-Id: <ba4a2ece87a0ba6488b54118a9f3ba20aa7b920d.1672939797.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.39.0
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

Free rxwi cache releasing WED rx buffers in mt7915_wed_release_rx_buf
routine

Tested-by: Daniel Golle <daniel@makrotopia.org>
Co-developed-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Sujuan Chen <sujuan.chen@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/dma.c         | 3 ++-
 drivers/net/wireless/mediatek/mt76/mt76.h        | 1 +
 drivers/net/wireless/mediatek/mt76/mt7915/mmio.c | 2 ++
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wireless/mediatek/mt76/dma.c
index 2284ce4fd7cb..5629b949fac0 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/dma.c
@@ -165,7 +165,7 @@ mt76_free_pending_txwi(struct mt76_dev *dev)
 	local_bh_enable();
 }
 
-static void
+void
 mt76_free_pending_rxwi(struct mt76_dev *dev)
 {
 	struct mt76_txwi_cache *t;
@@ -178,6 +178,7 @@ mt76_free_pending_rxwi(struct mt76_dev *dev)
 	}
 	local_bh_enable();
 }
+EXPORT_SYMBOL_GPL(mt76_free_pending_rxwi);
 
 static void
 mt76_dma_sync_idx(struct mt76_dev *dev, struct mt76_queue *q)
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 7c3036eea3f8..9037780f9e88 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -1268,6 +1268,7 @@ mt76_tx_status_get_hw(struct mt76_dev *dev, struct sk_buff *skb)
 void mt76_put_txwi(struct mt76_dev *dev, struct mt76_txwi_cache *t);
 void mt76_put_rxwi(struct mt76_dev *dev, struct mt76_txwi_cache *t);
 struct mt76_txwi_cache *mt76_get_rxwi(struct mt76_dev *dev);
+void mt76_free_pending_rxwi(struct mt76_dev *dev);
 void mt76_rx_complete(struct mt76_dev *dev, struct sk_buff_head *frames,
 		      struct napi_struct *napi);
 void mt76_rx_poll_complete(struct mt76_dev *dev, enum mt76_rxq_id q,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
index c0e7b30dfd48..76de0ca22c2a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
@@ -612,6 +612,8 @@ static void mt7915_mmio_wed_release_rx_buf(struct mtk_wed_device *wed)
 
 		mt76_put_rxwi(&dev->mt76, t);
 	}
+
+	mt76_free_pending_rxwi(&dev->mt76);
 }
 
 static u32 mt7915_mmio_wed_init_rx_buf(struct mtk_wed_device *wed, int size)
-- 
2.39.0

