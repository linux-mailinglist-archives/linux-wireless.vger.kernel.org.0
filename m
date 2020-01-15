Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48DB313BDDD
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jan 2020 11:59:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729850AbgAOK7h (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Jan 2020 05:59:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:59096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726550AbgAOK7g (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Jan 2020 05:59:36 -0500
Received: from localhost.localdomain.com (nat-pool-mxp-t.redhat.com [149.6.153.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 48FED24679;
        Wed, 15 Jan 2020 10:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579085976;
        bh=HzXAKIZLejGBRJ+ACe6Jzce0fn6q8KCLEihnYieCALE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T7TkYyxCym+ckW6WOXDsZIReLBw5wJNfL24Jn9HorpO54FBaF3ZjIxVh8g/sO/BJ7
         xevkUDHSW+iLSiVZeoQfQCXeYeqlY3rZOuZFEC7tzMPIX+SnxenIX8C4Y2IYmp7ziY
         IQgVYRmtnjQ0WUPq2rGaZoPkKxmExolYZX/DS7x0=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        Sean.Wang@mediatek.com
Subject: [PATCH v3 03/18] mt76: mt76u: add mt76_queue to mt76u_get_next_rx_entry signature
Date:   Wed, 15 Jan 2020 11:58:43 +0100
Message-Id: <3a30a21a783127d0b3efc382cf6316cda9f06d8e.1579085367.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <cover.1579085367.git.lorenzo@kernel.org>
References: <cover.1579085367.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Rely on mt76_queue pointer in mt76u_get_next_rx_entry in order to add
support for new devices (e.g 7663u) that reports fw events through hw rx
mcu queue

Co-developed-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/usb.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/usb.c b/drivers/net/wireless/mediatek/mt76/usb.c
index 9b0a4104ec0e..23973ec6c92c 100644
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
2.21.1

