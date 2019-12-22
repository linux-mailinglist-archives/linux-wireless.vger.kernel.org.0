Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D26E8128D60
	for <lists+linux-wireless@lfdr.de>; Sun, 22 Dec 2019 11:33:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbfLVKdn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 22 Dec 2019 05:33:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:45132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725977AbfLVKdm (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 22 Dec 2019 05:33:42 -0500
Received: from lore-desk-wlan.lan (unknown [151.66.53.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 645A92084D;
        Sun, 22 Dec 2019 10:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577010822;
        bh=9rOs1S8jvgjREYgTyg8Il05txvYl0eUqT2ii/giQICw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pDj0agYt7Zj1OOpVoGdA0hgNwK+zQxn3XSnOMHgBqWd49vMygzg9+REhY5EwalgKK
         h54nTVizQeT/IEnHAAuzobF8XOwZ6wAQngpmblH2iMWIDx95JWmb1goCNtzlKP5KAH
         X7MOXng3PzJQReBhMwRHrH4sPkpnocC6AgdmfWGk=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        Sean.Wang@mediatek.com
Subject: [PATCH 03/18] mt76: mt76u: add mt76_queue to mt76u_get_next_rx_entry signature
Date:   Sun, 22 Dec 2019 11:33:05 +0100
Message-Id: <9c5dbe8ef83efcb41b2d964f1d0eabcedebae2fb.1577010183.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1577010183.git.lorenzo@kernel.org>
References: <cover.1577010183.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Rely on mt76_queue pointer in mt76u_get_next_rx_entry in order to add
support for new devices (e.g 7663u) that reports fw events through hw rx
mcu queue

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/usb.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/usb.c b/drivers/net/wireless/mediatek/mt76/usb.c
index 24f8178c9386..705a25c10845 100644
--- a/drivers/net/wireless/mediatek/mt76/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/usb.c
@@ -398,10 +398,9 @@ mt76u_fill_bulk_urb(struct mt76_dev *dev, int dir, int index,
 	urb->context = context;
 }
 
-static inline struct urb *
-mt76u_get_next_rx_entry(struct mt76_dev *dev)
+static struct urb *
+mt76u_get_next_rx_entry(struct mt76_queue *q)
 {
-	struct mt76_queue *q = &dev->q_rx[MT_RXQ_MAIN];
 	struct urb *urb = NULL;
 	unsigned long flags;
 
@@ -553,7 +552,7 @@ mt76u_process_rx_queue(struct mt76_dev *dev, struct mt76_queue *q)
 	int err, count;
 
 	while (true) {
-		urb = mt76u_get_next_rx_entry(dev);
+		urb = mt76u_get_next_rx_entry(q);
 		if (!urb)
 			break;
 
-- 
2.24.1

