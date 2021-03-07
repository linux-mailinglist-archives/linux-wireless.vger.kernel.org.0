Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE873303E5
	for <lists+linux-wireless@lfdr.de>; Sun,  7 Mar 2021 19:22:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231301AbhCGSVo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 7 Mar 2021 13:21:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:35626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231256AbhCGSVP (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 7 Mar 2021 13:21:15 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id AE44065186;
        Sun,  7 Mar 2021 18:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615141274;
        bh=ZCRs96IoO+0FYjfIQJvOiLqGzxAiya0Hja58V6lYoto=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QnQ2rQ4LdAWm8BeeaJBG9aQgQv9h7fuoS5XXaHOWWLPV9zYlZoCLNqvlZnpWtBNbe
         +G1izOt7yROMkNUYu9nX4nGT3IxaBrETsfaCqw/e/SbiveaU97WriwQ3jpnaGcGSEA
         S5a02gmo5DjpvCzs5mKRLf7dBUUcD0S0E3au42h6IdkwlfBwNDFRQG4RAyS2aiBFvC
         k58dloMfyJ0xpa2NEh9XfrKsYkDmIPLaSG9ofs9k29SIrvlPLgl8bGcT71GlcnUfoS
         dTqVvuHmlDZGNBog2aCfv1he/RdTpUJgpz8vugrLsQ5ki5y9+iSsVUrazFRa0Z1+bt
         OEtPNL8Y9lITA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com
Subject: [PATCH 6/7] mt76: dma: export mt76_dma_rx_cleanup routine
Date:   Sun,  7 Mar 2021 19:20:50 +0100
Message-Id: <0896b4da443cb6b0a05c36b00270526b6316b349.1615140875.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1615140875.git.lorenzo@kernel.org>
References: <cover.1615140875.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Export mt76_dma_rx_cleanup routine in mt76_queue_ops data structure.
This is a preliminary patch to introduce mt7921 chip reset support.

Co-developed-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/dma.c  | 1 +
 drivers/net/wireless/mediatek/mt76/mt76.h | 5 ++++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wireless/mediatek/mt76/dma.c
index 82711d69ec94..6d85d8d20d59 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/dma.c
@@ -653,6 +653,7 @@ static const struct mt76_queue_ops mt76_dma_ops = {
 	.tx_queue_skb_raw = mt76_dma_tx_queue_skb_raw,
 	.tx_queue_skb = mt76_dma_tx_queue_skb,
 	.tx_cleanup = mt76_dma_tx_cleanup,
+	.rx_cleanup = mt76_dma_rx_cleanup,
 	.rx_reset = mt76_dma_rx_reset,
 	.kick = mt76_dma_kick_queue,
 };
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index f306a9c71ebf..28e53385884c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -191,6 +191,8 @@ struct mt76_queue_ops {
 	void (*tx_cleanup)(struct mt76_dev *dev, struct mt76_queue *q,
 			   bool flush);
 
+	void (*rx_cleanup)(struct mt76_dev *dev, struct mt76_queue *q);
+
 	void (*kick)(struct mt76_dev *dev, struct mt76_queue *q);
 
 	void (*reset_q)(struct mt76_dev *dev, struct mt76_queue *q);
@@ -794,7 +796,8 @@ static inline u16 mt76_rev(struct mt76_dev *dev)
 #define mt76_tx_queue_skb_raw(dev, ...)	(dev)->mt76.queue_ops->tx_queue_skb_raw(&((dev)->mt76), __VA_ARGS__)
 #define mt76_tx_queue_skb(dev, ...)	(dev)->mt76.queue_ops->tx_queue_skb(&((dev)->mt76), __VA_ARGS__)
 #define mt76_queue_rx_reset(dev, ...)	(dev)->mt76.queue_ops->rx_reset(&((dev)->mt76), __VA_ARGS__)
-#define mt76_queue_tx_cleanup(dev, ...)        (dev)->mt76.queue_ops->tx_cleanup(&((dev)->mt76), __VA_ARGS__)
+#define mt76_queue_tx_cleanup(dev, ...)	(dev)->mt76.queue_ops->tx_cleanup(&((dev)->mt76), __VA_ARGS__)
+#define mt76_queue_rx_cleanup(dev, ...)	(dev)->mt76.queue_ops->rx_cleanup(&((dev)->mt76), __VA_ARGS__)
 #define mt76_queue_kick(dev, ...)	(dev)->mt76.queue_ops->kick(&((dev)->mt76), __VA_ARGS__)
 #define mt76_queue_reset(dev, ...)	(dev)->mt76.queue_ops->reset_q(&((dev)->mt76), __VA_ARGS__)
 
-- 
2.29.2

