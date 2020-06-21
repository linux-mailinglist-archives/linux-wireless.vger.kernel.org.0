Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F819202B83
	for <lists+linux-wireless@lfdr.de>; Sun, 21 Jun 2020 18:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730356AbgFUQDy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 21 Jun 2020 12:03:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:45794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730255AbgFUQDy (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 21 Jun 2020 12:03:54 -0400
Received: from localhost.localdomain (unknown [151.48.138.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F1D40251C0;
        Sun, 21 Jun 2020 16:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592755433;
        bh=iAVWUbvbMNmeg5b7Obnepn3MSubYS+rIsBAg6xeS9SE=;
        h=From:To:Cc:Subject:Date:From;
        b=ObwGsipHZlD0T3Ijp866r/ZE/rISQxiGOk5yqlm/9f7BeNkXOwk0rFKpBiY8HhQqn
         erbOwUpqNzzuSqOglhSgH/ZAQdAfh/2mt9m/qKIpTDbfIgJ86MX6S7Oa09O9eglwIZ
         R4FOK/D6hF5En3KXACCq7XRjjdWGTOExSIloYh4k=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, nbd@nbd.name,
        lorenzo.bianconi@redhat.com, sean.wang@mediatek.com
Subject: [PATCH v2 wireless-drivers] mt76: mt7663u: fix memory leaks in mt7663u_probe
Date:   Sun, 21 Jun 2020 18:03:38 +0200
Message-Id: <e4098f0c8a9ac51997de07f38c2bcdf7042d6db1.1592755166.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fix the two following memory leaks in mt7663u_probe:
1- if device power-own times out, remove ieee80211 hw device.
2- if mt76u queues allocation fails, remove pending urbs.

Fixes: eb99cc95c3b65 ("mt76: mt7615: introduce mt7663u support")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
Changes since v1:
- properly set return value if device power-own fails
---
 .../net/wireless/mediatek/mt76/mt7615/usb.c   | 11 +++++-----
 drivers/net/wireless/mediatek/mt76/usb.c      | 22 ++++++++++++++-----
 2 files changed, 23 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/usb.c b/drivers/net/wireless/mediatek/mt76/mt7615/usb.c
index a50077eb24d7..c7763e209e00 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/usb.c
@@ -329,25 +329,26 @@ static int mt7663u_probe(struct usb_interface *usb_intf,
 	if (!mt76_poll_msec(dev, MT_CONN_ON_MISC, MT_TOP_MISC2_FW_PWR_ON,
 			    FW_STATE_PWR_ON << 1, 500)) {
 		dev_err(dev->mt76.dev, "Timeout for power on\n");
-		return -EIO;
+		ret = -EIO;
+		goto error;
 	}
 
 alloc_queues:
 	ret = mt76u_alloc_mcu_queue(&dev->mt76);
 	if (ret)
-		goto error;
+		goto error_free_q;
 
 	ret = mt76u_alloc_queues(&dev->mt76);
 	if (ret)
-		goto error;
+		goto error_free_q;
 
 	ret = mt7663u_register_device(dev);
 	if (ret)
-		goto error_freeq;
+		goto error_free_q;
 
 	return 0;
 
-error_freeq:
+error_free_q:
 	mt76u_queues_deinit(&dev->mt76);
 error:
 	mt76u_deinit(&dev->mt76);
diff --git a/drivers/net/wireless/mediatek/mt76/usb.c b/drivers/net/wireless/mediatek/mt76/usb.c
index fb97ea25b4d4..2e89b0514ff6 100644
--- a/drivers/net/wireless/mediatek/mt76/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/usb.c
@@ -1066,11 +1066,16 @@ static int mt76u_alloc_tx(struct mt76_dev *dev)
 
 static void mt76u_free_tx(struct mt76_dev *dev)
 {
-	struct mt76_queue *q;
-	int i, j;
+	int i;
 
 	for (i = 0; i < IEEE80211_NUM_ACS; i++) {
+		struct mt76_queue *q;
+		int j;
+
 		q = dev->q_tx[i].q;
+		if (!q)
+			continue;
+
 		for (j = 0; j < q->ndesc; j++)
 			usb_free_urb(q->entry[j].urb);
 	}
@@ -1078,17 +1083,22 @@ static void mt76u_free_tx(struct mt76_dev *dev)
 
 void mt76u_stop_tx(struct mt76_dev *dev)
 {
-	struct mt76_queue_entry entry;
-	struct mt76_queue *q;
-	int i, j, ret;
+	int ret;
 
 	ret = wait_event_timeout(dev->tx_wait, !mt76_has_tx_pending(&dev->phy),
 				 HZ / 5);
 	if (!ret) {
+		struct mt76_queue_entry entry;
+		struct mt76_queue *q;
+		int i, j;
+
 		dev_err(dev->dev, "timed out waiting for pending tx\n");
 
 		for (i = 0; i < IEEE80211_NUM_ACS; i++) {
 			q = dev->q_tx[i].q;
+			if (!q)
+				continue;
+
 			for (j = 0; j < q->ndesc; j++)
 				usb_kill_urb(q->entry[j].urb);
 		}
@@ -1100,6 +1110,8 @@ void mt76u_stop_tx(struct mt76_dev *dev)
 		 */
 		for (i = 0; i < IEEE80211_NUM_ACS; i++) {
 			q = dev->q_tx[i].q;
+			if (!q)
+				continue;
 
 			/* Assure we are in sync with killed tasklet. */
 			spin_lock_bh(&q->lock);
-- 
2.26.2

