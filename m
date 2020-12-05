Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10F1A2CFB06
	for <lists+linux-wireless@lfdr.de>; Sat,  5 Dec 2020 11:41:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727886AbgLEKiq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 5 Dec 2020 05:38:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:45098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729223AbgLEKgb (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 5 Dec 2020 05:36:31 -0500
From:   Lorenzo Bianconi <lorenzo@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org
Subject: [PATCH 1/2] mt76: usb: remove wake logic in mt76u_status_worker
Date:   Sat,  5 Dec 2020 11:35:25 +0100
Message-Id: <00009bf0cfdc9565e4432cad3ed51888c667c25d.1607164041.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1607164041.git.lorenzo@kernel.org>
References: <cover.1607164041.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Similar to mmio code path, remove wake logic in mt76u_status_worker
handler

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/usb.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/usb.c b/drivers/net/wireless/mediatek/mt76/usb.c
index 81393788f98e..658b36a2281d 100644
--- a/drivers/net/wireless/mediatek/mt76/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/usb.c
@@ -811,7 +811,6 @@ static void mt76u_status_worker(struct mt76_worker *w)
 	struct mt76_dev *dev = container_of(usb, struct mt76_dev, usb);
 	struct mt76_queue_entry entry;
 	struct mt76_queue *q;
-	bool wake;
 	int i;
 
 	for (i = 0; i < IEEE80211_NUM_ACS; i++) {
@@ -827,10 +826,6 @@ static void mt76u_status_worker(struct mt76_worker *w)
 			mt76_queue_tx_complete(dev, q, &entry);
 		}
 
-		wake = q->stopped && q->queued < q->ndesc - 8;
-		if (wake)
-			q->stopped = false;
-
 		if (!q->queued)
 			wake_up(&dev->tx_wait);
 
@@ -839,8 +834,6 @@ static void mt76u_status_worker(struct mt76_worker *w)
 		if (dev->drv->tx_status_data &&
 		    !test_and_set_bit(MT76_READING_STATS, &dev->phy.state))
 			queue_work(dev->wq, &dev->usb.stat_work);
-		if (wake)
-			ieee80211_wake_queue(dev->hw, i);
 	}
 }
 
-- 
2.28.0

