Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7546303B05
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Jan 2021 12:03:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404786AbhAZLDJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 26 Jan 2021 06:03:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:35818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404774AbhAZLDF (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 26 Jan 2021 06:03:05 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5A3E423104;
        Tue, 26 Jan 2021 11:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611658945;
        bh=cuf+7kki04NnMhtDTTOevd4ortyvy8aAh/LrEWAERVc=;
        h=From:To:Cc:Subject:Date:From;
        b=dGtoip9HJAD1+QL2NOncQ4BFY0MtNeUhLiih1izREzeRpN4i2FhAJAzYEf/kumlko
         7nULR6UaVaHfpzINWDUc/DaOif6T5Sv+WbuoRua9TX73jD8+13xlZJmQ4HdxcqaCOk
         aq6qF6fGefP6IhdavEpo9lUcaCWUkEbHrtIUim0FcICwINPsi2sfgKuQh/wIEJQegv
         QV8dfgmLXydHu3gxfBUetsswALjCnVWjHNHuy3znKyso1JAUu0IhUonXWVlHslSVnM
         p5PPn8I00sf/Fh+BbrWob1Ti0oxtZddAdb6xwqAav0HsDMXGBzThWgzAw14jgTtjFC
         DsyJYcX0CMVbA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     linux-wireless@vger.kernel.org
Cc:     nbd@nbd.name, lorenzo.bianconi@redhat.com
Subject: [PATCH wireless-drivers] mt76: dma: fix a possible memory leak in mt76_add_fragment()
Date:   Tue, 26 Jan 2021 12:02:13 +0100
Message-Id: <4f9dd73407da88b2a552517ce8db242d86bf4d5c.1611616130.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fix a memory leak in mt76_add_fragment routine returning the buffer
to the page_frag_cache when we receive a new fragment and the
skb_shared_info frag array is full.

Fixes: b102f0c522cf6 ("mt76: fix array overflow on receiving too many fragments for a packet")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/dma.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wireless/mediatek/mt76/dma.c
index 73eeb00d5aa6..e81dfaf99bcb 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/dma.c
@@ -509,15 +509,17 @@ static void
 mt76_add_fragment(struct mt76_dev *dev, struct mt76_queue *q, void *data,
 		  int len, bool more)
 {
-	struct page *page = virt_to_head_page(data);
-	int offset = data - page_address(page);
 	struct sk_buff *skb = q->rx_head;
 	struct skb_shared_info *shinfo = skb_shinfo(skb);
 
 	if (shinfo->nr_frags < ARRAY_SIZE(shinfo->frags)) {
-		offset += q->buf_offset;
+		struct page *page = virt_to_head_page(data);
+		int offset = data - page_address(page) + q->buf_offset;
+
 		skb_add_rx_frag(skb, shinfo->nr_frags, page, offset, len,
 				q->buf_size);
+	} else {
+		skb_free_frag(data);
 	}
 
 	if (more)
-- 
2.29.2

