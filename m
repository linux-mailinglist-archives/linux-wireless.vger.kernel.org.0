Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F210D251185
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Aug 2020 07:29:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728715AbgHYF3Z (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Aug 2020 01:29:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728653AbgHYF3R (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Aug 2020 01:29:17 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCA48C061799
        for <linux-wireless@vger.kernel.org>; Mon, 24 Aug 2020 22:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=rA1DOLXwQ59WC5TTbobxF30UxtUDddp+8OTrnM1mI7g=; b=XyBCJrsh8tNXN9PBGYQsWRoQE1
        KIyZQXlVd5bb8OF+sKFr2xS7z6ffUylGmERKfwBbsO9xhGVxgQSkrIUymx8teD8y4+1bh0e4NB7Ho
        KEc6DboUAKTeFCK6l2KyDicQOCej49CB3uICZwKdjY/MIPlhjdEZdEEQb5npUvO8iyJE=;
Received: from p5b206497.dip0.t-ipconnect.de ([91.32.100.151] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1kARWB-0006jr-OQ
        for linux-wireless@vger.kernel.org; Tue, 25 Aug 2020 07:29:11 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 4/9] mt76: mt7915: schedule tx tasklet in mt7915_mac_tx_free
Date:   Tue, 25 Aug 2020 07:29:04 +0200
Message-Id: <20200825052909.36955-4-nbd@nbd.name>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200825052909.36955-1-nbd@nbd.name>
References: <20200825052909.36955-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The previous scheduling round may have been limited by AQL.
More frames might be available after the tx free run.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt7915/dma.c | 2 --
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c | 1 +
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/dma.c b/drivers/net/wireless/mediatek/mt76/mt7915/dma.c
index f6c18a08d414..34e90bb08f0a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/dma.c
@@ -96,8 +96,6 @@ static int mt7915_poll_tx(struct napi_struct *napi, int budget)
 
 	mt7915_tx_cleanup(dev);
 
-	tasklet_schedule(&dev->mt76.tx_tasklet);
-
 	if (napi_complete_done(napi, 0))
 		mt7915_irq_enable(dev, MT_INT_TX_DONE_ALL);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 06bb8d0103ba..9c920c9f4d2b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -936,6 +936,7 @@ void mt7915_mac_tx_free(struct mt7915_dev *dev, struct sk_buff *skb)
 	dev_kfree_skb(skb);
 
 	mt7915_mac_sta_poll(dev);
+	tasklet_schedule(&dev->mt76.tx_tasklet);
 }
 
 void mt7915_tx_complete_skb(struct mt76_dev *mdev, enum mt76_txq_id qid,
-- 
2.28.0

