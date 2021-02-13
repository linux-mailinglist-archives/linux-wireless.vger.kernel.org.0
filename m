Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C57531AD76
	for <lists+linux-wireless@lfdr.de>; Sat, 13 Feb 2021 18:55:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbhBMRww (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 13 Feb 2021 12:52:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbhBMRwm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 13 Feb 2021 12:52:42 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7085C06178C
        for <linux-wireless@vger.kernel.org>; Sat, 13 Feb 2021 09:51:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=98aJN4IgCwZRNNHnxh9mFC2qbV2kNIxBsTGqOP8Iiq4=; b=QrD/PvowL+A5dz9ghc+mf4lt0C
        d6+xh39HGnSWNJDVYoateT4j67siV4IYtmOzdPuhm+i19nrVjNBTHUQvmRiFYPw+H8PlAQnswtqyJ
        ozAzeAzGX9tkIY47kwH+1wYfr5qg6jpREfzgEhtsvsKd9W25WxsxlhW6R+Tkq8n6gNJY=;
Received: from p4ff13c8d.dip0.t-ipconnect.de ([79.241.60.141] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1lAz4R-0007si-6p
        for linux-wireless@vger.kernel.org; Sat, 13 Feb 2021 18:51:03 +0100
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 7/7] mt76: mt7915: fix tx skb dma unmap
Date:   Sat, 13 Feb 2021 18:51:00 +0100
Message-Id: <20210213175100.22608-7-nbd@nbd.name>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210213175100.22608-1-nbd@nbd.name>
References: <20210213175100.22608-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The first pointer in the txp needs to be unmapped as well, otherwise it will
leak DMA mapping entries

Reported-by: Ben Greear <greearb@candelatech.com>
Fixes: 27d5c528a7ca ("mt76: fix double DMA unmap of the first buffer on 7615/7915")
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 71ccefcdc89c..b3168dd3baed 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -1136,7 +1136,7 @@ void mt7915_txp_skb_unmap(struct mt76_dev *dev,
 	int i;
 
 	txp = mt7915_txwi_to_txp(dev, t);
-	for (i = 1; i < txp->nbuf; i++)
+	for (i = 0; i < txp->nbuf; i++)
 		dma_unmap_single(dev->dev, le32_to_cpu(txp->buf[i]),
 				 le16_to_cpu(txp->len[i]), DMA_TO_DEVICE);
 }
-- 
2.28.0

