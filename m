Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8DE97124CC1
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Dec 2019 17:09:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727484AbfLRQIy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Dec 2019 11:08:54 -0500
Received: from smail.rz.tu-ilmenau.de ([141.24.186.67]:51426 "EHLO
        smail.rz.tu-ilmenau.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727323AbfLRQIy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Dec 2019 11:08:54 -0500
Received: from isengard.tu-ilmenau.de (unknown [141.24.207.101])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smail.rz.tu-ilmenau.de (Postfix) with ESMTPSA id 3DBB458007B;
        Wed, 18 Dec 2019 17:08:52 +0100 (CET)
From:   Markus Theil <markus.theil@tu-ilmenau.de>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        Stanislaw Gruszka <stf_xl@wp.pl>, kvalo@codeaurora.org,
        Markus Theil <markus.theil@tu-ilmenau.de>
Subject: [PATCH v10 4/6] mt76: mt76x02: remove a copy call for usb speedup
Date:   Wed, 18 Dec 2019 17:07:52 +0100
Message-Id: <20191218160754.24111-5-markus.theil@tu-ilmenau.de>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191218160754.24111-1-markus.theil@tu-ilmenau.de>
References: <20191218160754.24111-1-markus.theil@tu-ilmenau.de>
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
 .../wireless/mediatek/mt76/mt76x02_beacon.c   | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_beacon.c b/drivers/net/wireless/mediatek/mt76/mt76x02_beacon.c
index c93e2e8749f0..3d0d3f6d28eb 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_beacon.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_beacon.c
@@ -26,15 +26,26 @@ static int
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
+	if (mt76_is_usb(&dev->mt76)) {
+		struct mt76x02_txwi *txwi;
+
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
2.24.1

