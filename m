Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C99D7102897
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Nov 2019 16:48:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728559AbfKSPsD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 19 Nov 2019 10:48:03 -0500
Received: from smail.rz.tu-ilmenau.de ([141.24.186.67]:43691 "EHLO
        smail.rz.tu-ilmenau.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728187AbfKSPsD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 19 Nov 2019 10:48:03 -0500
Received: from localhost.localdomain (unknown [141.24.207.101])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smail.rz.tu-ilmenau.de (Postfix) with ESMTPSA id F0D3C58007E;
        Tue, 19 Nov 2019 16:48:00 +0100 (CET)
From:   Markus Theil <markus.theil@tu-ilmenau.de>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        Stanislaw Gruszka <sgruszka@redhat.com>,
        Markus Theil <markus.theil@tu-ilmenau.de>
Subject: [PATCH v6 3/5] mt76: mt76x02: remove a copy call for usb speedup
Date:   Tue, 19 Nov 2019 16:47:44 +0100
Message-Id: <20191119154746.20821-4-markus.theil@tu-ilmenau.de>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191119154746.20821-1-markus.theil@tu-ilmenau.de>
References: <20191119154746.20821-1-markus.theil@tu-ilmenau.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patch removes a mt76_wr_copy call from the beacon path to hw.
The skb which is used in this place gets therefore build with txwi
inside its data. For mt76 usb drivers, this saves one synchronuous
copy call over usb, which lets the beacon work complete faster.

In mmio case, there is not enough headroom to put the txwi into the
skb, it is therefore using an additional mt76_wr_copy, which is fast
over mmio. Thanks Stanislaw for pointing this out.

Signed-off-by: Markus Theil <markus.theil@tu-ilmenau.de>
---
 .../wireless/mediatek/mt76/mt76x02_beacon.c   | 20 +++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_beacon.c b/drivers/net/wireless/mediatek/mt76/mt76x02_beacon.c
index 09013adae854..422d53111229 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_beacon.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_beacon.c
@@ -26,15 +26,27 @@ static int
 mt76x02_write_beacon(struct mt76x02_dev *dev, int offset, struct sk_buff *skb)
 {
 	int beacon_len = dev->beacon_ops->slot_size;
-	struct mt76x02_txwi txwi;
 
 	if (WARN_ON_ONCE(beacon_len < skb->len + sizeof(struct mt76x02_txwi)))
 		return -ENOSPC;
 
-	mt76x02_mac_write_txwi(dev, &txwi, skb, NULL, NULL, skb->len);
+	/* USB devices already reserve enough skb headroom for txwi's. This
+	 * helps to save slow copies over USB.
+	 */
+	if (mt76_is_usb(dev)) {
+		struct mt76x02_txwi *txwi;
+
+		mt76_insert_hdr_pad(skb);
+		txwi = (struct mt76x02_txwi *)(skb->data - sizeof(*txwi));
+		mt76x02_mac_write_txwi(dev, txwi, skb, NULL, NULL, skb->len);
+		skb_push(skb, sizeof(*txwi));
+	} else {
+		struct mt76x02_txwi txwi;
 
-	mt76_wr_copy(dev, offset, &txwi, sizeof(txwi));
-	offset += sizeof(txwi);
+		mt76x02_mac_write_txwi(dev, &txwi, skb, NULL, NULL, skb->len);
+		mt76_wr_copy(dev, offset, &txwi, sizeof(txwi));
+		offset += sizeof(txwi);
+	}
 
 	mt76_wr_copy(dev, offset, skb->data, skb->len);
 	return 0;
-- 
2.24.0

