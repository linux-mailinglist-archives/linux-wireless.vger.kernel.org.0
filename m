Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E551D128D69
	for <lists+linux-wireless@lfdr.de>; Sun, 22 Dec 2019 11:33:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbfLVKd5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 22 Dec 2019 05:33:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:45376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725977AbfLVKd4 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 22 Dec 2019 05:33:56 -0500
Received: from lore-desk-wlan.lan (unknown [151.66.53.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3281F20733;
        Sun, 22 Dec 2019 10:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577010836;
        bh=BcpbnkYRN8DSuLFy5/9GPcXhRvPlT4/Gevi9xnwfnDo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ByxgjysFjc7T3ZX+eAJmG+2Hc7Y4Jqf7mRXxNbRTkBb2plI3/BD7blzUKttexMzoc
         IBNSKHMYUk9NzTjqR7PZynyh/yN58g06ivkEEutTf3mz3G4QaEHrebycucMzvyvHea
         jgElp0o6Gp0sOvOVoC2FZu1pUw0tGTHey2gsLOOA=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        Sean.Wang@mediatek.com
Subject: [PATCH 12/18] mt76: mt76u: resume all rx queue in mt76u_resume_rx
Date:   Sun, 22 Dec 2019 11:33:14 +0100
Message-Id: <7ab2bfd7c1497df69321744555011c5e400b96ad.1577010183.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1577010183.git.lorenzo@kernel.org>
References: <cover.1577010183.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Resume all possible rx queues after suspend. This is a preliminary patch
to support mt7663u devices

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/usb.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/usb.c b/drivers/net/wireless/mediatek/mt76/usb.c
index 51707f134c6a..575a1d1e6e66 100644
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
2.24.1

