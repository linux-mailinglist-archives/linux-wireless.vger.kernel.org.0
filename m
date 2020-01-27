Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CAC0614A9B0
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Jan 2020 19:18:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbgA0SR7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 27 Jan 2020 13:17:59 -0500
Received: from nbd.name ([46.4.11.11]:48202 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725828AbgA0SR5 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 27 Jan 2020 13:17:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=eLDODatZtz3DibR6RyYo6On5K5gCqCGQNsdvzDgNKv8=; b=BSxxQ24Ec7YP5qyraSgIZ/2gMC
        ZW8Fq4L4b3CKIVgNgkk+QSUCF2jXSQFOpKHANmlLux8xtv2BoG4MSs8CpDBG0Xk9gmQ8IOW7AY3gV
        eSkfmUjboEGU9+9OCztxZPA7H9ViQgrbJZPjEORbUXbjZY7fW0AJ3kmh+8PEeFQ0nlxc=;
Received: from [178.162.209.132] (helo=maeck.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1iw8xP-0007db-Ju
        for linux-wireless@vger.kernel.org; Mon, 27 Jan 2020 19:17:55 +0100
Received: by maeck.local (Postfix, from userid 501)
        id 2003D7A566E3; Mon, 27 Jan 2020 19:17:54 +0100 (CET)
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 1/5] mt76: set dma-done flag for flushed descriptors
Date:   Mon, 27 Jan 2020 19:17:50 +0100
Message-Id: <20200127181754.2810-1-nbd@nbd.name>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Avoids a theoretical corner case where the hardware could try to process
a stale descriptor after a watchdog reset

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/dma.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wireless/mediatek/mt76/dma.c
index 9e03a7871ff4..e69329feed78 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/dma.c
@@ -246,7 +246,9 @@ mt76_dma_dequeue(struct mt76_dev *dev, struct mt76_queue *q, bool flush,
 	if (!q->queued)
 		return NULL;
 
-	if (!flush && !(q->desc[idx].ctrl & cpu_to_le32(MT_DMA_CTL_DMA_DONE)))
+	if (flush)
+		q->desc[idx].ctrl |= cpu_to_le32(MT_DMA_CTL_DMA_DONE);
+	else if (!(q->desc[idx].ctrl & cpu_to_le32(MT_DMA_CTL_DMA_DONE)))
 		return NULL;
 
 	q->tail = (q->tail + 1) % q->ndesc;
-- 
2.24.0

