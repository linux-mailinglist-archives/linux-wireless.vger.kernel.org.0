Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A967251184
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Aug 2020 07:29:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728687AbgHYF3Y (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Aug 2020 01:29:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728630AbgHYF3R (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Aug 2020 01:29:17 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4372C061797
        for <linux-wireless@vger.kernel.org>; Mon, 24 Aug 2020 22:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=vAp1kUCxDhAD2zQ47Xojt01AZLeTeC/elLrg17j7ZvI=; b=ZSy4/1350ZFs/yzkagHOON0M3n
        cpC2LNsxHJogCqsUjIpss5Qz2oYCzCoBjHJ6/KIhKfQeH3iUV7M67vYDpPfVJMLz3LpA8PZrDiUsG
        2N49Jtyu5ofb7Or3i8fAuq8xG2dluPXC5wkU7UqFhZv9Hb09QQWyujxVrSzWRhq00vp4=;
Received: from p5b206497.dip0.t-ipconnect.de ([91.32.100.151] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1kARWC-0006jr-L8
        for linux-wireless@vger.kernel.org; Tue, 25 Aug 2020 07:29:12 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 8/9] mt76: add memory barrier to DMA queue kick
Date:   Tue, 25 Aug 2020 07:29:08 +0200
Message-Id: <20200825052909.36955-8-nbd@nbd.name>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200825052909.36955-1-nbd@nbd.name>
References: <20200825052909.36955-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ensure that descriptor memory has been fully written before letting the
hardware read it

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/dma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wireless/mediatek/mt76/dma.c
index 7545b552db25..24ff21eedbd0 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/dma.c
@@ -143,6 +143,7 @@ mt76_dma_sync_idx(struct mt76_dev *dev, struct mt76_queue *q)
 static void
 mt76_dma_kick_queue(struct mt76_dev *dev, struct mt76_queue *q)
 {
+	wmb();
 	writel(q->head, &q->regs->cpu_idx);
 }
 
-- 
2.28.0

