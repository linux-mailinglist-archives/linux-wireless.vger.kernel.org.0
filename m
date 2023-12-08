Return-Path: <linux-wireless+bounces-577-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5299E809D77
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Dec 2023 08:50:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 717B6281324
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Dec 2023 07:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C46810799;
	Fri,  8 Dec 2023 07:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="t1XNMtXV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE4E1171D
	for <linux-wireless@vger.kernel.org>; Thu,  7 Dec 2023 23:50:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=WaPY37g2MdrutFqCtl5rIs7+qSY6aElsb8Bepft1saQ=; b=t1XNMtXVz/GgheQBqxVYsPehEk
	+E1ClrwF0IWn/g+++TOMTxfsfg8fW310TbNjNSpGY8yrj1M/Wny3Gu9yONJG2hFE1T7k0/zT9sXkB
	73IfpVIoqQTsMSirJcwit3ZI4PmWIVwpEy9sTFlBOeKwukbdbAts0P8Fa/5e7oTVJTvE=;
Received: from p4ff13178.dip0.t-ipconnect.de ([79.241.49.120] helo=localhost.localdomain)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.94.2)
	(envelope-from <nbd@nbd.name>)
	id 1rBVcb-00ATNk-Im; Fri, 08 Dec 2023 08:50:05 +0100
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Cc: kvalo@kernel.org
Subject: [PATCH wireless] wifi: mt76: fix crash with WED rx support enabled
Date: Fri,  8 Dec 2023 08:50:04 +0100
Message-ID: <20231208075004.69843-1-nbd@nbd.name>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If WED rx is enabled, rx buffers are added to a buffer pool that can be
filled from multiple page pools. Because buffers freed from rx poll are
not guaranteed to belong to the processed queue's page pool, lockless
caching must not be used in this case.

Cc: stable@vger.kernel.org
Fixes: 2f5c3c77fc9b ("wifi: mt76: switch to page_pool allocator")
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/dma.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wireless/mediatek/mt76/dma.c
index 511fe7e6e744..68ad915203aa 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/dma.c
@@ -783,7 +783,7 @@ mt76_dma_rx_reset(struct mt76_dev *dev, enum mt76_rxq_id qid)
 
 static void
 mt76_add_fragment(struct mt76_dev *dev, struct mt76_queue *q, void *data,
-		  int len, bool more, u32 info)
+		  int len, bool more, u32 info, bool allow_direct)
 {
 	struct sk_buff *skb = q->rx_head;
 	struct skb_shared_info *shinfo = skb_shinfo(skb);
@@ -795,7 +795,7 @@ mt76_add_fragment(struct mt76_dev *dev, struct mt76_queue *q, void *data,
 
 		skb_add_rx_frag(skb, nr_frags, page, offset, len, q->buf_size);
 	} else {
-		mt76_put_page_pool_buf(data, true);
+		mt76_put_page_pool_buf(data, allow_direct);
 	}
 
 	if (more)
@@ -815,6 +815,7 @@ mt76_dma_rx_process(struct mt76_dev *dev, struct mt76_queue *q, int budget)
 	struct sk_buff *skb;
 	unsigned char *data;
 	bool check_ddone = false;
+	bool allow_direct = !mt76_queue_is_wed_rx(q);
 	bool more;
 
 	if (IS_ENABLED(CONFIG_NET_MEDIATEK_SOC_WED) &&
@@ -855,7 +856,8 @@ mt76_dma_rx_process(struct mt76_dev *dev, struct mt76_queue *q, int budget)
 		}
 
 		if (q->rx_head) {
-			mt76_add_fragment(dev, q, data, len, more, info);
+			mt76_add_fragment(dev, q, data, len, more, info,
+					  allow_direct);
 			continue;
 		}
 
@@ -884,7 +886,7 @@ mt76_dma_rx_process(struct mt76_dev *dev, struct mt76_queue *q, int budget)
 		continue;
 
 free_frag:
-		mt76_put_page_pool_buf(data, true);
+		mt76_put_page_pool_buf(data, allow_direct);
 	}
 
 	mt76_dma_rx_fill(dev, q, true);
-- 
2.41.0


