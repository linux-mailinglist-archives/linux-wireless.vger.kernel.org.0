Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6C881307F0
	for <lists+linux-wireless@lfdr.de>; Sun,  5 Jan 2020 13:23:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbgAEMXD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 5 Jan 2020 07:23:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:47490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725897AbgAEMXC (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 5 Jan 2020 07:23:02 -0500
Received: from new-host-5.station (net-2-42-61-77.cust.vodafonedsl.it [2.42.61.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9BBAF217F4;
        Sun,  5 Jan 2020 12:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578226982;
        bh=3OCb5vgqfMdfpiBMBADRdCve6TAEFlY/ezff/7gGl0Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hFafSr+ExAQdmE6OiQpKb1m+wnfeURZlgsnSS3Jh+/4Be86YCjVI6Nl+HsuHYuNDJ
         YGTto7W/e4wYQtbato7M5KY3MEDgOGpd+GBLgd2UZQXPuYRjZ6PE3f6SNrXdQv4AKE
         ky2Ftu7fzwgyOW5ZGHw69Don+OTUgFwDJyB//T9M=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        Sean.Wang@mediatek.com
Subject: [PATCH v2 15/18] mt76: mt76u: take into account different queue mapping for 7663
Date:   Sun,  5 Jan 2020 13:21:53 +0100
Message-Id: <04c0f1bdce00dd171153ee00b78aad24036b7e45.1578226544.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <cover.1578226544.git.lorenzo@kernel.org>
References: <cover.1578226544.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

7663u devices rely on a different endpoint mapping. Take it into account
in mt76u_alloc_tx routine

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/usb.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/usb.c b/drivers/net/wireless/mediatek/mt76/usb.c
index 6b31a7a99072..1f29cd905fdd 100644
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
2.21.1

