Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5554B13BDE8
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jan 2020 11:59:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729921AbgAOK7s (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Jan 2020 05:59:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:59354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729856AbgAOK7s (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Jan 2020 05:59:48 -0500
Received: from localhost.localdomain.com (nat-pool-mxp-t.redhat.com [149.6.153.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A9F524679;
        Wed, 15 Jan 2020 10:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579085987;
        bh=dIf/mjZrMuCeDOhVD8nhVM5+Q9l0Qf2+Om8JMYn9suE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oV3Pp8bL0xzFR5dYY9lKnB6df6acyvyYOZAqm0bau1dQKW8D4CPjhJiUvKDRd3KVW
         4uYtfKEDTVwu7ApHod4vuepfZ0/u9RzhDq3IOqkA2nJmHXAaBt9GoR8jPKE18jQchH
         lIEp5x/ZBlfiT4iTjXDCMnNPloJwwdOKygon+TDk=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        Sean.Wang@mediatek.com
Subject: [PATCH v3 11/18] mt76: mt76u: add queue parameter to mt76u_rx_urb_alloc
Date:   Wed, 15 Jan 2020 11:58:51 +0100
Message-Id: <7e9e18ec566b159f2f3e7e9241e1302159c6e6a6.1579085367.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <cover.1579085367.git.lorenzo@kernel.org>
References: <cover.1579085367.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add mt76_queue parameter to mt76u_rx_urb_alloc signature since this
routine will be used to allocate urbs for mcu hw queue used by new
chipset generation (e.g. mt7663u). Check sg_max_size in in
mt76u_urb_alloc in order to use linear urb for mcu queue

Co-developed-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/usb.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/usb.c b/drivers/net/wireless/mediatek/mt76/usb.c
index e1112899a207..f80380c674a1 100644
--- a/drivers/net/wireless/mediatek/mt76/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/usb.c
@@ -347,24 +347,25 @@ mt76u_urb_alloc(struct mt76_dev *dev, struct mt76_queue_entry *e,
 
 	usb_init_urb(e->urb);
 
-	if (dev->usb.sg_en)
+	if (dev->usb.sg_en && sg_max_size > 0)
 		e->urb->sg = (struct scatterlist *)(e->urb + 1);
 
 	return 0;
 }
 
 static int
-mt76u_rx_urb_alloc(struct mt76_dev *dev, struct mt76_queue_entry *e)
+mt76u_rx_urb_alloc(struct mt76_dev *dev, struct mt76_queue *q,
+		   struct mt76_queue_entry *e)
 {
-	struct mt76_queue *q = &dev->q_rx[MT_RXQ_MAIN];
-	int err;
+	enum mt76_rxq_id qid = q - &dev->q_rx[MT_RXQ_MAIN];
+	int err, sg_size;
 
-	err = mt76u_urb_alloc(dev, e, MT_RX_SG_MAX_SIZE);
+	sg_size = qid == MT_RXQ_MAIN ? MT_RX_SG_MAX_SIZE : 0;
+	err = mt76u_urb_alloc(dev, e, sg_size);
 	if (err)
 		return err;
 
-	return mt76u_refill_rx(dev, q, e->urb, MT_RX_SG_MAX_SIZE,
-			       GFP_KERNEL);
+	return mt76u_refill_rx(dev, q, e->urb, sg_size, GFP_KERNEL);
 }
 
 static void mt76u_urb_free(struct urb *urb)
@@ -620,7 +621,7 @@ mt76u_alloc_rx_queue(struct mt76_dev *dev, enum mt76_rxq_id qid)
 	q->buf_size = PAGE_SIZE;
 
 	for (i = 0; i < q->ndesc; i++) {
-		err = mt76u_rx_urb_alloc(dev, &q->entry[i]);
+		err = mt76u_rx_urb_alloc(dev, q, &q->entry[i]);
 		if (err < 0)
 			return err;
 	}
-- 
2.21.1

