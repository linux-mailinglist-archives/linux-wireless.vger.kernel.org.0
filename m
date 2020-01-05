Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0BE1307E9
	for <lists+linux-wireless@lfdr.de>; Sun,  5 Jan 2020 13:22:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbgAEMWw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 5 Jan 2020 07:22:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:47236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725897AbgAEMWw (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 5 Jan 2020 07:22:52 -0500
Received: from new-host-5.station (net-2-42-61-77.cust.vodafonedsl.it [2.42.61.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 47277217F4;
        Sun,  5 Jan 2020 12:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578226971;
        bh=b+3osIGCJepqbLx/yOe55N0kRJsx0rkrZnh7f+UUy2c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oOdw1uWpoh52RQvZUUUQTHzLvS7G09oLcYTZCddPngFU7Xha7JZCey2Ey/OlJvjbE
         mrBSnj7rDXSmHbH1FFxn3731hVreLl9eVTKiLzhzMCGxuSyf+vpiFPRG9OxB8BiYbt
         Y1XCjx8y4KnS4HueCJEH/A+WLZCmMBEqan+zHb0g=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        Sean.Wang@mediatek.com
Subject: [PATCH v2 09/18] mt76: mt76u: stop/free all possible rx queues
Date:   Sun,  5 Jan 2020 13:21:47 +0100
Message-Id: <c235569a40bfa7ab945fa16e5f219ee37b3a6742.1578226544.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <cover.1578226544.git.lorenzo@kernel.org>
References: <cover.1578226544.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Stop/free all configured rx queues (data/mcu) in
mt76u_stop_rx/mt76u_free_rx. This is a preliminary patch to support new
devices (e.g. mt7663u) that rely on a hw queue for mcu messages

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/usb.c | 25 ++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/usb.c b/drivers/net/wireless/mediatek/mt76/usb.c
index 8f0d92c11abf..dde1ee34d23d 100644
--- a/drivers/net/wireless/mediatek/mt76/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/usb.c
@@ -646,18 +646,31 @@ mt76u_free_rx_queue(struct mt76_dev *dev, struct mt76_queue *q)
 
 static void mt76u_free_rx(struct mt76_dev *dev)
 {
-	struct mt76_queue *q = &dev->q_rx[MT_RXQ_MAIN];
+	struct mt76_queue *q;
+	int i;
+
+	for (i = 0; i < __MT_RXQ_MAX; i++) {
+		q = &dev->q_rx[i];
+		if (!q->ndesc)
+			continue;
 
-	mt76u_free_rx_queue(dev, q);
+		mt76u_free_rx_queue(dev, q);
+	}
 }
 
 void mt76u_stop_rx(struct mt76_dev *dev)
 {
-	struct mt76_queue *q = &dev->q_rx[MT_RXQ_MAIN];
-	int i;
+	struct mt76_queue *q;
+	int i, j;
 
-	for (i = 0; i < q->ndesc; i++)
-		usb_poison_urb(q->entry[i].urb);
+	for (i = 0; i < __MT_RXQ_MAX; i++) {
+		q = &dev->q_rx[i];
+		if (!q->ndesc)
+			continue;
+
+		for (j = 0; j < q->ndesc; j++)
+			usb_poison_urb(q->entry[j].urb);
+	}
 
 	tasklet_kill(&dev->usb.rx_tasklet);
 }
-- 
2.21.1

