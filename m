Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E0A476549
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jul 2019 14:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbfGZMLB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 26 Jul 2019 08:11:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44510 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726282AbfGZMLB (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 26 Jul 2019 08:11:01 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1ACB84ACDF;
        Fri, 26 Jul 2019 12:11:01 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 381A45F9DD;
        Fri, 26 Jul 2019 12:10:58 +0000 (UTC)
From:   Stanislaw Gruszka <sgruszka@redhat.com>
To:     linux-wireless@vger.kernel.org
Cc:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Ryder Lee <ryder.lee@mediatek.com>, Roy Luo <royluo@google.com>
Subject: [RFC] mt76: fix tx hung regression on MT7630E 
Date:   Fri, 26 Jul 2019 14:10:56 +0200
Message-Id: <1564143056-14610-1-git-send-email-sgruszka@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Fri, 26 Jul 2019 12:11:01 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Since 41634aa8d6db ("mt76: only schedule txqs from the tx tasklet")
I can observe firmware hangs on MT7630E on station mode: tx stop
functioning after minor activity (rx keep working) and on module
unload device fail to stop with messages:

[ 5446.141413] mt76x0e 0000:06:00.0: TX DMA did not stop
[ 5449.176764] mt76x0e 0000:06:00.0: TX DMA did not stop

Loading module again results in failure to associate with AP.
Only machine power off / power on cycle can make device work again.

I have no idea why the commit caused F/W hangs. Most likely some proper
fix is needed of changing registers programming (or assuring proper order
of actions), but so far I can not came up with any better fix than
a partial revert of 41634aa8d6db.

Signed-off-by: Stanislaw Gruszka <sgruszka@redhat.com>
---
 drivers/net/wireless/mediatek/mt76/tx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/tx.c b/drivers/net/wireless/mediatek/mt76/tx.c
index 5397827668b9..fefe0ee52584 100644
--- a/drivers/net/wireless/mediatek/mt76/tx.c
+++ b/drivers/net/wireless/mediatek/mt76/tx.c
@@ -598,7 +598,7 @@ void mt76_wake_tx_queue(struct ieee80211_hw *hw, struct ieee80211_txq *txq)
 	if (!test_bit(MT76_STATE_RUNNING, &dev->state))
 		return;
 
-	tasklet_schedule(&dev->tx_tasklet);
+	mt76_txq_schedule(dev, txq->ac);
 }
 EXPORT_SYMBOL_GPL(mt76_wake_tx_queue);
 
-- 
1.9.3

