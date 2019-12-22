Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2EB9F128D6C
	for <lists+linux-wireless@lfdr.de>; Sun, 22 Dec 2019 11:34:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbfLVKeC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 22 Dec 2019 05:34:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:45432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725977AbfLVKeB (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 22 Dec 2019 05:34:01 -0500
Received: from lore-desk-wlan.lan (unknown [151.66.53.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C6C2B20733;
        Sun, 22 Dec 2019 10:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577010841;
        bh=WF8W3IdIdiiWTL+qioJPz2Uv7KWfqGR3lB/ogBkRJEg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jola4tusxbVFYCPgq9JxVA1dyS7rBIripQYSeHnsTxMt0TBvzwnKnnvzo75T9519D
         FseLeZsvEn9EOoWJo9VJbbI6T2W13W89/p/b04+3GdmdlYyk3ih7R7FPQYqJCNAH9T
         HZfCXIwPDjwLIXvON64uqE7cOsvsOBvF/Z55S04U=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        Sean.Wang@mediatek.com
Subject: [PATCH 15/18] mt76: mt76u: take into account different queue mapping for 7663
Date:   Sun, 22 Dec 2019 11:33:17 +0100
Message-Id: <32c4a94f70969827de1b6e07a62288d7a3dabbce.1577010183.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1577010183.git.lorenzo@kernel.org>
References: <cover.1577010183.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

7663u devices rely on a different endpoint mapping. Take it into account
in mt76u_alloc_tx routine

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/usb.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/usb.c b/drivers/net/wireless/mediatek/mt76/usb.c
index 854a420738ed..d1fe0351c24e 100644
--- a/drivers/net/wireless/mediatek/mt76/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/usb.c
@@ -964,6 +964,14 @@ static void mt76u_tx_kick(struct mt76_dev *dev, struct mt76_queue *q)
 	}
 }
 
+static u8 mt76u_ac_to_hwq(struct mt76_dev *dev, u8 ac)
+{
+	if (mt76_chip(dev) == 0x7663)
+		return ac ^ 0x3;
+
+	return mt76_ac_to_hwq(ac);
+}
+
 static int mt76u_alloc_tx(struct mt76_dev *dev)
 {
 	struct mt76_queue *q;
@@ -982,7 +990,7 @@ static int mt76u_alloc_tx(struct mt76_dev *dev)
 			return -ENOMEM;
 
 		spin_lock_init(&q->lock);
-		q->hw_idx = mt76_ac_to_hwq(i);
+		q->hw_idx = mt76u_ac_to_hwq(dev, i);
 		dev->q_tx[i].q = q;
 
 		q->entry = devm_kcalloc(dev->dev,
-- 
2.24.1

