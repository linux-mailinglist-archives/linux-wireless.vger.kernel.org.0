Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC5A51307EC
	for <lists+linux-wireless@lfdr.de>; Sun,  5 Jan 2020 13:22:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbgAEMW5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 5 Jan 2020 07:22:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:47360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725897AbgAEMW5 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 5 Jan 2020 07:22:57 -0500
Received: from new-host-5.station (net-2-42-61-77.cust.vodafonedsl.it [2.42.61.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A1AE215A4;
        Sun,  5 Jan 2020 12:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578226976;
        bh=OGXgsGDlwpdWuGBpEYpGlHDlCkOw+rP9Fx37Op5a4a8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rNuxG7qvaiSHcVxkGGyRfN/A31pilz2xwSQC6ub28nNn153RJuRRmymwQFq9dh7ez
         TIEm5Udm4tYe2GvDSJr2ByxtEEOWvdRckA0RucYerbERAVQQ7m46z9GK8mZ5/uNyMI
         PoZ/FhL3ftVIRJQUrGuUt2k1H94Z1DL75hK33kAo=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        Sean.Wang@mediatek.com
Subject: [PATCH v2 12/18] mt76: mt76u: resume all rx queue in mt76u_resume_rx
Date:   Sun,  5 Jan 2020 13:21:50 +0100
Message-Id: <c2595002b71461dbceeae6c58eb6a1f49a65377a.1578226544.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <cover.1578226544.git.lorenzo@kernel.org>
References: <cover.1578226544.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Resume all possible rx queues after suspend. This is a preliminary patch
to support mt7663u devices

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/usb.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/usb.c b/drivers/net/wireless/mediatek/mt76/usb.c
index f80380c674a1..d85268c6df70 100644
--- a/drivers/net/wireless/mediatek/mt76/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/usb.c
@@ -680,13 +680,24 @@ EXPORT_SYMBOL_GPL(mt76u_stop_rx);
 
 int mt76u_resume_rx(struct mt76_dev *dev)
 {
-	struct mt76_queue *q = &dev->q_rx[MT_RXQ_MAIN];
-	int i;
+	struct mt76_queue *q;
+	int i, j, err;
 
-	for (i = 0; i < q->ndesc; i++)
-		usb_unpoison_urb(q->entry[i].urb);
+	for (i = 0; i < __MT_RXQ_MAX; i++) {
+		q = &dev->q_rx[i];
 
-	return mt76u_submit_rx_buffers(dev, MT_RXQ_MAIN);
+		if (!q->ndesc)
+			continue;
+
+		for (j = 0; j < q->ndesc; j++)
+			usb_unpoison_urb(q->entry[j].urb);
+
+		err = mt76u_submit_rx_buffers(dev, i);
+		if (err < 0)
+			return err;
+	}
+
+	return 0;
 }
 EXPORT_SYMBOL_GPL(mt76u_resume_rx);
 
-- 
2.21.1

