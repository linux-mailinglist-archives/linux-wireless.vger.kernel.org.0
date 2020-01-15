Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5069E13BDE6
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jan 2020 11:59:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729892AbgAOK7p (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Jan 2020 05:59:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:59288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729856AbgAOK7p (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Jan 2020 05:59:45 -0500
Received: from localhost.localdomain.com (nat-pool-mxp-t.redhat.com [149.6.153.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C0F0B24671;
        Wed, 15 Jan 2020 10:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579085984;
        bh=oVbQrIl3jPwZZQvmzz5CLjd6xxBK/ryXyuiwA9V0nxg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pLtOxcPoHHxbVBTS41B03X6F/o548hx4Maec7x2TRKxtkWWvVHjhbzrO247swLeUv
         AHfsMOAWCKHY97pbTROIMA5BWOrARps1XcFpTC6+xBYIMdhdkF1JUDtHFptdVfeY8Y
         uiUW6/245PHgwePpBUCID/zIVLkjQZlX7PTyT+ts=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        Sean.Wang@mediatek.com
Subject: [PATCH v3 09/18] mt76: mt76u: stop/free all possible rx queues
Date:   Wed, 15 Jan 2020 11:58:49 +0100
Message-Id: <91db35644c9290cb9e56273108a52bac5d256cc2.1579085367.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <cover.1579085367.git.lorenzo@kernel.org>
References: <cover.1579085367.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Stop/free all configured rx queues (data/mcu) in
mt76u_stop_rx/mt76u_free_rx. This is a preliminary patch to support new
devices (e.g. mt7663u) that rely on a hw queue for mcu messages

Co-developed-by: Sean Wang <sean.wang@mediatek.com>
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

