Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD963ADB49
	for <lists+linux-wireless@lfdr.de>; Sat, 19 Jun 2021 20:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234939AbhFSSWP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 19 Jun 2021 14:22:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:37786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234084AbhFSSWP (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 19 Jun 2021 14:22:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CEAA2611CC;
        Sat, 19 Jun 2021 18:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624126803;
        bh=ZKhXwftqv7KArKaLN6vI2dd+fw17pOyafwVTwdNbS/s=;
        h=From:To:Cc:Subject:Date:From;
        b=lp0kig9uQ9upkHQsXHWtEURZuJNz8++WKARCZtbzAQT6uKutN3LX4o1uzuoxTFs3O
         SSs3PdTx80fM3KFRQ3jFviqmndwzmz4CNunBVryp7LgOrrbMV3mcOdK0u+/EGXj0fk
         iplKZ9bIqgXf/Bv4qPsbvwx3gpQ3Iw7iByjOw9w38BSIBhi9POpGvYKm351rMskOhd
         Swt8iHii68Ip0fUo8HOUb4EcRcgLI/8hYoMv19AnLLwZla8RuKaCYyQxY1bFBqH62l
         /qOt/FUocRsJ8lrscZRXJRgzimnggWgziDzHL6xhdvQzfg3yEMoRgMkp8kGBusmEWg
         wcHBAn67YwR0A==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        sean.wang@mediatek.com, deren.wu@mediatek.com
Subject: [PATCH] mt76: mt7921: avoid unnecessary spin_lock/spin_unlock in mt7921_mcu_tx_done_event
Date:   Sat, 19 Jun 2021 20:19:58 +0200
Message-Id: <d46cdfc6f05145f2145afef59f78ad998cbec2a6.1624126766.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Do not grab the spinlock in mt7921_mcu_tx_done_event routine if not
necessary.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7921/mcu.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
index 1819de869fdf..8e011214169c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
@@ -534,9 +534,7 @@ mt7921_mcu_tx_done_event(struct mt7921_dev *dev, struct sk_buff *skb)
 		mt7921_mcu_tx_rate_parse(mphy->mt76, &peer,
 					 &msta->stats.tx_rate,
 					 le16_to_cpu(event->tx_rate));
-
-		spin_lock_bh(&dev->sta_poll_lock);
-		break;
+		return;
 	}
 	spin_unlock_bh(&dev->sta_poll_lock);
 }
-- 
2.31.1

