Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9BB342A4B1
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Oct 2021 14:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236600AbhJLMkH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 12 Oct 2021 08:40:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:60012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236593AbhJLMj2 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 12 Oct 2021 08:39:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DBC6160EBB;
        Tue, 12 Oct 2021 12:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634042243;
        bh=6gAXXY0rECVnmLTkUimoZ54V1p7R3BCw5vegAdwt2w8=;
        h=From:To:Cc:Subject:Date:From;
        b=frGtLUu7MO2UpEyApVkTc9wDQe3WXRQDUheb8f9FSb2d00A1BYznufI+LpHvbCWV3
         jGzoWuchSC2lfZjcp/oAn8jpPUuxm4FlldIjCsYeUU0qq9ss1oOF6ii+WRcluP3Iqm
         R/0k+xNTqt/cGNjSBB6UnKLyuA5m3bLNUyDtgPw2sqBjTC6eZUT1KMpXv7T8Nt/a7g
         D3hOupXOEoOtu8llwtXx3ofXe1JOjHNEHjgzyZFVPTjdb2XHnwVA7AGVhEDRiGffYj
         zLBzfymopzLIQ/2lQBGNd2EY9JJPBRo6BTlAK8bM9+d/by4p6WQg0WTzn/mV5wXMbg
         Gr5+JC7ETUHXw==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com
Subject: [PATCH] mt76: avoid possible infinite loop in mt76_tx_status_check
Date:   Tue, 12 Oct 2021 14:37:11 +0200
Message-Id: <4c41c277035d9e955b1f9e8ad0f2d98971f98289.1634042187.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Do not check status timestamp before DMA completion.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/tx.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/tx.c b/drivers/net/wireless/mediatek/mt76/tx.c
index 1c4e6e4fa8fc..11719ef034d8 100644
--- a/drivers/net/wireless/mediatek/mt76/tx.c
+++ b/drivers/net/wireless/mediatek/mt76/tx.c
@@ -169,9 +169,14 @@ mt76_tx_status_skb_get(struct mt76_dev *dev, struct mt76_wcid *wcid, int pktid,
 	idr_for_each_entry(&wcid->pktid, skb, id) {
 		struct mt76_tx_cb *cb = mt76_tx_skb_cb(skb);
 
-		if (pktid >= 0 && !time_after(jiffies, cb->jiffies +
-					      MT_TX_STATUS_SKB_TIMEOUT))
-			continue;
+		if (pktid >= 0) {
+			if (!(cb->flags & MT_TX_CB_DMA_DONE))
+				continue;
+
+			if (!time_is_after_jiffies(cb->jiffies +
+						   MT_TX_STATUS_SKB_TIMEOUT))
+				continue;
+		}
 
 		/* It has been too long since DMA_DONE, time out this packet
 		 * and stop waiting for TXS callback.
@@ -192,15 +197,12 @@ EXPORT_SYMBOL_GPL(mt76_tx_status_skb_get);
 void
 mt76_tx_status_check(struct mt76_dev *dev, bool flush)
 {
+	struct mt76_wcid *wcid, *tmp;
 	struct sk_buff_head list;
-	struct mt76_wcid *wcid;
 
 	mt76_tx_status_lock(dev, &list);
-	while (!list_empty(&dev->wcid_list)) {
-		wcid = list_first_entry(&dev->wcid_list, struct mt76_wcid,
-					list);
+	list_for_each_entry_safe(wcid, tmp, &dev->wcid_list, list)
 		mt76_tx_status_skb_get(dev, wcid, flush ? -1 : 0, &list);
-	}
 	mt76_tx_status_unlock(dev, &list);
 }
 EXPORT_SYMBOL_GPL(mt76_tx_status_check);
-- 
2.31.1

