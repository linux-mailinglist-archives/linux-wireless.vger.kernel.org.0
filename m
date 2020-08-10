Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7DB12403B5
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Aug 2020 10:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbgHJI6k (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 10 Aug 2020 04:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726597AbgHJI6h (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 10 Aug 2020 04:58:37 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33452C06178B
        for <linux-wireless@vger.kernel.org>; Mon, 10 Aug 2020 01:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=H44c2BMdG1DEMo5nQoHrKZGUmCSWvhrzgn3Sgl6l5dU=; b=k7wwAZZCsLQYzbNRHgxWHnOGnJ
        Dm7xDk2ne0zgchoJN+32WofEgr89BXGid3oKzREaefOWMNIG+OpdDhXdOVYKiZDnEVpomt1dCPBIF
        W+2Ekpo8SuICn68LPqiYPUsSvhxRBq/QhyvFiVi/hXaXlihA8qJ/oDC6OVXDXPm3EBRk=;
Received: from p54ae996c.dip0.t-ipconnect.de ([84.174.153.108] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1k53da-0003XJ-Pe
        for linux-wireless@vger.kernel.org; Mon, 10 Aug 2020 10:58:34 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 6/6] mt76: mt7915: do not do any work in napi poll after calling napi_complete_done()
Date:   Mon, 10 Aug 2020 10:58:32 +0200
Message-Id: <20200810085832.65662-6-nbd@nbd.name>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200810085832.65662-1-nbd@nbd.name>
References: <20200810085832.65662-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fixes a race condition where multiple tx cleanup or sta poll tasks could run
in parallel.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt7915/dma.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/dma.c b/drivers/net/wireless/mediatek/mt76/mt7915/dma.c
index a8832c5e6004..8a1ae08d9572 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/dma.c
@@ -95,16 +95,13 @@ static int mt7915_poll_tx(struct napi_struct *napi, int budget)
 	dev = container_of(napi, struct mt7915_dev, mt76.tx_napi);
 
 	mt7915_tx_cleanup(dev);
-
-	if (napi_complete_done(napi, 0))
-		mt7915_irq_enable(dev, MT_INT_TX_DONE_ALL);
-
-	mt7915_tx_cleanup(dev);
-
 	mt7915_mac_sta_poll(dev);
 
 	tasklet_schedule(&dev->mt76.tx_tasklet);
 
+	if (napi_complete_done(napi, 0))
+		mt7915_irq_enable(dev, MT_INT_TX_DONE_ALL);
+
 	return 0;
 }
 
-- 
2.28.0

