Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72BC6103967
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Nov 2019 13:01:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727911AbfKTMBp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 Nov 2019 07:01:45 -0500
Received: from smail.rz.tu-ilmenau.de ([141.24.186.67]:47378 "EHLO
        smail.rz.tu-ilmenau.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728728AbfKTMBp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 Nov 2019 07:01:45 -0500
Received: from isengard.tu-ilmenau.de (unknown [141.24.207.101])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smail.rz.tu-ilmenau.de (Postfix) with ESMTPSA id 7AFA958007B;
        Wed, 20 Nov 2019 13:01:43 +0100 (CET)
From:   Markus Theil <markus.theil@tu-ilmenau.de>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org,
        Markus Theil <markus.theil@tu-ilmenau.de>
Subject: [PATCH] mt76: use rcu_read_lock_bh in mt76u_rx_tasklet
Date:   Wed, 20 Nov 2019 13:01:38 +0100
Message-Id: <20191120120138.11427-1-markus.theil@tu-ilmenau.de>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fixes potential RCU issues and avoids calling ieee80211_rx_napi with softirq
enabled.

Signed-off-by: Markus Theil <markus.theil@tu-ilmenau.de>
---
 drivers/net/wireless/mediatek/mt76/usb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/usb.c b/drivers/net/wireless/mediatek/mt76/usb.c
index 0ad83fb5fd38..1cfbb41f7a36 100644
--- a/drivers/net/wireless/mediatek/mt76/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/usb.c
@@ -549,7 +549,7 @@ static void mt76u_rx_tasklet(unsigned long data)
 	struct urb *urb;
 	int err, count;
 
-	rcu_read_lock();
+	rcu_read_lock_bh();
 
 	while (true) {
 		urb = mt76u_get_next_rx_entry(dev);
@@ -566,7 +566,7 @@ static void mt76u_rx_tasklet(unsigned long data)
 	}
 	mt76_rx_poll_complete(dev, MT_RXQ_MAIN, NULL);
 
-	rcu_read_unlock();
+	rcu_read_unlock_bh();
 }
 
 static int mt76u_submit_rx_buffers(struct mt76_dev *dev)
-- 
2.24.0

