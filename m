Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D541510B0E8
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Nov 2019 15:12:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbfK0OM3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 27 Nov 2019 09:12:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:34346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726320AbfK0OM3 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 27 Nov 2019 09:12:29 -0500
Received: from localhost.localdomain.com (unknown [77.139.212.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 037BD206F0;
        Wed, 27 Nov 2019 14:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574863949;
        bh=ZwKewTRRk61v5WsthvJwNhsdqH2UjquHd6ghWMdTTFU=;
        h=From:To:Cc:Subject:Date:From;
        b=UJ9imJ+W8jgZKC+lIr/qvdUinyVW//WUwgShKbe9qycYrFHoPNHJLw1OAO4mzI4NX
         v8zzGUZDVPbOFIR4ktQx1PJURMQDe3qsdtGUo5VgUhYb0IQE2GqKCZjgV6YmfwHvg+
         uzrvlMEGQpI1yoFWVk+LxPwg3QY0JKP2Qz608njU=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com
Subject: [PATCH] mt76: remove check in mt76_txq_dequeue
Date:   Wed, 27 Nov 2019 16:12:18 +0200
Message-Id: <a59bd55c49819d0be9c88b336bacb623009df4d7.1574850011.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Get rid of not useful skb pointer check in mt76_txq_dequeue routine

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/tx.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/tx.c b/drivers/net/wireless/mediatek/mt76/tx.c
index 7ee91d946882..0a5fa08e7c2d 100644
--- a/drivers/net/wireless/mediatek/mt76/tx.c
+++ b/drivers/net/wireless/mediatek/mt76/tx.c
@@ -306,11 +306,7 @@ mt76_txq_dequeue(struct mt76_dev *dev, struct mt76_txq *mtxq, bool ps)
 		return skb;
 	}
 
-	skb = ieee80211_tx_dequeue(dev->hw, txq);
-	if (!skb)
-		return NULL;
-
-	return skb;
+	return ieee80211_tx_dequeue(dev->hw, txq);
 }
 
 static void
-- 
2.21.0

