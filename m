Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCB24312413
	for <lists+linux-wireless@lfdr.de>; Sun,  7 Feb 2021 12:50:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbhBGLte (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 7 Feb 2021 06:49:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:34148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229681AbhBGLtV (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 7 Feb 2021 06:49:21 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id AB63064E40;
        Sun,  7 Feb 2021 11:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612698520;
        bh=w/mIgUYWtnaVsHbnu+zkFd2Mui3g5R3DriFeAuXMp7w=;
        h=From:To:Cc:Subject:Date:From;
        b=bpRSQ3KUneRnJx3ek/e7hRi+9ivth/iDGAPK7js0Q+VSDGPpI6u1ExBY9cONpGvbP
         605yOMT5AM3ueTHQHZ5wtFMQmpFXDnsJPNVekJUN5jpePyxzjMr6uYOOzcRpQTJqIM
         sIZ1iVTNBwmkHbSSgvOlZ6XCacRFvfm3WBMKt1CHGZEh+y2sRfTNybyi4Ybb3W5IeU
         3aApqhWNcNWSZ3Fewb8+XmHdi36ijkwO/mtCjdLtSBljk1qa96jIFg2ixVDpbenjx5
         rcv87WRNZBpviBo+daOp+hS0kWhqEwLO5WfDnrua9Fr5YqLZ+LgjEiPFpXi7FFM840
         xbvVhNlnAK4+g==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     linux-wireless@vger.kernel.org
Cc:     kvalo@codeaurora.org, kuba@kernel.org, nbd@nbd.name,
        lorenzo.bianconi@redhat.com
Subject: [PATCH wireless-drivers] mt76: dma: do not report truncated frames to mac80211
Date:   Sun,  7 Feb 2021 12:48:31 +0100
Message-Id: <a03166fcc8214644333c68674a781836e0f57576.1612697217.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

If the fragment is discarded in mt76_add_fragment() since shared_info
frag array is full, discard truncated frames and do not forward them to
mac80211.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/dma.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wireless/mediatek/mt76/dma.c
index e81dfaf99bcb..9bf13994c036 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/dma.c
@@ -511,13 +511,13 @@ mt76_add_fragment(struct mt76_dev *dev, struct mt76_queue *q, void *data,
 {
 	struct sk_buff *skb = q->rx_head;
 	struct skb_shared_info *shinfo = skb_shinfo(skb);
+	int nr_frags = shinfo->nr_frags;
 
-	if (shinfo->nr_frags < ARRAY_SIZE(shinfo->frags)) {
+	if (nr_frags < ARRAY_SIZE(shinfo->frags)) {
 		struct page *page = virt_to_head_page(data);
 		int offset = data - page_address(page) + q->buf_offset;
 
-		skb_add_rx_frag(skb, shinfo->nr_frags, page, offset, len,
-				q->buf_size);
+		skb_add_rx_frag(skb, nr_frags, page, offset, len, q->buf_size);
 	} else {
 		skb_free_frag(data);
 	}
@@ -526,7 +526,10 @@ mt76_add_fragment(struct mt76_dev *dev, struct mt76_queue *q, void *data,
 		return;
 
 	q->rx_head = NULL;
-	dev->drv->rx_skb(dev, q - dev->q_rx, skb);
+	if (nr_frags < ARRAY_SIZE(shinfo->frags))
+		dev->drv->rx_skb(dev, q - dev->q_rx, skb);
+	else
+		dev_kfree_skb(skb);
 }
 
 static int
-- 
2.29.2

