Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BBA404CC15
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Jun 2019 12:39:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730815AbfFTKjw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 20 Jun 2019 06:39:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:57728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726222AbfFTKjw (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 20 Jun 2019 06:39:52 -0400
Received: from localhost.localdomain (unknown [151.66.61.123])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1DBD02070B;
        Thu, 20 Jun 2019 10:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561027191;
        bh=kqdsx5+f7xavL6Lvu+NfBKaj5BoWOPhdoJeN1gteEXg=;
        h=From:To:Cc:Subject:Date:From;
        b=gSmpjrw4CF7ze+HKH5clcFkcZhvLNqtwV3fNMj52DhELJQPzyG2CjlWfN+x+jnFki
         6clxtXOFKskBIp2neley2/3ym4BwJ+mnDSoeCH7CjxBqdU0hpolQhlLK5D9KvvUiw2
         O0b51QXthnn1yGrGEBDeF0+m3DLkrmAzOix7K0Hs=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        sgruszka@redhat.com
Subject: [PATCH v4] mt76: mt76u: reduce rx memory footprint
Date:   Thu, 20 Jun 2019 12:39:36 +0200
Message-Id: <736fff59b805cf2f25a9dcd687f0d172b79331eb.1561026861.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Reduce rx memory footprint allocating just one SG buffer since for the
moment we support just 3839B as maximal size of an A-MSDU.
Introduce different SG_MAX_SIZE definitions for TX and RX sides.
Moreover set q->buf_size to PAGE_SIZE even for SG case.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
Changes since v3:
- drop patch 2/3: mt76u: introduce mt76u_ep data structure
- do not align usb buffer size to usb max endpoint length
---
 drivers/net/wireless/mediatek/mt76/mt76.h      |  3 ++-
 .../net/wireless/mediatek/mt76/mt76x0/usb.c    |  2 +-
 .../wireless/mediatek/mt76/mt76x2/usb_init.c   |  2 +-
 drivers/net/wireless/mediatek/mt76/usb.c       | 18 +++++++++++-------
 4 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 23a5ebefac3a..eee83c369a64 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -384,7 +384,8 @@ enum mt76u_out_ep {
 	__MT_EP_OUT_MAX,
 };
 
-#define MT_SG_MAX_SIZE		8
+#define MT_TX_SG_MAX_SIZE	8
+#define MT_RX_SG_MAX_SIZE	1
 #define MT_NUM_TX_ENTRIES	256
 #define MT_NUM_RX_ENTRIES	128
 #define MCU_RESP_URB_SIZE	1024
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x0/usb.c b/drivers/net/wireless/mediatek/mt76/mt76x0/usb.c
index 7c38ec4418db..5b9701ce6f37 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x0/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x0/usb.c
@@ -191,7 +191,7 @@ static int mt76x0u_register_device(struct mt76x02_dev *dev)
 
 	/* check hw sg support in order to enable AMSDU */
 	if (dev->mt76.usb.sg_en)
-		hw->max_tx_fragments = MT_SG_MAX_SIZE;
+		hw->max_tx_fragments = MT_TX_SG_MAX_SIZE;
 	else
 		hw->max_tx_fragments = 1;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/usb_init.c b/drivers/net/wireless/mediatek/mt76/mt76x2/usb_init.c
index f2c57d5b87f9..94f52f98019b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/usb_init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/usb_init.c
@@ -225,7 +225,7 @@ int mt76x2u_register_device(struct mt76x02_dev *dev)
 
 	/* check hw sg support in order to enable AMSDU */
 	if (dev->mt76.usb.sg_en)
-		hw->max_tx_fragments = MT_SG_MAX_SIZE;
+		hw->max_tx_fragments = MT_TX_SG_MAX_SIZE;
 	else
 		hw->max_tx_fragments = 1;
 
diff --git a/drivers/net/wireless/mediatek/mt76/usb.c b/drivers/net/wireless/mediatek/mt76/usb.c
index dd90427b2d67..ecc1aa59f5c1 100644
--- a/drivers/net/wireless/mediatek/mt76/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/usb.c
@@ -333,12 +333,13 @@ mt76u_refill_rx(struct mt76_dev *dev, struct urb *urb, int nsgs, gfp_t gfp)
 }
 
 static int
-mt76u_urb_alloc(struct mt76_dev *dev, struct mt76_queue_entry *e)
+mt76u_urb_alloc(struct mt76_dev *dev, struct mt76_queue_entry *e,
+		int sg_max_size)
 {
 	unsigned int size = sizeof(struct urb);
 
 	if (dev->usb.sg_en)
-		size += MT_SG_MAX_SIZE * sizeof(struct scatterlist);
+		size += sg_max_size * sizeof(struct scatterlist);
 
 	e->urb = kzalloc(size, GFP_KERNEL);
 	if (!e->urb)
@@ -357,11 +358,12 @@ mt76u_rx_urb_alloc(struct mt76_dev *dev, struct mt76_queue_entry *e)
 {
 	int err;
 
-	err = mt76u_urb_alloc(dev, e);
+	err = mt76u_urb_alloc(dev, e, MT_RX_SG_MAX_SIZE);
 	if (err)
 		return err;
 
-	return mt76u_refill_rx(dev, e->urb, MT_SG_MAX_SIZE, GFP_KERNEL);
+	return mt76u_refill_rx(dev, e->urb, MT_RX_SG_MAX_SIZE,
+			       GFP_KERNEL);
 }
 
 static void mt76u_urb_free(struct urb *urb)
@@ -605,8 +607,9 @@ static int mt76u_alloc_rx(struct mt76_dev *dev)
 	if (!q->entry)
 		return -ENOMEM;
 
-	q->buf_size = dev->usb.sg_en ? MT_RX_BUF_SIZE : PAGE_SIZE;
 	q->ndesc = MT_NUM_RX_ENTRIES;
+	q->buf_size = PAGE_SIZE;
+
 	for (i = 0; i < q->ndesc; i++) {
 		err = mt76u_rx_urb_alloc(dev, &q->entry[i]);
 		if (err < 0)
@@ -763,7 +766,7 @@ mt76u_tx_setup_buffers(struct mt76_dev *dev, struct sk_buff *skb,
 		urb->transfer_buffer = skb->data;
 		return 0;
 	} else {
-		sg_init_table(urb->sg, MT_SG_MAX_SIZE);
+		sg_init_table(urb->sg, MT_TX_SG_MAX_SIZE);
 		urb->num_sgs = skb_to_sgvec(skb, urb->sg, 0, skb->len);
 		if (urb->num_sgs == 0)
 			return -ENOMEM;
@@ -857,7 +860,8 @@ static int mt76u_alloc_tx(struct mt76_dev *dev)
 
 		q->ndesc = MT_NUM_TX_ENTRIES;
 		for (j = 0; j < q->ndesc; j++) {
-			err = mt76u_urb_alloc(dev, &q->entry[j]);
+			err = mt76u_urb_alloc(dev, &q->entry[j],
+					      MT_TX_SG_MAX_SIZE);
 			if (err < 0)
 				return err;
 		}
-- 
2.21.0

