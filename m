Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E833E11ECF5
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Dec 2019 22:36:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbfLMVgb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Dec 2019 16:36:31 -0500
Received: from nbd.name ([46.4.11.11]:47436 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725554AbfLMVgb (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Dec 2019 16:36:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=8kKiKbay0/BtMJgH0ST9RsgMcmU7mr2IXgmzQiITx3c=; b=l4nt/bfX/VGQAuKAGo2bxByEEi
        BsD3F+9m4+PBzY7Xe+JYQ6kNUKKcIkt/xHOsgvGwLzztaTGirk2OixFlj4L7nzvivI0uE8ZWXt9+C
        jKnCP971xIapCvE6h8TfCbMTGtGAVFZd5YRy/eJ7OrTmFiz5TkZrx7vxH21uNy7voE2U=;
Received: from p4ff13e83.dip0.t-ipconnect.de ([79.241.62.131] helo=maeck.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1ifsbt-0001nW-LW
        for linux-wireless@vger.kernel.org; Fri, 13 Dec 2019 22:36:30 +0100
Received: by maeck.local (Postfix, from userid 501)
        id 2161473C113F; Fri, 13 Dec 2019 22:36:28 +0100 (CET)
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 4/4] mt76: disable bh in mt76_dma_rx_poll
Date:   Fri, 13 Dec 2019 22:36:28 +0100
Message-Id: <20191213213628.73840-4-nbd@nbd.name>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191213213628.73840-1-nbd@nbd.name>
References: <20191213213628.73840-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fixes potential RCU issues and avoids calling ieee80211_rx_napi with softirq
enabled.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/dma.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wireless/mediatek/mt76/dma.c
index 2298a4e91943..9e03a7871ff4 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/dma.c
@@ -538,6 +538,7 @@ mt76_dma_rx_poll(struct napi_struct *napi, int budget)
 	dev = container_of(napi->dev, struct mt76_dev, napi_dev);
 	qid = napi - dev->napi;
 
+	local_bh_disable();
 	rcu_read_lock();
 
 	do {
@@ -547,6 +548,7 @@ mt76_dma_rx_poll(struct napi_struct *napi, int budget)
 	} while (cur && done < budget);
 
 	rcu_read_unlock();
+	local_bh_enable();
 
 	if (done < budget && napi_complete(napi))
 		dev->drv->rx_poll_complete(dev, qid);
-- 
2.24.0

