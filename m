Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E121740882A
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Sep 2021 11:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238359AbhIMJ1B (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Sep 2021 05:27:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:47246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238559AbhIMJ06 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Sep 2021 05:26:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 07AA961004;
        Mon, 13 Sep 2021 09:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631525143;
        bh=gOpuIFBFT7fOUVPP6iswy5tPeqleK2sLXHLeElsl86Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vFUWrhF0d1Aek0CbqcSWJRqet3B5uzwjPvF503chvr61xhK4MAwMnRmQ2R+TzxyUp
         dtZMT3QnWSsrOILeJMeACrBJ3ShVTlt/4HFfnBO3y3bTX5+FSjaMhKN+EGtjKT1j4u
         ldCKqF+3wQq+JoQxaFaSU1PnZ2elhr+21pB0cKJiPPGPgTgOeBnaedriatwFZEY3yO
         R5FxD45MG57LPwxdlcEO8V5EOuf4m4UKm+wG5sXFuvPCTLWY7UOEIkIizBZYkQjs6p
         H2uPRuPw0/dy9fg+1NNA/kceX11i8TCIkySivWhr6oh3A+U3d/Vk9noeoqqRWKgVZ9
         ZK7lG/2G0LpAA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        greearb@candelatech.com, mrkiko.rs@gmail.com
Subject: [PATCH 4/4] mt76: schedule status timeout at dma completion
Date:   Mon, 13 Sep 2021 11:25:05 +0200
Message-Id: <8abf95f745bbd53106395891ab431e3d172f9dff.1631525026.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1631525026.git.lorenzo@kernel.org>
References: <cover.1631525026.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Reduce MT_TX_STATUS_SKB_TIMEOUT to 250ms

Tested-by: mrkiko.rs@gmail.com
Co-developed-by: Ben Greear <greearb@candelatech.com>
Signed-off-by: Ben Greear <greearb@candelatech.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76.h | 9 +++++++--
 drivers/net/wireless/mediatek/mt76/tx.c   | 5 ++++-
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index bb3f7314fcf2..e76fb04de047 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -308,8 +308,13 @@ struct mt76_rx_tid {
 #define MT_PACKET_ID_NO_SKB		1
 #define MT_PACKET_ID_FIRST		2
 #define MT_PACKET_ID_HAS_RATE		BIT(7)
-
-#define MT_TX_STATUS_SKB_TIMEOUT	HZ
+/* This is timer for when to give up when waiting for TXS callback,
+ * with starting time being the time at which the DMA_DONE callback
+ * was seen (so, we know packet was processed then, it should not take
+ * long after that for firmware to send the TXS callback if it is going
+ * to do so.)
+ */
+#define MT_TX_STATUS_SKB_TIMEOUT	(HZ / 4)
 
 struct mt76_tx_cb {
 	unsigned long jiffies;
diff --git a/drivers/net/wireless/mediatek/mt76/tx.c b/drivers/net/wireless/mediatek/mt76/tx.c
index aca41468cd75..1c4e6e4fa8fc 100644
--- a/drivers/net/wireless/mediatek/mt76/tx.c
+++ b/drivers/net/wireless/mediatek/mt76/tx.c
@@ -141,7 +141,6 @@ mt76_tx_status_skb_add(struct mt76_dev *dev, struct mt76_wcid *wcid,
 
 	cb->wcid = wcid->idx;
 	cb->pktid = pid;
-	cb->jiffies = jiffies;
 
 	if (list_empty(&wcid->list))
 		list_add_tail(&wcid->list, &dev->wcid_list);
@@ -174,6 +173,9 @@ mt76_tx_status_skb_get(struct mt76_dev *dev, struct mt76_wcid *wcid, int pktid,
 					      MT_TX_STATUS_SKB_TIMEOUT))
 			continue;
 
+		/* It has been too long since DMA_DONE, time out this packet
+		 * and stop waiting for TXS callback.
+		 */
 		idr_remove(&wcid->pktid, cb->pktid);
 		__mt76_tx_status_skb_done(dev, skb, MT_TX_CB_TXS_FAILED |
 						    MT_TX_CB_TXS_DONE, list);
@@ -259,6 +261,7 @@ void __mt76_tx_complete_skb(struct mt76_dev *dev, u16 wcid_idx, struct sk_buff *
 	}
 
 	mt76_tx_status_lock(dev, &list);
+	cb->jiffies = jiffies;
 	__mt76_tx_status_skb_done(dev, skb, MT_TX_CB_DMA_DONE, &list);
 	mt76_tx_status_unlock(dev, &list);
 
-- 
2.31.1

