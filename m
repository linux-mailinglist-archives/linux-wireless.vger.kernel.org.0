Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64C58CE4C2
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Oct 2019 16:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727744AbfJGOKY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 7 Oct 2019 10:10:24 -0400
Received: from nbd.name ([46.4.11.11]:59048 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727753AbfJGOKY (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 7 Oct 2019 10:10:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=References:In-Reply-To:Message-Id:Date:Subject:To:From:Sender:
        Reply-To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=xF3Flvsmfw/oheWhqWYhUjltW7JsyPWc5Jh3nHC7f90=; b=J/aqNp1wtSL740BPLGcCISEZAg
        27Xw870HFC84T3mOrFsOFMttHeB2rxXw8YjqX9X51q4bSB48vH7r5IPyX6a8qlj0v7W5DJh+6JfI9
        iRgpJp/fAo2CoZLcsdVDb4j3bC+wkfWqUKD8fjvBgSJ+rmbrI8rvqtON4ZK/ChiVzRZI=;
Received: from p54ae9582.dip0.t-ipconnect.de ([84.174.149.130] helo=maeck.lan)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1iHTiQ-0002Wp-Tq
        for linux-wireless@vger.kernel.org; Mon, 07 Oct 2019 16:10:22 +0200
Received: by maeck.lan (Postfix, from userid 501)
        id 5AB906AB2C97; Mon,  7 Oct 2019 16:10:22 +0200 (CEST)
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 4/4] mt76: avoid enabling interrupt if NAPI poll is still pending
Date:   Mon,  7 Oct 2019 16:10:22 +0200
Message-Id: <20191007141022.75184-4-nbd@nbd.name>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20191007141022.75184-1-nbd@nbd.name>
References: <20191007141022.75184-1-nbd@nbd.name>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

if napi_complete() returns false, it means that polling is still pending.
Interrupts should not fire until the polling is no longer scheduled

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/dma.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wireless/mediatek/mt76/dma.c
index e2ce59b260c1..4da7cffbab29 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/dma.c
@@ -537,10 +537,8 @@ mt76_dma_rx_poll(struct napi_struct *napi, int budget)
 
 	rcu_read_unlock();
 
-	if (done < budget) {
-		napi_complete(napi);
+	if (done < budget && napi_complete(napi))
 		dev->drv->rx_poll_complete(dev, qid);
-	}
 
 	return done;
 }
-- 
2.17.0

