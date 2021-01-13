Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C63AC2F554E
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Jan 2021 00:52:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727879AbhAMXvf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Jan 2021 18:51:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:55018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729617AbhAMXuZ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Jan 2021 18:50:25 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D0DAB2336F;
        Wed, 13 Jan 2021 23:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610580394;
        bh=EIGGKIkAWvCzZCUyzQrQta5h/2opmHIrNQXss0JIFKU=;
        h=From:To:Cc:Subject:Date:From;
        b=c7Gw4UbOP5ZMVPbbgqgNx6F8G5gZtRIbDqbmy2VFYCkZ5bzAR0yGJpL+7FM7U/1Mv
         FzmG5pqk9+D1+BExEsa9ECS/S4VOPTg4gUwf2+9N3iU6tsRb0GDmwL1isvC4bsDY/5
         3Y+73s3L/H7iAj3POHxko9rDquOi+5Qq9JxAdHoygySTiF0AH6GcPhqdajMw1/wBug
         gIAfHNGSOf7FfOBr5mxJJEwzmNaIOl9lP6IBjHHYa9zZQYFZeqZQO1eaWL8Y3XgDmj
         nmu+79ZOISA77XCS82Skb8nOiQWNvHGDbceKdKXJ9yqmro5UH+bawQWyhCss83VqsT
         d/lip/MOUXFrw==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     linux-wireless@vger.kernel.org
Cc:     lorenzo.bianconi@redhat.com, kuba@kernel.org
Subject: [PATCH] mt7601u: use ieee80211_rx_list to pass frames to the network stack as a batch
Date:   Thu, 14 Jan 2021 00:26:26 +0100
Message-Id: <5c72fa2dda45c1ae3f285af80c02f3db23341d85.1610580222.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Similar to mt76 driver, rely on ieee80211_rx_list in order to
improve icache footprint

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt7601u/dma.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt7601u/dma.c b/drivers/net/wireless/mediatek/mt7601u/dma.c
index 5f99054f535b..e0f96c64aab3 100644
--- a/drivers/net/wireless/mediatek/mt7601u/dma.c
+++ b/drivers/net/wireless/mediatek/mt7601u/dma.c
@@ -74,7 +74,8 @@ mt7601u_rx_skb_from_seg(struct mt7601u_dev *dev, struct mt7601u_rxwi *rxwi,
 }
 
 static void mt7601u_rx_process_seg(struct mt7601u_dev *dev, u8 *data,
-				   u32 seg_len, struct page *p)
+				   u32 seg_len, struct page *p,
+				   struct list_head *list)
 {
 	struct sk_buff *skb;
 	struct mt7601u_rxwi *rxwi;
@@ -104,9 +105,13 @@ static void mt7601u_rx_process_seg(struct mt7601u_dev *dev, u8 *data,
 	if (!skb)
 		return;
 
-	spin_lock(&dev->mac_lock);
-	ieee80211_rx(dev->hw, skb);
-	spin_unlock(&dev->mac_lock);
+	local_bh_disable();
+	rcu_read_lock();
+
+	ieee80211_rx_list(dev->hw, NULL, skb, list);
+
+	rcu_read_unlock();
+	local_bh_enable();
 }
 
 static u16 mt7601u_rx_next_seg_len(u8 *data, u32 data_len)
@@ -130,6 +135,7 @@ mt7601u_rx_process_entry(struct mt7601u_dev *dev, struct mt7601u_dma_buf_rx *e)
 	u32 seg_len, data_len = e->urb->actual_length;
 	u8 *data = page_address(e->p);
 	struct page *new_p = NULL;
+	LIST_HEAD(list);
 	int cnt = 0;
 
 	if (!test_bit(MT7601U_STATE_INITIALIZED, &dev->state))
@@ -140,7 +146,8 @@ mt7601u_rx_process_entry(struct mt7601u_dev *dev, struct mt7601u_dma_buf_rx *e)
 		new_p = dev_alloc_pages(MT_RX_ORDER);
 
 	while ((seg_len = mt7601u_rx_next_seg_len(data, data_len))) {
-		mt7601u_rx_process_seg(dev, data, seg_len, new_p ? e->p : NULL);
+		mt7601u_rx_process_seg(dev, data, seg_len,
+				       new_p ? e->p : NULL, &list);
 
 		data_len -= seg_len;
 		data += seg_len;
@@ -150,6 +157,8 @@ mt7601u_rx_process_entry(struct mt7601u_dev *dev, struct mt7601u_dma_buf_rx *e)
 	if (cnt > 1)
 		trace_mt_rx_dma_aggr(dev, cnt, !!new_p);
 
+	netif_receive_skb_list(&list);
+
 	if (new_p) {
 		/* we have one extra ref from the allocator */
 		__free_pages(e->p, MT_RX_ORDER);
-- 
2.29.2

