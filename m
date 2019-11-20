Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CBBC103906
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Nov 2019 12:46:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728308AbfKTLqt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 Nov 2019 06:46:49 -0500
Received: from nbd.name ([46.4.11.11]:53566 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727934AbfKTLqt (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 Nov 2019 06:46:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=vs+jdvwIQor/Cu4wu979kFaF7syA3FMgi9ouPtqV9Aw=; b=NJev6GgvqDd0bmflvlGSo85Mze
        rTRHdVKgQElUQeStufpc1I8LviE2riHpf8zSogKRF9Km+MyFbjMzSXRkoR+G7T+Vh4dvzi8KkoFPU
        3sp2aKnTFkjusdJeTq5Do/Gw/l02XbuJ23SvyoZLRMar/8COsKNL4wfw3pQX9gmOlGgQ=;
Received: from p4ff13fe7.dip0.t-ipconnect.de ([79.241.63.231] helo=maeck.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1iXORc-0006fj-7Z; Wed, 20 Nov 2019 12:46:48 +0100
Received: by maeck.local (Postfix, from userid 501)
        id B886470ED734; Wed, 20 Nov 2019 12:46:47 +0100 (CET)
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     Markus Theil <markus.theil@tu-ilmenau.de>
Subject: [PATCH] mt76: use rcu_read_lock_bh in mt76_dma_rx_poll
Date:   Wed, 20 Nov 2019 12:46:47 +0100
Message-Id: <20191120114647.88967-1-nbd@nbd.name>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fixes potential RCU issues and avoids calling ieee80211_rx_napi with softirq
enabled.

Reported-by: Markus Theil <markus.theil@tu-ilmenau.de>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/dma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wireless/mediatek/mt76/dma.c
index 6173c80189ba..ed0ee2d4a452 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/dma.c
@@ -528,7 +528,7 @@ mt76_dma_rx_poll(struct napi_struct *napi, int budget)
 	dev = container_of(napi->dev, struct mt76_dev, napi_dev);
 	qid = napi - dev->napi;
 
-	rcu_read_lock();
+	rcu_read_lock_bh();
 
 	do {
 		cur = mt76_dma_rx_process(dev, &dev->q_rx[qid], budget - done);
@@ -536,7 +536,7 @@ mt76_dma_rx_poll(struct napi_struct *napi, int budget)
 		done += cur;
 	} while (cur && done < budget);
 
-	rcu_read_unlock();
+	rcu_read_unlock_bh();
 
 	if (done < budget && napi_complete(napi))
 		dev->drv->rx_poll_complete(dev, qid);
-- 
2.24.0

