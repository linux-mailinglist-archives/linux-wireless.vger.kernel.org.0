Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0726823F870
	for <lists+linux-wireless@lfdr.de>; Sat,  8 Aug 2020 20:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbgHHSZp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 8 Aug 2020 14:25:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:55752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726200AbgHHSZo (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 8 Aug 2020 14:25:44 -0400
Received: from localhost.localdomain (unknown [5.170.224.121])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1EB77206B6;
        Sat,  8 Aug 2020 18:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596911144;
        bh=ivX9oIC/8BDyOQAuwGel0lGjiDp9rT4p9w6XOL4YCDk=;
        h=From:To:Cc:Subject:Date:From;
        b=gDdvvDq2FNZefrP0dvboQK9MEX54IMY/AocNp+3E/UjPkOMpFlcrgI/gZKRpDW308
         11t26ndeDtebTMsS48A8FMTFOh2Y4zcOhQHDNGM1pCYbpPlNHXXIDt4RP2kmFroiAB
         MYe83gPGeCv7ZhQGfw30XNcvW7UDOD0oARO3ubTc=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        dan.carpenter@oracle.com
Subject: [PATCH] mt76: mt7615: release mutex in mt7615_reset_test_set
Date:   Sat,  8 Aug 2020 20:25:41 +0200
Message-Id: <fc09800f29909e3461a0f8a62fd75f67ee63b7a1.1596910154.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Reduce scope of mutex_acquire/mutex_release in mt7615_reset_test_set
routine in order to fix the following static checker warning:

drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c:179
mt7615_reset_test_set()
warn: inconsistent returns 'dev->mt76.mutex'.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Fixes: ea4906c4be49 ("mt76: mt7615: wake device before accessing regmap in debugfs")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c
index 88931658a9fb..937cb71bed64 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c
@@ -165,15 +165,14 @@ mt7615_reset_test_set(void *data, u64 val)
 	if (!mt7615_wait_for_mcu_init(dev))
 		return 0;
 
-	mt7615_mutex_acquire(dev);
-
 	skb = alloc_skb(1, GFP_KERNEL);
 	if (!skb)
 		return -ENOMEM;
 
 	skb_put(skb, 1);
-	mt76_tx_queue_skb_raw(dev, 0, skb, 0);
 
+	mt7615_mutex_acquire(dev);
+	mt76_tx_queue_skb_raw(dev, 0, skb, 0);
 	mt7615_mutex_release(dev);
 
 	return 0;
-- 
2.26.2

