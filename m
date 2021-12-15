Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D181475F7F
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Dec 2021 18:39:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234987AbhLORix (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Dec 2021 12:38:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234594AbhLORiw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Dec 2021 12:38:52 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1B41C06173E
        for <linux-wireless@vger.kernel.org>; Wed, 15 Dec 2021 09:38:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=PTtmBDxqnXiUaPJjsZlrf7O8JMGRO+xS/k9BBmp2hWY=; b=ARpHDG6dYVw92T/9hPJfpgdRUj
        6J/E7FWcz9mHLAOOrhnCbV+mu2u13oJRrV1Q/TR98gmiu/vCjSbUazB/pnyf/bL9qdA99bxOMxas4
        xyYdY8+I7g57VyrNICQ0RDnX1CTj1jBeusijMs5iCLr02dkLWTo7N5nz+XIh9XTHEE6o=;
Received: from p54ae911a.dip0.t-ipconnect.de ([84.174.145.26] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1mxYEr-0000He-Dx
        for linux-wireless@vger.kernel.org; Wed, 15 Dec 2021 18:38:49 +0100
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 1/3] mt76: allow drivers to drop rx packets early
Date:   Wed, 15 Dec 2021 18:38:37 +0100
Message-Id: <20211215173839.20853-1-nbd@nbd.name>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This can be used to free received events without allocating an extra skb

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/dma.c  | 19 ++++++++++++-------
 drivers/net/wireless/mediatek/mt76/mt76.h |  2 ++
 2 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wireless/mediatek/mt76/dma.c
index 5e1c1506a4c6..3a9af8931c35 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/dma.c
@@ -572,9 +572,7 @@ mt76_dma_rx_process(struct mt76_dev *dev, struct mt76_queue *q, int budget)
 		if (data_len < len + q->buf_offset) {
 			dev_kfree_skb(q->rx_head);
 			q->rx_head = NULL;
-
-			skb_free_frag(data);
-			continue;
+			goto free_frag;
 		}
 
 		if (q->rx_head) {
@@ -582,11 +580,14 @@ mt76_dma_rx_process(struct mt76_dev *dev, struct mt76_queue *q, int budget)
 			continue;
 		}
 
+		if (!more && dev->drv->rx_check &&
+		    !(dev->drv->rx_check(dev, data, len)))
+			goto free_frag;
+
 		skb = build_skb(data, q->buf_size);
-		if (!skb) {
-			skb_free_frag(data);
-			continue;
-		}
+		if (!skb)
+			goto free_frag;
+
 		skb_reserve(skb, q->buf_offset);
 
 		if (q == &dev->q_rx[MT_RXQ_MCU]) {
@@ -603,6 +604,10 @@ mt76_dma_rx_process(struct mt76_dev *dev, struct mt76_queue *q, int budget)
 		}
 
 		dev->drv->rx_skb(dev, q - dev->q_rx, skb);
+		continue;
+
+free_frag:
+		skb_free_frag(data);
 	}
 
 	mt76_dma_rx_fill(dev, q);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 239742112e16..8edbf42b4526 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -373,6 +373,8 @@ struct mt76_driver_ops {
 
 	bool (*tx_status_data)(struct mt76_dev *dev, u8 *update);
 
+	bool (*rx_check)(struct mt76_dev *dev, void *data, int len);
+
 	void (*rx_skb)(struct mt76_dev *dev, enum mt76_rxq_id q,
 		       struct sk_buff *skb);
 
-- 
2.34.1

